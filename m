Return-Path: <SRS0=e+qW=YX=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v7 05/12] mux: support simplified bindings for single-user
 gpio mux
To: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-6-git-send-email-peda@axentia.se>
 <d89179f5-6ad6-3c40-cdb8-f49cf324e9ee@axentia.se>
 <9652928a-5d54-5fa4-48ad-6df57bc8513c@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet
 <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org
From: Peter Rosin <peda@axentia.se>
Message-ID: <60cd24a4-dd13-c5e8-c06d-bbd12a8e7e21@axentia.se>
Date: Sun, 8 Jan 2017 22:56:04 +0100
MIME-Version: 1.0
In-Reply-To: <9652928a-5d54-5fa4-48ad-6df57bc8513c@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 2017-01-08 11:28, Jonathan Cameron wrote:
> On 05/01/17 16:21, Peter Rosin wrote:
>> On 2017-01-04 13:16, Peter Rosin wrote:
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  drivers/mux/mux-core.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>>  drivers/mux/mux-gpio.c | 56 ++--------------------------------
>>>  include/linux/mux.h    |  7 +++++
>>>  3 files changed, 89 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
>>> index 21da15a264ad..d887ae1c0e55 100644
>>> --- a/drivers/mux/mux-core.c
>>> +++ b/drivers/mux/mux-core.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/device.h>
>>>  #include <linux/err.h>
>>>  #include <linux/idr.h>
>>> +#include <linux/gpio/consumer.h>
>>>  #include <linux/module.h>
>>>  #include <linux/mux.h>
>>>  #include <linux/of.h>
>>> @@ -288,6 +289,63 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>>>  	return dev ? to_mux_chip(dev) : NULL;
>>>  }
>>>  
>>> +#ifdef CONFIG_MUX_GPIO
>>> +
>>> +static int mux_gpio_set(struct mux_control *mux, int state)
>>> +{
>>> +	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
>>> +	int i;
>>> +
>>> +	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
>>> +		mux_gpio->val[i] = (state >> i) & 1;
>>> +
>>> +	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
>>> +				       mux_gpio->gpios->desc,
>>> +				       mux_gpio->val);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct mux_control_ops mux_gpio_ops = {
>>> +	.set = mux_gpio_set,
>>> +};
>>> +
>>> +struct mux_chip *mux_gpio_alloc(struct device *dev)
>>> +{
>>> +	struct mux_chip *mux_chip;
>>> +	struct mux_gpio *mux_gpio;
>>> +	int pins;
>>> +	int ret;
>>> +
>>> +	pins = gpiod_count(dev, "mux");
>>> +	if (pins < 0)
>>> +		return ERR_PTR(pins);
>>> +
>>> +	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
>>> +				       pins * sizeof(*mux_gpio->val));
>>> +	if (!mux_chip)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	mux_gpio = mux_chip_priv(mux_chip);
>>> +	mux_gpio->val = (int *)(mux_gpio + 1);
>>> +	mux_chip->ops = &mux_gpio_ops;
>>> +
>>> +	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
>>> +	if (IS_ERR(mux_gpio->gpios)) {
>>> +		ret = PTR_ERR(mux_gpio->gpios);
>>> +		if (ret != -EPROBE_DEFER)
>>> +			dev_err(dev, "failed to get gpios\n");
>>> +		return ERR_PTR(ret);
>>> +	}
>>> +	WARN_ON(pins != mux_gpio->gpios->ndescs);
>>> +	mux_chip->mux->states = 1 << pins;
>>> +
>>> +	return mux_chip;
>>> +}
>>> +EXPORT_SYMBOL_GPL(mux_gpio_alloc);
>>> +
>>> +#endif /* CONFIG_MUX_GPIO */
>>> +
>>>  struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>>  {
>>>  	struct device_node *np = dev->of_node;
>>> @@ -307,9 +365,28 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>>  	ret = of_parse_phandle_with_args(np,
>>>  					 "mux-controls", "#mux-control-cells",
>>>  					 index, &args);
>>> +
>>> +#ifdef CONFIG_MUX_GPIO
>>> +	if (ret == -ENOENT && !mux_name && gpiod_count(dev, "mux") > 0) {
>>> +		mux_chip = mux_gpio_alloc(dev);
>>> +		if (!IS_ERR(mux_chip)) {
>>> +			ret = devm_mux_chip_register(dev, mux_chip);
>>> +			if (ret < 0) {
>>> +				dev_err(dev, "failed to register mux-chip\n");
>>> +				return ERR_PTR(ret);
>>> +			}
>>> +			get_device(&mux_chip->dev);
>>> +			return mux_chip->mux;
>>> +		}
>>> +
>>> +		ret = PTR_ERR(mux_chip);
>>> +	}
>>> +#endif
>>> +
>>>  	if (ret) {
>>> -		dev_err(dev, "%s: failed to get mux-control %s(%i)\n",
>>> -			np->full_name, mux_name ?: "", index);
>>> +		if (ret != -EPROBE_DEFER)
>>> +			dev_err(dev, "%s: failed to get mux-control %s(%i)\n",
>>> +				np->full_name, mux_name ?: "", index);
>>>  		return ERR_PTR(ret);
>>>  	}
>>>  
>>> diff --git a/drivers/mux/mux-gpio.c b/drivers/mux/mux-gpio.c
>>> index 76b52bc63470..8a7bfbc0c4bb 100644
>>> --- a/drivers/mux/mux-gpio.c
>>> +++ b/drivers/mux/mux-gpio.c
>>> @@ -11,37 +11,12 @@
>>>   */
>>>  
>>>  #include <linux/err.h>
>>> -#include <linux/gpio/consumer.h>
>>>  #include <linux/module.h>
>>>  #include <linux/mux.h>
>>>  #include <linux/of_platform.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/property.h>
>>
>> Instead of moving the mux-gpio guts from mux-gpio.c to mux-core.c, I
>> will instead make CONFIG_MUX_GPIO a bool option (no module possible)
>> and call it from the mux-core. That will be cleaner and less of a
>> break of abstractions in my opinion.
> Hmm. I wonder if the balance is right here or whether we should just not have the
> simplified binding at all as it breaks the assumption that all muxes are of the
> same level...
> 
> I like the binding, but it is causing significant complexity in here.

Yes, in this patch it looks pretty bad. But with the suggested
changes it at least looks fine (apart from the remaining ifdef
in mux_control_get). But then there's of course the conceptual
badness of the core depending on a specific driver that you
mention...

But. I expect that gpio based muxes will be in vast majority, and
giving them some extra freedoms is probably not wrong considering
the upside of the simpler binding.

>>
>> Cheers,
>> Peter
>>
>>> -struct mux_gpio {
>>> -	struct gpio_descs *gpios;
>>> -	int *val;
>>> -};
>>> -
>>> -static int mux_gpio_set(struct mux_control *mux, int state)
>>> -{
>>> -	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
>>> -	int i;
>>> -
>>> -	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
>>> -		mux_gpio->val[i] = (state >> i) & 1;
>>> -
>>> -	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
>>> -				       mux_gpio->gpios->desc,
>>> -				       mux_gpio->val);
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -static const struct mux_control_ops mux_gpio_ops = {
>>> -	.set = mux_gpio_set,
>>> -};
>>> -
>>>  static const struct of_device_id mux_gpio_dt_ids[] = {
>>>  	{ .compatible = "mux-gpio", },
>>>  	{ /* sentinel */ }
>>> @@ -51,38 +26,13 @@ MODULE_DEVICE_TABLE(of, mux_gpio_dt_ids);
>>>  static int mux_gpio_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev = &pdev->dev;
>>> -	struct device_node *np = dev->of_node;
>>>  	struct mux_chip *mux_chip;
>>> -	struct mux_gpio *mux_gpio;
>>> -	int pins;
>>>  	u32 idle_state;
>>>  	int ret;
>>>  
>>> -	if (!np)
>>> -		return -ENODEV;
>>> -
>>> -	pins = gpiod_count(dev, "mux");
>>> -	if (pins < 0)
>>> -		return pins;
>>> -
>>> -	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
>>> -				       pins * sizeof(*mux_gpio->val));
>>> -	if (!mux_chip)
>>> -		return -ENOMEM;
>>> -
>>> -	mux_gpio = mux_chip_priv(mux_chip);
>>> -	mux_gpio->val = (int *)(mux_gpio + 1);
>>> -	mux_chip->ops = &mux_gpio_ops;
>>> -
>>> -	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
>>> -	if (IS_ERR(mux_gpio->gpios)) {
>>> -		ret = PTR_ERR(mux_gpio->gpios);
>>> -		if (ret != -EPROBE_DEFER)
>>> -			dev_err(dev, "failed to get gpios\n");
>>> -		return ret;
>>> -	}
>>> -	WARN_ON(pins != mux_gpio->gpios->ndescs);
>>> -	mux_chip->mux->states = 1 << pins;
>>> +	mux_chip = mux_gpio_alloc(dev);
>>> +	if (IS_ERR(mux_chip))
>>> +		return PTR_ERR(mux_chip);
>>>  
>>>  	ret = device_property_read_u32(dev, "idle-state", &idle_state);
>>>  	if (ret >= 0) {
>>> diff --git a/include/linux/mux.h b/include/linux/mux.h
>>> index 3b9439927f11..3bfee23cfb8c 100644
>>> --- a/include/linux/mux.h
>>> +++ b/include/linux/mux.h
>>> @@ -241,4 +241,11 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>>>   */
>>>  void devm_mux_control_put(struct device *dev, struct mux_control *mux);
>>>  
>>> +struct mux_gpio {
>>> +	struct gpio_descs *gpios;
>>> +	int *val;
>>> +};
>>> +
>>> +struct mux_chip *mux_gpio_alloc(struct device *dev);
>>> +
>>>  #endif /* _LINUX_MUX_H */
>>>
>>
> 
