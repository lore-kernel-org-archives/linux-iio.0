Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55943 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964895AbcBQT3w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2016 14:29:52 -0500
Subject: Re: [PATCH 1/2] iio: ina2xx: Fix whitespace and re-order code
To: "Andrew F. Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Titinger <mtitinger@baylibre.com>
References: <1455302063-8414-1-git-send-email-afd@ti.com>
 <56BF27A4.50904@kernel.org> <56C0E71F.3010508@ti.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56C4CA2A.7070206@kernel.org>
Date: Wed, 17 Feb 2016 19:29:46 +0000
MIME-Version: 1.0
In-Reply-To: <56C0E71F.3010508@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/16 20:44, Andrew F. Davis wrote:
> On 02/13/2016 06:55 AM, Jonathan Cameron wrote:
>> On 12/02/16 18:34, Andrew F. Davis wrote:
>>> Group of probably overly rigorous whitespace and code cleanups.
>>>   - Alphabetize includes
>>>   - Assign to variables in the order they are defined
>>>   - Alignment issues
>>>   - Group alike statements together
>>>   - Use helper macros
>>>
>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Definitely overzealous in some cases - but some good stuff in here
>> as well.  Some of this just adds noise for no real gain.  From the point
>> of view of bisection etc - we have to balance the possible cost of the
>> more minor cleanups against their benefits.
>>
> 
> My original plan was to push these last cycle so they would come in
> with the drivers creation patches.
Things would have been a little easier then, but still churn is a problem
from a maintenance point of view. 
> 
> I still would argue this driver is new enough that not many trees
> have made changes to this that would complicate rebasing back onto
> mainline with these changes on top. This is the bottom of a series
> with some more important changes I will not have time this window
> to get in, so I pushed these early to keep the delta low if anyone
> else starts working on this driver.
> 
> And at any rate, I would say code should be the #1 priority, being
> afraid to change code for the sake of keeping the source control tools
> happy seems a bit backwards to me.
It's not about keeping the source controls happy, it's about keeping them
useful. Churn adds a high level of noise - it is far from costless.
It breaks the ability to workout where a bug was originally introduced
and it also makes back porting bug fixes effectively not happen.  As far
as I know, no one has ever submitted a non trivial backport of an IIO bug
fix to stable.  The ones that go in are the ones that the stable maintainers
can apply in a few seconds.

Some of the changes you make in here do not significantly improve the 
code - that is the barrier that any patch must cross if it is to be applied.
Others are definitely worth the cost.

Jonathan
> 
>> I'll run through and give my opinion on which ones are worthwhile etc.
>> Quite a few are marginal, but I feel fairly strongly against one of the
>> changes in alignment of the \ in the large macro.
>>
>> Jonathan
>>> ---
>>>   drivers/iio/adc/ina2xx-adc.c | 164 +++++++++++++++++++++----------------------
>>>   1 file changed, 80 insertions(+), 84 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
>>> index d803e50..61e8ae9 100644
>>> --- a/drivers/iio/adc/ina2xx-adc.c
>>> +++ b/drivers/iio/adc/ina2xx-adc.c
>>> @@ -19,17 +19,18 @@
>>>    *
>>>    * Configurable 7-bit I2C slave address from 0x40 to 0x4F
>>>    */
>>> -#include <linux/module.h>
>>> -#include <linux/kthread.h>
>>> +
>>>   #include <linux/delay.h>
>>> +#include <linux/i2c.h>
>>>   #include <linux/iio/kfifo_buf.h>
>>>   #include <linux/iio/sysfs.h>
>>> -#include <linux/i2c.h>
>>> +#include <linux/kthread.h>
>>> +#include <linux/module.h>
>>>   #include <linux/regmap.h>
>>> -#include <linux/platform_data/ina2xx.h>
>>> -
>>>   #include <linux/util_macros.h>
>> There is sometimes some logical grouping going on in the way the author
>> decides to put the headers in, here it's not that well defined that
>> I can see. However, there is no real benefit in alphabetical order either
>> though clearly some other projects disagree and do mandate this...
> 
> Up to you then, but you can see below I have grouped the non-kernel-common
> headers out, so this would add to any logical grouping.
This one is unlikely to cause maintenance issues so feel free.
> 
>>>
>>> +#include <linux/platform_data/ina2xx.h>
>>> +
>>>   /* INA2XX registers definition */
>>>   #define INA2XX_CONFIG                   0x00
>>>   #define INA2XX_SHUNT_VOLTAGE            0x01    /* readonly */
>>> @@ -38,7 +39,7 @@
>>>   #define INA2XX_CURRENT                  0x04    /* readonly */
>>>   #define INA2XX_CALIBRATION              0x05
>>>
>>> -#define INA226_ALERT_MASK        0x06
>>> +#define INA226_ALERT_MASK        GENMASK(2, 1)
>>>   #define INA266_CVRF            BIT(3)
>>>
>>>   #define INA2XX_MAX_REGISTERS            8
>>> @@ -113,7 +114,7 @@ struct ina2xx_chip_info {
>>>       struct mutex state_lock;
>>>       unsigned int shunt_resistor;
>>>       int avg;
>>> -    s64 prev_ns;    /* track buffer capture time, check for underruns*/
>>> +    s64 prev_ns; /* track buffer capture time, check for underruns*/
>> Fair enough, though a space before the */ would be nice!
>>>       int int_time_vbus; /* Bus voltage integration time uS */
>>>       int int_time_vshunt; /* Shunt voltage integration time uS */
>>>       bool allow_async_readout;
>>> @@ -121,21 +122,21 @@ struct ina2xx_chip_info {
>>>
>>>   static const struct ina2xx_config ina2xx_config[] = {
>>>       [ina219] = {
>> I'd have left this indenting alone. It's more of a matter of taste
>> than any hard and fast rule.  I'd do indenting myself the way
>> you have, but it's not worth the noise to change it.
> 
> To me this should be considered against the style guidelines on indentation.
> It's almost like
> 
> while (something) {
>                   code;
>                   code;
>                   }
> 
> Auto formatting tools will make this change as well, so it may get fixed someday
> anyway if any checks for this are added to checkpatch.
That would first of all require the style guidelines to cover this case.
Right now they don't that I can identify.

Fine keep this one in. 
> 
>>> -            .config_default = INA219_CONFIG_DEFAULT,
>>> -            .calibration_factor = 40960000,
>>> -            .shunt_div = 100,
>>> -            .bus_voltage_shift = 3,
>>> -            .bus_voltage_lsb = 4000,
>>> -            .power_lsb = 20000,
>>> -            },
>>> +        .config_default = INA219_CONFIG_DEFAULT,
>>> +        .calibration_factor = 40960000,
>>> +        .shunt_div = 100,
>>> +        .bus_voltage_shift = 3,
>>> +        .bus_voltage_lsb = 4000,
>>> +        .power_lsb = 20000,
>>> +    },
>>>       [ina226] = {
>>> -            .config_default = INA226_CONFIG_DEFAULT,
>>> -            .calibration_factor = 5120000,
>>> -            .shunt_div = 400,
>>> -            .bus_voltage_shift = 0,
>>> -            .bus_voltage_lsb = 1250,
>>> -            .power_lsb = 25000,
>>> -            },
>>> +        .config_default = INA226_CONFIG_DEFAULT,
>>> +        .calibration_factor = 5120000,
>>> +        .shunt_div = 400,
>>> +        .bus_voltage_shift = 0,
>>> +        .bus_voltage_lsb = 1250,
>>> +        .power_lsb = 25000,
>>> +    },
>>>   };
>>>
>>>   static int ina2xx_read_raw(struct iio_dev *indio_dev,
>>> @@ -149,7 +150,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>>>       switch (mask) {
>>>       case IIO_CHAN_INFO_RAW:
>>>           ret = regmap_read(chip->regmap, chan->address, &regval);
>>> -        if (ret < 0)
>>> +        if (ret)
>>>               return ret;
>> These are good to clean up.
>>>
>>>           if (is_signed_reg(chan->address))
>>> @@ -251,7 +252,7 @@ static int ina226_set_int_time_vbus(struct ina2xx_chip_info *chip,
>>>           return -EINVAL;
>>>
>>>       bits = find_closest(val_us, ina226_conv_time_tab,
>>> -            ARRAY_SIZE(ina226_conv_time_tab));
>>> +                ARRAY_SIZE(ina226_conv_time_tab));
>> Good to get these nicely aligned as well.
>>>
>>>       chip->int_time_vbus = ina226_conv_time_tab[bits];
>>>
>>> @@ -270,7 +271,7 @@ static int ina226_set_int_time_vshunt(struct ina2xx_chip_info *chip,
>>>           return -EINVAL;
>>>
>>>       bits = find_closest(val_us, ina226_conv_time_tab,
>>> -            ARRAY_SIZE(ina226_conv_time_tab));
>>> +                ARRAY_SIZE(ina226_conv_time_tab));
>>>
>>>       chip->int_time_vshunt = ina226_conv_time_tab[bits];
>>>
>>> @@ -285,8 +286,8 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
>>>                   int val, int val2, long mask)
>>>   {
>>>       struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>>> -    int ret;
>>>       unsigned int config, tmp;
>>> +    int ret;
>> Definitely in the doesn't matter category, but if you really want to this
>> one is fine.
>>>
>>>       if (iio_buffer_enabled(indio_dev))
>>>           return -EBUSY;
>>> @@ -294,8 +295,8 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
>>>       mutex_lock(&chip->state_lock);
>>>
>>>       ret = regmap_read(chip->regmap, INA2XX_CONFIG, &config);
>>> -    if (ret < 0)
>>> -        goto _err;
>>> +    if (ret)
>>> +        goto err;
>> Good.
>>>
>>>       tmp = config;
>>>
>>> @@ -310,19 +311,19 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
>>>           else
>>>               ret = ina226_set_int_time_vbus(chip, val2, &tmp);
>>>           break;
>>> +
>> Maybe a slight gain in readability so fair enough.
>>>       default:
>>>           ret = -EINVAL;
>>>       }
>>>
>>>       if (!ret && (tmp != config))
>>>           ret = regmap_write(chip->regmap, INA2XX_CONFIG, tmp);
>>> -_err:
>>> +err:
>> Fine.
>>>       mutex_unlock(&chip->state_lock);
>>>
>>>       return ret;
>>>   }
>>>
>>> -
>>>   static ssize_t ina2xx_allow_async_readout_show(struct device *dev,
>>>                          struct device_attribute *attr,
>>>                          char *buf)
>>> @@ -355,6 +356,7 @@ static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
>>>           return -EINVAL;
>>>
>>>       chip->shunt_resistor = val;
>>> +
>> good.
>>>       return 0;
>>>   }
>>>
>>> @@ -408,21 +410,21 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>>>    * Sampling Freq is a consequence of the integration times of
>>>    * the Voltage channels.
>>>    */
>>> -#define INA2XX_CHAN_VOLTAGE(_index, _address) { \
>>> -    .type = IIO_VOLTAGE, \
>>> -    .address = (_address), \
>>> -    .indexed = 1, \
>>> -    .channel = (_index), \
>>> -    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>>> -                  BIT(IIO_CHAN_INFO_SCALE) | \
>>> -                  BIT(IIO_CHAN_INFO_INT_TIME), \
>>> -    .scan_index = (_index), \
>>> -    .scan_type = { \
>>> -        .sign = 'u', \
>>> -        .realbits = 16, \
>>> -        .storagebits = 16, \
>>> -        .endianness = IIO_LE, \
>>> -    } \
>> This one I disagree with.  It too often leads to noise when we end up with
>> an element with a line and have to change the spacing before the \s.
>> Much less churn occurs with teh version as original defined.
>> As someone who handles a fair number of patch reviews I feel pretty strongly
>> about anything that leads to more churn.
>>
> 
> That's fine, this one I changed to I could see what was going on
> in didn't really care how it is done, I think I even left the
> other macro like this unchanged, so this change can be dropped.
> 
>>> +#define INA2XX_CHAN_VOLTAGE(_index, _address) {            \
>>> +    .type = IIO_VOLTAGE,                    \
>>> +    .address = (_address),                    \
>>> +    .indexed = 1,                        \
>>> +    .channel = (_index),                    \
>>> +    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |        \
>>> +                  BIT(IIO_CHAN_INFO_SCALE) |    \
>>> +                  BIT(IIO_CHAN_INFO_INT_TIME),    \
>>> +    .scan_index = (_index),                    \
>>> +    .scan_type = {                        \
>>> +        .sign = 'u',                    \
>>> +        .realbits = 16,                    \
>>> +        .storagebits = 16,                \
>>> +        .endianness = IIO_LE,                \
>>> +    }                            \
>>>   }
>>>
>>>   static const struct iio_chan_spec ina2xx_channels[] = {
>>> @@ -500,7 +502,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>>>
>>>   static int ina2xx_capture_thread(void *data)
>>>   {
>>> -    struct iio_dev *indio_dev = (struct iio_dev *)data;
>>> +    struct iio_dev *indio_dev = data;
>> good.
>>>       struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>>>       unsigned int sampling_us = SAMPLING_PERIOD(chip);
>>>       int buffer_us;
>>> @@ -575,8 +577,7 @@ static int ina2xx_debug_reg(struct iio_dev *indio_dev,
>>>   }
>>>
>>>   /* Possible integration times for vshunt and vbus */
>>> -static IIO_CONST_ATTR_INT_TIME_AVAIL \
>>> - ("0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244");
>>> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244");
>>>
>>>   static IIO_DEVICE_ATTR(in_allow_async_readout, S_IRUGO | S_IWUSR,
>>>                  ina2xx_allow_async_readout_show,
>>> @@ -598,21 +599,23 @@ static const struct attribute_group ina2xx_attribute_group = {
>>>   };
>>>
>>>   static const struct iio_info ina2xx_info = {
>>> -    .debugfs_reg_access = &ina2xx_debug_reg,
>>> -    .read_raw = &ina2xx_read_raw,
>>> -    .write_raw = &ina2xx_write_raw,
>>> -    .attrs = &ina2xx_attribute_group,
>>>       .driver_module = THIS_MODULE,
>>> +    .attrs = &ina2xx_attribute_group,
>>> +    .read_raw = ina2xx_read_raw,
>>> +    .write_raw = ina2xx_write_raw,
>>> +    .debugfs_reg_access = ina2xx_debug_reg,
>> sensible change.
>>>   };
>>>
>>>   /* Initialize the configuration and calibration registers. */
>>>   static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>>>   {
>>>       u16 regval;
>>> -    int ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
>>> +    int ret;
>> This form is considered acceptable in kernel code - but perhaps yours is
>> a tiny bit more readable so if you want to keep this one.
>>>
>>> -    if (ret < 0)
>>> +    ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
>>> +    if (ret)
>>>           return ret;
>> good
>>> +
>>>       /*
>>>        * Set current LSB to 1mA, shunt is in uOhms
>>>        * (equation 13 in datasheet). We hardcode a Current_LSB
>>> @@ -621,7 +624,7 @@ static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>>>        * to the user for now.
>>>        */
>>>       regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
>>> -                chip->shunt_resistor);
>>> +                   chip->shunt_resistor);
>> good
>>>
>>>       return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
>>>   }
>>> @@ -632,8 +635,8 @@ static int ina2xx_probe(struct i2c_client *client,
>>>       struct ina2xx_chip_info *chip;
>>>       struct iio_dev *indio_dev;
>>>       struct iio_buffer *buffer;
>>> -    int ret;
>>>       unsigned int val;
>>> +    int ret;
>> Again, don't care on this one.
>>>
>>>       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>>>       if (!indio_dev)
>>> @@ -641,8 +644,19 @@ static int ina2xx_probe(struct i2c_client *client,
>>>
>>>       chip = iio_priv(indio_dev);
>>>
>> All this reordering needs a detailed justification. It adds a lot of churn
>> for limited benefit.  I prefer the ordering you end up with, but is it
>> worth the noise?  Not to my mind.
> 
> I would say it is, keeping the initialization steps logically ordered and
> grouped, as opposed to randomly mixed, is very important for bug finding
> and for easier bug spotting during future development, it's also easier to
> read and follow/comprehend.
While the ordering is different from yours, I'm not convinced that it
is particularly less logical.  The level of churn in here, might make bug
finding ever so slightly easier, but at the cost of pretty much ensuring
any bug fixes never make it as back ports.
> 
>>> +    /* This is only used for device removal purposes. */
>>> +    i2c_set_clientdata(client, indio_dev);
>>> +
>>> +    chip->regmap = devm_regmap_init_i2c(client, &ina2xx_regmap_config);
>>> +    if (IS_ERR(chip->regmap)) {
>>> +        dev_err(&client->dev, "failed to allocate register map\n");
>>> +        return PTR_ERR(chip->regmap);
>>> +    }
>>> +
>>>       chip->config = &ina2xx_config[id->driver_data];
>>>
>>> +    mutex_init(&chip->state_lock);
>>> +
>>>       if (of_property_read_u32(client->dev.of_node,
>>>                    "shunt-resistor", &val) < 0) {
>>>           struct ina2xx_platform_data *pdata =
>>> @@ -658,25 +672,6 @@ static int ina2xx_probe(struct i2c_client *client,
>>>       if (ret)
>>>           return ret;
>>>
>>> -    mutex_init(&chip->state_lock);
>>> -
>>> -    /* This is only used for device removal purposes. */
>>> -    i2c_set_clientdata(client, indio_dev);
>>> -
>>> -    indio_dev->name = id->name;
>>> -    indio_dev->channels = ina2xx_channels;
>>> -    indio_dev->num_channels = ARRAY_SIZE(ina2xx_channels);
>>> -
>>> -    indio_dev->dev.parent = &client->dev;
>>> -    indio_dev->info = &ina2xx_info;
>>> -    indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>>> -
>>> -    chip->regmap = devm_regmap_init_i2c(client, &ina2xx_regmap_config);
>>> -    if (IS_ERR(chip->regmap)) {
>>> -        dev_err(&client->dev, "failed to allocate register map\n");
>>> -        return PTR_ERR(chip->regmap);
>>> -    }
>>> -
>>>       /* Patch the current config register with default. */
>>>       val = chip->config->config_default;
>>>
>>> @@ -687,24 +682,28 @@ static int ina2xx_probe(struct i2c_client *client,
>>>       }
>>>
>>>       ret = ina2xx_init(chip, val);
>>> -    if (ret < 0) {
>>> -        dev_err(&client->dev, "error configuring the device: %d\n",
>>> -            ret);
>>> -        return -ENODEV;
>>> +    if (ret) {
>> This change is good however.
>>
>>> +        dev_err(&client->dev, "error configuring the device\n");
>> Dropping the return value might be 'cleaner' in some sense, but I don't think
>> it's worth making the change.
> 
> We are returning the error code, so informing the user of its number every
> step in the error path leads to a lot of noise, we often end up with the
> number printed three or more times. I think it should only get printed by
> the last step in the chain that eats the number by not returning it though
> to another step.
> 
>>> +        return ret;
>>>       }
>>>
>>> +    indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>>> +    indio_dev->dev.parent = &client->dev;
>>> +    indio_dev->channels = ina2xx_channels;
>>> +    indio_dev->num_channels = ARRAY_SIZE(ina2xx_channels);
>>> +    indio_dev->name = id->name;
>>> +    indio_dev->info = &ina2xx_info;
>>> +    indio_dev->setup_ops = &ina2xx_setup_ops;
>>> +
>>>       buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
>>>       if (!buffer)
>>>           return -ENOMEM;
>>>
>>> -    indio_dev->setup_ops = &ina2xx_setup_ops;
>>> -
>>>       iio_device_attach_buffer(indio_dev, buffer);
>>>
>>>       return iio_device_register(indio_dev);
>>>   }
>>>
>>> -
>>>   static int ina2xx_remove(struct i2c_client *client)
>>>   {
>>>       struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>> @@ -717,7 +716,6 @@ static int ina2xx_remove(struct i2c_client *client)
>>>                     INA2XX_MODE_MASK, 0);
>>>   }
>>>
>>> -
>> good.
>>>   static const struct i2c_device_id ina2xx_id[] = {
>>>       {"ina219", ina219},
>>>       {"ina220", ina219},
>>> @@ -726,7 +724,6 @@ static const struct i2c_device_id ina2xx_id[] = {
>>>       {"ina231", ina226},
>>>       {}
>>>   };
>>> -
>> good
>>>   MODULE_DEVICE_TABLE(i2c, ina2xx_id);
>>>
>>>   static struct i2c_driver ina2xx_driver = {
>>> @@ -737,7 +734,6 @@ static struct i2c_driver ina2xx_driver = {
>>>       .remove = ina2xx_remove,
>>>       .id_table = ina2xx_id,
>>>   };
>>> -
>> good as well.
>>>   module_i2c_driver(ina2xx_driver);
>>>
>>>   MODULE_AUTHOR("Marc Titinger <marc.titinger@baylibre.com>");
>>>
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

