Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32005 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3GBMQ0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 08:16:26 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MPB009R462P1Y40@mailout1.w1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 02 Jul 2013 13:16:25 +0100 (BST)
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@kernel.org, denis.ciocca@st.com
Cc: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Lukasz Czerwinski <l.czerwinski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 3/4] iio: accel: Add event subsystem to st_accel driver
Date: Tue, 02 Jul 2013 14:15:37 +0200
Message-id: <1372767338-13179-4-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
References: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds event support for iio st_accel driver.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../bindings/iio/accelerometer/st_accel.txt        |    1 +
 drivers/iio/accel/st_accel_core.c                  |  149 ++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt b/Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt
index 9eab7d9..f461a77 100644
--- a/Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt
+++ b/Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt
@@ -21,6 +21,7 @@ Optional properties:
   - interrupt-parent : phandle to the interrupt map subnode
   - interrupts : interrupt mapping for st_accel interrupt sources:
 	0: INT1 irq_data_ready
+	1: INT2 irq_event
   - irq-map : irq sub-node defining interrupt map
               (all properties listed below are required):
       - #interrupt-cells : should be 1
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 385cd86..983e8c4 100644
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
@@ -93,6 +108,20 @@
 #define ST_ACCEL_2_DRDY_IRQ_INT1_MASK		0x02
 #define ST_ACCEL_2_DRDY_IRQ_INT2_MASK		0x10
 #define ST_ACCEL_2_MULTIREAD_BIT		true
+#define ST_ACCEL_2_EVENT_IRQ_ADDR		0x22
+#define ST_ACCEL_2_EVENT_IRQ_MASK		0x01
+#define ST_ACCEL_2_EVENT_CTRL_REG		0x30
+#define ST_ACCEL_2_EVENT_CTRL_MASK		0xc0
+#define ST_ACCEL_2_EVENT_CTRL_DEFAULT_VAL	0x01
+#define ST_ACCEL_2_THS_REG			0x32
+#define ST_ACCEL_2_EVENT_STATUS_REG		0x31
+#define ST_ACCEL_2_EVENT_STATUS_REG_MASK	0x7f
+#define ST_ACCEL_2_INT1_XL			0
+#define ST_ACCEL_2_INT1_XH			1
+#define ST_ACCEL_2_INT1_YL			2
+#define ST_ACCEL_2_INT1_YH			3
+#define ST_ACCEL_2_INT1_ZL			4
+#define ST_ACCEL_2_INT1_ZH			5
 
 /* CUSTOM VALUES FOR SENSOR 3 */
 #define ST_ACCEL_3_WAI_EXP			0x40
@@ -129,6 +158,20 @@
 #define ST_ACCEL_3_IG1_EN_MASK			0x08
 #define ST_ACCEL_3_MULTIREAD_BIT		false
 
+#define ST_SENSORS_LSM_ACCEL_EVENT(ch, mod, dir, bit_pos, ths_reg) \
+{ \
+	.bit = bit_pos,\
+	.chan = ch, \
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
@@ -232,6 +275,46 @@ static const struct st_sensors st_accel_sensors[] = {
 		},
 		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
 		.bootime = 2,
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
+				ST_SENSORS_LSM_ACCEL_EVENT(0, IIO_MOD_X,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_1_INT1_XL,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(0, IIO_MOD_X,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_1_INT1_XH,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(1, IIO_MOD_Y,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_1_INT1_YL,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(1, IIO_MOD_Y,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_1_INT1_YH,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(2, IIO_MOD_Z,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_1_INT1_ZL,
+						ST_ACCEL_1_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(2, IIO_MOD_Z,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_1_INT1_ZH,
+						ST_ACCEL_1_THS_REG),
+			},
+		},
 	},
 	{
 		.wai = ST_ACCEL_2_WAI_EXP,
@@ -294,6 +377,47 @@ static const struct st_sensors st_accel_sensors[] = {
 		},
 		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
 		.bootime = 2,
+		.event_irq = {
+			.addr = ST_ACCEL_2_EVENT_IRQ_ADDR,
+			.mask = ST_ACCEL_2_EVENT_IRQ_MASK,
+			.event_count = 6,
+			.ctrl_reg = {
+				.addr = ST_ACCEL_2_EVENT_CTRL_REG,
+				.mask = ST_ACCEL_2_EVENT_CTRL_MASK,
+				.val = ST_ACCEL_2_EVENT_CTRL_DEFAULT_VAL,
+			},
+			.status_reg = {
+				.addr = ST_ACCEL_2_EVENT_STATUS_REG,
+				.mask = ST_ACCEL_2_EVENT_STATUS_REG_MASK,
+			},
+			.events = {
+				ST_SENSORS_LSM_ACCEL_EVENT(0, IIO_MOD_X,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_2_INT1_XL,
+						ST_ACCEL_2_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(0, IIO_MOD_X,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_2_INT1_XH,
+						ST_ACCEL_2_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(1, IIO_MOD_Y,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_2_INT1_YL,
+						ST_ACCEL_2_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(1, IIO_MOD_Y,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_2_INT1_YH,
+						ST_ACCEL_2_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(2, IIO_MOD_Z,
+						IIO_EV_DIR_FALLING,
+						ST_ACCEL_2_INT1_ZL,
+						ST_ACCEL_2_THS_REG),
+				ST_SENSORS_LSM_ACCEL_EVENT(2, IIO_MOD_Z,
+						IIO_EV_DIR_RISING,
+						ST_ACCEL_2_INT1_ZH,
+						ST_ACCEL_2_THS_REG),
+			},
+		},
+
 	},
 	{
 		.wai = ST_ACCEL_3_WAI_EXP,
@@ -437,6 +561,10 @@ static const struct iio_info accel_info = {
 	.attrs = &st_accel_attribute_group,
 	.read_raw = &st_accel_read_raw,
 	.write_raw = &st_accel_write_raw,
+	.read_event_value = &st_sensors_read_event_value,
+	.write_event_value = &st_sensors_write_event_value,
+	.read_event_config = &st_sensors_read_event_config,
+	.write_event_config = &st_sensors_write_event_config,
 };
 
 #ifdef CONFIG_IIO_TRIGGER
@@ -452,6 +580,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	int err;
+	int i;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -489,6 +618,20 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 			goto st_accel_probe_trigger_error;
 	}
 
+	if (adata->get_irq_event(indio_dev) > 0) {
+		err = st_sensors_request_event_irq(indio_dev);
+		if (err < 0)
+			goto st_accel_request_irq_event_error;
+
+		for (i = 0; i < indio_dev->num_channels; i++)
+			adata->sensor->ch[i].event_mask =
+				ST_SENSORS_LSM_EVENTS_MASK;
+
+		err = st_sensors_enable_events(indio_dev);
+		if (err < 0)
+			goto st_accel_enable_events_error;
+	}
+
 	err = iio_device_register(indio_dev);
 	if (err)
 		goto st_accel_device_register_error;
@@ -496,6 +639,10 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	return err;
 
 st_accel_device_register_error:
+st_accel_enable_events_error:
+	if (adata->get_irq_event(indio_dev) > 0)
+		free_irq(adata->get_irq_event(indio_dev), indio_dev);
+st_accel_request_irq_event_error:
 	if (adata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 st_accel_probe_trigger_error:
@@ -515,6 +662,8 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 		st_accel_deallocate_ring(indio_dev);
 	}
+	if (adata->get_irq_event(indio_dev) > 0)
+		free_irq(adata->get_irq_event(indio_dev), indio_dev);
 	iio_device_free(indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_remove);
-- 
1.7.9.5

