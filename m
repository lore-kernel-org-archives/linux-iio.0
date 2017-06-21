Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdFUTyr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 15:54:47 -0400
Date: Wed, 21 Jun 2017 20:54:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: common: st_sensors: move
 st_sensors_of_i2c_probe() in common code
Message-ID: <20170621205442.7e830422@kernel.org>
In-Reply-To: <20170620195212.23213-2-lorenzo.bianconi@st.com>
References: <20170620195212.23213-1-lorenzo.bianconi@st.com>
        <20170620195212.23213-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Jun 2017 21:52:08 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Move st_sensors_of_i2c_probe() in st_sensors_core and rename it in
> st_sensors_of_name_probe(). That change is necessary to add device-tree
> support in spi code otherwise the rest of the autodetection will fail
> since spi->modalias (and indio_dev->name) will be set using compatible
> string value that differs from standard sensor name
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Sensible bit of refactoring and future proofing. Hence I've taken
this now. Applied to the togreg branch of iio.git - pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/st_accel_i2c.c                |  3 ++-
>  drivers/iio/common/st_sensors/st_sensors_core.c | 31 +++++++++++++++++++++++++
>  drivers/iio/common/st_sensors/st_sensors_i2c.c  | 29 -----------------------
>  drivers/iio/gyro/st_gyro_i2c.c                  |  3 ++-
>  drivers/iio/magnetometer/st_magn_i2c.c          |  3 ++-
>  drivers/iio/pressure/st_pressure_i2c.c          |  3 ++-
>  include/linux/iio/common/st_sensors.h           | 12 ++++++++++
>  include/linux/iio/common/st_sensors_i2c.h       | 10 --------
>  8 files changed, 51 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 543f0ad7fd7e..ac67826135be 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -144,7 +144,8 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  	adata = iio_priv(indio_dev);
>  
>  	if (client->dev.of_node) {
> -		st_sensors_of_i2c_probe(client, st_accel_of_match);
> +		st_sensors_of_name_probe(&client->dev, st_accel_of_match,
> +					 client->name, sizeof(client->name));
>  	} else if (ACPI_HANDLE(&client->dev)) {
>  		ret = st_sensors_match_acpi_device(&client->dev);
>  		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 79c8c7cd70d5..274868100fd0 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <asm/unaligned.h>
>  #include <linux/iio/common/st_sensors.h>
>  
> @@ -345,6 +346,36 @@ static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
>  
>  	return pdata;
>  }
> +
> +/**
> + * st_sensors_of_name_probe() - device tree probe for ST sensor name
> + * @dev: driver model representation of the device.
> + * @match: the OF match table for the device, containing compatible strings
> + *	but also a .data field with the corresponding internal kernel name
> + *	used by this sensor.
> + * @name: device name buffer reference.
> + * @len: device name buffer length.
> + *
> + * In effect this function matches a compatible string to an internal kernel
> + * name for a certain sensor device, so that the rest of the autodetection can
> + * rely on that name from this point on. I2C/SPI devices will be renamed
> + * to match the internal kernel convention.
> + */
> +void st_sensors_of_name_probe(struct device *dev,
> +			      const struct of_device_id *match,
> +			      char *name, int len)
> +{
> +	const struct of_device_id *of_id;
> +
> +	of_id = of_match_device(match, dev);
> +	if (!of_id || !of_id->data)
> +		return;
> +
> +	/* The name from the OF match takes precedence if present */
> +	strncpy(name, of_id->data, len);
> +	name[len - 1] = '\0';
> +}
> +EXPORT_SYMBOL(st_sensors_of_name_probe);
>  #else
>  static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
>  		struct st_sensors_platform_data *defdata)
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index c83df4dbfcd7..b81e48e9f27e 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -79,35 +79,6 @@ void st_sensors_i2c_configure(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL(st_sensors_i2c_configure);
>  
> -#ifdef CONFIG_OF
> -/**
> - * st_sensors_of_i2c_probe() - device tree probe for ST I2C sensors
> - * @client: the I2C client device for the sensor
> - * @match: the OF match table for the device, containing compatible strings
> - *	but also a .data field with the corresponding internal kernel name
> - *	used by this sensor.
> - *
> - * In effect this function matches a compatible string to an internal kernel
> - * name for a certain sensor device, so that the rest of the autodetection can
> - * rely on that name from this point on. I2C client devices will be renamed
> - * to match the internal kernel convention.
> - */
> -void st_sensors_of_i2c_probe(struct i2c_client *client,
> -			     const struct of_device_id *match)
> -{
> -	const struct of_device_id *of_id;
> -
> -	of_id = of_match_device(match, &client->dev);
> -	if (!of_id)
> -		return;
> -
> -	/* The name from the OF match takes precedence if present */
> -	strncpy(client->name, of_id->data, sizeof(client->name));
> -	client->name[sizeof(client->name) - 1] = '\0';
> -}
> -EXPORT_SYMBOL(st_sensors_of_i2c_probe);
> -#endif
> -
>  #ifdef CONFIG_ACPI
>  int st_sensors_match_acpi_device(struct device *dev)
>  {
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> index 3f628746cb93..b405b82b9177 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -75,7 +75,8 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	gdata = iio_priv(indio_dev);
> -	st_sensors_of_i2c_probe(client, st_gyro_of_match);
> +	st_sensors_of_name_probe(&client->dev, st_gyro_of_match,
> +				 client->name, sizeof(client->name));
>  
>  	st_sensors_i2c_configure(indio_dev, client, gdata);
>  
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 8aa37af306ed..6a6c8121ac2c 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -59,7 +59,8 @@ static int st_magn_i2c_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	mdata = iio_priv(indio_dev);
> -	st_sensors_of_i2c_probe(client, st_magn_of_match);
> +	st_sensors_of_name_probe(&client->dev, st_magn_of_match,
> +				 client->name, sizeof(client->name));
>  
>  	st_sensors_i2c_configure(indio_dev, client, mdata);
>  
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index 17417a4d5a5f..7f15e927fa2b 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -77,7 +77,8 @@ static int st_press_i2c_probe(struct i2c_client *client,
>  	press_data = iio_priv(indio_dev);
>  
>  	if (client->dev.of_node) {
> -		st_sensors_of_i2c_probe(client, st_press_of_match);
> +		st_sensors_of_name_probe(&client->dev, st_press_of_match,
> +					 client->name, sizeof(client->name));
>  	} else if (ACPI_HANDLE(&client->dev)) {
>  		ret = st_sensors_match_acpi_device(&client->dev);
>  		if ((ret < 0) || (ret >= ST_PRESS_MAX))
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 497f2b3a5a62..1f8211b6438b 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -325,4 +325,16 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
>  ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf);
>  
> +#ifdef CONFIG_OF
> +void st_sensors_of_name_probe(struct device *dev,
> +			      const struct of_device_id *match,
> +			      char *name, int len);
> +#else
> +static inline void st_sensors_of_name_probe(struct device *dev,
> +					    const struct of_device_id *match,
> +					    char *name, int len)
> +{
> +}
> +#endif
> +
>  #endif /* ST_SENSORS_H */
> diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
> index 254de3c7dde8..0a2c25e06d1f 100644
> --- a/include/linux/iio/common/st_sensors_i2c.h
> +++ b/include/linux/iio/common/st_sensors_i2c.h
> @@ -18,16 +18,6 @@
>  void st_sensors_i2c_configure(struct iio_dev *indio_dev,
>  		struct i2c_client *client, struct st_sensor_data *sdata);
>  
> -#ifdef CONFIG_OF
> -void st_sensors_of_i2c_probe(struct i2c_client *client,
> -			     const struct of_device_id *match);
> -#else
> -static inline void st_sensors_of_i2c_probe(struct i2c_client *client,
> -					   const struct of_device_id *match)
> -{
> -}
> -#endif
> -
>  #ifdef CONFIG_ACPI
>  int st_sensors_match_acpi_device(struct device *dev);
>  #else

