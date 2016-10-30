Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42943 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbcJ3Qwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 12:52:44 -0400
Subject: Re: [PATCH 1/2] iio: accel: st_accel: add support to lng2dm
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1477429744-27713-1-git-send-email-lorenzo.bianconi@st.com>
 <1477429744-27713-2-git-send-email-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com, Denis CIOCCA <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b28ade0a-204e-0200-48ee-1a6da3fd3b53@kernel.org>
Date: Sun, 30 Oct 2016 16:52:41 +0000
MIME-Version: 1.0
In-Reply-To: <1477429744-27713-2-git-send-email-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 22:09, Lorenzo Bianconi wrote:
> add support to STMicroelectronics LNG2DM accelerometer to
> st_accel framework
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Looks fine to me. If anyone want to add anything it'll be in 
a tree I can rebase for at least a few days.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/Kconfig         |  3 +-
>  drivers/iio/accel/st_accel.h      |  1 +
>  drivers/iio/accel/st_accel_core.c | 73 +++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c  |  5 +++
>  drivers/iio/accel/st_accel_spi.c  |  1 +
>  5 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index c6cc2c0..c68bdb6 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -127,7 +127,8 @@ config IIO_ST_ACCEL_3AXIS
>  	help
>  	  Say yes here to build support for STMicroelectronics accelerometers:
>  	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
> -	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL.
> +	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
> +	  LNG2DM
>  
>  	  This driver can also be built as a module. If so, these modules
>  	  will be created:
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index f8dfdb6..7c23168 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -30,6 +30,7 @@
>  #define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
>  #define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
>  #define LIS3L02DQ_ACCEL_DEV_NAME	"lis3l02dq"
> +#define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
>  
>  /**
>  * struct st_sensors_platform_data - default accel platform data
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index ce69048..bdb619a 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -231,6 +231,12 @@
>  #define ST_ACCEL_7_DRDY_IRQ_INT1_MASK		0x04
>  #define ST_ACCEL_7_MULTIREAD_BIT		false
>  
> +/* CUSTOM VALUES FOR SENSOR 8 */
> +#define ST_ACCEL_8_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(15600)
> +#define ST_ACCEL_8_FS_AVL_4_GAIN		IIO_G_TO_M_S_2(31200)
> +#define ST_ACCEL_8_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(62500)
> +#define ST_ACCEL_8_FS_AVL_16_GAIN		IIO_G_TO_M_S_2(187500)
> +
>  static const struct iio_chan_spec st_accel_8bit_channels[] = {
>  	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> @@ -726,6 +732,73 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = ST_ACCEL_7_MULTIREAD_BIT,
>  		.bootime = 2,
>  	},
> +	{
> +		.wai = ST_ACCEL_1_WAI_EXP,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = LNG2DM_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
> +		.odr = {
> +			.addr = ST_ACCEL_1_ODR_ADDR,
> +			.mask = ST_ACCEL_1_ODR_MASK,
> +			.odr_avl = {
> +				{ 1, ST_ACCEL_1_ODR_AVL_1HZ_VAL, },
> +				{ 10, ST_ACCEL_1_ODR_AVL_10HZ_VAL, },
> +				{ 25, ST_ACCEL_1_ODR_AVL_25HZ_VAL, },
> +				{ 50, ST_ACCEL_1_ODR_AVL_50HZ_VAL, },
> +				{ 100, ST_ACCEL_1_ODR_AVL_100HZ_VAL, },
> +				{ 200, ST_ACCEL_1_ODR_AVL_200HZ_VAL, },
> +				{ 400, ST_ACCEL_1_ODR_AVL_400HZ_VAL, },
> +				{ 1600, ST_ACCEL_1_ODR_AVL_1600HZ_VAL, },
> +			},
> +		},
> +		.pw = {
> +			.addr = ST_ACCEL_1_ODR_ADDR,
> +			.mask = ST_ACCEL_1_ODR_MASK,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.enable_axis = {
> +			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> +			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> +		},
> +		.fs = {
> +			.addr = ST_ACCEL_1_FS_ADDR,
> +			.mask = ST_ACCEL_1_FS_MASK,
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_ACCEL_FS_AVL_2G,
> +					.value = ST_ACCEL_1_FS_AVL_2_VAL,
> +					.gain = ST_ACCEL_8_FS_AVL_2_GAIN,
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_4G,
> +					.value = ST_ACCEL_1_FS_AVL_4_VAL,
> +					.gain = ST_ACCEL_8_FS_AVL_4_GAIN,
> +				},
> +				[2] = {
> +					.num = ST_ACCEL_FS_AVL_8G,
> +					.value = ST_ACCEL_1_FS_AVL_8_VAL,
> +					.gain = ST_ACCEL_8_FS_AVL_8_GAIN,
> +				},
> +				[3] = {
> +					.num = ST_ACCEL_FS_AVL_16G,
> +					.value = ST_ACCEL_1_FS_AVL_16_VAL,
> +					.gain = ST_ACCEL_8_FS_AVL_16_GAIN,
> +				},
> +			},
> +		},
> +		.drdy_irq = {
> +			.addr = ST_ACCEL_1_DRDY_IRQ_ADDR,
> +			.mask_int1 = ST_ACCEL_1_DRDY_IRQ_INT1_MASK,
> +			.mask_int2 = ST_ACCEL_1_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_ACCEL_1_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_ACCEL_1_IHL_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
> +		},
> +		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
> +		.bootime = 2,
> +	},
>  };
>  
>  static int st_accel_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index e9d427a..c0f8867 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -84,6 +84,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis3l02dq",
>  		.data = LIS3L02DQ_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lng2dm-accel",
> +		.data = LNG2DM_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -135,6 +139,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LSM303AGR_ACCEL_DEV_NAME },
>  	{ LIS2DH12_ACCEL_DEV_NAME },
>  	{ LIS3L02DQ_ACCEL_DEV_NAME },
> +	{ LNG2DM_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index efd4394..c25ac50 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -60,6 +60,7 @@ static const struct spi_device_id st_accel_id_table[] = {
>  	{ LSM303AGR_ACCEL_DEV_NAME },
>  	{ LIS2DH12_ACCEL_DEV_NAME },
>  	{ LIS3L02DQ_ACCEL_DEV_NAME },
> +	{ LNG2DM_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_accel_id_table);
> 

