Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33097 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275AbcE2PKZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 11:10:25 -0400
Subject: Re: [RFC PATCH v1 9/9] iio:st_sensors: fix power regulator usage
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <66af1630513a8e14900a0257c6c376742a298a86.1461056711.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e26af549-bf94-c86f-918e-e297237f141e@kernel.org>
Date: Sun, 29 May 2016 16:10:22 +0100
MIME-Version: 1.0
In-Reply-To: <66af1630513a8e14900a0257c6c376742a298a86.1461056711.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/16 10:18, Gregor Boirie wrote:
> Ensure failure to enable power regulators is properly handled.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
This looks good to me so I've applied it to the togreg branch of iio.git

Again, this caused a fair bit of fuzz but all looks straight forward.

If you do a series like this in future adding new part support, please put that
new stuff at the end and any fixes / core reworks like this up at the top of
the series.

Whilst better error handling is always good to have, this one doesn't strike
me as suitable material for stable or even necessary to fast track it into
the current cycle.  It's more of a case of making sure we tidy up loose ends
than a 'bug' fix.

Thanks and sorry for the delay with this seris.

Jonathan
> ---
>  drivers/iio/accel/st_accel_core.c               | 12 ++++++----
>  drivers/iio/common/st_sensors/st_sensors_core.c | 29 ++++++++++++++++++++-----
>  drivers/iio/gyro/st_gyro_core.c                 | 12 ++++++----
>  drivers/iio/magnetometer/st_magn_core.c         | 12 ++++++----
>  drivers/iio/pressure/st_pressure_core.c         | 12 ++++++----
>  include/linux/iio/common/st_sensors.h           |  2 +-
>  6 files changed, 57 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index dc73f2d..b8d3c3c 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -757,13 +757,15 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->info = &accel_info;
>  	mutex_init(&adata->tb.buf_lock);
>  
> -	st_sensors_power_enable(indio_dev);
> +	err = st_sensors_power_enable(indio_dev);
> +	if (err)
> +		return err;
>  
>  	err = st_sensors_check_device_support(indio_dev,
>  					ARRAY_SIZE(st_accel_sensors_settings),
>  					st_accel_sensors_settings);
>  	if (err < 0)
> -		return err;
> +		goto st_accel_power_off;
>  
>  	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
>  	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
> @@ -780,11 +782,11 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  
>  	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
>  	if (err < 0)
> -		return err;
> +		goto st_accel_power_off;
>  
>  	err = st_accel_allocate_ring(indio_dev);
>  	if (err < 0)
> -		return err;
> +		goto st_accel_power_off;
>  
>  	if (irq > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
> @@ -807,6 +809,8 @@ st_accel_device_register_error:
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_accel_probe_trigger_error:
>  	st_accel_deallocate_ring(indio_dev);
> +st_accel_power_off:
> +	st_sensors_power_disable(indio_dev);
>  
>  	return err;
>  }
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 6901c7f..286f28c 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -228,7 +228,7 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
>  }
>  EXPORT_SYMBOL(st_sensors_set_axis_enable);
>  
> -void st_sensors_power_enable(struct iio_dev *indio_dev)
> +int st_sensors_power_enable(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *pdata = iio_priv(indio_dev);
>  	int err;
> @@ -237,18 +237,37 @@ void st_sensors_power_enable(struct iio_dev *indio_dev)
>  	pdata->vdd = devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
>  	if (!IS_ERR(pdata->vdd)) {
>  		err = regulator_enable(pdata->vdd);
> -		if (err != 0)
> +		if (err != 0) {
>  			dev_warn(&indio_dev->dev,
>  				 "Failed to enable specified Vdd supply\n");
> +			return err;
> +		}
> +	} else {
> +		err = PTR_ERR(pdata->vdd);
> +		if (err != -ENODEV)
> +			return err;
>  	}
>  
>  	pdata->vdd_io = devm_regulator_get_optional(indio_dev->dev.parent, "vddio");
>  	if (!IS_ERR(pdata->vdd_io)) {
>  		err = regulator_enable(pdata->vdd_io);
> -		if (err != 0)
> +		if (err != 0) {
>  			dev_warn(&indio_dev->dev,
>  				 "Failed to enable specified Vdd_IO supply\n");
> +			goto st_sensors_disable_vdd;
> +		}
> +	} else {
> +		err = PTR_ERR(pdata->vdd_io);
> +		if (err != -ENODEV)
> +			goto st_sensors_disable_vdd;
>  	}
> +
> +	return 0;
> +
> +st_sensors_disable_vdd:
> +	if (!IS_ERR_OR_NULL(pdata->vdd))
> +		regulator_disable(pdata->vdd);
> +	return err;
>  }
>  EXPORT_SYMBOL(st_sensors_power_enable);
>  
> @@ -256,10 +275,10 @@ void st_sensors_power_disable(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *pdata = iio_priv(indio_dev);
>  
> -	if (!IS_ERR(pdata->vdd))
> +	if (!IS_ERR_OR_NULL(pdata->vdd))
>  		regulator_disable(pdata->vdd);
>  
> -	if (!IS_ERR(pdata->vdd_io))
> +	if (!IS_ERR_OR_NULL(pdata->vdd_io))
>  		regulator_disable(pdata->vdd_io);
>  }
>  EXPORT_SYMBOL(st_sensors_power_disable);
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index be9057e..f07f105 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -424,13 +424,15 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->info = &gyro_info;
>  	mutex_init(&gdata->tb.buf_lock);
>  
> -	st_sensors_power_enable(indio_dev);
> +	err = st_sensors_power_enable(indio_dev);
> +	if (err)
> +		return err;
>  
>  	err = st_sensors_check_device_support(indio_dev,
>  					ARRAY_SIZE(st_gyro_sensors_settings),
>  					st_gyro_sensors_settings);
>  	if (err < 0)
> -		return err;
> +		goto st_gyro_power_off;
>  
>  	gdata->num_data_channels = ST_GYRO_NUMBER_DATA_CHANNELS;
>  	gdata->multiread_bit = gdata->sensor_settings->multi_read_bit;
> @@ -444,11 +446,11 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  	err = st_sensors_init_sensor(indio_dev,
>  				(struct st_sensors_platform_data *)&gyro_pdata);
>  	if (err < 0)
> -		return err;
> +		goto st_gyro_power_off;
>  
>  	err = st_gyro_allocate_ring(indio_dev);
>  	if (err < 0)
> -		return err;
> +		goto st_gyro_power_off;
>  
>  	if (irq > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
> @@ -471,6 +473,8 @@ st_gyro_device_register_error:
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_gyro_probe_trigger_error:
>  	st_gyro_deallocate_ring(indio_dev);
> +st_gyro_power_off:
> +	st_sensors_power_disable(indio_dev);
>  
>  	return err;
>  }
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 62036d2..7c94adc 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -588,13 +588,15 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->info = &magn_info;
>  	mutex_init(&mdata->tb.buf_lock);
>  
> -	st_sensors_power_enable(indio_dev);
> +	err = st_sensors_power_enable(indio_dev);
> +	if (err)
> +		return err;
>  
>  	err = st_sensors_check_device_support(indio_dev,
>  					ARRAY_SIZE(st_magn_sensors_settings),
>  					st_magn_sensors_settings);
>  	if (err < 0)
> -		return err;
> +		goto st_magn_power_off;
>  
>  	mdata->num_data_channels = ST_MAGN_NUMBER_DATA_CHANNELS;
>  	mdata->multiread_bit = mdata->sensor_settings->multi_read_bit;
> @@ -607,11 +609,11 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  
>  	err = st_sensors_init_sensor(indio_dev, NULL);
>  	if (err < 0)
> -		return err;
> +		goto st_magn_power_off;
>  
>  	err = st_magn_allocate_ring(indio_dev);
>  	if (err < 0)
> -		return err;
> +		goto st_magn_power_off;
>  
>  	if (irq > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
> @@ -634,6 +636,8 @@ st_magn_device_register_error:
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_magn_probe_trigger_error:
>  	st_magn_deallocate_ring(indio_dev);
> +st_magn_power_off:
> +	st_sensors_power_disable(indio_dev);
>  
>  	return err;
>  }
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index bacdf6c..4b01b19 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -588,13 +588,15 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->info = &press_info;
>  	mutex_init(&press_data->tb.buf_lock);
>  
> -	st_sensors_power_enable(indio_dev);
> +	err = st_sensors_power_enable(indio_dev);
> +	if (err)
> +		return err;
>  
>  	err = st_sensors_check_device_support(indio_dev,
>  					ARRAY_SIZE(st_press_sensors_settings),
>  					st_press_sensors_settings);
>  	if (err < 0)
> -		return err;
> +		goto st_press_power_off;
>  
>  	press_data->num_data_channels = press_data->sensor_settings->num_ch - 1;
>  	press_data->multiread_bit = press_data->sensor_settings->multi_read_bit;
> @@ -615,11 +617,11 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  
>  	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
>  	if (err < 0)
> -		return err;
> +		goto st_press_power_off;
>  
>  	err = st_press_allocate_ring(indio_dev);
>  	if (err < 0)
> -		return err;
> +		goto st_press_power_off;
>  
>  	if (irq > 0) {
>  		err = st_sensors_allocate_trigger(indio_dev,
> @@ -642,6 +644,8 @@ st_press_device_register_error:
>  		st_sensors_deallocate_trigger(indio_dev);
>  st_press_probe_trigger_error:
>  	st_press_deallocate_ring(indio_dev);
> +st_press_power_off:
> +	st_sensors_power_disable(indio_dev);
>  
>  	return err;
>  }
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 78a1934..91d5f68 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -278,7 +278,7 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable);
>  
>  int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
>  
> -void st_sensors_power_enable(struct iio_dev *indio_dev);
> +int st_sensors_power_enable(struct iio_dev *indio_dev);
>  
>  void st_sensors_power_disable(struct iio_dev *indio_dev);
>  
> 

