Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754997AbdFXTqW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 15:46:22 -0400
Date: Sat, 24 Jun 2017 20:46:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: gregor.boirie@parrot.com, linux-iio@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH] iio: pressure: st_pressure_core: disable multiread by
 default for LPS22HB
Message-ID: <20170624204617.2a9c5450@kernel.org>
In-Reply-To: <20170622174643.13259-1-lorenzo.bianconi@st.com>
References: <20170622174643.13259-1-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 22 Jun 2017 19:46:43 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Set multiread variable to false for LPS22HB pressure sensor since
> it is already enabled in CTRL_REG2. Previous configuration does not
> cause any issue in I2C communication since SUB Msb has no meaning
> whereas it breaks register address in SPI communication
> 
> Fixes: e039e2f5b4da (iio:st_pressure:initial lps22hb sensor support)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
This will probably only go upstream after the merge window now.

Jonathan

> ---
>  drivers/iio/pressure/st_pressure_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index aa61ec15c139..f1bce05ffa13 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -456,7 +456,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.mask_od = 0x40,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = true,
> +		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
>  };

