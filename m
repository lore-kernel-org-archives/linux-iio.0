Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45114 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbKVMWX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2015 07:22:23 -0500
Subject: Re: [PATCH 1/2 v3] iio: st_sensors: support active-low interrupts
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1447924517-8190-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5651B37C.5030008@kernel.org>
Date: Sun, 22 Nov 2015 12:22:20 +0000
MIME-Version: 1.0
In-Reply-To: <1447924517-8190-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/11/15 09:15, Linus Walleij wrote:
> Most ST MEMS Sensors that support interrupts can also handle sending
> an active low interrupt, i.e. going from high to low on data ready
> (or other interrupt) and thus triggering on a falling edge to the
> interrupt controller.
> 
> Set up logic to inspect the interrupt line we get for a sensor: if
> it is triggering on rising edge, leave everything alone, but if it
> triggers on falling edges, set up active low, and if unsupported
> configurations appear: warn with errors and reconfigure the interrupt
> to a rising edge, which all interrupt generating sensors support.
> 
> Create a local header for st_sensors_core.h to share functions
> between the sensor core and the trigger setup code.
> 
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Looks good to me.  Ideally I'd like ack from Denis.
(it's early in the cycle so plenty of time for this one!)

Jonathan
> ---
> ChangeLog v2->v3:
> - Fix the missing IHL (IEA) setting for the LSM303AGR
>   magnetometer
> - Drop the active low settings for the gyros: these have
>   DRDY on INT2 and that does not support setting polarity or
>   open drain. Insert an explanatory comment instead.
> ChangeLog v1->v2:
> - Rebased to come first in the series independently of the
>   request_any_context_irq() change.
> - Fixed some errorpath issues found by Denis, including a
>   cleanup to return out directly on the first error.
> ---
>  drivers/iio/accel/st_accel_core.c                  | 16 +++++++
>  drivers/iio/common/st_sensors/st_sensors_core.c    |  6 +--
>  drivers/iio/common/st_sensors/st_sensors_core.h    |  8 ++++
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 52 +++++++++++++++++-----
>  drivers/iio/gyro/st_gyro_core.c                    | 15 +++++++
>  drivers/iio/magnetometer/st_magn_core.c            |  4 ++
>  drivers/iio/pressure/st_pressure_core.c            |  8 ++++
>  include/linux/iio/common/st_sensors.h              |  4 ++
>  8 files changed, 100 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/iio/common/st_sensors/st_sensors_core.h
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 197a08b4e2f3..1132224cbc10 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -67,6 +67,8 @@
>  #define ST_ACCEL_1_DRDY_IRQ_ADDR		0x22
>  #define ST_ACCEL_1_DRDY_IRQ_INT1_MASK		0x10
>  #define ST_ACCEL_1_DRDY_IRQ_INT2_MASK		0x08
> +#define ST_ACCEL_1_IHL_IRQ_ADDR			0x25
> +#define ST_ACCEL_1_IHL_IRQ_MASK			0x02
>  #define ST_ACCEL_1_MULTIREAD_BIT		true
>  
>  /* CUSTOM VALUES FOR SENSOR 2 */
> @@ -92,6 +94,8 @@
>  #define ST_ACCEL_2_DRDY_IRQ_ADDR		0x22
>  #define ST_ACCEL_2_DRDY_IRQ_INT1_MASK		0x02
>  #define ST_ACCEL_2_DRDY_IRQ_INT2_MASK		0x10
> +#define ST_ACCEL_2_IHL_IRQ_ADDR			0x22
> +#define ST_ACCEL_2_IHL_IRQ_MASK			0x80
>  #define ST_ACCEL_2_MULTIREAD_BIT		true
>  
>  /* CUSTOM VALUES FOR SENSOR 3 */
> @@ -125,6 +129,8 @@
>  #define ST_ACCEL_3_DRDY_IRQ_ADDR		0x23
>  #define ST_ACCEL_3_DRDY_IRQ_INT1_MASK		0x80
>  #define ST_ACCEL_3_DRDY_IRQ_INT2_MASK		0x00
> +#define ST_ACCEL_3_IHL_IRQ_ADDR			0x23
> +#define ST_ACCEL_3_IHL_IRQ_MASK			0x40
>  #define ST_ACCEL_3_IG1_EN_ADDR			0x23
>  #define ST_ACCEL_3_IG1_EN_MASK			0x08
>  #define ST_ACCEL_3_MULTIREAD_BIT		false
> @@ -169,6 +175,8 @@
>  #define ST_ACCEL_5_DRDY_IRQ_ADDR		0x22
>  #define ST_ACCEL_5_DRDY_IRQ_INT1_MASK		0x04
>  #define ST_ACCEL_5_DRDY_IRQ_INT2_MASK		0x20
> +#define ST_ACCEL_5_IHL_IRQ_ADDR			0x22
> +#define ST_ACCEL_5_IHL_IRQ_MASK			0x80
>  #define ST_ACCEL_5_IG1_EN_ADDR			0x21
>  #define ST_ACCEL_5_IG1_EN_MASK			0x08
>  #define ST_ACCEL_5_MULTIREAD_BIT		false
> @@ -291,6 +299,8 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.addr = ST_ACCEL_1_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_ACCEL_1_DRDY_IRQ_INT1_MASK,
>  			.mask_int2 = ST_ACCEL_1_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_ACCEL_1_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_ACCEL_1_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -354,6 +364,8 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.addr = ST_ACCEL_2_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_ACCEL_2_DRDY_IRQ_INT1_MASK,
>  			.mask_int2 = ST_ACCEL_2_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_ACCEL_2_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_ACCEL_2_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -429,6 +441,8 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.addr = ST_ACCEL_3_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_ACCEL_3_DRDY_IRQ_INT1_MASK,
>  			.mask_int2 = ST_ACCEL_3_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_ACCEL_3_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_ACCEL_3_IHL_IRQ_MASK,
>  			.ig1 = {
>  				.en_addr = ST_ACCEL_3_IG1_EN_ADDR,
>  				.en_mask = ST_ACCEL_3_IG1_EN_MASK,
> @@ -536,6 +550,8 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.addr = ST_ACCEL_5_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_ACCEL_5_DRDY_IRQ_INT1_MASK,
>  			.mask_int2 = ST_ACCEL_5_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_ACCEL_5_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_ACCEL_5_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_ACCEL_5_MULTIREAD_BIT,
>  		.bootime = 2, /* guess */
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 25258e2c1a82..ed6f54d5c932 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -17,7 +17,7 @@
>  #include <linux/of.h>
>  #include <asm/unaligned.h>
>  #include <linux/iio/common/st_sensors.h>
> -
> +#include "st_sensors_core.h"
>  
>  #define ST_SENSORS_WAI_ADDRESS		0x0f
>  
> @@ -26,8 +26,8 @@ static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
>  	return (s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8;
>  }
>  
> -static int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
> -						u8 reg_addr, u8 mask, u8 data)
> +int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
> +				    u8 reg_addr, u8 mask, u8 data)
>  {
>  	int err;
>  	u8 new_data;
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.h b/drivers/iio/common/st_sensors/st_sensors_core.h
> new file mode 100644
> index 000000000000..cd88098ff6f1
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.h
> @@ -0,0 +1,8 @@
> +/*
> + * Local functions in the ST Sensors core
> + */
> +#ifndef __ST_SENSORS_CORE_H
> +#define __ST_SENSORS_CORE_H
> +int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
> +				    u8 reg_addr, u8 mask, u8 data);
> +#endif
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 3c0aa17d753f..54115ccdada2 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -14,33 +14,66 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/interrupt.h>
> -
>  #include <linux/iio/common/st_sensors.h>
> -
> +#include "st_sensors_core.h"
>  
>  int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  				const struct iio_trigger_ops *trigger_ops)
>  {
> -	int err;
> +	int err, irq;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	unsigned long irq_trig;
>  
>  	sdata->trig = iio_trigger_alloc("%s-dev%d",
>  					indio_dev->name, indio_dev->id);
>  	if (sdata->trig == NULL) {
> -		err = -ENOMEM;
>  		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
> -		goto iio_trigger_alloc_error;
> +		return -ENOMEM;
>  	}
>  
> -	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
> +	irq = sdata->get_irq_data_ready(indio_dev);
> +	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
> +	/*
> +	 * If the IRQ is triggered on falling edge, we need to mark the
> +	 * interrupt as active low, if the hardware supports this.
> +	 */
> +	if (irq_trig == IRQF_TRIGGER_FALLING) {
> +		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
> +			dev_err(&indio_dev->dev,
> +				"falling edge specified for IRQ but hardware "
> +				"only support rising edge, will request "
> +				"rising edge\n");
> +			irq_trig = IRQF_TRIGGER_RISING;
> +		} else {
> +			/* Set up INT active low i.e. falling edge */
> +			err = st_sensors_write_data_with_mask(indio_dev,
> +				sdata->sensor_settings->drdy_irq.addr_ihl,
> +				sdata->sensor_settings->drdy_irq.mask_ihl, 1);
> +			if (err < 0)
> +				goto iio_trigger_free;
> +			dev_info(&indio_dev->dev,
> +				 "interrupts on the falling edge\n");
> +		}
> +	} else if (irq_trig == IRQF_TRIGGER_RISING) {
> +		dev_info(&indio_dev->dev,
> +			 "interrupts on the rising edge\n");
> +
> +	} else {
> +		dev_err(&indio_dev->dev,
> +			"unsupported IRQ trigger specified (%lx), only "
> +			"rising and falling edges supported, enforce "
> +			"rising edge\n", irq_trig);
> +		irq_trig = IRQF_TRIGGER_RISING;
> +	}
> +	err = request_threaded_irq(irq,
>  			iio_trigger_generic_data_rdy_poll,
>  			NULL,
> -			IRQF_TRIGGER_RISING,
> +			irq_trig,
>  			sdata->trig->name,
>  			sdata->trig);
>  	if (err) {
>  		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
> -		goto request_irq_error;
> +		goto iio_trigger_free;
>  	}
>  
>  	iio_trigger_set_drvdata(sdata->trig, indio_dev);
> @@ -58,9 +91,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  
>  iio_trigger_register_error:
>  	free_irq(sdata->get_irq_data_ready(indio_dev), sdata->trig);
> -request_irq_error:
> +iio_trigger_free:
>  	iio_trigger_free(sdata->trig);
> -iio_trigger_alloc_error:
>  	return err;
>  }
>  EXPORT_SYMBOL(st_sensors_allocate_trigger);
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 02eddcebeea3..110f95b6e52f 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -185,6 +185,11 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_GYRO_1_DRDY_IRQ_ADDR,
>  			.mask_int2 = ST_GYRO_1_DRDY_IRQ_INT2_MASK,
> +			/*
> +			 * The sensor has IHL (active low) and open
> +			 * drain settings, but only for INT1 and not
> +			 * for the DRDY line on INT2.
> +			 */
>  		},
>  		.multi_read_bit = ST_GYRO_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -248,6 +253,11 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_GYRO_2_DRDY_IRQ_ADDR,
>  			.mask_int2 = ST_GYRO_2_DRDY_IRQ_INT2_MASK,
> +			/*
> +			 * The sensor has IHL (active low) and open
> +			 * drain settings, but only for INT1 and not
> +			 * for the DRDY line on INT2.
> +			 */
>  		},
>  		.multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -307,6 +317,11 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_GYRO_3_DRDY_IRQ_ADDR,
>  			.mask_int2 = ST_GYRO_3_DRDY_IRQ_INT2_MASK,
> +			/*
> +			 * The sensor has IHL (active low) and open
> +			 * drain settings, but only for INT1 and not
> +			 * for the DRDY line on INT2.
> +			 */
>  		},
>  		.multi_read_bit = ST_GYRO_3_MULTIREAD_BIT,
>  		.bootime = 2,
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index b27f0146647b..501f858df413 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -175,6 +175,8 @@
>  #define ST_MAGN_3_BDU_MASK			0x10
>  #define ST_MAGN_3_DRDY_IRQ_ADDR			0x62
>  #define ST_MAGN_3_DRDY_INT_MASK			0x01
> +#define ST_MAGN_3_IHL_IRQ_ADDR			0x63
> +#define ST_MAGN_3_IHL_IRQ_MASK			0x04
>  #define ST_MAGN_3_FS_AVL_15000_GAIN		1500
>  #define ST_MAGN_3_MULTIREAD_BIT			false
>  #define ST_MAGN_3_OUT_X_L_ADDR			0x68
> @@ -480,6 +482,8 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_MAGN_3_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_MAGN_3_DRDY_INT_MASK,
> +			.addr_ihl = ST_MAGN_3_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_MAGN_3_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_MAGN_3_MULTIREAD_BIT,
>  		.bootime = 2,
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index b39a2fb0671c..172393ad34af 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -62,6 +62,8 @@
>  #define ST_PRESS_LPS331AP_DRDY_IRQ_ADDR		0x22
>  #define ST_PRESS_LPS331AP_DRDY_IRQ_INT1_MASK	0x04
>  #define ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK	0x20
> +#define ST_PRESS_LPS331AP_IHL_IRQ_ADDR		0x22
> +#define ST_PRESS_LPS331AP_IHL_IRQ_MASK		0x80
>  #define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
>  #define ST_PRESS_LPS331AP_TEMP_OFFSET		42500
>  
> @@ -100,6 +102,8 @@
>  #define ST_PRESS_LPS25H_DRDY_IRQ_ADDR		0x23
>  #define ST_PRESS_LPS25H_DRDY_IRQ_INT1_MASK	0x01
>  #define ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK	0x10
> +#define ST_PRESS_LPS25H_IHL_IRQ_ADDR		0x22
> +#define ST_PRESS_LPS25H_IHL_IRQ_MASK		0x80
>  #define ST_PRESS_LPS25H_MULTIREAD_BIT		true
>  #define ST_PRESS_LPS25H_TEMP_OFFSET		42500
>  #define ST_PRESS_LPS25H_OUT_XL_ADDR		0x28
> @@ -220,6 +224,8 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.addr = ST_PRESS_LPS331AP_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_PRESS_LPS331AP_DRDY_IRQ_INT1_MASK,
>  			.mask_int2 = ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_PRESS_LPS331AP_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_PRESS_LPS331AP_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_PRESS_LPS331AP_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -304,6 +310,8 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.addr = ST_PRESS_LPS25H_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_PRESS_LPS25H_DRDY_IRQ_INT1_MASK,
>  			.mask_int2 = ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_PRESS_LPS25H_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_PRESS_LPS25H_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_PRESS_LPS25H_MULTIREAD_BIT,
>  		.bootime = 2,
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 2fe939c73cd2..6670c3d25c58 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -119,6 +119,8 @@ struct st_sensor_bdu {
>   * @addr: address of the register.
>   * @mask_int1: mask to enable/disable IRQ on INT1 pin.
>   * @mask_int2: mask to enable/disable IRQ on INT2 pin.
> + * @addr_ihl: address to enable/disable active low on the INT lines.
> + * @mask_ihl: mask to enable/disable active low on the INT lines.
>   * struct ig1 - represents the Interrupt Generator 1 of sensors.
>   * @en_addr: address of the enable ig1 register.
>   * @en_mask: mask to write the on/off value for enable.
> @@ -127,6 +129,8 @@ struct st_sensor_data_ready_irq {
>  	u8 addr;
>  	u8 mask_int1;
>  	u8 mask_int2;
> +	u8 addr_ihl;
> +	u8 mask_ihl;
>  	struct {
>  		u8 en_addr;
>  		u8 en_mask;
> 

