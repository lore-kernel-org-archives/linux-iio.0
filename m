Return-Path: <SRS0=DOt9=HJ=invensense.com=JManeyrol@kernel.org>
Subject: Re: [PATCH v7 1/2] iio:imu: inv_mpu6050: support more interrupt types
To: Martin Kelly <mkelly@xevo.com>, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <20180420165401.13076-1-mkelly@xevo.com>
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Message-ID: <89236b5d-2862-9b65-b921-6174c66453c1@invensense.com>
Date: Fri, 20 Apr 2018 19:04:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180420165401.13076-1-mkelly@xevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 20/04/2018 18:54, Martin Kelly wrote:
> Currently, we support only rising edge interrupts, and in fact we assume
> that the interrupt we're given is rising edge (and things won't work if
> it's not). However, the device supports rising edge, falling edge, level
> low, and level high interrupts.
> 
> Empirically, on my system, switching to level interrupts has fixed a
> problem I had with significant (~40%) interrupt loss with edge
> interrupts. This issue is likely related to the SoC I'm using (Allwinner
> H3), but being able to switch the interrupt type is still a very useful
> workaround.
> 
> I tested this with each interrupt type and verified correct behavior in
> a logic analyzer.
> 
> Add support for these interrupt types while also eliminating the error
> case of the device tree and driver using different interrupt types.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
> ---
> v7:
> - Actually flush the FIFO when we fail to ACK the interrupt, and end the session
>    when we get a spurious interrupt.
> v6:
> - Use -EINVAL if devicetree interrupt configuration is missing.
> - Use u8 for irq_mask.
> - Stop mixing register and bit defines, and group them separately.
> - If we fail to ACK the interrupt, flush the FIFO.
> v5:
> - Check interrupt status in all cases rather than only in the level triggered
>     case, and warn if we get spurious interrupts.
> - Rename INV_MPU6050_LEVEL_TRIGGERED to INV_MPU6050_LATCH_INT_EN to match
>     datasheet naming.
> - Write st->irq_mask prior to device power off to make sure it is fully set.
> - Write st->irq_mask instead of 0 in inv_mpu6050_deselect_bypass.
> - Make irq_type local instead of part of the driver state, as we use it only at
>     probe time and never again.
> - Remove the comment about bus lockups, as I have determined them to be
>     unrelated.
> - Add missing documentation for irq_type and irq_mask.
> v4:
> - Moved the ACK inside the mutex.
> v3:
> - Sent version 2 too quickly. Now that the ACK is moved to the top of the
>     function, the "goto out" logic is unnecessary, so we can clean it up.
> v2:
> - Changed to ACK level interrupts at the start of the bottom half thread instead
>     of at the end of it. Without this, the sample timestamps get distorted because
>     the time to handle the bottom half thread delays future interrupts. With this
>     change, the timestamps appear evenly distributed at the right frequency.
> 
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 33 ++++++++++++++++++++++++++-
>   drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  5 ++--
>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 15 ++++++++++--
>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 15 ++++++++++++
>   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  4 ++--
>   5 files changed, 64 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7d64be353403..c2cec7508451 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -24,6 +24,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/iio/iio.h>
>   #include <linux/acpi.h>
> +#include <linux/platform_device.h>
>   #include "inv_mpu_iio.h"
>   
>   /*
> @@ -52,6 +53,7 @@ static const struct inv_mpu6050_reg_map reg_set_6500 = {
>   	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
>   	.temperature            = INV_MPU6050_REG_TEMPERATURE,
>   	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
> +	.int_status             = INV_MPU6050_REG_INT_STATUS,
>   	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
>   	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
>   	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
> @@ -278,6 +280,10 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>   	if (result)
>   		return result;
>   
> +	result = regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
> +	if (result)
> +		return result;
> +
>   	memcpy(&st->chip_config, hw_info[st->chip_type].config,
>   	       sizeof(struct inv_mpu6050_chip_config));
>   	result = inv_mpu6050_set_power_itg(st, false);
> @@ -882,6 +888,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>   	struct inv_mpu6050_platform_data *pdata;
>   	struct device *dev = regmap_get_device(regmap);
>   	int result;
> +	struct irq_data *desc;
> +	int irq_type;
>   
>   	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>   	if (!indio_dev)
> @@ -913,6 +921,29 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>   		st->plat_data = *pdata;
>   	}
>   
> +	desc = irq_get_irq_data(irq);
> +	if (!desc) {
> +		dev_err(dev, "Could not find IRQ %d\n", irq);
> +		return -EINVAL;
> +	}
> +
> +	irq_type = irqd_get_trigger_type(desc);
> +	if (irq_type == IRQF_TRIGGER_RISING)
> +		st->irq_mask = INV_MPU6050_ACTIVE_HIGH;
> +	else if (irq_type == IRQF_TRIGGER_FALLING)
> +		st->irq_mask = INV_MPU6050_ACTIVE_LOW;
> +	else if (irq_type == IRQF_TRIGGER_HIGH)
> +		st->irq_mask = INV_MPU6050_ACTIVE_HIGH |
> +			INV_MPU6050_LATCH_INT_EN;
> +	else if (irq_type == IRQF_TRIGGER_LOW)
> +		st->irq_mask = INV_MPU6050_ACTIVE_LOW |
> +			INV_MPU6050_LATCH_INT_EN;
> +	else {
> +		dev_err(dev, "Invalid interrupt type 0x%x specified\n",
> +			irq_type);
> +		return -EINVAL;
> +	}
> +
>   	/* power is turned on inside check chip type*/
>   	result = inv_check_and_setup_chip(st);
>   	if (result)
> @@ -948,7 +979,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>   		dev_err(dev, "configure buffer fail %d\n", result);
>   		return result;
>   	}
> -	result = inv_mpu6050_probe_trigger(indio_dev);
> +	result = inv_mpu6050_probe_trigger(indio_dev, irq_type);
>   	if (result) {
>   		dev_err(dev, "trigger probe fail %d\n", result);
>   		goto out_unreg_ring;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index fcd7a92b6cf8..1b02d2b69174 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -44,8 +44,7 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>   	if (!ret) {
>   		st->powerup_count++;
>   		ret = regmap_write(st->map, st->reg->int_pin_cfg,
> -				   INV_MPU6050_INT_PIN_CFG |
> -				   INV_MPU6050_BIT_BYPASS_EN);
> +			   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
>   	}
>   write_error:
>   	mutex_unlock(&st->lock);
> @@ -60,7 +59,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>   
>   	mutex_lock(&st->lock);
>   	/* It doesn't really mattter, if any of the calls fails */
> -	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
> +	regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
>   	st->powerup_count--;
>   	if (!st->powerup_count)
>   		regmap_write(st->map, st->reg->pwr_mgmt_1,
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 065794162d65..eaa9158ac753 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -40,6 +40,7 @@
>    *  @raw_accl:		Address of first accel register.
>    *  @temperature:	temperature register
>    *  @int_enable:	Interrupt enable register.
> + *  @int_status:	Interrupt status register.
>    *  @pwr_mgmt_1:	Controls chip's power state and clock source.
>    *  @pwr_mgmt_2:	Controls power state of individual sensors.
>    *  @int_pin_cfg;	Controls interrupt pin configuration.
> @@ -60,6 +61,7 @@ struct inv_mpu6050_reg_map {
>   	u8 raw_accl;
>   	u8 temperature;
>   	u8 int_enable;
> +	u8 int_status;
>   	u8 pwr_mgmt_1;
>   	u8 pwr_mgmt_2;
>   	u8 int_pin_cfg;
> @@ -125,6 +127,7 @@ struct inv_mpu6050_hw {
>    *  @timestamps:        kfifo queue to store time stamp.
>    *  @map		regmap pointer.
>    *  @irq		interrupt number.
> + *  @irq_mask		the int_pin_cfg mask to configure interrupt type.
>    */
>   struct inv_mpu6050_state {
>   #define TIMESTAMP_FIFO_SIZE 16
> @@ -143,6 +146,7 @@ struct inv_mpu6050_state {
>   	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
>   	struct regmap *map;
>   	int irq;
> +	u8 irq_mask;
>   };
>   
>   /*register and associated bit definition*/
> @@ -166,6 +170,9 @@ struct inv_mpu6050_state {
>   #define INV_MPU6050_REG_TEMPERATURE         0x41
>   #define INV_MPU6050_REG_RAW_GYRO            0x43
>   
> +#define INV_MPU6050_REG_INT_STATUS          0x3A
> +#define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
> +
>   #define INV_MPU6050_REG_USER_CTRL           0x6A
>   #define INV_MPU6050_BIT_FIFO_RST            0x04
>   #define INV_MPU6050_BIT_DMP_RST             0x08
> @@ -215,8 +222,12 @@ struct inv_mpu6050_state {
>   #define INV_MPU6050_OUTPUT_DATA_SIZE         24
>   
>   #define INV_MPU6050_REG_INT_PIN_CFG	0x37
> +#define INV_MPU6050_ACTIVE_HIGH		0x00
> +#define INV_MPU6050_ACTIVE_LOW		0x80
> +/* enable level triggering */
> +#define INV_MPU6050_LATCH_INT_EN	0x20
>   #define INV_MPU6050_BIT_BYPASS_EN	0x2
> -#define INV_MPU6050_INT_PIN_CFG		0
> +
>   
>   /* init parameters */
>   #define INV_MPU6050_INIT_FIFO_RATE           50
> @@ -287,7 +298,7 @@ enum inv_mpu6050_clock_sel_e {
>   
>   irqreturn_t inv_mpu6050_irq_handler(int irq, void *p);
>   irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
> -int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev);
> +int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
>   void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st);
>   int inv_reset_fifo(struct iio_dev *indio_dev);
>   int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index ff81c6aa009d..672c3df2d1d1 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -127,8 +127,23 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>   	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>   	u16 fifo_count;
>   	s64 timestamp;
> +	int int_status;
>   
>   	mutex_lock(&st->lock);
> +
> +	/* ack interrupt and check status */
> +	result = regmap_read(st->map, st->reg->int_status, &int_status);
> +	if (result) {
> +		dev_err(regmap_get_device(st->map),
> +			"failed to ack interrupt\n");
> +		goto flush_fifo;
> +	}
> +	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT)) {
> +		dev_warn(regmap_get_device(st->map),
> +			"spurious interrupt with status 0x%x\n", int_status);
> +		goto end_session;
> +	}
> +
>   	if (!(st->chip_config.accl_fifo_enable |
>   		st->chip_config.gyro_fifo_enable))
>   		goto end_session;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index f963f9fc98c0..b8c5584e4252 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -117,7 +117,7 @@ static const struct iio_trigger_ops inv_mpu_trigger_ops = {
>   	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
>   };
>   
> -int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
> +int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
>   {
>   	int ret;
>   	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> @@ -131,7 +131,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>   
>   	ret = devm_request_irq(&indio_dev->dev, st->irq,
>   			       &iio_trigger_generic_data_rdy_poll,
> -			       IRQF_TRIGGER_RISING,
> +			       irq_type,
>   			       "inv_mpu",
>   			       st->trig);
>   	if (ret)
> 

All OK for me now.

Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
