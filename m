Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44792 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeCJQ3K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Mar 2018 11:29:10 -0500
Date: Sat, 10 Mar 2018 16:29:06 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Michael Nosthoff <committed@heine.so>
Cc: linux-iio@vger.kernel.org,
        Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: Re: [PATCH 2/2] iio: st_pressure: st_accel: pass correct platform
 data to init
Message-ID: <20180310162906.20364dd8@archlinux>
In-Reply-To: <500bb58a2dc6d70fa096d6a63321dc23@heine.so>
References: <500bb58a2dc6d70fa096d6a63321dc23@heine.so>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 09 Mar 2018 10:02:45 +0100
Michael Nosthoff <committed@heine.so> wrote:

> Commit 7383d44b added a pointer pdata which get set to the default
> platform_data when non was defined in the device. But it did not
> pass this pointer to the st_sensors_init_sensor call but still
> used the maybe uninitialized platform_data from dev.
> 
> This breaks initialization when no platform_data is given and
> the optional st,drdy-int-pin devicetree option is not set.
> 
> This commit fixes this.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7383d44b ("iio: st_pressure: st_accel: Initialise sensor platform 
> data properly")
> Signed-off-by: Michael Nosthoff <committed@heine.so>
Both patches were corrupted by your email client.  I did the
revert directly and then manually applied this.

Thanks for tracking down the problem.

Applied to the fixes-togreg branch of iio.git.

Jonathan

> ---
>   drivers/iio/accel/st_accel_core.c       | 2 +-
>   drivers/iio/pressure/st_pressure_core.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c 
> b/drivers/iio/accel/st_accel_core.c
> index 460aa58..3e6fd5a 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -951,7 +951,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>   	if (!pdata)
>   		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
> 
> -	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
> +	err = st_sensors_init_sensor(indio_dev, pdata);
>   	if (err < 0)
>   		goto st_accel_power_off;
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c 
> b/drivers/iio/pressure/st_pressure_core.c
> index 349e5c7..4ddb6cf 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -640,7 +640,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>   		       press_data->sensor_settings->drdy_irq.int2.addr))
>   		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
> 
> -	err = st_sensors_init_sensor(indio_dev, 
> press_data->dev->platform_data);
> +	err = st_sensors_init_sensor(indio_dev, pdata);
>   	if (err < 0)
>   		goto st_press_power_off;
> 

