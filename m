Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57390 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaJDKYY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 06:24:24 -0400
Message-ID: <542FCAD6.1080403@kernel.org>
Date: Sat, 04 Oct 2014 11:24:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/7] iio:imu: changed structure name from st_sensors to
 st_sensor_settings
References: <1412350541-29431-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1412350541-29431-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 16:35, Denis CIOCCA wrote:
> This patch change structure name and related variables names.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
That's a better name choice.  However, you should have made it clear somewhere
that that is the change for this new patch series!

Applied to the togreg branch of iio.git initially pushed out as testing
for the autobuilders to play.
> ---
>  drivers/iio/accel/st_accel_core.c               |  13 +--
>  drivers/iio/common/st_sensors/st_sensors_core.c | 126 +++++++++++++-----------
>  drivers/iio/gyro/st_gyro_core.c                 |  13 +--
>  drivers/iio/magnetometer/st_magn_core.c         |  13 +--
>  drivers/iio/pressure/st_pressure_core.c         |  20 ++--
>  include/linux/iio/common/st_sensors.h           |  10 +-
>  6 files changed, 104 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 0878648..7cbdfae 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -161,7 +161,7 @@ static const struct iio_chan_spec st_accel_16bit_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3)
>  };
>  
> -static const struct st_sensors st_accel_sensors[] = {
> +static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  	{
>  		.wai = ST_ACCEL_1_WAI_EXP,
>  		.sensors_supported = {
> @@ -470,18 +470,19 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
>  	st_sensors_power_enable(indio_dev);
>  
>  	err = st_sensors_check_device_support(indio_dev,
> -				ARRAY_SIZE(st_accel_sensors), st_accel_sensors);
> +					ARRAY_SIZE(st_accel_sensors_settings),
> +					st_accel_sensors_settings);
>  	if (err < 0)
>  		return err;
>  
>  	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
> -	adata->multiread_bit = adata->sensor->multi_read_bit;
> -	indio_dev->channels = adata->sensor->ch;
> +	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
> +	indio_dev->channels = adata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
>  	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -						&adata->sensor->fs.fs_avl[0];
> -	adata->odr = adata->sensor->odr.odr_avl[0].hz;
> +					&adata->sensor_settings->fs.fs_avl[0];
> +	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
>  
>  	if (!plat_data)
>  		plat_data =
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 24cfe4e..edd13d2 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -44,18 +44,18 @@ st_sensors_write_data_with_mask_error:
>  	return err;
>  }
>  
> -static int st_sensors_match_odr(struct st_sensors *sensor,
> +static int st_sensors_match_odr(struct st_sensor_settings *sensor_settings,
>  			unsigned int odr, struct st_sensor_odr_avl *odr_out)
>  {
>  	int i, ret = -EINVAL;
>  
>  	for (i = 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
> -		if (sensor->odr.odr_avl[i].hz == 0)
> +		if (sensor_settings->odr.odr_avl[i].hz == 0)
>  			goto st_sensors_match_odr_error;
>  
> -		if (sensor->odr.odr_avl[i].hz == odr) {
> -			odr_out->hz = sensor->odr.odr_avl[i].hz;
> -			odr_out->value = sensor->odr.odr_avl[i].value;
> +		if (sensor_settings->odr.odr_avl[i].hz == odr) {
> +			odr_out->hz = sensor_settings->odr.odr_avl[i].hz;
> +			odr_out->value = sensor_settings->odr.odr_avl[i].value;
>  			ret = 0;
>  			break;
>  		}
> @@ -71,23 +71,26 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
>  	struct st_sensor_odr_avl odr_out = {0, 0};
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> -	err = st_sensors_match_odr(sdata->sensor, odr, &odr_out);
> +	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);
>  	if (err < 0)
>  		goto st_sensors_match_odr_error;
>  
> -	if ((sdata->sensor->odr.addr == sdata->sensor->pw.addr) &&
> -			(sdata->sensor->odr.mask == sdata->sensor->pw.mask)) {
> +	if ((sdata->sensor_settings->odr.addr ==
> +					sdata->sensor_settings->pw.addr) &&
> +				(sdata->sensor_settings->odr.mask ==
> +					sdata->sensor_settings->pw.mask)) {
>  		if (sdata->enabled == true) {
>  			err = st_sensors_write_data_with_mask(indio_dev,
> -				sdata->sensor->odr.addr,
> -				sdata->sensor->odr.mask,
> +				sdata->sensor_settings->odr.addr,
> +				sdata->sensor_settings->odr.mask,
>  				odr_out.value);
>  		} else {
>  			err = 0;
>  		}
>  	} else {
>  		err = st_sensors_write_data_with_mask(indio_dev,
> -			sdata->sensor->odr.addr, sdata->sensor->odr.mask,
> +			sdata->sensor_settings->odr.addr,
> +			sdata->sensor_settings->odr.mask,
>  			odr_out.value);
>  	}
>  	if (err >= 0)
> @@ -98,16 +101,16 @@ st_sensors_match_odr_error:
>  }
>  EXPORT_SYMBOL(st_sensors_set_odr);
>  
> -static int st_sensors_match_fs(struct st_sensors *sensor,
> +static int st_sensors_match_fs(struct st_sensor_settings *sensor_settings,
>  					unsigned int fs, int *index_fs_avl)
>  {
>  	int i, ret = -EINVAL;
>  
>  	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
> -		if (sensor->fs.fs_avl[i].num == 0)
> +		if (sensor_settings->fs.fs_avl[i].num == 0)
>  			goto st_sensors_match_odr_error;
>  
> -		if (sensor->fs.fs_avl[i].num == fs) {
> +		if (sensor_settings->fs.fs_avl[i].num == fs) {
>  			*index_fs_avl = i;
>  			ret = 0;
>  			break;
> @@ -118,25 +121,24 @@ st_sensors_match_odr_error:
>  	return ret;
>  }
>  
> -static int st_sensors_set_fullscale(struct iio_dev *indio_dev,
> -								unsigned int fs)
> +static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
>  {
>  	int err, i = 0;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> -	err = st_sensors_match_fs(sdata->sensor, fs, &i);
> +	err = st_sensors_match_fs(sdata->sensor_settings, fs, &i);
>  	if (err < 0)
>  		goto st_accel_set_fullscale_error;
>  
>  	err = st_sensors_write_data_with_mask(indio_dev,
> -				sdata->sensor->fs.addr,
> -				sdata->sensor->fs.mask,
> -				sdata->sensor->fs.fs_avl[i].value);
> +				sdata->sensor_settings->fs.addr,
> +				sdata->sensor_settings->fs.mask,
> +				sdata->sensor_settings->fs.fs_avl[i].value);
>  	if (err < 0)
>  		goto st_accel_set_fullscale_error;
>  
>  	sdata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -						&sdata->sensor->fs.fs_avl[i];
> +					&sdata->sensor_settings->fs.fs_avl[i];
>  	return err;
>  
>  st_accel_set_fullscale_error:
> @@ -153,10 +155,12 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
>  	if (enable) {
> -		tmp_value = sdata->sensor->pw.value_on;
> -		if ((sdata->sensor->odr.addr == sdata->sensor->pw.addr) &&
> -			(sdata->sensor->odr.mask == sdata->sensor->pw.mask)) {
> -			err = st_sensors_match_odr(sdata->sensor,
> +		tmp_value = sdata->sensor_settings->pw.value_on;
> +		if ((sdata->sensor_settings->odr.addr ==
> +					sdata->sensor_settings->pw.addr) &&
> +				(sdata->sensor_settings->odr.mask ==
> +					sdata->sensor_settings->pw.mask)) {
> +			err = st_sensors_match_odr(sdata->sensor_settings,
>  							sdata->odr, &odr_out);
>  			if (err < 0)
>  				goto set_enable_error;
> @@ -164,8 +168,8 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
>  			found = true;
>  		}
>  		err = st_sensors_write_data_with_mask(indio_dev,
> -				sdata->sensor->pw.addr,
> -				sdata->sensor->pw.mask, tmp_value);
> +				sdata->sensor_settings->pw.addr,
> +				sdata->sensor_settings->pw.mask, tmp_value);
>  		if (err < 0)
>  			goto set_enable_error;
>  
> @@ -175,9 +179,9 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
>  			sdata->odr = odr_out.hz;
>  	} else {
>  		err = st_sensors_write_data_with_mask(indio_dev,
> -				sdata->sensor->pw.addr,
> -				sdata->sensor->pw.mask,
> -				sdata->sensor->pw.value_off);
> +				sdata->sensor_settings->pw.addr,
> +				sdata->sensor_settings->pw.mask,
> +				sdata->sensor_settings->pw.value_off);
>  		if (err < 0)
>  			goto set_enable_error;
>  
> @@ -194,8 +198,9 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
>  	return st_sensors_write_data_with_mask(indio_dev,
> -				sdata->sensor->enable_axis.addr,
> -				sdata->sensor->enable_axis.mask, axis_enable);
> +				sdata->sensor_settings->enable_axis.addr,
> +				sdata->sensor_settings->enable_axis.mask,
> +				axis_enable);
>  }
>  EXPORT_SYMBOL(st_sensors_set_axis_enable);
>  
> @@ -236,13 +241,13 @@ void st_sensors_power_disable(struct iio_dev *indio_dev)
>  EXPORT_SYMBOL(st_sensors_power_disable);
>  
>  static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
> -				       struct st_sensors_platform_data *pdata)
> +					struct st_sensors_platform_data *pdata)
>  {
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
>  	switch (pdata->drdy_int_pin) {
>  	case 1:
> -		if (sdata->sensor->drdy_irq.mask_int1 == 0) {
> +		if (sdata->sensor_settings->drdy_irq.mask_int1 == 0) {
>  			dev_err(&indio_dev->dev,
>  					"DRDY on INT1 not available.\n");
>  			return -EINVAL;
> @@ -250,7 +255,7 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
>  		sdata->drdy_int_pin = 1;
>  		break;
>  	case 2:
> -		if (sdata->sensor->drdy_irq.mask_int2 == 0) {
> +		if (sdata->sensor_settings->drdy_irq.mask_int2 == 0) {
>  			dev_err(&indio_dev->dev,
>  					"DRDY on INT2 not available.\n");
>  			return -EINVAL;
> @@ -318,7 +323,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  
>  	if (sdata->current_fullscale) {
>  		err = st_sensors_set_fullscale(indio_dev,
> -					       sdata->current_fullscale->num);
> +						sdata->current_fullscale->num);
>  		if (err < 0)
>  			return err;
>  	} else
> @@ -330,7 +335,8 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  
>  	/* set BDU */
>  	err = st_sensors_write_data_with_mask(indio_dev,
> -			sdata->sensor->bdu.addr, sdata->sensor->bdu.mask, true);
> +					sdata->sensor_settings->bdu.addr,
> +					sdata->sensor_settings->bdu.mask, true);
>  	if (err < 0)
>  		return err;
>  
> @@ -346,26 +352,28 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
>  	u8 drdy_mask;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> -	if (!sdata->sensor->drdy_irq.addr)
> +	if (!sdata->sensor_settings->drdy_irq.addr)
>  		return 0;
>  
>  	/* Enable/Disable the interrupt generator 1. */
> -	if (sdata->sensor->drdy_irq.ig1.en_addr > 0) {
> +	if (sdata->sensor_settings->drdy_irq.ig1.en_addr > 0) {
>  		err = st_sensors_write_data_with_mask(indio_dev,
> -			sdata->sensor->drdy_irq.ig1.en_addr,
> -			sdata->sensor->drdy_irq.ig1.en_mask, (int)enable);
> +				sdata->sensor_settings->drdy_irq.ig1.en_addr,
> +				sdata->sensor_settings->drdy_irq.ig1.en_mask,
> +				(int)enable);
>  		if (err < 0)
>  			goto st_accel_set_dataready_irq_error;
>  	}
>  
>  	if (sdata->drdy_int_pin == 1)
> -		drdy_mask = sdata->sensor->drdy_irq.mask_int1;
> +		drdy_mask = sdata->sensor_settings->drdy_irq.mask_int1;
>  	else
> -		drdy_mask = sdata->sensor->drdy_irq.mask_int2;
> +		drdy_mask = sdata->sensor_settings->drdy_irq.mask_int2;
>  
>  	/* Enable/Disable the interrupt generator for data ready. */
>  	err = st_sensors_write_data_with_mask(indio_dev,
> -			sdata->sensor->drdy_irq.addr, drdy_mask, (int)enable);
> +					sdata->sensor_settings->drdy_irq.addr,
> +					drdy_mask, (int)enable);
>  
>  st_accel_set_dataready_irq_error:
>  	return err;
> @@ -378,8 +386,8 @@ int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale)
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
>  	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
> -		if ((sdata->sensor->fs.fs_avl[i].gain == scale) &&
> -				(sdata->sensor->fs.fs_avl[i].gain != 0)) {
> +		if ((sdata->sensor_settings->fs.fs_avl[i].gain == scale) &&
> +				(sdata->sensor_settings->fs.fs_avl[i].gain != 0)) {
>  			err = 0;
>  			break;
>  		}
> @@ -388,7 +396,7 @@ int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale)
>  		goto st_sensors_match_scale_error;
>  
>  	err = st_sensors_set_fullscale(indio_dev,
> -					sdata->sensor->fs.fs_avl[i].num);
> +				sdata->sensor_settings->fs.fs_avl[i].num);
>  
>  st_sensors_match_scale_error:
>  	return err;
> @@ -439,7 +447,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
>  		if (err < 0)
>  			goto out;
>  
> -		msleep((sdata->sensor->bootime * 1000) / sdata->odr);
> +		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
>  		err = st_sensors_read_axis_data(indio_dev, ch, val);
>  		if (err < 0)
>  			goto out;
> @@ -456,7 +464,8 @@ out:
>  EXPORT_SYMBOL(st_sensors_read_info_raw);
>  
>  int st_sensors_check_device_support(struct iio_dev *indio_dev,
> -			int num_sensors_list, const struct st_sensors *sensors)
> +			int num_sensors_list,
> +			const struct st_sensor_settings *sensor_settings)
>  {
>  	u8 wai;
>  	int i, n, err;
> @@ -470,23 +479,24 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
>  	}
>  
>  	for (i = 0; i < num_sensors_list; i++) {
> -		if (sensors[i].wai == wai)
> +		if (sensor_settings[i].wai == wai)
>  			break;
>  	}
>  	if (i == num_sensors_list)
>  		goto device_not_supported;
>  
> -	for (n = 0; n < ARRAY_SIZE(sensors[i].sensors_supported); n++) {
> +	for (n = 0; n < ARRAY_SIZE(sensor_settings[i].sensors_supported); n++) {
>  		if (strcmp(indio_dev->name,
> -				&sensors[i].sensors_supported[n][0]) == 0)
> +				&sensor_settings[i].sensors_supported[n][0]) == 0)
>  			break;
>  	}
> -	if (n == ARRAY_SIZE(sensors[i].sensors_supported)) {
> +	if (n == ARRAY_SIZE(sensor_settings[i].sensors_supported)) {
>  		dev_err(&indio_dev->dev, "device name and WhoAmI mismatch.\n");
>  		goto sensor_name_mismatch;
>  	}
>  
> -	sdata->sensor = (struct st_sensors *)&sensors[i];
> +	sdata->sensor_settings =
> +			(struct st_sensor_settings *)&sensor_settings[i];
>  
>  	return i;
>  
> @@ -508,11 +518,11 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
>  
>  	mutex_lock(&indio_dev->mlock);
>  	for (i = 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
> -		if (sdata->sensor->odr.odr_avl[i].hz == 0)
> +		if (sdata->sensor_settings->odr.odr_avl[i].hz == 0)
>  			break;
>  
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -					sdata->sensor->odr.odr_avl[i].hz);
> +				sdata->sensor_settings->odr.odr_avl[i].hz);
>  	}
>  	mutex_unlock(&indio_dev->mlock);
>  	buf[len - 1] = '\n';
> @@ -530,11 +540,11 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  
>  	mutex_lock(&indio_dev->mlock);
>  	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
> -		if (sdata->sensor->fs.fs_avl[i].num == 0)
> +		if (sdata->sensor_settings->fs.fs_avl[i].num == 0)
>  			break;
>  
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> -					sdata->sensor->fs.fs_avl[i].gain);
> +				sdata->sensor_settings->fs.fs_avl[i].gain);
>  	}
>  	mutex_unlock(&indio_dev->mlock);
>  	buf[len - 1] = '\n';
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index f156fc6..9d41b68 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -103,7 +103,7 @@ static const struct iio_chan_spec st_gyro_16bit_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3)
>  };
>  
> -static const struct st_sensors st_gyro_sensors[] = {
> +static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  	{
>  		.wai = ST_GYRO_1_WAI_EXP,
>  		.sensors_supported = {
> @@ -322,18 +322,19 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
>  	st_sensors_power_enable(indio_dev);
>  
>  	err = st_sensors_check_device_support(indio_dev,
> -				ARRAY_SIZE(st_gyro_sensors), st_gyro_sensors);
> +					ARRAY_SIZE(st_gyro_sensors_settings),
> +					st_gyro_sensors_settings);
>  	if (err < 0)
>  		return err;
>  
>  	gdata->num_data_channels = ST_GYRO_NUMBER_DATA_CHANNELS;
> -	gdata->multiread_bit = gdata->sensor->multi_read_bit;
> -	indio_dev->channels = gdata->sensor->ch;
> +	gdata->multiread_bit = gdata->sensor_settings->multi_read_bit;
> +	indio_dev->channels = gdata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
>  	gdata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -						&gdata->sensor->fs.fs_avl[0];
> -	gdata->odr = gdata->sensor->odr.odr_avl[0].hz;
> +					&gdata->sensor_settings->fs.fs_avl[0];
> +	gdata->odr = gdata->sensor_settings->odr.odr_avl[0].hz;
>  
>  	err = st_sensors_init_sensor(indio_dev, pdata);
>  	if (err < 0)
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 68cae86..b422620 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -149,7 +149,7 @@ static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3)
>  };
>  
> -static const struct st_sensors st_magn_sensors[] = {
> +static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  	{
>  		.wai = ST_MAGN_1_WAI_EXP,
>  		.sensors_supported = {
> @@ -374,18 +374,19 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
>  	st_sensors_power_enable(indio_dev);
>  
>  	err = st_sensors_check_device_support(indio_dev,
> -				ARRAY_SIZE(st_magn_sensors), st_magn_sensors);
> +					ARRAY_SIZE(st_magn_sensors_settings),
> +					st_magn_sensors_settings);
>  	if (err < 0)
>  		return err;
>  
>  	mdata->num_data_channels = ST_MAGN_NUMBER_DATA_CHANNELS;
> -	mdata->multiread_bit = mdata->sensor->multi_read_bit;
> -	indio_dev->channels = mdata->sensor->ch;
> +	mdata->multiread_bit = mdata->sensor_settings->multi_read_bit;
> +	indio_dev->channels = mdata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
>  	mdata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -						&mdata->sensor->fs.fs_avl[0];
> -	mdata->odr = mdata->sensor->odr.odr_avl[0].hz;
> +					&mdata->sensor_settings->fs.fs_avl[0];
> +	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
>  
>  	err = st_sensors_init_sensor(indio_dev, pdata);
>  	if (err < 0)
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 473d914..9563118 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -175,7 +175,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(1)
>  };
>  
> -static const struct st_sensors st_press_sensors[] = {
> +static const struct st_sensor_settings st_press_sensors_settings[] = {
>  	{
>  		.wai = ST_PRESS_LPS331AP_WAI_EXP,
>  		.sensors_supported = {
> @@ -422,24 +422,24 @@ int st_press_common_probe(struct iio_dev *indio_dev,
>  	st_sensors_power_enable(indio_dev);
>  
>  	err = st_sensors_check_device_support(indio_dev,
> -					      ARRAY_SIZE(st_press_sensors),
> -					      st_press_sensors);
> +					ARRAY_SIZE(st_press_sensors_settings),
> +					st_press_sensors_settings);
>  	if (err < 0)
>  		return err;
>  
>  	pdata->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
> -	pdata->multiread_bit     = pdata->sensor->multi_read_bit;
> -	indio_dev->channels      = pdata->sensor->ch;
> -	indio_dev->num_channels  = pdata->sensor->num_ch;
> +	pdata->multiread_bit = pdata->sensor_settings->multi_read_bit;
> +	indio_dev->channels = pdata->sensor_settings->ch;
> +	indio_dev->num_channels = pdata->sensor_settings->num_ch;
>  
> -	if (pdata->sensor->fs.addr != 0)
> +	if (pdata->sensor_settings->fs.addr != 0)
>  		pdata->current_fullscale = (struct st_sensor_fullscale_avl *)
> -			&pdata->sensor->fs.fs_avl[0];
> +			&pdata->sensor_settings->fs.fs_avl[0];
>  
> -	pdata->odr = pdata->sensor->odr.odr_avl[0].hz;
> +	pdata->odr = pdata->sensor_settings->odr.odr_avl[0].hz;
>  
>  	/* Some devices don't support a data ready pin. */
> -	if (!plat_data && pdata->sensor->drdy_irq.addr)
> +	if (!plat_data && pdata->sensor_settings->drdy_irq.addr)
>  		plat_data =
>  			(struct st_sensors_platform_data *)&default_press_pdata;
>  
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index d8257ab..2c476ac 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -164,7 +164,7 @@ struct st_sensor_transfer_function {
>  };
>  
>  /**
> - * struct st_sensors - ST sensors list
> + * struct st_sensor_settings - ST specific sensor settings
>   * @wai: Contents of WhoAmI register.
>   * @sensors_supported: List of supported sensors by struct itself.
>   * @ch: IIO channels for the sensor.
> @@ -177,7 +177,7 @@ struct st_sensor_transfer_function {
>   * @multi_read_bit: Use or not particular bit for [I2C/SPI] multi-read.
>   * @bootime: samples to discard when sensor passing from power-down to power-up.
>   */
> -struct st_sensors {
> +struct st_sensor_settings {
>  	u8 wai;
>  	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
>  	struct iio_chan_spec *ch;
> @@ -196,7 +196,7 @@ struct st_sensors {
>   * struct st_sensor_data - ST sensor device status
>   * @dev: Pointer to instance of struct device (I2C or SPI).
>   * @trig: The trigger in use by the core driver.
> - * @sensor: Pointer to the current sensor struct in use.
> + * @sensor_settings: Pointer to the specific sensor settings in use.
>   * @current_fullscale: Maximum range of measure by the sensor.
>   * @vdd: Pointer to sensor's Vdd power supply
>   * @vdd_io: Pointer to sensor's Vdd-IO power supply
> @@ -213,7 +213,7 @@ struct st_sensors {
>  struct st_sensor_data {
>  	struct device *dev;
>  	struct iio_trigger *trig;
> -	struct st_sensors *sensor;
> +	struct st_sensor_settings *sensor_settings;
>  	struct st_sensor_fullscale_avl *current_fullscale;
>  	struct regulator *vdd;
>  	struct regulator *vdd_io;
> @@ -279,7 +279,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *ch, int *val);
>  
>  int st_sensors_check_device_support(struct iio_dev *indio_dev,
> -			int num_sensors_list, const struct st_sensors *sensors);
> +	int num_sensors_list, const struct st_sensor_settings *sensor_settings);
>  
>  ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf);
> 
