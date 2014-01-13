Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48079 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbaAMV2h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Jan 2014 16:28:37 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/6] staging:iio:accel:sca3000: Fix format of comments
Date: Mon, 13 Jan 2014 22:28:30 +0100
Message-Id: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/accel/sca3000_core.c | 52 ++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 908d5cd..b627d8f 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -32,7 +32,8 @@ enum sca3000_variant {
 	e05,
 };
 
-/* Note where option modes are not defined, the chip simply does not
+/*
+ * Note where option modes are not defined, the chip simply does not
  * support any.
  * Other chips in the sca3000 series use i2c and are not included here.
  *
@@ -191,7 +192,6 @@ error_ret:
 	return ret;
 }
 
-/* Crucial that lock is called before calling this */
 /**
  * sca3000_read_ctrl_reg() read from lock protected control register.
  *
@@ -402,7 +402,8 @@ error_ret:
 }
 
 
-/* Not even vaguely standard attributes so defined here rather than
+/*
+ * Not even vaguely standard attributes so defined here rather than
  * in the relevant IIO core headers
  */
 static IIO_DEVICE_ATTR(measurement_mode_available, S_IRUGO,
@@ -662,7 +663,8 @@ error_free_lock:
 	return ret ? ret : len;
 }
 
-/* Should only really be registered if ring buffer support is compiled in.
+/*
+ * Should only really be registered if ring buffer support is compiled in.
  * Does no harm however and doing it right would add a fair bit of complexity
  */
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sca3000_read_av_freq);
@@ -675,10 +677,10 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 /**
  * sca3000_read_temp() sysfs interface to get the temperature when available
  *
-* The alignment of data in here is downright odd. See data sheet.
-* Converting this into a meaningful value is left to inline functions in
-* userspace part of header.
-**/
+ * The alignment of data in here is downright odd. See data sheet.
+ * Converting this into a meaningful value is left to inline functions in
+ * userspace part of header.
+ **/
 static ssize_t sca3000_read_temp(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -802,12 +804,12 @@ static const struct attribute_group sca3000_attribute_group_with_temp = {
 	.attrs = sca3000_attributes_with_temp,
 };
 
-/* RING RELATED interrupt handler */
-/* depending on event, push to the ring buffer event chrdev or the event one */
-
 /**
  * sca3000_event_handler() - handling ring and non ring events
  *
+ * Ring related interrupt handler. Depending on event, push to
+ * the ring buffer event chrdev or the event one.
+ *
  * This function is complicated by the fact that the devices can signify ring
  * and non ring events via the same interrupt line and they can only
  * be distinguished via a read of the relevant status register.
@@ -819,7 +821,8 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	int ret, val;
 	s64 last_timestamp = iio_get_time_ns();
 
-	/* Could lead if badly timed to an extra read of status reg,
+	/*
+	 * Could lead if badly timed to an extra read of status reg,
 	 * but ensures no interrupt is missed.
 	 */
 	mutex_lock(&st->lock);
@@ -934,7 +937,6 @@ static ssize_t sca3000_query_free_fall_mode(struct device *dev,
  * the device falls more than 25cm.  This has not been tested due
  * to fragile wiring.
  **/
-
 static ssize_t sca3000_set_free_fall_mode(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf,
@@ -956,7 +958,7 @@ static ssize_t sca3000_set_free_fall_mode(struct device *dev,
 	if (ret)
 		goto error_ret;
 
-	/*if off and should be on*/
+	/* if off and should be on */
 	if (val && !(st->rx[0] & protect_mask))
 		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
 					(st->rx[0] | SCA3000_FREE_FALL_DETECT));
@@ -991,13 +993,15 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 	int num = chan->channel2;
 
 	mutex_lock(&st->lock);
-	/* First read the motion detector config to find out if
-	 * this axis is on*/
+	/*
+	 * First read the motion detector config to find out if
+	 * this axis is on
+	 */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
 	if (ret < 0)
 		goto exit_point;
 	ctrlval = ret;
-	/* Off and should be on */
+	/* if off and should be on */
 	if (state && !(ctrlval & sca3000_addresses[num][2])) {
 		ret = sca3000_write_ctrl_reg(st,
 					     SCA3000_REG_CTRL_SEL_MD_CTRL,
@@ -1020,7 +1024,7 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto exit_point;
-	/*if off and should be on*/
+	/* if off and should be on */
 	if ((st->mo_det_use_count)
 	    && ((st->rx[0] & protect_mask) != SCA3000_MEAS_MODE_MOT_DET))
 		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
@@ -1066,7 +1070,7 @@ static struct attribute_group sca3000_event_attribute_group = {
  * Devices use flash memory to store many of the register values
  * and hence can come up in somewhat unpredictable states.
  * Hence reset everything on driver load.
-  **/
+ **/
 static int sca3000_clean_setup(struct sca3000_state *st)
 {
 	int ret;
@@ -1106,9 +1110,11 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 				| SCA3000_INT_MASK_ACTIVE_LOW);
 	if (ret)
 		goto error_ret;
-	/* Select normal measurement mode, free fall off, ring off */
-	/* Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
-	 * as that occurs in one of the example on the datasheet */
+	/*
+	 * Select normal measurement mode, free fall off, ring off
+	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
+	 * as that occurs in one of the example on the datasheet
+	 */
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
@@ -1235,7 +1241,7 @@ static int sca3000_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	/* Must ensure no interrupts can be generated after this!*/
+	/* Must ensure no interrupts can be generated after this! */
 	sca3000_stop_all_interrupts(st);
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
-- 
1.8.3.2

