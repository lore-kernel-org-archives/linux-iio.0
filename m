Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37944 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdDKJs3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2017 05:48:29 -0400
Received: by mail-wm0-f47.google.com with SMTP id t189so56790644wmt.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2017 02:48:29 -0700 (PDT)
Date: Tue, 11 Apr 2017 10:48:25 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org,
        martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: Re: [PATCH v2 5/5] mfd: cros_ec: add RTC as mfd subdevice
Message-ID: <20170411094825.64kwe5uckdpc3n4q@dell>
References: <20170403163536.25634-1-enric.balletbo@collabora.com>
 <20170403163536.25634-6-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170403163536.25634-6-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 03 Apr 2017, Enric Balletbo i Serra wrote:

> From: Stephen Barber <smbarber@chromium.org>
> 
> If the EC supports RTC host commands, expose an RTC device.

This could be made nicer by checking RTC compatibility in the RTC
driver.  So register it regardless, then check if the device is
supported from within.  If it's not supported simply return -ENODEV
from probe.

> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes since v1:
>  - Use PLATFORM_DEVID_AUTO to add the subdevice.
> 
>  drivers/mfd/cros_ec.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index bbc17ab..76874be 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -51,6 +51,10 @@ static const struct mfd_cell ec_pd_cell = {
>  	.pdata_size = sizeof(pd_p),
>  };
>  
> +static const struct mfd_cell ec_rtc_cell = {
> +	.name = "cros-ec-rtc",
> +};
> +
>  static irqreturn_t ec_irq_thread(int irq, void *data)
>  {
>  	struct cros_ec_device *ec_dev = data;
> @@ -238,6 +242,16 @@ static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
>  	kfree(msg);
>  }
>  
> +static void cros_ec_rtc_register(struct cros_ec_device *ec_dev)
> +{
> +	int ret;
> +
> +	ret = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_rtc_cell,
> +			      1, NULL, 0, NULL);
> +	if (ret)
> +		dev_err(ec_dev->dev, "failed to add EC RTC\n");
> +}
> +
>  int cros_ec_register(struct cros_ec_device *ec_dev)
>  {
>  	struct device *dev = ec_dev->dev;
> @@ -287,6 +301,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  	if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec_dev);
>  
> +	/* Check whether this EC has RTC support */
> +	if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
> +		cros_ec_rtc_register(ec_dev);
> +
>  	if (ec_dev->max_passthru) {
>  		/*
>  		 * Register a PD device as well on top of this device.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
