Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 26/99] staging:iio: Remove legacy event handling.
Date: Wed,  4 May 2011 12:57:58 +0100
Message-Id: <1304510351-10922-27-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This requires all drivers using the channel registration code and
events to change in one go.

V2: rebase related fixes to move to new IIO_CHAN macro. All trivial.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   36 +---
 drivers/staging/iio/accel/sca3000_core.c   |   27 +--
 drivers/staging/iio/adc/max1363.h          |    4 -
 drivers/staging/iio/adc/max1363_core.c     |  115 ++++--------
 drivers/staging/iio/chrdev.h               |   21 ---
 drivers/staging/iio/iio.h                  |   86 +---------
 drivers/staging/iio/industrialio-core.c    |  266 +++-------------------------
 drivers/staging/iio/sysfs.h                |  129 --------------
 8 files changed, 85 insertions(+), 599 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index c764fc9..2b70a67 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -416,10 +416,9 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("280 560 1120 4480");
 
-static irqreturn_t lis3l02dq_event_handler(int irq, void *_int_info)
+static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 {
-	struct iio_interrupt *int_info = _int_info;
-	struct iio_dev *indio_dev = int_info->dev_info;
+	struct iio_dev *indio_dev = private;
 	struct iio_sw_ring_helper_state *h
 		= iio_dev_get_devdata(indio_dev);
 	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
@@ -442,14 +441,11 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *_int_info)
 
 static struct iio_chan_spec lis3l02dq_channels[] = {
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X, LIS3L02DQ_INFO_MASK,
-		 0, 0, IIO_ST('s', 12, 16, 0),
-		 LIS3L02DQ_EVENT_MASK, NULL),
+		 0, 0, IIO_ST('s', 12, 16, 0), LIS3L02DQ_EVENT_MASK),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y, LIS3L02DQ_INFO_MASK,
-		 1, 1, IIO_ST('s', 12, 16, 0),
-		 LIS3L02DQ_EVENT_MASK, NULL),
+		 1, 1, IIO_ST('s', 12, 16, 0), LIS3L02DQ_EVENT_MASK),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z, LIS3L02DQ_INFO_MASK,
-		 2, 2, IIO_ST('s', 12, 16, 0),
-		 LIS3L02DQ_EVENT_MASK, NULL),
+		 2, 2, IIO_ST('s', 12, 16, 0), LIS3L02DQ_EVENT_MASK),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
@@ -508,7 +504,7 @@ int lis3l02dq_disable_all_events(struct iio_dev *indio_dev)
 		goto error_ret;
 
 	if (irqtofree)
-		free_irq(st->us->irq, indio_dev->interrupts[0]);
+		free_irq(st->us->irq, indio_dev);
 
 	ret = control;
 error_ret:
@@ -517,7 +513,6 @@ error_ret:
 
 static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
 					int event_code,
-					struct iio_event_handler_list *list_el,
 					int state)
 {
 	struct iio_sw_ring_helper_state *h
@@ -559,7 +554,7 @@ static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
 					  &lis3l02dq_event_handler,
 					  IRQF_TRIGGER_RISING,
 					  "lis3l02dq_event",
-					  indio_dev->interrupts[0]);
+					  indio_dev);
 			if (ret)
 				goto error_ret;
 		}
@@ -580,7 +575,7 @@ static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
 
 		/* remove interrupt handler if nothing is still on */
 		if (!(val & 0x3f))
-			free_irq(st->us->irq, indio_dev->interrupts[0]);
+			free_irq(st->us->irq, indio_dev);
 	}
 
 error_ret:
@@ -743,16 +738,9 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
 		st->inter = 0;
-		ret = iio_register_interrupt_line(spi->irq,
-						  st->help.indio_dev,
-						  0,
-						  IRQF_TRIGGER_RISING,
-						  "lis3l02dq");
-		if (ret)
-			goto error_uninitialize_ring;
 		ret = lis3l02dq_probe_trigger(st->help.indio_dev);
 		if (ret)
-			goto error_unregister_line;
+			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
@@ -764,9 +752,6 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 error_remove_trigger:
 	if (st->help.indio_dev->modes & INDIO_RING_TRIGGERED)
 		lis3l02dq_remove_trigger(st->help.indio_dev);
-error_unregister_line:
-	if (st->help.indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->help.indio_dev, 0);
 error_uninitialize_ring:
 	iio_ring_buffer_unregister(st->help.indio_dev->ring);
 error_unreg_ring_funcs:
@@ -831,9 +816,6 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	lis3l02dq_remove_trigger(indio_dev);
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
 	iio_ring_buffer_unregister(indio_dev->ring);
 	lis3l02dq_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 00704a5..d11fc94 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -440,14 +440,11 @@ static IIO_DEV_ATTR_REV(sca3000_show_rev);
 
 static struct iio_chan_spec sca3000_channels[] = {
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X, SCA3000_INFO_MASK,
-		 0, 0, IIO_ST('s', 11, 16, 5),
-		 SCA3000_EVENT_MASK, NULL),
+		 0, 0, IIO_ST('s', 11, 16, 5), SCA3000_EVENT_MASK),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y, SCA3000_INFO_MASK,
-		 1, 1, IIO_ST('s', 11, 16, 5),
-		 SCA3000_EVENT_MASK, NULL),
+		 1, 1, IIO_ST('s', 11, 16, 5), SCA3000_EVENT_MASK),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z, SCA3000_INFO_MASK,
-		 2, 2, IIO_ST('s', 11, 16, 5),
-		 SCA3000_EVENT_MASK, NULL),
+		 2, 2, IIO_ST('s', 11, 16, 5), SCA3000_EVENT_MASK),
 };
 
 static u8 sca3000_addresses[3][3] = {
@@ -977,7 +974,6 @@ error_ret:
  **/
 static int sca3000_write_event_config(struct iio_dev *indio_dev,
 				      int e,
-				      struct iio_event_handler_list *list_el,
 				      int state)
 {
 	struct sca3000_state *st = indio_dev->dev_data;
@@ -1032,23 +1028,20 @@ exit_point:
 	return ret;
 }
 
-/* Shared event handler for all events as single event status register */
-IIO_EVENT_SH(all, NULL);
-
 /* Free fall detector related event attribute */
-IIO_EVENT_ATTR_NAMED_SH(accel_xayaz_mag_falling_en,
-			accel_x&y&z_mag_falling_en,
-			iio_event_all,
-			sca3000_query_free_fall_mode,
-			sca3000_set_free_fall_mode,
-			0);
+static IIO_DEVICE_ATTR_NAMED(accel_xayaz_mag_falling_en,
+			     accel_x&y&z_mag_falling_en,
+			     S_IRUGO | S_IWUSR,
+			     sca3000_query_free_fall_mode,
+			     sca3000_set_free_fall_mode,
+			     0);
 
 static IIO_CONST_ATTR_NAMED(accel_xayaz_mag_falling_period,
 			    accel_x&y&z_mag_falling_period,
 			    "0.226");
 
 static struct attribute *sca3000_event_attributes[] = {
-	&iio_event_attr_accel_xayaz_mag_falling_en.dev_attr.attr,
+	&iio_dev_attr_accel_xayaz_mag_falling_en.dev_attr.attr,
 	&iio_const_attr_accel_xayaz_mag_falling_period.dev_attr.attr,
 	NULL,
 };
diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index b5a3dcd..76635a0 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -189,8 +189,6 @@ struct max1363_chip_info {
  * @mask_low:		bitmask for enabled low thresholds
  * @thresh_high:	high threshold values
  * @thresh_low:		low threshold values
- * @last_timestamp:	timestamp of last event interrupt
- * @thresh_work:	bh work structure for event handling
  */
 struct max1363_state {
 	struct i2c_client		*client;
@@ -213,8 +211,6 @@ struct max1363_state {
 	/* 4x unipolar first then the fours bipolar ones */
 	s16				thresh_high[8];
 	s16				thresh_low[8];
-	s64				last_timestamp;
-	struct work_struct		thresh_work;
 };
 
 const struct max1363_mode
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 66bdc87..78ed918 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -263,20 +263,6 @@ static const enum max1363_modes max1363_mode_list[] = {
 	d0m1to2m3, d1m0to3m2,
 };
 
-static int max1363_int_th(struct iio_dev *indio_dev,
-			int index,
-			s64 timestamp,
-			int not_test)
-{
-	struct max1363_state *st = iio_priv(indio_dev);
-
-	st->last_timestamp = timestamp;
-	schedule_work(&st->thresh_work);
-	return 0;
-}
-
-IIO_EVENT_SH(max1363_thresh, max1363_int_th);
-
 #define MAX1363_EV_M						\
 	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)	\
 	 | IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
@@ -284,71 +270,53 @@ IIO_EVENT_SH(max1363_thresh, max1363_int_th);
 
 static struct iio_chan_spec max1363_channels[] = {
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0, MAX1363_INFO_MASK,
-		 _s0, 0, IIO_ST('u', 12, 16, 0), MAX1363_EV_M,
-		 &iio_event_max1363_thresh),
+		 _s0, 0, IIO_ST('u', 12, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0, MAX1363_INFO_MASK,
-		 _s1, 1, IIO_ST('u', 12, 16, 0), MAX1363_EV_M,
-		 &iio_event_max1363_thresh),
+		 _s1, 1, IIO_ST('u', 12, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0, MAX1363_INFO_MASK,
-		 _s2, 2, IIO_ST('u', 12, 16, 0), MAX1363_EV_M,
-		 &iio_event_max1363_thresh),
+		 _s2, 2, IIO_ST('u', 12, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0, MAX1363_INFO_MASK,
-		 _s3, 3, IIO_ST('u', 12, 16, 0), MAX1363_EV_M,
-		 &iio_event_max1363_thresh),
+		 _s3, 3, IIO_ST('u', 12, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 0, 1, MAX1363_INFO_MASK,
-		 d0m1, 4, IIO_ST('s', 12, 16, 0),
-		 MAX1363_EV_M, &iio_event_max1363_thresh),
+		 d0m1, 4, IIO_ST('s', 12, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 3, MAX1363_INFO_MASK,
-		 d2m3, 5, IIO_ST('s', 12, 16, 0),
-		 MAX1363_EV_M, &iio_event_max1363_thresh),
+		 d2m3, 5, IIO_ST('s', 12, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 0, MAX1363_INFO_MASK,
-		 d1m0, 6, IIO_ST('s', 12, 16, 0),
-		 MAX1363_EV_M, &iio_event_max1363_thresh),
+		 d1m0, 6, IIO_ST('s', 12, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 3, 2, MAX1363_INFO_MASK,
-		 d3m2, 7, IIO_ST('s', 12, 16, 0),
-		 MAX1363_EV_M, &iio_event_max1363_thresh),
+		 d3m2, 7, IIO_ST('s', 12, 16, 0), MAX1363_EV_M),
 	IIO_CHAN_SOFT_TIMESTAMP(8)
 };
 
 static struct iio_chan_spec max1361_channels[] = {
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0, MAX1363_INFO_MASK,
-		 _s0, 0, IIO_ST('u', 10, 16, 0), MAX1363_EV_M,
-		 &iio_event_max1363_thresh),
+		 _s0, 0, IIO_ST('u', 10, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0, MAX1363_INFO_MASK,
-		 _s1, 1, IIO_ST('u', 10, 16, 0), MAX1363_EV_M,
-		 &iio_event_max1363_thresh),
+		 _s1, 1, IIO_ST('u', 10, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0, MAX1363_INFO_MASK,
-		 _s2, 2, IIO_ST('u', 10, 16, 0), MAX1363_EV_M,
-		 &iio_event_max1363_thresh),
+		 _s2, 2, IIO_ST('u', 10, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0, MAX1363_INFO_MASK,
-		 _s3, 3, IIO_ST('u', 10, 16, 0), MAX1363_EV_M,
-		 &iio_event_max1363_thresh),
+		 _s3, 3, IIO_ST('u', 10, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 0, 1, MAX1363_INFO_MASK,
-		 d0m1, 4, IIO_ST('s', 10, 16, 0),
-		 MAX1363_EV_M, &iio_event_max1363_thresh),
+		 d0m1, 4, IIO_ST('s', 10, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 3, MAX1363_INFO_MASK,
-		 d2m3, 5, IIO_ST('s', 10, 16, 0),
-		 MAX1363_EV_M, &iio_event_max1363_thresh),
+		 d2m3, 5, IIO_ST('s', 10, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 0, MAX1363_INFO_MASK,
-		 d1m0, 6, IIO_ST('s', 10, 16, 0),
-		 MAX1363_EV_M, &iio_event_max1363_thresh),
+		 d1m0, 6, IIO_ST('s', 10, 16, 0), MAX1363_EV_M),
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 3, 2, MAX1363_INFO_MASK,
-		 d3m2, 7, IIO_ST('s', 10, 16, 0),
-		 MAX1363_EV_M, &iio_event_max1363_thresh),
+		 d3m2, 7, IIO_ST('s', 10, 16, 0), MAX1363_EV_M),
 	IIO_CHAN_SOFT_TIMESTAMP(8)
 };
 
 #define MAX1363_CHAN_U(num, address, scan_index, bits)		\
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, num, 0, MAX1363_INFO_MASK,	\
 		 address, scan_index, IIO_ST('u', bits,		\
-					     (bits == 8) ? 8 : 16, 0),	\
-		 0, NULL)
+					     (bits == 8) ? 8 : 16, 0), 0)
 /* bipolar channel */
 #define MAX1363_CHAN_B(num, num2, address, scan_index, bits)		\
 	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, num, num2, MAX1363_INFO_MASK,\
 		 address, scan_index, IIO_ST('s', bits,		\
-					     (bits == 8) ? 8 : 16, 0),	\
-		 0, NULL)
+					     (bits == 8) ? 8 : 16, 0), 0)
 
 #define MAX1363_4X_CHANS(bits) {		\
 	MAX1363_CHAN_U(0, _s0, 0, bits),	\
@@ -907,11 +875,11 @@ static int max1363_write_thresh(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static void max1363_thresh_handler_bh(struct work_struct *work_s)
+static irqreturn_t max1363_event_handler(int irq, void *private)
 {
-	struct max1363_state *st = container_of(work_s, struct max1363_state,
-						thresh_work);
-	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	struct iio_dev *indio_dev = private;
+	struct max1363_state *st = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns();
 	u8 rx;
 	u8 tx[2] = { st->setupbyte,
 		     MAX1363_MON_INT_ENABLE | (st->monitor_speed << 1) | 0xF0 };
@@ -921,37 +889,39 @@ static void max1363_thresh_handler_bh(struct work_struct *work_s)
 	if (rx & (1 << 0))
 		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_LOW_THRESH(3),
-			st->last_timestamp);
+			timestamp);
 	if (rx & (1 << 1))
 		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_HIGH_THRESH(3),
-			st->last_timestamp);
+			timestamp);
 	if (rx & (1 << 2))
 		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_LOW_THRESH(2),
-			st->last_timestamp);
+			timestamp);
 	if (rx & (1 << 3))
 		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_HIGH_THRESH(2),
-			st->last_timestamp);
+			timestamp);
 	if (rx & (1 << 4))
 		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_LOW_THRESH(1),
-			st->last_timestamp);
+			timestamp);
 	if (rx & (1 << 5))
 		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_HIGH_THRESH(1),
-			st->last_timestamp);
+			timestamp);
 	if (rx & (1 << 6))
 		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_LOW_THRESH(0),
-			st->last_timestamp);
+			timestamp);
 	if (rx & (1 << 7))
 		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_HIGH_THRESH(0),
-			st->last_timestamp);
+			timestamp);
 	enable_irq(st->client->irq);
 	i2c_master_send(st->client, tx, 2);
+
+	return IRQ_HANDLED;
 }
 
 static int max1363_read_event_config(struct iio_dev *indio_dev,
@@ -1108,7 +1078,6 @@ error_ret:
 
 static int max1363_write_event_config(struct iio_dev *indio_dev,
 				      int event_code,
-				      struct iio_event_handler_list *listel,
 				      int state)
 {
 	int ret = 0;
@@ -1140,12 +1109,6 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 			st->mask_high |= (1 << number);
 		}
 	}
-	if (st->monitor_on && !st->mask_high && !st->mask_low)
-		iio_remove_event_from_list(listel,
-					   &indio_dev->interrupts[0]->ev_list);
-	if (!st->monitor_on && state)
-		iio_add_event_to_list(listel,
-				      &indio_dev->interrupts[0]->ev_list);
 
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
 error_ret:
@@ -1264,15 +1227,15 @@ static int __devinit max1363_probe(struct i2c_client *client,
 		goto error_cleanup_ring;
 
 	if (st->chip_info->monitor_mode && client->irq) {
-		ret = iio_register_interrupt_line(client->irq,
-						indio_dev,
-						0,
-						IRQF_TRIGGER_RISING,
-						client->name);
+		ret = request_threaded_irq(st->client->irq,
+					   NULL,
+					   &max1363_event_handler,
+					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					   "max1363_event",
+					   indio_dev);
 
 		if (ret)
 			goto error_uninit_ring;
-		INIT_WORK(&st->thresh_work, max1363_thresh_handler_bh);
 	}
 
 	return 0;
@@ -1304,7 +1267,7 @@ static int max1363_remove(struct i2c_client *client)
 	struct regulator *reg = st->reg;
 
 	if (st->chip_info->monitor_mode && client->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(st->client->irq, indio_dev);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	max1363_ring_cleanup(indio_dev);
 	kfree(indio_dev->available_scan_masks);
diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index d72049c..10491f0 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -78,28 +78,7 @@ struct iio_event_interface {
 	void					*private;
 	char					_name[35];
 	char					_attrname[20];
-
-	struct list_head event_attr_list;
 	struct list_head dev_attr_list;
 };
 
-/**
- * struct iio_event_handler_list - element in list of handlers for events
- * @list:		list header
- * @refcount:		as the handler may be shared between multiple device
- *			side events, reference counting ensures clean removal
- * @exist_lock:		prevents race conditions related to refcount usage.
- * @handler:		event handler function - called on event if this
- *			event_handler is enabled.
- *
- * Each device has one list of these per interrupt line.
- **/
-struct iio_event_handler_list {
-	struct list_head	list;
-	int			refcount;
-	struct mutex		exist_lock;
-	int (*handler)(struct iio_dev *dev_info, int index, s64 timestamp,
-		       int no_test);
-};
-
 #endif
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index a215a12..88e19f8 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -107,7 +107,6 @@ enum iio_chan_info_enum {
  *			the value in channel will be suppressed for attribute
  *			but not for event codes. Typically set it to 0 when
  *			the index is false.
- * @shared_handler:	Single handler for the events registered.
  */
 struct iio_chan_spec {
 	enum iio_chan_type	type;
@@ -127,9 +126,6 @@ struct iio_chan_spec {
 	unsigned		processed_val:1;
 	unsigned		modified:1;
 	unsigned		indexed:1;
-	/* TODO: investigate pushing shared event handling out to
-	 * the drivers */
-	struct iio_event_handler_list *shared_handler;
 };
 /* Meant for internal use only */
 void __iio_device_attr_deinit(struct device_attribute *dev_attr);
@@ -148,8 +144,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
 
 #define IIO_CHAN(_type, _mod, _indexed, _proc, _name, _chan, _chan2,	\
-		 _inf_mask, _address, _si, _stype, _event_mask,		\
-		 _handler)						\
+		 _inf_mask, _address, _si, _stype, _event_mask)		\
 	{ .type = _type,						\
 	  .modified = _mod,						\
 	  .indexed = _indexed,						\
@@ -160,8 +155,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	  .info_mask = _inf_mask,					\
 	  .scan_index = _si,						\
 	  .scan_type = _stype,						\
-	  .event_mask = _event_mask,					\
-	  .shared_handler = _handler }
+	  .event_mask = _event_mask }
 
 #define IIO_CHAN_SOFT_TIMESTAMP(_si)					\
 	{ .type = IIO_TIMESTAMP, .channel = -1,				\
@@ -196,26 +190,6 @@ static inline s64 iio_get_time_ns(void)
 	return timespec_to_ns(&ts);
 }
 
-/**
- * iio_add_event_to_list() - Wraps adding to event lists
- * @el:		the list element of the event to be handled.
- * @head:	the list associated with the event handler being used.
- *
- * Does reference counting to allow shared handlers.
- **/
-void iio_add_event_to_list(struct iio_event_handler_list *el,
-			   struct list_head *head);
-
-/**
- * iio_remove_event_from_list() - Wraps removing from event list
- * @el:		element to be removed
- * @head:	associate list head for the interrupt handler.
- *
- * Does reference counting to allow shared handlers.
- **/
-void iio_remove_event_from_list(struct iio_event_handler_list *el,
-				struct list_head *head);
-
 /* Device operating modes */
 #define INDIO_DIRECT_MODE		0x01
 #define INDIO_RING_TRIGGERED		0x02
@@ -239,7 +213,6 @@ void iio_remove_event_from_list(struct iio_event_handler_list *el,
  * @driver_module:	[DRIVER] module structure used to ensure correct
  *			ownership of chrdevs etc
  * @num_interrupt_lines:[DRIVER] number of physical interrupt lines from device
- * @interrupts:		[INTERN] interrupt line specific event lists etc
  * @event_attrs:	[DRIVER] event control attributes
  * @event_conf_attrs:	[DRIVER] event configuration attributes
  * @event_interfaces:	[INTERN] event chrdevs associated with interrupt lines
@@ -260,7 +233,6 @@ struct iio_dev {
 	struct module			*driver_module;
 
 	int				num_interrupt_lines;
-	struct iio_interrupt		**interrupts;
 	struct attribute_group		*event_attrs;
 	struct attribute_group		*event_conf_attrs;
 
@@ -295,7 +267,6 @@ struct iio_dev {
 
 	int (*write_event_config)(struct iio_dev *indio_dev,
 				  int event_code,
-				  struct iio_event_handler_list *listel,
 				  int state);
 
 	int (*read_event_value)(struct iio_dev *indio_dev,
@@ -319,49 +290,6 @@ int iio_device_register(struct iio_dev *dev_info);
 void iio_device_unregister(struct iio_dev *dev_info);
 
 /**
- * struct iio_interrupt - wrapper used to allow easy handling of multiple
- *			physical interrupt lines
- * @dev_info:		the iio device for which the is an interrupt line
- * @line_number:	associated line number
- * @id:			ida allocated unique id number
- * @irq:		associate interrupt number
- * @ev_list:		event handler list for associated events
- * @ev_list_lock:	ensure only one access to list at a time
- **/
-struct iio_interrupt {
-	struct iio_dev			*dev_info;
-	int				line_number;
-	int				id;
-	int				irq;
-	struct list_head		ev_list;
-	spinlock_t			ev_list_lock;
-};
-
-#define to_iio_interrupt(i) container_of(i, struct iio_interrupt, ev_list)
-
-/**
- * iio_register_interrupt_line() - Tell IIO about interrupt lines
- *
- * @irq:		Typically provided via platform data
- * @dev_info:		IIO device info structure for device
- * @line_number:	Which interrupt line of the device is this?
- * @type:		Interrupt type (e.g. edge triggered etc)
- * @name:		Identifying name.
- **/
-int iio_register_interrupt_line(unsigned int			irq,
-				struct iio_dev			*dev_info,
-				int				line_number,
-				unsigned long			type,
-				const char			*name);
-
-void iio_unregister_interrupt_line(struct iio_dev *dev_info,
-				   int line_number);
-
-
-/* temporarily exported to allow moving of interrupt requesting into drivers */
-irqreturn_t iio_interrupt_handler(int irq, void *_int_info);
-
-/**
  * iio_push_event() - try to add event to the list for userspace reading
  * @dev_info:		IIO device structure
  * @ev_line:		Which event line (hardware interrupt)
@@ -374,16 +302,6 @@ int iio_push_event(struct iio_dev *dev_info,
 		  s64 timestamp);
 
 /**
- * __iio_push_event() - tries to add an event to the list associated with a chrdev
- * @ev_int:		the event interface to which we are pushing the event
- * @ev_code:		the outgoing event code
- * @timestamp:		timestamp of the event
- **/
-int __iio_push_event(struct iio_event_interface *ev_int,
-		     int ev_code,
-		     s64 timestamp);
-
-/**
  * iio_allocate_chrdev() - Allocate a chrdev
  * @handler:	struct that contains relevant file handling for chrdev
  * @dev_info:	iio_dev for which chrdev is being created
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 136ff04..52188f9 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -82,16 +82,13 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBBIAS_SHARED/2] = "calibbias",
 };
 
-/* Used both in the interrupt line put events and the ring buffer ones */
-
-/* Note that in it's current form someone has to be listening before events
- * are queued. Hence a client MUST open the chrdev before the ring buffer is
- * switched on.
- */
-int __iio_push_event(struct iio_event_interface *ev_int,
-		     int ev_code,
-		     s64 timestamp)
+int iio_push_event(struct iio_dev *dev_info,
+		   int ev_line,
+		   int ev_code,
+		   s64 timestamp)
 {
+	struct iio_event_interface *ev_int
+		= &dev_info->event_interfaces[ev_line];
 	struct iio_detected_event_list *ev;
 	int ret = 0;
 
@@ -121,76 +118,8 @@ int __iio_push_event(struct iio_event_interface *ev_int,
 error_ret:
 	return ret;
 }
-EXPORT_SYMBOL(__iio_push_event);
-
-int iio_push_event(struct iio_dev *dev_info,
-		   int ev_line,
-		   int ev_code,
-		   s64 timestamp)
-{
-	return __iio_push_event(&dev_info->event_interfaces[ev_line],
-				ev_code, timestamp);
-}
 EXPORT_SYMBOL(iio_push_event);
 
-/* Generic interrupt line interrupt handler */
-irqreturn_t iio_interrupt_handler(int irq, void *_int_info)
-{
-	struct iio_interrupt *int_info = _int_info;
-	struct iio_dev *dev_info = int_info->dev_info;
-	struct iio_event_handler_list *p;
-	s64 time_ns;
-	unsigned long flags;
-
-	spin_lock_irqsave(&int_info->ev_list_lock, flags);
-	if (list_empty(&int_info->ev_list)) {
-		spin_unlock_irqrestore(&int_info->ev_list_lock, flags);
-		return IRQ_NONE;
-	}
-
-	time_ns = iio_get_time_ns();
-	list_for_each_entry(p, &int_info->ev_list, list) {
-		disable_irq_nosync(irq);
-		p->handler(dev_info, 1, time_ns, !(p->refcount > 1));
-	}
-	spin_unlock_irqrestore(&int_info->ev_list_lock, flags);
-
-	return IRQ_HANDLED;
-}
-EXPORT_SYMBOL(iio_interrupt_handler);
-
-static struct iio_interrupt *iio_allocate_interrupt(void)
-{
-	struct iio_interrupt *i = kmalloc(sizeof *i, GFP_KERNEL);
-	if (i) {
-		spin_lock_init(&i->ev_list_lock);
-		INIT_LIST_HEAD(&i->ev_list);
-	}
-	return i;
-}
-
-/* Confirming the validity of supplied irq is left to drivers.*/
-int iio_register_interrupt_line(unsigned int irq,
-				struct iio_dev *dev_info,
-				int line_number,
-				unsigned long type,
-				const char *name)
-{
-	int ret = 0;
-
-	dev_info->interrupts[line_number] = iio_allocate_interrupt();
-	if (dev_info->interrupts[line_number] == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	dev_info->interrupts[line_number]->line_number = line_number;
-	dev_info->interrupts[line_number]->irq = irq;
-	dev_info->interrupts[line_number]->dev_info = dev_info;
-
-error_ret:
-	return ret;
-}
-EXPORT_SYMBOL(iio_register_interrupt_line);
 
 /* This turns up an awful lot */
 ssize_t iio_read_const_attr(struct device *dev,
@@ -201,52 +130,6 @@ ssize_t iio_read_const_attr(struct device *dev,
 }
 EXPORT_SYMBOL(iio_read_const_attr);
 
-/* Before this runs the interrupt generator must have been disabled */
-void iio_unregister_interrupt_line(struct iio_dev *dev_info, int line_number)
-{
-	/* make sure the interrupt handlers are all done */
-	flush_scheduled_work();
-	kfree(dev_info->interrupts[line_number]);
-}
-EXPORT_SYMBOL(iio_unregister_interrupt_line);
-
-/* Reference counted add and remove */
-void iio_add_event_to_list(struct iio_event_handler_list *el,
-			  struct list_head *head)
-{
-	unsigned long flags;
-	struct iio_interrupt *inter = to_iio_interrupt(head);
-
-	/* take mutex to protect this element */
-	mutex_lock(&el->exist_lock);
-	if (el->refcount == 0) {
-		/* Take the event list spin lock */
-		spin_lock_irqsave(&inter->ev_list_lock, flags);
-		list_add(&el->list, head);
-		spin_unlock_irqrestore(&inter->ev_list_lock, flags);
-	}
-	el->refcount++;
-	mutex_unlock(&el->exist_lock);
-}
-EXPORT_SYMBOL(iio_add_event_to_list);
-
-void iio_remove_event_from_list(struct iio_event_handler_list *el,
-			       struct list_head *head)
-{
-	unsigned long flags;
-	struct iio_interrupt *inter = to_iio_interrupt(head);
-
-	mutex_lock(&el->exist_lock);
-	el->refcount--;
-	if (el->refcount == 0) {
-		/* Take the event list spin lock */
-		spin_lock_irqsave(&inter->ev_list_lock, flags);
-		list_del_init(&el->list);
-		spin_unlock_irqrestore(&inter->ev_list_lock, flags);
-	}
-	mutex_unlock(&el->exist_lock);
-}
-EXPORT_SYMBOL(iio_remove_event_from_list);
 
 static ssize_t iio_event_chrdev_read(struct file *filep,
 				     char __user *buf,
@@ -922,15 +805,14 @@ static ssize_t iio_ev_state_store(struct device *dev,
 				  size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	unsigned long val;
 	ret = strict_strtoul(buf, 10, &val);
 	if (ret || val < 0 || val > 1)
 		return -EINVAL;
 
-	ret = indio_dev->write_event_config(indio_dev, this_attr->mask,
-					    this_attr->listel,
+	ret = indio_dev->write_event_config(indio_dev, this_attr->address,
 					    val);
 	return (ret < 0) ? ret : len;
 }
@@ -940,8 +822,8 @@ static ssize_t iio_ev_state_show(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
-	int val = indio_dev->read_event_config(indio_dev, this_attr->mask);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int val = indio_dev->read_event_config(indio_dev, this_attr->address);
 
 	if (val < 0)
 		return val;
@@ -987,83 +869,6 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	return len;
 }
 
-static int __iio_add_chan_event_attr(const char *postfix,
-				     const char *group,
-				     struct iio_chan_spec const *chan,
-				     unsigned int mask,
-				     struct device *dev,
-				     struct list_head *attr_list)
-{
-	char *name_format, *full_postfix;
-	int ret;
-	struct iio_event_attr *iio_ev_attr;
-
-	iio_ev_attr = kzalloc(sizeof *iio_ev_attr, GFP_KERNEL);
-	if (iio_ev_attr == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	sysfs_attr_init(&iio_ev_attr->dev_attr.attr);
-	ret = __iio_build_postfix(chan, 0, postfix, &full_postfix);
-	if (ret)
-		goto error_ret;
-	/* Special case for types that uses both channel numbers in naming */
-	if (chan->type == IIO_IN_DIFF)
-		name_format
-			= kasprintf(GFP_KERNEL, "%s_%s",
-				    iio_chan_type_name_spec_complex[chan->type],
-				    full_postfix);
-	else if (!chan->indexed)
-		name_format
-			= kasprintf(GFP_KERNEL, "%s_%s",
-				    iio_chan_type_name_spec_shared[chan->type],
-				    full_postfix);
-	else
-		name_format
-			= kasprintf(GFP_KERNEL, "%s%d_%s",
-				    iio_chan_type_name_spec_shared[chan->type],
-				    chan->channel,
-				    full_postfix);
-	if (name_format == NULL) {
-		ret = -ENOMEM;
-		goto error_free_attr;
-	}
-
-	iio_ev_attr->dev_attr.attr.name = kasprintf(GFP_KERNEL,
-						    name_format,
-						    chan->channel,
-						    chan->channel2);
-	if (iio_ev_attr->dev_attr.attr.name == NULL) {
-		ret = -ENOMEM;
-		goto error_free_name_format;
-	}
-
-	iio_ev_attr->dev_attr.attr.mode = S_IRUGO | S_IWUSR;
-	iio_ev_attr->dev_attr.show = &iio_ev_state_show;
-	iio_ev_attr->dev_attr.store = &iio_ev_state_store;
-	iio_ev_attr->mask = mask;
-	iio_ev_attr->listel = chan->shared_handler;
-	ret = sysfs_add_file_to_group(&dev->kobj,
-				      &iio_ev_attr->dev_attr.attr,
-				      group);
-	if (ret < 0)
-		goto error_free_name;
-	list_add(&iio_ev_attr->l, attr_list);
-	kfree(name_format);
-	return 0;
-
-error_free_name:
-	kfree(iio_ev_attr->dev_attr.attr.name);
-error_free_name_format:
-	kfree(name_format);
-error_free_attr:
-	kfree(iio_ev_attr);
-error_ret:
-	return ret;
-}
-
-
 static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 				      struct iio_chan_spec const *chan)
 {
@@ -1102,18 +907,21 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 		default:
 			printk(KERN_INFO "currently unhandled type of event\n");
 		}
-		ret = __iio_add_chan_event_attr(postfix,
-						NULL,
-						chan,
-						mask,
-						/*HACK. - limits us to one
-						  event interface - fix by
-						  extending the bitmask - but
-						  how far*/
-						&dev_info->event_interfaces[0]
-						.dev,
-						&dev_info->event_interfaces[0].
-						event_attr_list);
+		ret = __iio_add_chan_devattr(postfix,
+					     NULL,
+					     chan,
+					     &iio_ev_state_show,
+					     iio_ev_state_store,
+					     mask,
+					     /*HACK. - limits us to one
+					       event interface - fix by
+					       extending the bitmask - but
+					       how far*/
+					     0,
+					     &dev_info->event_interfaces[0]
+					     .dev,
+					     &dev_info->event_interfaces[0].
+					     dev_attr_list);
 		kfree(postfix);
 		if (ret)
 			goto error_ret;
@@ -1149,7 +957,6 @@ static inline void __iio_remove_all_event_sysfs(struct iio_dev *dev_info,
 						int num)
 {
 	struct iio_dev_attr *p, *n;
-	struct iio_event_attr *q, *m;
 	list_for_each_entry_safe(p, n,
 				 &dev_info->event_interfaces[num].
 				 dev_attr_list, l) {
@@ -1160,23 +967,12 @@ static inline void __iio_remove_all_event_sysfs(struct iio_dev *dev_info,
 		kfree(p->dev_attr.attr.name);
 		kfree(p);
 	}
-	list_for_each_entry_safe(q, m,
-				 &dev_info->event_interfaces[num].
-				 event_attr_list, l) {
-		sysfs_remove_file_from_group(&dev_info
-					     ->event_interfaces[num].dev.kobj,
-					     &q->dev_attr.attr,
-					     groupname);
-		kfree(q->dev_attr.attr.name);
-		kfree(q);
-	}
 }
 
 static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
 {
 	int j;
 	int ret;
-	/*p for adding, q for removing */
 	struct attribute **attrp, **attrq;
 
 	if (dev_info->event_conf_attrs && dev_info->event_conf_attrs[i].attrs) {
@@ -1192,7 +988,6 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
 			attrp++;
 		}
 	}
-	INIT_LIST_HEAD(&dev_info->event_interfaces[0].event_attr_list);
 	INIT_LIST_HEAD(&dev_info->event_interfaces[0].dev_attr_list);
 	/* Dynically created from the channels array */
 	if (dev_info->channels) {
@@ -1263,14 +1058,6 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 		goto error_ret;
 	}
 
-	dev_info->interrupts = kzalloc(sizeof(struct iio_interrupt *)
-				       *dev_info->num_interrupt_lines,
-				       GFP_KERNEL);
-	if (dev_info->interrupts == NULL) {
-		ret = -ENOMEM;
-		goto error_free_event_interfaces;
-	}
-
 	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
 		dev_info->event_interfaces[i].owner = dev_info->driver_module;
 
@@ -1328,8 +1115,6 @@ error_remove_sysfs_interfaces:
 error_free_setup_ev_ints:
 	for (j = 0; j < i; j++)
 		iio_free_ev_int(&dev_info->event_interfaces[j]);
-	kfree(dev_info->interrupts);
-error_free_event_interfaces:
 	kfree(dev_info->event_interfaces);
 error_ret:
 
@@ -1352,7 +1137,6 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 
 	for (i = 0; i < dev_info->num_interrupt_lines; i++)
 		iio_free_ev_int(&dev_info->event_interfaces[i]);
-	kfree(dev_info->interrupts);
 	kfree(dev_info->event_interfaces);
 }
 
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 44bd575..6a7642e 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -15,22 +15,6 @@
 #include "iio.h"
 
 /**
- * struct iio_event_attr - event control attribute
- * @dev_attr:	underlying device attribute
- * @mask:	mask for the event when detecting
- * @listel:	list header to allow addition to list of event handlers
-*/
-struct iio_event_attr {
-	struct device_attribute dev_attr;
-	int mask;
-	struct iio_event_handler_list *listel;
-	struct list_head l;
-};
-
-#define to_iio_event_attr(_dev_attr) \
-	container_of(_dev_attr, struct iio_event_attr, dev_attr)
-
-/**
  * struct iio_dev_attr - iio specific device attribute
  * @dev_attr:	underlying device attribute
  * @address:	associated register address
@@ -184,85 +168,6 @@ struct iio_const_attr {
 #define IIO_CONST_ATTR_TEMP_SCALE(_string)		\
 	IIO_CONST_ATTR(temp_scale, _string)
 
-/**
- * IIO_EVENT_SH - generic shared event handler
- * @_name: event name
- * @_handler: handler function to be called
- *
- * This is used in cases where more than one event may result from a single
- * handler.  Often the case that some alarm register must be read and multiple
- * alarms may have been triggered.
- **/
-#define IIO_EVENT_SH(_name, _handler)					\
-	static struct iio_event_handler_list				\
-	iio_event_##_name = {						\
-		.handler = _handler,					\
-		.refcount = 0,						\
-		.exist_lock = __MUTEX_INITIALIZER(iio_event_##_name	\
-						  .exist_lock),		\
-		.list = {						\
-			.next = &iio_event_##_name.list,		\
-			.prev = &iio_event_##_name.list,		\
-		},							\
-	};
-
-/**
- * IIO_EVENT_ATTR_SH - generic shared event attribute
- * @_name: event name
- * @_ev_list: event handler list
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- * @_mask: mask used when detecting the event
- *
- * An attribute with an associated IIO_EVENT_SH
- **/
-#define IIO_EVENT_ATTR_SH(_name, _ev_list, _show, _store, _mask)	\
-	static struct iio_event_attr					\
-	iio_event_attr_##_name						\
-	= { .dev_attr = __ATTR(_name, S_IRUGO | S_IWUSR,		\
-			       _show, _store),				\
-	    .mask = _mask,						\
-	    .listel = &_ev_list };
-
-#define IIO_EVENT_ATTR_NAMED_SH(_vname, _name, _ev_list, _show, _store, _mask) \
-	static struct iio_event_attr					\
-	iio_event_attr_##_vname						\
-	= { .dev_attr = __ATTR(_name, S_IRUGO | S_IWUSR,		\
-			       _show, _store),				\
-	    .mask = _mask,						\
-	    .listel = &_ev_list };
-
-/**
- * IIO_EVENT_ATTR - non-shared event attribute
- * @_name: event name
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- * @_mask: mask used when detecting the event
- * @_handler: handler function to be called
- **/
-#define IIO_EVENT_ATTR(_name, _show, _store, _mask, _handler)		\
-	IIO_EVENT_SH(_name, _handler);					\
-	static struct							\
-	iio_event_attr							\
-	iio_event_attr_##_name						\
-	= { .dev_attr = __ATTR(_name, S_IRUGO | S_IWUSR,		\
-			       _show, _store),				\
-	    .mask = _mask,						\
-	    .listel = &iio_event_##_name };				\
-
-/**
- * IIO_EVENT_ATTR_DATA_RDY - event driven by data ready signal
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- * @_mask: mask used when detecting the event
- * @_handler: handler function to be called
- *
- * Not typically implemented in devices where full triggering support
- * has been implemented.
- **/
-#define IIO_EVENT_ATTR_DATA_RDY(_show, _store, _mask, _handler) \
-	IIO_EVENT_ATTR(data_rdy, _show, _store, _mask, _handler)
-
 /* must match our channel defs */
 #define IIO_EV_CLASS_IN			IIO_IN
 #define IIO_EV_CLASS_IN_DIFF		IIO_IN_DIFF
@@ -322,38 +227,4 @@ struct iio_const_attr {
 
 #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 13) & 0x7)
 
-/**
- * IIO_EVENT_ATTR_RING_50_FULL - ring buffer event to indicate 50% full
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- * @_mask: mask used when detecting the event
- * @_handler: handler function to be called
- **/
-#define IIO_EVENT_ATTR_RING_50_FULL(_show, _store, _mask, _handler)	\
-	IIO_EVENT_ATTR(ring_50_full, _show, _store, _mask, _handler)
-
-/**
- * IIO_EVENT_ATTR_RING_50_FULL_SH - shared ring event to indicate 50% full
- * @_evlist: event handler list
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- * @_mask: mask used when detecting the event
- **/
-#define IIO_EVENT_ATTR_RING_50_FULL_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(ring_50_full, _evlist, _show, _store, _mask)
-
-/**
- * IIO_EVENT_ATTR_RING_75_FULL_SH - shared ring event to indicate 75% full
- * @_evlist: event handler list
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- * @_mask: mask used when detecting the event
- **/
-#define IIO_EVENT_ATTR_RING_75_FULL_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(ring_75_full, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_CODE_RING_50_FULL	IIO_BUFFER_EVENT_CODE(0)
-#define IIO_EVENT_CODE_RING_75_FULL	IIO_BUFFER_EVENT_CODE(1)
-#define IIO_EVENT_CODE_RING_100_FULL	IIO_BUFFER_EVENT_CODE(2)
-
 #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
-- 
1.7.3.4
