Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45811 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbbKOKbz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 05:31:55 -0500
Subject: Re: [PATCH 1/2] iio: st_sensors: support active-low interrupts
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1447445896-12655-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56485F18.7000608@kernel.org>
Date: Sun, 15 Nov 2015 10:31:52 +0000
MIME-Version: 1.0
In-Reply-To: <1447445896-12655-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/11/15 20:18, Linus Walleij wrote:
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
Looks good to me.  Ideally would like an ack from Denis and
feedback from Giuseppe on the LSM303AGR.  Also I guess
the lis2dh12 is probably the same as similar parts
but best to check as that got added yesterday.
> ---
> This patch requires the previously sent patch to switch the
> driver to request_any_context_irq().
Really requires or will create some fuzz without it?  Looks like
the latter so if we end up discussing that one for a while
I might reorder.  Mind you early in this cycle anyway so
no rush on this one!

Jonathan

p.s. If anyone fancies adding support for the venerable 
lis3l02dq as well so we can kill off my ancient driver
in staging that would be great! (I know I should do it
myself probably but I can always hope someone else will
get there first ;)


> 
> I am missing a data sheet for the LSM303AGR sensor that Giuseppe
> added recently, so I have no idea what bits to poke to get active
> low IRQs (or open drain) on that sensor.
> ---
>  drivers/iio/accel/st_accel_core.c                  | 16 ++++++++
>  drivers/iio/common/st_sensors/st_sensors_core.c    |  6 +--
>  drivers/iio/common/st_sensors/st_sensors_core.h    |  8 ++++
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 44 ++++++++++++++++++++--
>  drivers/iio/gyro/st_gyro_core.c                    | 12 ++++++
>  drivers/iio/pressure/st_pressure_core.c            |  8 ++++
>  include/linux/iio/common/st_sensors.h              |  4 ++
>  7 files changed, 91 insertions(+), 7 deletions(-)
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
> index e33796cdd607..cb53d14aca94 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -14,15 +14,16 @@
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
>  	int err;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	unsigned long irq_trig;
> +	int irq;
>  
>  	sdata->trig = iio_trigger_alloc("%s-dev%d",
>  					indio_dev->name, indio_dev->id);
> @@ -32,9 +33,43 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  		goto iio_trigger_alloc_error;
>  	}
>  
> -	err = request_any_context_irq(sdata->get_irq_data_ready(indio_dev),
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
> +				goto iio_trigger_edge_error;
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
> +	err = request_any_context_irq(irq,
>  			iio_trigger_generic_data_rdy_poll,
> -			IRQF_TRIGGER_RISING,
> +			irq_trig,
>  			sdata->trig->name,
>  			sdata->trig);
>  	if (err) {
> @@ -59,6 +94,7 @@ iio_trigger_register_error:
>  	free_irq(sdata->get_irq_data_ready(indio_dev), sdata->trig);
>  request_irq_error:
>  	iio_trigger_free(sdata->trig);
> +iio_trigger_edge_error:
>  iio_trigger_alloc_error:
>  	return err;
>  }
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 02eddcebeea3..260bfe021904 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -61,6 +61,8 @@
>  #define ST_GYRO_1_BDU_MASK			0x80
>  #define ST_GYRO_1_DRDY_IRQ_ADDR			0x22
>  #define ST_GYRO_1_DRDY_IRQ_INT2_MASK		0x08
> +#define ST_GYRO_1_IHL_IRQ_ADDR			0x22
> +#define ST_GYRO_1_IHL_IRQ_MASK			0x20
>  #define ST_GYRO_1_MULTIREAD_BIT			true
>  
>  /* CUSTOM VALUES FOR SENSOR 2 */
> @@ -85,6 +87,8 @@
>  #define ST_GYRO_2_BDU_MASK			0x80
>  #define ST_GYRO_2_DRDY_IRQ_ADDR			0x22
>  #define ST_GYRO_2_DRDY_IRQ_INT2_MASK		0x08
> +#define ST_GYRO_2_IHL_IRQ_ADDR			0x22
> +#define ST_GYRO_2_IHL_IRQ_MASK			0x20
>  #define ST_GYRO_2_MULTIREAD_BIT			true
>  
>  /* CUSTOM VALUES FOR SENSOR 3 */
> @@ -109,6 +113,8 @@
>  #define ST_GYRO_3_BDU_MASK			0x80
>  #define ST_GYRO_3_DRDY_IRQ_ADDR			0x22
>  #define ST_GYRO_3_DRDY_IRQ_INT2_MASK		0x08
> +#define ST_GYRO_3_IHL_IRQ_ADDR			0x22
> +#define ST_GYRO_3_IHL_IRQ_MASK			0x20
>  #define ST_GYRO_3_MULTIREAD_BIT			true
>  
>  
> @@ -185,6 +191,8 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_GYRO_1_DRDY_IRQ_ADDR,
>  			.mask_int2 = ST_GYRO_1_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_GYRO_1_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_GYRO_1_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_GYRO_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -248,6 +256,8 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_GYRO_2_DRDY_IRQ_ADDR,
>  			.mask_int2 = ST_GYRO_2_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_GYRO_2_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_GYRO_2_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -307,6 +317,8 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_GYRO_3_DRDY_IRQ_ADDR,
>  			.mask_int2 = ST_GYRO_3_DRDY_IRQ_INT2_MASK,
> +			.addr_ihl = ST_GYRO_3_IHL_IRQ_ADDR,
> +			.mask_ihl = ST_GYRO_3_IHL_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_GYRO_3_MULTIREAD_BIT,
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

