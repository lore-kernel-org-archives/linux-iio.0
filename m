Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324B3F0AA2;
	Fri,  8 May 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247027; cv=none; b=l2hB8+gQpIH0/C36isGVm2CKUDmG5hxWAh9xL3OCdPc7SZ7EvJJWgRYbnlO307IaBGPbbuGDNK1+jOkTs3gm23RzKI0YrHv/Xe2V/0YzNLLdJ2VxwqBpvYxBVN1LXWMMoXWSmxacYjwXKVd8a1UvRP9kF5pFJdlO09fOKPvNWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247027; c=relaxed/simple;
	bh=Q78JCwHuHw/6hCCFE73xrv/3czGcBLb8PHqSQxTvX/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuffpnE+aMgeKkDYKypvox6HJx1uORAcDw5PYBIx7tRAopGfzXGVjKW17nC5F8ygFDJOe3jxEUYquz6OCAUq5WFCDdQR78rrYE3we/9/s8NpA4PrHcXi17i/4Uptn20+M1Mx18K8BD/wN0b/ZjLMHnZnhwpX+Iz+rtFRHiYfH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtjnQ+B9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtjnQ+B9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8545CC2BCB0;
	Fri,  8 May 2026 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778247026;
	bh=Q78JCwHuHw/6hCCFE73xrv/3czGcBLb8PHqSQxTvX/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TtjnQ+B9JdiYiR/9muYI2RkPxptJRg8g4KHdNQq87M7ldB+hrx4eaILJdk6PRENTc
	 LfEP3tsBFmJxRAdOT0lDtrPKuqn3u3UxOEfP/ZGW4uyoagVus36D93/QpDGt0tPsSx
	 a8LKsmN/JM7y8d1Z75Xiq2z1wt6fF9eyhkDCnVLyATfiHqTWpdRU8flJFQ0d0nNbJ1
	 Do6pmaKmp9IcpwhLDTwEUndpZFsg5EFuIjmoY08o+w8Zo0/g2XLdy+CkdSuEXGj/ko
	 TOwDAQ1LTD6PLKeqPcoT4MJaUsgHF/57qvd0GQaNaWelhOr1yqCHykkVKnMzBDIQ+T
	 rkAHImb8ONIUg==
Date: Fri, 8 May 2026 14:30:17 +0100
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
Subject: Re: [PATCH v2 2/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260508143017.28f86551@jic23-huawei>
In-Reply-To: <20260508-ad5529r-driver-v2-2-e315441685d7@analog.com>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
	<20260508-ad5529r-driver-v2-2-e315441685d7@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 13:55:48 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Hi Janani,

Various comments inline

Thanks,
Jonathan

> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> new file mode 100644
> index 000000000000..3676956f6eff
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c
> @@ -0,0 +1,564 @@
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
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/spi.h>
> +#include <linux/errno.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>

Alphabetical order.

> +
> +/* Register Map */
> +#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
> +#define AD5529R_REG_INTERFACE_CONFIG_B		0x01
> +#define AD5529R_REG_DEVICE_CONFIG		0x02
> +#define AD5529R_REG_CHIP_TYPE			0x03
> +#define AD5529R_REG_PRODUCT_ID_L		0x04
> +#define AD5529R_REG_PRODUCT_ID_H		0x05
> +#define AD5529R_REG_CHIP_GRADE			0x06
> +#define AD5529R_REG_SCRATCH_PAD			0x0A
> +#define AD5529R_REG_SPI_REVISION		0x0B
> +#define AD5529R_REG_VENDOR_L			0x0C
> +#define AD5529R_REG_VENDOR_H			0x0D
> +#define AD5529R_REG_STREAM_MODE			0x0E
> +#define AD5529R_REG_TRANSFER_CONFIG		0x0F
> +#define AD5529R_REG_INTERFACE_CONFIG_C		0x10
> +#define AD5529R_REG_INTERFACE_STATUS_A		0x11
> +
> +/* Configuration registers */
> +#define AD5529R_REG_MULTI_DAC_CH_SEL		(0x14 + 1)

Feels like this would all be simpler if you used autoincrement rather than
default value of autdecrement.  What breaks if you do that?
Superficially feels like all the +1 would go away - though with need
for a byte swap?  Might be worth that pain for the simpler code.
Should just be a regmap_config parameter.

> +#define AD5529R_REG_LDAC_SYNC_ASYNC		(0x16 + 1)
> +#define AD5529R_REG_LDAC_HW_SW			(0x18 + 1)
> +
> +/* Hardware LDAC source and edge select registers (per channel, 16-bit) =
*/
> +#define AD5529R_REG_LDAC_HW_SRC_EDGE_SEL_BASE	(0x1A + 1)
> +#define AD5529R_REG_LDAC_HW_SRC_EDGE_SEL(ch)	\
> +	(AD5529R_REG_LDAC_HW_SRC_EDGE_SEL_BASE + (ch) * 2)
> +
> +/* Output configuration */
> +#define AD5529R_REG_OUT_OPERATING_MODE		(0x3A + 1)
> +#define AD5529R_REG_OUT_RANGE_BASE		(0x3C + 1)
> +#define AD5529R_REG_OUT_RANGE(ch)		(AD5529R_REG_OUT_RANGE_BASE + (ch) * =
2)
> +
> +/* Calibration registers */
> +#define AD5529R_REG_CAL_GAIN_BASE		(0x5C + 1)
> +#define AD5529R_REG_CAL_GAIN(ch)		(AD5529R_REG_CAL_GAIN_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_CAL_OFFSET_BASE		(0x7C + 1)
> +#define AD5529R_REG_CAL_OFFSET(ch)		(AD5529R_REG_CAL_OFFSET_BASE + (ch) =
* 2)
> +
> +/* Function generator registers */
> +#define AD5529R_REG_FUNC_EN			(0x9C + 1)
> +#define AD5529R_REG_FUNC_MODE_SEL_BASE		(0x9E + 1)
> +#define AD5529R_REG_FUNC_MODE_SEL(ch)		\
> +	(AD5529R_REG_FUNC_MODE_SEL_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_FUNC_DAC_INPUT_B_BASE	(0xBE + 1)
> +#define AD5529R_REG_FUNC_DAC_INPUT_B(ch)	\
> +	(AD5529R_REG_FUNC_DAC_INPUT_B_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_FUNC_DITHER_PERIOD_BASE	(0xDE + 1)
> +#define AD5529R_REG_FUNC_DITHER_PERIOD(ch)	\
> +	(AD5529R_REG_FUNC_DITHER_PERIOD_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_FUNC_DITHER_PHASE_BASE	(0xFE + 1)
> +#define AD5529R_REG_FUNC_DITHER_PHASE(ch)	\
> +	(AD5529R_REG_FUNC_DITHER_PHASE_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_FUNC_RAMP_STEP_BASE		(0x11E + 1)
> +#define AD5529R_REG_FUNC_RAMP_STEP(ch)		\
> +	(AD5529R_REG_FUNC_RAMP_STEP_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_FUNC_INT_EN			(0x13E + 1)
> +
> +/* Multiplexer and main DAC registers */
> +#define AD5529R_REG_MUX_OUT_SEL			(0x140 + 1)
> +#define AD5529R_REG_MULTI_DAC_SW_LDAC		(0x142 + 1)
> +#define AD5529R_REG_MULTI_DAC_INPUT_A		(0x144 + 1)
> +#define AD5529R_REG_DAC_SW_LDAC			(0x146 + 1)
> +
> +#define AD5529R_REG_DAC_INPUT_A_BASE		(0x148 + 1)
> +#define AD5529R_REG_DAC_INPUT_A(ch)		(AD5529R_REG_DAC_INPUT_A_BASE + (ch=
) * 2)
> +
> +/* Status and readback registers */
> +#define AD5529R_REG_FUNC_INT_STAT		(0x168 + 1)
> +#define AD5529R_REG_DAC_DATA_READBACK_BASE	(0x16A + 1)
> +#define AD5529R_REG_DAC_DATA_READBACK(ch)	\
> +	(AD5529R_REG_DAC_DATA_READBACK_BASE + (ch) * 2)
> +
> +/* Temperature sensor registers */
> +#define AD5529R_REG_TSENS_EN			(0x18A + 1)
> +#define AD5529R_REG_TSENS_ALERT_FLAG		(0x18C + 1)
> +#define AD5529R_REG_TSENS_SHTD_FLAG		(0x18E + 1)
> +#define AD5529R_REG_TSENS_ALERT_STAT		(0x190 + 1)
> +#define AD5529R_REG_TSENS_SHTD_STAT		(0x192 + 1)
> +#define AD5529R_REG_ALARMB_TSENS_EN		(0x194 + 1)
> +#define AD5529R_REG_ALARMB_TSENS_SEL		(0x196 + 1)
> +#define AD5529R_REG_TSENS_SHTD_EN_CH		(0x198 + 1)
> +#define AD5529R_REG_DAC_DIS_DEGLITCH_CH		(0x19A + 1)
> +#define AD5529R_REG_DAC_INT_EN			(0x19C + 1)
> +#define AD5529R_REG_ALL_FUNC_INT_STAT		(0x19E + 1)
> +#define AD5529R_REG_FUNC_BUSY			(0x1A0 + 1)
> +#define AD5529R_REG_REF_SRC_SEL			(0x1A2 + 1)
> +#define AD5529R_REG_INIT_CRC_ERR_STAT		(0x1A4 + 1)
> +
> +/* Hotpath registers for multi-device support */
> +#define AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC		(0x1A8 + 1)
> +#define AD5529R_REG_MULTI_DAC_HOTPATH_INPUT_A_DIE_0	(0x1AA + 1)
> +#define AD5529R_REG_MULTI_DAC_HOTPATH_INPUT_A_DIE_1	(0x1AC + 1)
> +#define AD5529R_REG_MULTI_DAC_HOTPATH_INPUT_A_DIE_2	(0x1AE + 1)
> +#define AD5529R_REG_MULTI_DAC_HOTPATH_INPUT_A_DIE_3	(0x1B0 + 1)
> +#define AD5529R_REG_DAC_HOTPATH_SW_LDAC			(0x1B2 + 1)
> +
> +/* Hotpath per-channel DAC input registers for each die */
> +#define AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_0_BASE	(0x1B4 + 1)
> +#define AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_0(ch)	\
> +	(AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_0_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_1_BASE	(0x1D4 + 1)
> +#define AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_1(ch)	\
> +	(AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_1_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_2_BASE	(0x1F4 + 1)
> +#define AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_2(ch)	\
> +	(AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_2_BASE + (ch) * 2)
> +
> +#define AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_3_BASE	(0x214 + 1)
> +#define AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_3(ch)	\
> +	(AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_3_BASE + (ch) * 2)
> +
> +#define   AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0))
> +#define   AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
> +#define   AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
> +#define   AD5529R_INTERFACE_CONFIG_A_DEFAULT	0x10
I'd put the values it represents inline and get rid of this define.

_DEFAULT defines are rarely a good design pattern

> +#define   AD5529R_NUM_CHANNELS			16

I'd store this along side the channels pointer then you can use ARRAY_SIZE(=
) on the
the chan_spec array and drop this constant.

> +#define   AD5529R_MAX_CHANNEL_INDEX		(AD5529R_NUM_CHANNELS - 1)

With the above gone, just make this a hard coded 15.

> +#define   AD5529R_MAX_REGISTER			(0x232 + 1)
> +#define   AD5529R_8BIT_REG_MAX			0x13
> +#define   AD5529R_ADDR(reg_addr)		((reg_addr) & 0xFFF)

Not used, so drop it.

> +#define   AD5529R_RESET_PULSE_US		1000
> +#define   AD5529R_RESET_DELAY_US		10000

As mentioned below - just put these numbers inline. Defines just make
the code harder to read when they are used only once and represent exactly
what the value is.

> +#define   AD5529R_SPI_BUF_SIZE			4

No idea what this is for - not used.


> +#define   AD5529R_NUM_SUPPLIES			4

No need for a constant for this - use [] to define the names array and ARRA=
Y_SIZE()
on that to get the size where needed.

> +#define   AD5529R_SPI_READ_FLAG			0x80

> +
> +static const struct regmap_range ad5529r_8bit_readable_ranges[] =3D {
> +	regmap_reg_range(AD5529R_REG_INTERFACE_CONFIG_A, AD5529R_REG_CHIP_GRADE=
),
> +	regmap_reg_range(AD5529R_REG_SCRATCH_PAD, AD5529R_REG_VENDOR_H),
> +	regmap_reg_range(AD5529R_REG_STREAM_MODE, AD5529R_REG_INTERFACE_STATUS_=
A),
> +};
> +
> +static const struct regmap_range ad5529r_16bit_readable_ranges[] =3D {

Tricky bit here is you are saying it's a 16 bit regmap but then providing
address ranges including the ones we shouldn't use. We need to hide those
intermediate addresses.  Various things might work depending on the address=
es.
Can we hide the bottom bit of each address then write it to appropriate val=
ue
under the hood. That is divide addresses by 2?

> +	regmap_reg_range(AD5529R_REG_MULTI_DAC_CH_SEL, AD5529R_REG_LDAC_HW_SW),
> +	regmap_reg_range(AD5529R_REG_LDAC_HW_SRC_EDGE_SEL_BASE,
> +			 AD5529R_REG_LDAC_HW_SRC_EDGE_SEL_BASE + AD5529R_MAX_CHANNEL_INDEX * =
2),
> +	regmap_reg_range(AD5529R_REG_OUT_OPERATING_MODE, AD5529R_REG_OUT_OPERAT=
ING_MODE),
> +	regmap_reg_range(AD5529R_REG_OUT_RANGE_BASE,
> +			 AD5529R_REG_OUT_RANGE_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_CAL_GAIN_BASE,
> +			 AD5529R_REG_CAL_GAIN_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_CAL_OFFSET_BASE,
> +			 AD5529R_REG_CAL_OFFSET_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_FUNC_EN, AD5529R_REG_FUNC_EN),
> +	regmap_reg_range(AD5529R_REG_FUNC_MODE_SEL_BASE,
> +			 AD5529R_REG_FUNC_MODE_SEL_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_FUNC_DAC_INPUT_B_BASE,
> +			 AD5529R_REG_FUNC_DAC_INPUT_B_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_FUNC_DITHER_PERIOD_BASE,
> +			 AD5529R_REG_FUNC_DITHER_PERIOD_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_FUNC_DITHER_PHASE_BASE,
> +			 AD5529R_REG_FUNC_DITHER_PHASE_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_FUNC_RAMP_STEP_BASE,
> +			 AD5529R_REG_FUNC_RAMP_STEP_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_FUNC_INT_EN, AD5529R_REG_DAC_SW_LDAC),
> +	regmap_reg_range(AD5529R_REG_DAC_INPUT_A_BASE,
> +			 AD5529R_REG_DAC_INPUT_A_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_FUNC_INT_STAT, AD5529R_REG_FUNC_INT_STAT),
> +	regmap_reg_range(AD5529R_REG_DAC_DATA_READBACK_BASE,
> +			 AD5529R_REG_DAC_DATA_READBACK_BASE + AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_TSENS_EN, AD5529R_REG_INIT_CRC_ERR_STAT),
> +	regmap_reg_range(AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC, AD5529R_REG_DAC=
_HOTPATH_SW_LDAC),
> +	regmap_reg_range(AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_0_BASE,
> +			 AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_0_BASE +
> +			 AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_1_BASE,
> +			 AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_1_BASE +
> +			 AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_2_BASE,
> +			 AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_2_BASE +
> +			 AD5529R_MAX_CHANNEL_INDEX * 2),
> +	regmap_reg_range(AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_3_BASE,
> +			 AD5529R_REG_DAC_HOTPATH_INPUT_A_DIE_3_BASE +
> +			 AD5529R_MAX_CHANNEL_INDEX * 2),

Yikes. This thing has an ugly register map.

> +};

> +
> +static int ad5529r_detect_device(struct ad5529r_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap_8bit, AD5529R_REG_PRODUCT_ID_L, &product=
_id);
> +	if (ret)
> +		return ret;
> +
> +	switch (product_id) {
> +	case AD5529R_PRODUCT_ID_16BIT:
> +		st->model_data =3D &ad5529r_16bit_model_data;
> +		break;
> +	case AD5529R_PRODUCT_ID_12BIT:
> +		st->model_data =3D &ad5529r_12bit_model_data;
> +		break;
> +	default:
> +		dev_err(&st->spi->dev, "Unknown product ID: 0x%02X\n", product_id);
> +		return -ENODEV;

See below on why this doesn't extend to fallback compatibles from DT and
what to do instead.

> +	}
> +
> +	dev_dbg(&st->spi->dev, "Detected %s variant (Product ID: 0x%02X)\n",
> +		st->model_data->model_name, product_id);
> +
> +	return 0;
> +}
> +
> +static int ad5529r_reset(struct ad5529r_state *st)
> +{
> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	if (rst) {
> +		ret =3D reset_control_deassert(rst);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +				   AD5529R_INTERFACE_CONFIG_A_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fsleep(AD5529R_RESET_DELAY_US);

This define is only used in one place. I'd rather see the value here and
a comment on where it comes from - typically a spec reference.

> +
> +	return regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +			   AD5529R_INTERFACE_CONFIG_A_DEFAULT);
> +}
> +
> +static int ad5529r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ad5529r_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_addr;
> +	unsigned int reg_val_h;

Could combine those two on oneline (not that important)

> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		reg_addr =3D AD5529R_REG_DAC_INPUT_A(chan->channel);
> +		ret =3D regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D reg_val_h;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Using default 0-5V range: VOUTn =3D A =C3=97 D/2^N + B
> +		 * where A =3D 5V, B =3D 0V, D =3D digital code, N =3D resolution
> +		 * Scale =3D 5000mV / 2^resolution

See the comment on the dt-binding. I think we need support for
dt described output ranges from the start. This is a rare multi range
device where we could set a safe default but to me it makes little sense
and the driver will be doing something unexpected if a newer DT is
provided with a different range.

> +		 */
> +		*val =3D 5000;
> +		*val2 =3D st->model_data->resolution;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5529r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ad5529r_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > GENMASK(st->model_data->resolution - 1, 0))
> +			return -EINVAL;
> +
> +		return regmap_write(st->regmap_16bit, AD5529R_REG_DAC_INPUT_A(chan->ch=
annel), val);
That's a very long line.  Break it up as:
		return regmap_write(st->regmap_16bit,
				    AD5529R_REG_DAC_INPUT_A(chan->channel), val);

I don't mind going past 80 for readability but here I don't see it as great=
ly hurt
by breaking the line and it was way past 80.  Or use a local reg_addr varia=
ble
like you have in read_raw()

> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int ad5529r_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5529r_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	st->spi =3D spi;
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev, AD5529R_NUM_SUPPLIES,
> +					     ad5529r_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable regulators\n"=
);
> +
> +	st->regmap_8bit =3D devm_regmap_init_spi(spi, &ad5529r_regmap_8bit_conf=
ig);
> +	if (IS_ERR(st->regmap_8bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
> +				     "Failed to initialize 8-bit regmap\n");
> +
> +	st->regmap_16bit =3D devm_regmap_init_spi(spi, &ad5529r_regmap_16bit_co=
nfig);
> +	if (IS_ERR(st->regmap_16bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_16bit),
> +				     "Failed to initialize 16-bit regmap\n");
> +
> +	ret =3D ad5529r_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset device\n");
> +
> +	ret =3D ad5529r_detect_device(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to detect device variant\n");

No to this. It breaks the use of fallback device tree compatibles.  As such=
 we
never fail on an ID missmatch. Instead we just believe firmware when it says
whatever is there is compatible with this device. See below on why I think
we need to break this into separate compatibles.

> +
> +	indio_dev->name =3D st->model_data->model_name;
> +	indio_dev->info =3D &ad5529r_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D st->model_data->channels;
> +	indio_dev->num_channels =3D AD5529R_NUM_CHANNELS;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad5529r_of_match[] =3D {
> +	{ .compatible =3D "adi,ad5529r" },

Hmm. I'm in two minds on this.  Is it better to do as you have
an detect between the ad5529r-12 and ad5529r-16 based on ID or should
we just have them as separate compatibles?  If they had different part
numbers (which is most common way this is done by ADI and others) then
we'd not consider sharing a compatible.  As such I think we should split
them.  That also makes fallback compatibles work.  Otherwise how
would we know whether a new device ID should be 12 or 16 bit?


> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad5529r_of_match);
> +
> +static const struct spi_device_id ad5529r_id[] =3D {
> +	{ "ad5529r" },
Same would apply here for including the postfix in the naming.
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad5529r_id);
> +
> +static struct spi_driver ad5529r_driver =3D {
> +	.driver =3D {
> +		.name =3D "ad5529r",
> +		.of_match_table =3D ad5529r_of_match,
> +	},
> +	.probe =3D ad5529r_probe,
> +	.id_table =3D ad5529r_id,
> +};
> +module_spi_driver(ad5529r_driver);
> +
> +MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5529R 12/16-bit DAC driver");
> +MODULE_LICENSE("GPL");
>=20

