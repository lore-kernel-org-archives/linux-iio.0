Return-Path: <SRS0=zKlK=HL=gmail.com=davidjulianveenstra@kernel.org>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com> <752211cc5dd962e9588263d9d3591d2f4d386c26.1524247563.git.davidjulianveenstra@gmail.com> <20180421180704.2b5b183b@archlinux>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de, daniel.baluta@nxp.com, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 10/13] staging: iio: ad2s1200: Add scaling factor for angular velocity channel
In-reply-to: <20180421180704.2b5b183b@archlinux>
Date: Sun, 22 Apr 2018 16:37:59 +0200
Message-ID: <87k1szmhmg.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


On 21, April 2018 19:07, Jonathan Cameron wrote:

> On Fri, 20 Apr 2018 21:31:09 +0200
> David Veenstra <davidjulianveenstra@gmail.com> wrote:
>
>> The sysfs iio ABI states radians per second is expected as the unit for
>> angular velocity, but the 12-bit angular velocity register has rps
>> as its unit. So a fractional scaling factor of approximately 2 * Pi is
>> added to the angular velocity channel.
>> 
>> The added comments will also be relevant for the scaling factor of
>> the angle channel.
>> 
>> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
> Comment inline.  The function you are talking about isn't used
> in the majority of likely use cases for this part.  The maths will actually
> be done in userspace (which can use floating point).
>
> Thanks,
>
> Jonathan
>
>> ---
>> Changes in v2:
>>   - Move explanation of Pi approximation to top of switch statement,
>>     as this will also be relevant to angle channel.
>>   - Replaced 33102 / 2 with 16551 on line 84.
>> 
>>  drivers/staging/iio/resolver/ad2s1200.c | 84 +++++++++++++++++++++++----------
>>  1 file changed, 59 insertions(+), 25 deletions(-)
>> 
>> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
>> index 29a9bb666e7b..6c56257be3b1 100644
>> --- a/drivers/staging/iio/resolver/ad2s1200.c
>> +++ b/drivers/staging/iio/resolver/ad2s1200.c
>> @@ -60,38 +60,71 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>>  	int ret = 0;
>>  	u16 vel;
>>  
>> -	mutex_lock(&st->lock);
>> -	gpiod_set_value(st->sample, 0);
>> +	/*
>> +	 * Below a fractional approximation of Pi is needed.
>> +	 * The following approximation will be used: 103993 / 33102.
>> +	 * This is accurate in 9 decimals places.
>> +	 *
>> +	 * This fraction is based on OEIS series of nominator/denominator
>> +	 * of convergents to Pi (A002485 and A002486).
>> +	 */
>> +	switch (m) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_ANGL_VEL:
>> +			/*
>> +			 * 2 * Pi ~= 2 * 103993 / 33102
>> +			 *
>> +			 * iio_convert_raw_to_processed uses integer
>> +			 * division. This will cause at most 5% error
>> +			 * (for very small values). But for 99.5% of the values
>> +			 * it will cause less that 1% error.
> This is an interesting comment, but relies on anyone actually
> using iio_convert_raw_to_processed with this device.
>
> I would imagine that 'in kernel' users of a resolver (who would use
> that function) will be few and far between.  Mostly this will just
> get passed to userspace.  That involves this being converted to
> a decimal.  I would just specify it as one in the first place.

Hmm, I didn't realize that it might never be used in kernel. A
decimal representation is indeed a lot more clear. I'll change
scale value type to IIO_VAL_INT_PLUS_MICRO for both the angular
velocity and angel channel.

Best regards,
David Veenstra

>
>> +			 */
>> +			*val = 103993;
>> +			*val2 = 16551;
>> +			return IIO_VAL_FRACTIONAL;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&st->lock);
>> +		gpiod_set_value(st->sample, 0);
>> +
>> +		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
>> +		udelay(1);
>> +		gpiod_set_value(st->sample, 1);
>> +		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
>> +
>> +		ret = spi_read(st->sdev, st->rx, 2);
>> +		if (ret < 0) {
>> +			mutex_unlock(&st->lock);
>> +			return ret;
>> +		}
>>  
>> -	/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
>> -	udelay(1);
>> -	gpiod_set_value(st->sample, 1);
>> -	gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
>> +		vel = be16_to_cpup((__be16 *)st->rx);
>> +		switch (chan->type) {
>> +		case IIO_ANGL:
>> +			*val = vel >> 4;
>> +			break;
>> +		case IIO_ANGL_VEL:
>> +			*val = sign_extend32((s16)vel >> 4, 11);
>> +			break;
>> +		default:
>> +			mutex_unlock(&st->lock);
>> +			return -EINVAL;
>> +		}
>>  
>> -	ret = spi_read(st->sdev, st->rx, 2);
>> -	if (ret < 0) {
>> +		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
>> +		udelay(1);
>>  		mutex_unlock(&st->lock);
>> -		return ret;
>> -	}
>>  
>> -	vel = be16_to_cpup((__be16 *)st->rx);
>> -	switch (chan->type) {
>> -	case IIO_ANGL:
>> -		*val = vel >> 4;
>> -		break;
>> -	case IIO_ANGL_VEL:
>> -		*val = sign_extend32((s16)vel >> 4, 11);
>> -		break;
>> +		return IIO_VAL_INT;
>>  	default:
>> -		mutex_unlock(&st->lock);
>> -		return -EINVAL;
>> +		break;
>>  	}
>>  
>> -	/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
>> -	udelay(1);
>> -	mutex_unlock(&st->lock);
>> -
>> -	return IIO_VAL_INT;
>> +	return -EINVAL;
>>  }
>>  
>>  static const struct iio_chan_spec ad2s1200_channels[] = {
>> @@ -105,6 +138,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
>>  		.indexed = 1,
>>  		.channel = 0,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>>  	}
>>  };
>>  
