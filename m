Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36760 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbaBRIkw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 03:40:52 -0500
Message-ID: <53031CBB.9050106@kernel.org>
Date: Tue, 18 Feb 2014 08:41:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH]staging:iio:ad799x use regulator for vref
References: <5300A8DA.3070107@gmx.de> <53010A35.2040102@metafoo.de>
In-Reply-To: <53010A35.2040102@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/02/14 18:57, Lars-Peter Clausen wrote:
> On 02/16/2014 01:02 PM, Hartmut Knaack wrote:
>> Switch the ad799x driver to use the regulator framework and add binding for reference voltage.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied with a little fuzz to the togreg branch of iio.git
This will go out as testing initially for the autobuilders to play.
>
>> ---
>> diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
>> index a591aa6..fc8c852 100644
>> --- a/drivers/staging/iio/adc/ad799x.h
>> +++ b/drivers/staging/iio/adc/ad799x.h
>> @@ -95,7 +95,7 @@ struct ad799x_state {
>>       struct i2c_client        *client;
>>       const struct ad799x_chip_info    *chip_info;
>>       struct regulator        *reg;
>> -    u16                int_vref_mv;
>> +    struct regulator        *vref;
>>       unsigned            id;
>>       u16                config;
>>
>> @@ -103,14 +103,6 @@ struct ad799x_state {
>>       unsigned int            transfer_size;
>>   };
>>
>> -/*
>> - * TODO: struct ad799x_platform_data needs to go into include/linux/iio
>> - */
>> -
>> -struct ad799x_platform_data {
>> -    u16                vref_mv;
>> -};
>> -
>>   #ifdef CONFIG_AD799X_RING_BUFFER
>>   int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev);
>>   void ad799x_ring_cleanup(struct iio_dev *indio_dev);
>> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
>> index 570c594..747d1da 100644
>> --- a/drivers/staging/iio/adc/ad799x_core.c
>> +++ b/drivers/staging/iio/adc/ad799x_core.c
>> @@ -179,7 +179,10 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>>               RES_MASK(chan->scan_type.realbits);
>>           return IIO_VAL_INT;
>>       case IIO_CHAN_INFO_SCALE:
>> -        *val = st->int_vref_mv;
>> +        ret = regulator_get_voltage(st->vref);
>> +        if (ret < 0)
>> +            return ret;
>> +        *val = ret / 1000;
>>           *val2 = chan->scan_type.realbits;
>>           return IIO_VAL_FRACTIONAL_LOG2;
>>       }
>> @@ -527,7 +530,6 @@ static int ad799x_probe(struct i2c_client *client,
>>                      const struct i2c_device_id *id)
>>   {
>>       int ret;
>> -    struct ad799x_platform_data *pdata = client->dev.platform_data;
>>       struct ad799x_state *st;
>>       struct iio_dev *indio_dev;
>>
>> @@ -545,17 +547,21 @@ static int ad799x_probe(struct i2c_client *client,
>>
>>       /* TODO: Add pdata options for filtering and bit delay */
>>
>> -    if (!pdata)
>> -        return -EINVAL;
>> -
>> -    st->int_vref_mv = pdata->vref_mv;
>> -
>>       st->reg = devm_regulator_get(&client->dev, "vcc");
>> -    if (!IS_ERR(st->reg)) {
>> -        ret = regulator_enable(st->reg);
>> -        if (ret)
>> -            return ret;
>> +    if (IS_ERR(st->reg))
>> +        return PTR_ERR(st->reg);
>> +    ret = regulator_enable(st->reg);
>> +    if (ret)
>> +        return ret;
>> +    st->vref = devm_regulator_get(&client->dev, "vref");
>> +    if (IS_ERR(st->vref)) {
>> +        ret = PTR_ERR(st->vref);
>> +        goto error_disable_reg;
>>       }
>> +    ret = regulator_enable(st->vref);
>> +    if (ret)
>> +        goto error_disable_reg;
>> +
>>       st->client = client;
>>
>>       indio_dev->dev.parent = &client->dev;
>> @@ -592,6 +598,8 @@ error_free_irq:
>>   error_cleanup_ring:
>>       ad799x_ring_cleanup(indio_dev);
>>   error_disable_reg:
>> +    if (!IS_ERR(st->vref))
>> +        regulator_disable(st->vref);
>>       if (!IS_ERR(st->reg))
>>           regulator_disable(st->reg);
>>
>> @@ -608,6 +616,8 @@ static int ad799x_remove(struct i2c_client *client)
>>           free_irq(client->irq, indio_dev);
>>
>>       ad799x_ring_cleanup(indio_dev);
>> +    if (!IS_ERR(st->vref))
>> +        regulator_disable(st->vref);
>>       if (!IS_ERR(st->reg))
>>           regulator_disable(st->reg);
>>       kfree(st->rx_buf);
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

