Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16235 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab3HPNMa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2013 09:12:30 -0400
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH/RFC v4 2/3] iio: gp2ap020a00f: Add a driver for the device
Date: Fri, 16 Aug 2013 15:12:19 +0200
Message-id: <1376658739-3417-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a new driver for the ambient light/proximity sensor
device. The driver exposes three channels: light_clear
light_ir and proximity. It also supports triggered buffer,
high and low ambient light threshold event and proximity
detection events.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/light/Kconfig        |   12 +
 drivers/iio/light/Makefile       |    1 +
 drivers/iio/light/gp2ap020a00f.c | 1470 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1483 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iio/light/gp2ap020a00f.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index bf9fa0d..0b809a6 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -27,6 +27,18 @@ config APDS9300
 	 To compile this driver as a module, choose M here: the
 	 module will be called apds9300.
 
+config GP2AP020A00F
+	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here if you have a Sharp GP2AP020A00F proximity/als combo-chip
+	  hooked to an I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gp2ap020a00f.
+
 config HID_SENSOR_ALS
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 354ee9a..2eb6294 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -5,6 +5,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
+obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
 obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
new file mode 100644
index 0000000..2ecb738
--- /dev/null
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -0,0 +1,1470 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ * Author: Jacek Anaszewski <j.anaszewski@samsung.com>
+ *
+ * IIO features supported by the driver:
+ *
+ * Read-only raw channels:
+ *   - illiminance_clear
+ *   - illiminance_ir
+ *   - proximity
+ *
+ * Triggered buffer:
+ *   - illiminance_clear
+ *   - illiminance_ir
+ *   - proximity
+ *
+ * Events:
+ *   - illuminance_clear (rising and falling)
+ *   - proximity (rising and falling)
+ *     - both falling and rising thresholds for the proximity events
+ *       must be set to the values greater than 0 - if they aren't they
+ *       will be adjusted respectively to 10 and 11 upon enabling an event.
+ *
+ * The driver supports triggered buffers for all the three
+ * channels as well as rising and falling events for the
+ * illuminance_clear and proxmimity channels. Triggers
+ * can be enabled simultaneously with both illuminance_clear
+ * events. Proximity events cannot be enabled simultaneously
+ * with any triggers or illuminance events. Enabling/disabling
+ * one of the proximity events automatically enables/disables
+ * the other one.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+#include <linux/debugfs.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define GP2A_I2C_NAME "gp2ap020a00f"
+
+/* Registers */
+#define GP2AP020A00F_OP_REG	0x00 /* Basic operations */
+#define GP2AP020A00F_ALS_REG	0x01 /* ALS related settings */
+#define GP2AP020A00F_PS_REG	0x02 /* PS related settings */
+#define GP2AP020A00F_LED_REG	0x03 /* LED reg */
+#define GP2AP020A00F_TL_L_REG	0x04 /* ALS: Threshold low LSB */
+#define GP2AP020A00F_TL_H_REG	0x05 /* ALS: Threshold low MSB */
+#define GP2AP020A00F_TH_L_REG	0x06 /* ALS: Threshold high LSB */
+#define GP2AP020A00F_TH_H_REG	0x07 /* ALS: Threshold high MSB */
+#define GP2AP020A00F_PL_L_REG	0x08 /* PS: Threshold low LSB */
+#define GP2AP020A00F_PL_H_REG	0x09 /* PS: Threshold low MSB */
+#define GP2AP020A00F_PH_L_REG	0x0a /* PS: Threshold high LSB */
+#define GP2AP020A00F_PH_H_REG	0x0b /* PS: Threshold high MSB */
+#define GP2AP020A00F_D0_L_REG	0x0c /* ALS result: Clear/Illuminance LSB */
+#define GP2AP020A00F_D0_H_REG	0x0d /* ALS result: Clear/Illuminance MSB */
+#define GP2AP020A00F_D1_L_REG	0x0e /* ALS result: IR LSB */
+#define GP2AP020A00F_D1_H_REG	0x0f /* ALS result: IR LSB */
+#define GP2AP020A00F_D2_L_REG	0x10 /* PS result LSB */
+#define GP2AP020A00F_D2_H_REG	0x11 /* PS result MSB */
+#define GP2AP020A00F_NUM_REGS	0x12 /* Number of registers */
+
+/* OP_REG bits */
+#define GP2AP020A00F_OP3_MASK		0x80 /* Software shutdown */
+#define GP2AP020A00F_OP3_SHUTDOWN	0x00
+#define GP2AP020A00F_OP3_OPERATION	0x80
+#define GP2AP020A00F_OP2_MASK		0x40 /* Auto shutdown/Continuous mode */
+#define GP2AP020A00F_OP2_AUTO_SHUTDOWN	0x00
+#define GP2AP020A00F_OP2_CONT_OPERATION	0x40
+#define GP2AP020A00F_OP_MASK		0x30 /* Operating mode selection  */
+#define GP2AP020A00F_OP_ALS_AND_PS	0x00
+#define GP2AP020A00F_OP_ALS		0x10
+#define GP2AP020A00F_OP_PS		0x20
+#define GP2AP020A00F_OP_DEBUG		0x30
+#define GP2AP020A00F_PROX_MASK		0x08 /* PS: detection/non-detection */
+#define GP2AP020A00F_PROX_NON_DETECT	0x00
+#define GP2AP020A00F_PROX_DETECT	0x08
+#define GP2AP020A00F_FLAG_P		0x04 /* PS: interrupt result  */
+#define GP2AP020A00F_FLAG_A		0x02 /* ALS: interrupt result  */
+#define GP2AP020A00F_TYPE_MASK		0x01 /* Output data type selection */
+#define GP2AP020A00F_TYPE_MANUAL_CALC	0x00
+#define GP2AP020A00F_TYPE_AUTO_CALC	0x01
+
+/* ALS_REG bits */
+#define GP2AP020A00F_PRST_MASK		0xc0 /* Number of measurement cycles */
+#define GP2AP020A00F_PRST_ONCE		0x00
+#define GP2AP020A00F_PRST_4_CYCLES	0x40
+#define GP2AP020A00F_PRST_8_CYCLES	0x80
+#define GP2AP020A00F_PRST_16_CYCLES	0xc0
+#define GP2AP020A00F_RES_A_MASK		0x38 /* ALS: Resolution */
+#define GP2AP020A00F_RES_A_800ms	0x00
+#define GP2AP020A00F_RES_A_400ms	0x08
+#define GP2AP020A00F_RES_A_200ms	0x10
+#define GP2AP020A00F_RES_A_100ms	0x18
+#define GP2AP020A00F_RES_A_25ms		0x20
+#define GP2AP020A00F_RES_A_6_25ms	0x28
+#define GP2AP020A00F_RES_A_1_56ms	0x30
+#define GP2AP020A00F_RES_A_0_39ms	0x38
+#define GP2AP020A00F_RANGE_A_MASK	0x07 /* ALS: Max measurable range */
+#define GP2AP020A00F_RANGE_A_x1		0x00
+#define GP2AP020A00F_RANGE_A_x2		0x01
+#define GP2AP020A00F_RANGE_A_x4		0x02
+#define GP2AP020A00F_RANGE_A_x8		0x03
+#define GP2AP020A00F_RANGE_A_x16	0x04
+#define GP2AP020A00F_RANGE_A_x32	0x05
+#define GP2AP020A00F_RANGE_A_x64	0x06
+#define GP2AP020A00F_RANGE_A_x128	0x07
+
+/* PS_REG bits */
+#define GP2AP020A00F_ALC_MASK		0x80 /* Auto light cancel */
+#define GP2AP020A00F_ALC_ON		0x80
+#define GP2AP020A00F_ALC_OFF		0x00
+#define GP2AP020A00F_INTTYPE_MASK	0x40 /* Interrupt type setting */
+#define GP2AP020A00F_INTTYPE_LEVEL	0x00
+#define GP2AP020A00F_INTTYPE_PULSE	0x40
+#define GP2AP020A00F_RES_P_MASK		0x38 /* PS: Resolution */
+#define GP2AP020A00F_RES_P_800ms_x2	0x00
+#define GP2AP020A00F_RES_P_400ms_x2	0x08
+#define GP2AP020A00F_RES_P_200ms_x2	0x10
+#define GP2AP020A00F_RES_P_100ms_x2	0x18
+#define GP2AP020A00F_RES_P_25ms_x2	0x20
+#define GP2AP020A00F_RES_P_6_25ms_x2	0x28
+#define GP2AP020A00F_RES_P_1_56ms_x2	0x30
+#define GP2AP020A00F_RES_P_0_39ms_x2	0x38
+#define GP2AP020A00F_RANGE_P_MASK	0x07 /* PS: Max measurable range */
+#define GP2AP020A00F_RANGE_P_x1		0x00
+#define GP2AP020A00F_RANGE_P_x2		0x01
+#define GP2AP020A00F_RANGE_P_x4		0x02
+#define GP2AP020A00F_RANGE_P_x8		0x03
+#define GP2AP020A00F_RANGE_P_x16	0x04
+#define GP2AP020A00F_RANGE_P_x32	0x05
+#define GP2AP020A00F_RANGE_P_x64	0x06
+#define GP2AP020A00F_RANGE_P_x128	0x07
+
+/* LED reg bits */
+#define GP2AP020A00F_INTVAL_MASK	0xc0 /* Intermittent operating */
+#define GP2AP020A00F_INTVAL_0		0x00
+#define GP2AP020A00F_INTVAL_4		0x40
+#define GP2AP020A00F_INTVAL_8		0x80
+#define GP2AP020A00F_INTVAL_16		0xc0
+#define GP2AP020A00F_IS_MASK		0x30 /* ILED drive peak current */
+#define GP2AP020A00F_IS_13_8mA		0x00
+#define GP2AP020A00F_IS_27_5mA		0x10
+#define GP2AP020A00F_IS_55mA		0x20
+#define GP2AP020A00F_IS_110mA		0x30
+#define GP2AP020A00F_PIN_MASK		0x0c /* INT terminal setting */
+#define GP2AP020A00F_PIN_ALS_OR_PS	0x00
+#define GP2AP020A00F_PIN_ALS		0x04
+#define GP2AP020A00F_PIN_PS		0x08
+#define GP2AP020A00F_PIN_PS_DETECT	0x0c
+#define GP2AP020A00F_FREQ_MASK		0x02 /* LED modulation frequency */
+#define GP2AP020A00F_FREQ_327_5kHz	0x00
+#define GP2AP020A00F_FREQ_81_8kHz	0x02
+#define GP2AP020A00F_RST		0x01 /* Software reset */
+
+#define GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR	0
+#define GP2AP020A00F_SCAN_MODE_LIGHT_IR		1
+#define GP2AP020A00F_SCAN_MODE_PROXIMITY	2
+#define GP2AP020A00F_CHAN_TIMESTAMP		3
+
+#define GP2AP020A00F_DATA_READY_TIMEOUT		msecs_to_jiffies(1000)
+
+#define GP2AP020A00F_DATA_REG(chan)		(GP2AP020A00F_D0_L_REG + \
+							(chan) * 2)
+#define GP2AP020A00F_THRESH_VAL_ID(reg_addr)	((reg_addr - 4) / 2)
+
+#define GP2AP020A00F_SUBTRACT_MODE	0
+#define GP2AP020A00F_ADD_MODE		1
+
+#define GP2AP020A00F_MAX_CHANNELS	3
+
+enum gp2ap020a00f_opmode {
+	GP2AP020A00F_OPMODE_READ_RAW_CLEAR,
+	GP2AP020A00F_OPMODE_READ_RAW_IR,
+	GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY,
+	GP2AP020A00F_OPMODE_ALS,
+	GP2AP020A00F_OPMODE_PS,
+	GP2AP020A00F_OPMODE_ALS_AND_PS,
+	GP2AP020A00F_OPMODE_PROX_DETECT,
+	GP2AP020A00F_OPMODE_SHUTDOWN,
+	GP2AP020A00F_NUM_OPMODES,
+};
+
+enum gp2ap020a00f_cmd {
+	GP2AP020A00F_CMD_READ_RAW_CLEAR,
+	GP2AP020A00F_CMD_READ_RAW_IR,
+	GP2AP020A00F_CMD_READ_RAW_PROXIMITY,
+	GP2AP020A00F_CMD_TRIGGER_CLEAR_EN,
+	GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS,
+	GP2AP020A00F_CMD_TRIGGER_IR_EN,
+	GP2AP020A00F_CMD_TRIGGER_IR_DIS,
+	GP2AP020A00F_CMD_TRIGGER_PROX_EN,
+	GP2AP020A00F_CMD_TRIGGER_PROX_DIS,
+	GP2AP020A00F_CMD_ALS_HIGH_EV_EN,
+	GP2AP020A00F_CMD_ALS_HIGH_EV_DIS,
+	GP2AP020A00F_CMD_ALS_LOW_EV_EN,
+	GP2AP020A00F_CMD_ALS_LOW_EV_DIS,
+	GP2AP020A00F_CMD_PROX_HIGH_EV_EN,
+	GP2AP020A00F_CMD_PROX_HIGH_EV_DIS,
+	GP2AP020A00F_CMD_PROX_LOW_EV_EN,
+	GP2AP020A00F_CMD_PROX_LOW_EV_DIS,
+};
+
+enum gp2ap020a00f_flags {
+	GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER,
+	GP2AP020A00F_FLAG_ALS_IR_TRIGGER,
+	GP2AP020A00F_FLAG_PROX_TRIGGER,
+	GP2AP020A00F_FLAG_PROX_RISING_EVENT,
+	GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
+	GP2AP020A00F_FLAG_ALS_RISING_EVENT,
+	GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
+	GP2AP020A00F_FLAG_LUX_MODE_HIGH,
+};
+
+enum gp2ap020a00f_thresh_buf_id {
+	GP2AP020A00F_THRESH_TL,
+	GP2AP020A00F_THRESH_TH,
+	GP2AP020A00F_THRESH_PL,
+	GP2AP020A00F_THRESH_PH,
+};
+
+struct gp2ap020a00f_data {
+	const struct gp2ap020a00f_platform_data *pdata;
+	struct i2c_client *client;
+	struct mutex lock;
+	char *buffer;
+	struct regulator *vled_reg;
+	unsigned long flags;
+	enum gp2ap020a00f_opmode cur_opmode;
+	struct iio_trigger *trig;
+	struct regmap *regmap;
+	unsigned int thresh_reg_val[4];
+	u8 debug_reg_addr;
+};
+
+static const u8 gp2ap020a00f_reg_init_tab[] = {
+	[GP2AP020A00F_OP_REG] = GP2AP020A00F_OP3_SHUTDOWN,
+	[GP2AP020A00F_ALS_REG] = GP2AP020A00F_RES_A_25ms |
+				 GP2AP020A00F_RANGE_A_x8,
+	[GP2AP020A00F_PS_REG] = GP2AP020A00F_ALC_ON |
+				GP2AP020A00F_RES_P_1_56ms_x2 |
+				GP2AP020A00F_RANGE_P_x4,
+	[GP2AP020A00F_LED_REG] = GP2AP020A00F_INTVAL_0 |
+				 GP2AP020A00F_IS_110mA |
+				 GP2AP020A00F_FREQ_327_5kHz,
+	[GP2AP020A00F_TL_L_REG] = 0,
+	[GP2AP020A00F_TL_H_REG] = 0,
+	[GP2AP020A00F_TH_L_REG] = 0,
+	[GP2AP020A00F_TH_H_REG] = 0,
+	[GP2AP020A00F_PL_L_REG] = 0,
+	[GP2AP020A00F_PL_H_REG] = 0,
+	[GP2AP020A00F_PH_L_REG] = 0,
+	[GP2AP020A00F_PH_H_REG] = 0,
+};
+
+static bool gp2ap020a00f_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case GP2AP020A00F_OP_REG:
+	case GP2AP020A00F_D0_L_REG:
+	case GP2AP020A00F_D0_H_REG:
+	case GP2AP020A00F_D1_L_REG:
+	case GP2AP020A00F_D1_H_REG:
+	case GP2AP020A00F_D2_L_REG:
+	case GP2AP020A00F_D2_H_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config gp2ap020a00f_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = GP2AP020A00F_D2_H_REG,
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = gp2ap020a00f_is_volatile_reg,
+};
+
+static const struct gp2ap020a00f_mutable_config_regs {
+	u8 op_reg;
+	u8 als_reg;
+	u8 ps_reg;
+	u8 led_reg;
+} opmode_regs_settings[GP2AP020A00F_NUM_OPMODES] = {
+	[GP2AP020A00F_OPMODE_READ_RAW_CLEAR] = {
+			GP2AP020A00F_OP_ALS | GP2AP020A00F_OP2_AUTO_SHUTDOWN
+			| GP2AP020A00F_OP3_OPERATION
+			| GP2AP020A00F_TYPE_MANUAL_CALC,
+			GP2AP020A00F_PRST_ONCE,
+			GP2AP020A00F_INTTYPE_LEVEL,
+			GP2AP020A00F_PIN_ALS
+	},
+	[GP2AP020A00F_OPMODE_READ_RAW_IR] = {
+			GP2AP020A00F_OP_ALS | GP2AP020A00F_OP2_AUTO_SHUTDOWN
+			| GP2AP020A00F_OP3_OPERATION
+			| GP2AP020A00F_TYPE_MANUAL_CALC,
+			GP2AP020A00F_PRST_ONCE,
+			GP2AP020A00F_INTTYPE_LEVEL,
+			GP2AP020A00F_PIN_ALS
+	},
+	[GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY] = {
+			GP2AP020A00F_OP_PS | GP2AP020A00F_OP2_AUTO_SHUTDOWN
+			| GP2AP020A00F_OP3_OPERATION
+			| GP2AP020A00F_TYPE_MANUAL_CALC,
+			GP2AP020A00F_PRST_ONCE,
+			GP2AP020A00F_INTTYPE_LEVEL,
+			GP2AP020A00F_PIN_PS
+	},
+	[GP2AP020A00F_OPMODE_PROX_DETECT] = {
+			GP2AP020A00F_OP_PS | GP2AP020A00F_OP2_CONT_OPERATION
+			| GP2AP020A00F_OP3_OPERATION
+			| GP2AP020A00F_TYPE_MANUAL_CALC,
+			GP2AP020A00F_PRST_4_CYCLES,
+			GP2AP020A00F_INTTYPE_PULSE,
+			GP2AP020A00F_PIN_PS_DETECT
+	},
+	[GP2AP020A00F_OPMODE_ALS] = {
+			GP2AP020A00F_OP_ALS | GP2AP020A00F_OP2_CONT_OPERATION
+			| GP2AP020A00F_OP3_OPERATION
+			| GP2AP020A00F_TYPE_MANUAL_CALC,
+			GP2AP020A00F_PRST_ONCE,
+			GP2AP020A00F_INTTYPE_LEVEL,
+			GP2AP020A00F_PIN_ALS
+	},
+	[GP2AP020A00F_OPMODE_PS] = {
+			GP2AP020A00F_OP_PS | GP2AP020A00F_OP2_CONT_OPERATION
+			| GP2AP020A00F_OP3_OPERATION
+			| GP2AP020A00F_TYPE_MANUAL_CALC,
+			GP2AP020A00F_PRST_4_CYCLES,
+			GP2AP020A00F_INTTYPE_LEVEL,
+			GP2AP020A00F_PIN_PS
+	},
+	[GP2AP020A00F_OPMODE_ALS_AND_PS] = {
+			GP2AP020A00F_OP_ALS_AND_PS
+			| GP2AP020A00F_OP2_CONT_OPERATION
+			| GP2AP020A00F_OP3_OPERATION
+			| GP2AP020A00F_TYPE_MANUAL_CALC,
+			GP2AP020A00F_PRST_4_CYCLES,
+			GP2AP020A00F_INTTYPE_LEVEL,
+			GP2AP020A00F_PIN_ALS_OR_PS
+	},
+	[GP2AP020A00F_OPMODE_SHUTDOWN] = {
+			GP2AP020A00F_OP3_SHUTDOWN,
+	},
+};
+
+static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
+					enum gp2ap020a00f_opmode op)
+{
+	unsigned int op_reg_val;
+	int err;
+
+	if (op != GP2AP020A00F_OPMODE_SHUTDOWN) {
+		err = regmap_read(data->regmap, GP2AP020A00F_OP_REG,
+					&op_reg_val);
+		if (err < 0)
+			return err;
+		/*
+		 * Shutdown the device if the operation being executed entails
+		 * mode transition.
+		 */
+		if ((opmode_regs_settings[op].op_reg & GP2AP020A00F_OP_MASK) !=
+		    (op_reg_val & GP2AP020A00F_OP_MASK)) {
+			/* set shutdown mode */
+			err = regmap_update_bits(data->regmap,
+				GP2AP020A00F_OP_REG, GP2AP020A00F_OP3_MASK,
+				GP2AP020A00F_OP3_SHUTDOWN);
+			if (err < 0)
+				return err;
+		}
+
+		err = regmap_update_bits(data->regmap, GP2AP020A00F_ALS_REG,
+			GP2AP020A00F_PRST_MASK, opmode_regs_settings[op]
+								.als_reg);
+		if (err < 0)
+			return err;
+
+		err = regmap_update_bits(data->regmap, GP2AP020A00F_PS_REG,
+			GP2AP020A00F_INTTYPE_MASK, opmode_regs_settings[op]
+								.ps_reg);
+		if (err < 0)
+			return err;
+
+		err = regmap_update_bits(data->regmap, GP2AP020A00F_LED_REG,
+			GP2AP020A00F_PIN_MASK, opmode_regs_settings[op]
+								.led_reg);
+		if (err < 0)
+			return err;
+	}
+
+	/* Set OP_REG and apply operation mode (power on / off) */
+	err = regmap_update_bits(data->regmap,
+				 GP2AP020A00F_OP_REG,
+				 GP2AP020A00F_OP_MASK | GP2AP020A00F_OP2_MASK |
+				 GP2AP020A00F_OP3_MASK | GP2AP020A00F_TYPE_MASK,
+				 opmode_regs_settings[op].op_reg);
+	if (err < 0)
+		return err;
+
+	data->cur_opmode = op;
+
+	return 0;
+}
+
+static bool gp2ap020a00f_als_enabled(struct gp2ap020a00f_data *data)
+{
+	return test_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER,
+							&data->flags) ||
+	       test_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER,
+							&data->flags) ||
+	       test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
+							&data->flags) ||
+	       test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
+							&data->flags);
+}
+
+static bool gp2ap020a00f_prox_detect_enabled(struct gp2ap020a00f_data *data)
+{
+	return test_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT,
+							&data->flags) ||
+	       test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
+							&data->flags);
+}
+
+static int gp2ap020a00f_alter_opmode(struct gp2ap020a00f_data *data,
+			enum gp2ap020a00f_opmode diff_mode, int add_sub)
+{
+	enum gp2ap020a00f_opmode new_mode;
+	int err;
+
+	if (diff_mode != GP2AP020A00F_OPMODE_ALS &&
+	    diff_mode != GP2AP020A00F_OPMODE_PS)
+		return -EINVAL;
+
+	if (add_sub == GP2AP020A00F_ADD_MODE) {
+		if (data->cur_opmode == GP2AP020A00F_OPMODE_SHUTDOWN)
+			new_mode =  diff_mode;
+		else
+			new_mode = GP2AP020A00F_OPMODE_ALS_AND_PS;
+	} else {
+		if (data->cur_opmode == GP2AP020A00F_OPMODE_ALS_AND_PS)
+			new_mode = (diff_mode == GP2AP020A00F_OPMODE_ALS) ?
+					GP2AP020A00F_OPMODE_PS :
+					GP2AP020A00F_OPMODE_ALS;
+		else
+			new_mode = GP2AP020A00F_OPMODE_SHUTDOWN;
+	}
+
+	err = gp2ap020a00f_set_operation_mode(data, new_mode);
+
+	return err;
+}
+
+static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
+					enum gp2ap020a00f_cmd cmd)
+{
+	__le16 thresh_buf = 0;
+	int err = 0;
+
+	switch (cmd) {
+	case GP2AP020A00F_CMD_READ_RAW_CLEAR:
+		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
+			return -EBUSY;
+		err = gp2ap020a00f_set_operation_mode(data,
+					GP2AP020A00F_OPMODE_READ_RAW_CLEAR);
+		break;
+	case GP2AP020A00F_CMD_READ_RAW_IR:
+		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
+			return -EBUSY;
+		err = gp2ap020a00f_set_operation_mode(data,
+					GP2AP020A00F_OPMODE_READ_RAW_IR);
+		break;
+	case GP2AP020A00F_CMD_READ_RAW_PROXIMITY:
+		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
+			return -EBUSY;
+		err = gp2ap020a00f_set_operation_mode(data,
+					GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY);
+		break;
+	case GP2AP020A00F_CMD_TRIGGER_CLEAR_EN:
+		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
+			return -EBUSY;
+		if (!gp2ap020a00f_als_enabled(data))
+			err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_ALS,
+						GP2AP020A00F_ADD_MODE);
+		set_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &data->flags);
+		break;
+	case GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS:
+		clear_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &data->flags);
+		if (gp2ap020a00f_als_enabled(data))
+			break;
+		err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_ALS,
+						GP2AP020A00F_SUBTRACT_MODE);
+		break;
+	case GP2AP020A00F_CMD_TRIGGER_IR_EN:
+		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
+			return -EBUSY;
+		if (!gp2ap020a00f_als_enabled(data))
+			err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_ALS,
+						GP2AP020A00F_ADD_MODE);
+		set_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &data->flags);
+		break;
+	case GP2AP020A00F_CMD_TRIGGER_IR_DIS:
+		clear_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &data->flags);
+		if (gp2ap020a00f_als_enabled(data))
+			break;
+		err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_ALS,
+						GP2AP020A00F_SUBTRACT_MODE);
+		break;
+	case GP2AP020A00F_CMD_TRIGGER_PROX_EN:
+		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
+			return -EBUSY;
+		err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_PS,
+						GP2AP020A00F_ADD_MODE);
+		set_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &data->flags);
+		break;
+	case GP2AP020A00F_CMD_TRIGGER_PROX_DIS:
+		clear_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &data->flags);
+		err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_PS,
+						GP2AP020A00F_SUBTRACT_MODE);
+		break;
+	case GP2AP020A00F_CMD_ALS_HIGH_EV_EN:
+		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
+			return -EBUSY;
+		if (!gp2ap020a00f_als_enabled(data)) {
+			err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_ALS,
+						GP2AP020A00F_ADD_MODE);
+			if (err < 0)
+				return err;
+		}
+		set_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT, &data->flags);
+		thresh_buf = cpu_to_le16(
+				data->thresh_reg_val[GP2AP020A00F_THRESH_TH]);
+		err = regmap_bulk_write(data->regmap, GP2AP020A00F_TH_L_REG,
+						(u8 *)&thresh_buf, 2);
+		break;
+	case GP2AP020A00F_CMD_ALS_HIGH_EV_DIS:
+		clear_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT, &data->flags);
+		if (!gp2ap020a00f_als_enabled(data)) {
+			err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_ALS,
+						GP2AP020A00F_SUBTRACT_MODE);
+			if (err < 0)
+				return err;
+		}
+		err = regmap_bulk_write(data->regmap, GP2AP020A00F_TH_L_REG,
+						(u8 *)&thresh_buf, 2);
+		break;
+	case GP2AP020A00F_CMD_ALS_LOW_EV_EN:
+		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
+			return -EBUSY;
+		if (!gp2ap020a00f_als_enabled(data)) {
+			err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_ALS,
+						GP2AP020A00F_ADD_MODE);
+			if (err < 0)
+				return err;
+		}
+		set_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT, &data->flags);
+		thresh_buf = cpu_to_le16(
+				data->thresh_reg_val[GP2AP020A00F_THRESH_TL]);
+		err = regmap_bulk_write(data->regmap, GP2AP020A00F_TL_L_REG,
+						(u8 *)&thresh_buf, 2);
+		break;
+	case GP2AP020A00F_CMD_ALS_LOW_EV_DIS:
+		clear_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT, &data->flags);
+		if (!gp2ap020a00f_als_enabled(data)) {
+			err = gp2ap020a00f_alter_opmode(data,
+						GP2AP020A00F_OPMODE_ALS,
+						GP2AP020A00F_SUBTRACT_MODE);
+			if (err < 0)
+				return err;
+		}
+		err = regmap_bulk_write(data->regmap, GP2AP020A00F_TL_L_REG,
+						(u8 *)&thresh_buf, 2);
+		break;
+	case GP2AP020A00F_CMD_PROX_HIGH_EV_EN:
+		if (gp2ap020a00f_als_enabled(data) ||
+		    data->cur_opmode == GP2AP020A00F_OPMODE_PS)
+			return -EBUSY;
+		if (!gp2ap020a00f_prox_detect_enabled(data)) {
+			err = gp2ap020a00f_set_operation_mode(data,
+					GP2AP020A00F_OPMODE_PROX_DETECT);
+			if (err < 0)
+				return err;
+		}
+		set_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT, &data->flags);
+		thresh_buf = cpu_to_le16(
+				data->thresh_reg_val[GP2AP020A00F_THRESH_PH]);
+		err = regmap_bulk_write(data->regmap, GP2AP020A00F_PH_L_REG,
+						(u8 *)&thresh_buf, 2);
+		break;
+	case GP2AP020A00F_CMD_PROX_HIGH_EV_DIS:
+		clear_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT, &data->flags);
+		err = gp2ap020a00f_set_operation_mode(data,
+					GP2AP020A00F_OPMODE_SHUTDOWN);
+		if (err < 0)
+			return err;
+		err = regmap_bulk_write(data->regmap, GP2AP020A00F_PH_L_REG,
+						(u8 *)&thresh_buf, 2);
+		break;
+	case GP2AP020A00F_CMD_PROX_LOW_EV_EN:
+		if (gp2ap020a00f_als_enabled(data) ||
+		    data->cur_opmode == GP2AP020A00F_OPMODE_PS)
+			return -EBUSY;
+		if (!gp2ap020a00f_prox_detect_enabled(data)) {
+			err = gp2ap020a00f_set_operation_mode(data,
+					GP2AP020A00F_OPMODE_PROX_DETECT);
+			if (err < 0)
+				return err;
+		}
+		set_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT, &data->flags);
+		thresh_buf = cpu_to_le16(
+				data->thresh_reg_val[GP2AP020A00F_THRESH_PL]);
+		err = regmap_bulk_write(data->regmap, GP2AP020A00F_PL_L_REG,
+						(u8 *)&thresh_buf, 2);
+		break;
+	case GP2AP020A00F_CMD_PROX_LOW_EV_DIS:
+		clear_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT, &data->flags);
+		err = gp2ap020a00f_set_operation_mode(data,
+					GP2AP020A00F_OPMODE_SHUTDOWN);
+		if (err < 0)
+			return err;
+		err = regmap_bulk_write(data->regmap, GP2AP020A00F_PL_L_REG,
+						(u8 *)&thresh_buf, 2);
+		break;
+	}
+
+	return err;
+}
+
+static int gp2ap020a00f_read_output(struct gp2ap020a00f_data *data,
+					unsigned int output_reg, int *val)
+{
+	u8 reg_buf[2];
+	int err;
+
+	err = regmap_bulk_read(data->regmap, output_reg, reg_buf, 2);
+	if (err < 0)
+		return err;
+
+	*val = le16_to_cpup((__le16 *)reg_buf);
+
+	return err;
+}
+
+static bool gp2ap020a00f_adjust_lux_mode(struct gp2ap020a00f_data *data,
+				 int output_val)
+{
+	u8 new_range = 0xff;
+	int err;
+
+	if (!test_bit(GP2AP020A00F_FLAG_LUX_MODE_HIGH, &data->flags)) {
+		if (output_val > 16000) {
+			set_bit(GP2AP020A00F_FLAG_LUX_MODE_HIGH,
+								&data->flags);
+			new_range = GP2AP020A00F_RANGE_A_x128;
+		}
+	} else {
+		if (output_val < 1000) {
+			clear_bit(GP2AP020A00F_FLAG_LUX_MODE_HIGH,
+								&data->flags);
+			new_range = GP2AP020A00F_RANGE_A_x8;
+		}
+	}
+
+	if (new_range != 0xff) {
+		err = regmap_update_bits(data->regmap,
+			GP2AP020A00F_ALS_REG,
+			GP2AP020A00F_RANGE_A_MASK,
+			new_range);
+		if (err < 0) {
+			dev_err(&data->client->dev,
+				"Adjusting device lux mode failed.\n");
+			goto error_ret;
+		}
+
+		return true;
+	}
+
+error_ret:
+	return false;
+}
+
+static irqreturn_t gp2ap020a00f_event_handler(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct gp2ap020a00f_data *lgt = iio_priv(indio_dev);
+	u8 op_reg_flags, d0_reg_buf[2];
+	unsigned int output_val, op_reg_val;
+	int thresh_val_id, ret;
+
+	mutex_lock(&lgt->lock);
+
+	/* Read interrupt flags */
+	ret = regmap_read(lgt->regmap, GP2AP020A00F_OP_REG,
+					(unsigned int *)&op_reg_val);
+	if (ret < 0)
+		goto done;
+
+	op_reg_flags = op_reg_val & (GP2AP020A00F_FLAG_A | GP2AP020A00F_FLAG_P
+					| GP2AP020A00F_PROX_DETECT);
+
+	op_reg_val &= (~GP2AP020A00F_FLAG_A & ~GP2AP020A00F_FLAG_P
+					& ~GP2AP020A00F_PROX_DETECT);
+
+	/* Clear interrupt flags (if not in INTTYPE_PULSE mode) */
+	if (lgt->cur_opmode != GP2AP020A00F_OPMODE_PROX_DETECT) {
+		ret = regmap_write(lgt->regmap, GP2AP020A00F_OP_REG,
+								op_reg_val);
+		if (ret < 0)
+			goto done;
+	}
+
+	if (lgt->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_CLEAR ||
+	    lgt->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_IR ||
+	    lgt->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY) {
+		goto done;
+	}
+
+	if (gp2ap020a00f_prox_detect_enabled(lgt)) {
+		if (op_reg_flags & GP2AP020A00F_PROX_DETECT) {
+			iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(
+				    IIO_PROXIMITY,
+				    GP2AP020A00F_SCAN_MODE_PROXIMITY,
+				    IIO_EV_TYPE_ROC,
+				    IIO_EV_DIR_RISING),
+			       iio_get_time_ns());
+		} else {
+			iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(
+				    IIO_PROXIMITY,
+				    GP2AP020A00F_SCAN_MODE_PROXIMITY,
+				    IIO_EV_TYPE_ROC,
+				    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns());
+		}
+
+		/*
+		 * There shouldn't be anything else to do here
+		 * in the PROX_DETECT mode.
+		 */
+		goto done;
+	}
+
+
+	/*
+	 * We need to read output value to distinguish
+	 * between high and low ambient light threshold event.
+	 */
+	if (op_reg_flags & GP2AP020A00F_FLAG_A) {
+		ret = regmap_bulk_read(lgt->regmap, GP2AP020A00F_D0_L_REG,
+							d0_reg_buf, 2);
+		if (ret < 0)
+			goto done;
+
+		output_val = le16_to_cpup((__le16 *)d0_reg_buf);
+
+		if (test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
+							&lgt->flags)) {
+			thresh_val_id =
+			    GP2AP020A00F_THRESH_VAL_ID(GP2AP020A00F_TH_L_REG);
+			if (output_val > lgt->thresh_reg_val[thresh_val_id])
+				iio_push_event(indio_dev,
+				       IIO_MOD_EVENT_CODE(
+					    IIO_LIGHT,
+					    GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
+					    IIO_MOD_LIGHT_CLEAR,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_RISING),
+				       iio_get_time_ns());
+		}
+
+		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
+							&lgt->flags)) {
+			thresh_val_id =
+			    GP2AP020A00F_THRESH_VAL_ID(GP2AP020A00F_TL_L_REG);
+			if (output_val < lgt->thresh_reg_val[thresh_val_id])
+				iio_push_event(indio_dev,
+				       IIO_MOD_EVENT_CODE(
+					    IIO_LIGHT,
+					    GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
+					    IIO_MOD_LIGHT_CLEAR,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_FALLING),
+				       iio_get_time_ns());
+		}
+	}
+
+done:
+	/* This fires off trigger handler */
+	iio_trigger_poll(lgt->trig, 0);
+
+	mutex_unlock(&lgt->lock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
+{
+	struct iio_poll_func *pf = data;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct gp2ap020a00f_data *lgt = iio_priv(indio_dev);
+	size_t d_size = 0;
+	int i, out_val, ret;
+
+	for_each_set_bit(i, indio_dev->active_scan_mask,
+		indio_dev->masklength) {
+		ret = regmap_bulk_read(lgt->regmap,
+				GP2AP020A00F_DATA_REG(i),
+				&lgt->buffer[d_size], 2);
+		if (ret < 0)
+			goto done;
+
+		if (i == GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR ||
+		    i == GP2AP020A00F_SCAN_MODE_LIGHT_IR) {
+			out_val = le16_to_cpup((__le16 *)&lgt->buffer[d_size]);
+			gp2ap020a00f_adjust_lux_mode(lgt, out_val);
+		}
+		d_size += 2;
+	}
+
+	if (indio_dev->scan_timestamp) {
+		s64 *timestamp = (s64 *)((u8 *)lgt->buffer +
+						ALIGN(d_size, sizeof(s64)));
+		*timestamp = pf->timestamp;
+	}
+
+	iio_push_to_buffers(indio_dev, lgt->buffer);
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static u8 gp2ap020a00f_get_reg_by_event_code(u64 event_code)
+{
+	int event_dir = IIO_EVENT_CODE_EXTRACT_DIR(event_code);
+
+	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	case IIO_PROXIMITY:
+		if (event_dir == IIO_EV_DIR_RISING)
+			return GP2AP020A00F_PH_L_REG;
+		else
+			return GP2AP020A00F_PL_L_REG;
+	case IIO_LIGHT:
+		if (event_dir == IIO_EV_DIR_RISING)
+			return GP2AP020A00F_TH_L_REG;
+		else
+			return GP2AP020A00F_TL_L_REG;
+	}
+
+	return -EINVAL;
+}
+
+static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
+					u64 event_code, int val)
+{
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	bool event_en = false;
+	u8 thresh_val_id;
+	u8 thresh_reg_l;
+	__le16 reg_buf;
+	int err = 0;
+
+	mutex_lock(&data->lock);
+
+	thresh_reg_l = gp2ap020a00f_get_reg_by_event_code(event_code);
+	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
+
+	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
+		err = -EINVAL;
+		goto error_ret;
+	}
+
+	data->thresh_reg_val[thresh_val_id] = val;
+
+	switch (thresh_reg_l) {
+	case GP2AP020A00F_TH_L_REG:
+		event_en = !!test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
+							&data->flags);
+		break;
+	case GP2AP020A00F_TL_L_REG:
+		event_en = !!test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
+							&data->flags);
+		break;
+	case GP2AP020A00F_PH_L_REG:
+		event_en = !!test_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT,
+							&data->flags);
+		break;
+	case GP2AP020A00F_PL_L_REG:
+		event_en = !!test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
+							&data->flags);
+		break;
+	}
+
+	if (event_en) {
+		reg_buf = cpu_to_le16(
+				data->thresh_reg_val[thresh_val_id]);
+		err = regmap_bulk_write(data->regmap, thresh_reg_l,
+							(u8 *)&reg_buf, 2);
+	}
+
+error_ret:
+	mutex_unlock(&data->lock);
+
+	return err;
+}
+
+static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
+					u64 event_code, int *val)
+{
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	u8 thresh_reg_l;
+	int err = 0;
+
+	mutex_lock(&data->lock);
+
+	thresh_reg_l = gp2ap020a00f_get_reg_by_event_code(event_code);
+
+	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
+		err = -EINVAL;
+		goto error_ret;
+	}
+
+	*val = data->thresh_reg_val[GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l)];
+
+error_ret:
+	mutex_unlock(&data->lock);
+
+	return err;
+}
+
+static int gp2ap020a00f_write_prox_event_config(struct iio_dev *indio_dev,
+					u64 event_code, int state)
+{
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	enum gp2ap020a00f_cmd cmd_high_ev, cmd_low_ev;
+	int err;
+
+	cmd_high_ev = state ? GP2AP020A00F_CMD_PROX_HIGH_EV_EN :
+			      GP2AP020A00F_CMD_PROX_HIGH_EV_DIS;
+	cmd_low_ev = state ? GP2AP020A00F_CMD_PROX_LOW_EV_EN :
+			     GP2AP020A00F_CMD_PROX_LOW_EV_DIS;
+
+	/* In order to enable proximity detection feature in the device
+	 * both high and low threshold registers have to be written
+	 * with different values, greater than zero.
+	 */
+	if (state) {
+		if (data->thresh_reg_val[GP2AP020A00F_THRESH_PL] == 0)
+			data->thresh_reg_val[GP2AP020A00F_THRESH_PL] = 10;
+
+		if (data->thresh_reg_val[GP2AP020A00F_THRESH_PH] == 0)
+			data->thresh_reg_val[GP2AP020A00F_THRESH_PH] = 11;
+	}
+
+	err = gp2ap020a00f_exec_cmd(data, cmd_high_ev);
+	if (err < 0)
+		return err;
+
+	err = gp2ap020a00f_exec_cmd(data, cmd_low_ev);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
+					u64 event_code, int state)
+{
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	enum gp2ap020a00f_cmd cmd;
+	int err;
+
+	mutex_lock(&data->lock);
+
+	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	case IIO_PROXIMITY:
+		err = gp2ap020a00f_write_prox_event_config(indio_dev,
+					event_code, state);
+		break;
+	case IIO_LIGHT:
+		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
+					== IIO_EV_DIR_RISING) {
+			cmd = state ? GP2AP020A00F_CMD_ALS_HIGH_EV_EN :
+				      GP2AP020A00F_CMD_ALS_HIGH_EV_DIS;
+			err = gp2ap020a00f_exec_cmd(data, cmd);
+		} else {
+			cmd = state ? GP2AP020A00F_CMD_ALS_LOW_EV_EN :
+				      GP2AP020A00F_CMD_ALS_LOW_EV_DIS;
+			err = gp2ap020a00f_exec_cmd(data, cmd);
+		}
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	mutex_unlock(&data->lock);
+
+	return err;
+}
+
+static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
+					u64 event_code)
+{
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	int event_en = 0;
+
+	mutex_lock(&data->lock);
+
+	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	case IIO_PROXIMITY:
+		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
+					== IIO_EV_DIR_RISING)
+			event_en =
+				test_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT,
+								&data->flags);
+		else
+			event_en =
+				test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
+								&data->flags);
+		break;
+	case IIO_LIGHT:
+		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
+					== IIO_EV_DIR_RISING)
+			event_en = test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
+								&data->flags);
+		else
+			event_en = test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
+								&data->flags);
+		break;
+	}
+
+	mutex_unlock(&data->lock);
+
+	return event_en;
+}
+
+static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
+				struct iio_chan_spec const *chan, int *val)
+{
+	enum gp2ap020a00f_cmd cmd;
+	int cnt_loops = 0, err;
+
+	switch (chan->scan_index) {
+	case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
+		cmd = GP2AP020A00F_CMD_READ_RAW_CLEAR;
+		break;
+	case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
+		cmd = GP2AP020A00F_CMD_READ_RAW_IR;
+		break;
+	case GP2AP020A00F_SCAN_MODE_PROXIMITY:
+		cmd = GP2AP020A00F_CMD_READ_RAW_PROXIMITY;
+		break;
+	}
+
+	/*
+	 * The purpose of this loop is repeating the conversion in case
+	 * the output value exceedes the threshold related to the current
+	 * lux mode - a new conversion has to be performed then, with
+	 * adjusted maximum measurable range setting.
+	 */
+	do {
+		err = gp2ap020a00f_exec_cmd(data, cmd);
+		if (err < 0) {
+			dev_err(&data->client->dev,
+				"gp2ap020a00f_exec_cmd failed\n");
+			goto error_ret;
+		}
+
+		msleep(1000);
+
+		err = gp2ap020a00f_read_output(data, chan->address, val);
+		if (err < 0)
+			dev_err(&data->client->dev,
+				"gp2ap020a00f_read_output failed\n");
+
+		data->cur_opmode = GP2AP020A00F_OPMODE_SHUTDOWN;
+
+		if (++cnt_loops > 2) {
+			dev_err(&data->client->dev,
+				"Lux mode adjusting error.\n");
+			break;
+		}
+	} while ((cmd == GP2AP020A00F_CMD_READ_RAW_CLEAR ||
+		  cmd == GP2AP020A00F_CMD_READ_RAW_IR) &&
+		 gp2ap020a00f_adjust_lux_mode(data, *val));
+
+
+error_ret:
+	return err;
+}
+
+static int gp2ap020a00f_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2,
+			   long mask)
+{
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	int err = -EINVAL;
+
+	mutex_lock(&data->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev)) {
+			err = -EBUSY;
+			goto error_ret;
+		}
+
+		err = gp2ap020a00f_read_channel(data, chan, val);
+		break;
+	}
+
+error_ret:
+	mutex_unlock(&data->lock);
+
+	return err < 0 ? err : IIO_VAL_INT;
+}
+
+static const struct iio_chan_spec gp2ap020a00f_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.shift = 0,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+		.scan_index = GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
+		.address = GP2AP020A00F_D0_L_REG,
+		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH,
+					 IIO_EV_DIR_RISING) |
+			      IIO_EV_BIT(IIO_EV_TYPE_THRESH,
+					 IIO_EV_DIR_FALLING),
+	},
+	{
+		.type = IIO_LIGHT,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.shift = 0,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+		.scan_index = GP2AP020A00F_SCAN_MODE_LIGHT_IR,
+		.address = GP2AP020A00F_D1_L_REG,
+	},
+	{
+		.type = IIO_PROXIMITY,
+		.modified = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.shift = 0,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+		.scan_index = GP2AP020A00F_SCAN_MODE_PROXIMITY,
+		.address = GP2AP020A00F_D2_L_REG,
+		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_ROC,
+					 IIO_EV_DIR_RISING) |
+			      IIO_EV_BIT(IIO_EV_TYPE_ROC,
+					 IIO_EV_DIR_FALLING),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(GP2AP020A00F_CHAN_TIMESTAMP),
+};
+
+static const struct iio_info gp2ap020a00f_info = {
+	.read_raw = &gp2ap020a00f_read_raw,
+	.read_event_value = &gp2ap020a00f_read_event_val,
+	.read_event_config = &gp2ap020a00f_read_event_config,
+	.write_event_value = &gp2ap020a00f_write_event_val,
+	.write_event_config = &gp2ap020a00f_write_event_config,
+	.driver_module = THIS_MODULE,
+};
+
+static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	int i, err = 0;
+
+	mutex_lock(&data->lock);
+
+	/* Enable triggers according to the scan_mask */
+	for_each_set_bit(i, indio_dev->active_scan_mask,
+		indio_dev->masklength) {
+		switch (i) {
+		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
+			err = gp2ap020a00f_exec_cmd(data,
+					GP2AP020A00F_CMD_TRIGGER_CLEAR_EN);
+			if (err < 0)
+				goto error_ret;
+			break;
+		case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
+			err = gp2ap020a00f_exec_cmd(data,
+					GP2AP020A00F_CMD_TRIGGER_IR_EN);
+			if (err < 0)
+				goto error_ret;
+			break;
+		case GP2AP020A00F_SCAN_MODE_PROXIMITY:
+			err = gp2ap020a00f_exec_cmd(data,
+					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
+			if (err < 0)
+				goto error_ret;
+			break;
+		}
+	}
+
+	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (data->buffer == NULL) {
+		err = -ENOMEM;
+		goto error_ret;
+	}
+
+	err = iio_triggered_buffer_postenable(indio_dev);
+
+error_ret:
+	mutex_unlock(&data->lock);
+
+	return err;
+}
+
+static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	int i, err;
+
+	mutex_lock(&data->lock);
+
+	err = iio_triggered_buffer_predisable(indio_dev);
+	if (err < 0)
+		goto error_ret;
+
+	for_each_set_bit(i, indio_dev->active_scan_mask,
+		indio_dev->masklength) {
+		switch (i) {
+		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
+			err = gp2ap020a00f_exec_cmd(data,
+					GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS);
+			if (err < 0)
+				goto error_ret;
+			break;
+		case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
+			err = gp2ap020a00f_exec_cmd(data,
+					GP2AP020A00F_CMD_TRIGGER_IR_DIS);
+			if (err < 0)
+				goto error_ret;
+			break;
+		case GP2AP020A00F_SCAN_MODE_PROXIMITY:
+			err = gp2ap020a00f_exec_cmd(data,
+					GP2AP020A00F_CMD_TRIGGER_PROX_DIS);
+			if (err < 0)
+				goto error_ret;
+			break;
+		}
+	}
+
+	kfree(data->buffer);
+
+error_ret:
+	mutex_unlock(&data->lock);
+
+	return err;
+}
+
+static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
+	.postenable = &gp2ap020a00f_buffer_postenable,
+	.predisable = &gp2ap020a00f_buffer_predisable,
+};
+
+static const struct iio_trigger_ops gp2ap020a00f_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
+static int gp2ap020a00f_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct gp2ap020a00f_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int err;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->vled_reg = devm_regulator_get(&client->dev, "vled");
+	if (IS_ERR(data->vled_reg))
+		return PTR_ERR(data->vled_reg);
+
+	err = regulator_enable(data->vled_reg);
+	if (err)
+		return err;
+
+	regmap = devm_regmap_init_i2c(client, &gp2ap020a00f_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Regmap initialization failed.\n");
+		err = PTR_ERR(regmap);
+		goto error_regulator_disable;
+	}
+
+	/* Initialize device registers */
+	err = regmap_bulk_write(regmap, GP2AP020A00F_OP_REG,
+			gp2ap020a00f_reg_init_tab,
+			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
+
+	if (err < 0) {
+		dev_err(&client->dev, "Device initialization failed.\n");
+		goto error_regulator_disable;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+
+	data->client = client;
+	data->cur_opmode = GP2AP020A00F_OPMODE_SHUTDOWN;
+	data->regmap = regmap;
+
+	mutex_init(&data->lock);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->channels = gp2ap020a00f_channels;
+	indio_dev->num_channels = ARRAY_SIZE(gp2ap020a00f_channels);
+	indio_dev->info = &gp2ap020a00f_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* Allocate buffer */
+	err = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		&gp2ap020a00f_trigger_handler, &gp2ap020a00f_buffer_setup_ops);
+	if (err < 0)
+		goto error_regulator_disable;
+
+	/* Allocate trigger */
+	data->trig = devm_iio_trigger_alloc(&client->dev, "%s-trigger",
+							indio_dev->name);
+	if (data->trig == NULL) {
+		err = -ENOMEM;
+		dev_err(&indio_dev->dev, "Failed to allocate iio trigger.\n");
+		goto error_uninit_buffer;
+	}
+
+	err = devm_request_threaded_irq(&client->dev,
+					client->irq,
+					NULL,
+					&gp2ap020a00f_event_handler,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					"gp2ap020a00f_event",
+					indio_dev);
+	if (err < 0) {
+		dev_err(&client->dev, "Irq request failed.\n");
+		goto error_uninit_buffer;
+	}
+
+	data->trig->ops = &gp2ap020a00f_trigger_ops;
+	data->trig->dev.parent = &data->client->dev;
+
+	err = iio_trigger_register(data->trig);
+	if (err < 0) {
+		dev_err(&client->dev, "Failed to register iio trigger.\n");
+		goto error_uninit_buffer;
+	}
+
+	indio_dev->trig = data->trig;
+
+	err = iio_device_register(indio_dev);
+	if (err < 0)
+		goto error_trigger_unregister;
+
+	return 0;
+
+error_trigger_unregister:
+	iio_trigger_unregister(data->trig);
+error_uninit_buffer:
+	iio_triggered_buffer_cleanup(indio_dev);
+error_regulator_disable:
+	regulator_disable(data->vled_reg);
+
+	return err;
+}
+
+static int gp2ap020a00f_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	int err;
+
+	err = gp2ap020a00f_set_operation_mode(data,
+					GP2AP020A00F_OPMODE_SHUTDOWN);
+	if (err < 0)
+		dev_err(&indio_dev->dev, "Failed to power off the device.\n");
+
+	iio_device_unregister(indio_dev);
+	iio_trigger_unregister(data->trig);
+	iio_triggered_buffer_cleanup(indio_dev);
+	regulator_disable(data->vled_reg);
+
+	return 0;
+}
+
+static const struct i2c_device_id gp2ap020a00f_id[] = {
+	{ GP2A_I2C_NAME, 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id gp2ap020a00f_of_match[] = {
+	{ .compatible = "sharp,gp2ap020a00f" },
+	{ }
+};
+#endif
+
+static struct i2c_driver gp2ap020a00f_driver = {
+	.driver = {
+		.name	= GP2A_I2C_NAME,
+		.of_match_table = of_match_ptr(gp2ap020a00f_of_match),
+		.owner	= THIS_MODULE,
+	},
+	.probe		= gp2ap020a00f_probe,
+	.remove		= gp2ap020a00f_remove,
+	.id_table	= gp2ap020a00f_id,
+};
+
+module_i2c_driver(gp2ap020a00f_driver);
+
+MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
+MODULE_DESCRIPTION("Sharp GP2AP020A00F Proximity/ALS sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4

