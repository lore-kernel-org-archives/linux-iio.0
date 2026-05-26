Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9463C277E
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830756; cv=pass; b=CbLuOVSzis8THLD3WAaY6hiOKSRnbqIfT+SHtjBE5+Myy7WOg1ZajNFBIX4t5QPRELKCI/UX+Q0EmtVTkDxgIhLhk9Sm/wrQudxoE/3lW9g7P0RQFQqN6LDxaBOJx465yDi2ybg7nx5GxLfxODWvkNE2MM7riX6XokxtgIySOU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830756; c=relaxed/simple;
	bh=Cd7zWI0lsrOqHdRBbulkjvyPOD3GT6JDE8z7Rpv3/Cw=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XILYnaWF6q4eNhF3LMkkx3OUaM6erdIWOtO3NjZBgY6inhGKgeHP+ZVH8y8e7q/7cuKhvN3wRcSe8MfGi94riG8975Xc/FRzmzkybMkB3yxyFWhY7ZU1Qe7cvIBnYC5/4sD9Ol7nDwqkmzWbHN0GyYKX5cccgbWFpuKSleBXlfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FM/MTi+A; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FM/MTi+A"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67f94c078e8so1699855a12.1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 14:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779830751; cv=none;
        d=google.com; s=arc-20240605;
        b=Yyq3NR1gHhBwbtgghjTy0kJIlL5W7MttbkzU/5sjEmN7AHlnDLp+QrHQK5EZ9rJh67
         8FZIHh75V5tjg6n0qp6Sls2qpDimvZ8bcVa+LWkpbLrLuX7fCl6Yi/lZevxyB2iPbCJc
         sCLQb9uXU5K0tLoQ5dLAuA2sbzKK6OW+S7M9WiYO9jAvBqdz8CxhyapI9qSOJOsNsoat
         6R0tCQz2OV+EGn9he+2RUQm8V+ufuGdVXmRjXfeZbtiheulkgTHxurdv6v5XGAhSDuW+
         0lnBDnAIJJAcCMlNXh3Ip6AMgEoHWPHLd3TO0z/1NNN5xaTo4AR2pEFt3UDbnHnA4BAQ
         SMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:dkim-signature;
        bh=dn3CDjIt2vIiMqs+R+BPuA4q7fB48nnalDkVYsI1XXk=;
        fh=lCj7o+rhhkp48N5qJIkGYpkexws7Lu8fdGm38TDsJXI=;
        b=B79y4Om0UhuY5pgBczAeY+jXLpQXy5MjBykxKN5eY+1iA/E9zVMCPnR2epkYCIJ7KL
         nc/msT4+xicWT5kEjPBMLTo6dAI4dsiqIu421RDYDB92rvqAbMlmOdIAmUrs/fA0g6G3
         uLc2Kcbfg2dAXrxPkxcLxKWPTTzFHj+HpTYDCT5nSa9t17X+2Ibl6F3OUQAOGo/20VJd
         aXPufj5HDcCs8hBUwXEiZ6UBY+vMc3VtbHQiiwNrJPyFNvAUfqUtyU6kifrO84HAyFil
         lyCAOH7ZueHav6Rwy2VnyrX5wRFnJb1XUCGsrI1QO9YjpYNt2UHUjveGoguunSEHiBVN
         zJHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779830751; x=1780435551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dn3CDjIt2vIiMqs+R+BPuA4q7fB48nnalDkVYsI1XXk=;
        b=FM/MTi+A+nH/tfwO1a/NVonGTpVwjLQ0snIqcjZO/uVK/Im+njuhcVuDoaF5pl8SIt
         /uQOExTggs+PbhqTgqGKJvs389x63EdT9X4KyGcX3pPbjBQsPrFrbpXHwpIhy0bi3rR3
         06ep/GjxPCRT4pc+RUimyF6xhBaT1bTokbBhy9Hz4A+MsN484bGaaZ6NtiaU4qYrzChZ
         LRQanhpJSMwa7erIVFkUwtjGGKLFcePNgy9a80mZNeIR3sL7Yn5SKkzfZU5hMRMU50yH
         jBMd3cedA3JjrwASScp5nmgvZL+kbzB4SvIXfjj8WUvjUIbo7I6yrNfg6uM1ndawfIRl
         z2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830751; x=1780435551;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dn3CDjIt2vIiMqs+R+BPuA4q7fB48nnalDkVYsI1XXk=;
        b=ATHEA5MjF2ImARt6d0Yc5t3JQxgqibEUjgiLl3bg7FSr11kbUdQ3PPd4w6S3ZOm0BU
         FUXng7hdnl1wo6wcDW6Mil92/a1hNR6A6KHBAadtWY8Pb7kgZJgqVZhErjxGnAj7rano
         RDpmSFSk7OeiCo5t+pC16y1DHL50g8ktNRYQNHEyK1eba7AsFSNWWF89URgAT6GLdprC
         zy4Hbjs6aN0olCwx+5CpfayQMHUIYqDApq/GycLyvB8oronRr99Vi99IZUf+MrF3SOu4
         b94R15J3gg/JleBzLN4YsQSJSICIYuqWVQmbId4L9kKuJKULJPcryIeduFrJi09xXEHb
         sZfw==
X-Forwarded-Encrypted: i=1; AFNElJ9iH862+1WwgILVPskLd0RPoFSCpl39tTxue6baM+ePqnosjKS/x07tCygHs5vwN3Gy0WmCXiMqztc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGTpl1UoFId3dZE4TcImoT8s6O4yh3+zoO6QexhqCf6nX+nVRP
	vXPSdtcBFNe7G+h0D3RET3mfX4o4antfSu99w3cpaWMI78TfzPnD3L/1QJ96BwbZQEctd40R6Pk
	qzDXz2Tv2KoF0RCzWdNQfJOv6r6nvA3De9kKgxA1wzQ==
X-Gm-Gg: Acq92OG1P/rOSKigpT3O16UpcEW0dAoiA32/XglKuGUxpLtPTtjZMJ5UZ6MUOdR90rX
	KYJO6GgRkg0QiRXr2VFz1j+DR9y9RVidpe60z62KIs9dScuvHnyUhvw+uvjbx57AkyeI6k84L8z
	9Y9bhqt/mD4wX0YJwQZfjIuC4dHIUHqd6K1wOn3bkJJGqNc3k4TY2Nidxdm7/7XYkDRrm88LF33
	awX/ZNUWwO9nINlk6FeL4i/S87AZhqmnHIo5D6AXKdQsdQ5Rn7kH7Yg5XXk3/kYAvolX98oIfMq
	6bkv8h//QV7b7LD2Juu7OTfX+u/pOwOOpEx7
X-Received: by 2002:a17:907:fd8a:b0:bd5:18ee:a54a with SMTP id
 a640c23a62f3a-bdd2293ec75mr1247285466b.8.1779830751354; Tue, 26 May 2026
 14:25:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 May 2026 23:25:50 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 May 2026 23:25:50 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
Mail-Followup-To: Jonathan Cameron <jic23@kernel.org>, 
	Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
 <20260522-wip-stmark2-dac-v3-11-16be0ad35a67@baylibre.com> <20260526143050.5fca6514@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526143050.5fca6514@jic23-huawei>
Date: Tue, 26 May 2026 23:25:50 +0200
X-Gm-Features: AVHnY4K4EVRlMYVfttR7ggQcjq5xwYPhtPTl_I0B1Kvzgy2_6s0yq2t2OwfFyUw
Message-ID: <CALSJ-wAqOkQ0j-rKb7Oju9BVqWuE1_Y-D5WQSHeaiV6JPQngRQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] iio: dac: add mcf54415 DAC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

On Tue, May 26, 2026 at 02:30:50PM +0100, Jonathan Cameron wrote:
> On Fri, 22 May 2026 23:20:39 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >
> > Add basic version of mcf54415 DAC driver. DAC is embedded in the cpu and
> > DAC configuration registers are mapped in the internal IO address space.
> >
> > The DAC accepts a 12-bit digital signal and creates a monotonic 12-bit
> > analog output varying from DAC_VREFL to DAC_VREFH. The DAC module
> > consists of a conversion unit, an output amplifier, and the associated
> > digital control blocks. Default register values for DAC_VREFL and DAC_VREFH
> > are respectively 0 and 0xfff, left untouched in this initial version.
> >
> > This initial version of the driver is minimalistic, "output raw" only, to
> > be extended in the future. DMA and external sync are disabled, default mode
> > is high speed, default format is right-justified 12bit on 16bit word.
> >
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> https://sashiko.dev/#/patchset/20260522-wip-stmark2-dac-v3-0-16be0ad35a67%40baylibre.com
>
> Given there were only a couple of comments I've included them below alongside
> my review.  All minor stuff.
>
> Thanks,
>
> Jonathan
>
> > ---
> > Changes in v2:
> > - remove tests from commit message, moved to patch 0
> > - remove additional blank lines
> > - remove dead code and unused definitions
> > - use regmap
> > - add limit check on raw write
> > - non functional style fixes
> > - add COMPILE_TEST to Kconfig
> > Changes in v3:
> > - add comments where needed
> > - code style changes
> > - remove unneeded variables
> > - use regmap_set_bits where possible
> > - remove macro not needed to define a single channel
> > - set up regmap to big_endian accesses for next patches that will come,
> >   that will adjust ColdFire readx/writex as standard LE (links in 0/x).
> > - add return value check on regmap calls
> > - sashiko: remove unneeded .io_port from regmap init.
> > - sashiko: add select REGMAP_MMIO in Kconfig
>
> Looks like you missed or disagreed with the previous sashiko comment on v2 about
> type passed to regmap_read()
>

Sahiko asks if regmap_read produces a compiler watning.
I don't see any,

> > ---
> >  drivers/iio/dac/Kconfig        |  11 +++
> >  drivers/iio/dac/Makefile       |   1 +
> >  drivers/iio/dac/mcf54415_dac.c | 207 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 219 insertions(+)
> >
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index cd4870b65415..b1a578076188 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -516,6 +516,17 @@ config MAX5821
> >  	  Say yes here to build support for Maxim MAX5821
> >  	  10 bits DAC.
> >
> > +config MCF54415_DAC
> > +	tristate "NXP MCF54415 DAC driver"
> > +	depends on M5441x || COMPILE_TEST
> > +	select REGMAP_MMIO
> > +	help
> > +	  Say yes here to build support for NXP MCF54415
> > +	  12bit DAC.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called mcf54415_dac.
> > +
>
> > diff --git a/drivers/iio/dac/mcf54415_dac.c b/drivers/iio/dac/mcf54415_dac.c
> > new file mode 100644
> > index 000000000000..c8c87572d43d
> > --- /dev/null
> > +++ b/drivers/iio/dac/mcf54415_dac.c
> > @@ -0,0 +1,207 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * NXP mcf54415 DAC driver
> > + *
> > + * Copyright 2026 BayLibre - adureghello@baylibre.com
> > + */
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/compiler_types.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
>
> not seeing any use of this. I guess it 'evolved' away.
> Anyhow, please sanity check these all one more time for v4.
>

thanks,
removed it and also linux/array_size.h that's unused now.

> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <linux/iio/iio.h>
> > +
> > +#define MCF54415_DAC_CR			0x00
> > +#define MCF54415_DAC_CR_PDN		BIT(0)
> > +#define MCF54415_DAC_CR_HSLS		BIT(6)
> > +#define MCF54415_DAC_CR_WMLVL		GENMASK(9, 8)
> > +#define MCF54415_DAC_CR_FILT		BIT(12)
> > +
> > +#define MCF54415_DAC_DATA		0x02
> > +
> > +struct mcf54415_dac {
> > +	struct regmap *map;
> > +	struct clk *clk;
> > +};
> > +
> > +static const struct regmap_config mcf54415_dac_regmap_config = {
> > +	.reg_bits = 16,
> > +	.reg_stride = 2,
> > +	.val_bits = 16,
> > +	.max_register = 0x0c, /* DACX_FILTCNT,  R.M. Table 30-2 */
> > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> > +};
> > +
> > +static int mcf54415_dac_init(struct mcf54415_dac *info)
> > +{
> > +	int ret;
> > +
> > +	/* Keeping defaults and enable DAC (bit 0 set to 0) */
> > +	ret = regmap_write(info->map, MCF54415_DAC_CR, MCF54415_DAC_CR_FILT |
> > +			   FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1));
>
> Perhaps use a local variable. It is a tiny bit too easy to miss that
> parameter being split over two lines.
>
> 	u16 val = MCF54415_DAC_CR_FILT | FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);
>
> would avoid that.

ack, done.

>
> Alternatively perhaps just reflowing as:
> 	ret = regmap_write(info->map, MCF54415_DAC_CR,
> 			   MCF54415_DAC_CR_FILT |
> 			   FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1));
>
> avoids that reading issue (I read it wrong ;)
>
>
>
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* DAC is ready after 12us, from RM table 40-3  */
> > +	fsleep(12);
> > +
> > +	return 0;
> > +}
>
> > +
> > +static int mcf54415_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long mask)
> > +{
> > +	struct mcf54415_dac *info = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = regmap_read(info->map, MCF54415_DAC_DATA, val);
>
> Sashiko pointed out that regmap_read() expects a u32* so this should use
> a local variable for the read.
>

Sashiko asked if this is causing a warning. I don't see any.
Register read is a 16bit reg, and the valid 12bits are masked just after
to ensure returned value is always correct.

So can stay as is, or to make sashiko happy i can do something as:

	struct mcf54415_dac *info = iio_priv(indio_dev);
	int ret;
	u32 reg;

	switch (mask) {
	case IIO_CHAN_INFO_RAW:
		ret = regmap_read(info->map, MCF54415_DAC_DATA, &reg);
		if (ret)
			return -EIO;
		*val = reg & 0xfff;
		return IIO_VAL_INT;

> > +		if (ret)
> > +			return -EIO;
>
> Another one sashiko got. Why is this eating the possibly more useful error
> code from regmap_read()?
>

fixed with return ret

> > +		*val &= 0xfff;
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/* Reference voltage as per ColdFire datasheet is 3.3V */
> > +		*val = 3300 /* mV */;
> > +		*val2 = 12;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
>
> > +static int mcf54415_dac_resume(struct device *dev)
> > +{
> > +	struct mcf54415_dac *info = iio_priv(dev_get_drvdata(dev));
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(info->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mcf54415_dac_init(info);
> If this fails should we report it?  I think you'd at least want
> some print to help with debug. (Sashiko got this)
>

Ok, so doing


	ret = mcf54415_dac_init(info);

	if (ret) {
		dev_err(dev, "could not resume device\n");
		return ret;
	}



> > +
> > +	return 0;
> > +}
>
>

Regards,
angelo
