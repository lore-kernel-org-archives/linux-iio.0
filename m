Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58065 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949035AbdDZFhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 01:37:19 -0400
Subject: Re: [PATCH] iio: st_pressure: st_accel: Initialise sensor platform
 data properly
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi83@gmail.com, gregor.boirie@parrot.com,
        rob@kernel.org, linux-kernel@vger.kernel.org,
        m.niestroj@grinn-global.com
References: <20170419140500.7793-1-shrirang.bagul@canonical.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <022dcd26-801b-5a5e-ee75-45791d9c5986@kernel.org>
Date: Wed, 26 Apr 2017 06:37:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170419140500.7793-1-shrirang.bagul@canonical.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/17 15:05, Shrirang Bagul wrote:
> This patch fixes the sensor platform data initialisation for st_pressure
> and st_accel device drivers. Without this patch, the driver fails to
> register the sensors when the user removes and re-loads the driver.
> 
> 1. Unload the kernel modules for st_pressure
> $ sudo rmmod st_pressure_i2c
> $ sudo rmmod st_pressure
> 
> 2. Re-load the driver
> $ sudo insmod st_pressure
> $ sudo insmod st_pressure_i2c
> --- OR ---
> $ sudo modprobe st_pressure_i2c
> 
> dmesg errors:
> 
> [ 160.935707] iio iio:device2: DRDY on pdata not valid.
> [ 160.941505] st-press-i2c: probe of i2c-SMO9210:00 failed with error -22
> 
> The driver fails to register the pressure sensor device. Devices
> supported by st_accel driver also suffer from the same bug.
> 
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
Unless I am missing something, the severity of this bug is fairly minor
so whilst I'm pleased to have it fixed, I'm not intending to mark this
for stable.

If anyone has a cunning way of exploiting it then let me know!

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/st_accel_core.c       | 7 ++++---
>  drivers/iio/pressure/st_pressure_core.c | 8 ++++----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 784670e2736b..07d1489cd457 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -710,6 +710,8 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  int st_accel_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
> +	struct st_sensors_platform_data *pdata =
> +		(struct st_sensors_platform_data *)adata->dev->platform_data;
>  	int irq = adata->get_irq_data_ready(indio_dev);
>  	int err;
>  
> @@ -736,9 +738,8 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  					&adata->sensor_settings->fs.fs_avl[0];
>  	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
>  
> -	if (!adata->dev->platform_data)
> -		adata->dev->platform_data =
> -			(struct st_sensors_platform_data *)&default_accel_pdata;
> +	if (!pdata)
> +		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
>  
>  	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
>  	if (err < 0)
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 5f2680855552..0d8d5665769a 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -567,6 +567,8 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
>  int st_press_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *press_data = iio_priv(indio_dev);
> +	struct st_sensors_platform_data *pdata =
> +		(struct st_sensors_platform_data *)press_data->dev->platform_data;
>  	int irq = press_data->get_irq_data_ready(indio_dev);
>  	int err;
>  
> @@ -602,10 +604,8 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
>  
>  	/* Some devices don't support a data ready pin. */
> -	if (!press_data->dev->platform_data &&
> -				press_data->sensor_settings->drdy_irq.addr)
> -		press_data->dev->platform_data =
> -			(struct st_sensors_platform_data *)&default_press_pdata;
> +	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
> +		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
>  
>  	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
>  	if (err < 0)
> 

