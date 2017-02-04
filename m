Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58887 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdBDMYO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 07:24:14 -0500
Subject: Re: [PATCH 2/5] iio: imu: st_lsm6dsx: add support to lsm6dsl
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170129104928.15533-1-lorenzo.bianconi@st.com>
 <20170129104928.15533-3-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bebc7800-f060-40be-a181-df7be360e204@kernel.org>
Date: Sat, 4 Feb 2017 12:24:10 +0000
MIME-Version: 1.0
In-Reply-To: <20170129104928.15533-3-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/01/17 10:49, Lorenzo Bianconi wrote:
> Add support to STM LSM6DSL 6-axis (acc + gyro) Mems sensor
> 
> http://www.st.com/resource/en/datasheet/lsm6dsl.pdf
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig             | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 5 +++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
>  6 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 935d4cd0..d264783 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -8,7 +8,7 @@ config IIO_ST_LSM6DSX
>  	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
> -	  sensor. Supported devices: lsm6ds3, lsm6dsm
> +	  sensor. Supported devices: lsm6ds3, lsm6dsl, lsm6dsm
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 2c1bb9e..e0ece13 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -15,10 +15,12 @@
>  #include <linux/device.h>
>  
>  #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
> +#define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
>  #define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> +	ST_LSM6DSL_ID,
>  	ST_LSM6DSM_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 78532ce..73a6492e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -1,7 +1,7 @@
>  /*
>   * STMicroelectronics st_lsm6dsx FIFO buffer library driver
>   *
> - * LSM6DS3/LSM6DSM: The FIFO buffer can be configured to store data
> + * LSM6DS3/LSM6DSL/LSM6DSM: The FIFO buffer can be configured to store data
>   * from gyroscope and accelerometer. Samples are queued without any tag
>   * according to a specific pattern based on 'FIFO data sets' (6 bytes each):
>   *  - 1st data set is reserved for gyroscope data
> @@ -206,7 +206,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
>  }
>  
>  /**
> - * st_lsm6dsx_read_fifo() - LSM6DS3-LSM6DSM read FIFO routine
> + * st_lsm6dsx_read_fifo() - LSM6DS3-LSM6DSL-LSM6DSM read FIFO routine
>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>   *
>   * Read samples from the hw FIFO and push them to IIO buffers.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 499e60a..5d8d5cd 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -17,7 +17,7 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 8KB
>   *
> - * - LSM6DSM:
> + * - LSM6DSL/LSM6DSM:
>   *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
> @@ -168,7 +168,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x6a,
>  		.max_fifo_size = 4096,
>  		.id = {
> -			[0] = ST_LSM6DSM_ID,
> +			[0] = ST_LSM6DSL_ID,
> +			[1] = ST_LSM6DSM_ID,
>  		},
>  	},
>  };
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index ea30411..60a3de0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -71,6 +71,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.data = (void *)ST_LSM6DS3_ID,
>  	},
>  	{
> +		.compatible = "st,lsm6dsl",
> +		.data = (void *)ST_LSM6DSL_ID,
> +	},
> +	{
>  		.compatible = "st,lsm6dsm",
>  		.data = (void *)ST_LSM6DSM_ID,
>  	},
> @@ -80,6 +84,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
>  
>  static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
> +	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
>  	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
>  	{},
>  };
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index fbe7247..39edb40 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -88,6 +88,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.data = (void *)ST_LSM6DS3_ID,
>  	},
>  	{
> +		.compatible = "st,lsm6dsl",
> +		.data = (void *)ST_LSM6DSL_ID,
> +	},
> +	{
>  		.compatible = "st,lsm6dsm",
>  		.data = (void *)ST_LSM6DSM_ID,
>  	},
> @@ -97,6 +101,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
>  
>  static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
> +	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
>  	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
>  	{},
>  };
> 

