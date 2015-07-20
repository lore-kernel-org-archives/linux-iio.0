Return-Path: <ludovic.tancerel@maplehightech.com>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] iio: TSYS01, TSYS02D, HTU21, MS5637, MS8607 Measurement Specialties driver development
From: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
In-Reply-To: <55ABB7B5.8090401@kernel.org>
Date: Mon, 20 Jul 2015 18:18:36 +0200
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org,
 William.Markezana@meas-spec.com
Message-Id: <A75E9EAB-9FAA-4757-8374-CC39F35D4168@maplehightech.com>
References: <1437031541-27249-1-git-send-email-ludovic.tancerel@maplehightech.com> <55ABB7B5.8090401@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

thank you for the feedback.
Before proceeding to the rework and cutting out into several patches,
I have a few questions on your remarks.

Please have a look below,
regards,
Ludovic


Le 19 juil. 2015 =E0 16:44, Jonathan Cameron <jic23@kernel.org> a =E9crit =
:

> On 16/07/15 08:25, Ludovic Tancerel wrote:
>> Hello all,
>> this patch contains 5 drivers, including ms5637 that was proposed on =
a previous
>> patch, but reworked for following reasons.
>> As previously discussed with Jonathan, common part have been written =
to avoid
>> code duplication. I hope the approach followed will please you.
>> I tried to apply all previous feedback so hopefully, you will not =
have too
>> much formatting problems to comment on.
>>=20
>> Few notes on the content.
>> - HTU21 is already present in hwmon, however all the features wished =
by
>> Meas-Spec and the reuse between other HW makes that I have added a =
new one in
>> iio. Should the hwmon be removed in that case ?
> Not certain. Certainly not in the short term.  We will need to open
> a dialog with the hwmon guys about the way forward.
Will that happen once the driver is pushed ?
I believe it does not hurt anybody if both are present.

>=20
>> - There are things that can be commonalized with drivers =
ms5611/ms5607 pushed
>> by Thomas. The proposal is to have this done once this patch is =
approved.
> cool
>> - The HW resolution when configurable can be modified using =
SAMPLE_FREQ channel
>> as requested to avoid private ABI.
>> - Summary on HW :
>> TSYS01 : I2C / SPI - Temp sensor (only I2C supported in this patch)
>> TSYS02D : I2C only - Temp sensor
>> HTU21 : I2C only - Temp & Humidity (T part common with TSYS02D)
>> MS5637 : I2C only - Temp & Pressure
>> MS8607 : I2C only - Temp, Pressure & Humidity sensor (T&P part comon =
with MS563$
> typo?
Yes, sorry,
you should have read (T&P part common with MS5637 and humidity part =
commong with HTU21)

>>=20
>> Thank you for reviewing,
>> Ludovic
>>=20
> Others have clearly picked up on process issues etc (how many patches)
> so I'm just diving in regardless to get some nitty gritty bits.
>=20
> First general point is that exported functions should have kernel-doc
> style documentation.
>=20
> Split the dual part drivers (e.g. two devices in one physical package) =
into
> two different drivers.  We have this one commonly and it is never =
worth the
> pain of a single driver (when there is no actual connection other than =
the
> package)  I would guess this may result in more shared code as the
> humidity parts are probably the same and you have documented above
> that hte pressure and temp parts are.
I agree it makes sense to split both into two for MS8607 which really is =
2 parts into one package.
I don=92t plan on making HTU21 and MS5637 as different drivers. It is =
one part for each, and this is how other drivers are usually written.

>=20
> The common library approach seems to have worked pretty well. Just a =
bit
> of tidying up to do.
>=20
> Jonathan
>> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
>> ---
>> drivers/iio/common/Kconfig                     |   1 +
>> drivers/iio/common/Makefile                    |   1 +
>> drivers/iio/common/ms_sensors/Kconfig          |   6 +
>> drivers/iio/common/ms_sensors/Makefile         |   5 +
>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 496 =
+++++++++++++++++++++++++
>> drivers/iio/common/ms_sensors/ms_sensors_i2c.h |  59 +++
>> drivers/iio/humidity/Kconfig                   |  11 +
>> drivers/iio/humidity/Makefile                  |   1 +
>> drivers/iio/humidity/htu21.c                   | 237 ++++++++++++
>> drivers/iio/pressure/Kconfig                   |  22 ++
>> drivers/iio/pressure/Makefile                  |   2 +
>> drivers/iio/pressure/ms5637.c                  | 189 ++++++++++
>> drivers/iio/pressure/ms8607.c                  | 330 ++++++++++++++++
>> drivers/iio/temperature/Kconfig                |  30 ++
>> drivers/iio/temperature/Makefile               |   3 +
>> drivers/iio/temperature/tsys01.c               | 191 ++++++++++
>> drivers/iio/temperature/tsys01.h               |  43 +++
>> drivers/iio/temperature/tsys01_i2c.c           |  67 ++++
>> drivers/iio/temperature/tsys02d.c              | 206 ++++++++++
>> 19 files changed, 1900 insertions(+)
>> create mode 100644 drivers/iio/common/ms_sensors/Kconfig
>> create mode 100644 drivers/iio/common/ms_sensors/Makefile
>> create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>> create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>> create mode 100644 drivers/iio/humidity/htu21.c
>> create mode 100644 drivers/iio/pressure/ms5637.c
>> create mode 100644 drivers/iio/pressure/ms8607.c
>> create mode 100644 drivers/iio/temperature/tsys01.c
>> create mode 100644 drivers/iio/temperature/tsys01.h
>> create mode 100644 drivers/iio/temperature/tsys01_i2c.c
>> create mode 100644 drivers/iio/temperature/tsys02d.c
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
>> index 0000000..a79ea48
>> --- /dev/null
>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>> @@ -0,0 +1,496 @@
>> +/*
>> + * Measurements Specialties driver common i2c functions
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/device.h>
>> +#include <linux/delay.h>
>> +
>> +#include "ms_sensors_i2c.h"
>> +
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
>> +#define MS_SENSORS_USER_REG_WRITE		0xE6
>> +#define MS_SENSORS_USER_REG_READ		0xE7
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
>> +int ms_sensors_i2c_reset(void *cli, u8 cmd, unsigned int delay)
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
>> +EXPORT_SYMBOL(ms_sensors_i2c_reset);
>> +
>> +int ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 *word)
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
>> +EXPORT_SYMBOL(ms_sensors_i2c_read_prom_word);
>> +
>> +int ms_sensors_i2c_convert_and_read(void *cli, u8 conv, u8 rd,
>> +				    unsigned int delay, u32 *adc)
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
>> +	dev_dbg(&client->dev, "ADC raw value : %x\n", cpu_to_be32(buf) =
>> 8);
>> +	*adc =3D cpu_to_be32(buf) >> 8;
>> +
>> +	return 0;
>> +err:
>> +	dev_err(&client->dev, "Unable to make sensor adc conversion\n");
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_convert_and_read);
>> +
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
> This function is a little fiddly, perhaps a few more comments on what =
it
> is doing?
>> +int ms_sensors_i2c_read_serial(struct i2c_client *client, u64 *sn)
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
>> +		 .buf =3D (char *)&send_buf,
>> +		 },
>> +		{
>> +		 .addr =3D client->addr,
>> +		 .flags =3D client->flags | I2C_M_RD,
>> +		 .buf =3D (char *)&rcv_buf,
>> +		 },
>> +	};
>> +
>> +	/* Read MSB part of serial number */
>> +	send_buf =3D be16_to_cpu(MS_SENSORS_SERIAL_READ_MSB);
>> +	msg[1].len =3D 8;
> Just set that above... why leave it until here?
>=20
>> +	ret =3D i2c_transfer(client->adapter, msg, 2);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	rcv_buf =3D cpu_to_be64(rcv_buf);
> Why would recv_buf at this point have cpu endianness?
>=20
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
>> +	send_buf =3D be16_to_cpu(MS_SENSORS_SERIAL_READ_LSB);
>> +	msg[1].len =3D 6;
>> +	rcv_buf =3D 0;
>> +	ret =3D i2c_transfer(client->adapter, msg, 2);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	rcv_buf =3D cpu_to_be64(rcv_buf) >> 16;
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
>> +
>> +err:
>> +	dev_err(&client->dev, "Unable to read device serial number");
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_read_serial);
>> +
>> +static int ms_sensors_i2c_read_user_reg(struct i2c_client *client,
>> +					u8 *user_reg)
>> +{
>> +	int ret;
>> +
>> +	ret =3D i2c_smbus_write_byte(client, MS_SENSORS_USER_REG_READ);
>> +	if (ret)
>> +		goto err;
>> +
>> +	ret =3D i2c_master_recv(client, user_reg, 1);
>> +	if (ret < 0)
>> +		goto err;
>> +	dev_dbg(&client->dev, "User register :%x\n", *user_reg);
>> +
>> +	return 0;
>> +err:
>> +	dev_err(&client->dev, "Unable to read user reg");
>> +	return ret;
>> +}
>> +
>> +ssize_t ms_sensors_i2c_write_resolution(struct ms_ht_dev *dev_data,
>> +					u8 i)
>> +{
>> +	u8 user_reg;
>> +	int ret;
>> +
>> +	ret =3D ms_sensors_i2c_read_user_reg(dev_data->client, =
&user_reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	user_reg &=3D 0x7E;
>> +	user_reg |=3D ((i & 1) << 7) + ((i & 2) >> 1);
>> +
>> +	ret =3D i2c_smbus_write_byte_data(dev_data->client,
>> +					MS_SENSORS_USER_REG_WRITE,
>> +					user_reg);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_write_resolution);
>> +
>> +ssize_t ms_sensors_i2c_show_serial(struct ms_ht_dev *dev_data, char =
*buf)
>> +{
>> +	int ret =3D sprintf(buf, "%08llx\n", dev_data->serial_number);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_show_serial);
>> +
>> +ssize_t ms_sensors_i2c_show_battery_low(struct ms_ht_dev *dev_data,
>> +					char *buf)
>> +{
>> +	int ret;
>> +	u8 user_reg;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	ret =3D ms_sensors_i2c_read_user_reg(dev_data->client, =
&user_reg);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sprintf(buf, "%d\n", (user_reg & 0x40) >> 6);
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_show_battery_low);
>> +
>> +ssize_t ms_sensors_i2c_show_heater(struct ms_ht_dev *dev_data,
>> +				   char *buf)
>> +{
>> +	u8 user_reg;
>> +	int ret;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	ret =3D ms_sensors_i2c_read_user_reg(dev_data->client, =
&user_reg);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sprintf(buf, "%d\n", (user_reg & 0x4) >> 2);
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_show_heater);
>> +
>> +ssize_t ms_sensors_i2c_write_heater(struct ms_ht_dev *dev_data,
>> +				    const char *buf, size_t len)
>> +{
>> +	u8 val, user_reg;
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
>> +	ret =3D ms_sensors_i2c_read_user_reg(dev_data->client, =
&user_reg);
>> +	if (ret) {
>> +		mutex_unlock(&dev_data->lock);
>> +		return ret;
>> +	}
>> +
>> +	user_reg &=3D 0xFB;
>> +	user_reg |=3D val << 2;
>> +
>> +	ret =3D i2c_smbus_write_byte_data(dev_data->client,
>> +					MS_SENSORS_USER_REG_WRITE,
>> +					user_reg);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret) {
>> +		dev_err(&dev_data->client->dev, "Unable to write user =
reg\n");
>> +		return ret;
>> +	}
>> +
>> +	return len;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_write_heater);
>> +
>> +int ms_sensors_i2c_ht_read_temperature(struct ms_ht_dev *dev_data,
>> +				       s32 *temperature)
>> +{
>> +	int ret;
>> +	u32 adc;
>> +	u16 delay;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	delay =3D ms_sensors_ht_t_conversion_time[dev_data->res_index];
>> +	ret =3D ms_sensors_i2c_convert_and_read(dev_data->client,
>> +					      =
MS_SENSORS_HT_T_CONVERSION_START,
>> +					      MS_SENSORS_NO_READ_CMD,
>> +					      delay, &adc);
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
>> +EXPORT_SYMBOL(ms_sensors_i2c_ht_read_temperature);
>> +
>> +int ms_sensors_i2c_ht_read_humidity(struct ms_ht_dev *dev_data,
>> +				    u32 *humidity)
>> +{
>> +	int ret;
>> +	u32 adc;
>> +	u16 delay;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	delay =3D ms_sensors_ht_h_conversion_time[dev_data->res_index];
>> +	ret =3D ms_sensors_i2c_convert_and_read(dev_data->client,
>> +					      =
MS_SENSORS_HT_H_CONVERSION_START,
>> +					      MS_SENSORS_NO_READ_CMD,
>> +					      delay, &adc);
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
>> +	*humidity =3D (((s32)(adc >> 8) * 12500) >> 16) - 600;
>> +	if (*humidity >=3D 10000)
>> +		*humidity =3D 10000;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_ht_read_humidity);
>> +
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
> General principal is that all exported functions should  have =
kernel-doc
> comments to describe them.  Not immediately obvious what you are =
reading
> from a prom.
This is used in computation of temp & pressure. I will add kernel-doc, =
sorry about this miss.

>> +int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
>> +{
>> +	int i, ret;
>> +
>> +	for (i =3D 0; i < MS_SENSORS_TP_PROM_WORDS_NB; i++) {
>> +		ret =3D ms_sensors_i2c_read_prom_word(
>> +					dev_data->client,
>> +					MS_SENSORS_TP_PROM_READ + (i << =
1),
>> +					&dev_data->prom[i]);
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
>> +int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
>> +				      int *temperature,
>> +				      unsigned int *pressure)
>> +{
>> +	int ret;
>> +	u32 t_adc, p_adc;
>> +	s32 dt, temp;
>> +	s64 off, sens, t2, off2, sens2;
>> +	u16 *prom =3D dev_data->prom, delay;
>> +	u8 i;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	i =3D dev_data->res_index * 2;
>> +	delay =3D ms_sensors_tp_conversion_time[dev_data->res_index];
>> +	ret =3D ms_sensors_i2c_convert_and_read(
>> +					dev_data->client,
>> +					MS_SENSORS_TP_T_CONVERSION_START =
+ i,
>> +					MS_SENSORS_TP_ADC_READ,
>> +					delay, &t_adc);
>> +	if (ret) {
>> +		mutex_unlock(&dev_data->lock);
>> +		return ret;
>> +	}
>> +	ret =3D ms_sensors_i2c_convert_and_read(
>> +					dev_data->client,
>> +					MS_SENSORS_TP_P_CONVERSION_START =
+ i,
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
>> index 0000000..45e49ed
>> --- /dev/null
>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>> @@ -0,0 +1,59 @@
>> +/*
>> + * Measurements Specialties common sensor driver
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * This program is free software; you can redistribute it and/or =
modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
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
>> +#define MS_SENSORS_ATTR_SERIAL			0
>> +#define MS_SENSORS_ATTR_BAT			1
>> +#define MS_SENSORS_ATTR_HEATER			2
>> +
>> +struct ms_ht_dev {
>> +	struct i2c_client *client;
>> +	struct mutex lock; /* mutex protecting data structure */
>> +	u64 serial_number;
>> +	u8 res_index;
>> +};
>> +
>> +struct ms_tp_dev {
>> +	struct i2c_client *client;
>> +	struct mutex lock; /* mutex protecting data structure */
>> +	/* Added element for CRC computation */
>> +	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];
>> +	u8 res_index;
>> +};
>> +
>> +int ms_sensors_i2c_reset(void *cli, u8 cmd, unsigned int delay);
>> +int ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 *word);
>> +int ms_sensors_i2c_convert_and_read(void *cli, u8 conv, u8 rd,
>> +				    unsigned int delay, u32 *adc);
>> +int ms_sensors_i2c_read_serial(struct i2c_client *client, u64 *sn);
>> +ssize_t ms_sensors_i2c_show_serial(struct ms_ht_dev *dev_data, char =
*buf);
>> +ssize_t ms_sensors_i2c_write_resolution(struct ms_ht_dev *dev_data, =
u8 i);
>> +ssize_t ms_sensors_i2c_show_battery_low(struct ms_ht_dev *dev_data, =
char *buf);
>> +ssize_t ms_sensors_i2c_show_heater(struct ms_ht_dev *dev_data, char =
*buf);
>> +ssize_t ms_sensors_i2c_write_heater(struct ms_ht_dev *dev_data,
>> +				    const char *buf, size_t len);
>> +int ms_sensors_i2c_ht_read_temperature(struct ms_ht_dev *dev_data,
>> +				       s32 *temperature);
>> +int ms_sensors_i2c_ht_read_humidity(struct ms_ht_dev *dev_data,
>> +				    u32 *humidity);
>> +int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data);
>> +int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
>> +				      int *temperature,
>> +				      unsigned int *pressure);
>> +
>> +#endif /* _MS_SENSORS_I2C_H */
>> diff --git a/drivers/iio/humidity/Kconfig =
b/drivers/iio/humidity/Kconfig
>> index 4813b79..ccb2de3 100644
>> --- a/drivers/iio/humidity/Kconfig
>> +++ b/drivers/iio/humidity/Kconfig
>> @@ -12,6 +12,17 @@ config DHT11
>> 	  Other sensors should work as well as long as they speak the
>> 	  same protocol.
>>=20
>> +config HTU21
>> +	tristate "Measurement Specialities HTU21 humidity & temperature =
sensor"
>> +	depends on I2C
>> +        select IIO_MS_SENSORS_I2C
>> +	help
>> +	  If you say yes here you get support for the Measurement =
Specialties
>> +	  HTU21 humidity and temperature sensor.
>> +
>> +	  This driver can also be built as a module. If so, the module =
will
>> +	  be called htu21.
>> +
>> config SI7005
>> 	tristate "SI7005 relative humidity and temperature sensor"
>> 	depends on I2C
>> diff --git a/drivers/iio/humidity/Makefile =
b/drivers/iio/humidity/Makefile
>> index 86e2d26..826b1d5 100644
>> --- a/drivers/iio/humidity/Makefile
>> +++ b/drivers/iio/humidity/Makefile
>> @@ -3,5 +3,6 @@
>> #
>>=20
>> obj-$(CONFIG_DHT11) +=3D dht11.o
>> +obj-$(CONFIG_HTU21) +=3D htu21.o
>> obj-$(CONFIG_SI7005) +=3D si7005.o
>> obj-$(CONFIG_SI7020) +=3D si7020.o
>> diff --git a/drivers/iio/humidity/htu21.c =
b/drivers/iio/humidity/htu21.c
>> new file mode 100644
>> index 0000000..1efc291
>> --- /dev/null
>> +++ b/drivers/iio/humidity/htu21.c
>> @@ -0,0 +1,237 @@
>> +/*
>> + * htu21.c - Support for Measurement-Specialties
>> + *           htu21 temperature & humidity sensor
>> + *
>> + * Copyright (c) 2014 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + * (7-bit I2C slave address 0x40)
>> + *
>> + * Datasheet:
>> + *  http://www.meas-spec.com/downloads/HTU21D.pdf
>> + *
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/stat.h>
>> +#include <linux/module.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#include "../common/ms_sensors/ms_sensors_i2c.h"
>> +
>> +#define HTU21_RESET				0xFE
>> +
>> +static const int htu21_samp_freq[4] =3D { 20, 40, 70, 120 };
>> +/* String copy of the above const for readability purpose */
>> +static const char htu21_show_samp_freq[] =3D "20 40 70 120";
>> +
>> +static int htu21_read_raw(struct iio_dev *indio_dev,
>> +			  struct iio_chan_spec const *channel, int *val,
>> +			  int *val2, long mask)
>> +{
>> +	int ret, temperature;
>> +	unsigned int humidity;
>> +	struct ms_ht_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		switch (channel->type) {
>> +		case IIO_TEMP:	/* in =B0C */
>> +			ret =3D =
ms_sensors_i2c_ht_read_temperature(dev_data,
>> +								 =
&temperature);
>> +			if (ret)
>> +				return ret;
>> +			*val =3D temperature / 1000;
>> +			*val2 =3D (temperature % 1000) * 1000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		case IIO_HUMIDITYRELATIVE:	/* in %RH */
>> +			ret =3D =
ms_sensors_i2c_ht_read_humidity(dev_data,
>> +							      =
&humidity);
>> +			if (ret)
>> +				return ret;
>> +			*val =3D humidity / 100;
>> +			*val2 =3D (humidity % 100) * 10000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val =3D htu21_samp_freq[dev_data->res_index];
>> +
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int htu21_write_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int val, int val2, long mask)
>> +{
>> +	struct ms_ht_dev *dev_data =3D iio_priv(indio_dev);
>> +	int i, ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		i =3D ARRAY_SIZE(htu21_samp_freq);
>> +		while (i-- > 0)
>> +			if (val =3D=3D htu21_samp_freq[i])
>> +				break;
>> +		if (i < 0)
>> +			return -EINVAL;
>> +		mutex_lock(&dev_data->lock);
>> +		dev_data->res_index =3D i;
>> +		ret =3D ms_sensors_i2c_write_resolution(dev_data, i);
>> +		mutex_unlock(&dev_data->lock);
>> +
>> +		return ret;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_chan_spec htu21_channels[] =3D {
>> +	{
>> +		.type =3D IIO_TEMP,
>> +		.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all =3D =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	 },
>> +	{
>> +		.type =3D IIO_HUMIDITYRELATIVE,
>> +		.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all =3D =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	 }
>> +};
>> +
>> +static ssize_t htu21_i2c_write_heater(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t len)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> +	struct ms_ht_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	return ms_sensors_i2c_write_heater(dev_data, buf, len);
>> +}
>> +
>> +static ssize_t htu21_attr_read(struct device *dev,
>> +			       struct device_attribute *attr, char *buf)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> +	struct ms_ht_dev *dev_data =3D iio_priv(indio_dev);
>> +	struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> Break this up into individual attr funcs.
>> +
>> +	switch (this_attr->address) {
>> +	case MS_SENSORS_ATTR_SERIAL:
>> +
>> +		return ms_sensors_i2c_show_serial(dev_data, buf);
>> +	case MS_SENSORS_ATTR_BAT:
>> +
>> +		return ms_sensors_i2c_show_battery_low(dev_data, buf);
>> +	case MS_SENSORS_ATTR_HEATER:
>> +
>> +		return ms_sensors_i2c_show_heater(dev_data, buf);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(htu21_show_samp_freq);
>> +static IIO_DEVICE_ATTR(in_serial, S_IRUGO,
>> +		       htu21_attr_read, NULL, MS_SENSORS_ATTR_SERIAL);
>> +static IIO_DEVICE_ATTR(in_battery_low, S_IRUGO,
>> +		       htu21_attr_read, NULL, MS_SENSORS_ATTR_BAT);
>> +static IIO_DEVICE_ATTR(heater_enable,
>> +		       S_IRUGO | S_IWUSR,
>> +		       htu21_attr_read,
>> +		       htu21_i2c_write_heater, MS_SENSORS_ATTR_HEATER);
>> +
>> +static struct attribute *htu21_attributes[] =3D {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	&iio_dev_attr_in_serial.dev_attr.attr,
>> +	&iio_dev_attr_in_battery_low.dev_attr.attr,
>> +	&iio_dev_attr_heater_enable.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group htu21_attribute_group =3D {
>> +	.attrs =3D htu21_attributes,
>> +};
>> +
>> +static const struct iio_info htu21_info =3D {
>> +	.read_raw =3D htu21_read_raw,
>> +	.write_raw =3D htu21_write_raw,
>> +	.attrs =3D &htu21_attribute_group,
>> +	.driver_module =3D THIS_MODULE,
>> +};
>> +
>> +int htu21_probe(struct i2c_client *client,
>> +		const struct i2c_device_id *id)
>> +{
>> +	struct ms_ht_dev *dev_data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support some transaction\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&client->dev, =
sizeof(*dev_data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	dev_data =3D iio_priv(indio_dev);
>> +	dev_data->client =3D client;
>> +	dev_data->res_index =3D 0;
>> +	mutex_init(&dev_data->lock);
>> +
>> +	indio_dev->info =3D &htu21_info;
>> +	indio_dev->name =3D id->name;
>> +	indio_dev->dev.parent =3D &client->dev;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->channels =3D htu21_channels;
>> +	indio_dev->num_channels =3D ARRAY_SIZE(htu21_channels);
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ret =3D ms_sensors_i2c_reset(client, HTU21_RESET, 15000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ms_sensors_i2c_read_serial(client, =
&dev_data->serial_number);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(&client->dev, indio_dev);
>> +}
>> +
>> +static const struct i2c_device_id htu21_id[] =3D {
>> +	{"htu21", 0},
>> +	{}
>> +};
>> +
>> +static struct i2c_driver htu21_driver =3D {
>> +	.probe =3D htu21_probe,
>> +	.id_table =3D htu21_id,
>> +	.driver =3D {
>> +		   .name =3D "htu21",
>> +		   .owner =3D THIS_MODULE,
>> +		   },
>> +};
>> +
>> +module_i2c_driver(htu21_driver);
>> +
>> +MODULE_DESCRIPTION("Measurement-Specialties htu21 temperature and =
humidity driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/pressure/Kconfig =
b/drivers/iio/pressure/Kconfig
>> index fa62950..8108597 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -79,6 +79,28 @@ config MS5611_SPI
>> 	  To compile this driver as a module, choose M here: the module =
will
>> 	  be called ms5611_spi.
>>=20
>> +config MS5637
>> +	tristate "Measurement Specialities MS5637 pressure & temperature =
sensor"
>> +	depends on I2C
>> +        select IIO_MS_SENSORS_I2C
>> +	help
>> +	  If you say yes here you get support for the Measurement =
Specialties
>> +	  MS5637 pressure and temperature sensor.
>> +
>> +	  This driver can also be built as a module. If so, the module =
will
>> +	  be called ms5637.
>> +
>> +config MS8607
>> +	tristate "Measurement Specialities MS8607 pressure, temperature =
& humidity sensor"
>> +	depends on I2C
>> +        select IIO_MS_SENSORS_I2C
>> +	help
>> +	  If you say yes here you get support for the Measurement =
Specialties
>> +	  MS8607 pressure, temperature and humidity sensor.
>> +
>> +	  This driver can also be built as a module. If so, the module =
will
>> +	  be called ms8607.
>> +
>> config IIO_ST_PRESS
>> 	tristate "STMicroelectronics pressure sensor Driver"
>> 	depends on (I2C || SPI_MASTER) && SYSFS
>> diff --git a/drivers/iio/pressure/Makefile =
b/drivers/iio/pressure/Makefile
>> index a4f98f8..89c9e37 100644
>> --- a/drivers/iio/pressure/Makefile
>> +++ b/drivers/iio/pressure/Makefile
>> @@ -10,6 +10,8 @@ obj-$(CONFIG_MPL3115) +=3D mpl3115.o
>> obj-$(CONFIG_MS5611) +=3D ms5611_core.o
>> obj-$(CONFIG_MS5611_I2C) +=3D ms5611_i2c.o
>> obj-$(CONFIG_MS5611_SPI) +=3D ms5611_spi.o
>> +obj-$(CONFIG_MS5637) +=3D ms5637.o
>> +obj-$(CONFIG_MS8607) +=3D ms8607.o
>> obj-$(CONFIG_IIO_ST_PRESS) +=3D st_pressure.o
>> st_pressure-y :=3D st_pressure_core.o
>> st_pressure-$(CONFIG_IIO_BUFFER) +=3D st_pressure_buffer.o
>> diff --git a/drivers/iio/pressure/ms5637.c =
b/drivers/iio/pressure/ms5637.c
>> new file mode 100644
>> index 0000000..2f50772
>> --- /dev/null
>> +++ b/drivers/iio/pressure/ms5637.c
>> @@ -0,0 +1,189 @@
>> +/*
>> + * ms5637.c - Support for Measurement-Specialties ms5637
>> + *            pressure & temperature sensor
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + * (7-bit I2C slave address 0x76)
>> + *
>> + * Datasheet:
>> + *  http://www.meas-spec.com/downloads/MS5637-02BA03.pdf
>> + *
>> + */
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/stat.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/mutex.h>
>> +
>> +#include "../common/ms_sensors/ms_sensors_i2c.h"
>> +
>> +static const int ms5637_samp_freq[6] =3D { 960, 480, 240, 120, 60, =
30 };
>> +/* String copy of the above const for readability purpose */
>> +static const char ms5637_show_samp_freq[] =3D "960 480 240 120 60 =
30";
>> +
>> +static int ms5637_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *channel, int =
*val,
>> +			   int *val2, long mask)
>> +{
>> +	int ret;
>> +	int temperature;
>> +	unsigned int pressure;
>> +	struct ms_tp_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		ret =3D ms_sensors_read_temp_and_pressure(dev_data,
>> +							&temperature,
>> +							&pressure);
>> +		if (ret)
>> +			return ret;
>> +
>> +		switch (channel->type) {
>> +		case IIO_TEMP:	/* in =B0C */
>> +			*val =3D temperature / 1000;
>> +			*val2 =3D (temperature % 1000) * 1000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		case IIO_PRESSURE:	/* in kPa */
>> +			*val =3D pressure / 1000;
>> +			*val2 =3D (pressure % 1000) * 1000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val =3D ms5637_samp_freq[dev_data->res_index];
>> +
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ms5637_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct ms_tp_dev *dev_data =3D iio_priv(indio_dev);
>> +	int i;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		i =3D ARRAY_SIZE(ms5637_samp_freq);
>> +		while (i-- > 0)
>> +			if (val =3D=3D ms5637_samp_freq[i])
>> +				break;
>> +		if (i < 0)
>> +			return -EINVAL;
>> +		dev_data->res_index =3D i;
>> +
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_chan_spec ms5637_channels[] =3D {
>> +	{
>> +		.type =3D IIO_TEMP,
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all =3D =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	},
>> +	{
>> +		.type =3D IIO_PRESSURE,
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all =3D =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	}
>> +};
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(ms5637_show_samp_freq);
>> +
>> +static struct attribute *ms5637_attributes[] =3D {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group ms5637_attribute_group =3D {
>> +	.attrs =3D ms5637_attributes,
>> +};
>> +
>> +static const struct iio_info ms5637_info =3D {
>> +	.read_raw =3D ms5637_read_raw,
>> +	.write_raw =3D ms5637_write_raw,
>> +	.attrs =3D &ms5637_attribute_group,
>> +	.driver_module =3D THIS_MODULE,
>> +};
>> +
>> +static int ms5637_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	struct ms_tp_dev *dev_data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_READ_WORD_DATA |
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support some transaction\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&client->dev, =
sizeof(*dev_data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	dev_data =3D iio_priv(indio_dev);
>> +	dev_data->client =3D client;
>> +	dev_data->res_index =3D 5;
>> +	mutex_init(&dev_data->lock);
>> +
>> +	indio_dev->info =3D &ms5637_info;
>> +	indio_dev->name =3D id->name;
>> +	indio_dev->dev.parent =3D &client->dev;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->channels =3D ms5637_channels;
>> +	indio_dev->num_channels =3D ARRAY_SIZE(ms5637_channels);
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ret =3D ms_sensors_i2c_reset(client, 0x1E, 3000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ms_sensors_tp_read_prom(dev_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(&client->dev, indio_dev);
>> +}
>> +
>> +static const struct i2c_device_id ms5637_id[] =3D {
>> +	{"ms5637", 0},
>> +	{}
>> +};
>> +
>> +static struct i2c_driver ms5637_driver =3D {
>> +	.probe =3D ms5637_probe,
>> +	.id_table =3D ms5637_id,
>> +	.driver =3D {
>> +		   .name =3D "ms5637",
>> +		   .owner =3D THIS_MODULE,
>> +		   },
>> +};
>> +
>> +module_i2c_driver(ms5637_driver);
>> +
>> +MODULE_DESCRIPTION("Measurement-Specialties ms5637 temperature & =
pressure driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/pressure/ms8607.c =
b/drivers/iio/pressure/ms8607.c
>> new file mode 100644
>> index 0000000..32de648
>> --- /dev/null
>> +++ b/drivers/iio/pressure/ms8607.c
>> @@ -0,0 +1,330 @@
>> +/*
>> + * ms8607.c - Support for Measurement-Specialties
>> + *            ms8607 temperature, pressure and humidity sensor
>> + *
>> + * Copyright (c) 2014 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + * (7-bit I2C slave address 0x40 and 0x77)
>> + *
>> + * Datasheet:
>> + *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
>> + *
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/stat.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/mutex.h>
>> +
>> +#include "../common/ms_sensors/ms_sensors_i2c.h"
>> +
>> +/* MS8607 uses 2 I2C addresses. First one is defined in device tree =
*/
>> +#define MS8607_H_ADDRESS	0x40
>> +
>> +struct ms8607_dev {
>> +	struct ms_tp_dev tp;
>> +	struct ms_ht_dev ht;
>> +};
>> +
>> +static const int ms8607_samp_freq_tp[6] =3D { 960, 480, 240, 120, =
60, 30 };
>> +/* String copy of the above const for readability purpose */
>> +static const char ms8607_show_samp_freq_tp[] =3D "960 480 240 120 60 =
30";
>> +
>> +static const int ms8607_samp_freq_ht[4] =3D { 20, 40, 70, 120 };
>> +/* String copy of the above const for readability purpose */
>> +static const char ms8607_show_samp_freq_ht[] =3D "20 40 70 120";
>> +
>> +static int ms8607_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan, int *val,
>> +			   int *val2, long mask)
>> +{
>> +	int ret;
>> +	int temperature;
>> +	unsigned int pressure;
>> +	unsigned int humidity;
>> +	struct ms8607_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		switch (chan->type) {
>> +		case IIO_TEMP: /* in =B0C */
>> +			ret =3D =
ms_sensors_read_temp_and_pressure(&dev_data->tp,
>> +								=
&temperature,
>> +								=
&pressure);
>> +			if (ret)
>> +				return ret;
>> +			*val =3D temperature / 1000;
>> +			*val2 =3D (temperature % 1000) * 1000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		case IIO_PRESSURE: /* in kPa */
>> +			ret =3D =
ms_sensors_read_temp_and_pressure(&dev_data->tp,
>> +								=
&temperature,
>> +								=
&pressure);
>> +			if (ret)
>> +				return ret;
>> +			*val =3D pressure / 1000;
>> +			*val2 =3D (pressure % 1000) * 1000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		case IIO_HUMIDITYRELATIVE: /* in %RH */
>> +			ret =3D =
ms_sensors_i2c_ht_read_humidity(&dev_data->ht,
>> +							      =
&humidity);
>> +			if (ret)
>> +				return ret;
>> +			*val =3D humidity / 100;
>> +			*val2 =3D (humidity % 100) * 10000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		ret =3D IIO_VAL_INT;
>> +		break;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		switch (chan->type) {
>> +		case IIO_PRESSURE:
>> +		case IIO_TEMP:
>> +			*val =3D =
ms8607_samp_freq_tp[dev_data->tp.res_index];
>> +
>> +			return IIO_VAL_INT;
>> +		case IIO_HUMIDITYRELATIVE:
>> +			*val =3D =
ms8607_samp_freq_ht[dev_data->ht.res_index];
>> +
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int ms8607_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct ms8607_dev *dev_data =3D iio_priv(indio_dev);
>> +	int i, ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +		case IIO_PRESSURE:
>> +			i =3D ARRAY_SIZE(ms8607_samp_freq_tp);
>> +			while (i-- > 0)
>> +				if (val =3D=3D ms8607_samp_freq_tp[i])
>> +					break;
>> +			if (i < 0)
>> +				return -EINVAL;
>> +			dev_data->tp.res_index =3D i;
>> +
>> +			return 0;
>> +		case IIO_HUMIDITYRELATIVE:
>> +			i =3D ARRAY_SIZE(ms8607_samp_freq_ht);
>> +			while (i-- > 0)
>> +				if (val =3D=3D ms8607_samp_freq_ht[i])
>> +					break;
>> +			if (i < 0)
>> +				return -EINVAL;
>> +			mutex_lock(&dev_data->ht.lock);
>> +			dev_data->ht.res_index =3D i;
>> +			ret =3D =
ms_sensors_i2c_write_resolution(&dev_data->ht,
>> +							      i);
>> +			mutex_unlock(&dev_data->ht.lock);
>> +
>> +			return ret;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_chan_spec ms8607_channels[] =3D {
>> +	{
>> +		.type =3D IIO_TEMP,
>> +		.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED) |
>> +					    =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	},
>> +	{
>> +		.type =3D IIO_PRESSURE,
>> +		.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED) |
>> +					    =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	},
>> +	{
>> +		.type =3D IIO_HUMIDITYRELATIVE,
>> +		.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED) |
>> +					    =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	}
>> +};
>> +
>> +static ssize_t ms8607_i2c_write_heater(struct device *dev,
>> +				       struct device_attribute *attr,
>> +				       const char *buf, size_t len)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> +	struct ms8607_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	return ms_sensors_i2c_write_heater(&dev_data->ht, buf, len);
>> +}
>> +
>> +static ssize_t ms8607_attr_read(struct device *dev,
>> +				struct device_attribute *attr, char =
*buf)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> +	struct ms8607_dev *dev_data =3D iio_priv(indio_dev);
>> +	struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +
> Separate attr_read functions will be cleaner than this.. One per case
> below.
>> +	switch (this_attr->address) {
>> +	case MS_SENSORS_ATTR_SERIAL:
>> +
>> +		return ms_sensors_i2c_show_serial(&dev_data->ht, buf);
>> +	case MS_SENSORS_ATTR_BAT:
>> +
>> +		return ms_sensors_i2c_show_battery_low(&dev_data->ht, =
buf);
>> +	case MS_SENSORS_ATTR_HEATER:
>> +
>> +		return ms_sensors_i2c_show_heater(&dev_data->ht, buf);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +IIO_CONST_ATTR(sampling_frequency_available_tp, =
ms8607_show_samp_freq_tp);
>> +IIO_CONST_ATTR(sampling_frequency_available_h, =
ms8607_show_samp_freq_ht);
>> +static IIO_DEVICE_ATTR(in_serial, S_IRUGO,
>> +		       ms8607_attr_read, NULL, MS_SENSORS_ATTR_SERIAL);
>> +static IIO_DEVICE_ATTR(in_battery_low, S_IRUGO,
>> +		       ms8607_attr_read, NULL, MS_SENSORS_ATTR_BAT);
>> +static IIO_DEVICE_ATTR(heater_enable,
>> +		       S_IRUGO | S_IWUSR,
>> +		       ms8607_attr_read,
>> +		       ms8607_i2c_write_heater, MS_SENSORS_ATTR_HEATER);
>> +
>> +static struct attribute *ms8607_attributes[] =3D {
>=20
> non standard abi for no particular reason.  Note this goes away if you
> split the driver in to it's two halves as suggested below.
>=20
>> +	&iio_const_attr_sampling_frequency_available_tp.dev_attr.attr,
>> +	&iio_const_attr_sampling_frequency_available_h.dev_attr.attr,
>> +	&iio_dev_attr_in_serial.dev_attr.attr,
>> +	&iio_dev_attr_in_battery_low.dev_attr.attr,
>> +	&iio_dev_attr_heater_enable.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group ms8607_attribute_group =3D {
>> +	.attrs =3D ms8607_attributes,
>> +};
>> +
>> +static const struct iio_info ms8607_info =3D {
>> +	.read_raw =3D ms8607_read_raw,
>> +	.write_raw =3D ms8607_write_raw,
>> +	.attrs =3D &ms8607_attribute_group,
>> +	.driver_module =3D THIS_MODULE,
>> +};
>> +
>> +static int ms8607_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	struct ms8607_dev *dev_data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_READ_WORD_DATA |
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support some transaction\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&client->dev, =
sizeof(*dev_data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	dev_data =3D iio_priv(indio_dev);
> Hmm. Why the dummy i2c bus?
>=20
> Definitely needs an explanation. I am guessing we are dealing with two
> separate i2c parts in the same package?
>=20
> Hmm. just looked at the datasheet and this is indeed a package with =
two
> completely separate sensors in it.  Split the driver.  It leads to a =
simpler
> answer ever time we meet this..  Just have ms8607_humidity and =
ms8607_pressure
> driver pair.
>=20
>> +	dev_data->tp.client =3D client;
>> +	dev_data->ht.client =3D i2c_new_dummy(client->adapter, =
MS8607_H_ADDRESS);
>> +	if (!dev_data->ht.client) {
>> +		dev_err(&client->dev, "%s: new i2c device failed\n", =
__func__);
>> +		return -ENODEV;
>> +	}
>> +	dev_data->tp.res_index =3D 5;
>> +	dev_data->ht.res_index =3D 0;
>> +
>> +	mutex_init(&dev_data->tp.lock);
>> +	mutex_init(&dev_data->ht.lock);
>> +
>> +	indio_dev->info =3D &ms8607_info;
>> +	indio_dev->name =3D id->name;
>> +	indio_dev->dev.parent =3D &client->dev;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->channels =3D ms8607_channels;
>> +	indio_dev->num_channels =3D ARRAY_SIZE(ms8607_channels);
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ret =3D ms_sensors_i2c_reset(client, 0x1E, 3000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ms_sensors_i2c_reset(dev_data->ht.client, 0xFE, 15000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ms_sensors_i2c_read_serial(dev_data->ht.client,
>> +					 &dev_data->ht.serial_number);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ms_sensors_tp_read_prom(&dev_data->tp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(&client->dev, indio_dev);
> Don't use a devm_register if you have anything else in your remove.
> Just use the non devm version. =20
>=20
>> +}
>> +
>> +static int ms8607_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
>> +	struct ms8607_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	i2c_unregister_device(dev_data->ht.client);
>=20
>> +	devm_iio_device_unregister(&client->dev, indio_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id ms8607_id[] =3D {
>> +	{"ms8607", 0},
>> +	{}
>> +};
>> +
>> +static struct i2c_driver ms8607_driver =3D {
>> +	.probe =3D ms8607_probe,
>> +	.remove =3D ms8607_remove,
>> +	.id_table =3D ms8607_id,
>> +	.driver =3D {
>> +		   .name =3D "ms8607",
>> +		   .owner =3D THIS_MODULE,
>> +		   },
>> +};
>> +
>> +module_i2c_driver(ms8607_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Measurement-Specialties ms8607 temperature, =
pressure & humidity driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>> diff --git a/drivers/iio/temperature/Kconfig =
b/drivers/iio/temperature/Kconfig
>> index 21feaa4..d9b30de 100644
>> --- a/drivers/iio/temperature/Kconfig
>> +++ b/drivers/iio/temperature/Kconfig
>> @@ -23,4 +23,34 @@ config TMP006
>> 	  This driver can also be built as a module. If so, the module =
will
>> 	  be called tmp006.
>>=20
>> +config TSYS01
>> +	tristate "Measurement Specialities TSYS01 temperature sensor"
>> +	help
>> +	  If you say yes here you get support for the Measurement =
Specialties
>> +	  TSYS01 temperature sensor.
>> +
>> +	  This driver can also be built as a module. If so, the module =
will
>> +	  be called tsys01.
>> +
>> +config TSYS01_I2C
>> +	tristate "Measurement Specialities TSYS01 support I2C bus =
connection"
>> +	depends on I2C && TSYS01
>> +	select IIO_MS_SENSORS_I2C
>> +	help
>> +	  If you say yes here you build I2C bus for TSYS01.
>> +
>> +	  This driver can also be built as a module. If so, the module =
will
>> +	  be called tsys01_i2c.
>> +
>> +config TSYS02D
>> +	tristate "Measurement Specialities TSYS02D temperature sensor"
>> +	depends on I2C
>> +	select IIO_MS_SENSORS_I2C
>> +	help
>> +	  If you say yes here you get support for the Measurement =
Specialties
>> +	  TSYS02D temperature sensor.
>> +
>> +	  This driver can also be built as a module. If so, the module =
will
>> +	  be called tsys02d.
>> +
>> endmenu
>> diff --git a/drivers/iio/temperature/Makefile =
b/drivers/iio/temperature/Makefile
>> index 40710a8..bcebd17 100644
>> --- a/drivers/iio/temperature/Makefile
>> +++ b/drivers/iio/temperature/Makefile
>> @@ -4,3 +4,6 @@
>>=20
>> obj-$(CONFIG_MLX90614) +=3D mlx90614.o
>> obj-$(CONFIG_TMP006) +=3D tmp006.o
>> +obj-$(CONFIG_TSYS01) +=3D tsys01.o
>> +obj-$(CONFIG_TSYS01_I2C) +=3D tsys01_i2c.o
>> +obj-$(CONFIG_TSYS02D) +=3D tsys02d.o
>> diff --git a/drivers/iio/temperature/tsys01.c =
b/drivers/iio/temperature/tsys01.c
>> new file mode 100644
>> index 0000000..6788c23
>> --- /dev/null
>> +++ b/drivers/iio/temperature/tsys01.c
>> @@ -0,0 +1,191 @@
>> +/*
>> + * tsys01.c - Support for Measurement-Specialties tsys01 temperature =
sensor
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + * Datasheet:
>> + *  =
http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
>> + *
>> + */
>> +
>> +#include "tsys01.h"
>> +
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/stat.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +/* Multiplication coefficients for temperature computation */
>> +static const int coeff_mul[] =3D { -1500000, 1000000, -2000000,
>> +				 4000000, -2000000 };
>> +
>> +static int tsys01_read_temperature(struct iio_dev *indio_dev,
>> +				   s32 *temperature)
>> +{
>> +	int ret, i;
>> +	u32 adc;
>> +	s64 temp =3D 0;
>> +	struct tsys01_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	mutex_lock(&dev_data->lock);
>> +	ret =3D dev_data->convert_and_read(dev_data->client,
>> +					 TSYS01_CONVERSION_START,
>> +					 TSYS01_ADC_READ, 9000, &adc);
>> +	mutex_unlock(&dev_data->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	adc >>=3D 8;
>> +
>> +	/* Temperature algorithm */
>> +	for (i =3D 4; i > 0; i--) {
>> +		temp +=3D coeff_mul[i] *
>> +			(s64)dev_data->prom[5 - i];
>> +		temp *=3D (s64)adc;
>> +		temp =3D div64_s64(temp, 100000);
>> +	}
>> +	temp *=3D 10;
>> +	temp +=3D coeff_mul[0] * (s64)dev_data->prom[5];
>> +	temp =3D div64_s64(temp, 100000);
>> +
>> +	*temperature =3D temp;
>> +
>> +	return 0;
>> +}
>> +
>> +static int tsys01_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *channel, int =
*val,
>> +			   int *val2, long mask)
>> +{
>> +	int ret;
>> +	s32 temperature;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		switch (channel->type) {
>> +		case IIO_TEMP:	/* in =B0C */
>> +			ret =3D tsys01_read_temperature(indio_dev, =
&temperature);
>> +			if (ret)
>> +				return ret;
>> +			*val =3D temperature / 1000;
>> +			*val2 =3D (temperature % 1000) * 1000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_chan_spec tsys01_channels[] =3D {
>> +	{
>> +		.type =3D IIO_TEMP,
>> +		.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED),
>> +	}
>> +};
>> +
>> +static ssize_t tsys01_show_avail(struct device *dev,
>> +				 struct device_attribute *attr, char =
*buf)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> +	struct tsys01_dev *dev_data =3D iio_priv(indio_dev);
>> +	ssize_t len;
>> +	int i;
>> +	char *ptr =3D buf;
>> +
>> +	for (i =3D 0 ; i < TSYS01_PROM_WORDS_NB ; i++)	{
>> +		len =3D sprintf(ptr, "%x ",
>> +			      dev_data->prom[i]);
>> +		ptr +=3D len;
>> +	}
>> +	len =3D ptr - buf;
>> +	len +=3D sprintf(ptr, "\n");
>> +
>> +	return len;
>> +}
>> +
>> +static IIO_DEVICE_ATTR(in_prom, S_IRUGO,
>> +		       tsys01_show_avail, NULL, TSYS01_ATTR_PROM);
>> +
>> +static struct attribute *tsys01_attributes[] =3D {
>> +	&iio_dev_attr_in_prom.dev_attr.attr,
> Is it useful to userspace to be able to get these?
>=20
> If so we need docs.
Discussed with Measurements Specialties, and will have this removed

>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group tsys01_attribute_group =3D {
>> +	.attrs =3D tsys01_attributes,
>> +};
>> +
>> +static const struct iio_info tsys01_info =3D {
>> +	.read_raw =3D tsys01_read_raw,
>> +	.attrs =3D &tsys01_attribute_group,
>> +	.driver_module =3D THIS_MODULE,
>> +};
>> +
>> +static bool tsys01_crc_valid(u16 *n_prom)
>> +{
>> +	u8 cnt;
>> +	u8 sum =3D 0;
>> +
>> +	for (cnt =3D 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
>> +		sum +=3D ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
>> +
>> +	return (sum =3D=3D 0);
>> +}
>> +
>> +static int tsys01_read_prom(struct iio_dev *indio_dev)
>> +{
>> +	int i, ret;
>> +	struct tsys01_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	for (i =3D 0; i < TSYS01_PROM_WORDS_NB; i++) {
>> +		ret =3D dev_data->read_prom_word(dev_data->client,
>> +					       TSYS01_PROM_READ + (i << =
1),
>> +					       &dev_data->prom[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (!tsys01_crc_valid(dev_data->prom)) {
>> +		dev_err(&indio_dev->dev,
>> +			"prom crc check error\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int tsys01_probe(struct iio_dev *indio_dev, struct device *dev)
>> +{
>> +	int ret;
>> +	struct tsys01_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	mutex_init(&dev_data->lock);
>> +
>> +	indio_dev->info =3D &tsys01_info;
>> +	indio_dev->name =3D dev->driver->name;
>> +	indio_dev->dev.parent =3D dev;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->channels =3D tsys01_channels;
>> +	indio_dev->num_channels =3D ARRAY_SIZE(tsys01_channels);
>> +
>> +	ret =3D dev_data->reset(dev_data->client, TSYS01_RESET, 3000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D tsys01_read_prom(indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +EXPORT_SYMBOL(tsys01_probe);
>> +
>> +MODULE_DESCRIPTION("Measurement-Specialties tsys01 temperature =
driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/temperature/tsys01.h =
b/drivers/iio/temperature/tsys01.h
>> new file mode 100644
>> index 0000000..8dc2bcc
>> --- /dev/null
>> +++ b/drivers/iio/temperature/tsys01.h
>> @@ -0,0 +1,43 @@
>> +/*
>> + * TSYS01 temperature sensor driver
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * This program is free software; you can redistribute it and/or =
modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#ifndef _TSYS01_H
>> +#define _TSYS01_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/mutex.h>
>> +#include <linux/module.h>
>> +
>> +/* TSYS01 Commands */
>> +#define TSYS01_RESET				0x1E
>> +#define TSYS01_CONVERSION_START			0x48
>> +#define TSYS01_ADC_READ				0x00
>> +#define TSYS01_PROM_READ			0xA0
>> +
>> +#define TSYS01_PROM_WORDS_NB			8
>> +#define TSYS01_ATTR_PROM			0
>> +
>> +struct tsys01_dev {
>> +	void *client;
>> +	struct mutex lock; /* lock during conversion */
>> +
>> +	int (*reset)(void *cli, u8 cmd, unsigned int delay);
>> +	int (*convert_and_read)(void *cli, u8 conv, u8 rd,
>> +				unsigned int delay, u32 *adc);
>> +	int (*read_prom_word)(void *cli, int cmd, u16 *word);
>> +
>> +	u16 prom[TSYS01_PROM_WORDS_NB];
>> +};
>> +
>> +int tsys01_probe(struct iio_dev *indio_dev, struct device *dev);
>> +
>> +#endif /* _TSYS01_H */
>> diff --git a/drivers/iio/temperature/tsys01_i2c.c =
b/drivers/iio/temperature/tsys01_i2c.c
>> new file mode 100644
>> index 0000000..9bb8b1e
>> --- /dev/null
>> +++ b/drivers/iio/temperature/tsys01_i2c.c
>> @@ -0,0 +1,67 @@
>> +/*
>> + * TSYS01 Measurement-Specialties temperature sensor (i2c bus)
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + * (7-bit I2C slave address 0x76 or 0x77 depending on CSB bit HW =
configuration)
>> + *
>> + */
>=20
>> +
>> +#include <linux/i2c.h>
>> +
>> +#include "tsys01.h"
>> +#include "../common/ms_sensors/ms_sensors_i2c.h"
>> +
>> +static int tsys01_i2c_probe(struct i2c_client *client,
>> +			    const struct i2c_device_id *id)
>> +{
>> +	struct tsys01_dev *dev_data;
>> +	struct iio_dev *indio_dev;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_WORD_DATA |
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support some transaction\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&client->dev, =
sizeof(*dev_data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	dev_data =3D iio_priv(indio_dev);
>> +	dev_data->client =3D client;
>> +	dev_data->reset =3D ms_sensors_i2c_reset;
>> +	dev_data->read_prom_word =3D ms_sensors_i2c_read_prom_word;
>> +	dev_data->convert_and_read =3D ms_sensors_i2c_convert_and_read;
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	return tsys01_probe(indio_dev, &client->dev);
>> +}
>> +
>> +static const struct i2c_device_id tsys01_id[] =3D {
>> +	{"tsys01", 0},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, tsys01_id);
>> +
>> +static struct i2c_driver tsys01_driver =3D {
>> +	.probe =3D tsys01_i2c_probe,
>> +	.id_table =3D tsys01_id,
>> +	.driver =3D {
>> +		   .name =3D "tsys01",
>> +		   .owner =3D THIS_MODULE,
>> +		   },
>> +};
>> +
>> +module_i2c_driver(tsys01_driver);
> Given how little is here, I'd be tempted to roll this file into
> the tsys01.c file and if necessary (e.g. SPI support at somepoint) =
then
> use #ifdefs to allow for only one bus support to be available.
>=20
>> +
>> +MODULE_DESCRIPTION("Measurement-Specialties tsys01 temperature =
driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/temperature/tsys02d.c =
b/drivers/iio/temperature/tsys02d.c
>> new file mode 100644
>> index 0000000..9e2e807
>> --- /dev/null
>> +++ b/drivers/iio/temperature/tsys02d.c
>> @@ -0,0 +1,206 @@
>> +/*
>> + * tsys02d.c - Support for Measurement-Specialties tsys02d =
temperature sensor
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + * (7-bit I2C slave address 0x40)
>> + *
>> + * Datasheet:
>> + *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
>> + *
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/stat.h>
>> +#include <linux/module.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#include "../common/ms_sensors/ms_sensors_i2c.h"
>> +
>> +#define TSYS02D_RESET				0xFE
>> +
>> +static const int tsys02d_samp_freq[4] =3D { 20, 40, 70, 140 };
>> +/* String copy of the above const for readability purpose */
>> +static const char tsys02d_show_samp_freq[] =3D "20 40 70 140";
>> +
>> +static int tsys02d_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *channel, int =
*val,
>> +			    int *val2, long mask)
>> +{
>> +	int ret;
>> +	s32 temperature;
>> +	struct ms_ht_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		switch (channel->type) {
>> +		case IIO_TEMP:	/* in =B0C */
>> +			ret =3D =
ms_sensors_i2c_ht_read_temperature(dev_data,
>> +								 =
&temperature);
>> +			if (ret)
>> +				return ret;
>> +			*val =3D temperature / 1000;
> In common with Hwmon our temperature units are milli degrees C. Please
> check this is true here.
>> +			*val2 =3D (temperature % 1000) * 1000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val =3D tsys02d_samp_freq[dev_data->res_index];
>> +
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int tsys02d_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int val, int val2, long mask)
>> +{
>> +	struct ms_ht_dev *dev_data =3D iio_priv(indio_dev);
>> +	int i, ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		i =3D ARRAY_SIZE(tsys02d_samp_freq);
>> +		while (i-- > 0)
>> +			if (val =3D=3D tsys02d_samp_freq[i])
>> +				break;
>> +		if (i < 0)
>> +			return -EINVAL;
>> +		mutex_lock(&dev_data->lock);
>> +		dev_data->res_index =3D i;
>> +		ret =3D ms_sensors_i2c_write_resolution(dev_data, i);
>> +		mutex_unlock(&dev_data->lock);
>> +
>> +		return ret;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_chan_spec tsys02d_channels[] =3D {
>> +	{
>> +		.type =3D IIO_TEMP,
>> +		.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all =3D =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	}
>> +};
>> +
>> +static ssize_t tsys02_attr_read(struct device *dev,
>> +				struct device_attribute *attr, char =
*buf)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> +	struct ms_ht_dev *dev_data =3D iio_priv(indio_dev);
>> +	struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +
>> +	switch (this_attr->address) {
> Be cleaner to use two different read functions rather than this =
mashup.
>=20
>> +	case MS_SENSORS_ATTR_SERIAL:
>> +
>> +		return ms_sensors_i2c_show_serial(dev_data, buf);
>> +	case MS_SENSORS_ATTR_BAT:
>> +
>> +		return ms_sensors_i2c_show_battery_low(dev_data, buf);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(tsys02d_show_samp_freq);
>> +static IIO_DEVICE_ATTR(in_serial, S_IRUGO,
>> +		       tsys02_attr_read, NULL,
>> +		       0);
>> +static IIO_DEVICE_ATTR(in_battery_low, S_IRUGO,
>> +		       tsys02_attr_read, NULL,
>> +		       0);
>> +
>> +static struct attribute *tsys02d_attributes[] =3D {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	&iio_dev_attr_in_serial.dev_attr.attr,
> Why 'in'?  It's not a channel.  Just call it serial number.  Is this
> useful to userspace?  Often devices will provide this only as part of =
a
> 'I am here' message to the kernel logs on startup.
>=20
>> +	&iio_dev_attr_in_battery_low.dev_attr.attr,
> Does this correspond to a threshold detector of some type?  If so =
please
> use those interfaces.  Either way needs documenting!
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group tsys02d_attribute_group =3D {
>> +	.attrs =3D tsys02d_attributes,
>> +};
>> +
>> +static const struct iio_info tsys02d_info =3D {
>> +	.read_raw =3D tsys02d_read_raw,
>> +	.write_raw =3D tsys02d_write_raw,
>> +	.attrs =3D &tsys02d_attribute_group,
>> +	.driver_module =3D THIS_MODULE,
>> +};
>> +
>> +int tsys02d_probe(struct i2c_client *client,
>> +		  const struct i2c_device_id *id)
>> +{
>> +	struct ms_ht_dev *dev_data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support some transaction\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&client->dev, =
sizeof(*dev_data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	dev_data =3D iio_priv(indio_dev);
>> +	dev_data->client =3D client;
>> +	dev_data->res_index =3D 0;
>> +	mutex_init(&dev_data->lock);
>> +
>> +	indio_dev->info =3D &tsys02d_info;
>> +	indio_dev->name =3D id->name;
>> +	indio_dev->dev.parent =3D &client->dev;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->channels =3D tsys02d_channels;
>> +	indio_dev->num_channels =3D ARRAY_SIZE(tsys02d_channels);
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ret =3D ms_sensors_i2c_reset(client, TSYS02D_RESET, 15000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ms_sensors_i2c_read_serial(client, =
&dev_data->serial_number);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(&client->dev, indio_dev);
>> +}
>> +
>> +static const struct i2c_device_id tsys02d_id[] =3D {
>> +	{"tsys02d", 0},
>> +	{}
>> +};
>> +
>> +static struct i2c_driver tsys02d_driver =3D {
>> +	.probe =3D tsys02d_probe,
>> +	.id_table =3D tsys02d_id,
>> +	.driver =3D {
>> +		   .name =3D "tsys02d",
>> +		   .owner =3D THIS_MODULE,
>> +		   },
>> +};
>> +
>> +module_i2c_driver(tsys02d_driver);
>> +
>> +MODULE_DESCRIPTION("Measurement-Specialties tsys02d temperature =
driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>> +MODULE_LICENSE("GPL v2");
>>=20
>=20
