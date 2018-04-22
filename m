Return-Path: <SRS0=zKlK=HL=gmail.com=davidjulianveenstra@kernel.org>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com> <22b031a8baafad18c3ba2136f8d43fbb4083c1cf.1524247563.git.davidjulianveenstra@gmail.com> <20180421175521.5592e47a@archlinux>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de, daniel.baluta@nxp.com, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/13] staging: iio: ad2s1200: Improve readability with be16_to_cpup
In-reply-to: <20180421175521.5592e47a@archlinux>
Date: Sun, 22 Apr 2018 16:31:37 +0200
Message-ID: <87muxvmhx2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


On 21, April 2018 18:55, Jonathan Cameron wrote:

> On Fri, 20 Apr 2018 21:30:32 +0200
> David Veenstra <davidjulianveenstra@gmail.com> wrote:
>
>> The manual states that the data is contained in the upper 12 bits
>> of the 16 bits read by spi. The code that extracts these 12 bits
>> is correct for both be and le machines, but this is not clear
>> from a first glance.
>> 
>> To improve readability the relevant expressions are replaced
>> with equivalent expressions that use be16_to_cpup.
>> 
>> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
>> ---
>>  drivers/staging/iio/resolver/ad2s1200.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
>> index 0a5fc9917e32..11ed9c7332e6 100644
>> --- a/drivers/staging/iio/resolver/ad2s1200.c
>> +++ b/drivers/staging/iio/resolver/ad2s1200.c
>> @@ -57,7 +57,7 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>>  {
>>  	struct ad2s1200_state *st = iio_priv(indio_dev);
>>  	int ret = 0;
>> -	s16 vel;
>> +	u16 vel;
>>  
>>  	mutex_lock(&st->lock);
>>  	gpio_set_value(st->sample, 0);
>> @@ -73,14 +73,13 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>>  		return ret;
>>  	}
>>  
>> +	vel = be16_to_cpup((__be16 *)st->rx);
> Well it isn't vel (velocity) in one case so now the name is misleading.
>
> Also that type cast suggests a fairly obvious cleanup associated with this one.
> Why not make st->rx a __be16 in the first pace avoiding the need to cast at all?
>
> Then you could just have *val = be16_to_cpu(st->rx) >> 4 and similar.

Agreed on naming of vel, and type of st-rx. I'll change this for v3.

Best regards,
David Veenstra

>
>>  	switch (chan->type) {
>>  	case IIO_ANGL:
>> -		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>> +		*val = vel >> 4;
>>  		break;
>>  	case IIO_ANGL_VEL:
>> -		vel = (((s16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>> -		vel = sign_extend32(vel, 11);
>> -		*val = vel;
>> +		*val = sign_extend32((s16)vel >> 4, 11);
> If you were to use an intermediate that was s16 then the sign extend would
> be automatic.  Perhaps it is clear to do it like this though.. 
> Up to you.
>
>>  		break;
>>  	default:
>>  		mutex_unlock(&st->lock);
