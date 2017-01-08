Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43286 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938018AbdAHKdC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 05:33:02 -0500
Subject: Re: [PATCH v7 12/12] mux: adg792a: add mux controller driver for
 ADG792A/G
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-13-git-send-email-peda@axentia.se>
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
Message-ID: <05649ac9-0129-baad-4d0c-b65364df546a@kernel.org>
Date: Sun, 8 Jan 2017 10:32:59 +0000
MIME-Version: 1.0
In-Reply-To: <1483532187-28494-13-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/17 12:16, Peter Rosin wrote:
> Analog Devices ADG792A/G is a triple 4:1 mux.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>

A nice little driver.  Hopefully this example will do the job of
convincing people a subsystem makes sense!

Jonathan
> ---
>  drivers/mux/Kconfig       |  12 ++++
>  drivers/mux/Makefile      |   1 +
>  drivers/mux/mux-adg792a.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 182 insertions(+)
>  create mode 100644 drivers/mux/mux-adg792a.c
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index de5a35ffe7af..39b06e19aa96 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -16,6 +16,18 @@ menuconfig MULTIPLEXER
>  
>  if MULTIPLEXER
>  
> +config MUX_ADG792A
> +	tristate "Analog Devices ADG792A/ADG792G Multiplexers"
> +	depends on I2C
> +	help
> +	  ADG792A and ADG792G Wide Bandwidth Triple 4:1 Multiplexers
> +
> +	  The driver supports both operating the three multiplexers in
> +	  parallel and operating them independently.
> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called mux-adg792a.
> +
>  config MUX_GPIO
>  	tristate "GPIO-controlled Multiplexer"
>  	depends on OF && GPIOLIB
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
> index facc43da3648..fddbb073fc77 100644
> --- a/drivers/mux/Makefile
> +++ b/drivers/mux/Makefile
> @@ -3,4 +3,5 @@
>  #
>  
>  obj-$(CONFIG_MULTIPLEXER)      	+= mux-core.o
> +obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
>  obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
> diff --git a/drivers/mux/mux-adg792a.c b/drivers/mux/mux-adg792a.c
> new file mode 100644
> index 000000000000..c6d5c4571e7c
> --- /dev/null
> +++ b/drivers/mux/mux-adg792a.c
> @@ -0,0 +1,169 @@
> +/*
> + * Multiplexer driver for Analog Devices ADG792A/G Triple 4:1 mux
> + *
> + * Copyright (C) 2016 Axentia Technologies AB
> + *
> + * Author: Peter Rosin <peda@axentia.se>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mux.h>
> +
> +#define ADG792A_LDSW		BIT(0)
> +#define ADG792A_RESET		BIT(1)
> +#define ADG792A_DISABLE(mux)	(0x50 | (mux))
> +#define ADG792A_DISABLE_ALL	(0x5f)
> +#define ADG792A_MUX(mux, state)	(0xc0 | (((mux) + 1) << 2) | (state))
> +#define ADG792A_MUX_ALL(state)	(0xc0 | (state))
> +
> +#define ADG792A_DISABLE_STATE	(4)
> +
> +static int adg792a_set(struct mux_control *mux, int state)
> +{
> +	struct i2c_client *i2c = to_i2c_client(mux->chip->dev.parent);
> +	u8 cmd;
> +
> +	if (mux->chip->controllers == 1) {
> +		/* parallel mux controller operation */
> +		if (state == ADG792A_DISABLE_STATE)
> +			cmd = ADG792A_DISABLE_ALL;
> +		else
> +			cmd = ADG792A_MUX_ALL(state);
> +	} else {
> +		unsigned int controller = mux_control_get_index(mux);
> +
> +		if (state == ADG792A_DISABLE_STATE)
> +			cmd = ADG792A_DISABLE(controller);
> +		else
> +			cmd = ADG792A_MUX(controller, state);
> +	}
> +
> +	return i2c_smbus_write_byte_data(i2c, cmd, ADG792A_LDSW);
> +}
> +
> +static const struct mux_control_ops adg792a_ops = {
> +	.set = adg792a_set,
> +};
> +
> +static int adg792a_probe(struct i2c_client *i2c,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct mux_chip *mux_chip;
> +	bool parallel;
> +	int count;
> +	int ret;
> +	int i;
> +
> +	parallel = of_property_read_bool(i2c->dev.of_node, "adi,parallel");
> +
> +	mux_chip = devm_mux_chip_alloc(dev, parallel ? 1 : 3, 0);
> +	if (!mux_chip)
> +		return -ENOMEM;
> +
> +	mux_chip->ops = &adg792a_ops;
> +
> +	ret = i2c_smbus_write_byte_data(i2c, ADG792A_DISABLE_ALL,
> +					ADG792A_RESET | ADG792A_LDSW);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < mux_chip->controllers; ++i) {
> +		struct mux_control *mux = &mux_chip->mux[i];
> +
> +		mux->states = 4;
> +	}
> +
> +	count = of_property_count_u32_elems(dev->of_node, "adi,idle-state");
> +	for (i = 0; i < count; i += 2) {
> +		u32 index;
> +		u32 idle_state;
> +
> +		ret = of_property_read_u32_index(dev->of_node,
> +						 "adi,idle-state", i,
> +						 &index);
> +		if (ret < 0)
> +			return ret;
> +		if (index >= mux_chip->controllers) {
> +			dev_err(dev, "invalid mux %u\n", index);
> +			return -EINVAL;
> +		}
> +
> +		ret = of_property_read_u32_index(dev->of_node,
> +						 "adi,idle-state", i + 1,
> +						 &idle_state);
> +		if (ret < 0)
> +			return ret;
> +		if (idle_state >= ADG792A_DISABLE_STATE) {
> +			dev_err(dev, "invalid idle-state %u for mux %u\n",
> +				idle_state, index);
> +			return -EINVAL;
> +		}
> +		mux_chip->mux[index].idle_state = idle_state;
> +	}
> +
> +	count = of_property_count_u32_elems(dev->of_node,
> +					    "adi,idle-high-impedance");
> +	for (i = 0; i < count; ++i) {
> +		u32 index;
> +
> +		ret = of_property_read_u32_index(dev->of_node,
> +						 "adi,idle-high-impedance", i,
> +						 &index);
> +		if (ret < 0)
> +			return ret;
> +		if (index >= mux_chip->controllers) {
> +			dev_err(dev, "invalid mux %u\n", index);
> +			return -EINVAL;
> +		}
> +
> +		mux_chip->mux[index].idle_state = ADG792A_DISABLE_STATE;
> +	}
> +
> +	ret = devm_mux_chip_register(dev, mux_chip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register mux-chip\n");
> +		return ret;
> +	}
> +
> +	if (parallel)
> +		dev_info(dev, "triple pole quadruple throw mux registered\n");
> +	else
> +		dev_info(dev, "3x single pole quadruple throw muxes registered\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id adg792a_id[] = {
> +	{ .name = "adg792a", },
> +	{ .name = "adg792g", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, adg792a_id);
> +
> +static const struct of_device_id adg792a_of_match[] = {
> +	{ .compatible = "adi,adg792a", },
> +	{ .compatible = "adi,adg792g", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adg792a_of_match);
> +
> +static struct i2c_driver adg792a_driver = {
> +	.driver		= {
> +		.name		= "adg792a",
> +		.of_match_table = of_match_ptr(adg792a_of_match),
> +	},
> +	.probe		= adg792a_probe,
> +	.id_table	= adg792a_id,
> +};
> +module_i2c_driver(adg792a_driver);
> +
> +MODULE_DESCRIPTION("Analog Devices ADG792A/G Triple 4:1 mux driver");
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se");
> +MODULE_LICENSE("GPL v2");
> 

