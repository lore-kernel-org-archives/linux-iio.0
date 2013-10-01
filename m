Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34446 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab3JAUKp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 16:10:45 -0400
Message-ID: <524B3A70.6000503@kernel.org>
Date: Tue, 01 Oct 2013 22:11:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, holler@ahsoftware.de
Subject: Re: [PATCH] HID RTC: Open sensor hub open close
References: <1380644532-29927-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1380644532-29927-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/13 17:22, Srinivas Pandruvada wrote:
> Open sensor hub when module is loaded and close when module is removed.
> This helps saving power by opening HID transport only when there is an
> user.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Acked-by: Alessandro Zummo <a.zummo@towertech.it>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/rtc/rtc-hid-sensor-time.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
> index 4e2a818..45560ff 100644
> --- a/drivers/rtc/rtc-hid-sensor-time.c
> +++ b/drivers/rtc/rtc-hid-sensor-time.c
> @@ -275,6 +275,12 @@ static int hid_time_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = sensor_hub_device_open(hsdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to open sensor hub device!\n");
> +		goto err_open;
> +	}
> +
>  	time_state->rtc = devm_rtc_device_register(&pdev->dev,
>  					"hid-sensor-time", &hid_time_rtc_ops,
>  					THIS_MODULE);
> @@ -282,17 +288,24 @@ static int hid_time_probe(struct platform_device *pdev)
>  	if (IS_ERR_OR_NULL(time_state->rtc)) {
>  		ret = time_state->rtc ? PTR_ERR(time_state->rtc) : -ENODEV;
>  		time_state->rtc = NULL;
> -		sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
>  		dev_err(&pdev->dev, "rtc device register failed!\n");
> +		goto err_rtc;
>  	}
>  
>  	return ret;
> +
> +err_rtc:
> +	sensor_hub_device_close(hsdev);
> +err_open:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
> +	return ret;
>  }
>  
>  static int hid_time_remove(struct platform_device *pdev)
>  {
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  
> +	sensor_hub_device_close(hsdev);
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
>  
>  	return 0;
> 
