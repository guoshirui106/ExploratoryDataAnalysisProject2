# 读取数据
NEI <- readRDS("summarySCC_PM25.rds")

# 筛选巴尔的摩市数据
baltimore_data <- NEI[NEI$fips == "24510", ]

# 计算每年排放量
baltimore_total <- aggregate(Emissions ~ year, data = baltimore_data, sum)

# 打开PNG设备
png("plot2.png", width = 480, height = 480, bg = "white")

# base线图（带点标记，清晰展示趋势）
plot(
  x = baltimore_total$year,
  y = baltimore_total$Emissions,
  type = "b", # 同时画点和线
  pch = 19, # 实心圆点
  col = "darkred",
  lwd = 2,
  main = "PM2.5 Emissions in Baltimore City (1999-2008)",
  xlab = "Year",
  ylab = "Emissions (tons)"
)

# 关闭设备
dev.off()