Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753099AbdICQzR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 12:55:17 -0400
Date: Sun, 3 Sep 2017 17:55:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: pressure: add support to LPS33HW and LPS35HW
Message-ID: <20170903175513.7f177d2b@archlinux>
In-Reply-To: <20170902173915.17341-2-lorenzo.bianconi@st.com>
References: <20170902173915.17341-1-lorenzo.bianconi@st.com>
        <20170902173915.17341-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  2 Sep 2017 19:39:14 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> add support to STMicroelectronics LPS33HW and LPS35HW pressure sensors
> to st_pressure framework
> 
> http://www.st.com/resource/en/datasheet/lps33hw.pdf
> http://www.st.com/resource/en/datasheet/lps35hw.pdf
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/st_pressure.h      |  4 ++++
>  drivers/iio/pressure/st_pressure_core.c |  2 ++
>  drivers/iio/pressure/st_pressure_i2c.c  | 10 ++++++++++
>  drivers/iio/pressure/st_pressure_spi.c  | 10 ++++++++++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
> index 7d995937adba..e67eb0d971bf 100644
> --- a/drivers/iio/pressure/st_pressure.h
> +++ b/drivers/iio/pressure/st_pressure.h
> @@ -19,6 +19,8 @@ enum st_press_type {
>  	LPS25H,
>  	LPS331AP,
>  	LPS22HB,
> +	LPS33HW,
> +	LPS35HW,
>  	ST_PRESS_MAX,
>  };
>  
> @@ -26,6 +28,8 @@ enum st_press_type {
>  #define LPS25H_PRESS_DEV_NAME		"lps25h"
>  #define LPS331AP_PRESS_DEV_NAME		"lps331ap"
>  #define LPS22HB_PRESS_DEV_NAME		"lps22hb"
> +#define LPS33HW_PRESS_DEV_NAME		"lps33hw"
> +#define LPS35HW_PRESS_DEV_NAME		"lps35hw"
>  
>  /**
>   * struct st_sensors_platform_data - default press platform data
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 0c1c092cc157..b8890e37a2d2 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -419,6 +419,8 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LPS22HB_PRESS_DEV_NAME,
> +			[1] = LPS33HW_PRESS_DEV_NAME,
> +			[2] = LPS35HW_PRESS_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_press_lps22hb_channels,
>  		.num_ch = ARRAY_SIZE(st_press_lps22hb_channels),
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index 7f15e927fa2b..fbb59059e942 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -37,6 +37,14 @@ static const struct of_device_id st_press_of_match[] = {
>  		.compatible = "st,lps22hb-press",
>  		.data = LPS22HB_PRESS_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lps33hw",
> +		.data = LPS33HW_PRESS_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,lps35hw",
> +		.data = LPS35HW_PRESS_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_press_of_match);
> @@ -59,6 +67,8 @@ static const struct i2c_device_id st_press_id_table[] = {
>  	{ LPS25H_PRESS_DEV_NAME,  LPS25H },
>  	{ LPS331AP_PRESS_DEV_NAME, LPS331AP },
>  	{ LPS22HB_PRESS_DEV_NAME, LPS22HB },
> +	{ LPS33HW_PRESS_DEV_NAME, LPS33HW },
> +	{ LPS35HW_PRESS_DEV_NAME, LPS35HW },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_press_id_table);
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index f5ebd36bb4bf..9a3441b128e7 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -41,6 +41,14 @@ static const struct of_device_id st_press_of_match[] = {
>  		.compatible = "st,lps22hb-press",
>  		.data = LPS22HB_PRESS_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lps33hw",
> +		.data = LPS33HW_PRESS_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,lps35hw",
> +		.data = LPS35HW_PRESS_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_press_of_match);
> @@ -83,6 +91,8 @@ static const struct spi_device_id st_press_id_table[] = {
>  	{ LPS25H_PRESS_DEV_NAME },
>  	{ LPS331AP_PRESS_DEV_NAME },
>  	{ LPS22HB_PRESS_DEV_NAME },
> +	{ LPS33HW_PRESS_DEV_NAME },
> +	{ LPS35HW_PRESS_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_press_id_table);

