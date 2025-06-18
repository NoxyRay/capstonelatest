import sql from "@/lib/data";
import { NextRequest, NextResponse } from "next/server";
import { decrypt, encrypt } from "@/lib/encrypt";

// 📄 Get all data
export async function GET() {
  try {
    const rows = await sql`
      SELECT 
        t.id, t.title, t.description, t.created_at, t.updated_at, t.assigned_at, t.resolved_at,
        p.id AS priority_id, p.name AS priority_name,
        s.id AS status_id, s.name AS status_name,
        c.id AS customer_id, c.name AS customer_name, c.email AS customer_email,
        e.id AS engineer_id, e.name AS engineer_name, e.email AS engineer_email
      FROM tickets t
      LEFT JOIN priorities p ON t.priority_id = p.id
      LEFT JOIN status s ON t.status_id = s.id
      LEFT JOIN users c ON t.customer_id = c.id
      LEFT JOIN users e ON t.engineer_id = e.id
      ORDER BY t.created_at DESC
    `;

    const tickets = rows.map((row) => ({
      id: row.id,
      title: row.title,
      description: decrypt(row.description),
      priority: {
        id: row.priority_id,
        name: row.priority_name,
      },
      status: {
        id: row.status_id,
        name: row.status_name,
      },
      customer: {
        id: row.customer_id,
        name: row.customer_name,
        email: row.customer_email,
      },
      engineer: row.engineer_id
        ? {
            id: row.engineer_id,
            name: row.engineer_name,
            email: row.engineer_email,
          }
        : null,
      created_at: row.created_at,
      updated_at: row.updated_at,
      assigned_at: row.assigned_at,
      resolved_at: row.resolved_at,
    }));

    return NextResponse.json(tickets);
  } catch (err) {
    console.error("🔥 ERROR GET /api/tickets:", err);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

// ➕ Create new data
export async function POST(req: NextRequest) {
  try {
    const data = await req.json();
    const {
      title,
      description,
      priority_id,
      customer_id,
      engineer_id,
      category_id,
      images, // 👈 new
    } = data;

    // Validasi
    if (!title)
      return NextResponse.json({ error: "Title is required" }, { status: 400 });
    if (!category_id)
      return NextResponse.json(
        { error: "Category is required" },
        { status: 400 }
      );
    if (!description)
      return NextResponse.json(
        { error: "Description is required" },
        { status: 400 }
      );
    if (!customer_id)
      return NextResponse.json(
        { error: "Customer ID is required" },
        { status: 400 }
      );

    // Enkripsi deskripsi
    const encryptedDescription = encrypt(description);
    const categoryId = Number(category_id);
    if (isNaN(categoryId)) {
      return NextResponse.json(
        { error: "Invalid category_id" },
        { status: 400 }
      );
    }

    // Simpan ticket
    const result = await sql`
      INSERT INTO tickets (
        title, description, priority_id, customer_id, engineer_id, category_id
      ) VALUES (
        ${title}, ${encryptedDescription}, ${
      priority_id ?? null
    }, ${customer_id}, ${engineer_id ?? null}, ${categoryId}
      )
      RETURNING id
    `;

    const ticketId = result[0]?.id;

    // Simpan gambar-gambar jika ada
    for (const imgUrl of images) {
      await sql`
        INSERT INTO images (image, ticket_id)
        VALUES (${imgUrl}, ${ticketId})
      `;
    }

    return NextResponse.json({ message: "Ticket created", ticketId });
  } catch (err) {
    console.error("🔥 ERROR POST /api/tickets:", err);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
