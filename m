Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35328 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbcGVASk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2016 20:18:40 -0400
Received: by mail-qk0-f173.google.com with SMTP id s63so88757213qkb.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Jul 2016 17:18:39 -0700 (PDT)
Message-ID: <1469146716.2673.23.camel@lucasmagasweran-vm>
Subject: [RFC] iio: imu: mm7150: Add support for MM7150
From: Lucas Magasweran <lucas.magasweran@daqri.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Paul Reioux <paul.reioux@daqri.com>
Date: Thu, 21 Jul 2016 17:18:36 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add initial driver support for the Microchip MM7150 Motion Module imu chips.

Signed-off-by: Lucas Magasweran <lucas.magasweran@daqri.com>
---

Hi all,

This driver is a work in progress but already has support for raw and triggered
buffered access to the accelerometer, magnetometer, gyroscope, inclinometer, and
orientation sensors. While I work adding IIO features such as events, I would
appreciate feedback on the current implementation and the following design
concerns I had while developing this lower-level IIO driver.

1. Multiple sensor updates with different sampling rates.

This device supports per sensor sampling rates and triggers a level sensitive
interrupt for each sensor that has new data. The device expects the host to read
one sensor update at a time in the isr. It does not expect the host to perform
synchronous reads of all enabled scan channels. Therefore, when handling a
triggered buffer's update not all enabled scan channels have new data. 

My current approach is to push cached sensor data into the triggered buffer.
This occurs for each interrupt triggered. To avoid an invalid cache when first
enabling the buffer, userspace must perform a raw read of the enabled sensors.
Data will be stale only until the sensor updates. 

The concern I have is when the sensors are setup to update at very different
rates (e.g. 10 Hz accelerometer and a 100 Hz gyroscope). In this case, userspace
will see multiple buffer updates without a way to tell which channel has
changed. Is this a valid concern? Should each buffer be restricted to a single
sampling rate? If so, should the buffer only notify userspace of new data when
all channels have updated?

2. Disabling sensor before servicing sensor update isr.

Level sensitive interrupts will remain unhandled if userspace disables a sensor
without a triggered buffer enabled. To clear this condition, userspace must
enable and immediately disable the triggered buffer if one is not already
running.

Should I require that the buffer be disabled before the sensors? For example,
queue any requests to disable a sensor and only act on them inside the
postdisable?

3. An interrupt is required during probe to detect device reset.

This device will assert the interrupt after completing a reset (either host or
self initiated). During probe, I would like to wait on a condition variable
until the interrupt is serviced. However, the interrupt is tried to a trigger
and that trigger pollfunc is only active when a triggered buffer is enabled.
How can I service this interrupt without an active triggered buffer? 

I tried to define an interrupt handler and call iio_trigger_poll_chained() or
iio_trigger_poll() when a trigger is enable but was not successful and would
appreciate some guidance.


Thanks for your time,

Lucas

 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 drivers/iio/imu/Kconfig                            |   12 +
 drivers/iio/imu/Makefile                           |    2 +
 drivers/iio/imu/mm7150.c                           | 1678 ++++++++++++++++++++
 4 files changed, 1693 insertions(+)
 create mode 100644 drivers/iio/imu/mm7150.c

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index acc5cd6..a20187c 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -120,6 +120,7 @@ microchip,mcp4662-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Mem
 microchip,mcp4662-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
 microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
 microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
+microchip,mm7150	Microchip MM7150 Motion Module
 national,lm63		Temperature sensor with integrated fan control
 national,lm75		I2C TEMP SENSOR
 national,lm80		Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 1f1ad41..879fe2b 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -40,6 +40,18 @@ config KMX61
 
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
 
+config MM7150
+        tristate "Microchip MM7150 Motion Module"
+        depends on I2C
+        select IIO_BUFFER
+        select IIO_TRIGGERED_BUFFER
+        help
+          Say Y here if you want to build a driver for Microchip MM7150 Motion
+          Module with accelerometer, magnetometer, gyroscope, inclinometer,
+          and orientation.
+          To compile this driver as module, choose M here: the module will
+          be called mm7150.
+
 endmenu
 
 config IIO_ADIS_LIB
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index c71bcd3..534c2df 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -17,3 +17,5 @@ obj-y += bmi160/
 obj-y += inv_mpu6050/
 
 obj-$(CONFIG_KMX61) += kmx61.o
+
+obj-$(CONFIG_MM7150) += mm7150.o
diff --git a/drivers/iio/imu/mm7150.c b/drivers/iio/imu/mm7150.c
new file mode 100644
index 0000000..b500a0b
--- /dev/null
+++ b/drivers/iio/imu/mm7150.c
@@ -0,0 +1,1678 @@
+/*
+ * mm7150.c - driver for the Microchip MM7150 Motion Module
+ *
+ * Copyright (C) 2016, DAQRI. All rights reserved.
+ *
+ * Author: Lucas Magasweran <lucas.magasweran@daqri.com>
+ *
+ * Thanks: Alex Deddo <alex.deddo@daqri.com>
+ *
+ * Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/00001888B.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/sysfs.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/nls.h>
+#include <linux/of.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/*
+ * Verbose debug output. Such as hexdump of i2c communication
+ */
+#ifndef MM7150_DEBUG_LEVEL
+#define MM7150_DEBUG_LEVEL	0
+#endif
+
+#define MM7150_DBG(msg, ...)						\
+	dev_dbg(&data->client->dev, "%s: " msg "\n", __func__, ##__VA_ARGS__)
+#define MM7150_ERR(msg, ...)						\
+	dev_err(&data->client->dev, "%s: " msg "\n", __func__, ##__VA_ARGS__)
+
+#define HID_DESC_CMD			0x0001
+#define HID_DESC_CMD_LEN		2
+#define HID_DESC_LEN			30 /* 1.00 descriptor length */
+#define HID_REPORT_DESC_CMD		0x0002
+#define HID_REPORT_DESC_CMD_LEN		2
+/*
+ * HID/I2C Command Register
+ * MSB
+ *   7-4: Reserved
+ *   3-0: Op Code
+ * LSB
+ *   7-6: Reserved
+ *   5-4: Report Type
+ *   3-0: Report ID
+ */
+#define HID_CMD_LEN			4
+#define HID_RPRT_CMD_LEN		6 /* TODO cite source */
+#define HID_RPRT_LEN			33 /* TODO cite source */
+
+/* FIXME replace with op code nibbles */
+#define HID_RESET_CMD			0x0100
+#define HID_GET_REPORT_CMD		0x0200
+#define HID_SET_REPORT_CMD		0x0300
+#define HID_POWER_CMD			0x0800
+
+enum hid_power_state {
+	ON = 0,
+	SLEEP = 1,
+};
+
+#define MM7150_VERSION			0x7150
+#define MM7150_VID			0x04D8
+#define MM7150_PID			0x0F01
+
+/* from i2c-hid.c */
+struct i2c_hid_desc {
+	__le16 wHIDDescLength;
+	__le16 bcdVersion;
+	__le16 wReportDescLength;
+	__le16 wReportDescRegister;
+	__le16 wInputRegister;
+	__le16 wMaxInputLength;
+	__le16 wOutputRegister;
+	__le16 wMaxOutputLength;
+	__le16 wCommandRegister;
+	__le16 wDataRegister;
+	__le16 wVendorID;
+	__le16 wProductID;
+	__le16 wVersionID;
+	__le32 reserved;
+} __packed;
+
+enum mm7150_feature_power_state {
+	FULL_POWER = 2,
+	LOW_POWER = 3,
+	POWER_OFF = 6,
+};
+
+enum mm7150_feature_reporting_state {
+	HID_REPORTING_STATE_NO_EVENTS = 0x01,
+	HID_REPORTING_STATE_ALL_EVENTS,
+	HID_REPORTING_STATE_THRESHOLD_EVENTS,
+	HID_REPORTING_STATE_NO_EVENTS_WAKE,
+	HID_REPORTING_STATE_ALL_EVENTS_WAKE,
+	HID_REPORTING_STATE_THRESHOLD_EVENTS_WAKE,
+};
+
+static const char * const mm7150_feature_reporting_state_str[] = {
+	"no events",
+	"all events",
+	"threshold events",
+	"no events wake",
+	"all events wake",
+	"threshold events wake"
+};
+
+static const char * const mm7150_power_state_str[] = {
+	"full",
+	"low",
+	"off"
+};
+
+static const char * const mm7150_feature_sensor_state_str[] = {
+	"unknown",
+	"ready",
+	"unavailable",
+	"no data",
+	"initializing",
+	"access denied",
+	"error"
+};
+
+enum mm7150_feature_sensor_state {
+	SENSOR_STATE_UNKNOWN = 1,
+	SENSOR_STATE_READY = 2,
+	SENSOR_STATE_UNAVAILABLE = 3,
+	SENSOR_STATE_NO_DATA = 4,
+	SENSOR_STATE_INITIALIZING = 5,
+	SENSOR_STATE_ACCESS_DENIED = 6,
+	SENSOR_STATE_ERROR = 7,
+};
+
+/* spec difference: this includes the length field */
+struct mm7150_hid_feat_rpt {
+	uint16_t len; /* hid/i2c length, saved for convenience */
+	uint8_t ucReportID;
+	uint8_t ucConnectionType;
+	uint8_t ucReportingState;
+	uint8_t ucPowerState;
+	uint8_t ucSensorState;
+	uint16_t uIReportInterval; /* sampling rate */
+	uint16_t usAccuracy;
+	uint16_t usResolution;
+	uint16_t usChangeSensitivity;
+	int16_t sMaximum;
+	int16_t sMinimum;
+	uint16_t minimumReportInterval;
+	wchar_t sensorDesc[6];
+} __packed;
+
+#if (MM7150_DEBUG_LEVEL > 0)
+static const char * const mm7150_hid_event_type_str[] = {
+	"unknown",
+	"state changed",
+	"property changed",
+	"data updated",
+	"poll response",
+	"change sensitivity",
+};
+#endif
+
+/* TODO document source */
+#define ACCEL_SENSOR_TYPE		0x73
+#define GYRO_SENSOR_TYPE		0x76
+#define CMP_SENSOR_TYPE			0x83
+#define ORI_SENSOR_TYPE			0x8a
+#define INCL_SENSOR_TYPE		0x86
+#define RAW_SENSOR_TYPE			0xe1
+
+/* from USB HID report descriptor:
+ *  sensor  | usage type | report id
+ *  acc     | 0x73       | 1
+ *  cmp     | 0x83       | 2
+ *  gyr     | 0x76       | 3
+ *  inc     | 0x86       | 4
+ *  ori     | 0x8a       | 5
+ *  and three raw sensors (TODO)
+ *  acc_raw | 0xe1       | 6
+ *  cmp_raw | 0xe1       | 7 TODO not sure if it's cmp or gyr
+ *  gyr_raw | 0xe1       | 8
+ *
+ *  TODO where is mag? it's a physical sensor
+ */
+enum mm7150_sensor_report_id {
+	MM7150_RPT_ID_ACC = 1,
+	MM7150_RPT_ID_CMP = 2,
+	MM7150_RPT_ID_GYR = 3,
+	MM7150_RPT_ID_INC = 4,
+	MM7150_RPT_ID_ORI = 5,
+	MM7150_RPT_ID_MAX,
+};
+
+static const char * const mm7150_hid_input_report_id_str[] = {
+	"accelerometer",
+	"compass",
+	"gyroscope",
+	"inclinometer",
+	"orientation",
+};
+
+struct mm7150_hid_in_rpt_hdr {
+	uint16_t len; /* from HID/I2C saved here for convenience */
+	uint8_t ucReportID;
+	uint8_t ucSensorState;
+	uint8_t ucEventType;
+} __packed;
+
+/* spec divergence: includes length field */
+struct mm7150_hid_in_rpt_acc {
+	uint16_t len; /* from HID/I2C saved here for convenience */
+	uint8_t ucReportID;
+	uint8_t ucSensorState;
+	uint8_t ucEventType;
+	int16_t sAccelXValue;
+	int16_t sAccelYValue;
+	int16_t sAccelZValue;
+	uint8_t ucShakeDetectState;
+} __packed;
+
+/* spec divergence: includes length field */
+struct mm7150_hid_in_rpt_cmp {
+	uint16_t len; /* from HID/I2C saved here for convenience */
+	uint8_t ucReportID;
+	uint8_t ucSensorState;
+	uint8_t ucEventType;
+	int16_t sHeadingCompensatedMagneticNorthValue;
+	int16_t sFluxXValue;
+	int16_t sFluxYValue;
+	int16_t sFluxZValue;
+} __packed;
+
+/* spec divergence: includes length field */
+struct mm7150_hid_in_rpt_gyr {
+	uint16_t len; /* from HID/I2C saved here for convenience */
+	uint8_t ucReportID;
+	uint8_t ucSensorState;
+	uint8_t ucEventType;
+	int16_t sGyroXValue;
+	int16_t sGyroYValue;
+	int16_t sGyroZValue;
+	uint8_t ucShakeDetectState;
+} __packed;
+
+/* spec divergence: includes length field */
+struct mm7150_hid_in_rpt_inc {
+	uint16_t len; /* from HID/I2C saved here for convenience */
+	uint8_t ucReportID;
+	uint8_t ucSensorState;
+	uint8_t ucEventType;
+	int16_t sIncXValue;
+	int16_t sIncYValue;
+	int16_t sIncZValue;
+} __packed;
+
+/* spec divergence: includes length field */
+struct mm7150_hid_in_rpt_ori {
+	uint16_t len; /* from HID/I2C saved here for convenience */
+	uint8_t ucReportID;
+	uint8_t ucSensorState;
+	uint8_t ucEventType;
+	int16_t sOriXValue;
+	int16_t sOriYValue;
+	int16_t sOriZValue;
+	int16_t sOriWValue;
+} __packed;
+
+enum hid_report_type {
+	HID_REPORT_TYPE_INPUT = 0x01,
+	HID_REPORT_TYPE_OUTPUT = 0x02,
+	HID_REPORT_TYPE_FEATURE	= 0x03,
+};
+
+/*
+ * @client: parent i2c client/bus device
+ * @hid_desc: i2c over hid descriptor
+ * @reset: reset completion flag
+ * @trig: device data ready iio trigger
+ * @feature: sensor feature reports
+ * @input: cache of last sensor input report (data values) needed by buffered
+ *         mode to return all enabled sensors values within a single buffer
+ *
+ */
+struct mm7150_data {
+	struct i2c_client *client;
+	struct i2c_hid_desc hid_desc;
+	struct completion reset;
+	struct iio_trigger *trig;
+	struct mm7150_hid_feat_rpt feature[MM7150_RPT_ID_MAX-1];
+	uint8_t *input[MM7150_RPT_ID_MAX-1];
+};
+
+#define MM7150_TO_STR(idx, tbl) mm7150_to_str(idx, tbl, ARRAY_SIZE(tbl))
+
+static const char * const mm7150_to_str(
+	int idx,
+	const char * const tbl[],
+	int count)
+{
+	if (idx < 0)
+		return "invalid";
+	else if (idx > count - 1)
+		return "unsupported";
+	else
+		return tbl[idx];
+}
+
+static void mm7150_hid_feature_report_parse(
+	struct mm7150_data *data,
+	enum hid_report_type report_type,
+	struct mm7150_hid_feat_rpt *report)
+{
+
+	MM7150_DBG("0x%02lx report id:%d (%s)",
+		   offsetof(struct mm7150_hid_feat_rpt, ucReportID),
+		   report->ucReportID,
+		   MM7150_TO_STR(report->ucReportID - 1,
+				 mm7150_hid_input_report_id_str));
+	MM7150_DBG("0x%02lx connection type:0x%02x",
+		   offsetof(struct mm7150_hid_feat_rpt, ucConnectionType),
+		   report->ucConnectionType);
+	MM7150_DBG("0x%02lx reporting state:0x%02x (%s)",
+		   offsetof(struct mm7150_hid_feat_rpt, ucReportingState),
+		   report->ucReportingState,
+		   MM7150_TO_STR(report->ucReportingState - 1,
+				 mm7150_feature_reporting_state_str));
+	MM7150_DBG("0x%02lx power on state:0x%02x (%s)",
+		   offsetof(struct mm7150_hid_feat_rpt, ucPowerState),
+		   report->ucPowerState,
+		   MM7150_TO_STR(report->ucPowerState - 1,
+				 mm7150_power_state_str));
+	MM7150_DBG("0x%02lx sensor state:0x%02x (%s)",
+		   offsetof(struct mm7150_hid_feat_rpt, ucSensorState),
+		   report->ucSensorState,
+		   MM7150_TO_STR(report->ucSensorState - 1,
+				 mm7150_feature_sensor_state_str));
+	MM7150_DBG("0x%02lx reporting interval:%d",
+		   offsetof(struct mm7150_hid_feat_rpt, uIReportInterval),
+		   report->uIReportInterval);
+	MM7150_DBG("0x%02lx accuracy:%d",
+		   offsetof(struct mm7150_hid_feat_rpt, usAccuracy),
+		   report->usAccuracy);
+	MM7150_DBG("0x%02lx resolution:%d",
+		   offsetof(struct mm7150_hid_feat_rpt, usResolution),
+		   report->usResolution);
+	MM7150_DBG("0x%02lx change sensitivity:%d",
+		   offsetof(struct mm7150_hid_feat_rpt, usChangeSensitivity),
+		   report->usChangeSensitivity);
+	MM7150_DBG("0x%02lx maximum range:%d",
+		   offsetof(struct mm7150_hid_feat_rpt, sMaximum),
+		   report->sMaximum);
+	MM7150_DBG("0x%02lx minimum range:%d",
+		   offsetof(struct mm7150_hid_feat_rpt, sMinimum),
+		   report->sMinimum);
+	MM7150_DBG("0x%02lx minimum report interval:%d",
+		   offsetof(struct mm7150_hid_feat_rpt, minimumReportInterval),
+		   report->minimumReportInterval);
+	/* TODO MM7150_DBG("0x%02lx sensor desc:%s", report->sensorDesc); */
+}
+
+#if (MM7150_DEBUG_LEVEL > 0)
+static void mm7150_hid_input_report_parse(
+	struct mm7150_data *data, uint8_t *buf,
+	int len)
+{
+	struct mm7150_hid_in_rpt_hdr *header =
+		(struct mm7150_hid_in_rpt_hdr *)buf;
+
+	if (len < 3)
+		return;
+
+	MM7150_DBG("report id:%d (%s)",
+		header->ucReportID,
+		MM7150_TO_STR(header->ucReportID - 1,
+			      mm7150_hid_input_report_id_str));
+	MM7150_DBG("  sensor state:0x%02x (%s)",
+		header->ucSensorState,
+		MM7150_TO_STR(header->ucSensorState - 1,
+			      mm7150_feature_sensor_state_str));
+	MM7150_DBG("  event type:%02x (%s)",
+		header->ucEventType,
+		MM7150_TO_STR(header->ucEventType - 1,
+			      mm7150_hid_event_type_str));
+
+	switch (buf[2]) {
+	case MM7150_RPT_ID_ACC:
+	{
+		struct mm7150_hid_in_rpt_acc *report =
+			(struct mm7150_hid_in_rpt_acc *)buf;
+
+		MM7150_DBG("  x axis:%i", report->sAccelXValue);
+		MM7150_DBG("  y axis:%i", report->sAccelYValue);
+		MM7150_DBG("  z axis:%i", report->sAccelZValue);
+		MM7150_DBG("  shake event detection:%d",
+			   report->ucShakeDetectState);
+		break;
+	}
+	case MM7150_RPT_ID_CMP:
+	{
+		struct mm7150_hid_in_rpt_cmp *report =
+			(struct mm7150_hid_in_rpt_cmp *)buf;
+
+		MM7150_DBG("  magnetic north:%i",
+			   report->sHeadingCompensatedMagneticNorthValue);
+		MM7150_DBG("  x axis:%i", report->sFluxXValue);
+		MM7150_DBG("  y axis:%i", report->sFluxYValue);
+		MM7150_DBG("  z axis:%i", report->sFluxZValue);
+		break;
+	}
+	case MM7150_RPT_ID_GYR:
+	{
+		struct mm7150_hid_in_rpt_gyr *report =
+			(struct mm7150_hid_in_rpt_gyr *)buf;
+
+		MM7150_DBG("  x axis:%i", report->sGyroXValue);
+		MM7150_DBG("  y axis:%i", report->sGyroYValue);
+		MM7150_DBG("  z axis:%i", report->sGyroZValue);
+		break;
+	}
+	case MM7150_RPT_ID_INC:
+	{
+		struct mm7150_hid_in_rpt_inc *report =
+			(struct mm7150_hid_in_rpt_inc *)buf;
+
+		MM7150_DBG("  x axis:%i", report->sIncXValue);
+		MM7150_DBG("  y axis:%i", report->sIncYValue);
+		MM7150_DBG("  z axis:%i", report->sIncZValue);
+		break;
+	}
+	case MM7150_RPT_ID_ORI:
+	{
+		struct mm7150_hid_in_rpt_ori *report =
+			(struct mm7150_hid_in_rpt_ori *)buf;
+
+		MM7150_DBG("  x axis:%i", report->sOriXValue);
+		MM7150_DBG("  y axis:%i", report->sOriYValue);
+		MM7150_DBG("  z axis:%i", report->sOriZValue);
+		MM7150_DBG("  w axis:%i", report->sOriWValue);
+		break;
+	}
+	default:
+		MM7150_ERR("unsupported report id:%d", buf[2]);
+	}
+}
+#endif
+
+/* shared function */
+static int mm7150_hid_desc_read(struct mm7150_data *data)
+{
+	uint8_t cmd[HID_DESC_CMD_LEN];
+	uint8_t rsp[HID_DESC_LEN];
+	struct i2c_msg msg[2];
+	int ret;
+
+	MM7150_DBG("enter");
+
+	memset(cmd, 0, sizeof(cmd));
+	memset(rsp, 0, sizeof(rsp));
+
+	cmd[0] = HID_DESC_CMD & 0xFF;
+	cmd[1] = HID_DESC_CMD >> 8;
+
+	msg[0].addr = data->client->addr;
+	msg[0].flags = 0;
+	msg[0].len = HID_DESC_CMD_LEN;
+	msg[0].buf = cmd;
+
+	msg[1].addr = data->client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = HID_DESC_LEN;
+	msg[1].buf = rsp;
+
+	ret = i2c_transfer(data->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		MM7150_ERR("hid descriptor read i2c transfer failed");
+		return -EIO;
+	}
+
+	memcpy(&data->hid_desc, rsp, sizeof(struct i2c_hid_desc));
+
+	if (__le16_to_cpu(data->hid_desc.wHIDDescLength) != HID_DESC_LEN)
+		return -1;
+
+	if (__le16_to_cpu(data->hid_desc.wVendorID) != MM7150_VID
+		|| __le16_to_cpu(data->hid_desc.wProductID) != MM7150_PID)
+		return -1;
+
+	if (__le16_to_cpu(data->hid_desc.wVersionID) != MM7150_VERSION)
+		return -1;
+
+	MM7150_DBG("command reg:%d len:%d",
+		   __le16_to_cpu(data->hid_desc.wCommandRegister),
+		   HID_CMD_LEN);
+	MM7150_DBG("report descriptor reg:%d len:%d",
+		   __le16_to_cpu(data->hid_desc.wReportDescRegister),
+		   __le16_to_cpu(data->hid_desc.wReportDescLength));
+	MM7150_DBG("input reg:%d max len:%d",
+		   __le16_to_cpu(data->hid_desc.wInputRegister),
+		   __le16_to_cpu(data->hid_desc.wMaxInputLength));
+	MM7150_DBG("output reg:%d max len:%d",
+		   __le16_to_cpu(data->hid_desc.wOutputRegister),
+		   __le16_to_cpu(data->hid_desc.wMaxOutputLength));
+	MM7150_DBG("data reg:%d", __le16_to_cpu(data->hid_desc.wDataRegister));
+
+	return 0;
+}
+
+static int mm7150_hid_reset_cmd(struct mm7150_data *data)
+{
+	uint8_t cmd[HID_CMD_LEN];
+	struct i2c_msg msg[1];
+	int ret;
+
+	MM7150_DBG("enter");
+
+	memset(cmd, 0, sizeof(cmd));
+
+	cmd[0] = __le16_to_cpu(data->hid_desc.wCommandRegister) & 0xFF;
+	cmd[1] = __le16_to_cpu(data->hid_desc.wCommandRegister) >> 8;
+	cmd[2] = HID_RESET_CMD & 0xFF;
+	cmd[3] = HID_RESET_CMD >> 8;
+
+	msg[0].addr = data->client->addr;
+	msg[0].flags = 0;
+	msg[0].len = sizeof(cmd);
+	msg[0].buf = cmd;
+
+	ret = i2c_transfer(data->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		MM7150_ERR("hid reset i2c transfer failed");
+		ret = -EIO;
+	}
+
+	return 0;
+}
+
+static int mm7150_hid_set_power_cmd(
+	struct mm7150_data *data,
+	enum mm7150_feature_power_state state)
+{
+	uint8_t cmd[HID_CMD_LEN];
+	struct i2c_msg msg[1];
+	int ret;
+
+	MM7150_DBG("enter");
+
+	memset(cmd, 0, sizeof(cmd));
+
+	if (state != 0 && state != 1)
+		return -EINVAL;
+
+	cmd[0] = __le16_to_cpu(data->hid_desc.wCommandRegister) & 0xff;
+	cmd[1] = __le16_to_cpu(data->hid_desc.wCommandRegister) >> 8;
+	cmd[2] = (HID_POWER_CMD & 0xff) | state;
+	cmd[3] = HID_POWER_CMD >> 8;
+
+	msg[0].addr = data->client->addr;
+	msg[0].flags = 0;
+	msg[0].len = HID_CMD_LEN;
+	msg[0].buf = cmd;
+
+	ret = i2c_transfer(data->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		MM7150_ERR("hid set power i2c transfer failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * FIXME Returned reports are variable length and should use the length reported
+ * in the HID Report Descriptor. We cannot use the first two bytes to determine
+ * the actual length because i2c_transfer() will issue a I2C stop bit between
+ * transfers, which is not allowed according the the HID/I2C spec (host
+ * must use repeated start when retrieving the data for a GET_REPORT request).
+ * For now, use hard coded values that work for this device.
+ * This currently does not match the expected lengths from the datasheet.
+ * e.g. Gyro is 12 bytes but I have not seen another report that is 12 bytes.
+ */
+static int mm7150_hid_report_get_length(
+	enum hid_report_type report_type,
+	int id)
+{
+	uint16_t rsp_len = 0;
+
+	if (report_type == HID_REPORT_TYPE_FEATURE) {
+		rsp_len = sizeof(struct mm7150_hid_feat_rpt);
+	} else if (report_type == HID_REPORT_TYPE_INPUT) {
+		if (id == 1)
+			rsp_len = 12;
+		else if (id == 2)
+			rsp_len = 13;
+		else if (id == 3)
+			rsp_len = 11;
+		else if (id == 4)
+			rsp_len = 11;
+		else if (id == 5)
+			rsp_len = 13;
+	}
+
+	return rsp_len;
+}
+
+/*
+ * @report_type: 0x01 input, 0x03 feature
+ */
+static int mm7150_hid_get_report(
+	struct mm7150_data *data,
+	enum hid_report_type report_type,
+	int id,
+	uint8_t *report,
+	int report_len)
+{
+	uint8_t cmd[HID_RPRT_CMD_LEN];
+	uint16_t len;
+	struct i2c_msg msg[2];
+	int ret;
+
+	MM7150_DBG("enter report_type:%d report_len:%d",
+		   report_type, report_len);
+
+	memset(cmd, 0, sizeof(cmd));
+
+	cmd[0] = __le16_to_cpu(data->hid_desc.wCommandRegister) & 0xFF;
+	cmd[1] = __le16_to_cpu(data->hid_desc.wCommandRegister) >> 8;
+	cmd[2] = (report_type << 4) | id;
+	cmd[3] = HID_GET_REPORT_CMD >> 8;
+	cmd[4] = __le16_to_cpu(data->hid_desc.wDataRegister) & 0xFF;
+	cmd[5] = __le16_to_cpu(data->hid_desc.wDataRegister) >> 8;
+
+	msg[0].addr = data->client->addr;
+	msg[0].flags = 0;
+	msg[0].len = HID_RPRT_CMD_LEN;
+	msg[0].buf = cmd;
+	msg[1].addr = data->client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = report_len;
+	msg[1].buf = report;
+
+	ret = i2c_transfer(data->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		MM7150_ERR("hid get report type:%d id:%d i2c transfer failed",
+			   report_type, id);
+		return -EIO;
+	}
+
+	len = (report[1] << 8) | report[0];
+	if (len == 0) {
+		MM7150_DBG("invalid length %d", len);
+		return -1;
+	}
+
+	MM7150_DBG("feature report type:%d len:%d (used %d) id:%d type:%d",
+		   report_type,
+		   len,
+		   report_len,
+		   report[2],
+		   report[3]);
+	print_hex_dump_bytes("", DUMP_PREFIX_NONE, report, len);
+
+	return 0;
+}
+
+/* @report_type: 0x02 output, 0x03 feature */
+static int mm7150_hid_set_report(
+	struct mm7150_data *data,
+	enum hid_report_type report_type,
+	int id,
+	uint8_t *report,
+	int report_len)
+{
+	uint8_t *cmd = kzalloc(HID_RPRT_CMD_LEN + report_len, GFP_KERNEL);
+	struct i2c_msg msg[1];
+	int i;
+	int ret;
+
+	cmd[0] = __le16_to_cpu(data->hid_desc.wCommandRegister) & 0xFF;
+	cmd[1] = __le16_to_cpu(data->hid_desc.wCommandRegister) >> 8;
+	cmd[2] = (report_type << 4) | id;
+	cmd[3] = HID_SET_REPORT_CMD >> 8;
+	cmd[4] = __le16_to_cpu(data->hid_desc.wDataRegister) & 0xFF;
+	cmd[5] = __le16_to_cpu(data->hid_desc.wDataRegister) >> 8;
+	for (i = 0; i < report_len; ++i)
+		cmd[i + 6] = report[i];
+
+	msg[0].addr = data->client->addr;
+	msg[0].flags = 0;
+	msg[0].len = HID_RPRT_CMD_LEN + report_len;
+	msg[0].buf = cmd;
+
+	ret = i2c_transfer(data->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		MM7150_ERR("hid set report type:%d id:%d i2c transfer failed",
+			   report_type, id);
+		kfree(cmd);
+		return -EIO;
+	}
+
+	kfree(cmd);
+
+	return 0;
+}
+
+static int mm7150_hid_report_desc_read(struct mm7150_data *data)
+{
+	uint8_t cmd[HID_REPORT_DESC_CMD_LEN];
+	uint8_t *rsp;
+	struct i2c_msg msg[2];
+	int ret;
+
+	rsp = kzalloc(__le16_to_cpu(data->hid_desc.wReportDescLength),
+		      GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	MM7150_DBG("read hid report descriptor reg:%d len:%d",
+		   __le16_to_cpu(data->hid_desc.wReportDescRegister),
+		   __le16_to_cpu(data->hid_desc.wReportDescLength));
+
+	cmd[0] = __le16_to_cpu(data->hid_desc.wReportDescRegister) & 0xFF;
+	cmd[1] = __le16_to_cpu(data->hid_desc.wReportDescRegister) >> 8;
+
+	msg[0].addr = data->client->addr;
+	msg[0].flags = 0;
+	msg[0].len = sizeof(cmd);
+	msg[0].buf = cmd;
+	msg[1].addr = data->client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = __le16_to_cpu(data->hid_desc.wReportDescLength);
+	msg[1].buf = rsp;
+
+	ret = i2c_transfer(data->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		MM7150_ERR("Failed to read report descriptor");
+		kfree(rsp);
+		return -EIO;
+	}
+
+#if (MM7150_DEBUG_LEVEL > 1)
+	print_hex_dump_bytes("", DUMP_PREFIX_NONE, rsp,
+			     __le16_to_cpu(data->hid_desc.wReportDescLength));
+#endif
+
+	kfree(rsp);
+
+	return 0;
+}
+
+enum {
+	MM7150_SCAN_ACC_X,
+	MM7150_SCAN_ACC_Y,
+	MM7150_SCAN_ACC_Z,
+	MM7150_SCAN_CMP_X,
+	MM7150_SCAN_CMP_Y,
+	MM7150_SCAN_CMP_Z,
+	MM7150_SCAN_CMP_NORTH,
+	MM7150_SCAN_GYR_X,
+	MM7150_SCAN_GYR_Y,
+	MM7150_SCAN_GYR_Z,
+	MM7150_SCAN_INC_X,
+	MM7150_SCAN_INC_Y,
+	MM7150_SCAN_INC_Z,
+	MM7150_SCAN_ORI,
+	MM7150_SCAN_TIMESTAMP, /* must be last for framework */
+};
+
+#define MM7150_CHANNEL_ACC(_axis) {					\
+	.type = IIO_ACCEL,						\
+	.address = MM7150_RPT_ID_ACC,					\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				  | BIT(IIO_CHAN_INFO_ENABLE)		\
+				  | BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = MM7150_SCAN_ACC_##_axis,				\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+#define MM7150_CHANNEL_CMP(_axis) {					\
+	.type = IIO_MAGN,						\
+	.address = MM7150_RPT_ID_CMP,					\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				  | BIT(IIO_CHAN_INFO_ENABLE)		\
+				  | BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = MM7150_SCAN_CMP_##_axis,				\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+#define MM7150_CHANNEL_GYR(_axis) {					\
+	.type = IIO_ANGL_VEL,						\
+	.address = MM7150_RPT_ID_GYR,					\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				  | BIT(IIO_CHAN_INFO_ENABLE) \
+				  | BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_index = MM7150_SCAN_GYR_##_axis,	\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+#define MM7150_CHANNEL_INC(_axis) {					\
+	.type = IIO_INCLI,						\
+	.address = MM7150_RPT_ID_INC,					\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				  | BIT(IIO_CHAN_INFO_ENABLE),		\
+	.scan_index = MM7150_SCAN_INC_##_axis,				\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+/*
+ * @address: used by driver to store mm7150 hid report id
+ */
+static const struct iio_chan_spec mm7150_channels[] = {
+	MM7150_CHANNEL_ACC(X),
+	MM7150_CHANNEL_ACC(Y),
+	MM7150_CHANNEL_ACC(Z),
+	MM7150_CHANNEL_CMP(X),
+	MM7150_CHANNEL_CMP(Y),
+	MM7150_CHANNEL_CMP(Z),
+	{
+		.type = IIO_MAGN,
+		.address = MM7150_RPT_ID_CMP,
+		.modified = 1,
+		.channel2 = IIO_MOD_NORTH_MAGN,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ)
+					  | BIT(IIO_CHAN_INFO_ENABLE)
+					  | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = MM7150_SCAN_CMP_NORTH,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	MM7150_CHANNEL_GYR(X),
+	MM7150_CHANNEL_GYR(Y),
+	MM7150_CHANNEL_GYR(Z),
+	MM7150_CHANNEL_INC(X),
+	MM7150_CHANNEL_INC(Y),
+	MM7150_CHANNEL_INC(Z),
+	{
+		.type = IIO_ROT,
+		.address = MM7150_RPT_ID_ORI,
+		.modified = 1,
+		.channel2 = IIO_MOD_QUATERNION,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ)
+					  | BIT(IIO_CHAN_INFO_ENABLE),
+		.scan_index = MM7150_SCAN_ORI,
+		.scan_type = {
+			.sign = 's',
+			.realbits = sizeof(uint16_t) * 8,
+			.storagebits = sizeof(uint16_t) * 8,
+			.endianness = IIO_LE,
+			.repeat = 4,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(MM7150_SCAN_TIMESTAMP),
+};
+
+static int mm7150_read_raw_multi(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan,
+	int size, int *vals, int *val_len,
+	long mask)
+{
+	struct mm7150_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	MM7150_DBG("type:%d chan:%d chan2:%d address:%lu size:%d mask:%li",
+		   chan->type, chan->channel, chan->channel2, chan->address,
+		   size, mask);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
+	{
+		int report_len =
+			mm7150_hid_report_get_length(HID_REPORT_TYPE_INPUT,
+						     chan->address);
+		uint8_t *report = kzalloc(report_len, GFP_KERNEL);
+
+		if (!report)
+			return -ENOMEM;
+
+		ret = mm7150_hid_get_report(data,
+					    HID_REPORT_TYPE_INPUT,
+					    chan->address,
+					    report,
+					    report_len);
+		if (ret) {
+			kfree(report);
+			return -EIO;
+		}
+
+		/*
+		 * cache sensor values
+		 * buffered access will use this cached value if during a
+		 * trigger handler, not all sensors have updated (e.g. the
+		 * first trigger).
+		 */
+		memcpy(data->input[chan->address-1], report, report_len);
+
+		if (chan->type == IIO_ACCEL) {
+			struct mm7150_hid_in_rpt_acc *rpt_accel =
+				(struct mm7150_hid_in_rpt_acc *)report;
+
+			if (chan->channel2 == IIO_MOD_X)
+				vals[0] = rpt_accel->sAccelXValue;
+			else if (chan->channel2 == IIO_MOD_Y)
+				vals[0] = rpt_accel->sAccelYValue;
+			else if (chan->channel2 == IIO_MOD_Z)
+				vals[0] = rpt_accel->sAccelZValue;
+			*val_len = 1;
+
+			ret = IIO_VAL_INT;
+		} else if (chan->type == IIO_MAGN) {
+			struct mm7150_hid_in_rpt_cmp *rpt_cmp =
+				(struct mm7150_hid_in_rpt_cmp *)report;
+
+			if (chan->channel2 == IIO_MOD_X)
+				vals[0] = rpt_cmp->sFluxXValue;
+			else if (chan->channel2 == IIO_MOD_Y)
+				vals[0] = rpt_cmp->sFluxYValue;
+			else if (chan->channel2 == IIO_MOD_Z)
+				vals[0] = rpt_cmp->sFluxZValue;
+			else if (chan->channel2 == IIO_MOD_NORTH_MAGN)
+				vals[0] =
+				rpt_cmp->sHeadingCompensatedMagneticNorthValue;
+			*val_len = 1;
+
+			ret = IIO_VAL_INT;
+		} else if (chan->type == IIO_ANGL_VEL) {
+			struct mm7150_hid_in_rpt_gyr *rpt_gyr =
+				(struct mm7150_hid_in_rpt_gyr *)report;
+
+			if (chan->channel2 == IIO_MOD_X)
+				vals[0] = rpt_gyr->sGyroXValue;
+			else if (chan->channel2 == IIO_MOD_Y)
+				vals[0] = rpt_gyr->sGyroYValue;
+			else if (chan->channel2 == IIO_MOD_Z)
+				vals[0] = rpt_gyr->sGyroZValue;
+			*val_len = 1;
+
+			ret = IIO_VAL_INT;
+		} else if (chan->type == IIO_INCLI) {
+			struct mm7150_hid_in_rpt_inc *rpt_inc =
+				(struct mm7150_hid_in_rpt_inc *)report;
+
+			if (chan->channel2 == IIO_MOD_X)
+				vals[0] = rpt_inc->sIncXValue;
+			else if (chan->channel2 == IIO_MOD_Y)
+				vals[0] = rpt_inc->sIncYValue;
+			else if (chan->channel2 == IIO_MOD_Z)
+				vals[0] = rpt_inc->sIncZValue;
+			*val_len = 1;
+
+			ret = IIO_VAL_INT;
+		} else if (chan->type == IIO_ROT) {
+			struct mm7150_hid_in_rpt_ori *rpt_ori =
+				(struct mm7150_hid_in_rpt_ori *)report;
+
+			if (size >= 4) {
+				vals[0] = rpt_ori->sOriXValue;
+				vals[1] = rpt_ori->sOriYValue;
+				vals[2] = rpt_ori->sOriZValue;
+				vals[3] = rpt_ori->sOriWValue;
+				*val_len = 4;
+				ret = IIO_VAL_INT_MULTIPLE;
+			} else
+				ret = -EINVAL;
+		}
+
+		kfree(report);
+
+		break;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_ACCEL) {
+			vals[0] = 0;
+			vals[1] = IIO_G_TO_M_S_2(1000000);
+			*val_len = 1;
+			ret = IIO_VAL_INT_PLUS_NANO;
+		} else if (chan->type == IIO_MAGN) {
+			/* 100 uT = 1 gauss */
+			vals[0] = 100;
+			*val_len = 1;
+			ret = IIO_VAL_INT;
+		} else if (chan->type == IIO_ANGL_VEL) {
+			/* TODO why does IIO_DEGREE_TO_RAD() add 90 degrees? */
+			vals[0] = 0;
+			vals[1] = 17453292;
+			*val_len = 1;
+			ret = IIO_VAL_INT_PLUS_NANO;
+		} else {
+			ret = -EINVAL;
+		}
+		break;
+
+	case IIO_CHAN_INFO_ENABLE:
+		if (size >= 1) {
+			vals[0] = data->feature[chan->address-1].ucPowerState
+				  == FULL_POWER ? 1 : 0;
+			*val_len = 1;
+			ret = IIO_VAL_INT;
+		} else
+			ret = -EINVAL;
+		break;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (size >= 1) {
+			vals[0] =
+				data->feature[chan->address-1].uIReportInterval;
+			*val_len = 1;
+			ret = IIO_VAL_INT_MULTIPLE;
+		} else
+			ret = -EINVAL;
+		break;
+
+	default:
+		MM7150_DBG("unsupported mask:%li", mask);
+	}
+
+	return ret;
+}
+
+/**
+ * mm7150_write_raw() - data write function.
+ * @indio_dev:	the struct iio_dev associated with this device instance
+ * @chan:	the channel whose data is to be written
+ * @val:	first element of value to set (typically INT)
+ * @val2:	second element of value to set (typically MICRO)
+ * @mask:	what we actually want to write as per the info_mask_*
+ *		in iio_chan_spec.
+ *
+ * Note that all raw writes are assumed IIO_VAL_INT and info mask elements
+ * are assumed to be IIO_INT_PLUS_MICRO unless the callback write_raw_get_fmt
+ * in struct iio_info is provided by the driver.
+ */
+static int mm7150_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan,
+	int val,
+	int val2,
+	long mask)
+{
+	struct mm7150_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	MM7150_DBG("chan:%d chan2:%d address:%lu mask:%li val:%d",
+		   chan->channel, chan->channel2, chan->address, mask, val);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		if (val != 0 && val != 1)
+			return ret;
+
+		/* TODO why not POWER_OFF? because of sensor fusion? */
+		data->feature[chan->address-1].ucPowerState =
+			(val == 1 ? FULL_POWER : LOW_POWER);
+		data->feature[chan->address-1].ucReportingState =
+			(val == 1 ? HID_REPORTING_STATE_ALL_EVENTS :
+				    HID_REPORTING_STATE_NO_EVENTS);
+		/* 0 is a special case that maintains report interval */
+		data->feature[chan->address-1].usChangeSensitivity = 0;
+
+		break;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < data->feature[chan->address-1].minimumReportInterval)
+			return ret;
+
+		data->feature[chan->address-1].uIReportInterval = val;
+
+		break;
+
+	default:
+		MM7150_DBG("unsupported mask:%li", mask);
+		return ret;
+	}
+
+	ret = mm7150_hid_set_report(data,
+				    HID_REPORT_TYPE_FEATURE,
+				    chan->address,
+				    (uint8_t *)&data->feature[chan->address-1],
+				    sizeof(struct mm7150_hid_feat_rpt));
+	if (ret)
+		return ret;
+
+	/* sync configuration cache */
+	ret = mm7150_hid_get_report(data,
+				    HID_REPORT_TYPE_FEATURE,
+				    chan->address,
+				    (uint8_t *)&data->feature[chan->address-1],
+				    sizeof(struct mm7150_hid_feat_rpt));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct iio_info mm7150_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw_multi = mm7150_read_raw_multi,
+	.write_raw = mm7150_write_raw,
+};
+
+static irqreturn_t mm7150_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mm7150_data *data = iio_priv(indio_dev);
+	struct i2c_msg msg[1];
+	uint8_t *rsp;
+	int len; /* includes 2-bytes for length word */
+	uint16_t *buffer;
+	uint8_t bit;
+	int i = 0;
+	int ret;
+
+	dev_dbg_ratelimited(&data->client->dev, "%s: enter\n", __func__);
+
+	/* spec: host must issue read for max input report length */
+	rsp = kzalloc(__le16_to_cpu(data->hid_desc.wMaxInputLength),
+				    GFP_KERNEL);
+	if (!rsp)
+		return IRQ_HANDLED;
+
+	buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (!buffer) {
+		kfree(rsp);
+		return IRQ_HANDLED;
+	}
+
+	msg[0].addr = data->client->addr;
+	msg[0].flags = I2C_M_RD;
+	msg[0].len = __le16_to_cpu(data->hid_desc.wMaxInputLength);
+	msg[0].buf = rsp;
+
+	ret = i2c_transfer(data->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		MM7150_ERR("failed to read input report len:%d",
+			   __le16_to_cpu(data->hid_desc.wMaxInputLength));
+		ret = -EIO;
+		goto done;
+	}
+
+	/*
+	 * on reset the device writes the sentinel value 0x0000
+	 * to the Input Register length field
+	 */
+	if ((rsp[0] == 0) && (rsp[1] == 0)) {
+		if (!completion_done(&data->reset)) {
+			MM7150_DBG("reset complete");
+			complete(&data->reset);
+		} else {
+			MM7150_DBG("device initiated reset detected");
+		}
+		goto done;
+	}
+
+	/* first two bytes contain actual length */
+	len = rsp[0] | (rsp[1] << 8);
+#if (MM7150_DEBUG_LEVEL > 0)
+	dev_dbg_ratelimited(&data->client->dev, "%s: read len:%d\n",
+		__func__, len);
+	print_hex_dump_bytes("", DUMP_PREFIX_NONE, rsp, len);
+#endif
+
+	/* ignore empty messages */
+	if (len <= 2)
+		goto done;
+
+#if (MM7150_DEBUG_LEVEL > 0)
+	mm7150_hid_input_report_parse(data, rsp, len);
+#endif
+
+	/* cache sensor value */
+	memcpy(data->input[rsp[2]-1], rsp, len);
+
+	/*
+	 * make sure scan index is still enabled.
+	 * the imu could have a pending interrupt from previous buffer setup.
+	 */
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->num_channels) {
+		switch (bit) {
+		case MM7150_SCAN_ACC_X:
+		case MM7150_SCAN_ACC_Y:
+		case MM7150_SCAN_ACC_Z:
+			if (rsp[2] == MM7150_RPT_ID_ACC)
+				goto new_data;
+			break;
+		case MM7150_SCAN_CMP_X:
+		case MM7150_SCAN_CMP_Y:
+		case MM7150_SCAN_CMP_Z:
+			if (rsp[2] == MM7150_RPT_ID_CMP)
+				goto new_data;
+			break;
+		case MM7150_SCAN_GYR_X:
+		case MM7150_SCAN_GYR_Y:
+		case MM7150_SCAN_GYR_Z:
+			if (rsp[2] == MM7150_RPT_ID_GYR)
+				goto new_data;
+			break;
+		case MM7150_SCAN_INC_X:
+		case MM7150_SCAN_INC_Y:
+		case MM7150_SCAN_INC_Z:
+			if (rsp[2] == MM7150_RPT_ID_INC)
+				goto new_data;
+			break;
+		case MM7150_SCAN_ORI:
+			if (rsp[2] == MM7150_RPT_ID_ORI)
+				goto new_data;
+			break;
+		}
+	}
+
+	/* sensor/scan channel is not enabled for this buffer */
+	goto done;
+
+	/*
+	 * the imu will trigger this handler per sensor update and expects the
+	 * host to perform a read of the max input report length. it does not
+	 * expect the host to perform a synchronous read of the inputs reports
+	 * for each enabled sensor. therefore, at least on the first instance,
+	 * not all sensor values will have been cached (this is worse if the
+	 * sensor sampling rates are very different). however, userspace expects
+	 * the triggered buffer to be ready at the rate of the fastest sampling
+	 * rate. in order to avoid invalid data for sensors that have not yet
+	 * updated, userspace should perform a raw read of the sensors before
+	 * starting the buffered access.
+	 * FIXME if sensor is disabled this will always return stale data
+	 */
+new_data:
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->num_channels) {
+		MM7150_DBG("report id:%d bit %d set", rsp[2], bit);
+		switch (bit) {
+		case MM7150_SCAN_ACC_X:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_acc *)
+				data->input[MM7150_RPT_ID_ACC-1])->sAccelXValue;
+			break;
+		case MM7150_SCAN_ACC_Y:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_acc *)
+				data->input[MM7150_RPT_ID_ACC-1])->sAccelYValue;
+			break;
+		case MM7150_SCAN_ACC_Z:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_acc *)
+				data->input[MM7150_RPT_ID_ACC-1])->sAccelZValue;
+			break;
+		case MM7150_SCAN_CMP_X:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_cmp *)
+				data->input[MM7150_RPT_ID_CMP-1])->sFluxXValue;
+			break;
+		case MM7150_SCAN_CMP_Y:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_cmp *)
+				data->input[MM7150_RPT_ID_CMP-1])->sFluxYValue;
+			break;
+		case MM7150_SCAN_CMP_Z:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_cmp *)
+				data->input[MM7150_RPT_ID_CMP-1])->sFluxZValue;
+			break;
+		case MM7150_SCAN_GYR_X:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_gyr *)
+				data->input[MM7150_RPT_ID_GYR-1])->sGyroXValue;
+			break;
+		case MM7150_SCAN_GYR_Y:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_gyr *)
+				data->input[MM7150_RPT_ID_GYR-1])->sGyroYValue;
+			break;
+		case MM7150_SCAN_GYR_Z:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_gyr *)
+				data->input[MM7150_RPT_ID_GYR-1])->sGyroZValue;
+			break;
+		case MM7150_SCAN_INC_X:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_inc *)
+				data->input[MM7150_RPT_ID_INC-1])->sIncXValue;
+			break;
+		case MM7150_SCAN_INC_Y:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_inc *)
+				data->input[MM7150_RPT_ID_INC-1])->sIncYValue;
+			break;
+		case MM7150_SCAN_INC_Z:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_inc *)
+				data->input[MM7150_RPT_ID_INC-1])->sIncZValue;
+			break;
+		case MM7150_SCAN_ORI:
+			buffer[i++] = ((struct mm7150_hid_in_rpt_ori *)
+				data->input[MM7150_RPT_ID_ORI-1])->sOriXValue;
+			buffer[i++] = ((struct mm7150_hid_in_rpt_ori *)
+				data->input[MM7150_RPT_ID_ORI-1])->sOriYValue;
+			buffer[i++] = ((struct mm7150_hid_in_rpt_ori *)
+				data->input[MM7150_RPT_ID_ORI-1])->sOriZValue;
+			buffer[i++] = ((struct mm7150_hid_in_rpt_ori *)
+				data->input[MM7150_RPT_ID_ORI-1])->sOriWValue;
+			break;
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	kfree(buffer);
+	kfree(rsp);
+
+	return IRQ_HANDLED;
+}
+
+/* TODO enable and disable asynchronous/synchronous mode */
+static int mm7150_set_trigger_state(struct iio_trigger *trig,
+				     bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct mm7150_data *data = iio_priv(indio_dev);
+
+	MM7150_DBG("scan_bytes:%d state:%d", indio_dev->scan_bytes, state);
+
+	return 0;
+}
+
+static int mm7150_validate_device(struct iio_trigger *trig,
+				   struct iio_dev *indio_dev)
+{
+	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
+
+	if (indio != indio_dev)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops mm7150_trigger_ops = {
+	.set_trigger_state = mm7150_set_trigger_state,
+	.validate_device = mm7150_validate_device,
+	.owner = THIS_MODULE,
+};
+
+static int mm7150_probe(
+	struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct mm7150_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+	int i;
+
+	dev_dbg(&client->dev, "%s: enter\n", __func__);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	/* allocate memory and private data for IIO device */
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	/* save pointer to private data */
+	data = iio_priv(indio_dev);
+	data->client = client;
+	i2c_set_clientdata(client, data);
+
+	/* reset pending condition */
+	init_completion(&data->reset);
+
+	ret = mm7150_hid_desc_read(data);
+	if (ret) {
+		MM7150_ERR("mm7150_hid_desc_read failed: %d", ret);
+		return ret;
+	}
+
+	/* allocate input report buffer caches */
+	for (i = MM7150_RPT_ID_ACC; i < MM7150_RPT_ID_MAX; ++i) {
+		data->input[i-1] =
+			devm_kzalloc(&data->client->dev,
+				__le16_to_cpu(data->hid_desc.wMaxInputLength),
+				GFP_KERNEL);
+		if (!data->input[i-1]) {
+			MM7150_ERR("kzalloc input report buffer %d error", i-1);
+			return -ENOMEM;
+		}
+	}
+
+	/* set parent device */
+	indio_dev->dev.parent = &data->client->dev;
+
+	/* make iio_dev struct available to remove function */
+	i2c_set_clientdata(client, indio_dev);
+
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &mm7150_info;
+
+	indio_dev->channels = mm7150_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mm7150_channels);
+
+	if (client->irq > 0) {
+		/*
+		 * setup iio buffer
+		 * this triggered buffer requires an irq because the trigger
+		 * handler will only have data to read when the alert line
+		 * is asserted by the device.
+		 */
+		MM7150_DBG("iio_triggered_buffer_setup");
+		ret = iio_triggered_buffer_setup(indio_dev,
+						 iio_pollfunc_store_time,
+						 mm7150_trigger_handler,
+						 NULL); /* default buffer ops */
+		if (ret < 0) {
+			MM7150_ERR("triggered buffer setup failed: %d", ret);
+			return ret;
+		}
+
+		/* setup iio trigger */
+		MM7150_DBG("devm_iio_trigger_alloc");
+		data->trig = devm_iio_trigger_alloc(&data->client->dev,
+						    "%s-dev%d",
+						    indio_dev->name,
+						    indio_dev->id);
+		if (!data->trig) {
+			MM7150_ERR("trigger allocation failed");
+			ret = -ENOMEM;
+			goto err_buffer_cleanup;
+		}
+
+		data->trig->dev.parent = &data->client->dev;
+		data->trig->ops = &mm7150_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		MM7150_DBG("iio_trigger_register");
+		ret = iio_trigger_register(data->trig);
+		if (ret) {
+			MM7150_DBG("trigger register failed: %d", ret);
+			goto err_buffer_cleanup;
+		}
+
+		/* setup alert line interrupt */
+		MM7150_DBG("devm_request_threaded_irq irq:%d", client->irq);
+		ret = devm_request_threaded_irq(&data->client->dev,
+			client->irq,
+			iio_trigger_generic_data_rdy_poll,
+			NULL,
+			IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+			"mm7150-alert",
+			data->trig);
+		if (ret) {
+			MM7150_ERR("failed to request threaded irq");
+			goto err_trigger_unregister;
+		}
+	}
+
+	MM7150_DBG("iio_device_register");
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		MM7150_ERR("iio_device_register failed: %d", ret);
+		goto err_trigger_unregister;
+	}
+
+	/*
+	 * setup i2c device after setting up iio in order to have the isr for
+	 * the reset complete signal.
+	 * 1. get HID descriptor. done above to get registers and lengths
+	 *    needed in isr.
+	 * 2. set power on
+	 * 3. reset and wait for completion
+	 * 3. get report descriptor (available sensors)
+	 * 4. get feature reports (default sensor rate and sensitivity)
+	 */
+	ret = mm7150_hid_set_power_cmd(data, ON);
+	if (ret)
+		goto err_device_unregister;
+
+	/* wait 30 ms before sending another command (from spec) */
+	msleep(30);
+
+	/* reseting the device will cause the alert line to be asserted */
+	ret = mm7150_hid_reset_cmd(data);
+	if (ret)
+		goto err_device_unregister;
+
+	/* hid/i2c spec: device must respond within 5 s of reset command */
+#if 0 /* FIXME how to enable isr tied to triggered buffer inside of probe? */
+	MM7150_DBG("wait up to 5 s for reset irq");
+	if (!wait_for_completion_timeout(&data->reset,
+					 msecs_to_jiffies(5*1000))) {
+		MM7150_ERR("Failed to receive reset irq");
+		ret = -EIO;
+		goto err_device_unregister;
+	}
+#else
+	{
+		uint8_t *rsp;
+		struct i2c_msg msg[1];
+
+		rsp = kzalloc(__le16_to_cpu(data->hid_desc.wMaxInputLength),
+			      GFP_KERNEL);
+		if (!rsp) {
+			ret = -ENOMEM;
+			goto err_device_unregister;
+		}
+
+		msg[0].addr = data->client->addr;
+		msg[0].flags = I2C_M_RD;
+		msg[0].len = __le16_to_cpu(data->hid_desc.wMaxInputLength);
+		msg[0].buf = rsp;
+
+		msleep(1000); /* wait for reset to complete */
+
+		ret = i2c_transfer(data->client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret != ARRAY_SIZE(msg)) {
+			MM7150_ERR("failed to read data after reset");
+			kfree(rsp);
+			ret = -EIO;
+			goto err_device_unregister;
+		}
+
+		/*
+		 * on reset the device writes the sentinel value 0x0000 to the
+		 * Input Register length field
+		 */
+		if ((rsp[0] == 0) && (rsp[1] == 0)) {
+			MM7150_DBG("reset successful");
+		} else {
+			MM7150_DBG("reset failed");
+			ret = -1;
+			kfree(rsp);
+			goto err_device_unregister;
+		}
+
+		kfree(rsp);
+	}
+#endif
+
+	ret = mm7150_hid_report_desc_read(data);
+	if (ret)
+		goto err_device_unregister;
+
+	/* get sensor feature reports */
+	for (i = MM7150_RPT_ID_ACC;
+		i < MM7150_RPT_ID_MAX; ++i) {
+		ret = mm7150_hid_get_report(data,
+					    HID_REPORT_TYPE_FEATURE,
+					    i,
+					    (uint8_t *)&data->feature[i-1],
+					    sizeof(struct mm7150_hid_feat_rpt));
+		if (ret)
+			goto err_device_unregister;
+
+		MM7150_DBG("feature report id:%d", i);
+		mm7150_hid_feature_report_parse(data,
+						HID_REPORT_TYPE_FEATURE,
+						&data->feature[i-1]);
+	}
+
+	dev_info(&data->client->dev, "iio driver initialized\n");
+
+	return 0;
+
+err_device_unregister:
+	iio_device_unregister(indio_dev);
+
+err_trigger_unregister:
+	if (data->trig)
+		iio_trigger_unregister(data->trig);
+
+err_buffer_cleanup:
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+		iio_triggered_buffer_cleanup(indio_dev);
+
+	return ret;
+}
+
+static int mm7150_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mm7150_data *data = iio_priv(indio_dev);
+
+	MM7150_DBG("enter");
+
+	iio_device_unregister(indio_dev);
+
+	if (data->trig)
+		iio_trigger_unregister(data->trig);
+
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+		iio_triggered_buffer_cleanup(indio_dev);
+
+	return 0;
+}
+
+static struct i2c_device_id mm7150_id_table[] = {
+	{ "mm7150", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, mm7150_id_table);
+
+#ifdef CONFIG_OF
+static const struct of_device_id mm7150_match_table[] = {
+	{ .compatible = "microchip,mm7150", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mm7150_match_table);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id mm7150_acpi_match[] = {
+	{ "MM7150", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, mm7150_acpi_match);
+#endif
+
+static struct i2c_driver mm7150_driver = {
+	.driver = {
+		.name = "mm7150",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mm7150_match_table),
+		.acpi_match_table = ACPI_PTR(mm7150_acpi_match),
+	},
+	.probe = mm7150_probe,
+	.remove = mm7150_remove,
+	.id_table = mm7150_id_table,
+};
+module_i2c_driver(mm7150_driver);
+
+MODULE_AUTHOR("Lucas Magasweran <lucas.magasweran@daqri.com>");
+MODULE_DESCRIPTION("Microchip MM7150 IIO I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.5.0


