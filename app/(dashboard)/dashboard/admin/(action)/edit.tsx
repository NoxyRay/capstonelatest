import { Button } from "@/components/ui/button"
import {
    Dialog,
    DialogClose,
    DialogContent,
    DialogFooter,
    DialogHeader,
    DialogTitle,
    DialogTrigger,
} from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { IconPlus } from "@tabler/icons-react"
import { useRef, useState } from "react"
import { toast } from "sonner"

export default function DialogEdit({ mutateUsers }: { mutateUsers: () => void }) {

    const closeRef = useRef<HTMLButtonElement>(null);

    const [formData, setFormData] = useState({
        company: "",
        name: "",
        email: "",
        password: "",
        role: 2
    })

    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
        setFormData({
            ...formData,
            [e.target.name]: e.target.value,
        })
    }

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault()

        try {
            const res = await fetch("/api/users", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(formData),
            })

            if (res.ok) {
                toast.success("Admin created successfully")
                closeRef.current?.click();
                setFormData({
                    company: "",
                    name: "",
                    email: "",
                    password: "",
                    role: 1
                })
                mutateUsers()
            } else {
                const err = await res.json()
                toast.error("Error: " + err.message || "Failed to create admin")
            }
        } catch (err) {
            console.error("🔥 Error creating admin:", err)
            toast.error("Server error")
        }
    }

    return (
        <Dialog>
            <DialogTrigger asChild>
                <Button>
                    <IconPlus className="mr-2 h-4 w-4" />
                    Add Admin
                </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px]">
                <form onSubmit={handleSubmit}>
                    <DialogHeader>
                        <DialogTitle>Add New Admin</DialogTitle>
                    </DialogHeader>
                    <div className="grid gap-4 py-6">
                        <div className="grid gap-3">
                            <Label htmlFor="company">Company</Label>
                            <Input
                                id="company"
                                name="company"
                                value={formData.company}
                                onChange={handleChange}
                            />
                        </div>
                        <div className="grid gap-3">
                            <Label htmlFor="name">Name</Label>
                            <Input
                                id="name"
                                name="name"
                                value={formData.name}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <div className="grid gap-3">
                            <Label htmlFor="email">Email</Label>
                            <Input
                                id="email"
                                name="email"
                                type="email"
                                value={formData.email}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <div className="grid gap-3">
                            <Label htmlFor="password">Password</Label>
                            <Input
                                id="password"
                                name="password"
                                type="password"
                                value={formData.password}
                                onChange={handleChange}
                                required
                            />
                        </div>
                    </div>
                    <DialogFooter>
                        <DialogClose asChild>
                            <Button ref={closeRef} variant="outline">Cancel</Button>
                        </DialogClose>
                        <Button type="submit">Add Admin</Button>
                    </DialogFooter>
                </form>
            </DialogContent>
        </Dialog>
    )
}
