Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45761 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab3FVKm7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jun 2013 06:42:59 -0400
Message-ID: <51C57FB5.50005@kernel.org>
Date: Sat, 22 Jun 2013 11:43:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: j.anaszewski@samsung.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Added ST-sensors platform data to select the DRDY
 interrupt pin
References: <1371630508-8464-1-git-send-email-denis.ciocca@st.com> <1371630508-8464-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1371630508-8464-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/19/2013 09:28 AM, Denis CIOCCA wrote:
> This patch add support to redirect the DRDY interrupt on INT1 or INT2
> on accelerometer and pressure sensors.
>
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git. Thanks.

> ---
>  drivers/iio/accel/st_accel.h                    |   11 +++++-
>  drivers/iio/accel/st_accel_core.c               |   27 ++++++++++-----
>  drivers/iio/accel/st_accel_i2c.c                |    2 +-
>  drivers/iio/accel/st_accel_spi.c                |    2 +-
>  drivers/iio/common/st_sensors/st_sensors_core.c |   41 ++++++++++++++++++++---
>  drivers/iio/gyro/st_gyro.h                      |   11 +++++-
>  drivers/iio/gyro/st_gyro_core.c                 |   13 +++----
>  drivers/iio/gyro/st_gyro_i2c.c                  |    3 +-
>  drivers/iio/gyro/st_gyro_spi.c                  |    3 +-
>  drivers/iio/magnetometer/st_magn.h              |    3 +-
>  drivers/iio/magnetometer/st_magn_core.c         |    5 +--
>  drivers/iio/magnetometer/st_magn_i2c.c          |    2 +-
>  drivers/iio/magnetometer/st_magn_spi.c          |    2 +-
>  drivers/iio/pressure/st_pressure.h              |   11 +++++-
>  drivers/iio/pressure/st_pressure_core.c         |   15 ++++++---
>  drivers/iio/pressure/st_pressure_i2c.c          |    2 +-
>  drivers/iio/pressure/st_pressure_spi.c          |    2 +-
>  include/linux/iio/common/st_sensors.h           |   14 ++++++--
>  include/linux/platform_data/st_sensors_pdata.h  |   24 +++++++++++++
>  19 files changed, 153 insertions(+), 40 deletions(-)
>  create mode 100644 include/linux/platform_data/st_sensors_pdata.h
>
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 37949b9..c387763 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -25,7 +25,16 @@
>  #define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
>  #define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
>
> -int st_accel_common_probe(struct iio_dev *indio_dev);
> +/**
> +* struct st_sensors_platform_data - default accel platform data
> +* @drdy_int_pin: default accel DRDY is available on INT1 pin.
> +*/
> +static const struct st_sensors_platform_data default_accel_pdata = {
> +	.drdy_int_pin = 1,
> +};
> +
> +int st_accel_common_probe(struct iio_dev *indio_dev,
> +					struct st_sensors_platform_data *pdata);
>  void st_accel_common_remove(struct iio_dev *indio_dev);
>
>  #ifdef CONFIG_IIO_BUFFER
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 4aec121..aef3c9b 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -65,7 +65,8 @@
>  #define ST_ACCEL_1_BDU_ADDR			0x23
>  #define ST_ACCEL_1_BDU_MASK			0x80
>  #define ST_ACCEL_1_DRDY_IRQ_ADDR		0x22
> -#define ST_ACCEL_1_DRDY_IRQ_MASK		0x10
> +#define ST_ACCEL_1_DRDY_IRQ_INT1_MASK		0x10
> +#define ST_ACCEL_1_DRDY_IRQ_INT2_MASK		0x08
>  #define ST_ACCEL_1_MULTIREAD_BIT		true
>
>  /* CUSTOM VALUES FOR SENSOR 2 */
> @@ -89,7 +90,8 @@
>  #define ST_ACCEL_2_BDU_ADDR			0x23
>  #define ST_ACCEL_2_BDU_MASK			0x80
>  #define ST_ACCEL_2_DRDY_IRQ_ADDR		0x22
> -#define ST_ACCEL_2_DRDY_IRQ_MASK		0x02
> +#define ST_ACCEL_2_DRDY_IRQ_INT1_MASK		0x02
> +#define ST_ACCEL_2_DRDY_IRQ_INT2_MASK		0x10
>  #define ST_ACCEL_2_MULTIREAD_BIT		true
>
>  /* CUSTOM VALUES FOR SENSOR 3 */
> @@ -121,7 +123,8 @@
>  #define ST_ACCEL_3_BDU_ADDR			0x20
>  #define ST_ACCEL_3_BDU_MASK			0x08
>  #define ST_ACCEL_3_DRDY_IRQ_ADDR		0x23
> -#define ST_ACCEL_3_DRDY_IRQ_MASK		0x80
> +#define ST_ACCEL_3_DRDY_IRQ_INT1_MASK		0x80
> +#define ST_ACCEL_3_DRDY_IRQ_INT2_MASK		0x00
>  #define ST_ACCEL_3_IG1_EN_ADDR			0x23
>  #define ST_ACCEL_3_IG1_EN_MASK			0x08
>  #define ST_ACCEL_3_MULTIREAD_BIT		false
> @@ -224,7 +227,8 @@ static const struct st_sensors st_accel_sensors[] = {
>  		},
>  		.drdy_irq = {
>  			.addr = ST_ACCEL_1_DRDY_IRQ_ADDR,
> -			.mask = ST_ACCEL_1_DRDY_IRQ_MASK,
> +			.mask_int1 = ST_ACCEL_1_DRDY_IRQ_INT1_MASK,
> +			.mask_int2 = ST_ACCEL_1_DRDY_IRQ_INT2_MASK,
>  		},
>  		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -285,7 +289,8 @@ static const struct st_sensors st_accel_sensors[] = {
>  		},
>  		.drdy_irq = {
>  			.addr = ST_ACCEL_2_DRDY_IRQ_ADDR,
> -			.mask = ST_ACCEL_2_DRDY_IRQ_MASK,
> +			.mask_int1 = ST_ACCEL_2_DRDY_IRQ_INT1_MASK,
> +			.mask_int2 = ST_ACCEL_2_DRDY_IRQ_INT2_MASK,
>  		},
>  		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -358,7 +363,8 @@ static const struct st_sensors st_accel_sensors[] = {
>  		},
>  		.drdy_irq = {
>  			.addr = ST_ACCEL_3_DRDY_IRQ_ADDR,
> -			.mask = ST_ACCEL_3_DRDY_IRQ_MASK,
> +			.mask_int1 = ST_ACCEL_3_DRDY_IRQ_INT1_MASK,
> +			.mask_int2 = ST_ACCEL_3_DRDY_IRQ_INT2_MASK,
>  			.ig1 = {
>  				.en_addr = ST_ACCEL_3_IG1_EN_ADDR,
>  				.en_mask = ST_ACCEL_3_IG1_EN_MASK,
> @@ -443,7 +449,8 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>
> -int st_accel_common_probe(struct iio_dev *indio_dev)
> +int st_accel_common_probe(struct iio_dev *indio_dev,
> +				struct st_sensors_platform_data *plat_data)
>  {
>  	int err;
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
> @@ -465,7 +472,11 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  						&adata->sensor->fs.fs_avl[0];
>  	adata->odr = adata->sensor->odr.odr_avl[0].hz;
>
> -	err = st_sensors_init_sensor(indio_dev);
> +	if (!plat_data)
> +		plat_data =
> +			(struct st_sensors_platform_data *)&default_accel_pdata;
> +
> +	err = st_sensors_init_sensor(indio_dev, plat_data);
>  	if (err < 0)
>  		goto st_accel_common_probe_error;
>
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index ffc9d09..58d164d 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -36,7 +36,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>
>  	st_sensors_i2c_configure(indio_dev, client, adata);
>
> -	err = st_accel_common_probe(indio_dev);
> +	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
>  	if (err < 0)
>  		goto st_accel_common_probe_error;
>
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 22b35bf..21ed929 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -35,7 +35,7 @@ static int st_accel_spi_probe(struct spi_device *spi)
>
>  	st_sensors_spi_configure(indio_dev, spi, adata);
>
> -	err = st_accel_common_probe(indio_dev);
> +	err = st_accel_common_probe(indio_dev, spi->dev.platform_data);
>  	if (err < 0)
>  		goto st_accel_common_probe_error;
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 865b178..965ee22 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -22,7 +22,7 @@
>
>  static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
>  {
> -	return ((s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8);
> +	return (s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8;
>  }
>
>  static int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
> @@ -118,7 +118,7 @@ st_sensors_match_odr_error:
>  }
>
>  static int st_sensors_set_fullscale(struct iio_dev *indio_dev,
> -							unsigned int fs)
> +								unsigned int fs)
>  {
>  	int err, i = 0;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> @@ -198,13 +198,39 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
>  }
>  EXPORT_SYMBOL(st_sensors_set_axis_enable);
>
> -int st_sensors_init_sensor(struct iio_dev *indio_dev)
> +int st_sensors_init_sensor(struct iio_dev *indio_dev,
> +					struct st_sensors_platform_data *pdata)
>  {
>  	int err;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>
>  	mutex_init(&sdata->tb.buf_lock);
>
> +	switch (pdata->drdy_int_pin) {
> +	case 1:
> +		if (sdata->sensor->drdy_irq.mask_int1 == 0) {
> +			dev_err(&indio_dev->dev,
> +					"DRDY on INT1 not available.\n");
> +			err = -EINVAL;
> +			goto init_error;
> +		}
> +		sdata->drdy_int_pin = 1;
> +		break;
> +	case 2:
> +		if (sdata->sensor->drdy_irq.mask_int2 == 0) {
> +			dev_err(&indio_dev->dev,
> +					"DRDY on INT2 not available.\n");
> +			err = -EINVAL;
> +			goto init_error;
> +		}
> +		sdata->drdy_int_pin = 2;
> +		break;
> +	default:
> +		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
> +		err = -EINVAL;
> +		goto init_error;
> +	}
> +
>  	err = st_sensors_set_enable(indio_dev, false);
>  	if (err < 0)
>  		goto init_error;
> @@ -234,6 +260,7 @@ EXPORT_SYMBOL(st_sensors_init_sensor);
>  int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
>  {
>  	int err;
> +	u8 drdy_mask;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>
>  	/* Enable/Disable the interrupt generator 1. */
> @@ -245,10 +272,14 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
>  			goto st_accel_set_dataready_irq_error;
>  	}
>
> +	if (sdata->drdy_int_pin == 1)
> +		drdy_mask = sdata->sensor->drdy_irq.mask_int1;
> +	else
> +		drdy_mask = sdata->sensor->drdy_irq.mask_int2;
> +
>  	/* Enable/Disable the interrupt generator for data ready. */
>  	err = st_sensors_write_data_with_mask(indio_dev,
> -			sdata->sensor->drdy_irq.addr,
> -			sdata->sensor->drdy_irq.mask, (int)enable);
> +			sdata->sensor->drdy_irq.addr, drdy_mask, (int)enable);
>
>  st_accel_set_dataready_irq_error:
>  	return err;
> diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
> index 3ad9907..f8f2bf8 100644
> --- a/drivers/iio/gyro/st_gyro.h
> +++ b/drivers/iio/gyro/st_gyro.h
> @@ -23,7 +23,16 @@
>  #define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
>  #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
>
> -int st_gyro_common_probe(struct iio_dev *indio_dev);
> +/**
> + * struct st_sensors_platform_data - gyro platform data
> + * @drdy_int_pin: DRDY on gyros is available only on INT2 pin.
> + */
> +static const struct st_sensors_platform_data gyro_pdata = {
> +	.drdy_int_pin = 2,
> +};
> +
> +int st_gyro_common_probe(struct iio_dev *indio_dev,
> +					struct st_sensors_platform_data *pdata);
>  void st_gyro_common_remove(struct iio_dev *indio_dev);
>
>  #ifdef CONFIG_IIO_BUFFER
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index f9ed348..85fa8d3 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -60,7 +60,7 @@
>  #define ST_GYRO_1_BDU_ADDR			0x23
>  #define ST_GYRO_1_BDU_MASK			0x80
>  #define ST_GYRO_1_DRDY_IRQ_ADDR			0x22
> -#define ST_GYRO_1_DRDY_IRQ_MASK			0x08
> +#define ST_GYRO_1_DRDY_IRQ_INT2_MASK		0x08
>  #define ST_GYRO_1_MULTIREAD_BIT			true
>
>  /* CUSTOM VALUES FOR SENSOR 2 */
> @@ -84,7 +84,7 @@
>  #define ST_GYRO_2_BDU_ADDR			0x23
>  #define ST_GYRO_2_BDU_MASK			0x80
>  #define ST_GYRO_2_DRDY_IRQ_ADDR			0x22
> -#define ST_GYRO_2_DRDY_IRQ_MASK			0x08
> +#define ST_GYRO_2_DRDY_IRQ_INT2_MASK		0x08
>  #define ST_GYRO_2_MULTIREAD_BIT			true
>
>  static const struct iio_chan_spec st_gyro_16bit_channels[] = {
> @@ -158,7 +158,7 @@ static const struct st_sensors st_gyro_sensors[] = {
>  		},
>  		.drdy_irq = {
>  			.addr = ST_GYRO_1_DRDY_IRQ_ADDR,
> -			.mask = ST_GYRO_1_DRDY_IRQ_MASK,
> +			.mask_int2 = ST_GYRO_1_DRDY_IRQ_INT2_MASK,
>  		},
>  		.multi_read_bit = ST_GYRO_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -221,7 +221,7 @@ static const struct st_sensors st_gyro_sensors[] = {
>  		},
>  		.drdy_irq = {
>  			.addr = ST_GYRO_2_DRDY_IRQ_ADDR,
> -			.mask = ST_GYRO_2_DRDY_IRQ_MASK,
> +			.mask_int2 = ST_GYRO_2_DRDY_IRQ_INT2_MASK,
>  		},
>  		.multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -302,7 +302,8 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
>  #define ST_GYRO_TRIGGER_OPS NULL
>  #endif
>
> -int st_gyro_common_probe(struct iio_dev *indio_dev)
> +int st_gyro_common_probe(struct iio_dev *indio_dev,
> +					struct st_sensors_platform_data *pdata)
>  {
>  	int err;
>  	struct st_sensor_data *gdata = iio_priv(indio_dev);
> @@ -324,7 +325,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  						&gdata->sensor->fs.fs_avl[0];
>  	gdata->odr = gdata->sensor->odr.odr_avl[0].hz;
>
> -	err = st_sensors_init_sensor(indio_dev);
> +	err = st_sensors_init_sensor(indio_dev, pdata);
>  	if (err < 0)
>  		goto st_gyro_common_probe_error;
>
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> index 8a31050..c7a29a4 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -36,7 +36,8 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
>
>  	st_sensors_i2c_configure(indio_dev, client, gdata);
>
> -	err = st_gyro_common_probe(indio_dev);
> +	err = st_gyro_common_probe(indio_dev,
> +				(struct st_sensors_platform_data *)&gyro_pdata);
>  	if (err < 0)
>  		goto st_gyro_common_probe_error;
>
> diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
> index f354039..14b0762 100644
> --- a/drivers/iio/gyro/st_gyro_spi.c
> +++ b/drivers/iio/gyro/st_gyro_spi.c
> @@ -35,7 +35,8 @@ static int st_gyro_spi_probe(struct spi_device *spi)
>
>  	st_sensors_spi_configure(indio_dev, spi, gdata);
>
> -	err = st_gyro_common_probe(indio_dev);
> +	err = st_gyro_common_probe(indio_dev,
> +				(struct st_sensors_platform_data *)&gyro_pdata);
>  	if (err < 0)
>  		goto st_gyro_common_probe_error;
>
> diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
> index 7e81d00..694e33e 100644
> --- a/drivers/iio/magnetometer/st_magn.h
> +++ b/drivers/iio/magnetometer/st_magn.h
> @@ -18,7 +18,8 @@
>  #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
>  #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
>
> -int st_magn_common_probe(struct iio_dev *indio_dev);
> +int st_magn_common_probe(struct iio_dev *indio_dev,
> +					struct st_sensors_platform_data *pdata);
>  void st_magn_common_remove(struct iio_dev *indio_dev);
>
>  #ifdef CONFIG_IIO_BUFFER
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index ebfe8f1..7cd784f 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -345,7 +345,8 @@ static const struct iio_info magn_info = {
>  	.write_raw = &st_magn_write_raw,
>  };
>
> -int st_magn_common_probe(struct iio_dev *indio_dev)
> +int st_magn_common_probe(struct iio_dev *indio_dev,
> +					struct st_sensors_platform_data *pdata)
>  {
>  	int err;
>  	struct st_sensor_data *mdata = iio_priv(indio_dev);
> @@ -367,7 +368,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  						&mdata->sensor->fs.fs_avl[0];
>  	mdata->odr = mdata->sensor->odr.odr_avl[0].hz;
>
> -	err = st_sensors_init_sensor(indio_dev);
> +	err = st_sensors_init_sensor(indio_dev, pdata);
>  	if (err < 0)
>  		goto st_magn_common_probe_error;
>
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index e6adc4a..1bed117 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -36,7 +36,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
>
>  	st_sensors_i2c_configure(indio_dev, client, mdata);
>
> -	err = st_magn_common_probe(indio_dev);
> +	err = st_magn_common_probe(indio_dev, NULL);
>  	if (err < 0)
>  		goto st_magn_common_probe_error;
>
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index 51adb79..a2333a1 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -35,7 +35,7 @@ static int st_magn_spi_probe(struct spi_device *spi)
>
>  	st_sensors_spi_configure(indio_dev, spi, mdata);
>
> -	err = st_magn_common_probe(indio_dev);
> +	err = st_magn_common_probe(indio_dev, NULL);
>  	if (err < 0)
>  		goto st_magn_common_probe_error;
>
> diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
> index 414e45a..b0b6306 100644
> --- a/drivers/iio/pressure/st_pressure.h
> +++ b/drivers/iio/pressure/st_pressure.h
> @@ -16,7 +16,16 @@
>
>  #define LPS331AP_PRESS_DEV_NAME		"lps331ap"
>
> -int st_press_common_probe(struct iio_dev *indio_dev);
> +/**
> + * struct st_sensors_platform_data - default press platform data
> + * @drdy_int_pin: default press DRDY is available on INT1 pin.
> + */
> +static const struct st_sensors_platform_data default_press_pdata = {
> +	.drdy_int_pin = 1,
> +};
> +
> +int st_press_common_probe(struct iio_dev *indio_dev,
> +					struct st_sensors_platform_data *pdata);
>  void st_press_common_remove(struct iio_dev *indio_dev);
>
>  #ifdef CONFIG_IIO_BUFFER
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 9c343b4..b8ecc87 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -56,7 +56,8 @@
>  #define ST_PRESS_1_BDU_ADDR			0x20
>  #define ST_PRESS_1_BDU_MASK			0x04
>  #define ST_PRESS_1_DRDY_IRQ_ADDR		0x22
> -#define ST_PRESS_1_DRDY_IRQ_MASK		0x04
> +#define ST_PRESS_1_DRDY_IRQ_INT1_MASK		0x04
> +#define ST_PRESS_1_DRDY_IRQ_INT2_MASK		0x20
>  #define ST_PRESS_1_MULTIREAD_BIT		true
>  #define ST_PRESS_1_TEMP_OFFSET			42500
>
> @@ -114,7 +115,8 @@ static const struct st_sensors st_press_sensors[] = {
>  		},
>  		.drdy_irq = {
>  			.addr = ST_PRESS_1_DRDY_IRQ_ADDR,
> -			.mask = ST_PRESS_1_DRDY_IRQ_MASK,
> +			.mask_int1 = ST_PRESS_1_DRDY_IRQ_INT1_MASK,
> +			.mask_int2 = ST_PRESS_1_DRDY_IRQ_INT2_MASK,
>  		},
>  		.multi_read_bit = ST_PRESS_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -200,7 +202,8 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
>  #define ST_PRESS_TRIGGER_OPS NULL
>  #endif
>
> -int st_press_common_probe(struct iio_dev *indio_dev)
> +int st_press_common_probe(struct iio_dev *indio_dev,
> +				struct st_sensors_platform_data *plat_data)
>  {
>  	int err;
>  	struct st_sensor_data *pdata = iio_priv(indio_dev);
> @@ -222,7 +225,11 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  						&pdata->sensor->fs.fs_avl[0];
>  	pdata->odr = pdata->sensor->odr.odr_avl[0].hz;
>
> -	err = st_sensors_init_sensor(indio_dev);
> +	if (!plat_data)
> +		plat_data =
> +			(struct st_sensors_platform_data *)&default_press_pdata;
> +
> +	err = st_sensors_init_sensor(indio_dev, plat_data);
>  	if (err < 0)
>  		goto st_press_common_probe_error;
>
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index 7cebcc7..3065993 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -36,7 +36,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
>
>  	st_sensors_i2c_configure(indio_dev, client, pdata);
>
> -	err = st_press_common_probe(indio_dev);
> +	err = st_press_common_probe(indio_dev, client->dev.platform_data);
>  	if (err < 0)
>  		goto st_press_common_probe_error;
>
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index 17a1490..b2aded6 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -35,7 +35,7 @@ static int st_press_spi_probe(struct spi_device *spi)
>
>  	st_sensors_spi_configure(indio_dev, spi, pdata);
>
> -	err = st_press_common_probe(indio_dev);
> +	err = st_press_common_probe(indio_dev, spi->dev.platform_data);
>  	if (err < 0)
>  		goto st_press_common_probe_error;
>
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 72b2694..e51f654 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -17,6 +17,8 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/bitops.h>
>
> +#include <linux/platform_data/st_sensors_pdata.h>
> +
>  #define ST_SENSORS_TX_MAX_LENGTH		2
>  #define ST_SENSORS_RX_MAX_LENGTH		6
>
> @@ -118,14 +120,16 @@ struct st_sensor_bdu {
>  /**
>   * struct st_sensor_data_ready_irq - ST sensor device data-ready interrupt
>   * @addr: address of the register.
> - * @mask: mask to write the on/off value.
> + * @mask_int1: mask to enable/disable IRQ on INT1 pin.
> + * @mask_int2: mask to enable/disable IRQ on INT2 pin.
>   * struct ig1 - represents the Interrupt Generator 1 of sensors.
>   * @en_addr: address of the enable ig1 register.
>   * @en_mask: mask to write the on/off value for enable.
>   */
>  struct st_sensor_data_ready_irq {
>  	u8 addr;
> -	u8 mask;
> +	u8 mask_int1;
> +	u8 mask_int2;
>  	struct {
>  		u8 en_addr;
>  		u8 en_mask;
> @@ -201,6 +205,7 @@ struct st_sensors {
>   * @buffer_data: Data used by buffer part.
>   * @odr: Output data rate of the sensor [Hz].
>   * num_data_channels: Number of data channels used in buffer.
> + * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
>   * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
>   * @tf: Transfer function structure used by I/O operations.
>   * @tb: Transfer buffers and mutex used by I/O operations.
> @@ -219,6 +224,8 @@ struct st_sensor_data {
>  	unsigned int odr;
>  	unsigned int num_data_channels;
>
> +	u8 drdy_int_pin;
> +
>  	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
>
>  	const struct st_sensor_transfer_function *tf;
> @@ -249,7 +256,8 @@ static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
>  }
>  #endif
>
> -int st_sensors_init_sensor(struct iio_dev *indio_dev);
> +int st_sensors_init_sensor(struct iio_dev *indio_dev,
> +					struct st_sensors_platform_data *pdata);
>
>  int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable);
>
> diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
> new file mode 100644
> index 0000000..7538391
> --- /dev/null
> +++ b/include/linux/platform_data/st_sensors_pdata.h
> @@ -0,0 +1,24 @@
> +/*
> + * STMicroelectronics sensors platform-data driver
> + *
> + * Copyright 2013 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#ifndef ST_SENSORS_PDATA_H
> +#define ST_SENSORS_PDATA_H
> +
> +/**
> + * struct st_sensors_platform_data - Platform data for the ST sensors
> + * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
> + *	Available only for accelerometer and pressure sensors.
> + *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
> + */
> +struct st_sensors_platform_data {
> +	u8 drdy_int_pin;
> +};
> +
> +#endif /* ST_SENSORS_PDATA_H */
>
