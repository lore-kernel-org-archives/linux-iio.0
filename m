Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57403 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaJDK0R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 06:26:17 -0400
Message-ID: <542FCB47.8040500@kernel.org>
Date: Sat, 04 Oct 2014 11:26:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/7] iio:pressure: Changed pressure data variable name
 to press_data
References: <1412350541-29431-1-git-send-email-denis.ciocca@st.com> <1412350541-29431-6-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1412350541-29431-6-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 16:35, Denis CIOCCA wrote:
> This patch fix pressure data variable name. Usually pdata name
> it is used for platform data.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied
> ---
>  drivers/iio/pressure/st_pressure_buffer.c | 12 +++++-----
>  drivers/iio/pressure/st_pressure_core.c   | 40 ++++++++++++++++---------------
>  drivers/iio/pressure/st_pressure_i2c.c    | 10 ++++----
>  drivers/iio/pressure/st_pressure_spi.c    | 10 ++++----
>  4 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
> index b37b1c9..2ff53f2 100644
> --- a/drivers/iio/pressure/st_pressure_buffer.c
> +++ b/drivers/iio/pressure/st_pressure_buffer.c
> @@ -38,10 +38,10 @@ static int st_press_buffer_preenable(struct iio_dev *indio_dev)
>  static int st_press_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	int err;
> -	struct st_sensor_data *pdata = iio_priv(indio_dev);
> +	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  
> -	pdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (pdata->buffer_data == NULL) {
> +	press_data->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	if (press_data->buffer_data == NULL) {
>  		err = -ENOMEM;
>  		goto allocate_memory_error;
>  	}
> @@ -53,7 +53,7 @@ static int st_press_buffer_postenable(struct iio_dev *indio_dev)
>  	return err;
>  
>  st_press_buffer_postenable_error:
> -	kfree(pdata->buffer_data);
> +	kfree(press_data->buffer_data);
>  allocate_memory_error:
>  	return err;
>  }
> @@ -61,7 +61,7 @@ allocate_memory_error:
>  static int st_press_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	int err;
> -	struct st_sensor_data *pdata = iio_priv(indio_dev);
> +	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  
>  	err = iio_triggered_buffer_predisable(indio_dev);
>  	if (err < 0)
> @@ -70,7 +70,7 @@ static int st_press_buffer_predisable(struct iio_dev *indio_dev)
>  	err = st_sensors_set_enable(indio_dev, false);
>  
>  st_press_buffer_predisable_error:
> -	kfree(pdata->buffer_data);
> +	kfree(press_data->buffer_data);
>  	return err;
>  }
>  
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index ee2ef7d..97baf40d 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -333,7 +333,7 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
>  							int *val2, long mask)
>  {
>  	int err;
> -	struct st_sensor_data *pdata = iio_priv(indio_dev);
> +	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -347,10 +347,10 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
>  
>  		switch (ch->type) {
>  		case IIO_PRESSURE:
> -			*val2 = pdata->current_fullscale->gain;
> +			*val2 = press_data->current_fullscale->gain;
>  			break;
>  		case IIO_TEMP:
> -			*val2 = pdata->current_fullscale->gain2;
> +			*val2 = press_data->current_fullscale->gain2;
>  			break;
>  		default:
>  			err = -EINVAL;
> @@ -371,7 +371,7 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_FRACTIONAL;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = pdata->odr;
> +		*val = press_data->odr;
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -411,8 +411,8 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
>  
>  int st_press_common_probe(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *pdata = iio_priv(indio_dev);
> -	int irq = pdata->get_irq_data_ready(indio_dev);
> +	struct st_sensor_data *press_data = iio_priv(indio_dev);
> +	int irq = press_data->get_irq_data_ready(indio_dev);
>  	int err;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -426,23 +426,25 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		return err;
>  
> -	pdata->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
> -	pdata->multiread_bit = pdata->sensor_settings->multi_read_bit;
> -	indio_dev->channels = pdata->sensor_settings->ch;
> -	indio_dev->num_channels = pdata->sensor_settings->num_ch;
> +	press_data->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
> +	press_data->multiread_bit = press_data->sensor_settings->multi_read_bit;
> +	indio_dev->channels = press_data->sensor_settings->ch;
> +	indio_dev->num_channels = press_data->sensor_settings->num_ch;
>  
> -	if (pdata->sensor_settings->fs.addr != 0)
> -		pdata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -			&pdata->sensor_settings->fs.fs_avl[0];
> +	if (press_data->sensor_settings->fs.addr != 0)
> +		press_data->current_fullscale =
> +			(struct st_sensor_fullscale_avl *)
> +				&press_data->sensor_settings->fs.fs_avl[0];
>  
> -	pdata->odr = pdata->sensor_settings->odr.odr_avl[0].hz;
> +	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
>  
>  	/* Some devices don't support a data ready pin. */
> -	if (!pdata->dev->platform_data && pdata->sensor_settings->drdy_irq.addr)
> -		pdata->dev->platform_data =
> +	if (!press_data->dev->platform_data &&
> +				press_data->sensor_settings->drdy_irq.addr)
> +		press_data->dev->platform_data =
>  			(struct st_sensors_platform_data *)&default_press_pdata;
>  
> -	err = st_sensors_init_sensor(indio_dev, pdata->dev->platform_data);
> +	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
>  	if (err < 0)
>  		return err;
>  
> @@ -478,12 +480,12 @@ EXPORT_SYMBOL(st_press_common_probe);
>  
>  void st_press_common_remove(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *pdata = iio_priv(indio_dev);
> +	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  
>  	st_sensors_power_disable(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (pdata->get_irq_data_ready(indio_dev) > 0)
> +	if (press_data->get_irq_data_ready(indio_dev) > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
>  
>  	st_press_deallocate_ring(indio_dev);
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index dd73351..8859e93 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -43,18 +43,18 @@ static int st_press_i2c_probe(struct i2c_client *client,
>  						const struct i2c_device_id *id)
>  {
>  	struct iio_dev *indio_dev;
> -	struct st_sensor_data *pdata;
> +	struct st_sensor_data *press_data;
>  	int err;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*pdata));
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*press_data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	pdata = iio_priv(indio_dev);
> -	pdata->dev = &client->dev;
> +	press_data = iio_priv(indio_dev);
> +	press_data->dev = &client->dev;
>  	st_sensors_of_i2c_probe(client, st_press_of_match);
>  
> -	st_sensors_i2c_configure(indio_dev, client, pdata);
> +	st_sensors_i2c_configure(indio_dev, client, press_data);
>  
>  	err = st_press_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index 98c3e8e..10c9624 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -21,17 +21,17 @@
>  static int st_press_spi_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> -	struct st_sensor_data *pdata;
> +	struct st_sensor_data *press_data;
>  	int err;
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*pdata));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*press_data));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
> -	pdata = iio_priv(indio_dev);
> -	pdata->dev = &spi->dev;
> +	press_data = iio_priv(indio_dev);
> +	press_data->dev = &spi->dev;
>  
> -	st_sensors_spi_configure(indio_dev, spi, pdata);
> +	st_sensors_spi_configure(indio_dev, spi, press_data);
>  
>  	err = st_press_common_probe(indio_dev);
>  	if (err < 0)
> 
