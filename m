Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33128 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbcFKS5U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 14:57:20 -0400
From: Azael Avalos <coproscefalo@gmail.com>
To: Darren Hart <dvhart@infradead.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Azael Avalos <coproscefalo@gmail.com>
Subject: [PATCH 1/3] toshiba_acpi: Add IIO interface for accelerometer axis data
Date: Sat, 11 Jun 2016 12:57:10 -0600
Message-Id: <20160611185710.14234-1-coproscefalo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the accelerometer axis data to the IIO subsystem.

Currently reporting the X, Y and Z values, as no other data can be
queried given the fact that the accelerometer chip itself is hidden
behind the Toshiba proprietary interface.

Signed-off-by: Azael Avalos <coproscefalo@gmail.com>
---
All:
 This is my first attempt with the IIO subsysem, I'll be looking
 forward for your valuable input on this.

Darren:
 There's a warning about more than 80 columns on this patch, once
 I get feedback from the IIO guys I'll respin this with that issue
 corrected.

 drivers/platform/x86/toshiba_acpi.c | 130 ++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 01e12d2..85014a3 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -53,6 +53,7 @@
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/rfkill.h>
+#include <linux/iio/iio.h>
 #include <linux/toshiba.h>
 #include <acpi/video.h>
 
@@ -134,6 +135,7 @@ MODULE_LICENSE("GPL");
 
 /* Field definitions */
 #define HCI_ACCEL_MASK			0x7fff
+#define HCI_ACCEL_DIRECTION_MASK	0x8000
 #define HCI_HOTKEY_DISABLE		0x0b
 #define HCI_HOTKEY_ENABLE		0x09
 #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
@@ -178,6 +180,7 @@ struct toshiba_acpi_dev {
 	struct led_classdev eco_led;
 	struct miscdevice miscdev;
 	struct rfkill *wwan_rfk;
+	struct iio_dev *indio_dev;
 
 	int force_fan;
 	int last_key_event;
@@ -1962,8 +1965,8 @@ static ssize_t position_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	struct toshiba_acpi_dev *toshiba = dev_get_drvdata(dev);
-	u32 xyval, zval, tmp;
-	u16 x, y, z;
+	u32 xyval, zval;
+	int x, y, z;
 	int ret;
 
 	xyval = zval = 0;
@@ -1971,10 +1974,14 @@ static ssize_t position_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	/* Accelerometer values */
 	x = xyval & HCI_ACCEL_MASK;
-	tmp = xyval >> HCI_MISC_SHIFT;
-	y = tmp & HCI_ACCEL_MASK;
+	y = (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_MASK;
 	z = zval & HCI_ACCEL_MASK;
+	/* Movement direction */
+	x *= xyval & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
+	y *= (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
+	z *= zval & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
 
 	return sprintf(buf, "%d %d %d\n", x, y, z);
 }
@@ -2420,6 +2427,94 @@ static void toshiba_acpi_kbd_bl_work(struct work_struct *work)
 }
 
 /*
+ * IIO device
+ */
+
+enum toshiba_accel_chan {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z
+};
+
+static int toshiba_accel_get_axis(enum toshiba_accel_chan chan)
+{
+	u32 xyval, zval;
+	int x, y, z;
+	int ret;
+
+	xyval = zval = 0;
+	ret = toshiba_accelerometer_get(toshiba_acpi, &xyval, &zval);
+	if (ret < 0)
+		return ret;
+
+	/* Accelerometer values */
+	x = xyval & HCI_ACCEL_MASK;
+	y = (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_MASK;
+	z = zval & HCI_ACCEL_MASK;
+	/* Movement direction */
+	x *= xyval & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
+	y *= (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
+	z *= zval & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
+
+	switch (chan) {
+	case AXIS_X:
+		ret = x;
+		break;
+	case AXIS_Y:
+		ret = y;
+		break;
+	case AXIS_Z:
+		ret = z;
+		break;
+	}
+
+	return ret;
+}
+
+static int toshiba_accel_read_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  int *val, int *val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		ret = toshiba_accel_get_axis(chan->scan_index);
+		if (ret == -EIO || ret == -ENODEV)
+			return ret;
+
+		*val = ret;
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+#define TOSHIBA_ACCEL_CHANNEL(axis, chan) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_##axis, \
+	.output = 1, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.scan_index = chan, \
+}
+
+static const struct iio_chan_spec toshiba_accel_channels[] = {
+	TOSHIBA_ACCEL_CHANNEL(X, AXIS_X),
+	TOSHIBA_ACCEL_CHANNEL(Y, AXIS_Y),
+	TOSHIBA_ACCEL_CHANNEL(Z, AXIS_Z),
+};
+
+static const struct iio_info toshiba_accel_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &toshiba_accel_read_raw,
+};
+
+/*
  * Misc device
  */
 static int toshiba_acpi_smm_bridge(SMMRegisters *regs)
@@ -2903,6 +2998,11 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 	misc_deregister(&dev->miscdev);
 
 	remove_toshiba_proc_entries(dev);
+
+	if (dev->accelerometer_supported) {
+		iio_device_unregister(dev->indio_dev);
+		iio_device_free(dev->indio_dev);
+	}
 
 	if (dev->sysfs_created)
 		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
@@ -3051,6 +3151,28 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	dev->touchpad_supported = !ret;
 
 	toshiba_accelerometer_available(dev);
+	if (dev->accelerometer_supported) {
+		dev->indio_dev = iio_device_alloc(sizeof(*dev));
+		if (!dev->indio_dev)
+			return -ENOMEM;
+
+		pr_info("Registering Toshiba accelerometer iio device\n");
+
+		dev->indio_dev->info = &toshiba_accel_info;
+		dev->indio_dev->name = "Toshiba accelerometer";
+		dev->indio_dev->dev.parent = &acpi_dev->dev;
+		dev->indio_dev->modes = INDIO_DIRECT_MODE;
+		dev->indio_dev->channels = toshiba_accel_channels;
+		dev->indio_dev->num_channels = ARRAY_SIZE(toshiba_accel_channels);
+
+		ret = iio_device_register(dev->indio_dev);
+		if (ret < 0) {
+			pr_err("Unable to register iio device\n");
+			iio_device_free(dev->indio_dev);
+		}
+
+		iio_device_set_drvdata(dev->indio_dev, dev);
+	}
 
 	toshiba_usb_sleep_charge_available(dev);
 
-- 
2.8.3

