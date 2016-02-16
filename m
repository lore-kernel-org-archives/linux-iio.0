Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:21257 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932478AbcBPO0M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 16 Feb 2016 09:26:12 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 3/4] iio: ad5755: added full support for devicetree
Date: Tue, 16 Feb 2016 15:25:56 +0100
Message-ID: <1455632757-21748-3-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1455632757-21748-2-git-send-email-sean.nyekjaer@prevas.dk>
References: <1455632757-21748-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1455632757-21748-2-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Devicetree can provide platform data

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Changes since v2:
- removed defines from DT

Still missing check of the valid from DT is valid.

 drivers/iio/dac/ad5755.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index e1b6e78..8d264f0 100644
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
@@ -556,6 +557,82 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
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
+	int devnr;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->ext_dc_dc_compenstation_resistor =
+	       of_property_read_bool(np, "adi,ext_dc_dc_compenstation_resistor");
+
+	if (!of_property_read_u32(np, "adi,dc_dc_phase", &tmp))
+		pdata->dc_dc_phase = tmp;
+	else
+		pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
+
+	if (!of_property_read_u32(np, "adi,dc_dc_freq", &tmp))
+		pdata->dc_dc_freq = tmp;
+	else
+		pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
+
+	if (!of_property_read_u32(np, "adi,dc_dc_maxv", &tmp))
+		pdata->dc_dc_maxv = tmp;
+	else
+		pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
+
+	devnr = 0;
+	for_each_child_of_node(np, pp) {
+		if (devnr > AD5755_NUM_CHANNELS) {
+			dev_err(dev, "There is to many channels defined in DT\n");
+			goto error_out;
+		}
+
+		if (!of_property_read_u32(pp, "adi,mode", &tmp))
+			pdata->dac[devnr].mode = tmp;
+		else
+			pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
+
+		pdata->dac[devnr].ext_current_sense_resistor =
+		       of_property_read_bool(pp, "adi,ext_current_sense_resistor");
+
+		pdata->dac[devnr].enable_voltage_overrange =
+			of_property_read_bool(pp, "adi,enable_voltage_overrange");
+		if (!of_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
+			pdata->dac[devnr].slew.enable = tmparray[0];
+			pdata->dac[devnr].slew.rate = tmparray[1];
+			pdata->dac[devnr].slew.step_size = tmparray[2];
+		} else {
+			pdata->dac[devnr].slew.enable = false;
+			pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;
+			pdata->dac[devnr].slew.step_size = AD5755_SLEW_STEP_SIZE_1;
+		}
+
+		devnr++;
+	}
+
+	return pdata;
+
+error_out:
+	devm_kfree(dev, pdata);
+	return NULL;
+}
+#else
+static
+struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int ad5755_probe(struct spi_device *spi)
 {
 	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
@@ -583,8 +660,15 @@ static int ad5755_probe(struct spi_device *spi)
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
-- 
2.7.1

