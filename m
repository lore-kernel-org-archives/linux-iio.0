Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40271 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab3HCVXm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 17:23:42 -0400
Message-ID: <51FD82EF.3080908@kernel.org>
Date: Sat, 03 Aug 2013 23:23:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, kyungmin.park@samsung.com,
	s.nawrocki@samsung.com
Subject: Re: [PATHC/RFC v3] iio: gp2ap020a00f: Add a driver for the device
References: <1374170651-3862-1-git-send-email-j.anaszewski@samsung.com> <1374170651-3862-2-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1374170651-3862-2-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/18/13 19:04, Jacek Anaszewski wrote:
> Add a new driver for the ambient light/proximity sensor
> device. The driver exposes three channels: light_clear
> light_ir and proximity. It also supports triggered buffer,
> high and low ambient light threshold event and proximity
> detection event.
>
Hi,

Sorry for the slow reply on this, been a busy few weeks.

Anyhow a few bits and bobs left I'm afraid.

The error handling in the probe function has gotten
all messed up and needs another look.

As you'll be respinning the patch anyway, switching over
to the new devm_iio_device_alloc would be good and simplify
your error paths a little.

It may well make sense to add a managed allocator for
iio_trig as well as the one we have for iio_dev.

There are some locally implemented versions of standard endian
conversion functions.  Please use the standard versions.

For your debugfs interface... I thought one of the things regmap gave
was a nice clean interface to do much the same as you have here?

Thanks,

Jonathan
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   20 +
>  drivers/iio/light/Kconfig                          |   12 +
>  drivers/iio/light/Makefile                         |    1 +
>  drivers/iio/light/gp2ap020a00f.c                   | 1547 ++++++++++++++++++++
>  4 files changed, 1580 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>  create mode 100644 drivers/iio/light/gp2ap020a00f.c
>
> diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> new file mode 100644
> index 0000000..e4f377d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> @@ -0,0 +1,20 @@
> +* Sharp GP2AP020A00F I2C Proximity/ALS sensor
> +
> +Required properties:
> +
> +  - compatible : should be "sharp,gp2ap020a00f"
> +  - reg : the I2C address of the light sensor
> +  - interrupt-parent : phandle to the parent interrupt controller
> +  - interrupts : should be INT interrupt pin
> +  - vled-supply : VLED power supply, as covered
> +		  in Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +Example:
> +
> +gp2ap020a00f@39 {
> +	compatible = "sharp,gp2ap020a00f";
> +	reg = <0x39>;
> +	interrupt-parent = <&gpx0>;
> +	interrupts = <2 0>;
> +	vled-supply = <...>;
> +};
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 5ef1a39..ad343a9 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -52,6 +52,18 @@ config VCNL4000
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called vcnl4000.
>
> +config GP2AP020A00F
> +	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here if you have a Sharp GP2AP020A00F proximity/als combo-chip
> +	  hooked to an I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gp2ap020a00f.
> +
>  config HID_SENSOR_ALS
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 040d9c7..b20c667 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
> +obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o

These should be in alphabetical order.    They weren't at
one point, but are now in the iio.git tree.
(not sure that patch has gone to Greg yet).

If not, I'll fix this up during merge.

> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> new file mode 100644
> index 0000000..12e06c1
> --- /dev/null
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -0,0 +1,1547 @@
> +/*
> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> + * Author: Jacek Anaszewski <j.anaszewski@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +#include <linux/debugfs.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define GP2A_I2C_NAME "gp2ap020a00f"
> +
> +/* Registers */
> +#define GP2AP020A00F_OP_REG	0x00 /* Basic operations */
> +#define GP2AP020A00F_ALS_REG	0x01 /* ALS related settings */
> +#define GP2AP020A00F_PS_REG	0x02 /* PS related settings */
> +#define GP2AP020A00F_LED_REG	0x03 /* LED reg */
> +#define GP2AP020A00F_TL_L_REG	0x04 /* ALS: Threshold low LSB */
> +#define GP2AP020A00F_TL_H_REG	0x05 /* ALS: Threshold low MSB */
> +#define GP2AP020A00F_TH_L_REG	0x06 /* ALS: Threshold high LSB */
> +#define GP2AP020A00F_TH_H_REG	0x07 /* ALS: Threshold high MSB */
> +#define GP2AP020A00F_PL_L_REG	0x08 /* PS: Threshold low LSB */
> +#define GP2AP020A00F_PL_H_REG	0x09 /* PS: Threshold low MSB */
> +#define GP2AP020A00F_PH_L_REG	0x0a /* PS: Threshold high LSB */
> +#define GP2AP020A00F_PH_H_REG	0x0b /* PS: Threshold high MSB */
> +#define GP2AP020A00F_D0_L_REG	0x0c /* ALS result: Clear/Illuminance LSB */
> +#define GP2AP020A00F_D0_H_REG	0x0d /* ALS result: Clear/Illuminance MSB */
> +#define GP2AP020A00F_D1_L_REG	0x0e /* ALS result: IR LSB */
> +#define GP2AP020A00F_D1_H_REG	0x0f /* ALS result: IR LSB */
> +#define GP2AP020A00F_D2_L_REG	0x10 /* PS result LSB */
> +#define GP2AP020A00F_D2_H_REG	0x11 /* PS result MSB */
> +#define GP2AP020A00F_NUM_REGS	0x12 /* Number of registers */
> +
> +/* OP_REG bits */
> +#define GP2AP020A00F_OP3_MASK		0x80 /* Software shutdown */
> +#define GP2AP020A00F_OP3_SHUTDOWN	0x00
> +#define GP2AP020A00F_OP3_OPERATION	0x80
> +#define GP2AP020A00F_OP2_MASK		0x40 /* Auto shutdown/Continuous mode */
> +#define GP2AP020A00F_OP2_AUTO_SHUTDOWN	0x00
> +#define GP2AP020A00F_OP2_CONT_OPERATION	0x40
> +#define GP2AP020A00F_OP_MASK		0x30 /* Operating mode selection  */
> +#define GP2AP020A00F_OP_ALS_AND_PS	0x00
> +#define GP2AP020A00F_OP_ALS		0x10
> +#define GP2AP020A00F_OP_PS		0x20
> +#define GP2AP020A00F_OP_DEBUG		0x30
> +#define GP2AP020A00F_PROX_MASK		0x08 /* PS: detection/non-detection */
> +#define GP2AP020A00F_PROX_NON_DETECT	0x00
> +#define GP2AP020A00F_PROX_DETECT	0x08
> +#define GP2AP020A00F_FLAG_P		0x04 /* PS: interrupt result  */
> +#define GP2AP020A00F_FLAG_A		0x02 /* ALS: interrupt result  */
> +#define GP2AP020A00F_TYPE_MASK		0x01 /* Output data type selection */
> +#define GP2AP020A00F_TYPE_MANUAL_CALC	0x00
> +#define GP2AP020A00F_TYPE_AUTO_CALC	0x01
> +
> +/* ALS_REG bits */
> +#define GP2AP020A00F_PRST_MASK		0xc0 /* Number of measurement cycles */
> +#define GP2AP020A00F_PRST_ONCE		0x00
> +#define GP2AP020A00F_PRST_4_CYCLES	0x40
> +#define GP2AP020A00F_PRST_8_CYCLES	0x80
> +#define GP2AP020A00F_PRST_16_CYCLES	0xc0
> +#define GP2AP020A00F_RES_A_MASK		0x38 /* ALS: Resolution */
> +#define GP2AP020A00F_RES_A_800ms	0x00
> +#define GP2AP020A00F_RES_A_400ms	0x08
> +#define GP2AP020A00F_RES_A_200ms	0x10
> +#define GP2AP020A00F_RES_A_100ms	0x18
> +#define GP2AP020A00F_RES_A_25ms		0x20
> +#define GP2AP020A00F_RES_A_6_25ms	0x28
> +#define GP2AP020A00F_RES_A_1_56ms	0x30
> +#define GP2AP020A00F_RES_A_0_39ms	0x38
> +#define GP2AP020A00F_RANGE_A_MASK	0x07 /* ALS: Max measurable range */
> +#define GP2AP020A00F_RANGE_A_x1		0x00
> +#define GP2AP020A00F_RANGE_A_x2		0x01
> +#define GP2AP020A00F_RANGE_A_x4		0x02
> +#define GP2AP020A00F_RANGE_A_x8		0x03
> +#define GP2AP020A00F_RANGE_A_x16	0x04
> +#define GP2AP020A00F_RANGE_A_x32	0x05
> +#define GP2AP020A00F_RANGE_A_x64	0x06
> +#define GP2AP020A00F_RANGE_A_x128	0x07
> +
> +/* PS_REG bits */
> +#define GP2AP020A00F_ALC_MASK		0x80 /* Auto light cancel */
> +#define GP2AP020A00F_ALC_ON		0x80
> +#define GP2AP020A00F_ALC_OFF		0x00
> +#define GP2AP020A00F_INTTYPE_MASK	0x40 /* Interrupt type setting */
> +#define GP2AP020A00F_INTTYPE_LEVEL	0x00
> +#define GP2AP020A00F_INTTYPE_PULSE	0x40
> +#define GP2AP020A00F_RES_P_MASK		0x38 /* PS: Resolution */
> +#define GP2AP020A00F_RES_P_800ms_x2	0x00
> +#define GP2AP020A00F_RES_P_400ms_x2	0x08
> +#define GP2AP020A00F_RES_P_200ms_x2	0x10
> +#define GP2AP020A00F_RES_P_100ms_x2	0x18
> +#define GP2AP020A00F_RES_P_25ms_x2	0x20
> +#define GP2AP020A00F_RES_P_6_25ms_x2	0x28
> +#define GP2AP020A00F_RES_P_1_56ms_x2	0x30
> +#define GP2AP020A00F_RES_P_0_39ms_x2	0x38
> +#define GP2AP020A00F_RANGE_P_MASK	0x07 /* PS: Max measurable range */
> +#define GP2AP020A00F_RANGE_P_x1		0x00
> +#define GP2AP020A00F_RANGE_P_x2		0x01
> +#define GP2AP020A00F_RANGE_P_x4		0x02
> +#define GP2AP020A00F_RANGE_P_x8		0x03
> +#define GP2AP020A00F_RANGE_P_x16	0x04
> +#define GP2AP020A00F_RANGE_P_x32	0x05
> +#define GP2AP020A00F_RANGE_P_x64	0x06
> +#define GP2AP020A00F_RANGE_P_x128	0x07
> +
> +/* LED reg bits */
> +#define GP2AP020A00F_INTVAL_MASK	0xc0 /* Intermittent operating */
> +#define GP2AP020A00F_INTVAL_0		0x00
> +#define GP2AP020A00F_INTVAL_4		0x40
> +#define GP2AP020A00F_INTVAL_8		0x80
> +#define GP2AP020A00F_INTVAL_16		0xc0
> +#define GP2AP020A00F_IS_MASK		0x30 /* ILED drive peak current */
> +#define GP2AP020A00F_IS_13_8mA		0x00
> +#define GP2AP020A00F_IS_27_5mA		0x10
> +#define GP2AP020A00F_IS_55mA		0x20
> +#define GP2AP020A00F_IS_110mA		0x30
> +#define GP2AP020A00F_PIN_MASK		0x0c /* INT terminal setting */
> +#define GP2AP020A00F_PIN_ALS_OR_PS	0x00
> +#define GP2AP020A00F_PIN_ALS		0x04
> +#define GP2AP020A00F_PIN_PS		0x08
> +#define GP2AP020A00F_PIN_PS_DETECT	0x0c
> +#define GP2AP020A00F_FREQ_MASK		0x02 /* LED modulation frequency */
> +#define GP2AP020A00F_FREQ_327_5kHz	0x00
> +#define GP2AP020A00F_FREQ_81_8kHz	0x02
> +#define GP2AP020A00F_RST		0x01 /* Software reset */
> +
> +#define GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR	0
> +#define GP2AP020A00F_SCAN_MODE_LIGHT_IR		1
> +#define GP2AP020A00F_SCAN_MODE_PROXIMITY	2
> +#define GP2AP020A00F_CHAN_TIMESTAMP		3
> +
> +#define GP2AP020A00F_DATA_READY_TIMEOUT		msecs_to_jiffies(1000)
> +
> +#define GP2AP020A00F_DATA_REG(chan)		(GP2AP020A00F_D0_L_REG + \
> +							(chan) * 2)
> +#define GP2AP020A00F_THRESH_VAL_ID(reg_addr)	((reg_addr - 4) / 2)
> +
> +#define GP2AP020A00F_SUBTRACT_MODE	0
> +#define GP2AP020A00F_ADD_MODE		1
> +
> +#define GP2AP020A00F_MAX_CHANNELS	3
> +
> +enum gp2ap020a00f_opmode {
> +	GP2AP020A00F_OPMODE_READ_RAW_CLEAR,
> +	GP2AP020A00F_OPMODE_READ_RAW_IR,
> +	GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY,
> +	GP2AP020A00F_OPMODE_ALS,
> +	GP2AP020A00F_OPMODE_PS,
> +	GP2AP020A00F_OPMODE_ALS_AND_PS,
> +	GP2AP020A00F_OPMODE_PROX_DETECT,
> +	GP2AP020A00F_OPMODE_SHUTDOWN,
> +	GP2AP020A00F_NUM_OPMODES,
> +};
> +
> +enum gp2ap020a00f_cmd {
> +	GP2AP020A00F_CMD_READ_RAW_CLEAR,
> +	GP2AP020A00F_CMD_READ_RAW_IR,
> +	GP2AP020A00F_CMD_READ_RAW_PROXIMITY,
> +	GP2AP020A00F_CMD_TRIGGER_CLEAR_EN,
> +	GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS,
> +	GP2AP020A00F_CMD_TRIGGER_IR_EN,
> +	GP2AP020A00F_CMD_TRIGGER_IR_DIS,
> +	GP2AP020A00F_CMD_TRIGGER_PROX_EN,
> +	GP2AP020A00F_CMD_TRIGGER_PROX_DIS,
> +	GP2AP020A00F_CMD_ALS_HIGH_EV_EN,
> +	GP2AP020A00F_CMD_ALS_HIGH_EV_DIS,
> +	GP2AP020A00F_CMD_ALS_LOW_EV_EN,
> +	GP2AP020A00F_CMD_ALS_LOW_EV_DIS,
> +	GP2AP020A00F_CMD_PROX_HIGH_EV_EN,
> +	GP2AP020A00F_CMD_PROX_HIGH_EV_DIS,
> +	GP2AP020A00F_CMD_PROX_LOW_EV_EN,
> +	GP2AP020A00F_CMD_PROX_LOW_EV_DIS,
> +};
> +
> +enum gp2ap020a00f_flags {
> +	GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER,
> +	GP2AP020A00F_FLAG_ALS_IR_TRIGGER,
> +	GP2AP020A00F_FLAG_PROX_TRIGGER,
> +	GP2AP020A00F_FLAG_PROX_RISING_EVENT,
> +	GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
> +	GP2AP020A00F_FLAG_ALS_RISING_EVENT,
> +	GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
> +	GP2AP020A00F_FLAG_LUX_MODE_HIGH,
> +};
> +
> +enum gp2ap020a00f_thresh_buf_id {
> +	GP2AP020A00F_THRESH_TL,
> +	GP2AP020A00F_THRESH_TH,
> +	GP2AP020A00F_THRESH_PL,
> +	GP2AP020A00F_THRESH_PH,
> +};
> +
> +struct gp2ap020a00f_data {
> +	const struct gp2ap020a00f_platform_data *pdata;
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	char *buffer;
> +	struct regulator *vled_reg;
> +	unsigned long flags;
> +	enum gp2ap020a00f_opmode cur_opmode;
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +	unsigned int thresh_reg_val[4];
> +	u8 debug_reg_addr;
> +};
> +
> +static const u8 gp2ap020a00f_reg_init_tab[] = {
> +	[GP2AP020A00F_OP_REG] = GP2AP020A00F_OP3_SHUTDOWN,
> +	[GP2AP020A00F_ALS_REG] = GP2AP020A00F_RES_A_25ms |
> +				 GP2AP020A00F_RANGE_A_x8,
> +	[GP2AP020A00F_PS_REG] = GP2AP020A00F_ALC_ON |
> +				GP2AP020A00F_RES_P_1_56ms_x2 |
> +				GP2AP020A00F_RANGE_P_x4,
> +	[GP2AP020A00F_LED_REG] = GP2AP020A00F_INTVAL_0 |
> +				 GP2AP020A00F_IS_110mA |
> +				 GP2AP020A00F_FREQ_327_5kHz,
> +	[GP2AP020A00F_TL_L_REG] = 0,
> +	[GP2AP020A00F_TL_H_REG] = 0,
> +	[GP2AP020A00F_TH_L_REG] = 0,
> +	[GP2AP020A00F_TH_H_REG] = 0,
> +	[GP2AP020A00F_PL_L_REG] = 0,
> +	[GP2AP020A00F_PL_H_REG] = 0,
> +	[GP2AP020A00F_PH_L_REG] = 0,
> +	[GP2AP020A00F_PH_H_REG] = 0,
> +};
> +
> +static bool gp2ap020a00f_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case GP2AP020A00F_OP_REG:
> +	case GP2AP020A00F_D0_L_REG:
> +	case GP2AP020A00F_D0_H_REG:
> +	case GP2AP020A00F_D1_L_REG:
> +	case GP2AP020A00F_D1_H_REG:
> +	case GP2AP020A00F_D2_L_REG:
> +	case GP2AP020A00F_D2_H_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config gp2ap020a00f_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = GP2AP020A00F_D2_H_REG,
> +	.cache_type = REGCACHE_RBTREE,
> +
> +	.volatile_reg = gp2ap020a00f_is_volatile_reg,
> +};
> +
> +static const struct gp2ap020a00f_mutable_config_regs {
> +	u8 op_reg;
> +	u8 als_reg;
> +	u8 ps_reg;
> +	u8 led_reg;
> +} opmode_regs_settings[GP2AP020A00F_NUM_OPMODES] = {
> +	[GP2AP020A00F_OPMODE_READ_RAW_CLEAR] = {
> +			GP2AP020A00F_OP_ALS | GP2AP020A00F_OP2_AUTO_SHUTDOWN
> +			| GP2AP020A00F_OP3_OPERATION
> +			| GP2AP020A00F_TYPE_MANUAL_CALC,
> +			GP2AP020A00F_PRST_ONCE,
> +			GP2AP020A00F_INTTYPE_LEVEL,
> +			GP2AP020A00F_PIN_ALS
> +	},
> +	[GP2AP020A00F_OPMODE_READ_RAW_IR] = {
> +			GP2AP020A00F_OP_ALS | GP2AP020A00F_OP2_AUTO_SHUTDOWN
> +			| GP2AP020A00F_OP3_OPERATION
> +			| GP2AP020A00F_TYPE_MANUAL_CALC,
> +			GP2AP020A00F_PRST_ONCE,
> +			GP2AP020A00F_INTTYPE_LEVEL,
> +			GP2AP020A00F_PIN_ALS
> +	},
> +	[GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY] = {
> +			GP2AP020A00F_OP_PS | GP2AP020A00F_OP2_AUTO_SHUTDOWN
> +			| GP2AP020A00F_OP3_OPERATION
> +			| GP2AP020A00F_TYPE_MANUAL_CALC,
> +			GP2AP020A00F_PRST_ONCE,
> +			GP2AP020A00F_INTTYPE_LEVEL,
> +			GP2AP020A00F_PIN_PS
> +	},
> +	[GP2AP020A00F_OPMODE_PROX_DETECT] = {
> +			GP2AP020A00F_OP_PS | GP2AP020A00F_OP2_CONT_OPERATION
> +			| GP2AP020A00F_OP3_OPERATION
> +			| GP2AP020A00F_TYPE_MANUAL_CALC,
> +			GP2AP020A00F_PRST_4_CYCLES,
> +			GP2AP020A00F_INTTYPE_PULSE,
> +			GP2AP020A00F_PIN_PS_DETECT
> +	},
> +	[GP2AP020A00F_OPMODE_ALS] = {
> +			GP2AP020A00F_OP_ALS | GP2AP020A00F_OP2_CONT_OPERATION
> +			| GP2AP020A00F_OP3_OPERATION
> +			| GP2AP020A00F_TYPE_MANUAL_CALC,
> +			GP2AP020A00F_PRST_ONCE,
> +			GP2AP020A00F_INTTYPE_LEVEL,
> +			GP2AP020A00F_PIN_ALS
> +	},
> +	[GP2AP020A00F_OPMODE_PS] = {
> +			GP2AP020A00F_OP_PS | GP2AP020A00F_OP2_CONT_OPERATION
> +			| GP2AP020A00F_OP3_OPERATION
> +			| GP2AP020A00F_TYPE_MANUAL_CALC,
> +			GP2AP020A00F_PRST_4_CYCLES,
> +			GP2AP020A00F_INTTYPE_LEVEL,
> +			GP2AP020A00F_PIN_PS
> +	},
> +	[GP2AP020A00F_OPMODE_ALS_AND_PS] = {
> +			GP2AP020A00F_OP_ALS_AND_PS
> +			| GP2AP020A00F_OP2_CONT_OPERATION
> +			| GP2AP020A00F_OP3_OPERATION
> +			| GP2AP020A00F_TYPE_MANUAL_CALC,
> +			GP2AP020A00F_PRST_4_CYCLES,
> +			GP2AP020A00F_INTTYPE_LEVEL,
> +			GP2AP020A00F_PIN_ALS_OR_PS
> +	},
> +	[GP2AP020A00F_OPMODE_SHUTDOWN] = {
> +			GP2AP020A00F_OP3_SHUTDOWN,
> +	},
> +};
> +
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static int gp2ap020a00f_show_reg_val(void *arg, u64 *val)
> +{
> +	struct gp2ap020a00f_data *data = arg;
> +	u8 reg_buf[GP2AP020A00F_NUM_REGS];
> +	int i, err;
> +
> +	memset(reg_buf, 0, sizeof(reg_buf));
> +
> +	err = regmap_bulk_read(data->regmap, GP2AP020A00F_OP_REG,
> +				reg_buf, GP2AP020A00F_NUM_REGS - 1);
> +	if (err < 0)
> +		goto error_ret;
> +
> +	for (i = 0; i < GP2AP020A00F_NUM_REGS; ++i)
> +		dev_notice(&data->client->dev,
> +			   "reg: %02x: %02x\n", i, reg_buf[i]);
> +
> +error_ret:
> +	*val = reg_buf[data->debug_reg_addr];
> +
> +	return 0;
> +}
> +
> +static int gp2ap020a00f_store_reg_val(void *arg, u64 val)
> +{
> +	struct gp2ap020a00f_data *data = arg;
> +
> +	regmap_write(data->regmap, data->debug_reg_addr, val);
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(gp2ap020a00f_reg_val_fops,
> +	gp2ap020a00f_show_reg_val, gp2ap020a00f_store_reg_val, "%02llx\n");
> +
> +static int gp2ap020a00f_show_reg_addr(void *arg, u64 *val)
> +{
> +	struct gp2ap020a00f_data *data = arg;
> +
> +	*val = data->debug_reg_addr;
> +
> +	return 0;
> +}
> +
> +static int gp2ap020a00f_store_reg_addr(void *arg, u64 val)
> +{
> +	struct gp2ap020a00f_data *data = arg;
> +
> +	data->debug_reg_addr = val;
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(gp2ap020a00f_reg_addr_fops,
> +	gp2ap020a00f_show_reg_addr, gp2ap020a00f_store_reg_addr, "%02llx\n");
> +
> +static int gp2ap020a00f_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +
Silly question, but doesn't regmap already give this functionality?

> +	debugfs_create_file("gp2ap020a00f_reg_addr", S_IRUSR | S_IWUSR,
> +		indio_dev->debugfs_dentry, data, &gp2ap020a00f_reg_addr_fops);
> +
> +	debugfs_create_file("gp2ap020a00f_reg_val", S_IRUSR | S_IWUSR,
> +		indio_dev->debugfs_dentry, data, &gp2ap020a00f_reg_val_fops);
> +
> +	return 0;
> +}
> +
> +#else
> +
> +static int gp2ap020a00f_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
> +static void gp2ap020a00f_word_to_bytes(int val, u8 *buf)
> +{
> +	buf[0] = val & 0xff;
> +	buf[1] = val >> 8;
Isn't this just a conventional endian conversion?  There are standard
functions for this.
> +}
> +
> +static void gp2ap020a00f_bytes_to_word(u8 *buf, int *val)
> +{
> +	*val = (buf[1] << 8) | buf[0];
Don't reinvent the wheel.  le16_to_cpu or similar....
> +}
> +
> +static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
> +					enum gp2ap020a00f_opmode op)
> +{
> +	u8 op_reg_mask = GP2AP020A00F_OP_MASK | GP2AP020A00F_OP2_MASK
> +			| GP2AP020A00F_OP3_MASK | GP2AP020A00F_TYPE_MASK;
> +	u8 als_reg_mask = GP2AP020A00F_PRST_MASK;
> +	u8 ps_reg_mask = GP2AP020A00F_INTTYPE_MASK;
> +	u8 led_reg_mask = GP2AP020A00F_PIN_MASK;
Why have these local temporary values?

> +	unsigned int op_reg_val;
> +	int err;
> +
> +	if (op != GP2AP020A00F_OPMODE_SHUTDOWN) {
> +		err = regmap_read(data->regmap, GP2AP020A00F_OP_REG,
> +					&op_reg_val);
> +		if (err < 0)
> +			return err;
> +		/*
> +		 * Shutdown the device if the operation being executed entails
> +		 * mode transition.
> +		 */
> +		if ((opmode_regs_settings[op].op_reg & GP2AP020A00F_OP_MASK) !=
> +		    (op_reg_val & GP2AP020A00F_OP_MASK)) {
> +			/* set shutdown mode */
> +			err = regmap_update_bits(data->regmap,
> +				GP2AP020A00F_OP_REG, GP2AP020A00F_OP3_MASK,
> +				GP2AP020A00F_OP3_SHUTDOWN);
> +			if (err < 0)
> +				return err;
> +		}
> +
> +		err = regmap_update_bits(data->regmap, GP2AP020A00F_ALS_REG,
> +			als_reg_mask, opmode_regs_settings[op].als_reg);
> +		if (err < 0)
> +			return err;
> +
> +		err = regmap_update_bits(data->regmap, GP2AP020A00F_PS_REG,
> +			ps_reg_mask, opmode_regs_settings[op].ps_reg);
> +		if (err < 0)
> +			return err;
> +
> +		err = regmap_update_bits(data->regmap, GP2AP020A00F_LED_REG,
> +			led_reg_mask, opmode_regs_settings[op].led_reg);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	/* Set OP_REG and apply operation mode (power on / off) */
> +	err = regmap_update_bits(data->regmap, GP2AP020A00F_OP_REG,
> +			op_reg_mask, opmode_regs_settings[op].op_reg);
> +	if (err < 0)
> +		return err;
> +
> +	data->cur_opmode = op;
> +
> +	return 0;
> +}
> +
> +static bool gp2ap020a00f_als_enabled(struct gp2ap020a00f_data *data)
> +{
> +	return test_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER,
> +							&data->flags) ||
> +	       test_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER,
> +							&data->flags) ||
> +	       test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
> +							&data->flags) ||
> +	       test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
> +							&data->flags);
> +}
> +
> +static bool gp2ap020a00f_prox_detect_enabled(struct gp2ap020a00f_data *data)
> +{
> +	return test_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT,
> +							&data->flags) ||
> +	       test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
> +							&data->flags);
> +}
> +
> +static int gp2ap020a00f_alter_opmode(struct gp2ap020a00f_data *data,
> +			enum gp2ap020a00f_opmode diff_mode, int add_sub)
> +{
> +	enum gp2ap020a00f_opmode new_mode;
> +	int err;
> +
> +	if (diff_mode != GP2AP020A00F_OPMODE_ALS &&
> +	    diff_mode != GP2AP020A00F_OPMODE_PS)
> +		return -EINVAL;
> +
> +	if (add_sub == GP2AP020A00F_ADD_MODE) {
> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_SHUTDOWN)
> +			new_mode =  diff_mode;
> +		else
> +			new_mode = GP2AP020A00F_OPMODE_ALS_AND_PS;
> +	} else {
> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_ALS_AND_PS)
> +			new_mode = (diff_mode == GP2AP020A00F_OPMODE_ALS) ?
> +					GP2AP020A00F_OPMODE_PS :
> +					GP2AP020A00F_OPMODE_ALS;
> +		else
> +			new_mode = GP2AP020A00F_OPMODE_SHUTDOWN;
> +	}
> +
> +	err = gp2ap020a00f_set_operation_mode(data, new_mode);
> +
> +	return err;
> +}
> +
> +static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
> +					enum gp2ap020a00f_cmd cmd)
> +{
> +	u8 thresh_buf[2] = {0x00, 0x00};
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case GP2AP020A00F_CMD_READ_RAW_CLEAR:
> +		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
> +			return -EBUSY;
> +		err = gp2ap020a00f_set_operation_mode(data,
> +					GP2AP020A00F_OPMODE_READ_RAW_CLEAR);
> +		break;
> +	case GP2AP020A00F_CMD_READ_RAW_IR:
> +		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
> +			return -EBUSY;
> +		err = gp2ap020a00f_set_operation_mode(data,
> +					GP2AP020A00F_OPMODE_READ_RAW_IR);
> +		break;
> +	case GP2AP020A00F_CMD_READ_RAW_PROXIMITY:
> +		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
> +			return -EBUSY;
> +		err = gp2ap020a00f_set_operation_mode(data,
> +					GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY);
> +		break;
> +	case GP2AP020A00F_CMD_TRIGGER_CLEAR_EN:
> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
> +			return -EBUSY;
> +		if (!gp2ap020a00f_als_enabled(data))
> +			err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_ALS,
> +						GP2AP020A00F_ADD_MODE);
> +		set_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &data->flags);
> +		break;
> +	case GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS:
> +		clear_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &data->flags);
> +		if (gp2ap020a00f_als_enabled(data))
> +			break;
> +		err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_ALS,
> +						GP2AP020A00F_SUBTRACT_MODE);
> +		break;
> +	case GP2AP020A00F_CMD_TRIGGER_IR_EN:
> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
> +			return -EBUSY;
> +		if (!gp2ap020a00f_als_enabled(data))
> +			err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_ALS,
> +						GP2AP020A00F_ADD_MODE);
> +		set_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &data->flags);
> +		break;
> +	case GP2AP020A00F_CMD_TRIGGER_IR_DIS:
> +		clear_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &data->flags);
> +		if (gp2ap020a00f_als_enabled(data))
> +			break;
> +		err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_ALS,
> +						GP2AP020A00F_SUBTRACT_MODE);
> +		break;
> +	case GP2AP020A00F_CMD_TRIGGER_PROX_EN:
> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
> +			return -EBUSY;
> +		err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_PS,
> +						GP2AP020A00F_ADD_MODE);
> +		set_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &data->flags);
> +		break;
> +	case GP2AP020A00F_CMD_TRIGGER_PROX_DIS:
> +		clear_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &data->flags);
> +		err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_PS,
> +						GP2AP020A00F_SUBTRACT_MODE);
> +		break;
> +	case GP2AP020A00F_CMD_ALS_HIGH_EV_EN:
> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
> +			return -EBUSY;
> +		if (!gp2ap020a00f_als_enabled(data)) {
> +			err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_ALS,
> +						GP2AP020A00F_ADD_MODE);
> +			if (err < 0)
> +				return err;
> +		}
> +		set_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT, &data->flags);
> +		gp2ap020a00f_word_to_bytes(
> +		    data->thresh_reg_val[GP2AP020A00F_THRESH_TH], thresh_buf);
> +		err = regmap_bulk_write(data->regmap, GP2AP020A00F_TH_L_REG,
> +						thresh_buf, 2);
> +		break;
> +	case GP2AP020A00F_CMD_ALS_HIGH_EV_DIS:
> +		clear_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT, &data->flags);
> +		if (!gp2ap020a00f_als_enabled(data)) {
> +			err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_ALS,
> +						GP2AP020A00F_SUBTRACT_MODE);
> +			if (err < 0)
> +				return err;
> +		}
> +		err = regmap_bulk_write(data->regmap, GP2AP020A00F_TH_L_REG,
> +						thresh_buf, 2);
> +		break;
> +	case GP2AP020A00F_CMD_ALS_LOW_EV_EN:
> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
> +			return -EBUSY;
> +		if (!gp2ap020a00f_als_enabled(data)) {
> +			err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_ALS,
> +						GP2AP020A00F_ADD_MODE);
> +			if (err < 0)
> +				return err;
> +		}
> +		set_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT, &data->flags);
> +		gp2ap020a00f_word_to_bytes(
> +		    data->thresh_reg_val[GP2AP020A00F_THRESH_TL], thresh_buf);
> +		err = regmap_bulk_write(data->regmap, GP2AP020A00F_TL_L_REG,
> +						thresh_buf, 2);
> +		break;
> +	case GP2AP020A00F_CMD_ALS_LOW_EV_DIS:
> +		clear_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT, &data->flags);
> +		if (!gp2ap020a00f_als_enabled(data)) {
> +			err = gp2ap020a00f_alter_opmode(data,
> +						GP2AP020A00F_OPMODE_ALS,
> +						GP2AP020A00F_SUBTRACT_MODE);
> +			if (err < 0)
> +				return err;
> +		}
> +		err = regmap_bulk_write(data->regmap, GP2AP020A00F_TL_L_REG,
> +						thresh_buf, 2);
> +		break;
> +	case GP2AP020A00F_CMD_PROX_HIGH_EV_EN:
> +		if (gp2ap020a00f_als_enabled(data) ||
> +		    data->cur_opmode == GP2AP020A00F_OPMODE_PS)
> +			return -EBUSY;
> +		if (!gp2ap020a00f_prox_detect_enabled(data)) {
> +			err = gp2ap020a00f_set_operation_mode(data,
> +					GP2AP020A00F_OPMODE_PROX_DETECT);
> +			if (err < 0)
> +				return err;
> +		}
> +		set_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT, &data->flags);
> +		gp2ap020a00f_word_to_bytes(
> +		    data->thresh_reg_val[GP2AP020A00F_THRESH_PH], thresh_buf);
> +		err = regmap_bulk_write(data->regmap, GP2AP020A00F_PH_L_REG,
> +						thresh_buf, 2);
> +		break;
> +	case GP2AP020A00F_CMD_PROX_HIGH_EV_DIS:
> +		clear_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT, &data->flags);
> +		err = gp2ap020a00f_set_operation_mode(data,
> +					GP2AP020A00F_OPMODE_SHUTDOWN);
> +		if (err < 0)
> +			return err;
> +		err = regmap_bulk_write(data->regmap, GP2AP020A00F_PH_L_REG,
> +						thresh_buf, 2);
> +		break;
> +	case GP2AP020A00F_CMD_PROX_LOW_EV_EN:
> +		if (gp2ap020a00f_als_enabled(data) ||
> +		    data->cur_opmode == GP2AP020A00F_OPMODE_PS)
> +			return -EBUSY;
> +		if (!gp2ap020a00f_prox_detect_enabled(data)) {
> +			err = gp2ap020a00f_set_operation_mode(data,
> +					GP2AP020A00F_OPMODE_PROX_DETECT);
> +			if (err < 0)
> +				return err;
> +		}
> +		set_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT, &data->flags);
> +		gp2ap020a00f_word_to_bytes(
> +		    data->thresh_reg_val[GP2AP020A00F_THRESH_PL], thresh_buf);
> +		err = regmap_bulk_write(data->regmap, GP2AP020A00F_PL_L_REG,
> +						thresh_buf, 2);
> +		break;
> +	case GP2AP020A00F_CMD_PROX_LOW_EV_DIS:
> +		clear_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT, &data->flags);
> +		err = gp2ap020a00f_set_operation_mode(data,
> +					GP2AP020A00F_OPMODE_SHUTDOWN);
> +		if (err < 0)
> +			return err;
> +		err = regmap_bulk_write(data->regmap, GP2AP020A00F_PL_L_REG,
> +						thresh_buf, 2);
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static int gp2ap020a00f_read_output(struct gp2ap020a00f_data *data,
> +					unsigned int output_reg, int *val)
> +{
> +	u8 reg_buf[2];
> +	int err;
> +
> +	err = regmap_bulk_read(data->regmap, output_reg, reg_buf, 2);
> +	if (err < 0)
> +		return err;
> +
> +	*val = (reg_buf[1] << 8) | reg_buf[0];
Use a standard endian conversion here (it might be free ;)
> +
> +	return err;
> +}
> +
> +static bool gp2ap020a00f_adjust_lux_mode(struct gp2ap020a00f_data *data,
> +				 int output_val)
> +{
> +	u8 new_range = 0xff;
> +	int err;
> +
> +	if (!test_bit(GP2AP020A00F_FLAG_LUX_MODE_HIGH, &data->flags)) {
> +		if (output_val > 16000) {
> +			set_bit(GP2AP020A00F_FLAG_LUX_MODE_HIGH,
> +								&data->flags);
> +			new_range = GP2AP020A00F_RANGE_A_x128;
> +		}
> +	} else {
> +		if (output_val < 1000) {
> +			clear_bit(GP2AP020A00F_FLAG_LUX_MODE_HIGH,
> +								&data->flags);
> +			new_range = GP2AP020A00F_RANGE_A_x8;
> +		}
> +	}
> +
> +	if (new_range != 0xff) {
> +		err = regmap_update_bits(data->regmap,
> +			GP2AP020A00F_ALS_REG,
> +			GP2AP020A00F_RANGE_A_MASK,
> +			new_range);
> +		if (err < 0) {
> +			dev_err(&data->client->dev,
> +				"Adjusting device lux mode failed.\n");
> +			goto error_ret;
> +		}
> +
> +		return true;
> +	}
> +
> +error_ret:
> +	return false;
> +}
> +
> +static irqreturn_t gp2ap020a00f_event_handler(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct gp2ap020a00f_data *lgt = iio_priv(indio_dev);
> +	u8 op_reg_flags, d0_reg_buf[2];
> +	unsigned int output_val, op_reg_val;
> +	int thresh_val_id, ret;
> +
> +	mutex_lock(&lgt->lock);
> +
> +	/* Read interrupt flags */
> +	ret = regmap_read(lgt->regmap, GP2AP020A00F_OP_REG,
> +					(unsigned int *)&op_reg_val);
> +	if (ret < 0)
> +		goto done;
> +
> +	op_reg_flags = op_reg_val & (GP2AP020A00F_FLAG_A | GP2AP020A00F_FLAG_P
> +					| GP2AP020A00F_PROX_DETECT);
> +
> +	op_reg_val &= (~GP2AP020A00F_FLAG_A & ~GP2AP020A00F_FLAG_P
> +					& ~GP2AP020A00F_PROX_DETECT);
> +
> +	/* Clear interrupt flags (if not in INTTYPE_PULSE mode) */
> +	if (lgt->cur_opmode != GP2AP020A00F_OPMODE_PROX_DETECT) {
> +		ret = regmap_write(lgt->regmap, GP2AP020A00F_OP_REG,
> +								op_reg_val);
> +		if (ret < 0)
> +			goto done;
> +	}
> +
> +	if (lgt->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_CLEAR ||
> +	    lgt->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_IR ||
> +	    lgt->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY) {
> +		goto done;
> +	}
> +
> +	if (gp2ap020a00f_prox_detect_enabled(lgt)) {
> +		if (op_reg_flags & GP2AP020A00F_PROX_DETECT) {
> +			iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(
> +				    IIO_PROXIMITY,
> +				    GP2AP020A00F_SCAN_MODE_PROXIMITY,
> +				    IIO_EV_TYPE_ROC,
> +				    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns());
> +		} else {
> +			iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(
> +				    IIO_PROXIMITY,
> +				    GP2AP020A00F_SCAN_MODE_PROXIMITY,
> +				    IIO_EV_TYPE_ROC,
> +				    IIO_EV_DIR_FALLING),
> +			       iio_get_time_ns());
> +		}
> +
> +		/*
> +		 * There shouldn't be anything else to do here
> +		 * in the PROX_DETECT mode.
> +		 */
> +		goto done;
> +	}
> +
> +
> +	/*
> +	 * We need to read output value to distinguish
> +	 * between high and low ambient light threshold event.
> +	 */
> +	if (op_reg_flags & GP2AP020A00F_FLAG_A) {
> +		ret = regmap_bulk_read(lgt->regmap, GP2AP020A00F_D0_L_REG,
> +							d0_reg_buf, 2);
> +		if (ret < 0)
> +			goto done;
> +
> +		output_val = (d0_reg_buf[1] << 8) | d0_reg_buf[0];
> +
> +		if (test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
> +							&lgt->flags)) {
> +			thresh_val_id =
> +			    GP2AP020A00F_THRESH_VAL_ID(GP2AP020A00F_TH_L_REG);
> +			if (output_val > lgt->thresh_reg_val[thresh_val_id])
> +				iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(
> +					    IIO_LIGHT,
> +					    GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
> +					    IIO_MOD_LIGHT_CLEAR,
> +					    IIO_EV_TYPE_THRESH,
> +					    IIO_EV_DIR_RISING),
> +				       iio_get_time_ns());
> +		}
> +
> +		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
> +							&lgt->flags)) {
> +			thresh_val_id =
> +			    GP2AP020A00F_THRESH_VAL_ID(GP2AP020A00F_TL_L_REG);
> +			if (output_val < lgt->thresh_reg_val[thresh_val_id])
I was going to suggest combining the two if statements above, but having
tried it can see just how ugly that ends up.  Hence probably best to leave
it as it is :)
> +				iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(
> +					    IIO_LIGHT,
> +					    GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
> +					    IIO_MOD_LIGHT_CLEAR,
> +					    IIO_EV_TYPE_THRESH,
> +					    IIO_EV_DIR_FALLING),
> +				       iio_get_time_ns());
> +		}
> +	}
> +
> +done:
> +	mutex_unlock(&lgt->lock);
> +
> +	/* This fires off trigger handler */
> +	iio_trigger_poll(lgt->trig, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
> +{
> +	struct iio_poll_func *pf = data;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct gp2ap020a00f_data *lgt = iio_priv(indio_dev);
> +	size_t d_size = 0;
> +	int i, out_val, ret;
> +
> +	mutex_lock(&lgt->lock);
> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +		ret = regmap_bulk_read(lgt->regmap,
> +				GP2AP020A00F_DATA_REG(i),
> +				&lgt->buffer[d_size], 2);
> +		if (ret < 0)
> +			goto done;
> +
> +		if (i == GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR ||
> +		    i == GP2AP020A00F_SCAN_MODE_LIGHT_IR) {
> +			gp2ap020a00f_bytes_to_word(&lgt->buffer[d_size],
> +								&out_val);
> +			gp2ap020a00f_adjust_lux_mode(lgt, out_val);
> +		}
> +		d_size += 2;
> +	}
> +
> +	if (indio_dev->scan_timestamp) {
> +		s64 *timestamp = (s64 *)((u8 *)lgt->buffer +
> +						ALIGN(d_size, sizeof(s64)));
> +		*timestamp = pf->timestamp;
> +	}
> +
> +	iio_push_to_buffers(indio_dev, lgt->buffer);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	mutex_unlock(&lgt->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u8 gp2ap020a00f_get_reg_by_event_code(u64 event_code)
> +{
> +	int event_dir = IIO_EVENT_CODE_EXTRACT_DIR(event_code);
> +
> +	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
> +	case IIO_PROXIMITY:
> +		if (event_dir == IIO_EV_DIR_RISING)
> +			return GP2AP020A00F_PH_L_REG;
> +		else
> +			return GP2AP020A00F_PL_L_REG;
> +	case IIO_LIGHT:
> +		if (event_dir == IIO_EV_DIR_RISING)
> +			return GP2AP020A00F_TH_L_REG;
> +		else
> +			return GP2AP020A00F_TL_L_REG;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
> +					u64 event_code, int val)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	bool event_en = false;
> +	u8 reg_buf[2], thresh_val_id;
> +	u8 thresh_reg_l;
> +	int err = 0;
> +
> +	mutex_lock(&data->lock);
> +
> +	thresh_reg_l = gp2ap020a00f_get_reg_by_event_code(event_code);
> +	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
> +
> +	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
> +		err = -EINVAL;
> +		goto error_ret;
> +	}
> +
> +	data->thresh_reg_val[thresh_val_id] = val;
> +
> +	switch (thresh_reg_l) {
> +	case GP2AP020A00F_TH_L_REG:
> +		if (test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
> +							&data->flags))
> +			event_en = true;
> +		break;
> +	case GP2AP020A00F_TL_L_REG:
> +		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
> +							&data->flags))
> +			event_en = true;
> +		break;
> +	case GP2AP020A00F_PH_L_REG:
> +		if (test_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT,
> +							&data->flags))
> +			event_en = true;
> +		break;
> +	case GP2AP020A00F_PL_L_REG:
> +		if (test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
> +							&data->flags))
> +			event_en = true;
event_en = !!test_bit(GP ... );


> +		break;
> +	}
> +
> +	if (event_en) {
> +		gp2ap020a00f_word_to_bytes(
> +			data->thresh_reg_val[thresh_val_id], reg_buf);
regbuf is clearly actually a 16 bit value so represent it as such
in your code + use standard endian conversion functions.
> +		err = regmap_bulk_write(data->regmap, thresh_reg_l,
> +								reg_buf, 2);
> +	}
> +
> +error_ret:
> +	mutex_unlock(&data->lock);
> +
> +	return err;
> +}
> +
> +static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
> +					u64 event_code, int *val)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	u8 thresh_reg_l;
> +	int err = 0;
> +
> +	mutex_lock(&data->lock);
> +
> +	thresh_reg_l = gp2ap020a00f_get_reg_by_event_code(event_code);
> +
> +	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
> +		err = -EINVAL;
> +		goto error_ret;
> +	}
> +
> +	*val = data->thresh_reg_val[GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l)];
> +
> +error_ret:
> +	mutex_unlock(&data->lock);
> +
> +	return err;
> +}
> +
> +static int gp2ap020a00f_write_prox_event_config(struct iio_dev *indio_dev,
> +					u64 event_code, int state)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	enum gp2ap020a00f_cmd cmd_high_ev, cmd_low_ev;
> +	int err;
> +
> +	cmd_high_ev = state ? GP2AP020A00F_CMD_PROX_HIGH_EV_EN :
> +			      GP2AP020A00F_CMD_PROX_HIGH_EV_DIS;
> +	cmd_low_ev = state ? GP2AP020A00F_CMD_PROX_LOW_EV_EN :
> +			     GP2AP020A00F_CMD_PROX_LOW_EV_DIS;
> +
> +	/* In order to enable proximity detection feature in the device
> +	 * both high and low threshold registers have to be written
> +	 * with different values, greater than zero.
> +	 */
> +	if (state) {
> +		if (data->thresh_reg_val[GP2AP020A00F_THRESH_PL] == 0)
> +			data->thresh_reg_val[GP2AP020A00F_THRESH_PL] = 10;
> +
> +		if (data->thresh_reg_val[GP2AP020A00F_THRESH_PH] == 0)
> +			data->thresh_reg_val[GP2AP020A00F_THRESH_PH] = 11;
> +	}
> +
> +	err = gp2ap020a00f_exec_cmd(data, cmd_high_ev);
> +	if (err < 0)
> +		return -EINVAL;
> +
> +	err = gp2ap020a00f_exec_cmd(data, cmd_low_ev);
> +	if (err < 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
> +					u64 event_code, int state)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	enum gp2ap020a00f_cmd cmd;
> +	int err;
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
> +	case IIO_PROXIMITY:
> +		err = gp2ap020a00f_write_prox_event_config(indio_dev,
> +					event_code, state);
> +		break;
> +	case IIO_LIGHT:
> +		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
> +					== IIO_EV_DIR_RISING) {
> +			cmd = state ? GP2AP020A00F_CMD_ALS_HIGH_EV_EN :
> +				      GP2AP020A00F_CMD_ALS_HIGH_EV_DIS;
> +			err = gp2ap020a00f_exec_cmd(data, cmd);
> +		} else {
> +			cmd = state ? GP2AP020A00F_CMD_ALS_LOW_EV_EN :
> +				      GP2AP020A00F_CMD_ALS_LOW_EV_DIS;
> +			err = gp2ap020a00f_exec_cmd(data, cmd);
> +		}
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return err;
> +}
> +
> +static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
> +					u64 event_code)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	int event_en = 0;
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
> +	case IIO_PROXIMITY:
> +		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
> +					== IIO_EV_DIR_RISING)
> +			event_en =
> +				test_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT,
> +								&data->flags);
> +		else
> +			event_en =
> +				test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
> +								&data->flags);
> +		break;
> +	case IIO_LIGHT:
> +		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
> +					== IIO_EV_DIR_RISING)
> +			event_en = test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
> +								&data->flags);
> +		else
> +			event_en = test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
> +								&data->flags);
> +		break;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return event_en;
> +}
> +
> +static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
> +				struct iio_chan_spec const *chan, int *val)
> +{
> +	enum gp2ap020a00f_cmd cmd;
> +	int cnt_loops = 0, err;
> +
> +	switch (chan->scan_index) {
> +	case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
> +		cmd = GP2AP020A00F_CMD_READ_RAW_CLEAR;
> +		break;
> +	case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
> +		cmd = GP2AP020A00F_CMD_READ_RAW_IR;
> +		break;
> +	case GP2AP020A00F_SCAN_MODE_PROXIMITY:
> +		cmd = GP2AP020A00F_CMD_READ_RAW_PROXIMITY;
> +		break;
> +	}
> +
> +	/*
> +	 * The purpose of this loop is repeating the conversion in case
> +	 * the output value exceedes the threshold related to the current
> +	 * lux mode - a new conversion has to be performed then, with
> +	 * adjusted maximum measurable range setting.
> +	 */
> +	do {
> +		err = gp2ap020a00f_exec_cmd(data, cmd);
> +		if (err < 0) {
> +			dev_err(&data->client->dev,
> +				"gp2ap020a00f_exec_cmd failed\n");
> +			goto error_ret;
> +		}
> +
> +		msleep(1000);
> +
> +		err = gp2ap020a00f_read_output(data, chan->address, val);
> +		if (err < 0)
> +			dev_err(&data->client->dev,
> +				"gp2ap020a00f_read_output failed\n");
> +
> +		data->cur_opmode = GP2AP020A00F_OPMODE_SHUTDOWN;
> +
> +		if (++cnt_loops > 2) {
> +			dev_err(&data->client->dev,
> +				"Lux mode adjusting error.\n");
> +			break;
> +		}
> +	} while ((cmd == GP2AP020A00F_CMD_READ_RAW_CLEAR ||
> +		  cmd == GP2AP020A00F_CMD_READ_RAW_IR) &&
> +		 gp2ap020a00f_adjust_lux_mode(data, *val));
> +
> +
> +error_ret:
> +	return err;
> +}
> +
> +static int gp2ap020a00f_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2,
> +			   long mask)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	int err = -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(indio_dev)) {
> +			err = -EBUSY;
> +			goto error_ret;
> +		}
> +
> +		err = gp2ap020a00f_read_channel(data, chan, val);
> +		break;
> +	}
> +
> +error_ret:
> +	mutex_unlock(&data->lock);
> +
> +	return err < 0 ? err : IIO_VAL_INT;
> +}
> +
> +static const struct iio_chan_spec gp2ap020a00f_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.shift = 0,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
> +		.scan_index = GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
> +		.address = GP2AP020A00F_D0_L_REG,
> +		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH,
> +					 IIO_EV_DIR_RISING) |
> +			      IIO_EV_BIT(IIO_EV_TYPE_THRESH,
> +					 IIO_EV_DIR_FALLING),
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.shift = 0,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
> +		.scan_index = GP2AP020A00F_SCAN_MODE_LIGHT_IR,
> +		.address = GP2AP020A00F_D1_L_REG,
> +	},
> +	{
> +		.type = IIO_PROXIMITY,
> +		.modified = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.shift = 0,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
> +		.scan_index = GP2AP020A00F_SCAN_MODE_PROXIMITY,
> +		.address = GP2AP020A00F_D2_L_REG,
> +		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_ROC,
> +					 IIO_EV_DIR_RISING) |
> +			      IIO_EV_BIT(IIO_EV_TYPE_ROC,
> +					 IIO_EV_DIR_FALLING),
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(GP2AP020A00F_CHAN_TIMESTAMP),
> +};
> +
> +static const struct iio_info gp2ap020a00f_info = {
> +	.read_raw = &gp2ap020a00f_read_raw,
> +	.read_event_value = &gp2ap020a00f_read_event_val,
> +	.read_event_config = &gp2ap020a00f_read_event_config,
> +	.write_event_value = &gp2ap020a00f_write_event_val,
> +	.write_event_config = &gp2ap020a00f_write_event_config,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	int i, err = 0;
> +
> +	mutex_lock(&data->lock);
> +
> +	/* Enable triggers according to the scan_mask */
> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +		switch (i) {
> +		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
> +			err = gp2ap020a00f_exec_cmd(data,
> +					GP2AP020A00F_CMD_TRIGGER_CLEAR_EN);
> +			if (err < 0)
> +				goto error_ret;
> +			break;
> +		case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
> +			err = gp2ap020a00f_exec_cmd(data,
> +					GP2AP020A00F_CMD_TRIGGER_IR_EN);
> +			if (err < 0)
> +				goto error_ret;
> +			break;
> +		case GP2AP020A00F_SCAN_MODE_PROXIMITY:
> +			err = gp2ap020a00f_exec_cmd(data,
> +					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
> +			if (err < 0)
> +				goto error_ret;
> +			break;
> +		}
> +	}
> +
> +	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	if (data->buffer == NULL) {
> +		err = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	err = iio_triggered_buffer_postenable(indio_dev);
> +
> +error_ret:
> +	mutex_unlock(&data->lock);
> +
> +	return err;
> +}
> +
> +static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	int i, err;
> +
> +	mutex_lock(&data->lock);
> +
> +	err = iio_triggered_buffer_predisable(indio_dev);
> +	if (err < 0)
> +		goto error_ret;
> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +		switch (i) {
> +		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
> +			err = gp2ap020a00f_exec_cmd(data,
> +					GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS);
> +			if (err < 0)
> +				goto error_ret;
> +			break;
> +		case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
> +			err = gp2ap020a00f_exec_cmd(data,
> +					GP2AP020A00F_CMD_TRIGGER_IR_DIS);
> +			if (err < 0)
> +				goto error_ret;
> +			break;
> +		case GP2AP020A00F_SCAN_MODE_PROXIMITY:
> +			err = gp2ap020a00f_exec_cmd(data,
> +					GP2AP020A00F_CMD_TRIGGER_PROX_DIS);
> +			if (err < 0)
> +				goto error_ret;
> +			break;
> +		}
> +	}
> +
> +	kfree(data->buffer);
> +
> +error_ret:
> +	mutex_unlock(&data->lock);
> +
> +	return err;
> +}
> +
> +static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
> +	.preenable = &iio_sw_buffer_preenable,
> +	.postenable = &gp2ap020a00f_buffer_postenable,
> +	.predisable = &gp2ap020a00f_buffer_predisable,
> +};
> +
> +static const struct iio_trigger_ops gp2ap020a00f_trigger_ops = {
> +	.owner = THIS_MODULE,
> +};
> +
> +static int gp2ap020a00f_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct gp2ap020a00f_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int err = -EINVAL;
No need to set err here. There are no paths where it is not otherwise
set (that I can see!)
> +
> +	indio_dev = iio_device_alloc(sizeof(*data));
> +	if (indio_dev == NULL) {
> +		err = -ENOMEM;
> +		goto error_alloc;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +
> +	data->vled_reg = devm_regulator_get(&client->dev, "vled");
> +	if (IS_ERR(data->vled_reg)) {
> +		err = PTR_ERR(data->vled_reg);
> +		goto error_regulator_get;
> +	}
> +
> +	err = regulator_enable(data->vled_reg);
> +	if (err)

> +		goto error_free_data;
> +
> +	regmap = devm_regmap_init_i2c(client, &gp2ap020a00f_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Regmap initialization failed.\n");
> +		err = PTR_ERR(regmap);
> +		goto error_free_data;
> +	}
> +
> +	/* Initialize device registers */
> +	err = regmap_bulk_write(regmap, GP2AP020A00F_OP_REG,
> +			gp2ap020a00f_reg_init_tab,
> +			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
> +
> +	if (err < 0) {
> +		dev_err(&client->dev, "Device initialization failed.\n");
> +		goto error_free_data;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data->client = client;
> +	data->cur_opmode = GP2AP020A00F_OPMODE_SHUTDOWN;
> +	data->regmap = regmap;
> +
> +	mutex_init(&data->lock);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = gp2ap020a00f_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(gp2ap020a00f_channels);
> +	indio_dev->info = &gp2ap020a00f_info;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* Allocate buffer */
> +	err = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +		&gp2ap020a00f_trigger_handler, &gp2ap020a00f_buffer_setup_ops);
> +	if (err < 0)
> +		goto error_free_data;
> +
> +	/* Allocate trigger */
> +	data->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
> +	if (data->trig == NULL) {
> +		err = -ENOMEM;
> +		dev_err(&indio_dev->dev, "Failed to allocate iio trigger.\n");
> +		goto error_uninit_buffer;
> +	}
> +
> +	err = request_threaded_irq(client->irq,
> +				   NULL,
> +				   &gp2ap020a00f_event_handler,
> +				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
> +					| IRQF_ONESHOT,
> +				   "gp2ap020a00f_event",
> +				   indio_dev);
> +	if (err < 0) {
> +		dev_err(&client->dev, "Irq request failed.\n");

should this one not also free the trigger?
> +		goto error_uninit_buffer;
> +	}
> +
> +	data->trig->private_data = indio_dev;
> +	data->trig->ops = &gp2ap020a00f_trigger_ops;
> +	data->trig->dev.parent = &data->client->dev;
> +
> +	err = iio_trigger_register(data->trig);
> +	if (err < 0) {
> +		dev_err(&client->dev, "Failed to register iio trigger.\n");
> +		goto error_free_irq;
> +	}
> +
> +	indio_dev->trig = data->trig;
> +
> +	err = iio_device_register(indio_dev);
> +	if (err < 0)
> +		goto error_free_irq;
> +
> +	gp2ap020a00f_debugfs_init(indio_dev);
> +
> +	return 0;
> +
> +error_free_irq:
> +	free_irq(client->irq, indio_dev);
> +error_uninit_buffer:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +error_free_data:
These error labels are somewhat confused to say the least.

> +	regulator_disable(data->vled_reg);
> +error_regulator_get:
> +	iio_device_free(indio_dev);
> +error_alloc:
> +	return err;
> +}
> +
> +static int gp2ap020a00f_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> +	int err;
> +
> +	err = gp2ap020a00f_set_operation_mode(data,
> +					GP2AP020A00F_OPMODE_SHUTDOWN);
> +	if (err < 0)
> +		dev_err(&indio_dev->dev, "Failed to power off the device.\n");
> +
> +	iio_device_unregister(indio_dev);
> +	free_irq(client->irq, indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	regulator_disable(data->vled_reg);
> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id gp2ap020a00f_id[] = {
> +	{ GP2A_I2C_NAME, 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id gp2ap020a00f_of_match[] = {
> +	{ .compatible = "sharp,gp2ap020a00f" },
> +	{ }
> +};
> +#endif
> +
> +static struct i2c_driver gp2ap020a00f_driver = {
> +	.driver = {
> +		.name	= GP2A_I2C_NAME,
> +		.of_match_table = of_match_ptr(gp2ap020a00f_of_match),
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= gp2ap020a00f_probe,
> +	.remove		= gp2ap020a00f_remove,
> +	.id_table	= gp2ap020a00f_id,
> +};
> +
> +module_i2c_driver(gp2ap020a00f_driver);
> +
> +MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
> +MODULE_DESCRIPTION("Sharp GP2AP020A00F Proximity/ALS sensor driver");
> +MODULE_LICENSE("GPL v2");
>
