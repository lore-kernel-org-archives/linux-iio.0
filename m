Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/16] staging:iio:adc:ad7150: chan_spec conv + i2c_smbus commands + drop unused poweroff timeout control.
Date: Fri, 26 Aug 2011 11:19:19 +0100
Message-Id: <1314353973-7662-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Minimal changes to code layout as going to do chan spec conversion shortly.
Otherwise, there are numerous code sharing opportunities in here and abi
elements that are uterly non compliant.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7150.c |  840 ++++++++++++++++++--------------------
 1 files changed, 389 insertions(+), 451 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 3e4801f..0eb1992 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -23,22 +23,16 @@
 #define AD7150_STATUS_OUT1         (1 << 3)
 #define AD7150_STATUS_OUT2         (1 << 5)
 #define AD7150_CH1_DATA_HIGH       1
-#define AD7150_CH1_DATA_LOW        2
 #define AD7150_CH2_DATA_HIGH       3
-#define AD7150_CH2_DATA_LOW        4
 #define AD7150_CH1_AVG_HIGH        5
-#define AD7150_CH1_AVG_LOW         6
 #define AD7150_CH2_AVG_HIGH        7
-#define AD7150_CH2_AVG_LOW         8
 #define AD7150_CH1_SENSITIVITY     9
 #define AD7150_CH1_THR_HOLD_H      9
 #define AD7150_CH1_TIMEOUT         10
-#define AD7150_CH1_THR_HOLD_L      10
 #define AD7150_CH1_SETUP           11
 #define AD7150_CH2_SENSITIVITY     12
 #define AD7150_CH2_THR_HOLD_H      12
 #define AD7150_CH2_TIMEOUT         13
-#define AD7150_CH2_THR_HOLD_L      13
 #define AD7150_CH2_SETUP           14
 #define AD7150_CFG                 15
 #define AD7150_CFG_FIX             (1 << 7)
@@ -53,25 +47,45 @@
 
 #define AD7150_MAX_CONV_MODE       4
 
-/*
- * struct ad7150_chip_info - chip specifc information
+/**
+ * Todo list:
+ * - Review whether old_state usage makes sense.
+ * - get rid of explicit control of conversion mode
  */
 
+/**
+ * struct ad7150_chip_info - instance specific chip data
+ * @client: i2c client for this device
+ * @current_event: device always has one type of event enabled.
+ *	This element stores the event code of the current one.
+ * @threshold: thresholds for simple capacitance value events
+ * @thresh_sensitivity: threshold for simple capacitance offset
+ *	from 'average' value.
+ * @mag_sensitity: threshold for magnitude of capacitance offset from
+ *	from 'average' value.
+ * @thresh_timeout: a timeout, in samples from the moment an
+ *	adaptive threshold event occurs to when the average
+ *	value jumps to current value.
+ * @mag_timeout: a timeout, in sample from the moment an
+ *	adaptive magnitude event occurs to when the average
+ *	value jumps to the current value.
+ * @old_state: store state from previous event, allowing confirmation
+ *	of new condition.
+ * @conversion_mode: the current conversion mode.
+ * @state_lock: ensure consistent state of this structure wrt the
+ *	hardware.
+ */
 struct ad7150_chip_info {
 	struct i2c_client *client;
-	bool inter;
-	u16 ch1_threshold;     /* Ch1 Threshold (in fixed threshold mode) */
-	u8  ch1_sensitivity;   /* Ch1 Sensitivity (in adaptive threshold mode) */
-	u8  ch1_timeout;       /* Ch1 Timeout (in adaptive threshold mode) */
-	u8  ch1_setup;
-	u16 ch2_threshold;     /* Ch2 Threshold (in fixed threshold mode) */
-	u8  ch2_sensitivity;   /* Ch1 Sensitivity (in adaptive threshold mode) */
-	u8  ch2_timeout;       /* Ch1 Timeout (in adaptive threshold mode) */
-	u8  ch2_setup;
-	u8  powerdown_timer;
-	char threshold_mode[10]; /* adaptive/fixed threshold mode */
+	u64 current_event;
+	u16 threshold[2][2];
+	u8 thresh_sensitivity[2][2];
+	u8 mag_sensitivity[2][2];
+	u8 thresh_timeout[2][2];
+	u8 mag_timeout[2][2];
 	int old_state;
 	char *conversion_mode;
+	struct mutex state_lock;
 };
 
 struct ad7150_conversion_mode {
@@ -88,80 +102,13 @@ ad7150_conv_mode_table[AD7150_MAX_CONV_MODE] = {
 };
 
 /*
- * ad7150 register access by I2C
- */
-
-static int ad7150_i2c_read(struct ad7150_chip_info *chip, u8 reg, u8 *data, int len)
-{
-	struct i2c_client *client = chip->client;
-	int ret = 0;
-
-	ret = i2c_master_send(client, &reg, 1);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C write error\n");
-		return ret;
-	}
-
-	ret = i2c_master_recv(client, data, len);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C read error\n");
-		return ret;
-	}
-
-	return ret;
-}
-
-static int ad7150_i2c_write(struct ad7150_chip_info *chip, u8 reg, u8 data)
-{
-	struct i2c_client *client = chip->client;
-	int ret = 0;
-
-	u8 tx[2] = {
-		reg,
-		data,
-	};
-
-	ret = i2c_master_send(client, tx, 2);
-	if (ret < 0)
-		dev_err(&client->dev, "I2C write error\n");
-
-	return ret;
-}
-
-/*
  * sysfs nodes
  */
 
-#define IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(_show)				\
+#define IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(_show)			\
 	IIO_DEVICE_ATTR(available_conversion_modes, S_IRUGO, _show, NULL, 0)
 #define IIO_DEV_ATTR_CONVERSION_MODE(_mode, _show, _store)              \
 	IIO_DEVICE_ATTR(conversion_mode, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_AVAIL_THRESHOLD_MODES(_show)				\
-	IIO_DEVICE_ATTR(available_threshold_modes, S_IRUGO, _show, NULL, 0)
-#define IIO_DEV_ATTR_THRESHOLD_MODE(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(threshold_mode, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH1_THRESHOLD(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(ch1_threshold, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH2_THRESHOLD(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(ch2_threshold, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH1_SENSITIVITY(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch1_sensitivity, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH2_SENSITIVITY(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch2_sensitivity, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH1_TIMEOUT(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch1_timeout, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH2_TIMEOUT(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch2_timeout, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH1_VALUE(_show)		\
-	IIO_DEVICE_ATTR(ch1_value, S_IRUGO, _show, NULL, 0)
-#define IIO_DEV_ATTR_CH2_VALUE(_show)		\
-	IIO_DEVICE_ATTR(ch2_value, S_IRUGO, _show, NULL, 0)
-#define IIO_DEV_ATTR_CH1_SETUP(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch1_setup, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH2_SETUP(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(ch2_setup, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_POWERDOWN_TIMER(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(powerdown_timer, _mode, _show, _store, 0)
 
 static ssize_t ad7150_show_conversion_modes(struct device *dev,
 		struct device_attribute *attr,
@@ -171,7 +118,8 @@ static ssize_t ad7150_show_conversion_modes(struct device *dev,
 	int len = 0;
 
 	for (i = 0; i < AD7150_MAX_CONV_MODE; i++)
-		len += sprintf(buf + len, "%s\n", ad7150_conv_mode_table[i].name);
+		len += sprintf(buf + len, "%s\n",
+			       ad7150_conv_mode_table[i].name);
 
 	return len;
 }
@@ -196,16 +144,24 @@ static ssize_t ad7150_store_conversion_mode(struct device *dev,
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7150_chip_info *chip = iio_priv(dev_info);
 	u8 cfg;
-	int i;
+	int i, ret;
 
-	ad7150_i2c_read(chip, AD7150_CFG, &cfg, 1);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+	if (ret < 0)
+		return ret;
+	cfg = ret;
 
 	for (i = 0; i < AD7150_MAX_CONV_MODE; i++) {
 		if (strncmp(buf, ad7150_conv_mode_table[i].name,
-				strlen(ad7150_conv_mode_table[i].name) - 1) == 0) {
+				strlen(ad7150_conv_mode_table[i].name) - 1) ==
+		    0) {
 			chip->conversion_mode = ad7150_conv_mode_table[i].name;
 			cfg |= 0x18 | ad7150_conv_mode_table[i].reg_cfg;
-			ad7150_i2c_write(chip, AD7150_CFG, cfg);
+			ret = i2c_smbus_write_byte_data(chip->client,
+							AD7150_CFG,
+							cfg);
+			if (ret < 0)
+				return ret;
 			return len;
 		}
 	}
@@ -219,419 +175,376 @@ static IIO_DEV_ATTR_CONVERSION_MODE(S_IRUGO | S_IWUSR,
 		ad7150_show_conversion_mode,
 		ad7150_store_conversion_mode);
 
-static ssize_t ad7150_show_threshold_modes(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return sprintf(buf, "adaptive\nfixed\n");
-}
-
-static IIO_DEV_ATTR_AVAIL_THRESHOLD_MODES(ad7150_show_threshold_modes);
-
-static ssize_t ad7150_show_ch1_value(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	u8 data[2];
-
-	ad7150_i2c_read(chip, AD7150_CH1_DATA_HIGH, data, 2);
-	return sprintf(buf, "%d\n", ((int) data[0] << 8) | data[1]);
-}
-
-static IIO_DEV_ATTR_CH1_VALUE(ad7150_show_ch1_value);
-
-static ssize_t ad7150_show_ch2_value(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	u8 data[2];
-
-	ad7150_i2c_read(chip, AD7150_CH2_DATA_HIGH, data, 2);
-	return sprintf(buf, "%d\n", ((int) data[0] << 8) | data[1]);
-}
-
-static IIO_DEV_ATTR_CH2_VALUE(ad7150_show_ch2_value);
-
-static ssize_t ad7150_show_threshold_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%s\n", chip->threshold_mode);
-}
-
-static ssize_t ad7150_store_threshold_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	u8 cfg;
-
-	ad7150_i2c_read(chip, AD7150_CFG, &cfg, 1);
-
-	if (strncmp(buf, "fixed", 5) == 0) {
-		strcpy(chip->threshold_mode, "fixed");
-		cfg |= AD7150_CFG_FIX;
-		ad7150_i2c_write(chip, AD7150_CFG, cfg);
-
-		return len;
-	} else if (strncmp(buf, "adaptive", 8) == 0) {
-		strcpy(chip->threshold_mode, "adaptive");
-		cfg &= ~AD7150_CFG_FIX;
-		ad7150_i2c_write(chip, AD7150_CFG, cfg);
-
-		return len;
-	}
-
-	dev_err(dev, "not supported threshold mode\n");
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_THRESHOLD_MODE(S_IRUGO | S_IWUSR,
-		ad7150_show_threshold_mode,
-		ad7150_store_threshold_mode);
-
-static ssize_t ad7150_show_ch1_threshold(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", chip->ch1_threshold);
-}
+static const u8 ad7150_addresses[][6] = {
+	{ AD7150_CH1_DATA_HIGH, AD7150_CH1_AVG_HIGH,
+	  AD7150_CH1_SETUP, AD7150_CH1_THR_HOLD_H,
+	  AD7150_CH1_SENSITIVITY, AD7150_CH1_TIMEOUT },
+	{ AD7150_CH2_DATA_HIGH, AD7150_CH2_AVG_HIGH,
+	  AD7150_CH2_SETUP, AD7150_CH2_THR_HOLD_H,
+	  AD7150_CH2_SENSITIVITY, AD7150_CH2_TIMEOUT },
+};
 
-static ssize_t ad7150_store_ch1_threshold(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static int ad7150_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long mask)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
 	int ret;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x10000)) {
-		ad7150_i2c_write(chip, AD7150_CH1_THR_HOLD_H, data >> 8);
-		ad7150_i2c_write(chip, AD7150_CH1_THR_HOLD_L, data);
-		chip->ch1_threshold = data;
-		return len;
+	switch (mask) {
+	case 0:
+		ret = i2c_smbus_read_word_data(chip->client,
+					ad7150_addresses[chan->channel][0]);
+		if (ret < 0)
+			return ret;
+		*val = swab16(ret);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE):
+		ret = i2c_smbus_read_word_data(chip->client,
+					ad7150_addresses[chan->channel][1]);
+		if (ret < 0)
+			return ret;
+		*val = swab16(ret);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
 	}
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CH1_THRESHOLD(S_IRUGO | S_IWUSR,
-		ad7150_show_ch1_threshold,
-		ad7150_store_ch1_threshold);
-
-static ssize_t ad7150_show_ch2_threshold(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", chip->ch2_threshold);
 }
 
-static ssize_t ad7150_store_ch2_threshold(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static int ad7150_read_event_config(struct iio_dev *indio_dev, u64 event_code)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
 	int ret;
+	u8 threshtype;
+	bool adaptive;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
 
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x10000)) {
-		ad7150_i2c_write(chip, AD7150_CH2_THR_HOLD_H, data >> 8);
-		ad7150_i2c_write(chip, AD7150_CH2_THR_HOLD_L, data);
-		chip->ch2_threshold = data;
-		return len;
-	}
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+	if (ret < 0)
+		return ret;
 
+	threshtype = (ret >> 5) & 0x03;
+	adaptive = !!(ret & 0x80);
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		if (rising)
+			return adaptive && (threshtype == 0x1);
+		else
+			return adaptive && (threshtype == 0x0);
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		if (rising)
+			return adaptive && (threshtype == 0x3);
+		else
+			return adaptive && (threshtype == 0x2);
+
+	case IIO_EV_TYPE_THRESH:
+		if (rising)
+			return !adaptive && (threshtype == 0x1);
+		else
+			return !adaptive && (threshtype == 0x0);
+	};
 	return -EINVAL;
 }
 
-static IIO_DEV_ATTR_CH2_THRESHOLD(S_IRUGO | S_IWUSR,
-		ad7150_show_ch2_threshold,
-		ad7150_store_ch2_threshold);
-
-static ssize_t ad7150_show_ch1_sensitivity(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", chip->ch1_sensitivity);
-}
-
-static ssize_t ad7150_store_ch1_sensitivity(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+/* lock should be held */
+static int ad7150_write_event_params(struct iio_dev *indio_dev, u64 event_code)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
 	int ret;
+	u16 value;
+	u8 sens, timeout;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
+
+	if (event_code != chip->current_event)
+		return 0;
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+		/* Note completely different from the adaptive versions */
+	case IIO_EV_TYPE_THRESH:
+		value = chip->threshold[rising][chan];
+		ret = i2c_smbus_write_word_data(chip->client,
+						ad7150_addresses[chan][3],
+						swab16(value));
+		if (ret < 0)
+			return ret;
+		return 0;
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		sens = chip->mag_sensitivity[rising][chan];
+		timeout = chip->mag_timeout[rising][chan];
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		sens = chip->thresh_sensitivity[rising][chan];
+		timeout = chip->thresh_timeout[rising][chan];
+		break;
+	default:
+		return -EINVAL;
+	};
+	ret = i2c_smbus_write_byte_data(chip->client,
+					ad7150_addresses[chan][4],
+					sens);
+	if (ret < 0)
+		return ret;
 
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x100)) {
-		ad7150_i2c_write(chip, AD7150_CH1_SENSITIVITY, data);
-		chip->ch1_sensitivity = data;
-		return len;
-	}
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CH1_SENSITIVITY(S_IRUGO | S_IWUSR,
-		ad7150_show_ch1_sensitivity,
-		ad7150_store_ch1_sensitivity);
-
-static ssize_t ad7150_show_ch2_sensitivity(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
+	ret = i2c_smbus_write_byte_data(chip->client,
+					ad7150_addresses[chan][5],
+					timeout);
+	if (ret < 0)
+		return ret;
 
-	return sprintf(buf, "%d\n", chip->ch2_sensitivity);
+	return 0;
 }
 
-static ssize_t ad7150_store_ch2_sensitivity(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static int ad7150_write_event_config(struct iio_dev *indio_dev,
+				     u64 event_code, int state)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
+	u8 thresh_type, cfg, adaptive;
 	int ret;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
 
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x100)) {
-		ad7150_i2c_write(chip, AD7150_CH2_SENSITIVITY, data);
-		chip->ch2_sensitivity = data;
-		return len;
-	}
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CH2_SENSITIVITY(S_IRUGO | S_IWUSR,
-		ad7150_show_ch2_sensitivity,
-		ad7150_store_ch2_sensitivity);
-
-static ssize_t ad7150_show_ch1_timeout(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", chip->ch1_timeout);
-}
+	/* Something must always be turned on */
+	if (state == 0)
+		return -EINVAL;
 
-static ssize_t ad7150_store_ch1_timeout(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
-	int ret;
+	if (event_code == chip->current_event)
+		return 0;
+	mutex_lock(&chip->state_lock);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+	if (ret < 0)
+		goto error_ret;
 
-	ret = strict_strtoul(buf, 10, &data);
+	cfg = ret & ~((0x03 << 5) | (0x1 << 7));
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		adaptive = 1;
+		if (rising)
+			thresh_type = 0x1;
+		else
+			thresh_type = 0x0;
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		adaptive = 1;
+		if (rising)
+			thresh_type = 0x3;
+		else
+			thresh_type = 0x2;
+		break;
+	case IIO_EV_TYPE_THRESH:
+		adaptive = 0;
+		if (rising)
+			thresh_type = 0x1;
+		else
+			thresh_type = 0x0;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret;
+	};
 
-	if ((!ret) && (data < 0x100)) {
-		ad7150_i2c_write(chip, AD7150_CH1_TIMEOUT, data);
-		chip->ch1_timeout = data;
-		return len;
-	}
+	cfg |= (!adaptive << 7) | (thresh_type << 5);
 
-	return -EINVAL;
-}
+	ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
+	if (ret < 0)
+		goto error_ret;
 
-static IIO_DEV_ATTR_CH1_TIMEOUT(S_IRUGO | S_IWUSR,
-		ad7150_show_ch1_timeout,
-		ad7150_store_ch1_timeout);
+	chip->current_event = event_code;
 
-static ssize_t ad7150_show_ch2_timeout(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
+	/* update control attributes */
+	ret = ad7150_write_event_params(indio_dev, event_code);
+error_ret:
+	mutex_unlock(&chip->state_lock);
 
-	return sprintf(buf, "%d\n", chip->ch2_timeout);
+	return 0;
 }
 
-static ssize_t ad7150_store_ch2_timeout(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static int ad7150_read_event_value(struct iio_dev *indio_dev,
+				   u64 event_code,
+				   int *val)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
-	int ret;
-
-	ret = strict_strtoul(buf, 10, &data);
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
 
-	if ((!ret) && (data < 0x100)) {
-		ad7150_i2c_write(chip, AD7150_CH2_TIMEOUT, data);
-		chip->ch2_timeout = data;
-		return len;
-	}
+	/* Complex register sharing going on here */
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		*val = chip->mag_sensitivity[rising][chan];
+		return 0;
 
-	return -EINVAL;
-}
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		*val = chip->thresh_sensitivity[rising][chan];
+		return 0;
 
-static IIO_DEV_ATTR_CH2_TIMEOUT(S_IRUGO | S_IWUSR,
-		ad7150_show_ch2_timeout,
-		ad7150_store_ch2_timeout);
+	case IIO_EV_TYPE_THRESH:
+		*val = chip->threshold[rising][chan];
+		return 0;
 
-static ssize_t ad7150_show_ch1_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "0x%02x\n", chip->ch1_setup);
+	default:
+		return -EINVAL;
+	};
 }
 
-static ssize_t ad7150_store_ch1_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static int ad7150_write_event_value(struct iio_dev *indio_dev,
+				   u64 event_code,
+				   int val)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
 	int ret;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
+
+	mutex_lock(&chip->state_lock);
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		chip->mag_sensitivity[rising][chan] = val;
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		chip->thresh_sensitivity[rising][chan] = val;
+		break;
+	case IIO_EV_TYPE_THRESH:
+		chip->threshold[rising][chan] = val;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret;
+	};
 
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x100)) {
-		ad7150_i2c_write(chip, AD7150_CH1_SETUP, data);
-		chip->ch1_setup = data;
-		return len;
-	}
-
+	/* write back if active */
+	ret = ad7150_write_event_params(indio_dev, event_code);
 
-	return -EINVAL;
+	mutex_unlock(&chip->state_lock);
+error_ret:
+	return ret;
 }
 
-static IIO_DEV_ATTR_CH1_SETUP(S_IRUGO | S_IWUSR,
-		ad7150_show_ch1_setup,
-		ad7150_store_ch1_setup);
-
-static ssize_t ad7150_show_ch2_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t ad7150_show_timeout(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7150_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	u8 value;
+
+	/* use the event code for consistency reasons */
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(this_attr->address);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
+			== IIO_EV_DIR_RISING);
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		value = chip->mag_timeout[rising][chan];
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		value = chip->thresh_timeout[rising][chan];
+		break;
+	default:
+		return -EINVAL;
+	};
 
-	return sprintf(buf, "0x%02x\n", chip->ch2_setup);
+	return sprintf(buf, "%d\n", value);
 }
 
-static ssize_t ad7150_store_ch2_setup(struct device *dev,
+static ssize_t ad7150_store_timeout(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(this_attr->address);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address) ==
+			IIO_EV_DIR_RISING);
+	u8 data;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x100)) {
-		ad7150_i2c_write(chip, AD7150_CH2_SETUP, data);
-		chip->ch2_setup = data;
-		return len;
-	}
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CH2_SETUP(S_IRUGO | S_IWUSR,
-		ad7150_show_ch2_setup,
-		ad7150_store_ch2_setup);
-
-static ssize_t ad7150_show_powerdown_timer(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "0x%02x\n", chip->powerdown_timer);
-}
+	ret = kstrtou8(buf, 10, &data);
+	if (ret < 0)
+		return ret;
 
-static ssize_t ad7150_store_powerdown_timer(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
-	int ret;
+	mutex_lock(&chip->state_lock);
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		chip->mag_timeout[rising][chan] = data;
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		chip->thresh_timeout[rising][chan] = data;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret;
+	};
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = ad7150_write_event_params(indio_dev, this_attr->address);
+error_ret:
+	mutex_unlock(&chip->state_lock);
 
-	if ((!ret) && (data < 0x40)) {
-		chip->powerdown_timer = data;
-		return len;
-	}
+	if (ret < 0)
+		return ret;
 
-	return -EINVAL;
+	return len;
 }
 
-static IIO_DEV_ATTR_POWERDOWN_TIMER(S_IRUGO | S_IWUSR,
-		ad7150_show_powerdown_timer,
-		ad7150_store_powerdown_timer);
+#define AD7150_TIMEOUT(chan, type, dir, ev_type, ev_dir)		\
+	IIO_DEVICE_ATTR(in_capacitance##chan##_##type##_##dir##_timeout, \
+		S_IRUGO | S_IWUSR,					\
+		&ad7150_show_timeout,					\
+		&ad7150_store_timeout,					\
+		IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,			\
+				     chan,				\
+				     IIO_EV_TYPE_##ev_type,		\
+				     IIO_EV_DIR_##ev_dir))
+static AD7150_TIMEOUT(0, mag_adaptive, rising, MAG_ADAPTIVE, RISING);
+static AD7150_TIMEOUT(0, mag_adaptive, falling, MAG_ADAPTIVE, FALLING);
+static AD7150_TIMEOUT(1, mag_adaptive, rising, MAG_ADAPTIVE, RISING);
+static AD7150_TIMEOUT(1, mag_adaptive, falling, MAG_ADAPTIVE, FALLING);
+static AD7150_TIMEOUT(0, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
+static AD7150_TIMEOUT(0, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
+static AD7150_TIMEOUT(1, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
+static AD7150_TIMEOUT(1, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
+
+static const struct iio_chan_spec ad7150_channels[] = {
+	{
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
+		.event_mask =
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_FALLING) |
+		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_FALLING)
+	}, {
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
+		.event_mask =
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_FALLING) |
+		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_FALLING)
+	},
+};
 
 static struct attribute *ad7150_attributes[] = {
 	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
 	&iio_dev_attr_conversion_mode.dev_attr.attr,
-	&iio_dev_attr_available_threshold_modes.dev_attr.attr,
-	&iio_dev_attr_threshold_mode.dev_attr.attr,
-	&iio_dev_attr_ch1_threshold.dev_attr.attr,
-	&iio_dev_attr_ch2_threshold.dev_attr.attr,
-	&iio_dev_attr_ch1_timeout.dev_attr.attr,
-	&iio_dev_attr_ch2_timeout.dev_attr.attr,
-	&iio_dev_attr_ch1_setup.dev_attr.attr,
-	&iio_dev_attr_ch2_setup.dev_attr.attr,
-	&iio_dev_attr_ch1_sensitivity.dev_attr.attr,
-	&iio_dev_attr_ch2_sensitivity.dev_attr.attr,
-	&iio_dev_attr_powerdown_timer.dev_attr.attr,
-	&iio_dev_attr_ch1_value.dev_attr.attr,
-	&iio_dev_attr_ch2_value.dev_attr.attr,
 	NULL,
 };
 
@@ -649,8 +562,13 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	u8 int_status;
 	s64 timestamp = iio_get_time_ns();
+	int ret;
 
-	ad7150_i2c_read(chip, AD7150_STATUS, &int_status, 1);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	int_status = ret;
 
 	if ((int_status & AD7150_STATUS_OUT1) &&
 	    !(chip->old_state & AD7150_STATUS_OUT1))
@@ -685,19 +603,30 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
 			       timestamp);
+	/* store the status to avoid repushing same events */
+	chip->old_state = int_status;
+
 	return IRQ_HANDLED;
 }
 
-static IIO_CONST_ATTR(ch1_high_en, "1");
-static IIO_CONST_ATTR(ch2_high_en, "1");
-static IIO_CONST_ATTR(ch1_low_en, "1");
-static IIO_CONST_ATTR(ch2_low_en, "1");
-
+/* Timeouts not currently handled by core */
 static struct attribute *ad7150_event_attributes[] = {
-	&iio_const_attr_ch1_high_en.dev_attr.attr,
-	&iio_const_attr_ch2_high_en.dev_attr.attr,
-	&iio_const_attr_ch1_low_en.dev_attr.attr,
-	&iio_const_attr_ch2_low_en.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_mag_adaptive_rising_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_mag_adaptive_falling_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_mag_adaptive_rising_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_mag_adaptive_falling_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_thresh_adaptive_rising_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_thresh_adaptive_falling_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_thresh_adaptive_rising_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_thresh_adaptive_falling_timeout
+	.dev_attr.attr,
 	NULL,
 };
 
@@ -710,7 +639,13 @@ static const struct iio_info ad7150_info = {
 	.attrs = &ad7150_attribute_group,
 	.event_attrs = &ad7150_event_attribute_group,
 	.driver_module = THIS_MODULE,
+	.read_raw = &ad7150_read_raw,
+	.read_event_config = &ad7150_read_event_config,
+	.write_event_config = &ad7150_write_event_config,
+	.read_event_value = &ad7150_read_event_value,
+	.write_event_value = &ad7150_write_event_value,
 };
+
 /*
  * device probe and remove
  */
@@ -728,13 +663,16 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 		goto error_ret;
 	}
 	chip = iio_priv(indio_dev);
+	mutex_init(&chip->state_lock);
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
 
-	/* Establish that the iio_dev is a child of the i2c device */
 	indio_dev->name = id->name;
+	indio_dev->channels = ad7150_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7150_channels);
+	/* Establish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
 
 	indio_dev->info = &ad7150_info;
@@ -757,8 +695,8 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 	if (ret)
 		goto error_free_irq;
 
-
-	dev_err(&client->dev, "%s capacitive sensor registered, irq: %d\n", id->name, client->irq);
+	dev_info(&client->dev, "%s capacitive sensor registered,irq: %d\n",
+		 id->name, client->irq);
 
 	return 0;
 error_free_irq:
-- 
1.7.3.4
