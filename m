Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:61353 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbcF0Iho (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jun 2016 04:37:44 -0400
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v6 1/2] iio: ad5755: add support for dt bindings
Date: Mon, 27 Jun 2016 10:27:17 +0200
Message-ID: <20160627082718.2087-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Devicetree can provide platform data

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Changes since v5:
- added CONFIG_OF define

Changes since v4:
- added lookups tables instead of large switchcases

Changes since v3:
- replaced '_' with '-'
- Now used actual values instead of register values.

Changes since v2:
- removed defines from DT
 drivers/iio/dac/ad5755.c | 188 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index bfb350a..0fde593 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/platform_data/ad5755.h>
@@ -109,6 +110,51 @@ enum ad5755_type {
 	ID_AD5737,
 };
 
+#ifdef CONFIG_OF
+static const int ad5755_dcdc_freq_table[][2] = {
+	{ 250000, AD5755_DC_DC_FREQ_250kHZ },
+	{ 410000, AD5755_DC_DC_FREQ_410kHZ },
+	{ 650000, AD5755_DC_DC_FREQ_650kHZ }
+};
+
+static const int ad5755_dcdc_maxv_table[][2] = {
+	{ 23000000, AD5755_DC_DC_MAXV_23V },
+	{ 24500000, AD5755_DC_DC_MAXV_24V5 },
+	{ 27000000, AD5755_DC_DC_MAXV_27V },
+	{ 29500000, AD5755_DC_DC_MAXV_29V5 },
+};
+
+static const int ad5755_slew_rate_table[][2] = {
+	{ 64000, AD5755_SLEW_RATE_64k },
+	{ 32000, AD5755_SLEW_RATE_32k },
+	{ 16000, AD5755_SLEW_RATE_16k },
+	{ 8000, AD5755_SLEW_RATE_8k },
+	{ 4000, AD5755_SLEW_RATE_4k },
+	{ 2000, AD5755_SLEW_RATE_2k },
+	{ 1000, AD5755_SLEW_RATE_1k },
+	{ 500, AD5755_SLEW_RATE_500 },
+	{ 250, AD5755_SLEW_RATE_250 },
+	{ 125, AD5755_SLEW_RATE_125 },
+	{ 64, AD5755_SLEW_RATE_64 },
+	{ 32, AD5755_SLEW_RATE_32 },
+	{ 16, AD5755_SLEW_RATE_16 },
+	{ 8, AD5755_SLEW_RATE_8 },
+	{ 4, AD5755_SLEW_RATE_4 },
+	{ 0, AD5755_SLEW_RATE_0_5 },
+};
+
+static const int ad5755_slew_step_table[][2] = {
+	{ 256, AD5755_SLEW_STEP_SIZE_256 },
+	{ 128, AD5755_SLEW_STEP_SIZE_128 },
+	{ 64, AD5755_SLEW_STEP_SIZE_64 },
+	{ 32, AD5755_SLEW_STEP_SIZE_32 },
+	{ 16, AD5755_SLEW_STEP_SIZE_16 },
+	{ 4, AD5755_SLEW_STEP_SIZE_4 },
+	{ 2, AD5755_SLEW_STEP_SIZE_2 },
+	{ 1, AD5755_SLEW_STEP_SIZE_1 },
+};
+#endif
+
 static int ad5755_write_unlocked(struct iio_dev *indio_dev,
 	unsigned int reg, unsigned int val)
 {
@@ -556,6 +602,129 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
 	},
 };
 
+#ifdef CONFIG_OF
+static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *pp;
+	struct ad5755_platform_data *pdata;
+	unsigned int tmp;
+	unsigned int tmparray[3];
+	int devnr, i;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->ext_dc_dc_compenstation_resistor =
+	    of_property_read_bool(np, "adi,ext-dc-dc-compenstation-resistor");
+
+	if (!of_property_read_u32(np, "adi,dc-dc-phase", &tmp))
+		pdata->dc_dc_phase = tmp;
+	else
+		pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
+
+	pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
+	if (!of_property_read_u32(np, "adi,dc-dc-freq-hz", &tmp)) {
+		for (i = 0; i < ARRAY_SIZE(ad5755_dcdc_freq_table); i++) {
+			if (tmp == ad5755_dcdc_freq_table[i][0]) {
+				pdata->dc_dc_freq = ad5755_dcdc_freq_table[i][1];
+				break;
+			}
+		}
+
+		if (i == ARRAY_SIZE(ad5755_dcdc_freq_table)) {
+			dev_err(dev,
+				"adi,dc-dc-freq out of range selecting 410kHz");
+		}
+	}
+
+	pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
+	if (!of_property_read_u32(np, "adi,dc-dc-max-microvolt", &tmp)) {
+		for (i = 0; i < ARRAY_SIZE(ad5755_dcdc_maxv_table); i++) {
+			if (tmp == ad5755_dcdc_maxv_table[i][0]) {
+				pdata->dc_dc_maxv = ad5755_dcdc_maxv_table[i][1];
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(ad5755_dcdc_maxv_table)) {
+				dev_err(dev,
+					"adi,dc-dc-maxv out of range selecting 23V");
+		}
+	}
+
+	devnr = 0;
+	for_each_child_of_node(np, pp) {
+		if (devnr > AD5755_NUM_CHANNELS) {
+			dev_err(dev,
+				"There is to many channels defined in DT\n");
+			goto error_out;
+		}
+
+		if (!of_property_read_u32(pp, "adi,mode", &tmp))
+			pdata->dac[devnr].mode = tmp;
+		else
+			pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
+
+		pdata->dac[devnr].ext_current_sense_resistor =
+		    of_property_read_bool(pp, "adi,ext-current-sense-resistor");
+
+		pdata->dac[devnr].enable_voltage_overrange =
+		    of_property_read_bool(pp, "adi,enable-voltage-overrange");
+
+		if (!of_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
+			pdata->dac[devnr].slew.enable = tmparray[0];
+
+			pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;
+			for (i = 0; i < ARRAY_SIZE(ad5755_slew_rate_table); i++) {
+				if (tmparray[1] == ad5755_slew_rate_table[i][0]) {
+					pdata->dac[devnr].slew.rate =
+						ad5755_slew_rate_table[i][1];
+					break;
+				}
+			}
+			if (i == ARRAY_SIZE(ad5755_slew_rate_table)) {
+				dev_err(dev,
+					"channel %d slew rate out of range selecting 64kHz",
+					devnr);
+			}
+
+			pdata->dac[devnr].slew.step_size = AD5755_SLEW_STEP_SIZE_1;
+			for (i = 0; i < ARRAY_SIZE(ad5755_slew_step_table); i++) {
+				if (tmparray[2] == ad5755_slew_step_table[i][0]) {
+					pdata->dac[devnr].slew.step_size =
+						ad5755_slew_step_table[i][1];
+					break;
+				}
+			}
+			if (i == ARRAY_SIZE(ad5755_slew_step_table)) {
+				dev_err(dev,
+					"channel %d slew step size out of range selecting 1 LSB",
+					devnr);
+			}
+		} else {
+			pdata->dac[devnr].slew.enable = false;
+			pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;
+			pdata->dac[devnr].slew.step_size =
+			    AD5755_SLEW_STEP_SIZE_1;
+		}
+		devnr++;
+	}
+
+	return pdata;
+
+ error_out:
+	devm_kfree(dev, pdata);
+	return NULL;
+}
+#else
+static
+struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int ad5755_probe(struct spi_device *spi)
 {
 	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
@@ -583,8 +752,15 @@ static int ad5755_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = AD5755_NUM_CHANNELS;
 
-	if (!pdata)
+	if (spi->dev.of_node)
+		pdata = ad5755_parse_dt(&spi->dev);
+	else
+		pdata = spi->dev.platform_data;
+
+	if (!pdata) {
+		dev_warn(&spi->dev, "no platform data? using default\n");
 		pdata = &ad5755_default_pdata;
+	}
 
 	ret = ad5755_init_channels(indio_dev, pdata);
 	if (ret)
@@ -607,6 +783,16 @@ static const struct spi_device_id ad5755_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
+static const struct of_device_id ad5755_of_match[] = {
+	{ .compatible = "adi,ad5755" },
+	{ .compatible = "adi,ad5755-1" },
+	{ .compatible = "adi,ad5757" },
+	{ .compatible = "adi,ad5735" },
+	{ .compatible = "adi,ad5737" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5755_of_match);
+
 static struct spi_driver ad5755_driver = {
 	.driver = {
 		.name = "ad5755",
-- 
2.9.0

