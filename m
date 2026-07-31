Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5C3B0AF5
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509666; cv=none; b=fU2pXeZZDoj/GQj6Q1QrNsm+XErOYuz4vBy2/ZJabfZk4seLyVCeBU5yGM+VHKZ9Rf30FNE4/Ic1je+CfruYSFKoQLGsJ1h1Ij2Wmhzs72hQ2xsVTRY1IsyWrj3uSc1n+bjWRtwYkYIcz1kQ7VdxDQn63F2nWkzmAkpYj+G6ZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509666; c=relaxed/simple;
	bh=XlFw6fzMqwBgI+qoIqXlYx6roo5L38Tu3V5xv8RRU7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyVhob8rL/Ea8ZJS9nog1S2nEwFv1HWFdUnf0wJBmXNdJsMP5oZstMRNRlU2n+B2FuooLIHtpT5qgS/r/qS6vdHPjMw9SpTSnVqzvLbwukCu0sOuHc/uKRsprtdY27bOhEycsHTSWaMHRWZg2+TS5G4hTuovUoK5ObvWnPNPGR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AswDVwVC; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AswDVwVC"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6680ae2031fso885416d50.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785509661; x=1786114461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CIyhafrwj8Bz3hkHWmQTK8hShgQpyNNSe1342jQGJs=;
        b=AswDVwVCFKuBy53Yo8A+ZJq8a3kgtTkJ/l1/cxOfJAI9nZthjmfqCaqih4axyuDGqV
         96odNerf5Bn7iBtWkHeHNcgPjhdBj3vSitxqY7bT6dTv89Wjrdv+OFE11H2tFHg0mbgL
         XxDRRha5lg9T1pdlhy0XOnR+VdvKtMnxzmYP6wjxkiL/u2jGhtA0AO9s7KCmyOnmKtfZ
         zmfQV+wKLRUP1tqUii2/GV6L814OST1bUyqLksQWZ+TKhumSA/n+J4QmRYbLphnlgOKz
         Xq8r/Wc694ZOQ9qC7SzMlbsKZ6+vq6N6yZVs/2HCmbRK9XsDg/zqHEm66EQG3jvrYHM/
         eHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785509661; x=1786114461;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CIyhafrwj8Bz3hkHWmQTK8hShgQpyNNSe1342jQGJs=;
        b=IpuVzFOJq9LpZfEUx+vJRZY8gXbaTOFWblZy/92a05rWmOzp6JnM5XzHXJOANgwhyi
         ly6br3Enhh5Hg1orn4YMuUcZonj88SHv1t0sZURlglSsnYMADmxHcwTchg34JRoB2Hmn
         qbKsRZxR+PTYYZ7x796gKEL5FqPXCiyp1wnhCLDdcCAZ+YrDum0Evl7mEavD59qCaCcs
         v4K2dedYT01V1CXP9gjdsmRibJvqp0gUk3b2aTTOg1VmuEQPQA0Fd+/Gr2LTPGCiL6Y6
         op/RlRVTdtCJuio9mNT9cO/iBwJEqHlAivgDhCvcvnt0uVwYE3XuVLEaMnsja6d2VzP/
         sfEg==
X-Gm-Message-State: AOJu0YwSXRTFc3tvMOQ8qFhNNjiFbr1+w7ZBmDET23Rc9FeZCBST59ht
	GIpn+9d8Dca8D0hlpgte49vlCIIhj3ys3ipYOatx9GnYgw2va4Da4mmeJ+KXRkoJCnA=
X-Gm-Gg: AR+sD10IM9vM/ei7rGRcUaa8JhybibWjvV5uaqJxtmnKY6L/ulDigeEFCoapM1l40Qt
	w06DHucjpYeoHA1KeFRY3GDtlrFnI3lMYY0FvK4rzF/+cZtw6nhzsDUbN6jEaRbtifVhDS0SZyi
	jnDz9c3ojsaJQilnTgo+crEv4dgLR0W6mMKE/+aMXcQo5r9b727HR8dIMQv07bVbDnCiNYEIVUH
	ka/0shaXOC2SzLkdTK1r1pz+AT21muAq2V2ZA6SzCexinVVfeaoA/ElocPuZYCSZFpcz6RWV6WN
	NLnovw6zOg0CC8EPu7IjFmjhrVVJpj/8t1qLdki9BRStNklsSu7O/4iCccN03btorWrpGf5YoAd
	/sivVj7t4j4D0h+sJAQRaqvlRWsUzqfqJ1aSSudpBnuWput9688tKrQEy3VnI0P3yEjg/82Npf+
	HaWMgYmja47+9Vz4+4l7PGShAw5L1RgPIWYrUCJCubGiqTw2RXkklcZbQUdWCAKzO2kZcsLVD0x
	tXOr9LS8XkUrFVZp0k3l/IyvD/p7pFuddMV3LE=
X-Received: by 2002:a05:690c:968a:b0:81d:bc5:4624 with SMTP id 00721157ae682-81fd4b8c8ebmr1026387b3.25.1785509661335;
        Fri, 31 Jul 2026 07:54:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:fa40:746f:401a:3b75? ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6f24sm7777867b3.30.2026.07.31.07.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:54:20 -0700 (PDT)
Message-ID: <0f092382-416e-43ac-b58f-b915165e29ba@baylibre.com>
Date: Fri, 31 Jul 2026 09:54:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
 <20260731-ti-ads112c04-driver-v2-2-aab0168c3c01@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260731-ti-ads112c04-driver-v2-2-aab0168c3c01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 9:58 PM, Kyle Hsieh wrote:
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
>  drivers/iio/adc/Kconfig        |  10 ++
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ti-ads112c04.c | 378 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 389 insertions(+)
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
> index 000000000000..28d3be81934f
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads112c04.c
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Texas Instruments ADS112C04 16-bit I2C ADC driver
> + * Based on TI Reference Code and standard Linux IIO framework.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
> +#include <linux/property.h>
> +#include <linux/gpio/consumer.h>
> +
> +/* ADS112C04 Commands */
> +#define ADS112C04_CMD_RESET         0x06
> +#define ADS112C04_CMD_START_SYNC    0x08
> +#define ADS112C04_CMD_POWERDOWN     0x02
> +#define ADS112C04_CMD_RDATA         0x10
> +#define ADS112C04_CMD_RREG(reg)     (0x20 | ((reg) << 2))
> +#define ADS112C04_CMD_WREG(reg)     (0x40 | ((reg) << 2))
> +
> +/* Registers */
> +#define ADS112C04_REG_CONFIG0       0x00
> +#define ADS112C04_REG_CONFIG1       0x01
> +#define ADS112C04_REG_CONFIG2       0x02
> +#define ADS112C04_REG_CONFIG3       0x03
> +
> +#define ADS112C04_DRDY_MASK         BIT(7)
> +#define ADS112C04_MUX_MASK          GENMASK(7, 4)

We like to include the name of the register in the mask names
(and usually don't bother with _MASK to keep it shorter) and
organize the fields under the registers with a bit of indent.

Something like:

#define ADS112C04_REG_CONFIG0       0x00
#define   ADS112C04_CONFIG0_MUX       GENMASK(7, 4)
#define ADS112C04_REG_CONFIG1       0x01
#define ADS112C04_REG_CONFIG2       0x02
#define   ADS112C04_CONFIG2_DRDY      BIT(7)
#define ADS112C04_REG_CONFIG3       0x03

> +
> +struct ads112c04_state {
> +	struct i2c_client *client;
> +	/* Protects concurrent ADC reads and device configuration */
> +	struct mutex lock;
> +	struct completion completion;
> +	struct regulator *vref_reg;
> +	int vref_mv;
> +	u8 config0;
> +	u8 config1;
> +};
> +
> +static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
> +{
> +	int ret = i2c_master_send(client, &cmd, 1);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *val)
> +{
> +	u8 cmd = ADS112C04_CMD_RREG(reg);
> +	int ret;
> +
> +	ret = i2c_master_send(client, &cmd, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(client, val, 1);
> +	return ret < 0 ? ret : 0;

This can be done in one I2C call.

	ret = i2c_smbus_read_byte_data(client, cmd);
	if (ret < 0)
		reutrn ret;

	*val = ret;

	return 0;


> +}
> +
> +static int ads112c04_write_reg(struct i2c_client *client, u8 reg, u8 val)
> +{
> +	u8 buf[2] = { ADS112C04_CMD_WREG(reg), val };
> +	int ret;
> +
> +	ret = i2c_master_send(client, buf, 2);
> +	return ret < 0 ? ret : 0;

And here it can be:

	u8 cmd = ADS112C04_CMD_WREG(reg);

	return i2c_smbus_write_byte_data(client, cmd, val);

> +}
> +
> +static int ads112c04_wait_for_data(struct ads112c04_state *st)
> +{
> +	int ret;
> +	u8 val;

The slowest data rate is 20 SPS, so wouldn't 100 ms timeout be more than
enough? 1 second seems a bit long.


> +
> +	if (st->client->irq > 0) {
> +		ret = wait_for_completion_timeout(&st->completion, msecs_to_jiffies(1000));
> +		if (!ret)
> +			return -ETIMEDOUT;
> +		return 0;
> +	}
> +
> +	return read_poll_timeout(ads112c04_read_reg, ret,
> +				 (ret < 0 || (val & ADS112C04_DRDY_MASK)),
> +				 1000, 1000000, false,

When there is more than 3 or 4 zeros, it is helpful to use macros, like
1 * MICRO.

> +				 st->client, ADS112C04_REG_CONFIG2, &val);
> +}
> +
> +static int ads112c04_read_data(struct ads112c04_state *st, int *val)
> +{
> +	u8 cmd = ADS112C04_CMD_RDATA;
> +	__be16 buf;

I would call this data instead of buf.

> +	int ret;
> +
> +	ret = i2c_master_send(st->client, &cmd, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(st->client, (u8 *)&buf, 2);

sizeof(buf) instead of 2.

> +	if (ret < 0)
> +		return ret;


Or more simply ...

	ret = i2c_smbus_read_word_data(client, cmd);
	if (ret < 0)
		return ret;

	*val = sign_extend32(be16_to_cpu(ret), 15);

> +
> +	*val = sign_extend32(be16_to_cpu(buf), 15);
> +	return 0;
> +}
> +
> +static int ads112c04_get_adc_result(struct ads112c04_state *st,
> +				    struct iio_chan_spec const *chan,
> +				    int *val)
> +{
> +	int ret;
> +	u8 mux, new_config0;
> +
> +	mux = FIELD_PREP(ADS112C04_MUX_MASK, chan->address);
> +	new_config0 = (st->config0 & 0x0F) | mux;

~ADS112C04_MUX_MASK instead of 0x0F. 

Or:

	new_config0 = st->config0;
	FIELD_MODIFY(ADS112C04_MUX_MASK, &new_config0, chan->address);

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
> +		*val = st->vref_mv;
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
> +	u32 num_channels, i = 0, pair[2];
> +
> +	num_channels = device_get_named_child_node_count(dev, "channel");
> +	if (!num_channels)
> +		return -EINVAL;
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		struct iio_chan_spec *spec = &channels[i];
> +
> +		spec->type = IIO_VOLTAGE;
> +		spec->indexed = 1;
> +		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
> +		spec->scan_index = i;

scan_index isn't currently used, so we could leave that out for now.

> +
> +		if (fwnode_property_present(child, "single-channel")) {
> +			fwnode_property_read_u32(child, "single-channel", &pair[0]);
> +			spec->channel = pair[0];
> +			spec->differential = 0;

differential is already 0, so don't need to set it here.

> +			spec->address = 0x08 + pair[0];
> +		} else if (fwnode_property_present(child, "diff-channels")) {
> +			fwnode_property_read_u32_array(child, "diff-channels", pair, 2);
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
> +				return -EINVAL;

Could be useful to use dev_err_probe() to print a message in this case. Helps
when you make a typo in the devicetree.

> +		} else {
> +			return -EINVAL;
> +		}

I would also check if the other properties mentioned in the DT binding review
exist here and return error if they do since they aren't implemented. See
similar example below with refp-refn properties.

> +		i++;
> +	}
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;

This should be i. num_channels could actually be > i if any node has status = "disabled";.

> +
> +	return 0;
> +}
> +
> +static int ads112c04_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads112c04_state *st;
> +	struct gpio_desc *reset_gpio;
> +	int ret;
> +

Would be nice to make a local dev variable so we don't have to
write &clinet->dev so much.

> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(&client->dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	init_completion(&st->completion);
> +
> +	indio_dev->name = "ads112c04";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads112c04_info;
> +
> +	ret = ads112c04_parse_channels(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(&client->dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "failed to get avdd regulator\n");
> +
> +	ret = devm_regulator_get_enable(&client->dev, "dvdd");
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "failed to get dvdd regulator\n");
> +

We've been tending towards writing below like:

	if (device_property_present(dev, "refp-supply") {
		ret = devm_regulator_get_enable_read_voltage(dev, "refp");
		if (ret < 0)
			return dev_err_probe(dev, ret, "failed to read REFP voltage\n");

		...
	}

And I would check the other ref properties too even if we don't implement them.

	if (device_property_present(dev, "refn-supply")
		return dev_err_probe(dev, -EOPNOTSUPP, "refn-supply is not implemented\n");

	if (device_property_present(dev, "ti,refp-refn-resistor-ohms")
		return dev_err_probe(dev, -EOPNOTSUPP, "ti,refp-refn-resistor-ohms is not implemented\n");

> +	st->vref_reg = devm_regulator_get_optional(&client->dev, "refp");
> +	if (IS_ERR(st->vref_reg)) {
> +		ret = PTR_ERR(st->vref_reg);
> +		if (ret == -ENODEV) {
> +			st->vref_mv = 2048;
> +			st->config1 = 0x00;
> +		} else {
> +			return ret;
> +		}
> +	} else {
> +		ret = regulator_enable(st->vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&client->dev, ads112c04_regulator_disable,
> +					       st->vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(st->vref_reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->vref_mv = ret / 1000;

We've been writing this like:

		st->vref_mv = ret / (MICRO / MILLI);

> +		st->config1 = 0x02;

Add a macro and use FIELD_PREP().

> +	}

And as in the DT bindings reply, we should go ahead and make the reference
voltage per channel. Even if we don't need it now, it would be hard to change
it in the future without breaking existing users.

> +
> +	reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);

If we make this GPIOD_OUT_HIGH, then we save a line later.

> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +
> +	if (reset_gpio) {
> +		gpiod_set_value_cansleep(reset_gpio, 1);
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
> +	st->config0 = 0x01;

Needs a macro and FIELD_PREP().

Also, since we are parsing channels now, can/should we leave PGA enabled
for diff-channels? Otherwise add a comment explaining current choice.

> +	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->config0);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_irq(&client->dev, client->irq,
> +				       ads112c04_irq_handler,
> +				       0,

Can put 0 on the previous line.

> +				       indio_dev->name, indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "Failed to request DRDY IRQ\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id ads112c04_id[] = {
> +	{ .name = "ads112c04", .driver_data = 0 },

No need for .driver_data since it is 0.

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

