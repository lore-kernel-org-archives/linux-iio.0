Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48760 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbcEAV0C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:26:02 -0400
Subject: Re: [RFC 5/7] iio: inv_mpu6050: Add support for auxiliary I2C master
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <4aeaced7c1c8e222996df4c1b4b71e505ab256f7.1461953982.git.leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>, Peter Rosin <peda@axentia.se>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <7168c23b-8b82-5e57-42fd-b164bee9fa85@kernel.org>
Date: Sun, 1 May 2016 18:27:39 +0100
MIME-Version: 1.0
In-Reply-To: <4aeaced7c1c8e222996df4c1b4b71e505ab256f7.1461953982.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/16 20:02, Crestez Dan Leonard wrote:
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
Quite a few missing cc's here.  Device tree bindings => device tree list
and maintainers.  Master i2c device => wolfram + linux-i2c.
All these people need to be included in this sort of discussion.

The quirk used to avoid unecessary writes to one of the registers bothers
me in that it's not obviously correct.  Perhaps using a read / write pair
would be nicer?
> ---
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  61 +++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 239 ++++++++++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  46 ++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   8 -
>  4 files changed, 341 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index a9fc11e..aaf12b4 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -1,16 +1,27 @@
>  InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
>  
> -http://www.invensense.com/mems/gyro/mpu6050.html
If this is invalid, please add an up to date link if possible.
> -
>  Required properties:
> - - compatible : should be "invensense,mpu6050"
> - - reg : the I2C address of the sensor
> + - compatible : should be "invensense,mpuXXXX"
List them all explicitly here rather than wild cards.
> + - reg : the I2C or SPI address of the sensor
>   - interrupt-parent : should be the phandle for the interrupt controller
>   - interrupts : interrupt mapping for GPIO IRQ
>  
>  Optional properties:
>   - mount-matrix: an optional 3x3 mounting rotation matrix
> + - inv,i2c-aux-master: operate aux i2c in "master mode" (default is mux).
> +
> +Valid compatible strings:
Vendor prefix? These will work for historical reasons, but now vendor
prefix should definitely be there as well.
> + - mpu6000
> + - mpu6050
> + - mpu6500
> + - mpu9150
> +
> +It is possible to attach auxiliary sensors to the MPU and have them be handled
> +by linux. Those auxiliary sensors are described as an i2c bus.
> +
> +Devices connected in "bypass" mode must be listed behind i2c@0 with the address 0
>  
> +Devices connected in "master" mode must be listed behind i2c@1 with the address 1
>  
>  Example:
>  	mpu6050@68 {
> @@ -28,3 +39,45 @@ Example:
>  		               "0",                   /* y2 */
>  		               "0.984807753012208";   /* z2 */
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
> +		inv,i2c-aux-master
> +		i2c@1 {
> +			reg = <1>;
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
> index 5918c23..064fc07 100644
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
> @@ -130,6 +144,10 @@ static bool inv_mpu6050_volatile_reg(struct device *dev, unsigned int reg)
>  	case INV_MPU6050_REG_FIFO_COUNT_H:
>  	case INV_MPU6050_REG_FIFO_COUNT_H + 1:
>  	case INV_MPU6050_REG_FIFO_R_W:
> +	case INV_MPU6050_REG_I2C_MST_STATUS:
> +	case INV_MPU6050_REG_INT_STATUS:
> +	case INV_MPU6050_REG_I2C_SLV4_CTRL:
> +	case INV_MPU6050_REG_I2C_SLV4_DI:
>  		return true;
>  	default:
>  		return false;
> @@ -140,6 +158,8 @@ static bool inv_mpu6050_precious_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case INV_MPU6050_REG_FIFO_R_W:
> +	case INV_MPU6050_REG_I2C_MST_STATUS:
> +	case INV_MPU6050_REG_INT_STATUS:
>  		return true;
>  	default:
>  		return false;
> @@ -852,6 +872,196 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	return 0;
>  }
>  
> +static irqreturn_t inv_mpu_irq_handler(int irq, void *private)
> +{
> +	struct inv_mpu6050_state *st = (struct inv_mpu6050_state *)private;
> +
> +	iio_trigger_poll(st->trig);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t inv_mpu_irq_thread_handler(int irq, void *private)
> +{
> +	struct inv_mpu6050_state *st = (struct inv_mpu6050_state *)private;
> +	int ret, val;
> +
> +	ret = regmap_read(st->map, st->reg->mst_status, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +#ifdef CONFIG_I2C
> +	if (val & INV_MPU6050_BIT_I2C_SLV4_DONE)
> +		complete(&st->slv4_done);
> +#endif
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_I2C
> +static u32 inv_mpu_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_SMBUS_BYTE_DATA;
> +}
> +
> +static int
> +inv_mpu_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> +		       unsigned short flags, char read_write, u8 command,
> +		       int size, union i2c_smbus_data *data)
> +{
> +	struct inv_mpu6050_state *st = i2c_get_adapdata(adap);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +
> +	unsigned long time_left;
> +	int result, val;
> +	u8 ctrl;
> +
> +	/*
> +	 * The i2c adapter we implement is extremely limited.
> +	 * Check for callers that don't check functionality bits.
> +	 *
> +	 * If we don't check we might succesfully return incorrect data.
> +	 */
> +	if (size != I2C_SMBUS_BYTE_DATA) {
> +		dev_err(&adap->dev, "unsupported xfer rw=%d size=%d\n",
> +			read_write, size);
> +		dump_stack();
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&indio_dev->mlock);
> +	result = inv_mpu6050_set_power_itg(st, true);
> +	mutex_unlock(&indio_dev->mlock);
> +	if (result < 0)
> +		return result;
> +
> +	if (read_write == I2C_SMBUS_WRITE)
> +		addr |= INV_MPU6050_BIT_I2C_SLV4_W;
> +	else
> +		addr |= INV_MPU6050_BIT_I2C_SLV4_R;
> +
> +	/*
> +	 * Regmap will never ignore writes but it will ignore full-register
> +	 * updates to the same value.
Hmm. I'd missed this distinction.  Feels decidely 'interesting'... and makes
my earlier suggestion invalid as I guess the fields stuff uses update bits
internally.

> +	 *
> +	 * This avoids having to touch slv4_addr when doing consecutive
> +	 * reads/writes with the same device.
> +	 */
> +	result = regmap_update_bits(st->map, st->reg->slv4_addr, 0xff, addr);
> +	if (result < 0)
> +		return result;
> +
> +	result = regmap_write(st->map, st->reg->slv4_reg, command);
> +	if (result < 0)
> +		return result;
> +
> +	if (read_write == I2C_SMBUS_WRITE) {
> +		result = regmap_write(st->map, st->reg->slv4_do, data->byte);
> +		if (result < 0)
> +			return result;
> +	}
> +
> +	ctrl = INV_MPU6050_BIT_SLV4_EN | INV_MPU6050_BIT_SLV4_INT_EN;
> +	result = regmap_write(st->map, st->reg->slv4_ctrl, ctrl);
> +	if (result < 0)
> +		return result;
> +
> +	/* Wait for completion for both reads and writes */
> +	time_left = wait_for_completion_timeout(&st->slv4_done, HZ);
> +	if (!time_left)
> +		return -ETIMEDOUT;
> +
> +	if (read_write == I2C_SMBUS_READ) {
> +		result = regmap_read(st->map, st->reg->slv4_di, &val);
> +		if (result < 0)
> +			return result;
> +		data->byte = val;
> +	}
> +
> +	mutex_lock(&indio_dev->mlock);
> +	result = inv_mpu6050_set_power_itg(st, false);
> +	mutex_unlock(&indio_dev->mlock);
> +	if (result < 0)
> +		return result;
> +	return 0;
> +}
> +
> +static const struct i2c_algorithm inv_mpu_i2c_algo = {
> +	.smbus_xfer	=	inv_mpu_i2c_smbus_xfer,
> +	.functionality	=	inv_mpu_i2c_functionality,
> +};
> +
> +static struct device_node *inv_mpu_get_aux_i2c_ofnode(struct device_node *parent)
> +{
> +	struct device_node *child;
> +	int result;
> +	u32 reg;
> +
> +	if (!parent)
> +		return NULL;
> +	for_each_child_of_node(parent, child) {
> +		result = of_property_read_u32(child, "reg", &reg);
> +		if (result)
> +			continue;
> +		if (reg == 1 && !strcmp(child->name, "i2c"))
> +			return child;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int inv_mpu_probe_aux_master(struct iio_dev* indio_dev)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	int result;
> +
> +	/* First check i2c-aux-master property */
> +	st->i2c_aux_master_mode = of_property_read_bool(dev->of_node,
> +							"inv,i2c-aux-master");
> +	if (!st->i2c_aux_master_mode)
> +		return 0;
> +	dev_info(dev, "Configuring aux i2c in master mode\n");
> +
> +	result = inv_mpu6050_set_power_itg(st, true);
> +	if (result < 0)
> +		return result;
> +
> +	/* enable master */
> +	st->chip_config.user_ctrl |= INV_MPU6050_BIT_I2C_MST_EN;
> +	result = regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
> +	if (result < 0)
> +		return result;
> +
> +	result = regmap_update_bits(st->map, st->reg->int_enable,
> +				 INV_MPU6050_BIT_MST_INT_EN,
> +				 INV_MPU6050_BIT_MST_INT_EN);
> +	if (result < 0)
> +		return result;
> +
> +	result = inv_mpu6050_set_power_itg(st, false);
> +	if (result < 0)
> +		return result;
> +
> +	init_completion(&st->slv4_done);
> +	st->aux_master_adapter.owner = THIS_MODULE;
> +	st->aux_master_adapter.algo = &inv_mpu_i2c_algo;
> +	st->aux_master_adapter.dev.parent = dev;
> +	snprintf(st->aux_master_adapter.name, sizeof(st->aux_master_adapter.name),
> +			"aux-master-%s", indio_dev->name);
> +	st->aux_master_adapter.dev.of_node = inv_mpu_get_aux_i2c_ofnode(dev->of_node);
> +	i2c_set_adapdata(&st->aux_master_adapter, st);
> +	/* This will also probe aux devices so transfers must work now */
> +	result = i2c_add_adapter(&st->aux_master_adapter);
> +	if (result < 0) {
> +		dev_err(dev, "i2x aux master register fail %d\n", result);
> +		return result;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
>  {
> @@ -931,16 +1141,39 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		goto out_unreg_ring;
>  	}
>  
> +	/* Request interrupt for trigger and i2c master adapter */
> +	result = devm_request_threaded_irq(&indio_dev->dev, st->irq,
> +					   &inv_mpu_irq_handler,
> +					   &inv_mpu_irq_thread_handler,
> +					   IRQF_TRIGGER_RISING, "inv_mpu",
> +					   st);
> +	if (result) {
> +		dev_err(dev, "request irq fail %d\n", result);
> +		goto out_remove_trigger;
> +	}
> +
> +#ifdef CONFIG_I2C
> +	result = inv_mpu_probe_aux_master(indio_dev);
> +	if (result < 0) {
> +		dev_err(dev, "i2c aux master probe fail %d\n", result);
> +		goto out_remove_trigger;
> +	}
> +#endif
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
> +#ifdef CONFIG_I2C
> +	i2c_del_adapter(&st->aux_master_adapter);
> +#endif
>  out_remove_trigger:
>  	inv_mpu6050_remove_trigger(st);
>  out_unreg_ring:
> @@ -952,10 +1185,14 @@ EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
>  int inv_mpu_core_remove(struct device  *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  	inv_mpu6050_remove_trigger(iio_priv(indio_dev));
>  	iio_triggered_buffer_cleanup(indio_dev);
> +#ifdef CONFIG_I2C
> +	i2c_del_adapter(&st->aux_master_adapter);
> +#endif
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index bd2c0fd..9d15633 100644
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
> @@ -139,6 +155,15 @@ struct inv_mpu6050_state {
>  	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
>  	struct regmap *map;
>  	int irq;
> +
> +	/* if the MPU connects to aux devices as a master */
> +	bool i2c_aux_master_mode;
> +
> +#ifdef CONFIG_I2C
> +	/* I2C adapter for talking to aux sensors in "master" mode */
> +	struct i2c_adapter aux_master_adapter;
> +	struct completion slv4_done;
> +#endif
>  };
>  
>  /*register and associated bit definition*/
> @@ -154,9 +179,30 @@ struct inv_mpu6050_state {
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
> index fc55923..a334ed9 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -126,14 +126,6 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
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

