Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48120 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcFZRiy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 13:38:54 -0400
Subject: Re: [PATCH v1 7/7] iio:st_pressure:lps22hb: temperature support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1466687364.git.gregor.boirie@parrot.com>
 <b4869f2d40e47f62113559dfd98e0d38cac56cbb.1466687364.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a9d3ead7-a106-2a38-50c8-294461dbdad1@kernel.org>
Date: Sun, 26 Jun 2016 18:38:52 +0100
MIME-Version: 1.0
In-Reply-To: <b4869f2d40e47f62113559dfd98e0d38cac56cbb.1466687364.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/06/16 14:49, Gregor Boirie wrote:
> Implement lps22hb temperature sampling channel.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
one small comment in this.  I'll clear it up if the rest of the
series is good to go.

Thanks for getting back to this stuff.
I hope it was a good sort of busy :)

Jonathan
> ---
>  drivers/iio/pressure/st_pressure_core.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index fad54c3..fdc228c 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -196,6 +196,10 @@
>   * See LPS22HB datasheet:
>   * http://www2.st.com/resource/en/datasheet/lps22hb.pdf
>   */
> +
> +/* LPS22HB temperature sensitivity */
> +#define ST_PRESS_LPS22HB_LSB_PER_CELSIUS	100UL
> +
>  #define ST_PRESS_LPS22HB_WAI_EXP		0xb1
>  #define ST_PRESS_LPS22HB_ODR_ADDR		0x10
>  #define ST_PRESS_LPS22HB_ODR_MASK		0x70
> @@ -307,7 +311,24 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.modified = 0,
>  	},
> -	IIO_CHAN_SOFT_TIMESTAMP(1)
> +	{
> +		.type = IIO_TEMP,
> +		.channel2 = IIO_NO_MOD,
No need to specify this as no mod is the default + if not modified it won't be
read by anything anyway.

> +		.address = ST_TEMP_1_OUT_L_ADDR,
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.modified = 0,
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2)
>  };
>  
>  static const struct st_sensor_settings st_press_sensors_settings[] = {
> @@ -494,12 +515,13 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		.fs = {
>  			.fs_avl = {
>  				/*
> -				 * Sensitivity values as defined in table 3 of
> -				 * LPS22HB datasheet.
> +				 * Pressure and temperature sensitivity values
> +				 * as defined in table 3 of LPS22HB datasheet.
>  				 */
>  				[0] = {
>  					.num = ST_PRESS_FS_AVL_1260MB,
>  					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
> +					.gain2 = ST_PRESS_LPS22HB_LSB_PER_CELSIUS,
>  				},
>  			},
>  		},
> 

