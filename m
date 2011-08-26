Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53054 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab1HZKLZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 06:11:25 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/16] staging:iio:adc:ad7291 bring into line with current abi + chan_spec conversion.
Date: Fri, 26 Aug 2011 11:19:31 +0100
Message-Id: <1314353973-7662-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also add some locking.

Some major changes to how this driver works.

For voltage channels it is currently either in single read mode or in
a monitor mode (events only). Could be much cleverer and allow
reading of any channels that happend to be monitored, but haven't
done that yet.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7291.c |  892 ++++++++++++++------------------------
 1 files changed, 315 insertions(+), 577 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 52e0311..b6be672 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -7,18 +7,28 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/i2c.h>
+#include <linux/mutex.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
 
 /*
+ * Simplified handling
+ *
+ * If no events enabled - single polled channel read
+ * If event enabled direct reads disable unless channel
+ * is in the read mask.
+ *
+ * The noise-delayed bit as per datasheet suggestion is always enabled.
+ *
+ * Extref control should be based on regulator provision - not handled.
+ */
+/*
  * AD7291 registers definition
  */
 #define AD7291_COMMAND			0
@@ -55,29 +65,13 @@
 #define AD7291_T_VALUE_FLOAT_OFFSET	2
 #define AD7291_T_VALUE_FLOAT_MASK	0x2
 
-/*
- * struct ad7291_chip_info - chip specifc information
- */
-
 struct ad7291_chip_info {
 	struct i2c_client *client;
 	u16 command;
-	u8  channels;	/* Active voltage channels */
+	u8 c_mask;	/* Active voltage channels for events */
+	struct mutex state_lock;
 };
 
-/*
- * struct ad7291_chip_info - chip specifc information
- */
-
-struct ad7291_limit_regs {
-	u16	data_high;
-	u16	data_low;
-	u16	hysteresis;
-};
-
-/*
- * ad7291 register access by I2C
- */
 static int ad7291_i2c_read(struct ad7291_chip_info *chip, u8 reg, u16 *data)
 {
 	struct i2c_client *client = chip->client;
@@ -96,111 +90,9 @@ static int ad7291_i2c_read(struct ad7291_chip_info *chip, u8 reg, u16 *data)
 
 static int ad7291_i2c_write(struct ad7291_chip_info *chip, u8 reg, u16 data)
 {
-	struct i2c_client *client = chip->client;
-	int ret = 0;
-
-	ret = i2c_smbus_write_word_data(client, reg, swab16(data));
-	if (ret < 0)
-		dev_err(&client->dev, "I2C write error\n");
-
-	return ret;
-}
-
-/* Returns negative errno, or else the number of words read. */
-static int ad7291_i2c_read_data(struct ad7291_chip_info *chip, u8 reg, u16 *data)
-{
-	struct i2c_client *client = chip->client;
-	u8 commands[4];
-	int ret = 0;
-	int i, count;
-
-	if (reg == AD7291_T_SENSE || reg == AD7291_T_AVERAGE)
-		count = 2;
-	else if (reg == AD7291_VOLTAGE) {
-		if (!chip->channels) {
-			dev_err(&client->dev, "No voltage channel is selected.\n");
-			return -EINVAL;
-		}
-		count = 2 + chip->channels * 2;
-	} else {
-		dev_err(&client->dev, "I2C wrong data register\n");
-		return -EINVAL;
-	}
-
-	commands[0] = 0;
-	commands[1] = (chip->command >> 8) & 0xff;
-	commands[2] = chip->command & 0xff;
-	commands[3] = reg;
-
-	ret = i2c_master_send(client, commands, 4);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C master send error\n");
-		return ret;
-	}
-
-	ret = i2c_master_recv(client, (u8 *)data, count);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C master receive error\n");
-		return ret;
-	}
-	ret >>= 2;
-
-	for (i = 0; i < ret; i++)
-		data[i] = swab16(data[i]);
-
-	return ret;
-}
-
-static ssize_t ad7291_show_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-
-	if (chip->command & AD7291_AUTOCYCLE)
-		return sprintf(buf, "autocycle\n");
-	else
-		return sprintf(buf, "command\n");
+	return i2c_smbus_write_word_data(chip->client, reg, swab16(data));
 }
 
-static ssize_t ad7291_store_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 command;
-	int ret;
-
-	command = chip->command & (~AD7291_AUTOCYCLE);
-	if (strcmp(buf, "autocycle"))
-		command |= AD7291_AUTOCYCLE;
-
-	ret = ad7291_i2c_write(chip, AD7291_COMMAND, command);
-	if (ret)
-		return -EIO;
-
-	chip->command = command;
-
-	return ret;
-}
-
-static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
-		ad7291_show_mode,
-		ad7291_store_mode,
-		0);
-
-static ssize_t ad7291_show_available_modes(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return sprintf(buf, "command\nautocycle\n");
-}
-
-static IIO_DEVICE_ATTR(available_modes, S_IRUGO, ad7291_show_available_modes, NULL, 0);
-
 static ssize_t ad7291_store_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -208,240 +100,15 @@ static ssize_t ad7291_store_reset(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 command;
-	int ret;
-
-	command = chip->command | AD7291_RESET;
-
-	ret = ad7291_i2c_write(chip, AD7291_COMMAND, command);
-	if (ret)
-		return -EIO;
-
-	return ret;
-}
-
-static IIO_DEVICE_ATTR(reset, S_IWUSR,
-		NULL,
-		ad7291_store_reset,
-		0);
-
-static ssize_t ad7291_show_ext_ref(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", !!(chip->command & AD7291_EXT_REF));
-}
-
-static ssize_t ad7291_store_ext_ref(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 command;
-	int ret;
-
-	command = chip->command & (~AD7291_EXT_REF);
-	if (strcmp(buf, "1"))
-		command |= AD7291_EXT_REF;
-
-	ret = ad7291_i2c_write(chip, AD7291_COMMAND, command);
-	if (ret)
-		return -EIO;
-
-	chip->command = command;
-
-	return ret;
-}
-
-static IIO_DEVICE_ATTR(ext_ref, S_IRUGO | S_IWUSR,
-		ad7291_show_ext_ref,
-		ad7291_store_ext_ref,
-		0);
-
-static ssize_t ad7291_show_noise_delay(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", !!(chip->command & AD7291_NOISE_DELAY));
-}
-
-static ssize_t ad7291_store_noise_delay(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 command;
-	int ret;
-
-	command = chip->command & (~AD7291_NOISE_DELAY);
-	if (strcmp(buf, "1"))
-		command |= AD7291_NOISE_DELAY;
-
-	ret = ad7291_i2c_write(chip, AD7291_COMMAND, command);
-	if (ret)
-		return -EIO;
-
-	chip->command = command;
 
-	return ret;
+	return ad7291_i2c_write(chip, AD7291_COMMAND,
+				chip->command | AD7291_RESET);
 }
 
-static IIO_DEVICE_ATTR(noise_delay, S_IRUGO | S_IWUSR,
-		ad7291_show_noise_delay,
-		ad7291_store_noise_delay,
-		0);
-
-static ssize_t ad7291_show_t_sense(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 data;
-	char sign = ' ';
-	int ret;
-
-	ret = ad7291_i2c_read_data(chip, AD7291_T_SENSE, &data);
-	if (ret)
-		return -EIO;
-
-	if (data & AD7291_T_VALUE_SIGN) {
-		/* convert supplement to positive value */
-		data = (AD7291_T_VALUE_SIGN << 1) - data;
-		sign = '-';
-	}
-
-	return sprintf(buf, "%c%d.%.2d\n", sign,
-		(data >> AD7291_T_VALUE_FLOAT_OFFSET),
-		(data & AD7291_T_VALUE_FLOAT_MASK) * 25);
-}
-
-static IIO_DEVICE_ATTR(t_sense, S_IRUGO, ad7291_show_t_sense, NULL, 0);
-
-static ssize_t ad7291_show_t_average(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 data;
-	char sign = ' ';
-	int ret;
-
-	ret = ad7291_i2c_read_data(chip, AD7291_T_AVERAGE, &data);
-	if (ret)
-		return -EIO;
-
-	if (data & AD7291_T_VALUE_SIGN) {
-		/* convert supplement to positive value */
-		data = (AD7291_T_VALUE_SIGN << 1) - data;
-		sign = '-';
-	}
-
-	return sprintf(buf, "%c%d.%.2d\n", sign,
-		(data >> AD7291_T_VALUE_FLOAT_OFFSET),
-		(data & AD7291_T_VALUE_FLOAT_MASK) * 25);
-}
-
-static IIO_DEVICE_ATTR(t_average, S_IRUGO, ad7291_show_t_average, NULL, 0);
-
-static ssize_t ad7291_show_voltage(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 data[AD7291_VOLTAGE_LIMIT_COUNT];
-	int i, size, ret;
-
-	ret = ad7291_i2c_read_data(chip, AD7291_VOLTAGE, data);
-	if (ret)
-		return -EIO;
-
-	for (i = 0; i < AD7291_VOLTAGE_LIMIT_COUNT; i++) {
-		if (chip->command & (AD7291_T_SENSE_MASK << i)) {
-			ret = sprintf(buf, "channel[%d]=%d\n", i,
-					data[i] & AD7291_VALUE_MASK);
-			if (ret < 0)
-				break;
-			buf += ret;
-			size += ret;
-		}
-	}
-
-	return size;
-}
-
-static IIO_DEVICE_ATTR(voltage, S_IRUGO, ad7291_show_voltage, NULL, 0);
-
-static ssize_t ad7291_show_channel_mask(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "0x%x\n", (chip->command & AD7291_VOLTAGE_MASK) >>
-			AD7291_VOLTAGE_OFFSET);
-}
-
-static ssize_t ad7291_store_channel_mask(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 command;
-	unsigned long data;
-	int i, ret;
-
-	ret = strict_strtoul(buf, 16, &data);
-	if (ret || data > 0xff)
-		return -EINVAL;
-
-	command = chip->command & (~AD7291_VOLTAGE_MASK);
-	command |= data << AD7291_VOLTAGE_OFFSET;
-
-	ret = ad7291_i2c_write(chip, AD7291_COMMAND, command);
-	if (ret)
-		return -EIO;
-
-	chip->command = command;
-
-	for (i = 0, chip->channels = 0; i < AD7291_VOLTAGE_LIMIT_COUNT; i++) {
-		if (chip->command & (AD7291_T_SENSE_MASK << i))
-			chip->channels++;
-	}
-
-	return ret;
-}
-
-static IIO_DEVICE_ATTR(channel_mask, S_IRUGO | S_IWUSR,
-		ad7291_show_channel_mask,
-		ad7291_store_channel_mask,
-		0);
+static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, ad7291_store_reset, 0);
 
 static struct attribute *ad7291_attributes[] = {
-	&iio_dev_attr_available_modes.dev_attr.attr,
-	&iio_dev_attr_mode.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_dev_attr_ext_ref.dev_attr.attr,
-	&iio_dev_attr_noise_delay.dev_attr.attr,
-	&iio_dev_attr_t_sense.dev_attr.attr,
-	&iio_dev_attr_t_average.dev_attr.attr,
-	&iio_dev_attr_voltage.dev_attr.attr,
-	&iio_dev_attr_channel_mask.dev_attr.attr,
 	NULL,
 };
 
@@ -449,10 +116,6 @@ static const struct attribute_group ad7291_attribute_group = {
 	.attrs = ad7291_attributes,
 };
 
-/*
- * temperature bound events
- */
-
 static irqreturn_t ad7291_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -477,28 +140,15 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 	command = chip->command & ~AD7291_ALART_CLEAR;
 	ad7291_i2c_write(chip, AD7291_COMMAND, command);
 
-	if (t_status & (1 << 0))
+	/* For now treat t_sense and t_sense_average the same */
+	if ((t_status & (1 << 0)) || (t_status & (1 << 2)))
 		iio_push_event(indio_dev,
 			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
 			       timestamp);
-	if (t_status & (1 << 1))
-		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
-						    0,
-						    IIO_EV_TYPE_THRESH,
-						    IIO_EV_DIR_RISING),
-			       timestamp);
-	if (t_status & (1 << 2))
-		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
-						    0,
-						    IIO_EV_TYPE_THRESH,
-						    IIO_EV_DIR_FALLING),
-			       timestamp);
-	if (t_status & (1 << 3))
+	if ((t_status & (1 << 1)) || (t_status & (1 << 3)))
 		iio_push_event(indio_dev,
 			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 						    0,
@@ -526,7 +176,7 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static inline ssize_t ad7291_show_t_bound(struct device *dev,
+static inline ssize_t ad7291_show_hyst(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
@@ -534,243 +184,324 @@ static inline ssize_t ad7291_show_t_bound(struct device *dev,
 	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u16 data;
-	char sign = ' ';
 	int ret;
 
 	ret = ad7291_i2c_read(chip, this_attr->address, &data);
-	if (ret)
-		return -EIO;
-
-	data &= AD7291_VALUE_MASK;
-	if (data & AD7291_T_VALUE_SIGN) {
-		/* convert supplement to positive value */
-		data = (AD7291_T_VALUE_SIGN << 1) - data;
-		sign = '-';
-	}
+	if (ret < 0)
+		return ret;
 
-	return sprintf(buf, "%c%d.%.2d\n", sign,
-			data >> AD7291_T_VALUE_FLOAT_OFFSET,
-			(data & AD7291_T_VALUE_FLOAT_MASK) * 25);
+	return sprintf(buf, "%d\n", data & 0x0FFF);
 }
 
-static inline ssize_t ad7291_set_t_bound(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static inline ssize_t ad7291_set_hyst(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7291_chip_info *chip = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	long tmp1, tmp2;
 	u16 data;
-	char *pos;
 	int ret;
 
-	pos = strchr(buf, '.');
+	ret = kstrtou16(buf, 10, &data);
 
-	ret = strict_strtol(buf, 10, &tmp1);
-
-	if (ret || tmp1 > 127 || tmp1 < -128)
+	if (ret < 0)
+		return ret;
+	if (data < 4096)
 		return -EINVAL;
 
-	if (pos) {
-		len = strlen(pos);
-		if (len > AD7291_T_VALUE_FLOAT_OFFSET)
-			len = AD7291_T_VALUE_FLOAT_OFFSET;
-		pos[len] = 0;
-		ret = strict_strtol(pos, 10, &tmp2);
+	return ad7291_i2c_write(chip, this_attr->address, data);
+}
 
-		if (!ret)
-			tmp2 = (tmp2 / 25) * 25;
-	}
+static IIO_DEVICE_ATTR(in_temp0_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst,
+		       AD7291_T_SENSE_HYST);
+static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst, 0x06);
+static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst, 0x09);
+static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst, 0x0C);
+static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst, 0x0F);
+static IIO_DEVICE_ATTR(in_voltage4_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst, 0x12);
+static IIO_DEVICE_ATTR(in_voltage5_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst, 0x15);
+static IIO_DEVICE_ATTR(in_voltage6_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst, 0x18);
+static IIO_DEVICE_ATTR(in_voltage7_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_hyst, ad7291_set_hyst, 0x1B);
 
-	if (tmp1 < 0)
-		data = (u16)(-tmp1);
-	else
-		data = (u16)tmp1;
-	data = (data << AD7291_T_VALUE_FLOAT_OFFSET) |
-		(tmp2 & AD7291_T_VALUE_FLOAT_MASK);
-	if (tmp1 < 0)
-		/* convert positive value to supplyment */
-		data = (AD7291_T_VALUE_SIGN << 1) - data;
-
-	ret = ad7291_i2c_write(chip, this_attr->address, data);
-	if (ret)
-		return -EIO;
+static struct attribute *ad7291_event_attributes[] = {
+	&iio_dev_attr_in_temp0_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage2_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage3_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage4_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage5_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage6_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage7_thresh_both_hyst_raw.dev_attr.attr,
+	NULL,
+};
 
-	return ret;
-}
+/* high / low */
+static u8 ad7291_limit_regs[9][2] = {
+	{ 0x04, 0x05 },
+	{ 0x07, 0x08 },
+	{ 0x0A, 0x0B },
+	{ 0x0E, 0x0D }, /* note reversed order */
+	{ 0x10, 0x11 },
+	{ 0x13, 0x14 },
+	{ 0x16, 0x17 },
+	{ 0x19, 0x1A },
+	/* temp */
+	{ 0x1C, 0x1D },
+};
 
-static inline ssize_t ad7291_show_v_bound(struct device *dev,
-		struct device_attribute *attr,
-		u8 bound_reg,
-		char *buf)
+static int ad7291_read_event_value(struct iio_dev *indio_dev,
+				   u64 event_code,
+				   int *val)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	u16 data;
-	int ret;
+	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 
-	if (bound_reg < AD7291_VOLTAGE_LIMIT_BASE ||
-		bound_reg >= AD7291_VOLTAGE_LIMIT_BASE +
-		AD7291_VOLTAGE_LIMIT_COUNT)
+	int ret;
+	u8 reg;
+	u16 uval;
+	s16 signval;
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_VOLTAGE:
+		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
+			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			   IIO_EV_DIR_RISING)];
+
+		ret = ad7291_i2c_read(chip, reg, &uval);
+		if (ret < 0)
+			return ret;
+		*val = swab16(uval) & 0x0FFF;
+		return 0;
+
+	case IIO_TEMP:
+		reg = ad7291_limit_regs[8]
+			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			   IIO_EV_DIR_RISING)];
+
+		ret = ad7291_i2c_read(chip, reg, &signval);
+		if (ret < 0)
+			return ret;
+		signval = (s16)((swab16(signval) & 0x0FFF) << 4) >> 4;
+		*val = signval;
+		return 0;
+	default:
 		return -EINVAL;
+	};
+}
 
-	ret = ad7291_i2c_read(chip, bound_reg, &data);
-	if (ret)
-		return -EIO;
+static int ad7291_write_event_value(struct iio_dev *indio_dev,
+				    u64 event_code,
+				    int val)
+{
+	struct ad7291_chip_info *chip = iio_priv(indio_dev);
+	u8 reg;
+	s16 signval;
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_VOLTAGE:
+		if (val > 0xFFF || val < 0)
+			return -EINVAL;
+		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
+			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			   IIO_EV_DIR_RISING)];
 
-	data &= AD7291_VALUE_MASK;
+		return ad7291_i2c_write(chip, reg, val);
 
-	return sprintf(buf, "%d\n", data);
+	case IIO_TEMP:
+		if (val > 2047 || val < -2048)
+			return -EINVAL;
+		reg = ad7291_limit_regs[8]
+			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			   IIO_EV_DIR_RISING)];
+		signval = val;
+		return ad7291_i2c_write(chip, reg, *(u16 *)&signval);
+	default:
+		return -EINVAL;
+	};
 }
 
-static inline ssize_t ad7291_set_v_bound(struct device *dev,
-		struct device_attribute *attr,
-		u8 bound_reg,
-		const char *buf,
-		size_t len)
+static int ad7291_read_event_config(struct iio_dev *indio_dev,
+				    u64 event_code)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
-	unsigned long value;
-	u16 data;
-	int ret;
-
-	if (bound_reg < AD7291_VOLTAGE_LIMIT_BASE ||
-		bound_reg >= AD7291_VOLTAGE_LIMIT_BASE +
-		AD7291_VOLTAGE_LIMIT_COUNT)
+	struct ad7291_chip_info *chip = iio_priv(indio_dev);
+	/* To be enabled the channel must simply be on. If any are enabled
+	   we are in continuous sampling mode */
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_VOLTAGE:
+		if (chip->c_mask &
+		    (1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code)))
+			return 1;
+		else
+			return 0;
+	case IIO_TEMP:
+		/* always on */
+		return 1;
+	default:
 		return -EINVAL;
+	}
 
-	ret = strict_strtoul(buf, 10, &value);
-
-	if (ret || value >= 4096)
-		return -EINVAL;
+}
 
-	data = (u16)value;
-	ret = ad7291_i2c_write(chip, bound_reg, data);
-	if (ret)
-		return -EIO;
+static int ad7291_write_event_config(struct iio_dev *indio_dev,
+				     u64 event_code,
+				     int state)
+{
+	int ret = 0;
+	struct ad7291_chip_info *chip = iio_priv(indio_dev);
+	u16 regval;
+
+	mutex_lock(&chip->state_lock);
+	regval = chip->command;
+	/*
+	 * To be enabled the channel must simply be on. If any are enabled
+	 * use continuous sampling mode.
+	 * Possible to disable temp as well but that makes single read tricky.
+	 */
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_VOLTAGE:
+		if ((!state) && (chip->c_mask &
+			       (1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code))))
+			chip->c_mask &=
+				~(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code));
+		else if (state && (!(chip->c_mask &
+				(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code)))))
+			chip->c_mask &=
+				(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code));
+		else
+			break;
+
+		regval &= 0xFFFE;
+		regval |= ((u16)chip->c_mask << 8);
+		if (chip->c_mask) /* Enable autocycle? */
+			regval |= AD7291_AUTOCYCLE;
+
+		ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
+		if (ret < 0)
+			goto error_ret;
+
+		chip->command = regval;
+		break;
+	default:
+		ret = -EINVAL;
+	}
 
+error_ret:
+	mutex_unlock(&chip->state_lock);
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(t_sense_high_value,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound,
-		       AD7291_T_SENSE_HIGH);
-static IIO_DEVICE_ATTR(t_sense_low_value,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound,
-		       AD7291_T_SENSE_LOW);
-static IIO_DEVICE_ATTR(t_sense_hyst_value,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound,
-		       AD7291_T_SENSE_HYST);
-static IIO_DEVICE_ATTR(v0_high,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x04);
-static IIO_DEVICE_ATTR(v0_low,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x05);
-static IIO_DEVICE_ATTR(v0_hyst,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x06);
-static IIO_DEVICE_ATTR(v1_high,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x07);
-static IIO_DEVICE_ATTR(v1_low,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x08);
-static IIO_DEVICE_ATTR(v1_hyst,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x09);
-static IIO_DEVICE_ATTR(v2_high,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0A);
-static IIO_DEVICE_ATTR(v2_low,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0B);
-static IIO_DEVICE_ATTR(v2_hyst,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0C);
-static IIO_DEVICE_ATTR(v3_high,
-		       S_IRUGO | S_IWUSR,
-		       /* Datasheet suggests this one and this one only
-			  has the registers in different order */
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0E);
-static IIO_DEVICE_ATTR(v3_low,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0D);
-static IIO_DEVICE_ATTR(v3_hyst,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0F);
-static IIO_DEVICE_ATTR(v4_high,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x10);
-static IIO_DEVICE_ATTR(v4_low,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x11);
-static IIO_DEVICE_ATTR(v4_hyst,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x12);
-static IIO_DEVICE_ATTR(v5_high,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x13);
-static IIO_DEVICE_ATTR(v5_low,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x14);
-static IIO_DEVICE_ATTR(v5_hyst,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x15);
-static IIO_DEVICE_ATTR(v6_high,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x16);
-static IIO_DEVICE_ATTR(v6_low,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x17);
-static IIO_DEVICE_ATTR(v6_hyst,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x18);
-static IIO_DEVICE_ATTR(v7_high,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x19);
-static IIO_DEVICE_ATTR(v7_low,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x1A);
-static IIO_DEVICE_ATTR(v7_hyst,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_t_bound, ad7291_set_t_bound, 0x1B);
+static int ad7291_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long mask)
+{
+	int ret;
+	struct ad7291_chip_info *chip = iio_priv(indio_dev);
+	u16 regval;
+	s16 signval;
+
+	switch (mask) {
+	case 0:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			mutex_lock(&chip->state_lock);
+			/* If in autocycle mode drop through */
+			if (chip->command & 0x1) {
+				mutex_unlock(&chip->state_lock);
+				return -EBUSY;
+			}
+			/* Enable this channel alone */
+			regval = chip->command & (~AD7291_VOLTAGE_MASK);
+			regval |= 1 << (chan->channel + 8);
+			ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
+			if (ret < 0) {
+				mutex_unlock(&chip->state_lock);
+				return ret;
+			}
+			/* Read voltage */
+			ret = i2c_smbus_read_word_data(chip->client,
+						       AD7291_VOLTAGE);
+			if (ret < 0) {
+				mutex_unlock(&chip->state_lock);
+				return ret;
+			}
+			*val = swab16((u16)ret) & 0x0FFF;
+			mutex_unlock(&chip->state_lock);
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			/* Assumes tsense bit of command register always set */
+			ret = i2c_smbus_read_word_data(chip->client,
+						       AD7291_T_SENSE);
+			if (ret < 0)
+				return ret;
+			signval = (s16)((swab16((u16)ret) & 0x0FFF) << 4) >> 4;
+			*val = signval;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE):
+		ret = i2c_smbus_read_word_data(chip->client,
+					       AD7291_T_AVERAGE);
+			if (ret < 0)
+				return ret;
+			signval = (s16)((swab16((u16)ret) & 0x0FFF) << 4) >> 4;
+			*val = signval;
+			return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
 
-static struct attribute *ad7291_event_attributes[] = {
-	&iio_dev_attr_t_sense_high_value.dev_attr.attr,
-	&iio_dev_attr_t_sense_low_value.dev_attr.attr,
-	&iio_dev_attr_t_sense_hyst_value.dev_attr.attr,
-	&iio_dev_attr_v0_high.dev_attr.attr,
-	&iio_dev_attr_v0_low.dev_attr.attr,
-	&iio_dev_attr_v0_hyst.dev_attr.attr,
-	&iio_dev_attr_v1_high.dev_attr.attr,
-	&iio_dev_attr_v1_low.dev_attr.attr,
-	&iio_dev_attr_v1_hyst.dev_attr.attr,
-	&iio_dev_attr_v2_high.dev_attr.attr,
-	&iio_dev_attr_v2_low.dev_attr.attr,
-	&iio_dev_attr_v2_hyst.dev_attr.attr,
-	&iio_dev_attr_v3_high.dev_attr.attr,
-	&iio_dev_attr_v3_low.dev_attr.attr,
-	&iio_dev_attr_v3_hyst.dev_attr.attr,
-	&iio_dev_attr_v4_high.dev_attr.attr,
-	&iio_dev_attr_v4_low.dev_attr.attr,
-	&iio_dev_attr_v4_hyst.dev_attr.attr,
-	&iio_dev_attr_v5_high.dev_attr.attr,
-	&iio_dev_attr_v5_low.dev_attr.attr,
-	&iio_dev_attr_v5_hyst.dev_attr.attr,
-	&iio_dev_attr_v6_high.dev_attr.attr,
-	&iio_dev_attr_v6_low.dev_attr.attr,
-	&iio_dev_attr_v6_hyst.dev_attr.attr,
-	&iio_dev_attr_v7_high.dev_attr.attr,
-	&iio_dev_attr_v7_low.dev_attr.attr,
-	&iio_dev_attr_v7_hyst.dev_attr.attr,
-	NULL,
+#define AD7291_VOLTAGE_CHAN(_chan)					\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = _chan,						\
+	.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)|\
+	IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)		\
+}
+
+static const struct iio_chan_spec ad7291_channels[] = {
+	AD7291_VOLTAGE_CHAN(0),
+	AD7291_VOLTAGE_CHAN(1),
+	AD7291_VOLTAGE_CHAN(2),
+	AD7291_VOLTAGE_CHAN(3),
+	AD7291_VOLTAGE_CHAN(4),
+	AD7291_VOLTAGE_CHAN(5),
+	AD7291_VOLTAGE_CHAN(6),
+	AD7291_VOLTAGE_CHAN(7),
+	{
+		.type = IIO_TEMP,
+		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
+		.indexed = 1,
+		.channel = 0,
+		.event_mask =
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)|
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)
+	}
 };
 
 static struct attribute_group ad7291_event_attribute_group = {
@@ -779,13 +510,14 @@ static struct attribute_group ad7291_event_attribute_group = {
 
 static const struct iio_info ad7291_info = {
 	.attrs = &ad7291_attribute_group,
+	.read_raw = &ad7291_read_raw,
+	.read_event_config = &ad7291_read_event_config,
+	.write_event_config = &ad7291_write_event_config,
+	.read_event_value = &ad7291_read_event_value,
+	.write_event_value = &ad7291_write_event_value,
 	.event_attrs = &ad7291_event_attribute_group,
 };
 
-/*
- * device probe and remove
- */
-
 static int __devinit ad7291_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -799,13 +531,18 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 		goto error_ret;
 	}
 	chip = iio_priv(indio_dev);
+	mutex_init(&chip->state_lock);
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
+	/* Tsense always enabled */
 	chip->command = AD7291_NOISE_DELAY | AD7291_T_SENSE_MASK;
 
 	indio_dev->name = id->name;
+	indio_dev->channels = ad7291_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7291_channels);
+
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad7291_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -840,7 +577,8 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	return 0;
 
 error_unreg_irq:
-	free_irq(client->irq, indio_dev);
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
-- 
1.7.3.4

