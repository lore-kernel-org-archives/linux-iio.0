Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59839 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbbGENfy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 09:35:54 -0400
Message-ID: <559932B7.7080901@kernel.org>
Date: Sun, 05 Jul 2015 14:35:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tomasz Duszynski <tduszyns@gmail.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: ms5611: add support for MS5607 temperature
 and pressure sensor
References: <1435085148-12404-1-git-send-email-tduszyns@gmail.com> <1435085148-12404-2-git-send-email-tduszyns@gmail.com>
In-Reply-To: <1435085148-12404-2-git-send-email-tduszyns@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/06/15 19:45, Tomasz Duszynski wrote:
> MS5607 is temperature and pressure sensor which hardware is similar to MS5611.
> Both sensors share command protocol and support both I2C and SPI serial
> protocols. They only differ in compensation algorithms.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Looks good.

Applied to the togreg branch of iio.git. Pushed out shortly as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/Kconfig       |  2 +-
>  drivers/iio/pressure/ms5611.h      | 16 +++++++-
>  drivers/iio/pressure/ms5611_core.c | 76 +++++++++++++++++++++++++++++++++-----
>  drivers/iio/pressure/ms5611_i2c.c  |  5 ++-
>  drivers/iio/pressure/ms5611_spi.c  |  6 ++-
>  5 files changed, 88 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index b13ea6f..4745179 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -56,7 +56,7 @@ config MS5611
>  	tristate "Measurement Specialties MS5611 pressure sensor driver"
>  	help
>  	  Say Y here to build support for the Measurement Specialties
> -	  MS5611 pressure and temperature sensor.
> +	  MS5611, MS5607 pressure and temperature sensors.
>  
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called ms5611_core.
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index 099c6cd..23b93c7 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -27,6 +27,18 @@
>  
>  #define MS5611_PROM_WORDS_NB		8
>  
> +enum {
> +	MS5611,
> +	MS5607,
> +};
> +
> +struct ms5611_chip_info {
> +	u16 prom[MS5611_PROM_WORDS_NB];
> +
> +	int (*temp_and_pressure_compensate)(struct ms5611_chip_info *chip_info,
> +					    s32 *temp, s32 *pressure);
> +};
> +
>  struct ms5611_state {
>  	void *client;
>  	struct mutex lock;
> @@ -36,9 +48,9 @@ struct ms5611_state {
>  	int (*read_adc_temp_and_pressure)(struct device *dev,
>  					  s32 *temp, s32 *pressure);
>  
> -	u16 prom[MS5611_PROM_WORDS_NB];
> +	struct ms5611_chip_info *chip_info;
>  };
>  
> -int ms5611_probe(struct iio_dev *indio_dev, struct device *dev);
> +int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type);
>  
>  #endif /* _MS5611_H */
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 1109513..2f3d9b4 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -9,6 +9,7 @@
>   *
>   * Data sheet:
>   *  http://www.meas-spec.com/downloads/MS5611-01BA03.pdf
> + *  http://www.meas-spec.com/downloads/MS5607-02BA03.pdf
>   *
>   */
>  
> @@ -50,7 +51,8 @@ static int ms5611_read_prom(struct iio_dev *indio_dev)
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  
>  	for (i = 0; i < MS5611_PROM_WORDS_NB; i++) {
> -		ret = st->read_prom_word(&indio_dev->dev, i, &st->prom[i]);
> +		ret = st->read_prom_word(&indio_dev->dev,
> +					 i, &st->chip_info->prom[i]);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to read prom at %d\n", i);
> @@ -58,7 +60,7 @@ static int ms5611_read_prom(struct iio_dev *indio_dev)
>  		}
>  	}
>  
> -	if (!ms5611_prom_is_valid(st->prom, MS5611_PROM_WORDS_NB)) {
> +	if (!ms5611_prom_is_valid(st->chip_info->prom, MS5611_PROM_WORDS_NB)) {
>  		dev_err(&indio_dev->dev, "PROM integrity check failed\n");
>  		return -ENODEV;
>  	}
> @@ -70,22 +72,30 @@ static int ms5611_read_temp_and_pressure(struct iio_dev *indio_dev,
>  					 s32 *temp, s32 *pressure)
>  {
>  	int ret;
> -	s32 t, p;
> -	s64 off, sens, dt;
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  
> -	ret = st->read_adc_temp_and_pressure(&indio_dev->dev, &t, &p);
> +	ret = st->read_adc_temp_and_pressure(&indio_dev->dev, temp, pressure);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev,
>  			"failed to read temperature and pressure\n");
>  		return ret;
>  	}
>  
> -	dt = t - (st->prom[5] << 8);
> -	off = ((s64)st->prom[2] << 16) + ((st->prom[4] * dt) >> 7);
> -	sens = ((s64)st->prom[1] << 15) + ((st->prom[3] * dt) >> 8);
> +	return st->chip_info->temp_and_pressure_compensate(st->chip_info,
> +							   temp, pressure);
> +}
> +
> +static int ms5611_temp_and_pressure_compensate(struct ms5611_chip_info *chip_info,
> +					       s32 *temp, s32 *pressure)
> +{
> +	s32 t = *temp, p = *pressure;
> +	s64 off, sens, dt;
>  
> -	t = 2000 + ((st->prom[6] * dt) >> 23);
> +	dt = t - (chip_info->prom[5] << 8);
> +	off = ((s64)chip_info->prom[2] << 16) + ((chip_info->prom[4] * dt) >> 7);
> +	sens = ((s64)chip_info->prom[1] << 15) + ((chip_info->prom[3] * dt) >> 8);
> +
> +	t = 2000 + ((chip_info->prom[6] * dt) >> 23);
>  	if (t < 2000) {
>  		s64 off2, sens2, t2;
>  
> @@ -111,6 +121,42 @@ static int ms5611_read_temp_and_pressure(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static int ms5607_temp_and_pressure_compensate(struct ms5611_chip_info *chip_info,
> +					       s32 *temp, s32 *pressure)
> +{
> +	s32 t = *temp, p = *pressure;
> +	s64 off, sens, dt;
> +
> +	dt = t - (chip_info->prom[5] << 8);
> +	off = ((s64)chip_info->prom[2] << 17) + ((chip_info->prom[4] * dt) >> 6);
> +	sens = ((s64)chip_info->prom[1] << 16) + ((chip_info->prom[3] * dt) >> 7);
> +
> +	t = 2000 + ((chip_info->prom[6] * dt) >> 23);
> +	if (t < 2000) {
> +		s64 off2, sens2, t2;
> +
> +		t2 = (dt * dt) >> 31;
> +		off2 = (61 * (t - 2000) * (t - 2000)) >> 4;
> +		sens2 = off2 << 1;
> +
> +		if (t < -1500) {
> +			s64 tmp = (t + 1500) * (t + 1500);
> +
> +			off2 += 15 * tmp;
> +			sens2 += (8 * tmp);
> +		}
> +
> +		t -= t2;
> +		off -= off2;
> +		sens -= sens2;
> +	}
> +
> +	*temp = t;
> +	*pressure = (((p * sens) >> 21) - off) >> 15;
> +
> +	return 0;
> +}
> +
>  static int ms5611_reset(struct iio_dev *indio_dev)
>  {
>  	int ret;
> @@ -160,6 +206,15 @@ static int ms5611_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static struct ms5611_chip_info chip_info_tbl[] = {
> +	[MS5611] = {
> +		.temp_and_pressure_compensate = ms5611_temp_and_pressure_compensate,
> +	},
> +	[MS5607] = {
> +		.temp_and_pressure_compensate = ms5607_temp_and_pressure_compensate,
> +	}
> +};
> +
>  static const struct iio_chan_spec ms5611_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> @@ -187,12 +242,13 @@ static int ms5611_init(struct iio_dev *indio_dev)
>  	return ms5611_read_prom(indio_dev);
>  }
>  
> -int ms5611_probe(struct iio_dev *indio_dev, struct device *dev)
> +int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type)
>  {
>  	int ret;
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  
>  	mutex_init(&st->lock);
> +	st->chip_info = &chip_info_tbl[type];
>  	indio_dev->dev.parent = dev;
>  	indio_dev->name = dev->driver->name;
>  	indio_dev->info = &ms5611_info;
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 748fd9a..9d504f1 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -104,11 +104,12 @@ static int ms5611_i2c_probe(struct i2c_client *client,
>  	st->read_adc_temp_and_pressure = ms5611_i2c_read_adc_temp_and_pressure;
>  	st->client = client;
>  
> -	return ms5611_probe(indio_dev, &client->dev);
> +	return ms5611_probe(indio_dev, &client->dev, id->driver_data);
>  }
>  
>  static const struct i2c_device_id ms5611_id[] = {
> -	{ "ms5611", 0 },
> +	{ "ms5611", MS5611 },
> +	{ "ms5607", MS5607 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ms5611_id);
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index 976726f..08ee6e8 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -103,11 +103,13 @@ static int ms5611_spi_probe(struct spi_device *spi)
>  	st->read_adc_temp_and_pressure = ms5611_spi_read_adc_temp_and_pressure;
>  	st->client = spi;
>  
> -	return ms5611_probe(indio_dev, &spi->dev);
> +	return ms5611_probe(indio_dev, &spi->dev,
> +			    spi_get_device_id(spi)->driver_data);
>  }
>  
>  static const struct spi_device_id ms5611_id[] = {
> -	{ "ms5611", 0 },
> +	{ "ms5611", MS5611 },
> +	{ "ms5607", MS5607 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ms5611_id);
> 

