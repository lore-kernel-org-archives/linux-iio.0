Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbeAEJWW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jan 2018 04:22:22 -0500
Subject: Re: [PATCH 1/3] iio: cros_ec: light code cleanup
To: Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        groeck@chromium.org
Cc: linux-iio@vger.kernel.org
References: <20180104201718.221900-1-gwendal@chromium.org>
 <20180104201718.221900-2-gwendal@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <369a0027-5ca0-6a4e-3f9a-4f7a498a7cc2@collabora.com>
Date: Fri, 5 Jan 2018 10:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180104201718.221900-2-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Gwendal,

On 04/01/18 21:17, Gwendal Grignou wrote:
> - use dev instead of &pdev->dev when defined
> - remove syfs.h inclusion.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 5 ++---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 7 +++----
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 7d30c59da3e2..2297c8ce7cb8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -29,7 +29,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  
>  #include "cros_ec_sensors_core.h"
>  
> @@ -201,7 +200,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -241,7 +240,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>  			channel->type = IIO_MAGN;
>  			break;
>  		default:
> -			dev_err(&pdev->dev, "Unknown motion sensor\n");
> +			dev_err(dev, "Unknown motion sensor\n");
>  			return -EINVAL;
>  		}
>  	}
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 416cae5ebbd0..d50a32ba91fe 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -24,7 +24,6 @@
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/platform_device.h>
>  
>  #include "cros_ec_sensors_core.h"
> @@ -41,13 +40,13 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> -	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	state->ec = ec->ec_dev;
> -	state->msg = devm_kzalloc(&pdev->dev,
> +	state->msg = devm_kzalloc(dev,
>  				max((u16)sizeof(struct ec_params_motion_sense),
>  				state->ec->max_response), GFP_KERNEL);
>  	if (!state->msg)
> @@ -62,7 +61,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>  	state->msg->outsize = sizeof(struct ec_params_motion_sense);
>  
> -	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.parent = dev;
>  	indio_dev->name = pdev->name;
>  
>  	if (physical_device) {
> 

This patch looks good to me but did you miss to include the patch when you sent
v2? At least I did not receive the patch within v2 nor is available in linux-iio
patchwork v2 series.

Best regards,
 Enric
