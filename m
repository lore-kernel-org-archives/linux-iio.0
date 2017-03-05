Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59467 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdCEKjW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 05:39:22 -0500
Subject: Re: [PATCH 3/4] iio: adc: Add max9611/9612 ADC driver
To: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, meerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
 <1487948756-25172-4-git-send-email-jacopo+renesas@jmondi.org>
 <61af9d83-ec8f-33f9-52b5-feb50b399edd@kernel.org>
 <09d7a846-caa5-711f-7602-ea84ff8bdda8@jmondi.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9ec90496-b71e-9f09-9202-7d38c95d0797@kernel.org>
Date: Sun, 5 Mar 2017 10:39:18 +0000
MIME-Version: 1.0
In-Reply-To: <09d7a846-caa5-711f-7602-ea84ff8bdda8@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/02/17 07:45, jacopo mondi wrote:
> Hi Jonathan,
>    thanks for review
> 
> On 25/02/2017 16:53, Jonathan Cameron wrote:
>> On 24/02/17 15:05, Jacopo Mondi wrote:
>>> Add iio driver for Maxim max9611/9612 current-sense amplifiers with
>>> 12-bits ADC.
>> Data sheet link always good
>>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> I'm going to respond to the cover letter wrt to providing dynamic scales
>> and offsets in a moment as you raised the question there.
>>
>> Otherwise, various bits and bobs inline.
>>
>> Interesting part to handle as it can read a lot of values that are useful only
>> after some magic calculations are done.
>>
>> Jonathan
>>> ---
>>>  drivers/iio/adc/Kconfig   |  10 +
>>>  drivers/iio/adc/Makefile  |   1 +
>>>  drivers/iio/adc/max961x.c | 648 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 659 insertions(+)
>>>  create mode 100644 drivers/iio/adc/max961x.c
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index dedae7a..f86026a 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -354,6 +354,16 @@ config MAX1363
>>>        To compile this driver as a module, choose M here: the module will be
>>>        called max1363.
>>>
>>> +config    MAX961x
>>> +    tristate "Maxim max9611/9612 ADC driver"
>>> +    depends on I2C
>>> +    help
>>> +      Say yes here to build support for Maxim max9611/9612 current sense
>>> +      amplifiers with 12-bits ADC interface.
>>> +
>>> +      To compile this driver as a module, choose M here: the module will be
>>> +      called max961x.
>>> +
>>>  config MCP320X
>>>      tristate "Microchip Technology MCP3x01/02/04/08"
>>>      depends on SPI
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index d001262..ff19250 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -34,6 +34,7 @@ obj-$(CONFIG_LTC2485) += ltc2485.o
>>>  obj-$(CONFIG_MAX1027) += max1027.o
>>>  obj-$(CONFIG_MAX11100) += max11100.o
>>>  obj-$(CONFIG_MAX1363) += max1363.o
>>> +obj-$(CONFIG_MAX961x) += max961x.o
>>>  obj-$(CONFIG_MCP320X) += mcp320x.o
>>>  obj-$(CONFIG_MCP3422) += mcp3422.o
>>>  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
>>> diff --git a/drivers/iio/adc/max961x.c b/drivers/iio/adc/max961x.c
>>> new file mode 100644
>>> index 0000000..a544e69
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/max961x.c
>>> @@ -0,0 +1,648 @@
>>> +/*
>>> + * iio/adc/max961x.c
>>> + *
>>> + * Maxim max9611/9612 high side current sense amplifier with
>>> + * 12-bit ADC interface.
>>> + *
>>> + * Copyright (C) 2017 Jacopo Mondi
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +/*
>>> + * This driver supports input common-mode voltage, current-sense
>>> + * amplifier with programmable gains and die temperature reading from
>>> + * Maxim max9611/9612.
>>> + * Op-amp, analog comparator, and watchdog functionalities are not
>>> + * supported by this driver.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/module.h>
>>> +
>>> +#define DRIVER_NAME "max961x"
>>> +
>>> +/* max961x register addresses */
>> Prefix these with MAX9611_ to avoid possible clashes in future.
>>
> 
> I initially did, then removed that to counterbalance my tendency to be a bit verbose in naming stuff.
> 
> I'll use the MAX9611_ prefix where appropriate
> 
>>> +#define REG_CSA_DATA            0x00
> [snip
>>> +      .info_mask_separate    = BIT(IIO_CHAN_INFO_RAW) |
>>> +                  BIT(IIO_CHAN_INFO_SCALE) |
>> The only cases we normally allow bother raw and processed output in
>> are ones where we are supporting some defunct (i.e. wrong usage) in the
>> userspace ABI.  So drop the processed path please.
> 
> Will do
> 
>>
>>> +                  BIT(IIO_CHAN_INFO_PROCESSED),
>>> +      .address        = MAX961x_CHAN_TEMPERATURE,
>>> +    },
>>> +    { /* [1] common voltage input */
>>> +      .type            = IIO_VOLTAGE,
>>> +      .info_mask_separate    = BIT(IIO_CHAN_INFO_RAW) |
>>> +                  BIT(IIO_CHAN_INFO_SCALE) |
>>> +                  BIT(IIO_CHAN_INFO_OFFSET),
>>> +      .address        = MAX961x_CHAN_VOLTAGE_INPUT,
>>> +      .channel        = MAX961x_CHAN_VOLTAGE_INPUT,
>> For the channel it would be easier to read perhaps if you just put
>> the 0 in directly here.
>>> +      .indexed        = 1,
>>> +    },
>>> +    { /* [2] current sense amplifier voltage output */
>>> +      .type            = IIO_VOLTAGE,
>>> +      .info_mask_separate    = BIT(IIO_CHAN_INFO_RAW) |
>>> +                  BIT(IIO_CHAN_INFO_SCALE) |
>>> +                  BIT(IIO_CHAN_INFO_OFFSET),
>>> +      .address        = MAX961x_CHAN_VOLTAGE_SENSE,
>>> +      .channel        = MAX961x_CHAN_VOLTAGE_SENSE,
>>> +      .indexed        = 1,
>>> +    },
>>
>> As you say, the next one is a computed channel.
>>> +    { /* [3] load current measurement */
>>> +      .type            = IIO_CURRENT,
>>> +      .info_mask_separate    = BIT(IIO_CHAN_INFO_RAW) |
>>> +                  BIT(IIO_CHAN_INFO_SCALE),
>>> +      .address        = MAX961x_CHAN_CURRENT_LOAD,
>>> +    },
>> As is this one.
> 
> It's not clear to me if the fact of being a "computed channel" implies I have to use a different channel type to expose it (and, what channel type should I use in place of _RAW and _SCALE).

Basically boils down to whether the conversion is linear or not.  Doesn't
strictly speaking havie antyhing to do with whether it is computed from
a number of inputs or not. If the conversion is linear then leave it to
userspace (_raw and _scale + _offset if needed).  If it's non linear we
have no way to describe it so we have to do it in kernel and use _processed.

However, another element applies.  If either the scale or offset is not
independent of the reading (i.e. we can't cache a value indefinitely in
userspace code and expect it not to change unless userspace asks it to)
then we should wrap that up in the kernel and just used a processed output
directly. Otherwise userspace can not be sure it got a valid set of values
from which to compute the real reading.

> Please not my question is independent on the auto-gain discussion started in response the patch series cover letter.
> 
>>> +    { /* [4] load current measurement */
>>> +      .type            = IIO_POWER,
>>> +      .info_mask_separate    = BIT(IIO_CHAN_INFO_RAW) |
>>> +                  BIT(IIO_CHAN_INFO_SCALE),
>>> +      .address        = MAX961x_CHAN_POWER_LOAD,
>>> +    },
>>> +};
>>> +
>>> +static int max961x_reg_read(struct max961x_dev *max961x, u8 reg, u16 *val)
>>> +{
>> I'm not convinced this particular wrapper adds anything.
>> I'd be tempted to just use the i2c read directly as needed rather than
>> bounce through this.
>>
> 
> I would say "inline it then", but I'm not sure trying to outsmart complier is desirable.

My issue is that the wrapper adds code that needs to be reviewed, with no
actual benefit given it's a direct and simple call to the i2c core.
> 
>>> +    int ret;
>>> +
>>> +    ret = i2c_smbus_read_word_swapped(max961x->i2c_client, reg);
>>> +    if (ret < 0) {
>>> +        dev_err(max961x->dev, "i2c read word from 0x%2x failed\n",
>>> +            reg);
>>> +        return ret;
>>> +    }
>>> +
>>> +    *val = ret;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int max961x_reg_write(struct max961x_dev *max961x, u8 reg, u8 val)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = i2c_smbus_write_byte_data(max961x->i2c_client, reg, val);
>>> +    if (ret) {
>>> +        dev_err(max961x->dev, "i2c write byte failed: 0x%2x - 0x%2x\n",
>>> +            reg, val);
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* FIXME: need a delay here to make register configuration
>>> +     *      stabilize. 1 msec at least, from empirical testing.
>> Why fixme?  Sounds like it really needs to be the case to me!
>>
>> Also, fix up your multiline comment syntax please.
> 
> It's a FIXME as I found that out after some testing, I'm not sure about the root cause yet.
> But yes, it's required to have driver work properly, so I'll drop this
> 
>>> +     */
>>> +    usleep_range(1000, 2000);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * max961x_read_single() - read a single vale from ADC interface
>>> + *
>>> + * Data registers are 16 bit long, spread between two 8 bit registers
>>> + * with consecutive addresses.
>>> + * Configure ADC mux first, then read register at address "reg_addr".
>>> + * The smbus_read_word routine asks for 16 bits and the ADC is kind enough
>>> + * to return values from "reg_addr" and "reg_addr + 1" consecutively.
>>> + *
>>> + * @max961x: max961x device
>>> + * @selector: index for mux and register configuration
>>> + * @raw_val: the value returned from ADC
>>> + */
>>> +static int max961x_read_single(struct max961x_dev *max961x,
>>> +                   enum max961x_conf_ids selector,
>>> +                   u16 *raw_val)
>>> +{
>>> +    int ret;
>>> +
>>> +    u8 mux_conf = max961x_conf[selector][0] & MUX_MASK;
>>> +    u8 reg_addr = max961x_conf[selector][1];
>>> +
>> You have no lockign around these various sequences.
>> Nothing prevents multiple sysfs reads at the same time so you definitely
>> want to prevent this stuff from running concurrently.
>>
>> A mutex should do the job, either at this low level or up in the calling
>> functions.
> 
> I had verified the i2c_smbus_  functions where protected by their own mutexes and thought that was enough.
That protects the bus, but not a interacting sequences like this.  Could
easily have two running in parallel.

> But yes, read and writes here shall be protected as well. Will re-add mutex back then
> 
> 
>>> +    ret = max961x_reg_write(max961x, REG_CTRL1, mux_conf);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = max961x_reg_read(max961x, reg_addr, raw_val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * max961x_read_csa_voltage() - read current sense amplifier output voltage
>>> + *
>>> + * Current sense amplifier output voltage is read through a configurable
>>> + * 1x, 4x or 8x gain.
>>> + * Start with plain 1x gain, and adjust gain control properly until a
>>> + * meaningful value is read from ADC output.
>>> + *
>>> + * @max961x: max961x device
>>> + * @adc_raw: raw value read from ADC output
>>> + * @csa_gain: gain configuration option selector
>>> + */
>>> +static int max961x_read_csa_voltage(struct max961x_dev *max961x,
>>> +                    u16 *adc_raw,
>>> +                    enum max961x_csa_gain *csa_gain)
>>> +{
>>> +    int ret;
>>> +    unsigned int i;
>>> +    enum max961x_conf_ids gain_selectors[] = {
>>> +        CONF_SENSE_1x,
>>> +        CONF_SENSE_4x,
>>> +        CONF_SENSE_8x
>>> +    };
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(gain_selectors); ++i) {
>>> +        ret = max961x_read_single(max961x, gain_selectors[i], adc_raw);
>>> +        if (ret)
>>> +            return ret;
>>> +
>>> +        if (*adc_raw > 0) {
>>> +            *csa_gain = gain_selectors[i];
>>> +            return 0;
>>> +        }
>>> +    }
>>> +
>>> +    return -EIO;
>>> +}
>>> +
>>> +static int max961x_read_raw(struct iio_dev *indio_dev,
>>> +                struct iio_chan_spec const *chan,
>>> +                int *val, int *val2, long mask)
>>> +{
>>> +    int ret;
>>> +    u16 adc_data;
>>> +    enum max961x_csa_gain gain_selector;
>>> +    unsigned int *csa_gain;
>>> +    struct max961x_dev *dev = iio_priv(indio_dev);
>>> +
>>> +    switch (mask) {
>>> +    case IIO_CHAN_INFO_RAW:
>>> +        switch (chan->address) {
>>> +        case MAX961x_CHAN_TEMPERATURE:
>>> +            ret = max961x_read_single(dev, CONF_TEMP,
>>> +                          &adc_data);
>>> +            if (ret)
>>> +                return ret;
>>> +
>>> +            *val = TEMP_RAW(adc_data);
>>> +
>>> +            return IIO_VAL_INT;
>>> +
>>> +        case MAX961x_CHAN_VOLTAGE_INPUT:
>>> +            ret = max961x_read_single(dev, CONF_IN_VOLT,
>>> +                          &adc_data);
>>> +            if (ret)
>>> +                return ret;
>>> +
>>> +            *val = MAX961x_VOLTAGE_RAW(adc_data);
>>> +
>>> +            return IIO_VAL_INT;
>>> +
>>> +        case MAX961x_CHAN_VOLTAGE_SENSE:
>>> +            ret = max961x_read_csa_voltage(dev, &adc_data,
>>> +                               &gain_selector);
>>> +            if (ret)
>>> +                return ret;
>>> +
>>> +            *val = MAX961x_VOLTAGE_RAW(adc_data);
>>> +
>>> +            return IIO_VAL_INT;
>>> +
>>> +        case MAX961x_CHAN_CURRENT_LOAD:
>>> +            /* raw (nV): raw * LSB (nV) */
>>> +            ret = max961x_read_csa_voltage(dev, &adc_data,
>>> +                               &gain_selector);
>>> +            if (ret)
>>> +                return ret;
>>> +
>>> +            csa_gain = max961x_gain_conf[gain_selector];
>>> +
>>> +            *val = MAX961x_VOLTAGE_RAW(adc_data) *
>>> +                   csa_gain[CSA_GAIN_LSB_nV];
>>> +
>>> +            return IIO_VAL_INT;
>>> +
>>> +        case MAX961x_CHAN_POWER_LOAD:
>>> +            /* raw (mV): raw * LSB (mV) */
>>> +            ret = max961x_read_single(dev, CONF_IN_VOLT,
>>> +                          &adc_data);
>>> +
>>> +            *val = MAX961x_VOLTAGE_RAW(adc_data) *
>>> +                   CIM_VOLTAGE_LSB_mV;
>>> +
>>> +            return IIO_VAL_INT;
>>> +        }
>>> +
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +        switch (chan->address) {
>>> +
>>> +        case MAX961x_CHAN_TEMPERATURE:
>>> +            /* processed (C): raw * scale (C) */
>>> +            *val = TEMP_SCALE_NUM;
>>> +            *val2 = TEMP_SCALE_DIV;
>>> +
>>> +            return IIO_VAL_FRACTIONAL;
>>> +
>>> +        case MAX961x_CHAN_VOLTAGE_INPUT:
>>> +            /* processed (mV): raw * scale_mV */
>> Err, I'm confused.  We read adc_data then do nothing with it?
> 
> leftover, sorry about this...
> 
>>> +            ret = max961x_read_single(dev, CONF_IN_VOLT,
>>> +                          &adc_data);
>>> +            if (ret)
>>> +                return ret;
>>> +
>>> +            *val = CIM_VOLTAGE_LSB_mV;
>>> +
>>> +            return IIO_VAL_INT;
>>> +
>>> +        case MAX961x_CHAN_VOLTAGE_SENSE:
>>> +            /* processed (mV): raw (mV) * (scale (nV) / 10^6) */
>>> +            ret = max961x_read_csa_voltage(dev, &adc_data,
>>> +                               &gain_selector);
>>> +            if (ret)
>>> +                return ret;
>> As with the offset below, this is a non starter to my mind as we have
>> no way of knowing it was the 'same' gain value.  That has to be the case
>> or we'll get all sorts of horrible instabilities in apparent output as
>> we pass from one gain setting to another.
> 
> Let's keep discussing this in response to the cover letter
> 
>>> +
>>> +            csa_gain = max961x_gain_conf[gain_selector];
>>> +
>>> +            *val = csa_gain[CSA_GAIN_LSB_nV];
>>> +            *val2 = 1000000;
>>> +
>>> +            return IIO_VAL_FRACTIONAL;
>>> +
>>> +        case MAX961x_CHAN_CURRENT_LOAD:
>>> +            /* processed (mA): raw (nV)  / scale (uOhm)  */
>>> +            *val = 1;
>>> +            *val2 = dev->shunt_resistor_uOhm;
>>> +
>>> +            return IIO_VAL_FRACTIONAL;
>>> +
>>> +        case MAX961x_CHAN_POWER_LOAD:
>>> +            /* processed (mW): raw (mV) * (scale (mA) / 1000) */
>>> +            ret = max961x_read_csa_voltage(dev, &adc_data,
>>> +                               &gain_selector);
>> Again, nothing says the gain_selector value is the one used when we
>> took the measurement (or will be if we take it in future) so we can't do
>> it this way.  Either we need to remove the computed value and provide
>> enough info to userspace to allow it to do the job, or we need to ensure
>> that the kernel data manipulation doesn't allow for any instabilities around
>> gain transitions.
>>> +            if (ret)
>>> +                return ret;
>>> +
>>> +            csa_gain = max961x_gain_conf[gain_selector];
>>> +
>>> +            /* val = (nV / uOhm) = mA */
>>> +            *val = MAX961x_VOLTAGE_RAW(adc_data) *
>>> +                   csa_gain[CSA_GAIN_LSB_nV];
>>> +            *val /= dev->shunt_resistor_uOhm;
>>> +
>>> +            *val2 = 1000;
>>> +
>>> +            return IIO_VAL_FRACTIONAL;
>>> +        }
>>> +
>>> +    case IIO_CHAN_INFO_OFFSET:
>>> +        switch (chan->address) {
>>> +        case MAX961x_CHAN_VOLTAGE_INPUT:
>>> +            *val = CIM_VOLTAGE_OFFSET_RAW;
>>> +
>>> +            return IIO_VAL_INT;
>>> +
>>> +        case MAX961x_CHAN_VOLTAGE_SENSE:
>> Interesting. Nothing here ensures the reported scale is correct for
>> the reading we are looking it up for which is an issue.
>>
>> For a compound value - i.e. one where the userspace interpretation is
>> dependent on several different readings (the classic being light sensors
>> where illuminance is often computed from two different light sensing
>> elementents) we tend to hide the complexity by doing it in kernel.
>>
>> So my gut feeling is this should be hidden away.  That should ensure
>> the value used is the correct one as well.
>>
>>> +            ret = max961x_read_csa_voltage(dev, &adc_data,
>>> +                               &gain_selector);
>>> +            if (ret)
>>> +                return ret;
>>> +
>>> +            *val = max961x_gain_conf[gain_selector]
>>> +                        [CSA_GAIN_OFFS_RAW];
>>> +            *val2 = 1000;
>>> +
>>> +            return IIO_VAL_FRACTIONAL;
>>> +        }
>>> +
>>
>> As stated above, please drop this as userspace can do this trivially from
>> the raw and scale provided.
> 
> I agree that the offset may not match values returned from _raw and _scale (because of the auto-gain selection), but how can userspace retrieve offset from _raw and _scale if not opening the device datasheet?

Two crossed bits of review here.  If it had been the case that raw and
scale were fixed then having this made no sense.  As it turns out the
opposite is true, so we should not have raw output for any channels where
the scale might change.  Sorry I should have cleaned this comment up
after I understood what was going on in more detail.
> 
>>> +    case IIO_CHAN_INFO_PROCESSED:
>>> +        /* processed (mC): raw * LSB (mC) */
>>> +        if (chan->address != MAX961x_CHAN_TEMPERATURE)
>>> +            return -EINVAL;
>>> +
>>> +        ret = max961x_read_single(dev, CONF_TEMP,
>>> +                      &adc_data);
>>> +        if (ret)
>>> +            return ret;
>>> +
>>> +        *val = TEMP_RAW(adc_data) * TEMP_LSB_mC;
>>> +
>>> +        return IIO_VAL_INT;
>>> +    }
>>> +
>>> +    return -EINVAL;
>>> +}
>>> +
>>> +static ssize_t max961x_shunt_resistor_show(struct device *dev,
>>> +                       struct device_attribute *attr,
>>> +                       char *buf)
>>> +{
>>> +    struct max961x_dev *max961x = iio_priv(dev_to_iio_dev(dev));
>>> +
>>> +    return sprintf(buf, "%d\n", max961x->shunt_resistor_uOhm);
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(in_shunt_resistor, S_IRUGO,
>>> +               max961x_shunt_resistor_show, NULL, 0);
>>> +
>>> +static struct attribute *max961x_attributes[] = {
>>> +    &iio_dev_attr_in_shunt_resistor.dev_attr.attr,
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct attribute_group max961x_attribute_group = {
>>> +    .attrs = max961x_attributes,
>>> +};
>>> +
>>> +static const struct iio_info indio_info = {
>>> +    .driver_module    = THIS_MODULE,
>>> +    .read_raw    = max961x_read_raw,
>>> +    .attrs        = &max961x_attribute_group,
>>> +};
>>> +
>>> +static int max961x_init(struct max961x_dev *max961x)
>>> +{
>>> +    int ret;
>>> +    u16 regval;
>>> +    struct i2c_client *client = max961x->i2c_client;
>>> +
>>> +    if (!i2c_check_functionality(client->adapter,
>>> +                     I2C_FUNC_SMBUS_WRITE_BYTE    |
>>> +                     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
>>> +        dev_err(max961x->dev,
>>> +            "I2c adapter does not support smbus write_byte and "\
>> Whilst it'll break the 80 char limit by quite a way, it's preferable to do that
>> than to break the ability of someone to grep for an error message.  So keep
>> this on one line please.
> 
> I'll make this less verbose.
Can do or just have a long line!
> 
>>> +            "read_word_data functionalities. Aborting probe.\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    max961x_reg_write(max961x, REG_CTRL1, MUX_TEMPERATURE);
>>> +    max961x_reg_write(max961x, REG_CTRL2, 0);
>>> +
>>> +    /* Make sure die temperature is in range to test communications. */
>>> +    regval = 0;
>>> +    ret = max961x_reg_read(max961x, REG_TEMP_DATA, &regval);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    regval = regval & ~TEMP_MASK;
>>> +    if ((regval > TEMP_MAX_RAW_POS &&
>>> +         regval < TEMP_MIN_RAW_NEG) ||
>>> +         regval > TEMP_MAX_RAW_NEG) {
>>> +        dev_err(max961x->dev,
>>> +            "In-valid value received from ADC 0x%4x: aborting\n",
>>> +            regval);
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    /* Mux shall be zeroed back before applying other configurations */
>>> +    max961x_reg_write(max961x, REG_CTRL1, 0);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int max961x_probe(struct i2c_client *client,
>>> +             const struct i2c_device_id *id)
>>> +{
>>> +    int ret;
>>> +    struct max961x_dev *max961x;
>>> +    struct iio_dev *indio_dev;
>>> +    struct device_node *of_node = client->dev.of_node;
>>> +    unsigned int of_shunt;
>>> +    const char * const shunt_res_prop = "shunt-resistor";
>>> +
>>> +    indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max961x));
>>> +    if (IS_ERR(indio_dev))
>>> +        return PTR_ERR(indio_dev);
>>> +
>>> +    i2c_set_clientdata(client, indio_dev);
>>> +
>>> +    max961x        = iio_priv(indio_dev);
>>> +    max961x->dev    = &client->dev;
>>> +    max961x->i2c_client = client;
>>> +
>>> +    ret = of_property_read_u32(of_node, shunt_res_prop, &of_shunt);
>>> +    if (ret) {
>>> +        dev_err(&client->dev,
>>> +            "Missing %s property for %s node\n",
>>> +            shunt_res_prop, of_node->full_name);
>>> +        return ret;
>>> +    }
>>> +    max961x->shunt_resistor_uOhm = of_shunt;
>>> +
>>> +    ret = max961x_init(max961x);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    indio_dev->dev.parent    = &client->dev;
>>> +    indio_dev->dev.of_node    = client->dev.of_node;
>>> +    indio_dev->name        = DRIVER_NAME;
>>> +    indio_dev->modes    = INDIO_DIRECT_MODE;
>>> +    indio_dev->info        = &indio_info;
>>> +    indio_dev->channels    = max961x_channels;
>>> +    indio_dev->num_channels    = ARRAY_SIZE(max961x_channels);
>>> +
>>> +    ret = devm_iio_device_register(&client->dev, indio_dev);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    dev_info(&client->dev, "%s: probed\n", DRIVER_NAME);
>> This one is always hotly debated.  To my mind, this provides
>> no information, but if you are particularly attached to it I don't
>> really mind.  If not, then return devm_iio_* directly.
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int max961x_remove(struct i2c_client *client)
>>> +{
>>> +    struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>> +
>>> +    iio_device_unregister(indio_dev);
>> If all you have in a remove function is a call to iio_device_unregister
>> my immediate thought is could you use devm_iio_device_register.
>>
>> Ah, you are.  Double unregister!  If you are using the devm form of register
>> it will be unregistered automatically as part of the removal of the
>> underlying struct device.  Thus you don't need to do it explicitly.
>>
>> Thus you can drop this remove function completely as it should be
>> empty.
> 
> Uh that's bad. I added the remove just before sending this out and tried to insert remove the module a couple of time without visible issues (I guess a double unregister fails silently then)
> I'll drop this...
> 
> 
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct of_device_id max961x_of_table[] = {
>>> +    {.compatible = "maxim,max961x"},
>> Already been raised in the bindings reviews, but you shouldn't
>> use wild cards in compatible strings.
>>
>> Actually as it almost always goes wrong, you shouldn't used them
>> for naming of anything.  Pick a part and use that were you
>> currently have max961x throughout the driver.
>>
>> i.e. max9611_of_table etc.
>>
>> Avoids possible issues down the line when maxim decide to
>> release something incompatible and call it a max9619..
> 
> I'll use max9611 everywhere I can, and add 2 "compatible" entries for both max9611 and max9612.
Cool
> 
> Thanks
>    j
> 
> 
>>> +    { },
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(of, max961x_of_table);
>>> +
>>> +static struct i2c_driver max961x_driver = {
>>> +    .driver = {
>>> +           .name = DRIVER_NAME,
>>> +           .owner = THIS_MODULE,
>>> +           .of_match_table = max961x_of_table,
>>> +    },
>>> +    .probe = max961x_probe,
>>> +    .remove = max961x_remove,
>>> +};
>>> +module_i2c_driver(max961x_driver);
>>> +
>>> +MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org>");
>>> +MODULE_DESCRIPTION("Maxim max9611/12 current sense amplifier with 12bit ADC");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

