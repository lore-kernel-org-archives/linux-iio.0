Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57062 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759165Ab3HMRj0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2013 13:39:26 -0400
Message-ID: <520A7D5B.10206@kernel.org>
Date: Tue, 13 Aug 2013 19:39:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 6/9] iio: hid-sensor-gyro-3d: Use devm_iio_device_alloc
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org> <1376375675-11595-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-6-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/13/13 07:34, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Applied to the togreg branch of iio.git.
> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 9cc8aa1..d9d7bef 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -282,11 +282,9 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  	struct iio_chan_spec *channels;
>  
> -	indio_dev = iio_device_alloc(sizeof(struct gyro_3d_state));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	gyro_state = iio_priv(indio_dev);
> @@ -298,15 +296,14 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  						&gyro_state->common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup common attributes\n");
> -		goto error_free_dev;
> +		return ret;
>  	}
>  
>  	channels = kmemdup(gyro_3d_channels, sizeof(gyro_3d_channels),
>  			   GFP_KERNEL);
>  	if (!channels) {
> -		ret = -ENOMEM;
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
> -		goto error_free_dev;
> +		return -ENOMEM;
>  	}
>  
>  	ret = gyro_3d_parse_report(pdev, hsdev, channels,
> @@ -363,9 +360,6 @@ error_unreg_buffer_funcs:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_free_dev_mem:
>  	kfree(indio_dev->channels);
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
>  	return ret;
>  }
>  
> @@ -380,7 +374,6 @@ static int hid_gyro_3d_remove(struct platform_device *pdev)
>  	hid_sensor_remove_trigger(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	kfree(indio_dev->channels);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
