Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdI3Rpn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 13:45:43 -0400
Date: Sat, 30 Sep 2017 18:45:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.io
Subject: Re: [PATCH 1/2] iio: adc: sun4i-gpadc-iio: register in the thermal
 after registering in pm
Message-ID: <20170930184538.10ec70f1@archlinux>
In-Reply-To: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
References: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Sep 2017 14:52:18 +0200
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> This driver has a get_temp function used by the thermal framework that
> uses pm functions.
> 
> However, the driver isn't registered in pm before it is registered in
> thermal framework, resulting in the pm_resume not being called and thus
> the IP not enabled.
> 
> When the IP is disabled, the raw temp value is always 0. With the
> devices currently supported, it isn't a problem since with their
> respective formula, they return a really cold SoC temperature which
> isn't a problem for the thermal framework. But for future SoC that have
> a different formula, it could return a critically hot temperature,
> forcing the thermal framework to shutdown the board.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Hmm. I wondered about sending this as a fix, but decided in the end
that your argument convinced me we could let this go the slow way.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 34 ++++++++++++++------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 137f577..392d47f 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -529,17 +529,10 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> -		return 0;
> +	if (IS_ENABLED(CONFIG_THERMAL_OF))
> +		info->sensor_device = &pdev->dev;
>  
> -	info->sensor_device = &pdev->dev;
> -	info->tzd = thermal_zone_of_sensor_register(info->sensor_device, 0,
> -						    info, &sun4i_ts_tz_ops);
> -	if (IS_ERR(info->tzd))
> -		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
> -			PTR_ERR(info->tzd));
> -
> -	return PTR_ERR_OR_ZERO(info->tzd);
> +	return 0;
>  }
>  
>  static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
> @@ -586,15 +579,6 @@ static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
>  		 * return the temperature.
>  		 */
>  		info->sensor_device = pdev->dev.parent;
> -		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
> -							    0, info,
> -							    &sun4i_ts_tz_ops);
> -		if (IS_ERR(info->tzd)) {
> -			dev_err(&pdev->dev,
> -				"could not register thermal sensor: %ld\n",
> -				PTR_ERR(info->tzd));
> -			return PTR_ERR(info->tzd);
> -		}
>  	} else {
>  		indio_dev->num_channels =
>  			ARRAY_SIZE(sun4i_gpadc_channels_no_temp);
> @@ -664,6 +648,18 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
> +	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> +		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
> +							    0, info,
> +							    &sun4i_ts_tz_ops);
> +		if (IS_ERR(info->tzd)) {
> +			dev_err(&pdev->dev,
> +				"could not register thermal sensor: %ld\n",
> +				PTR_ERR(info->tzd));
> +			return PTR_ERR(info->tzd);
> +		}
> +	}
> +
>  	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "could not register the device\n");
> 
> base-commit: 1f183459b5144384e2669a3f757d36bacab108cf

