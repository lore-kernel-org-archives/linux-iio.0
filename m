Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35526 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933360AbcKLP34 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 10:29:56 -0500
Subject: Re: [PATCH 1/4] iio: accel: st_accel: inline per-sensor data
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1478704200-19046-1-git-send-email-linus.walleij@linaro.org>
 <1478704200-19046-2-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ccbc6b6d-c5a7-7fe0-b82d-a27780e6836e@kernel.org>
Date: Sat, 12 Nov 2016 15:29:48 +0000
MIME-Version: 1.0
In-Reply-To: <1478704200-19046-2-git-send-email-linus.walleij@linaro.org>
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
Interesting that sensor type 5 has IG1 address / mask defined (previously) but
not used... hohum. I have no idea what those even are ;)

My only conselation in having just checked this is it must have
been even more boring to write as a patch!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/st_accel_core.c | 538 +++++++++++++-------------------------
>  1 file changed, 177 insertions(+), 361 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index da3fb069ec5c..d21b2dbe7432 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -43,194 +43,6 @@
>  #define ST_ACCEL_FS_AVL_200G			200
>  #define ST_ACCEL_FS_AVL_400G			400
>  
> -/* CUSTOM VALUES FOR SENSOR 1 */
> -#define ST_ACCEL_1_WAI_EXP			0x33
> -#define ST_ACCEL_1_ODR_ADDR			0x20
> -#define ST_ACCEL_1_ODR_MASK			0xf0
> -#define ST_ACCEL_1_ODR_AVL_1HZ_VAL		0x01
> -#define ST_ACCEL_1_ODR_AVL_10HZ_VAL		0x02
> -#define ST_ACCEL_1_ODR_AVL_25HZ_VAL		0x03
> -#define ST_ACCEL_1_ODR_AVL_50HZ_VAL		0x04
> -#define ST_ACCEL_1_ODR_AVL_100HZ_VAL		0x05
> -#define ST_ACCEL_1_ODR_AVL_200HZ_VAL		0x06
> -#define ST_ACCEL_1_ODR_AVL_400HZ_VAL		0x07
> -#define ST_ACCEL_1_ODR_AVL_1600HZ_VAL		0x08
> -#define ST_ACCEL_1_FS_ADDR			0x23
> -#define ST_ACCEL_1_FS_MASK			0x30
> -#define ST_ACCEL_1_FS_AVL_2_VAL			0x00
> -#define ST_ACCEL_1_FS_AVL_4_VAL			0x01
> -#define ST_ACCEL_1_FS_AVL_8_VAL			0x02
> -#define ST_ACCEL_1_FS_AVL_16_VAL		0x03
> -#define ST_ACCEL_1_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(1000)
> -#define ST_ACCEL_1_FS_AVL_4_GAIN		IIO_G_TO_M_S_2(2000)
> -#define ST_ACCEL_1_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(4000)
> -#define ST_ACCEL_1_FS_AVL_16_GAIN		IIO_G_TO_M_S_2(12000)
> -#define ST_ACCEL_1_BDU_ADDR			0x23
> -#define ST_ACCEL_1_BDU_MASK			0x80
> -#define ST_ACCEL_1_DRDY_IRQ_ADDR		0x22
> -#define ST_ACCEL_1_DRDY_IRQ_INT1_MASK		0x10
> -#define ST_ACCEL_1_DRDY_IRQ_INT2_MASK		0x08
> -#define ST_ACCEL_1_IHL_IRQ_ADDR			0x25
> -#define ST_ACCEL_1_IHL_IRQ_MASK			0x02
> -#define ST_ACCEL_1_MULTIREAD_BIT		true
> -
> -/* CUSTOM VALUES FOR SENSOR 2 */
> -#define ST_ACCEL_2_WAI_EXP			0x32
> -#define ST_ACCEL_2_ODR_ADDR			0x20
> -#define ST_ACCEL_2_ODR_MASK			0x18
> -#define ST_ACCEL_2_ODR_AVL_50HZ_VAL		0x00
> -#define ST_ACCEL_2_ODR_AVL_100HZ_VAL		0x01
> -#define ST_ACCEL_2_ODR_AVL_400HZ_VAL		0x02
> -#define ST_ACCEL_2_ODR_AVL_1000HZ_VAL		0x03
> -#define ST_ACCEL_2_PW_ADDR			0x20
> -#define ST_ACCEL_2_PW_MASK			0xe0
> -#define ST_ACCEL_2_FS_ADDR			0x23
> -#define ST_ACCEL_2_FS_MASK			0x30
> -#define ST_ACCEL_2_FS_AVL_2_VAL			0X00
> -#define ST_ACCEL_2_FS_AVL_4_VAL			0X01
> -#define ST_ACCEL_2_FS_AVL_8_VAL			0x03
> -#define ST_ACCEL_2_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(1000)
> -#define ST_ACCEL_2_FS_AVL_4_GAIN		IIO_G_TO_M_S_2(2000)
> -#define ST_ACCEL_2_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(3900)
> -#define ST_ACCEL_2_BDU_ADDR			0x23
> -#define ST_ACCEL_2_BDU_MASK			0x80
> -#define ST_ACCEL_2_DRDY_IRQ_ADDR		0x22
> -#define ST_ACCEL_2_DRDY_IRQ_INT1_MASK		0x02
> -#define ST_ACCEL_2_DRDY_IRQ_INT2_MASK		0x10
> -#define ST_ACCEL_2_IHL_IRQ_ADDR			0x22
> -#define ST_ACCEL_2_IHL_IRQ_MASK			0x80
> -#define ST_ACCEL_2_OD_IRQ_ADDR			0x22
> -#define ST_ACCEL_2_OD_IRQ_MASK			0x40
> -#define ST_ACCEL_2_MULTIREAD_BIT		true
> -
> -/* CUSTOM VALUES FOR SENSOR 3 */
> -#define ST_ACCEL_3_WAI_EXP			0x40
> -#define ST_ACCEL_3_ODR_ADDR			0x20
> -#define ST_ACCEL_3_ODR_MASK			0xf0
> -#define ST_ACCEL_3_ODR_AVL_3HZ_VAL		0x01
> -#define ST_ACCEL_3_ODR_AVL_6HZ_VAL		0x02
> -#define ST_ACCEL_3_ODR_AVL_12HZ_VAL		0x03
> -#define ST_ACCEL_3_ODR_AVL_25HZ_VAL		0x04
> -#define ST_ACCEL_3_ODR_AVL_50HZ_VAL		0x05
> -#define ST_ACCEL_3_ODR_AVL_100HZ_VAL		0x06
> -#define ST_ACCEL_3_ODR_AVL_200HZ_VAL		0x07
> -#define ST_ACCEL_3_ODR_AVL_400HZ_VAL		0x08
> -#define ST_ACCEL_3_ODR_AVL_800HZ_VAL		0x09
> -#define ST_ACCEL_3_ODR_AVL_1600HZ_VAL		0x0a
> -#define ST_ACCEL_3_FS_ADDR			0x24
> -#define ST_ACCEL_3_FS_MASK			0x38
> -#define ST_ACCEL_3_FS_AVL_2_VAL			0X00
> -#define ST_ACCEL_3_FS_AVL_4_VAL			0X01
> -#define ST_ACCEL_3_FS_AVL_6_VAL			0x02
> -#define ST_ACCEL_3_FS_AVL_8_VAL			0x03
> -#define ST_ACCEL_3_FS_AVL_16_VAL		0x04
> -#define ST_ACCEL_3_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(61)
> -#define ST_ACCEL_3_FS_AVL_4_GAIN		IIO_G_TO_M_S_2(122)
> -#define ST_ACCEL_3_FS_AVL_6_GAIN		IIO_G_TO_M_S_2(183)
> -#define ST_ACCEL_3_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(244)
> -#define ST_ACCEL_3_FS_AVL_16_GAIN		IIO_G_TO_M_S_2(732)
> -#define ST_ACCEL_3_BDU_ADDR			0x20
> -#define ST_ACCEL_3_BDU_MASK			0x08
> -#define ST_ACCEL_3_DRDY_IRQ_ADDR		0x23
> -#define ST_ACCEL_3_DRDY_IRQ_INT1_MASK		0x80
> -#define ST_ACCEL_3_DRDY_IRQ_INT2_MASK		0x00
> -#define ST_ACCEL_3_IHL_IRQ_ADDR			0x23
> -#define ST_ACCEL_3_IHL_IRQ_MASK			0x40
> -#define ST_ACCEL_3_IG1_EN_ADDR			0x23
> -#define ST_ACCEL_3_IG1_EN_MASK			0x08
> -#define ST_ACCEL_3_MULTIREAD_BIT		false
> -
> -/* CUSTOM VALUES FOR SENSOR 4 */
> -#define ST_ACCEL_4_WAI_EXP			0x3a
> -#define ST_ACCEL_4_ODR_ADDR			0x20
> -#define ST_ACCEL_4_ODR_MASK			0x30 /* DF1 and DF0 */
> -#define ST_ACCEL_4_ODR_AVL_40HZ_VAL		0x00
> -#define ST_ACCEL_4_ODR_AVL_160HZ_VAL		0x01
> -#define ST_ACCEL_4_ODR_AVL_640HZ_VAL		0x02
> -#define ST_ACCEL_4_ODR_AVL_2560HZ_VAL		0x03
> -#define ST_ACCEL_4_PW_ADDR			0x20
> -#define ST_ACCEL_4_PW_MASK			0xc0
> -#define ST_ACCEL_4_FS_ADDR			0x21
> -#define ST_ACCEL_4_FS_MASK			0x80
> -#define ST_ACCEL_4_FS_AVL_2_VAL			0X00
> -#define ST_ACCEL_4_FS_AVL_6_VAL			0X01
> -#define ST_ACCEL_4_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(1024)
> -#define ST_ACCEL_4_FS_AVL_6_GAIN		IIO_G_TO_M_S_2(340)
> -#define ST_ACCEL_4_BDU_ADDR			0x21
> -#define ST_ACCEL_4_BDU_MASK			0x40
> -#define ST_ACCEL_4_DRDY_IRQ_ADDR		0x21
> -#define ST_ACCEL_4_DRDY_IRQ_INT1_MASK		0x04
> -#define ST_ACCEL_4_MULTIREAD_BIT		true
> -
> -/* CUSTOM VALUES FOR SENSOR 5 */
> -#define ST_ACCEL_5_WAI_EXP			0x3b
> -#define ST_ACCEL_5_ODR_ADDR			0x20
> -#define ST_ACCEL_5_ODR_MASK			0x80
> -#define ST_ACCEL_5_ODR_AVL_100HZ_VAL		0x00
> -#define ST_ACCEL_5_ODR_AVL_400HZ_VAL		0x01
> -#define ST_ACCEL_5_PW_ADDR			0x20
> -#define ST_ACCEL_5_PW_MASK			0x40
> -#define ST_ACCEL_5_FS_ADDR			0x20
> -#define ST_ACCEL_5_FS_MASK			0x20
> -#define ST_ACCEL_5_FS_AVL_2_VAL			0X00
> -#define ST_ACCEL_5_FS_AVL_8_VAL			0X01
> -/* TODO: check these resulting gain settings, these are not in the datsheet */
> -#define ST_ACCEL_5_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(18000)
> -#define ST_ACCEL_5_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(72000)
> -#define ST_ACCEL_5_DRDY_IRQ_ADDR		0x22
> -#define ST_ACCEL_5_DRDY_IRQ_INT1_MASK		0x04
> -#define ST_ACCEL_5_DRDY_IRQ_INT2_MASK		0x20
> -#define ST_ACCEL_5_IHL_IRQ_ADDR			0x22
> -#define ST_ACCEL_5_IHL_IRQ_MASK			0x80
> -#define ST_ACCEL_5_OD_IRQ_ADDR			0x22
> -#define ST_ACCEL_5_OD_IRQ_MASK			0x40
> -#define ST_ACCEL_5_IG1_EN_ADDR			0x21
> -#define ST_ACCEL_5_IG1_EN_MASK			0x08
> -#define ST_ACCEL_5_MULTIREAD_BIT		false
> -
> -/* CUSTOM VALUES FOR SENSOR 6 */
> -#define ST_ACCEL_6_WAI_EXP			0x32
> -#define ST_ACCEL_6_ODR_ADDR			0x20
> -#define ST_ACCEL_6_ODR_MASK			0x18
> -#define ST_ACCEL_6_ODR_AVL_50HZ_VAL		0x00
> -#define ST_ACCEL_6_ODR_AVL_100HZ_VAL		0x01
> -#define ST_ACCEL_6_ODR_AVL_400HZ_VAL		0x02
> -#define ST_ACCEL_6_ODR_AVL_1000HZ_VAL		0x03
> -#define ST_ACCEL_6_PW_ADDR			0x20
> -#define ST_ACCEL_6_PW_MASK			0x20
> -#define ST_ACCEL_6_FS_ADDR			0x23
> -#define ST_ACCEL_6_FS_MASK			0x30
> -#define ST_ACCEL_6_FS_AVL_100_VAL		0x00
> -#define ST_ACCEL_6_FS_AVL_200_VAL		0x01
> -#define ST_ACCEL_6_FS_AVL_400_VAL		0x03
> -#define ST_ACCEL_6_FS_AVL_100_GAIN		IIO_G_TO_M_S_2(49000)
> -#define ST_ACCEL_6_FS_AVL_200_GAIN		IIO_G_TO_M_S_2(98000)
> -#define ST_ACCEL_6_FS_AVL_400_GAIN		IIO_G_TO_M_S_2(195000)
> -#define ST_ACCEL_6_BDU_ADDR			0x23
> -#define ST_ACCEL_6_BDU_MASK			0x80
> -#define ST_ACCEL_6_DRDY_IRQ_ADDR		0x22
> -#define ST_ACCEL_6_DRDY_IRQ_INT1_MASK		0x02
> -#define ST_ACCEL_6_DRDY_IRQ_INT2_MASK		0x10
> -#define ST_ACCEL_6_IHL_IRQ_ADDR			0x22
> -#define ST_ACCEL_6_IHL_IRQ_MASK			0x80
> -#define ST_ACCEL_6_MULTIREAD_BIT		true
> -
> -/* CUSTOM VALUES FOR SENSOR 7 */
> -#define ST_ACCEL_7_ODR_ADDR			0x20
> -#define ST_ACCEL_7_ODR_MASK			0x30
> -#define ST_ACCEL_7_ODR_AVL_280HZ_VAL		0x00
> -#define ST_ACCEL_7_ODR_AVL_560HZ_VAL		0x01
> -#define ST_ACCEL_7_ODR_AVL_1120HZ_VAL		0x02
> -#define ST_ACCEL_7_ODR_AVL_4480HZ_VAL		0x03
> -#define ST_ACCEL_7_PW_ADDR			0x20
> -#define ST_ACCEL_7_PW_MASK			0xc0
> -#define ST_ACCEL_7_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(488)
> -#define ST_ACCEL_7_BDU_ADDR			0x21
> -#define ST_ACCEL_7_BDU_MASK			0x40
> -#define ST_ACCEL_7_DRDY_IRQ_ADDR		0x21
> -#define ST_ACCEL_7_DRDY_IRQ_INT1_MASK		0x04
> -#define ST_ACCEL_7_MULTIREAD_BIT		false
> -
>  static const struct iio_chan_spec st_accel_8bit_channels[] = {
>  	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> @@ -281,7 +93,7 @@ static const struct iio_chan_spec st_accel_16bit_channels[] = {
>  
>  static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  	{
> -		.wai = ST_ACCEL_1_WAI_EXP,
> +		.wai = 0x33,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LIS3DH_ACCEL_DEV_NAME,
> @@ -294,22 +106,22 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>  		.odr = {
> -			.addr = ST_ACCEL_1_ODR_ADDR,
> -			.mask = ST_ACCEL_1_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0xf0,
>  			.odr_avl = {
> -				{ 1, ST_ACCEL_1_ODR_AVL_1HZ_VAL, },
> -				{ 10, ST_ACCEL_1_ODR_AVL_10HZ_VAL, },
> -				{ 25, ST_ACCEL_1_ODR_AVL_25HZ_VAL, },
> -				{ 50, ST_ACCEL_1_ODR_AVL_50HZ_VAL, },
> -				{ 100, ST_ACCEL_1_ODR_AVL_100HZ_VAL, },
> -				{ 200, ST_ACCEL_1_ODR_AVL_200HZ_VAL, },
> -				{ 400, ST_ACCEL_1_ODR_AVL_400HZ_VAL, },
> -				{ 1600, ST_ACCEL_1_ODR_AVL_1600HZ_VAL, },
> +				{ .hz = 1, .value = 0x01, },
> +				{ .hz = 10, .value = 0x02, },
> +				{ .hz = 25, .value = 0x03, },
> +				{ .hz = 50, .value = 0x04, },
> +				{ .hz = 100, .value = 0x05, },
> +				{ .hz = 200, .value = 0x06, },
> +				{ .hz = 400, .value = 0x07, },
> +				{ .hz = 1600, .value = 0x08, },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_ACCEL_1_ODR_ADDR,
> -			.mask = ST_ACCEL_1_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0xf0,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
>  		.enable_axis = {
> @@ -317,48 +129,48 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
>  		},
>  		.fs = {
> -			.addr = ST_ACCEL_1_FS_ADDR,
> -			.mask = ST_ACCEL_1_FS_MASK,
> +			.addr = 0x23,
> +			.mask = 0x30,
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_ACCEL_FS_AVL_2G,
> -					.value = ST_ACCEL_1_FS_AVL_2_VAL,
> -					.gain = ST_ACCEL_1_FS_AVL_2_GAIN,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(1000),
>  				},
>  				[1] = {
>  					.num = ST_ACCEL_FS_AVL_4G,
> -					.value = ST_ACCEL_1_FS_AVL_4_VAL,
> -					.gain = ST_ACCEL_1_FS_AVL_4_GAIN,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(2000),
>  				},
>  				[2] = {
>  					.num = ST_ACCEL_FS_AVL_8G,
> -					.value = ST_ACCEL_1_FS_AVL_8_VAL,
> -					.gain = ST_ACCEL_1_FS_AVL_8_GAIN,
> +					.value = 0x02,
> +					.gain = IIO_G_TO_M_S_2(4000),
>  				},
>  				[3] = {
>  					.num = ST_ACCEL_FS_AVL_16G,
> -					.value = ST_ACCEL_1_FS_AVL_16_VAL,
> -					.gain = ST_ACCEL_1_FS_AVL_16_GAIN,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(12000),
>  				},
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_ACCEL_1_BDU_ADDR,
> -			.mask = ST_ACCEL_1_BDU_MASK,
> +			.addr = 0x23,
> +			.mask = 0x80,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_ACCEL_1_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_ACCEL_1_DRDY_IRQ_INT1_MASK,
> -			.mask_int2 = ST_ACCEL_1_DRDY_IRQ_INT2_MASK,
> -			.addr_ihl = ST_ACCEL_1_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_ACCEL_1_IHL_IRQ_MASK,
> +			.addr = 0x22,
> +			.mask_int1 = 0x10,
> +			.mask_int2 = 0x08,
> +			.addr_ihl = 0x25,
> +			.mask_ihl = 0x02,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
> +		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_ACCEL_2_WAI_EXP,
> +		.wai = 0x32,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LIS331DLH_ACCEL_DEV_NAME,
> @@ -368,18 +180,18 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>  		.odr = {
> -			.addr = ST_ACCEL_2_ODR_ADDR,
> -			.mask = ST_ACCEL_2_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x18,
>  			.odr_avl = {
> -				{ 50, ST_ACCEL_2_ODR_AVL_50HZ_VAL, },
> -				{ 100, ST_ACCEL_2_ODR_AVL_100HZ_VAL, },
> -				{ 400, ST_ACCEL_2_ODR_AVL_400HZ_VAL, },
> -				{ 1000, ST_ACCEL_2_ODR_AVL_1000HZ_VAL, },
> +				{ .hz = 50, .value = 0x00, },
> +				{ .hz = 100, .value = 0x01, },
> +				{ .hz = 400, .value = 0x02, },
> +				{ .hz = 1000, .value = 0x03, },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_ACCEL_2_PW_ADDR,
> -			.mask = ST_ACCEL_2_PW_MASK,
> +			.addr = 0x20,
> +			.mask = 0xe0,
>  			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
> @@ -388,69 +200,69 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
>  		},
>  		.fs = {
> -			.addr = ST_ACCEL_2_FS_ADDR,
> -			.mask = ST_ACCEL_2_FS_MASK,
> +			.addr = 0x23,
> +			.mask = 0x30,
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_ACCEL_FS_AVL_2G,
> -					.value = ST_ACCEL_2_FS_AVL_2_VAL,
> -					.gain = ST_ACCEL_2_FS_AVL_2_GAIN,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(1000),
>  				},
>  				[1] = {
>  					.num = ST_ACCEL_FS_AVL_4G,
> -					.value = ST_ACCEL_2_FS_AVL_4_VAL,
> -					.gain = ST_ACCEL_2_FS_AVL_4_GAIN,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(2000),
>  				},
>  				[2] = {
>  					.num = ST_ACCEL_FS_AVL_8G,
> -					.value = ST_ACCEL_2_FS_AVL_8_VAL,
> -					.gain = ST_ACCEL_2_FS_AVL_8_GAIN,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(3900),
>  				},
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_ACCEL_2_BDU_ADDR,
> -			.mask = ST_ACCEL_2_BDU_MASK,
> +			.addr = 0x23,
> +			.mask = 0x80,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_ACCEL_2_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_ACCEL_2_DRDY_IRQ_INT1_MASK,
> -			.mask_int2 = ST_ACCEL_2_DRDY_IRQ_INT2_MASK,
> -			.addr_ihl = ST_ACCEL_2_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_ACCEL_2_IHL_IRQ_MASK,
> -			.addr_od = ST_ACCEL_2_OD_IRQ_ADDR,
> -			.mask_od = ST_ACCEL_2_OD_IRQ_MASK,
> +			.addr = 0x22,
> +			.mask_int1 = 0x02,
> +			.mask_int2 = 0x10,
> +			.addr_ihl = 0x22,
> +			.mask_ihl = 0x80,
> +			.addr_od = 0x22,
> +			.mask_od = 0x40,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
> +		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_ACCEL_3_WAI_EXP,
> +		.wai = 0x40,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LSM330_ACCEL_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
>  		.odr = {
> -			.addr = ST_ACCEL_3_ODR_ADDR,
> -			.mask = ST_ACCEL_3_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0xf0,
>  			.odr_avl = {
> -				{ 3, ST_ACCEL_3_ODR_AVL_3HZ_VAL },
> -				{ 6, ST_ACCEL_3_ODR_AVL_6HZ_VAL, },
> -				{ 12, ST_ACCEL_3_ODR_AVL_12HZ_VAL, },
> -				{ 25, ST_ACCEL_3_ODR_AVL_25HZ_VAL, },
> -				{ 50, ST_ACCEL_3_ODR_AVL_50HZ_VAL, },
> -				{ 100, ST_ACCEL_3_ODR_AVL_100HZ_VAL, },
> -				{ 200, ST_ACCEL_3_ODR_AVL_200HZ_VAL, },
> -				{ 400, ST_ACCEL_3_ODR_AVL_400HZ_VAL, },
> -				{ 800, ST_ACCEL_3_ODR_AVL_800HZ_VAL, },
> -				{ 1600, ST_ACCEL_3_ODR_AVL_1600HZ_VAL, },
> +				{ .hz = 3, .value = 0x01, },
> +				{ .hz = 6, .value = 0x02, },
> +				{ .hz = 12, .value = 0x03, },
> +				{ .hz = 25, .value = 0x04, },
> +				{ .hz = 50, .value = 0x05, },
> +				{ .hz = 100, .value = 0x06, },
> +				{ .hz = 200, .value = 0x07, },
> +				{ .hz = 400, .value = 0x08, },
> +				{ .hz = 800, .value = 0x09, },
> +				{ .hz = 1600, .value = 0x0a, },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_ACCEL_3_ODR_ADDR,
> -			.mask = ST_ACCEL_3_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0xf0,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
>  		.enable_axis = {
> @@ -458,75 +270,75 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
>  		},
>  		.fs = {
> -			.addr = ST_ACCEL_3_FS_ADDR,
> -			.mask = ST_ACCEL_3_FS_MASK,
> +			.addr = 0x24,
> +			.mask = 0x38,
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_ACCEL_FS_AVL_2G,
> -					.value = ST_ACCEL_3_FS_AVL_2_VAL,
> -					.gain = ST_ACCEL_3_FS_AVL_2_GAIN,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(61),
>  				},
>  				[1] = {
>  					.num = ST_ACCEL_FS_AVL_4G,
> -					.value = ST_ACCEL_3_FS_AVL_4_VAL,
> -					.gain = ST_ACCEL_3_FS_AVL_4_GAIN,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(122),
>  				},
>  				[2] = {
>  					.num = ST_ACCEL_FS_AVL_6G,
> -					.value = ST_ACCEL_3_FS_AVL_6_VAL,
> -					.gain = ST_ACCEL_3_FS_AVL_6_GAIN,
> +					.value = 0x02,
> +					.gain = IIO_G_TO_M_S_2(183),
>  				},
>  				[3] = {
>  					.num = ST_ACCEL_FS_AVL_8G,
> -					.value = ST_ACCEL_3_FS_AVL_8_VAL,
> -					.gain = ST_ACCEL_3_FS_AVL_8_GAIN,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(244),
>  				},
>  				[4] = {
>  					.num = ST_ACCEL_FS_AVL_16G,
> -					.value = ST_ACCEL_3_FS_AVL_16_VAL,
> -					.gain = ST_ACCEL_3_FS_AVL_16_GAIN,
> +					.value = 0x04,
> +					.gain = IIO_G_TO_M_S_2(732),
>  				},
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_ACCEL_3_BDU_ADDR,
> -			.mask = ST_ACCEL_3_BDU_MASK,
> +			.addr = 0x20,
> +			.mask = 0x08,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_ACCEL_3_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_ACCEL_3_DRDY_IRQ_INT1_MASK,
> -			.mask_int2 = ST_ACCEL_3_DRDY_IRQ_INT2_MASK,
> -			.addr_ihl = ST_ACCEL_3_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_ACCEL_3_IHL_IRQ_MASK,
> +			.addr = 0x23,
> +			.mask_int1 = 0x80,
> +			.mask_int2 = 0x00,
> +			.addr_ihl = 0x23,
> +			.mask_ihl = 0x40,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  			.ig1 = {
> -				.en_addr = ST_ACCEL_3_IG1_EN_ADDR,
> -				.en_mask = ST_ACCEL_3_IG1_EN_MASK,
> +				.en_addr = 0x23,
> +				.en_mask = 0x08,
>  			},
>  		},
> -		.multi_read_bit = ST_ACCEL_3_MULTIREAD_BIT,
> +		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
>  	{
> -		.wai = ST_ACCEL_4_WAI_EXP,
> +		.wai = 0x3a,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LIS3LV02DL_ACCEL_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>  		.odr = {
> -			.addr = ST_ACCEL_4_ODR_ADDR,
> -			.mask = ST_ACCEL_4_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x30, /* DF1 and DF0 */
>  			.odr_avl = {
> -				{ 40, ST_ACCEL_4_ODR_AVL_40HZ_VAL },
> -				{ 160, ST_ACCEL_4_ODR_AVL_160HZ_VAL, },
> -				{ 640, ST_ACCEL_4_ODR_AVL_640HZ_VAL, },
> -				{ 2560, ST_ACCEL_4_ODR_AVL_2560HZ_VAL, },
> +				{ .hz = 40, .value = 0x00, },
> +				{ .hz = 160, .value = 0x01, },
> +				{ .hz = 640, .value = 0x02, },
> +				{ .hz = 2560, .value = 0x03, },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_ACCEL_4_PW_ADDR,
> -			.mask = ST_ACCEL_4_PW_MASK,
> +			.addr = 0x20,
> +			.mask = 0xc0,
>  			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
> @@ -535,51 +347,51 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
>  		},
>  		.fs = {
> -			.addr = ST_ACCEL_4_FS_ADDR,
> -			.mask = ST_ACCEL_4_FS_MASK,
> +			.addr = 0x21,
> +			.mask = 0x80,
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_ACCEL_FS_AVL_2G,
> -					.value = ST_ACCEL_4_FS_AVL_2_VAL,
> -					.gain = ST_ACCEL_4_FS_AVL_2_GAIN,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(1024),
>  				},
>  				[1] = {
>  					.num = ST_ACCEL_FS_AVL_6G,
> -					.value = ST_ACCEL_4_FS_AVL_6_VAL,
> -					.gain = ST_ACCEL_4_FS_AVL_6_GAIN,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(340),
>  				},
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_ACCEL_4_BDU_ADDR,
> -			.mask = ST_ACCEL_4_BDU_MASK,
> +			.addr = 0x21,
> +			.mask = 0x40,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_ACCEL_4_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_ACCEL_4_DRDY_IRQ_INT1_MASK,
> +			.addr = 0x21,
> +			.mask_int1 = 0x04,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_ACCEL_4_MULTIREAD_BIT,
> +		.multi_read_bit = true,
>  		.bootime = 2, /* guess */
>  	},
>  	{
> -		.wai = ST_ACCEL_5_WAI_EXP,
> +		.wai = 0x3b,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LIS331DL_ACCEL_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
>  		.odr = {
> -			.addr = ST_ACCEL_5_ODR_ADDR,
> -			.mask = ST_ACCEL_5_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x80,
>  			.odr_avl = {
> -				{ 100, ST_ACCEL_5_ODR_AVL_100HZ_VAL },
> -				{ 400, ST_ACCEL_5_ODR_AVL_400HZ_VAL, },
> +				{ .hz = 100, .value = 0x00, },
> +				{ .hz = 400, .value = 0x01, },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_ACCEL_5_PW_ADDR,
> -			.mask = ST_ACCEL_5_PW_MASK,
> +			.addr = 0x20,
> +			.mask = 0x40,
>  			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
> @@ -588,54 +400,58 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
>  		},
>  		.fs = {
> -			.addr = ST_ACCEL_5_FS_ADDR,
> -			.mask = ST_ACCEL_5_FS_MASK,
> +			.addr = 0x20,
> +			.mask = 0x20,
> +			/*
> +			 * TODO: check these resulting gain settings, these are
> +			 * not in the datsheet
> +			 */
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_ACCEL_FS_AVL_2G,
> -					.value = ST_ACCEL_5_FS_AVL_2_VAL,
> -					.gain = ST_ACCEL_5_FS_AVL_2_GAIN,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(18000),
>  				},
>  				[1] = {
>  					.num = ST_ACCEL_FS_AVL_8G,
> -					.value = ST_ACCEL_5_FS_AVL_8_VAL,
> -					.gain = ST_ACCEL_5_FS_AVL_8_GAIN,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(72000),
>  				},
>  			},
>  		},
>  		.drdy_irq = {
> -			.addr = ST_ACCEL_5_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_ACCEL_5_DRDY_IRQ_INT1_MASK,
> -			.mask_int2 = ST_ACCEL_5_DRDY_IRQ_INT2_MASK,
> -			.addr_ihl = ST_ACCEL_5_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_ACCEL_5_IHL_IRQ_MASK,
> -			.addr_od = ST_ACCEL_5_OD_IRQ_ADDR,
> -			.mask_od = ST_ACCEL_5_OD_IRQ_MASK,
> +			.addr = 0x22,
> +			.mask_int1 = 0x04,
> +			.mask_int2 = 0x20,
> +			.addr_ihl = 0x22,
> +			.mask_ihl = 0x80,
> +			.addr_od = 0x22,
> +			.mask_od = 0x40,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_ACCEL_5_MULTIREAD_BIT,
> +		.multi_read_bit = false,
>  		.bootime = 2, /* guess */
>  	},
>  	{
> -		.wai = ST_ACCEL_6_WAI_EXP,
> +		.wai = 0x32,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = H3LIS331DL_DRIVER_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>  		.odr = {
> -			.addr = ST_ACCEL_6_ODR_ADDR,
> -			.mask = ST_ACCEL_6_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x18,
>  			.odr_avl = {
> -				{ 50, ST_ACCEL_6_ODR_AVL_50HZ_VAL },
> -				{ 100, ST_ACCEL_6_ODR_AVL_100HZ_VAL, },
> -				{ 400, ST_ACCEL_6_ODR_AVL_400HZ_VAL, },
> -				{ 1000, ST_ACCEL_6_ODR_AVL_1000HZ_VAL, },
> +				{ .hz = 50, .value = 0x00, },
> +				{ .hz = 100, .value = 0x01, },
> +				{ .hz = 400, .value = 0x02, },
> +				{ .hz = 1000, .value = 0x03, },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_ACCEL_6_PW_ADDR,
> -			.mask = ST_ACCEL_6_PW_MASK,
> +			.addr = 0x20,
> +			.mask = 0x20,
>  			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
> @@ -644,38 +460,38 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
>  		},
>  		.fs = {
> -			.addr = ST_ACCEL_6_FS_ADDR,
> -			.mask = ST_ACCEL_6_FS_MASK,
> +			.addr = 0x23,
> +			.mask = 0x30,
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_ACCEL_FS_AVL_100G,
> -					.value = ST_ACCEL_6_FS_AVL_100_VAL,
> -					.gain = ST_ACCEL_6_FS_AVL_100_GAIN,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(49000),
>  				},
>  				[1] = {
>  					.num = ST_ACCEL_FS_AVL_200G,
> -					.value = ST_ACCEL_6_FS_AVL_200_VAL,
> -					.gain = ST_ACCEL_6_FS_AVL_200_GAIN,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(98000),
>  				},
>  				[2] = {
>  					.num = ST_ACCEL_FS_AVL_400G,
> -					.value = ST_ACCEL_6_FS_AVL_400_VAL,
> -					.gain = ST_ACCEL_6_FS_AVL_400_GAIN,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(195000),
>  				},
>  			},
>  		},
>  		.bdu = {
> -			.addr = ST_ACCEL_6_BDU_ADDR,
> -			.mask = ST_ACCEL_6_BDU_MASK,
> +			.addr = 0x23,
> +			.mask = 0x80,
>  		},
>  		.drdy_irq = {
> -			.addr = ST_ACCEL_6_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_ACCEL_6_DRDY_IRQ_INT1_MASK,
> -			.mask_int2 = ST_ACCEL_6_DRDY_IRQ_INT2_MASK,
> -			.addr_ihl = ST_ACCEL_6_IHL_IRQ_ADDR,
> -			.mask_ihl = ST_ACCEL_6_IHL_IRQ_MASK,
> +			.addr = 0x22,
> +			.mask_int1 = 0x02,
> +			.mask_int2 = 0x10,
> +			.addr_ihl = 0x22,
> +			.mask_ihl = 0x80,
>  		},
> -		.multi_read_bit = ST_ACCEL_6_MULTIREAD_BIT,
> +		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
>  	{
> @@ -685,18 +501,18 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>  		.odr = {
> -			.addr = ST_ACCEL_7_ODR_ADDR,
> -			.mask = ST_ACCEL_7_ODR_MASK,
> +			.addr = 0x20,
> +			.mask = 0x30,
>  			.odr_avl = {
> -				{ 280, ST_ACCEL_7_ODR_AVL_280HZ_VAL, },
> -				{ 560, ST_ACCEL_7_ODR_AVL_560HZ_VAL, },
> -				{ 1120, ST_ACCEL_7_ODR_AVL_1120HZ_VAL, },
> -				{ 4480, ST_ACCEL_7_ODR_AVL_4480HZ_VAL, },
> +				{ .hz = 280, .value = 0x00, },
> +				{ .hz = 560, .value = 0x01, },
> +				{ .hz = 1120, .value = 0x02, },
> +				{ .hz = 4480, .value = 0x03, },
>  			},
>  		},
>  		.pw = {
> -			.addr = ST_ACCEL_7_PW_ADDR,
> -			.mask = ST_ACCEL_7_PW_MASK,
> +			.addr = 0x20,
> +			.mask = 0xc0,
>  			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>  			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>  		},
> @@ -708,7 +524,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.fs_avl = {
>  				[0] = {
>  					.num = ST_ACCEL_FS_AVL_2G,
> -					.gain = ST_ACCEL_7_FS_AVL_2_GAIN,
> +					.gain = IIO_G_TO_M_S_2(488),
>  				},
>  			},
>  		},
> @@ -719,11 +535,11 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.bdu = {
>  		},
>  		.drdy_irq = {
> -			.addr = ST_ACCEL_7_DRDY_IRQ_ADDR,
> -			.mask_int1 = ST_ACCEL_7_DRDY_IRQ_INT1_MASK,
> +			.addr = 0x21,
> +			.mask_int1 = 0x04,
>  			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
> -		.multi_read_bit = ST_ACCEL_7_MULTIREAD_BIT,
> +		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
>  };
> 

