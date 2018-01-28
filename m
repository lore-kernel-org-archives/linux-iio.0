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
Subject: [PATCH v2 08/16] iio: adc: sun4i-gpadc-iio: rework: add interrupt support
Date: Mon, 29 Jan 2018 00:29:11 +0100
Message-Id: <20180128232919.12639-9-embed3d@gmail.com>
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch rewors the driver to support interrupts for the thermal part
of the sensor.

This is only available for the newer sensor (currently H3 and A83T).
The interrupt will be trigerd on data available and triggers the update
for the thermal sensors. All newer sensors have different amount of
sensors and different interrupts for each device the reset of the
interrupts need to be done different

For the newer sensors is the autosuspend disabled.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Jonathan  Cameron <jonathan.cameron@huawei.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 60 +++++++++++++++++++++++++++++++++++----
 include/linux/mfd/sun4i-gpadc.h   |  2 ++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 74eeb5cd5218..b7b5451226b0 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -71,11 +71,14 @@ struct gpadc_data {
 	unsigned int	temp_data[MAX_SENSOR_COUNT];
 	int		(*sample_start)(struct sun4i_gpadc_iio *info);
 	int		(*sample_end)(struct sun4i_gpadc_iio *info);
+	u32		irq_clear_map;
+	u32		irq_control_map;
 	bool		has_bus_clk;
 	bool		has_bus_rst;
 	bool		has_mod_clk;
 	int		sensor_count;
 	bool		supports_nvmem;
+	bool		support_irq;
 };
 
 static const struct gpadc_data sun4i_gpadc_data = {
@@ -90,6 +93,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.sample_end = sun4i_gpadc_sample_end,
 	.sensor_count = 1,
 	.supports_nvmem = false,
+	.support_irq = false,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -104,6 +108,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.sample_end = sun4i_gpadc_sample_end,
 	.sensor_count = 1,
 	.supports_nvmem = false,
+	.support_irq = false,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -118,6 +123,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.sample_end = sun4i_gpadc_sample_end,
 	.sensor_count = 1,
 	.supports_nvmem = false,
+	.support_irq = false,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
@@ -129,6 +135,7 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.sample_end = sun4i_gpadc_sample_end,
 	.sensor_count = 1,
 	.supports_nvmem = false,
+	.support_irq = false,
 };
 
 struct sun4i_gpadc_iio {
@@ -332,6 +339,11 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
 		return 0;
 	}
 
+	if (info->data->support_irq) {
+		regmap_read(info->regmap, info->data->temp_data[sensor], val);
+		return 0;
+	}
+
 	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
 }
 
@@ -429,6 +441,17 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t sunxi_irq_thread(int irq, void *data)
+{
+	struct sun4i_gpadc_iio *info = data;
+
+	regmap_write(info->regmap, SUN8I_H3_THS_STAT, info->data->irq_clear_map);
+
+	thermal_zone_device_update(info->tzd, THERMAL_EVENT_TEMP_SAMPLE);
+
+	return IRQ_HANDLED;
+}
+
 static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info)
 {
 	/* Disable the ADC on IP */
@@ -572,12 +595,29 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	struct nvmem_cell *cell;
 	ssize_t cell_size;
 	u64 *cell_data;
+	int irq;
 
 	info->data = of_device_get_match_data(&pdev->dev);
 	if (!info->data)
 		return -ENODEV;
 
-	info->no_irq = true;
+	if (info->data->support_irq) {
+		/* only the new versions of ths support right now irqs */
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
+			return irq;
+		}
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+				sunxi_irq_thread, IRQF_ONESHOT,
+				dev_name(&pdev->dev), info);
+		if (ret)
+			return ret;
+
+	} else
+		info->no_irq = true;
+
 	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
 	indio_dev->channels = sun8i_a33_gpadc_channels;
 
@@ -789,11 +829,13 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev,
-					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	if (!info->data->support_irq) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev,
+						 SUN4I_GPADC_AUTOSUSPEND_DELAY);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
 
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
 		for (i = 0; i < info->data->sensor_count; i++) {
@@ -814,6 +856,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (info->data->support_irq)
+		info->data->sample_start(info);
+
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register the device\n");
@@ -843,6 +888,9 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	if (!IS_ENABLED(CONFIG_THERMAL_OF))
 		return 0;
 
+	if (info->data->support_irq)
+		info->data->sample_end(info);
+
 	thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
 
 	if (!info->no_irq)
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 20fa02040007..458f2159a95a 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -91,6 +91,8 @@
 #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
 
 /* SUNXI_THS COMMON REGISTERS + DEFINES */
+#define SUN8I_H3_THS_INTC				0x44
+
 #define MAX_SENSOR_COUNT				4
 
 struct sun4i_gpadc_dev {
-- 
2.11.0
