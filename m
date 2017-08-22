Return-Path: <SRS0=1TP6=7Y=wunner.de=lukas@kernel.org>
Message-Id: <f61c85ca59a45800672d8879f7ea715f134dbd51.1503407738.git.lukas@wunner.de>
In-Reply-To: <cover.1503407738.git.lukas@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 22 Aug 2017 15:33:00 +0200
Subject: [PATCH 4/6] iio: adc: mcp320x: Drop unnecessary of_device_id
 attributes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mathias Duckeck <m.duckeck@kunbus.de>, Phil Elwell <phil@raspberrypi.org>, Oskar Andero <oskar.andero@gmail.com>, Andrea Galbusera <gizero@gmail.com>, Akinobu Mita <akinobu.mita@gmail.com>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Michael Welling <mwelling@ieee.org>, Soeren Andersen <san@rosetechnology.dk>, linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

The driver sets a .data pointer for each .compatible string but never
calls of_device_get_match_data().  Instead, ADC properties are looked up
with spi_get_device_id().  The .data pointer is therefore unnecessary,
so drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/adc/mcp320x.c | 75 ++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 790d3e857c80..6e10fa934aca 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -365,62 +365,25 @@ static int mcp320x_remove(struct spi_device *spi)
 #if defined(CONFIG_OF)
 static const struct of_device_id mcp320x_dt_ids[] = {
 	/* NOTE: The use of compatibles with no vendor prefix is deprecated. */
-	{
-		.compatible = "mcp3001",
-		.data = &mcp320x_chip_infos[mcp3001],
-	}, {
-		.compatible = "mcp3002",
-		.data = &mcp320x_chip_infos[mcp3002],
-	}, {
-		.compatible = "mcp3004",
-		.data = &mcp320x_chip_infos[mcp3004],
-	}, {
-		.compatible = "mcp3008",
-		.data = &mcp320x_chip_infos[mcp3008],
-	}, {
-		.compatible = "mcp3201",
-		.data = &mcp320x_chip_infos[mcp3201],
-	}, {
-		.compatible = "mcp3202",
-		.data = &mcp320x_chip_infos[mcp3202],
-	}, {
-		.compatible = "mcp3204",
-		.data = &mcp320x_chip_infos[mcp3204],
-	}, {
-		.compatible = "mcp3208",
-		.data = &mcp320x_chip_infos[mcp3208],
-	}, {
-		.compatible = "mcp3301",
-		.data = &mcp320x_chip_infos[mcp3301],
-	}, {
-		.compatible = "microchip,mcp3001",
-		.data = &mcp320x_chip_infos[mcp3001],
-	}, {
-		.compatible = "microchip,mcp3002",
-		.data = &mcp320x_chip_infos[mcp3002],
-	}, {
-		.compatible = "microchip,mcp3004",
-		.data = &mcp320x_chip_infos[mcp3004],
-	}, {
-		.compatible = "microchip,mcp3008",
-		.data = &mcp320x_chip_infos[mcp3008],
-	}, {
-		.compatible = "microchip,mcp3201",
-		.data = &mcp320x_chip_infos[mcp3201],
-	}, {
-		.compatible = "microchip,mcp3202",
-		.data = &mcp320x_chip_infos[mcp3202],
-	}, {
-		.compatible = "microchip,mcp3204",
-		.data = &mcp320x_chip_infos[mcp3204],
-	}, {
-		.compatible = "microchip,mcp3208",
-		.data = &mcp320x_chip_infos[mcp3208],
-	}, {
-		.compatible = "microchip,mcp3301",
-		.data = &mcp320x_chip_infos[mcp3301],
-	}, {
-	}
+	{ .compatible = "mcp3001" },
+	{ .compatible = "mcp3002" },
+	{ .compatible = "mcp3004" },
+	{ .compatible = "mcp3008" },
+	{ .compatible = "mcp3201" },
+	{ .compatible = "mcp3202" },
+	{ .compatible = "mcp3204" },
+	{ .compatible = "mcp3208" },
+	{ .compatible = "mcp3301" },
+	{ .compatible = "microchip,mcp3001" },
+	{ .compatible = "microchip,mcp3002" },
+	{ .compatible = "microchip,mcp3004" },
+	{ .compatible = "microchip,mcp3008" },
+	{ .compatible = "microchip,mcp3201" },
+	{ .compatible = "microchip,mcp3202" },
+	{ .compatible = "microchip,mcp3204" },
+	{ .compatible = "microchip,mcp3208" },
+	{ .compatible = "microchip,mcp3301" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
 #endif
-- 
2.11.0
