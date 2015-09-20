Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49991 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbbITKyX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 06:54:23 -0400
Subject: Re: [RESEND PATCH 3/4] iio: st_sensors: add debugfs register read
 hook
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1442303377-11858-1-git-send-email-linus.walleij@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FE905E.7070604@kernel.org>
Date: Sun, 20 Sep 2015 11:54:22 +0100
MIME-Version: 1.0
In-Reply-To: <1442303377-11858-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/09/15 08:49, Linus Walleij wrote:
> This adds a debugfs hook to read/write registers in the ST
> sensors using debugfs. Proved to be awesome help when trying
> to debug why IRQs do not arrive.
> 
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
This one is already in my tree as well. Will be doing a pull shortly
so should turn up in linux next fairly soon.

Jonathan
> ---
> ChangeLog v1->v2:
> - User &ampersand i front of function name for debugfs helper
> - EXPORT the debugfs regread symbol so modules work
> ---
>  drivers/iio/accel/st_accel_core.c               |  1 +
>  drivers/iio/common/st_sensors/st_sensors_core.c | 22 ++++++++++++++++++++++
>  drivers/iio/gyro/st_gyro_core.c                 |  1 +
>  drivers/iio/magnetometer/st_magn_core.c         |  1 +
>  drivers/iio/pressure/st_pressure_core.c         |  1 +
>  include/linux/iio/common/st_sensors.h           |  4 ++++
>  6 files changed, 30 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index b9a7b5c7c5e7..44321ded84cd 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -618,6 +618,7 @@ static const struct iio_info accel_info = {
>  	.attrs = &st_accel_attribute_group,
>  	.read_raw = &st_accel_read_raw,
>  	.write_raw = &st_accel_write_raw,
> +	.debugfs_reg_access = &st_sensors_debugfs_reg_access,
>  };
>  
>  #ifdef CONFIG_IIO_TRIGGER
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 2e7fdb502645..25258e2c1a82 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -44,6 +44,28 @@ st_sensors_write_data_with_mask_error:
>  	return err;
>  }
>  
> +int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
> +				  unsigned reg, unsigned writeval,
> +				  unsigned *readval)
> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	u8 readdata;
> +	int err;
> +
> +	if (!readval)
> +		return sdata->tf->write_byte(&sdata->tb, sdata->dev,
> +					     (u8)reg, (u8)writeval);
> +
> +	err = sdata->tf->read_byte(&sdata->tb, sdata->dev, (u8)reg, &readdata);
> +	if (err < 0)
> +		return err;
> +
> +	*readval = (unsigned)readdata;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(st_sensors_debugfs_reg_access);
> +
>  static int st_sensors_match_odr(struct st_sensor_settings *sensor_settings,
>  			unsigned int odr, struct st_sensor_odr_avl *odr_out)
>  {
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 4b993a5bc9a1..02eddcebeea3 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -383,6 +383,7 @@ static const struct iio_info gyro_info = {
>  	.attrs = &st_gyro_attribute_group,
>  	.read_raw = &st_gyro_read_raw,
>  	.write_raw = &st_gyro_write_raw,
> +	.debugfs_reg_access = &st_sensors_debugfs_reg_access,
>  };
>  
>  #ifdef CONFIG_IIO_TRIGGER
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index f8dc4b85d70c..b27f0146647b 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -560,6 +560,7 @@ static const struct iio_info magn_info = {
>  	.attrs = &st_magn_attribute_group,
>  	.read_raw = &st_magn_read_raw,
>  	.write_raw = &st_magn_write_raw,
> +	.debugfs_reg_access = &st_sensors_debugfs_reg_access,
>  };
>  
>  #ifdef CONFIG_IIO_TRIGGER
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index eb41d2b92c24..b39a2fb0671c 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -400,6 +400,7 @@ static const struct iio_info press_info = {
>  	.attrs = &st_press_attribute_group,
>  	.read_raw = &st_press_read_raw,
>  	.write_raw = &st_press_write_raw,
> +	.debugfs_reg_access = &st_sensors_debugfs_reg_access,
>  };
>  
>  #ifdef CONFIG_IIO_TRIGGER
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 3c17cd7fdf06..2fe939c73cd2 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -271,6 +271,10 @@ void st_sensors_power_enable(struct iio_dev *indio_dev);
>  
>  void st_sensors_power_disable(struct iio_dev *indio_dev);
>  
> +int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
> +				  unsigned reg, unsigned writeval,
> +				  unsigned *readval);
> +
>  int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr);
>  
>  int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
> 

