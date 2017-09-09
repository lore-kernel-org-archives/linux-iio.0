Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:45765 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdIISdd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Sep 2017 14:33:33 -0400
Message-Id: <f948e3b438b4fc7fdecb83c4f044e060bcffb150.1504807204.git.lukas@wunner.de>
In-Reply-To: <cover.1504807204.git.lukas@wunner.de>
References: <cover.1504807204.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 9 Sep 2017 20:32:41 +0200
Subject: [PATCH v2 2/6] iio: adc: mcp320x: Drop unnecessary of_device_id
 attributes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver sets a .data pointer for each .compatible string but never
calls of_device_get_match_data().  Instead, ADC properties are looked up
with spi_get_device_id().  The .data pointer is therefore unnecessary,
so drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/adc/mcp320x.c | 75 ++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 15b5fa7ad427..bf4794009413 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -363,62 +363,25 @@ static int mcp320x_remove(struct spi_device *spi)
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

