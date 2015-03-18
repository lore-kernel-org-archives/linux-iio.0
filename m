Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:35327 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbbCRPjy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2015 11:39:54 -0400
Received: by webcq43 with SMTP id cq43so35475581web.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2015 08:39:52 -0700 (PDT)
Date: Wed, 18 Mar 2015 15:39:48 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND] iio: st-sensors: add support for lis3lv02d
 accelerometer
Message-ID: <20150318153948.GQ3318@x1>
References: <1426672326-6292-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1426672326-6292-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Mar 2015, Linus Walleij wrote:

> This adds support for the LIS3LV02 accelerometer found in the
> ST Microelectronics Nomadik board series.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Denis CIOCCA <denis.ciocca@st.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I'm not giving up on this. I think the st-sensors driver should
> support this variant as its framework is way better than the misc
> driver. The other driver is anyway not even in the right subsystem.

I'm not sure what the historical issues are, but the code looks fine
to me.

Acked-by: Lee Jones <lee.jones@linaro.org>

> ---
>  .../devicetree/bindings/iio/st-sensors.txt         |  1 +
>  drivers/iio/accel/st_accel.h                       |  1 +
>  drivers/iio/accel/st_accel_core.c                  | 81 ++++++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c                   |  4 ++
>  4 files changed, 87 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index a7a0a15913ad..d2aaca974531 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -23,6 +23,7 @@ standard bindings from pinctrl/pinctrl-bindings.txt.
>  Valid compatible strings:
>  
>  Accelerometers:
> +- st,lis3lv02dl-accel
>  - st,lsm303dlh-accel
>  - st,lsm303dlhc-accel
>  - st,lis3dh-accel
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index fa9646034305..7ee9724b1428 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/iio/common/st_sensors.h>
>  
> +#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl_accel"
>  #define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
>  #define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
>  #define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 53f32629283a..58d1d13d552a 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -129,6 +129,30 @@
>  #define ST_ACCEL_3_IG1_EN_MASK			0x08
>  #define ST_ACCEL_3_MULTIREAD_BIT		false
>  
> +/* CUSTOM VALUES FOR SENSOR 4 */
> +#define ST_ACCEL_4_WAI_EXP			0x3a
> +#define ST_ACCEL_4_ODR_ADDR			0x20
> +#define ST_ACCEL_4_ODR_MASK			0x30 /* DF1 and DF0 */
> +#define ST_ACCEL_4_ODR_AVL_40HZ_VAL		0x00
> +#define ST_ACCEL_4_ODR_AVL_160HZ_VAL		0x01
> +#define ST_ACCEL_4_ODR_AVL_640HZ_VAL		0x02
> +#define ST_ACCEL_4_ODR_AVL_2560HZ_VAL		0x03
> +#define ST_ACCEL_4_PW_ADDR			0x20
> +#define ST_ACCEL_4_PW_MASK			0xc0
> +#define ST_ACCEL_4_FS_ADDR			0x21
> +#define ST_ACCEL_4_FS_MASK			0x80
> +#define ST_ACCEL_4_FS_AVL_2_VAL			0X00
> +#define ST_ACCEL_4_FS_AVL_6_VAL			0X01
> +#define ST_ACCEL_4_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(1024)
> +#define ST_ACCEL_4_FS_AVL_6_GAIN		IIO_G_TO_M_S_2(340)
> +#define ST_ACCEL_4_BDU_ADDR			0x21
> +#define ST_ACCEL_4_BDU_MASK			0x40
> +#define ST_ACCEL_4_DRDY_IRQ_ADDR		0x21
> +#define ST_ACCEL_4_DRDY_IRQ_INT1_MASK		0x04
> +#define ST_ACCEL_4_IG1_EN_ADDR			0x21
> +#define ST_ACCEL_4_IG1_EN_MASK			0x08
> +#define ST_ACCEL_4_MULTIREAD_BIT		true
> +
>  static const struct iio_chan_spec st_accel_12bit_channels[] = {
>  	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> @@ -373,6 +397,63 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = ST_ACCEL_3_MULTIREAD_BIT,
>  		.bootime = 2,
>  	},
> +	{
> +		.wai = ST_ACCEL_4_WAI_EXP,
> +		.sensors_supported = {
> +			[0] = LIS3LV02DL_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
> +		.odr = {
> +			.addr = ST_ACCEL_4_ODR_ADDR,
> +			.mask = ST_ACCEL_4_ODR_MASK,
> +			.odr_avl = {
> +				{ 40, ST_ACCEL_4_ODR_AVL_40HZ_VAL },
> +				{ 160, ST_ACCEL_4_ODR_AVL_160HZ_VAL, },
> +				{ 640, ST_ACCEL_4_ODR_AVL_640HZ_VAL, },
> +				{ 2560, ST_ACCEL_4_ODR_AVL_2560HZ_VAL, },
> +			},
> +		},
> +		.pw = {
> +			.addr = ST_ACCEL_4_PW_ADDR,
> +			.mask = ST_ACCEL_4_PW_MASK,
> +			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.enable_axis = {
> +			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> +			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> +		},
> +		.fs = {
> +			.addr = ST_ACCEL_4_FS_ADDR,
> +			.mask = ST_ACCEL_4_FS_MASK,
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_ACCEL_FS_AVL_2G,
> +					.value = ST_ACCEL_4_FS_AVL_2_VAL,
> +					.gain = ST_ACCEL_4_FS_AVL_2_GAIN,
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_6G,
> +					.value = ST_ACCEL_4_FS_AVL_6_VAL,
> +					.gain = ST_ACCEL_4_FS_AVL_6_GAIN,
> +				},
> +			},
> +		},
> +		.bdu = {
> +			.addr = ST_ACCEL_4_BDU_ADDR,
> +			.mask = ST_ACCEL_4_BDU_MASK,
> +		},
> +		.drdy_irq = {
> +			.addr = ST_ACCEL_4_DRDY_IRQ_ADDR,
> +			.mask_int1 = ST_ACCEL_4_DRDY_IRQ_INT1_MASK,
> +			.ig1 = {
> +				.en_addr = ST_ACCEL_4_IG1_EN_ADDR,
> +				.en_mask = ST_ACCEL_4_IG1_EN_MASK,
> +			},
> +		},
> +		.multi_read_bit = ST_ACCEL_4_MULTIREAD_BIT,
> +		.bootime = 2, /* guess */
> +	},
>  };
>  
>  static int st_accel_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index c7246bdd30b9..6b720c190b2d 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -21,6 +21,10 @@
>  #ifdef CONFIG_OF
>  static const struct of_device_id st_accel_of_match[] = {
>  	{
> +		.compatible = "st,lis3lv02dl-accel",
> +		.data = LIS3LV02DL_ACCEL_DEV_NAME,
> +	},
> +	{
>  		.compatible = "st,lsm303dlh-accel",
>  		.data = LSM303DLH_ACCEL_DEV_NAME,
>  	},

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
