Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35740 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966389AbcKLQLc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 11:11:32 -0500
Subject: Re: [PATCH 1/2] iio: st_sensors: centralize I2C probe() code
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1478773133-23034-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3761c454-10e5-ba26-bee3-2cc4df5025e0@kernel.org>
Date: Sat, 12 Nov 2016 16:11:14 +0000
MIME-Version: 1.0
In-Reply-To: <1478773133-23034-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/16 10:18, Linus Walleij wrote:
> The probe() calls for the ST Sensors I2C modules were all doing
> pretty much the same things for the different IIO subsubsystems,
> they were all allocating the same state container struct just
> giving different names to the same variable. Move it all to the
> ommon code in st_sensors_i2c.c to avoid code duplication.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Looks fine to me other the missing c in the description above ;)

Would like some input from Denis and / or Giuseppe on this
though (partly as I'm falling asleep so might well miss something!)

Also wondering why we ended up with the divide between generic
and specific where it was rather than as you have it here.
oh well.  Made sense at the time I guess ;)

Jonathan
> ---
>  drivers/iio/accel/st_accel_i2c.c               | 16 +++-----
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 53 +++++++++++++++++---------
>  drivers/iio/gyro/st_gyro_i2c.c                 | 16 +++-----
>  drivers/iio/magnetometer/st_magn_i2c.c         | 16 +++-----
>  drivers/iio/pressure/st_pressure_i2c.c         | 16 +++-----
>  include/linux/iio/common/st_sensors_i2c.h      | 15 ++------
>  6 files changed, 59 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index e9d427a5df7c..1256bb5a59ac 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -92,23 +92,17 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
>  #endif
>  
>  static int st_accel_i2c_probe(struct i2c_client *client,
> -						const struct i2c_device_id *id)
> +			      const struct i2c_device_id *id)
>  {
>  	struct iio_dev *indio_dev;
> -	struct st_sensor_data *adata;
>  	int err;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	adata = iio_priv(indio_dev);
> -	st_sensors_of_i2c_probe(client, st_accel_of_match);
> -
> -	st_sensors_i2c_configure(indio_dev, client, adata);
> +	err = st_sensors_i2c_probe(client, st_accel_of_match, &indio_dev);
> +	if (err)
> +		return err;
>  
>  	err = st_accel_common_probe(indio_dev);
> -	if (err < 0)
> +	if (err)
>  		return err;
>  
>  	return 0;
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index b43aa36031f8..ed6bd865cc0d 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -64,20 +64,6 @@ static const struct st_sensor_transfer_function st_sensors_tf_i2c = {
>  	.read_multiple_byte = st_sensors_i2c_read_multiple_byte,
>  };
>  
> -void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> -		struct i2c_client *client, struct st_sensor_data *sdata)
> -{
> -	i2c_set_clientdata(client, indio_dev);
> -
> -	indio_dev->dev.parent = &client->dev;
> -	indio_dev->name = client->name;
> -
> -	sdata->dev = &client->dev;
> -	sdata->tf = &st_sensors_tf_i2c;
> -	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
> -}
> -EXPORT_SYMBOL(st_sensors_i2c_configure);
> -
>  #ifdef CONFIG_OF
>  /**
>   * st_sensors_of_i2c_probe() - device tree probe for ST I2C sensors
> @@ -91,8 +77,8 @@ EXPORT_SYMBOL(st_sensors_i2c_configure);
>   * rely on that name from this point on. I2C client devices will be renamed
>   * to match the internal kernel convention.
>   */
> -void st_sensors_of_i2c_probe(struct i2c_client *client,
> -			     const struct of_device_id *match)
> +static void st_sensors_of_i2c_probe(struct i2c_client *client,
> +				    const struct of_device_id *match)
>  {
>  	const struct of_device_id *of_id;
>  
> @@ -104,9 +90,42 @@ void st_sensors_of_i2c_probe(struct i2c_client *client,
>  	strncpy(client->name, of_id->data, sizeof(client->name));
>  	client->name[sizeof(client->name) - 1] = '\0';
>  }
> -EXPORT_SYMBOL(st_sensors_of_i2c_probe);
> +#else
> +static void st_sensors_of_i2c_probe(struct i2c_client *client,
> +				    const struct of_device_id *match)
> +{
> +}
>  #endif
>  
> +int st_sensors_i2c_probe(struct i2c_client *client,
> +			 const struct of_device_id *match,
> +			 struct iio_dev **ret_indio_dev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct st_sensor_data *sdata;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sdata));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	sdata = iio_priv(indio_dev);
> +	st_sensors_of_i2c_probe(client, match);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = client->name;
> +
> +	sdata->dev = &client->dev;
> +	sdata->tf = &st_sensors_tf_i2c;
> +	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	*ret_indio_dev = indio_dev;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(st_sensors_i2c_probe);
> +
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics ST-sensors i2c driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> index 40056b821036..2fac5c63c8b3 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -60,23 +60,17 @@ MODULE_DEVICE_TABLE(of, st_gyro_of_match);
>  #endif
>  
>  static int st_gyro_i2c_probe(struct i2c_client *client,
> -						const struct i2c_device_id *id)
> +			     const struct i2c_device_id *id)
>  {
>  	struct iio_dev *indio_dev;
> -	struct st_sensor_data *gdata;
>  	int err;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*gdata));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	gdata = iio_priv(indio_dev);
> -	st_sensors_of_i2c_probe(client, st_gyro_of_match);
> -
> -	st_sensors_i2c_configure(indio_dev, client, gdata);
> +	err = st_sensors_i2c_probe(client, st_gyro_of_match, &indio_dev);
> +	if (err)
> +		return err;
>  
>  	err = st_gyro_common_probe(indio_dev);
> -	if (err < 0)
> +	if (err)
>  		return err;
>  
>  	return 0;
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 8aa37af306ed..7f519d3fa973 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -48,23 +48,17 @@ MODULE_DEVICE_TABLE(of, st_magn_of_match);
>  #endif
>  
>  static int st_magn_i2c_probe(struct i2c_client *client,
> -						const struct i2c_device_id *id)
> +			     const struct i2c_device_id *id)
>  {
>  	struct iio_dev *indio_dev;
> -	struct st_sensor_data *mdata;
>  	int err;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mdata));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	mdata = iio_priv(indio_dev);
> -	st_sensors_of_i2c_probe(client, st_magn_of_match);
> -
> -	st_sensors_i2c_configure(indio_dev, client, mdata);
> +	err = st_sensors_i2c_probe(client, st_magn_of_match, &indio_dev);
> +	if (err)
> +		return err;
>  
>  	err = st_magn_common_probe(indio_dev);
> -	if (err < 0)
> +	if (err)
>  		return err;
>  
>  	return 0;
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index ed18701c68c9..4d78e39c8a2f 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -44,23 +44,17 @@ MODULE_DEVICE_TABLE(of, st_press_of_match);
>  #endif
>  
>  static int st_press_i2c_probe(struct i2c_client *client,
> -						const struct i2c_device_id *id)
> +			      const struct i2c_device_id *id)
>  {
>  	struct iio_dev *indio_dev;
> -	struct st_sensor_data *press_data;
>  	int err;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*press_data));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	press_data = iio_priv(indio_dev);
> -	st_sensors_of_i2c_probe(client, st_press_of_match);
> -
> -	st_sensors_i2c_configure(indio_dev, client, press_data);
> +	err = st_sensors_i2c_probe(client, st_press_of_match, &indio_dev);
> +	if (err)
> +		return err;
>  
>  	err = st_press_common_probe(indio_dev);
> -	if (err < 0)
> +	if (err)
>  		return err;
>  
>  	return 0;
> diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
> index 1796af093368..b0c5342942da 100644
> --- a/include/linux/iio/common/st_sensors_i2c.h
> +++ b/include/linux/iio/common/st_sensors_i2c.h
> @@ -15,17 +15,8 @@
>  #include <linux/iio/common/st_sensors.h>
>  #include <linux/of.h>
>  
> -void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> -		struct i2c_client *client, struct st_sensor_data *sdata);
> -
> -#ifdef CONFIG_OF
> -void st_sensors_of_i2c_probe(struct i2c_client *client,
> -			     const struct of_device_id *match);
> -#else
> -static inline void st_sensors_of_i2c_probe(struct i2c_client *client,
> -					   const struct of_device_id *match)
> -{
> -}
> -#endif
> +int st_sensors_i2c_probe(struct i2c_client *client,
> +			 const struct of_device_id *match,
> +			 struct iio_dev **ret_indio_dev);
>  
>  #endif /* ST_SENSORS_I2C_H */
> 

