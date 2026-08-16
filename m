Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD11448E0;
	Sun, 16 Aug 2026 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786907456; cv=none; b=SNbWD9Ux4B3u4Z4wjk0B5dy2iql+GaucV7A0Q91QLdbLyVI5dsiNu4ladVk9/c/UgIMp1xtBEyNMBUBhGgVkG3UbxM8uyeJrZ1+0mY7zH3/T+CLIpaLQmxrwsEBHZQlFXB6k3ua3D1mtZBkMZ3mXiJ/k5WBFzaXbxWIvI+tskVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786907456; c=relaxed/simple;
	bh=dXyfwN1OvHUR4hsNbuXVPctafFuigpJVVPxnCc59rKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izgCu3FU1tajxXbLBbSTdMvJiT3AItCnsJKUivvDzsDUuW1zKal6BsbivIbGqlC5oIWTxeD1bjdmrmvQV7zNy55CHJfi+6X4dh8XXZcN7fv2N0fEIXVtUb7igNkV0CQOSaeLrMzBgEzRhD9OTotM5h7QuV6NI8t2quLd9NAyvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWmgvKGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWmgvKGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED01A1F000E9;
	Sun, 16 Aug 2026 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786907453;
	bh=8vDsoHPG7UI3Ni+YH0w21ka61FP8SmnEsboMiDLlnBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nWmgvKGA7bnT61VLfCzydOEK307hp/EZ4LVX8H6/SjbXXHhEk5bsj+cGHxo0easg7
	 he9m1zbJAi1tGjx1L2FRZoRLyvLgidZBymdldEsYQDYAnhh1jOIw0zzjo8s1l4dCqn
	 bYgTzJEUfHAAbq1SdN6NOGg6nNDg+XFFW1iacy4MmG8pR1y/uFVjY8Je5hNlPbahp1
	 ezxGhPnwfs8cC8bLAnxwpXZjeXiVblEMlNXRO2qEo0eeDEA5NiY7naYMHHbn/6BwqY
	 OaMGYfCOUD7U1A6uLxaWOhqXTB3lQ0Kf44LKS8rAs8aaOHoECuBFQp7aRA4yK3SAnY
	 Cpv/+NkNTb85g==
Date: Sun, 16 Aug 2026 20:10:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 05/14] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <20260816201049.480143e1@jic23-huawei>
In-Reply-To: <20260813-ad7768-driver-v3-5-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-5-cb554399ad26@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:56:58 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Hi Janani,

There are various comments in here that apply very widely.
It might be worth you taking a look at a few recently accepted
drivers for places where you have done things differently.
A particular example is the register defines where we have one
way of doing it (see below) and I'm not going to merge new
drivers doing it differently.

Jonathan
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d1b198cb8a80..d621d859e1d6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -429,6 +429,21 @@ config AD7766
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7766.
>  
> +config AD7768
> +	tristate "Analog Devices AD7768/AD7768-4 ADC driver"
> +	depends on SPI
> +	depends on REGULATOR || COMPILE_TEST
> +	select AUXILIARY_BUS
Bring this in when it's used, not from the start.
> +	select IIO_BUFFER
> +	select IIO_BACKEND
> +	select REGMAP
> +	help
> +	  Say yes here to build support for Analog Devices AD7768 and AD7768-4
> +	  SPI analog to digital converters.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7768.

> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> new file mode 100644
> index 000000000000..9b908ce0a1c3
> --- /dev/null
> +++ b/drivers/iio/adc/ad7768.c
> @@ -0,0 +1,813 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AD7768 ADC driver
> + *
> + * Copyright 2018-2026 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#define AD7768_REG_GPIO_CONTROL		0x0E
> +
> +/* AD7768 registers definition */

See below. The style of extra indent for fields is only useful if you
put the register address, its fields and their values all in one block
rather than having register addresses up here and the fields below
and needing comments to associate them.

> +#define AD7768_REG_CH_STANDBY			0x00
> +#define AD7768_REG_CH_MODE(x)			(0x01 + (x))
> +#define AD7768_REG_CH_MODE_SEL			0x03
> +#define AD7768_REG_POWER_MODE			0x04
> +#define AD7768_REG_GENERAL_CONFIG		0x05
> +#define AD7768_REG_DATA_CONTROL			0x06
> +#define AD7768_REG_INTERFACE_CFG		0x07
> +#define AD7768_REG_REV_ID			0x0A
> +#define AD7768_REG_PRECHARGE_BUF1		0x11
> +#define AD7768_REG_PRECHARGE_BUF2		0x12
> +#define AD7768_REG_REFP_BUF			0x13
> +#define AD7768_REG_REFN_BUF			0x14
> +#define AD7768_REG_OFFSET_BASE			0x1E
> +#define AD7768_REG_GAIN_BASE			0x36
> +#define AD7768_REG_PHASE_BASE			0x4E
> +#define AD7768_REG_OFFSET(ch)			((AD7768_REG_OFFSET_BASE + (3 * (ch))))
> +#define AD7768_REG_GAIN(ch)			((AD7768_REG_GAIN_BASE + (3 * (ch))))
> +#define AD7768_REG_PHASE(ch)			((AD7768_REG_PHASE_BASE + (ch)))
> +#define __AD7768_4_REG_MAP(ch)		((ch) < 2 ? (ch) : ((ch) + 2))
> +#define AD7768_4_REG_OFFSET(ch) \
> +	(AD7768_REG_OFFSET_BASE + (3 * __AD7768_4_REG_MAP(ch)))
> +#define AD7768_4_REG_GAIN(ch) \
> +	(AD7768_REG_GAIN_BASE + (3 * __AD7768_4_REG_MAP(ch)))
> +#define AD7768_4_REG_PHASE(ch)		(AD7768_REG_PHASE_BASE + __AD7768_4_REG_MAP(ch))
> +#define AD7768_REG_DIAGNOSTIC_RX		0x56
> +#define AD7768_REG_CHOP_CTRL			0x59
> +
> +/* AD7768_REG_CH_MODE */
> +#define   AD7768_CH_MODE_FILTER_TYPE_MSK	BIT(3)
> +#define   AD7768_CH_MODE_FILTER_TYPE_MODE(x)	(((x) & 0x1) << 3)
> +#define   AD7768_CH_MODE_DEC_RATE_MSK		GENMASK(2, 0)
> +#define   AD7768_CH_MODE_DEC_RATE_MODE(x)	(((x) & 0x7) << 0)
> +
> +/* AD7768_REG_POWER_MODE */
> +#define   AD7768_SLEEP_MODE_MSK			BIT(7)
> +#define   AD7768_POWER_MODE_POWER_MODE_MSK	GENMASK(5, 4)
> +#define   AD7768_POWER_MODE_POWER_MODE(x)	(((x) & 0x3) << 4)
Similar to below - don't define shifted values.  That's what the FIELD_PREP()
being used inline is for

Also put register address definitions and the contents all
in one large block. Otherwise the extra indent you have usd
here isn't particularly useful.

#define AD7768_REG_POWER_MODE			0x04
#define   AD7768_POWER_MODE_POWER_MODE_MSK	GENMASK(5, 4)
#define     AD7768_POWER_MODE_POWER_MODE_LOW	0
#define     AD7768_POWER_MODE_POWER_MODE_MID	1
#define     AD7768_POWER_MODE_POWER_MODE_HIGH	2
Then use FIELD_PREP() inline.

I'll not comment on any more of these, but apply this feedback for
all similar cases.		

> +#define   AD7768_POWER_MODE_MCLK_DIV_MSK	GENMASK(1, 0)
> +
> +/* AD7768_REG_DATA_CONTROL */
> +#define   AD7768_DATA_CONTROL_SPI_RESET_1	0x03
> +#define   AD7768_DATA_CONTROL_SPI_RESET_2	0x02
> +#define   AD7768_DATA_CONTROL_SPI_SYNC_MSK	BIT(7)
> +
> +/* AD7768_REG_INTERFACE_CFG */
> +#define   AD7768_INTERFACE_CFG_DCLK_DIV_MSK	GENMASK(1, 0)
> +#define   AD7768_INTERFACE_CFG_DCLK_DIV_MODE(x)	(4 - ffs(x))
> +#define   AD7768_MAX_DCLK_DIV			8
> +
> +#define   AD7768_INTERFACE_CFG_CRC_SELECT_MSK	GENMASK(3, 2)
> +/* Hardware supports CRC every 4 or 16 samples; backend supports 4-sample only */
> +#define   AD7768_INTERFACE_CFG_CRC_SELECT	FIELD_PREP(GENMASK(3, 2), 0x01)
Don't define shifted field values.

#define   AD7768_INTERFACE_CFG_CRC_SELECT_MSK	GENMASK(3, 2)
/* Hardware supports CRC every 4 or 16 samples; backend supports 4-sample only */
#define     AD7768_INTERFACE_CFG_CRC_SELECT_4	0x01
and use that via 
		FIELD_PREP(AD7768_INTERFACE_CFG_CRC_SELECT_MSK, 
			   AD7768_INTERFACE_CFG_CRC_SELECT_4);

inline within the code.  This isn't about correctness but more
conventions on how FIELD_PREP/GET are used that reviewers expect.

> +
> +/* AD7768_REG_GENERAL_CONFIG */
> +/* AD7768_REG_PRECHARGE_BUF1 and 2*/
> +#define   AD7768_PREBUF_POS_EN(ch)	BIT((ch) * 2)
> +#define   AD7768_PREBUF_NEG_EN(ch)	BIT(((ch) * 2) + 1)
> +
> +#define   AD7768_SPI_READ_CMD			BIT(15)
> +#define   AD7768_SPI_REG_MASK			GENMASK(14, 8)
> +#define   AD7768_SPI_DATA_MASK			GENMASK(7, 0)
> +#define   AD7768_SAMPLE_SIZE				32

This isn't a field of a register, so why the extra indent?

> +#define   AD7768_MAX_CHANNEL  8
Chose a style and stick to it.  If you are forcing alignment of
values then do it consistently.
> +#define   AD7768_REV_ID_VAL			0x06
> +
> +enum ad7768_power_modes {
> +	AD7768_LOW_POWER_MODE,
> +	AD7768_MEDIAN_MODE,
> +	AD7768_FAST_MODE,
> +	AD7768_NUM_POWER_MODES
Not using the NUM value and the rest have to take values matching
hardware. I'd just use 3 defines as suggested above.
> +};

> +static int ad7768_regmap_read(void *context, const void *reg_buf,
> +			      size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	struct ad7768_state *st = spi_get_drvdata(spi);
> +	u8 *data_val = val_buf;
> +	unsigned int reg;
> +	int ret;
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->d16,
> +			.len = 2,
sizeof(st->d16)


> +			.cs_change = 1,
> +		}, {
> +			/*
> +			 * The second transfer clocks out the readback data, so
> +			 * we must provide dummy TX bytes while receiving the
> +			 * response. The device ignores MOSI in this phase, so
> +			 * reuse st->d16 for both TX and RX.

Why do you need dummy TX?  I thought the spi core dealt with that when
it was supplied as NULL.  Or do you need to write the previous value again?

> +			 */
> +			.tx_buf = &st->d16,
> +			.rx_buf = &st->d16,

sizeof()

> +			.len = 2,
> +		},
> +	};
> +
> +	reg = *(const u8 *)reg_buf;
> +
> +	st->d16 = be16_replace_bits(cpu_to_be16(AD7768_SPI_READ_CMD), reg,
> +				    AD7768_SPI_REG_MASK);
> +
> +	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> +	if (ret)
> +		return ret;
> +
> +	*data_val = be16_get_bits(st->d16, AD7768_SPI_DATA_MASK);
> +
> +	return 0;
> +}
> +
> +static int ad7768_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct spi_device *spi = context;
> +
> +	return spi_write(spi, data, count);
> +}

> +
> +static int ad7768_sync(struct ad7768_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_DATA_CONTROL,
> +				 AD7768_DATA_CONTROL_SPI_SYNC_MSK, 0);

regmap_clear_bits()

> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, AD7768_REG_DATA_CONTROL,
> +				  AD7768_DATA_CONTROL_SPI_SYNC_MSK,
> +				  FIELD_PREP(AD7768_DATA_CONTROL_SPI_SYNC_MSK, 1));

regmap_set_bits()

Note that it's common to drop the _MSK when it is a single bit and
maybe the name makes it clear what the 0 and 1 values mean.


> +}
> +


> +
> +static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
> +					      struct ad7768_precharge_config *precharge_cfg)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	u8 prebuf1_val, prebuf2_val;
> +	u16 prebuf_mask = 0;
> +	u8 refbufp_val = 0;
> +	u8 refbufn_val = 0;
> +	int ret;
> +	u8 ch;
> +
> +	for (ch = 0; ch < indio_dev->num_channels; ch++) {
Pull ch declaration into the loop
	for (u8 ch = 0;

Look to do that wherever you can as it reduces scope and makes code
slightly more readable.

> +		u8 channel = indio_dev->channels[ch].channel;
> +
> +		if (precharge_cfg[channel].prebufp_en)
> +			prebuf_mask |= AD7768_PREBUF_POS_EN(channel);
> +
> +		if (precharge_cfg[channel].prebufn_en)
> +			prebuf_mask |= AD7768_PREBUF_NEG_EN(channel);
> +
> +		if (precharge_cfg[channel].refbufp)
> +			refbufp_val |= ad7768_channel_mask(st, channel);
> +
> +		if (precharge_cfg[channel].refbufn)
> +			refbufn_val |= ad7768_channel_mask(st, channel);
> +	}

> +
> +static int ad7768_parse_config(struct iio_dev *indio_dev,
> +			       struct device *dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	const unsigned int *available_datalines;
> +	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
> +	struct iio_chan_spec *chan;
> +	unsigned int num_channels;
> +	unsigned int channel;
> +	unsigned int i, len;
> +	int chan_idx = 0;
> +	int ret;
> +
> +	num_channels = 0;
> +	device_for_each_child_node_scoped(dev, child) {
> +		if (!fwnode_property_present(child, "reg"))

What nodes is this trying to skip over?  Given we enforce the naming
of channel nodes, perhaps it would be more reliable to use that than
presence of reg?

> +			continue;
> +
> +		num_channels++;
> +	}
> +
> +	if (!num_channels || num_channels > st->chip_info->num_channels)
> +		return dev_err_probe(dev, -EINVAL, "Invalid number of channels\n");
> +
> +	chan = devm_kcalloc(indio_dev->dev.parent, num_channels,
> +			    sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +	indio_dev->num_channels = num_channels;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_STANDBY,
> +			   ad7768_all_channels_mask(st));
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		if (!fwnode_property_present(child, "reg"))
> +			continue;
> +

As above - using reg which is a very common property for lots of 
things seems a fragile way of finding the channels.

> +		ret = fwnode_property_read_u32(child, "reg", &channel);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to parse reg property of %pfwP\n",
> +					     child);
> +
> +		if (channel >= st->chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid channel number %d from firmware\n",
> +					     channel);
> +
> +		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +					 ad7768_channel_mask(st, channel), 0);

regmap_clear_bits()

> +		if (ret)
> +			return ret;
> +
> +		if (fwnode_property_read_bool(child, "adi,prechargebuf-pos-enable"))
> +			precharge_cfg[channel].prebufp_en = true;
Maybe simpler as:
		
		precharge_cfg[channel].prebufp_en = 
			fwnode_property_read_bool(child, "adi,prechargebuf-pos-enable");
etc


> +
> +		if (fwnode_property_read_bool(child, "adi,prechargebuf-neg-enable"))
> +			precharge_cfg[channel].prebufn_en = true;
> +
> +		if (fwnode_property_read_bool(child, "adi,refbuf-pos-enable"))
> +			precharge_cfg[channel].refbufp = true;
> +
> +		if (fwnode_property_read_bool(child, "adi,refbuf-neg-enable"))
> +			precharge_cfg[channel].refbufn = true;
> +
> +		chan[chan_idx] = (struct iio_chan_spec) {
> +			.type = IIO_VOLTAGE,
> +			.indexed = 1,
> +			.address = channel,
> +			.channel = channel,
> +			.scan_index = channel,
> +			.scan_type = {
> +				.sign = 's',
> +				.realbits = 24,
> +				.storagebits = 32,
> +			},
> +		};
> +		chan_idx++;
> +	}
> +
> +	ret = ad7768_configure_precharge_buffers(indio_dev, precharge_cfg);
> +	if (ret)
> +		return ret;
> +
> +	st->datalines = st->chip_info->available_datalines[st->chip_info->num_datalines - 1];
> +	ret = device_property_read_u32(dev, "adi,data-lines-number",
> +				       &st->datalines);

Use a property_present check for the default case (though I'm not sure a default
makes much sense here).  That will allow you to avoid the dance with -EINVAL
and simplify the code.

This is a fairly new style in IIO but it is much clearer than relying on particular
return codes, so we are encouraging its use in all new code.

> +	if (ret && ret != -EINVAL)
> +		return dev_err_probe(dev, ret,
> +				     "Invalid \"adi,data-lines-number\" property\n");
> +
> +	available_datalines = st->chip_info->available_datalines;
> +	len = st->chip_info->num_datalines;
> +
> +	for (i = 0; i < len; i++) {
> +		if (available_datalines[i] == st->datalines)
> +			break;
> +	}
> +
> +	if (i == len)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid data-lines-number %d for %s\n",
> +				     st->datalines, st->chip_info->name);
> +
> +	return ad7768_configure_capture(st);
> +}
> +
> +static int ad7768_reset(struct ad7768_state *st)
> +{
> +	struct reset_control *reset_ctrl;
> +	unsigned long reset_low_us;
> +	unsigned long mclk;
> +	int ret;
> +
> +	reset_ctrl = devm_reset_control_get_optional_exclusive(regmap_get_device(st->regmap),

Probably use a local variable for struct device *dev = regmap_get_device(st->regmap);
to reduce line length.

> +							       NULL);

> +}
> +
> +static int ad7768_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	unsigned int spi_readback, rev_id;
> +	struct iio_dev *indio_dev;
> +	struct ad7768_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, st);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->chip_info = spi_get_device_match_data(spi);
There is an annoying path that lets this end up NULL
if the user has forced the driver to bind without firmware describing
the device.  So check for NULL and error out to avoid problems with that.
> +
> +	ret = devm_regulator_get_enable(dev, "avdd1");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable AVDD1 supply\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(ad7768_supply_names),
> +					     ad7768_supply_names);
> +	if (ret)
> +		return ret;
> +
> +	st->mclk = devm_clk_get_enabled(dev, NULL);

Related to dt feedback. Some clocks for this device are a lot more
complex to bring up.  I don't mind just doing the simple one for
an initial driver, but we should be checking that is what we have
and failing probe if we have an LVDS clock and we don't support the
necessary signal sequencing.

> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
> +
> +	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
> +				      st->chip_info->regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ad7768_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Dummy SPI register read to discard the Reset response from the chip */
> +	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &spi_readback);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &rev_id);
> +	if (ret)
> +		return ret;
> +
> +	if (rev_id != AD7768_REV_ID_VAL)
> +		dev_warn(dev, "Unexpected revision ID 0x%02x\n", rev_id);
Probably dev_info() unless we know of problems with earlier revisions.
If there is something we aren't handling then error out.   We shouldn't
get any problems with newer ones I hope!.

> +
> +	ret = ad7768_parse_config(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				 AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
> +				 AD7768_INTERFACE_CFG_CRC_SELECT);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7768_info;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, st->datalines);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_crc_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->setup_ops = &ad7768_buffer_ops;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_request_autosuspend(dev);

Why?  This smells like a sashiko or AI driven change. If you just skip
this the driver core will do it anyway.  Look in drivers/base/dd.c

> +	if (ret < 0 && ret != -EAGAIN)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to request initial autosuspend\n");
If there is a more fundamental reason to care, then add a comment.
> +
> +	return 0;
> +}


> +static int ad7768_runtime_resume(struct device *dev)
> +{
> +	struct ad7768_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				AD7768_SLEEP_MODE_MSK);
> +	if (ret)
> +		return ret;
> +
> +	/* Empirically determined delay to re-enable ADC and digital clocks.*/
> +	fsleep(20000);

Any chance of poking the datasheet author to get some numbers in there
for the longer term?  I don't mind empirical when we don't have
good contacts to get stuff clarified, but given you can hopefully
track them down, it would be nice to do get the unknown closed properly!

> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(ad7768_pm_ops, ad7768_runtime_suspend,
> +	ad7768_runtime_resume, NULL);
> +
Unless there is a good reason to do otherwise (usually very very long lines),
formatting preference for IIO is to always align parameters after (

static DEFINE_RUNTIME_DEV_PM_OPS(ad7768_pm_ops, ad7768_runtime_suspend,
				 ad7768_runtime_resume, NULL);

Or for these group related on one line (going a little long is fine).

static DEFINE_RUNTIME_DEV_PM_OPS(ad7768_pm_ops,
				 ad7768_runtime_suspend, ad7768_runtime_resume, NULL);



