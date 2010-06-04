Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
To: jic23@cam.ac.uk, gregkh@suse.de
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/3] adis16400: fix some minor issues and clean-up
Date: Fri, 4 Jun 2010 17:19:53 +0800
Message-ID: <1275643194-25328-3-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1275643194-25328-2-git-send-email-21cnbao@gmail.com>
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com>
 <1275643194-25328-2-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

1. move adis16400_spi_read_burst() to adis16400_ring.c since it is only
   called there
2. add the lost calling to adis16400_self_test()
3. codes cleanup

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/imu/adis16400.h      |    6 --
 drivers/staging/iio/imu/adis16400_core.c |   84 +++++++----------------------
 drivers/staging/iio/imu/adis16400_ring.c |   48 +++++++++++++++++
 3 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 5a69a7a..04bae36 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -147,14 +147,8 @@ struct adis16400_state {
 	struct mutex			buf_lock;
 };
 
-int adis16400_spi_read_burst(struct device *dev, u8 *rx);
-
 int adis16400_set_irq(struct device *dev, bool enable);
 
-int adis16400_reset(struct device *dev);
-
-int adis16400_check_status(struct device *dev);
-
 #ifdef CONFIG_IIO_RING_BUFFER
 /* At the moment triggers are only used for ring buffer
  * filling. This may change!
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index e69e2ce..a668a90 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -36,6 +36,8 @@
 
 #define DRIVER_NAME		"adis16400"
 
+static int adis16400_check_status(struct device *dev);
+
 /* At the moment the spi framework doesn't allow global setting of cs_change.
  * It's in the likely to be added comment at the top of spi.h.
  * This means that use cannot be made of spi_write etc.
@@ -161,54 +163,6 @@ error_ret:
 	return ret;
 }
 
-/**
- * adis16400_spi_read_burst() - read all data registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @rx: somewhere to pass back the value read (min size is 24 bytes)
- **/
-int adis16400_spi_read_burst(struct device *dev, u8 *rx)
-{
-	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	u32 old_speed_hz = st->us->max_speed_hz;
-	int ret;
-
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 0,
-		}, {
-			.rx_buf = rx,
-			.bits_per_word = 8,
-			.len = 24,
-			.cs_change = 1,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_READ_REG(ADIS16400_GLOB_CMD);
-	st->tx[1] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-
-	st->us->max_speed_hz = min(ADIS16400_SPI_BURST, old_speed_hz);
-	spi_setup(st->us);
-
-	ret = spi_sync(st->us, &msg);
-	if (ret)
-		dev_err(&st->us->dev, "problem when burst reading");
-
-	st->us->max_speed_hz = old_speed_hz;
-	spi_setup(st->us);
-	mutex_unlock(&st->buf_lock);
-	return ret;
-}
-
 static ssize_t adis16400_spi_read_signed(struct device *dev,
 		struct device_attribute *attr,
 		char *buf,
@@ -277,7 +231,6 @@ static ssize_t adis16400_read_12bit_signed(struct device *dev,
 	return ret;
 }
 
-
 static ssize_t adis16400_write_16bit(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -349,6 +302,18 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
+static int adis16400_reset(struct device *dev)
+{
+	int ret;
+	ret = adis16400_spi_write_reg_8(dev,
+			ADIS16400_GLOB_CMD,
+			ADIS16400_GLOB_CMD_SW_RESET);
+	if (ret)
+		dev_err(dev, "problem resetting device");
+
+	return ret;
+}
+
 static ssize_t adis16400_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
@@ -364,8 +329,6 @@ static ssize_t adis16400_write_reset(struct device *dev,
 	return -1;
 }
 
-
-
 int adis16400_set_irq(struct device *dev, bool enable)
 {
 	int ret;
@@ -388,18 +351,6 @@ error_ret:
 	return ret;
 }
 
-int adis16400_reset(struct device *dev)
-{
-	int ret;
-	ret = adis16400_spi_write_reg_8(dev,
-			ADIS16400_GLOB_CMD,
-			ADIS16400_GLOB_CMD_SW_RESET);
-	if (ret)
-		dev_err(dev, "problem resetting device");
-
-	return ret;
-}
-
 /* Power down the device */
 static int adis16400_stop_device(struct device *dev)
 {
@@ -430,7 +381,7 @@ err_ret:
 	return ret;
 }
 
-int adis16400_check_status(struct device *dev)
+static int adis16400_check_status(struct device *dev)
 {
 	u16 status;
 	int ret;
@@ -496,6 +447,11 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 	}
 
 	/* Do self test */
+	ret = adis16400_self_test(dev);
+	if (ret) {
+		dev_err(dev, "self test failure");
+		goto err_ret;
+	}
 
 	/* Read status register to check the result */
 	ret = adis16400_check_status(dev);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 5529b32..5d94cdc 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -96,6 +97,54 @@ static void adis16400_poll_func_th(struct iio_dev *indio_dev)
 	 */
 }
 
+/**
+ * adis16400_spi_read_burst() - read all data registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @rx: somewhere to pass back the value read (min size is 24 bytes)
+ **/
+static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	u32 old_speed_hz = st->us->max_speed_hz;
+	int ret;
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 0,
+		}, {
+			.rx_buf = rx,
+			.bits_per_word = 8,
+			.len = 24,
+			.cs_change = 1,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16400_READ_REG(ADIS16400_GLOB_CMD);
+	st->tx[1] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+
+	st->us->max_speed_hz = min(ADIS16400_SPI_BURST, old_speed_hz);
+	spi_setup(st->us);
+
+	ret = spi_sync(st->us, &msg);
+	if (ret)
+		dev_err(&st->us->dev, "problem when burst reading");
+
+	st->us->max_speed_hz = old_speed_hz;
+	spi_setup(st->us);
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
 /* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
  * specific to be rolled into the core.
  */
-- 
1.5.6.3
