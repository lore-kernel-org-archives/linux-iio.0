Return-Path: <SRS0=HpEw=LN=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@bootlin.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	eugen.hristev@microchip.com,
	rdunlap@infradead.org,
	vilhelm.gray@gmail.com,
	clabbe.montjoie@gmail.com,
	quentin.schulz@bootlin.com,
	geert+renesas@glider.be,
	lukas@wunner.de,
	icenowy@aosc.io,
	arnd@arndb.de,
	broonie@kernel.org,
	arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v3 22/30] iio: adc: sun4i-gpadc-iio: add support for A83T thermal sensor
Date: Thu, 30 Aug 2018 17:45:10 +0200
Message-Id: <20180830154518.29507-23-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the A83T ths sensor.

The A83T supports interrupts. The interrupt is configured to update the
the sensor values every second.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c   | 59 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/adc/sun4i-gpadc.h |  6 ++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d5c7971b2558..a184a87c56d4 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -84,6 +84,8 @@ static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info);
 static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info);
 static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data);
 
+static int sun8i_a83t_ths_resume(struct sun4i_gpadc_iio *info);
+
 static const struct gpadc_data sun4i_gpadc_data = {
 	.temp_offset = -1932,
 	.temp_scale = 133,
@@ -158,6 +160,21 @@ static const struct gpadc_data sun8i_h3_ths_data = {
 	.ths_irq_clear = SUN8I_H3_THS_INTS_TDATA_IRQ_0,
 };
 
+static const struct gpadc_data sun8i_a83t_ths_data = {
+	.temp_offset = -2724,
+	.temp_scale = -70,
+	.temp_data_base = SUN8I_H3_THS_TDATA0,
+	.ths_irq_thread = sunx8i_h3_irq_thread,
+	.support_irq = true,
+	.sensor_count = 3,
+	.supports_nvmem = true,
+	.ths_resume = sun8i_a83t_ths_resume,
+	.ths_suspend = sun8i_h3_ths_suspend,
+	.ths_irq_clear = SUN8I_H3_THS_INTS_TDATA_IRQ_0 |
+			SUN8I_A83T_THS_INTS_TDATA_IRQ_1 |
+			SUN8I_A83T_THS_INTS_TDATA_IRQ_2,
+};
+
 struct sun4i_sensor_tzd {
 	struct sun4i_gpadc_iio		*info;
 	struct thermal_zone_device	*tzd;
@@ -541,6 +558,44 @@ static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info)
 	return 0;
 }
 
+static int sun8i_a83t_ths_resume(struct sun4i_gpadc_iio *info)
+{
+	u32 value;
+
+	sun8i_h3_calibrate(info);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
+			SUN4I_GPADC_CTRL0_T_ACQ(0x13f));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
+			SUN8I_H3_THS_ACQ1(0x13f));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
+			SUN8I_H3_THS_INTS_TDATA_IRQ_0   |
+			SUN8I_A83T_THS_INTS_TDATA_IRQ_1 |
+			SUN8I_A83T_THS_INTS_TDATA_IRQ_2);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
+			SUN4I_GPADC_CTRL3_FILTER_EN |
+			SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
+			SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
+			SUN8I_A83T_THS_INTC_TDATA_IRQ_EN1 |
+			SUN8I_A83T_THS_INTC_TDATA_IRQ_EN2 |
+			SUN8I_H3_THS_TEMP_PERIOD(0x257));
+
+	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
+			SUN8I_H3_THS_TEMP_SENSE_EN0   |
+			SUN8I_A83T_THS_TEMP_SENSE_EN1 |
+			SUN8I_A83T_THS_TEMP_SENSE_EN2 |
+			value);
+
+	return 0;
+}
+
 static int sun4i_gpadc_get_temp(void *data, int *temp)
 {
 	struct sun4i_sensor_tzd *tzd = data;
@@ -588,6 +643,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun8i-h3-ths",
 		.data = &sun8i_h3_ths_data,
 	},
+	{
+		.compatible = "allwinner,sun8i-a83t-ths",
+		.data = &sun8i_a83t_ths_data,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/include/linux/iio/adc/sun4i-gpadc.h b/include/linux/iio/adc/sun4i-gpadc.h
index 169b4de9a34d..673459bb3ec3 100644
--- a/include/linux/iio/adc/sun4i-gpadc.h
+++ b/include/linux/iio/adc/sun4i-gpadc.h
@@ -105,13 +105,19 @@
 #define SUN8I_H3_THS_CTRL2				0x40
 #define SUN8I_H3_THS_ACQ1(x)			(GENMASK(31, 16) & ((x) << 16))
 #define SUN8I_H3_THS_TEMP_SENSE_EN0			BIT(0)
+#define SUN8I_A83T_THS_TEMP_SENSE_EN1			BIT(1)
+#define SUN8I_A83T_THS_TEMP_SENSE_EN2			BIT(2)
 
 #define SUN8I_H3_THS_INTC				0x44
 #define SUN8I_H3_THS_TEMP_PERIOD(x)		(GENMASK(31, 12) & ((x) << 12))
 #define SUN8I_H3_THS_INTC_TDATA_IRQ_EN0			BIT(8)
+#define SUN8I_A83T_THS_INTC_TDATA_IRQ_EN1		BIT(9)
+#define SUN8I_A83T_THS_INTC_TDATA_IRQ_EN2		BIT(10)
 
 #define SUN8I_H3_THS_STAT				0x48
 #define SUN8I_H3_THS_INTS_TDATA_IRQ_0			BIT(8)
+#define SUN8I_A83T_THS_INTS_TDATA_IRQ_1			BIT(9)
+#define SUN8I_A83T_THS_INTS_TDATA_IRQ_2			BIT(10)
 
 #define SUN8I_H3_THS_FILTER				0x70
 #define SUNXI_THS_CDATA_0_1				0x74
-- 
2.11.0
