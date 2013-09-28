Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41700 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab3I1KEO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 06:04:14 -0400
Message-ID: <5246B7C6.7090206@kernel.org>
Date: Sat, 28 Sep 2013 12:04:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH] iio:magnetometer: Bugfix magnetometer default output
 registers
References: <1380034294-22887-1-git-send-email-denis.ciocca@st.com> <1380034294-22887-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1380034294-22887-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/24/13 15:51, Denis CIOCCA wrote:
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git

Does this want to go to stable as well?

Thanks,
> ---
>  drivers/iio/magnetometer/st_magn_core.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index e8d2849..cab3bc7 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -29,9 +29,9 @@
>  #define ST_MAGN_NUMBER_DATA_CHANNELS		3
>  
>  /* DEFAULT VALUE FOR SENSORS */
> -#define ST_MAGN_DEFAULT_OUT_X_L_ADDR		0X04
> -#define ST_MAGN_DEFAULT_OUT_Y_L_ADDR		0X08
> -#define ST_MAGN_DEFAULT_OUT_Z_L_ADDR		0X06
> +#define ST_MAGN_DEFAULT_OUT_X_H_ADDR		0X03
> +#define ST_MAGN_DEFAULT_OUT_Y_H_ADDR		0X07
> +#define ST_MAGN_DEFAULT_OUT_Z_H_ADDR		0X05
>  
>  /* FULLSCALE */
>  #define ST_MAGN_FS_AVL_1300MG			1300
> @@ -117,16 +117,16 @@
>  static const struct iio_chan_spec st_magn_16bit_channels[] = {
>  	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> -			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
> -			ST_MAGN_DEFAULT_OUT_X_L_ADDR),
> +			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_BE, 16, 16,
> +			ST_MAGN_DEFAULT_OUT_X_H_ADDR),
>  	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> -			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
> -			ST_MAGN_DEFAULT_OUT_Y_L_ADDR),
> +			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_BE, 16, 16,
> +			ST_MAGN_DEFAULT_OUT_Y_H_ADDR),
>  	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> -			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
> -			ST_MAGN_DEFAULT_OUT_Z_L_ADDR),
> +			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_BE, 16, 16,
> +			ST_MAGN_DEFAULT_OUT_Z_H_ADDR),
>  	IIO_CHAN_SOFT_TIMESTAMP(3)
>  };
>  
> 
