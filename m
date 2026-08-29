Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1779CD;
	Sat, 29 Aug 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788025014; cv=none; b=aaYk9/1VcRT+SJuIKz8Eo1oegc9Dvw7Sw+3WKvykf5YzOgX3pIGDhaUTMJHr+aE6okpsvCPhrgHUu4/g5bbDiRUL8ND6/MdGYw1S3Wc7YJu8QH4D0L+UHd3FD/YtMJUM4/ZeXAsngb5J/jwGTtVvCklnFFqiEEPd2wZ5XqwujqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788025014; c=relaxed/simple;
	bh=srH0E+Bef3FLUxE2WXWOPDWFGjI35lRWb7diZ0584LY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=G8tKfSAXJIY68zZwyvVEhFS2snSMKBgeqNGKqB/6P6Nq4wyHq3DwyjkDQpCn/SDdjxMJpWh6Rm2eyKb3SdexZyz2QxdEsUljDPzB31MhASBTkV/q2xBBSkUOLOxhbcrO2RPIi5SzioDZte91LZ/1MRtq7Rp+6NEdFIb7NaEb/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzvpSyrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzvpSyrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E721F000E9;
	Sat, 29 Aug 2026 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788025013;
	bh=arwNI5jvfLFyh17u1JnYh5UjicEST3xS0vCapCq6HXU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HzvpSyrwPhC8/ro+FLt23pBGUSoPVX6y+8BZN7Std7iTmfSLArdsqpm5Q1rbFQ3NC
	 4C2FSiu/M9NTub1Kas7xNpmINb/6x9FZdxxN+x6nKCx5Hn4Btw5xobGLEsh11R9UF8
	 tfcuidY9ISZFbn0ayT3ct+4kAqr9rsacmTXaKnqXqQqggsz64vzvRnjcRO4P3iJOP9
	 MKTvbn3TaIqBvNi+FbsbyEbxHwK9omx6V2zOTbEZfwOLBHdbXshiwV5uzfUAA6bBr3
	 eNyuIjiFp+tCHqU7qWMEygV+n/SaE9h8Y8avZi9wnTZL3Jn57pEuWComSRKG7NLC1C
	 4MrEJ8SLhO9hA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 4/4] iio: dac: ad3530r: add support for
 AD5710R/AD5711R
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com, 
 devicetree@vger.kernel.org
In-Reply-To: <20260829-iio-ad5710r-upstream-v4-4-8af3121c7d21@analog.com>
References: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
 <20260829-iio-ad5710r-upstream-v4-4-8af3121c7d21@analog.com>
Date: Sat, 29 Aug 2026 18:36:30 +0100
Message-Id: <178802499067.2615829.14956299998028570684.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7162;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=srH0E+Bef3FLUxE2WXWOPDWFGjI35lRWb7diZ0584LY=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqkxii+pi3yvN0pxqP2EwEQzk15cuG/5XNOp6yl
 kHtKh1ZeAKJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapMYohEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiGSrD/4+3H8g1HAsjTjdGfLbbwpilIetycaQh9ZtEq6AgXnlrf/
 Sqprc+OzwQf5uC0Bx7CiGr13SSJtocS+0K08G4OmRzv3AkPVZdruiugFRbteoBTFRbmbsatX6BO
 jcFY+nKnWDhqCpyTMoZWvocWoyNHn4jzRbtn5H4KdWQOdLVEO1y7jZWb+MGS36mSLMd38mF0raq
 RenLOI91GOrnemVJhSUjxesCrt8cRiiczmLvD2gA+c1FAOlZB93c4jC4tN2RDCByUrzuagHQxst
 yMFN+aryP9QPZDlKq1Tp+WdrvjXXO1Af100YzAibk9JVLjGhThdh7lFQeM7zpLz71JJt6zcoJw3
 OCHPIPjI8onqUJtzWiRxgI9xAPjUkE681QcJsC8G7fVpqq5shVjBIbP4dnLwOb3m0XJxC3p9SmI
 wUEvhrP9gspKF4wa54qUx1iLB8wD5Y6ULnlvKzqy+ecVZYGKQ/SUlFABhP78TTa/lT5eo9JkVMr
 nOuTooFEZxIaTw8ZKbPDXCnOENRYOpSOSA7dV1Ko8uSTFIFA2YBXdmPukE2kUYLtyvgQVBPI4uO
 iJsKsw9rwx6PaKjiH6gScDlSbLPcSk9CAzB9UH4I17FtV8w5kBGC+2CWFNfGj73pBGflYTPgxou
 7JriFerrWuxuoFVQNOJ0GuFYq/aijv8D0wFfeFA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add support for the AD5710R/AD5711R, 8-channel 16-/12-bit configurable
> IDAC/VDAC parts. They share the AD3530R register map and access model,
> so fold them into this driver.
> 
> Each channel is configured as voltage or current output from its DT
> channel@N node via adi,ch-func, building the iio_chan_spec dynamically.
> Voltage channels enable VMODE_EN and report the reference-derived scale,
> current channels report the 50 mA internal Iref scale. The powerdown
> mode is read-only and derived from the channel's configured type.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 3b3c77d8b3e1..f108d5bac572 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -16,6 +16,7 @@ config AD3530R
>  	  - AD3530/AD3530R (8-channel)
>  	  - AD3531/AD3531R (4-channel)
>  	  - AD3532/AD3532R (16-channel)
> +	  - AD5710R/AD5711R (8-channel configurable IDAC/VDAC)
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad3530r.
> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> index 3056593a5ca0..dd8d5547fd16 100644
> --- a/drivers/iio/dac/ad3530r.c
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -3,6 +3,8 @@
>   * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
>   * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
>   * AD3532R/AD3532 16-channel, 16-bit Voltage Output DAC Driver
> + * AD5710R 8-channel, 16-bit Configurable IDAC/VDAC Driver
> + * AD5711R 8-channel, 12-bit Configurable IDAC/VDAC Driver
>   *
>   * Copyright 2025 Analog Devices Inc.

FWIW this is a substantial enough change that I'd kind of expect any update
on the copywrite to 2025-26.

>   */
> @@ -27,6 +29,8 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> +#include <dt-bindings/iio/addac/adi,ad74413r.h>
> +
>  #define AD3530R_INTERFACE_CONFIG_A		0x00
>  #define AD3530R_OUTPUT_OPERATING_MODE_0		0x20
>  #define AD3530R_OUTPUT_OPERATING_MODE_1		0x21
> @@ -39,6 +43,8 @@
>  #define AD3531R_SW_LDAC_TRIG_A			0xDD
>  #define AD3531R_INPUT_CH			0xE3
>  
> +#define AD5710R_CHN_VMODE_EN			0xFF
> +
>  /* AD3532R/AD3532 bank 0 registers (channels 0-7) */
>  #define AD3532R_INTERFACE_CONFIG_A_0		0x1000
>  #define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
> @@ -62,9 +68,11 @@
>  #define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
>  #define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
>  #define AD3530R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << 2 * (chan))
> +#define AD5710R_CHN_VMODE_EN_BIT(chan)		BIT(chan)
>  
>  #define AD3530R_SW_RESET			(BIT(7) | BIT(0))
>  #define AD3530R_INTERNAL_VREF_mV		2500
> +#define AD5710R_INTERNAL_IREF_mA		50
>  #define AD3530R_LDAC_PULSE_US			100
>  
>  #define AD3530R_CH_PER_REG			4
> @@ -99,6 +107,7 @@ struct ad3530r_chip_info {
>  	unsigned int num_op_mode_regs;
>  	unsigned int resolution;
>  	bool internal_ref_support;
> +	bool channel_configurable;

If respinning for any other reason I think a more specific bool naming
would likely prove a better bet for the future.

>  };

> +static const char * const ad5710r_powerdown_modes[] = {
> +	"15kohm_to_gnd",
> +	"three_state",
> +};



> +static const struct iio_enum ad5710r_powerdown_mode_enum = {
> +	.items = ad5710r_powerdown_modes,
> +	.num_items = ARRAY_SIZE(ad5710r_powerdown_modes),
> +	.get = ad5710r_get_powerdown_mode,
> +};

> +static const struct iio_chan_spec_ext_info ad5710r_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.shared = IIO_SEPARATE,
> +		.read = ad5710r_get_dac_powerdown,
> +		.write = ad5710r_set_dac_powerdown,
> +	},
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5710r_powerdown_mode_enum),
> +	{ }
> +};

This doesn't make sense.  The code is I advertising a choice of two power
own modes, but in reality as you state in the patch description there
is no choice as it comes from whether it is a voltage or a current
output channel.

Upshot, you can either not provide powerdown_mode_available (easiest
path here) or it for some reason userspace expects it, then you need
to make it only list the variant you want which means you can't use
the IIO_ENUM stuff to provide it.

> +
>  #define AD3530R_CHAN(_chan, _ext_info)				\
>  {								\
>  	.type = IIO_VOLTAGE,					\
> @@ -467,6 +574,17 @@ static const struct iio_chan_spec ad3532r_channels[] = {
>  	AD3530R_CHAN(15, ad3532r_ext_info),
>  };

...

> +static int ad3530r_parse_channel_cfg(struct iio_dev *indio_dev)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct iio_chan_spec *channels;
> +	unsigned int num_chan, i;
> +	int ret;
> +	u32 reg;
> +
> +	num_chan = device_get_child_node_count(dev);
> +	if (!num_chan)
> +		return dev_err_probe(dev, -ENOENT, "No channels configured\n");
> +
> +	channels = devm_kcalloc(dev, num_chan, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	device_for_each_child_node_scoped(dev, child) {
> +		unsigned int mode_reg, mode_mask, ch_func;
> +		enum iio_chan_type chan_type;

I think reg is only used in the loop. If so, declare it here.

> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read reg property of %pfwP\n",
> +					     child);
> +
> +		if (reg >= st->chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg out of range in %pfwP\n",
> +					     child);
> +
> +		ret = fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing adi,ch-func property for %pfwP\n",
> +					     child);
> +
> +		switch (ch_func) {
> +		case CH_FUNC_VOLTAGE_OUTPUT:
> +			ret = regmap_set_bits(st->regmap, AD5710R_CHN_VMODE_EN,
> +					      AD5710R_CHN_VMODE_EN_BIT(reg));
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to set voltage output for %pfwP\n",
> +						     child);
> +
> +			chan_type = IIO_VOLTAGE;
> +			break;
> +		case CH_FUNC_CURRENT_OUTPUT:
> +			chan_type = IIO_CURRENT;
> +			break;
> +		default:
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid adi,ch-func %u for %pfwP\n",
> +					     ch_func, child);
> +		}
> +
> +		channels[i] = ad5710r_channels[reg];
> +		channels[i].type = chan_type;
> +		i++;
> +
> +		ad5710r_get_op_mode_reg(reg, &mode_reg, &mode_mask);
> +
> +		/* Enable the channel in normal operation mode */
> +		ret = regmap_update_bits(st->regmap, mode_reg, mode_mask,
> +					 field_prep(mode_mask, AD3530R_NORMAL_OP));
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to set normal operating mode for %pfwP\n",
> +					     child);
> +	}
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_chan;
> +
> +	return 0;
> +}
> +

Rest looks good to me,

Thanks

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
