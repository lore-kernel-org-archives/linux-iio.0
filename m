Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37652 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3GFJk5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jul 2013 05:40:57 -0400
Message-ID: <51D7E629.8000603@kernel.org>
Date: Sat, 06 Jul 2013 10:40:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: jic23@cam.ac.uk, gregkh@linuxfoundation.org, lars@metafoo.de,
	wfp5p@virginia.edu, yongjun_wei@trendmicro.com.cn,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging:iio:ad7291: add missing .driver_module to struct
 iio_info
References: <CAPgLHd-v0MJWgtjY66Ky87ieQYxXg_9bFQxB0N5zoibshCV7Jg@mail.gmail.com>
In-Reply-To: <CAPgLHd-v0MJWgtjY66Ky87ieQYxXg_9bFQxB0N5zoibshCV7Jg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/2013 02:46 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add missing .driver_module of struct iio_info. This prevents the
> module from being removed from underneath its users.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Applied to the fixes-togreg branch of iio.git.

Obviously we want this fix whatever the outcome of the discussion started
by Greg as any changes will be in the next cycle, not this one.

Thanks,

Jonathan
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
>  
>  static int ad7291_probe(struct i2c_client *client,
> 
