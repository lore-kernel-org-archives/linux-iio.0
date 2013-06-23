Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42758 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab3FWVa2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Jun 2013 17:30:28 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/4] iio: add store_eeprom to mcp4725 dac driver
Date: Sun, 23 Jun 2013 23:30:17 +0200
Message-Id: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/dac/mcp4725.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index a612ec7..cb9db90 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -12,14 +12,13 @@
  * driver for the Microchip I2C 12-bit digital-to-analog converter (DAC)
  * (7-bit I2C slave address 0x60, the three LSBs can be configured in
  * hardware)
- *
- * writing the DAC value to EEPROM is not supported
  */
 
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -64,6 +63,66 @@ static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
 #define MCP4725_PM_OPS NULL
 #endif
 
+static int mcp4725_store_eeprom(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct mcp4725_data *data = iio_priv(indio_dev);
+	int tries = 20;
+	u8 inoutbuf[3];
+	bool state;
+	int ret;
+
+	ret = strtobool(buf, &state);
+	if (ret < 0)
+		return ret;
+
+	if (!state)
+		return 0;
+
+	inoutbuf[0] = 0x60; /* write EEPROM */
+	inoutbuf[1] = data->dac_value >> 4;
+	inoutbuf[2] = (data->dac_value & 0xf) << 4;
+
+	ret = i2c_master_send(data->client, inoutbuf, 3);
+	if (ret < 0)
+		return ret;
+	else if (ret != 3)
+		return -EIO;
+
+	/* wait for write complete, takes up to 50ms */
+	while (tries--) {
+		msleep(20);
+		ret = i2c_master_recv(data->client, inoutbuf, 3);
+		if (ret < 0)
+			return ret;
+		else if (ret != 3)
+			return -EIO;
+
+		if (inoutbuf[0] & 0x80)
+			break;
+	}
+
+	if (tries < 0) {
+		dev_err(&data->client->dev,
+			"mcp4725_store_eeprom() failed, incomplete\n");
+		return -EIO;
+	}
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(store_eeprom, S_IWUSR, NULL, mcp4725_store_eeprom, 0);
+
+static struct attribute *mcp4725_attributes[] = {
+	&iio_dev_attr_store_eeprom.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group mcp4725_attribute_group = {
+	.attrs = mcp4725_attributes,
+};
+
 static const struct iio_chan_spec mcp4725_channel = {
 	.type		= IIO_VOLTAGE,
 	.indexed	= 1,
@@ -138,6 +197,7 @@ static int mcp4725_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info mcp4725_info = {
 	.read_raw = mcp4725_read_raw,
 	.write_raw = mcp4725_write_raw,
+	.attrs = &mcp4725_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.8.3.1

