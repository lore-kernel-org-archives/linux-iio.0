Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35644 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbdLQL4j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Dec 2017 06:56:39 -0500
Date: Sun, 17 Dec 2017 11:56:35 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v1 5/7] iio: adc: ina2xx: Use a monotonic clock for
 delay calculation
Message-ID: <20171217115635.51427f14@archlinux>
In-Reply-To: <20171212202114.654fc59b@archlinux>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
        <7330c7df-330f-449f-8706-a2407e92ebcf@rwthex-w2-a.rwth-ad.de>
        <20171210173157.6cc78b4b@archlinux>
        <2674819.FhFV8Gkxuq@pebbles>
        <20171212202114.654fc59b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 12 Dec 2017 20:21:14 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 10 Dec 2017 21:47:37 +0100
> Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:
> 
> > On Sunday, December 10, 2017 6:31:57 PM CET Jonathan Cameron wrote:  
> > > On Fri, 8 Dec 2017 18:41:50 +0100
> > > 
> > > Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:    
> > > > The iio timestamp clock is user selectable and may be non-monotonic. Also,
> > > > only part of the acquisition time is measured, thus the delay was longer
> > > > than intended.
> > > > 
> > > > Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> > > > ---
> > > > 
> > > >  drivers/iio/adc/ina2xx-adc.c | 35 +++++++++++++++++++++--------------
> > > >  1 file changed, 21 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> > > > index 2621a34ee5c6..65bd9e69faf2 100644
> > > > --- a/drivers/iio/adc/ina2xx-adc.c
> > > > +++ b/drivers/iio/adc/ina2xx-adc.c
> > > > @@ -703,10 +703,10 @@ static int ina2xx_work_buffer(struct iio_dev    
> > > > *indio_dev)>     
> > > >  	/* data buffer needs space for channel data and timestap */
> > > >  	unsigned short data[4 + sizeof(s64)/sizeof(short)];
> > > >  	int bit, ret, i = 0;
> > > > 
> > > > -	s64 time_a, time_b;
> > > > +	s64 time;
> > > > 
> > > >  	unsigned int alert;
> > > > 
> > > > -	time_a = iio_get_time_ns(indio_dev);
> > > > +	time = iio_get_time_ns(indio_dev);
> > > > 
> > > >  	/*
> > > >  	
> > > >  	 * Because the timer thread and the chip conversion clock
> > > > 
> > > > @@ -752,11 +752,9 @@ static int ina2xx_work_buffer(struct iio_dev    
> > > > *indio_dev)>     
> > > >  		data[i++] = val;
> > > >  	
> > > >  	}
> > > > 
> > > > -	time_b = iio_get_time_ns(indio_dev);
> > > > +	iio_push_to_buffers_with_timestamp(indio_dev, data, time);
> > > > 
> > > > -	iio_push_to_buffers_with_timestamp(indio_dev, data, time_a);
> > > > -
> > > > -	return (unsigned long)(time_b - time_a) / 1000;
> > > > +	return 0;
> > > > 
> > > >  };
> > > >  
> > > >  static int ina2xx_capture_thread(void *data)
> > > > 
> > > > @@ -764,7 +762,9 @@ static int ina2xx_capture_thread(void *data)
> > > > 
> > > >  	struct iio_dev *indio_dev = data;
> > > >  	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
> > > >  	int sampling_us = SAMPLING_PERIOD(chip);
> > > > 
> > > > -	int buffer_us, delay_us;
> > > > +	int ret;
> > > > +	struct timespec64 next, now, delta;
> > > > +	s64 delay_us;
> > > > 
> > > >  	/*
> > > >  	
> > > >  	 * Poll a bit faster than the chip internal Fs, in case
> > > > 
> > > > @@ -773,15 +773,22 @@ static int ina2xx_capture_thread(void *data)
> > > > 
> > > >  	if (!chip->allow_async_readout)
> > > >  	
> > > >  		sampling_us -= 200;
> > > > 
> > > > +	ktime_get_ts64(&next);
> > > > +
> > > > 
> > > >  	do {
> > > > 
> > > > -		buffer_us = ina2xx_work_buffer(indio_dev);
> > > > -		if (buffer_us < 0)
> > > > -			return buffer_us;
> > > > +		ret = ina2xx_work_buffer(indio_dev);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > 
> > > > -		if (sampling_us > buffer_us) {
> > > > -			delay_us = sampling_us - buffer_us;
> > > > -			usleep_range(delay_us, (delay_us * 3) >> 1);
> > > > -		}
> > > > +		ktime_get_ts64(&now);
> > > > +
> > > > +		do {
> > > > +			timespec64_add_ns(&next, 1000 * sampling_us);
> > > > +			delta = timespec64_sub(next, now);
> > > > +			delay_us = timespec64_to_ns(&delta) / 1000;
> > > > +		} while (delay_us <= 0);    
> > > 
> > > Umm. I'm lost, what is the purpose of the above dance?
> > > A comment perhaps.    
> > 
> > next is the timestamp for the next read to happen, now is the current time. 
> > Obviously we have to sleep for the remainder.
> > 
> > Each sampling interval the "next" timestamp is pushed back by sampling_us. 
> > Normally this happens exactly once per read, i.e. we schedule the reads to 
> > happen exactly each sampling interval.
> > 
> > The sampling inteval is *only* added multiple times if it is faster than the 
> > bus can deliver the data (at 100 kBits/s, each register read takes about 400 
> > us, so sampling faster than every ~1 ms is not possible.  
> 
> So this is deliberately skipping a sample if this happens?  It was this
> element that I wasn't understanding previously. 
> Add a comment in the code to explain this and I'm happy. It's horrible,
> but not much we can do if things are simply going too fast.
I still want to see a comment in the code making it clear what is
happening in that loop.  So for now I'm going to stop here in applying
this series.

Jonathan

> 
> Thanks for the info.
> 
> Jonathan
> > 
> > The old code measured the time spent for reading the registers and slept for 
> > the remainder of the interval. This way the sampling drifts, as there is some 
> > time not accounted for - usleep_range, function call overhead, kthread 
> > interrupted.
> > 
> > Using a timestamp avoids the drift. It also allows simple readjustment of the 
> > "next" sampling time when polling the status register.
> > 
> > Kind regards,
> > 
> > Stefan
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

