Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49454 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755274AbcIRKfg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:35:36 -0400
Subject: Re: [PATCH 12/15 v2] iio: accel: kxsd9: Fetch and handle regulators
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
 <1472723089-25113-12-git-send-email-linus.walleij@linaro.org>
 <9ba2fe58-58b5-0f7b-9268-f98e1e813ef5@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c1a91fdd-9371-730d-3116-e772dbdda163@kernel.org>
Date: Sun, 18 Sep 2016 11:35:34 +0100
MIME-Version: 1.0
In-Reply-To: <9ba2fe58-58b5-0f7b-9268-f98e1e813ef5@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/16 17:43, Jonathan Cameron wrote:
> On 01/09/16 10:44, Linus Walleij wrote:
>> This adds supply regulator handling for the VDD and IOVDD inputs
>> on the KXSD9 component, makes sure to bring the regulators online
>> during probe and disable them on remove or the errorpath.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> I'm lazy and tested this without actually checking the regs were
> either configured correctly in my board file (unlikely ;) or
> actually enabled.  It doesn't break that case :)
Applied.
> 
> Jonathan
>> ---
>> ChangeLog v1->v2:
>> - Rebase on the rest of the series.
>> ---
>>  drivers/iio/accel/kxsd9.c | 88 +++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 85 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>> index 8c6a4559256e..dc53f70e616e 100644
>> --- a/drivers/iio/accel/kxsd9.c
>> +++ b/drivers/iio/accel/kxsd9.c
>> @@ -21,6 +21,8 @@
>>  #include <linux/module.h>
>>  #include <linux/regmap.h>
>>  #include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/regulator/consumer.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>>  #include <linux/iio/buffer.h>
>> @@ -65,10 +67,12 @@
>>   * struct kxsd9_state - device related storage
>>   * @dev: pointer to the parent device
>>   * @map: regmap to the device
>> + * @regs: regulators for this device, VDD and IOVDD
>>   */
>>  struct kxsd9_state {
>>  	struct device *dev;
>>  	struct regmap *map;
>> +	struct regulator_bulk_data regs[2];
>>  };
>>  
>>  #define KXSD9_SCALE_2G "0.011978"
>> @@ -81,6 +85,12 @@ static const int kxsd9_micro_scales[4] = { 47853, 35934, 23927, 11978 };
>>  
>>  #define KXSD9_ZERO_G_OFFSET -2048
>>  
>> +/*
>> + * Regulator names
>> + */
>> +static const char kxsd9_reg_vdd[] = "vdd";
>> +static const char kxsd9_reg_iovdd[] = "iovdd";
>> +
>>  static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
>>  {
>>  	int ret, i;
>> @@ -252,12 +262,69 @@ static int kxsd9_power_up(struct kxsd9_state *st)
>>  {
>>  	int ret;
>>  
>> -	ret = regmap_write(st->map, KXSD9_REG_CTRL_B, 0x40);
>> +	/* Enable the regulators */
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(st->regs), st->regs);
>> +	if (ret) {
>> +		dev_err(st->dev, "Cannot enable regulators\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Power up */
>> +	ret = regmap_write(st->map,
>> +			   KXSD9_REG_CTRL_B,
>> +			   KXSD9_CTRL_B_ENABLE);
>>  	if (ret)
>>  		return ret;
>> -	return regmap_write(st->map, KXSD9_REG_CTRL_C, 0x9b);
>> +
>> +	/*
>> +	 * Set 1000Hz LPF, 2g fullscale, motion wakeup threshold 1g,
>> +	 * latched wakeup
>> +	 */
>> +	ret = regmap_write(st->map,
>> +			   KXSD9_REG_CTRL_C,
>> +			   KXSD9_CTRL_C_LP_1000HZ |
>> +			   KXSD9_CTRL_C_MOT_LEV	|
>> +			   KXSD9_CTRL_C_MOT_LAT |
>> +			   KXSD9_CTRL_C_FS_2G);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Power-up time depends on the LPF setting, but typ 15.9 ms, let's
>> +	 * set 20 ms to allow for some slack.
>> +	 */
>> +	msleep(20);
>> +
>> +	return 0;
>>  };
>>  
>> +static int kxsd9_power_down(struct kxsd9_state *st)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * Set into low power mode - since there may be more users of the
>> +	 * regulators this is the first step of the power saving: it will
>> +	 * make sure we conserve power even if there are others users on the
>> +	 * regulators.
>> +	 */
>> +	ret = regmap_update_bits(st->map,
>> +				 KXSD9_REG_CTRL_B,
>> +				 KXSD9_CTRL_B_ENABLE,
>> +				 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Disable the regulators */
>> +	ret = regulator_bulk_disable(ARRAY_SIZE(st->regs), st->regs);
>> +	if (ret) {
>> +		dev_err(st->dev, "Cannot disable regulators\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct iio_info kxsd9_info = {
>>  	.read_raw = &kxsd9_read_raw,
>>  	.write_raw = &kxsd9_write_raw,
>> @@ -292,6 +359,17 @@ int kxsd9_common_probe(struct device *parent,
>>  	indio_dev->modes = INDIO_DIRECT_MODE;
>>  	indio_dev->available_scan_masks = kxsd9_scan_masks;
>>  
>> +	/* Fetch and turn on regulators */
>> +	st->regs[0].supply = kxsd9_reg_vdd;
>> +	st->regs[1].supply = kxsd9_reg_iovdd;
>> +	ret = devm_regulator_bulk_get(parent,
>> +				      ARRAY_SIZE(st->regs),
>> +				      st->regs);
>> +	if (ret) {
>> +		dev_err(parent, "Cannot get regulators\n");
>> +		return ret;
>> +	}
>> +
>>  	kxsd9_power_up(st);
>>  
>>  	ret = iio_triggered_buffer_setup(indio_dev,
>> @@ -300,7 +378,7 @@ int kxsd9_common_probe(struct device *parent,
>>  					 NULL);
>>  	if (ret) {
>>  		dev_err(parent, "triggered buffer setup failed\n");
>> -		return ret;
>> +		goto err_power_down;
>>  	}
>>  
>>  	ret = iio_device_register(indio_dev);
>> @@ -313,6 +391,8 @@ int kxsd9_common_probe(struct device *parent,
>>  
>>  err_cleanup_buffer:
>>  	iio_triggered_buffer_cleanup(indio_dev);
>> +err_power_down:
>> +	kxsd9_power_down(st);
>>  
>>  	return ret;
>>  }
>> @@ -321,9 +401,11 @@ EXPORT_SYMBOL(kxsd9_common_probe);
>>  int kxsd9_common_remove(struct device *parent)
>>  {
>>  	struct iio_dev *indio_dev = dev_get_drvdata(parent);
>> +	struct kxsd9_state *st = iio_priv(indio_dev);
>>  
>>  	iio_triggered_buffer_cleanup(indio_dev);
>>  	iio_device_unregister(indio_dev);
>> +	kxsd9_power_down(st);
>>  
>>  	return 0;
>>  }
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

