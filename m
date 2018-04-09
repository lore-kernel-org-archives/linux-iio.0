Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com ([104.47.41.73]:2565
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeDIKOU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Apr 2018 06:14:20 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use devm_* at init and delete
 remove
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio <linux-iio@vger.kernel.org>
References: <CY4PR1201MB0184436AEE0F374831D9BDFFC4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
 <20180408171557.0024ce10@archlinux>
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Message-ID: <c4e92dce-5d59-062a-7da2-9493109fd049@invensense.com>
Date: Mon, 9 Apr 2018 12:14:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180408171557.0024ce10@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

all the patches I sent are in fact independent from each others and 
build on top of testing branch.

I will rework the remaining ones in a series if it is simpler. I am now 
trying Thunderbird for emailing, I hope this is working better.

Thanks.
JB

On 08/04/2018 18:15, Jonathan Cameron wrote:
> On Fri, 6 Apr 2018 08:05:07 +0000
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
> 
>> Use devm_* for iio_triggered_buffer_setup, iio_device_register,
>> iio_trigger_register. Delete unneeded inv_mpu6050_remove_trigger,
>> inv_mpu_core_remove, and inv_mpu_remove for spi driver.
>>
>> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>> ---
> This patch looks fine, but when you send multiple patches applying
> to a given driver, please indicate the order in which they should be
> applied.
> 
> There are 3 options for this.
> 1. Put the patches all in one series, ordering obvious.
> 2. List all expected ordering in each patch.
> 3. Only send me on 'set' at a time (break into short series) so I'm
> not guessing...
> 
> 
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 32 ++++++---------------------
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 12 ++++------
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 --
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  6 -----
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  7 +-----
>>   5 files changed, 12 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> index 7d64be3..c0a075d 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> @@ -940,10 +940,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>>   	indio_dev->info = &mpu_info;
>>   	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
>>   
>> -	result = iio_triggered_buffer_setup(indio_dev,
>> -					    inv_mpu6050_irq_handler,
>> -					    inv_mpu6050_read_fifo,
>> -					    NULL);
>> +	result = devm_iio_triggered_buffer_setup(dev, indio_dev,
>> +						 inv_mpu6050_irq_handler,
>> +						 inv_mpu6050_read_fifo,
>> +						 NULL);
>>   	if (result) {
>>   		dev_err(dev, "configure buffer fail %d\n", result);
>>   		return result;
>> @@ -951,39 +951,21 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>>   	result = inv_mpu6050_probe_trigger(indio_dev);
>>   	if (result) {
>>   		dev_err(dev, "trigger probe fail %d\n", result);
>> -		goto out_unreg_ring;
>> +		return result;
>>   	}
>>   
>>   	INIT_KFIFO(st->timestamps);
>>   	spin_lock_init(&st->time_stamp_lock);
>> -	result = iio_device_register(indio_dev);
>> +	result = devm_iio_device_register(dev, indio_dev);
>>   	if (result) {
>>   		dev_err(dev, "IIO register fail %d\n", result);
>> -		goto out_remove_trigger;
>> +		return result;
>>   	}
>>   
>>   	return 0;
>> -
>> -out_remove_trigger:
>> -	inv_mpu6050_remove_trigger(st);
>> -out_unreg_ring:
>> -	iio_triggered_buffer_cleanup(indio_dev);
>> -	return result;
>>   }
>>   EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
>>   
>> -int inv_mpu_core_remove(struct device  *dev)
>> -{
>> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> -
>> -	iio_device_unregister(indio_dev);
>> -	inv_mpu6050_remove_trigger(iio_priv(indio_dev));
>> -	iio_triggered_buffer_cleanup(indio_dev);
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL_GPL(inv_mpu_core_remove);
>> -
>>   #ifdef CONFIG_PM_SLEEP
>>   
>>   static int inv_mpu_resume(struct device *dev)
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> index fcd7a92..c9ed082 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> @@ -137,14 +137,12 @@ static int inv_mpu_probe(struct i2c_client *client,
>>   				 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
>>   				 inv_mpu6050_select_bypass,
>>   				 inv_mpu6050_deselect_bypass);
>> -	if (!st->muxc) {
>> -		result = -ENOMEM;
>> -		goto out_unreg_device;
>> -	}
>> +	if (!st->muxc)
>> +		return -ENOMEM;
>>   	st->muxc->priv = dev_get_drvdata(&client->dev);
>>   	result = i2c_mux_add_adapter(st->muxc, 0, 0, 0);
>>   	if (result)
>> -		goto out_unreg_device;
>> +		return result;
>>   
>>   	result = inv_mpu_acpi_create_mux_client(client);
>>   	if (result)
>> @@ -154,8 +152,6 @@ static int inv_mpu_probe(struct i2c_client *client,
>>   
>>   out_del_mux:
>>   	i2c_mux_del_adapters(st->muxc);
>> -out_unreg_device:
>> -	inv_mpu_core_remove(&client->dev);
>>   	return result;
>>   }
>>   
>> @@ -167,7 +163,7 @@ static int inv_mpu_remove(struct i2c_client *client)
>>   	inv_mpu_acpi_delete_mux_client(client);
>>   	i2c_mux_del_adapters(st->muxc);
>>   
>> -	return inv_mpu_core_remove(&client->dev);
>> +	return 0;
>>   }
>>   
>>   /*
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>> index c3d6225..f680d00 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>> @@ -288,7 +288,6 @@ enum inv_mpu6050_clock_sel_e {
>>   irqreturn_t inv_mpu6050_irq_handler(int irq, void *p);
>>   irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
>>   int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev);
>> -void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st);
>>   int inv_reset_fifo(struct iio_dev *indio_dev);
>>   int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask);
>>   int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
>> @@ -297,5 +296,4 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
>>   void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
>>   int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>>   		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
>> -int inv_mpu_core_remove(struct device *dev);
>>   extern const struct dev_pm_ops inv_mpu_pmops;
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>> index 74506e5..93fdd17 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>> @@ -69,11 +69,6 @@ static int inv_mpu_probe(struct spi_device *spi)
>>   				  inv_mpu_i2c_disable, chip_type);
>>   }
>>   
>> -static int inv_mpu_remove(struct spi_device *spi)
>> -{
>> -	return inv_mpu_core_remove(&spi->dev);
>> -}
>> -
>>   /*
>>    * device id table is used to identify what device can be
>>    * supported by this driver
>> @@ -97,7 +92,6 @@ MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
>>   
>>   static struct spi_driver inv_mpu_driver = {
>>   	.probe		=	inv_mpu_probe,
>> -	.remove		=	inv_mpu_remove,
>>   	.id_table	=	inv_mpu_id,
>>   	.driver = {
>>   		.acpi_match_table = ACPI_PTR(inv_acpi_match),
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> index f963f9f..2ec1215 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> @@ -141,7 +141,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>>   	st->trig->ops = &inv_mpu_trigger_ops;
>>   	iio_trigger_set_drvdata(st->trig, indio_dev);
>>   
>> -	ret = iio_trigger_register(st->trig);
>> +	ret = devm_iio_trigger_register(&indio_dev->dev, st->trig);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -149,8 +149,3 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>>   
>>   	return 0;
>>   }
>> -
>> -void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
>> -{
>> -	iio_trigger_unregister(st->trig);
>> -}
> 
