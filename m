Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42770 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdCYPTs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 11:19:48 -0400
Subject: Re: [PATCH 3/7] iio: cros_ec_sensors: Use devm to setup the triggered
 buffer.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-4-enric.balletbo@collabora.com>
Cc: martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3de164b9-c1c6-cb4c-2e97-bc49f9d28dee@kernel.org>
Date: Sat, 25 Mar 2017 15:09:28 +0000
MIME-Version: 1.0
In-Reply-To: <20170324174407.25401-4-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 17:44, Enric Balletbo i Serra wrote:
> Use resourced managed function devm_iio_triggered_buffer_setup
> to make error path simpler and be able to get rid of the remove
> function.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
>   This is an improvement that can wait to 4.12 merge window, again can be
> picked independently of the other patches and can go through IIO Jonathan's
> Cameron tree.
Thanks for these notes btw. Saves me having to figure out the dependencies
within the series.  Very useful.
> 
>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   | 26 +++-------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index c17596f..38e8783 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -267,31 +267,12 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  	else
>  		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -					 cros_ec_sensors_capture, NULL);
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +			cros_ec_sensors_capture, NULL);
>  	if (ret)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_uninit_buffer;
> -
> -	return 0;
> -
> -error_uninit_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
> -}
> -
> -static int cros_ec_sensors_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static const struct platform_device_id cros_ec_sensors_ids[] = {
> @@ -313,7 +294,6 @@ static struct platform_driver cros_ec_sensors_platform_driver = {
>  		.name	= "cros-ec-sensors",
>  	},
>  	.probe		= cros_ec_sensors_probe,
> -	.remove		= cros_ec_sensors_remove,
>  	.id_table	= cros_ec_sensors_ids,
>  };
>  module_platform_driver(cros_ec_sensors_platform_driver);
> 

