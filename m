Return-Path: <bijosh.t@hotmail.com>
Message-ID: <BLU185-W76B271320DD25A1095861D80B90@phx.gbl>
From: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC: "mahfouz.saif.elyazal@gmail.com" <mahfouz.saif.elyazal@gmail.com>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] staging: coding style cleanups for
 staging/iio/light/tsl2583 driver
Date: Sun, 28 Feb 2016 22:42:17 +0530
In-Reply-To: <56D32276.7070705@kernel.org>
References: 
 <BLU437-SMTP46745C0D4BEFE546C5C7A280B90@phx.gbl>,<56D32276.7070705@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan=2C=0A=
=0A=
Thanks for your feed back. There was some typos in the previous commit mess=
ages and corrected them in new version.=0A=
I will modify start of all these comments and resubmit the patch.=0A=
=0A=
Regards=2C=0A=
-Bijosh.=0A=
----------------------------------------=0A=
> Subject: Re: [PATCH v3 1/1] staging: coding style cleanups for staging/ii=
o/light/tsl2583 driver=0A=
> To: bijosh.t@hotmail.com=3B gregkh@linuxfoundation.org=3B knaack.h@gmx.de=
=3B lars@metafoo.de=3B pmeerw@pmeerw.net=0A=
> CC: mahfouz.saif.elyazal@gmail.com=3B devel@driverdev.osuosl.org=3B linux=
-iio@vger.kernel.org=3B linux-kernel@vger.kernel.org=0A=
> From: jic23@kernel.org=0A=
> Date: Sun=2C 28 Feb 2016 16:38:14 +0000=0A=
>=0A=
> On 28/02/16 08:28=2C Bijosh Thykkoottathil wrote:=0A=
>> This patch fixes following coding style warning reported by check patch=
=0A=
>> script=2C in tsl2583 driver:=0A=
>> - Block comments use a trailing */ on a separate line=0A=
>>=0A=
>> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>=0A=
> Hi Bijosh=2C=0A=
>=0A=
> When issuing new revisions of a patch it is best to put a brief=0A=
> summary of what the changes were from the previous version (under the ---=
=0A=
> normally) I haven't even tried to figure out what the difference is betwe=
en the=0A=
> 3 revisions you sent this morning. If you are sending a revision without =
any=0A=
> changes (usually due to a formatting error or similar - please reply to t=
he original=0A=
> thread with a quick notes saying what was wrong and that you are going to=
 send a new=0A=
> version - that way we don't accidentally review the previous version)=0A=
>=0A=
> Also=2C if cleaning up comment style like this=2C please read the style g=
uide as the=0A=
> start of these comments are all wrong as well and should be fixed in the =
same patch.=0A=
>=0A=
> Thanks=2C=0A=
>=0A=
> Jonathan=0A=
>> ---=0A=
>> drivers/staging/iio/light/tsl2583.c | 15 ++++++++++-----=0A=
>> 1 file changed=2C 10 insertions(+)=2C 5 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/l=
ight/tsl2583.c=0A=
>> index 3100d96..9159298 100644=0A=
>> --- a/drivers/staging/iio/light/tsl2583.c=0A=
>> +++ b/drivers/staging/iio/light/tsl2583.c=0A=
>> @@ -241=2C7 +241=2C8 @@ static int taos_get_lux(struct iio_dev *indio_de=
v)=0A=
>> }=0A=
>>=0A=
>> /* clear status=2C really interrupt status (interrupts are off)=2C but=
=0A=
>> - * we use the bit anyway - don't forget 0x80 - this is a command*/=0A=
>> + * we use the bit anyway - don't forget 0x80 - this is a command=0A=
>> + */=0A=
>> ret =3D i2c_smbus_write_byte(chip->client=2C=0A=
>> (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |=0A=
>> TSL258X_CMD_ALS_INT_CLR))=3B=0A=
>> @@ -430=2C7 +431=2C8 @@ static int taos_chip_on(struct iio_dev *indio_de=
v)=0A=
>> chip->als_time_scale =3D (als_time + 25) / 50=3B=0A=
>>=0A=
>> /* TSL258x Specific power-on / adc enable sequence=0A=
>> - * Power on the device 1st. */=0A=
>> + * Power on the device 1st.=0A=
>> + */=0A=
>> utmp =3D TSL258X_CNTL_PWR_ON=3B=0A=
>> ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>> TSL258X_CMD_REG | TSL258X_CNTRL=2C utmp)=3B=0A=
>> @@ -440=2C7 +442=2C8 @@ static int taos_chip_on(struct iio_dev *indio_de=
v)=0A=
>> }=0A=
>>=0A=
>> /* Use the following shadow copy for our delay before enabling ADC.=0A=
>> - * Write all the registers. */=0A=
>> + * Write all the registers.=0A=
>> + */=0A=
>> for (i =3D 0=2C uP =3D chip->taos_config=3B i < TSL258X_REG_MAX=3B i++) =
{=0A=
>> ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>> TSL258X_CMD_REG + i=2C=0A=
>> @@ -454=2C7 +457=2C8 @@ static int taos_chip_on(struct iio_dev *indio_de=
v)=0A=
>>=0A=
>> usleep_range(3000=2C 3500)=3B=0A=
>> /* NOW enable the ADC=0A=
>> - * initialize the desired mode of operation */=0A=
>> + * initialize the desired mode of operation=0A=
>> + */=0A=
>> utmp =3D TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL=3B=0A=
>> ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>> TSL258X_CMD_REG | TSL258X_CNTRL=2C=0A=
>> @@ -696=2C7 +700=2C8 @@ static ssize_t taos_luxtable_show(struct device =
*dev=2C=0A=
>> taos_device_lux[i].ch1)=3B=0A=
>> if (taos_device_lux[i].ratio =3D=3D 0) {=0A=
>> /* We just printed the first "0" entry.=0A=
>> - * Now get rid of the extra "=2C" and break. */=0A=
>> + * Now get rid of the extra "=2C" and break.=0A=
>> + */=0A=
>> offset--=3B=0A=
>> break=3B=0A=
>> }=0A=
>>=0A=
>=0A=
 		 	   		  =
