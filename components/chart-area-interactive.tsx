"use client"

import * as React from "react"
import { Area, AreaChart, CartesianGrid, XAxis } from "recharts"

import { useIsMobile } from "@/hooks/use-mobile"
import {
  Card,
  CardAction,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@/components/ui/chart"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import {
  ToggleGroup,
  ToggleGroupItem,
} from "@/components/ui/toggle-group"
import { useFetchTickets } from "@/hooks/useFetchTickets"

export const description = "An interactive area chart"

const chartConfig = {
  tickets: {
    label: "Tickets",
    color: "var(--primary)",
  },
} satisfies ChartConfig

export function ChartAreaInteractive() {

  const { tickets: ticketData } = useFetchTickets()

  const isMobile = useIsMobile()
  const [timeRange, setTimeRange] = React.useState("90d")

  React.useEffect(() => {
    if (isMobile) setTimeRange("7d")
  }, [isMobile])

  const grouped: Record<string, number> = {}
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  ticketData.forEach((t: any) => {
    const date = new Date(t.created_at).toISOString().split("T")[0]
    if (!grouped[date]) grouped[date] = 0
    grouped[date]++
  })

  const chartData = Object.entries(grouped)
    .map(([date, total]) => ({ date, total }))
    .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime())

  const referenceDate = new Date("2025-06-30")
  const days = timeRange === "7d" ? 7 : timeRange === "30d" ? 30 : 90
  const startDate = new Date(referenceDate)
  startDate.setDate(referenceDate.getDate() - days)

  const filteredData = chartData.filter((d) => new Date(d.date) >= startDate)

  return (
    <Card className="@container/card">
      <CardHeader>
        <CardTitle>Total Tickets</CardTitle>
        <CardDescription>
          <span className="hidden @[540px]/card:block">
            Ticket creation in selected range
          </span>
          <span className="@[540px]/card:hidden">Ticket stats</span>
        </CardDescription>
        <CardAction>
          <ToggleGroup
            type="single"
            value={timeRange}
            onValueChange={setTimeRange}
            variant="outline"
            className="hidden *:data-[slot=toggle-group-item]:!px-4 @[767px]/card:flex"
          >
            <ToggleGroupItem value="90d">Last 3 months</ToggleGroupItem>
            <ToggleGroupItem value="30d">Last 30 days</ToggleGroupItem>
            <ToggleGroupItem value="7d">Last 7 days</ToggleGroupItem>
          </ToggleGroup>
          <Select value={timeRange} onValueChange={setTimeRange}>
            <SelectTrigger
              className="flex w-40 @[767px]/card:hidden"
              size="sm"
            >
              <SelectValue placeholder="Last 3 months" />
            </SelectTrigger>
            <SelectContent className="rounded-xl">
              <SelectItem value="90d">Last 3 months</SelectItem>
              <SelectItem value="30d">Last 30 days</SelectItem>
              <SelectItem value="7d">Last 7 days</SelectItem>
            </SelectContent>
          </Select>
        </CardAction>
      </CardHeader>
      <CardContent className="px-2 pt-4 sm:px-6 sm:pt-6">
        <ChartContainer
          config={chartConfig}
          className="aspect-auto h-[250px] w-full"
        >
          <AreaChart data={filteredData}>
            <defs>
              <linearGradient id="fillTickets" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="var(--color-tickets)" stopOpacity={1.0} />
                <stop offset="95%" stopColor="var(--color-tickets)" stopOpacity={0.1} />
              </linearGradient>
            </defs>
            <CartesianGrid vertical={false} />
            <XAxis
              dataKey="date"
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              minTickGap={32}
              tickFormatter={(value) =>
                new Date(value).toLocaleDateString("en-US", {
                  month: "short",
                  day: "numeric",
                })
              }
            />
            <ChartTooltip
              cursor={false}
              defaultIndex={isMobile ? -1 : filteredData.length - 1}
              content={
                <ChartTooltipContent
                  labelFormatter={(value) =>
                    new Date(value).toLocaleDateString("en-US", {
                      month: "short",
                      day: "numeric",
                    })
                  }
                  indicator="dot"
                />
              }
            />
            <Area
              dataKey="total"
              type="monotone"
              fill="url(#fillTickets)"
              stroke="var(--color-tickets)"
            />
          </AreaChart>
        </ChartContainer>
      </CardContent>
    </Card>
  )
}
