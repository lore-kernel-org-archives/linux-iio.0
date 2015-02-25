Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:35220
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbBYPzm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 10:55:42 -0500
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH 5/7] iio: mlx90614: Allow tuning EEPROM configuration
Date: Wed, 25 Feb 2015 16:55:10 +0100
Message-Id: <1424879712-28304-6-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device attributes for getting/setting emissivity, IIR, and FIR
coefficients, and getting the gain (which should not be modified in
order to keep factory calibration).

The attributes provide raw values whose meaning is described in the
datasheet [1].

Writing to EEPROM requires an explicit erase by writing zero.  In
addition, it takes 20ms for the erase/write to complete.  During this
time no EEPROM register should be accessed.  Therefore, two msleep()s
are added to the write function and a mutex protects against concurrent
access.

Since it is not expected to be updated frequently, the configuration
register is read before modifying it rather than caching it.

[1] http://melexis.com/Assets/IR-sensor-thermometer-MLX90614-Datasheet-5152.aspx

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
---
 drivers/iio/temperature/mlx90614.c | 164 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 0b36746..ab98fb6 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -12,14 +12,16 @@
  *
  * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
  *
- * TODO: sleep mode, configuration EEPROM
+ * TODO: sleep mode
  */
 
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define MLX90614_OP_RAM		0x00
 #define MLX90614_OP_EEPROM	0x20
@@ -53,8 +55,47 @@
 
 struct mlx90614_data {
 	struct i2c_client *client;
+	struct mutex lock; /* for EEPROM access only */
 };
 
+/*
+ * Erase an address and write word.
+ * The mutex must be locked before calling.
+ */
+static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
+			       u16 value)
+{
+	/*
+	 * Note: The mlx90614 requires a PEC on writing but does not send us a
+	 * valid PEC on reading.  Hence, we cannot set I2C_CLIENT_PEC in
+	 * i2c_client.flags.  As a workaround, we use i2c_smbus_xfer here.
+	 */
+	union i2c_smbus_data data;
+	s32 ret;
+
+	dev_dbg(&client->dev, "Writing 0x%x to address 0x%x", value, command);
+
+	data.word = 0x0000; /* erase command */
+	ret = i2c_smbus_xfer(client->adapter, client->addr,
+			     client->flags | I2C_CLIENT_PEC,
+			     I2C_SMBUS_WRITE, command,
+			     I2C_SMBUS_WORD_DATA, &data);
+	if (ret < 0)
+		return ret;
+
+	msleep(MLX90614_TIMING_EEPROM);
+
+	data.word = value; /* actual write */
+	ret = i2c_smbus_xfer(client->adapter, client->addr,
+			     client->flags | I2C_CLIENT_PEC,
+			     I2C_SMBUS_WRITE, command,
+			     I2C_SMBUS_WORD_DATA, &data);
+
+	msleep(MLX90614_TIMING_EEPROM);
+
+	return ret;
+}
+
 static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long mask)
@@ -111,6 +152,102 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t mlx90614_show_emissivity(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	s32 ret;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_read_word_data(data->client, MLX90614_EMISSIVITY);
+	mutex_unlock(&data->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+static ssize_t mlx90614_store_emissivity(struct device *dev,
+					 struct device_attribute *devattr,
+					 const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	u16 val;
+	s32 ret;
+
+	if (kstrtou16(buf, 0, &val))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY, val);
+	mutex_unlock(&data->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t mlx90614_show_config(struct device *dev,
+				    struct device_attribute *devattr,
+				    char *buf)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	struct iio_dev_attr *indio_attr = to_iio_dev_attr(devattr);
+	u16 mask = indio_attr->address & 0xffff;
+	u16 shift = indio_attr->address >> 16;
+	s32 ret;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
+	mutex_unlock(&data->lock);
+
+	if (ret < 0)
+		return ret;
+
+	ret = (ret & mask) >> shift;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+static ssize_t mlx90614_store_config(struct device *dev,
+				     struct device_attribute *devattr,
+				     const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	struct iio_dev_attr *indio_attr = to_iio_dev_attr(devattr);
+	u16 mask = indio_attr->address & 0xffff;
+	u16 shift = indio_attr->address >> 16;
+	u16 val;
+	s32 ret;
+
+	if (kstrtou16(buf, 0, &val) || val != (val & (mask >> shift)))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+
+	ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
+	if (ret < 0)
+		goto out;
+
+	val = (val << shift) | ((u16)ret & ~mask);
+	ret = mlx90614_write_word(data->client, MLX90614_CONFIG, val);
+
+out:
+	mutex_unlock(&data->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
 static const struct iio_chan_spec mlx90614_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -154,7 +291,31 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 	},
 };
 
+static IIO_DEVICE_ATTR(emissivity, S_IRUGO | S_IWUSR, mlx90614_show_emissivity,
+		mlx90614_store_emissivity, -1);
+static IIO_DEVICE_ATTR(iir, S_IRUGO | S_IWUSR,
+		mlx90614_show_config, mlx90614_store_config,
+		(MLX90614_CONFIG_IIR_SHIFT << 16) | MLX90614_CONFIG_IIR_MASK);
+static IIO_DEVICE_ATTR(fir, S_IRUGO | S_IWUSR,
+		mlx90614_show_config, mlx90614_store_config,
+		(MLX90614_CONFIG_FIR_SHIFT << 16) | MLX90614_CONFIG_FIR_MASK);
+static IIO_DEVICE_ATTR(gain, S_IRUGO, mlx90614_show_config, NULL,
+		(MLX90614_CONFIG_GAIN_SHIFT << 16) | MLX90614_CONFIG_GAIN_MASK);
+
+static struct attribute *mlx90614_attr[] = {
+	&iio_dev_attr_emissivity.dev_attr.attr,
+	&iio_dev_attr_iir.dev_attr.attr,
+	&iio_dev_attr_fir.dev_attr.attr,
+	&iio_dev_attr_gain.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group mlx90614_attr_group = {
+	.attrs = mlx90614_attr,
+};
+
 static const struct iio_info mlx90614_info = {
+	.attrs = &mlx90614_attr_group,
 	.read_raw = mlx90614_read_raw,
 	.driver_module = THIS_MODULE,
 };
@@ -189,6 +350,7 @@ static int mlx90614_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
-- 
2.3.0

