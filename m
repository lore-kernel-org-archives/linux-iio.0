Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752484AbdHQPF6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 11:05:58 -0400
Date: Thu, 17 Aug 2017 16:05:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: accel: add support to LIS2DW12
Message-ID: <20170817160551.2b22c1d5@archlinux>
In-Reply-To: <20170816191316.11469-5-lorenzo.bianconi@st.com>
References: <20170816191316.11469-1-lorenzo.bianconi@st.com>
        <20170816191316.11469-5-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 16 Aug 2017 21:13:15 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> add support to STMicroelectronics LIS2DW12 accelerometer in
> st_accel framework
> 
> http://www.st.com/resource/en/datasheet/lis2dw12.pdf
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Looks good to me from a quick glance (I haven't checked against the data
sheet).  Might take a closer look on v2.

Jonathan
> ---
>  drivers/iio/accel/st_accel.h      |  2 +
>  drivers/iio/accel/st_accel_core.c | 79 +++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c  |  5 +++
>  drivers/iio/accel/st_accel_spi.c  |  5 +++
>  4 files changed, 91 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 0fe521609a3a..2ed0f60418c0 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -32,6 +32,7 @@ enum st_accel_type {
>  	H3LIS331DL,
>  	LIS331DL,
>  	LIS3LV02DL,
> +	LIS2DW12,
>  	ST_ACCEL_MAX,
>  };
>  
> @@ -52,6 +53,7 @@ enum st_accel_type {
>  #define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
>  #define LIS3L02DQ_ACCEL_DEV_NAME	"lis3l02dq"
>  #define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
> +#define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
>  
>  /**
>  * struct st_sensors_platform_data - default accel platform data
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 4d9190625630..42ada20daca0 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -692,6 +692,85 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> +	{
> +		.wai = 0x44,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = LIS2DW12_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
> +		.odr = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
> +			.odr_avl = {
> +				{ .hz = 1, .value = 0x01, },
> +				{ .hz = 12, .value = 0x02, },
> +				{ .hz = 25, .value = 0x03, },
> +				{ .hz = 50, .value = 0x04, },
> +				{ .hz = 100, .value = 0x05, },
> +				{ .hz = 200, .value = 0x06, },
> +			},
> +		},
> +		.pw = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.fs = {
> +			.addr = 0x25,
> +			.mask = 0x30,
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_ACCEL_FS_AVL_2G,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(976),
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_4G,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(1952),
> +				},
> +				[2] = {
> +					.num = ST_ACCEL_FS_AVL_8G,
> +					.value = 0x02,
> +					.gain = IIO_G_TO_M_S_2(3904),
> +				},
> +				[3] = {
> +					.num = ST_ACCEL_FS_AVL_16G,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(7808),
> +				},
> +			},
> +		},
> +		.bdu = {
> +			.addr = 0x21,
> +			.mask = 0x08,
> +		},
> +		.drdy_irq = {
> +			.int1 = {
> +				.addr = 0x23,
> +				.mask = 0x01,
> +			},
> +			.int2 = {
> +				.addr = 0x24,
> +				.mask = 0x01,
> +			},
> +			.addr_ihl = 0x22,
> +			.mask_ihl = 0x08,
> +			.addr_od = 0x22,
> +			.mask_od = 0x20,
> +			.stat_drdy = {
> +				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
> +				.mask = 0x01,
> +			},
> +		},
> +		.sim = {
> +			.addr = 0x21,
> +			.value = BIT(0),
> +		},
> +		.multi_read_bit = false,
> +		.bootime = 2,
> +	},
>  };
>  
>  static int st_accel_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 18cafb9f2468..363429b5686c 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -94,6 +94,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lng2dm-accel",
>  		.data = LNG2DM_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2dw12",
> +		.data = LIS2DW12_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -129,6 +133,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ H3LIS331DL_ACCEL_DEV_NAME, H3LIS331DL },
>  	{ LIS331DL_ACCEL_DEV_NAME, LIS331DL },
>  	{ LIS3LV02DL_ACCEL_DEV_NAME, LIS3LV02DL },
> +	{ LIS2DW12_ACCEL_DEV_NAME, LIS2DW12 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 915fa49085f7..7692da49e59f 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -82,6 +82,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis331dl-accel",
>  		.data = LIS331DL_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2dw12",
> +		.data = LIS2DW12_ACCEL_DEV_NAME,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -133,6 +137,7 @@ static const struct spi_device_id st_accel_id_table[] = {
>  	{ H3LIS331DL_ACCEL_DEV_NAME },
>  	{ LIS331DL_ACCEL_DEV_NAME },
>  	{ LIS3LV02DL_ACCEL_DEV_NAME },
> +	{ LIS2DW12_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_accel_id_table);

