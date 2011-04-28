Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/2] Example of naming usage
Date: Thu, 28 Apr 2011 15:24:23 +0100
Message-Id: <1304000663-5176-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk>
References: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

---
 drivers/staging/iio/light/tsl2563.c |  323 +++++++++++++----------------------
 1 files changed, 116 insertions(+), 207 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index d613086..9ee9494 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -464,31 +464,6 @@ static unsigned int adc_to_lux(u32 adc0, u32 adc1)
 /*                      Sysfs interface                         */
 /*--------------------------------------------------------------*/
 
-static ssize_t tsl2563_adc_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret;
-
-	mutex_lock(&chip->lock);
-
-	ret = tsl2563_get_adc(chip);
-	if (ret)
-		goto out;
-
-	switch (this_attr->address) {
-	case 0:
-		ret = snprintf(buf, PAGE_SIZE, "%d\n", chip->data0);
-		break;
-	case 1:
-		ret = snprintf(buf, PAGE_SIZE, "%d\n", chip->data1);
-		break;
-	}
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
-}
 
 /* Apply calibration coefficient to ADC count. */
 static u32 calib_adc(u32 adc, u32 calib)
@@ -501,180 +476,136 @@ static u32 calib_adc(u32 adc, u32 calib)
 	return (u32) scaled;
 }
 
-static ssize_t tsl2563_lux_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static int tsl2563_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
 {
-	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
-	u32 calib0, calib1;
-	int ret;
-
-	mutex_lock(&chip->lock);
-
-	ret = tsl2563_get_adc(chip);
-	if (ret)
-		goto out;
-
-	calib0 = calib_adc(chip->data0, chip->calib0) * chip->cover_comp_gain;
-	calib1 = calib_adc(chip->data1, chip->calib1) * chip->cover_comp_gain;
-
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", adc_to_lux(calib0, calib1));
-
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
-}
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
+	
+	if (chan->channel == 0)
+		chip->calib0 = calib_from_sysfs(val);
+	else
+		chip->calib1 = calib_from_sysfs(val);
 
-static ssize_t format_calib(char *buf, int len, u32 calib)
-{
-	return snprintf(buf, PAGE_SIZE, "%d\n", calib_to_sysfs(calib));
+	return 0;
 }
 
-static ssize_t tsl2563_calib_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static int tsl2563_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long m)
 {
-	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret;
+	int ret = -EINVAL;
+	u32 calib0, calib1;
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
 
 	mutex_lock(&chip->lock);
-	switch (this_attr->address) {
+	switch (m) {
 	case 0:
-		ret = format_calib(buf, PAGE_SIZE, chip->calib0);
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = tsl2563_get_adc(chip);
+			if (ret)
+				goto error_ret;
+			calib0 = calib_adc(chip->data0, chip->calib0) * chip->cover_comp_gain;
+			calib1 = calib_adc(chip->data1, chip->calib1) * chip->cover_comp_gain;
+			*val = adc_to_lux(calib0, calib1);
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_INTENSITY:
+			ret = tsl2563_get_adc(chip);
+			if (ret)
+				goto error_ret;
+			if (chan->channel == 0)
+				*val = chip->data0;
+			else
+				*val = chip->data1;
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			break;
+		}
 		break;
-	case 1:
-		ret = format_calib(buf, PAGE_SIZE, chip->calib1);
+		
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		if (chan->channel == 0)
+			*val = calib_to_sysfs(chip->calib0);
+		else
+			*val = calib_to_sysfs(chip->calib1);
+		ret = IIO_VAL_INT;
 		break;
 	default:
-		ret = -ENODEV;
-	}
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-
-static ssize_t tsl2563_calib_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t len)
-{
-	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int value;
-	u32 calib;
-
-	if (1 != sscanf(buf, "%d", &value))
 		return -EINVAL;
-
-	calib = calib_from_sysfs(value);
-
-	switch (this_attr->address) {
-	case 0:
-		chip->calib0 = calib;
-		break;
-	case 1:
-		chip->calib1 = calib;
-		break;
 	}
 
-	return len;
-}
-
-static IIO_DEVICE_ATTR(intensity0_both_raw, S_IRUGO,
-		tsl2563_adc_show, NULL, 0);
-static IIO_DEVICE_ATTR(intensity1_ir_raw, S_IRUGO,
-		tsl2563_adc_show, NULL, 1);
-static DEVICE_ATTR(illuminance0_input, S_IRUGO, tsl2563_lux_show, NULL);
-static IIO_DEVICE_ATTR(intensity0_both_calibgain, S_IRUGO | S_IWUSR,
-		tsl2563_calib_show, tsl2563_calib_store, 0);
-static IIO_DEVICE_ATTR(intensity1_ir_calibgain, S_IRUGO | S_IWUSR,
-		tsl2563_calib_show, tsl2563_calib_store, 1);
-
-static ssize_t tsl2563_show_name(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
-	return sprintf(buf, "%s\n", chip->client->name);
+error_ret:
+	mutex_unlock(&chip->lock);
+	return ret;
 }
 
-static DEVICE_ATTR(name, S_IRUGO, tsl2563_show_name, NULL);
-
-static struct attribute *tsl2563_attributes[] = {
-	&iio_dev_attr_intensity0_both_raw.dev_attr.attr,
-	&iio_dev_attr_intensity1_ir_raw.dev_attr.attr,
-	&dev_attr_illuminance0_input.attr,
-	&iio_dev_attr_intensity0_both_calibgain.dev_attr.attr,
-	&iio_dev_attr_intensity1_ir_calibgain.dev_attr.attr,
-	&dev_attr_name.attr,
-	NULL
+static const struct iio_chan_spec tsl2563_channels[] = {
+	IIO_CHAN_PROC_EV(IIO_LIGHT, NULL, 0, 0, 0, 0, {}, 0),
+	IIO_CHAN_UNPROC_EV(IIO_INTENSITY, "both", 0,
+			   (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE), 0, 0, {},
+			   IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
+			   IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)),
+	IIO_CHAN_UNPROC_EV(IIO_INTENSITY, "ir", 1,
+			   (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE), 0, 0, {},
+			   0)
 };
 
-static const struct attribute_group tsl2563_group = {
-	.attrs = tsl2563_attributes,
-};
-
-static ssize_t tsl2563_read_thresh(struct device *dev,
-			struct device_attribute *attr,
-			char *buf)
+static int tsl2563_read_thresh(struct iio_dev *indio_dev,
+				int event_code,
+				int *val)
 {
-	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u16 val = 0;
-	switch (this_attr->address) {
-	case TSL2563_REG_HIGHLOW:
-		val = chip->high_thres;
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
+
+	switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+	case IIO_EV_DIR_RISING:
+		*val = chip->high_thres;
 		break;
-	case TSL2563_REG_LOWLOW:
-		val = chip->low_thres;
+	case IIO_EV_DIR_FALLING:
+		*val = chip->low_thres;
 		break;
+	default:
+		return -EINVAL;
 	}
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+
+	return 0;
 }
 
-static ssize_t tsl2563_write_thresh(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf,
-				size_t len)
+static ssize_t tsl2563_write_thresh(struct iio_dev *indio_dev,
+				  int event_code,
+				  int val)
 {
-	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	unsigned long val;
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
+	u8 address;
 
-	ret = strict_strtoul(buf, 10, &val);
-	if (ret)
-		return ret;
+	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_RISING)
+		address = TSL2563_REG_HIGHLOW;
+	else
+		address = TSL2563_REG_LOWLOW;
 	mutex_lock(&chip->lock);
-	ret = tsl2563_write(chip->client, this_attr->address, val & 0xFF);
+	ret = tsl2563_write(chip->client, address, val & 0xFF);
 	if (ret)
 		goto error_ret;
-	ret = tsl2563_write(chip->client, this_attr->address + 1,
+	ret = tsl2563_write(chip->client, address + 1,
 			(val >> 8) & 0xFF);
-	switch (this_attr->address) {
-	case TSL2563_REG_HIGHLOW:
+	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_RISING)
 		chip->high_thres = val;
-		break;
-	case TSL2563_REG_LOWLOW:
+	else
 		chip->low_thres = val;
-		break;
-	}
 
 error_ret:
 	mutex_unlock(&chip->lock);
 
-	return ret < 0 ? ret : len;
+	return ret;
 }
 
-static IIO_DEVICE_ATTR(intensity0_both_raw_thresh_rising_value,
-		S_IRUGO | S_IWUSR,
-		tsl2563_read_thresh,
-		tsl2563_write_thresh,
-		TSL2563_REG_HIGHLOW);
-
-static IIO_DEVICE_ATTR(intensity0_both_raw_thresh_falling_value,
-		S_IRUGO | S_IWUSR,
-		tsl2563_read_thresh,
-		tsl2563_write_thresh,
-		TSL2563_REG_LOWLOW);
-
 static irqreturn_t tsl2563_event_handler(int irq, void *private)
 {
 	struct iio_dev *dev_info = private;
@@ -693,20 +624,15 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static ssize_t tsl2563_write_interrupt_config(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf,
-					size_t len)
+static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
+					int event_code,
+					int state)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
-	int input, ret = 0;
+	int ret = 0;
 
-	ret = sscanf(buf, "%d", &input);
-	if (ret != 1)
-		return -EINVAL;
 	mutex_lock(&chip->lock);
-	if (input && !(chip->intr & 0x30)) {
+	if (state && !(chip->intr & 0x30)) {
 		chip->intr &= ~0x30;
 		chip->intr |= 0x10;
 		/* ensure the chip is actually on */
@@ -723,7 +649,7 @@ static ssize_t tsl2563_write_interrupt_config(struct device *dev,
 		chip->int_enabled = true;
 	}
 
-	if (!input && (chip->intr & 0x30)) {
+	if (!state && (chip->intr & 0x30)) {
 		chip->intr |= ~0x30;
 		ret = tsl2563_write(chip->client, TSL2563_REG_INT, chip->intr);
 		chip->int_enabled = false;
@@ -733,47 +659,27 @@ static ssize_t tsl2563_write_interrupt_config(struct device *dev,
 out:
 	mutex_unlock(&chip->lock);
 
-	return (ret < 0) ? ret : len;
+	return ret;
 }
 
-static ssize_t tsl2563_read_interrupt_config(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+static int tsl2563_read_interrupt_config(struct iio_dev *indio_dev,
+					   int event_code)
 {
-	struct tsl2563_chip *chip = iio_priv(dev_get_drvdata(dev));
-	int ret;
+	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	u8 rxbuf;
-	ssize_t len;
+	int ret;
 
 	mutex_lock(&chip->lock);
-	ret = tsl2563_read(chip->client,
-			TSL2563_REG_INT,
-			&rxbuf,
-			sizeof(rxbuf));
+	ret = tsl2563_read(chip->client, TSL2563_REG_INT,
+			   &rxbuf, sizeof(rxbuf));
 	mutex_unlock(&chip->lock);
 	if (ret < 0)
 		goto error_ret;
-	len = snprintf(buf, PAGE_SIZE, "%d\n", !!(rxbuf & 0x30));
+	ret = !!(rxbuf & 0x30);
 error_ret:
 
-	return (ret < 0) ? ret : len;
+	return ret;
 }
-static IIO_DEVICE_ATTR(intensity0_both_thresh_en,
-		       S_IRUGO | S_IWUSR,
-		       tsl2563_read_interrupt_config,
-		       tsl2563_write_interrupt_config,
-		       0);
-
-static struct attribute *tsl2563_event_attributes[] = {
-	&iio_dev_attr_intensity0_both_thresh_en.dev_attr.attr,
-	&iio_dev_attr_intensity0_both_raw_thresh_rising_value.dev_attr.attr,
-	&iio_dev_attr_intensity0_both_raw_thresh_falling_value.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group tsl2563_event_attribute_group = {
-	.attrs = tsl2563_event_attributes,
-};
 
 /*--------------------------------------------------------------*/
 /*                      Probe, Attach, Remove                   */
@@ -825,20 +731,23 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 		chip->cover_comp_gain = 1;
 
 	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
-
-	indio_dev->attrs = &tsl2563_group;
+	indio_dev->name = client->name;
+	indio_dev->channels = tsl2563_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tsl2563_channels);
+	indio_dev->read_raw = &tsl2563_read_raw;
+	indio_dev->write_raw = &tsl2563_write_raw;
+	indio_dev->read_event_value = &tsl2563_read_thresh;
+	indio_dev->write_event_value = &tsl2563_write_thresh;
+	indio_dev->read_event_config = &tsl2563_read_interrupt_config;
+	indio_dev->write_event_config = &tsl2563_write_interrupt_config;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->driver_module = THIS_MODULE;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (client->irq) {
+	if (client->irq)
 		indio_dev->num_interrupt_lines = 1;
-		indio_dev->event_attrs
-			= &tsl2563_event_attribute_group;
-	}
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto fail1;
-
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
-- 
1.7.3.4
