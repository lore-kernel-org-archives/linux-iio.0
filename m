Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10F1F4C8C;
	Sun, 22 Mar 2026 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774198270; cv=none; b=iKe087ormRomcHbsEkSssHYxy1PADEDJrukbQ+MfsueXS06vfHsf/CZALAM31qnrjHEnuOzZZX0hf5rdwZvitV330mFqAy51ke7HBu/ZCGosozlNNBWHQYYb2Ru49tVDaSNKKUHht/QsfeGD4HDDZ8RkgJNHKJ82lMjeLUoM03E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774198270; c=relaxed/simple;
	bh=spZ0PXZnWr4H1sFpl+vDEMg/ktjcpwVDoch6D86ZljA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3OEeXTyaRcuKPOhNdFGRgBwT/5K2Kyojhg+r6N52G0Fre5K7QpdQabGSZjRfE4mCdubyKbkKvwq9EKagThHBkq+I717rA9NPwu26DxG+93GvZhejsBrEiw0Bf9VlPQ6hzDPZebrGBvBlXSbX77I/dXjcNAIC3GToUhcIwhhScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZq+zS9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZq+zS9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C26C19424;
	Sun, 22 Mar 2026 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774198269;
	bh=spZ0PXZnWr4H1sFpl+vDEMg/ktjcpwVDoch6D86ZljA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZq+zS9jo24eb5qks7LZpnqB4cOXGlyRVTAGQao05lkS8Hd+RHgEmyCKsf5dUv74F
	 1N9d7lkFOj+sanN5fjaZggExWmnhC0Q9NkmGou6JrdsrbzWx29ahUlVXV5gT62sVGy
	 zL9SuzqzQuscvjo9rpbN6RudbOofqM9dHUtWkAvBTZ1W89YC7scVKgd+zSyhrRT81H
	 V3BLsLxRwdEjDhDVj/y5arP49Qnq7djyn5fRnWI9fOKBlp4yxt2gy1yXn700zgzzkc
	 V8U6FjnZ4HmTONka828u1ErT238P6zYxmGHM7KIcAkHzqFHkDub7/l6+vEeC/AdCbx
	 M02vbNqowvdrw==
Date: Sun, 22 Mar 2026 16:50:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 2/9] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <20260322165058.6c4b193e@jic23-huawei>
In-Reply-To: <20260318-ad9910-iio-driver-v2-2-e79f93becf11@analog.com>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
	<20260318-ad9910-iio-driver-v2-2-e79f93becf11@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 17:56:02 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add the core AD9910 DDS driver infrastructure with single tone mode
> support. This includes SPI register access, profile management via GPIO
> pins, PLL/DAC configuration from firmware properties, and single tone
> frequency/phase/amplitude control through IIO attributes.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo

I want some time for the discussion on the ABI to take place and haven't
made any real comments on that here. Focus was more on the code.

So various minor things inline,

Thanks,

Jonathan

> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 583cbdf4e8cd..180e74f62d11 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig

> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> new file mode 100644
> index 000000000000..a362d96cf651
> --- /dev/null
> +++ b/drivers/iio/frequency/ad9910.c
> @@ -0,0 +1,1006 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD9910 SPI DDS (Direct Digital Synthesizer) driver
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>

Generally can avoid including device.h in favour of more specific
headers.  There are a few exceptions where we can't such as actual
dereferencing of struct device, but I don't recall seeing a case in here.

> +
> +#define AD9910_ASF_MAX			(BIT(14) - 1)
> +#define AD9910_POW_MAX			(BIT(16) - 1)
GENMASK() tends to be clearer for max values.



> +
> +static const char * const ad9910_power_supplies[] = {
> +	"dvdd-io33", "avdd33", "dvdd18", "avdd18",
> +};
> +
> +static const char * const ad9910_refclk_out_drv0[] = {
> +	"disabled", "low", "medium", "high",
> +};

These are only used in very localized bits of code. I'd move them down near
them rather than having them up here at the top of the file.


> +static int ad9910_profile_set(struct ad9910_state *st, u8 profile)
> +{
> +	DECLARE_BITMAP(values, BITS_PER_TYPE(profile));
> +
> +	if (profile >= AD9910_NUM_PROFILES)
> +		return -EINVAL;
> +
> +	st->profile = profile;
> +	values[0] = profile;
> +	gpiod_multi_set_value_cansleep(st->gpio_profile, values);

Trivial but blank line here. Having one before a simple return statement
just makes it a little easier to read.

> +	return 0;
> +}
>
> +
> +#define AD9910_EXT_INFO(_name, _ident, _shared) { \
> +	.name = _name, \
> +	.read = ad9910_ext_info_read, \
> +	.write = ad9910_ext_info_write, \
> +	.private = _ident, \
> +	.shared = _shared, \

If there are only a few of these, I'd put it long hand rather than
using a macro. Tends to end up easier to read.

> +}
> +
> +static const struct iio_chan_spec_ext_info ad9910_phy_ext_info[] = {
> +	AD9910_EXT_INFO("profile", AD9910_PROFILE, IIO_SEPARATE),
> +	AD9910_EXT_INFO("powerdown", AD9910_POWERDOWN, IIO_SEPARATE),
> +	{ }
> +};

> +static int ad9910_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	u64 tmp64;
> +	u32 tmp32;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_SINGLE_TONE:

I haven't read on yet, but if you never have any other cases in here,
perhaps us an if() as it will reduce indent of the code that follows.

> +			tmp32 = FIELD_GET(AD9910_PROFILE_ST_FTW_MSK,
> +					  st->reg[AD9910_REG_PROFILE(st->profile)].val64);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		tmp64 = (u64)tmp32 * st->data.sysclk_freq_hz;
> +		*val = upper_32_bits(tmp64);
> +		*val2 = upper_32_bits((u64)lower_32_bits(tmp64) * MICRO);

I've no idea how this *val2 assignment works... Perhaps some comments?

> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_PHASE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_SINGLE_TONE:
> +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_POW_MSK,



> +
> +static int ad9910_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u64 tmp64;
> +	u32 tmp32;
> +	u16 tmp16;
> +	bool high32 = FIELD_GET(AD9910_REG_HIGH32_FLAG_MSK, reg);
> +
> +	/*
> +	 * HIGH32 flag is a workaround to allow access to upper 32 bits of
> +	 * 64-bit registers one at a time due to debugfs_reg_access limitations
> +	 * of only supporting 32-bit values.
> +	 */
> +	reg &= ~AD9910_REG_HIGH32_FLAG_MSK;
> +	if (reg >= AD9910_REG_RAM)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (reg) {
Split this in to two helpers.  It's rather hard to follow with read and
write paths mixed up in the code flow. 
> +	case AD9910_REG_DRG_LIMIT:
> +	case AD9910_REG_DRG_STEP:
> +	case AD9910_REG_PROFILE0:
Can you do
	case AD9910_REG_PROFILE0 ... AD9910_REG_PROFILE7:
here to help readability?

> +	case AD9910_REG_PROFILE1:
> +	case AD9910_REG_PROFILE2:
> +	case AD9910_REG_PROFILE3:
> +	case AD9910_REG_PROFILE4:
> +	case AD9910_REG_PROFILE5:
> +	case AD9910_REG_PROFILE6:
> +	case AD9910_REG_PROFILE7:
> +		if (readval) {
> +			ret = ad9910_reg64_read(st, reg, &tmp64);
> +			if (ret < 0)
> +				return ret;
> +
> +			if (high32)
> +				*readval = upper_32_bits(tmp64);
> +			else
> +				*readval = lower_32_bits(tmp64);
Might as well return 0 here.

> +		} else {
> +			tmp64 = st->reg[reg].val64;
> +			if (high32)
> +				FIELD_MODIFY(GENMASK_ULL(63, 32), &tmp64, writeval);
> +			else
> +				FIELD_MODIFY(GENMASK_ULL(31, 0), &tmp64, writeval);
> +
> +			return ad9910_reg64_write(st, reg, tmp64, true);
> +		}
> +		break;
> +	case AD9910_REG_POW:
> +		if (!readval)
> +			return ad9910_reg16_write(st, reg, writeval, true);
> +
> +		ret = ad9910_reg16_read(st, reg, &tmp16);
> +		if (ret < 0)
> +			return ret;
> +		*readval = tmp16;
> +		break;
return 0;
> +	default:
> +		if (!readval)
> +			return ad9910_reg32_write(st, reg, writeval, true);
> +
> +		ret = ad9910_reg32_read(st, reg, &tmp32);
> +		if (ret < 0)
> +			return ret;
> +		*readval = tmp32;
> +		break;
and return 0; here.  No point in break to go to as return and nothing else.

> +	}
> +
> +	return ret;
> +}

> +
> +static int ad9910_cfg_sysclk(struct ad9910_state *st, bool update)
> +{
> +	u32 tmp32, cfr3 = AD9910_CFR3_OPEN_MSK;
> +
> +	cfr3 |= AD9910_CFR3_VCO_SEL_MSK |
> +		FIELD_PREP(AD9910_CFR3_DRV0_MSK, st->data.refclk_out_drv);
> +
> +	if (st->data.pll_enabled) {
> +		tmp32 = st->data.pll_charge_pump_current - AD9910_ICP_MIN_uA;
> +		tmp32 = DIV_ROUND_CLOSEST(tmp32, AD9910_ICP_STEP_uA);
> +		cfr3 |= FIELD_PREP(AD9910_CFR3_ICP_MSK, tmp32) |
> +			AD9910_CFR3_PLL_EN_MSK;
> +	} else {
> +		cfr3 |= AD9910_CFR3_ICP_MSK |

For this, be explicit what value you are setting, probably be defining a max value
that the field can take.  Whilst just setting the mask is the same it doesn't
convey the same meaning to someone reading the code.

> +			AD9910_CFR3_REFCLK_DIV_RESETB_MSK |
> +			AD9910_CFR3_PFD_RESET_MSK;
> +	}
> +	st->reg[AD9910_REG_CFR3].val32 = cfr3;
> +
> +	return ad9910_set_sysclk_freq(st, AD9910_PLL_OUT_MAX_FREQ_HZ, update);
> +}
> +
> +static int ad9910_parse_fw(struct ad9910_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	u32 tmp;
> +	int ret;
> +
> +	st->data.pll_enabled = device_property_read_bool(dev, "adi,pll-enable");
> +	if (st->data.pll_enabled) {
> +		tmp = AD9910_ICP_MAX_uA;

Defaulting to max current seems unusual.  What's the motivation? Normal instinct is
go minimum if no other info.

> +		device_property_read_u32(dev, "adi,charge-pump-current-microamp", &tmp);
> +		if (tmp < AD9910_ICP_MIN_uA || tmp > AD9910_ICP_MAX_uA)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "invalid charge pump current %u\n", tmp);
> +		st->data.pll_charge_pump_current = tmp;
> +
> +		st->data.refclk_out_drv = AD9910_REFCLK_OUT_DRV_DISABLED;
> +		ret = device_property_match_property_string(dev,
> +							    "adi,refclk-out-drive-strength",
> +							    ad9910_refclk_out_drv0,
> +							    ARRAY_SIZE(ad9910_refclk_out_drv0));
> +		if (ret >= 0)
> +			st->data.refclk_out_drv = ret;
> +	}
> +
> +	tmp = AD9910_DAC_IOUT_DEFAULT_uA;
> +	device_property_read_u32(dev, "adi,dac-output-current-microamp", &tmp);
> +	if (tmp < AD9910_DAC_IOUT_MIN_uA || tmp > AD9910_DAC_IOUT_MAX_uA)
> +		return dev_err_probe(dev, -ERANGE,
> +				     "Invalid DAC output current %u uA\n", tmp);
> +	st->data.dac_output_current = tmp;
> +
> +	return 0;
> +}
> +
> +static int ad9910_setup(struct ad9910_state *st, struct reset_control *dev_rst)
> +{
> +	u32 reg32;
> +	int ret;
> +
> +	ret = reset_control_deassert(dev_rst);
> +	if (ret)
> +		return ret;
> +
> +	reg32 = AD9910_CFR1_SDIO_INPUT_ONLY_MSK;
> +	ret = ad9910_reg32_write(st, AD9910_REG_CFR1, reg32, false);
Trivial but I'd not bother using the local variable for simple values.
	ret = ad9910_reg32_write(st, AD9910_REG_CFR1,
				 AD9910_CFR1_SDIO_INPUT_ONLY_MSK, false);
is fine.
> +	if (ret)
> +		return ret;
> +
> +	reg32 = AD9910_CFR2_AMP_SCALE_SINGLE_TONE_MSK;

This split seems odd.  Why not combine above and the next block?

> +	reg32 |= AD9910_CFR2_SYNC_TIMING_VAL_DISABLE_MSK |
> +		 AD9910_CFR2_DRG_NO_DWELL_MSK |
> +		 AD9910_CFR2_DATA_ASM_HOLD_LAST_MSK |
> +		 AD9910_CFR2_SYNC_CLK_EN_MSK |
> +		 AD9910_CFR2_PDCLK_ENABLE_MSK;
> +	ret = ad9910_reg32_write(st, AD9910_REG_CFR2, reg32, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_cfg_sysclk(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_set_dac_current(st, false);
> +	if (ret)
> +		return ret;
> +
> +	return ad9910_io_update(st);
> +}
> +
> +static void ad9910_release(void *data)
> +{
> +	struct ad9910_state *st = data;
> +
> +	if (!ad9910_powerdown_set(st, true))
> +		return;
> +
> +	ad9910_reg32_update(st, AD9910_REG_CFR1,
> +			    AD9910_CFR1_SOFT_POWER_DOWN_MSK,
> +			    AD9910_CFR1_SOFT_POWER_DOWN_MSK,
> +			    true);
> +}
> +
> +static int ad9910_probe(struct spi_device *spi)
> +{
> +	struct reset_control *dev_rst;
> +	struct gpio_desc *io_rst_gpio;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad9910_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	st->refclk = devm_clk_get_enabled(dev, "ref_clk");
> +	if (IS_ERR(st->refclk))
> +		return dev_err_probe(dev, PTR_ERR(st->refclk),
> +				     "Failed to get reference clock\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(ad9910_power_supplies),
> +					     ad9910_power_supplies);

Maybe we can just call it ad9910_supplies without loss of meaning and have
slightly shorter lines?  Could also drag that const array into scope of this
function perhaps as we only need it in here.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "ad9910";
> +	indio_dev->info = &ad9910_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad9910_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad9910_channels);
> +
> +	dev_rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(dev_rst))
> +		return dev_err_probe(dev, PTR_ERR(dev_rst),
> +				     "failed to get device reset control\n");
> +
> +	ret = reset_control_assert(dev_rst);
Do we need this?  I 'think' that the gpio reset controller will ensure that
the reset line is GPIOD_OUT_HIGH, on registering it.
https://elixir.bootlin.com/linux/v6.19.9/source/drivers/reset/reset-gpio.c#L81
and that should I think correspond to asserted.

I was curious why there were _deasserted() variants of the get but not
_asserted() ones and went looking.  Seems assumption is that in general
should already be in asserted state as firmware deals with that (here the dt
binding / gpio reset driver).



> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to assert device reset control\n");

...

> +	ret = ad9910_parse_fw(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_setup(st, dev_rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "device setup failed\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ad9910_release, st);

What is this undoing?  Very unusual to have a register write that you
want to happen 'before' the userspace interfaces go away in the remove()
path.  Perhaps it is paired with ad9910_setup()?


> +}

> 

