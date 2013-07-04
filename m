Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 4 Jul 2013 09:01:10 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: jic23@cam.ac.uk, lars@metafoo.de, wfp5p@virginia.edu,
	yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging:iio:ad7291: add missing .driver_module to struct
 iio_info
Message-ID: <20130704160110.GC13897@kroah.com>
References: <CAPgLHd-v0MJWgtjY66Ky87ieQYxXg_9bFQxB0N5zoibshCV7Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPgLHd-v0MJWgtjY66Ky87ieQYxXg_9bFQxB0N5zoibshCV7Jg@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 04, 2013 at 09:46:34PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add missing .driver_module of struct iio_info. This prevents the
> module from being removed from underneath its users.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/staging/iio/adc/ad7291.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 3fc79e5..a2e61c2 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -517,6 +517,7 @@ static const struct iio_info ad7291_info = {
>  	.read_event_value = &ad7291_read_event_value,
>  	.write_event_value = &ad7291_write_event_value,
>  	.event_attrs = &ad7291_event_attribute_group,
> +	.driver_module = THIS_MODULE,
>  };

That's a hint that the register function should be changed so that no
module ever has to set this value.  Look at how PCI and USB do their
driver registration function for how to do this properly.

thanks,

greg k-h
