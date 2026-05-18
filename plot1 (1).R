# 读取数据
NEI <- readRDS("summarySCC_PM25.rds")

# 计算每年总排放量（单位：千吨，方便展示）
total_emissions <- aggregate(Emissions ~ year, data = NEI, sum)

# 打开PNG设备（规范设置宽高）
png("plot1.png", width = 480, height = 480, bg = "white")

# base绘图（会直接写入设备，无需print）
barplot(
  height = total_emissions$Emissions / 1000,
  names.arg = total_emissions$year,
  main = "Total PM2.5 Emissions in the US (1999-2008)",
  xlab = "Year",
  ylab = "Total Emissions (Kilotons)",
  col = "steelblue",
  border = "white"
)

# 关闭设备
dev.off()