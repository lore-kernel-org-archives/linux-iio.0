Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeCXOMm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 10:12:42 -0400
Date: Sat, 24 Mar 2018 14:12:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Julian Veenstra <davidjulianveenstra@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 10/11] staging: iio: ad2s1200: Replace angle channel
 with inclination channel
Message-ID: <20180324141236.4b243489@archlinux>
In-Reply-To: <87bmfdmyzn.fsf@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
        <73912d42bd2718325313ec792f8402a20f47405c.1521379685.git.davidjulianveenstra@gmail.com>
        <20180323142748.00005fec@huawei.com>
        <87bmfdmyzn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Mar 2018 13:36:44 +0100
David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:

> On 23, March 2018 14:27, Jonathan Cameron wrote:
> 
> > On Sun, 18 Mar 2018 14:37:04 +0100
> > David Veenstra <davidjulianveenstra@gmail.com> wrote:
> >  
> >> The angle channel is not defined in sysfs iio ABI. So it is replaced
> >> with an inclination channel, because it is defined in the ABI, and has the
> >> semantics of an angle.
> >> 
> >> In addition, a fractional scaling factor of 360 / (2^12 -1) is added,
> >> to scale the 12-bits angular position to degrees, conform the ABI.
> >> 
> >> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>  
> > No, please do not blugeon a device into the existing documented ABI.
> >
> > A resolver does not measure something that can be remotely
> > sensibly mapped to inclination.  Inclination is relative to 'down'.
> > A resolver doesn't care about down.
> >
> > Add an angle type to the ABI docs. It simply hasn't been documented
> > before because there were no drivers outside staging that use it.  
> 
> I'm sorry, I misunderstood our previous discussing on this topic
> (https://marc.info/?l=linux-iio&m=152087432322446&w=2) as saying:
> "there already exists another channel type that is a good enough match".
Ah, no I was making the point we need to match with the 'units' not
use the channel type. 

Hmm. We have an an unfortunate inconsistency between use of radians/sec
and degrees for different types.

Radians feels perfectly sensible for a rotary device, but not so much
for an angle of tilt.

I'm not sure how we resolve this cleanly or if we can.
My gut feeling is we need to go with radians for angle measures on
a rotating devices (to match against anglvel) and leave inclination
in degrees.

Sorry for the confusion, I'd missed that the units were inconsistent
which would have made that comment harder to interpret.

Jonathan

> 
> The in_incli and in_rot_from_* family all use degrees as their unit.
> For V2 I'll change it back to an angle channel and use angle as its
> unit.
> 
> Best regards,
> David Veenstra
> 
> >
> > Jonathan
> >  
> >> ---
> >>  drivers/staging/iio/resolver/ad2s1200.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> >> index 4b97a106012c..937676bcc0d4 100644
> >> --- a/drivers/staging/iio/resolver/ad2s1200.c
> >> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> >> @@ -64,6 +64,10 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
> >>  	switch (m) {
> >>  	case IIO_CHAN_INFO_SCALE:
> >>  		switch (chan->type) {
> >> +		case IIO_INCLI:
> >> +			*val = 360;
> >> +			*val2 = 0xFFF;
> >> +			return IIO_VAL_FRACTIONAL;
> >>  		case IIO_ANGL_VEL:
> >>  			/*
> >>  			 * 2 * Pi is almost equal to
> >> @@ -91,7 +95,7 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
> >>  		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
> >>  		udelay(1);
> >>  		gpiod_set_value(st->sample, 1);
> >> -		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
> >> +		gpiod_set_value(st->rdvel, !!(chan->type == IIO_INCLI));
> >>  
> >>  		ret = spi_read(st->sdev, st->rx, 2);
> >>  		if (ret < 0) {
> >> @@ -101,7 +105,7 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
> >>  
> >>  		vel = be16_to_cpup((__be16 *)st->rx);
> >>  		switch (chan->type) {
> >> -		case IIO_ANGL:
> >> +		case IIO_INCLI:
> >>  			*val = vel >> 4;
> >>  			ret = IIO_VAL_INT;
> >>  			break;
> >> @@ -128,10 +132,11 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
> >>  
> >>  static const struct iio_chan_spec ad2s1200_channels[] = {
> >>  	{
> >> -		.type = IIO_ANGL,
> >> +		.type = IIO_INCLI,
> >>  		.indexed = 1,
> >>  		.channel = 0,
> >>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> >>  	}, {
> >>  		.type = IIO_ANGL_VEL,
> >>  		.indexed = 1,  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

