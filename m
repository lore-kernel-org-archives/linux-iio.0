Return-Path: <SRS0=wNh4=6A=cisco.com=gauragup@kernel.org>
Date: Tue, 27 Jun 2017 11:59:56 -0700
From: Gaurav Gupta <gauragup@cisco.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH] iio/adc/ltc2497: Add IIO to HWMON hooks
Message-ID: <20170627185956.GA13580@sjc-ads-988.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Add missing hooks in the LTC2497 IIO driver to allow hwmon mapping.

Signed-off-by: Gaurav Gupta <gauragup@cisco.com>
---
 drivers/iio/adc/ltc2497.c | 54 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 2691b10..5bf8011 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -127,13 +128,14 @@ static int ltc2497_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-#define LTC2497_CHAN(_chan, _addr) { \
+#define LTC2497_CHAN(_chan, _addr, _ds_name) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
 	.channel = (_chan), \
 	.address = (_addr | (_chan / 2) | ((_chan & 1) ? LTC2497_SIGN : 0)), \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.datasheet_name = (_ds_name), \
 }
 
 #define LTC2497_CHAN_DIFF(_chan, _addr) { \
@@ -148,22 +150,22 @@ static int ltc2497_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec ltc2497_channel[] = {
-	LTC2497_CHAN(0, LTC2497_SGL),
-	LTC2497_CHAN(1, LTC2497_SGL),
-	LTC2497_CHAN(2, LTC2497_SGL),
-	LTC2497_CHAN(3, LTC2497_SGL),
-	LTC2497_CHAN(4, LTC2497_SGL),
-	LTC2497_CHAN(5, LTC2497_SGL),
-	LTC2497_CHAN(6, LTC2497_SGL),
-	LTC2497_CHAN(7, LTC2497_SGL),
-	LTC2497_CHAN(8, LTC2497_SGL),
-	LTC2497_CHAN(9, LTC2497_SGL),
-	LTC2497_CHAN(10, LTC2497_SGL),
-	LTC2497_CHAN(11, LTC2497_SGL),
-	LTC2497_CHAN(12, LTC2497_SGL),
-	LTC2497_CHAN(13, LTC2497_SGL),
-	LTC2497_CHAN(14, LTC2497_SGL),
-	LTC2497_CHAN(15, LTC2497_SGL),
+	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),
+	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),
+	LTC2497_CHAN(2, LTC2497_SGL, "CH2"),
+	LTC2497_CHAN(3, LTC2497_SGL, "CH3"),
+	LTC2497_CHAN(4, LTC2497_SGL, "CH4"),
+	LTC2497_CHAN(5, LTC2497_SGL, "CH5"),
+	LTC2497_CHAN(6, LTC2497_SGL, "CH6"),
+	LTC2497_CHAN(7, LTC2497_SGL, "CH7"),
+	LTC2497_CHAN(8, LTC2497_SGL, "CH8"),
+	LTC2497_CHAN(9, LTC2497_SGL, "CH9"),
+	LTC2497_CHAN(10, LTC2497_SGL, "CH10"),
+	LTC2497_CHAN(11, LTC2497_SGL, "CH11"),
+	LTC2497_CHAN(12, LTC2497_SGL, "CH12"),
+	LTC2497_CHAN(13, LTC2497_SGL, "CH13"),
+	LTC2497_CHAN(14, LTC2497_SGL, "CH14"),
+	LTC2497_CHAN(15, LTC2497_SGL, "CH15"),
 	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),
 	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),
 	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),
@@ -192,6 +194,7 @@ static int ltc2497_probe(struct i2c_client *client,
 {
 	struct iio_dev *indio_dev;
 	struct ltc2497_st *st;
+	struct iio_map *plat_data;
 	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
@@ -221,19 +224,31 @@ static int ltc2497_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	if (client->dev.platform_data) {
+		plat_data = ((struct iio_map *)client->dev.platform_data);
+		ret = iio_map_array_register(indio_dev, plat_data);
+		if (ret) {
+			dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
+			goto err_regulator_disable;
+		}
+	}
+
 	ret = i2c_smbus_write_byte(st->client, LTC2497_CONFIG_DEFAULT);
 	if (ret < 0)
-		goto err_regulator_disable;
+		goto err_array_unregister;
 
 	st->addr_prev = LTC2497_CONFIG_DEFAULT;
 	st->time_prev = ktime_get();
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto err_regulator_disable;
+		goto err_array_unregister;
 
 	return 0;
 
+err_array_unregister:
+	iio_map_array_unregister(indio_dev);
+
 err_regulator_disable:
 	regulator_disable(st->ref);
 
@@ -245,6 +260,7 @@ static int ltc2497_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ltc2497_st *st = iio_priv(indio_dev);
 
+	iio_map_array_unregister(indio_dev);
 	iio_device_unregister(indio_dev);
 	regulator_disable(st->ref);
 
-- 
2.10.2.dirty
