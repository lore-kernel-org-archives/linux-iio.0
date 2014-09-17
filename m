Return-Path: <maitysanchayan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1409171028340.27908@pmeerw.net>
References: <cover.1410873422.git.maitysanchayan@gmail.com>
	<0cd6b1bdf146a0c9024a804742078ce77a38e184.1410873422.git.maitysanchayan@gmail.com>
	<alpine.DEB.2.01.1409171028340.27908@pmeerw.net>
Date: Wed, 17 Sep 2014 19:52:25 +0530
Message-ID: <CANkTNWBtFYDFj3q2ZQpOGoc+cTnnWdYjJDB=-GTe40GCwdT7ZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: imx: vf610-adc: Add temperature sensor support
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: shawn.guo@freescale.com, Stefan Agner <stefan@agner.ch>, B38611@freescale.com,
	jic23@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

>> Vybrid ADC module includes a temperature sensor which
>> is connected to channel number 26. This patch adds
>> support for the sensor. The raw value is read and the
>> temperature calculated in degree Celsius which is
>> returned using the IIO_CHAN_INFO_PROCESSED option.
>
> the description is wrong, should be 'milli degree Celsius'

Agreed.

>
> more comments inline
>
>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> ---
>>  drivers/iio/adc/vf610_adc.c |   34 +++++++++++++++++++++++++++++++---
>>  1 file changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
>> index 44799eb5..aa682aa 100644
>> --- a/drivers/iio/adc/vf610_adc.c
>> +++ b/drivers/iio/adc/vf610_adc.c
>> @@ -91,7 +91,7 @@
>>  #define VF610_ADC_CAL                        0x80
>>
>>  /* Other field define */
>> -#define VF610_ADC_ADCHC(x)           ((x) & 0xF)
>> +#define VF610_ADC_ADCHC(x)           ((x) & 0x1F)
>>  #define VF610_ADC_AIEN                       (0x1 << 7)
>>  #define VF610_ADC_CONV_DISABLE               0x1F
>>  #define VF610_ADC_HS_COCO0           0x1
>> @@ -137,7 +137,7 @@ struct vf610_adc {
>>       struct clk *clk;
>>
>>       u32 vref_uv;
>> -     u32 value;
>> +     int value;
>>       struct regulator *vref;
>>       struct vf610_adc_feature adc_feature;
>>
>> @@ -153,6 +153,15 @@ struct vf610_adc {
>>                               BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>>  }
>>
>> +#define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {               \
> there is just one temperature channel, so not indexed
>> +     .type =3D (_chan_type),                                   \
>> +     .indexed =3D 1,                                                   =
\
>> +     .channel =3D (_idx),                                              =
\
>> +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),             =
\
>> +     .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |  \
>> +                             BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>
> no need for SCALE since temperature it is PROCESSED;
> maybe it would be better to expose RAW + offset/scale

I believe it would be a better option to return the processed
temperature value through sysfs for the user. I will remove the
info scale for this.

>
> I don't see how the sampling freq. can be separately controlled for the
> temperature channel

Yes, independent sampling frequency control is not available. Will
purge this as well.

>
>> +}
>> +
>>  static const struct iio_chan_spec vf610_adc_iio_channels[] =3D {
>>       VF610_ADC_CHAN(0, IIO_VOLTAGE),
>>       VF610_ADC_CHAN(1, IIO_VOLTAGE),
>> @@ -170,6 +179,7 @@ static const struct iio_chan_spec vf610_adc_iio_chan=
nels[] =3D {
>>       VF610_ADC_CHAN(13, IIO_VOLTAGE),
>>       VF610_ADC_CHAN(14, IIO_VOLTAGE),
>>       VF610_ADC_CHAN(15, IIO_VOLTAGE),
>> +     VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
>>       /* sentinel */
>>  };
>>
>> @@ -451,6 +461,7 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>>
>>       switch (mask) {
>>       case IIO_CHAN_INFO_RAW:
>> +     case IIO_CHAN_INFO_PROCESSED:
>>               mutex_lock(&indio_dev->mlock);
>>               reinit_completion(&info->completion);
>>
>> @@ -468,7 +479,24 @@ static int vf610_read_raw(struct iio_dev *indio_dev=
,
>>                       return ret;
>>               }
>>
>> -             *val =3D info->value;
>> +             switch (chan->type)     {
>> +             case IIO_VOLTAGE:
>> +                     *val =3D info->value;
>> +                     break;
>> +             case IIO_TEMP:
>> +                     /*
>> +                     * Calculate in degree celsius times 1000
>> +                     * Using sensor slope of 1.84 mV/=C2=B0C and
>> +                     * V at 25=C2=B0C of 696mv
>> +                     */
>> +                     info->value -=3D 864;
>> +                     info->value =3D 25000 - info->value * 1000000 / 18=
40;
>
> why write info->value?
> I'd leave value u32 and only read value here

The temperature sensor in VF61 module has a negative temperature
co-efficient. Using a signed integer allowed me to preserve the sign,
which was required for the correct calculation of temperature. Will
leave info->value at u32 and only do the read as suggested.

>
> *val =3D 25000 - (info->value - 864) * 1000000 / 1840;
>
>> +                     *val =3D info->value;
>> +                     break;
>> +             default:
>
> this should return an error

Ok.

>
>> +                     break;
>> +             }
>> +
>>               mutex_unlock(&indio_dev->mlock);
>>               return IIO_VAL_INT;
>>
>>
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
