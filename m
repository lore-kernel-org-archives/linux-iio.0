Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52515 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbbEHSaS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:30:18 -0400
Message-ID: <554CC064.7020209@kernel.org>
Date: Fri, 08 May 2015 09:55:48 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: khoroshilov@ispras.ru, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v3] iio: light: hid-sensor-prox: Fix memory leak in probe()
References: <1431041524-14113-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1431041524-14113-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/15 19:32, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> 'channels' is allocated via kmemdup and it is never freed.
> 
> Use 'indio_dev->channels' directly instead, so that we avoid such
> memory leak problem.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> ---
> Build-tested only. 
> 
> Changes since v2:
> - Get rid of the channels and use indio_dev->channels instead.
> 
>  drivers/iio/light/hid-sensor-prox.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 91ecc46..124a8f8 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -253,7 +253,6 @@ static int hid_prox_probe(struct platform_device *pdev)
>  	struct iio_dev *indio_dev;
>  	struct prox_state *prox_state;
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> -	struct iio_chan_spec *channels;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>  				sizeof(struct prox_state));
> @@ -272,20 +271,21 @@ static int hid_prox_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	channels = kmemdup(prox_channels, sizeof(prox_channels), GFP_KERNEL);
> -	if (!channels) {
> +	indio_dev->channels = kmemdup(prox_channels, sizeof(prox_channels),
> +				      GFP_KERNEL);
> +	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
>  	}
>  
> -	ret = prox_parse_report(pdev, hsdev, channels,
> +	ret = prox_parse_report(pdev, hsdev,
> +				(struct iio_chan_spec *)indio_dev->channels,
>  				HID_USAGE_SENSOR_PROX, prox_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		goto error_free_dev_mem;
>  	}
>  
> -	indio_dev->channels = channels;
>  	indio_dev->num_channels =
>  				ARRAY_SIZE(prox_channels);
>  	indio_dev->dev.parent = &pdev->dev;
> 

