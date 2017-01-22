Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40295 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAVNaG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 08:30:06 -0500
Subject: Re: [PATCH v8 12/12] mux: support simplified bindings for single-user
 gpio mux
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-13-git-send-email-peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <33b29f7e-3e48-b85d-ccf9-93b1d67ac634@kernel.org>
Date: Sun, 22 Jan 2017 13:30:02 +0000
MIME-Version: 1.0
In-Reply-To: <1484755035-25927-13-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/01/17 15:57, Peter Rosin wrote:
> Allow bindings for a GPIO controlled mux to be specified in the
> mux consumer node.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Code is good as far as I am concerned. Only question is whether this
is worth the hassle given the normal bindings don't give that high
a burden in complexity!

I don't really care either way:)

> ---
>  drivers/mux/Kconfig    |  5 +----
>  drivers/mux/mux-core.c | 23 +++++++++++++++++++++--
>  drivers/mux/mux-gpio.c | 28 +++++++++++++++++++++-------
>  drivers/mux/mux-gpio.h | 13 +++++++++++++
>  4 files changed, 56 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/mux/mux-gpio.h
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index d13fcf98958e..cd161c228537 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -29,7 +29,7 @@ config MUX_ADG792A
>  	  be called mux-adg792a.
>  
>  config MUX_GPIO
> -	tristate "GPIO-controlled Multiplexer"
> +	bool "GPIO-controlled Multiplexer"
>  	depends on OF && GPIOLIB
>  	help
>  	  GPIO-controlled Multiplexer controller.
> @@ -39,7 +39,4 @@ config MUX_GPIO
>  	  states. The GPIO pins can be connected (by the hardware) to several
>  	  multiplexers, which in that case will be operated in parallel.
>  
> -	  To compile the driver as a module, choose M here: the module will
> -	  be called mux-gpio.
> -
>  endif
> diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
> index 16a61253d164..0caafd6f5a77 100644
> --- a/drivers/mux/mux-core.c
> +++ b/drivers/mux/mux-core.c
> @@ -21,6 +21,8 @@
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
>  
> +#include "mux-gpio.h"
> +
>  static struct class mux_class = {
>  	.name = "mux",
>  	.owner = THIS_MODULE,
> @@ -314,9 +316,26 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  	ret = of_parse_phandle_with_args(np,
>  					 "mux-controls", "#mux-control-cells",
>  					 index, &args);
> +
> +#ifdef CONFIG_MUX_GPIO
> +	if (ret == -ENOENT && !mux_name) {
> +		mux_chip = mux_gpio_alloc(dev);
> +		if (!IS_ERR(mux_chip)) {
> +			ret = devm_mux_chip_register(dev, mux_chip);
> +			if (ret < 0)
> +				return ERR_PTR(ret);
> +			get_device(&mux_chip->dev);
> +			return mux_chip->mux;
> +		}
> +
> +		ret = PTR_ERR(mux_chip);
> +	}
> +#endif
> +
>  	if (ret) {
> -		dev_err(dev, "%s: failed to get mux-control %s(%i)\n",
> -			np->full_name, mux_name ?: "", index);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "%s: failed to get mux-control %s(%i)\n",
> +				np->full_name, mux_name ?: "", index);
>  		return ERR_PTR(ret);
>  	}
>  
> diff --git a/drivers/mux/mux-gpio.c b/drivers/mux/mux-gpio.c
> index 48ca4d6b4fc7..2ab8735e3415 100644
> --- a/drivers/mux/mux-gpio.c
> +++ b/drivers/mux/mux-gpio.c
> @@ -18,6 +18,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  
> +#include "mux-gpio.h"
> +
>  struct mux_gpio {
>  	struct gpio_descs *gpios;
>  	int *val;
> @@ -48,24 +50,21 @@ static const struct of_device_id mux_gpio_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mux_gpio_dt_ids);
>  
> -static int mux_gpio_probe(struct platform_device *pdev)
> +struct mux_chip *mux_gpio_alloc(struct device *dev)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
>  	struct mux_chip *mux_chip;
>  	struct mux_gpio *mux_gpio;
>  	int pins;
> -	u32 idle_state;
>  	int ret;
>  
>  	pins = gpiod_count(dev, "mux");
>  	if (pins < 0)
> -		return pins;
> +		return ERR_PTR(pins);
>  
>  	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
>  				       pins * sizeof(*mux_gpio->val));
>  	if (!mux_chip)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	mux_gpio = mux_chip_priv(mux_chip);
>  	mux_gpio->val = (int *)(mux_gpio + 1);
> @@ -76,11 +75,26 @@ static int mux_gpio_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(mux_gpio->gpios);
>  		if (ret != -EPROBE_DEFER)
>  			dev_err(dev, "failed to get gpios\n");
> -		return ret;
> +		return ERR_PTR(ret);
>  	}
>  	WARN_ON(pins != mux_gpio->gpios->ndescs);
>  	mux_chip->mux->states = 1 << pins;
>  
> +	return mux_chip;
> +}
> +EXPORT_SYMBOL_GPL(mux_gpio_alloc);
> +
> +static int mux_gpio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mux_chip *mux_chip;
> +	u32 idle_state;
> +	int ret;
> +
> +	mux_chip = mux_gpio_alloc(dev);
> +	if (IS_ERR(mux_chip))
> +		return PTR_ERR(mux_chip);
> +
>  	ret = device_property_read_u32(dev, "idle-state", &idle_state);
>  	if (ret >= 0) {
>  		if (idle_state >= mux_chip->mux->states) {
> diff --git a/drivers/mux/mux-gpio.h b/drivers/mux/mux-gpio.h
> new file mode 100644
> index 000000000000..fe3e8d0173aa
> --- /dev/null
> +++ b/drivers/mux/mux-gpio.h
> @@ -0,0 +1,13 @@
> +/*
> + * GPIO-controlled multiplexer driver interface
> + *
> + * Copyright (C) 2017 Axentia Technologies AB
> + *
> + * Author: Peter Rosin <peda@axentia.se>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +struct mux_chip *mux_gpio_alloc(struct device *dev);
> 

