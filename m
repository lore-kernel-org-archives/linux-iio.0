Return-Path: <gizero@gmail.com>
From: Andrea Galbusera <gizero@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Andrea Galbusera <gizero@gmail.com>
Subject: [PATCH 2/4] iio: adc: mcp320x: Add support for mcp3301
Date: Tue, 14 Jul 2015 15:36:21 +0200
Message-Id: <1436880983-29017-2-git-send-email-gizero@gmail.com>
In-Reply-To: <1436880983-29017-1-git-send-email-gizero@gmail.com>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This adds support for Microchip's 13 bit 1 channel AD converter MCP3301

Signed-off-by: Andrea Galbusera <gizero@gmail.com>
---
 drivers/iio/adc/mcp320x.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 0673ee7..4de77e4 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -25,6 +25,7 @@
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21290D.pdf  mcp3201
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21034D.pdf  mcp3202
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf  mcp3204/08
+ * http://ww1.microchip.com/downloads/en/DeviceDoc/21700E.pdf  mcp3301
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -47,6 +48,7 @@ enum {
 	mcp3202,
 	mcp3204,
 	mcp3208,
+	mcp3301,
 };
 
 struct mcp320x_chip_info {
@@ -76,6 +78,7 @@ static int mcp320x_channel_to_tx_data(int device_index,
 	switch (device_index) {
 	case mcp3001:
 	case mcp3201:
+	case mcp3301:
 		return 0;
 	case mcp3002:
 	case mcp3202:
@@ -102,7 +105,7 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 	adc->tx_buf = mcp320x_channel_to_tx_data(device_index,
 						channel, differential);
 
-	if (device_index != mcp3001 && device_index != mcp3201) {
+	if (device_index != mcp3001 && device_index != mcp3201 && device_index != mcp3301) {
 		ret = spi_sync(adc->spi, &adc->msg);
 		if (ret < 0)
 			return ret;
@@ -125,6 +128,8 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 	case mcp3204:
 	case mcp3208:
 		return (adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4);
+	case mcp3301:
+		return sign_extend32(adc->rx_buf[0] & 0x1f << 8 | adc->rx_buf[1], 12);
 	default:
 		return -EINVAL;
 	}
@@ -274,6 +279,11 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
 		.num_channels = ARRAY_SIZE(mcp3208_channels),
 		.resolution = 12
 	},
+	[mcp3301] = {
+		.channels = mcp3201_channels,
+		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.resolution = 13
+	},
 };
 
 static int mcp320x_probe(struct spi_device *spi)
@@ -367,6 +377,9 @@ static const struct of_device_id mcp320x_dt_ids[] = {
 		.compatible = "mcp3208",
 		.data = &mcp320x_chip_infos[mcp3208],
 	}, {
+		.compatible = "mcp3301",
+		.data = &mcp320x_chip_infos[mcp3301],
+	}, {
 	}
 };
 MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
@@ -381,6 +394,7 @@ static const struct spi_device_id mcp320x_id[] = {
 	{ "mcp3202", mcp3202 },
 	{ "mcp3204", mcp3204 },
 	{ "mcp3208", mcp3208 },
+	{ "mcp3301", mcp3301 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp320x_id);
-- 
1.9.1
