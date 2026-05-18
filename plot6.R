library(ggplot2)

# 读取数据
NEI <- readRDS("summarySCC_PM25.rds")

# 筛选两个城市的机动车源数据
motor_data <- NEI[(NEI$fips == "24510" | NEI$fips == "06037") & NEI$type == "ON-ROAD", ]

# 添加城市标签
motor_data$city <- ifelse(motor_data$fips == "24510", "Baltimore", "Los Angeles")

# 按年份+城市计算排放量
city_motor_total <- aggregate(Emissions ~ year + city, data = motor_data, sum)

# 打开PNG设备
png("plot6.png", width = 480, height = 480, bg = "white")

# 用print()包裹ggplot对象
print(
  ggplot(city_motor_total, aes(x = year, y = Emissions, color = city, group = city)) +
    geom_line(linewidth = 1.5) +
    geom_point(size = 3) +
    labs(
      title = "Motor Vehicle Emissions: Baltimore vs LA",
      x = "Year",
      y = "Emissions (tons)",
      color = "City"
    ) +
    theme_minimal()
)

# 关闭设备
dev.off()