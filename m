Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33121 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932277AbcE2POY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 11:14:24 -0400
Subject: Re: [RFC PATCH v1 2/9] iio:st_pressure: fix sampling gains
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <c9eb30c178e4643be23bcd09ca706b08ee69d04b.1461056711.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <453dba90-156c-1193-4cac-41da39e16938@kernel.org>
Date: Sun, 29 May 2016 16:14:22 +0100
MIME-Version: 1.0
In-Reply-To: <c9eb30c178e4643be23bcd09ca706b08ee69d04b.1461056711.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/16 10:18, Gregor Boirie wrote:
> Temperature channels report scaled samples in Celsius although expected as
> milli degree Celsius in Documentation/ABI/testing/sysfs-bus-iio.
> Gains are not implemented at all for LPS001WP pressure and temperature
> channels.
> 
> This patch ensures that proper offsets and scales are exposed to userpace
> for both pressure and temperature channels.
> Also fix a NULL pointer exception when userspace reads content of sysfs
> scale attribute when gains are not defined.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Hi Gregor,

This patch could do with a few comments to explain the values
of the various constants.  Personally I'm really beginning to
dislike the way these drivers have simple numeric values
wrapped up in defines at the top.  Would be somewhat clearer
if they were just inline.

Defines are fine for 'magic' numbers, but these are just
obscuring the straight forward values. Anyhow, not one to
fix up in this series!

I'm happy the fixes and new elements in here are correct.
However, we really ought to be pushing the fix elements
to stable trees so they'll need to get separated out from
the very minor parts that were added in the previous patch.

Also, we don't want things like updating datasheet paths in a
fix patch.  It's useful to do so but that wants to go in
as a separate patch.

I've stripped out the relevant bits for the fix patch and
applied it to the fixes-togreg-post-rc1 branch of iio.git.
Please keep in mind for future 'fix' patches - the aim is
the minimum changes possible.

Hope you don't mind rebasing the other odds and ends on
top of this.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/st_pressure_core.c | 109 ++++++++++++++++++++++----------
>  1 file changed, 75 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index c0ff3bf..b8087b9 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -28,21 +28,31 @@
>  #include <linux/iio/common/st_sensors.h>
>  #include "st_pressure.h"
>  
> +#define MCELSIUS_PER_CELSIUS			1000
> +
> +/* Default pressure sensitivity */
>  #define ST_PRESS_LSB_PER_MBAR			4096UL
>  #define ST_PRESS_KPASCAL_NANO_SCALE		(100000000UL / \
>  						 ST_PRESS_LSB_PER_MBAR)
> +
> +/* Default temperature sensitivity */
>  #define ST_PRESS_LSB_PER_CELSIUS		480UL
> -#define ST_PRESS_CELSIUS_NANO_SCALE		(1000000000UL / \
> -						 ST_PRESS_LSB_PER_CELSIUS)
> +#define ST_PRESS_MILLI_CELSIUS_OFFSET		42500UL
> +
>  #define ST_PRESS_NUMBER_DATA_CHANNELS		1
>  
>  /* FULLSCALE */
> +#define ST_PRESS_FS_AVL_1100MB			1100
>  #define ST_PRESS_FS_AVL_1260MB			1260
>  
>  #define ST_PRESS_1_OUT_XL_ADDR			0x28
>  #define ST_TEMP_1_OUT_L_ADDR			0x2b
>  
> -/* CUSTOM VALUES FOR LPS331AP SENSOR */
> +/*
> + * CUSTOM VALUES FOR LPS331AP SENSOR
> + * See LPS331AP datasheet:
> + * http://www2.st.com/resource/en/datasheet/lps331ap.pdf
> + */
>  #define ST_PRESS_LPS331AP_WAI_EXP		0xbb
>  #define ST_PRESS_LPS331AP_ODR_ADDR		0x20
>  #define ST_PRESS_LPS331AP_ODR_MASK		0x70
> @@ -54,9 +64,6 @@
>  #define ST_PRESS_LPS331AP_PW_MASK		0x80
>  #define ST_PRESS_LPS331AP_FS_ADDR		0x23
>  #define ST_PRESS_LPS331AP_FS_MASK		0x30
> -#define ST_PRESS_LPS331AP_FS_AVL_1260_VAL	0x00
> -#define ST_PRESS_LPS331AP_FS_AVL_1260_GAIN	ST_PRESS_KPASCAL_NANO_SCALE
> -#define ST_PRESS_LPS331AP_FS_AVL_TEMP_GAIN	ST_PRESS_CELSIUS_NANO_SCALE
>  #define ST_PRESS_LPS331AP_BDU_ADDR		0x20
>  #define ST_PRESS_LPS331AP_BDU_MASK		0x04
>  #define ST_PRESS_LPS331AP_DRDY_IRQ_ADDR		0x22
> @@ -67,9 +74,19 @@
>  #define ST_PRESS_LPS331AP_OD_IRQ_ADDR		0x22
>  #define ST_PRESS_LPS331AP_OD_IRQ_MASK		0x40
>  #define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
> -#define ST_PRESS_LPS331AP_TEMP_OFFSET		42500
>  
> -/* CUSTOM VALUES FOR LPS001WP SENSOR */
> +/*
> + * CUSTOM VALUES FOR LPS001WP SENSOR
> + *
> + * See LPS001WP datasheet:
> + * http://www.st.com/web/en/resource/technical/document/datasheet/CD00289624.pdf
They seem to have changed this link..
> + */
> +
> +/* LPS001WP pressure resolution */
> +#define ST_PRESS_LPS001WP_LSB_PER_MBAR		16UL
> +/* LPS001WP temperature resolution */
> +#define ST_PRESS_LPS001WP_LSB_PER_CELSIUS	64UL
> +
>  #define ST_PRESS_LPS001WP_WAI_EXP		0xba
>  #define ST_PRESS_LPS001WP_ODR_ADDR		0x20
>  #define ST_PRESS_LPS001WP_ODR_MASK		0x30
> @@ -78,13 +95,19 @@
>  #define ST_PRESS_LPS001WP_ODR_AVL_13HZ_VAL	0x03
>  #define ST_PRESS_LPS001WP_PW_ADDR		0x20
>  #define ST_PRESS_LPS001WP_PW_MASK		0x40
> +#define ST_PRESS_LPS001WP_FS_AVL_PRESS_GAIN \
> +	(100000000UL / ST_PRESS_LPS001WP_LSB_PER_MBAR)
This took me a few moments.  100 million / 16?

Our pressure units are kilopascals - I would imagine this
is getting used as the gain value which would be expected to be
the same as the value for each LSB which I think should bbe 100 / 16 or
0.0625 ah - you are then using int + nano so your
value is 0.006250000 which is correct.

>  #define ST_PRESS_LPS001WP_BDU_ADDR		0x20
>  #define ST_PRESS_LPS001WP_BDU_MASK		0x04
>  #define ST_PRESS_LPS001WP_MULTIREAD_BIT		true
>  #define ST_PRESS_LPS001WP_OUT_L_ADDR		0x28
>  #define ST_TEMP_LPS001WP_OUT_L_ADDR		0x2a
>  
> -/* CUSTOM VALUES FOR LPS25H SENSOR */
> +/*
> + * CUSTOM VALUES FOR LPS25H SENSOR
> + * See LPS25H datasheet:
> + * http://www2.st.com/resource/en/datasheet/lps25h.pdf
> + */
>  #define ST_PRESS_LPS25H_WAI_EXP			0xbd
>  #define ST_PRESS_LPS25H_ODR_ADDR		0x20
>  #define ST_PRESS_LPS25H_ODR_MASK		0x70
> @@ -94,11 +117,6 @@
>  #define ST_PRESS_LPS25H_ODR_AVL_25HZ_VAL	0x04
>  #define ST_PRESS_LPS25H_PW_ADDR			0x20
>  #define ST_PRESS_LPS25H_PW_MASK			0x80
So these are dropped because it isn't controllable?
> -#define ST_PRESS_LPS25H_FS_ADDR			0x00
> -#define ST_PRESS_LPS25H_FS_MASK			0x00
> -#define ST_PRESS_LPS25H_FS_AVL_1260_VAL		0x00
> -#define ST_PRESS_LPS25H_FS_AVL_1260_GAIN	ST_PRESS_KPASCAL_NANO_SCALE
> -#define ST_PRESS_LPS25H_FS_AVL_TEMP_GAIN	ST_PRESS_CELSIUS_NANO_SCALE
>  #define ST_PRESS_LPS25H_BDU_ADDR		0x20
>  #define ST_PRESS_LPS25H_BDU_MASK		0x04
>  #define ST_PRESS_LPS25H_DRDY_IRQ_ADDR		0x23
> @@ -109,11 +127,14 @@
>  #define ST_PRESS_LPS25H_OD_IRQ_ADDR		0x22
>  #define ST_PRESS_LPS25H_OD_IRQ_MASK		0x40
>  #define ST_PRESS_LPS25H_MULTIREAD_BIT		true
> -#define ST_PRESS_LPS25H_TEMP_OFFSET		42500
>  #define ST_PRESS_LPS25H_OUT_XL_ADDR		0x28
>  #define ST_TEMP_LPS25H_OUT_L_ADDR		0x2b
>  
> -/* CUSTOM VALUES FOR LPS22HB SENSOR */
> +/*
> + * CUSTOM VALUES FOR LPS22HB SENSOR
> + * See LPS22HB datasheet:
> + * http://www2.st.com/resource/en/datasheet/lps22hb.pdf
> + */
>  #define ST_PRESS_LPS22HB_WAI_EXP		0xb1
>  #define ST_PRESS_LPS22HB_ODR_ADDR		0x10
>  #define ST_PRESS_LPS22HB_ODR_MASK		0x70
> @@ -181,7 +202,9 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>  			.storagebits = 16,
>  			.endianness = IIO_LE,
>  		},
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
>  		.modified = 0,
>  	},
>  	{
> @@ -197,7 +220,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>  		},
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_OFFSET),
> +			BIT(IIO_CHAN_INFO_SCALE),
>  		.modified = 0,
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(1)
> @@ -253,11 +276,14 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.addr = ST_PRESS_LPS331AP_FS_ADDR,
>  			.mask = ST_PRESS_LPS331AP_FS_MASK,
>  			.fs_avl = {
> +				/*
> +				 * Pressure and temperature sensitivity values
> +				 * as defined in table 3 of LPS331AP datasheet.
> +				 */
>  				[0] = {
>  					.num = ST_PRESS_FS_AVL_1260MB,
> -					.value = ST_PRESS_LPS331AP_FS_AVL_1260_VAL,
> -					.gain = ST_PRESS_LPS331AP_FS_AVL_1260_GAIN,
> -					.gain2 = ST_PRESS_LPS331AP_FS_AVL_TEMP_GAIN,
> +					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
> +					.gain2 = ST_PRESS_LSB_PER_CELSIUS,
>  				},
>  			},
>  		},
> @@ -302,7 +328,17 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
>  		.fs = {
> -			.addr = 0,
> +			.fs_avl = {
> +				/*
> +				 * Pressure and temperature resolution values
> +				 * as defined in table 3 of LPS001WP datasheet.
> +				 */
> +				[0] = {
> +					.num = ST_PRESS_FS_AVL_1100MB,
> +					.gain = ST_PRESS_LPS001WP_FS_AVL_PRESS_GAIN,
> +					.gain2 = ST_PRESS_LPS001WP_LSB_PER_CELSIUS,
> +				},
> +			},
>  		},
>  		.bdu = {
>  			.addr = ST_PRESS_LPS001WP_BDU_ADDR,
> @@ -339,14 +375,15 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
>  		.fs = {
> -			.addr = ST_PRESS_LPS25H_FS_ADDR,
> -			.mask = ST_PRESS_LPS25H_FS_MASK,
>  			.fs_avl = {
> +				/*
> +				 * Pressure and temperature sensitivity values
> +				 * as defined in table 3 of LPS25H datasheet.
> +				 */
>  				[0] = {
>  					.num = ST_PRESS_FS_AVL_1260MB,
> -					.value = ST_PRESS_LPS25H_FS_AVL_1260_VAL,
> -					.gain = ST_PRESS_LPS25H_FS_AVL_1260_GAIN,
> -					.gain2 = ST_PRESS_LPS25H_FS_AVL_TEMP_GAIN,
> +					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
> +					.gain2 = ST_PRESS_LSB_PER_CELSIUS,
>  				},
>  			},
>  		},
> @@ -393,6 +430,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		},
>  		.fs = {
>  			.fs_avl = {
> +				/*
> +				 * Sensitivity values as defined in table 3 of
> +				 * LPS22HB datasheet.
> +				 */
>  				[0] = {
>  					.num = ST_PRESS_FS_AVL_1260MB,
>  					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
> @@ -450,26 +491,26 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -
>  		switch (ch->type) {
>  		case IIO_PRESSURE:
> +			*val = 0;
>  			*val2 = press_data->current_fullscale->gain;
> -			break;
> +			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_TEMP:
> +			*val = MCELSIUS_PER_CELSIUS;
>  			*val2 = press_data->current_fullscale->gain2;
> -			break;
> +			return IIO_VAL_FRACTIONAL;
>  		default:
>  			err = -EINVAL;
>  			goto read_error;
>  		}
>  
> -		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (ch->type) {
>  		case IIO_TEMP:
> -			*val = 425;
> -			*val2 = 10;
> +			*val = ST_PRESS_MILLI_CELSIUS_OFFSET *
> +			       press_data->current_fullscale->gain2;
> +			*val2 = MCELSIUS_PER_CELSIUS;
>  			break;
>  		default:
>  			err = -EINVAL;
> 

