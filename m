Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hartmut
 Knaack" <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, "Peter
 Meerwald" <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Subject: RE: [PATCH v2 1/4] iio: magn: Add support for BMC150 magnetometer
Date: Wed, 29 Apr 2015 18:00:36 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A5EC6D@irsmsx105.ger.corp.intel.com>
References: <1429814048-22808-1-git-send-email-irina.tirdea@intel.com>
 <1429814048-22808-2-git-send-email-irina.tirdea@intel.com>
 <553D1E1C.80009@kernel.org>
In-Reply-To: <553D1E1C.80009@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 26 April, 2015 20:19
> To: Tirdea, Irina; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Hartmut Knaack; Lars-Peter Clausen; Pet=
er Meerwald; Rob Herring; Pawel Moll; Mark Rutland; Ian
> Campbell; Kumar Gala
> Subject: Re: [PATCH v2 1/4] iio: magn: Add support for BMC150 magnetomete=
r
>=20
> On 23/04/15 19:34, Irina Tirdea wrote:
> > Add support for the Bosh BMC150 Magnetometer.
> Bosch. Good start :)
> > The specification can be downloaded from:
> > http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BM=
C150-DS000-04.pdf.
> > The chip contains both an accelerometer and a magnetometer.
> > This patch adds support only for the magnetometer part.
> >
> > The temperature compensation formulas are based on bmm050_api.c
> > authored by contact@bosch.sensortec.com.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Very nice.  A couple of tiny bits inline.  I'd like to leave this
> on the list for a few more days to see if anyone else has any comments
> to add to mine.  We are very early in this cycle, so no rush!
>=20

Thanks for the review, Jonathan!

> Thanks,
>=20
> Jonathan
> > ---
> >  drivers/iio/magnetometer/Kconfig       |  14 +
> >  drivers/iio/magnetometer/Makefile      |   2 +
> >  drivers/iio/magnetometer/bmc150_magn.c | 986 +++++++++++++++++++++++++=
++++++++
> >  3 files changed, 1002 insertions(+)
> >  create mode 100644 drivers/iio/magnetometer/bmc150_magn.c
> >
> > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetomete=
r/Kconfig
> > index a5d6de7..008baca 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -76,4 +76,18 @@ config IIO_ST_MAGN_SPI_3AXIS
> >  	depends on IIO_ST_MAGN_3AXIS
> >  	depends on IIO_ST_SENSORS_SPI
> >
> > +config BMC150_MAGN
> > +	tristate "Bosch BMC150 Magnetometer Driver"
> > +	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  Say yes here to build support for the BMC150 magnetometer.
> > +
> > +	  Currently this only supports the device via an i2c interface.
> > +
> > +	  This is a combo module with both accelerometer and magnetometer.
> > +	  This driver is only implementing magnetometer part, which has
> > +	  its own address and register map.
> > +
> >  endmenu
> > diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetomet=
er/Makefile
> > index 0f5d3c9..e2c3459 100644
> > --- a/drivers/iio/magnetometer/Makefile
> > +++ b/drivers/iio/magnetometer/Makefile
> > @@ -13,3 +13,5 @@ st_magn-$(CONFIG_IIO_BUFFER) +=3D st_magn_buffer.o
> >
> >  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) +=3D st_magn_i2c.o
> >  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) +=3D st_magn_spi.o
> > +
> > +obj-$(CONFIG_BMC150_MAGN) +=3D bmc150_magn.o
> > diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magne=
tometer/bmc150_magn.c
> > new file mode 100644
> > index 0000000..b8e4c90
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/bmc150_magn.c
> > @@ -0,0 +1,986 @@
> > +/*
> > + * Bosch BMC150 three-axis magnetic field sensor driver
> > + *
> > + * Copyright (c) 2015, Intel Corporation.
> > + *
> > + * This code is based on bmm050_api.c authored by contact@bosch.sensor=
tec.com:
> > + *
> > + * (C) Copyright 2011~2014 Bosch Sensortec GmbH All Rights Reserved
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/delay.h>
> > +#include <linux/slab.h>
> > +#include <linux/acpi.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/pm.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/regmap.h>
> > +
> > +#define BMC150_MAGN_DRV_NAME			"bmc150_magn"
> > +#define BMC150_MAGN_IRQ_NAME			"bmc150_magn_event"
> > +#define BMC150_MAGN_GPIO_INT			"interrupt"
> > +
> > +#define BMC150_MAGN_REG_CHIP_ID			0x40
> > +#define BMC150_MAGN_CHIP_ID_VAL			0x32
> > +
> > +#define BMC150_MAGN_REG_X_L			0x42
> > +#define BMC150_MAGN_REG_X_M			0x43
> > +#define BMC150_MAGN_REG_Y_L			0x44
> > +#define BMC150_MAGN_REG_Y_M			0x45
> > +#define BMC150_MAGN_SHIFT_XY_L			3
> > +#define BMC150_MAGN_REG_Z_L			0x46
> > +#define BMC150_MAGN_REG_Z_M			0x47
> > +#define BMC150_MAGN_SHIFT_Z_L			1
> > +#define BMC150_MAGN_REG_RHALL_L			0x48
> > +#define BMC150_MAGN_REG_RHALL_M			0x49
> > +#define BMC150_MAGN_SHIFT_RHALL_L		2
> > +
> > +#define BMC150_MAGN_REG_INT_STATUS		0x4A
> > +
> > +#define BMC150_MAGN_REG_POWER			0x4B
> > +#define BMC150_MAGN_MASK_POWER_CTL		BIT(0)
> > +
> > +#define BMC150_MAGN_REG_OPMODE_ODR		0x4C
> > +#define BMC150_MAGN_MASK_OPMODE			GENMASK(2, 1)
> > +#define BMC150_MAGN_SHIFT_OPMODE		1
> > +#define BMC150_MAGN_MODE_NORMAL			0x00
> > +#define BMC150_MAGN_MODE_FORCED			0x01
> > +#define BMC150_MAGN_MODE_SLEEP			0x03
> > +#define BMC150_MAGN_MASK_ODR			GENMASK(5, 3)
> > +#define BMC150_MAGN_SHIFT_ODR			3
> > +
> > +#define BMC150_MAGN_REG_INT			0x4D
> > +
> > +#define BMC150_MAGN_REG_INT_DRDY		0x4E
> > +#define BMC150_MAGN_MASK_DRDY_EN		BIT(7)
> > +#define BMC150_MAGN_SHIFT_DRDY_EN		7
> > +#define BMC150_MAGN_MASK_DRDY_INT3		BIT(6)
> > +#define BMC150_MAGN_MASK_DRDY_Z_EN		BIT(5)
> > +#define BMC150_MAGN_MASK_DRDY_Y_EN		BIT(4)
> > +#define BMC150_MAGN_MASK_DRDY_X_EN		BIT(3)
> > +#define BMC150_MAGN_MASK_DRDY_DR_POLARITY	BIT(2)
> > +#define BMC150_MAGN_MASK_DRDY_LATCHING		BIT(1)
> > +#define BMC150_MAGN_MASK_DRDY_INT3_POLARITY	BIT(0)
> > +
> > +#define BMC150_MAGN_REG_LOW_THRESH		0x4F
> > +#define BMC150_MAGN_REG_HIGH_THRESH		0x50
> > +#define BMC150_MAGN_REG_REP_XY			0x51
> > +#define BMC150_MAGN_REG_REP_Z			0x52
> > +
> > +#define BMC150_MAGN_REG_TRIM_START		0x5D
> > +#define BMC150_MAGN_REG_TRIM_END		0x71
> > +
> > +#define BMC150_MAGN_XY_OVERFLOW_VAL		-4096
> > +#define BMC150_MAGN_Z_OVERFLOW_VAL		-16384
> > +
> > +/* Time from SUSPEND to SLEEP */
> > +#define BMC150_MAGN_START_UP_TIME_MS		3
> > +
> > +#define BMC150_MAGN_AUTO_SUSPEND_DELAY_MS	2000
> > +
> > +#define BMC150_MAGN_REGVAL_TO_REPXY(regval) (((regval) * 2) + 1)
> > +#define BMC150_MAGN_REGVAL_TO_REPZ(regval) ((regval) + 1)
> > +#define BMC150_MAGN_REPXY_TO_REGVAL(rep) (((rep) - 1) / 2)
> > +#define BMC150_MAGN_REPZ_TO_REGVAL(rep) ((rep) - 1)
> > +
> > +enum bmc150_magn_axis {
> > +	AXIS_X,
> > +	AXIS_Y,
> > +	AXIS_Z,
> > +	RHALL,
> > +	AXIS_XYZ_MAX =3D RHALL,
> > +	AXIS_XYZR_MAX,
> > +};
> > +
> > +enum bmc150_magn_power_modes {
> > +	BMC150_MAGN_POWER_MODE_SUSPEND,
> > +	BMC150_MAGN_POWER_MODE_SLEEP,
> > +	BMC150_MAGN_POWER_MODE_NORMAL,
> > +};
> > +
> > +struct bmc150_magn_trim_regs {
> > +	s8 x1;
> > +	s8 y1;
> > +	__le16 reserved1;
> > +	u8 reserved2;
> > +	__le16 z4;
> > +	s8 x2;
> > +	s8 y2;
> > +	__le16 reserved3;
> > +	__le16 z2;
> > +	__le16 z1;
> > +	__le16 xyz1;
> > +	__le16 z3;
> > +	s8 xy2;
> > +	u8 xy1;
> > +} __packed;
> > +
> > +struct bmc150_magn_data {
> > +	struct i2c_client *client;
> > +	/*
> > +	 * 1. Protect this structure.
> > +	 * 2. Serialize sequences that power on/off the device and access HW.
> > +	 */
> > +	struct mutex mutex;
> > +	struct regmap *regmap;
> > +	/* 4 x 32 bits for x, y z, 4 bytes align, 64 bits timestamp */
> > +	s32 buffer[6];
> > +	struct iio_trigger *dready_trig;
> > +	bool dready_trigger_on;
> > +};
> > +
> > +static const struct {
> > +	int freq;
> > +	u8 reg_val;
> > +} bmc150_magn_samp_freq_table[] =3D { {2, 0x01},
> > +				    {6, 0x02},
> > +				    {8, 0x03},
> > +				    {10, 0x00},
> > +				    {15, 0x04},
> > +				    {20, 0x05},
> > +				    {25, 0x06},
> > +				    {30, 0x07} };
> > +
> > +enum bmc150_magn_presets {
> > +	LOW_POWER_PRESET,
> > +	REGULAR_PRESET,
> > +	ENHANCED_REGULAR_PRESET,
> > +	HIGH_ACCURACY_PRESET
> > +};
> > +
> > +static const struct bmc150_magn_preset {
> > +	u8 rep_xy;
> > +	u8 rep_z;
> > +	u8 odr;
> > +} bmc150_magn_presets_table[] =3D {
> > +	[LOW_POWER_PRESET] =3D {3, 3, 10},
> > +	[REGULAR_PRESET] =3D  {9, 15, 10},
> > +	[ENHANCED_REGULAR_PRESET] =3D  {15, 27, 10},
> > +	[HIGH_ACCURACY_PRESET] =3D  {47, 83, 20},
> > +};
> > +
> > +#define BMC150_MAGN_DEFAULT_PRESET REGULAR_PRESET
> > +
> > +static bool bmc150_magn_is_writeable_reg(struct device *dev, unsigned =
int reg)
> > +{
> > +	switch (reg) {
> > +	case BMC150_MAGN_REG_POWER:
> > +	case BMC150_MAGN_REG_OPMODE_ODR:
> > +	case BMC150_MAGN_REG_INT:
> > +	case BMC150_MAGN_REG_INT_DRDY:
> > +	case BMC150_MAGN_REG_LOW_THRESH:
> > +	case BMC150_MAGN_REG_HIGH_THRESH:
> > +	case BMC150_MAGN_REG_REP_XY:
> > +	case BMC150_MAGN_REG_REP_Z:
> > +		return true;
> > +	default:
> > +		return false;
> > +	};
> > +}
> > +
> > +static bool bmc150_magn_is_volatile_reg(struct device *dev, unsigned i=
nt reg)
> > +{
> > +	switch (reg) {
> > +	case BMC150_MAGN_REG_X_L:
> > +	case BMC150_MAGN_REG_X_M:
> > +	case BMC150_MAGN_REG_Y_L:
> > +	case BMC150_MAGN_REG_Y_M:
> > +	case BMC150_MAGN_REG_Z_L:
> > +	case BMC150_MAGN_REG_Z_M:
> > +	case BMC150_MAGN_REG_RHALL_L:
> > +	case BMC150_MAGN_REG_RHALL_M:
> > +	case BMC150_MAGN_REG_INT_STATUS:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static const struct regmap_config bmc150_magn_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +
> > +	.max_register =3D BMC150_MAGN_REG_TRIM_END,
> > +	.cache_type =3D REGCACHE_RBTREE,
> > +
> > +	.writeable_reg =3D bmc150_magn_is_writeable_reg,
> > +	.volatile_reg =3D bmc150_magn_is_volatile_reg,
> > +};
> > +
> > +static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
> > +				      enum bmc150_magn_power_modes mode,
> > +				      bool state)
> > +{
> > +	int ret;
> > +
> > +	switch (mode) {
> > +	case BMC150_MAGN_POWER_MODE_SUSPEND:
> > +		ret =3D regmap_update_bits(data->regmap, BMC150_MAGN_REG_POWER,
> > +					 BMC150_MAGN_MASK_POWER_CTL, !state);
> > +		if (ret < 0)
> > +			return ret;
> > +		usleep_range(BMC150_MAGN_START_UP_TIME_MS * 1000, 20000);
> > +		return 0;
> > +	case BMC150_MAGN_POWER_MODE_SLEEP:
> > +		return regmap_update_bits(data->regmap,
> > +					  BMC150_MAGN_REG_OPMODE_ODR,
> > +					  BMC150_MAGN_MASK_OPMODE,
> > +					  BMC150_MAGN_MODE_SLEEP <<
> > +					  BMC150_MAGN_SHIFT_OPMODE);
> > +	case BMC150_MAGN_POWER_MODE_NORMAL:
> > +		return regmap_update_bits(data->regmap,
> > +					  BMC150_MAGN_REG_OPMODE_ODR,
> > +					  BMC150_MAGN_MASK_OPMODE,
> > +					  BMC150_MAGN_MODE_NORMAL <<
> > +					  BMC150_MAGN_SHIFT_OPMODE);
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, =
bool on)
> > +{
> > +#ifdef CONFIG_PM
> > +	int ret;
> > +
> > +	if (on) {
> > +		ret =3D pm_runtime_get_sync(&data->client->dev);
> > +	} else {
> > +		pm_runtime_mark_last_busy(&data->client->dev);
> > +		ret =3D pm_runtime_put_autosuspend(&data->client->dev);
> > +	}
> > +
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev,
> > +			"failed to change power state to %d\n", on);
> > +		if (on)
> > +			pm_runtime_put_noidle(&data->client->dev);
> > +
> > +		return ret;
> > +	}
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val=
)
> > +{
> > +	int ret, reg_val;
> > +	u8 i, odr_val;
> > +
> > +	ret =3D regmap_read(data->regmap, BMC150_MAGN_REG_OPMODE_ODR, &reg_va=
l);
> > +	if (ret < 0)
> > +		return ret;
> > +	odr_val =3D (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR=
;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++)
> > +		if (bmc150_magn_samp_freq_table[i].reg_val =3D=3D odr_val) {
> > +			*val =3D bmc150_magn_samp_freq_table[i].freq;
> > +			return 0;
> > +		}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
> > +{
> > +	int ret;
> > +	u8 i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
> > +		if (bmc150_magn_samp_freq_table[i].freq =3D=3D val) {
> > +			ret =3D regmap_update_bits(data->regmap,
> > +						 BMC150_MAGN_REG_OPMODE_ODR,
> > +						 BMC150_MAGN_MASK_ODR,
> > +						 bmc150_magn_samp_freq_table[i].
> > +						 reg_val <<
> > +						 BMC150_MAGN_SHIFT_ODR);
> > +			if (ret < 0)
> > +				return ret;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static s32 bmc150_magn_compensate_x(struct bmc150_magn_trim_regs *treg=
s, s16 x,
> > +				    u16 rhall)
> > +{
> > +	s16 val;
> > +	u16 xyz1 =3D le16_to_cpu(tregs->xyz1);
> > +
> > +	if (x =3D=3D BMC150_MAGN_XY_OVERFLOW_VAL)
> > +		return S32_MIN;
> > +
> > +	if (!rhall)
> > +		rhall =3D xyz1;
> > +
> > +	val =3D ((s16)(((u16)((((s32)xyz1) << 14) / rhall)) - ((u16)0x4000)))=
;
> > +	val =3D ((s16)((((s32)x) * ((((((((s32)tregs->xy2) * ((((s32)val) *
> > +	      ((s32)val)) >> 7)) + (((s32)val) *
> > +	      ((s32)(((s16)tregs->xy1) << 7)))) >> 9) + ((s32)0x100000)) *
> > +	      ((s32)(((s16)tregs->x2) + ((s16)0xA0)))) >> 12)) >> 13)) +
> > +	      (((s16)tregs->x1) << 3);
> > +
> > +	return (s32)val;
> > +}
> > +
> > +static s32 bmc150_magn_compensate_y(struct bmc150_magn_trim_regs *treg=
s, s16 y,
> > +				    u16 rhall)
> > +{
> > +	s16 val;
> > +	u16 xyz1 =3D le16_to_cpu(tregs->xyz1);
> > +
> > +	if (y =3D=3D BMC150_MAGN_XY_OVERFLOW_VAL)
> > +		return S32_MIN;
> > +
> > +	if (!rhall)
> > +		rhall =3D xyz1;
> > +
> > +	val =3D ((s16)(((u16)((((s32)xyz1) << 14) / rhall)) - ((u16)0x4000)))=
;
> > +	val =3D ((s16)((((s32)y) * ((((((((s32)tregs->xy2) * ((((s32)val) *
> > +	      ((s32)val)) >> 7)) + (((s32)val) *
> > +	      ((s32)(((s16)tregs->xy1) << 7)))) >> 9) + ((s32)0x100000)) *
> > +	      ((s32)(((s16)tregs->y2) + ((s16)0xA0)))) >> 12)) >> 13)) +
> > +	      (((s16)tregs->y1) << 3);
> > +
> > +	return (s32)val;
> > +}
> > +
> > +static s32 bmc150_magn_compensate_z(struct bmc150_magn_trim_regs *treg=
s, s16 z,
> > +				    u16 rhall)
> > +{
> > +	s32 val;
> > +	u16 xyz1 =3D le16_to_cpu(tregs->xyz1);
> > +	u16 z1 =3D le16_to_cpu(tregs->z1);
> > +	s16 z2 =3D le16_to_cpu(tregs->z2);
> > +	s16 z3 =3D le16_to_cpu(tregs->z3);
> > +	s16 z4 =3D le16_to_cpu(tregs->z4);
> > +
> > +	if (z =3D=3D BMC150_MAGN_Z_OVERFLOW_VAL)
> > +		return S32_MIN;
> > +
> > +	val =3D (((((s32)(z - z4)) << 15) - ((((s32)z3) * ((s32)(((s16)rhall)=
 -
> > +	      ((s16)xyz1)))) >> 2)) / (z2 + ((s16)(((((s32)z1) *
> > +	      ((((s16)rhall) << 1))) + (1 << 15)) >> 16))));
> > +
> > +	return val;
> > +}
> > +
> > +static int bmc150_magn_read_xyz(struct bmc150_magn_data *data, s32 *bu=
ffer)
> > +{
> > +	int ret;
> > +	__le16 values[AXIS_XYZR_MAX];
> > +	s16 raw_x, raw_y, raw_z;
> > +	u16 rhall;
> > +	struct bmc150_magn_trim_regs tregs;
> > +
> > +	ret =3D regmap_bulk_read(data->regmap, BMC150_MAGN_REG_X_L,
> > +			       values, sizeof(values));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	raw_x =3D (s16)le16_to_cpu(values[AXIS_X]) >> BMC150_MAGN_SHIFT_XY_L;
> > +	raw_y =3D (s16)le16_to_cpu(values[AXIS_Y]) >> BMC150_MAGN_SHIFT_XY_L;
> > +	raw_z =3D (s16)le16_to_cpu(values[AXIS_Z]) >> BMC150_MAGN_SHIFT_Z_L;
> > +	rhall =3D le16_to_cpu(values[RHALL]) >> BMC150_MAGN_SHIFT_RHALL_L;
> > +
> > +	ret =3D regmap_bulk_read(data->regmap, BMC150_MAGN_REG_TRIM_START,
> > +			       &tregs, sizeof(tregs));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	buffer[AXIS_X] =3D bmc150_magn_compensate_x(&tregs, raw_x, rhall);
> > +	buffer[AXIS_Y] =3D bmc150_magn_compensate_y(&tregs, raw_y, rhall);
> > +	buffer[AXIS_Z] =3D bmc150_magn_compensate_z(&tregs, raw_z, rhall);
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int *val, int *val2, long mask)
> > +{
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +	s32 values[AXIS_XYZ_MAX];
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (iio_buffer_enabled(indio_dev))
> > +			return -EBUSY;
> > +		mutex_lock(&data->mutex);
> > +
> > +		ret =3D bmc150_magn_set_power_state(data, true);
> > +		if (ret < 0) {
> > +			mutex_unlock(&data->mutex);
> > +			return ret;
> > +		}
> > +
> > +		ret =3D bmc150_magn_read_xyz(data, values);
> > +		if (ret < 0) {
> > +			bmc150_magn_set_power_state(data, false);
> > +			mutex_unlock(&data->mutex);
> > +			return ret;
> > +		}
> > +		*val =3D values[chan->scan_index];
> > +
> > +		ret =3D bmc150_magn_set_power_state(data, false);
> > +		if (ret < 0) {
> > +			mutex_unlock(&data->mutex);
> > +			return ret;
> > +		}
> > +
> > +		mutex_unlock(&data->mutex);
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/*
> > +		 * The API/driver performs an off-chip temperature
> > +		 * compensation and outputs x/y/z magnetic field data in
> > +		 * 16 LSB/uT to the upper application layer.
> > +		 */
> > +		*val =3D 0;
> > +		*val2 =3D 625;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		ret =3D bmc150_magn_get_odr(data, val);
> > +		if (ret < 0)
> > +			return ret;
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
> > +				 struct iio_chan_spec const *chan,
> > +				 int val, int val2, long mask)
> > +{
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		mutex_lock(&data->mutex);
> > +		ret =3D bmc150_magn_set_odr(data, val);
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int bmc150_magn_validate_trigger(struct iio_dev *indio_dev,
> > +					struct iio_trigger *trig)
> > +{
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +
> > +	if (data->dready_trig !=3D trig)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("2 6 8 10 15 20 25 30");
> > +
> > +static struct attribute *bmc150_magn_attributes[] =3D {
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group bmc150_magn_attrs_group =3D {
> > +	.attrs =3D bmc150_magn_attributes,
> > +};
> > +
> > +#define BMC150_MAGN_CHANNEL(_axis) {					\
> > +	.type =3D IIO_MAGN,						\
> > +	.modified =3D 1,							\
> > +	.channel2 =3D IIO_MOD_##_axis,					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> > +				    BIT(IIO_CHAN_INFO_SCALE),		\
> > +	.scan_index =3D AXIS_##_axis,					\
> > +	.scan_type =3D {							\
> > +		.sign =3D 's',						\
> > +		.realbits =3D 32,						\
> > +		.storagebits =3D 32,					\
> > +		.shift =3D 0,						\
> Don't bother specifying the shift as it'll be set to 0 anyway.
> (also default in my mind will always be zero anyway for a shift so it
> doesn't serve a documentation purpose either!)

Right, there is no need for shift here.

> > +		.endianness =3D IIO_LE					\
> > +	},								\
> > +}
> > +
> > +static const struct iio_chan_spec bmc150_magn_channels[] =3D {
> > +	BMC150_MAGN_CHANNEL(X),
> > +	BMC150_MAGN_CHANNEL(Y),
> > +	BMC150_MAGN_CHANNEL(Z),
> > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
> > +
> > +static const struct iio_info bmc150_magn_info =3D {
> > +	.attrs =3D &bmc150_magn_attrs_group,
> > +	.read_raw =3D bmc150_magn_read_raw,
> > +	.write_raw =3D bmc150_magn_write_raw,
> > +	.validate_trigger =3D bmc150_magn_validate_trigger,
> > +	.driver_module =3D THIS_MODULE,
> > +};
> > +
> > +static const unsigned long bmc150_magn_scan_masks[] =3D {0x07, 0};
> > +
> > +static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret =3D bmc150_magn_read_xyz(data, data->buffer);
> > +	mutex_unlock(&data->mutex);
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > +					   pf->timestamp);
> > +
> > +err:
> > +	iio_trigger_notify_done(data->dready_trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int bmc150_magn_init(struct bmc150_magn_data *data)
> > +{
> > +	int ret, chip_id;
> > +	struct bmc150_magn_preset preset;
> > +
> > +	ret =3D bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPE=
ND,
> > +					 false);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev,
> > +			"Failed to bring up device from suspend mode\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D regmap_read(data->regmap, BMC150_MAGN_REG_CHIP_ID, &chip_id);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Failed reading chip id\n");
> > +		goto err_poweroff;
> > +	}
> > +	if (chip_id !=3D BMC150_MAGN_CHIP_ID_VAL) {
> > +		dev_err(&data->client->dev, "Invalid chip id 0x%x\n", ret);
> > +		ret =3D -ENODEV;
> > +		goto err_poweroff;
> > +	}
> > +	dev_dbg(&data->client->dev, "Chip id %x\n", ret);
> > +
> > +	preset =3D bmc150_magn_presets_table[BMC150_MAGN_DEFAULT_PRESET];
> > +	ret =3D bmc150_magn_set_odr(data, preset.odr);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Failed to set ODR to %d\n",
> > +			preset.odr);
> > +		goto err_poweroff;
> > +	}
> > +
> > +	ret =3D regmap_write(data->regmap, BMC150_MAGN_REG_REP_XY,
> > +			   BMC150_MAGN_REPXY_TO_REGVAL(preset.rep_xy));
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Failed to set REP XY to %d\n",
> > +			preset.rep_xy);
> > +		goto err_poweroff;
> > +	}
> > +
> > +	ret =3D regmap_write(data->regmap, BMC150_MAGN_REG_REP_Z,
> > +			   BMC150_MAGN_REPZ_TO_REGVAL(preset.rep_z));
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Failed to set REP Z to %d\n",
> > +			preset.rep_z);
> > +		goto err_poweroff;
> > +	}
> > +
> > +	ret =3D bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMA=
L,
> > +					 true);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Failed to power on device\n");
> > +		goto err_poweroff;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_poweroff:
> > +	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true=
);
> > +	return ret;
> > +}
> > +
> > +static int bmc150_magn_reset_intr(struct bmc150_magn_data *data)
> > +{
> > +	int tmp;
> > +
> > +	/*
> > +	 * Data Ready (DRDY) is always cleared after
> > +	 * readout of data registers ends.
> > +	 */
> > +	return regmap_read(data->regmap, BMC150_MAGN_REG_X_L, &tmp);
> > +}
> > +
> > +static int bmc150_magn_trig_try_reen(struct iio_trigger *trig)
> > +{
> > +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!data->dready_trigger_on)
> > +		return 0;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret =3D bmc150_magn_reset_intr(data);
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *=
trig,
> > +						  bool state)
> > +{
> > +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&data->mutex);
> > +	if (state =3D=3D data->dready_trigger_on)
> > +		goto err_unlock;
> > +
> > +	ret =3D bmc150_magn_set_power_state(data, state);
> > +	if (ret < 0)
> > +		goto err_unlock;
> > +
> > +	ret =3D regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
> > +				 BMC150_MAGN_MASK_DRDY_EN,
> > +				 state << BMC150_MAGN_SHIFT_DRDY_EN);
> > +	if (ret < 0)
> > +		goto err_poweroff;
> > +
> > +	data->dready_trigger_on =3D state;
> > +
> > +	if (state) {
> > +		ret =3D bmc150_magn_reset_intr(data);
> > +		if (ret < 0)
> > +			goto err_poweroff;
> > +	}
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return 0;
> > +
> > +err_poweroff:
> > +	bmc150_magn_set_power_state(data, false);
> > +err_unlock:
> > +	mutex_unlock(&data->mutex);
> > +	return ret;
> > +}
> > +
> > +static const struct iio_trigger_ops bmc150_magn_trigger_ops =3D {
> > +	.set_trigger_state =3D bmc150_magn_data_rdy_trigger_set_state,
> > +	.try_reenable =3D bmc150_magn_trig_try_reen,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static int bmc150_magn_gpio_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev;
> > +	struct gpio_desc *gpio;
> > +	int ret;
> > +
> > +	if (!client)
> > +		return -EINVAL;
> > +
> > +	dev =3D &client->dev;
> > +
> > +	/* data ready GPIO interrupt pin */
> > +	gpio =3D devm_gpiod_get_index(dev, BMC150_MAGN_GPIO_INT, 0);
> > +	if (IS_ERR(gpio)) {
> > +		dev_err(dev, "ACPI GPIO get index failed\n");
> > +		return PTR_ERR(gpio);
> > +	}
> > +
> > +	ret =3D gpiod_direction_input(gpio);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D gpiod_to_irq(gpio);
> > +
> > +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret=
);
> > +
> > +	return ret;
> > +}
> > +
> > +static const char *bmc150_magn_match_acpi_device(struct device *dev)
> > +{
> > +	const struct acpi_device_id *id;
> > +
> > +	id =3D acpi_match_device(dev->driver->acpi_match_table, dev);
> > +	if (!id)
> > +		return NULL;
> > +
> > +	return dev_name(dev);
> > +}
> > +
> > +static int bmc150_magn_probe(struct i2c_client *client,
> > +			     const struct i2c_device_id *id)
> > +{
> > +	struct bmc150_magn_data *data;
> > +	struct iio_dev *indio_dev;
> > +	const char *name =3D NULL;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data =3D iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data->client =3D client;
> > +
> > +	if (id)
> > +		name =3D id->name;
> > +	else if (ACPI_HANDLE(&client->dev))
> > +		name =3D bmc150_magn_match_acpi_device(&client->dev);
> > +	else
> > +		return -ENOSYS;
> > +
> > +	mutex_init(&data->mutex);
> > +	data->regmap =3D devm_regmap_init_i2c(client, &bmc150_magn_regmap_con=
fig);
> > +	if (IS_ERR(data->regmap)) {
> > +		dev_err(&client->dev, "Failed to allocate register map\n");
> > +		return PTR_ERR(data->regmap);
> > +	}
> > +
> > +	ret =3D bmc150_magn_init(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	indio_dev->dev.parent =3D &client->dev;
> > +	indio_dev->channels =3D bmc150_magn_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(bmc150_magn_channels);
> > +	indio_dev->available_scan_masks =3D bmc150_magn_scan_masks;
> > +	indio_dev->name =3D name;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->info =3D &bmc150_magn_info;
> > +
> > +	if (client->irq <=3D 0)
> > +		client->irq =3D bmc150_magn_gpio_probe(client);
> > +
> > +	if (client->irq > 0) {
> > +		data->dready_trig =3D devm_iio_trigger_alloc(&client->dev,
> > +							   "%s-dev%d",
> > +							   indio_dev->name,
> > +							   indio_dev->id);
> > +		if (!data->dready_trig) {
> > +			ret =3D -ENOMEM;
> > +			dev_err(&client->dev, "iio trigger alloc failed\n");
> > +			goto err_poweroff;
> > +		}
> > +
> > +		data->dready_trig->dev.parent =3D &client->dev;
> > +		data->dready_trig->ops =3D &bmc150_magn_trigger_ops;
> > +		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> > +		ret =3D iio_trigger_register(data->dready_trig);
> > +		if (ret) {
> > +			dev_err(&client->dev, "iio trigger register failed\n");
> > +			goto err_poweroff;
> > +		}
> > +
> > +		ret =3D iio_triggered_buffer_setup(indio_dev,
> > +						 &iio_pollfunc_store_time,
> > +						 bmc150_magn_trigger_handler,
> > +						 NULL);
> > +		if (ret < 0) {
> > +			dev_err(&client->dev,
> > +				"iio triggered buffer setup failed\n");
> > +			goto err_trigger_unregister;
> > +		}
> > +
> > +		ret =3D request_threaded_irq(client->irq,
> > +					   iio_trigger_generic_data_rdy_poll,
> > +					   NULL,
> > +					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > +					   BMC150_MAGN_IRQ_NAME,
> > +					   data->dready_trig);
> > +		if (ret < 0) {
> > +			dev_err(&client->dev, "request irq %d failed\n",
> > +				client->irq);
> > +			goto err_buffer_cleanup;
> > +		}
> > +	}
> > +
> > +	ret =3D iio_device_register(indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "unable to register iio device\n");
> > +		goto err_free_irq;
> > +	}
> > +
> > +	ret =3D pm_runtime_set_active(&client->dev);
> > +	if (ret)
> > +		goto err_iio_unregister;
> > +
> > +	pm_runtime_enable(&client->dev);
> > +	pm_runtime_set_autosuspend_delay(&client->dev,
> > +					 BMC150_MAGN_AUTO_SUSPEND_DELAY_MS);
> > +	pm_runtime_use_autosuspend(&client->dev);
> > +
> > +	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
> > +
> > +	return 0;
> > +
> > +err_iio_unregister:
> > +	iio_device_unregister(indio_dev);
> > +err_free_irq:
> > +	if (client->irq > 0)
> > +		free_irq(client->irq, data->dready_trig);
> > +err_buffer_cleanup:
> > +	if (data->dready_trig)
> > +		iio_triggered_buffer_cleanup(indio_dev);
> > +err_trigger_unregister:
> > +	if (data->dready_trig)
> > +		iio_trigger_unregister(data->dready_trig);
> > +err_poweroff:
> > +	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true=
);
> > +	return ret;
> > +}
> > +
> > +static int bmc150_magn_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +
> > +	pm_runtime_disable(&client->dev);
> > +	pm_runtime_set_suspended(&client->dev);
> > +	pm_runtime_put_noidle(&client->dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	if (client->irq > 0)
> > +		free_irq(data->client->irq, data->dready_trig);
> > +
> > +	if (data->dready_trig) {
> > +		iio_triggered_buffer_cleanup(indio_dev);
> > +		iio_trigger_unregister(data->dready_trig);
> > +	}
> > +
> > +	mutex_lock(&data->mutex);
> > +	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true=
);
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int bmc150_magn_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret =3D bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP=
,
> > +					 true);
> > +	mutex_unlock(&data->mutex);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "powering off device failed\n");
> > +		return -EAGAIN;
> Is EAGAIN a sensible error?  Would returning ret not make more sense?
>=20
I was thinking on forcing some retries for resume, but it's probably not wo=
rth it once we have i2c write errors.
I'll change it to ret.
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmc150_magn_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +
> > +	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL=
,
> > +					  true);
> > +}
> > +#endif
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int bmc150_magn_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret =3D bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP=
,
> > +					 true);
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static int bmc150_magn_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret =3D bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMA=
L,
> > +					 true);
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops bmc150_magn_pm_ops =3D {
> > +	SET_SYSTEM_SLEEP_PM_OPS(bmc150_magn_suspend, bmc150_magn_resume)
> > +	SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
> > +			   bmc150_magn_runtime_resume, NULL)
> > +};
> > +
> > +static const struct acpi_device_id bmc150_magn_acpi_match[] =3D {
> > +	{"BMC150B", 0},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
> > +
> > +static const struct i2c_device_id bmc150_magn_id[] =3D {
> > +	{"bmc150_magn", 0},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, bmc150_magn_id);
> > +
> > +static struct i2c_driver bmc150_magn_driver =3D {
> > +	.driver =3D {
> > +		   .name =3D BMC150_MAGN_DRV_NAME,
> > +		   .acpi_match_table =3D ACPI_PTR(bmc150_magn_acpi_match),
> > +		   .pm =3D &bmc150_magn_pm_ops,
> > +		   },
> > +	.probe =3D bmc150_magn_probe,
> > +	.remove =3D bmc150_magn_remove,
> > +	.id_table =3D bmc150_magn_id,
> > +};
> > +module_i2c_driver(bmc150_magn_driver);
> > +
> > +MODULE_AUTHOR("Irina Tirdea <irina.tirdea@intel.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("BMC150 magnetometer driver");
> >
