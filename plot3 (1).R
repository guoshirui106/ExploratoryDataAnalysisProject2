# 必须先加载ggplot2（脚本里写，避免依赖全局环境）
library(ggplot2)

# 读取数据
NEI <- readRDS("summarySCC_PM25.rds")

# 筛选巴尔的摩市数据
baltimore_data <- NEI[NEI$fips == "24510", ]

# 按年份+排放源计算排放量
baltimore_type <- aggregate(Emissions ~ year + type, data = baltimore_data, sum)

# 打开PNG设备
png("plot3.png", width = 480, height = 480, bg = "white")

# 关键：用print()包裹ggplot对象，source运行时才会写入设备
print(
  ggplot(baltimore_type, aes(x = year, y = Emissions, color = type, group = type)) +
    geom_line(linewidth = 1) +
    geom_point(size = 3) +
    labs(
      title = "PM2.5 Emissions by Source Type in Baltimore",
      x = "Year",
      y = "Emissions (tons)",
      color = "Source Type"
    ) +
    theme_minimal()
)

# 关闭设备
dev.off()