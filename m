Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39851 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbdABSIn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 13:08:43 -0500
Subject: Re: [PATCH v6 9/9] misc: mux-adg792a: add mux controller driver for
 ADG792A/G
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-10-git-send-email-peda@axentia.se>
 <fb8a7864-a6cf-351f-b9c5-a5036c30474e@kernel.org>
 <df2f2896-8fde-09a9-add5-ded77234a66e@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1b614d4e-1b81-3c47-c95d-1b26b29a3d1c@kernel.org>
Date: Mon, 2 Jan 2017 18:08:40 +0000
MIME-Version: 1.0
In-Reply-To: <df2f2896-8fde-09a9-add5-ded77234a66e@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/17 11:00, Peter Rosin wrote:
> On 2017-01-01 12:24, Jonathan Cameron wrote:
>> On 30/11/16 08:17, Peter Rosin wrote:
>>> Analog Devices ADG792A/G is a triple 4:1 mux.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> Looks pretty good. Some minor suggestions inline.
>>
>> This convinced me of two things:
>> 1. Need a separate subsystem directory for muxes - having them under misc
>> is going to lead to long term mess.
>> 2. Devm alloc and registration functions will make the drivers all simpler.
> 
> Ok, I'm making the move to drivers/mux/* for v7 and adding more devm_*
> functions.
> 
>> Also, browsing through ADIs list of muxes and switches it's clear that
>> one classic case will be where an i2c octal or similar switch is used with
>> outputs wired together in weird combinations to act as a mux.  Going to
>> be 'fun' describing that.
>>
>> There are also potentially cross point switches to be described ;)
>> (I had to look up what one of those was ;)
>>
>> Crosspoints aren't implausible as front ends for ADCs as you might
>> want to be able rapidly sample any 2 of say 16 channels coming from
>> for example a max14661.  We'd have to figure out how to add buffered
>> capture support with sensible restrictions to the iio-mux driver
>> to do that - realistically I think we would just not allow buffered
>> capture with the mux having to switch.  Without hardware support
>> (i.e. an ADC with external mux control) it would be too slow.
>>
>> Always good to bury some idle thoughts deep in the review of a random
>> driver ;) I'll never be able to remember where they were let alone
>> anyone else.
> 
> But that's switches, and this is muxes. Switches are way more flexible,
> so it's only natural that they are on a completely different level when
> it comes to trying a generic description of them... Intentionally not
> going there :-)
A switch is just a load of muxes (one per output) with the inputs
wired together. All a matter of definition!
> 
>>> ---
>>>  drivers/misc/Kconfig       |  12 ++++
>>>  drivers/misc/Makefile      |   1 +
>>>  drivers/misc/mux-adg792a.c | 154 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 167 insertions(+)
>>>  create mode 100644 drivers/misc/mux-adg792a.c
>>>
>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>> index 2ce675e410c5..45567a444bbf 100644
>>> --- a/drivers/misc/Kconfig
>>> +++ b/drivers/misc/Kconfig
>>> @@ -780,6 +780,18 @@ menuconfig MULTIPLEXER
>>>  
>>>  if MULTIPLEXER
>>>  
>>> +config MUX_ADG792A
>>> +	tristate "Analog Devices ADG792A/ADG792G Multiplexers"
>>> +	depends on I2C
>>> +	help
>>> +	  ADG792A and ADG792G Wide Bandwidth Triple 4:1 Multiplexers
>>> +
>>> +	  The driver supports both operating the three multiplexers in
>>> +	  parellel and operating them independently.
>> parallel
>>> +
>>> +	  To compile the driver as a module, choose M here: the module will
>>> +	  be called mux-adg792a.
>>> +
>>>  config MUX_GPIO
>>>  	tristate "GPIO-controlled Multiplexer"
>>>  	depends on OF && GPIOLIB
>>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>>> index 0befa2bba762..10ab8d34c9e5 100644
>>> --- a/drivers/misc/Makefile
>>> +++ b/drivers/misc/Makefile
>>> @@ -54,6 +54,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
>>>  obj-$(CONFIG_CXL_BASE)		+= cxl/
>>>  obj-$(CONFIG_PANEL)             += panel.o
>>>  obj-$(CONFIG_MULTIPLEXER)      	+= mux-core.o
>>> +obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
>>>  obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
>>>  
>>>  lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
>>> diff --git a/drivers/misc/mux-adg792a.c b/drivers/misc/mux-adg792a.c
>>> new file mode 100644
>>> index 000000000000..7d309a78af65
>>> --- /dev/null
>>> +++ b/drivers/misc/mux-adg792a.c
>>> @@ -0,0 +1,154 @@
>>> +/*
>>> + * Multiplexer driver for Analog Devices ADG792A/G Triple 4:1 mux
>>> + *
>>> + * Copyright (C) 2016 Axentia Technologies AB
>>> + *
>>> + * Author: Peter Rosin <peda@axentia.se>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mux.h>
>>> +
>>> +#define ADG792A_LDSW		BIT(0)
>>> +#define ADG792A_RESET		BIT(1)
>>> +#define ADG792A_DISABLE(mux)	(0x50 | (mux))
>>> +#define ADG792A_DISABLE_ALL	(0x5f)
>>> +#define ADG792A_MUX(mux, state)	(0xc0 | (((mux) + 1) << 2) | (state))
>>> +#define ADG792A_MUX_ALL(state)	(0xc0 | (state))
>>> +
>>> +#define ADG792A_DISABLE_STATE	(4)
>>> +#define ADG792A_KEEP_STATE	(5)
>>> +
>>> +static int adg792a_set(struct mux_control *mux, int state)
>>> +{
>>> +	struct i2c_client *i2c = to_i2c_client(mux->chip->dev.parent);
>>> +	u8 cmd;
>>> +
>>> +	if (mux->chip->controllers == 1) {
>>> +		/* parallel mux controller operation */
>>> +		if (state == ADG792A_DISABLE_STATE)
>>> +			cmd = ADG792A_DISABLE_ALL;
>>> +		else
>>> +			cmd = ADG792A_MUX_ALL(state);
>>> +	} else {
>>> +		unsigned int controller = mux_control_get_index(mux);
>>> +
>>> +		if (state == ADG792A_DISABLE_STATE)
>>> +			cmd = ADG792A_DISABLE(controller);
>>> +		else
>>> +			cmd = ADG792A_MUX(controller, state);
>>> +	}
>>> +
>>> +	return i2c_smbus_write_byte_data(i2c, cmd, ADG792A_LDSW);
>>> +}
>>> +
>>> +static const struct mux_control_ops adg792a_ops = {
>>> +	.set = adg792a_set,
>>> +};
>>> +
>>> +static int adg792a_probe(struct i2c_client *i2c,
>>> +			 const struct i2c_device_id *id)
>>> +{
>>> +	struct device *dev = &i2c->dev;
>>> +	struct mux_chip *mux_chip;
>>> +	bool parallel;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	parallel = of_property_read_bool(i2c->dev.of_node, "adi,parallel");
>>> +
>>> +	mux_chip = mux_chip_alloc(dev, parallel ? 1 : 3, 0);
>> This makes me wonder if we can have a more generic binding.
>> mux-poles = 3 vs mux-poles = 1?
> 
> The adg729 in theory allows to create one double pole mux and one single
> pole mux (three variations, depending on which mux is single pole).
> However, I did not put all that much effort into this driver. It is
> mainly a proof of concept, as mentioned in the cover letter, to "prove"
> that the proposed mux bindings are valid and that it is right to
> have separate mux nodes in devicetree. I'm not even sure it should
> be going upstream as it has seen zero testing. (But hey, it builds, what
> can be wrong?)
> 
>>> +	if (!mux_chip)
>>> +		return -ENOMEM;
>>> +
>>> +	mux_chip->ops = &adg792a_ops;
>>> +	dev_set_drvdata(dev, mux_chip);
>>> +
>>> +	ret = i2c_smbus_write_byte_data(i2c, ADG792A_DISABLE_ALL,
>>> +					ADG792A_RESET | ADG792A_LDSW);
>>> +	if (ret < 0)
>>> +		goto free_mux_chip;
>>> +
>>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>>> +		struct mux_control *mux = &mux_chip->mux[i];
>>> +		u32 idle_state;
>>> +
>>> +		mux->states = 4;
>>> +
>>> +		ret = of_property_read_u32_index(i2c->dev.of_node,
>>> +						 "adi,idle-state", i,
>>> +						 &idle_state);
>>> +		if (ret >= 0) {
>>> +			if (idle_state > ADG792A_KEEP_STATE) {
>>> +				dev_err(dev, "invalid idle-state %u\n",
>>> +					idle_state);
>>> +				ret = -EINVAL;
>>> +				goto free_mux_chip;
>>> +			}
>>> +			if (idle_state != ADG792A_KEEP_STATE)
>>> +				mux->idle_state = idle_state;
>>> +		}
>>> +	}
>>> +
>>> +	ret = mux_chip_register(mux_chip);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "failed to register mux-chip\n");
>>> +		goto free_mux_chip;
>>> +	}
>>> +
>>> +	if (parallel)
>>> +		dev_info(dev, "1 triple 4-way mux-controller registered\n");
>> I'd use the relay / switch standard description for this so 
>> 'triple pole, quadruple throw mux registered'.
>>> +	else
>>> +		dev_info(dev, "3 4-way mux-controllers registered\n");
>> '3x single pole, quadruple throw muxes registered'.
> 
> Ok, fine by me.
> 
>>> +
>>> +	return 0;
>>> +
>>> +free_mux_chip:
>>> +	mux_chip_free(mux_chip);
>>> +	return ret;
>>> +}
>>> +
>>> +static int adg792a_remove(struct i2c_client *i2c)
>>> +{
>>> +	struct mux_chip *mux_chip = dev_get_drvdata(&i2c->dev);
>>> +
>> Definitely looking like it's worth managed versions of mux_chip_register and
>> mux_chip_alloc given this is another case where they would let us get rid
>> of the remove function entirely.
>>> +	mux_chip_unregister(mux_chip);
>>> +	mux_chip_free(mux_chip);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct i2c_device_id adg792a_id[] = {
>>> +	{ .name = "adg792a", },
>>> +	{ .name = "adg792g", },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, adg792a_id);
>>> +
>>> +static const struct of_device_id adg792a_of_match[] = {
>>> +	{ .compatible = "adi,adg792a", },
>>> +	{ .compatible = "adi,adg792g", },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, adg792a_of_match);
>>> +
>>> +static struct i2c_driver adg792a_driver = {
>>> +	.driver		= {
>>> +		.name		= "adg792a",
>>> +		.of_match_table = of_match_ptr(adg792a_of_match),
>>> +	},
>>> +	.probe		= adg792a_probe,
>>> +	.remove		= adg792a_remove,
>>> +	.id_table	= adg792a_id,
>>> +};
>>> +module_i2c_driver(adg792a_driver);
>>> +
>>> +MODULE_DESCRIPTION("Analog Devices ADG792A/G Triple 4:1 mux driver");
>>> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
> 

