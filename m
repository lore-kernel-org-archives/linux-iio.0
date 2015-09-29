Return-Path: <ludovic.tancerel@maplehightech.com>
Content-Type: multipart/alternative; boundary="Apple-Mail=_6A0DEE29-E93F-4327-BA8B-418CAEB98862"
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 1/6] Add meas-spec sensors common part
From: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
In-Reply-To: <560817E4.60003@kernel.org>
Date: Tue, 29 Sep 2015 09:59:48 +0200
Cc: knaack.h@gmx.de,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org,
 William.Markezana@meas-spec.com
Message-Id: <B38C52D7-9503-4273-A742-A2BB88D72229@maplehightech.com>
References: <1443189405-18516-1-git-send-email-ludovic.tancerel@maplehightech.com> <1443189405-18516-2-git-send-email-ludovic.tancerel@maplehightech.com> <560817E4.60003@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_6A0DEE29-E93F-4327-BA8B-418CAEB98862
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello Jonathan, all,
thank you for reviewing

for once, I will reply shortly.
Hopefully, the message will go through the mail server.

Please have a look at comments below,
Regards,
Ludovic


Le 27 sept. 2015 =E0 18:23, Jonathan Cameron <jic23@kernel.org> a =E9crit =
:

> On 25/09/15 14:56, Ludovic Tancerel wrote:
>> Measurement specialties drivers common part.
>> These functions are used by further drivers in the patchset: TSYS01, =
TSYS02D, HTU21, MS5637, MS8607
>>=20
>> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
> A few more bits and bobs inline.
>> ---
>> drivers/iio/common/Kconfig                     |   1 +
>> drivers/iio/common/Makefile                    |   1 +
>> drivers/iio/common/ms_sensors/Kconfig          |   6 +
>> drivers/iio/common/ms_sensors/Makefile         |   5 +
>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 645 =
+++++++++++++++++++++++++
>> drivers/iio/common/ms_sensors/ms_sensors_i2c.h |  53 ++
>> 6 files changed, 711 insertions(+)
>> create mode 100644 drivers/iio/common/ms_sensors/Kconfig
>> create mode 100644 drivers/iio/common/ms_sensors/Makefile
>> create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>> create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>>=20
>> diff =97git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
=85
>>=20
>> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>> new file mode 100644
>> index 0000000..4b1bc31
>> --- /dev/null
>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>> @@ -0,0 +1,645 @@
>> +/*
>> + * Measurements Specialties driver common i2c functions
>> + *
>> + * Copyright (c) 2015 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
> Drop this blank line.
OK
>> + *
>> + */
>> +
=85
>> +
>> +/**
>> + * ms_sensors_i2c_read_prom_word() - i2c prom word read function
>> + * @cli:	pointer to i2c client
>> + * @cmd:	PROM read cmd. Depends on device and prom id
>> + * @word:	pointer to word destination value
>> + *
>> + * Generic i2c prom word read function for Measurement Specialties =
devices.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
>> +int ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 *word)
>> +{
>> +	int ret;
>> +	struct i2c_client *client =3D (struct i2c_client *)cli;
> Why pass an void * given the function name says this will always be an =
i2c_client?
>=20
> Once that's removed this wrapper does very little and I'd be tempted =
to
> drop it in favour of direct calls to the smbus read.

The void * is because this function might be used for the same chipset =
using SPI access (that is not supported yet).
I am passing the void *, to have common parameters for the future spi =
function.
This is the same for previous function ms_sensors_i2c_reset.

That references functions written for tsys01 written in patch v2/6 :
"
	dev_data->client =3D client;
	dev_data->reset =3D ms_sensors_i2c_reset;
	dev_data->read_prom_word =3D ms_sensors_i2c_read_prom_word;
	dev_data->convert_and_read =3D ms_sensors_i2c_convert_and_read;
"
The same could be done but using a spi function. Isn=92t that the =
appropriate approach ?
This is what I understood when looking at other drivers.

These functions are also used in different drivers, so if I drop t he =
wrapper, I cannot reuse the function for TSYS01.

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
>> +/**
>> + * ms_sensors_i2c_convert_and_read() - i2c ADC conversion & read =
function
>> + * @cli:	pointer to i2c client
>> + * @conv:	ADC conversion command. Depends on device in use
>> + * @rd:		ADC read command. Depends on device in use
>> + * @delay:	usleep minimal delay after conversion command is issued
>> + * @adc:	pointer to ADC destination value
>> + *
>> + * Generic i2c ADC conversion & read function for Measurement =
Specialties
>> + * devices.
>> + * The function will issue conversion command, sleep appopriate =
delay, and
>> + * issue command to read ADC.
>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
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
>> +	dev_dbg(&client->dev, "ADC raw value : %x\n", be32_to_cpu(buf) =
>> 8);
>> +	*adc =3D be32_to_cpu(buf) >> 8;
>> +
>> +	return 0;
>> +err:
>> +	dev_err(&client->dev, "Unable to make sensor adc conversion\n");
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(ms_sensors_i2c_convert_and_read);
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
> Can this be done with the standard kernel crc32 functions? (not dug =
into
> it enough to be sure!)

I don=92t think so.
CRC computation here is truly a 16-bits CRC check.
I have looked at crc16 lib but this a different polynomial used.

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
>> + * ms_sensors_i2c_read_serial() - i2c serial number read function
>> + * @cli:	pointer to i2c client
>> + * @sn:		pointer to 64-bits destination value
>> + *
>> + * Generic i2c serial number read function for Measurement =
Specialties devices.
>> + * This function is used for TSYS02d, HTU21, MS8607 chipset.
>> + * Refer to datasheet:
>> + *	=
http://www.meas-spec.com/downloads/HTU2X_Serial_Number_Reading.pdf
> THat's a first.  A whole datasheet on how the heck the serial number =
works!
>=20
> Got to wonder how anyone ever came up with that.  I'm going to =
conclude
> you got it right and not read any more ;)

Please read below.
If you read the spec, you will understand why there is one,
the Serial Number shape is really far fetched =85 :)

>> + *
>> + * Return: 0 on success, negative errno otherwise.
>> + */
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
> Umm. I'm really unclear what you are doing here.  You read into
> a 64 bit buffer, then do a hand endian swap and shift?  Should be =
possible
> to at least use standard functions to swap the byte order.

There are several 8bits CRC interlaced in the bytes read containing =
serial number.
So the "for (i =3D 0; i < 64; i +=3D 16)" is to check the different CRCs

The =AB *sn =3D =85 =BB is meant to regroup the bytes in between CRC =
words and retrieve the 32bits first portion of the serial number.
The shape is [ SNB 3 , CRC, SNB 2, CRC, SNB 1, CRC, SNB 0, CRC ]
I considered unifying both in the loop but this is not simpler

The second portion of serial number is read afterwards.

I agree this is overly complex for getting a serial number,
but this is how it is implemented in the sensor, and it is a wish from =
measurement specialties to read it at sensor init.

If you feel I should extract the SN bytes in a different way on the code =
below, let me know.
I can put it into a macro to improve readability ?

>=20
>> +	*sn =3D (((rcv_buf >> 32) & 0xFF000000) |
>> +	       ((rcv_buf >> 24) & 0x00FF0000) |
>> +	       ((rcv_buf >> 16) & 0x0000FF00) |
>> +	       ((rcv_buf >> 8) & 0x000000FF)) << 16;
>> +
>>=20
=85

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
> This local variable seens rather unnecessary. Just put it inline in =
the
> calls.

OK

>> +	delay =3D ms_sensors_tp_conversion_time[dev_data->res_index];
>> +
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
>> +
>> +=09

=85

>> +
>> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>> new file mode 100644
>> index 0000000..918b8af
>> --- /dev/null
>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>> @@ -0,0 +1,53 @@
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
>> +struct ms_ht_dev {
>> +	struct i2c_client *client;
>> +	struct mutex lock; /* mutex protecting data structure */
>> +	u8 res_index;
>> +};
>> +
> kernel doc comments preferred.

OK
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
> The presence or absense of _i2c in the function naming does feel =
rather
> random.  All of these functions ultimately make i2c calls so perhaps =
you
> can explain your reasoning behind having it in some and not others.

The functions used were meant to have _i2c when there is no direct calls =
to  smbus functions.
I agree that is rather awkward, I will change and put i2c everywhere.

>=20
>> +
>> +#endif /* _MS_SENSORS_I2C_H */
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_6A0DEE29-E93F-4327-BA8B-418CAEB98862
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Hello =
Jonathan, all,<div>thank you for reviewing<br><div><br></div><div>for =
once, I will reply shortly.</div><div>Hopefully, the message will go =
through the mail server.</div><div><br></div><div>Please have a look at =
comments =
below,</div><div>Regards,</div><div>Ludovic</div><div><br></div><div>
<br><div><div>Le 27 sept. 2015 =E0 18:23, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>&gt; a =E9crit =
:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On 25/09/15 14:56, Ludovic =
Tancerel wrote:<br><blockquote type=3D"cite">Measurement specialties =
drivers common part.<br>These functions are used by further drivers in =
the patchset: TSYS01, TSYS02D, HTU21, MS5637, =
MS8607<br><br>Signed-off-by: Ludovic Tancerel &lt;<a =
href=3D"mailto:ludovic.tancerel@maplehightech.com">ludovic.tancerel@mapleh=
ightech.com</a>&gt;<br></blockquote>A few more bits and bobs =
inline.<br><blockquote type=3D"cite">---<br>drivers/iio/common/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>drivers/iio/common/Makefile =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>drivers/iio/common/ms_sensors/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;6 =
+<br>drivers/iio/common/ms_sensors/Makefile =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;5 =
+<br>drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 645 =
+++++++++++++++++++++++++<br>drivers/iio/common/ms_sensors/ms_sensors_i2c.=
h | &nbsp;53 ++<br>6 files changed, 711 insertions(+)<br>create mode =
100644 drivers/iio/common/ms_sensors/Kconfig<br>create mode 100644 =
drivers/iio/common/ms_sensors/Makefile<br>create mode 100644 =
drivers/iio/common/ms_sensors/ms_sensors_i2c.c<br>create mode 100644 =
drivers/iio/common/ms_sensors/ms_sensors_i2c.h<br><br>diff =97git =
a/drivers/iio/common/Kconfig =
b/drivers/iio/common/Kconfig<br></blockquote></div></blockquote>=85<br><bl=
ockquote type=3D"cite"><div style=3D"font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"><blockquote =
type=3D"cite"><br>diff --git =
a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c<br>new file mode =
100644<br>index 0000000..4b1bc31<br>--- /dev/null<br>+++ =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c<br>@@ -0,0 +1,645 =
@@<br>+/*<br>+ * Measurements Specialties driver common i2c =
functions<br>+ *<br>+ * Copyright (c) 2015 Measurement-Specialties<br>+ =
*<br>+ * Licensed under the GPL-2.<br></blockquote>Drop this blank =
line.<br></div></blockquote>OK<br><blockquote type=3D"cite"><div =
style=3D"font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;"><blockquote type=3D"cite">+ *<br>+ =
*/<br>+<br></blockquote></div></blockquote>=85<br><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><blockquote =
type=3D"cite">+<br>+/**<br>+ * ms_sensors_i2c_read_prom_word() - i2c =
prom word read function<br>+ * @cli:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pointer to i2c client<br>+ * =
@cmd:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>PROM read cmd. Depends on device and prom id<br>+ * @word:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to word destination value<br>+ *<br>+ * Generic i2c prom word read =
function for Measurement Specialties devices.<br>+ *<br>+ * Return: 0 on =
success, negative errno otherwise.<br>+ */<br>+int =
ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 =
*word)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct i2c_client *client =3D =
(struct i2c_client *)cli;<br></blockquote>Why pass an void * given the =
function name says this will always be an i2c_client?<br><br>Once that's =
removed this wrapper does very little and I'd be tempted to<br>drop it =
in favour of direct calls to the smbus =
read.<br></div></blockquote><div><br></div>The void * is because this =
function might be used for the same chipset using SPI access (that is =
not supported yet).</div><div>I am passing the void *, to have common =
parameters for the future spi function.</div><div>This is the same for =
previous function ms_sensors_i2c_reset.</div><div><br></div><div>That =
references functions written for tsys01 written in patch v2/6 =
:</div><div>"</div><div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>dev_data-&gt;client =3D =
client;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>dev_data-&gt;reset =3D =
ms_sensors_i2c_reset;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>dev_data-&gt;read_prom_word =3D =
ms_sensors_i2c_read_prom_word;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>dev_data-&gt;convert_and_read =3D =
ms_sensors_i2c_convert_and_read;</div><div>"</div></div><div>The same =
could be done but using a spi function. Isn=92t that the appropriate =
approach ?</div><div><div>This is what I understood when looking at =
other drivers.</div><div><br></div><div>These functions are also used in =
different drivers, so if I drop t he wrapper, I cannot reuse the =
function for TSYS01.</div><div><br></div></div><div><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><blockquote =
type=3D"cite">+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D i2c_smbus_read_word_swapped(client, =
cmd);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (ret &lt; 0) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_err(&amp;client-&gt;dev, =
"Failed to read prom word\n");<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>*word =3D ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return =
0;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_i2c_read_prom_word);<br>+<br>+/**<br=
>+ * ms_sensors_i2c_convert_and_read() - i2c ADC conversion &amp; read =
function<br>+ * @cli:<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>pointer to i2c client<br>+ * @conv:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ADC =
conversion command. Depends on device in use<br>+ * @rd:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ADC read =
command. Depends on device in use<br>+ * @delay:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>usleep =
minimal delay after conversion command is issued<br>+ * @adc:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pointer =
to ADC destination value<br>+ *<br>+ * Generic i2c ADC conversion &amp; =
read function for Measurement Specialties<br>+ * devices.<br>+ * The =
function will issue conversion command, sleep appopriate delay, and<br>+ =
* issue command to read ADC.<br>+ *<br>+ * Return: 0 on success, =
negative errno otherwise.<br>+ */<br>+int =
ms_sensors_i2c_convert_and_read(void *cli, u8 conv, u8 rd,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;unsigned =
int delay, u32 *adc)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u32 buf =3D=
 0;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct i2c_client *client =3D (struct i2c_client =
*)cli;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Trigger conversion */<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>ret =3D =
i2c_smbus_write_byte(client, conv);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>goto =
err;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>usleep_range(delay, delay + 1000);<br>+<br>+<span =
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
ret;<br>+}<br>+EXPORT_SYMBOL(ms_sensors_i2c_convert_and_read);<br>+<br>+/*=
*<br>+ * ms_sensors_crc_valid() - CRC check function<br>+ * @value:<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>input and =
CRC compare value<br>+ *<br>+ * Cyclic Redundancy Check function used in =
TSYS02D, HTU21, MS8607.<br>+ * This function performs a x^8 + x^5 + x^4 =
+ 1 polynomial CRC.<br>+ * The argument contains CRC value in LSB byte =
while the bytes 1 and 2<br>+ * are used for CRC computation.<br>+ *<br>+ =
* Return: 1 if CRC is valid, 0 otherwise.<br></blockquote>Can this be =
done with the standard kernel crc32 functions? (not dug into<br>it =
enough to be sure!)<br></div></blockquote><div><br></div>I don=92t think =
so.</div><div>CRC computation here is truly a 16-bits CRC =
check.</div><div>I have looked at crc16 lib but this a different =
polynomial used.</div><div><br><blockquote type=3D"cite"><div =
style=3D"font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;"><blockquote type=3D"cite">+ =
*/<br>+static bool ms_sensors_crc_valid(u32 value)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u32 =
polynom =3D 0x988000;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* x^8 + x^5 + x^4 + 1 */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u32 msb =3D=
 0x800000;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>u32 mask =3D 0xFF8000;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u32 result =3D value &amp; =
0xFFFF00;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>u8 crc =3D value &amp; 0xFF;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>while =
(msb !=3D 0x80) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (result &amp; msb)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>result =3D ((result ^ polynom) =
&amp; mask)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>| (result &amp; ~mask);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>msb &gt;&gt;=3D 1;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>mask =
&gt;&gt;=3D 1;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>polynom &gt;&gt;=3D 1;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
result =3D=3D crc;<br>+}<br>+<br>+/**<br>+ * =
ms_sensors_i2c_read_serial() - i2c serial number read function<br>+ * =
@cli:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pointer to i2c client<br>+ * @sn:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pointer to 64-bits destination =
value<br>+ *<br>+ * Generic i2c serial number read function for =
Measurement Specialties devices.<br>+ * This function is used for =
TSYS02d, HTU21, MS8607 chipset.<br>+ * Refer to datasheet:<br>+ *<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><a =
href=3D"http://www.meas-spec.com/downloads/HTU2X_Serial_Number_Reading.pdf=
">http://www.meas-spec.com/downloads/HTU2X_Serial_Number_Reading.pdf</a><b=
r></blockquote>THat's a first. &nbsp;A whole datasheet on how the heck =
the serial number works!<br><br>Got to wonder how anyone ever came up =
with that. &nbsp;I'm going to conclude<br>you got it right and not read =
any more ;)<br></div></blockquote><div><br></div>Please read =
below.</div><div>If you read the spec, you will understand why there is =
one,</div><div>the Serial Number shape is really far fetched =85 =
:)</div><div><br><blockquote type=3D"cite"><div style=3D"font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;"><blockquote type=3D"cite">+ *<br>+ * Return: 0 on success, =
negative errno otherwise.<br>+ */<br>+int =
ms_sensors_i2c_read_serial(struct i2c_client *client, u64 =
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
</span>}<br>+<br></blockquote>Umm. I'm really unclear what you are doing =
here. &nbsp;You read into<br>a 64 bit buffer, then do a hand endian swap =
and shift? &nbsp;Should be possible<br>to at least use standard =
functions to swap the byte =
order.<br></div></blockquote><div><br></div></div><div>There are several =
8bits CRC interlaced in the bytes read containing serial =
number.</div><div>So the "for (i =3D 0; i &lt; 64; i +=3D 16)" is to =
check the different CRCs</div><div><br></div><div>The =AB&nbsp;*sn =3D =
=85&nbsp;=BB is meant to regroup the bytes in between CRC words and =
retrieve the 32bits first portion of the serial number.</div><div>The =
shape is [ SNB 3 , CRC,&nbsp;SNB&nbsp;2, CRC,&nbsp;SNB&nbsp;1, =
CRC,&nbsp;SNB&nbsp;0, CRC ]</div><div><div>I considered unifying both in =
the loop but this is not simpler</div></div><div><div><br></div><div>The =
second portion of serial number is read =
afterwards.</div><div><br></div></div><div>I agree this is overly =
complex for getting a serial number,</div><div>but this is how it is =
implemented in the sensor, and it is a wish from measurement specialties =
to read it at sensor init.</div><div><br></div><div>If you feel I should =
extract the SN bytes in a different way on the code below, let me =
know.</div><div>I can put it into a macro to improve readability =
?</div><div><br><blockquote type=3D"cite"><div style=3D"font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;"><br><blockquote type=3D"cite">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>*sn =3D (((rcv_buf &gt;&gt; 32) =
&amp; 0xFF000000) |<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;((rcv_buf &gt;&gt; 24) &amp; 0x00FF0000) |<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;((rcv_buf &gt;&gt; 16) &amp; 0x0000FF00) |<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;((rcv_buf &gt;&gt; 8) &amp; 0x000000FF)) &lt;&lt; =
16;<br>+<br><br></blockquote></div></blockquote>=85</div><div><br><blockqu=
ote type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><blockquote type=3D"cite">+int =
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
</span>u16 *prom =3D dev_data-&gt;prom, delay;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u8 =
i;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>i =3D =
dev_data-&gt;res_index * 2;<br></blockquote>This local variable seens =
rather unnecessary. Just put it inline in =
the<br>calls.<br></div></blockquote><div><br></div>OK</div><div><br><block=
quote type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><blockquote type=3D"cite">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>delay =3D =
ms_sensors_tp_conversion_time[dev_data-&gt;res_index];<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms_sensors_i2c_convert_and_read(<br>+<span class=3D"Apple-tab-span" =
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
</span>MS_SENSORS_TP_T_CONVERSION_START + i,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MS_SENSORS_TP_ADC_READ,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>delay, &amp;t_adc);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	=
</span><br></blockquote></div></blockquote><div><br></div>=85</div><div><b=
r><blockquote type=3D"cite"><div style=3D"font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"><blockquote =
type=3D"cite">+<br>diff --git =
a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h<br>new file mode =
100644<br>index 0000000..918b8af<br>--- /dev/null<br>+++ =
b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h<br>@@ -0,0 +1,53 =
@@<br>+/*<br>+ * Measurements Specialties common sensor driver<br>+ =
*<br>+ * Copyright (c) 2015 Measurement-Specialties<br>+ *<br>+ * This =
program is free software; you can redistribute it and/or modify<br>+ * =
it under the terms of the GNU General Public License version 2 as<br>+ * =
published by the Free Software Foundation.<br>+ */<br>+<br>+#ifndef =
_MS_SENSORS_I2C_H<br>+#define _MS_SENSORS_I2C_H<br>+<br>+#include =
&lt;linux/i2c.h&gt;<br>+#include &lt;linux/mutex.h&gt;<br>+<br>+#define =
MS_SENSORS_TP_PROM_WORDS_NB<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>7<br>+<br>+struct ms_ht_dev =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct i2c_client *client;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct mutex lock; /* mutex =
protecting data structure */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u8 =
res_index;<br>+};<br>+<br></blockquote>kernel doc comments =
preferred.<br></div></blockquote><div><br></div>OK<br><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><blockquote type=3D"cite">+struct =
ms_tp_dev {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>struct i2c_client *client;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
mutex lock; /* mutex protecting data structure */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* Added =
element for CRC computation */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u16 =
prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u8 res_index;<br>+};<br>+<br>+int =
ms_sensors_i2c_reset(void *cli, u8 cmd, unsigned int delay);<br>+int =
ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 *word);<br>+int =
ms_sensors_i2c_convert_and_read(void *cli, u8 conv, u8 rd,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;unsigned =
int delay, u32 *adc);<br>+int ms_sensors_i2c_read_serial(struct =
i2c_client *client, u64 *sn);<br>+ssize_t =
ms_sensors_i2c_show_serial(struct ms_ht_dev *dev_data, char =
*buf);<br>+ssize_t ms_sensors_i2c_write_resolution(struct ms_ht_dev =
*dev_data, u8 i);<br>+ssize_t ms_sensors_i2c_show_battery_low(struct =
ms_ht_dev *dev_data, char *buf);<br>+ssize_t =
ms_sensors_i2c_show_heater(struct ms_ht_dev *dev_data, char =
*buf);<br>+ssize_t ms_sensors_i2c_write_heater(struct ms_ht_dev =
*dev_data,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;const =
char *buf, size_t len);<br>+int =
ms_sensors_i2c_ht_read_temperature(struct ms_ht_dev *dev_data,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;s32 *temperature);<br>+int ms_sensors_i2c_ht_read_humidity(struct =
ms_ht_dev *dev_data,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;u32 =
*humidity);<br>+int ms_sensors_tp_read_prom(struct ms_tp_dev =
*dev_data);<br>+int ms_sensors_read_temp_and_pressure(struct ms_tp_dev =
*dev_data,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;int *temperature,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;unsigned int *pressure);<br></blockquote>The presence or absense of =
_i2c in the function naming does feel rather<br>random. &nbsp;All of =
these functions ultimately make i2c calls so perhaps you<br>can explain =
your reasoning behind having it in some and not =
others.<br></div></blockquote><div><br></div><div>The functions used =
were meant to have _i2c when there is no direct calls to &nbsp;smbus =
functions.</div><div>I agree that is rather awkward, I will change and =
put i2c everywhere.</div><br><blockquote type=3D"cite"><div =
style=3D"font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;"><br><blockquote =
type=3D"cite">+<br>+#endif /* _MS_SENSORS_I2C_H =
*/<br><br></blockquote><br>--<br>To unsubscribe from this list: send the =
line "unsubscribe linux-iio" in<br>the body of a message to<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a><br=
>More majordomo info at &nbsp;<a =
href=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org=
/majordomo-info.html</a></div></blockquote></div><br></div></div></body></=
html>=

--Apple-Mail=_6A0DEE29-E93F-4327-BA8B-418CAEB98862--
