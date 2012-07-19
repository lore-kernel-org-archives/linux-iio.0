Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jkosina@suse.cz,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 5/9] HID-Sensors: Common attribute and trigger
Date: Thu, 19 Jul 2012 11:17:27 -0700
Message-Id: <1342721851-2655-6-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1342721851-2655-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1342721851-2655-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch contains the common code, which is used by all HID sensors.
There are some common set of attributes, which every hid sensor
needs it. This patch contains all such attributes processing.
Also the trigger interface is common among all HID sensors. This
patch contains common trigger functions utilized by all HID sensors.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/iio/Kconfig                                |    1 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/common/Kconfig                         |    6 +
 drivers/iio/common/Makefile                        |    9 +
 drivers/iio/common/hid-sensors/Kconfig             |   26 ++
 drivers/iio/common/hid-sensors/Makefile            |    6 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  277 ++++++++++++++++++++
 .../iio/common/hid-sensors/hid-sensor-attributes.h |   58 ++++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  103 ++++++++
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |   25 ++
 10 files changed, 512 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iio/common/Kconfig
 create mode 100644 drivers/iio/common/Makefile
 create mode 100644 drivers/iio/common/hid-sensors/Kconfig
 create mode 100644 drivers/iio/common/hid-sensors/Makefile
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-trigger.c
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-trigger.h

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index df0c23a..61646c7 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -56,5 +56,6 @@ config IIO_CONSUMERS_PER_TRIGGER
 
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
+source "drivers/iio/common/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 8244bab..db0a043 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 
 obj-y += adc/
 obj-y += amplifiers/
+obj-y += common/
diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
new file mode 100644
index 0000000..97ef666
--- /dev/null
+++ b/drivers/iio/common/Kconfig
@@ -0,0 +1,6 @@
+#
+# IIO common modules
+#
+
+source "drivers/iio/common/hid-sensors/Kconfig"
+
diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
new file mode 100644
index 0000000..8158400
--- /dev/null
+++ b/drivers/iio/common/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for the IIO common modules.
+# Common modules contains modules, which can be shared among multiple
+# IIO modules. For example if the trigger processing is common for
+# multiple IIO modules then this can be moved to a common module
+# instead of duplicating in each module.
+#
+
+obj-y += hid-sensors/
diff --git a/drivers/iio/common/hid-sensors/Kconfig b/drivers/iio/common/hid-sensors/Kconfig
new file mode 100644
index 0000000..8e63d81
--- /dev/null
+++ b/drivers/iio/common/hid-sensors/Kconfig
@@ -0,0 +1,26 @@
+#
+# Hid Sensor common modules
+#
+menu "Hid Sensor IIO Common"
+
+config HID_SENSOR_IIO_COMMON
+	tristate "Common modules for all HID Sensor IIO drivers"
+	depends on HID_SENSOR_HUB
+	select IIO_TRIGGER if IIO_BUFFER
+	help
+	  Say yes here to build support for HID sensor to use
+	  HID sensor common processing for attributes and IIO triggers.
+	  There are many attributes which can be shared among multiple
+	  HID sensor drivers, this module contains processing for those
+	  attributes.
+
+config HID_SENSOR_ENUM_BASE_QUIRKS
+	tristate "ENUM base quirks for HID Sensor IIO drivers"
+	depends on HID_SENSOR_IIO_COMMON
+	help
+	  Say yes here to build support for sensor hub FW using
+	  enumeration, which is using 1 as base instead of 0.
+	  Since logical minimum is still set 0 instead of 1,
+	  there is no easy way to differentiate.
+
+endmenu
diff --git a/drivers/iio/common/hid-sensors/Makefile b/drivers/iio/common/hid-sensors/Makefile
new file mode 100644
index 0000000..1f463e0
--- /dev/null
+++ b/drivers/iio/common/hid-sensors/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the Hid sensor common modules.
+#
+
+obj-$(CONFIG_HID_SENSOR_IIO_COMMON) += hid-sensor-iio-common.o
+hid-sensor-iio-common-y := hid-sensor-attributes.o hid-sensor-trigger.o
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
new file mode 100644
index 0000000..1c121fa
--- /dev/null
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -0,0 +1,277 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/hid-sensor-hub.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include "hid-sensor-attributes.h"
+
+static void set_bit_range(u32 *num, int start, int end)
+{
+	int i;
+	for (i = start; i < end+1; ++i)
+		*num |= BIT(i);
+}
+
+static int pow(u32 val, int power)
+{
+	int i;
+	int ret = 1;
+	for (i = 0; i < power; ++i)
+		ret = ret * val;
+
+	return ret;
+}
+
+static void single_prec_div(int dividend, int divisor, int *whole,
+				int *micro_frac)
+{
+	int rem;
+	int exp = 0;
+
+	*micro_frac = 0;
+	if (divisor == 0) {
+		*whole = 0;
+		return;
+	}
+	*whole = dividend/divisor;
+	rem = dividend % divisor;
+	if (rem) {
+		while (rem <= divisor) {
+			rem *= 10;
+			exp++;
+		}
+		*micro_frac = (rem / divisor) * pow(10, 6 - exp);
+	}
+}
+
+static u32 hex_to_dec_integer(u32 value)
+{
+	unsigned int mask = 0xF;
+	unsigned int ret = 0;
+	unsigned int val;
+	int i, j;
+
+	for (i = 0, j = 0; i < sizeof(value)*2; i += 4, ++j) {
+		val = (value & mask) >> i;
+		if (val)
+			ret = ret + val * pow(16, j);
+		mask = mask << 4;
+	}
+
+	return ret;
+}
+
+static void split_micro_fraction(unsigned int no, int exp, int *val1, int *val2)
+{
+	*val1 = no/pow(10, exp);
+	*val2 = no%pow(10, exp) * pow(10, 6-exp);
+}
+
+/*
+VTF format uses exponent and variable size format.
+For example if the size is 2 bytes
+0x0067 with VTF16E14 format -> +1.03
+To convert just change to 0x67 to decimal and use two decimal as E14 stands
+for 10^-2.
+For negative numbers subtract number from 0xFFFF for two bytes and add 1
+0xFFF4 with VTF16E14 format -> -0.12
+So here FFFF-FFF4+1 = 0x0c = 12. With two decimal and sign, it will be -0.12
+*/
+static void convert_from_vtf_format(u32 value, int size, int exp,
+					int *val1, int *val2)
+{
+	u32 val = value;
+	u32 mask = 0;
+	int sign = 1;
+
+	if (value & BIT(size*8-1)) {
+		set_bit_range(&mask, 0, size*8-1);
+		val = mask-value+1;
+		sign = -1;
+	}
+	exp = hid_sensor_convert_exponent(exp);
+	if (exp >= 0) {
+		*val1 = sign * val * pow(10, exp);
+		*val2 = 0;
+	} else {
+		val = hex_to_dec_integer(val);
+		split_micro_fraction(val, -exp, val1, val2);
+		if (*val1)
+			*val1 = sign * (*val1);
+		else
+			*val2 = sign * (*val2);
+	}
+}
+
+static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
+{
+	u32 value = 0;
+	u32 mask = 0;
+	int sign = 1;
+
+	if (val1 < 0 || val2 < 0)
+		sign = -1;
+	exp = hid_sensor_convert_exponent(exp);
+	if (exp < 0) {
+		value = abs(val1) * pow(10, -exp);
+		value += abs(val2) / pow(10, 6+exp);
+	} else {
+		value = abs(val1) / pow(10, exp);
+	}
+	if (sign < 0) {
+		set_bit_range(&mask, 0, size*8-1);
+		value = mask-value+1;
+	}
+
+	return value;
+}
+
+int hid_sensor_read_samp_freq_value(struct hid_sensor_attributes *st,
+				int *val1, int *val2)
+{
+	s32 value;
+	int ret;
+
+	ret = sensor_hub_get_feature(st->hsdev,
+		st->poll.report_id,
+		st->poll.index, &value);
+	if (ret < 0 || value < 0)
+		*val1 = *val2 = 0;
+	else {
+		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
+			single_prec_div(1000, value, val1, val2);
+		else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
+			single_prec_div(1, value, val1, val2);
+		else
+			*val1 = *val2 = 0;
+	}
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+EXPORT_SYMBOL(hid_sensor_read_samp_freq_value);
+
+int hid_sensor_write_samp_freq_value(struct hid_sensor_attributes *st,
+				int val1, int val2)
+{
+	s32 value;
+	int ret;
+
+	value = val1 * pow(10, 6) + val2;
+	if (value) {
+		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
+			value = pow(10, 9)/value;
+		else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
+			value = pow(10, 6)/value;
+		else
+			value = 0;
+	}
+	ret = sensor_hub_set_feature(st->hsdev,
+		st->poll.report_id,
+		st->poll.index, value);
+	if (ret < 0 || value < 0)
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL(hid_sensor_write_samp_freq_value);
+
+int hid_sensor_read_raw_hyst_value(struct hid_sensor_attributes *st,
+				int *val1, int *val2)
+{
+	s32 value;
+	int ret;
+
+	ret = sensor_hub_get_feature(st->hsdev,
+		st->sensitivity.report_id,
+		st->sensitivity.index, &value);
+	if (ret < 0 || value < 0)
+		*val1 = *val2 = 0;
+	else {
+		convert_from_vtf_format(value, st->sensitivity.size,
+					st->sensitivity.unit_expo,
+					val1, val2);
+	}
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+EXPORT_SYMBOL(hid_sensor_read_raw_hyst_value);
+
+int hid_sensor_write_raw_hyst_value(struct hid_sensor_attributes *st,
+					int val1, int val2)
+{
+	s32 value;
+	int ret;
+
+	value = convert_to_vtf_format(st->sensitivity.size,
+				st->sensitivity.unit_expo,
+				val1, val2);
+	ret = sensor_hub_set_feature(st->hsdev,
+		st->sensitivity.report_id,
+		st->sensitivity.index, value);
+	if (ret < 0 || value < 0)
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
+
+int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
+					u32 usage_id,
+					struct hid_sensor_attributes *st)
+{
+
+	sensor_hub_input_get_attribute_info(hsdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_USAGE_SENSOR_PROP_REPORT_INTERVAL,
+					&st->poll);
+
+	sensor_hub_input_get_attribute_info(hsdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_USAGE_SENSOR_PROP_REPORT_STATE,
+					&st->report_state);
+
+	sensor_hub_input_get_attribute_info(hsdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_USAGE_SENSOR_PROY_POWER_STATE,
+					&st->power_state);
+
+	sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS,
+			 &st->sensitivity);
+
+	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x\n",
+			st->poll.index, st->poll.report_id,
+			st->report_state.index, st->report_state.report_id,
+			st->power_state.index, st->power_state.report_id,
+			st->sensitivity.index, st->sensitivity.report_id);
+
+	return 0;
+}
+EXPORT_SYMBOL(hid_sensor_parse_common_attributes);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
+MODULE_DESCRIPTION("HID Sensor common attribute processing");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.h b/drivers/iio/common/hid-sensors/hid-sensor-attributes.h
new file mode 100644
index 0000000..2dfe888
--- /dev/null
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.h
@@ -0,0 +1,58 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#ifndef _HID_SENSORS_ATTRIBUTES_H
+#define _HID_SENSORS_ATTRIBUTES_H
+
+/* Common sysfs attributes for HID sensors */
+struct hid_sensor_attributes {
+	struct hid_sensor_hub_device *hsdev;
+	struct platform_device *pdev;
+	unsigned usage_id;
+	bool data_ready;
+	struct hid_sensor_hub_attribute_info poll;
+	struct hid_sensor_hub_attribute_info report_state;
+	struct hid_sensor_hub_attribute_info power_state;
+	struct hid_sensor_hub_attribute_info sensitivity;
+	void *private;
+};
+
+/*Convert from hid unit expo to regular exponent*/
+static inline int hid_sensor_convert_exponent(int unit_expo)
+{
+	if (unit_expo < 0x08)
+		return unit_expo;
+	else if (unit_expo <= 0x0f)
+		return -(0x0f-unit_expo+1);
+	else
+		return 0;
+}
+
+int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
+					u32 usage_id,
+					struct hid_sensor_attributes *st);
+int hid_sensor_write_raw_hyst_value(struct hid_sensor_attributes *st,
+					int val1, int val2);
+int hid_sensor_read_raw_hyst_value(struct hid_sensor_attributes *st,
+					int *val1, int *val2);
+int hid_sensor_write_samp_freq_value(struct hid_sensor_attributes *st,
+					int val1, int val2);
+int hid_sensor_read_samp_freq_value(struct hid_sensor_attributes *st,
+					int *val1, int *val2);
+
+#endif
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
new file mode 100644
index 0000000..9a49cf9
--- /dev/null
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -0,0 +1,103 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/hid-sensor-hub.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/sysfs.h>
+#include "hid-sensor-attributes.h"
+
+static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	int state_val;
+
+	dev_dbg(&indio_dev->dev, "hid_sensor_data_rdy_trigger_set_state %d\n",
+			state);
+	state_val = state ? 1 : 0;
+#if (defined CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS) || \
+	(defined CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS_MODULE)
+	++state_val;
+#endif
+	st->data_ready = state;
+	sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
+					st->power_state.index,
+					(s32)state_val);
+
+	sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
+					st->report_state.index,
+					(s32)state_val);
+
+	return 0;
+}
+
+void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
+{
+	iio_trigger_unregister(indio_dev->trig);
+	iio_trigger_free(indio_dev->trig);
+}
+EXPORT_SYMBOL(hid_sensor_remove_trigger);
+
+static const struct iio_trigger_ops hid_sensor_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
+};
+
+int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name)
+{
+	int ret;
+	struct iio_trigger *trig;
+
+	trig = iio_trigger_alloc("%s-dev%d", name, indio_dev->id);
+	if (trig == NULL) {
+		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	trig->dev.parent = indio_dev->dev.parent;
+	trig->private_data = (void *)indio_dev;
+	trig->ops = &hid_sensor_trigger_ops;
+	ret = iio_trigger_register(trig);
+
+	if (ret) {
+		dev_err(&indio_dev->dev, "Trigger Register Failed\n");
+		goto error_free_trig;
+	}
+	indio_dev->trig = trig;
+
+	return ret;
+
+error_free_trig:
+	iio_trigger_free(trig);
+error_ret:
+	return ret;
+}
+EXPORT_SYMBOL(hid_sensor_setup_trigger);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
+MODULE_DESCRIPTION("HID Sensor trigger processing");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
new file mode 100644
index 0000000..05b05d1
--- /dev/null
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -0,0 +1,25 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#ifndef _HID_SENSOR_TRIGGER_H
+#define _HID_SENSOR_TRIGGER_H
+
+int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name);
+void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
+
+#endif
-- 
1.7.7.6
