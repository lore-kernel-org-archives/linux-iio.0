Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32771 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbcDWVcV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2016 17:32:21 -0400
Subject: Re: [PATCH] iio: inv_mpu6050: Add support for auxiliary I2C master
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <5b1937140558514b3e43ed2c21ee860ecbac61ec.1461172603.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Peter Rosin <peda@axentia.se>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a978ad85-8191-7506-8090-809f89d0b2e2@kernel.org>
Date: Sat, 23 Apr 2016 22:32:15 +0100
MIME-Version: 1.0
In-Reply-To: <5b1937140558514b3e43ed2c21ee860ecbac61ec.1461172603.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/04/16 18:17, Crestez Dan Leonard wrote:
> The MPU has an auxiliary I2C bus for connecting external
> sensors. This bus has two operating modes:
> * pass-through, which connects the primary and auxiliary busses
> together. This is already supported via an i2c mux.
> * I2C master mode, where the mpu60x0 acts as a master to any external
> connected sensors. This is implemented by this patch.
> 
> This I2C master mode also works when the MPU itself is connected via
> SPI.
> 
> I2C master supports up to 5 slaves. Slaves 0-3 have a common operating
> mode while slave 4 is different. This patch implements an i2c adapter
> using slave 4 because it has a cleaner interface and it has an
> interrupt that signals when data from slave to master arrived.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
This one needs acks from:

Device tree maintainer (odd binding ;)
Peter Rosin (odd binding interacting with the mux support)
Wolfram (it has a whole i2c master driver in here).

(just thought I'd list these for the avoidance of doubt).

Good feature to have, so hopefully won't prove 'too hard'.

My comments are only really about function naming so far...

Jonathan
> ---
> 
> This is based on earlier work by Daniel Baluta <daniel.baluta@intel.com>:
> https://www.spinics.net/lists/linux-iio/msg23573.html
> 
> Changes since that version:
> * Nest the adapter in inv_mpu6050_state instead of making it static
> * Explicitly forward of_node "i2c-aux-master" to allow describing aux devices
> via devicetree.
> 
> For bypass/mux mode devicetree works automatically. The forwarding is based on
> the "chan_id" parameter to i2c_add_mux_adapter and is implemented here:
> 
> http://lxr.free-electrons.com/source/drivers/i2c/i2c-mux.c#L158
> 
> Perhaps it might be better for devices handled via master mode to be described
> via i2c@1? This would work by scanning the mpu node's children for something
> with reg == 1.
> 
> Or maybe the two busses should be called i2c-aux-master and i2c-aux-mux? Not
> sure how to deal with that on the mux side.
> 
> It is not clear how to properly handle this and suggestions are welcome. The
> way it currently works with this patch is documented immediately below.
> 
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  59 +++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 152 ++++++++++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  41 ++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   8 --
>  4 files changed, 247 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index e4d8f1c..9d842f2 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -1,13 +1,24 @@
>  InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
>  
> -http://www.invensense.com/mems/gyro/mpu6050.html
> -
>  Required properties:
> - - compatible : should be "invensense,mpu6050"
> - - reg : the I2C address of the sensor
> + - compatible : should be "invensense,mpuXXXX"
> + - reg : the I2C or SPI address of the sensor
>   - interrupt-parent : should be the phandle for the interrupt controller
>   - interrupts : interrupt mapping for GPIO IRQ
>  
> +Valid compatible strings:
> + - mpu6000
> + - mpu6050
> + - mpu6500
> + - mpu9150
> +
> +It is possible to attach auxiliary sensors to the MPU and have them be handled
> +by linux. Those auxiliary sensors are describes as an i2c bus.
> +
> +Devices connected in "bypass" mode must be listed behind i2c@0 with the address 0
> +
> +Devices connected in "master" mode must be listed behind i2c-aux-master.
> +
>  Example:
>  	mpu6050@68 {
>  		compatible = "invensense,mpu6050";
> @@ -15,3 +26,43 @@ Example:
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <18 1>;
>  	};
> +
> +Example describing mpu9150 (which includes an ak9875 on chip):
> +	mpu9150@68 {
> +		compatible = "invensense,mpu9150";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <18 1>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ak8975@0c {
> +				compatible = "ak,ak8975";
> +				reg = <0x0c>;
> +			};
> +		};
> +	};
> +
> +Example describing a mpu6500 via SPI with an hmc5883l on auxiliary i2c:
> +	mpu6500@0 {
> +		compatible = "inv,mpu6500";
> +		reg = <0x0>;
> +		spi-max-frequency = <1000000>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <31 1>;
> +
> +		i2c-aux-master {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hmc5883l@1e {
> +				compatible = "honeywell,hmc5883l";
> +				reg = <0x1e>;
> +			};
> +		};
> +	};
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 3a82a49..fb67188 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -25,6 +25,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/i2c-mux.h>
>  #include <linux/acpi.h>
> +#include <linux/completion.h>
> +
>  #include "inv_mpu_iio.h"
>  
>  /*
> @@ -57,6 +59,12 @@ static const struct inv_mpu6050_reg_map reg_set_6500 = {
>  	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
>  	.accl_offset		= INV_MPU6500_REG_ACCEL_OFFSET,
>  	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
> +	.slv4_addr		= INV_MPU6050_REG_I2C_SLV4_ADDR,
> +	.slv4_reg		= INV_MPU6050_REG_I2C_SLV4_REG,
> +	.slv4_do		= INV_MPU6050_REG_I2C_SLV4_DO,
> +	.slv4_ctrl		= INV_MPU6050_REG_I2C_SLV4_CTRL,
> +	.slv4_di		= INV_MPU6050_REG_I2C_SLV4_DI,
> +	.mst_status		= INV_MPU6050_REG_I2C_MST_STATUS,
>  };
>  
>  static const struct inv_mpu6050_reg_map reg_set_6050 = {
> @@ -77,6 +85,12 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
>  	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
>  	.accl_offset		= INV_MPU6050_REG_ACCEL_OFFSET,
>  	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
> +	.slv4_addr		= INV_MPU6050_REG_I2C_SLV4_ADDR,
> +	.slv4_reg		= INV_MPU6050_REG_I2C_SLV4_REG,
> +	.slv4_do		= INV_MPU6050_REG_I2C_SLV4_DO,
> +	.slv4_ctrl		= INV_MPU6050_REG_I2C_SLV4_CTRL,
> +	.slv4_di		= INV_MPU6050_REG_I2C_SLV4_DI,
> +	.mst_status		= INV_MPU6050_REG_I2C_MST_STATUS,
>  };
>  
>  static const struct inv_mpu6050_chip_config chip_config_6050 = {
> @@ -786,6 +800,109 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	return 0;
>  }
>  
> +static irqreturn_t inv_mpu_datardy_irq_handler(int irq, void *private)
> +{
> +	struct inv_mpu6050_state *st = (struct inv_mpu6050_state *)private;
> +
> +	/* IRQs can come before triggers are initialized. */
> +	if (st->trig)
> +		iio_trigger_poll(st->trig);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t inv_mpu_datardy_thread_handler(int irq, void *private)
> +{
> +	struct inv_mpu6050_state *st = (struct inv_mpu6050_state *)private;
> +	int ret, val;
> +
> +	ret = regmap_read(st->map, st->reg->mst_status, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val & INV_MPU6050_BIT_I2C_SLV4_DONE)
> +		complete(&st->slv4_done);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 inv_mpu_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA;
> +}
> +
> +static int
> +inv_mpu_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> +		       unsigned short flags, char read_write, u8 command,
> +		       int size, union i2c_smbus_data *data)
> +{
> +	struct inv_mpu6050_state *st = i2c_get_adapdata(adap);
> +
> +	unsigned long time_left;
> +	int ret, val;
> +	u8 ctrl;
> +
> +	ret = inv_mpu6050_set_power_itg(st, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, st->reg->user_ctrl,
> +				 INV_MPU6050_BIT_I2C_MST_EN,
> +				 INV_MPU6050_BIT_I2C_MST_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, st->reg->int_enable,
> +				 INV_MPU6050_BIT_MST_INT_EN,
> +				 INV_MPU6050_BIT_MST_INT_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (read_write == I2C_SMBUS_WRITE)
> +		addr |= INV_MPU6050_BIT_I2C_SLV4_W;
> +	else
> +		addr |= INV_MPU6050_BIT_I2C_SLV4_R;
> +
> +	ret = regmap_write(st->map, st->reg->slv4_addr, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(st->map, st->reg->slv4_reg, command);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (read_write == I2C_SMBUS_WRITE) {
> +		ret = regmap_write(st->map, st->reg->slv4_do, data->byte);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ctrl = INV_MPU6050_BIT_SLV4_EN | INV_MPU6050_BIT_SLV4_INT_EN;
> +	ret = regmap_write(st->map, st->reg->slv4_ctrl, ctrl);
> +	if (ret < 0)
> +		return ret;
> +	if (read_write == I2C_SMBUS_READ) {
> +		time_left = wait_for_completion_timeout(&st->slv4_done, HZ);
> +		if (!time_left)
> +			return -ETIMEDOUT;
> +
> +		ret = regmap_read(st->map, st->reg->slv4_di, &val);
> +		if (ret < 0)
> +			return ret;
> +		data->byte = val;
> +	}
> +
> +	ret = inv_mpu6050_set_power_itg(st, false);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}
> +
> +static const struct i2c_algorithm inv_mpu_i2c_algo = {
> +	.smbus_xfer	=	inv_mpu_i2c_smbus_xfer,
> +	.functionality	=	inv_mpu_i2c_functionality,
> +};
> +
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
>  {
> @@ -848,22 +965,53 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		dev_err(dev, "configure buffer fail %d\n", result);
>  		return result;
>  	}
> +
Unrelated change - a good one, but shouldn't be in this patch really.
>  	result = inv_mpu6050_probe_trigger(indio_dev);
>  	if (result) {
>  		dev_err(dev, "trigger probe fail %d\n", result);
>  		goto out_unreg_ring;
>  	}
>  
> +	/* Request interrupt for trigger and i2c master adapter */
> +	result = devm_request_threaded_irq(&indio_dev->dev, st->irq,
> +					   &inv_mpu_datardy_irq_handler,
> +					   &inv_mpu_datardy_thread_handler,
Really want to rename these functions as well if they are now multi
purpose.
> +					   IRQF_TRIGGER_RISING, "inv_mpu",
> +					   st);
> +	if (result) {
> +		dev_err(dev, "request irq fail %d\n", result);
> +		goto out_remove_trigger;
> +	}
> +
> +	/* Setup i2c adapter for aux devices. */
> +	init_completion(&st->slv4_done);
> +	st->aux_master_adapter.owner = THIS_MODULE;
> +	st->aux_master_adapter.algo = &inv_mpu_i2c_algo;
> +	st->aux_master_adapter.dev.parent = dev;
> +	snprintf(st->aux_master_adapter.name, sizeof(st->aux_master_adapter.name),
> +			"aux-master-%s", indio_dev->name);
> +	st->aux_master_adapter.dev.of_node = of_get_child_by_name(
> +			dev->of_node, "i2c-aux-master");
> +	i2c_set_adapdata(&st->aux_master_adapter, st);
> +	/* This will also probe aux devices so transfers must work now */
> +	result = i2c_add_adapter(&st->aux_master_adapter);
> +	if (result < 0) {
> +		dev_err(dev, "i2x aux master register fail %d\n", result);
> +		goto out_remove_trigger;
> +	}
> +
>  	INIT_KFIFO(st->timestamps);
>  	spin_lock_init(&st->time_stamp_lock);
>  	result = iio_device_register(indio_dev);
>  	if (result) {
>  		dev_err(dev, "IIO register fail %d\n", result);
> -		goto out_remove_trigger;
> +		goto out_del_adapter;
>  	}
>  
>  	return 0;
>  
> +out_del_adapter:
> +	i2c_del_adapter(&st->aux_master_adapter);
>  out_remove_trigger:
>  	inv_mpu6050_remove_trigger(st);
>  out_unreg_ring:
> @@ -875,10 +1023,12 @@ EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
>  int inv_mpu_core_remove(struct device  *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  	inv_mpu6050_remove_trigger(iio_priv(indio_dev));
>  	iio_triggered_buffer_cleanup(indio_dev);
> +	i2c_del_adapter(&st->aux_master_adapter);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 38d6a09..0962437 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -42,6 +42,13 @@
>   *  @int_pin_cfg;	Controls interrupt pin configuration.
>   *  @accl_offset:	Controls the accelerometer calibration offset.
>   *  @gyro_offset:	Controls the gyroscope calibration offset.
> + *  @mst_status:	secondary I2C master interrupt source status
> + *  @slv4_addr:		I2C slave address for slave 4 transaction
> + *  @slv4_reg:		I2C register used with slave 4 transaction
> + *  @slv4_di:		I2C data in register for slave 4 transaction
> + *  @slv4_ctrl:		I2C slave 4 control register
> + *  @slv4_do:		I2C data out register for slave 4 transaction
> +
>   */
>  struct inv_mpu6050_reg_map {
>  	u8 sample_rate_div;
> @@ -61,6 +68,15 @@ struct inv_mpu6050_reg_map {
>  	u8 int_pin_cfg;
>  	u8 accl_offset;
>  	u8 gyro_offset;
> +	u8 mst_status;
> +
> +	/* slave 4 registers */
> +	u8 slv4_addr;
> +	u8 slv4_reg;
> +	u8 slv4_di; /* data in */
> +	u8 slv4_ctrl;
> +	u8 slv4_do; /* data out */
> +
>  };
>  
>  /*device enum */
> @@ -135,6 +151,10 @@ struct inv_mpu6050_state {
>  	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
>  	struct regmap *map;
>  	int irq;
> +
> +	/* I2C adapter for talking to aux sensors in "master" mode */
> +	struct i2c_adapter aux_master_adapter;
> +	struct completion slv4_done;
>  };
>  
>  /*register and associated bit definition*/
> @@ -150,9 +170,30 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BIT_ACCEL_OUT           0x08
>  #define INV_MPU6050_BITS_GYRO_OUT           0x70
>  
> +#define INV_MPU6050_REG_I2C_SLV4_ADDR       0x31
> +#define INV_MPU6050_BIT_I2C_SLV4_R          0x80
> +#define INV_MPU6050_BIT_I2C_SLV4_W          0x00
> +
> +#define INV_MPU6050_REG_I2C_SLV4_REG        0x32
> +#define INV_MPU6050_REG_I2C_SLV4_DO         0x33
> +#define INV_MPU6050_REG_I2C_SLV4_CTRL       0x34
> +
> +#define INV_MPU6050_BIT_SLV4_EN             0x80
> +#define INV_MPU6050_BIT_SLV4_INT_EN         0x40
> +#define INV_MPU6050_BIT_SLV4_DIS            0x20
> +
> +#define INV_MPU6050_REG_I2C_SLV4_DI         0x35
> +
> +#define INV_MPU6050_REG_I2C_MST_STATUS      0x36
> +#define INV_MPU6050_BIT_I2C_SLV4_DONE       0x40
> +
>  #define INV_MPU6050_REG_INT_ENABLE          0x38
>  #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
>  #define INV_MPU6050_BIT_DMP_INT_EN          0x02
> +#define INV_MPU6050_BIT_MST_INT_EN          0x08
> +
> +#define INV_MPU6050_REG_INT_STATUS          0x3A
> +#define INV_MPU6050_BIT_MST_INT             0x08
>  
>  #define INV_MPU6050_REG_RAW_ACCEL           0x3B
>  #define INV_MPU6050_REG_TEMPERATURE         0x41
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index e8818d4..acfa513 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -123,14 +123,6 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  	if (!st->trig)
>  		return -ENOMEM;
>  
> -	ret = devm_request_irq(&indio_dev->dev, st->irq,
> -			       &iio_trigger_generic_data_rdy_poll,
> -			       IRQF_TRIGGER_RISING,
> -			       "inv_mpu",
> -			       st->trig);
> -	if (ret)
> -		return ret;
> -
>  	st->trig->dev.parent = regmap_get_device(st->map);
>  	st->trig->ops = &inv_mpu_trigger_ops;
>  	iio_trigger_set_drvdata(st->trig, indio_dev);
> 

