Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46931 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbEDQ04 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:26:56 -0400
Message-ID: <55479DCA.1020300@kernel.org>
Date: Mon, 04 May 2015 17:26:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
CC: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 05/10] iio: magnetometer: support for lsm303dlh
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org> <1430399755-26475-5-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-5-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/04/15 14:15, Linus Walleij wrote:
> The LSM303DLH accelerometer/magnetometer has a different
> device identification method than using register 0x0f, instead
> three registers contain a magic value. We rely on WhoAmI
> to be zero for this variant.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git which will initially get
pushed out as testing sometime in the next few days.

Jonathan
> ---
>  .../devicetree/bindings/iio/st-sensors.txt         |   1 +
>  drivers/iio/magnetometer/st_magn.h                 |   1 +
>  drivers/iio/magnetometer/st_magn_core.c            | 116 +++++++++++++++++++++
>  drivers/iio/magnetometer/st_magn_i2c.c             |   5 +
>  4 files changed, 123 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index d2aaca974531..fb5e0c2d18b5 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -45,6 +45,7 @@ Gyroscopes:
>  - st,lsm330-gyro
>  
>  Magnetometers:
> +- st,lsm303dlh-magn
>  - st,lsm303dlhc-magn
>  - st,lsm303dlm-magn
>  - st,lis3mdl-magn
> diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
> index 7e81d00ef0c3..287691ca56c1 100644
> --- a/drivers/iio/magnetometer/st_magn.h
> +++ b/drivers/iio/magnetometer/st_magn.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/iio/common/st_sensors.h>
>  
> +#define LSM303DLH_MAGN_DEV_NAME		"lsm303dlh_magn"
>  #define LSM303DLHC_MAGN_DEV_NAME	"lsm303dlhc_magn"
>  #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
>  #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 8ade473f99fe..73574d912e7c 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -45,6 +45,46 @@
>  #define ST_MAGN_FS_AVL_12000MG			12000
>  #define ST_MAGN_FS_AVL_16000MG			16000
>  
> +/* CUSTOM VALUES FOR SENSOR 0 */
> +#define ST_MAGN_0_ODR_ADDR			0x00
> +#define ST_MAGN_0_ODR_MASK			0x1c
> +#define ST_MAGN_0_ODR_AVL_1HZ_VAL		0x00
> +#define ST_MAGN_0_ODR_AVL_2HZ_VAL		0x01
> +#define ST_MAGN_0_ODR_AVL_3HZ_VAL		0x02
> +#define ST_MAGN_0_ODR_AVL_8HZ_VAL		0x03
> +#define ST_MAGN_0_ODR_AVL_15HZ_VAL		0x04
> +#define ST_MAGN_0_ODR_AVL_30HZ_VAL		0x05
> +#define ST_MAGN_0_ODR_AVL_75HZ_VAL		0x06
> +#define ST_MAGN_0_ODR_AVL_220HZ_VAL		0x07
> +#define ST_MAGN_0_PW_ADDR			0x02
> +#define ST_MAGN_0_PW_MASK			0x03
> +#define ST_MAGN_0_PW_ON				0x00
> +#define ST_MAGN_0_PW_OFF			0x03
> +#define ST_MAGN_0_FS_ADDR			0x01
> +#define ST_MAGN_0_FS_MASK			0xe0
> +#define ST_MAGN_0_FS_AVL_1300_VAL		0x01
> +#define ST_MAGN_0_FS_AVL_1900_VAL		0x02
> +#define ST_MAGN_0_FS_AVL_2500_VAL		0x03
> +#define ST_MAGN_0_FS_AVL_4000_VAL		0x04
> +#define ST_MAGN_0_FS_AVL_4700_VAL		0x05
> +#define ST_MAGN_0_FS_AVL_5600_VAL		0x06
> +#define ST_MAGN_0_FS_AVL_8100_VAL		0x07
> +#define ST_MAGN_0_FS_AVL_1300_GAIN_XY		1100
> +#define ST_MAGN_0_FS_AVL_1900_GAIN_XY		855
> +#define ST_MAGN_0_FS_AVL_2500_GAIN_XY		670
> +#define ST_MAGN_0_FS_AVL_4000_GAIN_XY		450
> +#define ST_MAGN_0_FS_AVL_4700_GAIN_XY		400
> +#define ST_MAGN_0_FS_AVL_5600_GAIN_XY		330
> +#define ST_MAGN_0_FS_AVL_8100_GAIN_XY		230
> +#define ST_MAGN_0_FS_AVL_1300_GAIN_Z		980
> +#define ST_MAGN_0_FS_AVL_1900_GAIN_Z		760
> +#define ST_MAGN_0_FS_AVL_2500_GAIN_Z		600
> +#define ST_MAGN_0_FS_AVL_4000_GAIN_Z		400
> +#define ST_MAGN_0_FS_AVL_4700_GAIN_Z		355
> +#define ST_MAGN_0_FS_AVL_5600_GAIN_Z		295
> +#define ST_MAGN_0_FS_AVL_8100_GAIN_Z		205
> +#define ST_MAGN_0_MULTIREAD_BIT			false
> +
>  /* CUSTOM VALUES FOR SENSOR 1 */
>  #define ST_MAGN_1_WAI_EXP			0x3c
>  #define ST_MAGN_1_ODR_ADDR			0x00
> @@ -151,6 +191,82 @@ static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
>  
>  static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  	{
> +		.wai = 0, /* This sensor has no valid WhoAmI report 0 */
> +		.sensors_supported = {
> +			[0] = LSM303DLH_MAGN_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
> +		.odr = {
> +			.addr = ST_MAGN_0_ODR_ADDR,
> +			.mask = ST_MAGN_0_ODR_MASK,
> +			.odr_avl = {
> +				{ 1, ST_MAGN_0_ODR_AVL_1HZ_VAL, },
> +				{ 2, ST_MAGN_0_ODR_AVL_2HZ_VAL, },
> +				{ 3, ST_MAGN_0_ODR_AVL_3HZ_VAL, },
> +				{ 8, ST_MAGN_0_ODR_AVL_8HZ_VAL, },
> +				{ 15, ST_MAGN_0_ODR_AVL_15HZ_VAL, },
> +				{ 30, ST_MAGN_0_ODR_AVL_30HZ_VAL, },
> +				{ 75, ST_MAGN_0_ODR_AVL_75HZ_VAL, },
> +			},
> +		},
> +		.pw = {
> +			.addr = ST_MAGN_0_PW_ADDR,
> +			.mask = ST_MAGN_0_PW_MASK,
> +			.value_on = ST_MAGN_0_PW_ON,
> +			.value_off = ST_MAGN_0_PW_OFF,
> +		},
> +		.fs = {
> +			.addr = ST_MAGN_0_FS_ADDR,
> +			.mask = ST_MAGN_0_FS_MASK,
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_MAGN_FS_AVL_1300MG,
> +					.value = ST_MAGN_0_FS_AVL_1300_VAL,
> +					.gain = ST_MAGN_0_FS_AVL_1300_GAIN_XY,
> +					.gain2 = ST_MAGN_0_FS_AVL_1300_GAIN_Z,
> +				},
> +				[1] = {
> +					.num = ST_MAGN_FS_AVL_1900MG,
> +					.value = ST_MAGN_0_FS_AVL_1900_VAL,
> +					.gain = ST_MAGN_0_FS_AVL_1900_GAIN_XY,
> +					.gain2 = ST_MAGN_0_FS_AVL_1900_GAIN_Z,
> +				},
> +				[2] = {
> +					.num = ST_MAGN_FS_AVL_2500MG,
> +					.value = ST_MAGN_0_FS_AVL_2500_VAL,
> +					.gain = ST_MAGN_0_FS_AVL_2500_GAIN_XY,
> +					.gain2 = ST_MAGN_0_FS_AVL_2500_GAIN_Z,
> +				},
> +				[3] = {
> +					.num = ST_MAGN_FS_AVL_4000MG,
> +					.value = ST_MAGN_0_FS_AVL_4000_VAL,
> +					.gain = ST_MAGN_0_FS_AVL_4000_GAIN_XY,
> +					.gain2 = ST_MAGN_0_FS_AVL_4000_GAIN_Z,
> +				},
> +				[4] = {
> +					.num = ST_MAGN_FS_AVL_4700MG,
> +					.value = ST_MAGN_0_FS_AVL_4700_VAL,
> +					.gain = ST_MAGN_0_FS_AVL_4700_GAIN_XY,
> +					.gain2 = ST_MAGN_0_FS_AVL_4700_GAIN_Z,
> +				},
> +				[5] = {
> +					.num = ST_MAGN_FS_AVL_5600MG,
> +					.value = ST_MAGN_0_FS_AVL_5600_VAL,
> +					.gain = ST_MAGN_0_FS_AVL_5600_GAIN_XY,
> +					.gain2 = ST_MAGN_0_FS_AVL_5600_GAIN_Z,
> +				},
> +				[6] = {
> +					.num = ST_MAGN_FS_AVL_8100MG,
> +					.value = ST_MAGN_0_FS_AVL_8100_VAL,
> +					.gain = ST_MAGN_0_FS_AVL_8100_GAIN_XY,
> +					.gain2 = ST_MAGN_0_FS_AVL_8100_GAIN_Z,
> +				},
> +			},
> +		},
> +		.multi_read_bit = ST_MAGN_0_MULTIREAD_BIT,
> +		.bootime = 2,
> +	},
> +	{
>  		.wai = ST_MAGN_1_WAI_EXP,
>  		.sensors_supported = {
>  			[0] = LSM303DLHC_MAGN_DEV_NAME,
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 92e5c15452a3..5311d8aea8cc 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -21,6 +21,10 @@
>  #ifdef CONFIG_OF
>  static const struct of_device_id st_magn_of_match[] = {
>  	{
> +		.compatible = "st,lsm303dlh-magn",
> +		.data = LSM303DLH_MAGN_DEV_NAME,
> +	},
> +	{
>  		.compatible = "st,lsm303dlhc-magn",
>  		.data = LSM303DLHC_MAGN_DEV_NAME,
>  	},
> @@ -71,6 +75,7 @@ static int st_magn_i2c_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id st_magn_id_table[] = {
> +	{ LSM303DLH_MAGN_DEV_NAME },
>  	{ LSM303DLHC_MAGN_DEV_NAME },
>  	{ LSM303DLM_MAGN_DEV_NAME },
>  	{ LIS3MDL_MAGN_DEV_NAME },
> 

