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
Subject: [PATCH v2 06/16] iio: adc: sun4i-gpadc-iio: rework: support multiple sensors
Date: Mon, 29 Jan 2018 00:29:09 +0100
Message-Id: <20180128232919.12639-7-embed3d@gmail.com>
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

For adding newer sensor some basic rework of the code is necessary.

This patch reworks the driver to be able to handle more than one
thermal sensor. Newer SoC like the A80 have 4 thermal sensors.
Because of this the maximal sensor count value was set to 4.

The sensor_id value is set during sensor registration and is for each
registered sensor indiviual. This makes it able to differntiate the
sensors when the value is read from the register.

In function sun4i_gpadc_read_raw(), the sensor number of the ths sensor
was directly set to 0 (sun4i_gpadc_temp_read(x,x,0)). This selects
in the temp_read function automatically sensor 0. A check for the
sensor_id is here not required since the old sensors only have one
thermal sensor. In addition to that is the sun4i_gpadc_read_raw()
function only used by the "older" sensors (before A33) where the
thermal sensor was a cobination of an adc and a thermal sensor.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 36 +++++++++++++++++++++++-------------
 include/linux/mfd/sun4i-gpadc.h   |  3 +++
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 51ec0104d678..ac9ad2f8232f 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -67,12 +67,13 @@ struct gpadc_data {
 	unsigned int	tp_adc_select;
 	unsigned int	(*adc_chan_select)(unsigned int chan);
 	unsigned int	adc_chan_mask;
-	unsigned int	temp_data;
+	unsigned int	temp_data[MAX_SENSOR_COUNT];
 	int		(*sample_start)(struct sun4i_gpadc_iio *info);
 	int		(*sample_end)(struct sun4i_gpadc_iio *info);
 	bool		has_bus_clk;
 	bool		has_bus_rst;
 	bool		has_mod_clk;
+	int		sensor_count;
 };
 
 static const struct gpadc_data sun4i_gpadc_data = {
@@ -82,9 +83,10 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
-	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.temp_data = {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
 	.sample_start = sun4i_gpadc_sample_start,
 	.sample_end = sun4i_gpadc_sample_end,
+	.sensor_count = 1,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -94,9 +96,10 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
-	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.temp_data = {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
 	.sample_start = sun4i_gpadc_sample_start,
 	.sample_end = sun4i_gpadc_sample_end,
+	.sensor_count = 1,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -106,18 +109,20 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun6i_gpadc_chan_select,
 	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
-	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.temp_data = {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
 	.sample_start = sun4i_gpadc_sample_start,
 	.sample_end = sun4i_gpadc_sample_end,
+	.sensor_count = 1,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_offset = -1662,
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
-	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.temp_data = {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
 	.sample_start = sun4i_gpadc_sample_start,
 	.sample_end = sun4i_gpadc_sample_end,
+	.sensor_count = 1,
 };
 
 struct sun4i_gpadc_iio {
@@ -135,6 +140,7 @@ struct sun4i_gpadc_iio {
 	struct clk			*bus_clk;
 	struct clk			*mod_clk;
 	struct reset_control		*reset;
+	int				sensor_id;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
 	struct thermal_zone_device	*tzd;
@@ -302,14 +308,15 @@ static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
 	return sun4i_gpadc_read(indio_dev, channel, val, info->fifo_data_irq);
 }
 
-static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
+static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
+				int sensor)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
 	if (info->no_irq) {
 		pm_runtime_get_sync(indio_dev->dev.parent);
 
-		regmap_read(info->regmap, info->data->temp_data, val);
+		regmap_read(info->regmap, info->data->temp_data[sensor], val);
 
 		pm_runtime_mark_last_busy(indio_dev->dev.parent);
 		pm_runtime_put_autosuspend(indio_dev->dev.parent);
@@ -356,7 +363,7 @@ static int sun4i_gpadc_read_raw(struct iio_dev *indio_dev,
 			ret = sun4i_gpadc_adc_read(indio_dev, chan->channel,
 						   val);
 		else
-			ret = sun4i_gpadc_temp_read(indio_dev, val);
+			ret = sun4i_gpadc_temp_read(indio_dev, val, 0);
 
 		if (ret)
 			return ret;
@@ -470,7 +477,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
 	struct sun4i_gpadc_iio *info = data;
 	int val, scale, offset;
 
-	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
+	if (sun4i_gpadc_temp_read(info->indio_dev, &val, info->sensor_id))
 		return -ETIMEDOUT;
 
 	sun4i_gpadc_temp_scale(info->indio_dev, &scale);
@@ -712,7 +719,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 {
 	struct sun4i_gpadc_iio *info;
 	struct iio_dev *indio_dev;
-	int ret;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
 	if (!indio_dev)
@@ -745,9 +752,12 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-							    0, info,
-							    &sun4i_ts_tz_ops);
+		for (i = 0; i < info->data->sensor_count; i++) {
+			info->sensor_id = i;
+			info->tzd = thermal_zone_of_sensor_register(
+					info->sensor_device,
+					i, info, &sun4i_ts_tz_ops);
+		}
 		/*
 		 * Do not fail driver probing when failing to register in
 		 * thermal because no thermal DT node is found.
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 78d31984a222..20fa02040007 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -90,6 +90,9 @@
 /* 10s delay before suspending the IP */
 #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
 
+/* SUNXI_THS COMMON REGISTERS + DEFINES */
+#define MAX_SENSOR_COUNT				4
+
 struct sun4i_gpadc_dev {
 	struct device			*dev;
 	struct regmap			*regmap;
-- 
2.11.0
