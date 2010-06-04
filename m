Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
To: jic23@cam.ac.uk, gregkh@suse.de
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/3] adis16300: fix some minor issues and clean-up
Date: Fri, 4 Jun 2010 17:19:52 +0800
Message-ID: <1275643194-25328-2-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1275643194-25328-1-git-send-email-21cnbao@gmail.com>
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

1. add delay between spi transfers
2. move burst read to ring function
3. clean-up

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/imu/adis16300.h      |    6 -
 drivers/staging/iio/imu/adis16300_core.c |  151 +++++++++++++-----------------
 drivers/staging/iio/imu/adis16300_ring.c |   54 ++++++++++-
 3 files changed, 119 insertions(+), 95 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16300.h b/drivers/staging/iio/imu/adis16300.h
index 1c7ea5c..b050067 100644
--- a/drivers/staging/iio/imu/adis16300.h
+++ b/drivers/staging/iio/imu/adis16300.h
@@ -115,14 +115,8 @@ struct adis16300_state {
 	struct mutex			buf_lock;
 };
 
-int adis16300_spi_read_burst(struct device *dev, u8 *rx);
-
 int adis16300_set_irq(struct device *dev, bool enable);
 
-int adis16300_reset(struct device *dev);
-
-int adis16300_check_status(struct device *dev);
-
 #ifdef CONFIG_IIO_RING_BUFFER
 /* At the moment triggers are only used for ring buffer
  * filling. This may change!
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 5a7e5ef..28667e8 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -29,10 +29,7 @@
 
 #define DRIVER_NAME		"adis16300"
 
-/* At the moment the spi framework doesn't allow global setting of cs_change.
- * It's in the likely to be added comment at the top of spi.h.
- * This means that use cannot be made of spi_write etc.
- */
+static int adis16300_check_status(struct device *dev);
 
 /**
  * adis16300_spi_write_reg_8() - write single byte to a register
@@ -79,11 +76,13 @@ static int adis16300_spi_write_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
+			.delay_usecs = 75,
 		}, {
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
+			.delay_usecs = 75,
 		},
 	};
 
@@ -122,12 +121,14 @@ static int adis16300_spi_read_reg_16(struct device *dev,
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 0,
+			.cs_change = 1,
+			.delay_usecs = 75,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 0,
+			.cs_change = 1,
+			.delay_usecs = 75,
 		},
 	};
 
@@ -154,54 +155,6 @@ error_ret:
 	return ret;
 }
 
-/**
- * adis16300_spi_read_burst() - read all data registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @rx: somewhere to pass back the value read (min size is 24 bytes)
- **/
-int adis16300_spi_read_burst(struct device *dev, u8 *rx)
-{
-	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
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
-			.len = 18,
-			.cs_change = 0,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16300_READ_REG(ADIS16300_GLOB_CMD);
-	st->tx[1] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-
-	st->us->max_speed_hz = min(ADIS16300_SPI_BURST, old_speed_hz);
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
 static ssize_t adis16300_spi_read_signed(struct device *dev,
 		struct device_attribute *attr,
 		char *buf,
@@ -240,6 +193,24 @@ static ssize_t adis16300_read_12bit_unsigned(struct device *dev,
 	return sprintf(buf, "%u\n", val & 0x0FFF);
 }
 
+static ssize_t adis16300_read_14bit_unsigned(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	u16 val = 0;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis16300_spi_read_reg_16(dev, this_attr->address, &val);
+	if (ret)
+		return ret;
+
+	if (val & ADIS16300_ERROR_ACTIVE)
+		adis16300_check_status(dev);
+
+	return sprintf(buf, "%u\n", val & 0x3FFF);
+}
+
 static ssize_t adis16300_read_14bit_signed(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -356,6 +327,18 @@ static ssize_t adis16300_write_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
+static int adis16300_reset(struct device *dev)
+{
+	int ret;
+	ret = adis16300_spi_write_reg_8(dev,
+			ADIS16300_GLOB_CMD,
+			ADIS16300_GLOB_CMD_SW_RESET);
+	if (ret)
+		dev_err(dev, "problem resetting device");
+
+	return ret;
+}
+
 static ssize_t adis16300_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
@@ -371,8 +354,6 @@ static ssize_t adis16300_write_reset(struct device *dev,
 	return -1;
 }
 
-
-
 int adis16300_set_irq(struct device *dev, bool enable)
 {
 	int ret;
@@ -396,32 +377,37 @@ error_ret:
 	return ret;
 }
 
-int adis16300_reset(struct device *dev)
+/* Power down the device */
+static int adis16300_stop_device(struct device *dev)
 {
 	int ret;
-	ret = adis16300_spi_write_reg_8(dev,
-			ADIS16300_GLOB_CMD,
-			ADIS16300_GLOB_CMD_SW_RESET);
+	u16 val = ADIS16300_SLP_CNT_POWER_OFF;
+
+	ret = adis16300_spi_write_reg_16(dev, ADIS16300_SLP_CNT, val);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(dev, "problem with turning device off: SLP_CNT");
 
 	return ret;
 }
 
-/* Power down the device */
-static int adis16300_stop_device(struct device *dev)
+static int adis16300_self_test(struct device *dev)
 {
 	int ret;
-	u16 val = ADIS16300_SLP_CNT_POWER_OFF;
+	ret = adis16300_spi_write_reg_16(dev,
+			ADIS16300_MSC_CTRL,
+			ADIS16300_MSC_CTRL_MEM_TEST);
+	if (ret) {
+		dev_err(dev, "problem starting self test");
+		goto err_ret;
+	}
 
-	ret = adis16300_spi_write_reg_16(dev, ADIS16300_SLP_CNT, val);
-	if (ret)
-		dev_err(dev, "problem with turning device off: SLP_CNT");
+	adis16300_check_status(dev);
 
+err_ret:
 	return ret;
 }
 
-int adis16300_check_status(struct device *dev)
+static int adis16300_check_status(struct device *dev)
 {
 	u16 status;
 	int ret;
@@ -483,6 +469,11 @@ static int adis16300_initial_setup(struct adis16300_state *st)
 	}
 
 	/* Do self test */
+	ret = adis16300_self_test(dev);
+	if (ret) {
+		dev_err(dev, "self test failure");
+		goto err_ret;
+	}
 
 	/* Read status register to check the result */
 	ret = adis16300_check_status(dev);
@@ -526,7 +517,7 @@ static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
 		adis16300_write_16bit,
 		ADIS16300_ZACCL_OFF);
 
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16300_read_14bit_signed,
+static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16300_read_14bit_unsigned,
 			   ADIS16300_SUPPLY_OUT);
 static IIO_CONST_ATTR(in_supply_scale, "0.00242");
 
@@ -548,7 +539,7 @@ static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
 		ADIS16300_YINCLI_OUT);
 static IIO_CONST_ATTR(incli_scale, "0.044 d");
 
-static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_signed);
+static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned);
 static IIO_CONST_ATTR(temp_offset, "198.16 K");
 static IIO_CONST_ATTR(temp_scale, "0.14 K");
 
@@ -659,15 +650,7 @@ static int __devinit adis16300_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	}
 
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-#if 0 /* fixme: here we should support */
-		iio_init_work_cont(&st->work_cont_thresh,
-				NULL,
-				adis16300_thresh_handler_bh_no_check,
-				0,
-				0,
-				st);
-#endif
+	if (spi->irq) {
 		ret = iio_register_interrupt_line(spi->irq,
 				st->indio_dev,
 				0,
@@ -688,10 +671,9 @@ static int __devinit adis16300_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		adis16300_remove_trigger(st->indio_dev);
+	adis16300_remove_trigger(st->indio_dev);
 error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+	if (spi->irq)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
 error_uninitialize_ring:
 	adis16300_uninitialize_ring(st->indio_dev->ring);
@@ -712,7 +694,6 @@ error_ret:
 	return ret;
 }
 
-/* fixme, confirm ordering in this function */
 static int adis16300_remove(struct spi_device *spi)
 {
 	int ret;
@@ -726,12 +707,12 @@ static int adis16300_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16300_remove_trigger(indio_dev);
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+	if (spi->irq)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
 	adis16300_uninitialize_ring(indio_dev->ring);
-	adis16300_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
+	adis16300_unconfigure_ring(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
 	kfree(st);
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 76cf8a6..17ceb72 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -26,7 +27,7 @@ static inline u16 combine_8_to_16(u8 lower, u8 upper)
 	return _lower | (_upper << 8);
 }
 
-static IIO_SCAN_EL_C(supply, ADIS16300_SCAN_SUPPLY, IIO_SIGNED(14),
+static IIO_SCAN_EL_C(supply, ADIS16300_SCAN_SUPPLY, IIO_UNSIGNED(14),
 		     ADIS16300_SUPPLY_OUT, NULL);
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16300_SCAN_GYRO_X, IIO_SIGNED(14),
@@ -39,9 +40,9 @@ static IIO_SCAN_EL_C(accel_y, ADIS16300_SCAN_ACC_Y, IIO_SIGNED(14),
 static IIO_SCAN_EL_C(accel_z, ADIS16300_SCAN_ACC_Z, IIO_SIGNED(14),
 		     ADIS16300_ZACCL_OUT, NULL);
 
-static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, IIO_SIGNED(12),
+static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, IIO_UNSIGNED(12),
 		     ADIS16300_TEMP_OUT, NULL);
-static IIO_SCAN_EL_C(adc_0, ADIS16300_SCAN_ADC_0, IIO_SIGNED(12),
+static IIO_SCAN_EL_C(adc_0, ADIS16300_SCAN_ADC_0, IIO_UNSIGNED(12),
 		     ADIS16300_AUX_ADC, NULL);
 
 static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X, IIO_SIGNED(12),
@@ -87,6 +88,54 @@ static void adis16300_poll_func_th(struct iio_dev *indio_dev)
 	 */
 }
 
+/**
+ * adis16300_spi_read_burst() - read all data registers
+ * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @rx: somewhere to pass back the value read (min size is 24 bytes)
+ **/
+static int adis16300_spi_read_burst(struct device *dev, u8 *rx)
+{
+	struct spi_message msg;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16300_state *st = iio_dev_get_devdata(indio_dev);
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
+			.len = 18,
+			.cs_change = 0,
+		},
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = ADIS16300_READ_REG(ADIS16300_GLOB_CMD);
+	st->tx[1] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+
+	st->us->max_speed_hz = ADIS16300_SPI_BURST;
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
