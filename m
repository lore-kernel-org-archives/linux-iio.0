Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:60910 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751497AbdINOx5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Sep 2017 10:53:57 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 4/6] iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
Date: Thu, 14 Sep 2017 22:52:49 +0800
Message-Id: <20170914145251.21784-5-icenowy@aosc.io>
In-Reply-To: <20170914145251.21784-1-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds support for the Allwinner H3 thermal sensor.

Allwinner H3 has a thermal sensor like the one in A33, but have its
registers nearly all re-arranged, sample clock moved to CCU and a pair
of bus clock and reset added. It's also the base of newer SoCs' thermal
sensors.

The thermal sensors on A64 and H5 is like the one on H3, but with of
course different formula factors.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v4:
- Splitted out some code refactors.
- Code sequence changed back. (The gpadc_data went back to the start of
  the source file)

 drivers/iio/adc/sun4i-gpadc-iio.c | 48 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sun4i-gpadc.h   | 27 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 97845982d050..f7e4df6bd17a 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -59,6 +59,8 @@ struct sun4i_gpadc_iio;
  */
 static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
 static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
+static int sun8i_h3_gpadc_sample_start(struct sun4i_gpadc_iio *info);
+static int sun8i_h3_gpadc_sample_end(struct sun4i_gpadc_iio *info);
 
 struct gpadc_data {
 	int		temp_offset;
@@ -120,6 +122,24 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.sample_end = sun4i_gpadc_sample_end,
 };
 
+static const struct gpadc_data sun8i_h3_gpadc_data = {
+	/*
+	 * The original formula on the datasheet seems to be wrong.
+	 * These factors are calculated based on the formula in the BSP
+	 * kernel, which is originally Tem = 217 - (T / 8.253), in which Tem
+	 * is the temperature in Celsius degree and T is the raw value
+	 * from the sensor.
+	 */
+	.temp_offset = -1791,
+	.temp_scale = -121,
+	.temp_data = SUN8I_H3_GPADC_TEMP_DATA,
+	.sample_start = sun8i_h3_gpadc_sample_start,
+	.sample_end = sun8i_h3_gpadc_sample_end,
+	.has_bus_clk = true,
+	.has_bus_rst = true,
+	.has_mod_clk = true,
+};
+
 struct sun4i_gpadc_iio {
 	struct iio_dev			*indio_dev;
 	struct completion		completion;
@@ -425,6 +445,14 @@ static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info)
 	return 0;
 }
 
+static int sun8i_h3_gpadc_sample_end(struct sun4i_gpadc_iio *info)
+{
+	/* Disable temperature sensor */
+	regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL2, 0);
+
+	return 0;
+}
+
 static int sun4i_gpadc_runtime_suspend(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
@@ -451,6 +479,22 @@ static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
 	return 0;
 }
 
+static int sun8i_h3_gpadc_sample_start(struct sun4i_gpadc_iio *info)
+{
+	regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL2,
+		     SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN |
+		     SUN8I_H3_GPADC_CTRL2_T_ACQ1(31));
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
+		     SUN4I_GPADC_CTRL0_T_ACQ(31));
+	regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL3,
+		     SUN4I_GPADC_CTRL3_FILTER_EN |
+		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
+	regmap_write(info->regmap, SUN8I_H3_GPADC_INTC,
+		     SUN8I_H3_GPADC_INTC_TEMP_PERIOD(800));
+
+	return 0;
+}
+
 static int sun4i_gpadc_runtime_resume(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
@@ -537,6 +581,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun8i-a33-ths",
 		.data = &sun8i_a33_gpadc_data,
 	},
+	{
+		.compatible = "allwinner,sun8i-h3-ths",
+		.data = &sun8i_h3_gpadc_data,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 78d31984a222..5c2a12101052 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -42,6 +42,9 @@
 #define SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN		BIT(8)
 #define SUN8I_A33_GPADC_CTRL1_GPADC_CALI_EN		BIT(7)
 
+/* TP_CTRL1 bits for SoCs after H3 */
+#define SUN8I_H3_GPADC_CTRL1_GPADC_CALI_EN		BIT(17)
+
 #define SUN4I_GPADC_CTRL2				0x08
 
 #define SUN4I_GPADC_CTRL2_TP_SENSITIVE_ADJUST(x)	((GENMASK(3, 0) & (x)) << 28)
@@ -49,7 +52,17 @@
 #define SUN4I_GPADC_CTRL2_PRE_MEA_EN			BIT(24)
 #define SUN4I_GPADC_CTRL2_PRE_MEA_THRE_CNT(x)		(GENMASK(23, 0) & (x))
 
+#define SUN8I_H3_GPADC_CTRL2				0x40
+
+#define SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN		BIT(0)
+#define SUN8I_H3_GPADC_CTRL2_T_ACQ1(x)			((GENMASK(15, 0) * (x)) << 16)
+
 #define SUN4I_GPADC_CTRL3				0x0c
+/*
+ * This register is named "Average filter Control Register" in H3 Datasheet,
+ * but the register's definition is the same as the old CTRL3 register.
+ */
+#define SUN8I_H3_GPADC_CTRL3				0x70
 
 #define SUN4I_GPADC_CTRL3_FILTER_EN			BIT(2)
 #define SUN4I_GPADC_CTRL3_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
@@ -71,6 +84,13 @@
 #define SUN4I_GPADC_INT_FIFOC_TP_UP_IRQ_EN		BIT(1)
 #define SUN4I_GPADC_INT_FIFOC_TP_DOWN_IRQ_EN		BIT(0)
 
+#define SUN8I_H3_GPADC_INTC				0x44
+
+#define SUN8I_H3_GPADC_INTC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
+#define SUN8I_H3_GPADC_INTC_TEMP_DATA			BIT(8)
+#define SUN8I_H3_GPADC_INTC_TEMP_SHUT			BIT(4)
+#define SUN8I_H3_GPADC_INTC_TEMP_ALARM			BIT(0)
+
 #define SUN4I_GPADC_INT_FIFOS				0x14
 
 #define SUN4I_GPADC_INT_FIFOS_TEMP_DATA_PENDING		BIT(18)
@@ -80,9 +100,16 @@
 #define SUN4I_GPADC_INT_FIFOS_TP_UP_PENDING		BIT(1)
 #define SUN4I_GPADC_INT_FIFOS_TP_DOWN_PENDING		BIT(0)
 
+#define SUN8I_H3_GPADC_INTS				0x44
+
+#define SUN8I_H3_GPADC_INTS_TEMP_DATA			BIT(8)
+#define SUN8I_H3_GPADC_INTS_TEMP_SHUT			BIT(4)
+#define SUN8I_H3_GPADC_INTS_TEMP_ALARM			BIT(0)
+
 #define SUN4I_GPADC_CDAT				0x1c
 #define SUN4I_GPADC_TEMP_DATA				0x20
 #define SUN4I_GPADC_DATA				0x24
+#define SUN8I_H3_GPADC_TEMP_DATA			0x80
 
 #define SUN4I_GPADC_IRQ_FIFO_DATA			0
 #define SUN4I_GPADC_IRQ_TEMP_DATA			1
-- 
2.13.5

