library(ggplot2)

# 读取数据
NEI <- readRDS("summarySCC_PM25.rds")

# 筛选巴尔的摩市机动车源数据
baltimore_motor <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

# 计算每年排放量
motor_total <- aggregate(Emissions ~ year, data = baltimore_motor, sum)

# 打开PNG设备
png("plot5.png", width = 480, height = 480, bg = "white")

# 用print()包裹ggplot对象
print(
  ggplot(motor_total, aes(x = year, y = Emissions)) +
    geom_line(linewidth = 1.5, color = "orange") +
    geom_point(size = 3, color = "orange") +
    labs(
      title = "Motor Vehicle PM2.5 Emissions in Baltimore",
      x = "Year",
      y = "Emissions (tons)"
    ) +
    theme_minimal()
)

# 关闭设备
dev.off()