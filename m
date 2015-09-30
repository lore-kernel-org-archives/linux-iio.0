Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35916 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbbI3Bg0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2015 21:36:26 -0400
Received: by pablk4 with SMTP id lk4so22131352pab.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2015 18:36:26 -0700 (PDT)
From: Suresh Rajashekara <sureshraj@google.com>
To: linux-iio@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	devicetree@vger.kernel.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	Suresh Rajashekara <sureshraj@google.com>
Subject: [PATCH v3 1/2] iio:light: Add Dyna-Image AP3223 ambient light and proximity driver
Date: Tue, 29 Sep 2015 18:36:20 -0700
Message-Id: <1443576981-1210-1-git-send-email-sureshraj@google.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Minimal implementation with support for raw light and proximity reading.

This is based on the driver provided by the vendor
(which was an input driver). Authors of the
driver from the vendor included
* John Huang <john.huang@dyna-image.com>
* Templeton Tsai <templeton.tsai@dyna-image.com>
* Vic Lee <Vic_Lee@asus.com>

v3
* Resubmitting due to typo in accompanying patch

v2
* Using regmap framework
* Error handling
* Code cleanups following comments

Signed-off-by: Suresh Rajashekara <sureshraj@google.com>
---
 drivers/iio/light/Kconfig  |  11 +
 drivers/iio/light/Makefile |   1 +
 drivers/iio/light/ap3223.c | 706 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 718 insertions(+)
 create mode 100644 drivers/iio/light/ap3223.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ae68c64..5c93ef0 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -27,6 +27,17 @@ config AL3320A
 	 To compile this driver as a module, choose M here: the
 	 module will be called al3320a.
 
+config AP3223
+	tristate "AP3223 ambient light and proximity sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	 Say Y here if you want to build a driver for the Dyna Image AP3223
+	 ambient light and proximity sensor.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called ap3223.
+
 config APDS9300
 	tristate "APDS9300 ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index b12a516..13a74f9 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -5,6 +5,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
+obj-$(CONFIG_AP3223)		+= ap3223.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_CM32181)		+= cm32181.o
 obj-$(CONFIG_CM3232)		+= cm3232.o
diff --git a/drivers/iio/light/ap3223.c b/drivers/iio/light/ap3223.c
new file mode 100644
index 0000000..6b457c1
--- /dev/null
+++ b/drivers/iio/light/ap3223.c
@@ -0,0 +1,706 @@
+/*
+ * Copyright (C) 2015 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Note about the original authors:
+ *
+ * The driver for AP3223 was originally distributed by dyna image in a
+ * different framework (as an input driver). This driver uses code from
+ * that driver and converts it to iio framework. The non-iio driver from
+ * dyna image is not available online anywhere, so there is no reference
+ * for it here. However, that driver is also GPLv2.
+ * The following is part of the header found in that file
+ * (The GPL notice from the original header is removed)
+ *
+ * >> This file is part of the AP3223, AP3212C and AP3216C sensor driver.
+ * >> AP3426 is combined proximity and ambient light sensor.
+ * >> AP3216C is combined proximity, ambient light sensor and IRLED.
+ * >>
+ * >> Contact: John Huang <john.huang@dyna-image.com>
+ * >>	       Templeton Tsai <templeton.tsai@dyna-image.com>
+ *
+ * Another author initials mentioned in that file was just YC (and no name).
+ *
+ * Not sure for what kernel version the driver from dyna image was written for.
+ * Vic Lee <Vic_Lee@asus.com> made modifications to it to run on 3.14.
+ *
+ * Datasheet:
+ * http://www.dyna-image.com/english/product/optical-sensor-detail.php?cpid=2&dpid=8#doc
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/timer.h>
+#include <linux/gpio.h>
+#include <linux/device.h>
+
+#define AP3223_DRV_NAME "ap3223"
+
+/* ap3223 control registers */
+
+#define	AP3223_REG_SYS_CTRL		0x00
+#define AP3223_REG_SYS_CTRL_SHIFT	(0)
+#define AP3223_REG_SYS_CTRL_MASK	0x07
+
+/* System Mode (AP3223_REG_SYS_CTRL) */
+
+#define AP3223_SYS_DEV_DOWN		0x00
+#define AP3223_SYS_ALS_ENABLE		0x01
+#define AP3223_SYS_PS_ENABLE		0x02
+#define AP3223_SYS_ALS_PS_ENABLE	0x03
+#define AP3223_SYS_DEV_RESET		0x04
+
+#define AP3223_REG_SYS_INTSTATUS	0x01
+#define AP3223_REG_SYS_INT_SHIFT	(0)
+#define AP3223_REG_SYS_INT_ALS_SHIFT	(0)
+#define AP3223_REG_SYS_INT_PS_SHIFT	(1)
+#define AP3223_REG_SYS_INT_OBJ_SHIFT	(4)
+#define AP3223_REG_SYS_INT_IR_OV_SHIFT	(5)
+
+/* INT FLAG BIT MASK */
+
+#define AP3223_REG_SYS_INT_MASK		0x03
+#define AP3223_REG_SYS_INT_AMASK	0x01
+#define AP3223_REG_SYS_INT_PMASK	0x02
+#define AP3223_REG_SYS_INT_OBJ_MASK	0x10
+#define AP3223_REG_SYS_INT_IR_OV_MASK	0x20
+
+#define AP3223_REG_SYS_INTCTRL		0x02
+
+/* INT Clear Manner */
+
+#define	AP3223_SYS_INT_CLEAR_AUTO	0x00
+#define	AP3223_SYS_INT_CLEAR_MANUAL	0x01
+
+#define AP3223_REG_SYS_WAITTIME		0x06
+
+#define AP3223_WAITTIME_SLOT(n)		(n)
+
+/* ap3223 data registers */
+
+#define AP3223_REG_IR_DATA_LOW		0x0A
+#define AP3223_REG_IR_DATA_LOW_SHIFT	(0)
+#define AP3223_REG_IR_DATA_LOW_MASK	0xFF
+
+#define AP3223_REG_IR_DATA_HIGH		0x0B
+#define AP3223_REG_IR_DATA_HIGH_SHIFT	(0)
+#define AP3223_REG_IR_DATA_HIGH_MASK	0x03
+
+#define AP3223_REG_ALS_DATA_LOW		0x0C
+
+#define AP3223_REG_ALS_DATA_HIGH	0x0D
+
+#define AP3223_REG_PS_DATA_LOW		0x0E
+#define AP3223_REG_PS_DATA_LOW_SHIFT	(0)
+#define AL3223_REG_PS_DATA_LOW_MASK	0xFF
+
+#define AP3223_REG_PS_DATA_HIGH		0x0F
+#define AP3223_REG_PS_DATA_HIGH_SHIFT	(0)
+#define AL3223_REG_PS_DATA_HIGH_MASK	0x03
+
+#define AP3223_REG_ALS_GAIN		0x10
+
+/* ALS Gain */
+
+#define AP3223_ALS_RANGE_0		0x00	/* Full range 65535 lux */
+#define AP3223_ALS_RANGE_1		0x01	/* Full range 16383 lux */
+#define AP3223_ALS_RANGE_2		0x02	/* Full range 4095 lux */
+#define AP3223_ALS_RANGE_3		0x03	/* Full range 1023 lux */
+#define AP3223_ALS_RANGE_MASK		0x30
+#define AP3223_ALS_RANGE_SHIFT		(4)
+#define AP3223_ALS_PERSIST_MASK		0x0F
+
+#define AP3223_REG_ALS_PERSIST		0x14
+#define AP3223_REG_ALS_PERSIST_SHIFT	(0)
+#define AP3223_REG_ALS_PERSIST_MASK	0x3F
+
+#define AP3223_REG_ALS_THDL_L		0x1A
+#define AP3223_REG_ALS_THDL_L_SHIFT	(0)
+#define AP3223_REG_ALS_THDL_L_MASK	0xFF
+
+#define AP3223_REG_ALS_THDL_H		0x1B
+#define AP3223_REG_ALS_THDL_H_SHIFT	(0)
+#define AP3223_REG_ALS_THDL_H_MASK	0xFF
+
+#define AP3223_REG_ALS_THDH_L		0x1C
+#define AP3223_REG_ALS_THDH_L_SHIFT	(0)
+#define AP3223_REG_ALS_THDH_L_MASK	0xFF
+
+#define AP3223_REG_ALS_THDH_H		0x1D
+#define AP3223_REG_ALS_THDH_H_SHIFT	(0)
+#define AP3223_REG_ALS_THDH_H_MASK	0xFF
+
+/* ap3223 PS Gain registers */
+
+#define AP3223_REG_PS_GAIN		0x20
+#define AP3223_REG_PS_GAIN_SHIFT	(2)
+#define AP3223_REG_PS_GAIN_MASK		0x0C
+
+/* PS Gain */
+
+#define AP3223_PS_GAIN_1		0x00	/* PS resolution * 1 */
+#define AP3223_PS_GAIN_2		0x01	/* PS resolution * 2 */
+#define AP3223_PS_GAIN_4		0x02	/* PS resolution * 4 */
+#define AP3223_PS_GAIN_8		0x03	/* PS resolution * 8 */
+
+#define AP3223_REG_PS_LEDD		0x21	/* PS LED DRIVER */
+#define AP3223_REG_PS_LEDD_SHIFT	(0)
+#define AP3223_REG_PS_LEDD_MASK		0x03
+
+/* PS LED Driver current percentage */
+
+#define AP3223_PS_LED_DRVR_CUR_P_16_7	0x00	/* 16.7% */
+#define AP3223_PS_LED_DRVR_CUR_P_33_3	0x01	/* 33.3% */
+#define AP3223_PS_LED_DRVR_CUR_P_66_7	0x02	/* 66.7% */
+#define AP3223_PS_LED_DRVR_CUR_P_100	0x03	/* 100% (default) */
+
+#define AP3223_REG_PS_IFORM		0x22	/* PS INT Mode */
+
+#define AP3223_PS_INT_ALGO_ZONE_MODE	0x00
+#define AP3223_PS_INT_ALSO_HYST_MODE	0x01
+
+#define AP3223_REG_PS_MEAN		0x23
+#define AP3223_REG_PS_MEAN_SHIFT	(0)
+#define AP3223_REG_PS_MEAN_MASK		0x03
+
+/* PS MEAN */
+
+#define AP3223_PS_MEAN_0		0x00	/* 5ms @2T */
+#define AP3223_PS_MEAN_1		0x01	/* 9.6ms @2T */
+#define AP3223_PS_MEAN_2		0x02	/* 14.1ms @2T */
+#define AP3223_PS_MEAN_3		0x03	/* 18.7ms @2T */
+
+#define AP3223_REG_PS_SMARTINT		0x24	/* PS Smart INT for low power */
+#define AP3223_PS_SMARTINT_DISABLE	0x00
+#define AP3223_PS_SMARTINT_ENABLE	0x01
+
+#define AP3223_REG_PS_INTEGR_TIME	0x25
+
+#define AP3223_PS_INTEGR_TIME_SEL(t)	(t)
+
+#define AP3223_REG_PS_PERSIST		0x26
+#define AP3223_REG_PS_PERSIST_SHIFT	(0)
+#define AP3223_REG_PS_PERSIST_MASK	0x3F
+
+#define AP3223_PS_PERSIST_CONV_TIME(t)	(t)
+
+#define AP3223_REG_PS_CAL_L		0x28
+#define AP3223_REG_PS_CAL_L_SHIFT	(0)
+#define AP3223_REG_PS_CAL_L_MASK	0xFF
+
+#define AP3223_REG_PS_CAL_H		0x29
+#define AP3223_REG_PS_CAL_H_SHIFT	(0)
+#define AP3223_REG_PS_CAL_H_MASK	0x01
+
+#define AP3223_REG_PS_THDL_L		0x2A
+#define AP3223_REG_PS_THDL_L_SHIFT	(0)
+#define AP3223_REG_PS_THDL_L_MASK	0xFF
+
+#define AP3223_REG_PS_THDL_H		0x2B
+#define AP3223_REG_PS_THDL_H_SHIFT	(0)
+#define AP3223_REG_PS_THDL_H_MASK	0x03
+
+#define AP3223_REG_PS_THDH_L		0x2C
+#define AP3223_REG_PS_THDH_L_SHIFT	(0)
+#define AP3223_REG_PS_THDH_L_MASK	0xFF
+
+#define AP3223_REG_PS_THDH_H		0x2D
+#define AP3223_REG_PS_THDH_H_SHIFT	(0)
+#define AP3223_REG_PS_THDH_H_MASK	0x03
+
+/* PS Engineering Registers */
+
+#define AP3223_REG_PS_DC_1		0x30	/* Only in Engineering chip,
+						couldn't find in datasheet */
+#define AP3223_REG_PS_DC_1_SHIFT	(0)
+#define AP3223_REG_PS_DC_1_MASK		0xFF
+
+#define AP3223_REG_PS_DC_2		0x32	/* Only in Engineering chip,
+						couldn't find in datasheet */
+#define AP3223_REG_PS_DC_2_SHIFT	(0)
+#define AP3223_REG_PS_DC_2_MASK		0xFF
+
+/* No adjustment to lux value reading */
+#define AP3223_DEFAULT_CAL			100
+
+#define AP3223_GAIN_65535_LUX_PER_RES_BIT	65535
+#define AP3223_GAIN_16383_LUX_PER_RES_BIT	16383
+#define AP3223_GAIN_4095_LUX_PER_RES_BIT	4095
+#define AP3223_GAIN_1023_LUX_PER_RES_BIT	1023
+
+/* Initial Threshold Configuration */
+#define AP3223_ALS_LOW_THD_L_INIT		0xE8
+#define AP3223_ALS_LOW_THD_H_INIT		0x03
+#define AP3223_ALS_HIGH_THD_L_INIT		0xD0
+#define AP3223_ALS_HIGH_THD_H_INIT		0x07
+
+#define AP3223_PS_LOW_THD_L_INIT		0x64
+#define AP3223_PS_LOW_THD_H_INIT		0x00
+#define AP3223_PS_HIGH_THD_L_INIT		0xF4
+#define AP3223_PS_HIGH_THD_H_INIT		0x00
+
+struct ap3223_data {
+	struct i2c_client *client;
+	int cali;
+	struct regmap *regmap;
+};
+
+static const u8 ap3223_initial_reg_conf[] = {
+	AP3223_REG_SYS_CTRL, AP3223_SYS_ALS_PS_ENABLE,
+	AP3223_REG_SYS_WAITTIME, AP3223_WAITTIME_SLOT(0),
+	AP3223_REG_ALS_GAIN, (AP3223_ALS_RANGE_2 << AP3223_ALS_RANGE_SHIFT),
+	AP3223_REG_ALS_THDL_L, AP3223_ALS_LOW_THD_L_INIT,
+	AP3223_REG_ALS_THDL_H, AP3223_ALS_LOW_THD_H_INIT,
+	AP3223_REG_ALS_THDH_L, AP3223_ALS_HIGH_THD_L_INIT,
+	AP3223_REG_ALS_THDH_H, AP3223_ALS_HIGH_THD_H_INIT,
+	AP3223_REG_PS_GAIN, (AP3223_PS_GAIN_8 << AP3223_REG_PS_GAIN_SHIFT),
+	AP3223_REG_PS_LEDD, AP3223_PS_LED_DRVR_CUR_P_100,
+	AP3223_REG_PS_IFORM, AP3223_PS_INT_ALSO_HYST_MODE,
+	AP3223_REG_PS_MEAN, AP3223_PS_MEAN_0,
+	AP3223_REG_PS_SMARTINT, AP3223_PS_SMARTINT_ENABLE,
+	AP3223_REG_PS_INTEGR_TIME, AP3223_PS_INTEGR_TIME_SEL(0x1F),
+	AP3223_REG_PS_PERSIST, AP3223_PS_PERSIST_CONV_TIME(0x01),
+	AP3223_REG_PS_THDL_L, AP3223_PS_LOW_THD_L_INIT,
+	AP3223_REG_PS_THDH_L, AP3223_PS_HIGH_THD_L_INIT,
+	AP3223_REG_PS_THDH_H, AP3223_PS_HIGH_THD_H_INIT
+};
+
+static const int ap3223_range[] = {
+	AP3223_GAIN_65535_LUX_PER_RES_BIT,
+	AP3223_GAIN_16383_LUX_PER_RES_BIT,
+	AP3223_GAIN_4095_LUX_PER_RES_BIT,
+	AP3223_GAIN_1023_LUX_PER_RES_BIT
+};
+
+static bool ap3223_is_writable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AP3223_REG_SYS_CTRL:
+	case AP3223_REG_SYS_INTSTATUS:
+	case AP3223_REG_SYS_INTCTRL:
+	case AP3223_REG_SYS_WAITTIME:
+	case AP3223_REG_ALS_GAIN:
+	case AP3223_REG_ALS_PERSIST:
+	case AP3223_REG_ALS_THDL_L:
+	case AP3223_REG_ALS_THDL_H:
+	case AP3223_REG_ALS_THDH_L:
+	case AP3223_REG_ALS_THDH_H:
+	case AP3223_REG_PS_GAIN:
+	case AP3223_REG_PS_LEDD:
+	case AP3223_REG_PS_IFORM:
+	case AP3223_REG_PS_MEAN:
+	case AP3223_REG_PS_SMARTINT:
+	case AP3223_REG_PS_INTEGR_TIME:
+	case AP3223_REG_PS_PERSIST:
+	case AP3223_REG_PS_CAL_L:
+	case AP3223_REG_PS_CAL_H:
+	case AP3223_REG_PS_THDL_L:
+	case AP3223_REG_PS_THDL_H:
+	case AP3223_REG_PS_THDH_L:
+	case AP3223_REG_PS_THDH_H:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+static bool ap3223_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AP3223_REG_SYS_CTRL:
+	case AP3223_REG_SYS_INTSTATUS:
+	case AP3223_REG_SYS_INTCTRL:
+	case AP3223_REG_SYS_WAITTIME:
+	case AP3223_REG_IR_DATA_LOW:
+	case AP3223_REG_IR_DATA_HIGH:
+	case AP3223_REG_ALS_DATA_LOW:
+	case AP3223_REG_ALS_DATA_HIGH:
+	case AP3223_REG_PS_DATA_LOW:
+	case AP3223_REG_PS_DATA_HIGH:
+	case AP3223_REG_ALS_GAIN:
+	case AP3223_REG_ALS_PERSIST:
+	case AP3223_REG_ALS_THDL_L:
+	case AP3223_REG_ALS_THDL_H:
+	case AP3223_REG_ALS_THDH_L:
+	case AP3223_REG_ALS_THDH_H:
+	case AP3223_REG_PS_GAIN:
+	case AP3223_REG_PS_LEDD:
+	case AP3223_REG_PS_IFORM:
+	case AP3223_REG_PS_MEAN:
+	case AP3223_REG_PS_SMARTINT:
+	case AP3223_REG_PS_INTEGR_TIME:
+	case AP3223_REG_PS_PERSIST:
+	case AP3223_REG_PS_CAL_L:
+	case AP3223_REG_PS_CAL_H:
+	case AP3223_REG_PS_THDL_L:
+	case AP3223_REG_PS_THDL_H:
+	case AP3223_REG_PS_THDH_L:
+	case AP3223_REG_PS_THDH_H:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+static bool ap3223_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AP3223_REG_SYS_CTRL:
+	case AP3223_REG_SYS_INTSTATUS:
+	case AP3223_REG_IR_DATA_LOW:
+	case AP3223_REG_IR_DATA_HIGH:
+	case AP3223_REG_ALS_DATA_LOW:
+	case AP3223_REG_ALS_DATA_HIGH:
+	case AP3223_REG_PS_DATA_LOW:
+	case AP3223_REG_PS_DATA_HIGH:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config ap3223_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AP3223_REG_PS_THDH_H,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = ap3223_is_writable_reg,
+	.readable_reg = ap3223_is_readable_reg,
+	.volatile_reg = ap3223_is_volatile_reg,
+};
+
+#define AP3223_LIGHT_CHANNEL {				\
+	.type = IIO_LIGHT,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+}
+
+#define AP3223_PROXIMITY_CHANNEL {			\
+	.type = IIO_PROXIMITY,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+}
+
+static const struct iio_chan_spec ap3223_channels[] = {
+	AP3223_LIGHT_CHANNEL,
+	AP3223_PROXIMITY_CHANNEL,
+};
+
+static int ap3223_read_reg(struct i2c_client *client,
+			   u32 reg, u8 mask, u8 shift)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+	unsigned int tmp;
+
+	if (regmap_read(data->regmap, reg, &tmp) < 0)
+		return -EINVAL;
+
+	return (tmp & mask) >> shift;
+}
+
+static int ap3223_write_reg(struct i2c_client *client,
+			    u32 reg, u8 mask, u8 shift, u8 val)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+	int ret = 0;
+	unsigned int tmp;
+
+	if (regmap_read(data->regmap, reg, &tmp) < 0)
+		return -EINVAL;
+
+	tmp &= ~mask;
+	tmp |= val << shift;
+
+	ret = regmap_write(data->regmap, reg, tmp);
+	if (ret)
+		return -EINVAL;
+
+	return ret;
+}
+
+static int ap3223_get_mode(struct i2c_client *client)
+{
+	return ap3223_read_reg(client, AP3223_REG_SYS_CTRL,
+			       AP3223_REG_SYS_CTRL_MASK,
+			       AP3223_REG_SYS_CTRL_SHIFT);
+}
+
+static int ap3223_set_mode(struct i2c_client *client, int mode)
+{
+	int err = 0;
+
+	err = ap3223_write_reg(client, AP3223_REG_SYS_CTRL,
+			       AP3223_REG_SYS_CTRL_MASK,
+			       AP3223_REG_SYS_CTRL_SHIFT, mode);
+	if (err < 0)
+		dev_err(&client->dev, "Failed to set mode\n");
+
+	return err;
+}
+
+static int ap3223_get_range(struct i2c_client *client)
+{
+	u8 idx = ap3223_read_reg(client, AP3223_REG_ALS_GAIN,
+				 AP3223_ALS_RANGE_MASK,
+				 AP3223_ALS_RANGE_SHIFT);
+	if (idx < 0)
+		return -EINVAL;
+
+	return ap3223_range[idx];
+}
+
+static int ap3223_set_range(struct i2c_client *client, int range)
+{
+	int err = 0;
+
+	err = ap3223_write_reg(client, AP3223_REG_ALS_GAIN,
+			       AP3223_ALS_RANGE_MASK,
+			       AP3223_ALS_RANGE_SHIFT, range);
+	if (err < 0)
+		dev_err(&client->dev, "Failed to set range\n");
+
+	return err;
+}
+
+static int ap3223_get_adc_value(struct i2c_client *client)
+{
+	int range;
+	unsigned int lsb, msb;
+	unsigned int tmp;
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+
+	range = ap3223_get_range(client);
+	if (range < 0)
+		return range;
+
+	if (regmap_read(data->regmap, AP3223_REG_ALS_DATA_LOW, &lsb) < 0)
+		return -EINVAL;
+
+	if (regmap_read(data->regmap, AP3223_REG_ALS_DATA_HIGH, &msb) < 0)
+		return -EINVAL;
+
+	tmp = (((msb << 8) | lsb) * range) >> 16;
+	tmp = tmp * data->cali / 100;
+
+	return tmp;
+}
+
+static int ap3223_get_object(struct i2c_client *client)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+	unsigned int val;
+
+	if (regmap_read(data->regmap, AP3223_REG_SYS_INTSTATUS, &val) < 0)
+		return -EINVAL;
+
+	val &= AP3223_REG_SYS_INT_OBJ_MASK;
+
+	return val >> AP3223_REG_SYS_INT_OBJ_SHIFT;
+}
+
+static int ap3223_sw_reset(struct i2c_client *client)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+	int err = 0;
+
+	err = regmap_write(data->regmap, AP3223_REG_SYS_CTRL,
+		     AP3223_SYS_DEV_RESET);
+	if (err < 0)
+		dev_err(&client->dev, "Failed to set mode\n");
+
+	return err;
+}
+
+static int ap3223_init_client(struct i2c_client *client)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+
+	if (ap3223_set_range(client, AP3223_ALS_RANGE_0) < 0)
+		return -EINVAL;
+
+	if (ap3223_set_mode(data->client, AP3223_SYS_DEV_DOWN) < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ap3223_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct ap3223_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (chan->type) {
+	case IIO_LIGHT:
+		switch (mask) {
+		case IIO_CHAN_INFO_RAW:
+			ret = ap3223_get_mode(data->client);
+			if (ret < 0)
+				break;
+
+			*val = ap3223_get_adc_value(data->client);
+			if (*val < 0)
+				break;
+
+			return IIO_VAL_INT;
+		}
+		break;
+
+	case IIO_PROXIMITY:
+		switch (mask) {
+		case IIO_CHAN_INFO_RAW:
+			*val = ap3223_get_object(data->client);
+			if (*val < 0)
+				break;
+
+			return IIO_VAL_INT;
+		}
+		break;
+
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info ap3223_info = {
+	.driver_module  = THIS_MODULE,
+	.read_raw       = ap3223_read_raw,
+};
+
+static int ap3223_init_reg_config(struct i2c_client *client)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ap3223_initial_reg_conf); i += 2) {
+		if (ap3223_write_reg(client, ap3223_initial_reg_conf[i], 0xff,
+					 0, ap3223_initial_reg_conf[i + 1]) < 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ap3223_init(struct ap3223_data *data)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE)) {
+		err = -EIO;
+		goto exit_ap3223_init;
+	}
+
+	err = ap3223_sw_reset(client);
+	if (err < 0)
+		goto exit_ap3223_init;
+
+	err = ap3223_init_client(client);
+	if (err < 0)
+		goto exit_ap3223_init;
+
+	err = ap3223_init_reg_config(client);
+	if (err < 0) {
+		dev_err(&client->dev, "Failed to write initial reg config\n");
+		goto exit_ap3223_init;
+	}
+
+	err = regcache_sync(data->regmap);
+
+exit_ap3223_init:
+	return err;
+}
+
+static int ap3223_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct ap3223_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+	struct regmap *regmap;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	regmap = devm_regmap_init_i2c(client, &ap3223_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Regmap initialization failed.\n");
+		ret = PTR_ERR(regmap);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+
+	data->regmap = regmap;
+	data->client = client;
+	data->cali = AP3223_DEFAULT_CAL;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ap3223_info;
+	indio_dev->name = AP3223_DRV_NAME;
+	indio_dev->channels = ap3223_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ap3223_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = ap3223_init(data);
+	if (ret < 0) {
+		dev_err(&client->dev, "Chip init failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int ap3223_remove(struct i2c_client *client)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+
+	ap3223_sw_reset(data->client);
+	ap3223_set_mode(data->client, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id ap3223_id[] = {
+	{AP3223_DRV_NAME, 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ap3223_id);
+
+static struct i2c_driver ap3223_driver = {
+	.driver = {
+		.name = AP3223_DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe          = ap3223_probe,
+	.remove         = ap3223_remove,
+	.id_table       = ap3223_id,
+};
+
+module_i2c_driver(ap3223_driver);
+
+MODULE_AUTHOR("Suresh Rajashekara <sureshraj@google.com>");
+MODULE_DESCRIPTION("AP3223 Ambient Light and Proximity Sensor Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.6.0.rc2.230.g3dd15c0

