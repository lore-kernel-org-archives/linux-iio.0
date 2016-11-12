Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35623 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934577AbcKLPue (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 10:50:34 -0500
Subject: Re: [PATCH 4/4] iio: pressure: st_pressure: inline per-sensor data
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1478704200-19046-1-git-send-email-linus.walleij@linaro.org>
 <1478704200-19046-5-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <af58959c-4a00-0822-1c12-6fb0211147a6@kernel.org>
Date: Sat, 12 Nov 2016 15:50:27 +0000
MIME-Version: 1.0
In-Reply-To: <1478704200-19046-5-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/16 15:10, Linus Walleij wrote:
> We have #defines for all the individual sensor registers and
> value/mask pairs #defined at the top of the file and used at
> exactly one spot.
> 
> This is usually good if the #defines give a meaning to the
> opaque magic numbers.
> 
> However in this case, the semantic meaning is inherent in the
> name of the C99-addressable fields, and that means duplication
> of information, and only makes the code hard to maintain since
> you every time have to add a new #define AND update the site
> where it is to be used.
> 
> Get rid of the #defines and just open code the values into the
> appropriate struct elements. Make sure to explicitly address
> the .hz and .value fields in the st_sensor_odr_avl struct
> so that the meaning of all values is clear.
> 
> This patch is purely syntactic should have no semantic effect.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Also good. Applied to the togreg branch of iio.git and pushed out
soon as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/st_pressure_core.c | 257 ++++++++++++--------------------
>  1 file changed, 92 insertions(+), 165 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 55df9a75eb3a..e19e0787864c 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -112,115 +112,24 @@
>  #define ST_PRESS_1_OUT_XL_ADDR			0x28
>  #define ST_TEMP_1_OUT_L_ADDR			0x2b
>  
> -/*
> - * CUSTOM VALUES FOR LPS331AP SENSOR
> - * See LPS331AP datasheet:
> - * http://www2.st.com/resource/en/datasheet/lps331ap.pdf
> - */
> -#define ST_PRESS_LPS331AP_WAI_EXP		0xbb
> -#define ST_PRESS_LPS331AP_ODR_ADDR		0x20
> -#define ST_PRESS_LPS331AP_ODR_MASK		0x70
> -#define ST_PRESS_LPS331AP_ODR_AVL_1HZ_VAL	0x01
> -#define ST_PRESS_LPS331AP_ODR_AVL_7HZ_VAL	0x05
> -#define ST_PRESS_LPS331AP_ODR_AVL_13HZ_VAL	0x06
> -#define ST_PRESS_LPS331AP_ODR_AVL_25HZ_VAL	0x07
> -#define ST_PRESS_LPS331AP_PW_ADDR		0x20
> -#define ST_PRESS_LPS331AP_PW_MASK		0x80
> -#define ST_PRESS_LPS331AP_FS_ADDR		0x23
> -#define ST_PRESS_LPS331AP_FS_MASK		0x30
> -#define ST_PRESS_LPS331AP_BDU_ADDR		0x20
> -#define ST_PRESS_LPS331AP_BDU_MASK		0x04
> -#define ST_PRESS_LPS331AP_DRDY_IRQ_ADDR		0x22
> -#define ST_PRESS_LPS331AP_DRDY_IRQ_INT1_MASK	0x04
> -#define ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK	0x20
> -#define ST_PRESS_LPS331AP_IHL_IRQ_ADDR		0x22
> -#define ST_PRESS_LPS331AP_IHL_IRQ_MASK		0x80
> -#define ST_PRESS_LPS331AP_OD_IRQ_ADDR		0x22
> -#define ST_PRESS_LPS331AP_OD_IRQ_MASK		0x40
> -#define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
> -
> -/*
> - * CUSTOM VALUES FOR THE OBSOLETE LPS001WP SENSOR
> - */
> -
>  /* LPS001WP pressure resolution */
>  #define ST_PRESS_LPS001WP_LSB_PER_MBAR		16UL
>  /* LPS001WP temperature resolution */
>  #define ST_PRESS_LPS001WP_LSB_PER_CELSIUS	64UL
> -
> -#define ST_PRESS_LPS001WP_WAI_EXP		0xba
> -#define ST_PRESS_LPS001WP_ODR_ADDR		0x20
> -#define ST_PRESS_LPS001WP_ODR_MASK		0x30
> -#define ST_PRESS_LPS001WP_ODR_AVL_1HZ_VAL	0x01
> -#define ST_PRESS_LPS001WP_ODR_AVL_7HZ_VAL	0x02
> -#define ST_PRESS_LPS001WP_ODR_AVL_13HZ_VAL	0x03
> -#define ST_PRESS_LPS001WP_PW_ADDR		0x20
> -#define ST_PRESS_LPS001WP_PW_MASK		0x40
> +/* LPS001WP pressure gain */
>  #define ST_PRESS_LPS001WP_FS_AVL_PRESS_GAIN \
>  	(100000000UL / ST_PRESS_LPS001WP_LSB_PER_MBAR)
> -#define ST_PRESS_LPS001WP_BDU_ADDR		0x20
> -#define ST_PRESS_LPS001WP_BDU_MASK		0x04
> -#define ST_PRESS_LPS001WP_MULTIREAD_BIT		true
> +/* LPS001WP pressure and temp L addresses */
>  #define ST_PRESS_LPS001WP_OUT_L_ADDR		0x28
>  #define ST_TEMP_LPS001WP_OUT_L_ADDR		0x2a
>  
> -/*
> - * CUSTOM VALUES FOR LPS25H SENSOR
> - * See LPS25H datasheet:
> - * http://www2.st.com/resource/en/datasheet/lps25h.pdf
> - */
> -#define ST_PRESS_LPS25H_WAI_EXP			0xbd
> -#define ST_PRESS_LPS25H_ODR_ADDR		0x20
> -#define ST_PRESS_LPS25H_ODR_MASK		0x70
> -#define ST_PRESS_LPS25H_ODR_AVL_1HZ_VAL		0x01
> -#define ST_PRESS_LPS25H_ODR_AVL_7HZ_VAL		0x02
> -#define ST_PRESS_LPS25H_ODR_AVL_13HZ_VAL	0x03
> -#define ST_PRESS_LPS25H_ODR_AVL_25HZ_VAL	0x04
> -#define ST_PRESS_LPS25H_PW_ADDR			0x20
> -#define ST_PRESS_LPS25H_PW_MASK			0x80
> -#define ST_PRESS_LPS25H_BDU_ADDR		0x20
> -#define ST_PRESS_LPS25H_BDU_MASK		0x04
> -#define ST_PRESS_LPS25H_DRDY_IRQ_ADDR		0x23
> -#define ST_PRESS_LPS25H_DRDY_IRQ_INT1_MASK	0x01
> -#define ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK	0x10
> -#define ST_PRESS_LPS25H_IHL_IRQ_ADDR		0x22
> -#define ST_PRESS_LPS25H_IHL_IRQ_MASK		0x80
> -#define ST_PRESS_LPS25H_OD_IRQ_ADDR		0x22
> -#define ST_PRESS_LPS25H_OD_IRQ_MASK		0x40
> -#define ST_PRESS_LPS25H_MULTIREAD_BIT		true
> +/* LPS25H pressure and temp L addresses */
>  #define ST_PRESS_LPS25H_OUT_XL_ADDR		0x28
>  #define ST_TEMP_LPS25H_OUT_L_ADDR		0x2b
>  
> -/*
> - * CUSTOM VALUES FOR LPS22HB SENSOR
> - * See LPS22HB datasheet:
> - * http://www2.st.com/resource/en/datasheet/lps22hb.pdf
> - */
> -
>  /* LPS22HB temperature sensitivity */
>  #define ST_PRESS_LPS22HB_LSB_PER_CELSIUS	100UL
>  
> -#define ST_PRESS_LPS22HB_WAI_EXP		0xb1
> -#define ST_PRESS_LPS22HB_ODR_ADDR		0x10
> -#define ST_PRESS_LPS22HB_ODR_MASK		0x70
> -#define ST_PRESS_LPS22HB_ODR_AVL_1HZ_VAL	0x01
> -#define ST_PRESS_LPS22HB_ODR_AVL_10HZ_VAL	0x02
> -#define ST_PRESS_LPS22HB_ODR_AVL_25HZ_VAL	0x03
> -#define ST_PRESS_LPS22HB_ODR_AVL_50HZ_VAL	0x04
> -#define ST_PRESS_LPS22HB_ODR_AVL_75HZ_VAL	0x05
> -#define ST_PRESS_LPS22HB_PW_ADDR		0x10
> -#define ST_PRESS_LPS22HB_PW_MASK		0x70
> -#define ST_PRESS_LPS22HB_BDU_ADDR		0x10
> -#define ST_PRESS_LPS22HB_BDU_MASK		0x02
> -#define ST_PRESS_LPS22HB_DRDY_IRQ_ADDR		0x12
> -#define ST_PRESS_LPS22HB_DRDY_IRQ_INT1_MASK	0x04
> -#define ST_PRESS_LPS22HB_DRDY_IRQ_INT2_MASK	0x08
> -#define ST_PRESS_LPS22HB_IHL_IRQ_ADDR		0x12
> -#define ST_PRESS_LPS22HB_IHL_IRQ_MASK		0x80
> -#define ST_PRESS_LPS22HB_OD_IRQ_ADDR		0x12
> -#define ST_PRESS_LPS22HB_OD_IRQ_MASK		0x40
> -#define ST_PRESS_LPS22HB_MULTIREAD_BIT		true
> -
>  static const struct iio_chan_spec st_press_1_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> @@ -321,7 +230,12 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
>  
>  static const struct st_sensor_settings st_press_sensors_settings[] = {
>  	{
> -		.wai = ST_PRESS_LPS331AP_WAI_EXP,
> +		/*
> +		 * CUSTOM VALUES FOR LPS331AP SENSOR
> +		 * See LPS331AP datasheet:
> +		 * http://www2.st.com/resource/en/datasheet/lps331ap.pdf
> +		 */
> +		.wai = 0xbb,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LPS331AP_PRESS_DEV_NAME,
> @@ -329,24 +243,24 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		.ch = (struct iio_chan_spec *)st_press_1_channels,
>  		.num_ch = ARRAY_SIZE(st_press_1_channels),
>  		.odr = {
> -			.addr = ST_PRESS_LPS331AP_ODR_ADDR,
> -			.mask = ST_PRESS_LPS331AP_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x70,
>  			.odr_avl = {
> -				{ 1, ST_PRESS_LPS331AP_ODR_AVL_1HZ_VAL, },
> -				{ 7, ST_PRESS_LPS331AP_ODR_AVL_7HZ_VAL, },
> -				{ 13, ST_PRESS_LPS331AP_ODR_AVL_13HZ_VAL, },
> -				{ 25, ST_PRESS_LPS331AP_ODR_AVL_25HZ_VAL, },
> +				{ .hz = 1, .value = 0x01 },
> +				{ .hz = 7, .value = 0x05 },
> +				{ .hz = 13, .value = 0x06 },
> +				{ .hz = 25, .value = 0x07 },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_PRESS_LPS331AP_PW_ADDR,
> -			.mask = ST_PRESS_LPS331AP_PW_MASK,
> +			.addr = 0x20,
> +			.mask = 0x80,
>  			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
>  		.fs = {
> -			.addr = ST_PRESS_LPS331AP_FS_ADDR,
> -			.mask = ST_PRESS_LPS331AP_FS_MASK,
> +			.addr = 0x23,
> +			.mask = 0x30,
>  			.fs_avl = {
>  				/*
>  				 * Pressure and temperature sensitivity values
> @@ -360,24 +274,27 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_PRESS_LPS331AP_BDU_ADDR,
> -			.mask = ST_PRESS_LPS331AP_BDU_MASK,
> +			.addr = 0x20,
> +			.mask = 0x04,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_PRESS_LPS331AP_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_PRESS_LPS331AP_DRDY_IRQ_INT1_MASK,
> -			.mask_int2 = ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK,
> -			.addr_ihl = ST_PRESS_LPS331AP_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_PRESS_LPS331AP_IHL_IRQ_MASK,
> -			.addr_od = ST_PRESS_LPS331AP_OD_IRQ_ADDR,
> -			.mask_od = ST_PRESS_LPS331AP_OD_IRQ_MASK,
> +			.addr = 0x22,
> +			.mask_int1 = 0x04,
> +			.mask_int2 = 0x20,
> +			.addr_ihl = 0x22,
> +			.mask_ihl = 0x80,
> +			.addr_od = 0x22,
> +			.mask_od = 0x40,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_PRESS_LPS331AP_MULTIREAD_BIT,
> +		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_PRESS_LPS001WP_WAI_EXP,
> +		/*
> +		 * CUSTOM VALUES FOR LPS001WP SENSOR
> +		 */
> +		.wai = 0xba,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LPS001WP_PRESS_DEV_NAME,
> @@ -385,17 +302,17 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		.ch = (struct iio_chan_spec *)st_press_lps001wp_channels,
>  		.num_ch = ARRAY_SIZE(st_press_lps001wp_channels),
>  		.odr = {
> -			.addr = ST_PRESS_LPS001WP_ODR_ADDR,
> -			.mask = ST_PRESS_LPS001WP_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x30,
>  			.odr_avl = {
> -				{ 1, ST_PRESS_LPS001WP_ODR_AVL_1HZ_VAL, },
> -				{ 7, ST_PRESS_LPS001WP_ODR_AVL_7HZ_VAL, },
> -				{ 13, ST_PRESS_LPS001WP_ODR_AVL_13HZ_VAL, },
> +				{ .hz = 1, .value = 0x01 },
> +				{ .hz = 7, .value = 0x02 },
> +				{ .hz = 13, .value = 0x03 },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_PRESS_LPS001WP_PW_ADDR,
> -			.mask = ST_PRESS_LPS001WP_PW_MASK,
> +			.addr = 0x20,
> +			.mask = 0x40,
>  			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
> @@ -413,17 +330,22 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_PRESS_LPS001WP_BDU_ADDR,
> -			.mask = ST_PRESS_LPS001WP_BDU_MASK,
> +			.addr = 0x20,
> +			.mask = 0x04,
>  		},
>  		.drdy_irq = {
>  			.addr = 0,
>  		},
> -		.multi_read_bit = ST_PRESS_LPS001WP_MULTIREAD_BIT,
> +		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_PRESS_LPS25H_WAI_EXP,
> +		/*
> +		 * CUSTOM VALUES FOR LPS25H SENSOR
> +		 * See LPS25H datasheet:
> +		 * http://www2.st.com/resource/en/datasheet/lps25h.pdf
> +		 */
> +		.wai = 0xbd,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LPS25H_PRESS_DEV_NAME,
> @@ -431,18 +353,18 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		.ch = (struct iio_chan_spec *)st_press_1_channels,
>  		.num_ch = ARRAY_SIZE(st_press_1_channels),
>  		.odr = {
> -			.addr = ST_PRESS_LPS25H_ODR_ADDR,
> -			.mask = ST_PRESS_LPS25H_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x70,
>  			.odr_avl = {
> -				{ 1, ST_PRESS_LPS25H_ODR_AVL_1HZ_VAL, },
> -				{ 7, ST_PRESS_LPS25H_ODR_AVL_7HZ_VAL, },
> -				{ 13, ST_PRESS_LPS25H_ODR_AVL_13HZ_VAL, },
> -				{ 25, ST_PRESS_LPS25H_ODR_AVL_25HZ_VAL, },
> +				{ .hz = 1, .value = 0x01 },
> +				{ .hz = 7, .value = 0x02 },
> +				{ .hz = 13, .value = 0x03 },
> +				{ .hz = 25, .value = 0x04 },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_PRESS_LPS25H_PW_ADDR,
> -			.mask = ST_PRESS_LPS25H_PW_MASK,
> +			.addr = 0x20,
> +			.mask = 0x80,
>  			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
> @@ -460,24 +382,29 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_PRESS_LPS25H_BDU_ADDR,
> -			.mask = ST_PRESS_LPS25H_BDU_MASK,
> +			.addr = 0x20,
> +			.mask = 0x04,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_PRESS_LPS25H_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_PRESS_LPS25H_DRDY_IRQ_INT1_MASK,
> -			.mask_int2 = ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK,
> -			.addr_ihl = ST_PRESS_LPS25H_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_PRESS_LPS25H_IHL_IRQ_MASK,
> -			.addr_od = ST_PRESS_LPS25H_OD_IRQ_ADDR,
> -			.mask_od = ST_PRESS_LPS25H_OD_IRQ_MASK,
> +			.addr = 0x23,
> +			.mask_int1 = 0x01,
> +			.mask_int2 = 0x10,
> +			.addr_ihl = 0x22,
> +			.mask_ihl = 0x80,
> +			.addr_od = 0x22,
> +			.mask_od = 0x40,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_PRESS_LPS25H_MULTIREAD_BIT,
> +		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_PRESS_LPS22HB_WAI_EXP,
> +		/*
> +		 * CUSTOM VALUES FOR LPS22HB SENSOR
> +		 * See LPS22HB datasheet:
> +		 * http://www2.st.com/resource/en/datasheet/lps22hb.pdf
> +		 */
> +		.wai = 0xb1,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LPS22HB_PRESS_DEV_NAME,
> @@ -485,19 +412,19 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		.ch = (struct iio_chan_spec *)st_press_lps22hb_channels,
>  		.num_ch = ARRAY_SIZE(st_press_lps22hb_channels),
>  		.odr = {
> -			.addr = ST_PRESS_LPS22HB_ODR_ADDR,
> -			.mask = ST_PRESS_LPS22HB_ODR_MASK,
> +			.addr = 0x10,
> +			.mask = 0x70,
>  			.odr_avl = {
> -				{ 1, ST_PRESS_LPS22HB_ODR_AVL_1HZ_VAL, },
> -				{ 10, ST_PRESS_LPS22HB_ODR_AVL_10HZ_VAL, },
> -				{ 25, ST_PRESS_LPS22HB_ODR_AVL_25HZ_VAL, },
> -				{ 50, ST_PRESS_LPS22HB_ODR_AVL_50HZ_VAL, },
> -				{ 75, ST_PRESS_LPS22HB_ODR_AVL_75HZ_VAL, },
> +				{ .hz = 1, .value = 0x01 },
> +				{ .hz = 10, .value = 0x02 },
> +				{ .hz = 25, .value = 0x03 },
> +				{ .hz = 50, .value = 0x04 },
> +				{ .hz = 75, .value = 0x05 },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_PRESS_LPS22HB_PW_ADDR,
> -			.mask = ST_PRESS_LPS22HB_PW_MASK,
> +			.addr = 0x10,
> +			.mask = 0x70,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
>  		.fs = {
> @@ -514,20 +441,20 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_PRESS_LPS22HB_BDU_ADDR,
> -			.mask = ST_PRESS_LPS22HB_BDU_MASK,
> +			.addr = 0x10,
> +			.mask = 0x02,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_PRESS_LPS22HB_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_PRESS_LPS22HB_DRDY_IRQ_INT1_MASK,
> -			.mask_int2 = ST_PRESS_LPS22HB_DRDY_IRQ_INT2_MASK,
> -			.addr_ihl = ST_PRESS_LPS22HB_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_PRESS_LPS22HB_IHL_IRQ_MASK,
> -			.addr_od = ST_PRESS_LPS22HB_OD_IRQ_ADDR,
> -			.mask_od = ST_PRESS_LPS22HB_OD_IRQ_MASK,
> +			.addr = 0x12,
> +			.mask_int1 = 0x04,
> +			.mask_int2 = 0x08,
> +			.addr_ihl = 0x12,
> +			.mask_ihl = 0x80,
> +			.addr_od = 0x12,
> +			.mask_od = 0x40,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_PRESS_LPS22HB_MULTIREAD_BIT,
> +		.multi_read_bit = true,
>  	},
>  };
>  
> 

