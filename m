Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE32F7F08;
	Sun, 14 Jun 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456978; cv=none; b=sgCG2j0O+9k4vgFQtSPK/LPiANtV58DNq58Oz23NUJFHmdxdap0gL/FG19pPvd1Pqc76u4vbkiWw53p057o/4tdTdSIUAqwhKu5KAwyjZz1HMN+TaXEWQXDwOfzeRkXnRzgvhIU3AqV3UhmTdR8Yc8R6NP6FwOldd/ynYDASXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456978; c=relaxed/simple;
	bh=21tCmADvjSoTcSLp6aQtmZKv2uhMjrHa0QM0peR/fJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBUsPPZFdJD4NWRib0aUalIeAIyz30YLvtO2zrbzPfnjcGALMITFpyK1HQ75XUxEZoalJm7tN1JSaGEEeDP0C6wE1A5f7buZ3W2tYexp/ZVHKn2sTMsYgeEe5gMfnMFBG2/wGjSzvQBBxg6CPL3X0hlkb3f9VNQctkNwwKLHUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkO+tGhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkO+tGhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855011F000E9;
	Sun, 14 Jun 2026 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781456976;
	bh=Uw749H3GGlWTY4KQLHnfokDzek6zUL6dAxCZrm+lzXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HkO+tGhjXt7ti49O99MSpHcH62zaEjFstpbLJ7Qi8zBsVpmK/OfQPF/MFvJlp/el/
	 Gti5UKUotwb3E9J8OFGdxkEv1hGIanWXMaYxbjf4e1uOGUOQ8hH3/65lWHgB4YnxpD
	 DghPGuC2XDuS6m9HdoqmQ2jPSHJqX7UIfKLo1xJqtIAtmNApannuN+/Hh8aBHDAE68
	 IeYJeMSioEYkOz3zAjBB9jMJQYNAg/PP430grlwf58VcqiZ/tCAmmpsWZqi2Y2srvm
	 Q+t2Tc0vYeowiReRysOtYZcp/00uKodm8km6ASC7s782WfM2QWLqru1d/lXmi6n7Z3
	 4mM9SI5lDFjWA==
Date: Sun, 14 Jun 2026 18:09:25 +0100
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
Subject: Re: [PATCH v4 2/2] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260614180925.4d20f529@jic23-huawei>
In-Reply-To: <20260609-ad5529r-driver-v4-2-2e4c02234a1a@analog.com>
References: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
	<20260609-ad5529r-driver-v4-2-2e4c02234a1a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 17:00:21 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

A couple of minor things inline.

The sashiko thing about not relying on how gpio resets work and so 
adding an explicit assert before deassert is best practice so make sure
to tidy that up as well.

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
> index 000000000000..d2d0287d0f95
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c
> @@ -0,0 +1,517 @@
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
> +#include <linux/dev_printk.h>
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
> +#define   AD5529R_REF_SEL_INTERNAL_REF		BIT(0)

This extra indent thing only makes sense if they are next to the register
address definitions - the intent is to make the visually different.

e.g.

#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
#define   AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0))
#define   AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
#define   AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
#define AD5529R_REG_DEVICE_CONFIG		0x02
#define AD5529R_REG_CHIP_GRADE			0x06
#define AD5529R_REG_SCRATCH_PAD			0x0A
#define AD5529R_REG_SPI_REVISION		0x0B
#define AD5529R_REG_VENDOR_H			0x0D
#define AD5529R_REG_STREAM_MODE			0x0E
#define AD5529R_REG_INTERFACE_STATUS_A		0x11
#define AD5529R_REG_MULTI_DAC_CH_SEL		0x14
#define AD5529R_REG_OUT_RANGE_BASE		0x3C
#define AD5529R_REG_OUT_RANGE(ch)		(AD5529R_REG_OUT_RANGE_BASE + (ch) * 2)
#define AD5529R_REG_DAC_INPUT_A_BASE		0x148
#define AD5529R_REG_DAC_INPUT_A(ch)		(AD5529R_REG_DAC_INPUT_A_BASE + (ch) * 2)
#define AD5529R_REG_DAC_DATA_READBACK_BASE	0x16A
#define AD5529R_REG_TSENS_ALERT_FLAG		0x18C
#define AD5529R_REG_TSENS_SHTD_FLAG		0x18E
#define AD5529R_REG_FUNC_BUSY			0x1A0
#define AD5529R_REG_REF_SEL			0x1A2
#define   AD5529R_REF_SEL_INTERNAL_REF		BIT(0)


> +#define   AD5529R_MAX_REGISTER			0x232
> +#define   AD5529R_8BIT_REG_MAX			0x13
> +#define   AD5529R_SPI_READ_FLAG			0x80
There is no reason to do the extra indent for these 3.


> +static int ad5529r_parse_channel_ranges(struct device *dev,
> +					struct ad5529r_state *st)
> +{
> +	int ret, range_idx;
> +	u32 ch;
> +	s32 vals[2];
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		range_idx = AD5529R_RANGE_0V_5V;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing reg property in channel node\n");
> +
> +		if (ch >= 16)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid channel number: %u\n", ch);
> +
> +		/* Read u32 property into s32 to handle negative voltage ranges */

> +		if (!fwnode_property_read_u32_array(child,
> +						    "adi,output-range-microvolt",
> +						    (u32 *)vals, ARRAY_SIZE(vals))) {
> +			range_idx = ad5529r_find_output_range(vals);
> +			if (range_idx < 0)
> +				return dev_err_probe(dev, range_idx,
> +						     "Invalid range [%d %d] for ch %u\n",
> +						     vals[0], vals[1], ch);
> +		}

The indent is a little larger than ideal, but slight preference for doing explicit
checking for optional properties so as to separate buggy ones from deliberately not
there.

		if (fwnode_property_present("adi,output-range-microvolt")) {
			/* Read u32 property into s32 to handle negative voltage ranges */
			ret = fwnode_property_read_u32_array(child,
							    "adi,output-range-microvolt",
							    (u32 *)vals, ARRAY_SIZE(vals));
			if (ret < 0) // strictly if (ret) but the return value for this one is complex.
				return dev_err_probe();
			range_idx = ad5529r_find_output_range(vals);
			if (range_idx < 0)
				return dev_err_probe(dev, range_idx,
						     "Invalid range [%d %d] for ch %u\n",
						     vals[0], vals[1], ch);
		} else {
			range_idx = AD5529R_RANGE_0V_5V;
		}
> +
> +		st->output_range_idx[ch] = range_idx;
> +		ret = regmap_write(st->regmap_16bit,
> +				   AD5529R_REG_OUT_RANGE(ch), range_idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure range for ch %u\n",
> +					     ch);
> +	}
> +
> +	return 0;
> +}


