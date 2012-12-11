Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <1354923972-10717-1-git-send-email-ggao@invensense.com> <50C70A99.20607@metafoo.de>
In-Reply-To: <50C70A99.20607@metafoo.de>
MIME-Version: 1.0
Date: Tue, 11 Dec 2012 10:35:05 -0800
Message-ID: <f787c82bfa234fff85d4b1e89061b1b6@mail.gmail.com>
Subject: RE: [PATCH] [V5] Invensense MPU6050 Device Driver.
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Dear Lars-Peter,
	Thanks for the comments. I will modify the code according the
comments. But before that, I have some questions about the comments.
1. About power management: My previous design goal is that once master
enable is on, which is the buffer/enable under iio:deviceX/ directory, no
parameters should change. The parameter change should only happen when
enable is zero. The parameters include scale, sampling rate and there
could be more if secondary I2C slave or DMP is added. This would simplify
the design and avoid racing problems. However, writing into the scale and
sampling rate register would need the power to be on.
2. For the inv_mpu_misc.c file: I think this file is pretty big and is not
very useful in normal operations. It is only used when the program
started. It may also contain some more other stuff. If all into the
inv_mpu_core.c, it is too big.
3. For the i2c read and write function: I used to have  inv_i2c_read and
inv_i2c_write functions in my previous submission, but I was told that it
is not immediate clear that this function is actually calling the smbus
version of I2C and was suggested to use the original function. Now you
want this function to be wrapped. Which is the correct way to do that?

Best Regards,

Ge GAO


-----Original Message-----
From: Lars-Peter Clausen [mailto:lars@metafoo.de]
Sent: Tuesday, December 11, 2012 2:28 AM
To: Ge GAO
Cc: jic23@kernel.org; linux-iio@vger.kernel.org
Subject: Re: [PATCH] [V5] Invensense MPU6050 Device Driver.

On 12/08/2012 12:46 AM, Ge GAO wrote:
> From: Ge Gao <ggao@invensense.com>
>
> --This the basic function of Invensense MPU6050 Deivce driver.
> --MPU6050 is a gyro/accel combo device.
> --This does not contain any secondary I2C slave devices.
> --This does not contain DMP functions. DMP is a on-chip engine
>   that can do powerful process of motion gestures such as tap,
>   screen orientation, etc.
>
> Signed-off-by: Ge Gao <ggao@invensense.com>

Hi,

Looks pretty good, but there are a few review comments from last time
which have not been addressed. There is only one major issue left
everything else is basically just minor things or nitpicking.

The major issue is how the driver deals with power management. You have a
sysfs attribute which allows to enable or disable the device. Jonathon is
not really a fan of this and I'm neither. So the question is can power
management be managed dynamically? Which means power it up when it is
needed, e.g. sampling is started, power it down if it is not needed
anymore, e.g. sampling is stopped again.

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-mpu6050 |   14 +
>  drivers/iio/Kconfig                             |    2 +-
>  drivers/iio/imu/Kconfig                         |    2 +
>  drivers/iio/imu/Makefile                        |    2 +
>  drivers/iio/imu/inv_mpu6050/Kconfig             |   12 +
>  drivers/iio/imu/inv_mpu6050/Makefile            |   11 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c      |  781
+++++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h       |  394 ++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c      |  244 +++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c      |  346 ++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c   |   77 +++
>  include/linux/iio/imu/mpu.h                     |   33 +
>  12 files changed, 1917 insertions(+), 1 deletions(-)  create mode
> 100644 Documentation/ABI/testing/sysfs-bus-iio-mpu6050
>  create mode 100644 drivers/iio/imu/inv_mpu6050/Kconfig
>  create mode 100644 drivers/iio/imu/inv_mpu6050/Makefile
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>  create mode 100644 include/linux/iio/imu/mpu.h
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
> b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
> new file mode 100644
> index 0000000..6a8a2b4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
> @@ -0,0 +1,14 @@
> +What:           /sys/bus/iio/devices/iio:deviceX/gyro_matrix
> +What:           /sys/bus/iio/devices/iio:deviceX/accel_matrix
> +What:           /sys/bus/iio/devices/iio:deviceX/magn_matrix
> +KernelVersion:  3.4.0

KernelVersion should probably be 3.9

> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		This is mounting matrix for motion sensors. Mounting
matrix
> +		is a 3x3 unitary matrix. A typical mounting matrix would
look like
> +		[0, 1, 0; 1, 0, 0; 0, 0, -1]. Using this information, it
would be
> +		easy to tell the relative positions among sensors as well
as their
> +		positions relative to the board that holds these sensors.
Identity matrix
> +		[1, 0, 0; 0, 1, 0; 0, 0, 1] means sensor chip and device
are perfectly
> +		aligned with each other. All axes are exactly the same.
> +
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig index
> b2f963b..f4692e9 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -36,7 +36,7 @@ config IIO_KFIFO_BUF
>  	  often to read from the buffer.
>
>  config IIO_TRIGGERED_BUFFER
> -	tristate
> +	tristate "helper function to setup triggered buffer"

Hu? What's up with this change?
IIO_TRIGGERED_BUFFER should not be user selectable, a driver which needs
it should select it not depend on it.

>  	select IIO_TRIGGER
>  	select IIO_KFIFO_BUF
>  	help
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig index
> 3d79a40..723563b 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -25,3 +25,5 @@ config IIO_ADIS_LIB_BUFFER
>  	help
>  	  A set of buffer helper functions for the Analog Devices ADIS*
device
>  	  family.
> +
> +source "drivers/iio/imu/inv_mpu6050/Kconfig"
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile index
> cfe5763..1b41584 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -8,3 +8,5 @@ adis_lib-y += adis.o
>  adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_trigger.o
>  adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
>  obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
> +
> +obj-y += inv_mpu6050/
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig
> b/drivers/iio/imu/inv_mpu6050/Kconfig
> new file mode 100644
> index 0000000..62b475e
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -0,0 +1,12 @@
> +#
> +# inv-mpu6050 drivers for Invensense MPU devices and combos #
> +
> +config INV_MPU6050_IIO
> +	tristate "Invensense MPU6050 devices"
> +	depends on I2C && SYSFS && IIO && IIO_KFIFO_BUF &&
> +IIO_TRIGGERED_BUFFER

select IIO_TRIGGERED_BUFFER instead of depends on

> +	help
> +	  This driver supports the Invensense MPU6050 devices.
> +	  It is a gyroscope/accelerometer combo device.
> +	  This driver can be built as a module. The module will be called
> +	  inv-mpu6050.
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile
> b/drivers/iio/imu/inv_mpu6050/Makefile
> new file mode 100644
> index 0000000..5161777
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -0,0 +1,11 @@
> +#
> +# Makefile for Invensense MPU6050 device.
> +#
> +
> +obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
> +
> +inv-mpu6050-objs := inv_mpu_core.o
> +inv-mpu6050-objs += inv_mpu_ring.o
> +inv-mpu6050-objs += inv_mpu_misc.o
> +inv-mpu6050-objs += inv_mpu_trigger.o
> +
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> new file mode 100644
> index 0000000..c2c7e9c
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -0,0 +1,781 @@
[...]
> +int inv_switch_engine(struct inv_mpu_iio_s *st, bool en, u32 mask) {
> +	struct inv_reg_map_s *reg;
> +	u8 data, mgmt_1;
> +	int result;
> +
> +	reg = st->reg;
> +	/* switch clock needs to be careful. Only when gyro is on, can
> +	   clock source be switched to gyro. Otherwise, it must be set to
> +	   internal clock */
> +	if (MPU_BIT_PWR_GYRO_STBY == mask) {
> +		result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->pwr_mgmt_1, 1,
&mgmt_1);
> +		if (result != 1)
> +			return result;
> +
> +		mgmt_1 &= ~MPU_BIT_CLK_MASK;
> +	}
> +
> +	if ((MPU_BIT_PWR_GYRO_STBY == mask) && (!en)) {

Stricktly speaking the extra parenthis are not neccesary and it is rahter
uncommon to see them in kernel code.

> +		/* turning off gyro requires switch to internal clock
first.
> +		   Then turn off gyro engine */
> +		mgmt_1 |= INV_CLK_INTERNAL;
> +		result = i2c_smbus_write_i2c_block_data(st->client,
> +						reg->pwr_mgmt_1, 1,
&mgmt_1);
> +		if (result)
> +			return result;
> +	}
> +
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->pwr_mgmt_2, 1, &data);
> +	if (result != 1)
> +		return result;
> +	if (en)
> +		data &= ~mask;
> +	else
> +		data |= mask;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
> +						reg->pwr_mgmt_2, 1,
&data);
> +	if (result)
> +		return result;
> +
> +	if ((MPU_BIT_PWR_GYRO_STBY == mask) && en) {

strictly speaking the extra parenthesis around the comparison are not
required.

> +		/* only gyro on needs sensor up time */
> +		msleep(SENSOR_UP_TIME);
> +		/* after gyro is on & stable, switch internal clock to PLL
*/
> +		mgmt_1 |= INV_CLK_PLL;
> +		result = i2c_smbus_write_i2c_block_data(st->client,
> +						reg->pwr_mgmt_1, 1,
&mgmt_1);
> +		if (result)
> +			return result;
> +	}
> +
> +	return 0;
> +}
> +
[...]
> +
> +/**
> + *  inv_init_config() - Initialize hardware, disable FIFO.
> + *  @indio_dev:	Device driver instance.
> + *  Initial configuration:
> + *  FSR: +/- 2000DPS
> + *  DLPF: 20Hz
> + *  FIFO rate: 50Hz
> + *  Clock source: Gyro PLL
> + */
> +static int inv_init_config(struct iio_dev *indio_dev) {
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +
> +	if (st->chip_config.is_asleep)
> +		return -EPERM;
> +	reg = st->reg;
> +	result = set_inv_enable(indio_dev, false);
> +	if (result)
> +		return result;
> +
> +	d = (INV_FSR_2000DPS << GYRO_CONFIG_FSR_SHIFT);
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->gyro_config,
> +						1, &d);
> +	if (result)
> +		return result;
> +
> +	d = INV_FILTER_20HZ;
> +	result = i2c_smbus_write_i2c_block_data(st->client, reg->lpf, 1,
&d);
> +	if (result)
> +		return result;
> +
> +	d = ONE_K_HZ / INIT_FIFO_RATE - 1;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
> +						reg->sample_rate_div,
> +						1, &d);
> +	if (result)
> +		return result;
> +	st->irq_dur_ns = INIT_DUR_TIME,
> +
> +	d = (INV_FS_02G << ACCL_CONFIG_FSR_SHIFT);

No need for the extra brackets.

> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->accl_config,
> +						1, &d);
> +	if (result)
> +		return result;
> +
> +	memcpy(&st->chip_config, &chip_config_6050,
> +		sizeof(struct inv_chip_config_s));
> +
> +	return 0;
> +}
> +
> +static int inv_q30_mult(int a, int b) {
> +	long long temp;
> +	int result;
> +	temp = (long long)a * b;
> +	result = (int)(temp >> Q30_MULTI_SHIFT);
> +
> +	return result;
> +}
> +
> +/**
> + *  inv_temperature_show() - Read temperature data directly from
registers.
> + */
> +static int inv_temperature_show(struct inv_mpu_iio_s  *st, int *val)
> +{
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	s16 temp;
> +	u8 data[2];
> +
> +	reg = st->reg;
> +	if (st->chip_config.is_asleep)
> +		return -EPERM;
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       reg->temperature, 2, data);
> +	if (result != 2) {
> +		dev_err(&st->client->adapter->dev, "%s failed %d\n",
__func__,
> +				result);
> +		return -EINVAL;
> +	}
> +	temp = (s16)(be16_to_cpup((s16 *)&data[0]));
> +
> +	*val = MPU6050_TEMP_OFFSET +
> +			inv_q30_mult((int)temp << MPU_TEMP_SHIFT,
> +				     MPU6050_TEMP_SCALE);

It would be better to have scale and offset for the temperature channel
and just return the raw value.

> +
> +	return IIO_VAL_INT;
> +}

> +/**
> + *  mpu_read_raw() - read raw method.
> + */
> +static int mpu_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val,
> +			      int *val2,
> +			      long mask) {
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +
> +	if (st->chip_config.is_asleep)

Sometimes you just check is_asleep sometimes you use inv_check_enable, is
this on purpose? Also can the scale still be queried if the device is
asleep?

> +		return -EINVAL;
> +	switch (mask) {
> +	case 0:
> +		if (!st->chip_config.enable)
> +			return -EPERM;
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			return inv_sensor_show(st, st->reg->raw_gyro,
> +						chan->channel2, val);
> +		case IIO_ACCEL:
> +			return inv_sensor_show(st, st->reg->raw_accl,
> +						chan->channel2, val);
> +		case IIO_TEMP:
> +			return inv_temperature_show(st, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*val = gyro_scale_6050[st->chip_config.fsr];
> +
> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +			*val = accel_scale[st->chip_config.accl_fs];
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

> +
> +/**
> + *  mpu_write_raw() - write raw method.
> + */
> +static int mpu_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask) {
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +	int result;
> +
> +	if (inv_check_enable(st))
> +		return -EPERM;

Can the scale really only be updated if the device is enabled?

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			result = inv_write_fsr(st, val);
> +			break;
> +		case IIO_ACCEL:
> +			result = inv_write_accel_fs(st, val);
> +			break;
> +		default:
> +			result = -EINVAL;
> +			break;
> +		}
> +		return result;
> +	default:
> +		return -EINVAL;
> +	}
> +}
[...]
> +/**
> + *  inv_check_setup_chip() - check and setup chip type.
> + */
> +static int inv_check_and_setup_chip(struct inv_mpu_iio_s *st,
> +		const struct i2c_device_id *id)
> +{
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +
> +	st->chip_type = INV_MPU6050;
> +	st->hw  = &hw_info[st->chip_type];
> +	st->reg = (struct inv_reg_map_s *)&reg_set_6050;

The cast should not be neccessary.

> +	reg     = st->reg;
> +	/* reset to make sure previous state are not there */
> +	d = MPU_BIT_H_RESET;
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->pwr_mgmt_1,
> +						1, &d);
> +	if (result)
> +		return result;
> +	msleep(POWER_UP_TIME);
> +	/* toggle power state */
> +	result = inv_set_power_itg(st, false);
> +	if (result)
> +		return result;
> +	result = inv_set_power_itg(st, true);
> +	if (result)
> +		return result;
> +	/* turn off MEMS engine at start up */
> +	result = inv_switch_engine(st, false, MPU_BIT_PWR_GYRO_STBY);
> +	if (result)
> +		return result;
> +
> +	result = inv_switch_engine(st, false, MPU_BIT_PWR_ACCL_STBY);
> +	if (result)
> +		return result;
> +
> +	result = inv_get_silicon_rev_mpu6050(st);
> +	if (result) {
> +		dev_err(&st->client->adapter->dev, "%s failed %d\n",
__func__,
> +				result);
> +		inv_set_power_itg(st, false);
> +		return result;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_mpu_probe() - probe function.
> + */
> +static int inv_mpu_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct inv_mpu_iio_s *st;
> +	struct iio_dev *indio_dev;
> +	int result;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		result = -ENOSYS;
> +		goto out_no_free;
> +	}
> +	indio_dev = iio_device_alloc(sizeof(*st));
> +	if (indio_dev == NULL) {
> +		result =  -ENOMEM;
> +		goto out_no_free;
> +	}
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +	st->plat_data =
> +		*(struct mpu_platform_data
*)dev_get_platdata(&client->dev);

No cast neccesary.

> +	/* power is turned on inside check chip type*/
> +	result = inv_check_and_setup_chip(st, id);
> +	if (result)
> +		goto out_free;
> +
> +	result = inv_init_config(indio_dev);
> +	if (result) {
> +		dev_err(&client->adapter->dev,

This should be &client->dev, There are a few other similar places where
this comment applies as well.

> +			"Could not initialize device.\n");

It makes sense to also print the error code, same applies to the other
error messages in probe().

> +		goto out_free;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->channels = inv_mpu_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> +
> +	indio_dev->info = &mpu_info;
> +	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
> +
> +	result = inv_mpu_configure_ring(indio_dev);
> +	if (result) {
> +		dev_err(&st->client->adapter->dev, "configure buffer
fail\n");
> +		goto out_free;
> +	}
> +	st->irq = client->irq;
> +	result = inv_mpu_probe_trigger(indio_dev);
> +	if (result) {
> +		dev_err(&st->client->adapter->dev, "trigger probe
fail\n");
> +		goto out_unreg_ring;
> +	}
> +
> +	INIT_KFIFO(st->timestamps);
> +	spin_lock_init(&st->time_stamp_lock);
> +	result = iio_device_register(indio_dev);
> +	if (result) {
> +		dev_err(&st->client->adapter->dev, "IIO register fail\n");
> +		goto out_remove_trigger;
> +	}
> +
> +	return 0;
> +
> +out_remove_trigger:
> +	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)

Will this ever be false? Considering that you set modes to
INDIO_BUFFER_TRIGGERED a few lines above I don't think so.

> +		inv_mpu_remove_trigger(indio_dev);
> +out_unreg_ring:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +out_free:
> +	iio_device_free(indio_dev);
> +out_no_free:
> +	dev_err(&client->adapter->dev, "%s failed %d\n", __func__,
result);

The generic device driver layer will already print a similar message if
probe fails, so this one is kind of redudant and can be removed.

> +
> +	return result;
> +}
> +
> +/**
> + *  inv_mpu_remove() - remove function.
> + */
> +static int inv_mpu_remove(struct i2c_client *client) {
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> +	kfifo_free(&st->timestamps);
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	iio_device_free(indio_dev);
> +
> +	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
> +		inv_mpu_remove_trigger(indio_dev);
> +
> +	return 0;
> +}
[...]
> + */
> +static const struct i2c_device_id inv_mpu_id[] = {
> +	{"mpu6050", INV_MPU6050},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
> +
[...]
> +MODULE_ALIAS("inv-mpu6050");

You don't need MODULE_ALIAS if you have a MODULE_DEVICE_TABLE.
MODULE_DEVICE_TABLE creates a MODULE_ALIAS for each device table entry.

[...]
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c
> new file mode 100644
> index 0000000..99f3dfe
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_misc.c

I wonder why this needs a extra file and can't go into the main file.

> @@ -0,0 +1,244 @@
[...]
> +static int mpu_memory_read(struct inv_mpu_iio_s *st,
> +			   u16 mem_addr, u32 len, u8 *data) {
> +
> +	res = i2c_transfer(st->client->adapter, msgs, 4);

ARRAY_SIZE(msgs)

> +	if (res != 4) {
> +		if (res >= 0)
> +			res = -EIO;
> +		return res;
> +	} else {
> +		return 0;
> +	}
> +}
[...]
> +
> +int inv_get_silicon_rev_mpu6050(struct inv_mpu_iio_s *st) {
> +	int result;
> +	struct inv_reg_map_s *reg;
> +	u8 prod_ver = 0x00, prod_rev = 0x00;
> +	struct prod_rev_map_t *p_rev;
> +	u8 d;
> +	u8 bank = (MPU_BIT_PRFTCH_EN | MPU_BIT_CFG_USER_BANK |
> +					MPU_MEM_OTP_BANK_0);
> +	u16 mem_addr = ((bank << 8) | MEM_ADDR_PROD_REV);
> +	u16 key;
> +	u8 regs[SOFT_PROD_VER_BYTES];
> +	u16 sw_rev;
> +	s16 index;
> +	struct inv_chip_info_s *chip_info = &st->chip_info;

This is a bit ugly, maybe reorder the declarations in christmas tree or
reverse christmas tree order (means sort them by line length).

> +
> +	reg = st->reg;
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +					       MPU_REG_PRODUCT_ID,
> +					       1, &prod_ver);
> +	if (result != 1)
> +		return result;
> +	prod_ver &= 0xf;
> +	/*memory read need more time after power up */

missing space after the /*

[...]
> +}
> +
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> new file mode 100644
> index 0000000..c231e36
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
[...]
> +
> +/**
> + *  reset_fifo() - Reset FIFO related registers.
> + *  @indio_dev:	   Device driver instance.
> + */
> +static int inv_reset_fifo(struct iio_dev *indio_dev) {
> +	struct inv_reg_map_s *reg;
> +	int result;
> +	u8 d;
> +	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
> +
> +	reg = st->reg;
> +	d = 0;
> +	/* disable interrupt */
> +	result = i2c_smbus_write_i2c_block_data(st->client,
reg->int_enable,
> +						1, &d);

Considering how often you need to read or write a single byte it may make
sense to add a helper function for this which wraps
i2c_smbus_write_i2c_block_data and takes the value as a parameter, this
would allow to reduce the code size a bit, which also makes the code
easier to read.

cause you could e.g. write the line above
	result = inv_write_reg(st, reg->int_enable, 0);

> +	if (result) {
> +		dev_err(&st->client->adapter->dev, "int_enable failed\n");
> +		return result;
> +	}
[...]

> +}
> +
> +/**
> + *  set_inv_enable() - enable chip functions.
> + *  @indio_dev:	Device driver instance.
> + *  @enable: enable/disable
> + */
> +int set_inv_enable(struct iio_dev *indio_dev, bool enable) {
[...]
> +	}
> +	st->chip_config.enable = !!enable;

enable is already a bool, so !! is a no-op.

> +
> +	return 0;
> +}
> +

[...]
> +
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> new file mode 100644
> index 0000000..c5ae262
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -0,0 +1,77 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation,
> +and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +*/
> +
> +/**
> + *  @addtogroup  DRIVERS
> + *  @brief       Hardware drivers.
> + *
> + *  @{
> + *      @file    inv_mpu_trigger.c
> + *      @brief   A sysfs device driver for Invensense devices
> + *      @details This file is part of inv mpu iio driver code
> + */

Hm, what kind of comment is that?

[...]
> diff --git a/include/linux/iio/imu/mpu.h b/include/linux/iio/imu/mpu.h
> new file mode 100644 index 0000000..5ef4b91
> --- /dev/null
> +++ b/include/linux/iio/imu/mpu.h

This file should go into include/linux/platform_data/ and mabye it should
get a less generic name. Maybe invensense_mpu.h

> @@ -0,0 +1,33 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +*/
> +
> +#ifndef __MPU_H_
> +#define __MPU_H_
> +
> +#define INV_PROD_KEY(ver, rev) (ver * 100 + rev)

Does this macro need to be in this file? Will it be used by code outside
of
the driver?

> +/**
> + * struct mpu_platform_data - Platform data for the mpu driver
> + * @orientation:	Orientation matrix of the chip
> + *
> + * Contains platform specific information on how to configure the
MPU6050 to
> + * work on this platform.  The orientation matricies are 3x3 rotation
matricies
> + * that are applied to the data to rotate from the mounting orientation
to the
> + * platform orientation.  The values must be one of 0, 1, or -1 and
each row and
> + * column should have exactly 1 non-zero value.
> + */
> +struct mpu_platform_data {
> +	__s8 orientation[9];
> +};
> +
> +#endif	/* __MPU_H_ */
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
