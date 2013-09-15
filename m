Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49909 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776Ab3IOJSb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 05:18:31 -0400
Message-ID: <52358980.4030000@kernel.org>
Date: Sun, 15 Sep 2013 11:18:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	jc23@cam.ac.uk, jkosina@suse.cz, holler@ahsoftware.de,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: Re: [PATCH 3/3] HID RTC: Open sensor hub open close
References: <1378843432-5113-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1378843432-5113-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1378843432-5113-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

cc'd Alessandro and rtc list as this is within RTC. I'll happilly take
it through IIO given the dependency, but I would like an Ack from the RTC
side.

On 09/10/13 21:03, Srinivas Pandruvada wrote:
> Open sensor hub when module is loaded and close when module is removed.
> This helps saving power by opening HID transport only when there is an
> user.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/rtc/rtc-hid-sensor-time.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
> index 7273b01..1fe170c 100644
> --- a/drivers/rtc/rtc-hid-sensor-time.c
> +++ b/drivers/rtc/rtc-hid-sensor-time.c
> @@ -279,15 +279,28 @@ static int hid_time_probe(struct platform_device *pdev)
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
>  
>  	if (IS_ERR(time_state->rtc)) {
>  		dev_err(&pdev->dev, "rtc device register failed!\n");
> -		return PTR_ERR(time_state->rtc);
> +		ret = PTR_ERR(time_state->rtc);
> +		goto err_rtc;
>  	}
>  
> +	return 0;
> +
> +err_rtc:
> +	sensor_hub_device_close(hsdev);
> +err_open:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
>  	return ret;
>  }
>  
> @@ -295,6 +308,7 @@ static int hid_time_remove(struct platform_device *pdev)
>  {
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  
> +	sensor_hub_device_close(hsdev);
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
>  
>  	return 0;
> 
