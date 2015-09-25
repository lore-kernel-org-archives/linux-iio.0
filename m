Return-Path: <ludovic.tancerel@maplehightech.com>
Content-Type: multipart/alternative; boundary="Apple-Mail=_908AFBD0-8B8E-44A3-8401-79A9566083F1"
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH V2 6/6] iio: Add ms8607 meas-spec driver support
From: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
In-Reply-To: <55C63AD1.90004@kernel.org>
Date: Fri, 25 Sep 2015 11:25:50 +0200
Cc: knaack.h@gmx.de,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org,
 William.Markezana@meas-spec.com
Message-Id: <D50518AF-C9FC-43A0-8C08-7A1E5F648988@maplehightech.com>
References: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com> <1438248345-25820-7-git-send-email-ludovic.tancerel@maplehightech.com> <55C63AD1.90004@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_908AFBD0-8B8E-44A3-8401-79A9566083F1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Jonathan,
some quick feedback on one of the comments below.

Please let me know if you disagree.

Regards,
Ludovic


Le 8 ao=FBt 2015 =E0 19:22, Jonathan Cameron <jic23@kernel.org> a =E9crit =
:

> On 30/07/15 10:25, Ludovic Tancerel wrote:
>> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
> Little bits inline.
>=20
> A nice looking patch set.  I was unsure the division made sense =
between the
> core and the drivers, but it seems to work well.
> Will be interesting to see what other parts measurement specialties =
comes out
> with in the future!
>=20
> Jonathan
>> ---
>> Documentation/ABI/testing/sysfs-bus-iio-meas-spec |  1 +
>> drivers/iio/humidity/htu21.c                      | 32 =
++++++++++++++++++++---
>> drivers/iio/pressure/Kconfig                      | 13 +++++++++
>> drivers/iio/pressure/ms5637.c                     |  6 ++++-
>> 4 files changed, 48 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec =
b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>> index 7b09d3a..df70dda6 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>> @@ -12,3 +12,4 @@ Description:
>>                 Enable or disable heater function by writing either
>> 		'1' or '0'.
>>                 Same reading values apply
>> +		This ABI is available for htu21, ms8607
>> diff --git a/drivers/iio/humidity/htu21.c =
b/drivers/iio/humidity/htu21.c
>> index 870b631..4720cbc 100644
>> --- a/drivers/iio/humidity/htu21.c
>> +++ b/drivers/iio/humidity/htu21.c
>> @@ -1,6 +1,7 @@
>> /*
>>  * htu21.c - Support for Measurement-Specialties
>>  *           htu21 temperature & humidity sensor
>> + *	     and humidity part of MS8607 sensor
>>  *
>>  * Copyright (c) 2014 Measurement-Specialties
>>  *
>> @@ -10,6 +11,8 @@
>>  *
>>  * Datasheet:
>>  *  http://www.meas-spec.com/downloads/HTU21D.pdf
>> + * Datasheet:
>> + *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
>>  *
>>  */
>>=20
>> @@ -25,6 +28,11 @@
>>=20
>> #define HTU21_RESET				0xFE
>>=20
>> +enum {
>> +	HTU21,
>> +	MS8607
>> +};
>> +
>> static const int htu21_samp_freq[4] =3D { 20, 40, 70, 120 };
>> /* String copy of the above const for readability purpose */
>> static const char htu21_show_samp_freq[] =3D "20 40 70 120";
>> @@ -107,6 +115,17 @@ static const struct iio_chan_spec =
htu21_channels[] =3D {
>> 	 }
>> };
>>=20
>> +/* Meas Spec recommendation is to not read temperature
> /*
> * Meas
>> + * on this driver part for MS8607
>> + */
>> +static const struct iio_chan_spec ms8607_channels[] =3D {
>> +	{
>> +		.type =3D IIO_HUMIDITYRELATIVE,
>> +		.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all =3D =
BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	 }
>> +};
>> +
>> static ssize_t htu21_show_battery_low(struct device *dev,
>> 				      struct device_attribute *attr, =
char *buf)
>> {
>> @@ -189,8 +208,14 @@ int htu21_probe(struct i2c_client *client,
>> 	indio_dev->name =3D id->name;
>> 	indio_dev->dev.parent =3D &client->dev;
>> 	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> -	indio_dev->channels =3D htu21_channels;
>> -	indio_dev->num_channels =3D ARRAY_SIZE(htu21_channels);
>> +
>> +	if (id->driver_data =3D=3D MS8607) {
>> +		indio_dev->channels =3D ms8607_channels;
>> +		indio_dev->num_channels =3D ARRAY_SIZE(ms8607_channels);
>> +	} else {
>> +		indio_dev->channels =3D htu21_channels;
>> +		indio_dev->num_channels =3D ARRAY_SIZE(htu21_channels);
>> +	}
>>=20
>> 	i2c_set_clientdata(client, indio_dev);
>>=20
>> @@ -207,7 +232,8 @@ int htu21_probe(struct i2c_client *client,
>> }
>>=20
>> static const struct i2c_device_id htu21_id[] =3D {
>> -	{"htu21", 0},
>> +	{"htu21", HTU21},
>> +	{"ms8607-h", MS8607},
> perhaps -humidity for clarity if not already in use out in the field.

h stands for humidity
tp for temperature and pressure.

ms8607-temperaturepressure seems too long to me, so I prefer to keep =
ms8607-tp and keep ms8607-h for consistancy

>> 	{}
>> };
>>=20
>> diff --git a/drivers/iio/pressure/Kconfig =
b/drivers/iio/pressure/Kconfig
>> index 8142cfe..e6a7fd5 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -90,6 +90,19 @@ config MS5637
>> 	  This driver can also be built as a module. If so, the module =
will
>> 	  be called ms5637.
>>=20
>> +config MS8607
>> +	tristate "Measurement Specialties MS8607 pressure, temperature & =
humidity sensor"
>> +	depends on I2C
>> +        select IIO_MS_SENSORS_I2C
>> +        select HTU21
>> +        select MS5637
>> +	help
>> +	  If you say yes here you get support for the Measurement =
Specialties
>> +	  MS8607 pressure, temperature and humidity sensor.
>> +
>> +	  This is based on HTU21 and MS5637 drivers. If built as a =
module,
>> +	  modules to load will be htu21 and ms5637.
>> +
> Don't bother with the separate kconfig entry.  Just make sure the help =
texts for
> the other two make it clear that they also support part of this =
device.
>=20
>> config IIO_ST_PRESS
>> 	tristate "STMicroelectronics pressure sensor Driver"
>> 	depends on (I2C || SPI_MASTER) && SYSFS
>> diff --git a/drivers/iio/pressure/ms5637.c =
b/drivers/iio/pressure/ms5637.c
>> index e2073fd..c185aa0 100644
>> --- a/drivers/iio/pressure/ms5637.c
>> +++ b/drivers/iio/pressure/ms5637.c
>> @@ -1,5 +1,5 @@
>> /*
>> - * ms5637.c - Support for Measurement-Specialties ms5637
>> + * ms5637.c - Support for Measurement-Specialties ms5637 and ms8607
>>  *            pressure & temperature sensor
>>  *
>>  * Copyright (c) 2015 Measurement-Specialties
>> @@ -10,8 +10,11 @@
>>  *
>>  * Datasheet:
>>  *  http://www.meas-spec.com/downloads/MS5637-02BA03.pdf
>> + * Datasheet:
>> + *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
>>  *
>>  */
>> +
>> #include <linux/init.h>
>> #include <linux/device.h>
>> #include <linux/kernel.h>
>> @@ -168,6 +171,7 @@ static int ms5637_probe(struct i2c_client =
*client,
>>=20
>> static const struct i2c_device_id ms5637_id[] =3D {
>> 	{"ms5637", 0},
>> +	{"ms8607-tp", 1},
> Perhaps -temp for extra clarity (or are there devices out there =
already
> using this naming?)
>> 	{}
>> };
>>=20
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_908AFBD0-8B8E-44A3-8401-79A9566083F1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">Jonathan,<div>some quick feedback on one of the =
comments below.</div><div><br></div><div>Please let me know if you =
disagree.</div><div><br></div><div>Regards,</div><div>Ludovic<br><div =
apple-content-edited=3D"true"><br></div>
<br><div><div>Le 8 ao=FBt 2015 =E0 19:22, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>&gt; a =E9crit =
:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On 30/07/15 10:25, Ludovic =
Tancerel wrote:<br><blockquote type=3D"cite">Signed-off-by: Ludovic =
Tancerel &lt;<a =
href=3D"mailto:ludovic.tancerel@maplehightech.com">ludovic.tancerel@mapleh=
ightech.com</a>&gt;<br></blockquote>Little bits inline.<br><br>A nice =
looking patch set. &nbsp;I was unsure the division made sense between =
the<br>core and the drivers, but it seems to work well.<br>Will be =
interesting to see what other parts measurement specialties comes =
out<br>with in the future!<br><br>Jonathan<br><blockquote =
type=3D"cite">---<br>Documentation/ABI/testing/sysfs-bus-iio-meas-spec | =
&nbsp;1 +<br>drivers/iio/humidity/htu21.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 32 =
++++++++++++++++++++---<br>drivers/iio/pressure/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 13 =
+++++++++<br>drivers/iio/pressure/ms5637.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;6 ++++-<br>4 files =
changed, 48 insertions(+), 4 deletions(-)<br><br>diff --git =
a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec =
b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec<br>index =
7b09d3a..df70dda6 100644<br>--- =
a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec<br>+++ =
b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec<br>@@ -12,3 +12,4 @@ =
Description:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Enable or disable heater function =
by writing either<br><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>'1' or =
'0'.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Same reading values apply<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>This ABI =
is available for htu21, ms8607<br>diff --git =
a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c<br>index =
870b631..4720cbc 100644<br>--- a/drivers/iio/humidity/htu21.c<br>+++ =
b/drivers/iio/humidity/htu21.c<br>@@ -1,6 +1,7 @@<br>/*<br>&nbsp;* =
htu21.c - Support for Measurement-Specialties<br>&nbsp;* =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;htu21 =
temperature &amp; humidity sensor<br>+ *<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;and =
humidity part of MS8607 sensor<br>&nbsp;*<br>&nbsp;* Copyright (c) 2014 =
Measurement-Specialties<br>&nbsp;*<br>@@ -10,6 +11,8 =
@@<br>&nbsp;*<br>&nbsp;* Datasheet:<br>&nbsp;* &nbsp;<a =
href=3D"http://www.meas-spec.com/downloads/HTU21D.pdf">http://www.meas-spe=
c.com/downloads/HTU21D.pdf</a><br>+ * Datasheet:<br>+ * &nbsp;<a =
href=3D"http://www.meas-spec.com/downloads/MS8607-02BA01.pdf">http://www.m=
eas-spec.com/downloads/MS8607-02BA01.pdf</a><br>&nbsp;*<br>&nbsp;*/<br><br=
>@@ -25,6 +28,11 @@<br><br>#define HTU21_RESET<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xFE<br><br>+enum {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>HTU21,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MS8607<br>+};<br>+<br>static const int htu21_samp_freq[4] =3D { =
20, 40, 70, 120 };<br>/* String copy of the above const for readability =
purpose */<br>static const char htu21_show_samp_freq[] =3D "20 40 70 =
120";<br>@@ -107,6 +115,17 @@ static const struct iio_chan_spec =
htu21_channels[] =3D {<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>}<br>};<br><br>+/* Meas =
Spec recommendation is to not read temperature<br></blockquote>/*<br>* =
Meas<br><blockquote type=3D"cite">+ * on this driver part for =
MS8607<br>+ */<br>+static const struct iio_chan_spec ms8607_channels[] =3D=
 {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>.type =3D IIO_HUMIDITYRELATIVE,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.info_mask_shared_by_type =3D =
BIT(IIO_CHAN_INFO_PROCESSED),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.info_mask_shared_by_all =3D =
BIT(IIO_CHAN_INFO_SAMP_FREQ),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>}<br>+};<br>+<br>static =
ssize_t htu21_show_battery_low(struct device *dev,<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;struct device_attribute *attr, char *buf)<br>{<br>@@ -189,8 +208,14 @@ =
int htu21_probe(struct i2c_client *client,<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;name =3D id-&gt;name;<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;dev.parent =3D &amp;client-&gt;dev;<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;channels =3D htu21_channels;<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;num_channels =3D =
ARRAY_SIZE(htu21_channels);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (id-&gt;driver_data =3D=3D =
MS8607) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>indio_dev-&gt;channels =3D ms8607_channels;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;num_channels =3D =
ARRAY_SIZE(ms8607_channels);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>} else {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;channels =3D htu21_channels;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;num_channels =3D =
ARRAY_SIZE(htu21_channels);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br><br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>i2c_set_clientdata(client, indio_dev);<br><br>@@ -207,7 +232,8 @@ =
int htu21_probe(struct i2c_client *client,<br>}<br><br>static const =
struct i2c_device_id htu21_id[] =3D {<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>{"htu21", 0},<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>{"htu21", =
HTU21},<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{"ms8607-h", MS8607},<br></blockquote>perhaps -humidity for =
clarity if not already in use out in the =
field.<br></div></blockquote><div><br></div></div><div>h stands for =
humidity</div><div>tp for temperature and =
pressure.</div><div><br></div><div>ms8607-temperaturepressure seems too =
long to me, so I prefer to keep ms8607-tp and keep ms8607-h for =
consistancy</div><div><br><blockquote type=3D"cite"><div =
style=3D"font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;"><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{}<br>};<br><br>diff --git a/drivers/iio/pressure/Kconfig =
b/drivers/iio/pressure/Kconfig<br>index 8142cfe..e6a7fd5 100644<br>--- =
a/drivers/iio/pressure/Kconfig<br>+++ =
b/drivers/iio/pressure/Kconfig<br>@@ -90,6 +90,19 @@ config =
MS5637<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-converted-space">&nbsp;</span>&nbsp;This =
driver can also be built as a module. If so, the module will<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;be called =
ms5637.<br><br>+config MS8607<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>tristate "Measurement Specialties =
MS8607 pressure, temperature &amp; humidity sensor"<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>depends =
on I2C<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;select =
IIO_MS_SENSORS_I2C<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;select =
HTU21<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;select =
MS5637<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>help<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-converted-space">&nbsp;</span>&nbsp;If=
 you say yes here you get support for the Measurement =
Specialties<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;MS8607 pressure, =
temperature and humidity sensor.<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;This is based on =
HTU21 and MS5637 drivers. If built as a module,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;modules to load will =
be htu21 and ms5637.<br>+<br></blockquote>Don't bother with the separate =
kconfig entry. &nbsp;Just make sure the help texts for<br>the other two =
make it clear that they also support part of this =
device.<br><br><blockquote type=3D"cite">config IIO_ST_PRESS<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>tristate =
"STMicroelectronics pressure sensor Driver"<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>depends =
on (I2C || SPI_MASTER) &amp;&amp; SYSFS<br>diff --git =
a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c<br>index =
e2073fd..c185aa0 100644<br>--- a/drivers/iio/pressure/ms5637.c<br>+++ =
b/drivers/iio/pressure/ms5637.c<br>@@ -1,5 +1,5 @@<br>/*<br>- * ms5637.c =
- Support for Measurement-Specialties ms5637<br>+ * ms5637.c - Support =
for Measurement-Specialties ms5637 and ms8607<br>&nbsp;* =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pressure=
 &amp; temperature sensor<br>&nbsp;*<br>&nbsp;* Copyright (c) 2015 =
Measurement-Specialties<br>@@ -10,8 +10,11 @@<br>&nbsp;*<br>&nbsp;* =
Datasheet:<br>&nbsp;* &nbsp;<a =
href=3D"http://www.meas-spec.com/downloads/MS5637-02BA03.pdf">http://www.m=
eas-spec.com/downloads/MS5637-02BA03.pdf</a><br>+ * Datasheet:<br>+ * =
&nbsp;<a =
href=3D"http://www.meas-spec.com/downloads/MS8607-02BA01.pdf">http://www.m=
eas-spec.com/downloads/MS8607-02BA01.pdf</a><br>&nbsp;*<br>&nbsp;*/<br>+<b=
r>#include &lt;linux/init.h&gt;<br>#include =
&lt;linux/device.h&gt;<br>#include &lt;linux/kernel.h&gt;<br>@@ -168,6 =
+171,7 @@ static int ms5637_probe(struct i2c_client =
*client,<br><br>static const struct i2c_device_id ms5637_id[] =3D =
{<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{"ms5637", 0},<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>{"ms8607-tp", =
1},<br></blockquote>Perhaps -temp for extra clarity (or are there =
devices out there already<br>using this naming?)<br><blockquote =
type=3D"cite"><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>{}<br>};<br><br><br></blockquote><br>--<br>To unsubscribe =
from this list: send the line "unsubscribe linux-iio" in<br>the body of =
a message to<span class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a><br=
>More majordomo info at &nbsp;<a =
href=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org=
/majordomo-info.html</a></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_908AFBD0-8B8E-44A3-8401-79A9566083F1--
