Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1431543796.11262.82.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH v3 6/6] iio: pressure: hid-sensor-press: Fix memory leak
 in probe()
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, Fabio Estevam
	 <fabio.estevam@freescale.com>
Date: Wed, 13 May 2015 12:03:16 -0700
In-Reply-To: <1431540374-3168-6-git-send-email-festevam@gmail.com>
References: <1431540374-3168-1-git-send-email-festevam@gmail.com>
	 <1431540374-3168-6-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2015-05-13 at 15:06 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> 'channels' is allocated via kmemdup and it is never freed in the
> subsequent error paths.
> 
> Use 'indio_dev->channels' directly instead, so that we avoid such
> memory leak problem.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Build-tested only.
> 
> Changes since v2:
> - Properly align "press_parse_report(" in multiple lines
> Changes since v1:
> - Make clear in the commit log that the proble only occurs in the error
> paths
>  drivers/iio/pressure/hid-sensor-press.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index 7bb8d4c..5a10dbc 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -262,7 +262,6 @@ static int hid_press_probe(struct platform_device *pdev)
>  	struct iio_dev *indio_dev;
>  	struct press_state *press_state;
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> -	struct iio_chan_spec *channels;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>  				sizeof(struct press_state));
> @@ -282,20 +281,21 @@ static int hid_press_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	channels = kmemdup(press_channels, sizeof(press_channels), GFP_KERNEL);
> -	if (!channels) {
> +	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
> +				      GFP_KERNEL);
> +	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
>  	}
>  
> -	ret = press_parse_report(pdev, hsdev, channels,
> -				HID_USAGE_SENSOR_PRESSURE, press_state);
> +	ret = press_parse_report(pdev, hsdev,
> +				 (struct iio_chan_spec *)indio_dev->channels,
> +				 HID_USAGE_SENSOR_PRESSURE, press_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		goto error_free_dev_mem;
>  	}
>  
> -	indio_dev->channels = channels;
>  	indio_dev->num_channels =
>  				ARRAY_SIZE(press_channels);
>  	indio_dev->dev.parent = &pdev->dev;
