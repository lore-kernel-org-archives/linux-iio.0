Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36201 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbbGPOoI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 10:44:08 -0400
Date: Thu, 16 Jul 2015 16:38:46 +0200
From: Tomasz Duszynski <tduszyns@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	tduszyns@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: ms5611: add support for MS5803
 temperature and pressure sensor
Message-ID: <20150716143846.GE2566@Arch.lan>
References: <1436991152-824-1-git-send-email-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1436991152-824-1-git-send-email-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 15, 2015 at 10:12:32PM +0200, Tomasz Duszynski wrote:
> MS5803 is factory calibrated temperature and pressure sensor capable
> of providing precise 24bit measurements. Sensor supports  both I2C and SPI
> and uses the same command protocol as MS5611/MS5607.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  drivers/iio/pressure/Kconfig       |  2 +-
>  drivers/iio/pressure/ms5611.h      |  1 +
>  drivers/iio/pressure/ms5611_core.c | 43 ++++++++++++++++++++++++++++++++++++++
>  drivers/iio/pressure/ms5611_i2c.c  |  1 +
>  drivers/iio/pressure/ms5611_spi.c  |  1 +
>  5 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 4745179..5f339b7 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -56,7 +56,7 @@ config MS5611
>  	tristate "Measurement Specialties MS5611 pressure sensor driver"
>  	help
>  	  Say Y here to build support for the Measurement Specialties
> -	  MS5611, MS5607 pressure and temperature sensors.
> +	  MS5611, MS5607, MS5803 pressure and temperature sensors.
>
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called ms5611_core.
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index 23b93c7..07500b6 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -30,6 +30,7 @@
>  enum {
>  	MS5611,
>  	MS5607,
> +	MS5803
>  };
>
>  struct ms5611_chip_info {
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 2f3d9b4..173d7bf 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -10,6 +10,7 @@
>   * Data sheet:
>   *  http://www.meas-spec.com/downloads/MS5611-01BA03.pdf
>   *  http://www.meas-spec.com/downloads/MS5607-02BA03.pdf
> + *  http://www.meas-spec.com/downloads/MS5803-01BA.pdf
>   *
>   */
>
> @@ -157,6 +158,45 @@ static int ms5607_temp_and_pressure_compensate(struct ms5611_chip_info *chip_inf
>  	return 0;
>  }
>
> +static int ms5803_temp_and_pressure_compensate(struct ms5611_chip_info *chip_info,
> +					       s32 *temp, s32 *pressure)
> +{
> +	s32 t = *temp, p = *pressure;
> +	s64 off, sens, dt, off2, sens2, t2;
> +
> +	dt = t - (chip_info->prom[5] << 8);
> +	off = ((s64)chip_info->prom[2] << 16) + ((chip_info->prom[4] * dt) >> 7);
> +	sens = ((s64)chip_info->prom[1] << 15) + ((chip_info->prom[3] * dt) >> 8);
> +
> +	t = 2000 + ((chip_info->prom[6] * dt) >> 23);
> +	if (t < 2000) {
> +		s64 tmp = (t - 2000) * (t - 2000);
> +
> +		t2 = (dt * dt) >> 31;
> +		off2 = 3 * tmp;
> +		sens2 = (7 * tmp) >> 3;
> +
> +		if (t < -1500)
> +			sens2 += 2 * (t + 1500) * (t + 1500);
> +	} else {
> +		t2 = 0;
> +		off2 = 0;
> +		sens2 = 0;
> +
> +		if (t >= 4500)
> +			sens2 -= ((t - 4500) * (t - 4500)) >> 3;
> +	}
> +
> +	t -= t2;
> +	off -= off2;
> +	sens -= sens2;
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
> @@ -212,6 +252,9 @@ static struct ms5611_chip_info chip_info_tbl[] = {
>  	},
>  	[MS5607] = {
>  		.temp_and_pressure_compensate = ms5607_temp_and_pressure_compensate,
> +	},
> +	[MS5803] = {
> +		.temp_and_pressure_compensate = ms5803_temp_and_pressure_compensate,
>  	}
>  };
>
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 245797d..7125055 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -110,6 +110,7 @@ static int ms5611_i2c_probe(struct i2c_client *client,
>  static const struct i2c_device_id ms5611_id[] = {
>  	{ "ms5611", MS5611 },
>  	{ "ms5607", MS5607 },
> +	{ "ms5803", MS5803 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ms5611_id);
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index 08ee6e8..59a60ed 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -110,6 +110,7 @@ static int ms5611_spi_probe(struct spi_device *spi)
>  static const struct spi_device_id ms5611_id[] = {
>  	{ "ms5611", MS5611 },
>  	{ "ms5607", MS5607 },
> +	{ "ms5803", MS5803 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ms5611_id);
> --
> 2.4.5
>
Hi,

Hold on with reviewing this patch. I'll repost it shortly.
Thanks!
