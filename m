Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752225AbdGISRk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 14:17:40 -0400
Date: Sun, 9 Jul 2017 19:17:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        linus.walleij@linaro.org, tiberiu.a.breana@intel.com
Subject: Re: [PATCH 1/3] iio: accel: st_accel_i2c: fix i2c_device_id table
Message-ID: <20170709191736.520e3acb@kernel.org>
In-Reply-To: <20170708110018.12772-2-lorenzo.bianconi@st.com>
References: <20170708110018.12772-1-lorenzo.bianconi@st.com>
        <20170708110018.12772-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  8 Jul 2017 13:00:16 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add H3LIS331DL, LIS331DL and LIS3LV02DL entries in st_accel_id_table
> 
> Fixes: 1e52fefc9b0c (iio: accel: Add support for the h3lis331dl accel)
> Fixes: bbf5f037fad4 (iio: st_accel: support the LIS331DL sensor)
> Fixes: 3acddf74f807 (iio: st-sensors: add support for lis3lv02d accel)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/st_accel.h     | 3 +++
>  drivers/iio/accel/st_accel_i2c.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 3ad44ce7ae82..fe3864f0f146 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -29,6 +29,9 @@ enum st_accel_type {
>  	LIS2DH12,
>  	LIS3L02DQ,
>  	LNG2DM,
> +	H3LIS331DL,
> +	LIS331DL,
> +	LIS3LV02DL,
>  	ST_ACCEL_MAX,
>  };
>  
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index ac67826135be..1b22c5714e89 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -126,6 +126,9 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LIS2DH12_ACCEL_DEV_NAME, LIS2DH12 },
>  	{ LIS3L02DQ_ACCEL_DEV_NAME, LIS3L02DQ },
>  	{ LNG2DM_ACCEL_DEV_NAME, LNG2DM },
> +	{ H3LIS331DL_DRIVER_NAME, H3LIS331DL },
> +	{ LIS331DL_ACCEL_DEV_NAME, LIS331DL },
> +	{ LIS3LV02DL_ACCEL_DEV_NAME, LIS3LV02DL },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);

