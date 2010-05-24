Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/11] staging:iio: tsl2563 abi fixes and interrupt handling
Date: Mon, 24 May 2010 22:02:54 +0100
Message-Id: <1274734976-7941-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/light.h   |    7 +-
 drivers/staging/iio/light/tsl2563.c |  389 +++++++++++++++++++++++++++--------
 2 files changed, 300 insertions(+), 96 deletions(-)

diff --git a/drivers/staging/iio/light/light.h b/drivers/staging/iio/light/light.h
index f00f827..e4e1e2c 100644
--- a/drivers/staging/iio/light/light.h
+++ b/drivers/staging/iio/light/light.h
@@ -2,11 +2,6 @@
 
 /* Light to digital sensor attributes */
 
-#define IIO_DEV_ATTR_LIGHT_INFRARED(_num, _show, _addr)			\
-	IIO_DEVICE_ATTR(light_infrared##_num, S_IRUGO, _show, NULL, _addr)
+#define IIO_EVENT_CODE_LIGHT_THRESH IIO_EVENT_CODE_LIGHT_BASE
 
-#define IIO_DEV_ATTR_LIGHT_BROAD(_num, _show, _addr)			\
-	IIO_DEVICE_ATTR(light_broadspectrum##_num, S_IRUGO, _show, NULL, _addr)
 
-#define IIO_DEV_ATTR_LIGHT_VISIBLE(_num, _show, _addr)			\
-	IIO_DEVICE_ATTR(light_visible##_num, S_IRUGO, _show, NULL, _addr)
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 43aaacf..2d471ec 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
@@ -117,15 +118,17 @@ struct tsl2563_chip {
 	struct iio_dev		*indio_dev;
 	struct delayed_work	poweroff_work;
 
+	struct work_struct	work_thresh;
+	s64			event_timestamp;
 	/* Remember state for suspend and resume functions */
 	pm_message_t		state;
 
 	struct tsl2563_gainlevel_coeff *gainlevel;
 
-	/* Thresholds are in lux */
 	u16			low_thres;
 	u16			high_thres;
 	u8			intr;
+	bool			int_enabled;
 
 	/* Calibration coefficients */
 	u32			calib0;
@@ -189,17 +192,29 @@ static int tsl2563_get_power(struct tsl2563_chip *chip)
 
 static int tsl2563_configure(struct tsl2563_chip *chip)
 {
-	struct i2c_client *client = chip->client;
 	int ret;
 
-	ret = tsl2563_write(client, TSL2563_REG_TIMING,
+	ret = tsl2563_write(chip->client, TSL2563_REG_TIMING,
 			chip->gainlevel->gaintime);
 	if (ret)
-		goto out;
-
-	ret = tsl2563_write(client, TSL2563_REG_INT, chip->intr);
-
-out:
+		goto error_ret;
+	ret = tsl2563_write(chip->client, TSL2563_REG_HIGHLOW,
+			chip->high_thres & 0xFF);
+	if (ret)
+		goto error_ret;
+	ret = tsl2563_write(chip->client, TSL2563_REG_HIGHHIGH,
+			(chip->high_thres >> 8) & 0xFF);
+	if (ret)
+		goto error_ret;
+	ret = tsl2563_write(chip->client, TSL2563_REG_LOWLOW,
+			chip->low_thres & 0xFF);
+	if (ret)
+		goto error_ret;
+	ret = tsl2563_write(chip->client, TSL2563_REG_LOWHIGH,
+			(chip->low_thres >> 8) & 0xFF);
+/* Interrupt register is automatically written anyway if it is relevant
+   so is not here */
+error_ret:
 	return ret;
 }
 
@@ -323,21 +338,23 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
 	if (chip->state.event != PM_EVENT_ON)
 		goto out;
 
-	cancel_delayed_work(&chip->poweroff_work);
-
-	if (!tsl2563_get_power(chip)) {
-		ret = tsl2563_set_power(chip, 1);
-		if (ret)
-			goto out;
-		ret = tsl2563_configure(chip);
-		if (ret)
-			goto out;
-		tsl2563_wait_adc(chip);
+	if (!chip->int_enabled) {
+		cancel_delayed_work(&chip->poweroff_work);
+
+		if (!tsl2563_get_power(chip)) {
+			ret = tsl2563_set_power(chip, 1);
+			if (ret)
+				goto out;
+			ret = tsl2563_configure(chip);
+			if (ret)
+				goto out;
+			tsl2563_wait_adc(chip);
+		}
 	}
 
 	while (retry) {
 		ret = tsl2563_read(client,
-				   TSL2563_REG_DATA0LOW | TSL2563_CLEARINT,
+				   TSL2563_REG_DATA0LOW,
 				   buf0, sizeof(buf0));
 		if (ret != sizeof(buf0))
 			goto out;
@@ -356,7 +373,8 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
 	chip->data0 = normalize_adc(adc0, chip->gainlevel->gaintime);
 	chip->data1 = normalize_adc(adc1, chip->gainlevel->gaintime);
 
-	schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
+	if (!chip->int_enabled)
+		schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
 
 	ret = 0;
 out:
@@ -449,11 +467,12 @@ static unsigned int adc_to_lux(u32 adc0, u32 adc1)
 /*                      Sysfs interface                         */
 /*--------------------------------------------------------------*/
 
-static ssize_t tsl2563_adc0_show(struct device *dev,
+static ssize_t tsl2563_adc_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 
 	mutex_lock(&chip->lock);
@@ -462,26 +481,14 @@ static ssize_t tsl2563_adc0_show(struct device *dev,
 	if (ret)
 		goto out;
 
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", chip->data0);
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-
-static ssize_t tsl2563_adc1_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
-	int ret;
-
-	mutex_lock(&chip->lock);
-
-	ret = tsl2563_get_adc(chip);
-	if (ret)
-		goto out;
-
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", chip->data1);
+	switch (this_attr->address) {
+	case 0:
+		ret = snprintf(buf, PAGE_SIZE, "%d\n", chip->data0);
+		break;
+	case 1:
+		ret = snprintf(buf, PAGE_SIZE, "%d\n", chip->data1);
+		break;
+	}
 out:
 	mutex_unlock(&chip->lock);
 	return ret;
@@ -527,37 +534,36 @@ static ssize_t format_calib(char *buf, int len, u32 calib)
 	return snprintf(buf, PAGE_SIZE, "%d\n", calib_to_sysfs(calib));
 }
 
-static ssize_t tsl2563_calib0_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2563_chip *chip = indio_dev->dev_data;
-	int ret;
-
-	mutex_lock(&chip->lock);
-	ret = format_calib(buf, PAGE_SIZE, chip->calib0);
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-
-static ssize_t tsl2563_calib1_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t tsl2563_calib_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 
 	mutex_lock(&chip->lock);
-	ret = format_calib(buf, PAGE_SIZE, chip->calib1);
+	switch (this_attr->address) {
+	case 0:
+		ret = format_calib(buf, PAGE_SIZE, chip->calib0);
+		break;
+	case 1:
+		ret = format_calib(buf, PAGE_SIZE, chip->calib1);
+		break;
+	default:
+		ret = -ENODEV;
+	}
 	mutex_unlock(&chip->lock);
 	return ret;
 }
 
-static int do_calib_store(struct device *dev, const char *buf, size_t len,
-			  int ch)
+static ssize_t tsl2563_calib_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int value;
 	u32 calib;
 
@@ -566,37 +572,27 @@ static int do_calib_store(struct device *dev, const char *buf, size_t len,
 
 	calib = calib_from_sysfs(value);
 
-	if (ch)
-		chip->calib1 = calib;
-	else
+	switch (this_attr->address) {
+	case 0:
 		chip->calib0 = calib;
+		break;
+	case 1:
+		chip->calib1 = calib;
+		break;
+	}
 
 	return len;
 }
 
-static ssize_t tsl2563_calib0_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t len)
-{
-	return do_calib_store(dev, buf, len, 0);
-}
-
-static ssize_t tsl2563_calib1_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t len)
-{
-	return do_calib_store(dev, buf, len, 1);
-}
-
-/* AmitXXXX: Convert to IIO_DEV_ATTR_LIGHT* as in tsl2561
- * once I understand what they mean */
-static DEVICE_ATTR(adc0, S_IRUGO, tsl2563_adc0_show, NULL);
-static DEVICE_ATTR(adc1, S_IRUGO, tsl2563_adc1_show, NULL);
+static IIO_DEVICE_ATTR(intensity_both_raw, S_IRUGO,
+		tsl2563_adc_show, NULL, 0);
+static IIO_DEVICE_ATTR(intensity_ir_raw, S_IRUGO,
+		tsl2563_adc_show, NULL, 1);
 static DEVICE_ATTR(illuminance0_input, S_IRUGO, tsl2563_lux_show, NULL);
-static DEVICE_ATTR(calib0, S_IRUGO | S_IWUSR,
-		   tsl2563_calib0_show, tsl2563_calib0_store);
-static DEVICE_ATTR(calib1, S_IRUGO | S_IWUSR,
-		   tsl2563_calib1_show, tsl2563_calib1_store);
+static IIO_DEVICE_ATTR(intensity_both_calibgain, S_IRUGO | S_IWUSR,
+		tsl2563_calib_show, tsl2563_calib_store, 0);
+static IIO_DEVICE_ATTR(intensity_ir_calibgain, S_IRUGO | S_IWUSR,
+		tsl2563_calib_show, tsl2563_calib_store, 1);
 
 static ssize_t tsl2563_show_name(struct device *dev,
 				struct device_attribute *attr,
@@ -610,11 +606,11 @@ static ssize_t tsl2563_show_name(struct device *dev,
 static DEVICE_ATTR(name, S_IRUGO, tsl2563_show_name, NULL);
 
 static struct attribute *tsl2563_attributes[] = {
-	&dev_attr_adc0.attr,
-	&dev_attr_adc1.attr,
+	&iio_dev_attr_intensity_both_raw.dev_attr.attr,
+	&iio_dev_attr_intensity_ir_raw.dev_attr.attr,
 	&dev_attr_illuminance0_input.attr,
-	&dev_attr_calib0.attr,
-	&dev_attr_calib1.attr,
+	&iio_dev_attr_intensity_both_calibgain.dev_attr.attr,
+	&iio_dev_attr_intensity_ir_calibgain.dev_attr.attr,
 	&dev_attr_name.attr,
 	NULL
 };
@@ -623,6 +619,192 @@ static const struct attribute_group tsl2563_group = {
 	.attrs = tsl2563_attributes,
 };
 
+static ssize_t tsl2563_read_thresh(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	u16 val = 0;
+	switch (this_attr->address) {
+	case TSL2563_REG_HIGHLOW:
+		val = chip->high_thres;
+		break;
+	case TSL2563_REG_LOWLOW:
+		val = chip->low_thres;
+		break;
+	}
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t tsl2563_write_thresh(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned long val;
+	int ret;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	mutex_lock(&chip->lock);
+	ret = tsl2563_write(chip->client, this_attr->address, val & 0xFF);
+	if (ret)
+		goto error_ret;
+	ret = tsl2563_write(chip->client, this_attr->address + 1,
+			(val >> 8) & 0xFF);
+	switch (this_attr->address) {
+	case TSL2563_REG_HIGHLOW:
+		chip->high_thres = val;
+		break;
+	case TSL2563_REG_LOWLOW:
+		chip->low_thres = val;
+		break;
+	}
+
+error_ret:
+	mutex_unlock(&chip->lock);
+
+	return ret < 0 ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(intensity_both_thresh_high_value,
+		S_IRUGO | S_IWUSR,
+		tsl2563_read_thresh,
+		tsl2563_write_thresh,
+		TSL2563_REG_HIGHLOW);
+
+static IIO_DEVICE_ATTR(intensity_both_thresh_low_value,
+		S_IRUGO | S_IWUSR,
+		tsl2563_read_thresh,
+		tsl2563_write_thresh,
+		TSL2563_REG_LOWLOW);
+
+static int tsl2563_int_th(struct iio_dev *dev_info,
+			int index,
+			s64 timestamp,
+			int not_test)
+{
+	struct tsl2563_chip *chip = dev_info->dev_data;
+
+	chip->event_timestamp = timestamp;
+	schedule_work(&chip->work_thresh);
+
+	return 0;
+}
+
+static void tsl2563_int_bh(struct work_struct *work_s)
+{
+	struct tsl2563_chip *chip
+		= container_of(work_s,
+			struct tsl2563_chip, work_thresh);
+	u8 cmd = TSL2563_CMD | TSL2563_CLEARINT;
+
+	iio_push_event(chip->indio_dev, 0,
+		IIO_EVENT_CODE_LIGHT_BASE,
+		chip->event_timestamp);
+
+	/* reenable_irq */
+	enable_irq(chip->client->irq);
+	/* clear the interrupt and push the event */
+	i2c_master_send(chip->client, &cmd, sizeof(cmd));
+
+}
+
+static ssize_t tsl2563_write_interrupt_config(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tsl2563_chip *chip = indio_dev->dev_data;
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	int input, ret = 0;
+
+	ret = sscanf(buf, "%d", &input);
+	if (ret != 1)
+		return -EINVAL;
+	mutex_lock(&chip->lock);
+	if (input && !(chip->intr & 0x30)) {
+		iio_add_event_to_list(this_attr->listel,
+				&indio_dev->interrupts[0]->ev_list);
+		chip->intr &= ~0x30;
+		chip->intr |= 0x10;
+		/* ensure the chip is actually on */
+		cancel_delayed_work(&chip->poweroff_work);
+		if (!tsl2563_get_power(chip)) {
+			ret = tsl2563_set_power(chip, 1);
+			if (ret)
+				goto out;
+			ret = tsl2563_configure(chip);
+			if (ret)
+				goto out;
+		}
+		ret = tsl2563_write(chip->client, TSL2563_REG_INT, chip->intr);
+		chip->int_enabled = true;
+	}
+
+	if (!input && (chip->intr & 0x30)) {
+		chip->intr |= ~0x30;
+		ret = tsl2563_write(chip->client, TSL2563_REG_INT, chip->intr);
+		iio_remove_event_from_list(this_attr->listel,
+					&indio_dev->interrupts[0]->ev_list);
+		chip->int_enabled = false;
+		/* now the interrupt is not enabled, we can go to sleep */
+		schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
+	}
+out:
+	mutex_unlock(&chip->lock);
+
+	return (ret < 0) ? ret : len;
+}
+
+static ssize_t tsl2563_read_interrupt_config(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tsl2563_chip *chip = indio_dev->dev_data;
+	int ret;
+	u8 rxbuf;
+	ssize_t len;
+
+	mutex_lock(&chip->lock);
+	ret = tsl2563_read(chip->client,
+			TSL2563_REG_INT,
+			&rxbuf,
+			sizeof(rxbuf));
+	mutex_unlock(&chip->lock);
+	if (ret < 0)
+		goto error_ret;
+	len = snprintf(buf, PAGE_SIZE, "%d\n", !!(rxbuf & 0x30));
+error_ret:
+
+	return (ret < 0) ? ret : len;
+}
+
+IIO_EVENT_ATTR(intensity_both_thresh_both_en,
+	tsl2563_read_interrupt_config,
+	tsl2563_write_interrupt_config,
+	0,
+	tsl2563_int_th);
+
+static struct attribute *tsl2563_event_attributes[] = {
+	&iio_event_attr_intensity_both_thresh_both_en.dev_attr.attr,
+	&iio_dev_attr_intensity_both_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_intensity_both_thresh_low_value.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group tsl2563_event_attribute_group = {
+	.attrs = tsl2563_event_attributes,
+};
+
 /*--------------------------------------------------------------*/
 /*                      Probe, Attach, Remove                   */
 /*--------------------------------------------------------------*/
@@ -641,6 +823,7 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	if (!chip)
 		return -ENOMEM;
 
+	INIT_WORK(&chip->work_thresh, tsl2563_int_bh);
 	i2c_set_clientdata(client, chip);
 	chip->client = client;
 
@@ -679,18 +862,36 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	chip->indio_dev->dev_data = (void *)(chip);
 	chip->indio_dev->driver_module = THIS_MODULE;
 	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+	if (client->irq) {
+		chip->indio_dev->num_interrupt_lines = 1;
+		chip->indio_dev->event_attrs
+			= &tsl2563_event_attribute_group;
+	}
 	ret = iio_device_register(chip->indio_dev);
 	if (ret)
 		goto fail1;
 
+	if (client->irq) {
+		ret = iio_register_interrupt_line(client->irq,
+						chip->indio_dev,
+						0,
+						IRQF_TRIGGER_RISING,
+						client->name);
+		if (ret)
+			goto fail2;
+	}
 	err = tsl2563_configure(chip);
 	if (err)
-		goto fail2;
+		goto fail3;
 
 	INIT_DELAYED_WORK(&chip->poweroff_work, tsl2563_poweroff_work);
+	/* The interrupt cannot yet be enabled so this is fine without lock */
 	schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
 
 	return 0;
+fail3:
+	if (client->irq)
+		iio_unregister_interrupt_line(chip->indio_dev, 0);
 fail2:
 	iio_device_unregister(chip->indio_dev);
 fail1:
@@ -702,7 +903,15 @@ fail1:
 static int tsl2563_remove(struct i2c_client *client)
 {
 	struct tsl2563_chip *chip = i2c_get_clientdata(client);
-
+	if (!chip->int_enabled)
+		cancel_delayed_work(&chip->poweroff_work);
+	/* Ensure that interrupts are disabled - then flush any bottom halves */
+	chip->intr |= ~0x30;
+	tsl2563_write(chip->client, TSL2563_REG_INT, chip->intr);
+	flush_scheduled_work();
+	tsl2563_set_power(chip, 0);
+	if (client->irq)
+		iio_unregister_interrupt_line(chip->indio_dev, 0);
 	iio_device_unregister(chip->indio_dev);
 
 	i2c_set_clientdata(client, NULL);
-- 
1.7.0.4
