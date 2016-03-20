Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56803 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897AbcCTKrv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 06:47:51 -0400
Subject: Re: [PATCH 3/3] iio: imu: mpu6050: Add support for auxiliary I2C
 master
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
 <1458232366-12773-4-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	matt.ranostay@intel.com, lucas.demarchi@intel.com, cmo@melexis.com,
	linux-iio@vger.kernel.org, ggao@invensense.com,
	srinivas.pandruvada@linux.intel.com, adi.reus@gmail.com,
	Wolfram Sang <wsa@the-dreams.de>,
	Linux I2C <linux-i2c@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56EE7FD3.7050803@kernel.org>
Date: Sun, 20 Mar 2016 10:47:47 +0000
MIME-Version: 1.0
In-Reply-To: <1458232366-12773-4-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/16 16:32, Daniel Baluta wrote:
> The MPU-60X0 [1] has an auxiliary I2C bus for connecting external
> sensors. This bus has two operating modes:
> 	* pass-through, which connects the primary and auxiliary busses
> 	together [already implemented]
> 	* I2C master mode, where MPU60X0 acts as a master to any
> 	external connected sensors [implemented in this patch]
> 
> I2C master supports up to 5 slaves. Slaves 0-3 have a common operating
> mode while slave 4 is different.
> 
> This patch only adds support for slave 4 because it has a cleaner
> interface and it has an interrupt that signals when data from slave
> to master arrived.
> 
> Registers are described here [2].
> 
> We use threaded handler for reading slave4 done interrupt bit.
> 
> [1]
> https://www.cdiweb.com/datasheets/invensense/MPU-6050_DataSheet_V3%204.pdf
> [2]
> http://www6.in.tum.de/pub/Main/TeachingWs2015SeminarAuonomousFahren/RM-MPU-6000A.pdf
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
hmm. Daniel - this is an i2c driver (be it within an IIO driver) so you need
to cc Wolfram and the i2c list.

I'll be needing an Ack from Wolfram if I am to take this,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 137 ++++++++++++++++++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  38 ++++++++
>  2 files changed, 172 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 659a4be..a89854c 100644
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
> @@ -761,6 +775,114 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	return 0;
>  }
>  
> +static irqreturn_t inv_mpu_datardy_irq_handler(int irq, void *private)
> +{
> +	struct inv_mpu6050_state *st = (struct inv_mpu6050_state *)private;
> +
> +	iio_trigger_poll(st->trig);
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
> +static struct i2c_adapter inv_mpu_i2c_adapter = {
> +	.owner		= THIS_MODULE,
> +	.class		= I2C_CLASS_HWMON,
> +	.algo		= &inv_mpu_i2c_algo,
> +	.name		= "INV MPU secondary I2C",
> +};
> +
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
>  {
> @@ -796,6 +918,13 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return result;
>  	}
>  
> +	init_completion(&st->slv4_done);
> +
> +	result = i2c_add_adapter(&inv_mpu_i2c_adapter);
> +	if (result < 0)
> +		return result;
> +
> +	i2c_set_adapdata(&inv_mpu_i2c_adapter, st);
>  	dev_set_drvdata(dev, indio_dev);
>  	indio_dev->dev.parent = dev;
>  	/* name will be NULL when enumerated via ACPI */
> @@ -823,9 +952,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		goto out_unreg_ring;
>  	}
>  
> -	result = devm_request_irq(&indio_dev->dev, st->irq,
> -				  &iio_trigger_generic_data_rdy_poll,
> -				  IRQF_TRIGGER_RISING, "inv_mpu", st->trig);
> +	result = devm_request_threaded_irq(&indio_dev->dev, st->irq,
> +					   &inv_mpu_datardy_irq_handler,
> +					   &inv_mpu_datardy_thread_handler,
> +					   IRQF_TRIGGER_RISING, "inv_mpu",
> +					   st);
>  	if (result) {
>  		dev_err(dev, "request irq fail %d\n", result);
>  		goto out_remove_trigger;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index e302a49..5c3ea9a 100644
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
> @@ -133,6 +149,7 @@ struct inv_mpu6050_state {
>  	struct inv_mpu6050_platform_data plat_data;
>  	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
>  	struct regmap *map;
> +	struct completion slv4_done;
>  	int irq;
>  };
>  
> @@ -149,9 +166,30 @@ struct inv_mpu6050_state {
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
> 

