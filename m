Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/11] staging:iio:max1363 add theshold event support
Date: Mon, 24 May 2010 22:02:56 +0100
Message-Id: <1274734976-7941-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---

This patch does raise some interesting questions
that I'll bring up on the list in a future thread.

I've taken a few short cuts in here that take
advantage of the fact only the max136x chips
that are supported by this set actually have a monitor
mode.  If others turn up, we'll have to look at handling
the 'monitor modes' properly in a similar fashion to that
used for scan modes.

 drivers/staging/iio/adc/adc.h          |    3 +
 drivers/staging/iio/adc/max1363.h      |   45 +-
 drivers/staging/iio/adc/max1363_core.c |  696 +++++++++++++++++++++++++++++++-
 3 files changed, 721 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/adc/adc.h b/drivers/staging/iio/adc/adc.h
index 04eb16f..7841e6a 100644
--- a/drivers/staging/iio/adc/adc.h
+++ b/drivers/staging/iio/adc/adc.h
@@ -26,3 +26,6 @@
 			      _show,					\
 			      NULL,					\
 			      _addr)
+
+#define IIO_EVENT_CODE_IN_HIGH_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a)
+#define IIO_EVENT_CODE_IN_LOW_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a + 32)
diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 9f00783..1d30864 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -32,14 +32,6 @@
 
 /* Specific to the max1363 */
 #define MAX1363_MON_RESET_CHAN(a) (1 << ((a) + 4))
-#define MAX1363_MON_CONV_RATE_133ksps		0
-#define MAX1363_MON_CONV_RATE_66_5ksps		0x02
-#define MAX1363_MON_CONV_RATE_33_3ksps		0x04
-#define MAX1363_MON_CONV_RATE_16_6ksps		0x06
-#define MAX1363_MON_CONV_RATE_8_3ksps		0x08
-#define MAX1363_MON_CONV_RATE_4_2ksps		0x0A
-#define MAX1363_MON_CONV_RATE_2_0ksps		0x0C
-#define MAX1363_MON_CONV_RATE_1_0ksps		0x0E
 #define MAX1363_MON_INT_ENABLE			0x01
 
 /* defined for readability reasons */
@@ -67,9 +59,8 @@
 
 /**
  * struct max1363_mode - scan mode information
- * @name:	Name used to identify the scan mode.
  * @conf:	The corresponding value of the configuration register
- * @numvals:	The number of values returned by a single scan
+ * @modemask:	Bit mask corresponding to channels enabled in this mode
  */
 struct max1363_mode {
 	int8_t		conf;
@@ -122,15 +113,6 @@ struct max1363_mode {
 			.modemask = _mask				\
 }
 
-/* Not currently handled */
-#define MAX1363_MODE_MONITOR {					\
-		.name = "monitor",				\
-			.conf = MAX1363_CHANNEL_SEL(3)		\
-			| MAX1363_CONFIG_SCAN_MONITOR_MODE	\
-			| MAX1363_CONFIG_SE,			\
-			.numvals = 10,				\
-		}
-
 /* This may seem an overly long winded way to do this, but at least it makes
  * clear what all the various options actually do. Alternative suggestions
  * that don't require user to have intimate knowledge of the chip welcomed.
@@ -190,7 +172,6 @@ struct max1363_chip_info {
 	struct attribute_group		*scan_attrs;
 };
 
-
 /**
  * struct max1363_state - driver instance specific data
  * @indio_dev:		the industrial I/O device
@@ -203,12 +184,20 @@ struct max1363_chip_info {
  * @poll_work:		bottom half of polling interrupt handler
  * @protect_ring:	used to ensure only one polling bh running at a time
  * @reg:		supply regulator
+ * @monitor_on:		whether monitor mode is enabled
+ * @monitor_speed:	parameter corresponding to device monitor speed setting
+ * @mask_high:		bitmask for enabled high thresholds
+ * @mask_low:		bitmask for enabled low thresholds
+ * @thresh_high:	high threshold values
+ * @thresh_low:		low threshold values
+ * @last_timestamp:	timestamp of last event interrupt
+ * @thresh_work:	bh work structure for event handling
  */
 struct max1363_state {
 	struct iio_dev			*indio_dev;
 	struct i2c_client		*client;
-	char				setupbyte;
-	char				configbyte;
+	u8				setupbyte;
+	u8				configbyte;
 	const struct max1363_chip_info	*chip_info;
 	const struct max1363_mode	*current_mode;
 	u32				requestedmask;
@@ -216,6 +205,18 @@ struct max1363_state {
 	atomic_t			protect_ring;
 	struct iio_trigger		*trig;
 	struct regulator		*reg;
+
+	/* Using monitor modes and buffer at the same time is
+	   currently not supported */
+	bool				monitor_on;
+	unsigned int			monitor_speed:3;
+	u8				mask_high;
+	u8				mask_low;
+	/* 4x unipolar first then the fours bipolar ones */
+	s16				thresh_high[8];
+	s16				thresh_low[8];
+	s64				last_timestamp;
+	struct work_struct		thresh_work;
 };
 
 const struct max1363_mode
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 3d2f8d9..9ba5464 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -18,7 +18,6 @@
   *
   * Not currently implemented.
   *
-  * - Monitor interrrupt generation.
   * - Control of internal reference.
   */
 
@@ -205,6 +204,16 @@ static ssize_t max1363_read_single_channel(struct device *dev,
 	long mask;
 
 	mutex_lock(&dev_info->mlock);
+	/*
+	 * If monitor mode is enabled, the method for reading a single
+	 * channel will have to be rather different and has not yet
+	 * been implemented.
+	 */
+	if (st->monitor_on) {
+		ret = -EBUSY;
+		goto error_ret;
+	}
+
 	/* If ring buffer capture is occuring, query the buffer */
 	if (iio_ring_enabled(dev_info)) {
 		mask = max1363_mode_table[this_attr->address].modemask;
@@ -897,6 +906,668 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	}
 };
 
+static const int max1363_monitor_speeds[] = { 133000, 665000, 33300, 16600,
+					      8300, 4200, 2000, 1000 };
+
+static ssize_t max1363_monitor_show_freq(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	return sprintf(buf, "%d\n", max1363_monitor_speeds[st->monitor_speed]);
+}
+
+static ssize_t max1363_monitor_store_freq(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	int i, ret;
+	unsigned long val;
+	bool found = false;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(max1363_monitor_speeds); i++)
+		if (val == max1363_monitor_speeds[i]) {
+			found = true;
+			break;
+		}
+	if (!found)
+		return -EINVAL;
+
+	mutex_lock(&dev_info->mlock);
+	st->monitor_speed = i;
+	mutex_unlock(&dev_info->mlock);
+
+	return 0;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
+			max1363_monitor_show_freq,
+			max1363_monitor_store_freq);
+
+static IIO_CONST_ATTR(sampling_frequency_available,
+		"133000 665000 33300 16600 8300 4200 2000 1000");
+
+static ssize_t max1363_show_thresh(struct device *dev,
+				struct device_attribute *attr,
+				char *buf,
+				bool high)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	if (high)
+		return sprintf(buf, "%d\n",
+			st->thresh_high[this_attr->address]);
+	else
+		return sprintf(buf, "%d\n",
+			st->thresh_low[this_attr->address & 0x7]);
+}
+
+static ssize_t max1363_show_thresh_low(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	return max1363_show_thresh(dev, attr, buf, false);
+}
+
+static ssize_t max1363_show_thresh_high(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return max1363_show_thresh(dev, attr, buf, true);
+}
+
+static ssize_t max1363_store_thresh_unsigned(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len,
+					bool high)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned long val;
+	int ret;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+	switch (st->chip_info->bits) {
+	case 10:
+		if (val > 0x3FF)
+			return -EINVAL;
+		break;
+	case 12:
+		if (val > 0xFFF)
+			return -EINVAL;
+		break;
+	}
+
+	switch (high) {
+	case 1:
+		st->thresh_high[this_attr->address] = val;
+		break;
+	case 0:
+		st->thresh_low[this_attr->address & 0x7] = val;
+		break;
+	}
+
+	return len;
+}
+
+static ssize_t max1363_store_thresh_high_unsigned(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len)
+{
+	return max1363_store_thresh_unsigned(dev, attr, buf, len, true);
+}
+
+static ssize_t max1363_store_thresh_low_unsigned(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len)
+{
+	return max1363_store_thresh_unsigned(dev, attr, buf, len, false);
+}
+
+static ssize_t max1363_store_thresh_signed(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len,
+					bool high)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	long val;
+	int ret;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+	switch (st->chip_info->bits) {
+	case 10:
+		if (val < -512 || val > 511)
+			return -EINVAL;
+		break;
+	case 12:
+		if (val < -2048 || val > 2047)
+			return -EINVAL;
+		break;
+	}
+
+	switch (high) {
+	case 1:
+		st->thresh_high[this_attr->address] = val;
+		break;
+	case 0:
+		st->thresh_low[this_attr->address & 0x7] = val;
+		break;
+	}
+
+	return len;
+}
+
+static ssize_t max1363_store_thresh_high_signed(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len)
+{
+	return max1363_store_thresh_signed(dev, attr, buf, len, true);
+}
+
+static ssize_t max1363_store_thresh_low_signed(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len)
+{
+	return max1363_store_thresh_signed(dev, attr, buf, len, false);
+}
+
+static IIO_DEVICE_ATTR(in0_thresh_high_value, S_IRUGO | S_IWUSR,
+		max1363_show_thresh_high,
+		max1363_store_thresh_high_unsigned, 0);
+static IIO_DEVICE_ATTR(in0_thresh_low_value, S_IRUGO | S_IWUSR,
+		max1363_show_thresh_low,
+		max1363_store_thresh_low_unsigned, 0);
+static IIO_DEVICE_ATTR(in1_thresh_high_value, S_IRUGO | S_IWUSR,
+		max1363_show_thresh_high,
+		max1363_store_thresh_high_unsigned, 1);
+static IIO_DEVICE_ATTR(in1_thresh_low_value, S_IRUGO | S_IWUSR,
+		max1363_show_thresh_low,
+		max1363_store_thresh_low_unsigned, 1);
+static IIO_DEVICE_ATTR(in2_thresh_high_value, S_IRUGO | S_IWUSR,
+		max1363_show_thresh_high,
+		max1363_store_thresh_high_unsigned, 2);
+static IIO_DEVICE_ATTR(in2_thresh_low_value, S_IRUGO | S_IWUSR,
+		max1363_show_thresh_low,
+		max1363_store_thresh_low_unsigned, 2);
+static IIO_DEVICE_ATTR(in3_thresh_high_value, S_IRUGO | S_IWUSR,
+		max1363_show_thresh_high,
+		max1363_store_thresh_high_unsigned, 3);
+static IIO_DEVICE_ATTR(in3_thresh_low_value, S_IRUGO | S_IWUSR,
+		max1363_show_thresh_low,
+		max1363_store_thresh_low_unsigned, 3);
+
+static IIO_DEVICE_ATTR_NAMED(in0min1_thresh_high_value,
+			in0-in1_thresh_high_value,
+			S_IRUGO | S_IWUSR, max1363_show_thresh_high,
+			max1363_store_thresh_high_signed, 4);
+static IIO_DEVICE_ATTR_NAMED(in0min1_thresh_low_value,
+			in0-in1_thresh_low_value,
+			S_IRUGO | S_IWUSR, max1363_show_thresh_low,
+			max1363_store_thresh_low_signed, 4);
+static IIO_DEVICE_ATTR_NAMED(in2min3_thresh_high_value,
+			in2-in3_thresh_high_value,
+			S_IRUGO | S_IWUSR, max1363_show_thresh_high,
+			max1363_store_thresh_high_signed, 5);
+static IIO_DEVICE_ATTR_NAMED(in2min3_thresh_low_value,
+			in2-in3_thresh_low_value,
+			S_IRUGO | S_IWUSR, max1363_show_thresh_low,
+			max1363_store_thresh_low_signed, 5);
+static IIO_DEVICE_ATTR_NAMED(in1min0_thresh_high_value,
+			in1-in0_thresh_high_value,
+			S_IRUGO | S_IWUSR, max1363_show_thresh_high,
+			max1363_store_thresh_high_signed, 6);
+static IIO_DEVICE_ATTR_NAMED(in1min0_thresh_low_value,
+			in1-in0_thresh_low_value,
+			S_IRUGO | S_IWUSR, max1363_show_thresh_low,
+			max1363_store_thresh_low_signed, 6);
+static IIO_DEVICE_ATTR_NAMED(in3min2_thresh_high_value,
+			in3-in2_thresh_high_value,
+			S_IRUGO | S_IWUSR, max1363_show_thresh_high,
+			max1363_store_thresh_high_signed, 7);
+static IIO_DEVICE_ATTR_NAMED(in3min2_thresh_low_value,
+			in3-in2_thresh_low_value,
+			S_IRUGO | S_IWUSR, max1363_show_thresh_low,
+			max1363_store_thresh_low_signed, 7);
+
+static int max1363_int_th(struct iio_dev *dev_info,
+			int index,
+			s64 timestamp,
+			int not_test)
+{
+	struct max1363_state *st = dev_info->dev_data;
+
+	st->last_timestamp = timestamp;
+	schedule_work(&st->thresh_work);
+	return 0;
+}
+
+static void max1363_thresh_handler_bh(struct work_struct *work_s)
+{
+	struct max1363_state *st = container_of(work_s, struct max1363_state,
+						thresh_work);
+	u8 rx;
+	u8 tx[2] = { st->setupbyte,
+		     MAX1363_MON_INT_ENABLE | (st->monitor_speed << 1) | 0xF0 };
+
+	i2c_master_recv(st->client, &rx, 1);
+	if (rx & (1 << 0))
+		iio_push_event(st->indio_dev, 0,
+			IIO_EVENT_CODE_IN_LOW_THRESH(3),
+			st->last_timestamp);
+	if (rx & (1 << 1))
+		iio_push_event(st->indio_dev, 0,
+			IIO_EVENT_CODE_IN_HIGH_THRESH(3),
+			st->last_timestamp);
+	if (rx & (1 << 2))
+		iio_push_event(st->indio_dev, 0,
+			IIO_EVENT_CODE_IN_LOW_THRESH(2),
+			st->last_timestamp);
+	if (rx & (1 << 3))
+		iio_push_event(st->indio_dev, 0,
+			IIO_EVENT_CODE_IN_HIGH_THRESH(2),
+			st->last_timestamp);
+	if (rx & (1 << 4))
+		iio_push_event(st->indio_dev, 0,
+			IIO_EVENT_CODE_IN_LOW_THRESH(1),
+			st->last_timestamp);
+	if (rx & (1 << 5))
+		iio_push_event(st->indio_dev, 0,
+			IIO_EVENT_CODE_IN_HIGH_THRESH(1),
+			st->last_timestamp);
+	if (rx & (1 << 6))
+		iio_push_event(st->indio_dev, 0,
+			IIO_EVENT_CODE_IN_LOW_THRESH(0),
+			st->last_timestamp);
+	if (rx & (1 << 7))
+		iio_push_event(st->indio_dev, 0,
+			IIO_EVENT_CODE_IN_HIGH_THRESH(0),
+			st->last_timestamp);
+	enable_irq(st->client->irq);
+	i2c_master_send(st->client, tx, 2);
+}
+
+static ssize_t max1363_read_interrupt_config(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	int val;
+
+	mutex_lock(&dev_info->mlock);
+	if (this_attr->mask & 0x8)
+		val = (1 << (this_attr->mask & 0x7)) & st->mask_low;
+	else
+		val = (1 << this_attr->mask) & st->mask_high;
+	mutex_unlock(&dev_info->mlock);
+
+	return sprintf(buf, "%d\n", !!val);
+}
+
+static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
+{
+	u8 *tx_buf;
+	int ret, i = 3, j;
+	unsigned long numelements;
+	int len;
+	long modemask;
+
+	if (!enabled) {
+		/* transition to ring capture is not currently supported */
+		st->setupbyte &= ~MAX1363_SETUP_MONITOR_SETUP;
+		st->configbyte &= ~MAX1363_SCAN_MASK;
+		st->monitor_on = false;
+		return max1363_write_basic_config(st->client,
+						st->setupbyte,
+						st->configbyte);
+	}
+
+	/* Ensure we are in the relevant mode */
+	st->setupbyte |= MAX1363_SETUP_MONITOR_SETUP;
+	st->configbyte &= ~(MAX1363_CHANNEL_SEL_MASK
+			    | MAX1363_SCAN_MASK
+			| MAX1363_SE_DE_MASK);
+	st->configbyte |= MAX1363_CONFIG_SCAN_MONITOR_MODE;
+	if ((st->mask_low | st->mask_high) & 0x0F) {
+		st->configbyte |= max1363_mode_table[s0to3].conf;
+		modemask = max1363_mode_table[s0to3].modemask;
+	} else if ((st->mask_low | st->mask_high) & 0x30) {
+		st->configbyte |= max1363_mode_table[d0m1to2m3].conf;
+		modemask = max1363_mode_table[d0m1to2m3].modemask;
+	} else {
+		st->configbyte |= max1363_mode_table[d1m0to3m2].conf;
+		modemask = max1363_mode_table[d1m0to3m2].modemask;
+	}
+	numelements = hweight_long(modemask);
+	len = 3 * numelements + 3;
+	tx_buf = kmalloc(len, GFP_KERNEL);
+	if (!tx_buf) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	tx_buf[0] = st->configbyte;
+	tx_buf[1] = st->setupbyte;
+	tx_buf[2] = (st->monitor_speed << 1);
+
+	/*
+	 * So we need to do yet another bit of nefarious scan mode
+	 * setup to match what we need.
+	 */
+	for (j = 0; j < 8; j++)
+		if (modemask & (1 << j)) {
+			/* Establish the mode is in the scan */
+			if (st->mask_low & (1 << j)) {
+				tx_buf[i] = (st->thresh_low[j] >> 4) & 0xFF;
+				tx_buf[i + 1] = (st->thresh_low[j] << 4) & 0xF0;
+			} else if (j < 4) {
+				tx_buf[i] = 0;
+				tx_buf[i + 1] = 0;
+			} else {
+				tx_buf[i] = 0x80;
+				tx_buf[i + 1] = 0;
+			}
+			if (st->mask_high & (1 << j)) {
+				tx_buf[i + 1] |=
+					(st->thresh_high[j] >> 8) & 0x0F;
+				tx_buf[i + 2] = st->thresh_high[j] & 0xFF;
+			} else if (j < 4) {
+				tx_buf[i + 1] |= 0x0F;
+				tx_buf[i + 2] = 0xFF;
+			} else {
+				tx_buf[i + 1] |= 0x07;
+				tx_buf[i + 2] = 0xFF;
+			}
+			i += 3;
+		}
+
+
+	ret = i2c_master_send(st->client, tx_buf, len);
+	if (ret < 0)
+		goto error_ret;
+	if (ret != len) {
+		ret = -EIO;
+		goto error_ret;
+	}
+
+	/*
+	 * Now that we hopefully have sensible thresholds in place it is
+	 * time to turn the interrupts on.
+	 * It is unclear from the data sheet if this should be necessary
+	 * (i.e. whether monitor mode setup is atomic) but it appears to
+	 * be in practice.
+	 */
+	tx_buf[0] = st->setupbyte;
+	tx_buf[1] = MAX1363_MON_INT_ENABLE | (st->monitor_speed << 1) | 0xF0;
+	ret = i2c_master_send(st->client, tx_buf, 2);
+	if (ret < 0)
+		goto error_ret;
+	if (ret != 2) {
+		ret = -EIO;
+		goto error_ret;
+	}
+	ret = 0;
+	st->monitor_on = true;
+error_ret:
+
+	kfree(tx_buf);
+
+	return ret;
+}
+
+/*
+ * To keep this managable we always use one of 3 scan modes.
+ * Scan 0...3, 0-1,2-3 and 1-0,3-2
+ */
+static inline int __max1363_check_event_mask(int thismask, int checkmask)
+{
+	int ret = 0;
+	/* Is it unipolar */
+	if (thismask < 4) {
+		if (checkmask & ~0x0F) {
+			ret = -EBUSY;
+			goto error_ret;
+		}
+	} else if (thismask < 6) {
+		if (checkmask & ~0x30) {
+			ret = -EBUSY;
+			goto error_ret;
+		}
+	} else if (checkmask & ~0xC0)
+		ret = -EBUSY;
+error_ret:
+	return ret;
+}
+
+static ssize_t max1363_write_interrupt_config(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	unsigned long val;
+	int ret;
+	u16 unifiedmask;
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+	mutex_lock(&st->indio_dev->mlock);
+	unifiedmask = st->mask_low | st->mask_high;
+	if (this_attr->mask & 0x08) {
+		/* If we are disabling no need to test */
+		if (val == 0)
+			st->mask_low &= ~(1 << (this_attr->mask & 0x7));
+		else {
+			ret = __max1363_check_event_mask(this_attr->mask & 0x7,
+							unifiedmask);
+			if (ret)
+				goto error_ret;
+			st->mask_low |= (1 << (this_attr->mask & 0x7));
+		}
+	} else {
+		if (val == 0)
+			st->mask_high &= ~(1 << (this_attr->mask));
+		else {
+			ret = __max1363_check_event_mask(this_attr->mask,
+							unifiedmask);
+			if (ret)
+				goto error_ret;
+			st->mask_high |= (1 << this_attr->mask);
+		}
+	}
+	if (st->monitor_on && !st->mask_high && !st->mask_low)
+		iio_remove_event_from_list(this_attr->listel,
+					&dev_info->interrupts[0]->ev_list);
+	if (!st->monitor_on && val)
+		iio_add_event_to_list(this_attr->listel,
+				&dev_info->interrupts[0]->ev_list);
+
+	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
+error_ret:
+	mutex_unlock(&st->indio_dev->mlock);
+
+	return len;
+}
+
+IIO_EVENT_SH(max1363_thresh, max1363_int_th);
+
+#define MAX1363_HIGH_THRESH(a) a
+#define MAX1363_LOW_THRESH(a) (a | 0x8)
+
+IIO_EVENT_ATTR_SH(in0_thresh_high_en,
+		iio_event_max1363_thresh,
+		max1363_read_interrupt_config,
+		max1363_write_interrupt_config,
+		MAX1363_HIGH_THRESH(0));
+
+IIO_EVENT_ATTR_SH(in0_thresh_low_en,
+		iio_event_max1363_thresh,
+		max1363_read_interrupt_config,
+		max1363_write_interrupt_config,
+		MAX1363_LOW_THRESH(0));
+
+IIO_EVENT_ATTR_SH(in1_thresh_high_en,
+		iio_event_max1363_thresh,
+		max1363_read_interrupt_config,
+		max1363_write_interrupt_config,
+		MAX1363_HIGH_THRESH(1));
+
+IIO_EVENT_ATTR_SH(in1_thresh_low_en,
+		iio_event_max1363_thresh,
+		max1363_read_interrupt_config,
+		max1363_write_interrupt_config,
+		MAX1363_LOW_THRESH(1));
+
+IIO_EVENT_ATTR_SH(in2_thresh_high_en,
+		iio_event_max1363_thresh,
+		max1363_read_interrupt_config,
+		max1363_write_interrupt_config,
+		MAX1363_HIGH_THRESH(2));
+
+IIO_EVENT_ATTR_SH(in2_thresh_low_en,
+		iio_event_max1363_thresh,
+		max1363_read_interrupt_config,
+		max1363_write_interrupt_config,
+		MAX1363_LOW_THRESH(2));
+
+IIO_EVENT_ATTR_SH(in3_thresh_high_en,
+		iio_event_max1363_thresh,
+		max1363_read_interrupt_config,
+		max1363_write_interrupt_config,
+		MAX1363_HIGH_THRESH(3));
+
+IIO_EVENT_ATTR_SH(in3_thresh_low_en,
+		iio_event_max1363_thresh,
+		max1363_read_interrupt_config,
+		max1363_write_interrupt_config,
+		MAX1363_LOW_THRESH(3));
+
+IIO_EVENT_ATTR_NAMED_SH(in0min1_thresh_high_en,
+			in0-in1_thresh_high_en,
+			iio_event_max1363_thresh,
+			max1363_read_interrupt_config,
+			max1363_write_interrupt_config,
+			MAX1363_HIGH_THRESH(4));
+
+IIO_EVENT_ATTR_NAMED_SH(in0min1_thresh_low_en,
+			in0-in1_thresh_low_en,
+			iio_event_max1363_thresh,
+			max1363_read_interrupt_config,
+			max1363_write_interrupt_config,
+			MAX1363_LOW_THRESH(4));
+
+IIO_EVENT_ATTR_NAMED_SH(in3min2_thresh_high_en,
+			in3-in2_thresh_high_en,
+			iio_event_max1363_thresh,
+			max1363_read_interrupt_config,
+			max1363_write_interrupt_config,
+			MAX1363_HIGH_THRESH(5));
+
+IIO_EVENT_ATTR_NAMED_SH(in3min2_thresh_low_en,
+			in3-in2_thresh_low_en,
+			iio_event_max1363_thresh,
+			max1363_read_interrupt_config,
+			max1363_write_interrupt_config,
+			MAX1363_LOW_THRESH(5));
+
+IIO_EVENT_ATTR_NAMED_SH(in1min0_thresh_high_en,
+			in1-in0_thresh_high_en,
+			iio_event_max1363_thresh,
+			max1363_read_interrupt_config,
+			max1363_write_interrupt_config,
+			MAX1363_HIGH_THRESH(6));
+
+IIO_EVENT_ATTR_NAMED_SH(in1min0_thresh_low_en,
+			in1-in0_thresh_low_en,
+			iio_event_max1363_thresh,
+			max1363_read_interrupt_config,
+			max1363_write_interrupt_config,
+			MAX1363_LOW_THRESH(6));
+
+IIO_EVENT_ATTR_NAMED_SH(in2min3_thresh_high_en,
+			in2-in3_thresh_high_en,
+			iio_event_max1363_thresh,
+			max1363_read_interrupt_config,
+			max1363_write_interrupt_config,
+			MAX1363_HIGH_THRESH(7));
+
+IIO_EVENT_ATTR_NAMED_SH(in2min3_thresh_low_en,
+			in2-in3_thresh_low_en,
+			iio_event_max1363_thresh,
+			max1363_read_interrupt_config,
+			max1363_write_interrupt_config,
+			MAX1363_LOW_THRESH(7));
+
+/*
+ * As with scan_elements, only certain sets of these can
+ * be combined.
+ */
+static struct attribute *max1363_event_attributes[] = {
+	&iio_dev_attr_in0_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in0_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in1_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in1_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in2_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in2_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in3_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in3_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in0min1_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in0min1_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in2min3_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in2min3_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in1min0_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in1min0_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in3min2_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in3min2_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_event_attr_in0_thresh_high_en.dev_attr.attr,
+	&iio_event_attr_in0_thresh_low_en.dev_attr.attr,
+	&iio_event_attr_in1_thresh_high_en.dev_attr.attr,
+	&iio_event_attr_in1_thresh_low_en.dev_attr.attr,
+	&iio_event_attr_in2_thresh_high_en.dev_attr.attr,
+	&iio_event_attr_in2_thresh_low_en.dev_attr.attr,
+	&iio_event_attr_in3_thresh_high_en.dev_attr.attr,
+	&iio_event_attr_in3_thresh_low_en.dev_attr.attr,
+	&iio_event_attr_in0min1_thresh_high_en.dev_attr.attr,
+	&iio_event_attr_in0min1_thresh_low_en.dev_attr.attr,
+	&iio_event_attr_in3min2_thresh_high_en.dev_attr.attr,
+	&iio_event_attr_in3min2_thresh_low_en.dev_attr.attr,
+	&iio_event_attr_in1min0_thresh_high_en.dev_attr.attr,
+	&iio_event_attr_in1min0_thresh_low_en.dev_attr.attr,
+	&iio_event_attr_in2min3_thresh_high_en.dev_attr.attr,
+	&iio_event_attr_in2min3_thresh_low_en.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group max1363_event_attribute_group = {
+	.attrs = max1363_event_attributes,
+};
+
 static int max1363_initial_setup(struct max1363_state *st)
 {
 	st->setupbyte = MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_VDD
@@ -965,6 +1636,11 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	if (st->chip_info->monitor_mode && client->irq) {
+		st->indio_dev->num_interrupt_lines = 1;
+		st->indio_dev->event_attrs
+			= &max1363_event_attribute_group;
+	}
 
 	ret = max1363_initial_setup(st);
 	if (ret)
@@ -981,7 +1657,22 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	ret = max1363_initialize_ring(st->indio_dev->ring);
 	if (ret)
 		goto error_cleanup_ring;
+
+	if (st->chip_info->monitor_mode && client->irq) {
+		ret = iio_register_interrupt_line(client->irq,
+						st->indio_dev,
+						0,
+						IRQF_TRIGGER_RISING,
+						client->name);
+		if (ret)
+			goto error_uninit_ring;
+
+		INIT_WORK(&st->thresh_work, max1363_thresh_handler_bh);
+	}
+
 	return 0;
+error_uninit_ring:
+	max1363_uninitialize_ring(st->indio_dev->ring);
 error_cleanup_ring:
 	max1363_ring_cleanup(st->indio_dev);
 error_free_available_scan_masks:
@@ -1008,6 +1699,9 @@ static int max1363_remove(struct i2c_client *client)
 {
 	struct max1363_state *st = i2c_get_clientdata(client);
 	struct iio_dev *indio_dev = st->indio_dev;
+
+	if (st->chip_info->monitor_mode && client->irq)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
 	max1363_uninitialize_ring(indio_dev->ring);
 	max1363_ring_cleanup(indio_dev);
 	kfree(st->indio_dev->available_scan_masks);
-- 
1.7.0.4
