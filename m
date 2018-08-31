Return-Path: <SRS0=a+AT=LO=gmail.com=himanshujha199640@kernel.org>
Date: Fri, 31 Aug 2018 17:55:04 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Afonso Bordado <afonsobordado@az8.co>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: gyro: add support for fxas21002c
Message-ID: <20180831122504.GA5828@himanshu-Vostro-3559>
References: <20180830211825.12202-1-afonsobordado@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180830211825.12202-1-afonsobordado@az8.co>
List-ID: <linux-iio@vger.kernel.org>

Hello Afonso,

On Thu, Aug 30, 2018 at 10:18:22PM +0100, Afonso Bordado wrote:
> FXAS21002C is a 3 axis gyroscope with integrated temperature sensor
> 
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> ---
>  Changes in v2
>    - Use ANSI C Comments
>    - Minor cleanups
>    - More dscriptive devicetree bindings
> 
>  drivers/iio/gyro/Kconfig      |  11 +
>  drivers/iio/gyro/Makefile     |   1 +
>  drivers/iio/gyro/fxas21002c.c | 367 ++++++++++++++++++++++++++++++++++
>  3 files changed, 379 insertions(+)
>  create mode 100644 drivers/iio/gyro/fxas21002c.c
> 
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 3126cf05e6b9..d71e33ea9fa4 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -73,6 +73,17 @@ config BMG160_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config FXAS21002C
> +	tristate "Freescale FXAS21002C Gyroscope"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for the Freescale FXAS21002C Gyroscope
> +	  driver connected via I2C.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called fxas21002c.
> +
>  config HID_SENSOR_GYRO_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index 295ec780c4eb..ec3e2aeae92a 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_ADXRS450) += adxrs450.o
>  obj-$(CONFIG_BMG160) += bmg160_core.o
>  obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
>  obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
> +obj-$(CONFIG_FXAS21002C) += fxas21002c.o
>  
>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
>  
> diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
> new file mode 100644
> index 000000000000..261b73629544
> --- /dev/null
> +++ b/drivers/iio/gyro/fxas21002c.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FXAS21002C - Digital Angular Rate Gyroscope driver
> + *
> + * Copyright (c) 2018, Afonso Bordado <afonsobordado@az8.co>
> + *
> + * IIO driver for FXAS21002C (7-bit I2C slave address 0x20 or 0x21).
> + * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
> + * TODO:
> + *        ODR / Scale Support
> + *        Devicetree
> + *        Power management
> + *        LowPass/HighPass Filters
> + *        Buffers
> + *        Interrupts
> + *        Alarms
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regmap.h>

Nit: Alphabetical ordering would be nice.

> +#define FXAS21002C_DRV_NAME "fxas21002c"
> +
> +#define FXAS21002C_MAX_TRANSITION_TIME_MS 61
> +
> +#define FXAS21002C_CHIP_ID             0xD7
> +
> +#define FXAS21002C_REG_STATUS          0x00
> +#define FXAS21002C_REG_OUT_X_MSB       0x01
> +#define FXAS21002C_REG_OUT_X_LSB       0x02
> +#define FXAS21002C_REG_OUT_Y_MSB       0x03
> +#define FXAS21002C_REG_OUT_Y_LSB       0x04
> +#define FXAS21002C_REG_OUT_Z_MSB       0x05
> +#define FXAS21002C_REG_OUT_Z_LSB       0x06
> +#define FXAS21002C_REG_DR_STATUS       0x07
> +#define FXAS21002C_REG_F_STATUS        0x08
> +#define FXAS21002C_REG_F_SETUP         0x09
> +#define FXAS21002C_REG_F_EVENT         0x0A
> +#define FXAS21002C_REG_INT_SRC_FLAG    0x0B
> +#define FXAS21002C_REG_WHO_AM_I        0x0C
> +#define FXAS21002C_REG_CTRL_REG0       0x0D
> +#define FXAS21002C_REG_RT_CFG          0x0E
> +#define FXAS21002C_REG_RT_SRC          0x0F
> +#define FXAS21002C_REG_RT_THS          0x10
> +#define FXAS21002C_REG_RT_COUNT        0x11
> +#define FXAS21002C_REG_TEMP            0x12
> +
> +#define FXAS21002C_REG_CTRL_REG1       0x13
> +#define FXAS21002C_RST_BIT             BIT(6)
> +#define FXAS21002C_ACTIVE_BIT          BIT(1)
> +#define FXAS21002C_READY_BIT           BIT(0)
> +
> +#define FXAS21002C_REG_CTRL_REG2       0x14
> +#define FXAS21002C_REG_CTRL_REG3       0x15
> +
> +#define FXAS21002C_DEFAULT_ODR_HZ      800
> +
> +/* 0.0625 deg/s */
> +#define FXAS21002C_DEFAULT_SENSITIVITY IIO_DEGREE_TO_RAD(62500)
> +
> +#define FXAS21002C_TEMP_SCALE          1000
> +
> +enum fxas21002c_id {
> +	ID_FXAS21002C,
> +};
> +
> +enum fxas21002c_operating_mode {
> +	FXAS21002C_OM_BOOT,
> +	FXAS21002C_OM_STANDBY,
> +	FXAS21002C_OM_READY,
> +	FXAS21002C_OM_ACTIVE,
> +};
> +
> +struct fxas21002c_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_range fxas21002c_writable_ranges[] = {
> +	regmap_reg_range(FXAS21002C_REG_F_SETUP, FXAS21002C_REG_F_SETUP),
> +	regmap_reg_range(FXAS21002C_REG_CTRL_REG0, FXAS21002C_REG_RT_CFG),
> +	regmap_reg_range(FXAS21002C_REG_RT_THS, FXAS21002C_REG_RT_COUNT),
> +	regmap_reg_range(FXAS21002C_REG_CTRL_REG1, FXAS21002C_REG_CTRL_REG3),
> +};
> +
> +static const struct regmap_access_table fxas21002c_writable_table = {
> +	.yes_ranges = fxas21002c_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(fxas21002c_writable_ranges),
> +};
> +
> +static const struct regmap_range fxas21002c_volatile_ranges[] = {
> +	regmap_reg_range(FXAS21002C_REG_STATUS, FXAS21002C_REG_F_STATUS),
> +	regmap_reg_range(FXAS21002C_REG_F_EVENT, FXAS21002C_REG_INT_SRC_FLAG),
> +	regmap_reg_range(FXAS21002C_REG_RT_COUNT, FXAS21002C_REG_CTRL_REG1),
> +};
> +
> +static const struct regmap_access_table fxas21002c_volatile_table = {
> +	.yes_ranges = fxas21002c_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(fxas21002c_volatile_ranges),
> +};
> +
> +const struct regmap_config fxas21002c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = FXAS21002C_REG_CTRL_REG3,
> +	/* We don't specify a .rd_table because everything is readable */
> +	.wr_table = &fxas21002c_writable_table,
> +	.volatile_table = &fxas21002c_volatile_table,
> +};
> +EXPORT_SYMBOL(fxas21002c_regmap_config);

Is it necessary to export ?

Well, if you have plans in future to add SPI support
then probably it is essential. But for now it isn't.

Also, maybe adding SPI support in TODO ?

> +#define FXAS21002C_GYRO_CHAN(_axis) {					\
> +	.type = IIO_ANGL_VEL,						\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_ ## _axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.address = FXAS21002C_REG_OUT_ ## _axis ## _MSB,		\
> +}
> +
> +static const struct iio_chan_spec fxas21002c_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = FXAS21002C_REG_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	FXAS21002C_GYRO_CHAN(X),
> +	FXAS21002C_GYRO_CHAN(Y),
> +	FXAS21002C_GYRO_CHAN(Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static int fxas21002c_set_operating_mode(struct fxas21002c_data *data,
> +					 enum fxas21002c_operating_mode om)

If you plan to send a new version, then align this as:

static int fxas21002c_set_operating_mode(struct fxas21002c_data *data,
					 enum fxas21002c_operating_mode om)
> +{
> +	int ret;
> +	int mask;
> +
> +	switch (om) {
> +	case FXAS21002C_OM_STANDBY:
> +		mask = 0;
> +		break;
> +	case FXAS21002C_OM_READY:
> +		mask = FXAS21002C_READY_BIT;
> +		break;
> +	case FXAS21002C_OM_ACTIVE:
> +		mask = FXAS21002C_ACTIVE_BIT;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(data->regmap, FXAS21002C_REG_CTRL_REG1, mask);
> +	if (ret) {
> +		dev_err(&data->client->dev,
> +			"could not switch operating mode\n");
> +		return ret;
> +	}
> +
> +	msleep(FXAS21002C_MAX_TRANSITION_TIME_MS);
> +
> +	return 0;
> +}
> +
> +static void fxas21002c_standby(void *_data)
> +{
> +	struct fxas21002c_data *data = _data;
> +
> +	fxas21002c_set_operating_mode(data, FXAS21002C_OM_STANDBY);
> +}
> +
> +static int fxas21002c_reset(struct fxas21002c_data *data)
> +{
> +	int ret;
> +
> +	/*
> +	 * On issuing a Software Reset command over an I2C interface,
> +	 * the device immediately resets and does not send any
> +	 * acknowledgment (ACK) of the written byte to the Master.
> +	 *
> +	 * This is documented in table 46 on the datasheet. Due to this
> +	 * the write will fail with EREMOTEIO.
> +	 */
> +	ret = regmap_write(data->regmap,
> +			   FXAS21002C_REG_CTRL_REG1, FXAS21002C_RST_BIT);
> +
> +	if (ret != -EREMOTEIO) {
> +		dev_err(&data->client->dev, "could not reset device\n");
> +		return ret;
> +	}
> +
> +	regcache_mark_dirty(data->regmap);
> +
> +	/* Wait for device to boot up */
> +	msleep(FXAS21002C_MAX_TRANSITION_TIME_MS);
> +
> +	return 0;
> +}
> +
> +static int fxas21002c_verify_chip(struct fxas21002c_data *data)
> +{
> +	int ret;
> +	int chip_id;
> +
> +	ret = regmap_read(data->regmap, FXAS21002C_REG_WHO_AM_I, &chip_id);

Is this correct ?
regmap_read() needs unsigned int * as a the third agrument. This warning is
usually prompted on compilation IIRC and build shall fail!

> +	if (ret) {
> +		dev_err(&data->client->dev, "could not read device id\n");
> +		return ret;
> +	}
> +
> +	if (chip_id != FXAS21002C_CHIP_ID) {
> +		dev_err(&data->client->dev,
> +			"unsupported chip id %02x\n", chip_id);
						^ %02d ?

I have been skimming through the kernel source for a few a while and
have observed often that we ignore "-Wformat-signedness" warnings ?

-Wformat-signedness:
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
"If -Wformat is specified, also warn if the format string requires
 an unsigned argument and the argument is signed and vice versa."

And the ISO-C11 Standard says:
https://port70.net/~nsz/c/c11/n1570.html#7.21.6.1p9

 "If a conversion specification is invalid, the behavior is undefined.
 If any argument is not the correct type for the corresponding
 conversion specification, the behavior is *undefined*."

Undefined Behavior:
------------------

In the C community, undefined behavior may be humorously referred to as "nasal demons",
after a comp.std.c post that explained undefined behavior as allowing the compiler to
do _anything_ it chooses, even "to make demons fly out of your nose"

And Paul E. McKenney comments on compiler writers:
https://lwn.net/Articles/508999/

"I have seen the glint in their eyes when they discuss optimization
 techniques that you would not want your children to know about!"


You may try and check the compiler warning by building source with
"-Wformat-signedness" flag.

Otherwise, you can avoid my comment and call me a language-lawyer ;)

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fxas21002c_read_oneshot(struct fxas21002c_data *data,
> +				   struct iio_chan_spec const *chan, int *val)

Similar alignment here.

> +	int ret;
> +	__be16 bulk_raw;
> +
> +	switch (chan->type) {
> +	case IIO_ANGL_VEL:
> +		ret = regmap_bulk_read(data->regmap, chan->address,
> +				       &bulk_raw, sizeof(bulk_raw));
> +		if (ret)
> +			return ret;
> +
> +		*val = sign_extend32(be16_to_cpu(bulk_raw), 15);
> +		return IIO_VAL_INT;
> +	case IIO_TEMP:
> +		ret = regmap_read(data->regmap, chan->address, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int fxas21002c_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan, int *val,
> +			       int *val2, long mask)

Similarly here.

static int fxas21002c_read_raw(struct iio_dev *indio_dev,
			       struct iio_chan_spec const *chan, int *val,
			       int *val2, long mask)



Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
