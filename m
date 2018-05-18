Return-Path: <davidjulianveenstra@gmail.com>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com> <803058d8b119451a193c556866ffbb291ec83bcb.1524432236.git.davidjulianveenstra@gmail.com> <20180428182344.59fec23e@archlinux> <20180428183514.08ab2a6c@archlinux>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de, linux-iio@vger.kernel.org, daniel.baluta@nxp.com, devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/9] staging: iio: ad2s1200: Add scaling factor for angular velocity channel
In-reply-to: <20180428183514.08ab2a6c@archlinux>
Date: Fri, 18 May 2018 15:10:18 +0200
Message-ID: <8736ypcdol.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>


On 28, April 2018 17:35, Jonathan Cameron wrote:

> On Sat, 28 Apr 2018 18:23:44 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Mon, 23 Apr 2018 00:03:59 +0200
>> David Veenstra <davidjulianveenstra@gmail.com> wrote:
>> 
>> > The sysfs iio ABI states radians per second is expected as the unit for
>> > angular velocity, but the 12-bit angular velocity register has rps  
>> Really small point, but rps is a bit ambiguous given we are
>> talking about converting to radian's per second ;)
>> 
>> revs is the 'common' name for what it currently is I think.
>> 
>> Otherwise this looks good.
> Actually, I can't immediately tell from the datasheet what the scaling is...
>
> "Bit 15 through bit 4 correspond to the angular
> information. The angular position data format is unsigned
> binary, with all zeros corresponding to 0 degrees and all ones
> corresponding to 360 degrees –l LSB. The angular velocity data
> format instead is twos complement binary, with the MSB
> representing the rotation direction"
>
> Earlier was also had:
>
> "Data Format
> The digital angle signal represents the absolute position of the
> resolver shaft as a 12-bit unsigned binary word. The digital
> velocity signal is a 12-bit twos complement word, which
> represents the velocity of the resolver shaft rotating in either a
> clockwise or a counterclockwise direction."
>
> So for position the 12 bits correspond to 0 to 360 - 360/(2^12)
> hence _SCALE is 360/(2^12)
>
> But I'm not seeing any hint whatsoever on the scaling for the
> rotational velocity...
>
> Am I missing it somewhere?  you might be right in how you have
> read it given it will track up to 1000rps and we are 2 directional
> so -2048 to 2047 so not a huge amount of wasted space.
>
> Failing any other evidence I'll go with what you have until we
> can test this, but the datasheet could be clearer!

When I first read the datasheet it wasn't clear to me either. So I
emailed Michael Hennerich. He confirmed to me that the scaling factor
for degrees is indeed 360 / (2^12- 1). And he told me that the unit
for angular velocity is revolutions per second, and that I should
use a scaling factor of 2PI to convert it to rad/s.

Best regards,
David Veenstra

>
> Jonathan
>> 
>> Jonathan
>> 
>> 
>> > as its unit. So a scaling factor of approximately 2 * Pi is
>> > added to the angular velocity channel.
>> > 
>> > Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
>> > ---
>> > Changes in v3:
>> >  - A decimal approximation of the scale is used, instead
>> >    of a fractional approximation.
>> >  - Remove unneeded explanation of iio_convert_raw_to_processed.
>> > 
>> >  drivers/staging/iio/resolver/ad2s1200.c | 71 +++++++++++++++++++++------------
>> >  1 file changed, 45 insertions(+), 26 deletions(-)
>> > 
>> > diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
>> > index 3c7163610ff6..3e1696e52c38 100644
>> > --- a/drivers/staging/iio/resolver/ad2s1200.c
>> > +++ b/drivers/staging/iio/resolver/ad2s1200.c
>> > @@ -57,37 +57,55 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>> >  	struct ad2s1200_state *st = iio_priv(indio_dev);
>> >  	int ret = 0;
>> >  
>> > -	mutex_lock(&st->lock);
>> > -	gpiod_set_value(st->sample, 0);
>> > -
>> > -	/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
>> > -	udelay(1);
>> > -	gpiod_set_value(st->sample, 1);
>> > -	gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
>> > -
>> > -	ret = spi_read(st->sdev, &st->rx, 2);
>> > -	if (ret < 0) {
>> > +	switch (m) {
>> > +	case IIO_CHAN_INFO_SCALE:
>> > +		switch (chan->type) {
>> > +		case IIO_ANGL_VEL:
>> > +			/* 2 * Pi ~= 6.283185 */
>> > +			*val = 6;
>> > +			*val2 = 283185;
>> > +			return IIO_VAL_INT_PLUS_MICRO;
>> > +		default:
>> > +			return -EINVAL;
>> > +		}
>> > +		break;
>> > +	case IIO_CHAN_INFO_RAW:
>> > +		mutex_lock(&st->lock);
>> > +		gpiod_set_value(st->sample, 0);
>> > +
>> > +		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
>> > +		udelay(1);
>> > +		gpiod_set_value(st->sample, 1);
>> > +		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
>> > +
>> > +		ret = spi_read(st->sdev, &st->rx, 2);
>> > +		if (ret < 0) {
>> > +			mutex_unlock(&st->lock);
>> > +			return ret;
>> > +		}
>> > +
>> > +		switch (chan->type) {
>> > +		case IIO_ANGL:
>> > +			*val = be16_to_cpup(&st->rx) >> 4;
>> > +			break;
>> > +		case IIO_ANGL_VEL:
>> > +			*val = sign_extend32(be16_to_cpup(&st->rx) >> 4, 11);
>> > +			break;
>> > +		default:
>> > +			mutex_unlock(&st->lock);
>> > +			return -EINVAL;
>> > +		}
>> > +
>> > +		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
>> > +		udelay(1);
>> >  		mutex_unlock(&st->lock);
>> > -		return ret;
>> > -	}
>> >  
>> > -	switch (chan->type) {
>> > -	case IIO_ANGL:
>> > -		*val = be16_to_cpup(&st->rx) >> 4;
>> > -		break;
>> > -	case IIO_ANGL_VEL:
>> > -		*val = sign_extend32(be16_to_cpup(&st->rx) >> 4, 11);
>> > -		break;
>> > +		return IIO_VAL_INT;
>> >  	default:
>> > -		mutex_unlock(&st->lock);
>> > -		return -EINVAL;
>> > +		break;
>> >  	}
>> >  
>> > -	/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
>> > -	udelay(1);
>> > -	mutex_unlock(&st->lock);
>> > -
>> > -	return IIO_VAL_INT;
>> > +	return -EINVAL;
>> >  }
>> >  
>> >  static const struct iio_chan_spec ad2s1200_channels[] = {
>> > @@ -101,6 +119,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
>> >  		.indexed = 1,
>> >  		.channel = 0,
>> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> >  	}
>> >  };
>> >    
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
