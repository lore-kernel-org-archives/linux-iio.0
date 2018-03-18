Return-Path: <SRS0=dHSi=GI=gmail.com=shreeya.patel23498@kernel.org>
Date: Sun, 18 Mar 2018 15:18:44 +0530
In-Reply-To: <20180310155731.7b7f584d@archlinux>
References: <1520677223-11505-1-git-send-email-shreeya.patel23498@gmail.com> <20180310155731.7b7f584d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2] Staging: iio: adis16209: Move adis16209 driver out of staging
To: Jonathan Cameron <jic23@kernel.org>
CC: lars@metafoo.de,Michael.Hennerich@analog.com,knaack.h@gmx.de,pmeerw@pmeerw.net,gregkh@linuxfoundation.org,linux-iio@vger.kernel.org,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org,daniel.baluta@gmail.com
From: Shreeya Patel <shreeya.patel23498@gmail.com>
Message-ID: <C8AE11A6-48CC-4EBD-AA5C-A08DDCD6970F@gmail.com>
List-ID: <linux-iio@vger.kernel.org>



On 10 March 2018 21:27:31 GMT+05:30, Jonathan Cameron <jic23@kernel=2Eorg>

Hi Jonathan

>On Sat, 10 Mar 2018 15:50:23 +0530
>Shreeya Patel <shreeya=2Epatel23498@gmail=2Ecom> wrote:
>
>> Move the adis16209 driver out of staging directory and merge to the
>> mainline IIO subsystem=2E
>>=20
>> Signed-off-by: Shreeya Patel <shreeya=2Epatel23498@gmail=2Ecom>
>As this has a clear dependency on the previous patch, please put them
>in the same series for the next version=2E  That way I won't miss one!
>
>This also doesn't actually seem to have all the patches in place=2E
>The sign extend one is definitely missing for some reason=2E
>
>One question on the ABI choice of X for the rotation axis=2E
>I think the logical choice is actually Z but would like to know what
>you and others think=2E
>
>All existing users of IIO_ROT (outside staging) have been magnetometer
>where we don't have an axis, but rather a magnetic reference frame or
>a quaternion output which includes all the axes=2E
>
>Jonathan
>
>> ---
>>=20
>> Changes in v2
>>   -Re-send the patch after having some cleanups in the
>> file included in this patch=2E
>>=20
>>  drivers/iio/accel/Kconfig             |  12 ++
>>  drivers/iio/accel/Makefile            |   1 +
>>  drivers/iio/accel/adis16209=2Ec         | 329
>++++++++++++++++++++++++++++++++++
>>  drivers/staging/iio/accel/Kconfig     |  12 --
>>  drivers/staging/iio/accel/Makefile    |   1 -
>>  drivers/staging/iio/accel/adis16209=2Ec | 329
>----------------------------------
>>  6 files changed, 342 insertions(+), 342 deletions(-)
>>  create mode 100644 drivers/iio/accel/adis16209=2Ec
>>  delete mode 100644 drivers/staging/iio/accel/adis16209=2Ec
>>=20
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index c6d9517=2E=2Ef95f43c 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -5,6 +5,18 @@
>> =20
>>  menu "Accelerometers"
>> =20
>> +config ADIS16209
>> +        tristate "Analog Devices ADIS16209 Dual-Axis Digital
>Inclinometer and Accelerometer"
>> +        depends on SPI
>> +        select IIO_ADIS_LIB
>> +        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
>> +        help
>> +          Say Y here to build support for Analog Devices adis16209
>dual-axis digital inclinometer
>> +          and accelerometer=2E
>> +
>> +          To compile this driver as a module, say M here: the module
>will be
>> +          called adis16209=2E
>> +
>>  config ADXL345
>>  	tristate
>> =20
>> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>> index 368aedb=2E=2E40861b9 100644
>> --- a/drivers/iio/accel/Makefile
>> +++ b/drivers/iio/accel/Makefile
>> @@ -4,6 +4,7 @@
>>  #
>> =20
>>  # When adding new entries keep the list in alphabetical order
>> +obj-$(CONFIG_ADIS16209) +=3D adis16209=2Eo
>>  obj-$(CONFIG_ADXL345) +=3D adxl345_core=2Eo
>>  obj-$(CONFIG_ADXL345_I2C) +=3D adxl345_i2c=2Eo
>>  obj-$(CONFIG_ADXL345_SPI) +=3D adxl345_spi=2Eo
>> diff --git a/drivers/iio/accel/adis16209=2Ec
>b/drivers/iio/accel/adis16209=2Ec
>> new file mode 100644
>> index 0000000=2E=2Eed2e89f
>> --- /dev/null
>> +++ b/drivers/iio/accel/adis16209=2Ec
>> @@ -0,0 +1,329 @@
>> +/*
>> + * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
>> + *
>> + * Copyright 2010 Analog Devices Inc=2E
>> + *
>> + * Licensed under the GPL-2 or later=2E
>> + */
>> +
>> +#include <linux/delay=2Eh>
>> +#include <linux/device=2Eh>
>> +#include <linux/kernel=2Eh>
>> +#include <linux/list=2Eh>
>> +#include <linux/module=2Eh>
>> +#include <linux/spi/spi=2Eh>
>> +#include <linux/slab=2Eh>
>> +#include <linux/sysfs=2Eh>
>> +
>> +#include <linux/iio/iio=2Eh>
>> +#include <linux/iio/sysfs=2Eh>
>> +#include <linux/iio/buffer=2Eh>
>> +#include <linux/iio/imu/adis=2Eh>
>> +
>> +#define ADIS16209_STARTUP_DELAY_MS	220
>> +#define ADIS16209_FLASH_CNT_REG		0x00
>> +
>> +/* Data Output Register Definitions */
>> +#define ADIS16209_SUPPLY_OUT_REG	0x02
>> +#define ADIS16209_XACCL_OUT_REG		0x04
>> +#define ADIS16209_YACCL_OUT_REG		0x06
>> +/* Output, auxiliary ADC input */
>> +#define ADIS16209_AUX_ADC_REG		0x08
>> +/* Output, temperature */
>> +#define ADIS16209_TEMP_OUT_REG		0x0A
>> +/* Output, +/- 90 degrees X-axis inclination */
>> +#define ADIS16209_XINCL_OUT_REG		0x0C
>> +#define ADIS16209_YINCL_OUT_REG		0x0E
>> +/* Output, +/-180 vertical rotational position */
>> +#define ADIS16209_ROT_OUT_REG		0x10
>> +
>> +/*
>> + * Calibration Register Definitions=2E
>> + * Acceleration, inclination or rotation offset null=2E
>> + */
>> +#define ADIS16209_XACCL_NULL_REG	0x12
>> +#define ADIS16209_YACCL_NULL_REG	0x14
>> +#define ADIS16209_XINCL_NULL_REG	0x16
>> +#define ADIS16209_YINCL_NULL_REG	0x18
>> +#define ADIS16209_ROT_NULL_REG		0x1A
>> +
>> +/* Alarm Register Definitions */
>> +#define ADIS16209_ALM_MAG1_REG		0x20
>> +#define ADIS16209_ALM_MAG2_REG		0x22
>> +#define ADIS16209_ALM_SMPL1_REG		0x24
>> +#define ADIS16209_ALM_SMPL2_REG		0x26
>> +#define ADIS16209_ALM_CTRL_REG		0x28

I see that these alarm registers are not being used anywhere in the driver=
 and yet we have it's declaration=2E=20
Is it the left out work that will be done in future?=20

>> +
>> +#define ADIS16209_AUX_DAC_REG		0x30
>> +#define ADIS16209_GPIO_CTRL_REG		0x32
>> +#define ADIS16209_SMPL_PRD_REG		0x36
>> +#define ADIS16209_AVG_CNT_REG		0x38
>> +#define ADIS16209_SLP_CNT_REG		0x3A
>> +
>> +#define ADIS16209_MSC_CTRL_REG			0x34
>> +#define  ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
>> +#define  ADIS16209_MSC_CTRL_SELF_TEST_EN	BIT(8)
>> +#define  ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
>> +/* Data-ready polarity: 1 =3D active high, 0 =3D active low */
>> +#define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
>> +#define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
>> +
>> +#define ADIS16209_STAT_REG			0x3C
>> +#define  ADIS16209_STAT_ALARM2			BIT(9)
>> +#define  ADIS16209_STAT_ALARM1			BIT(8)

Even here

>> +#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
>> +#define  ADIS16209_STAT_SPI_FAIL_BIT		3
>> +#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
>> +/* Power supply above 3=2E625 V */
>> +#define  ADIS16209_STAT_POWER_HIGH_BIT		1
>> +/* Power supply below 3=2E15 V */
>> +#define  ADIS16209_STAT_POWER_LOW_BIT		0
>> +
>> +#define ADIS16209_CMD_REG			0x3E
>> +#define  ADIS16209_CMD_SW_RESET			BIT(7)
>> +#define  ADIS16209_CMD_CLEAR_STAT		BIT(4)
>> +#define  ADIS16209_CMD_FACTORY_CAL		BIT(1)
>> +

Here also we are just using the register and not the bit macros anywhere=
=2E

I would like to know the reason behind this=2E=20

Thanks

>> +#define ADIS16209_ERROR_ACTIVE			BIT(14)
>> +
>> +enum adis16209_scan {
>> +	ADIS16209_SCAN_SUPPLY,
>> +	ADIS16209_SCAN_ACC_X,
>> +	ADIS16209_SCAN_ACC_Y,
>> +	ADIS16209_SCAN_AUX_ADC,
>> +	ADIS16209_SCAN_TEMP,
>> +	ADIS16209_SCAN_INCLI_X,
>> +	ADIS16209_SCAN_INCLI_Y,
>> +	ADIS16209_SCAN_ROT,
>> +};
>> +
>> +static const u8 adis16209_addresses[8][1] =3D {
>> +	[ADIS16209_SCAN_SUPPLY] =3D { },
>> +	[ADIS16209_SCAN_AUX_ADC] =3D { },
>> +	[ADIS16209_SCAN_ACC_X] =3D { ADIS16209_XACCL_NULL_REG },
>> +	[ADIS16209_SCAN_ACC_Y] =3D { ADIS16209_YACCL_NULL_REG },
>> +	[ADIS16209_SCAN_INCLI_X] =3D { ADIS16209_XINCL_NULL_REG },
>> +	[ADIS16209_SCAN_INCLI_Y] =3D { ADIS16209_YINCL_NULL_REG },
>> +	[ADIS16209_SCAN_ROT] =3D { },
>> +	[ADIS16209_SCAN_TEMP] =3D { },
>> +};
>> +
>> +static int adis16209_write_raw(struct iio_dev *indio_dev,
>> +			       struct iio_chan_spec const *chan,
>> +			       int val,
>> +			       int val2,
>> +			       long mask)
>> +{
>> +	struct adis *st =3D iio_priv(indio_dev);
>> +	int bits;
>> +	s16 val16;
>> +	u8 addr;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_CALIBBIAS:
>> +		switch (chan->type) {
>> +		case IIO_ACCEL:
>> +		case IIO_INCLI:
>> +			bits =3D 14;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		val16 =3D val & ((1 << bits) - 1);
>> +		addr =3D adis16209_addresses[chan->scan_index][0];
>> +		return adis_write_reg_16(st, addr, val16);
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static int adis16209_read_raw(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan,
>> +			      int *val, int *val2,
>> +			      long mask)
>> +{
>> +	struct adis *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +	int bits;
>> +	u8 addr;
>> +	s16 val16;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		return adis_single_conversion(indio_dev, chan,
>> +			ADIS16209_ERROR_ACTIVE, val);
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_VOLTAGE:
>> +			*val =3D 0;
>> +			if (chan->channel =3D=3D 0)
>> +				*val2 =3D 305180; /* 0=2E30518 mV */
>> +			else
>> +				*val2 =3D 610500; /* 0=2E6105 mV */
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		case IIO_TEMP:
>> +			*val =3D -470;
>> +			*val2 =3D 0;
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		case IIO_ACCEL:
>> +			/*
>> +			 * IIO base unit for sensitivity of accelerometer
>> +			 * is milli g=2E
>> +			 * 1 LSB represents 0=2E244 mg=2E
>> +			 */
>> +			*val =3D 0;
>> +			*val2 =3D IIO_G_TO_M_S_2(244140);
>> +			return IIO_VAL_INT_PLUS_NANO;
>> +		case IIO_INCLI:
>> +		case IIO_ROT:
>> +			/*
>> +			 * IIO base units for rotation are degrees=2E
>> +			 * 1 LSB represents 0=2E025 milli degrees=2E
>> +			 */
>> +			*val =3D 0;
>> +			*val2 =3D 25000;
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		/*
>> +		 * The raw ADC value is 0x4FE when the temperature
>> +		 * is 45 degrees and the scale factor per milli
>> +		 * degree celcius is -470=2E
>> +		 */
>> +		*val =3D 25000 / -470 - 0x4FE;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_CALIBBIAS:
>> +		switch (chan->type) {
>> +		case IIO_ACCEL:
>> +			bits =3D 14;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		addr =3D adis16209_addresses[chan->scan_index][0];
>> +		ret =3D adis_read_reg_16(st, addr, &val16);
>> +		if (ret)
>> +			return ret;
>> +		val16 &=3D (1 << bits) - 1;
>> +		val16 =3D (s16)(val16 << (16 - bits)) >> (16 - bits);
>> +		*val =3D val16;
>Something odd here as this isn't the current code - doesn't have the
>sign extend patch in place=2E
>
>> +		return IIO_VAL_INT;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_chan_spec adis16209_channels[] =3D {
>> +	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT_REG, ADIS16209_SCAN_SUPPLY,
>> +			 0, 14),
>> +	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT_REG, ADIS16209_SCAN_TEMP, 0, 12),
>> +	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT_REG, ADIS16209_SCAN_ACC_X,
>> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>> +	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT_REG, ADIS16209_SCAN_ACC_Y,
>> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>> +	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC_REG, ADIS16209_SCAN_AUX_ADC, 0,
>12),
>> +	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT_REG, ADIS16209_SCAN_INCLI_X,
>> +			0, 0, 14),
>> +	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT_REG, ADIS16209_SCAN_INCLI_Y,
>> +			0, 0, 14),
>> +	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT_REG, ADIS16209_SCAN_ROT, 0, 0,
>14),
>This raises an interesting question=2E  How do we define rotation axes?
>I would assume it was rotation about the axis, as such I think the
>correct
>axis for this is Z=2E
>
>However, then we consider the two inclination axis=2E Again fiddly=2E  I
>suppose
>it is inclination 'from' an axis, but in what plane?  I guess x and y
>is about as good as we can do on those ones with the assumption they
>are aligned to perpendicular to the vertical=2E
>
>> +	IIO_CHAN_SOFT_TIMESTAMP(8)
>> +};
>> +
>> +static const struct iio_info adis16209_info =3D {
>> +	=2Eread_raw =3D adis16209_read_raw,
>> +	=2Ewrite_raw =3D adis16209_write_raw,
>> +	=2Eupdate_scan_mode =3D adis_update_scan_mode,
>> +};
>> +
>> +static const char * const adis16209_status_error_msgs[] =3D {
>> +	[ADIS16209_STAT_SELFTEST_FAIL_BIT] =3D "Self test failure",
>> +	[ADIS16209_STAT_SPI_FAIL_BIT] =3D "SPI failure",
>> +	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] =3D "Flash update failed",
>> +	[ADIS16209_STAT_POWER_HIGH_BIT] =3D "Power supply above 3=2E625V",
>> +	[ADIS16209_STAT_POWER_LOW_BIT] =3D "Power supply below 3=2E15V",
>> +};
>> +
>> +static const struct adis_data adis16209_data =3D {
>> +	=2Eread_delay =3D 30,
>> +	=2Emsc_ctrl_reg =3D ADIS16209_MSC_CTRL_REG,
>> +	=2Eglob_cmd_reg =3D ADIS16209_CMD_REG,
>> +	=2Ediag_stat_reg =3D ADIS16209_STAT_REG,
>> +
>> +	=2Eself_test_mask =3D ADIS16209_MSC_CTRL_SELF_TEST_EN,
>> +	=2Eself_test_no_autoclear =3D true,
>> +	=2Estartup_delay =3D ADIS16209_STARTUP_DELAY_MS,
>> +
>> +	=2Estatus_error_msgs =3D adis16209_status_error_msgs,
>> +	=2Estatus_error_mask =3D BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
>> +		BIT(ADIS16209_STAT_SPI_FAIL_BIT) |
>> +		BIT(ADIS16209_STAT_FLASH_UPT_FAIL_BIT) |
>> +		BIT(ADIS16209_STAT_POWER_HIGH_BIT) |
>> +		BIT(ADIS16209_STAT_POWER_LOW_BIT),
>> +};
>> +
>> +static int adis16209_probe(struct spi_device *spi)
>> +{
>> +	int ret;
>> +	struct adis *st;
>> +	struct iio_dev *indio_dev;
>It's not one I personally feel strongly about but when there is no
>reason not to do it, reverse Christmas tree ordering is preferred for
>variable declarations=2E
>
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>Blank line here=2E
>
>> +	st =3D iio_priv(indio_dev);
>> +	spi_set_drvdata(spi, indio_dev);
>> +
>> +	indio_dev->name =3D spi->dev=2Edriver->name;
>> +	indio_dev->dev=2Eparent =3D &spi->dev;
>> +	indio_dev->info =3D &adis16209_info;
>> +	indio_dev->channels =3D adis16209_channels;
>> +	indio_dev->num_channels =3D ARRAY_SIZE(adis16209_channels);
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +
>> +	ret =3D adis_init(st, indio_dev, spi, &adis16209_data);
>> +	if (ret)
>> +		return ret;
>Blank line here=2E
>
>> +	ret =3D adis_setup_buffer_and_trigger(st, indio_dev, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D adis_initial_startup(st);
>> +	if (ret)
>> +		goto error_cleanup_buffer_trigger;
>> +	ret =3D iio_device_register(indio_dev);
>> +	if (ret)
>> +		goto error_cleanup_buffer_trigger;
>> +
>> +	return 0;
>> +
>> +error_cleanup_buffer_trigger:
>> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
>> +	return ret;
>> +}
>> +
>> +static int adis16209_remove(struct spi_device *spi)
>> +{
>> +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
>> +	struct adis *st =3D iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
>> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct spi_driver adis16209_driver =3D {
>> +	=2Edriver =3D {
>> +		=2Ename =3D "adis16209",
>> +	},
>> +	=2Eprobe =3D adis16209_probe,
>> +	=2Eremove =3D adis16209_remove,
>> +};
>> +module_spi_driver(adis16209_driver);
>> +
>> +MODULE_AUTHOR("Barry Song <21cnbao@gmail=2Ecom>");
>> +MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital
>Inclinometer and Accelerometer");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("spi:adis16209");]
>
><snip>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
