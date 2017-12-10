Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdLJRcC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 12:32:02 -0500
Date: Sun, 10 Dec 2017 17:31:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>
Subject: Re: [PATCH v1 5/7] iio: adc: ina2xx: Use a monotonic clock for
 delay calculation
Message-ID: <20171210173157.6cc78b4b@archlinux>
In-Reply-To: <7330c7df-330f-449f-8706-a2407e92ebcf@rwthex-w2-a.rwth-ad.de>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
        <7330c7df-330f-449f-8706-a2407e92ebcf@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 8 Dec 2017 18:41:50 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> The iio timestamp clock is user selectable and may be non-monotonic. Also,
> only part of the acquisition time is measured, thus the delay was longer
> than intended.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> ---
> 
>  drivers/iio/adc/ina2xx-adc.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 2621a34ee5c6..65bd9e69faf2 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -703,10 +703,10 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  	/* data buffer needs space for channel data and timestap */
>  	unsigned short data[4 + sizeof(s64)/sizeof(short)];
>  	int bit, ret, i = 0;
> -	s64 time_a, time_b;
> +	s64 time;
>  	unsigned int alert;
>  
> -	time_a = iio_get_time_ns(indio_dev);
> +	time = iio_get_time_ns(indio_dev);
>  
>  	/*
>  	 * Because the timer thread and the chip conversion clock
> @@ -752,11 +752,9 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  		data[i++] = val;
>  	}
>  
> -	time_b = iio_get_time_ns(indio_dev);
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, time);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data, time_a);
> -
> -	return (unsigned long)(time_b - time_a) / 1000;
> +	return 0;
>  };
>  
>  static int ina2xx_capture_thread(void *data)
> @@ -764,7 +762,9 @@ static int ina2xx_capture_thread(void *data)
>  	struct iio_dev *indio_dev = data;
>  	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>  	int sampling_us = SAMPLING_PERIOD(chip);
> -	int buffer_us, delay_us;
> +	int ret;
> +	struct timespec64 next, now, delta;
> +	s64 delay_us;
>  
>  	/*
>  	 * Poll a bit faster than the chip internal Fs, in case
> @@ -773,15 +773,22 @@ static int ina2xx_capture_thread(void *data)
>  	if (!chip->allow_async_readout)
>  		sampling_us -= 200;
>  
> +	ktime_get_ts64(&next);
> +
>  	do {
> -		buffer_us = ina2xx_work_buffer(indio_dev);
> -		if (buffer_us < 0)
> -			return buffer_us;
> +		ret = ina2xx_work_buffer(indio_dev);
> +		if (ret < 0)
> +			return ret;
>  
> -		if (sampling_us > buffer_us) {
> -			delay_us = sampling_us - buffer_us;
> -			usleep_range(delay_us, (delay_us * 3) >> 1);
> -		}
> +		ktime_get_ts64(&now);
> +
> +		do {
> +			timespec64_add_ns(&next, 1000 * sampling_us);
> +			delta = timespec64_sub(next, now);
> +			delay_us = timespec64_to_ns(&delta) / 1000;
> +		} while (delay_us <= 0);

Umm. I'm lost, what is the purpose of the above dance?
A comment perhaps.

> +
> +		usleep_range(delay_us, (delay_us * 3) >> 1);
>  
>  	} while (!kthread_should_stop());
>  

