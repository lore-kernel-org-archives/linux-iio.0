Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48006 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbbFGRBB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 13:01:01 -0400
Message-ID: <557478CC.4030806@kernel.org>
Date: Sun, 07 Jun 2015 18:01:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
CC: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2 v2] iio: st_accel: support the LIS331DL sensor
References: <1432042638-26744-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1432042638-26744-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/15 14:37, Linus Walleij wrote:
> This adds support for the LIS331DL sensor version. This is
> a simple 8bit-only accelerometer.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git - pushed out as testing for
the autobuilders to play with it.

Dennis, if your ack covered this as well, then I can still add it
until I push out properly.

Thanks,

Jonathan
> ---
> ChangeLog v1->v2:
> - Change the full-scale sensitivity settings, apparently
>   this is the mg/digit setting multiplied by 1000, so
>   becomes microgram per digit, 18000 and 72000 respectively.
> ---
>  .../devicetree/bindings/iio/st-sensors.txt         |  1 +
>  drivers/iio/accel/st_accel.h                       |  1 +
>  drivers/iio/accel/st_accel_core.c                  | 70 ++++++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c                   |  4 ++
>  4 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index fb5e0c2d18b5..8a6be3bdf267 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -30,6 +30,7 @@ Accelerometers:
>  - st,lsm330d-accel
>  - st,lsm330dl-accel
>  - st,lsm330dlc-accel
> +- st,lis331dl-accel
>  - st,lis331dlh-accel
>  - st,lsm303dl-accel
>  - st,lsm303dlm-accel
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 7ee9724b1428..aa1001931d0c 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -20,6 +20,7 @@
>  #define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
>  #define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
>  #define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
> +#define LIS331DL_ACCEL_DEV_NAME		"lis331dl_accel"
>  #define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
>  #define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
>  #define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index ad19fb4304df..970e9f904dde 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -153,6 +153,28 @@
>  #define ST_ACCEL_4_IG1_EN_MASK			0x08
>  #define ST_ACCEL_4_MULTIREAD_BIT		true
>  
> +/* CUSTOM VALUES FOR SENSOR 5 */
> +#define ST_ACCEL_5_WAI_EXP			0x3b
> +#define ST_ACCEL_5_ODR_ADDR			0x20
> +#define ST_ACCEL_5_ODR_MASK			0x80
> +#define ST_ACCEL_5_ODR_AVL_100HZ_VAL		0x00
> +#define ST_ACCEL_5_ODR_AVL_400HZ_VAL		0x01
> +#define ST_ACCEL_5_PW_ADDR			0x20
> +#define ST_ACCEL_5_PW_MASK			0x40
> +#define ST_ACCEL_5_FS_ADDR			0x20
> +#define ST_ACCEL_5_FS_MASK			0x20
> +#define ST_ACCEL_5_FS_AVL_2_VAL			0X00
> +#define ST_ACCEL_5_FS_AVL_8_VAL			0X01
> +/* TODO: check these resulting gain settings, these are not in the datsheet */
> +#define ST_ACCEL_5_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(18000)
> +#define ST_ACCEL_5_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(72000)
> +#define ST_ACCEL_5_DRDY_IRQ_ADDR		0x22
> +#define ST_ACCEL_5_DRDY_IRQ_INT1_MASK		0x04
> +#define ST_ACCEL_5_DRDY_IRQ_INT2_MASK		0x20
> +#define ST_ACCEL_5_IG1_EN_ADDR			0x21
> +#define ST_ACCEL_5_IG1_EN_MASK			0x08
> +#define ST_ACCEL_5_MULTIREAD_BIT		false
> +
>  static const struct iio_chan_spec st_accel_8bit_channels[] = {
>  	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> @@ -470,6 +492,54 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = ST_ACCEL_4_MULTIREAD_BIT,
>  		.bootime = 2, /* guess */
>  	},
> +	{
> +		.wai = ST_ACCEL_5_WAI_EXP,
> +		.sensors_supported = {
> +			[0] = LIS331DL_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
> +		.odr = {
> +			.addr = ST_ACCEL_5_ODR_ADDR,
> +			.mask = ST_ACCEL_5_ODR_MASK,
> +			.odr_avl = {
> +				{ 100, ST_ACCEL_5_ODR_AVL_100HZ_VAL },
> +				{ 400, ST_ACCEL_5_ODR_AVL_400HZ_VAL, },
> +			},
> +		},
> +		.pw = {
> +			.addr = ST_ACCEL_5_PW_ADDR,
> +			.mask = ST_ACCEL_5_PW_MASK,
> +			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.enable_axis = {
> +			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> +			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> +		},
> +		.fs = {
> +			.addr = ST_ACCEL_5_FS_ADDR,
> +			.mask = ST_ACCEL_5_FS_MASK,
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_ACCEL_FS_AVL_2G,
> +					.value = ST_ACCEL_5_FS_AVL_2_VAL,
> +					.gain = ST_ACCEL_5_FS_AVL_2_GAIN,
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_8G,
> +					.value = ST_ACCEL_5_FS_AVL_8_VAL,
> +					.gain = ST_ACCEL_5_FS_AVL_8_GAIN,
> +				},
> +			},
> +		},
> +		.drdy_irq = {
> +			.addr = ST_ACCEL_5_DRDY_IRQ_ADDR,
> +			.mask_int1 = ST_ACCEL_5_DRDY_IRQ_INT1_MASK,
> +			.mask_int2 = ST_ACCEL_5_DRDY_IRQ_INT2_MASK,
> +		},
> +		.multi_read_bit = ST_ACCEL_5_MULTIREAD_BIT,
> +		.bootime = 2, /* guess */
> +	},
>  };
>  
>  static int st_accel_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 6b720c190b2d..d4ad72ca4a3d 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -49,6 +49,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.data = LSM330DLC_ACCEL_DEV_NAME,
>  	},
>  	{
> +		.compatible = "st,lis331dl-accel",
> +		.data = LIS331DL_ACCEL_DEV_NAME,
> +	},
> +	{
>  		.compatible = "st,lis331dlh-accel",
>  		.data = LIS331DLH_ACCEL_DEV_NAME,
>  	},
> 

