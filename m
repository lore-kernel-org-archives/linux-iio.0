Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdFUTwK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 15:52:10 -0400
Date: Wed, 21 Jun 2017 20:52:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: st_magn_core: enable multiread by
 default for LIS3MDL
Message-ID: <20170621205206.0f5416e4@kernel.org>
In-Reply-To: <20170620174245.6800-1-lorenzo.bianconi@st.com>
References: <20170620174245.6800-1-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Jun 2017 19:42:45 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Enable multiread by default for LIS3MDL since using I2C interface
> the subaddr Msb is used to automatically increase the slave address
> during multiple data read/write. In the same way, using SPI interface,
> bit 1 in register address is used to enable auto-increment of the slave
> address in multiple read/write.
> 
> Fixes: 872e79add756 (iio:magn: Add STMicroelectronics magn driver)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/st_magn_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 8e1b0861fbe4..3573636bad8e 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -315,7 +315,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  				},
>  			},
>  		},
> -		.multi_read_bit = false,
> +		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
>  	{

