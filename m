Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2041F35A
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136527; cv=none; b=G6W94ztxpJ30okC5BJ74TB6qwEzTQ1MyYWGzbsgu9vrcXiRAwvGGwXJn9PS9UNKty892UW1TVzFSxa0eoryctEYuge3BUBH66e8dlvmninvnnd1EeUv1SmKamZWdnuHq/28XczyFd3eD0DQQL4I2lgdrfxLC2NwC5EJR+WdDf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136527; c=relaxed/simple;
	bh=/61v4GsfBH/UswqgJ+4BztaONgApiIQT/j3yNHpPDcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U007alie6d8jEkmQ4unqdLSlvqeWSoTyHVrcYHzKtBWMrqqPWKKw2/gMacAtFkd3EQ/E19nhWSziH24/SffWmlTySZAzYU+TGb1suVQAdNiAdsuUUaxpsmLBSuKyIku9C0hIZh21MICOaH91ST6wJtrDmojNpc3O4Yqum+XnNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MjVwxqy/; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MjVwxqy/"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ee50eb2db4so17493a34.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786136522; x=1786741322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wYom0M8CAXI9fAp6jyAi/7lL7W4MwUnft+i///iv08A=;
        b=MjVwxqy/tfGuQcSFVSESQedpC3d5aRPjc/vMKMtmDmdg0gLJQDYEBTXmHOc7cHz0Nb
         wCaacxGHJkKCuuW++JJzJcfw4TLIjp3zQCfD8JTQecmzs138pMZWEafZ8sfV7lrOhw9C
         gU10gsjCgrMa8CaefLLfUSweHRz9wjyUBuzDs9jJqvGjE2KXh+DVaNt4NI/Hie+B/1lj
         r2LY8JNCpFm/x44+SBg8XAShwlTKS2QHRANEENNXI2c8Gwiz/c/WQWu4TnOrONLcqEzt
         zLfHk6IUl/Xn9lDEn9NZelS1F/M8SG3DqH4ugnJELZit3WJqva4tCMkXbdgBy5QjrpSg
         Eq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136522; x=1786741322;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wYom0M8CAXI9fAp6jyAi/7lL7W4MwUnft+i///iv08A=;
        b=EYv2ooF/IPaq79SjL/edJ8BYeagKjnvm8SE9No04ksFmms41Ii60chuIhpvwG5uQRo
         npEpTCVS1S0XdahmXrIkhkxKQvg2J8pu8eUbEoYUa6g5EXlmUB9Y8MZWbGLRPDUXtEmM
         HTKDcxU5NOdOMGwL7reoR64V5966hWpVHQFXtgNZMN4EPD//9epeYph5VFMwpDS32/xe
         /rDzwioaW5N4SL2xFSDDQgxV4Q7Nv0tAic3qSMK12LI9P47z+xQSu79gnRMAp0cgYnbT
         eirNjcgq6SZh6RKWEMFryXE1YaXHKPK0977T6Wqm2EHE/8umYc9JtKnozMk/cS/8nocE
         MSww==
X-Gm-Message-State: AOJu0YyzB9yWg7HUGjrqxU+3MfNRjZoskefAMFHpdDati7hdzN5l5/Jk
	rWQ147IJfA9Xlv3ceH4W0PhMssz+oEGK1G5lPHOpPqCXAmQI/wAdbwDAUMvMDGjTKPU=
X-Gm-Gg: AR+sD11VLSjoVZEjLjAF8ksP0JGqzcyi1gZ1UGFZaHYcei+/ko1bfx/teQi922RagoT
	n5b2q6ebHicbr/o07qinpuAiYgsUJpaLj2nDsFpfGxBQA6kwI+Ib08M1ivCr4pjNZhcb6wmYEBL
	nUAXfyBYc8mmQmknEeUA25ovpWoFSGvirimQbXDdqC1HiST0sp/lb2Cn/BUhdoBELUTen+bVZpa
	v4mcpENHUFoN629prJIWi1AHGxBD++S1pkUykfg6V2lQvXAkKpPHfmVG7OYN2KO4cOF5hcxyhep
	yV17AkS95SuEY9Wxm66uPApxZnuBjRR0MDrB5WvDKhv4Ikv8FwcIYfIW8qcPG4g4cfh9TnAxvNg
	LvGl9UlF9Wkfln2dYfag0+r4ykdro1HTyeCeHlTL3TPF+M8wX9P74KC1T1kNnWfsUNyjs+MgB82
	v/Nq9+oW2tOlXUKZNy2IpylcXGHqsFvhleaRS68jD+scfp5QXKTIexqfEfqPyk7vuUQUBeC5vvI
	zSjA+yQb+cTFvQSNkgZ5jLlnJ8VedO2WWYDFRgTFSrz/yE=
X-Received: by 2002:a05:6830:398d:b0:7e6:cee5:1bbf with SMTP id 46e09a7af769-7f35f14930bmr4108802a34.12.1786136517133;
        Fri, 07 Aug 2026 14:01:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2? ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5638f3sm2057694a34.2.2026.08.07.14.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 14:01:56 -0700 (PDT)
Message-ID: <2e81514a-e419-4b23-a3f9-f954047dd64c@baylibre.com>
Date: Fri, 7 Aug 2026 16:01:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
 <20260805-ti-ads112c04-driver-v3-2-49f436829e01@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260805-ti-ads112c04-driver-v3-2-49f436829e01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 12:38 AM, Kyle Hsieh wrote:
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
> - Dynamic reference voltage scaling via the regulator subsystem
>   (refp-supply/refn-supply), falling back to the internal 2.048V
>   reference if not specified.
> - Hardware reset fallback using GPIO.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  drivers/iio/adc/Kconfig        |  10 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ti-ads112c04.c | 423 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 434 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3755a81c1efd..402e841bc083 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1789,6 +1789,16 @@ config TI_ADS1119
>           This driver can also be built as a module. If so, the module will be
>           called ti-ads1119.
>  
> +config TI_ADS112C04
> +	tristate "Texas Instruments ADS112C04 ADC"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments
> +	  ADS112C04 (16-bit) I2C analog to digital converters.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads112c04.
> +
>  config TI_ADS124S08
>  	tristate "Texas Instruments ADS124S08"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 707dd708912f..ebf9d4047a5a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -153,6 +153,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
>  obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
>  obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
> +obj-$(CONFIG_TI_ADS112C04)	+= ti-ads112c04.o
>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
>  obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
> diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112c04.c
> new file mode 100644
> index 000000000000..64af866f615d
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads112c04.c
> @@ -0,0 +1,423 @@
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
> +struct ads112c04_state {
> +	struct i2c_client *client;
> +	/* Protects concurrent ADC reads and device configuration */
> +	struct mutex lock;
> +	struct completion completion;
> +	struct regulator *vref_reg;

vref_reg isn't used outside of probe, so we don't need it in this struct.

> +	int vref_mV;
> +	u8 config0;
> +	u8 config1;
> +};
> +
> +static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(client, cmd);

According to the docs, this can't return anything other than 0
or negative error, so drop the wrapper, it doesn't do anything
useful.

If you really want to keep it, just return directly.

> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, ADS112C04_CMD_RREG(reg));
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret;
> +
> +	return 0;
> +}
> +
> +static int ads112c04_write_reg(struct i2c_client *client, u8 reg, u8 val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, ADS112C04_CMD_WREG(reg), val);
> +
> +	return ret < 0 ? ret : 0;

It doesn't return anything > 0, so just return directly and drop
the local variable.

> +}
> +
> +static int ads112c04_wait_for_data(struct ads112c04_state *st)
> +{
> +	int ret, err;
> +	u8 val;
> +
> +	if (st->client->irq > 0) {
> +		/* Timeout is 100ms (slowest data rate is 20 SPS) */
> +		ret = wait_for_completion_timeout(&st->completion,
> +						  msecs_to_jiffies(100));
> +		if (!ret)
> +			return -ETIMEDOUT;

nit: add blank line here

> +		return 0;
> +	}
> +
> +	err = read_poll_timeout(ads112c04_read_reg, ret,
> +				(ret < 0 || (val & ADS112C04_CONFIG2_DRDY)),
> +				1000, 100 * USEC_PER_MSEC, false,
> +				st->client, ADS112C04_REG_CONFIG2, &val);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return err;
> +}
> +
> +static int ads112c04_read_data(struct ads112c04_state *st, int *val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(st->client, ADS112C04_CMD_RDATA);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = sign_extend32(be16_to_cpu(ret), 15);
> +
> +	return 0;
> +}
> +
> +static int ads112c04_get_adc_result(struct ads112c04_state *st,
> +				    struct iio_chan_spec const *chan,
> +				    int *val)
> +{
> +	u8 new_config0;
> +	int ret;
> +
> +	new_config0 = st->config0 & ~ADS112C04_CONFIG0_MUX;
> +	new_config0 |= FIELD_PREP(ADS112C04_CONFIG0_MUX, chan->address);

I would still copy the register when intializing the variable and then
use FIELD_MODIFY().

> +
> +	if (st->config0 != new_config0) {
> +		ret = ads112c04_write_reg(st->client, ADS112C04_REG_CONFIG0, new_config0);
> +		if (ret < 0)
> +			return ret;
> +		st->config0 = new_config0;
> +	}
> +
> +	reinit_completion(&st->completion);
> +
> +	ret = ads112c04_write_cmd(st->client, ADS112C04_CMD_START_SYNC);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ads112c04_wait_for_data(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ads112c04_read_data(st, val);
> +}
> +
> +static int ads112c04_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = ads112c04_get_adc_result(st, chan, val);
> +		mutex_unlock(&st->lock);
> +
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mV;
> +		*val2 = 15;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t ads112c04_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +
> +	complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ads112c04_info = {
> +	.read_raw = ads112c04_read_raw,
> +};
> +
> +static void ads112c04_regulator_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static int ads112c04_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *channels;
> +	u32 num_channels, pair[2];
> +	int ret, i = 0;
> +
> +	num_channels = device_get_named_child_node_count(dev, "channel");
> +	if (!num_channels)
> +		return -EINVAL;

Could be helpful to print an error message here (return dev_err_probe()). Lots
of things can cause EINVAL.

Probably good the check that num_channels <= 12 too.

> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		struct iio_chan_spec *spec = &channels[i];
> +
> +		if (fwnode_property_present(child, "excitation-channels") ||
> +		    fwnode_property_present(child, "reference-sources"))

I think we need to implement reference-sources now if you are using an
external reference. The default is internal, but the probe function handles
both.

We either need to drop suppport for external reference in the probe function
or handle references-sources other than the default here.

We should be able to copy the implementation from the ADS112C14 driver and
just remove the 2nd internal refernce voltage anyway, so it shouldn't be too
much work to implement it.

If you really want to keep it simpler, then we should at least make sure
that all reference-sources of all channels match and that it matches which
reference voltage we picked in probe.

> +			return dev_err_probe(dev, -EOPNOTSUPP,
> +					     "advanced channel properties are not supported yet\n");
> +
> +		spec->type = IIO_VOLTAGE;
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

nit: add blank line here.

> +		i++;
> +	}
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = i;
> +
> +	return 0;
> +}
> +
> +static int ads112c04_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads112c04_state *st;
> +	struct gpio_desc *reset_gpio;
> +	int ret, refp_mV = 2048;

I would make a macro for 2048 to make it self-documenting that this is the
internal reference voltage.

And as above, we don't want to assign this to refp_mV. refp_mV needs to always
be the external reference voltage since different channels can use different
references.

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

I would simplify this by checking device_property_present(dev, "refp-supply") and
then if it is present, use devm_regulator_get_enable_read_voltage().

> +	st->vref_reg = devm_regulator_get_optional(dev, "refp");
> +	if (IS_ERR(st->vref_reg)) {
> +		ret = PTR_ERR(st->vref_reg);
> +		if (ret == -ENODEV)
> +			st->config1 = 0x00;
> +		else
> +			return ret;
> +
> +	} else {
> +		ret = regulator_enable(st->vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(dev, ads112c04_regulator_disable,
> +					       st->vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(st->vref_reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		refp_mV = ret / (MICRO / MILLI);
> +		st->config1 = 0x02;
> +	}
> +
> +	st->vref_mV = refp_mV;
> +
> +	/* Power-On Reset (POR) delay */
> +	fsleep(50000);

50 * USEC_PER_MSEC

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

nit: I would put the 0 on the previous line.

> +				       indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id ads112c04_id[] = {
> +	{ .name = "ads112c04" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ads112c04_id);
> +
> +static const struct of_device_id ads112c04_of_match[] = {
> +	{ .compatible = "ti,ads112c04" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ads112c04_of_match);
> +
> +static struct i2c_driver ads112c04_driver = {
> +	.driver = {
> +		.name = "ads112c04",
> +		.of_match_table = ads112c04_of_match,
> +	},
> +	.probe = ads112c04_probe,
> +	.id_table = ads112c04_id,
> +};
> +module_i2c_driver(ads112c04_driver);
> +
> +MODULE_AUTHOR("Kyle Hsieh <kylehsieh1995@gmail.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADS112C04 ADC driver");
> +MODULE_LICENSE("GPL");
> 

