Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49458 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754693AbcIRKg2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:36:28 -0400
Subject: Re: [PATCH 14/15 v2] iio: accel: kxsd9: Deploy system and runtime PM
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
 <1472723089-25113-14-git-send-email-linus.walleij@linaro.org>
 <b0a027fe-93f9-b196-a78c-57abc0269e6f@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c1b225cd-5994-cfae-40de-fc5234b384e5@kernel.org>
Date: Sun, 18 Sep 2016 11:36:26 +0100
MIME-Version: 1.0
In-Reply-To: <b0a027fe-93f9-b196-a78c-57abc0269e6f@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/16 17:48, Jonathan Cameron wrote:
> On 01/09/16 10:44, Linus Walleij wrote:
>> This deploys runtime and system PM in the KXSD9 driver:
>>
>> - Use the force_runtime_suspend/resume callbacks as system PM
>>   operations.
>>
>> - Add buffer prepare/unprepare callbacks to grab the runtime
>>   PM while we're using buffered reads and put get/put_autosuspend
>>   in these.
>>
>> - Insert get/put_autosuspend calls anywhere the IO is used from
>>   the raw read/write callbacks.
>>
>> - Move the fullscale setting to be cached in the state container
>>   so we can restore it properly when coming back from
>>   system/runtime suspend.
>>
>> - Set the autosuspend delay to two orders of magnitude that of
>>   the sensor start-up time (20ms) so we will autosuspend after
>>   2s.
>>
>> - Register the callbacks in both the SPI and I2C subdrivers.
>>
>> Tested with the I2C KXSD9 on the Qualcomm APQ8060 Dragonboard.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Well, it does no harm in the no working power management case ;)
> 
> My board won't even software reboot which shows how far the power
> management related bits got ;)
Applied.
> 
> Jonathan
>> ---
>> ChangeLog v1->v2:
>> - Rebased on the rest of the series.
>> ---
>>  drivers/iio/accel/kxsd9-i2c.c |  1 +
>>  drivers/iio/accel/kxsd9-spi.c |  1 +
>>  drivers/iio/accel/kxsd9.c     | 92 ++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/iio/accel/kxsd9.h     |  2 +
>>  4 files changed, 94 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
>> index 4aaa27d0aa32..95e20855d2ef 100644
>> --- a/drivers/iio/accel/kxsd9-i2c.c
>> +++ b/drivers/iio/accel/kxsd9-i2c.c
>> @@ -55,6 +55,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
>>  	.driver = {
>>  		.name	= "kxsd9",
>>  		.of_match_table = of_match_ptr(kxsd9_of_match),
>> +		.pm = &kxsd9_dev_pm_ops,
>>  	},
>>  	.probe		= kxsd9_i2c_probe,
>>  	.remove		= kxsd9_i2c_remove,
>> diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
>> index c5af51b7dd7e..b7d0078fd00e 100644
>> --- a/drivers/iio/accel/kxsd9-spi.c
>> +++ b/drivers/iio/accel/kxsd9-spi.c
>> @@ -43,6 +43,7 @@ MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
>>  static struct spi_driver kxsd9_spi_driver = {
>>  	.driver = {
>>  		.name = "kxsd9",
>> +		.pm = &kxsd9_dev_pm_ops,
>>  	},
>>  	.probe = kxsd9_spi_probe,
>>  	.remove = kxsd9_spi_remove,
>> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>> index f18cc9436094..a28163b76e12 100644
>> --- a/drivers/iio/accel/kxsd9.c
>> +++ b/drivers/iio/accel/kxsd9.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/delay.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>>  #include <linux/iio/buffer.h>
>> @@ -68,11 +69,13 @@
>>   * @dev: pointer to the parent device
>>   * @map: regmap to the device
>>   * @regs: regulators for this device, VDD and IOVDD
>> + * @scale: the current scaling setting
>>   */
>>  struct kxsd9_state {
>>  	struct device *dev;
>>  	struct regmap *map;
>>  	struct regulator_bulk_data regs[2];
>> +	u8 scale;
>>  };
>>  
>>  #define KXSD9_SCALE_2G "0.011978"
>> @@ -111,6 +114,10 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
>>  				 i);
>>  	if (ret < 0)
>>  		goto error_ret;
>> +
>> +	/* Cached scale when the sensor is powered down */
>> +	st->scale = i;
>> +
>>  error_ret:
>>  	return ret;
>>  }
>> @@ -133,6 +140,9 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
>>  			   long mask)
>>  {
>>  	int ret = -EINVAL;
>> +	struct kxsd9_state *st = iio_priv(indio_dev);
>> +
>> +	pm_runtime_get_sync(st->dev);
>>  
>>  	if (mask == IIO_CHAN_INFO_SCALE) {
>>  		/* Check no integer component */
>> @@ -141,6 +151,9 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
>>  		ret = kxsd9_write_scale(indio_dev, val2);
>>  	}
>>  
>> +	pm_runtime_mark_last_busy(st->dev);
>> +	pm_runtime_put_autosuspend(st->dev);
>> +
>>  	return ret;
>>  }
>>  
>> @@ -154,6 +167,8 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>>  	__be16 raw_val;
>>  	u16 nval;
>>  
>> +	pm_runtime_get_sync(st->dev);
>> +
>>  	switch (mask) {
>>  	case IIO_CHAN_INFO_RAW:
>>  		ret = regmap_bulk_read(st->map, chan->address, &raw_val,
>> @@ -184,6 +199,9 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>>  	}
>>  
>>  error_ret:
>> +	pm_runtime_mark_last_busy(st->dev);
>> +	pm_runtime_put_autosuspend(st->dev);
>> +
>>  	return ret;
>>  };
>>  
>> @@ -214,6 +232,32 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static int kxsd9_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +	struct kxsd9_state *st = iio_priv(indio_dev);
>> +
>> +	pm_runtime_get_sync(st->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
>> +{
>> +	struct kxsd9_state *st = iio_priv(indio_dev);
>> +
>> +	pm_runtime_mark_last_busy(st->dev);
>> +	pm_runtime_put_autosuspend(st->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_buffer_setup_ops kxsd9_buffer_setup_ops = {
>> +	.preenable = kxsd9_buffer_preenable,
>> +	.postenable = iio_triggered_buffer_postenable,
>> +	.predisable = iio_triggered_buffer_predisable,
>> +	.postdisable = kxsd9_buffer_postdisable,
>> +};
>> +
>>  #define KXSD9_ACCEL_CHAN(axis, index)						\
>>  	{								\
>>  		.type = IIO_ACCEL,					\
>> @@ -285,7 +329,7 @@ static int kxsd9_power_up(struct kxsd9_state *st)
>>  			   KXSD9_CTRL_C_LP_1000HZ |
>>  			   KXSD9_CTRL_C_MOT_LEV	|
>>  			   KXSD9_CTRL_C_MOT_LAT |
>> -			   KXSD9_CTRL_C_FS_2G);
>> +			   st->scale);
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -369,13 +413,15 @@ int kxsd9_common_probe(struct device *dev,
>>  		dev_err(dev, "Cannot get regulators\n");
>>  		return ret;
>>  	}
>> +	/* Default scaling */
>> +	st->scale = KXSD9_CTRL_C_FS_2G;
>>  
>>  	kxsd9_power_up(st);
>>  
>>  	ret = iio_triggered_buffer_setup(indio_dev,
>>  					 iio_pollfunc_store_time,
>>  					 kxsd9_trigger_handler,
>> -					 NULL);
>> +					 &kxsd9_buffer_setup_ops);
>>  	if (ret) {
>>  		dev_err(dev, "triggered buffer setup failed\n");
>>  		goto err_power_down;
>> @@ -387,6 +433,19 @@ int kxsd9_common_probe(struct device *dev,
>>  
>>  	dev_set_drvdata(dev, indio_dev);
>>  
>> +	/* Enable runtime PM */
>> +	pm_runtime_get_noresume(dev);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +	/*
>> +	 * Set autosuspend to two orders of magnitude larger than the
>> +	 * start-up time. 20ms start-up time means 2000ms autosuspend,
>> +	 * i.e. 2 seconds.
>> +	 */
>> +	pm_runtime_set_autosuspend_delay(dev, 2000);
>> +	pm_runtime_use_autosuspend(dev);
>> +	pm_runtime_put(dev);
>> +
>>  	return 0;
>>  
>>  err_cleanup_buffer:
>> @@ -405,12 +464,41 @@ int kxsd9_common_remove(struct device *dev)
>>  
>>  	iio_triggered_buffer_cleanup(indio_dev);
>>  	iio_device_unregister(indio_dev);
>> +	pm_runtime_get_sync(dev);
>> +	pm_runtime_put_noidle(dev);
>> +	pm_runtime_disable(dev);
>>  	kxsd9_power_down(st);
>>  
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(kxsd9_common_remove);
>>  
>> +#ifdef CONFIG_PM
>> +static int kxsd9_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct kxsd9_state *st = iio_priv(indio_dev);
>> +
>> +	return kxsd9_power_down(st);
>> +}
>> +
>> +static int kxsd9_runtime_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct kxsd9_state *st = iio_priv(indio_dev);
>> +
>> +	return kxsd9_power_up(st);
>> +}
>> +#endif /* CONFIG_PM */
>> +
>> +const struct dev_pm_ops kxsd9_dev_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +				pm_runtime_force_resume)
>> +	SET_RUNTIME_PM_OPS(kxsd9_runtime_suspend,
>> +			   kxsd9_runtime_resume, NULL)
>> +};
>> +EXPORT_SYMBOL(kxsd9_dev_pm_ops);
>> +
>>  MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
>>  MODULE_DESCRIPTION("Kionix KXSD9 driver");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/accel/kxsd9.h b/drivers/iio/accel/kxsd9.h
>> index 9c0861f6b838..7e8a28168310 100644
>> --- a/drivers/iio/accel/kxsd9.h
>> +++ b/drivers/iio/accel/kxsd9.h
>> @@ -8,3 +8,5 @@ int kxsd9_common_probe(struct device *dev,
>>  		       struct regmap *map,
>>  		       const char *name);
>>  int kxsd9_common_remove(struct device *dev);
>> +
>> +extern const struct dev_pm_ops kxsd9_dev_pm_ops;
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

