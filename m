Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/4] staging:iio:trivial sparse related cleanups.
Date: Mon, 25 Jul 2011 14:38:58 +0100
Message-Id: <1311601140-20660-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
References: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Getting rid of messages that make it harder to spot important issues.
Some code removed that will be useful one day.  Can put it back then.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_ring.c |   68 ------------------------------
 drivers/staging/iio/adc/ad7150.c         |    2 +
 drivers/staging/iio/dac/ad5791.c         |    1 -
 drivers/staging/iio/light/tsl2563.c      |    2 +-
 drivers/staging/iio/light/tsl2583.c      |    6 +-
 drivers/staging/iio/meter/ade7854.c      |    2 +-
 6 files changed, 7 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 2ecf769..cc38521e 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -218,74 +218,6 @@ static IIO_DEVICE_ATTR(75_percent, S_IRUGO | S_IWUSR,
 		       sca3000_set_ring_int,
 		       SCA3000_INT_MASK_RING_THREE_QUARTER);
 
-
-/**
- * sca3000_show_ring_bpse() -sysfs function to query bits per sample from ring
- * @dev: ring buffer device
- * @attr: this device attribute
- * @buf: buffer to write to
- **/
-static ssize_t sca3000_show_ring_bpse(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	int len = 0, ret;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct sca3000_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
-	if (ret)
-		goto error_ret;
-	if (st->rx[0] & SCA3000_RING_BUF_8BIT)
-		len = sprintf(buf, "s8/8\n");
-	else
-		len = sprintf(buf, "s11/16\n");
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
-/**
- * sca3000_store_ring_bpse() - bits per scan element
- * @dev: ring buffer device
- * @attr: attribute called from
- * @buf: input from userspace
- * @len: length of input
- **/
-static ssize_t sca3000_store_ring_bpse(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf,
-				      size_t len)
-{
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->lock);
-
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
-	if (ret)
-		goto error_ret;
-	if (sysfs_streq(buf, "s8/8")) {
-		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					st->rx[0] | SCA3000_RING_BUF_8BIT);
-		st->bpse = 8;
-	} else if (sysfs_streq(buf, "s11/16")) {
-		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					st->rx[0] & ~SCA3000_RING_BUF_8BIT);
-		st->bpse = 11;
-	} else
-		ret = -EINVAL;
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
 static ssize_t sca3000_show_buffer_scale(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 240c208..973fcea 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -617,6 +617,8 @@ static IIO_DEV_ATTR_POWERDOWN_TIMER(S_IRUGO | S_IWUSR,
 		ad7150_store_powerdown_timer);
 
 static struct attribute *ad7150_attributes[] = {
+	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
+	&iio_dev_attr_conversion_mode.dev_attr.attr,
 	&iio_dev_attr_available_threshold_modes.dev_attr.attr,
 	&iio_dev_attr_threshold_mode.dev_attr.attr,
 	&iio_dev_attr_ch1_threshold.dev_attr.attr,
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 64770d2..5b00b70 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -381,7 +381,6 @@ error_put_reg_pos:
 	if (!IS_ERR(reg_vdd))
 		regulator_put(reg_vdd);
 
-error_ret:
 	return ret;
 }
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index cafcbfb..0e204ce 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -696,7 +696,7 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	struct tsl2563_platform_data *pdata = client->dev.platform_data;
 	int err = 0;
 	int ret;
-	u8 id;
+	u8 id = 0;
 
 	indio_dev = iio_allocate_device(sizeof(*chip));
 	if (!indio_dev)
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index f5ab6f5..923cdfa 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -68,7 +68,7 @@ enum {
 	TSL258X_CHIP_UNKNOWN = 0,
 	TSL258X_CHIP_WORKING = 1,
 	TSL258X_CHIP_SUSPENDED = 2
-} TSL258X_CHIP_WORKING_STATUS;
+};
 
 /* Per-device data */
 struct taos_als_info {
@@ -113,7 +113,7 @@ struct taos_lux {
 /* This structure is intentionally large to accommodate updates via sysfs. */
 /* Sized to 11 = max 10 segments + 1 termination segment */
 /* Assumption is is one and only one type of glass used  */
-struct taos_lux taos_device_lux[11] = {
+static struct taos_lux taos_device_lux[11] = {
 	{  9830,  8520, 15729 },
 	{ 12452, 10807, 23344 },
 	{ 14746,  6383, 11705 },
@@ -318,7 +318,7 @@ out_unlock:
  * to derive actual lux).
  * Return updated gain_trim value.
  */
-int taos_als_calibrate(struct i2c_client *client)
+static int taos_als_calibrate(struct i2c_client *client)
 {
 	struct tsl2583_chip *chip = i2c_get_clientdata(client);
 	u8 reg_val;
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index b82659f..9b240ed 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -582,7 +582,7 @@ error_unreg_dev:
 	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
-error_ret:
+
 	return ret;
 }
 EXPORT_SYMBOL(ade7854_probe);
-- 
1.7.3.4
