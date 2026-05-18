library(ggplot2)

# 读取数据
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 筛选燃煤相关污染源（EI.Sector列包含"Coal"）
coal_scc <- SCC[grepl("Coal", SCC$EI.Sector, ignore.case = TRUE), ]
coal_data <- NEI[NEI$SCC %in% coal_scc$SCC, ]

# 计算每年排放量
coal_total <- aggregate(Emissions ~ year, data = coal_data, sum)

# 打开PNG设备
png("plot4.png", width = 480, height = 480, bg = "white")

# 用print()包裹ggplot对象
print(
  ggplot(coal_total, aes(x = year, y = Emissions)) +
    geom_line(linewidth = 1.5, color = "darkgreen") +
    geom_point(size = 3, color = "darkgreen") +
    labs(
      title = "Coal-Related PM2.5 Emissions in the US",
      x = "Year",
      y = "Emissions (tons)"
    ) +
    theme_minimal()
)

# 关闭设备
dev.off()