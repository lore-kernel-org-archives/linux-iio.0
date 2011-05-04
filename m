Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 21/99] staging:iio:ad7291 move from old event system to current.
Date: Wed,  4 May 2011 12:57:53 +0100
Message-Id: <1304510351-10922-22-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This driver needed some tender loving care. It still does.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7291.c |  422 ++++++++++++-------------------------
 1 files changed, 137 insertions(+), 285 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 976ae7f..23ad18e 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -8,14 +8,12 @@
 
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/i2c.h>
-#include <linux/rtc.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -65,8 +63,6 @@ struct ad7291_chip_info {
 	const char *name;
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
-	struct work_struct thresh_work;
-	s64 last_timestamp;
 	u16 command;
 	u8  channels;	/* Active voltage channels */
 };
@@ -477,22 +473,23 @@ static const struct attribute_group ad7291_attribute_group = {
 #define IIO_EVENT_CODE_AD7291_T_AVG_LOW     IIO_BUFFER_EVENT_CODE(3)
 #define IIO_EVENT_CODE_AD7291_VOLTAGE_BASE  IIO_BUFFER_EVENT_CODE(4)
 
-static void ad7291_interrupt_bh(struct work_struct *work_s)
+static irqreturn_t ad7291_event_handler(int irq, void *private)
 {
-	struct ad7291_chip_info *chip =
-		container_of(work_s, struct ad7291_chip_info, thresh_work);
+	struct iio_dev *indio_dev = private;
+	struct ad7291_chip_info *chip = iio_dev_get_devdata(private);
 	u16 t_status, v_status;
 	u16 command;
 	int i;
+	s64 timestamp = iio_get_time_ns();
 
 	if (ad7291_i2c_read(chip, AD7291_T_ALERT_STATUS, &t_status))
-		return;
+		return IRQ_HANDLED;
 
 	if (ad7291_i2c_read(chip, AD7291_VOLTAGE_ALERT_STATUS, &v_status))
-		return;
+		return IRQ_HANDLED;
 
 	if (!(t_status || v_status))
-		return;
+		return IRQ_HANDLED;
 
 	command = chip->command | AD7291_ALART_CLEAR;
 	ad7291_i2c_write(chip, AD7291_COMMAND, command);
@@ -500,50 +497,35 @@ static void ad7291_interrupt_bh(struct work_struct *work_s)
 	command = chip->command & ~AD7291_ALART_CLEAR;
 	ad7291_i2c_write(chip, AD7291_COMMAND, command);
 
-	enable_irq(chip->client->irq);
-
 	for (i = 0; i < 4; i++) {
 		if (t_status & (1 << i))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				IIO_EVENT_CODE_AD7291_T_SENSE_HIGH + i,
-				chip->last_timestamp);
+				timestamp);
 	}
 
 	for (i = 0; i < AD7291_VOLTAGE_LIMIT_COUNT*2; i++) {
 		if (v_status & (1 << i))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				IIO_EVENT_CODE_AD7291_VOLTAGE_BASE + i,
-				chip->last_timestamp);
+				timestamp);
 	}
-}
 
-static int ad7291_interrupt(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct ad7291_chip_info *chip = dev_info->dev_data;
-
-	chip->last_timestamp = timestamp;
-	schedule_work(&chip->thresh_work);
-
-	return 0;
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(ad7291, &ad7291_interrupt);
-
 static inline ssize_t ad7291_show_t_bound(struct device *dev,
 		struct device_attribute *attr,
-		u8 bound_reg,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u16 data;
 	char sign = ' ';
 	int ret;
 
-	ret = ad7291_i2c_read(chip, bound_reg, &data);
+	ret = ad7291_i2c_read(chip, this_attr->address, &data);
 	if (ret)
 		return -EIO;
 
@@ -561,12 +543,12 @@ static inline ssize_t ad7291_show_t_bound(struct device *dev,
 
 static inline ssize_t ad7291_set_t_bound(struct device *dev,
 		struct device_attribute *attr,
-		u8 bound_reg,
 		const char *buf,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7291_chip_info *chip = dev_info->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long tmp1, tmp2;
 	u16 data;
 	char *pos;
@@ -600,64 +582,13 @@ static inline ssize_t ad7291_set_t_bound(struct device *dev,
 		/* convert positive value to supplyment */
 		data = (AD7291_T_VALUE_SIGN << 1) - data;
 
-	ret = ad7291_i2c_write(chip, bound_reg, data);
+	ret = ad7291_i2c_write(chip, this_attr->address, data);
 	if (ret)
 		return -EIO;
 
 	return ret;
 }
 
-static ssize_t ad7291_show_t_sense_high(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return ad7291_show_t_bound(dev, attr,
-			AD7291_T_SENSE_HIGH, buf);
-}
-
-static inline ssize_t ad7291_set_t_sense_high(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return ad7291_set_t_bound(dev, attr,
-			AD7291_T_SENSE_HIGH, buf, len);
-}
-
-static ssize_t ad7291_show_t_sense_low(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return ad7291_show_t_bound(dev, attr,
-			AD7291_T_SENSE_LOW, buf);
-}
-
-static inline ssize_t ad7291_set_t_sense_low(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return ad7291_set_t_bound(dev, attr,
-			AD7291_T_SENSE_LOW, buf, len);
-}
-
-static ssize_t ad7291_show_t_sense_hyst(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return ad7291_show_t_bound(dev, attr,
-			AD7291_T_SENSE_HYST, buf);
-}
-
-static inline ssize_t ad7291_set_t_sense_hyst(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	return ad7291_set_t_bound(dev, attr,
-			AD7291_T_SENSE_HYST, buf, len);
-}
-
 static inline ssize_t ad7291_show_v_bound(struct device *dev,
 		struct device_attribute *attr,
 		u8 bound_reg,
@@ -712,191 +643,121 @@ static inline ssize_t ad7291_set_v_bound(struct device *dev,
 	return ret;
 }
 
-static int ad7291_get_voltage_limit_regs(const char *channel)
-{
-	int index;
-
-	if (strlen(channel) < 3 && channel[0] != 'v')
-		return -EINVAL;
-
-	index = channel[1] - '0';
-	if (index >= AD7291_VOLTAGE_LIMIT_COUNT)
-		return -EINVAL;
-
-	return index;
-}
-
-static ssize_t ad7291_show_voltage_high(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int regs;
-
-	regs = ad7291_get_voltage_limit_regs(attr->attr.name);
-
-	if (regs < 0)
-		return regs;
-
-	return ad7291_show_t_bound(dev, attr, regs, buf);
-}
-
-static inline ssize_t ad7291_set_voltage_high(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	int regs;
-
-	regs = ad7291_get_voltage_limit_regs(attr->attr.name);
-
-	if (regs < 0)
-		return regs;
-
-	return ad7291_set_t_bound(dev, attr, regs, buf, len);
-}
-
-static ssize_t ad7291_show_voltage_low(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int regs;
-
-	regs = ad7291_get_voltage_limit_regs(attr->attr.name);
-
-	if (regs < 0)
-		return regs;
-
-	return ad7291_show_t_bound(dev, attr, regs+1, buf);
-}
-
-static inline ssize_t ad7291_set_voltage_low(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	int regs;
-
-	regs = ad7291_get_voltage_limit_regs(attr->attr.name);
-
-	if (regs < 0)
-		return regs;
-
-	return ad7291_set_t_bound(dev, attr, regs+1, buf, len);
-}
-
-static ssize_t ad7291_show_voltage_hyst(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int regs;
-
-	regs = ad7291_get_voltage_limit_regs(attr->attr.name);
-
-	if (regs < 0)
-		return regs;
-
-	return ad7291_show_t_bound(dev, attr, regs+2, buf);
-}
-
-static inline ssize_t ad7291_set_voltage_hyst(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	int regs;
-
-	regs = ad7291_get_voltage_limit_regs(attr->attr.name);
-
-	if (regs < 0)
-		return regs;
-
-	return ad7291_set_t_bound(dev, attr, regs+2, buf, len);
-}
-
-IIO_EVENT_ATTR_SH(t_sense_high, iio_event_ad7291,
-		ad7291_show_t_sense_high, ad7291_set_t_sense_high, 0);
-IIO_EVENT_ATTR_SH(t_sense_low, iio_event_ad7291,
-		ad7291_show_t_sense_low, ad7291_set_t_sense_low, 0);
-IIO_EVENT_ATTR_SH(t_sense_hyst, iio_event_ad7291,
-		ad7291_show_t_sense_hyst, ad7291_set_t_sense_hyst, 0);
-
-IIO_EVENT_ATTR_SH(v0_high, iio_event_ad7291,
-		ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
-IIO_EVENT_ATTR_SH(v0_low, iio_event_ad7291,
-		ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
-IIO_EVENT_ATTR_SH(v0_hyst, iio_event_ad7291,
-		ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
-IIO_EVENT_ATTR_SH(v1_high, iio_event_ad7291,
-		ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
-IIO_EVENT_ATTR_SH(v1_low, iio_event_ad7291,
-		ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
-IIO_EVENT_ATTR_SH(v1_hyst, iio_event_ad7291,
-		ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
-IIO_EVENT_ATTR_SH(v2_high, iio_event_ad7291,
-		ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
-IIO_EVENT_ATTR_SH(v2_low, iio_event_ad7291,
-		ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
-IIO_EVENT_ATTR_SH(v2_hyst, iio_event_ad7291,
-		ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
-IIO_EVENT_ATTR_SH(v3_high, iio_event_ad7291,
-		ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
-IIO_EVENT_ATTR_SH(v3_low, iio_event_ad7291,
-		ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
-IIO_EVENT_ATTR_SH(v3_hyst, iio_event_ad7291,
-		ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
-IIO_EVENT_ATTR_SH(v4_high, iio_event_ad7291,
-		ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
-IIO_EVENT_ATTR_SH(v4_low, iio_event_ad7291,
-		ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
-IIO_EVENT_ATTR_SH(v4_hyst, iio_event_ad7291,
-		ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
-IIO_EVENT_ATTR_SH(v5_high, iio_event_ad7291,
-		ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
-IIO_EVENT_ATTR_SH(v5_low, iio_event_ad7291,
-		ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
-IIO_EVENT_ATTR_SH(v5_hyst, iio_event_ad7291,
-		ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
-IIO_EVENT_ATTR_SH(v6_high, iio_event_ad7291,
-		ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
-IIO_EVENT_ATTR_SH(v6_low, iio_event_ad7291,
-		ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
-IIO_EVENT_ATTR_SH(v6_hyst, iio_event_ad7291,
-		ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
-IIO_EVENT_ATTR_SH(v7_high, iio_event_ad7291,
-		ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
-IIO_EVENT_ATTR_SH(v7_low, iio_event_ad7291,
-		ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
-IIO_EVENT_ATTR_SH(v7_hyst, iio_event_ad7291,
-		ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
+static IIO_DEVICE_ATTR(t_sense_high_value,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound,
+		       AD7291_T_SENSE_HIGH);
+static IIO_DEVICE_ATTR(t_sense_low_value,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound,
+		       AD7291_T_SENSE_LOW);
+static IIO_DEVICE_ATTR(t_sense_hyst_value,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound,
+		       AD7291_T_SENSE_HYST);
+static IIO_DEVICE_ATTR(v0_high,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x04);
+static IIO_DEVICE_ATTR(v0_low,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x05);
+static IIO_DEVICE_ATTR(v0_hyst,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x06);
+static IIO_DEVICE_ATTR(v1_high,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x07);
+static IIO_DEVICE_ATTR(v1_low,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x08);
+static IIO_DEVICE_ATTR(v1_hyst,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x09);
+static IIO_DEVICE_ATTR(v2_high,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0A);
+static IIO_DEVICE_ATTR(v2_low,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0B);
+static IIO_DEVICE_ATTR(v2_hyst,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0C);
+static IIO_DEVICE_ATTR(v3_high,
+		       S_IRUGO | S_IWUSR,
+		       /* Datasheet suggests this one and this one only
+			  has the registers in different order */
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0E);
+static IIO_DEVICE_ATTR(v3_low,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0D);
+static IIO_DEVICE_ATTR(v3_hyst,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x0F);
+static IIO_DEVICE_ATTR(v4_high,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x10);
+static IIO_DEVICE_ATTR(v4_low,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x11);
+static IIO_DEVICE_ATTR(v4_hyst,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x12);
+static IIO_DEVICE_ATTR(v5_high,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x13);
+static IIO_DEVICE_ATTR(v5_low,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x14);
+static IIO_DEVICE_ATTR(v5_hyst,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x15);
+static IIO_DEVICE_ATTR(v6_high,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x16);
+static IIO_DEVICE_ATTR(v6_low,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x17);
+static IIO_DEVICE_ATTR(v6_hyst,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x18);
+static IIO_DEVICE_ATTR(v7_high,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x19);
+static IIO_DEVICE_ATTR(v7_low,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x1A);
+static IIO_DEVICE_ATTR(v7_hyst,
+		       S_IRUGO | S_IWUSR,
+		       ad7291_show_t_bound, ad7291_set_t_bound, 0x1B);
 
 static struct attribute *ad7291_event_attributes[] = {
-	&iio_event_attr_t_sense_high.dev_attr.attr,
-	&iio_event_attr_t_sense_low.dev_attr.attr,
-	&iio_event_attr_t_sense_hyst.dev_attr.attr,
-	&iio_event_attr_v0_high.dev_attr.attr,
-	&iio_event_attr_v0_low.dev_attr.attr,
-	&iio_event_attr_v0_hyst.dev_attr.attr,
-	&iio_event_attr_v1_high.dev_attr.attr,
-	&iio_event_attr_v1_low.dev_attr.attr,
-	&iio_event_attr_v1_hyst.dev_attr.attr,
-	&iio_event_attr_v2_high.dev_attr.attr,
-	&iio_event_attr_v2_low.dev_attr.attr,
-	&iio_event_attr_v2_hyst.dev_attr.attr,
-	&iio_event_attr_v3_high.dev_attr.attr,
-	&iio_event_attr_v3_low.dev_attr.attr,
-	&iio_event_attr_v3_hyst.dev_attr.attr,
-	&iio_event_attr_v4_high.dev_attr.attr,
-	&iio_event_attr_v4_low.dev_attr.attr,
-	&iio_event_attr_v4_hyst.dev_attr.attr,
-	&iio_event_attr_v5_high.dev_attr.attr,
-	&iio_event_attr_v5_low.dev_attr.attr,
-	&iio_event_attr_v5_hyst.dev_attr.attr,
-	&iio_event_attr_v6_high.dev_attr.attr,
-	&iio_event_attr_v6_low.dev_attr.attr,
-	&iio_event_attr_v6_hyst.dev_attr.attr,
-	&iio_event_attr_v7_high.dev_attr.attr,
-	&iio_event_attr_v7_low.dev_attr.attr,
-	&iio_event_attr_v7_hyst.dev_attr.attr,
+	&iio_dev_attr_t_sense_high_value.dev_attr.attr,
+	&iio_dev_attr_t_sense_low_value.dev_attr.attr,
+	&iio_dev_attr_t_sense_hyst_value.dev_attr.attr,
+	&iio_dev_attr_v0_high.dev_attr.attr,
+	&iio_dev_attr_v0_low.dev_attr.attr,
+	&iio_dev_attr_v0_hyst.dev_attr.attr,
+	&iio_dev_attr_v1_high.dev_attr.attr,
+	&iio_dev_attr_v1_low.dev_attr.attr,
+	&iio_dev_attr_v1_hyst.dev_attr.attr,
+	&iio_dev_attr_v2_high.dev_attr.attr,
+	&iio_dev_attr_v2_low.dev_attr.attr,
+	&iio_dev_attr_v2_hyst.dev_attr.attr,
+	&iio_dev_attr_v3_high.dev_attr.attr,
+	&iio_dev_attr_v3_low.dev_attr.attr,
+	&iio_dev_attr_v3_hyst.dev_attr.attr,
+	&iio_dev_attr_v4_high.dev_attr.attr,
+	&iio_dev_attr_v4_low.dev_attr.attr,
+	&iio_dev_attr_v4_hyst.dev_attr.attr,
+	&iio_dev_attr_v5_high.dev_attr.attr,
+	&iio_dev_attr_v5_low.dev_attr.attr,
+	&iio_dev_attr_v5_hyst.dev_attr.attr,
+	&iio_dev_attr_v6_high.dev_attr.attr,
+	&iio_dev_attr_v6_low.dev_attr.attr,
+	&iio_dev_attr_v6_hyst.dev_attr.attr,
+	&iio_dev_attr_v7_high.dev_attr.attr,
+	&iio_dev_attr_v7_low.dev_attr.attr,
+	&iio_dev_attr_v7_hyst.dev_attr.attr,
 	NULL,
 };
 
@@ -945,24 +806,15 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 		goto error_free_dev;
 
 	if (client->irq > 0) {
-		ret = iio_register_interrupt_line(client->irq,
-				chip->indio_dev,
-				0,
-				IRQF_TRIGGER_LOW,
-				chip->name);
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   &ad7291_event_handler,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   chip->name,
+					   chip->indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 
-		/*
-		 * The event handler list element refer to iio_event_ad7291.
-		 * All event attributes bind to the same event handler.
-		 * So, only register event handler once.
-		 */
-		iio_add_event_to_list(&iio_event_ad7291,
-				&chip->indio_dev->interrupts[0]->ev_list);
-
-		INIT_WORK(&chip->thresh_work, ad7291_interrupt_bh);
-
 		/* set irq polarity low level */
 		chip->command |= AD7291_ALART_POLARITY;
 	}
@@ -979,7 +831,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	return 0;
 
 error_unreg_irq:
-	iio_unregister_interrupt_line(chip->indio_dev, 0);
+	free_irq(client->irq, chip->indio_dev);
 error_unreg_dev:
 	iio_device_unregister(chip->indio_dev);
 error_free_dev:
@@ -996,7 +848,7 @@ static int __devexit ad7291_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = chip->indio_dev;
 
 	if (client->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(client->irq, chip->indio_dev);
 	iio_device_unregister(indio_dev);
 	iio_free_device(chip->indio_dev);
 	kfree(chip);
-- 
1.7.3.4
