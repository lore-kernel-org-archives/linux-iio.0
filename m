Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64647 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab3I0Qc2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:28 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 07/14] iio: st_accel: Add event subsystem to st_accel
 driver
Date: Fri, 27 Sep 2013 18:32:11 +0200
Message-id: <1380299538-22047-8-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds event support for iio st_accel driver.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/accel/st_accel_core.c |   96 ++++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 57e63bf..ec5f7ed 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/buffer.h>
@@ -68,6 +69,20 @@
 #define ST_ACCEL_1_DRDY_IRQ_INT1_MASK		0x10
 #define ST_ACCEL_1_DRDY_IRQ_INT2_MASK		0x08
 #define ST_ACCEL_1_MULTIREAD_BIT		true
+#define ST_ACCEL_1_EVENT_IRQ_ADDR		0x22
+#define ST_ACCEL_1_EVENT_IRQ_MASK		0x40
+#define ST_ACCEL_1_EVENT_CTRL_REG		0x30
+#define ST_ACCEL_1_EVENT_CTRL_MASK		0xc0
+#define ST_ACCEL_1_EVENT_CTRL_DEFAULT_VAL	0x01
+#define ST_ACCEL_1_THS_REG			0x32
+#define ST_ACCEL_1_EVENT_STATUS_REG		0x31
+#define ST_ACCEL_1_EVENT_STATUS_REG_MASK	0x7f
+#define ST_ACCEL_1_INT1_XL			0
+#define ST_ACCEL_1_INT1_XH			1
+#define ST_ACCEL_1_INT1_YL			2
+#define ST_ACCEL_1_INT1_YH			3
+#define ST_ACCEL_1_INT1_ZL			4
+#define ST_ACCEL_1_INT1_ZH			5
 
 /* CUSTOM VALUES FOR SENSOR 2 */
 #define ST_ACCEL_2_WAI_EXP			0x32
@@ -129,6 +144,19 @@
 #define ST_ACCEL_3_IG1_EN_MASK			0x08
 #define ST_ACCEL_3_MULTIREAD_BIT		false
 
+#define ST_SENSORS_LSM_ACCEL_EVENT(mod, dir, bit_pos, ths_reg) \
+{ \
+	.bit = bit_pos,\
+	.chan_type = IIO_ACCEL, \
+	.modifier = mod, \
+	.event_type = IIO_EV_TYPE_THRESH, \
+	.direction = dir, \
+	.event_ths_reg = { \
+		.addr = ths_reg, \
+		.mask = 0x7f, \
+	}, \
+}
+
 static const struct iio_chan_spec st_accel_12bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
@@ -230,6 +258,46 @@ static const struct st_sensors st_accel_sensors[] = {
 			.mask_int1 = ST_ACCEL_1_DRDY_IRQ_INT1_MASK,
 			.mask_int2 = ST_ACCEL_1_DRDY_IRQ_INT2_MASK,
 		},
+		.event_irq = {
+			.addr = ST_ACCEL_1_EVENT_IRQ_ADDR,
+			.mask = ST_ACCEL_1_EVENT_IRQ_MASK,
+			.event_count = 6,
+			.ctrl_reg = {
+				.addr = ST_ACCEL_1_EVENT_CTRL_REG,
+				.mask = ST_ACCEL_1_EVENT_CTRL_MASK,
+				.val = ST_ACCEL_1_EVENT_CTRL_DEFAULT_VAL,
+			},
+			.status_reg = {
+				.addr = ST_ACCEL_1_EVENT_STATUS_REG,
+				.mask = ST_ACCEL_1_EVENT_STATUS_REG_MASK,
+			},
+			.events = {
+				ST_SENSORS_LSM_ACCEL_EVENT(IIO_MOD_X,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_1_INT1_XL,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(IIO_MOD_X,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_1_INT1_XH,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(IIO_MOD_Y,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_1_INT1_YL,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(IIO_MOD_Y,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_1_INT1_YH,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(IIO_MOD_Z,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_1_INT1_ZL,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(IIO_MOD_Z,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_1_INT1_ZH,
+						ST_ACCEL_1_THS_REG),
+			},
+		},
 		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
 		.bootime = 2,
 	},
@@ -437,6 +505,10 @@ static const struct iio_info accel_info = {
 	.attrs = &st_accel_attribute_group,
 	.read_raw = &st_accel_read_raw,
 	.write_raw = &st_accel_write_raw,
+	.read_event_value = &st_sensors_read_event_value,
+	.write_event_value = &st_sensors_write_event_value,
+	.read_event_config = &st_sensors_read_event_config,
+	.write_event_config = &st_sensors_write_event_config,
 };
 
 #ifdef CONFIG_IIO_TRIGGER
@@ -452,7 +524,6 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
-	int irq = adata->get_irq_data_ready(indio_dev);
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -483,13 +554,24 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		return err;
 
-	if (irq > 0) {
+	if (adata->get_irq_data_ready(indio_dev) > 0) {
 		err = st_sensors_allocate_trigger(indio_dev,
 						 ST_ACCEL_TRIGGER_OPS);
 		if (err < 0)
 			goto st_accel_probe_trigger_error;
 	}
 
+	if (adata->get_irq_event(indio_dev) > 0) {
+		adata->events_enabled = true;
+		err = st_sensors_request_event_irq(indio_dev);
+		if (err < 0)
+			goto st_accel_request_irq_event_error;
+
+		err = st_sensors_enable_events(indio_dev);
+		if (err < 0)
+			goto st_accel_enable_events_error;
+	}
+
 	err = iio_device_register(indio_dev);
 	if (err)
 		goto st_accel_device_register_error;
@@ -497,9 +579,11 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	return 0;
 
 st_accel_device_register_error:
-	if (irq > 0)
+st_accel_enable_events_error:
+	if (adata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 st_accel_probe_trigger_error:
+st_accel_request_irq_event_error:
 	st_accel_deallocate_ring(indio_dev);
 
 	return err;
@@ -511,10 +595,10 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (adata->get_irq_data_ready(indio_dev) > 0)
+	if (adata->get_irq_data_ready(indio_dev) > 0) {
 		st_sensors_deallocate_trigger(indio_dev);
-
-	st_accel_deallocate_ring(indio_dev);
+		st_accel_deallocate_ring(indio_dev);
+	}
 }
 EXPORT_SYMBOL(st_accel_common_remove);
 
-- 
1.7.9.5

