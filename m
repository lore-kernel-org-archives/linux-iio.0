Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24177 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbbEHAZA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 May 2015 20:25:00 -0400
Message-ID: <1431044598.11262.0.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH v3] iio: light: hid-sensor-prox: Fix memory leak in
 probe()
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: jic23@kernel.org, khoroshilov@ispras.ru, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Thu, 07 May 2015 17:23:18 -0700
In-Reply-To: <1431041524-14113-1-git-send-email-festevam@gmail.com>
References: <1431041524-14113-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2015-05-07 at 20:32 -0300, Fabio Estevam wrote:
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

Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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


