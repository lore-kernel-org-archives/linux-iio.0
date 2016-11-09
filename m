Return-Path: <m.niestroj@grinn-global.com>
Subject: Re: [PATCH 1/2] iio: bmi160: Support hardware fifo
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161103112527.29623-1-m.niestroj@grinn-global.com>
 <alpine.DEB.2.02.1611031252480.11256@pmeerw.net>
 <eed0df11-6520-c3fa-c6cd-46c13dcddc1f@grinn-global.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Daniel Baluta
 <daniel.baluta@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>,
 Sanchayan Maity <maitysanchayan@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, linux-iio@vger.kernel.org
From: Marcin Niestroj <m.niestroj@grinn-global.com>
Message-ID: <48a86354-f566-d162-f1fa-5fe6ba78dde2@grinn-global.com>
Date: Wed, 9 Nov 2016 18:16:59 +0100
MIME-Version: 1.0
In-Reply-To: <eed0df11-6520-c3fa-c6cd-46c13dcddc1f@grinn-global.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09.11.2016 15:16, Marcin Niestroj wrote:
> Hi,
> Thanks for review, below are my comments.
>
> On 03.11.2016 13:09, Peter Meerwald-Stadler wrote:
>>
>>> This patch was developed primarily based on bmc150_accel hardware fifo
>>> implementation.
>>
>> parts of the patch are cleanup and bugfixing; should be separate?
>>
>> more comments below
>>
>>> IRQ handler was added, which for now is responsible only for handling
>>> watermark interrupts. The BMI160 chip has two interrupt outputs. By
>>> default INT is considered to be connected. If INT2 is used instead, the
>>> interrupt-names device-tree property can be used to specify that.
>>>
>>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>

<snip>

>>> @@ -574,8 +1114,11 @@ int bmi160_core_probe(struct device *dev,
>>> struct regmap *regmap,
>>>
>>>      data = iio_priv(indio_dev);
>>>      dev_set_drvdata(dev, indio_dev);
>>> +    data->irq = irq;
>>>      data->regmap = regmap;
>>>
>>> +    mutex_init(&data->mutex);
>>> +
>>>      ret = bmi160_chip_init(data, use_spi);
>>>      if (ret < 0)
>>>          return ret;
>>> @@ -591,10 +1134,50 @@ int bmi160_core_probe(struct device *dev,
>>> struct regmap *regmap,
>>>      indio_dev->info = &bmi160_info;
>>>
>>>      ret = iio_triggered_buffer_setup(indio_dev, NULL,
>>> -                     bmi160_trigger_handler, NULL);
>>> +                     bmi160_trigger_handler,
>>> +                     &bmi160_buffer_ops);
>>>      if (ret < 0)
>>>          goto uninit;
>>>
>>> +    if (data->irq > 0) {
>>> +        /* Check which interrupt pin is connected to our board */
>>> +        irq2 = of_irq_get_byname(dev->of_node, "INT2");
>>> +        if (irq2 == data->irq) {
>>> +            dev_dbg(dev, "Using interrupt line INT2\n");
>>> +            data->irq_data = &bmi160_irq2_data;
>>> +        } else {
>>> +            dev_dbg(dev, "Using interrupt line INT1\n");
>>> +            data->irq_data = &bmi160_irq1_data;
>>> +        }
>>> +
>>> +        ret = devm_request_threaded_irq(dev,
>>> +                        data->irq,
>>> +                        bmi160_irq_handler,
>>> +                        bmi160_irq_thread_handler,
>>> +                        IRQF_ONESHOT,
>>> +                        BMI160_IRQ_NAME,
>>> +                        indio_dev);
>>> +        if (ret)
>>> +            return ret;

I just noticed, that there should be a "goto buffer_cleanup" instead.

>>> +
>>> +        ret = bmi160_enable_irq(data);
>>> +        if (ret < 0)
>>> +            goto buffer_cleanup;
>>> +
>>> +        if (block_supported) {
>>> +            indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
>>> +            indio_dev->info = &bmi160_info_fifo;
>>> +            indio_dev->buffer->attrs = bmi160_fifo_attributes;
>>> +            data->fifo_buffer = devm_kmalloc(dev,
>>> +                            BMI160_FIFO_LENGTH,
>>> +                            GFP_KERNEL);
>>> +            if (!data->fifo_buffer) {
>>> +                ret = -ENOMEM;
>>
>> need to disable irq on failure?
>
> Yes, I missed that.

I am just wondering now if it is really neccessary. bmi160_enable_irq()
is just enabling IRQ output on INT1 or INT2 depending on device-tree.
This alone will not trigger interrupts, as all should be masked at this
stage.

>
>>
>>> +                goto buffer_cleanup;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>>      ret = iio_device_register(indio_dev);
>>>      if (ret < 0)
>>>          goto buffer_cleanup;
>>> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c
>>> b/drivers/iio/imu/bmi160/bmi160_i2c.c
>>> index 07a179d..aa63f89 100644
>>> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
>>> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
>>> @@ -23,6 +23,10 @@ static int bmi160_i2c_probe(struct i2c_client
>>> *client,
>>>  {
>>>      struct regmap *regmap;
>>>      const char *name = NULL;
>>> +    bool block_supported =
>>> +        i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
>>> +        i2c_check_functionality(client->adapter,
>>> +                    I2C_FUNC_SMBUS_READ_I2C_BLOCK);
>>>
>>>      regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
>>>      if (IS_ERR(regmap)) {
>>> @@ -34,7 +38,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>>>      if (id)
>>>          name = id->name;
>>>
>>> -    return bmi160_core_probe(&client->dev, regmap, name, false);
>>> +    return bmi160_core_probe(&client->dev, regmap, name, client->irq,
>>> +                false, block_supported);
>>>  }
>>>
>>>  static int bmi160_i2c_remove(struct i2c_client *client)
>>> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c
>>> b/drivers/iio/imu/bmi160/bmi160_spi.c
>>> index 1ec8b12..9b57fbe 100644
>>> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
>>> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
>>> @@ -25,7 +25,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
>>>              (int)PTR_ERR(regmap));
>>>          return PTR_ERR(regmap);
>>>      }
>>> -    return bmi160_core_probe(&spi->dev, regmap, id->name, true);
>>> +    return bmi160_core_probe(&spi->dev, regmap, id->name, spi->irq,
>>> +                true, true);
>>>  }
>>>
>>>  static int bmi160_spi_remove(struct spi_device *spi)
>>>
>>
>

-- 
Marcin Niestroj
