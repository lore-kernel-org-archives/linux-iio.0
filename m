Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:56502 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbaJ0VpM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Oct 2014 17:45:12 -0400
Message-ID: <544EBCDF.1040803@gmx.de>
Date: Mon, 27 Oct 2014 22:45:03 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: inv_mpu6050: Add i2c mux for by pass
References: <1413565901-4951-1-git-send-email-srinivas.pandruvada@linux.intel.com>	 <544D5F50.1060502@gmx.de> <1414380866.2908.10.camel@spandruv-hsb-test>
In-Reply-To: <1414380866.2908.10.camel@spandruv-hsb-test>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Srinivas Pandruvada schrieb am 27.10.2014 04:34:
> On Sun, 2014-10-26 at 21:53 +0100, Hartmut Knaack wrote:
>> Srinivas Pandruvada schrieb am 17.10.2014 19:11:
>>> This chip has a mode in which this chipset can be i2c master. But
>>> the current upstream driver doesn't support such mode as there is
>>> some limited support of clients, which can be connected.
>>>
>>> To attach such clients to main i2c bus chip has to be set up in
>>> bypass mode. Creates an i2c mux, which will enable/disable this mode.
>>> This was discussed for a while in mailing list, this was the decision.
>>>
>>> This change also provides an API, which allows clients to be created for
>>> this mux adapter.
>>>
>> Hi,
>> I found a few things in line, which could be improved.
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> ---
>>>  drivers/iio/imu/inv_mpu6050/Kconfig        |   1 +
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 163 +++++++++++++++++++++++++++--
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   9 ++
>>>  3 files changed, 167 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> index 2d0608b..48fbc0b 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
>>> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> @@ -7,6 +7,7 @@ config INV_MPU6050_IIO
>>>  	depends on I2C && SYSFS
>>>  	select IIO_BUFFER
>>>  	select IIO_TRIGGERED_BUFFER
>>> +	select I2C_MUX
>>>  	help
>>>  	  This driver supports the Invensense MPU6050 devices.
>>>  	  This driver can also support MPU6500 in MPU6050 compatibility mode
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> index b75519d..9864362 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/kfifo.h>
>>>  #include <linux/spinlock.h>
>>>  #include <linux/iio/iio.h>
>>> +#include <linux/i2c-mux.h>
>>>  #include "inv_mpu_iio.h"
>>>  
>>>  /*
>>> @@ -52,6 +53,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
>>>  	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
>>>  	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
>>>  	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
>>> +	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
>>>  };
>>>  
>>>  static const struct inv_mpu6050_chip_config chip_config_6050 = {
>>> @@ -72,11 +74,147 @@ static const struct inv_mpu6050_hw hw_info[INV_NUM_PARTS] = {
>>>  	},
>>>  };
>>>  
>>> +static struct i2c_adapter *inv_mux_adapter;
>>> +
>>>  int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 d)
>>>  {
>>>  	return i2c_smbus_write_i2c_block_data(st->client, reg, 1, &d);
>>>  }
>>>  
>>> +/*
>>> + * The i2c read/write needs to happen in unlocked mode. As the parent
>>> + * adapter is common. If we use locked versions, it will fail as
>>> + * the mux adapter will lock the parent i2c adapter, while calling
>>> + * select/deselect functions.
>>> + */
>>> +static int inv_mpu6050_write_reg_unlocked(struct inv_mpu6050_state *st,
>>> +					  int reg, u8 d)
>> reg should be u8.
>>> +{
>>> +	int ret;
>>> +	u8 buf[2];
>>> +	struct i2c_msg msg[1] = {
>>> +		{
>>> +			.addr = st->client->addr,
>>> +			.flags = 0,
>>> +			.len = sizeof(buf),
>>> +			.buf = buf,
>>> +		}
>>> +	};
>>> +
>>> +	buf[0] = reg;
>>> +	buf[1] = d;
>>> +	ret = __i2c_transfer(st->client->adapter, msg, 1);
>>> +	if (ret != 1)
>>> +		return ret;
>>> +
>>> +	return 0;
>> return (ret != 1) ? ret : 0;
>>> +}
>>> +
>>> +static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void *mux_priv,
>>> +				     u32 chan_id)
>>> +{
>>> +	struct iio_dev *indio_dev = mux_priv;
>>> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>> +	int ret = 0;
>>> +
>>> +	/* Use the same mutex which was used everywhere to protect power-op */
>> Did you mean power-up?
> I meant to say power - operation, which includes power-up and
> power-down.
>>> +	mutex_lock(&indio_dev->mlock);
>>> +	if (!st->powerup_count) {
>>> +		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
>>> +						     0);
>>> +		if (!ret)
>>> +			msleep(INV_MPU6050_REG_UP_TIME);
>> A bit of an uncommon way. It would be more straight-forward (although longer) to do:
>> if (ret)
>> 	goto label_of_mutex_unlock;
>> msleep(...);
>>> +	}
>>> +	if (!ret) {
>>> +		st->powerup_count++;
>>> +		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
>>> +						st->client->irq |
>>> +						INV_MPU6050_BIT_BYPASS_EN);
>> Indentation of these parameters should be improved.
> The usual alignment doesn't work as the last INV_.. goes beyond 80
> chars.
When I tested it, I got 80 chars sharp ;-) Even checkpatch.pl accepted it.
>>> +	}
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
>>> +				       void *mux_priv, u32 chan_id)
>>> +{
>>> +	struct iio_dev *indio_dev = mux_priv;
>>> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>> +
>>> +	mutex_lock(&indio_dev->mlock);
>>> +	/* It doesn't really mattter, if any of the calls fails */
>>> +	inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
>>> +				       st->client->irq);
>>> +	st->powerup_count--;
>>> +	if (!st->powerup_count)
>>> +		inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
>>> +					       INV_MPU6050_BIT_SLEEP);
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int inv_mpu6050_create_mux(struct iio_dev *indio_dev)
>>> +{
>>> +	struct inv_mpu6050_state *mpu_st = iio_priv(indio_dev);
>> Better be consistent with instance names for inv_mpu6050_state.
>>> +	struct i2c_client *client = mpu_st->client;
>>> +
>>> +	mpu_st->mux_adapter = i2c_add_mux_adapter(client->adapter,
>>> +						  &client->dev,
>>> +						  indio_dev,
>>> +						  0, 0, 0,
>>> +						  inv_mpu6050_select_bypass,
>>> +						  inv_mpu6050_deselect_bypass);
>>> +	if (mpu_st->mux_adapter == NULL) {
>>> +		dev_err(&mpu_st->client->dev, "Mux create Failed\n");
>>> +		return -ENODEV;
>>> +	}
>>> +	inv_mux_adapter = mpu_st->mux_adapter;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void inv_mpu6050_destroy_mux(struct iio_dev *indio_dev)
>>> +{
>>> +	struct inv_mpu6050_state *mpu_st = iio_priv(indio_dev);
>>> +
>>> +	if (mpu_st->mux_adapter)
>>> +		i2c_del_mux_adapter(mpu_st->mux_adapter);
>>> +	inv_mux_adapter = NULL;
>>> +}
>>> +
>>> +struct i2c_client *inv_mpu6050_add_mux_client(char *name, int addr,
>> addr could be unsigned short.
> 
>>> +					      int irq, void *plat_data)
>>> +{
>>> +	struct i2c_client *client;
>>> +	struct i2c_board_info info;
>>> +
>>> +	if (!inv_mux_adapter)
>>> +		return NULL;
>>> +
>>> +	memset(&info, 0, sizeof(struct i2c_board_info));
>>> +	strlcpy(info.type, name, sizeof(info.type));
>>> +	info.addr = addr;
>>> +	info.irq = irq;
>>> +	info.platform_data = plat_data;
>>> +	client = i2c_new_device(inv_mux_adapter, &info);
>>> +	if (!client) {
>>> +		dev_err(&inv_mux_adapter->dev,
>>> +			"failed to create mux clint %d\n", addr);
>> Typo: client
>>> +		return NULL;
>>> +	}
>>> +
>>> +	return client;
>>> +}
>>> +EXPORT_SYMBOL_GPL(inv_mpu6050_add_mux_client);
>>> +
>>> +void inv_mpu6050_del_mux_client(struct i2c_client *client)
>>> +{
>>> +	i2c_unregister_device(client);
>>> +}
>>> +EXPORT_SYMBOL_GPL(inv_mpu6050_del_mux_client);
>>> +
>>>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>>>  {
>>>  	u8 d, mgmt_1;
>>> @@ -133,13 +271,22 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>>>  
>>>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>>>  {
>>> -	int result;
>>> +	int result = 0;
>>> +
>>> +	if (power_on) {
>>> +		/* Already under indio-dev->mlock mutex */
>>> +		if (!st->powerup_count)
>>> +			result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
>>> +						       0);
>>> +		if (!result)
>>> +			st->powerup_count++;
>>> +	} else {
>>> +		st->powerup_count--;
>>> +		if (!st->powerup_count)
>>> +			result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
>>> +						       INV_MPU6050_BIT_SLEEP);
>>> +	}
>>>  
>>> -	if (power_on)
>>> -		result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1, 0);
>>> -	else
>>> -		result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
>>> -						INV_MPU6050_BIT_SLEEP);
>>>  	if (result)
>>>  		return result;
>>>  
>>> @@ -673,6 +820,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>>>  
>>>  	st = iio_priv(indio_dev);
>>>  	st->client = client;
>>> +	st->powerup_count = 0;
>>>  	pdata = dev_get_platdata(&client->dev);
>>>  	if (pdata)
>>>  		st->plat_data = *pdata;
>>> @@ -720,6 +868,8 @@ static int inv_mpu_probe(struct i2c_client *client,
>>>  		goto out_remove_trigger;
>>>  	}
>>>  
>>> +	inv_mpu6050_create_mux(indio_dev);
>> Shouldn't that be tested like this?
>> result = inv_mpu6050_create_mux(indio_dev);
>> if (result)
>> 	goto out_device_unregister;
>>> +
> Makes sense. I avoided bailing out because of mux creation for folks who
> didn't connect anything to INVXX i2c bus.
>>>  	return 0;
>>>  
>> out_device_unregister:
>> 	iio_device_unregister(indio_dev);
>>>  out_remove_trigger:
>>> @@ -734,6 +884,7 @@ static int inv_mpu_remove(struct i2c_client *client)
>>>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>>  
>>> +	inv_mpu6050_destroy_mux(indio_dev);
>>>  	iio_device_unregister(indio_dev);
>>>  	inv_mpu6050_remove_trigger(st);
>>>  	iio_triggered_buffer_cleanup(indio_dev);
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> index e779931..90697c6 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> @@ -54,6 +54,7 @@ struct inv_mpu6050_reg_map {
>>>  	u8 int_enable;
>>>  	u8 pwr_mgmt_1;
>>>  	u8 pwr_mgmt_2;
>>> +	u8 int_pin_cfg;
>>>  };
>>>  
>>>  /*device enum */
>>> @@ -119,6 +120,8 @@ struct inv_mpu6050_state {
>>>  	enum   inv_devices chip_type;
>>>  	spinlock_t time_stamp_lock;
>>>  	struct i2c_client *client;
>>> +	struct i2c_adapter *mux_adapter;
>>> +	int powerup_count;
>> unsigned int?
>>>  	struct inv_mpu6050_platform_data plat_data;
>>>  	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
>>>  };
>>> @@ -179,6 +182,9 @@ struct inv_mpu6050_state {
>>>  /* 6 + 6 round up and plus 8 */
>>>  #define INV_MPU6050_OUTPUT_DATA_SIZE         24
>>>  
>>> +#define INV_MPU6050_REG_INT_PIN_CFG	0x37
>>> +#define INV_MPU6050_BIT_BYPASS_EN	0x2
>>> +
>>>  /* init parameters */
>>>  #define INV_MPU6050_INIT_FIFO_RATE           50
>>>  #define INV_MPU6050_TIME_STAMP_TOR           5
>>> @@ -245,3 +251,6 @@ int inv_reset_fifo(struct iio_dev *indio_dev);
>>>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask);
>>>  int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
>>>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>>> +struct i2c_client *inv_mpu6050_add_mux_client(char *name, int adddr,
>> u8 addr? (also typo addr)
>>> +					      int irq, void *plat_data);
>>> +void inv_mpu6050_del_mux_client(struct i2c_client *client);
>>>
>>
> 
> Thanks,
> Srinivas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

