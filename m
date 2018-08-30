Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37215 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeH3Ts0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:26 -0400
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 19/30] iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
Date: Thu, 30 Aug 2018 17:45:07 +0200
Message-Id: <20180830154518.29507-20-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch reworks the driver to support nvmem calibration cells.
The driver checks if the nvmem calibration is supported and reads out
the nvmem.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 18ab72e52d78..2fd73d143815 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -70,6 +71,7 @@ struct gpadc_data {
 	bool		has_mod_clk;
 	u32		temp_data_base;
 	int		sensor_count;
+	bool		supports_nvmem;
 };
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
@@ -146,6 +148,7 @@ struct sun4i_gpadc_iio {
 	struct clk			*bus_clk;
 	struct clk			*mod_clk;
 	struct reset_control		*reset;
+	u32				calibration_data[2];
 };
 
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
@@ -484,6 +487,9 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	struct resource *mem;
 	void __iomem *base;
 	int ret;
+	struct nvmem_cell *cell;
+	ssize_t cell_size;
+	u32 *cell_data;
 
 	info->data = of_device_get_match_data(&pdev->dev);
 	if (!info->data)
@@ -494,6 +500,24 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	if (info->data->supports_nvmem) {
+
+		cell = nvmem_cell_get(&pdev->dev, "calibration");
+		if (IS_ERR(cell)) {
+			if (PTR_ERR(cell) == -EPROBE_DEFER)
+				return PTR_ERR(cell);
+		} else {
+			cell_data = (u32 *)nvmem_cell_read(cell, &cell_size);
+			if (cell_size != 8)
+				dev_err(&pdev->dev,
+					"Calibration data has wrong size\n");
+			else {
+				info->calibration_data[0] = cell_data[0];
+				info->calibration_data[1] = cell_data[1];
+			}
+		}
+	}
+
 	if (info->data->has_bus_clk)
 		info->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus",
 				base, &sun4i_gpadc_regmap_config);
-- 
2.11.0
