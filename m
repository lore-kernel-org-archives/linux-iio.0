Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42759 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab3FWVa3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Jun 2013 17:30:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: add powerdown to mcp4725 dac drive
Date: Sun, 23 Jun 2013 23:30:18 +0200
Message-Id: <1372023020-18742-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net>
References: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/dac/mcp4725.c | 87 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index cb9db90..f569738 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -31,15 +31,19 @@ struct mcp4725_data {
 	struct i2c_client *client;
 	u16 vref_mv;
 	u16 dac_value;
+	bool powerdown;
+	unsigned powerdown_mode;
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int mcp4725_suspend(struct device *dev)
 {
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct mcp4725_data *data = iio_priv(indio_dev);
 	u8 outbuf[2];
 
-	outbuf[0] = 0x3 << 4; /* power-down bits, 500 kOhm resistor */
+	outbuf[0] = (data->powerdown_mode + 1) << 4;
 	outbuf[1] = 0;
+	data->powerdown = true;
 
 	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
 }
@@ -53,10 +57,12 @@ static int mcp4725_resume(struct device *dev)
 	/* restore previous DAC value */
 	outbuf[0] = (data->dac_value >> 8) & 0xf;
 	outbuf[1] = data->dac_value & 0xff;
+	data->powerdown = false;
 
 	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
 #define MCP4725_PM_OPS (&mcp4725_pm_ops)
 #else
@@ -123,6 +129,78 @@ static const struct attribute_group mcp4725_attribute_group = {
 	.attrs = mcp4725_attributes,
 };
 
+static const char * const mcp4725_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"100kohm_to_gnd",
+	"500kohm_to_gnd"
+};
+
+static int mcp4725_get_powerdown_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	struct mcp4725_data *data = iio_priv(indio_dev);
+
+	return data->powerdown_mode;
+}
+
+static int mcp4725_set_powerdown_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned mode)
+{
+	struct mcp4725_data *data = iio_priv(indio_dev);
+
+	data->powerdown_mode = mode;
+
+	return 0;
+}
+
+static ssize_t mcp4725_read_powerdown(struct iio_dev *indio_dev,
+	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+{
+	struct mcp4725_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->powerdown);
+}
+
+static ssize_t mcp4725_write_powerdown(struct iio_dev *indio_dev,
+	 uintptr_t private, const struct iio_chan_spec *chan,
+	 const char *buf, size_t len)
+{
+	struct mcp4725_data *data = iio_priv(indio_dev);
+	bool state;
+	int ret;
+
+	ret = strtobool(buf, &state);
+	if (ret)
+		return ret;
+
+	if (state)
+		ret = mcp4725_suspend(&data->client->dev);
+	else
+		ret = mcp4725_resume(&data->client->dev);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static const struct iio_enum mcp4725_powerdown_mode_enum = {
+	.items = mcp4725_powerdown_modes,
+	.num_items = ARRAY_SIZE(mcp4725_powerdown_modes),
+	.get = mcp4725_get_powerdown_mode,
+	.set = mcp4725_set_powerdown_mode,
+};
+
+static const struct iio_chan_spec_ext_info mcp4725_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = mcp4725_read_powerdown,
+		.write = mcp4725_write_powerdown,
+	},
+	IIO_ENUM("powerdown_mode", false, &mcp4725_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", &mcp4725_powerdown_mode_enum),
+	{ },
+};
+
 static const struct iio_chan_spec mcp4725_channel = {
 	.type		= IIO_VOLTAGE,
 	.indexed	= 1,
@@ -131,6 +209,7 @@ static const struct iio_chan_spec mcp4725_channel = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type	= IIO_ST('u', 12, 16, 0),
+	.ext_info	= mcp4725_ext_info,
 };
 
 static int mcp4725_set_value(struct iio_dev *indio_dev, int val)
@@ -208,6 +287,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct mcp4725_platform_data *platform_data = client->dev.platform_data;
 	u8 inbuf[3];
+	u8 pd;
 	int err;
 
 	if (!platform_data || !platform_data->vref_mv) {
@@ -239,6 +319,9 @@ static int mcp4725_probe(struct i2c_client *client,
 		dev_err(&client->dev, "failed to read DAC value");
 		goto exit_free_device;
 	}
+	pd = (inbuf[0] >> 1) & 0x3;
+	data->powerdown = pd > 0 ? true : false;
+	data->powerdown_mode = pd ? pd-1 : 2; /* 500kohm_to_gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 
 	err = iio_device_register(indio_dev);
-- 
1.8.3.1

