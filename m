Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1431444079.11262.26.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH 1/6] iio: accel: hid-sensor-accel-3d: Fix memory leak in
 probe()
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, Fabio Estevam
	 <fabio.estevam@freescale.com>
Date: Tue, 12 May 2015 08:21:19 -0700
In-Reply-To: <1431115203-14511-1-git-send-email-festevam@gmail.com>
References: <1431115203-14511-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2015-05-08 at 16:59 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> 'channels' is allocated via kmemdup and it is never freed.
It is freed except when the parsing of hid report is failed, which is
unlikely. So change the commit message.
> 
> Use 'indio_dev->channels' directly instead, so that we avoid such
> memory leak problem.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Build-tested only.
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 2b4fad6..b933957 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -299,7 +299,6 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  	struct iio_dev *indio_dev;
>  	struct accel_3d_state *accel_state;
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> -	struct iio_chan_spec *channels;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>  					  sizeof(struct accel_3d_state));
> @@ -320,21 +319,21 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	channels = kmemdup(accel_3d_channels, sizeof(accel_3d_channels),
> -			   GFP_KERNEL);
> -	if (!channels) {
> +	indio_dev->channels = kmemdup(accel_3d_channels,
> +				      sizeof(accel_3d_channels), GFP_KERNEL);
> +	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
>  	}
>  
> -	ret = accel_3d_parse_report(pdev, hsdev, channels,
> -					HID_USAGE_SENSOR_ACCEL_3D, accel_state);
> +	ret = accel_3d_parse_report(pdev, hsdev,
> +				    (struct iio_chan_spec *)indio_dev->channels,
> +				     HID_USAGE_SENSOR_ACCEL_3D, accel_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		goto error_free_dev_mem;
>  	}
>  
> -	indio_dev->channels = channels;
>  	indio_dev->num_channels = ARRAY_SIZE(accel_3d_channels);
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &accel_3d_info;
