Return-Path: <nicola@corna.info>
Mime-Version: 1.0
Date: Sun, 23 Aug 2015 09:50:59 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <8bdb2c60fd1785b1d814277769881f08@rainloop.corna.info>
From: "Nicola Corna" <nicola@corna.info>
Subject: Re: [PATCH 2/3] iio:humidity:si7020: added No Hold read mode
To: "Jonathan Cameron" <jic23@kernel.org>, "Hartmut Knaack"
 <knaack.h@gmx.de>, "Lars-Peter Clausen" <lars@metafoo.de>, "Peter
 Meerwald" <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jdelvare@suse.com
In-Reply-To: <55D88078.5080006@kernel.org>
References: <55D88078.5080006@kernel.org>
 <1440079909-1337-1-git-send-email-nicola@corna.info>
 <1440079909-1337-2-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>

August 22 2015 4:00 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:=0A> =
On 20/08/15 15:11, Nicola Corna wrote:=0A> =0A>> The Si7013/20/21 modules=
 support 2 read modes:=0A>> * Hold mode, where the device stretches the c=
lock until the end of the=0A>> measurement=0A>> * No Hold mode, where the=
 device replies NACK for every I2C call during=0A>> the measurement=0A>> =
Here the No Hold mode is implemented, selectable with the boolean=0A>> pa=
rameter holdmode=3DN. The No Hold mode is less efficient, since it=0A>> r=
equires multiple calls to the device, but it can be used as a fallback if=
=0A>> the clock stretching is not supported.=0A> =0A> Interesting. Strike=
s me as something that should really be handled via the i2c=0A> core (and=
 device tree or similar bindings) rather than inside a driver as=0A> a mo=
dule parameter. Perhaps info provided to the i2c client driver=0A> via a =
check on whether the device supports clock stretching?=0A> =0A=0AReasonab=
le, but we also have to consider that:=0A * it can happen that the device=
 supports clock stretching but it is bugged=0A(like the Raspberry Pi)=0A =
* with the clock stretching the i2c bus is completely locked until the en=
d of=0Athe measurement (which can take up to 22.8 ms), while with the No =
Hold mode the=0Abus is used every 2-6 ms for very short periods (with a i=
2c clock at 100 KHz,=0Aeach call takes 0.1 ms)=0AIn some cases the No Hol=
d mode is preferable, even if the clock stretching is=0Asupported and wor=
king.=0A=0ANicola Corna=0A=0A> I'd like input from Jean on this.=0A> =0A>=
> Signed-off-by: Nicola Corna <nicola@corna.info>=0A>> ---=0A>> I've test=
ed this on a Raspberry Pi 2, where the clock stretching is=0A>> currently=
 bugged.=0A>> drivers/iio/humidity/si7020.c | 55 ++++++++++++++++++++++++=
+++++++++++++------=0A>> 1 file changed, 48 insertions(+), 7 deletions(-)=
=0A>> =0A>> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humi=
dity/si7020.c=0A>> index 62fdbcf..a8bad04 100644=0A>> --- a/drivers/iio/h=
umidity/si7020.c=0A>> +++ b/drivers/iio/humidity/si7020.c=0A>> @@ -2,6 +2=
,7 @@=0A>> * si7020.c - Silicon Labs Si7013/20/21 Relative Humidity and T=
emp Sensors=0A>> * Copyright (c) 2013,2014 Uplogix, Inc.=0A>> * David Bar=
ksdale <dbarksdale@uplogix.com>=0A>> + * Copyright (c) 2015 Nicola Corna =
<nicola@corna.info>=0A>> *=0A>> * This program is free software; you can =
redistribute it and/or modify it=0A>> * under the terms and conditions of=
 the GNU General Public License,=0A>> @@ -30,16 +31,33 @@=0A>> #include <=
linux/module.h>=0A>> #include <linux/slab.h>=0A>> #include <linux/sysfs.h=
>=0A>> +#include <linux/jiffies.h>=0A>> =0A>> #include <linux/iio/iio.h>=
=0A>> #include <linux/iio/sysfs.h>=0A>> =0A>> /* Measure Relative Humidit=
y, Hold Master Mode */=0A>> #define SI7020CMD_RH_HOLD 0xE5=0A>> +/* Measu=
re Relative Humidity, No Hold Master Mode */=0A>> +#define SI7020CMD_RH_N=
O_HOLD 0xF5=0A>> /* Measure Temperature, Hold Master Mode */=0A>> #define=
 SI7020CMD_TEMP_HOLD 0xE3=0A>> +/* Measure Temperature, No Hold Master Mo=
de */=0A>> +#define SI7020CMD_TEMP_NO_HOLD 0xF3=0A>> /* Software Reset */=
=0A>> #define SI7020CMD_RESET 0xFE=0A>> +/* Relative humidity measurement=
 timeout (us) */=0A>> +#define SI7020_RH_TIMEOUT 22800=0A>> +/* Temperatu=
re measurement timeout (us) */=0A>> +#define SI7020_TEMP_TIMEOUT 10800=0A=
>> +/* Minimum delay between retries (No Hold Mode) in us */=0A>> +#defin=
e SI7020_NOHOLD_SLEEP_MIN 2000=0A>> +/* Maximum delay between retries (No=
 Hold Mode) in us */=0A>> +#define SI7020_NOHOLD_SLEEP_MAX 6000=0A>> +=0A=
>> +static bool holdmode =3D 1;=0A>> +module_param(holdmode, bool, 0644);=
=0A>> +MODULE_PARM_DESC(holdmode, "Select whether the measurement has to =
be done with Hold Mode (clock=0A>> stretching) or No Hold Mode (repeated =
calls)");=0A>> =0A>> static int si7020_read_raw(struct iio_dev *indio_dev=
,=0A>> struct iio_chan_spec const *chan, int *val,=0A>> @@ -47,16 +65,39 =
@@ static int si7020_read_raw(struct iio_dev *indio_dev,=0A>> {=0A>> stru=
ct i2c_client **client =3D iio_priv(indio_dev);=0A>> int ret;=0A>> + unsi=
gned char buf[2];=0A>> + unsigned long start;=0A>> =0A>> switch (mask) {=
=0A>> case IIO_CHAN_INFO_RAW:=0A>> - ret =3D i2c_smbus_read_word_data(*cl=
ient,=0A>> - chan->type =3D=3D IIO_TEMP ?=0A>> - SI7020CMD_TEMP_HOLD :=0A=
>> - SI7020CMD_RH_HOLD);=0A>> - if (ret < 0)=0A>> - return ret;=0A>> - *v=
al =3D ret >> 2;=0A>> + if (holdmode) {=0A>> + ret =3D i2c_smbus_read_wor=
d_data(*client,=0A>> + chan->type =3D=3D IIO_TEMP ?=0A>> + SI7020CMD_TEMP=
_HOLD :=0A>> + SI7020CMD_RH_HOLD);=0A>> + if (ret < 0)=0A>> + return ret;=
=0A>> + *val =3D ret >> 2;=0A>> + } else {=0A>> + ret =3D i2c_smbus_write=
_byte(*client,=0A>> + chan->type =3D=3D IIO_TEMP ?=0A>> + SI7020CMD_TEMP_=
NO_HOLD :=0A>> + SI7020CMD_RH_NO_HOLD);=0A>> + if (ret < 0)=0A>> + return=
 ret;=0A>> + start =3D jiffies;=0A>> + while ((ret =3D i2c_master_recv(*c=
lient, buf, 2)) < 0) {=0A>> + if (time_after(jiffies, start +=0A>> + usec=
s_to_jiffies(=0A>> + chan->type =3D=3D IIO_TEMP ?=0A>> + SI7020_TEMP_TIME=
OUT :=0A>> + SI7020_RH_TIMEOUT)))=0A>> + return ret;=0A>> + usleep_range(=
SI7020_NOHOLD_SLEEP_MIN,=0A>> + SI7020_NOHOLD_SLEEP_MAX);=0A>> + }=0A>> +=
 *val =3D ((buf[0] << 8) | buf[1]) >> 2;=0A>> + }=0A>> /*=0A>> * Humidity=
 values can sligthly exceed the 0-100%RH=0A>> * range and should be corre=
cted by software
