Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE2448CF4
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457916; cv=none; b=FTSu8APKQaVE4I/t9R2FmL7DnnBSKCW/C9ANP8Yt8ZwGHmUULMi4x7PJim7RddAgqcaSx7uALJbCwX+Im6eA8tokXC4XiKxNaBTs0ANaot2WQirpIpbra8aQNSGFwRi9vOycRmqQ+6K6dKbldBvtpL58CxFwAF4DPD9Gk0wEqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457916; c=relaxed/simple;
	bh=9CEFq07lqtoEK7NAQQ2Nph98Qx9jktslnDV7+rkNLDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vsl31ucYjONdiif9XEfAYLQW1m/DkWqf3VAX9Ebqn10sNABkOq/1GKmStNmTkZkqKUFTyUTy9QaNnGZK6dFyoIVDdOeiCxyCNKRirdbMtjZ+mreUW/EQpc4aVN/BGOUewjzYYaW08ksZfJVxFWL51K40/0PtXrKzJYoYqYtMYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XojFrt7Q; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XojFrt7Q"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb63dbd229so683589a34.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786457911; x=1787062711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6qT73nVxQFYt5KuPDy17dSTfBdwDDmBnJgS+hWIZRQ=;
        b=XojFrt7QGdQ9jZI/MmcrkGMQuKEmGFsnv+qAcXWwvOmiKRcFnfy8jof/ajwSDLbNhh
         x43WGEYUfLSQbRx6H2ayBNb0lhMALAIzj6VwDflT/EQz7AX5W2l38T+j37jipUMv09In
         y64nUW71gXNRJs7exZsPxr89xhEHmzMT6ZP4x42fQMg9SS/88gvtefV6Vahov8ULwPk4
         kCtEjmaGzqnAn+LeR40gHgnSFDeOUBs8OjEXIciFYOvUdoVMPpICaVnoX3I4FpFc83/E
         SY2LA+QKSup8+kBqsAWRFpxfLeUu57nCrKbwNslSrYAQnBbbD4QlCLZwQesuLUzWng36
         LEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457911; x=1787062711;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6qT73nVxQFYt5KuPDy17dSTfBdwDDmBnJgS+hWIZRQ=;
        b=glsfIKWg6msODNtRNeokWIvljYWFitS57VD3Oz2Ftqmyip81riAJgBaqLPm7vgMUNs
         rqGYMBnqjc9R0PxXiUs6KXl7GRUtED+7uQOJo+wHj6d5DyqLueSYBF0DEu50K04i5o+b
         ILNCG3exDn5J2dys5+2ddwuxDpy99VFN+Mo0FD87KtIfHZ+Gh6l/2Ng+URRFBYO5QGs/
         zM46fOrLi26VjH6ugkA8RngpYW6QlprXCreoNmrUdwk3LijWOTqkMrz6IOpgKyV+ZW0u
         pDYghxL4hSpHa0N4pQ9aHWq5OaS0b3vqMcTNDvPIkvzhGmovuGhL+C30QD/q1qn1E9PJ
         0pjA==
X-Gm-Message-State: AOJu0YxD+YkHn6BsWmXnrbzqM0dBQjFqeXICvi1eGGoO0e5HmuHkIqp9
	XqkubDeCwxMdpwwmT9PJsdKJR1mb4dkNueOSMjN06ga63dBecS0lQdoUDCLeVkm0SUo=
X-Gm-Gg: AR+sD11dZzNOazcNv5ZukcqxvD8eth7FULKFWO63JexiTcXKxcYicULGtFrpD9XHzp2
	0EyjiuJfkNK/tlTDsVtwhAuxHVQINYRzhDA1jvz0y12I5pYRY7lYydifRHY0esvSf51S8ZG3TXH
	5AGS8qt121shmEEMVX/ptqb5nZwS9Gwym4xHe9oBqYp1/kx1eN836Sa+NrBTgTdfkygL9/ls/mJ
	8j8MXIFe4ZWIuDE2UJpkSVOdvm1QhKC3npaJGQ/X08LBY9VIV6LXhMqqhIsoZi9Ds7Y0ltR/1hI
	SF09pSeBxaJezeFSffhjXDQEou7WV2y9mu3KNpCZMXFpWWrU6jXkT5WY+Z2PC3iTBvj7pvMr63m
	rREJ5Xrr97/2fRLx8nbtVDYjhPDiq2TT6ogo7Z7vmHWNLMRvMUD5wjsk+JdW5kyoKy2knvqglre
	D40QGh/UhCO+s0hufNvQLfJRhsLw+F1ym+U9DIecdks9WRj2P035RdyFWcVphQ7TI5wYEu/G2cP
	v+M8B1A7Kb6zLc5CGRRbLakI85pF4JD68sRVgsET3YixDY=
X-Received: by 2002:a05:6830:6684:b0:7e9:da5e:93f5 with SMTP id 46e09a7af769-7f3b274949emr86250a34.12.1786457910597;
        Tue, 11 Aug 2026 07:18:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7060:91df:60e9:76b? ([2600:8803:e7e4:500:7060:91df:60e9:76b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3a7aa1ac6sm1285720a34.20.2026.08.11.07.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:18:29 -0700 (PDT)
Message-ID: <cd020926-9daf-4493-b0c1-6399a77fcf9c@baylibre.com>
Date: Tue, 11 Aug 2026 09:18:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 9:48 PM, Kyle Hsieh wrote:
> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 
> The driver implements:
> - Single-shot conversions using the IIO raw read interface.
> - Dynamic parsing of single-ended and differential channels from
>   device tree child nodes.
> - Hardware interrupt support via the DRDY pin, falling back to
>   software polling if no IRQ is provided.
> - Scale calculation based on the internal 2.048V reference.
> - Reference voltage scaling via the regulator subsystem (refp-supply),
>   falling back to the internal 2.048V reference if not specified.
>   refn-supply is not yet supported.
> - Hardware reset fallback using GPIO.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/iio/adc/Kconfig        |  10 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ti-ads112c04.c | 425 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 437 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 417d74b6d6cc..f51fbda9d4b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26992,6 +26992,7 @@ M:	Kyle Hsieh <kylehsieh1995@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> +F:	drivers/iio/adc/ti-ads112c04.c
>  
>  TI ADS112C14 ADC DRIVER
>  M:	David Lechner <dlechner@baylibre.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 990e7b3e7212..0ee50828f9e4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1817,6 +1817,16 @@ config TI_ADS1119
>           This driver can also be built as a module. If so, the module will be
>           called ti-ads1119.
>  
> +config TI_ADS112C04
> +    tristate "Texas Instruments ADS112C04 ADC"
> +    depends on I2C
> +    help
> +      If you say yes here you get support for Texas Instruments
> +      ADS112C04 (16-bit) I2C analog to digital converters.
> +
> +      This driver can also be built as a module. If so, the module will be
> +      called ti-ads112c04.
> +
>  config TI_ADS112C14
>  	tristate "Texas Instruments ADS112C14/ADS122C14"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index dcec0abb03b7..d8acf2831fd2 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -155,6 +155,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
>  obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
>  obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
> +obj-$(CONFIG_TI_ADS112C04) += ti-ads112c04.o
>  obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
> diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112c04.c
> new file mode 100644
> index 000000000000..3a775da2ae23
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads112c04.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Texas Instruments ADS112C04 16-bit I2C ADC driver
> + *
> + * Copyright (c) 2026 Kyle Hsieh <kylehsieh1995@gmail.com>
> + *
> + * Datasheet: https://www.ti.com/lit/ds/symlink/ads112c04.pdf
> + * Based on TI Reference Code and standard Linux IIO framework.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define ADS112C04_CMD_RESET         0x06
> +#define ADS112C04_CMD_START_SYNC    0x08
> +#define ADS112C04_CMD_POWERDOWN     0x02
> +#define ADS112C04_CMD_RDATA         0x10
> +#define ADS112C04_CMD_RREG(reg)     (0x20 | ((reg) << 2))
> +#define ADS112C04_CMD_WREG(reg)     (0x40 | ((reg) << 2))
> +
> +#define ADS112C04_REG_CONFIG0       0x00
> +#define ADS112C04_REG_CONFIG1       0x01
> +#define ADS112C04_REG_CONFIG2       0x02
> +#define ADS112C04_REG_CONFIG3       0x03
> +
> +#define ADS112C04_CONFIG0_MUX         GENMASK(7, 4)
> +#define ADS112C04_CONFIG0_PGA_BYPASS  BIT(0)
> +#define ADS112C04_CONFIG2_DRDY        BIT(7)
> +

I think I mentioned before the preferred way to orgainze the fields
under the corresponding register. And as below, there are more
fields we are using that need macros here.

> +struct ads112c04_state {
> +	struct i2c_client *client;
> +	/* Protects concurrent ADC reads and device configuration */
> +	struct mutex lock;
> +	struct completion completion;
> +	int vref_mV;
> +	u8 config0;
> +	u8 config1;
> +	bool has_refp;

This isn't used outside of probe. Can just be passed as a function argument.

> +};
> +

...

> +static irqreturn_t ads112c04_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +
> +	disable_irq_nosync(irq);

As mentioned in this recent discussion [1], we should not be disabling the IRQ.
If there is a true need for it, we need lots of comments explaining why. Since
we aren't doing buffered reads though, I can't see a reason why we would need
it right now. Unless we are worried about spurious interrupts, in which case
we should read the DRDY status bit before setting the completion here as that
would be more robust.

[1]: https://lore.kernel.org/linux-iio/20260802184126.04738251@jic23-huawei/

Also, this ia a bug because we can't call syncronous code in an IRQ handler.
We would need to change it to a threaded IRQ handler.

> +	complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ads112c04_info = {
> +	.read_raw = ads112c04_read_raw,
> +};
> +
> +static int ads112c04_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *channels;
> +	u32 num_channels, pair[2];
> +	int ret, i = 0;
> +
> +	num_channels = device_get_named_child_node_count(dev, "channel");
> +	if (!num_channels)
> +		return dev_err_probe(dev, -EINVAL, "no channel subnodes found\n");
> +
> +	if (num_channels > 12)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "num of channel nodes exceeds 12\n");
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		struct iio_chan_spec *spec = &channels[i];
> +
> +		if (fwnode_property_present(child, "excitation-channels"))
> +			return dev_err_probe(dev, -EOPNOTSUPP,
> +					     "excitation-channels is not supported yet\n");
> +
> +		if (fwnode_property_present(child, "reference-sources")) {
> +			const char *ref;
> +
> +			ret = fwnode_property_read_string(child, "reference-sources", &ref);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read reference-sources\n");
> +
> +			if ((!strcmp(ref, "external") && !st->has_refp) ||
> +			    (!strcmp(ref, "internal") && st->has_refp))
> +				return dev_err_probe(dev, -EINVAL,
> +						     "reference-sources does not match refp-supply\n");

As explained more below, this part needs comments to explain why it is
the way it is since it is not implementing fully what is allowed by the
devicetree bindings. And would return EOPNOTSUPP to be consistent that
this is just something that is not implemented yet.

> +		}
> +
> +		spec->type = IIO_VOLTAGE;

I would add a REVISIT comment here to explain that when ti,refp-refn-resistor-ohms is implemented,
then we have the possibility of the channel being resistance instead of votlage.

> +		spec->indexed = 1;
> +		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
> +
> +		if (fwnode_property_present(child, "single-channel")) {
> +			ret = fwnode_property_read_u32(child, "single-channel", &pair[0]);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read single-channel property\n");
> +
> +			if (pair[0] > 3)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "single-channel must be 0-3\n");
> +
> +			spec->channel = pair[0];
> +			spec->address = 0x08 + pair[0];
> +		} else if (fwnode_property_present(child, "diff-channels")) {
> +			ret = fwnode_property_read_u32_array(child, "diff-channels", pair, 2);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read diff-channels property\n");
> +
> +			if (pair[0] > 3 || pair[1] > 3)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "diff-channels must be 0-3\n");
> +
> +			spec->channel = pair[0];
> +			spec->channel2 = pair[1];
> +			spec->differential = 1;
> +
> +			if (pair[0] == 0 && pair[1] == 1)
> +				spec->address = 0x00;
> +			else if (pair[0] == 0 && pair[1] == 2)
> +				spec->address = 0x01;
> +			else if (pair[0] == 0 && pair[1] == 3)
> +				spec->address = 0x02;
> +			else if (pair[0] == 1 && pair[1] == 0)
> +				spec->address = 0x03;
> +			else if (pair[0] == 1 && pair[1] == 2)
> +				spec->address = 0x04;
> +			else if (pair[0] == 1 && pair[1] == 3)
> +				spec->address = 0x05;
> +			else if (pair[0] == 2 && pair[1] == 3)
> +				spec->address = 0x06;
> +			else if (pair[0] == 3 && pair[1] == 2)
> +				spec->address = 0x07;
> +			else
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid diff-channels combination\n");
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "channel node must have single-channel or diff-channels\n");
> +		}
> +
> +		i++;
> +	}
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = i;
> +
> +	return 0;
> +}
> +
> +#define ADS112C04_VREF_INTERNAL_MV	2048

Usually we put this at the top with other macro definitions.

> +
> +static int ads112c04_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads112c04_state *st;
> +	struct gpio_desc *reset_gpio;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	init_completion(&st->completion);
> +
> +	indio_dev->name = "ads112c04";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads112c04_info;
> +
> +	/* Forward compatibility checks for unimplemented DT properties */
> +	if (device_property_present(dev, "refn-supply") ||
> +	    device_property_present(dev, "ti,refp-refn-resistor-ohms"))
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "refn-supply and external resistors are not supported yet\n");
> +
> +	st->has_refp = device_property_present(dev, "refp-supply");
> +
> +	ret = ads112c04_parse_channels(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
> +
> +	ret = devm_regulator_get_enable(dev, "dvdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
> +
> +	if (device_property_present(dev, "refp-supply")) {

This can just be st->has_refp now.

> +		ret = devm_regulator_get_enable_read_voltage(dev, "refp");
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to get refp voltage\n");
> +
> +		st->vref_mV = ret / (MICRO / MILLI);
> +		st->config1 = 0x02;

I've asked before... these values should have macros to explain what
they are and be using FIELD_PREP().

> +	} else {
> +		st->vref_mV = ADS112C04_VREF_INTERNAL_MV;
> +		st->config1 = 0x00;
> +	}

I still don't think storing vref like this is a good idea since it should
be per-channel. If you really are against implementing it in a more
future-proof way, then it needs lots of comments explaining why it is
implemented this way instead and how one would go about doing it the "right
way" in the future.

> +
> +	/* Power-On Reset (POR) delay */
> +	fsleep(50 * USEC_PER_MSEC);
> +
> +	/* Requesting OUT_HIGH asserts the active-low reset pin immediately */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +
> +	if (reset_gpio) {
> +		fsleep(1000);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		ret = ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	fsleep(1000);
> +
> +	/* Bypass PGA for now to allow full-scale single-ended measurements */
> +	st->config0 = ADS112C04_CONFIG0_PGA_BYPASS;
> +	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->config0);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_irq(dev, client->irq,
> +				       ads112c04_irq_handler,
> +				       0,

I think I've asked twice now to move this 0 on the previous line.
If you don't agree with that, it is fine, but we just ask that you
reply to the suggestion with an explanation to state your reasoning.
Otherwise, it comes across as carelessness that you continue to
ignore suggestions. This is not the only suggestoin that has been
silently ignored. You might want to go back to the previous revisions
and see if you missed anything else.

> +				       indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
