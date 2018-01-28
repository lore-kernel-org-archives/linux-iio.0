Return-Path: <SRS0=zW5g=EX=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	davem@davemloft.net,
	hans.verkuil@cisco.com,
	mchehab@kernel.org,
	rask@formelder.dk,
	clabbe.montjoie@gmail.com,
	sean@mess.org,
	krzk@kernel.org,
	quentin.schulz@free-electrons.com,
	icenowy@aosc.io,
	edu.molinas@gmail.com,
	singhalsimran0@gmail.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v2 07/16] iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
Date: Mon, 29 Jan 2018 00:29:10 +0100
Message-Id: <20180128232919.12639-8-embed3d@gmail.com>
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch reworks the driver to support nvmem calibration cells.
The driver checks if the nvmem calibration is supported and reads out
the nvmem.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index ac9ad2f8232f..74eeb5cd5218 100644
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
@@ -74,6 +75,7 @@ struct gpadc_data {
 	bool		has_bus_rst;
 	bool		has_mod_clk;
 	int		sensor_count;
+	bool		supports_nvmem;
 };
 
 static const struct gpadc_data sun4i_gpadc_data = {
@@ -87,6 +89,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.sample_start = sun4i_gpadc_sample_start,
 	.sample_end = sun4i_gpadc_sample_end,
 	.sensor_count = 1,
+	.supports_nvmem = false,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -100,6 +103,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.sample_start = sun4i_gpadc_sample_start,
 	.sample_end = sun4i_gpadc_sample_end,
 	.sensor_count = 1,
+	.supports_nvmem = false,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -113,6 +117,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.sample_start = sun4i_gpadc_sample_start,
 	.sample_end = sun4i_gpadc_sample_end,
 	.sensor_count = 1,
+	.supports_nvmem = false,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
@@ -123,6 +128,7 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.sample_start = sun4i_gpadc_sample_start,
 	.sample_end = sun4i_gpadc_sample_end,
 	.sensor_count = 1,
+	.supports_nvmem = false,
 };
 
 struct sun4i_gpadc_iio {
@@ -141,6 +147,8 @@ struct sun4i_gpadc_iio {
 	struct clk			*mod_clk;
 	struct reset_control		*reset;
 	int				sensor_id;
+	u32				calibration_data[2];
+	bool				has_calibration_data[2];
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
 	struct thermal_zone_device	*tzd;
@@ -561,6 +569,9 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	struct resource *mem;
 	void __iomem *base;
 	int ret;
+	struct nvmem_cell *cell;
+	ssize_t cell_size;
+	u64 *cell_data;
 
 	info->data = of_device_get_match_data(&pdev->dev);
 	if (!info->data)
@@ -575,6 +586,39 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	info->has_calibration_data[0] = false;
+	info->has_calibration_data[1] = false;
+
+	if (!info->data->supports_nvmem)
+		goto no_nvmem;
+
+	cell = nvmem_cell_get(&pdev->dev, "calibration");
+	if (IS_ERR(cell)) {
+		if (PTR_ERR(cell) == -EPROBE_DEFER)
+			return PTR_ERR(cell);
+		goto no_nvmem;
+	}
+
+	cell_data = (u64 *)nvmem_cell_read(cell, &cell_size);
+	nvmem_cell_put(cell);
+	switch (cell_size) {
+		case 8:
+		case 6:
+			info->has_calibration_data[1] = true;
+			info->calibration_data[1] = be32_to_cpu(
+					upper_32_bits(cell_data[0]));
+		case 4:
+		case 2:
+			info->has_calibration_data[0] = true;
+			info->calibration_data[0] = be32_to_cpu(
+					lower_32_bits(cell_data[0]));
+			break;
+		default:
+			break;
+	}
+
+no_nvmem:
+
 	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					     &sun4i_gpadc_regmap_config);
 	if (IS_ERR(info->regmap)) {
-- 
2.11.0
