Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49456 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755274AbcIRKft (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:35:49 -0400
Subject: Re: [PATCH 13/15 v2] iio: accel: kxsd9: Replace "parent" with "dev"
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
 <1472723089-25113-13-git-send-email-linus.walleij@linaro.org>
 <35d6f188-b639-aca4-1c13-b59169e4dfc0@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7eb49733-fd0d-7be6-3a1c-56908ba5c4be@kernel.org>
Date: Sun, 18 Sep 2016 11:35:47 +0100
MIME-Version: 1.0
In-Reply-To: <35d6f188-b639-aca4-1c13-b59169e4dfc0@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/16 17:46, Jonathan Cameron wrote:
> On 01/09/16 10:44, Linus Walleij wrote:
>> What is passed to the .probe() and .remove() functions is
>> technically the parent of the created IIO device but it becomes
>> a big confusion for the head to have it named like this since
>> it is usually clear from context the "dev" refers to the physical
>> device, and when next adding PM callbacks a clean
>> "struct device *dev" pointer is passed to these and that makes
>> it even more confused. Rename "parent" to "dev" like in most
>> other drivers.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Jonathan Cameron <jic23@kernel.org>
Applied.
>> ---
> 
>> ChangeLog v1->v2:
>> - Rebased on the rest of the series.
>> ---
>>  drivers/iio/accel/kxsd9.c | 20 ++++++++++----------
>>  drivers/iio/accel/kxsd9.h |  4 ++--
>>  2 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>> index dc53f70e616e..f18cc9436094 100644
>> --- a/drivers/iio/accel/kxsd9.c
>> +++ b/drivers/iio/accel/kxsd9.c
>> @@ -335,7 +335,7 @@ static const struct iio_info kxsd9_info = {
>>  /* Four channels apart from timestamp, scan mask = 0x0f */
>>  static const unsigned long kxsd9_scan_masks[] = { 0xf, 0 };
>>  
>> -int kxsd9_common_probe(struct device *parent,
>> +int kxsd9_common_probe(struct device *dev,
>>  		       struct regmap *map,
>>  		       const char *name)
>>  {
>> @@ -343,18 +343,18 @@ int kxsd9_common_probe(struct device *parent,
>>  	struct kxsd9_state *st;
>>  	int ret;
>>  
>> -	indio_dev = devm_iio_device_alloc(parent, sizeof(*st));
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>>  	if (!indio_dev)
>>  		return -ENOMEM;
>>  
>>  	st = iio_priv(indio_dev);
>> -	st->dev = parent;
>> +	st->dev = dev;
>>  	st->map = map;
>>  
>>  	indio_dev->channels = kxsd9_channels;
>>  	indio_dev->num_channels = ARRAY_SIZE(kxsd9_channels);
>>  	indio_dev->name = name;
>> -	indio_dev->dev.parent = parent;
>> +	indio_dev->dev.parent = dev;
>>  	indio_dev->info = &kxsd9_info;
>>  	indio_dev->modes = INDIO_DIRECT_MODE;
>>  	indio_dev->available_scan_masks = kxsd9_scan_masks;
>> @@ -362,11 +362,11 @@ int kxsd9_common_probe(struct device *parent,
>>  	/* Fetch and turn on regulators */
>>  	st->regs[0].supply = kxsd9_reg_vdd;
>>  	st->regs[1].supply = kxsd9_reg_iovdd;
>> -	ret = devm_regulator_bulk_get(parent,
>> +	ret = devm_regulator_bulk_get(dev,
>>  				      ARRAY_SIZE(st->regs),
>>  				      st->regs);
>>  	if (ret) {
>> -		dev_err(parent, "Cannot get regulators\n");
>> +		dev_err(dev, "Cannot get regulators\n");
>>  		return ret;
>>  	}
>>  
>> @@ -377,7 +377,7 @@ int kxsd9_common_probe(struct device *parent,
>>  					 kxsd9_trigger_handler,
>>  					 NULL);
>>  	if (ret) {
>> -		dev_err(parent, "triggered buffer setup failed\n");
>> +		dev_err(dev, "triggered buffer setup failed\n");
>>  		goto err_power_down;
>>  	}
>>  
>> @@ -385,7 +385,7 @@ int kxsd9_common_probe(struct device *parent,
>>  	if (ret)
>>  		goto err_cleanup_buffer;
>>  
>> -	dev_set_drvdata(parent, indio_dev);
>> +	dev_set_drvdata(dev, indio_dev);
>>  
>>  	return 0;
>>  
>> @@ -398,9 +398,9 @@ err_power_down:
>>  }
>>  EXPORT_SYMBOL(kxsd9_common_probe);
>>  
>> -int kxsd9_common_remove(struct device *parent)
>> +int kxsd9_common_remove(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = dev_get_drvdata(parent);
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>  	struct kxsd9_state *st = iio_priv(indio_dev);
>>  
>>  	iio_triggered_buffer_cleanup(indio_dev);
>> diff --git a/drivers/iio/accel/kxsd9.h b/drivers/iio/accel/kxsd9.h
>> index 19131a7a692c..9c0861f6b838 100644
>> --- a/drivers/iio/accel/kxsd9.h
>> +++ b/drivers/iio/accel/kxsd9.h
>> @@ -4,7 +4,7 @@
>>  #define KXSD9_STATE_RX_SIZE 2
>>  #define KXSD9_STATE_TX_SIZE 2
>>  
>> -int kxsd9_common_probe(struct device *parent,
>> +int kxsd9_common_probe(struct device *dev,
>>  		       struct regmap *map,
>>  		       const char *name);
>> -int kxsd9_common_remove(struct device *parent);
>> +int kxsd9_common_remove(struct device *dev);
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

