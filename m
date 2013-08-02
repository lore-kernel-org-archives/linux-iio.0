Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23769 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304Ab3HBQCN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 2 Aug 2013 12:02:13 -0400
Message-ID: <51FBD9AA.90802@linux.intel.com>
Date: Fri, 02 Aug 2013 09:09:14 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk, jic23@kernel.org,
	denis.ciocca@st.com,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 1/2] iio: magnetometer: hid-sensor-magn-3d: Use devm_iio_device_alloc
References: <1375438128-23219-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375438128-23219-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/2013 03:08 AM, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> ---
> This series compile tested on togreg branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> ---
>   drivers/iio/magnetometer/hid-sensor-magn-3d.c |   19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index e71127a..5a6162d 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -283,11 +283,11 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
>   	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>   	struct iio_chan_spec *channels;
>   
> -	indio_dev = iio_device_alloc(sizeof(struct magn_3d_state));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> +					  sizeof(struct magn_3d_state));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
>   	platform_set_drvdata(pdev, indio_dev);
>   
>   	magn_state = iio_priv(indio_dev);
> @@ -299,15 +299,14 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
>   				&magn_state->common_attributes);
>   	if (ret) {
?free indio_dev
>   		dev_err(&pdev->dev, "failed to setup common attributes\n");
> -		goto error_free_dev;
> +		return ret;
>   	}
>   
>   	channels = kmemdup(magn_3d_channels, sizeof(magn_3d_channels),
>   			   GFP_KERNEL);
>   	if (!channels) {
> -		ret = -ENOMEM;
>   		dev_err(&pdev->dev, "failed to duplicate channels\n");
> -		goto error_free_dev;
> +		return -ENOMEM;
>   	}
>   
>   	ret = magn_3d_parse_report(pdev, hsdev, channels,

Any calls fail after this need to free indio_dev?
> @@ -364,9 +363,6 @@ error_unreg_buffer_funcs:
>   	iio_triggered_buffer_cleanup(indio_dev);
>   error_free_dev_mem:
>   	kfree(indio_dev->channels);
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
>   	return ret;
>   }
>   
> @@ -381,7 +377,6 @@ static int hid_magn_3d_remove(struct platform_device *pdev)
>   	hid_sensor_remove_trigger(indio_dev);
>   	iio_triggered_buffer_cleanup(indio_dev);
>   	kfree(indio_dev->channels);
> -	iio_device_free(indio_dev);
>   
>   	return 0;
>   }

