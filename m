Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32974 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161061AbcFCMPH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:15:07 -0400
Subject: Re: [PATCH 7/8] iio: adc: ti_am335x_adc: use variable names for
 sizeof() operator
To: "Andrew F. Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Dave Gerlach <d-gerlach@ti.com>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-8-afd@ti.com>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fb3ab1bb-4c06-1361-6675-f950216565d0@kernel.org>
Date: Fri, 3 Jun 2016 13:15:04 +0100
MIME-Version: 1.0
In-Reply-To: <20160531170013.2649-8-afd@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/16 18:00, Andrew F. Davis wrote:
> Fix the code formatting to use the kernel preferred style
> of using the actual variables to determize the size using
> the sizeof() operator.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Applied - thanks,

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 18af71d..8a36875 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -326,8 +326,7 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>  	int i;
>  
>  	indio_dev->num_channels = channels;
> -	chan_array = kcalloc(channels,
> -			sizeof(struct iio_chan_spec), GFP_KERNEL);
> +	chan_array = kcalloc(channels, sizeof(*chan_array), GFP_KERNEL);
>  	if (chan_array == NULL)
>  		return -ENOMEM;
>  
> @@ -467,8 +466,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev,
> -					  sizeof(struct tiadc_device));
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*indio_dev));
>  	if (indio_dev == NULL) {
>  		dev_err(&pdev->dev, "failed to allocate iio device\n");
>  		return -ENOMEM;
> 

