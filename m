Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47897 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbdCMUNb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:13:31 -0400
Subject: Re: [PATCH] iio:light: Add support for STMicro VL6180 sensor
To: Mani Sadhasivam <manivannanece23@gmail.com>
References: <20170302184031.GA27741@gmail.com>
 <2e6ed211-baf2-9877-fbb4-b39aa75f4dee@kernel.org>
 <20170305134600.GB5467@gmail.com>
 <53b785e1-7956-2833-91b6-dd4632556f2d@kernel.org>
 <CANBTL1V5mo7GaeMspo0rUW=B+XEh0A_3X_Sa71n7MQPB1xTztQ@mail.gmail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux iio <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <50348765-3a51-0f7b-e243-012890646dd7@kernel.org>
Date: Mon, 13 Mar 2017 20:13:29 +0000
MIME-Version: 1.0
In-Reply-To: <CANBTL1V5mo7GaeMspo0rUW=B+XEh0A_3X_Sa71n7MQPB1xTztQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

<snip>
>>>>> + * 2. ALS integration time: 100ms
>>>>> + * 3. ALS gain: 1
>>>>> + */
>>>>> +static int vl6180_init(struct vl6180_data *data)
>>>>> +{
>>>>> +   struct i2c_client *client = data->client;
>>>>> +   int ret;
>>>>> +
>>>>> +   ret = vl6180_read_byte(client, VL6180_MODEL_ID);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>>> +
>>>>> +   if (ret != VL6180_MODEL_ID_VAL) {
>>>>> +           dev_err(&client->dev, "invalid model ID %02x\n", ret);
>>>>> +           return -ENODEV;
>>>>> +   }
>>>>> +
>>>>> +   ret = vl6180_hold(data, true);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>>> +
>>>>> +   ret = vl6180_read_byte(client, VL6180_OUT_OF_RESET);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>>> +
>>>>> +   if (ret != 0x01) {
>>>>> +           dev_err(&client->dev, "device is not fresh out of reset\n");
>>>>> +           return -EINVAL;
>>>>> +   }
>>>> Why would it necessarily be fresh out of reset? If it is in some fashion
>>>> supposed to be guaranteed here, please add a comment explaining why.
>>> Device sometimes suffers from false reset condition. Hence, this check ensures that
>>> the device always starts up in the fresh reset condition.
>>> Will add a comment here.
>> Ensures it or checks that it is the case?
>>
>> What about a module remove and reprobe?  Should work in that case as well.
> If the device is not fresh out of reset it won't get registered, by
> this way we can prevent
> the device to run in false reset condition.
Remove and probe needs to work if at all possible. It's a common enough
thing to do for one reason or another.

A classic option would be to allow provision of a gpios to manually perform
the reset.  Sounds like that's not an option on your board however.

If not, is it possible to get the device to a known state by simply writing
all it's registers?  If it's really impossible to continue in this state
we need detailed explanation of why here in comments in the code.
> 
> When  the module is removed and installed again without resetting the
> device, this check
> will get into act.
>>>>> +
>>>>> +   ret = vl6180_write_byte(client, VL6180_INTR_CONFIG,
>>>>> +                           VL6180_ALS_READY | VL6180_RANGE_READY);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>>> +
>>>>> +   ret = vl6180_write_word(client, VL6180_ALS_IT, VL6180_ALS_IT_100);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>>> +
>>>>> +   ret = vl6180_write_byte(client, VL6180_ALS_GAIN, VL6180_ALS_GAIN_1);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>>> +
>>>>> +   ret = vl6180_write_byte(client, VL6180_OUT_OF_RESET, 0x00);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>>> +
>>>>> +   return vl6180_hold(data, false);
>>>>> +}
>>>>> +
>>>>> +static int vl6180_probe(struct i2c_client *client,
>>>>> +                     const struct i2c_device_id *id)
>>>>> +{
>>>>> +   struct vl6180_data *data;
>>>>> +   struct iio_dev *indio_dev;
>>>>> +   int ret;
>>>>> +
>>>>> +   indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>>>> +   if (!indio_dev)
>>>>> +           return -ENOMEM;
>>>>> +
>>>>> +   data = iio_priv(indio_dev);
>>>>> +   i2c_set_clientdata(client, indio_dev);
>>>>> +   data->client = client;
>>>>> +   mutex_init(&data->lock);
>>>>> +
>>>>> +   indio_dev->dev.parent = &client->dev;
>>>>> +   indio_dev->info = &vl6180_info;
>>>>> +   indio_dev->channels = vl6180_channels;
>>>>> +   indio_dev->num_channels = ARRAY_SIZE(vl6180_channels);
>>>>> +   indio_dev->name = VL6180_DRV_NAME;
>>>>> +   indio_dev->modes = INDIO_DIRECT_MODE;
>>>>> +
>>>>> +   ret = vl6180_init(data);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>>> +
>>>>> +   ret = devm_iio_device_register(&client->dev, indio_dev);
>>>>> +   if (ret < 0)
>>>>> +           return ret;
>>>> return devm_iio_device_register directly.
>>>>
>>>> The static checkers will fire on this anyway, but best to fix
>>>> it now.
>>> Ack
>>>>> +
>>>>> +   return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct of_device_id vl6180_of_match[] = {
>>>>> +   { .compatible = "st,vl6180", },
>>>>> +   { },
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, vl6180_of_match);
>>>>> +
>>>>> +static const struct i2c_device_id vl6180_id[] = {
>>>>> +   { "vl6180", 0 },
>>>>> +   { }
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(i2c, vl6180_id);
>>>>> +
>>>>> +static struct i2c_driver vl6180_driver = {
>>>>> +   .driver = {
>>>>> +           .name   = VL6180_DRV_NAME,
>>>>> +           .of_match_table = of_match_ptr(vl6180_of_match),
>>>>> +   },
>>>>> +   .probe  = vl6180_probe,
>>>>> +   .id_table = vl6180_id,
>>>>> +};
>>>>> +
>>>>> +module_i2c_driver(vl6180_driver);
>>>>> +
>>>>> +MODULE_AUTHOR("Peter Meerwald-Stadler <pmeerw@pmeerw.net>");
>>>>> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannanece23@gmail.com>");
>>>>> +MODULE_DESCRIPTION("STMicro VL6180 ALS and proximity sensor driver");
>>>>> +MODULE_LICENSE("GPL");
>>>>>
>>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

