Return-Path: <mranostay@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Scale and FS range information (was: Re: [PATCH v3] iio: adc: ti-ads1015: add support for ADS1115 part)
From: Matt Ranostay <mranostay@gmail.com>
In-Reply-To: <CAKi4VALcCPONTWo8zZM2Vqku+-a-pcXQDFe0PWgqtWNiEFbZhQ@mail.gmail.com>
Date: Mon, 16 May 2016 22:58:16 -0700
Cc: Matt Ranostay <matt.ranostay@intel.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 Daniel Baluta <daniel.baluta@intel.com>
Message-Id: <37F51630-B89C-45F3-B0C4-26E7959FB49C@gmail.com>
References: <CAKi4VALcCPONTWo8zZM2Vqku+-a-pcXQDFe0PWgqtWNiEFbZhQ@mail.gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Well if the ADC channels have a .scan_type you can look at the storage size f=
rom userspace. Which I suspect all in the future will have due to hrtimer tr=
igger.

Thanks,

Matt

Sent from my iPhone

> On May 16, 2016, at 17:37, Lucas De Marchi <lucas.de.marchi@gmail.com> wro=
te:
>=20
> Hi Matt,
>=20
> changing the subject to raise a question I remembered now that could
> potentially be a problem in this driver, but isn't.
>=20
>> On Mon, May 16, 2016 at 2:18 AM, Matt Ranostay <matt.ranostay@intel.com> w=
rote:
>> TI ADS1115 is a 16-bit resolution ADC that is register map
>> compatible with the ADS1015 device.
>>=20
>> Cc: daniel.baluta@intel.com
>> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
>> ---
>> Changes from v2:
>> * Add missing ads1115 data rate values
>> * Allow support defining data rates per chip
>>=20
>> drivers/iio/adc/ti-ads1015.c | 124 +++++++++++++++++++++++++++++++++++++-=
-----
>> 1 file changed, 109 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> index 73cbf0b..a835423 100644
>> --- a/drivers/iio/adc/ti-ads1015.c
>> +++ b/drivers/iio/adc/ti-ads1015.c
>> @@ -55,6 +55,11 @@
>> #define ADS1015_DEFAULT_DATA_RATE      4
>> #define ADS1015_DEFAULT_CHAN           0
>>=20
>> +enum {
>> +       ADS1015,
>> +       ADS1115,
>> +};
>> +
>> enum ads1015_channels {
>>        ADS1015_AIN0_AIN1 =3D 0,
>>        ADS1015_AIN0_AIN3,
>> @@ -71,6 +76,10 @@ static const unsigned int ads1015_data_rate[] =3D {
>>        128, 250, 490, 920, 1600, 2400, 3300, 3300
>> };
>>=20
>> +static const unsigned int ads1115_data_rate[] =3D {
>> +       8, 16, 32, 64, 128, 250, 475, 860
>> +};
>> +
>> static const struct {
>>        int scale;
>>        int uscale;
>=20
> I forgot to ask this some time ago. =46rom the documentation for in_voltag=
eY_raw:
>=20
> Description:
>                Raw (unscaled no bias removal etc.) voltage measurement fro=
m
>                channel Y. In special cases where the channel does not
>                correspond to externally available input one of the named
>                versions may be used. The number must always be specified a=
nd
>                unique to allow association with event codes. Units after
>                application of scale and offset are millivolts.
>=20
> So, taking the value and multiplying by scale.uscale gives us the
> value in mV. However the main reason to change the scale is actually
> to get the value you want within the FS range. It seems like IIO has
> no information to export to tell about FS information?
>=20
> In *this* case ADS1015 and ADS1115 do have the same FS, but they could
> be completely different without the user ever knowing.
>=20
>=20
>=20
> Lucas De Marchi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
