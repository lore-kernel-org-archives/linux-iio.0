Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36222 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbcGDRPP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 13:15:15 -0400
Subject: Re: [PATCH v2 3/7] iio:st_pressure: document sampling gains
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1467023672.git.gregor.boirie@parrot.com>
 <fe513b34c179810b42a77e806347088647d17106.1467023672.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <06967594-1d94-398b-a0ec-ac722a6313e1@kernel.org>
Date: Mon, 4 Jul 2016 18:15:12 +0100
MIME-Version: 1.0
In-Reply-To: <fe513b34c179810b42a77e806347088647d17106.1467023672.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 11:38, Gregor Boirie wrote:
> Details scaling factors and offsets applied to raw temperature and pressure
> samples.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied. 
> ---
>  drivers/iio/pressure/st_pressure_core.c | 92 +++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 8fa3d81..2ab1056 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -28,6 +28,72 @@
>  #include <linux/iio/common/st_sensors.h>
>  #include "st_pressure.h"
>  
> +/*
> + * About determining pressure scaling factors
> + * ------------------------------------------
> + *
> + * Datasheets specify typical pressure sensitivity so that pressure is computed
> + * according to the following equation :
> + *     pressure[mBar] = raw / sensitivity
> + * where :
> + *     raw          the 24 bits long raw sampled pressure
> + *     sensitivity  a scaling factor specified by the datasheet in LSB/mBar
> + *
> + * IIO ABI expects pressure to be expressed as kPascal, hence pressure should be
> + * computed according to :
> + *     pressure[kPascal] = pressure[mBar] / 10
> + *                       = raw / (sensitivity * 10)                          (1)
> + *
> + * Finally, st_press_read_raw() returns pressure scaling factor as an
> + * IIO_VAL_INT_PLUS_NANO with a zero integral part and "gain" as decimal part.
> + * Therefore, from (1), "gain" becomes :
> + *     gain = 10^9 / (sensitivity * 10)
> + *          = 10^8 / sensitivity
> + *
> + * About determining temperature scaling factors and offsets
> + * ---------------------------------------------------------
> + *
> + * Datasheets specify typical temperature sensitivity and offset so that
> + * temperature is computed according to the following equation :
> + *     temp[Celsius] = offset[Celsius] + (raw / sensitivity)
> + * where :
> + *     raw          the 16 bits long raw sampled temperature
> + *     offset       a constant specified by the datasheet in degree Celsius
> + *                  (sometimes zero)
> + *     sensitivity  a scaling factor specified by the datasheet in LSB/Celsius
> + *
> + * IIO ABI expects temperature to be expressed as milli degree Celsius such as
> + * user space should compute temperature according to :
> + *     temp[mCelsius] = temp[Celsius] * 10^3
> + *                    = (offset[Celsius] + (raw / sensitivity)) * 10^3
> + *                    = ((offset[Celsius] * sensitivity) + raw) *
> + *                      (10^3 / sensitivity)                                 (2)
> + *
> + * IIO ABI expects user space to apply offset and scaling factors to raw samples
> + * according to :
> + *     temp[mCelsius] = (OFFSET + raw) * SCALE
> + * where :
> + *     OFFSET an arbitrary constant exposed by device
> + *     SCALE  an arbitrary scaling factor exposed by device
> + *
> + * Matching OFFSET and SCALE with members of (2) gives :
> + *     OFFSET = offset[Celsius] * sensitivity                                (3)
> + *     SCALE  = 10^3 / sensitivity                                           (4)
> + *
> + * st_press_read_raw() returns temperature scaling factor as an
> + * IIO_VAL_FRACTIONAL with a 10^3 numerator and "gain2" as denominator.
> + * Therefore, from (3), "gain2" becomes :
> + *     gain2 = sensitivity
> + *
> + * When declared within channel, i.e. for a non zero specified offset,
> + * st_press_read_raw() will return the latter as an IIO_VAL_FRACTIONAL such as :
> + *     numerator = OFFSET * 10^3
> + *     denominator = 10^3
> + * giving from (4):
> + *     numerator = offset[Celsius] * 10^3 * sensitivity
> + *               = offset[mCelsius] * gain2
> + */
> +
>  #define MCELSIUS_PER_CELSIUS			1000
>  
>  /* Default pressure sensitivity */
> @@ -48,7 +114,11 @@
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
> @@ -71,7 +141,9 @@
>  #define ST_PRESS_LPS331AP_OD_IRQ_MASK		0x40
>  #define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
>  
> -/* CUSTOM VALUES FOR LPS001WP SENSOR */
> +/*
> + * CUSTOM VALUES FOR THE OBSOLETE LPS001WP SENSOR
> + */
>  
>  /* LPS001WP pressure resolution */
>  #define ST_PRESS_LPS001WP_LSB_PER_MBAR		16UL
> @@ -94,7 +166,11 @@
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
> @@ -117,7 +193,11 @@
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
> @@ -413,6 +493,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
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
> 

