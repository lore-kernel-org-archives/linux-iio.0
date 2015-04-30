Return-Path: <pmeerw@pmeerw.net>
Date: Thu, 30 Apr 2015 16:56:51 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
    Denis CIOCCA <denis.ciocca@st.com>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 06/10] iio: st_accel: support 8bit channel data
In-Reply-To: <1430399755-26475-6-git-send-email-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.02.1504301637070.4190@pmeerw.net>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org> <1430399755-26475-6-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> Some sensors like the LIS331DL only support 8bit data by a single
> register per axis. These utilize the MSB byte. Make it possible
> to register these apropriately.

this doesn't seem right;

st_accel_8bit_channels is just added, but not used; this probably results 
in a warning

the start address, ST_ACCEL_DEFAULT_OUT_X_L_ADDR, is +1 to read just the 
MSB byte; but the storage size is still 16bit

the actual read is done in st_sensors_get_buffer_element(); with special 
case handling for the reads depending on the number of channels

I think either the _ADDR should not be +1 or the storage_bits should be 8, 
but not both

p.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/accel/st_accel_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 58d1d13d552a..689a9f360e7c 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -153,6 +153,22 @@
>  #define ST_ACCEL_4_IG1_EN_MASK			0x08
>  #define ST_ACCEL_4_MULTIREAD_BIT		true
>  
> +static const struct iio_chan_spec st_accel_8bit_channels[] = {
> +	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 8, 16,
> +			ST_ACCEL_DEFAULT_OUT_X_L_ADDR+1),
> +	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 8, 16,
> +			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR+1),
> +	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 8, 16,
> +			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR+1),
> +	IIO_CHAN_SOFT_TIMESTAMP(3)
> +};
> +
>  static const struct iio_chan_spec st_accel_12bit_channels[] = {
>  	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
