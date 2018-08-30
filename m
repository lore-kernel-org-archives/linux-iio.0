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
Subject: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
Date: Thu, 30 Aug 2018 17:45:09 +0200
Message-Id: <20180830154518.29507-22-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the H3 ths sensor.

The H3 supports interrupts. The interrupt is configured to update the
the sensor values every second. The calibration data is writen at the
begin of the init process.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c   | 91 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/adc/sun4i-gpadc.h | 18 ++++++++
 2 files changed, 109 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index c7b46c82e3e5..d5c7971b2558 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -72,6 +72,7 @@ struct gpadc_data {
 	u32		temp_data_base;
 	int		sensor_count;
 	bool		supports_nvmem;
+	u32		ths_irq_clear;
 };
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
@@ -79,6 +80,10 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
 static int sun4i_ths_resume(struct sun4i_gpadc_iio *info);
 static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info);
 
+static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info);
+static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info);
+static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data);
+
 static const struct gpadc_data sun4i_gpadc_data = {
 	.temp_offset = -1932,
 	.temp_scale = 133,
@@ -137,6 +142,22 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.sensor_count = 1,
 };
 
+static const struct gpadc_data sun8i_h3_ths_data = {
+	.temp_offset = -1791,
+	.temp_scale = -121,
+	.temp_data_base = SUN8I_H3_THS_TDATA0,
+	.ths_irq_thread = sunx8i_h3_irq_thread,
+	.support_irq = true,
+	.has_bus_clk = true,
+	.has_bus_rst = true,
+	.has_mod_clk = true,
+	.sensor_count = 1,
+	.supports_nvmem = true,
+	.ths_resume = sun8i_h3_ths_resume,
+	.ths_suspend = sun8i_h3_ths_suspend,
+	.ths_irq_clear = SUN8I_H3_THS_INTS_TDATA_IRQ_0,
+};
+
 struct sun4i_sensor_tzd {
 	struct sun4i_gpadc_iio		*info;
 	struct thermal_zone_device	*tzd;
@@ -409,6 +430,31 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data)
+{
+	struct sun4i_gpadc_iio *info = data;
+	int i;
+
+	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
+			info->data->ths_irq_clear);
+
+	for (i = 0; i < info->data->sensor_count; i++)
+		thermal_zone_device_update(info->tzds[i].tzd,
+						THERMAL_EVENT_TEMP_SAMPLE);
+
+	return IRQ_HANDLED;
+}
+
+static int sun8i_h3_calibrate(struct sun4i_gpadc_iio *info)
+{
+//	regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
+//			info->calibration_data[0]);
+//	regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
+//			info->calibration_data[1]);
+
+	return 0;
+}
+
 static int sun4i_gpadc_runtime_suspend(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
@@ -428,6 +474,16 @@ static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
 	return 0;
 }
 
+static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info)
+{
+	/* Disable ths interrupt */
+	regmap_write(info->regmap, SUN8I_H3_THS_INTC, 0x0);
+	/* Disable temperature sensor */
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2, 0x0);
+
+	return 0;
+}
+
 static int sun4i_gpadc_runtime_resume(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
@@ -454,6 +510,37 @@ static int sun4i_ths_resume(struct sun4i_gpadc_iio *info)
 	return 0;
 }
 
+static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info)
+{
+	u32 value;
+
+	sun8i_h3_calibrate(info);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
+			SUN4I_GPADC_CTRL0_T_ACQ(0xff));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
+			SUN8I_H3_THS_ACQ1(0x3f));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
+			SUN8I_H3_THS_INTS_TDATA_IRQ_0);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
+			SUN4I_GPADC_CTRL3_FILTER_EN |
+			SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2));
+
+	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
+			SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
+			SUN8I_H3_THS_TEMP_PERIOD(0x55));
+
+	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
+
+	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
+			SUN8I_H3_THS_TEMP_SENSE_EN0 | value);
+
+	return 0;
+}
+
 static int sun4i_gpadc_get_temp(void *data, int *temp)
 {
 	struct sun4i_sensor_tzd *tzd = data;
@@ -497,6 +584,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun6i-a31-gpadc",
 		.data = &sun6i_gpadc_data
 	},
+	{
+		.compatible = "allwinner,sun8i-h3-ths",
+		.data = &sun8i_h3_ths_data,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/include/linux/iio/adc/sun4i-gpadc.h b/include/linux/iio/adc/sun4i-gpadc.h
index 99feeba28105..169b4de9a34d 100644
--- a/include/linux/iio/adc/sun4i-gpadc.h
+++ b/include/linux/iio/adc/sun4i-gpadc.h
@@ -100,6 +100,24 @@
 }
 
 /* SUNXI_THS COMMON REGISTERS + DEFINES */
+#define SUN8I_H3_THS_CTRL0				0x00
+
+#define SUN8I_H3_THS_CTRL2				0x40
+#define SUN8I_H3_THS_ACQ1(x)			(GENMASK(31, 16) & ((x) << 16))
+#define SUN8I_H3_THS_TEMP_SENSE_EN0			BIT(0)
+
+#define SUN8I_H3_THS_INTC				0x44
+#define SUN8I_H3_THS_TEMP_PERIOD(x)		(GENMASK(31, 12) & ((x) << 12))
+#define SUN8I_H3_THS_INTC_TDATA_IRQ_EN0			BIT(8)
+
+#define SUN8I_H3_THS_STAT				0x48
+#define SUN8I_H3_THS_INTS_TDATA_IRQ_0			BIT(8)
+
+#define SUN8I_H3_THS_FILTER				0x70
+#define SUNXI_THS_CDATA_0_1				0x74
+#define SUNXI_THS_CDATA_2_3				0x78
+#define SUN8I_H3_THS_TDATA0				0x80
+
 #define MAX_SENSOR_COUNT				4
 
 #endif
-- 
2.11.0
