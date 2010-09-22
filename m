Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:58440 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0IVLmi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2010 07:42:38 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/8] staging:iio:adis16350 Add optional event support
Date: Wed, 22 Sep 2010 12:47:49 +0100
Message-Id: <1285156073-6327-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1285156073-6327-1-git-send-email-jic23@cam.ac.uk>
References: <1285156073-6327-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is fairly complex.  The device provides two alarms
which can be configured as rising or falling thresholds
on the magnitude or the rate of change of any channel.

I have made things a little more manageable by restricting
things so you can't set both alarms to the same setting.

This also rolls in some name changes etc to make possible
use of macros for some elements.

Note there is an issue with event codes for ADC channels (there
are now too many of them) that will need fixing before this merges.

Various other minor fixes are also in here.
---
 drivers/staging/iio/adc/adc.h             |    8 +-
 drivers/staging/iio/gyro/gyro.h           |   31 ++-
 drivers/staging/iio/imu/Kconfig           |    7 +
 drivers/staging/iio/imu/Makefile          |    1 +
 drivers/staging/iio/imu/adis16350.h       |   65 +++-
 drivers/staging/iio/imu/adis16350_core.c  |   17 +-
 drivers/staging/iio/imu/adis16350_event.c |  499 +++++++++++++++++++++++++++++
 drivers/staging/iio/imu/adis16350_ring.c  |   12 +-
 drivers/staging/iio/sysfs.h               |   17 +-
 9 files changed, 624 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/adc/adc.h b/drivers/staging/iio/adc/adc.h
index 953b5ce..2cd2ef9 100644
--- a/drivers/staging/iio/adc/adc.h
+++ b/drivers/staging/iio/adc/adc.h
@@ -11,7 +11,7 @@
 
 /* Deprecated */
 #define IIO_DEV_ATTR_ADC(_num, _show, _addr)			\
-  IIO_DEVICE_ATTR(adc_##_num, S_IRUGO, _show, NULL, _addr)
+	IIO_DEVICE_ATTR(adc_##_num, S_IRUGO, _show, NULL, _addr)
 
 #define IIO_DEV_ATTR_IN_RAW(_num, _show, _addr)				\
 	IIO_DEVICE_ATTR(in##_num##_raw, S_IRUGO, _show, NULL, _addr)
@@ -36,3 +36,9 @@
 
 #define IIO_EVENT_CODE_IN_HIGH_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a)
 #define IIO_EVENT_CODE_IN_LOW_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a + 32)
+#define IIO_EVENT_CODE_IN_HIGH_ROC(a) (IIO_EVENT_CODE_ADC_BASE  + a + 64)
+#define IIO_EVENT_CODE_IN_LOW_ROC(a) (IIO_EVENT_CODE_ADC_BASE  + a + 96)
+#define IIO_EVENT_CODE_IN_SUPPLY_HIGH (IIO_EVENT_CODE_ADC_BASE + 97)
+#define IIO_EVENT_CODE_IN_SUPPLY_LOW (IIO_EVENT_CODE_ADC_BASE + 98)
+#define IIO_EVENT_CODE_IN_SUPPLY_ROC_HIGH (IIO_EVENT_CODE_ADC_BASE + 99)
+#define IIO_EVENT_CODE_IN_SUPPLY_ROC_LOW (IIO_EVENT_CODE_ADC_BASE + 100)
diff --git a/drivers/staging/iio/gyro/gyro.h b/drivers/staging/iio/gyro/gyro.h
index 98b837b..aa57f24 100644
--- a/drivers/staging/iio/gyro/gyro.h
+++ b/drivers/staging/iio/gyro/gyro.h
@@ -33,31 +33,31 @@
 #define IIO_DEV_ATTR_GYRO_Z_SCALE(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(gyro_z_scale, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_CALIBBIAS(_mode, _show, _store, _addr)		\
+#define IIO_DEV_ATTR_GYRO_CALIBBIAS(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_calibbias, S_IRUGO, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_X_CALIBBIAS(_mode, _show, _store, _addr)		\
+#define IIO_DEV_ATTR_GYRO_X_CALIBBIAS(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_x_calibbias, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_Y_CALIBBIAS(_mode, _show, _store, _addr)		\
+#define IIO_DEV_ATTR_GYRO_Y_CALIBBIAS(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_y_calibbias, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_Z_CALIBBIAS(_mode, _show, _store, _addr)		\
+#define IIO_DEV_ATTR_GYRO_Z_CALIBBIAS(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_z_calibbias, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_CALIBSCALE(_mode, _show, _store, _addr)		\
+#define IIO_DEV_ATTR_GYRO_CALIBSCALE(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_calibscale, S_IRUGO, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_X_CALIBSCALE(_mode, _show, _store, _addr)		\
+#define IIO_DEV_ATTR_GYRO_X_CALIBSCALE(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_x_calibscale, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_Y_CALIBSCALE(_mode, _show, _store, _addr)		\
+#define IIO_DEV_ATTR_GYRO_Y_CALIBSCALE(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_y_calibscale, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO_Z_CALIBSCALE(_mode, _show, _store, _addr)		\
+#define IIO_DEV_ATTR_GYRO_Z_CALIBSCALE(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(gyro_z_calibscale, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_GYRO(_show, _addr)			\
+#define IIO_DEV_ATTR_GYRO(_show, _addr)				\
 	IIO_DEVICE_ATTR(gyro_raw, S_IRUGO, _show, NULL, _addr)
 
 #define IIO_DEV_ATTR_GYRO_X(_show, _addr)			\
@@ -71,3 +71,16 @@
 
 #define IIO_DEV_ATTR_ANGL(_show, _addr)                         \
 	IIO_DEVICE_ATTR(angl_raw, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_EVENT_CODE_GYRO_X_HIGH (IIO_EVENT_CODE_GYRO_BASE)
+#define IIO_EVENT_CODE_GYRO_X_LOW (IIO_EVENT_CODE_GYRO_BASE + 1)
+#define IIO_EVENT_CODE_GYRO_X_ROC_HIGH (IIO_EVENT_CODE_GYRO_BASE + 2)
+#define IIO_EVENT_CODE_GYRO_X_ROC_LOW (IIO_EVENT_CODE_GYRO_BASE + 3)
+#define IIO_EVENT_CODE_GYRO_Y_HIGH (IIO_EVENT_CODE_GYRO_BASE + 4)
+#define IIO_EVENT_CODE_GYRO_Y_LOW (IIO_EVENT_CODE_GYRO_BASE + 5)
+#define IIO_EVENT_CODE_GYRO_Y_ROC_HIGH (IIO_EVENT_CODE_GYRO_BASE + 6)
+#define IIO_EVENT_CODE_GYRO_Y_ROC_LOW (IIO_EVENT_CODE_GYRO_BASE + 7)
+#define IIO_EVENT_CODE_GYRO_Z_HIGH (IIO_EVENT_CODE_GYRO_BASE + 8)
+#define IIO_EVENT_CODE_GYRO_Z_LOW (IIO_EVENT_CODE_GYRO_BASE + 9)
+#define IIO_EVENT_CODE_GYRO_Z_ROC_HIGH (IIO_EVENT_CODE_GYRO_BASE + 10)
+#define IIO_EVENT_CODE_GYRO_Z_ROC_LOW (IIO_EVENT_CODE_GYRO_BASE + 11)
diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 31a6233..11a4984 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -21,6 +21,13 @@ config ADIS16350
 	  Say yes here to build support for Analog Devices adis16350/54/55/60/62/64/65
 	  high precision tri-axis inertial sensor.
 
+if ADIS16350
+config ADIS16350_EVENT
+       bool "Enable events on the ADIS16350"
+       help
+	 Threshold and rate of change events for all channels.
+endif #ADIS16350
+
 config ADIS16400
 	tristate "Analog Devices ADIS16400/5 IMU SPI driver"
 	depends on SPI
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
index f3b450b..551a20f 100644
--- a/drivers/staging/iio/imu/Makefile
+++ b/drivers/staging/iio/imu/Makefile
@@ -7,6 +7,7 @@ adis16300-$(CONFIG_IIO_RING_BUFFER) += adis16300_ring.o adis16300_trigger.o
 obj-$(CONFIG_ADIS16300) += adis16300.o
 
 adis16350-y             := adis16350_core.o
+adis16350-$(CONFIG_ADIS16350_EVENT) += adis16350_event.o
 adis16350-$(CONFIG_IIO_RING_BUFFER) += adis16350_ring.o adis16350_trigger.o
 obj-$(CONFIG_ADIS16350) += adis16350.o
 
diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
index 07d3eeb..2d8080e 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -108,6 +108,13 @@
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
  * @burst_available:	does the device support burst reading
+ * @event_lock:		protect event state
+ * @event_irq:		irq for event line
+ * @event_timestamp:	local store for time of last event
+ * @work_event:		work struct for event bh
+ * @thresh_cache:	cache of thresholds for all the various alarms
+ * @smpl_cache:		cache of sample period for ROC alarms
+ * @active_alarms:	which alarms are on (in terms of attribute mask)
  **/
 struct adis16350_state {
 	struct spi_device		*us;
@@ -119,23 +126,57 @@ struct adis16350_state {
 	u8				*rx;
 	struct mutex			buf_lock;
 	unsigned int			burst_available:1;
+#ifdef CONFIG_ADIS16350_EVENT
+	struct mutex			event_lock;
+	int				event_irq;
+	s64				event_timestamp;
+	struct work_struct		work_event;
+	s16				thresh_cache[44];
+	u8				smpl_cache[22];
+	int				active_alarms[2];
+	unsigned int			oldest_alarm:1;
+	u8				alarm_on[2];
+#endif
 };
 
 int adis16350_set_irq(struct device *dev, bool enable);
 
-#ifdef CONFIG_IIO_RING_BUFFER
+int adis16350_spi_read_reg_16(struct device *dev,
+			u8 lower_reg_address,
+			u16 *val);
+
+int adis16350_spi_write_reg_16(struct device *dev,
+			u8 lower_reg_address,
+			u16 value);
+
+#ifdef CONFIG_ADIS16350_EVENT
+int adis16350_configure_event_line(struct adis16350_state *st,
+				int interrupt);
+void adis16350_unconfigure_event_line(struct adis16350_state *st);
+#else
+static inline int adis16350_configure_event_line(struct adis16350_state *st,
+						int interrupt)
+{
+	return 0;
+}
+static inline void adis16350_unconfigure_event_line(struct adis16350_state *st)
+{
+}
+#endif
+
+#define ADIS16350_SCAN_IN_SUPPLY	0
+#define ADIS16350_SCAN_GYRO_X		1
+#define ADIS16350_SCAN_GYRO_Y		2
+#define ADIS16350_SCAN_GYRO_Z		3
+#define ADIS16350_SCAN_ACCEL_X		4
+#define ADIS16350_SCAN_ACCEL_Y		5
+#define ADIS16350_SCAN_ACCEL_Z		6
+#define ADIS16350_SCAN_TEMP_X		7
+#define ADIS16350_SCAN_TEMP_Y		8
+#define ADIS16350_SCAN_TEMP_Z		9
+#define ADIS16350_SCAN_IN0		10
 
-#define ADIS16350_SCAN_SUPPLY	0
-#define ADIS16350_SCAN_GYRO_X	1
-#define ADIS16350_SCAN_GYRO_Y	2
-#define ADIS16350_SCAN_GYRO_Z	3
-#define ADIS16350_SCAN_ACC_X	4
-#define ADIS16350_SCAN_ACC_Y	5
-#define ADIS16350_SCAN_ACC_Z	6
-#define ADIS16350_SCAN_TEMP_X	7
-#define ADIS16350_SCAN_TEMP_Y	8
-#define ADIS16350_SCAN_TEMP_Z	9
-#define ADIS16350_SCAN_ADC_0	10
+#ifdef CONFIG_IIO_RING_BUFFER
 
 void adis16350_remove_trigger(struct iio_dev *indio_dev);
 int adis16350_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 5396813..5ccb9aa 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -62,7 +62,7 @@ static int adis16350_spi_write_reg_8(struct device *dev,
  *               is assumed to have address one greater.
  * @val: value to be written
  **/
-static int adis16350_spi_write_reg_16(struct device *dev,
+int adis16350_spi_write_reg_16(struct device *dev,
 		u8 lower_reg_address,
 		u16 value)
 {
@@ -108,7 +108,7 @@ static int adis16350_spi_write_reg_16(struct device *dev,
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
  **/
-static int adis16350_spi_read_reg_16(struct device *dev,
+int adis16350_spi_read_reg_16(struct device *dev,
 		u8 lower_reg_address,
 		u16 *val)
 {
@@ -641,13 +641,22 @@ static int __devinit adis16350_probe(struct spi_device *spi)
 		if (ret)
 			goto error_uninitialize_ring;
 	}
-
+	/* The event irq */
+	if (spi->dev.platform_data) {
+		ret = adis16350_configure_event_line(st,
+						*(int *)spi->dev.platform_data);
+		if (ret)
+			goto error_remove_trigger;
+	}
 	/* Get the device into a sane initial state */
 	ret = adis16350_initial_setup(st);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_unregister_event_line;
+
 	return 0;
 
+error_unregister_event_line:
+	adis16350_unconfigure_event_line(st);
 error_remove_trigger:
 	if (spi->irq)
 		adis16350_remove_trigger(st->indio_dev);
diff --git a/drivers/staging/iio/imu/adis16350_event.c b/drivers/staging/iio/imu/adis16350_event.c
new file mode 100644
index 0000000..116ace8
--- /dev/null
+++ b/drivers/staging/iio/imu/adis16350_event.c
@@ -0,0 +1,499 @@
+/*
+ * ADIS16350/54/55/60/62/64/65 high precision tri-axis inertial sensor
+ * event support.
+ *
+ * Copyright 2010 Jonathan Cameron <jic23@cam.ac.uk>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../accel/accel.h"
+#include "../adc/adc.h"
+#include "../gyro/gyro.h"
+
+#include "adis16350.h"
+
+#define ADIS16350_EV_ROC 0x40
+#define ADIS16350_EV_FALLING 0x80
+
+/* Short cut taken: we disable everything and setup from scatch */
+static int adis16350_update_alarms(struct adis16350_state *st,
+			struct device *dev)
+{
+	u16 regval = 0, temp;
+	int ret, i, loc, loc_sp;
+
+	ret = adis16350_spi_read_reg_16(dev,
+					ADIS16350_ALM_CTRL,
+					&regval);
+	regval &= 0x3;
+	if (ret)
+		goto error_ret;
+	ret = adis16350_spi_write_reg_16(dev,
+					ADIS16350_ALM_CTRL,
+					regval);
+	if (ret)
+		goto error_ret;
+	for (i = 0; i < 2; i++)
+		if (st->alarm_on[i]) {
+			regval |= ((st->active_alarms[i] & 0xF) + 1)
+				<< (8 + i * 4);
+			regval |= (!!(st->active_alarms[i] & ADIS16350_EV_ROC))
+				<< (6 + i);
+			regval |= (1 << 2);
+			loc = 4*(st->active_alarms[i] & 0x3f) +
+				2*!!(st->active_alarms[i] &
+					ADIS16350_EV_ROC) +
+				!!(st->active_alarms[i] &
+					ADIS16350_EV_FALLING);
+			temp = (st->thresh_cache[loc] & 0xFFF) |
+				(!(st->active_alarms[i] &
+					ADIS16350_EV_FALLING) << 15);
+			ret = adis16350_spi_write_reg_16(dev,
+							i ?
+							ADIS16350_ALM_MAG2 :
+							ADIS16350_ALM_MAG1,
+							temp);
+			if (ret)
+				goto error_ret;
+			if (st->active_alarms[i] & ADIS16350_EV_ROC) {
+				loc_sp = 2*(st->active_alarms[i] & 0x3f) +
+					!!(st->active_alarms[i] &
+						ADIS16350_EV_FALLING);
+				ret = adis16350_spi_write_reg_16(dev,
+							i ?
+							ADIS16350_ALM_SMPL2 :
+							ADIS16350_ALM_SMPL1,
+							st->smpl_cache[loc_sp]);
+				if (ret)
+					goto error_ret;
+			}
+		}
+	if (st->alarm_on[0] || st->alarm_on[1])
+		ret = adis16350_spi_write_reg_16(dev,
+						ADIS16350_ALM_CTRL,
+						regval);
+error_ret:
+	return ret;
+}
+
+static ssize_t adis16350_read_interrupt_config(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+	int enabled = 0;
+
+	mutex_lock(&st->event_lock);
+	if (st->alarm_on[0] && this_attr->mask == st->active_alarms[0])
+		enabled = 1;
+	if (st->alarm_on[1] && this_attr->mask == st->active_alarms[1])
+		enabled = 1;
+	mutex_unlock(&st->event_lock);
+
+	return sprintf(buf, "%d\n", enabled);
+}
+
+static ssize_t adis16350_write_interrupt_config(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len)
+{
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+	bool enable;
+	int i, ret = 0;
+
+	enable = !(buf[0] == '0');
+	mutex_lock(&st->event_lock);
+	/* First verify this one isn't already in use */
+	for (i = 0; i < 2; i++)
+		if (st->alarm_on[i] &&
+			(this_attr->mask == st->active_alarms[i])) {
+			if (!enable) {
+				st->alarm_on[i] = 0;
+				st->oldest_alarm = i;
+				iio_remove_event_from_list(this_attr->listel,
+							&indio_dev
+							->interrupts[0]
+							->ev_list);
+				goto update;
+			}
+	goto done;
+}
+/* Replace the cache of what should be running */
+
+	st->alarm_on[st->oldest_alarm] = 1;
+	st->active_alarms[st->oldest_alarm] = this_attr->mask;
+	st->oldest_alarm = !st->oldest_alarm;
+	iio_add_event_to_list(this_attr->listel,
+			&indio_dev->interrupts[0]->ev_list);
+
+update:
+	ret = adis16350_update_alarms(st, dev);
+done:
+	mutex_unlock(&st->event_lock);
+	return ret ? ret : len;
+}
+
+static int adis16350_thresh_handler_th(struct iio_dev *dev_info,
+				int index,
+				s64 timestamp,
+				int no_test)
+{
+	struct adis16350_state *st = iio_dev_get_devdata(dev_info);
+
+	st->event_timestamp = timestamp;
+	schedule_work(&st->work_event);
+
+	return IRQ_HANDLED;
+}
+
+IIO_EVENT_SH(threshold, &adis16350_thresh_handler_th);
+#define ADIS16350_EV(name, channel)				\
+	IIO_EVENT_ATTR_SH(name,					\
+			iio_event_threshold,			\
+			adis16350_read_interrupt_config,	\
+			adis16350_write_interrupt_config,	\
+			channel)
+
+static ssize_t adis16350_read_thresh(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int loc = 4*(this_attr->address & 0x3f) +
+		2*!!(this_attr->address & ADIS16350_EV_ROC) +
+		!!(this_attr->address & ADIS16350_EV_FALLING);
+
+	return sprintf(buf, "%d\n", st->thresh_cache[loc]);
+}
+
+static ssize_t adis16350_write_thresh(struct device *dev,
+				struct device_attribute *attr,
+				s16 valin)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int loc, i, ret;
+
+	loc = 4*(this_attr->address & 0x3f) +
+		2*!!(this_attr->address & ADIS16350_EV_ROC) +
+		!!(this_attr->address & ADIS16350_EV_FALLING);
+
+
+	st->thresh_cache[loc] = valin;
+
+	/* verify if this alarm is in use and update if it is */
+	for (i = 0; i < 2; i++)
+		if (st->alarm_on[i] &&
+			st->active_alarms[i] == this_attr->address) {
+			ret = adis16350_spi_write_reg_16(dev,
+							i ?
+							ADIS16350_ALM_MAG2 :
+							ADIS16350_ALM_MAG1,
+							st->thresh_cache[loc]);
+			if (ret)
+				return ret;
+		}
+
+	return 0;
+}
+
+static ssize_t adis16350_write_thresh_u12(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	unsigned long valin;
+	int ret;
+	ret = strict_strtoul(buf, 10, &valin);
+	if (ret)
+		return ret;
+	if (valin > 0xfff)
+		return -EINVAL;
+	ret = adis16350_write_thresh(dev, attr, valin);
+
+	return ret ? ret : len;
+}
+
+static ssize_t adis16350_write_thresh_s12(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	long valin;
+	int ret;
+	ret = strict_strtol(buf, 10, &valin);
+	if (ret)
+		return ret;
+	if (valin > 2047 || valin < -2048)
+		return -EINVAL;
+	ret = adis16350_write_thresh(dev, attr, valin);
+
+	return ret ? ret : len;
+}
+
+static ssize_t adis16350_write_thresh_s14(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	long valin;
+	int ret;
+	ret = strict_strtol(buf, 10, &valin);
+	if (ret)
+		return ret;
+	if (valin > 8191 || valin < -8192)
+		return -EINVAL;
+	ret = adis16350_write_thresh(dev, attr, valin);
+
+	return ret ? ret : len;
+}
+
+/* For now this is in samples used  - may need to rethink things */
+static ssize_t adis16350_read_sampl(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int loc;
+	loc = 2*(this_attr->address & 0x3f) +
+		!!(this_attr->address & ADIS16350_EV_FALLING);
+
+	return sprintf(buf, "%u\n", st->smpl_cache[loc]);
+}
+
+static ssize_t adis16350_write_sampl(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned long val;
+	int loc, ret, i;
+
+	loc = 2*(this_attr->address & 0x3f) +
+		!!(this_attr->address & ADIS16350_EV_FALLING);
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	if (val > 0xff)
+		return -EINVAL;
+
+	st->smpl_cache[loc] = val;
+
+	/* verify if this alarm is in use and update if it is */
+	for (i = 0; i < 2; i++)
+		if (st->alarm_on[i] &&
+			st->active_alarms[i] == this_attr->address) {
+			ret = adis16350_spi_write_reg_16(dev,
+							i ?
+							ADIS16350_ALM_SMPL2 :
+							ADIS16350_ALM_SMPL1,
+							st->smpl_cache[loc]);
+			if (ret)
+				goto error_ret;
+		}
+error_ret:
+	return ret ? ret : len;
+}
+
+#define ADIS16350_EV_PAIR_THRESH(name, channel, type)			\
+	ADIS16350_EV(name ## _thresh_rising_en, channel);		\
+	static IIO_DEVICE_ATTR(name ## _thresh_rising_value,		\
+			S_IWUSR | S_IRUGO,				\
+			adis16350_read_thresh,				\
+			adis16350_write_thresh_##type,			\
+			channel);					\
+	ADIS16350_EV(name ## _thresh_falling_en,			\
+		channel | ADIS16350_EV_FALLING);			\
+	static IIO_DEVICE_ATTR(name ## _thresh_falling_value,		\
+			S_IWUSR | S_IRUGO,				\
+			adis16350_read_thresh,				\
+			adis16350_write_thresh_##type,			\
+			channel | ADIS16350_EV_FALLING);
+
+#define ADIS16350_EV_PAIR_ROC(name, channel, type)			\
+	ADIS16350_EV(name ## _roc_rising_en,				\
+		channel | ADIS16350_EV_ROC);				\
+	static IIO_DEVICE_ATTR(name ## _roc_rising_value,		\
+			S_IWUSR | S_IRUGO,				\
+			adis16350_read_thresh,				\
+			adis16350_write_thresh_##type,			\
+			channel | ADIS16350_EV_ROC);			\
+	static IIO_DEVICE_ATTR(name ## _roc_rising_period,		\
+			S_IWUSR | S_IRUGO,				\
+			adis16350_read_sampl,				\
+			adis16350_write_sampl,				\
+			channel | ADIS16350_EV_ROC);			\
+	ADIS16350_EV(name ## _roc_falling_en,				\
+		channel | ADIS16350_EV_FALLING | ADIS16350_EV_ROC);	\
+	static IIO_DEVICE_ATTR(name ## _roc_falling_value,		\
+			S_IWUSR | S_IRUGO,				\
+			adis16350_read_thresh,				\
+			adis16350_write_thresh_##type,			\
+			channel | ADIS16350_EV_FALLING | ADIS16350_EV_ROC); \
+	static IIO_DEVICE_ATTR(name ## _roc_falling_period,		\
+			S_IWUSR | S_IRUGO,				\
+			adis16350_read_sampl,				\
+			adis16350_write_sampl,				\
+			channel | ADIS16350_EV_FALLING | ADIS16350_EV_ROC);
+
+#define ADIS16350_EV_QUAD(name, channel, type)				\
+	ADIS16350_EV_PAIR_THRESH(name, channel, type);			\
+	ADIS16350_EV_PAIR_ROC(name, channel, type);
+
+ADIS16350_EV_QUAD(in_supply, ADIS16350_SCAN_IN_SUPPLY, u12);
+ADIS16350_EV_QUAD(gyro_x, ADIS16350_SCAN_GYRO_X, s14);
+ADIS16350_EV_QUAD(gyro_y, ADIS16350_SCAN_GYRO_Y, s14);
+ADIS16350_EV_QUAD(gyro_z, ADIS16350_SCAN_GYRO_Z, s14);
+ADIS16350_EV_QUAD(accel_x, ADIS16350_SCAN_ACCEL_X, s14);
+ADIS16350_EV_QUAD(accel_y, ADIS16350_SCAN_ACCEL_Y, s14);
+ADIS16350_EV_QUAD(accel_z, ADIS16350_SCAN_ACCEL_Z, s14);
+ADIS16350_EV_QUAD(temp_x, ADIS16350_SCAN_TEMP_X, s12);
+ADIS16350_EV_QUAD(temp_y, ADIS16350_SCAN_TEMP_Y, s12);
+ADIS16350_EV_QUAD(temp_z, ADIS16350_SCAN_TEMP_Z, s12);
+ADIS16350_EV_QUAD(in0, ADIS16350_SCAN_IN0, u12);
+
+#define adis16350_ev_attrs(name)					\
+	&iio_event_attr_ ## name ##_thresh_rising_en.dev_attr.attr,	\
+	&iio_dev_attr_ ## name ## _thresh_rising_value.dev_attr.attr,	\
+	&iio_event_attr_ ## name ## _thresh_falling_en.dev_attr.attr,	\
+	&iio_dev_attr_ ## name ## _thresh_falling_value.dev_attr.attr,	\
+	&iio_event_attr_ ## name ## _roc_rising_en.dev_attr.attr,	\
+	&iio_dev_attr_ ## name ## _roc_rising_value.dev_attr.attr,	\
+	&iio_dev_attr_ ## name ## _roc_rising_period.dev_attr.attr,	\
+	&iio_event_attr_ ## name ## _roc_falling_en.dev_attr.attr,	\
+	&iio_dev_attr_ ## name ## _roc_falling_value.dev_attr.attr,	\
+	&iio_dev_attr_ ## name ## _roc_falling_period.dev_attr.attr
+
+static struct attribute *adis16350_event_attributes[] = {
+	adis16350_ev_attrs(in_supply),
+	adis16350_ev_attrs(gyro_x),
+	adis16350_ev_attrs(gyro_y),
+	adis16350_ev_attrs(gyro_z),
+	adis16350_ev_attrs(accel_x),
+	adis16350_ev_attrs(accel_y),
+	adis16350_ev_attrs(accel_z),
+	adis16350_ev_attrs(temp_x),
+	adis16350_ev_attrs(temp_y),
+	adis16350_ev_attrs(temp_z),
+	adis16350_ev_attrs(in0),
+	NULL,
+};
+
+static struct attribute_group adis16350_event_attribute_group = {
+	.attrs = adis16350_event_attributes,
+};
+
+#define ADIS16350_EV_CASES(type)					\
+	case ADIS16350_SCAN_##type:					\
+	ev_code = IIO_EVENT_CODE_##type##_HIGH;				\
+	break;								\
+	case ADIS16350_SCAN_##type | ADIS16350_EV_FALLING:		\
+	ev_code = IIO_EVENT_CODE_##type##_LOW;				\
+	break;								\
+	case ADIS16350_SCAN_##type | ADIS16350_EV_ROC:			\
+	ev_code = IIO_EVENT_CODE_##type##_ROC_HIGH;			\
+	break;								\
+	case (ADIS16350_SCAN_##type | ADIS16350_EV_FALLING |		\
+		ADIS16350_EV_ROC):					\
+	ev_code = IIO_EVENT_CODE_##type##_ROC_LOW;			\
+	break;
+
+static void adis16350_event_handler_bh(struct work_struct *work_s)
+{
+	struct adis16350_state *st
+		= container_of(work_s,
+			struct adis16350_state, work_event);
+	int ret, ev_code = 0;
+	u16 status;
+	int i;
+	/* Find out which alarm is triggered */
+	ret = adis16350_spi_read_reg_16(&st->indio_dev->dev,
+					ADIS16350_DIAG_STAT, &status);
+	if (ret)
+		dev_err(&st->indio_dev->dev, "Reading status failed\n");
+	for (i = 0; i < 2; i++)
+		if (status & (1 << (8 + i))) {
+			switch (st->active_alarms[i]) {
+			case ADIS16350_SCAN_IN0:
+				ev_code = IIO_EVENT_CODE_IN_HIGH_THRESH(0);
+				break;
+			case ADIS16350_SCAN_IN0 | ADIS16350_EV_FALLING:
+				ev_code = IIO_EVENT_CODE_IN_LOW_THRESH(0);
+				break;
+			case ADIS16350_SCAN_IN0 | ADIS16350_EV_ROC:
+				ev_code = IIO_EVENT_CODE_IN_HIGH_ROC(0);
+				break;
+			case (ADIS16350_SCAN_IN0 | ADIS16350_EV_FALLING |
+				ADIS16350_EV_ROC):
+				ev_code = IIO_EVENT_CODE_IN_LOW_ROC(0);
+				break;
+				ADIS16350_EV_CASES(IN_SUPPLY);
+				ADIS16350_EV_CASES(ACCEL_X);
+				ADIS16350_EV_CASES(ACCEL_Y);
+				ADIS16350_EV_CASES(ACCEL_Z);
+				ADIS16350_EV_CASES(GYRO_X);
+				ADIS16350_EV_CASES(GYRO_Y);
+				ADIS16350_EV_CASES(GYRO_Z);
+				ADIS16350_EV_CASES(TEMP_X);
+				ADIS16350_EV_CASES(TEMP_Y);
+				ADIS16350_EV_CASES(TEMP_Z);
+			default:
+				BUG_ON("unknown event");
+			}
+			iio_push_event(st->indio_dev,
+				0,
+				ev_code,
+				st->event_timestamp);
+		}
+
+	enable_irq(st->event_irq);
+}
+
+int adis16350_configure_event_line(struct adis16350_state *st, int interrupt)
+{
+	if (!st->event_irq)
+		return 0;
+
+	INIT_WORK(&st->work_event, adis16350_event_handler_bh);
+	mutex_init(&st->event_lock);
+	st->event_irq = interrupt;
+	st->indio_dev->event_attrs = &adis16350_event_attribute_group;
+	st->indio_dev->num_interrupt_lines = 1;
+
+	return iio_register_interrupt_line(st->event_irq,
+					st->indio_dev,
+					0,
+					IRQF_TRIGGER_RISING,
+					"adis16350_ev");
+}
+
+void adis16350_unconfigure_event_line(struct adis16350_state *st)
+{
+	if (st->event_irq)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+}
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index 5d6363c..a341e82 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -17,8 +17,8 @@
 #include "../trigger.h"
 #include "adis16350.h"
 
-static IIO_SCAN_EL_C(in_supply, ADIS16350_SCAN_SUPPLY,
-		ADIS16350_SUPPLY_OUT, NULL);
+static IIO_SCAN_EL_C(in_supply, ADIS16350_SCAN_IN_SUPPLY,
+		     ADIS16350_SUPPLY_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in_supply, u, 12, 16);
 
 static IIO_SCAN_EL_C(gyro_x, ADIS16350_SCAN_GYRO_X, ADIS16350_XGYRO_OUT, NULL);
@@ -26,9 +26,9 @@ static IIO_SCAN_EL_C(gyro_y, ADIS16350_SCAN_GYRO_Y, ADIS16350_YGYRO_OUT, NULL);
 static IIO_SCAN_EL_C(gyro_z, ADIS16350_SCAN_GYRO_Z, ADIS16350_ZGYRO_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(gyro, s, 14, 16);
 
-static IIO_SCAN_EL_C(accel_x, ADIS16350_SCAN_ACC_X, ADIS16350_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16350_SCAN_ACC_Y, ADIS16350_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_z, ADIS16350_SCAN_ACC_Z, ADIS16350_ZACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_x, ADIS16350_SCAN_ACCEL_X, ADIS16350_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16350_SCAN_ACCEL_Y, ADIS16350_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_z, ADIS16350_SCAN_ACCEL_Z, ADIS16350_ZACCL_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(accel, s, 14, 16);
 
 static IIO_SCAN_EL_C(temp_x, ADIS16350_SCAN_TEMP_X, ADIS16350_XTEMP_OUT, NULL);
@@ -36,7 +36,7 @@ static IIO_SCAN_EL_C(temp_y, ADIS16350_SCAN_TEMP_Y, ADIS16350_YTEMP_OUT, NULL);
 static IIO_SCAN_EL_C(temp_z, ADIS16350_SCAN_TEMP_Z, ADIS16350_ZTEMP_OUT, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(temp, s, 12, 16);
 
-static IIO_SCAN_EL_C(in0, ADIS16350_SCAN_ADC_0, ADIS16350_AUX_ADC, NULL);
+static IIO_SCAN_EL_C(in0, ADIS16350_SCAN_IN0, ADIS16350_AUX_ADC, NULL);
 static IIO_CONST_ATTR_SCAN_EL_TYPE(in0, u, 12, 16);
 
 static IIO_SCAN_EL_TIMESTAMP(11);
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index b531dc1..bd3edd4 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -63,7 +63,7 @@ struct iio_const_attr {
 	container_of(_dev_attr, struct iio_const_attr, dev_attr)
 
 /* Some attributes will be hard coded (device dependent) and not require an
-   address, in these cases pass a negative */
+ * address, in these cases pass a negative */
 #define IIO_ATTR(_name, _mode, _show, _store, _addr)		\
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
 	  .address = _addr }
@@ -256,8 +256,23 @@ struct iio_const_attr {
 #define IIO_EVENT_CODE_ADC_BASE		500
 #define IIO_EVENT_CODE_MISC_BASE	600
 #define IIO_EVENT_CODE_LIGHT_BASE	700
+#define IIO_EVENT_CODE_TEMP_BASE	800
 
 #define IIO_EVENT_CODE_DEVICE_SPECIFIC	1000
+/* Can we make these a little more predictable rather than
+ * just adding new ones when they turn up? */
+#define IIO_EVENT_CODE_TEMP_X_HIGH (IIO_EVENT_CODE_TEMP_BASE)
+#define IIO_EVENT_CODE_TEMP_X_LOW (IIO_EVENT_CODE_TEMP_BASE + 1)
+#define IIO_EVENT_CODE_TEMP_X_ROC_HIGH (IIO_EVENT_CODE_TEMP_BASE + 2)
+#define IIO_EVENT_CODE_TEMP_X_ROC_LOW (IIO_EVENT_CODE_TEMP_BASE + 3)
+#define IIO_EVENT_CODE_TEMP_Y_HIGH (IIO_EVENT_CODE_TEMP_BASE + 4)
+#define IIO_EVENT_CODE_TEMP_Y_LOW (IIO_EVENT_CODE_TEMP_BASE + 5)
+#define IIO_EVENT_CODE_TEMP_Y_ROC_HIGH (IIO_EVENT_CODE_TEMP_BASE + 6)
+#define IIO_EVENT_CODE_TEMP_Y_ROC_LOW (IIO_EVENT_CODE_TEMP_BASE + 7)
+#define IIO_EVENT_CODE_TEMP_Z_HIGH (IIO_EVENT_CODE_TEMP_BASE + 8)
+#define IIO_EVENT_CODE_TEMP_Z_LOW (IIO_EVENT_CODE_TEMP_BASE + 9)
+#define IIO_EVENT_CODE_TEMP_Z_ROC_HIGH (IIO_EVENT_CODE_TEMP_BASE + 10)
+#define IIO_EVENT_CODE_TEMP_Z_ROC_LOW (IIO_EVENT_CODE_TEMP_BASE + 11)
 
 /**
  * IIO_EVENT_ATTR_RING_50_FULL - ring buffer event to indicate 50% full
-- 
1.7.2.2

