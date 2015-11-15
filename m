Return-Path: <robh@kernel.org>
Date: Sat, 14 Nov 2015 20:20:21 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 2/2] iio: st_sensors: support open drain mode
Message-ID: <20151115022021.GA28928@rob-hp-laptop>
References: <1447445915-12704-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447445915-12704-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Nov 13, 2015 at 09:18:35PM +0100, Linus Walleij wrote:
> Some types of ST Sensors can be connected to the same IRQ line
> as other peripherals using open drain. Add a device tree binding
> and a sensor data property to flip the right bit in the interrupt
> control register to enable open drain mode on the INT line.
> 
> If the line is set to be open drain, also tag on IRQF_SHARED
> to the IRQ flags when requesting the interrupt, as the whole
> point of using open drain interrupt lines is to share them with
> more than one peripheral (wire-or).
> 
> Cc: devicetree@vger.kernel.org
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt |  3 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/accel/st_accel_core.c                    |  8 ++++++++
>  drivers/iio/common/st_sensors/st_sensors_core.c      | 20 ++++++++++++++++++++
>  drivers/iio/common/st_sensors/st_sensors_trigger.c   |  9 +++++++++
>  drivers/iio/gyro/st_gyro_core.c                      | 12 ++++++++++++
>  drivers/iio/pressure/st_pressure_core.c              |  8 ++++++++
>  include/linux/iio/common/st_sensors.h                |  6 ++++++
>  include/linux/platform_data/st_sensors_pdata.h       |  2 ++
>  8 files changed, 68 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index d3ccdb190c53..4ac20cb2ae8d 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -16,6 +16,9 @@ Optional properties:
>  - st,drdy-int-pin: the pin on the package that will be used to signal
>    "data ready" (valid values: 1 or 2). This property is not configurable
>    on all sensors.
> +- st,int-pin-open-drain: the interrupt/data ready line will be configured
> +  as open drain, which is useful if several sensors share the same
> +  interrupt line.
>  
>  Sensors may also have applicable pin control settings, those use the
>  standard bindings from pinctrl/pinctrl-bindings.txt.
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 1132224cbc10..888682b95693 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -96,6 +96,8 @@
>  #define ST_ACCEL_2_DRDY_IRQ_INT2_MASK		0x10
>  #define ST_ACCEL_2_IHL_IRQ_ADDR			0x22
>  #define ST_ACCEL_2_IHL_IRQ_MASK			0x80
> +#define ST_ACCEL_2_OD_IRQ_ADDR			0x22
> +#define ST_ACCEL_2_OD_IRQ_MASK			0x40
>  #define ST_ACCEL_2_MULTIREAD_BIT		true
>  
>  /* CUSTOM VALUES FOR SENSOR 3 */
> @@ -177,6 +179,8 @@
>  #define ST_ACCEL_5_DRDY_IRQ_INT2_MASK		0x20
>  #define ST_ACCEL_5_IHL_IRQ_ADDR			0x22
>  #define ST_ACCEL_5_IHL_IRQ_MASK			0x80
> +#define ST_ACCEL_5_OD_IRQ_ADDR			0x22
> +#define ST_ACCEL_5_OD_IRQ_MASK			0x40
>  #define ST_ACCEL_5_IG1_EN_ADDR			0x21
>  #define ST_ACCEL_5_IG1_EN_MASK			0x08
>  #define ST_ACCEL_5_MULTIREAD_BIT		false
> @@ -366,6 +370,8 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask_int2 = ST_ACCEL_2_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_ACCEL_2_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_ACCEL_2_IHL_IRQ_MASK,
> +			.addr_od = ST_ACCEL_2_OD_IRQ_ADDR,
> +			.mask_od = ST_ACCEL_2_OD_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -552,6 +558,8 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask_int2 = ST_ACCEL_5_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_ACCEL_5_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_ACCEL_5_IHL_IRQ_MASK,
> +			.addr_od = ST_ACCEL_5_OD_IRQ_ADDR,
> +			.mask_od = ST_ACCEL_5_OD_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_ACCEL_5_MULTIREAD_BIT,
>  		.bootime = 2, /* guess */
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index ed6f54d5c932..bff469dd9583 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -302,6 +302,14 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  	}
>  
> +	if (pdata->open_drain) {
> +		if (!sdata->sensor_settings->drdy_irq.addr_od)
> +			dev_err(&indio_dev->dev,
> +				"open drain requested but unsupported.\n");
> +		else
> +			sdata->int_pin_open_drain = true;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -322,6 +330,8 @@ static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
>  	else
>  		pdata->drdy_int_pin = defdata ? defdata->drdy_int_pin : 0;
>  
> +	pdata->open_drain = of_property_read_bool(np, "st,int-pin-open-drain");
> +
>  	return pdata;
>  }
>  #else
> @@ -375,6 +385,16 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  			return err;
>  	}
>  
> +	if (sdata->int_pin_open_drain) {
> +		dev_info(&indio_dev->dev,
> +			 "set interrupt line to open drain mode\n");
> +		err = st_sensors_write_data_with_mask(indio_dev,
> +				sdata->sensor_settings->drdy_irq.addr_od,
> +				sdata->sensor_settings->drdy_irq.mask_od, 1);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
>  
>  	return err;
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index cb53d14aca94..4283468fd502 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -67,6 +67,15 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  			"rising edge\n", irq_trig);
>  		irq_trig = IRQF_TRIGGER_RISING;
>  	}
> +
> +	/*
> +	 * If the interrupt pin is Open Drain, by definition this
> +	 * means that the interrupt line may be shared with other
> +	 * peripherals.
> +	 */
> +	if (sdata->int_pin_open_drain)
> +		irq_trig |= IRQF_SHARED;
> +
>  	err = request_any_context_irq(irq,
>  			iio_trigger_generic_data_rdy_poll,
>  			irq_trig,
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 260bfe021904..d53622b0e430 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -63,6 +63,8 @@
>  #define ST_GYRO_1_DRDY_IRQ_INT2_MASK		0x08
>  #define ST_GYRO_1_IHL_IRQ_ADDR			0x22
>  #define ST_GYRO_1_IHL_IRQ_MASK			0x20
> +#define ST_GYRO_1_OD_IRQ_ADDR			0x22
> +#define ST_GYRO_1_OD_IRQ_MASK			0x10
>  #define ST_GYRO_1_MULTIREAD_BIT			true
>  
>  /* CUSTOM VALUES FOR SENSOR 2 */
> @@ -89,6 +91,8 @@
>  #define ST_GYRO_2_DRDY_IRQ_INT2_MASK		0x08
>  #define ST_GYRO_2_IHL_IRQ_ADDR			0x22
>  #define ST_GYRO_2_IHL_IRQ_MASK			0x20
> +#define ST_GYRO_2_OD_IRQ_ADDR			0x22
> +#define ST_GYRO_2_OD_IRQ_MASK			0x10
>  #define ST_GYRO_2_MULTIREAD_BIT			true
>  
>  /* CUSTOM VALUES FOR SENSOR 3 */
> @@ -115,6 +119,8 @@
>  #define ST_GYRO_3_DRDY_IRQ_INT2_MASK		0x08
>  #define ST_GYRO_3_IHL_IRQ_ADDR			0x22
>  #define ST_GYRO_3_IHL_IRQ_MASK			0x20
> +#define ST_GYRO_3_OD_IRQ_ADDR			0x22
> +#define ST_GYRO_3_OD_IRQ_MASK			0x10
>  #define ST_GYRO_3_MULTIREAD_BIT			true
>  
>  
> @@ -193,6 +199,8 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  			.mask_int2 = ST_GYRO_1_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_GYRO_1_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_GYRO_1_IHL_IRQ_MASK,
> +			.addr_od = ST_GYRO_1_OD_IRQ_ADDR,
> +			.mask_od = ST_GYRO_1_OD_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_GYRO_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -258,6 +266,8 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  			.mask_int2 = ST_GYRO_2_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_GYRO_2_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_GYRO_2_IHL_IRQ_MASK,
> +			.addr_od = ST_GYRO_2_OD_IRQ_ADDR,
> +			.mask_od = ST_GYRO_2_OD_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -319,6 +329,8 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  			.mask_int2 = ST_GYRO_3_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_GYRO_3_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_GYRO_3_IHL_IRQ_MASK,
> +			.addr_od = ST_GYRO_3_OD_IRQ_ADDR,
> +			.mask_od = ST_GYRO_3_OD_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_GYRO_3_MULTIREAD_BIT,
>  		.bootime = 2,
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 172393ad34af..38186288f79c 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -64,6 +64,8 @@
>  #define ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK	0x20
>  #define ST_PRESS_LPS331AP_IHL_IRQ_ADDR		0x22
>  #define ST_PRESS_LPS331AP_IHL_IRQ_MASK		0x80
> +#define ST_PRESS_LPS331AP_OD_IRQ_ADDR		0x22
> +#define ST_PRESS_LPS331AP_OD_IRQ_MASK		0x40
>  #define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
>  #define ST_PRESS_LPS331AP_TEMP_OFFSET		42500
>  
> @@ -104,6 +106,8 @@
>  #define ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK	0x10
>  #define ST_PRESS_LPS25H_IHL_IRQ_ADDR		0x22
>  #define ST_PRESS_LPS25H_IHL_IRQ_MASK		0x80
> +#define ST_PRESS_LPS25H_OD_IRQ_ADDR		0x22
> +#define ST_PRESS_LPS25H_OD_IRQ_MASK		0x40
>  #define ST_PRESS_LPS25H_MULTIREAD_BIT		true
>  #define ST_PRESS_LPS25H_TEMP_OFFSET		42500
>  #define ST_PRESS_LPS25H_OUT_XL_ADDR		0x28
> @@ -226,6 +230,8 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.mask_int2 = ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_PRESS_LPS331AP_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_PRESS_LPS331AP_IHL_IRQ_MASK,
> +			.addr_od = ST_PRESS_LPS331AP_OD_IRQ_ADDR,
> +			.mask_od = ST_PRESS_LPS331AP_OD_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_PRESS_LPS331AP_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -312,6 +318,8 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.mask_int2 = ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_PRESS_LPS25H_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_PRESS_LPS25H_IHL_IRQ_MASK,
> +			.addr_od = ST_PRESS_LPS25H_OD_IRQ_ADDR,
> +			.mask_od = ST_PRESS_LPS25H_OD_IRQ_MASK,
>  		},
>  		.multi_read_bit = ST_PRESS_LPS25H_MULTIREAD_BIT,
>  		.bootime = 2,
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 6670c3d25c58..8972101224d9 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -121,6 +121,8 @@ struct st_sensor_bdu {
>   * @mask_int2: mask to enable/disable IRQ on INT2 pin.
>   * @addr_ihl: address to enable/disable active low on the INT lines.
>   * @mask_ihl: mask to enable/disable active low on the INT lines.
> + * @addr_od: address to enable/disable Open Drain on the INT lines.
> + * @mask_od: mask to enable/disable Open Drain on the INT lines.
>   * struct ig1 - represents the Interrupt Generator 1 of sensors.
>   * @en_addr: address of the enable ig1 register.
>   * @en_mask: mask to write the on/off value for enable.
> @@ -131,6 +133,8 @@ struct st_sensor_data_ready_irq {
>  	u8 mask_int2;
>  	u8 addr_ihl;
>  	u8 mask_ihl;
> +	u8 addr_od;
> +	u8 mask_od;
>  	struct {
>  		u8 en_addr;
>  		u8 en_mask;
> @@ -212,6 +216,7 @@ struct st_sensor_settings {
>   * @odr: Output data rate of the sensor [Hz].
>   * num_data_channels: Number of data channels used in buffer.
>   * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
> + * @int_pin_open_drain: Set the interrupt/DRDY to open drain.
>   * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
>   * @tf: Transfer function structure used by I/O operations.
>   * @tb: Transfer buffers and mutex used by I/O operations.
> @@ -233,6 +238,7 @@ struct st_sensor_data {
>  	unsigned int num_data_channels;
>  
>  	u8 drdy_int_pin;
> +	bool int_pin_open_drain;
>  
>  	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
>  
> diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
> index 753839187ba0..79b0e4cdb814 100644
> --- a/include/linux/platform_data/st_sensors_pdata.h
> +++ b/include/linux/platform_data/st_sensors_pdata.h
> @@ -16,9 +16,11 @@
>   * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
>   *	Available only for accelerometer and pressure sensors.
>   *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
> + * @open_drain: set the interrupt line to be open drain if possible.
>   */
>  struct st_sensors_platform_data {
>  	u8 drdy_int_pin;
> +	bool open_drain;
>  };
>  
>  #endif /* ST_SENSORS_PDATA_H */
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
