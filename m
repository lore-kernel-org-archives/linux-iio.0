Return-Path: <ludovic.tancerel@maplehightech.com>
Content-Type: multipart/alternative; boundary="Apple-Mail=_5CBE2663-6BF5-4721-8F1C-4DA47F554D49"
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v4 1/7] Add meas-spec sensors common part
From: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
In-Reply-To: <561131E1.3010805@kernel.org>
Date: Mon, 5 Oct 2015 18:28:31 +0200
Cc: knaack.h@gmx.de,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org,
 William.Markezana@meas-spec.com
Message-Id: <E37D2F92-849A-41CB-9CBA-1608640C5F4E@maplehightech.com>
References: <1443708822-8580-1-git-send-email-ludovic.tancerel@maplehightech.com> <1443708822-8580-2-git-send-email-ludovic.tancerel@maplehightech.com> <561131E1.3010805@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_5CBE2663-6BF5-4721-8F1C-4DA47F554D49
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Thank you for the help in setting these drivers in order.

Regards,
Ludovic


Le 4 oct. 2015 =E0 16:04, Jonathan Cameron <jic23@kernel.org> a =E9crit =
:

> On 01/10/15 15:13, Ludovic Tancerel wrote:
>> Measurement specialties drivers common part.
>> These functions are used by further drivers
>> in the patchset: TSYS01, TSYS02D, HTU21, MS5637, MS8607
>>=20
>> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
> Thanks for your persistence on this!
>=20
> Anyhow, applied to the togreg branch of iio.git. Initially pushed out
> as testing for the autobuilders to play with it.
>=20
> Thanks,
>=20
> Jonathan
>> ---
>> drivers/iio/common/Kconfig                     |   1 +
>> drivers/iio/common/Makefile                    |   1 +
>> drivers/iio/common/ms_sensors/Kconfig          |   6 +
>> drivers/iio/common/ms_sensors/Makefile         |   5 +
>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 651 =
+++++++++++++++++++++++++
>> drivers/iio/common/ms_sensors/ms_sensors_i2c.h |  66 +++
>> 6 files changed, 730 insertions(+)
>> create mode 100644 drivers/iio/common/ms_sensors/Kconfig
>> create mode 100644 drivers/iio/common/ms_sensors/Makefile
>> create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>> create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>>=20
>> diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
>> index 790f106..26a6026 100644
>> --- a/drivers/iio/common/Kconfig
>> +++ b/drivers/iio/common/Kconfig
>> @@ -3,5 +3,6 @@
>> #
>>=20
>> source "drivers/iio/common/hid-sensors/Kconfig"
>> +source "drivers/iio/common/ms_sensors/Kconfig"
>> source "drivers/iio/common/ssp_sensors/Kconfig"
>> source "drivers/iio/common/st_sensors/Kconfig"
>> diff --git a/drivers/iio/common/Makefile =
b/drivers/iio/common/Makefile
>> index b1e4d9c..585da6a 100644
>> --- a/drivers/iio/common/Makefile
>> +++ b/drivers/iio/common/Makefile
>> @@ -8,5 +8,6 @@
>>=20
>> # When adding new entries keep the list in alphabetical order
>> obj-y +=3D hid-sensors/
>> +obj-y +=3D ms_sensors/
>> obj-y +=3D ssp_sensors/
>> obj-y +=3D st_sensors/
>> diff --git a/drivers/iio/common/ms_sensors/Kconfig =
b/drivers/iio/common/ms_sensors/Kconfig
>> new file mode 100644
>> index 0000000..b28a92b
>> --- /dev/null
>> +++ b/drivers/iio/common/ms_sensors/Kconfig
>> @@ -0,0 +1,6 @@
>> +#
>> +# Measurements Specialties sensors common library
>> +#
>> +
>> +config IIO_MS_SENSORS_I2C
>> +        tristate
>> diff --git a/drivers/iio/common/ms_sensors/Makefile =
b/drivers/iio/common/ms_sensors/Makefile
>> new file mode 100644
>> index 0000000..7846428
>> --- /dev/null
>> +++ b/drivers/iio/common/ms_sensors/Makefile
>> @@ -0,0 +1,5 @@
>> +#
>> +# Makefile for the Measurement Specialties sensor common modules.
>> +#
>> +
>> +obj-$(CONFIG_IIO_MS_SENSORS_I2C) +=3D ms_sensors_i2c.o
>> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>> new file mode 100644
>> index 0000000..056c4f3
>> --- /dev/null
>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>> @@ -0,0 +1,651 @@
>> +/*
>> + * Measurements Specialties driver common i2c functions
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/device.h>
>> +#include <linux/delay.h>
>> +
>> +#include "ms_sensors_i2c.h"
>> +
>> +/* Conversion times in us */
>> +static const u16 ms_sensors_ht_t_conversion_time[] =3D { 50000, =
25000,
>> +						       13000, 7000 };
>> +static const u16 ms_sensors_ht_h_conversion_time[] =3D { 16000, =
3000,
>> +						       5000, 8000 };
>> +static const u16 ms_sensors_tp_conversion_time[] =3D { 500, 1100, =
2100,
>> +						     4100, 8220, 16440 =
};
>> +
>> +#define MS_SENSORS_SERIAL_READ_MSB		0xFA0F
>> +#define MS_SENSORS_SERIAL_READ_LSB		0xFCC9
>> +#define MS_SENSORS_CONFIG_REG_WRITE		0xE6
>> +#define MS_SENSORS_CONFIG_REG_READ		0xE7
>> +#define MS_SENSORS_HT_T_CONVERSION_START	0xF3
>> +#define MS_SENSORS_HT_H_CONVERSION_START	0xF5
>> +
>> +#define MS_SENSORS_TP_PROM_READ			0xA0
>> +#define MS_SENSORS_TP_T_CONVERSION_START	0x50
>> +#define MS_SENSORS_TP_P_CONVERSION_START	0x40
>> +#define MS_SENSORS_TP_ADC_READ			0x00
>> +
>> +#define MS_SENSORS_NO_READ_CMD			0xFF
>> +
>> +/**
>> + * ms_sensors_reset() - Reset function
>> + * @cli:	pointer to device client
>> + * @cmd:	reset cmd. Depends on device in use
>> + * @delay:	usleep minimal delay after reset command is issued
>> + *
>> + * Generic I2C reset function for Measurement Specialties devices.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_reset(void *cli, u8 cmd, unsigned int delay)
>> +{
>> +	int ret;
>> +	struct i2c_client *client =3D cli;
>> +
>> +	ret =3D i2c_smbus_write_byte(client, cmd);
>> +	if (ret) {
>> +		dev_err(&client->dev, "Failed to reset device\n");
>> +		return ret;
>> +	}
>> +	usleep_range(delay, delay + 1000);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_reset);
>> +
>> +/**
>> + * ms_sensors_read_prom_word() - PROM word read function
>> + * @cli:	pointer to device client
>> + * @cmd:	PROM read cmd. Depends on device and prom id
>> + * @word:	pointer to word destination value
>> + *
>> + * Generic i2c prom word read function for Measurement Specialties =
devices.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_read_prom_word(void *cli, int cmd, u16 *word)
>> +{
>> +	int ret;
>> +	struct i2c_client *client =3D (struct i2c_client *)cli;
>> +
>> +	ret =3D i2c_smbus_read_word_swapped(client, cmd);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Failed to read prom word\n");
>> +		return ret;
>> +	}
>> +	*word =3D ret;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_read_prom_word);
>> +
>> +/**
>> + * ms_sensors_convert_and_read() - ADC conversion & read function
>> + * @cli:	pointer to device client
>> + * @conv:	ADC conversion command. Depends on device in use
>> + * @rd:		ADC read command. Depends on device in use
>> + * @delay:	usleep minimal delay after conversion command is issued
>> + * @adc:	pointer to ADC destination value
>> + *
>> + * Generic ADC conversion & read function for Measurement =
Specialties
>> + * devices.
>> + * The function will issue conversion command, sleep appopriate =
delay, and
>> + * issue command to read ADC.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,
>> +				unsigned int delay, u32 *adc)
>> +{
>> +	int ret;
>> +	u32 buf =3D 0;
>> +	struct i2c_client *client =3D (struct i2c_client *)cli;
>> +
>> +	/* Trigger conversion */
>> +	ret =3D i2c_smbus_write_byte(client, conv);
>> +	if (ret)
>> +		goto err;
>> +	usleep_range(delay, delay + 1000);
>> +
>> +	/* Retrieve ADC value */
>> +	if (rd !=3D MS_SENSORS_NO_READ_CMD)
>> +		ret =3D i2c_smbus_read_i2c_block_data(client, rd, 3, (u8 =
*)&buf);
>> +	else
>> +		ret =3D i2c_master_recv(client, (u8 *)&buf, 3);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	dev_dbg(&client->dev, "ADC raw value : %x\n", be32_to_cpu(buf) =
>> 8);
>> +	*adc =3D be32_to_cpu(buf) >> 8;
>> +
>> +	return 0;
>> +err:
>> +	dev_err(&client->dev, "Unable to make sensor adc conversion\n");
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_convert_and_read);
>> +
>> +/**
>> + * ms_sensors_crc_valid() - CRC check function
>> + * @value:	input and CRC compare value
>> + *
>> + * Cyclic Redundancy Check function used in TSYS02D, HTU21, MS8607.
>> + * This function performs a x^8 + x^5 + x^4 + 1 polynomial CRC.
>> + * The argument contains CRC value in LSB byte while the bytes 1 and =
2
>> + * are used for CRC computation.
>> + *
>> + * Return: 1 if CRC is valid, 0 otherwise.
>> + */
>> +static bool ms_sensors_crc_valid(u32 value)
>> +{
>> +	u32 polynom =3D 0x988000;	/* x^8 + x^5 + x^4 + 1 */
>> +	u32 msb =3D 0x800000;
>> +	u32 mask =3D 0xFF8000;
>> +	u32 result =3D value & 0xFFFF00;
>> +	u8 crc =3D value & 0xFF;
>> +
>> +	while (msb !=3D 0x80) {
>> +		if (result & msb)
>> +			result =3D ((result ^ polynom) & mask)
>> +				| (result & ~mask);
>> +		msb >>=3D 1;
>> +		mask >>=3D 1;
>> +		polynom >>=3D 1;
>> +	}
>> +
>> +	return result =3D=3D crc;
>> +}
>> +
>> +/**
>> + * ms_sensors_read_serial() - Serial number read function
>> + * @cli:	pointer to i2c client
>> + * @sn:		pointer to 64-bits destination value
>> + *
>> + * Generic i2c serial number read function for Measurement =
Specialties devices.
>> + * This function is used for TSYS02d, HTU21, MS8607 chipset.
>> + * Refer to datasheet:
>> + *	=
http://www.meas-spec.com/downloads/HTU2X_Serial_Number_Reading.pdf
>> + *
>> + * Sensor raw MSB serial number format is the following :
>> + *	[ SNB3, CRC, SNB2, CRC, SNB1, CRC, SNB0, CRC]
>> + * Sensor raw LSB serial number format is the following :
>> + *	[ X, X, SNC1, SNC0, CRC, SNA1, SNA0, CRC]
>> + * The resulting serial number is following :
>> + *	[ SNA1, SNA0, SNB3, SNB2, SNB1, SNB0, SNC1, SNC0]
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_read_serial(struct i2c_client *client, u64 *sn)
>> +{
>> +	u8 i;
>> +	u64 rcv_buf =3D 0;
>> +	u16 send_buf;
>> +	int ret;
>> +
>> +	struct i2c_msg msg[2] =3D {
>> +		{
>> +		 .addr =3D client->addr,
>> +		 .flags =3D client->flags,
>> +		 .len =3D 2,
>> +		 .buf =3D (__u8 *)&send_buf,
>> +		 },
>> +		{
>> +		 .addr =3D client->addr,
>> +		 .flags =3D client->flags | I2C_M_RD,
>> +		 .buf =3D (__u8 *)&rcv_buf,
>> +		 },
>> +	};
>> +
>> +	/* Read MSB part of serial number */
>> +	send_buf =3D cpu_to_be16(MS_SENSORS_SERIAL_READ_MSB);
>> +	msg[1].len =3D 8;
>> +	ret =3D i2c_transfer(client->adapter, msg, 2);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Unable to read device serial =
number");
>> +		return ret;
>> +	}
>> +
>> +	rcv_buf =3D be64_to_cpu(rcv_buf);
>> +	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
>> +
>> +	for (i =3D 0; i < 64; i +=3D 16) {
>> +		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFF))
>> +			return -ENODEV;
>> +	}
>> +
>> +	*sn =3D (((rcv_buf >> 32) & 0xFF000000) |
>> +	       ((rcv_buf >> 24) & 0x00FF0000) |
>> +	       ((rcv_buf >> 16) & 0x0000FF00) |
>> +	       ((rcv_buf >> 8) & 0x000000FF)) << 16;
>> +
>> +	/* Read LSB part of serial number */
>> +	send_buf =3D cpu_to_be16(MS_SENSORS_SERIAL_READ_LSB);
>> +	msg[1].len =3D 6;
>> +	rcv_buf =3D 0;
>> +	ret =3D i2c_transfer(client->adapter, msg, 2);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Unable to read device serial =
number");
>> +		return ret;
>> +	}
>> +
>> +	rcv_buf =3D be64_to_cpu(rcv_buf) >> 16;
>> +	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
>> +
>> +	for (i =3D 0; i < 48; i +=3D 24) {
>> +		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFFFF))
>> +			return -ENODEV;
>> +	}
>> +
>> +	*sn |=3D (rcv_buf & 0xFFFF00) << 40 | (rcv_buf >> 32);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_read_serial);
>> +
>> +static int ms_sensors_read_config_reg(struct i2c_client *client,
>> +				      u8 *config_reg)
>> +{
>> +	int ret;
>> +
>> +	ret =3D i2c_smbus_write_byte(client, =
MS_SENSORS_CONFIG_REG_READ);
>> +	if (ret) {
>> +		dev_err(&client->dev, "Unable to read config register");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D i2c_master_recv(client, config_reg, 1);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Unable to read config register");
>> +		return ret;
>> +	}
>> +	dev_dbg(&client->dev, "Config register :%x\n", *config_reg);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ms_sensors_write_resolution() - Set resolution function
>> + * @dev_data:	pointer to temperature/humidity device data
>> + * @i:		resolution index to set
>> + *
>> + * This function will program the appropriate resolution based on =
the index
>> + * provided when user space will set samp_freq channel.
>> + * This function is used for TSYS02D, HTU21 and MS8607 chipsets.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +ssize_t ms_sensors_write_resolution(struct ms_ht_dev *dev_data,
>> +				    u8 i)
>> +{
>> +	u8 config_reg;
>> +	int ret;
>> +
>> +	ret =3D ms_sensors_read_config_reg(dev_data->client, =
&config_reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	config_reg &=3D 0x7E;
>> +	config_reg |=3D ((i & 1) << 7) + ((i & 2) >> 1);
>> +
>> +	return i2c_smbus_write_byte_data(dev_data->client,
>> +					 MS_SENSORS_CONFIG_REG_WRITE,
>> +					 config_reg);
>> +}
>> +EXPORT_SYMBOL(ms_sensors_write_resolution);
>> +
>> +/**
>> + * ms_sensors_show_battery_low() - Show device battery low indicator
>> + * @dev_data:	pointer to temperature/humidity device data
>> + * @buf:	pointer to char buffer to write result
>> + *
>> + * This function will read battery indicator value in the device and
>> + * return 1 if the device voltage is below 2.25V.
>> + * This function is used for TSYS02D, HTU21 and MS8607 chipsets.
>> + *
>> + * Return: length of sprintf on success, negative errno otherwise.
>> + */
>> +ssize_t ms_sensors_show_battery_low(struct ms_ht_dev *dev_data,
>> +				    char *buf)
>> +{
>> +	int ret;
>> +	u8 config_reg;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	ret =3D ms_sensors_read_config_reg(dev_data->client, =
&config_reg);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sprintf(buf, "%d\n", (config_reg & 0x40) >> 6);
>> +}
>> +EXPORT_SYMBOL(ms_sensors_show_battery_low);
>> +
>> +/**
>> + * ms_sensors_show_heater() - Show device heater
>> + * @dev_data:	pointer to temperature/humidity device data
>> + * @buf:	pointer to char buffer to write result
>> + *
>> + * This function will read heater enable value in the device and
>> + * return 1 if the heater is enabled.
>> + * This function is used for HTU21 and MS8607 chipsets.
>> + *
>> + * Return: length of sprintf on success, negative errno otherwise.
>> + */
>> +ssize_t ms_sensors_show_heater(struct ms_ht_dev *dev_data,
>> +			       char *buf)
>> +{
>> +	u8 config_reg;
>> +	int ret;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	ret =3D ms_sensors_read_config_reg(dev_data->client, =
&config_reg);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sprintf(buf, "%d\n", (config_reg & 0x4) >> 2);
>> +}
>> +EXPORT_SYMBOL(ms_sensors_show_heater);
>> +
>> +/**
>> + * ms_sensors_write_heater() - Write device heater
>> + * @dev_data:	pointer to temperature/humidity device data
>> + * @buf:	pointer to char buffer from user space
>> + * @len:	length of buf
>> + *
>> + * This function will write 1 or 0 value in the device
>> + * to enable or disable heater.
>> + * This function is used for HTU21 and MS8607 chipsets.
>> + *
>> + * Return: length of buffer, negative errno otherwise.
>> + */
>> +ssize_t ms_sensors_write_heater(struct ms_ht_dev *dev_data,
>> +				const char *buf, size_t len)
>> +{
>> +	u8 val, config_reg;
>> +	int ret;
>> +
>> +	ret =3D kstrtou8(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val > 1)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	ret =3D ms_sensors_read_config_reg(dev_data->client, =
&config_reg);
>> +	if (ret) {
>> +		mutex_unlock(&dev_data->lock);
>> +		return ret;
>> +	}
>> +
>> +	config_reg &=3D 0xFB;
>> +	config_reg |=3D val << 2;
>> +
>> +	ret =3D i2c_smbus_write_byte_data(dev_data->client,
>> +					MS_SENSORS_CONFIG_REG_WRITE,
>> +					config_reg);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret) {
>> +		dev_err(&dev_data->client->dev, "Unable to write config =
register\n");
>> +		return ret;
>> +	}
>> +
>> +	return len;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_write_heater);
>> +
>> +/**
>> + * ms_sensors_ht_read_temperature() - Read temperature
>> + * @dev_data:	pointer to temperature/humidity device data
>> + * @temperature:pointer to temperature destination value
>> + *
>> + * This function will get temperature ADC value from the device,
>> + * check the CRC and compute the temperature value.
>> + * This function is used for TSYS02D, HTU21 and MS8607 chipsets.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_ht_read_temperature(struct ms_ht_dev *dev_data,
>> +				   s32 *temperature)
>> +{
>> +	int ret;
>> +	u32 adc;
>> +	u16 delay;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	delay =3D ms_sensors_ht_t_conversion_time[dev_data->res_index];
>> +	ret =3D ms_sensors_convert_and_read(dev_data->client,
>> +					  =
MS_SENSORS_HT_T_CONVERSION_START,
>> +					  MS_SENSORS_NO_READ_CMD,
>> +					  delay, &adc);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!ms_sensors_crc_valid(adc)) {
>> +		dev_err(&dev_data->client->dev,
>> +			"Temperature read crc check error\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Temperature algorithm */
>> +	*temperature =3D (((s64)(adc >> 8) * 175720) >> 16) - 46850;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_ht_read_temperature);
>> +
>> +/**
>> + * ms_sensors_ht_read_humidity() - Read humidity
>> + * @dev_data:	pointer to temperature/humidity device data
>> + * @humidity:	pointer to humidity destination value
>> + *
>> + * This function will get humidity ADC value from the device,
>> + * check the CRC and compute the temperature value.
>> + * This function is used for HTU21 and MS8607 chipsets.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_ht_read_humidity(struct ms_ht_dev *dev_data,
>> +				u32 *humidity)
>> +{
>> +	int ret;
>> +	u32 adc;
>> +	u16 delay;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	delay =3D ms_sensors_ht_h_conversion_time[dev_data->res_index];
>> +	ret =3D ms_sensors_convert_and_read(dev_data->client,
>> +					  =
MS_SENSORS_HT_H_CONVERSION_START,
>> +					  MS_SENSORS_NO_READ_CMD,
>> +					  delay, &adc);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!ms_sensors_crc_valid(adc)) {
>> +		dev_err(&dev_data->client->dev,
>> +			"Humidity read crc check error\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Humidity algorithm */
>> +	*humidity =3D (((s32)(adc >> 8) * 12500) >> 16) * 10 - 6000;
>> +	if (*humidity >=3D 100000)
>> +		*humidity =3D 100000;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_ht_read_humidity);
>> +
>> +/**
>> + * ms_sensors_tp_crc_valid() - CRC check function for
>> + *     Temperature and pressure devices.
>> + *     This function is only used when reading PROM coefficients
>> + *
>> + * @prom:	pointer to PROM coefficients array
>> + * @len:	length of PROM coefficients array
>> + *
>> + * Return: True if CRC is ok.
>> + */
>> +static bool ms_sensors_tp_crc_valid(u16 *prom, u8 len)
>> +{
>> +	unsigned int cnt, n_bit;
>> +	u16 n_rem =3D 0x0000, crc_read =3D prom[0], crc =3D (*prom & =
0xF000) >> 12;
>> +
>> +	prom[len - 1] =3D 0;
>> +	prom[0] &=3D 0x0FFF;      /* Clear the CRC computation part */
>> +
>> +	for (cnt =3D 0; cnt < len * 2; cnt++) {
>> +		if (cnt % 2 =3D=3D 1)
>> +			n_rem ^=3D prom[cnt >> 1] & 0x00FF;
>> +		else
>> +			n_rem ^=3D prom[cnt >> 1] >> 8;
>> +
>> +		for (n_bit =3D 8; n_bit > 0; n_bit--) {
>> +			if (n_rem & 0x8000)
>> +				n_rem =3D (n_rem << 1) ^ 0x3000;
>> +			else
>> +				n_rem <<=3D 1;
>> +		}
>> +	}
>> +	n_rem >>=3D 12;
>> +	prom[0] =3D crc_read;
>> +
>> +	return n_rem =3D=3D crc;
>> +}
>> +
>> +/**
>> + * ms_sensors_tp_read_prom() - prom coeff read function
>> + * @dev_data:	pointer to temperature/pressure device data
>> + *
>> + * This function will read prom coefficients and check CRC.
>> + * This function is used for MS5637 and MS8607 chipsets.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
>> +{
>> +	int i, ret;
>> +
>> +	for (i =3D 0; i < MS_SENSORS_TP_PROM_WORDS_NB; i++) {
>> +		ret =3D ms_sensors_read_prom_word(
>> +			dev_data->client,
>> +			MS_SENSORS_TP_PROM_READ + (i << 1),
>> +			&dev_data->prom[i]);
>> +
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (!ms_sensors_tp_crc_valid(dev_data->prom,
>> +				     MS_SENSORS_TP_PROM_WORDS_NB + 1)) {
>> +		dev_err(&dev_data->client->dev,
>> +			"Calibration coefficients crc check error\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_tp_read_prom);
>> +
>> +/**
>> + * ms_sensors_read_temp_and_pressure() - read temp and pressure
>> + * @dev_data:	pointer to temperature/pressure device data
>> + * @temperature:pointer to temperature destination value
>> + * @pressure:	pointer to pressure destination value
>> + *
>> + * This function will read ADC and compute pressure and temperature =
value.
>> + * This function is used for MS5637 and MS8607 chipsets.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
>> +				      int *temperature,
>> +				      unsigned int *pressure)
>> +{
>> +	int ret;
>> +	u32 t_adc, p_adc;
>> +	s32 dt, temp;
>> +	s64 off, sens, t2, off2, sens2;
>> +	u16 *prom =3D dev_data->prom, delay;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	delay =3D ms_sensors_tp_conversion_time[dev_data->res_index];
>> +
>> +	ret =3D ms_sensors_convert_and_read(
>> +					dev_data->client,
>> +					MS_SENSORS_TP_T_CONVERSION_START =
+
>> +						dev_data->res_index * 2,
>> +					MS_SENSORS_TP_ADC_READ,
>> +					delay, &t_adc);
>> +	if (ret) {
>> +		mutex_unlock(&dev_data->lock);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D ms_sensors_convert_and_read(
>> +					dev_data->client,
>> +					MS_SENSORS_TP_P_CONVERSION_START =
+
>> +						dev_data->res_index * 2,
>> +					MS_SENSORS_TP_ADC_READ,
>> +					delay, &p_adc);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dt =3D (s32)t_adc - (prom[5] << 8);
>> +
>> +	/* Actual temperature =3D 2000 + dT * TEMPSENS */
>> +	temp =3D 2000 + (((s64)dt * prom[6]) >> 23);
>> +
>> +	/* Second order temperature compensation */
>> +	if (temp < 2000) {
>> +		s64 tmp =3D (s64)temp - 2000;
>> +
>> +		t2 =3D (3 * ((s64)dt * (s64)dt)) >> 33;
>> +		off2 =3D (61 * tmp * tmp) >> 4;
>> +		sens2 =3D (29 * tmp * tmp) >> 4;
>> +
>> +		if (temp < -1500) {
>> +			s64 tmp =3D (s64)temp + 1500;
>> +
>> +			off2 +=3D 17 * tmp * tmp;
>> +			sens2 +=3D 9 * tmp * tmp;
>> +		}
>> +	} else {
>> +		t2 =3D (5 * ((s64)dt * (s64)dt)) >> 38;
>> +		off2 =3D 0;
>> +		sens2 =3D 0;
>> +	}
>> +
>> +	/* OFF =3D OFF_T1 + TCO * dT */
>> +	off =3D (((s64)prom[2]) << 17) + ((((s64)prom[4]) * (s64)dt) >> =
6);
>> +	off -=3D off2;
>> +
>> +	/* Sensitivity at actual temperature =3D SENS_T1 + TCS * dT */
>> +	sens =3D (((s64)prom[1]) << 16) + (((s64)prom[3] * dt) >> 7);
>> +	sens -=3D sens2;
>> +
>> +	/* Temperature compensated pressure =3D D1 * SENS - OFF */
>> +	*temperature =3D (temp - t2) * 10;
>> +	*pressure =3D (u32)(((((s64)p_adc * sens) >> 21) - off) >> 15);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_read_temp_and_pressure);
>> +
>> +MODULE_DESCRIPTION("Measurement-Specialties common i2c driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>> +MODULE_LICENSE("GPL v2");
>> +
>> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>> new file mode 100644
>> index 0000000..7b614ad
>> --- /dev/null
>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>> @@ -0,0 +1,66 @@
>> +/*
>> + * Measurements Specialties common sensor driver
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * This program is free software; you can redistribute it and/or =
modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef _MS_SENSORS_I2C_H
>> +#define _MS_SENSORS_I2C_H
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/mutex.h>
>> +
>> +#define MS_SENSORS_TP_PROM_WORDS_NB		7
>> +
>> +/**
>> + * struct ms_ht_dev - Humidity/Temperature sensor device structure
>> + * @client:	i2c client
>> + * @lock:	lock protecting the i2c conversion
>> + * @res_index:	index to selected sensor resolution
>> + */
>> +struct ms_ht_dev {
>> +	struct i2c_client *client;
>> +	struct mutex lock;
>> +	u8 res_index;
>> +};
>> +
>> +/**
>> + * struct ms_tp_dev - Temperature/Pressure sensor device structure
>> + * @client:	i2c client
>> + * @lock:	lock protecting the i2c conversion
>> + * @prom:	array of PROM coefficients used for conversion. Added =
element
>> + *              for CRC computation
>> + * @res_index:	index to selected sensor resolution
>> + */
>> +struct ms_tp_dev {
>> +	struct i2c_client *client;
>> +	struct mutex lock;
>> +	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];
>> +	u8 res_index;
>> +};
>> +
>> +int ms_sensors_reset(void *cli, u8 cmd, unsigned int delay);
>> +int ms_sensors_read_prom_word(void *cli, int cmd, u16 *word);
>> +int ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,
>> +				unsigned int delay, u32 *adc);
>> +int ms_sensors_read_serial(struct i2c_client *client, u64 *sn);
>> +ssize_t ms_sensors_show_serial(struct ms_ht_dev *dev_data, char =
*buf);
>> +ssize_t ms_sensors_write_resolution(struct ms_ht_dev *dev_data, u8 =
i);
>> +ssize_t ms_sensors_show_battery_low(struct ms_ht_dev *dev_data, char =
*buf);
>> +ssize_t ms_sensors_show_heater(struct ms_ht_dev *dev_data, char =
*buf);
>> +ssize_t ms_sensors_write_heater(struct ms_ht_dev *dev_data,
>> +				const char *buf, size_t len);
>> +int ms_sensors_ht_read_temperature(struct ms_ht_dev *dev_data,
>> +				   s32 *temperature);
>> +int ms_sensors_ht_read_humidity(struct ms_ht_dev *dev_data,
>> +				u32 *humidity);
>> +int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data);
>> +int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
>> +				      int *temperature,
>> +				      unsigned int *pressure);
>> +
>> +#endif /* _MS_SENSORS_I2C_H */
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_5CBE2663-6BF5-4721-8F1C-4DA47F554D49
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Thank =
you for the help in setting these drivers in =
order.<div><br></div><div>Regards,</div><div>Ludovic<br><div =
apple-content-edited=3D"true"><br></div>
<br><div><div>Le 4 oct. 2015 =E0 16:04, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>&gt; a =E9crit =
:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On 01/10/15 15:13, Ludovic =
Tancerel wrote:<br><blockquote type=3D"cite">Measurement specialties =
drivers common part.<br>These functions are used by further =
drivers<br>in the patchset: TSYS01, TSYS02D, HTU21, MS5637, =
MS8607<br><br>Signed-off-by: Ludovic Tancerel &lt;<a =
href=3D"mailto:ludovic.tancerel@maplehightech.com">ludovic.tancerel@mapleh=
ightech.com</a>&gt;<br></blockquote>Thanks for your persistence on =
this!<br><br>Anyhow, applied to the togreg branch of iio.git. Initially =
pushed out<br>as testing for the autobuilders to play with =
it.<br><br>Thanks,<br><br>Jonathan<br><blockquote =
type=3D"cite">---<br>drivers/iio/common/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>drivers/iio/common/Makefile =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>drivers/iio/common/ms_sensors/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;6 =
+<br>drivers/iio/common/ms_sensors/Makefile =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;5 =
+<br>drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 651 =
+++++++++++++++++++++++++<br>drivers/iio/common/ms_sensors/ms_sensors_i2c.=
h | &nbsp;66 +++<br>6 files changed, 730 insertions(+)<br>create mode =
100644 drivers/iio/common/ms_sensors/Kconfig<br>create mode 100644 =
drivers/iio/common/ms_sensors/Makefile<br>create mode 100644 =
drivers/iio/common/ms_sensors/ms_sensors_i2c.c<br>create mode 100644 =
drivers/iio/common/ms_sensors/ms_sensors_i2c.h<br><br>diff --git =
a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig<br>index =
790f106..26a6026 100644<br>--- a/drivers/iio/common/Kconfig<br>+++ =
b/drivers/iio/common/Kconfig<br>@@ -3,5 +3,6 @@<br>#<br><br>source =
"drivers/iio/common/hid-sensors/Kconfig"<br>+source =
"drivers/iio/common/ms_sensors/Kconfig"<br>source =
"drivers/iio/common/ssp_sensors/Kconfig"<br>source =
"drivers/iio/common/st_sensors/Kconfig"<br>diff --git =
a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile<br>index =
b1e4d9c..585da6a 100644<br>--- a/drivers/iio/common/Makefile<br>+++ =
b/drivers/iio/common/Makefile<br>@@ -8,5 +8,6 @@<br><br># When adding =
new entries keep the list in alphabetical order<br>obj-y +=3D =
hid-sensors/<br>+obj-y +=3D ms_sensors/<br>obj-y +=3D =
ssp_sensors/<br>obj-y +=3D st_sensors/<br>diff --git =
a/drivers/iio/common/ms_sensors/Kconfig =
b/drivers/iio/common/ms_sensors/Kconfig<br>new file mode 100644<br>index =
0000000..b28a92b<br>--- /dev/null<br>+++ =
b/drivers/iio/common/ms_sensors/Kconfig<br>@@ -0,0 +1,6 @@<br>+#<br>+# =
Measurements Specialties sensors common library<br>+#<br>+<br>+config =
IIO_MS_SENSORS_I2C<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tristate<br>diff --git =
a/drivers/iio/common/ms_sensors/Makefile =
b/drivers/iio/common/ms_sensors/Makefile<br>new file mode =
100644<br>index 0000000..7846428<br>--- /dev/null<br>+++ =
b/drivers/iio/common/ms_sensors/Makefile<br>@@ -0,0 +1,5 @@<br>+#<br>+# =
Makefile for the Measurement Specialties sensor common =
modules.<br>+#<br>+<br>+obj-$(CONFIG_IIO_MS_SENSORS_I2C) +=3D =
ms_sensors_i2c.o<br>diff --git =
a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c<br>new file mode =
100644<br>index 0000000..056c4f3<br>--- /dev/null<br>+++ =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c<br>@@ -0,0 +1,651 =
@@<br>+/*<br>+ * Measurements Specialties driver common i2c =
functions<br>+ *<br>+ * Copyright (c) 2015 Measurement-Specialties<br>+ =
*<br>+ * Licensed under the GPL-2.<br>+ */<br>+<br>+#include =
&lt;linux/module.h&gt;<br>+#include &lt;linux/iio/iio.h&gt;<br>+#include =
&lt;linux/device.h&gt;<br>+#include =
&lt;linux/delay.h&gt;<br>+<br>+#include "ms_sensors_i2c.h"<br>+<br>+/* =
Conversion times in us */<br>+static const u16 =
ms_sensors_ht_t_conversion_time[] =3D { 50000, 25000,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;13000, 7000 };<br>+static const u16 =
ms_sensors_ht_h_conversion_time[] =3D { 16000, 3000,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;5000, 8000 };<br>+static const u16 =
ms_sensors_tp_conversion_time[] =3D { 500, 1100, 2100,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;4100,=
 8220, 16440 };<br>+<br>+#define MS_SENSORS_SERIAL_READ_MSB<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xFA0F<br>+#define MS_SENSORS_SERIAL_READ_LSB<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xFCC9<br>+#define MS_SENSORS_CONFIG_REG_WRITE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xE6<br>+#define MS_SENSORS_CONFIG_REG_READ<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xE7<br>+#define MS_SENSORS_HT_T_CONVERSION_START<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xF3<br>+#define MS_SENSORS_HT_H_CONVERSION_START<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xF5<br>+<br>+#define MS_SENSORS_TP_PROM_READ<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xA0<br>+#define MS_SENSORS_TP_T_CONVERSION_START<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x50<br>+#define MS_SENSORS_TP_P_CONVERSION_START<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x40<br>+#define MS_SENSORS_TP_ADC_READ<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00<br>+<br>+#define MS_SENSORS_NO_READ_CMD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xFF<br>+<br>+/**<br>+ * ms_sensors_reset() - Reset function<br>+ =
* @cli:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to device client<br>+ * @cmd:<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>reset cmd. Depends on device in =
use<br>+ * @delay:<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>usleep minimal delay after reset command is issued<br>+ =
*<br>+ * Generic I2C reset function for Measurement Specialties =
devices.<br>+ *<br>+ * Return: 0 on success, negative errno =
otherwise.<br>+ */<br>+int ms_sensors_reset(void *cli, u8 cmd, unsigned =
int delay)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct i2c_client *client =3D =
cli;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D i2c_smbus_write_byte(client, cmd);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_err(&amp;client-&gt;dev, "Failed to reset =
device\n");<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>usleep_range(delay, delay + 1000);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
0;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_reset);<br>+<br>+/**<br>+ * =
ms_sensors_read_prom_word() - PROM word read function<br>+ * @cli:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to device client<br>+ * @cmd:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>PROM read cmd. Depends on device =
and prom id<br>+ * @word:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pointer to word destination =
value<br>+ *<br>+ * Generic i2c prom word read function for Measurement =
Specialties devices.<br>+ *<br>+ * Return: 0 on success, negative errno =
otherwise.<br>+ */<br>+int ms_sensors_read_prom_word(void *cli, int cmd, =
u16 *word)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct i2c_client *client =3D =
(struct i2c_client *)cli;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
i2c_smbus_read_word_swapped(client, cmd);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>dev_err(&amp;client-&gt;dev, "Failed to read prom =
word\n");<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>*word =3D =
ret;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return =
0;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_read_prom_word);<br>+<br>+/**<br>+ =
* ms_sensors_convert_and_read() - ADC conversion &amp; read =
function<br>+ * @cli:<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>pointer to device client<br>+ * @conv:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ADC =
conversion command. Depends on device in use<br>+ * @rd:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ADC read =
command. Depends on device in use<br>+ * @delay:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>usleep =
minimal delay after conversion command is issued<br>+ * @adc:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to ADC destination value<br>+ *<br>+ * Generic ADC conversion &amp; read =
function for Measurement Specialties<br>+ * devices.<br>+ * The function =
will issue conversion command, sleep appopriate delay, and<br>+ * issue =
command to read ADC.<br>+ *<br>+ * Return: 0 on success, negative errno =
otherwise.<br>+ */<br>+int ms_sensors_convert_and_read(void *cli, u8 =
conv, u8 rd,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>unsigned int delay, u32 *adc)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>u32 buf =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct i2c_client *client =3D =
(struct i2c_client *)cli;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>/* Trigger conversion =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ret =3D i2c_smbus_write_byte(client, conv);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>goto err;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>usleep_range(delay, delay + 1000);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* =
Retrieve ADC value */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (rd !=3D =
MS_SENSORS_NO_READ_CMD)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
i2c_smbus_read_i2c_block_data(client, rd, 3, (u8 *)&amp;buf);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>else<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D i2c_master_recv(client, (u8 *)&amp;buf, =
3);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (ret &lt; 0)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto err;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_dbg(&amp;client-&gt;dev, "ADC raw value : %x\n", =
be32_to_cpu(buf) &gt;&gt; 8);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>*adc =3D be32_to_cpu(buf) =
&gt;&gt; 8;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return 0;<br>+err:<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_err(&amp;client-&gt;dev, =
"Unable to make sensor adc conversion\n");<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_convert_and_read);<br>+<br>+/**<br=
>+ * ms_sensors_crc_valid() - CRC check function<br>+ * @value:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>input and =
CRC compare value<br>+ *<br>+ * Cyclic Redundancy Check function used in =
TSYS02D, HTU21, MS8607.<br>+ * This function performs a x^8 + x^5 + x^4 =
+ 1 polynomial CRC.<br>+ * The argument contains CRC value in LSB byte =
while the bytes 1 and 2<br>+ * are used for CRC computation.<br>+ *<br>+ =
* Return: 1 if CRC is valid, 0 otherwise.<br>+ */<br>+static bool =
ms_sensors_crc_valid(u32 value)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u32 polynom =3D 0x988000;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* x^8 + =
x^5 + x^4 + 1 */<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>u32 msb =3D 0x800000;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u32 mask =3D 0xFF8000;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u32 =
result =3D value &amp; 0xFFFF00;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u8 crc =3D value &amp; =
0xFF;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>while (msb !=3D 0x80) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (result &amp; msb)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>result =3D =
((result ^ polynom) &amp; mask)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>| (result &amp; ~mask);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>msb =
&gt;&gt;=3D 1;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mask &gt;&gt;=3D 1;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>polynom &gt;&gt;=3D 1;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return result =3D=3D crc;<br>+}<br>+<br>+/**<br>+ * =
ms_sensors_read_serial() - Serial number read function<br>+ * @cli:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to i2c client<br>+ * @sn:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pointer to 64-bits destination =
value<br>+ *<br>+ * Generic i2c serial number read function for =
Measurement Specialties devices.<br>+ * This function is used for =
TSYS02d, HTU21, MS8607 chipset.<br>+ * Refer to datasheet:<br>+ *<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><a =
href=3D"http://www.meas-spec.com/downloads/HTU2X_Serial_Number_Reading.pdf=
">http://www.meas-spec.com/downloads/HTU2X_Serial_Number_Reading.pdf</a><b=
r>+ *<br>+ * Sensor raw MSB serial number format is the following :<br>+ =
*<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>[ =
SNB3, CRC, SNB2, CRC, SNB1, CRC, SNB0, CRC]<br>+ * Sensor raw LSB serial =
number format is the following :<br>+ *<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>[ X, X, SNC1, SNC0, CRC, SNA1, =
SNA0, CRC]<br>+ * The resulting serial number is following :<br>+ *<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>[ SNA1, =
SNA0, SNB3, SNB2, SNB1, SNB0, SNC1, SNC0]<br>+ *<br>+ * Return: 0 on =
success, negative errno otherwise.<br>+ */<br>+int =
ms_sensors_read_serial(struct i2c_client *client, u64 =
*sn)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>u8 i;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u64 rcv_buf =3D 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u16 =
send_buf;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct i2c_msg msg[2] =3D =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-converted-space">&nbsp;</span>.addr =3D =
client-&gt;addr,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-converted-space">&nbsp;</span>.flags =
=3D client-&gt;flags,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>.len =3D 2,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>.buf =3D (__u8 =
*)&amp;send_buf,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>},<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-converted-space">&nbsp;</span>.addr =3D =
client-&gt;addr,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-converted-space">&nbsp;</span>.flags =
=3D client-&gt;flags | I2C_M_RD,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>.buf =3D (__u8 =
*)&amp;rcv_buf,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>},<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>};<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Read MSB part of serial number */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>send_buf =
=3D cpu_to_be16(MS_SENSORS_SERIAL_READ_MSB);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>msg[1].len =3D 8;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
i2c_transfer(client-&gt;adapter, msg, 2);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>dev_err(&amp;client-&gt;dev, "Unable to read device =
serial number");<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>rcv_buf =3D=
 be64_to_cpu(rcv_buf);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_dbg(&amp;client-&gt;dev, =
"Serial MSB raw : %llx\n", rcv_buf);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>for (i =3D =
0; i &lt; 64; i +=3D 16) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if =
(!ms_sensors_crc_valid((rcv_buf &gt;&gt; i) &amp; 0xFFFF))<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-ENODEV;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>*sn =3D (((rcv_buf &gt;&gt; 32) &amp; 0xFF000000) =
|<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;((rcv_buf &gt;&gt; 24) &amp; 0x00FF0000) |<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;((rcv_buf &gt;&gt; 16) &amp; 0x0000FF00) |<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;((rcv_buf &gt;&gt; 8) &amp; 0x000000FF)) &lt;&lt; =
16;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>/* Read LSB part of serial number */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>send_buf =
=3D cpu_to_be16(MS_SENSORS_SERIAL_READ_LSB);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>msg[1].len =3D 6;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>rcv_buf =3D 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
i2c_transfer(client-&gt;adapter, msg, 2);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>dev_err(&amp;client-&gt;dev, "Unable to read device =
serial number");<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>rcv_buf =3D=
 be64_to_cpu(rcv_buf) &gt;&gt; 16;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_dbg(&amp;client-&gt;dev, =
"Serial MSB raw : %llx\n", rcv_buf);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>for (i =3D =
0; i &lt; 48; i +=3D 24) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if =
(!ms_sensors_crc_valid((rcv_buf &gt;&gt; i) &amp; 0xFFFFFF))<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-ENODEV;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>*sn |=3D (rcv_buf &amp; 0xFFFF00) &lt;&lt; 40 | (rcv_buf =
&gt;&gt; 32);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return =
0;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_read_serial);<br>+<br>+static int =
ms_sensors_read_config_reg(struct i2c_client *client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;u8 *config_reg)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
i2c_smbus_write_byte(client, MS_SENSORS_CONFIG_REG_READ);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_err(&amp;client-&gt;dev, "Unable to read config =
register");<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
i2c_master_recv(client, config_reg, 1);<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>if (ret &lt; 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_err(&amp;client-&gt;dev, "Unable to read config =
register");<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_dbg(&amp;client-&gt;dev, "Config register :%x\n", =
*config_reg);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return 0;<br>+}<br>+<br>+/**<br>+ =
* ms_sensors_write_resolution() - Set resolution function<br>+ * =
@dev_data:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to temperature/humidity device data<br>+ * @i:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>resolution index to set<br>+ *<br>+ * This function will program =
the appropriate resolution based on the index<br>+ * provided when user =
space will set samp_freq channel.<br>+ * This function is used for =
TSYS02D, HTU21 and MS8607 chipsets.<br>+ *<br>+ * Return: 0 on success, =
negative errno otherwise.<br>+ */<br>+ssize_t =
ms_sensors_write_resolution(struct ms_ht_dev *dev_data,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;u8 =
i)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>u8 config_reg;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms_sensors_read_config_reg(dev_data-&gt;client, =
&amp;config_reg);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>if (ret)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return ret;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>config_reg &amp;=3D 0x7E;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>config_reg |=3D ((i &amp; 1) =
&lt;&lt; 7) + ((i &amp; 2) &gt;&gt; 1);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
i2c_smbus_write_byte_data(dev_data-&gt;client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>MS_SENSORS_CONFIG_REG_WRITE,<=
br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>config_reg);<br>+}<br>+EXPORT=
_SYMBOL(ms_sensors_write_resolution);<br>+<br>+/**<br>+ * =
ms_sensors_show_battery_low() - Show device battery low indicator<br>+ * =
@dev_data:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to temperature/humidity device data<br>+ * @buf:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to char buffer to write result<br>+ *<br>+ * This function will read =
battery indicator value in the device and<br>+ * return 1 if the device =
voltage is below 2.25V.<br>+ * This function is used for TSYS02D, HTU21 =
and MS8607 chipsets.<br>+ *<br>+ * Return: length of sprintf on success, =
negative errno otherwise.<br>+ */<br>+ssize_t =
ms_sensors_show_battery_low(struct ms_ht_dev *dev_data,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;char =
*buf)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u8 config_reg;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms_sensors_read_config_reg(dev_data-&gt;client, =
&amp;config_reg);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return sprintf(buf, "%d\n", =
(config_reg &amp; 0x40) &gt;&gt; =
6);<br>+}<br>+EXPORT_SYMBOL(ms_sensors_show_battery_low);<br>+<br>+/**<br>=
+ * ms_sensors_show_heater() - Show device heater<br>+ * @dev_data:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to temperature/humidity device data<br>+ * @buf:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to char buffer to write result<br>+ *<br>+ * This function will read =
heater enable value in the device and<br>+ * return 1 if the heater is =
enabled.<br>+ * This function is used for HTU21 and MS8607 =
chipsets.<br>+ *<br>+ * Return: length of sprintf on success, negative =
errno otherwise.<br>+ */<br>+ssize_t ms_sensors_show_heater(struct =
ms_ht_dev *dev_data,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;char *buf)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u8 config_reg;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int =
ret;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mutex_lock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms_sensors_read_config_reg(dev_data-&gt;client, =
&amp;config_reg);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return sprintf(buf, "%d\n", =
(config_reg &amp; 0x4) &gt;&gt; =
2);<br>+}<br>+EXPORT_SYMBOL(ms_sensors_show_heater);<br>+<br>+/**<br>+ * =
ms_sensors_write_heater() - Write device heater<br>+ * @dev_data:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to temperature/humidity device data<br>+ * @buf:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to char buffer from user space<br>+ * @len:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>length of buf<br>+ *<br>+ * This =
function will write 1 or 0 value in the device<br>+ * to enable or =
disable heater.<br>+ * This function is used for HTU21 and MS8607 =
chipsets.<br>+ *<br>+ * Return: length of buffer, negative errno =
otherwise.<br>+ */<br>+ssize_t ms_sensors_write_heater(struct ms_ht_dev =
*dev_data,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>const char *buf, size_t len)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u8 val, =
config_reg;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D kstrtou8(buf, 10, =
&amp;val);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (ret)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return ret;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (val =
&gt; 1)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return -EINVAL;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms_sensors_read_config_reg(dev_data-&gt;client, =
&amp;config_reg);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>if (ret) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>config_reg &amp;=3D 0xFB;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>config_reg |=3D val &lt;&lt; 2;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
i2c_smbus_write_byte_data(dev_data-&gt;client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MS_SENSORS_CONFIG_REG_WRITE,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>config_reg);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_err(&amp;dev_data-&gt;client-&gt;dev, "Unable to write config =
register\n");<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
len;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_write_heater);<br>+<br>+/**<br>+ =
* ms_sensors_ht_read_temperature() - Read temperature<br>+ * =
@dev_data:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to temperature/humidity device data<br>+ * =
@temperature:pointer to temperature destination value<br>+ *<br>+ * This =
function will get temperature ADC value from the device,<br>+ * check =
the CRC and compute the temperature value.<br>+ * This function is used =
for TSYS02D, HTU21 and MS8607 chipsets.<br>+ *<br>+ * Return: 0 on =
success, negative errno otherwise.<br>+ */<br>+int =
ms_sensors_ht_read_temperature(struct ms_ht_dev *dev_data,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;s32 =
*temperature)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u32 =
adc;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>u16 delay;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>delay =3D =
ms_sensors_ht_t_conversion_time[dev_data-&gt;res_index];<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms_sensors_convert_and_read(dev_data-&gt;client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;MS_SENSORS_HT_T_CONVERS=
ION_START,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;MS_SENSORS_NO_READ_CMD,=
<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-converted-space">&nbsp;</span>&nbsp;delay, =
&amp;adc);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (!ms_sensors_crc_valid(adc)) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_err(&amp;dev_data-&gt;client-&gt;dev,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>"Temperature read crc check error\n");<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-ENODEV;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Temperature algorithm */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>*temperature =3D (((s64)(adc &gt;&gt; 8) * 175720) &gt;&gt; 16) - =
46850;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return =
0;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_ht_read_temperature);<br>+<br>+/**<b=
r>+ * ms_sensors_ht_read_humidity() - Read humidity<br>+ * =
@dev_data:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to temperature/humidity device data<br>+ * =
@humidity:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to humidity destination value<br>+ *<br>+ * This function =
will get humidity ADC value from the device,<br>+ * check the CRC and =
compute the temperature value.<br>+ * This function is used for HTU21 =
and MS8607 chipsets.<br>+ *<br>+ * Return: 0 on success, negative errno =
otherwise.<br>+ */<br>+int ms_sensors_ht_read_humidity(struct ms_ht_dev =
*dev_data,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>u32 *humidity)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u32 =
adc;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>u16 delay;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>delay =3D =
ms_sensors_ht_h_conversion_time[dev_data-&gt;res_index];<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms_sensors_convert_and_read(dev_data-&gt;client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;MS_SENSORS_HT_H_CONVERS=
ION_START,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;MS_SENSORS_NO_READ_CMD,=
<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-converted-space">&nbsp;</span>&nbsp;delay, =
&amp;adc);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (!ms_sensors_crc_valid(adc)) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_err(&amp;dev_data-&gt;client-&gt;dev,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>"Humidity =
read crc check error\n");<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -ENODEV;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Humidity algorithm */<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>*humidity =3D (((s32)(adc =
&gt;&gt; 8) * 12500) &gt;&gt; 16) * 10 - 6000;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(*humidity &gt;=3D 100000)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>*humidity =3D =
100000;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return =
0;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_ht_read_humidity);<br>+<br>+/**<br>+=
 * ms_sensors_tp_crc_valid() - CRC check function for<br>+ * =
&nbsp;&nbsp;&nbsp;&nbsp;Temperature and pressure devices.<br>+ * =
&nbsp;&nbsp;&nbsp;&nbsp;This function is only used when reading PROM =
coefficients<br>+ *<br>+ * @prom:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pointer to PROM coefficients =
array<br>+ * @len:<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>length of PROM coefficients array<br>+ *<br>+ * Return: =
True if CRC is ok.<br>+ */<br>+static bool ms_sensors_tp_crc_valid(u16 =
*prom, u8 len)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>unsigned int cnt, =
n_bit;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>u16 n_rem =3D 0x0000, crc_read =3D prom[0], crc =3D (*prom &amp; =
0xF000) &gt;&gt; 12;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>prom[len - 1] =3D 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>prom[0] =
&amp;=3D 0x0FFF; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Clear the CRC =
computation part */<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>for (cnt =3D 0; cnt &lt; len * 2; =
cnt++) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (cnt % 2 =3D=3D 1)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>n_rem ^=3D prom[cnt &gt;&gt; 1] =
&amp; 0x00FF;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>else<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>n_rem ^=3D prom[cnt &gt;&gt; 1] =
&gt;&gt; 8;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>for (n_bit =3D 8; n_bit &gt; 0; n_bit--) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (n_rem =
&amp; 0x8000)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>n_rem =3D (n_rem &lt;&lt; 1) ^ 0x3000;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>else<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>n_rem &lt;&lt;=3D 1;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>n_rem &gt;&gt;=3D 12;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>prom[0] =3D =
crc_read;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return n_rem =3D=3D crc;<br>+}<br>+<br>+/**<br>+ * =
ms_sensors_tp_read_prom() - prom coeff read function<br>+ * =
@dev_data:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to temperature/pressure device data<br>+ *<br>+ * This =
function will read prom coefficients and check CRC.<br>+ * This function =
is used for MS5637 and MS8607 chipsets.<br>+ *<br>+ * Return: 0 on =
success, negative errno otherwise.<br>+ */<br>+int =
ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int i, =
ret;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>for (i =3D 0; i &lt; MS_SENSORS_TP_PROM_WORDS_NB; i++) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ret =3D ms_sensors_read_prom_word(<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;client,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>MS_SENSORS_TP_PROM_READ + (i =
&lt;&lt; 1),<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>&amp;dev_data-&gt;prom[i]);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(!ms_sensors_tp_crc_valid(dev_data-&gt;prom,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;MS_SE=
NSORS_TP_PROM_WORDS_NB + 1)) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>dev_err(&amp;dev_data-&gt;client-&gt;dev,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>"Calibration coefficients crc check error\n");<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-ENODEV;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return =
0;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_tp_read_prom);<br>+<br>+/**<br>+ * =
ms_sensors_read_temp_and_pressure() - read temp and pressure<br>+ * =
@dev_data:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to temperature/pressure device data<br>+ * =
@temperature:pointer to temperature destination value<br>+ * =
@pressure:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to pressure destination value<br>+ *<br>+ * This function =
will read ADC and compute pressure and temperature value.<br>+ * This =
function is used for MS5637 and MS8607 chipsets.<br>+ *<br>+ * Return: 0 =
on success, negative errno otherwise.<br>+ */<br>+int =
ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;int *temperature,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;unsigned int *pressure)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u32 =
t_adc, p_adc;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>s32 dt, temp;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>s64 off, sens, t2, off2, =
sens2;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>u16 *prom =3D dev_data-&gt;prom, delay;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>delay =3D =
ms_sensors_tp_conversion_time[dev_data-&gt;res_index];<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms_sensors_convert_and_read(<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_data-&gt;client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MS_SENSORS_TP_T_CONVERSION_START +<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;res_index * 2,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>MS_SENSORS_TP_ADC_READ,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>delay, =
&amp;t_adc);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (ret) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D ms_sensors_convert_and_read(<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;client,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>MS_SENSORS_TP_P_CONVERSION_START =
+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;res_index * 2,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>MS_SENSORS_TP_ADC_READ,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>delay, =
&amp;p_adc);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dt =3D (s32)t_adc - (prom[5] =
&lt;&lt; 8);<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>/* Actual temperature =3D 2000 + dT * TEMPSENS =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>temp =3D 2000 + (((s64)dt * prom[6]) &gt;&gt; 23);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* Second =
order temperature compensation */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (temp &lt; 2000) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>s64 tmp =3D=
 (s64)temp - 2000;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>t2 =3D (3 * ((s64)dt * (s64)dt)) =
&gt;&gt; 33;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>off2 =3D (61 * tmp * tmp) &gt;&gt; 4;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>sens2 =3D =
(29 * tmp * tmp) &gt;&gt; 4;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (temp &lt; -1500) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>s64 tmp =3D=
 (s64)temp + 1500;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>off2 +=3D 17 * tmp * =
tmp;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sens2 +=3D 9 * tmp * tmp;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>} else =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>t2 =3D (5 * ((s64)dt * (s64)dt)) &gt;&gt; 38;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>off2 =3D =
0;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sens2 =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* OFF =3D =
OFF_T1 + TCO * dT */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>off =3D (((s64)prom[2]) &lt;&lt; =
17) + ((((s64)prom[4]) * (s64)dt) &gt;&gt; 6);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>off -=3D =
off2;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Sensitivity at actual temperature =3D SENS_T1 + TCS * =
dT */<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sens =3D (((s64)prom[1]) &lt;&lt; 16) + (((s64)prom[3] * dt) =
&gt;&gt; 7);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>sens -=3D sens2;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>/* Temperature compensated =
pressure =3D D1 * SENS - OFF */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>*temperature =3D (temp - t2) * =
10;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>*pressure =3D (u32)(((((s64)p_adc * sens) &gt;&gt; 21) - off) =
&gt;&gt; 15);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return =
0;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_read_temp_and_pressure);<br>+<br>+MO=
DULE_DESCRIPTION("Measurement-Specialties common i2c =
driver");<br>+MODULE_AUTHOR("William Markezana =
&lt;william.markezana@meas-spec.com&gt;");<br>+MODULE_AUTHOR("Ludovic =
Tancerel =
&lt;ludovic.tancerel@maplehightech.com&gt;");<br>+MODULE_LICENSE("GPL =
v2");<br>+<br>diff --git =
a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h<br>new file mode =
100644<br>index 0000000..7b614ad<br>--- /dev/null<br>+++ =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h<br>@@ -0,0 +1,66 =
@@<br>+/*<br>+ * Measurements Specialties common sensor driver<br>+ =
*<br>+ * Copyright (c) 2015 Measurement-Specialties<br>+ *<br>+ * This =
program is free software; you can redistribute it and/or modify<br>+ * =
it under the terms of the GNU General Public License version 2 as<br>+ * =
published by the Free Software Foundation.<br>+ */<br>+<br>+#ifndef =
_MS_SENSORS_I2C_H<br>+#define _MS_SENSORS_I2C_H<br>+<br>+#include =
&lt;linux/i2c.h&gt;<br>+#include &lt;linux/mutex.h&gt;<br>+<br>+#define =
MS_SENSORS_TP_PROM_WORDS_NB<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>7<br>+<br>+/**<br>+ * struct =
ms_ht_dev - Humidity/Temperature sensor device structure<br>+ * =
@client:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>i2c client<br>+ * @lock:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>lock protecting the i2c =
conversion<br>+ * @res_index:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>index to selected sensor =
resolution<br>+ */<br>+struct ms_ht_dev {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
i2c_client *client;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct mutex lock;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u8 =
res_index;<br>+};<br>+<br>+/**<br>+ * struct ms_tp_dev - =
Temperature/Pressure sensor device structure<br>+ * @client:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>i2c =
client<br>+ * @lock:<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>lock protecting the i2c conversion<br>+ * @prom:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>array of =
PROM coefficients used for conversion. Added element<br>+ * =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;for CRC computation<br>+ * @res_index:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>index to selected sensor =
resolution<br>+ */<br>+struct ms_tp_dev {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
i2c_client *client;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct mutex lock;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u16 =
prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u8 res_index;<br>+};<br>+<br>+int =
ms_sensors_reset(void *cli, u8 cmd, unsigned int delay);<br>+int =
ms_sensors_read_prom_word(void *cli, int cmd, u16 *word);<br>+int =
ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>unsigned =
int delay, u32 *adc);<br>+int ms_sensors_read_serial(struct i2c_client =
*client, u64 *sn);<br>+ssize_t ms_sensors_show_serial(struct ms_ht_dev =
*dev_data, char *buf);<br>+ssize_t ms_sensors_write_resolution(struct =
ms_ht_dev *dev_data, u8 i);<br>+ssize_t =
ms_sensors_show_battery_low(struct ms_ht_dev *dev_data, char =
*buf);<br>+ssize_t ms_sensors_show_heater(struct ms_ht_dev *dev_data, =
char *buf);<br>+ssize_t ms_sensors_write_heater(struct ms_ht_dev =
*dev_data,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>const char *buf, size_t len);<br>+int =
ms_sensors_ht_read_temperature(struct ms_ht_dev *dev_data,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;s32 =
*temperature);<br>+int ms_sensors_ht_read_humidity(struct ms_ht_dev =
*dev_data,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>u32 *humidity);<br>+int ms_sensors_tp_read_prom(struct =
ms_tp_dev *dev_data);<br>+int ms_sensors_read_temp_and_pressure(struct =
ms_tp_dev *dev_data,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;int *temperature,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;unsigned int *pressure);<br>+<br>+#endif /* _MS_SENSORS_I2C_H =
*/<br><br></blockquote><br>--<br>To unsubscribe from this list: send the =
line "unsubscribe linux-iio" in<br>the body of a message to<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a><br=
>More majordomo info at &nbsp;<a =
href=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org=
/majordomo-info.html</a></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_5CBE2663-6BF5-4721-8F1C-4DA47F554D49--
