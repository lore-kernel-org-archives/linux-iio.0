Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35604 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934319AbcKLPpw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 10:45:52 -0500
Subject: Re: [PATCH 3/4] iio: magn: st_magn: inline per-sensor data
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1478704200-19046-1-git-send-email-linus.walleij@linaro.org>
 <1478704200-19046-4-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <8aec42ff-ae73-72ca-62fe-d48f80a7e77c@kernel.org>
Date: Sat, 12 Nov 2016 15:45:44 +0000
MIME-Version: 1.0
In-Reply-To: <1478704200-19046-4-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/16 15:09, Linus Walleij wrote:
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
Looks good and applied.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/st_magn_core.c | 376 +++++++++++---------------------
>  1 file changed, 125 insertions(+), 251 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 3e1f06b2224c..8e1b0861fbe4 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -46,139 +46,12 @@
>  #define ST_MAGN_FS_AVL_15000MG			15000
>  #define ST_MAGN_FS_AVL_16000MG			16000
>  
> -/* CUSTOM VALUES FOR SENSOR 0 */
> -#define ST_MAGN_0_ODR_ADDR			0x00
> -#define ST_MAGN_0_ODR_MASK			0x1c
> -#define ST_MAGN_0_ODR_AVL_1HZ_VAL		0x00
> -#define ST_MAGN_0_ODR_AVL_2HZ_VAL		0x01
> -#define ST_MAGN_0_ODR_AVL_3HZ_VAL		0x02
> -#define ST_MAGN_0_ODR_AVL_8HZ_VAL		0x03
> -#define ST_MAGN_0_ODR_AVL_15HZ_VAL		0x04
> -#define ST_MAGN_0_ODR_AVL_30HZ_VAL		0x05
> -#define ST_MAGN_0_ODR_AVL_75HZ_VAL		0x06
> -#define ST_MAGN_0_ODR_AVL_220HZ_VAL		0x07
> -#define ST_MAGN_0_PW_ADDR			0x02
> -#define ST_MAGN_0_PW_MASK			0x03
> -#define ST_MAGN_0_PW_ON				0x00
> -#define ST_MAGN_0_PW_OFF			0x03
> -#define ST_MAGN_0_FS_ADDR			0x01
> -#define ST_MAGN_0_FS_MASK			0xe0
> -#define ST_MAGN_0_FS_AVL_1300_VAL		0x01
> -#define ST_MAGN_0_FS_AVL_1900_VAL		0x02
> -#define ST_MAGN_0_FS_AVL_2500_VAL		0x03
> -#define ST_MAGN_0_FS_AVL_4000_VAL		0x04
> -#define ST_MAGN_0_FS_AVL_4700_VAL		0x05
> -#define ST_MAGN_0_FS_AVL_5600_VAL		0x06
> -#define ST_MAGN_0_FS_AVL_8100_VAL		0x07
> -#define ST_MAGN_0_FS_AVL_1300_GAIN_XY		1100
> -#define ST_MAGN_0_FS_AVL_1900_GAIN_XY		855
> -#define ST_MAGN_0_FS_AVL_2500_GAIN_XY		670
> -#define ST_MAGN_0_FS_AVL_4000_GAIN_XY		450
> -#define ST_MAGN_0_FS_AVL_4700_GAIN_XY		400
> -#define ST_MAGN_0_FS_AVL_5600_GAIN_XY		330
> -#define ST_MAGN_0_FS_AVL_8100_GAIN_XY		230
> -#define ST_MAGN_0_FS_AVL_1300_GAIN_Z		980
> -#define ST_MAGN_0_FS_AVL_1900_GAIN_Z		760
> -#define ST_MAGN_0_FS_AVL_2500_GAIN_Z		600
> -#define ST_MAGN_0_FS_AVL_4000_GAIN_Z		400
> -#define ST_MAGN_0_FS_AVL_4700_GAIN_Z		355
> -#define ST_MAGN_0_FS_AVL_5600_GAIN_Z		295
> -#define ST_MAGN_0_FS_AVL_8100_GAIN_Z		205
> -#define ST_MAGN_0_MULTIREAD_BIT			false
> -
> -/* CUSTOM VALUES FOR SENSOR 1 */
> -#define ST_MAGN_1_WAI_EXP			0x3c
> -#define ST_MAGN_1_ODR_ADDR			0x00
> -#define ST_MAGN_1_ODR_MASK			0x1c
> -#define ST_MAGN_1_ODR_AVL_1HZ_VAL		0x00
> -#define ST_MAGN_1_ODR_AVL_2HZ_VAL		0x01
> -#define ST_MAGN_1_ODR_AVL_3HZ_VAL		0x02
> -#define ST_MAGN_1_ODR_AVL_8HZ_VAL		0x03
> -#define ST_MAGN_1_ODR_AVL_15HZ_VAL		0x04
> -#define ST_MAGN_1_ODR_AVL_30HZ_VAL		0x05
> -#define ST_MAGN_1_ODR_AVL_75HZ_VAL		0x06
> -#define ST_MAGN_1_ODR_AVL_220HZ_VAL		0x07
> -#define ST_MAGN_1_PW_ADDR			0x02
> -#define ST_MAGN_1_PW_MASK			0x03
> -#define ST_MAGN_1_PW_ON				0x00
> -#define ST_MAGN_1_PW_OFF			0x03
> -#define ST_MAGN_1_FS_ADDR			0x01
> -#define ST_MAGN_1_FS_MASK			0xe0
> -#define ST_MAGN_1_FS_AVL_1300_VAL		0x01
> -#define ST_MAGN_1_FS_AVL_1900_VAL		0x02
> -#define ST_MAGN_1_FS_AVL_2500_VAL		0x03
> -#define ST_MAGN_1_FS_AVL_4000_VAL		0x04
> -#define ST_MAGN_1_FS_AVL_4700_VAL		0x05
> -#define ST_MAGN_1_FS_AVL_5600_VAL		0x06
> -#define ST_MAGN_1_FS_AVL_8100_VAL		0x07
> -#define ST_MAGN_1_FS_AVL_1300_GAIN_XY		909
> -#define ST_MAGN_1_FS_AVL_1900_GAIN_XY		1169
> -#define ST_MAGN_1_FS_AVL_2500_GAIN_XY		1492
> -#define ST_MAGN_1_FS_AVL_4000_GAIN_XY		2222
> -#define ST_MAGN_1_FS_AVL_4700_GAIN_XY		2500
> -#define ST_MAGN_1_FS_AVL_5600_GAIN_XY		3030
> -#define ST_MAGN_1_FS_AVL_8100_GAIN_XY		4347
> -#define ST_MAGN_1_FS_AVL_1300_GAIN_Z		1020
> -#define ST_MAGN_1_FS_AVL_1900_GAIN_Z		1315
> -#define ST_MAGN_1_FS_AVL_2500_GAIN_Z		1666
> -#define ST_MAGN_1_FS_AVL_4000_GAIN_Z		2500
> -#define ST_MAGN_1_FS_AVL_4700_GAIN_Z		2816
> -#define ST_MAGN_1_FS_AVL_5600_GAIN_Z		3389
> -#define ST_MAGN_1_FS_AVL_8100_GAIN_Z		4878
> -#define ST_MAGN_1_MULTIREAD_BIT			false
> -
> -/* CUSTOM VALUES FOR SENSOR 2 */
> -#define ST_MAGN_2_WAI_EXP			0x3d
> -#define ST_MAGN_2_ODR_ADDR			0x20
> -#define ST_MAGN_2_ODR_MASK			0x1c
> -#define ST_MAGN_2_ODR_AVL_1HZ_VAL		0x00
> -#define ST_MAGN_2_ODR_AVL_2HZ_VAL		0x01
> -#define ST_MAGN_2_ODR_AVL_3HZ_VAL		0x02
> -#define ST_MAGN_2_ODR_AVL_5HZ_VAL		0x03
> -#define ST_MAGN_2_ODR_AVL_10HZ_VAL		0x04
> -#define ST_MAGN_2_ODR_AVL_20HZ_VAL		0x05
> -#define ST_MAGN_2_ODR_AVL_40HZ_VAL		0x06
> -#define ST_MAGN_2_ODR_AVL_80HZ_VAL		0x07
> -#define ST_MAGN_2_PW_ADDR			0x22
> -#define ST_MAGN_2_PW_MASK			0x03
> -#define ST_MAGN_2_PW_ON				0x00
> -#define ST_MAGN_2_PW_OFF			0x03
> -#define ST_MAGN_2_FS_ADDR			0x21
> -#define ST_MAGN_2_FS_MASK			0x60
> -#define ST_MAGN_2_FS_AVL_4000_VAL		0x00
> -#define ST_MAGN_2_FS_AVL_8000_VAL		0x01
> -#define ST_MAGN_2_FS_AVL_12000_VAL		0x02
> -#define ST_MAGN_2_FS_AVL_16000_VAL		0x03
> -#define ST_MAGN_2_FS_AVL_4000_GAIN		146
> -#define ST_MAGN_2_FS_AVL_8000_GAIN		292
> -#define ST_MAGN_2_FS_AVL_12000_GAIN		438
> -#define ST_MAGN_2_FS_AVL_16000_GAIN		584
> -#define ST_MAGN_2_MULTIREAD_BIT			false
> +/* Special L addresses for Sensor 2 */
>  #define ST_MAGN_2_OUT_X_L_ADDR			0x28
>  #define ST_MAGN_2_OUT_Y_L_ADDR			0x2a
>  #define ST_MAGN_2_OUT_Z_L_ADDR			0x2c
>  
> -/* CUSTOM VALUES FOR SENSOR 3 */
> -#define ST_MAGN_3_WAI_ADDR			0x4f
> -#define ST_MAGN_3_WAI_EXP			0x40
> -#define ST_MAGN_3_ODR_ADDR			0x60
> -#define ST_MAGN_3_ODR_MASK			0x0c
> -#define ST_MAGN_3_ODR_AVL_10HZ_VAL		0x00
> -#define ST_MAGN_3_ODR_AVL_20HZ_VAL		0x01
> -#define ST_MAGN_3_ODR_AVL_50HZ_VAL		0x02
> -#define ST_MAGN_3_ODR_AVL_100HZ_VAL		0x03
> -#define ST_MAGN_3_PW_ADDR			0x60
> -#define ST_MAGN_3_PW_MASK			0x03
> -#define ST_MAGN_3_PW_ON				0x00
> -#define ST_MAGN_3_PW_OFF			0x03
> -#define ST_MAGN_3_BDU_ADDR			0x62
> -#define ST_MAGN_3_BDU_MASK			0x10
> -#define ST_MAGN_3_DRDY_IRQ_ADDR			0x62
> -#define ST_MAGN_3_DRDY_INT_MASK			0x01
> -#define ST_MAGN_3_IHL_IRQ_ADDR			0x63
> -#define ST_MAGN_3_IHL_IRQ_MASK			0x04
> -#define ST_MAGN_3_FS_AVL_15000_GAIN		1500
> -#define ST_MAGN_3_MULTIREAD_BIT			false
> +/* Special L addresses for sensor 3 */
>  #define ST_MAGN_3_OUT_X_L_ADDR			0x68
>  #define ST_MAGN_3_OUT_Y_L_ADDR			0x6a
>  #define ST_MAGN_3_OUT_Z_L_ADDR			0x6c
> @@ -240,77 +113,78 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  		},
>  		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
>  		.odr = {
> -			.addr = ST_MAGN_0_ODR_ADDR,
> -			.mask = ST_MAGN_0_ODR_MASK,
> +			.addr = 0x00,
> +			.mask = 0x1c,
>  			.odr_avl = {
> -				{ 1, ST_MAGN_0_ODR_AVL_1HZ_VAL, },
> -				{ 2, ST_MAGN_0_ODR_AVL_2HZ_VAL, },
> -				{ 3, ST_MAGN_0_ODR_AVL_3HZ_VAL, },
> -				{ 8, ST_MAGN_0_ODR_AVL_8HZ_VAL, },
> -				{ 15, ST_MAGN_0_ODR_AVL_15HZ_VAL, },
> -				{ 30, ST_MAGN_0_ODR_AVL_30HZ_VAL, },
> -				{ 75, ST_MAGN_0_ODR_AVL_75HZ_VAL, },
> +				{ .hz = 1, .value = 0x00 },
> +				{ .hz = 2, .value = 0x01 },
> +				{ .hz = 3, .value = 0x02 },
> +				{ .hz = 8, .value = 0x03 },
> +				{ .hz = 15, .value = 0x04 },
> +				{ .hz = 30, .value = 0x05 },
> +				{ .hz = 75, .value = 0x06 },
> +				/* 220 Hz, 0x07 reportedly exist */
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_MAGN_0_PW_ADDR,
> -			.mask = ST_MAGN_0_PW_MASK,
> -			.value_on = ST_MAGN_0_PW_ON,
> -			.value_off = ST_MAGN_0_PW_OFF,
> +			.addr = 0x02,
> +			.mask = 0x03,
> +			.value_on = 0x00,
> +			.value_off = 0x03,
>  		},
>  		.fs = {
> -			.addr = ST_MAGN_0_FS_ADDR,
> -			.mask = ST_MAGN_0_FS_MASK,
> +			.addr = 0x01,
> +			.mask = 0xe0,
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_MAGN_FS_AVL_1300MG,
> -					.value = ST_MAGN_0_FS_AVL_1300_VAL,
> -					.gain = ST_MAGN_0_FS_AVL_1300_GAIN_XY,
> -					.gain2 = ST_MAGN_0_FS_AVL_1300_GAIN_Z,
> +					.value = 0x01,
> +					.gain = 1100,
> +					.gain2 = 980,
>  				},
>  				[1] = {
>  					.num = ST_MAGN_FS_AVL_1900MG,
> -					.value = ST_MAGN_0_FS_AVL_1900_VAL,
> -					.gain = ST_MAGN_0_FS_AVL_1900_GAIN_XY,
> -					.gain2 = ST_MAGN_0_FS_AVL_1900_GAIN_Z,
> +					.value = 0x02,
> +					.gain = 855,
> +					.gain2 = 760,
>  				},
>  				[2] = {
>  					.num = ST_MAGN_FS_AVL_2500MG,
> -					.value = ST_MAGN_0_FS_AVL_2500_VAL,
> -					.gain = ST_MAGN_0_FS_AVL_2500_GAIN_XY,
> -					.gain2 = ST_MAGN_0_FS_AVL_2500_GAIN_Z,
> +					.value = 0x03,
> +					.gain = 670,
> +					.gain2 = 600,
>  				},
>  				[3] = {
>  					.num = ST_MAGN_FS_AVL_4000MG,
> -					.value = ST_MAGN_0_FS_AVL_4000_VAL,
> -					.gain = ST_MAGN_0_FS_AVL_4000_GAIN_XY,
> -					.gain2 = ST_MAGN_0_FS_AVL_4000_GAIN_Z,
> +					.value = 0x04,
> +					.gain = 450,
> +					.gain2 = 400,
>  				},
>  				[4] = {
>  					.num = ST_MAGN_FS_AVL_4700MG,
> -					.value = ST_MAGN_0_FS_AVL_4700_VAL,
> -					.gain = ST_MAGN_0_FS_AVL_4700_GAIN_XY,
> -					.gain2 = ST_MAGN_0_FS_AVL_4700_GAIN_Z,
> +					.value = 0x05,
> +					.gain = 400,
> +					.gain2 = 355,
>  				},
>  				[5] = {
>  					.num = ST_MAGN_FS_AVL_5600MG,
> -					.value = ST_MAGN_0_FS_AVL_5600_VAL,
> -					.gain = ST_MAGN_0_FS_AVL_5600_GAIN_XY,
> -					.gain2 = ST_MAGN_0_FS_AVL_5600_GAIN_Z,
> +					.value = 0x06,
> +					.gain = 330,
> +					.gain2 = 295,
>  				},
>  				[6] = {
>  					.num = ST_MAGN_FS_AVL_8100MG,
> -					.value = ST_MAGN_0_FS_AVL_8100_VAL,
> -					.gain = ST_MAGN_0_FS_AVL_8100_GAIN_XY,
> -					.gain2 = ST_MAGN_0_FS_AVL_8100_GAIN_Z,
> +					.value = 0x07,
> +					.gain = 230,
> +					.gain2 = 205,
>  				},
>  			},
>  		},
> -		.multi_read_bit = ST_MAGN_0_MULTIREAD_BIT,
> +		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_MAGN_1_WAI_EXP,
> +		.wai = 0x3c,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LSM303DLHC_MAGN_DEV_NAME,
> @@ -318,175 +192,175 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  		},
>  		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
>  		.odr = {
> -			.addr = ST_MAGN_1_ODR_ADDR,
> -			.mask = ST_MAGN_1_ODR_MASK,
> +			.addr = 0x00,
> +			.mask = 0x1c,
>  			.odr_avl = {
> -				{ 1, ST_MAGN_1_ODR_AVL_1HZ_VAL, },
> -				{ 2, ST_MAGN_1_ODR_AVL_2HZ_VAL, },
> -				{ 3, ST_MAGN_1_ODR_AVL_3HZ_VAL, },
> -				{ 8, ST_MAGN_1_ODR_AVL_8HZ_VAL, },
> -				{ 15, ST_MAGN_1_ODR_AVL_15HZ_VAL, },
> -				{ 30, ST_MAGN_1_ODR_AVL_30HZ_VAL, },
> -				{ 75, ST_MAGN_1_ODR_AVL_75HZ_VAL, },
> -				{ 220, ST_MAGN_1_ODR_AVL_220HZ_VAL, },
> +				{ .hz = 1, .value = 0x00 },
> +				{ .hz = 2, .value = 0x01 },
> +				{ .hz = 3, .value = 0x02 },
> +				{ .hz = 8, .value = 0x03 },
> +				{ .hz = 15, .value = 0x04 },
> +				{ .hz = 30, .value = 0x05 },
> +				{ .hz = 75, .value = 0x06 },
> +				{ .hz = 220, .value = 0x07 },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_MAGN_1_PW_ADDR,
> -			.mask = ST_MAGN_1_PW_MASK,
> -			.value_on = ST_MAGN_1_PW_ON,
> -			.value_off = ST_MAGN_1_PW_OFF,
> +			.addr = 0x02,
> +			.mask = 0x03,
> +			.value_on = 0x00,
> +			.value_off = 0x03,
>  		},
>  		.fs = {
> -			.addr = ST_MAGN_1_FS_ADDR,
> -			.mask = ST_MAGN_1_FS_MASK,
> +			.addr = 0x01,
> +			.mask = 0xe0,
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_MAGN_FS_AVL_1300MG,
> -					.value = ST_MAGN_1_FS_AVL_1300_VAL,
> -					.gain = ST_MAGN_1_FS_AVL_1300_GAIN_XY,
> -					.gain2 = ST_MAGN_1_FS_AVL_1300_GAIN_Z,
> +					.value = 0x01,
> +					.gain = 909,
> +					.gain2 = 1020,
>  				},
>  				[1] = {
>  					.num = ST_MAGN_FS_AVL_1900MG,
> -					.value = ST_MAGN_1_FS_AVL_1900_VAL,
> -					.gain = ST_MAGN_1_FS_AVL_1900_GAIN_XY,
> -					.gain2 = ST_MAGN_1_FS_AVL_1900_GAIN_Z,
> +					.value = 0x02,
> +					.gain = 1169,
> +					.gain2 = 1315,
>  				},
>  				[2] = {
>  					.num = ST_MAGN_FS_AVL_2500MG,
> -					.value = ST_MAGN_1_FS_AVL_2500_VAL,
> -					.gain = ST_MAGN_1_FS_AVL_2500_GAIN_XY,
> -					.gain2 = ST_MAGN_1_FS_AVL_2500_GAIN_Z,
> +					.value = 0x03,
> +					.gain = 1492,
> +					.gain2 = 1666,
>  				},
>  				[3] = {
>  					.num = ST_MAGN_FS_AVL_4000MG,
> -					.value = ST_MAGN_1_FS_AVL_4000_VAL,
> -					.gain = ST_MAGN_1_FS_AVL_4000_GAIN_XY,
> -					.gain2 = ST_MAGN_1_FS_AVL_4000_GAIN_Z,
> +					.value = 0x04,
> +					.gain = 2222,
> +					.gain2 = 2500,
>  				},
>  				[4] = {
>  					.num = ST_MAGN_FS_AVL_4700MG,
> -					.value = ST_MAGN_1_FS_AVL_4700_VAL,
> -					.gain = ST_MAGN_1_FS_AVL_4700_GAIN_XY,
> -					.gain2 = ST_MAGN_1_FS_AVL_4700_GAIN_Z,
> +					.value = 0x05,
> +					.gain = 2500,
> +					.gain2 = 2816,
>  				},
>  				[5] = {
>  					.num = ST_MAGN_FS_AVL_5600MG,
> -					.value = ST_MAGN_1_FS_AVL_5600_VAL,
> -					.gain = ST_MAGN_1_FS_AVL_5600_GAIN_XY,
> -					.gain2 = ST_MAGN_1_FS_AVL_5600_GAIN_Z,
> +					.value = 0x06,
> +					.gain = 3030,
> +					.gain2 = 3389,
>  				},
>  				[6] = {
>  					.num = ST_MAGN_FS_AVL_8100MG,
> -					.value = ST_MAGN_1_FS_AVL_8100_VAL,
> -					.gain = ST_MAGN_1_FS_AVL_8100_GAIN_XY,
> -					.gain2 = ST_MAGN_1_FS_AVL_8100_GAIN_Z,
> +					.value = 0x07,
> +					.gain = 4347,
> +					.gain2 = 4878,
>  				},
>  			},
>  		},
> -		.multi_read_bit = ST_MAGN_1_MULTIREAD_BIT,
> +		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_MAGN_2_WAI_EXP,
> +		.wai = 0x3d,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LIS3MDL_MAGN_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_magn_2_16bit_channels,
>  		.odr = {
> -			.addr = ST_MAGN_2_ODR_ADDR,
> -			.mask = ST_MAGN_2_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x1c,
>  			.odr_avl = {
> -				{ 1, ST_MAGN_2_ODR_AVL_1HZ_VAL, },
> -				{ 2, ST_MAGN_2_ODR_AVL_2HZ_VAL, },
> -				{ 3, ST_MAGN_2_ODR_AVL_3HZ_VAL, },
> -				{ 5, ST_MAGN_2_ODR_AVL_5HZ_VAL, },
> -				{ 10, ST_MAGN_2_ODR_AVL_10HZ_VAL, },
> -				{ 20, ST_MAGN_2_ODR_AVL_20HZ_VAL, },
> -				{ 40, ST_MAGN_2_ODR_AVL_40HZ_VAL, },
> -				{ 80, ST_MAGN_2_ODR_AVL_80HZ_VAL, },
> +				{ .hz = 1, .value = 0x00 },
> +				{ .hz = 2, .value = 0x01 },
> +				{ .hz = 3, .value = 0x02 },
> +				{ .hz = 5, .value = 0x03 },
> +				{ .hz = 10, .value = 0x04 },
> +				{ .hz = 20, .value = 0x05 },
> +				{ .hz = 40, .value = 0x06 },
> +				{ .hz = 80, .value = 0x07 },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_MAGN_2_PW_ADDR,
> -			.mask = ST_MAGN_2_PW_MASK,
> -			.value_on = ST_MAGN_2_PW_ON,
> -			.value_off = ST_MAGN_2_PW_OFF,
> +			.addr = 0x22,
> +			.mask = 0x03,
> +			.value_on = 0x00,
> +			.value_off = 0x03,
>  		},
>  		.fs = {
> -			.addr = ST_MAGN_2_FS_ADDR,
> -			.mask = ST_MAGN_2_FS_MASK,
> +			.addr = 0x21,
> +			.mask = 0x60,
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_MAGN_FS_AVL_4000MG,
> -					.value = ST_MAGN_2_FS_AVL_4000_VAL,
> -					.gain = ST_MAGN_2_FS_AVL_4000_GAIN,
> +					.value = 0x00,
> +					.gain = 146,
>  				},
>  				[1] = {
>  					.num = ST_MAGN_FS_AVL_8000MG,
> -					.value = ST_MAGN_2_FS_AVL_8000_VAL,
> -					.gain = ST_MAGN_2_FS_AVL_8000_GAIN,
> +					.value = 0x01,
> +					.gain = 292,
>  				},
>  				[2] = {
>  					.num = ST_MAGN_FS_AVL_12000MG,
> -					.value = ST_MAGN_2_FS_AVL_12000_VAL,
> -					.gain = ST_MAGN_2_FS_AVL_12000_GAIN,
> +					.value = 0x02,
> +					.gain = 438,
>  				},
>  				[3] = {
>  					.num = ST_MAGN_FS_AVL_16000MG,
> -					.value = ST_MAGN_2_FS_AVL_16000_VAL,
> -					.gain = ST_MAGN_2_FS_AVL_16000_GAIN,
> +					.value = 0x03,
> +					.gain = 584,
>  				},
>  			},
>  		},
> -		.multi_read_bit = ST_MAGN_2_MULTIREAD_BIT,
> +		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_MAGN_3_WAI_EXP,
> -		.wai_addr = ST_MAGN_3_WAI_ADDR,
> +		.wai = 0x40,
> +		.wai_addr = 0x4f,
>  		.sensors_supported = {
>  			[0] = LSM303AGR_MAGN_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_magn_3_16bit_channels,
>  		.odr = {
> -			.addr = ST_MAGN_3_ODR_ADDR,
> -			.mask = ST_MAGN_3_ODR_MASK,
> +			.addr = 0x60,
> +			.mask = 0x0c,
>  			.odr_avl = {
> -				{ 10, ST_MAGN_3_ODR_AVL_10HZ_VAL, },
> -				{ 20, ST_MAGN_3_ODR_AVL_20HZ_VAL, },
> -				{ 50, ST_MAGN_3_ODR_AVL_50HZ_VAL, },
> -				{ 100, ST_MAGN_3_ODR_AVL_100HZ_VAL, },
> +				{ .hz = 10, .value = 0x00 },
> +				{ .hz = 20, .value = 0x01 },
> +				{ .hz = 50, .value = 0x02 },
> +				{ .hz = 100, .value = 0x03 },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_MAGN_3_PW_ADDR,
> -			.mask = ST_MAGN_3_PW_MASK,
> -			.value_on = ST_MAGN_3_PW_ON,
> -			.value_off = ST_MAGN_3_PW_OFF,
> +			.addr = 0x60,
> +			.mask = 0x03,
> +			.value_on = 0x00,
> +			.value_off = 0x03,
>  		},
>  		.fs = {
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_MAGN_FS_AVL_15000MG,
> -					.gain = ST_MAGN_3_FS_AVL_15000_GAIN,
> +					.gain = 1500,
>  				},
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_MAGN_3_BDU_ADDR,
> -			.mask = ST_MAGN_3_BDU_MASK,
> +			.addr = 0x62,
> +			.mask = 0x10,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_MAGN_3_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_MAGN_3_DRDY_INT_MASK,
> -			.addr_ihl = ST_MAGN_3_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_MAGN_3_IHL_IRQ_MASK,
> +			.addr = 0x62,
> +			.mask_int1 = 0x01,
> +			.addr_ihl = 0x63,
> +			.mask_ihl = 0x04,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_MAGN_3_MULTIREAD_BIT,
> +		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
>  };
> 

