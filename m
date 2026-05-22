Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC73140E5F;
	Fri, 22 May 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470698; cv=none; b=lM7iye9zGhzmB+vcqWqqDmaq52yyZ1mcWO5kGZEqFyPdPPH4j4IKoykM6bLBJNJPsCv7LZE+TOyueyLUNS50rx4knZlzkMSAPlBGD+CG2JVdNgHM63mcDqSmZZocwryJk4Wt6yVWMV9IXoG2StB+EQObqNbo58uc9cPjdyXkJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470698; c=relaxed/simple;
	bh=KRk3xgxCoxPNSYqXiLnsUeKObn/dXh4PRhBFTrQQ7BU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/tgzO/p0JnUMvtakOhJe7gSCv3X5YMtS9Y7eY3Jf+WVW+Eu6KVBd0JqEdXa927vUaWCL30G9H9HQSwj83BDBz+JJLckwelKWLLyhD+Bc6BtBqCGcN/Ff6A7Ed6MF8W5OvWC9p9TRxXw0+5Ygq1D2NpJTnJoDrQsX9z3Y7CzX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXMjombk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXMjombk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAFA1F000E9;
	Fri, 22 May 2026 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470696;
	bh=4mjjO6VdneKoWeCj+NB5NbY7sQb+ZjmoHWbdwNDYLCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kXMjombkCWxrWwK6n8igXy0dLuJMF2cZsfCA/tIV/Wk09CM5+UWWbH85RFT5KAbpe
	 igi7SE8wZ3dt2nVlaiUDDsHjUUnPaaN5hce6NPNfUT6qGjhNFk+vRoqw/DkuKV0xq7
	 xkKUu+F5e7sDAc/DJaSm3M4zxvI7Y6kDQt67Q1YqpJX7DTtFGGkd4MWcMIxhM4FtUy
	 2AeBKmoWqRitdWTCoMCqMKStO9BaLkbfBSzyeeN3N+gw1rl0+rb3i7W6+2XemoXp2J
	 yb5lmivZH4JdkqqSRSpMdHF1nAC5a8F0eFgeTn4D+1O7ZP1YMAzxPzwFkk23jluNCn
	 UFHHLO9F6WFNQ==
Date: Fri, 22 May 2026 18:24:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, "Jonathan Corbet" <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260522182445.6e58a58f@jic23-huawei>
In-Reply-To: <20260519-ad5529r-driver-v3-2-267c0731aa68@analog.com>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
	<20260519-ad5529r-driver-v3-2-267c0731aa68@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 17:42:59 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Hi Janani,

A few more things inline from a fresh read.

Have a good weekend

Jonathan


> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 003431798498..f35e060b3643 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_AD5446) += ad5446.o
>  obj-$(CONFIG_AD5446_SPI) += ad5446-spi.o
>  obj-$(CONFIG_AD5446_I2C) += ad5446-i2c.o
>  obj-$(CONFIG_AD5449) += ad5449.o
> +obj-$(CONFIG_AD5529R) += ad5529r.o
>  obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>  obj-$(CONFIG_AD5592R) += ad5592r.o
>  obj-$(CONFIG_AD5593R) += ad5593r.o
> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> new file mode 100644
> index 000000000000..9bb63030db95
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c
> @@ -0,0 +1,527 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD5529R Digital-to-Analog Converter Driver
> + * 16-Channel, 12/16-Bit, 40V High Voltage Precision DAC
> + *
> + * Copyright 2026 Analog Devices Inc.
> + * Author: Janani Sunil <janani.sunil@analog.com>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>

Generally don't include this in drivers unless you actually use
stuff in that header.  dev_printk.h etc are preferred.

> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +
> +#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
> +#define AD5529R_REG_DEVICE_CONFIG		0x02
> +#define AD5529R_REG_CHIP_GRADE			0x06
> +#define AD5529R_REG_SCRATCH_PAD			0x0A
> +#define AD5529R_REG_SPI_REVISION		0x0B
> +#define AD5529R_REG_VENDOR_H			0x0D
> +#define AD5529R_REG_STREAM_MODE			0x0E
> +#define AD5529R_REG_INTERFACE_STATUS_A		0x11
> +#define AD5529R_REG_MULTI_DAC_CH_SEL		0x14
> +#define AD5529R_REG_OUT_RANGE_BASE		0x3C
> +#define AD5529R_REG_OUT_RANGE(ch)		(AD5529R_REG_OUT_RANGE_BASE + (ch) * 2)
> +#define AD5529R_REG_DAC_INPUT_A_BASE		0x148
> +#define AD5529R_REG_DAC_INPUT_A(ch)		(AD5529R_REG_DAC_INPUT_A_BASE + (ch) * 2)
> +#define AD5529R_REG_DAC_DATA_READBACK_BASE	0x16A
> +#define AD5529R_REG_TSENS_ALERT_FLAG		0x18C
> +#define AD5529R_REG_TSENS_SHTD_FLAG		0x18E
> +#define AD5529R_REG_FUNC_BUSY			0x1A0
> +#define AD5529R_REG_REF_SEL			0x1A2
> +#define AD5529R_REG_INIT_CRC_ERR_STAT		0x1A4
> +#define AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC	0x1A8
> +
> +#define   AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0))
> +#define   AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
> +#define   AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
> +#define   AD5529R_REF_SEL_MASK			BIT(0)
Often when it's a single bit we don't call it MASK, but instead express
what the value with the bit set means.

> +#define   AD5529R_MAX_REGISTER			0x232
> +#define   AD5529R_8BIT_REG_MAX			0x13
> +#define   AD5529R_SPI_READ_FLAG			0x80

> +static int ad5529r_reset(struct ad5529r_state *st)
> +{
> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst = devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	if (rst) {
> +		ret = reset_control_deassert(rst);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +				   AD5529R_INTERFACE_CONFIG_A_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fsleep(10000);

Comment on why this value - typically a datasheet reference.

> +
> +	return regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +			    AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE |
> +			    AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION);
> +}
> +
> +static int ad5529r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ad5529r_state *st = iio_priv(indio_dev);
> +	unsigned int reg_addr, reg_val_h;
> +	int ret, range_idx, span_mv;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);

Sashiko made an interesting point here about whether the readback register
makes more sense here. I think not but maybe we should add a comment on
why.  My understanding is we are only dealing with the A value of the
toggle for now and this therefore always reflects the value set.

> +		ret = regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val_h;
> +
> +		return IIO_VAL_INT;


> +
> +static int ad5529r_find_output_range(const s32 *vals)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad5529r_output_ranges_mv); i++) {
	for (unsigned int i = 0; ...

> +		if (vals[0] == ad5529r_output_ranges_mv[i][0] * 1000 &&
> +		    vals[1] == ad5529r_output_ranges_mv[i][1] * 1000)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5529r_parse_channel_ranges(struct device *dev,
> +					struct ad5529r_state *st)
> +{
> +	int ret, ch, range_idx;
> +	s32 vals[2];
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		range_idx = AD5529R_RANGE_0V_5V;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);

Another sashiko one. Type is wrong. Need to pass in a u32 point. In practice
unlikely to be a problem but lets match what is expected.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing reg property in channel node\n");
> +
> +		if (ch >= 16)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid channel number: %d\n", ch);
> +
> +		if (!fwnode_property_read_u32_array(child,
> +						    "adi,output-range-microvolt",
> +						    vals, 2)) {

Here I think it is deliberately reading into signed storage.  Add a comment on that.
Might get the bot to leave it alone ;)  ARRAY_SIZE(vals) instead of 2.

> +			range_idx = ad5529r_find_output_range(vals);
> +			if (range_idx < 0)
> +				return dev_err_probe(dev, range_idx,
> +						     "Invalid range [%d %d] for ch %d\n",
> +						     vals[0], vals[1], ch);
> +		}
> +
> +		st->output_range_idx[ch] = range_idx;
> +		ret = regmap_write(st->regmap_16bit,
> +				   AD5529R_REG_OUT_RANGE(ch), range_idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure range for ch %d\n",
> +					     ch);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad5529r_debugfs_reg_read(struct ad5529r_state *st, unsigned int reg,
> +				    unsigned int *val)
> +{
> +	return regmap_read(ad5529r_get_regmap(st, reg), reg, val);
> +}
> +
> +static int ad5529r_debugfs_reg_write(struct ad5529r_state *st, unsigned int reg,
> +				     unsigned int val)
> +{
> +	return regmap_write(ad5529r_get_regmap(st, reg), reg, val);
> +}

These two helpers don't seem worth having over putting the calls inline.
Particularly as both are getting the regmap.

> +
> +static int ad5529r_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int writeval,
> +			      unsigned int *readval)
> +{
> +	struct ad5529r_state *st = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return ad5529r_debugfs_reg_read(st, reg, readval);
> +
> +	return ad5529r_debugfs_reg_write(st, reg, writeval);
> +}

> +static int ad5529r_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5529r_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->spi = spi;
> +
> +	st->model_data = spi_get_device_match_data(spi);
> +	if (!st->model_data)
> +		return dev_err_probe(dev, -EINVAL, "Failed to identify device variant\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad5529r_supply_names),
> +					     ad5529r_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable regulators\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "hvss");

Sashiko spotted this.   Try dropping hvss from your dt and see what return value you get.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable hvss regulator\n");
> +
> +	st->vref_regulator = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(st->vref_regulator)) {
> +		if (PTR_ERR(st->vref_regulator) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(st->vref_regulator),
> +					     "Failed to get vref regulator\n");
> +		st->vref_regulator = NULL;
> +	}
> +
> +	if (st->vref_regulator) {
> +		ret = regulator_enable(st->vref_regulator);
If you aren't going to use it except to enable, use
devm_regulator_get_optional_enabled() and a bool flag.

Sashiko had a comment about the oddity of not reading the voltage, but I think
that's fine as the datasheet seems pretty insistent it must be 4.096V to work
correctly. Bit odd as it also provides a range of values.  Ah well.
Perhaps add a comment somewhere to remind us of this assumption.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable vref regulator\n");
> +
> +		ret = devm_add_action_or_reset(dev, ad5529r_disable_regulator,
> +					       st->vref_regulator);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to add vref regulator cleanup\n");
> +	}

> +
> +	ret = regmap_update_bits(st->regmap_16bit, AD5529R_REG_REF_SEL,
> +				 AD5529R_REF_SEL_MASK,
> +				 st->vref_regulator ? 0 : AD5529R_REF_SEL_MASK);

regmap_assign_bits() using a flag for vref presence as mentioned above

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to configure reference\n");


> +static const struct spi_device_id ad5529r_id[] = {
> +	{ "ad5529r-16", .driver_data = (kernel_ulong_t)&ad5529r_16bit_model_data },
> +	{ "ad5529r-12", .driver_data = (kernel_ulong_t)&ad5529r_12bit_model_data },
.name =  

Might be long enough you need to do.
	{
		.name = ....
		.driver_data = (kernel_ulong_t)&...
 
> +	{ }
> +};


