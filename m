Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED43B27CC;
	Thu, 28 May 2026 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961495; cv=none; b=WKaZUbYXoYBdPkZPQRvzoKD9tM2Jvhx9z2d8Lr/MAeaIUR1ROFJbThsJQp7uMMEd24uUt3V5i9ZShkRtS3hfTdKwuTb5HUMeRopqwBdgKmAnLFUdKY+eBLg2e85LIYQzCZk9GaOtryGhclEh3iswDHdVhUGUPQQAsaAHI0cpT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961495; c=relaxed/simple;
	bh=ktfZvDrNYN9vTWCW8XNRTpxd/X7iCPWsarkD4YMp5rg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6brl6VWorsCeAnbnVGpqbG1mCasZRIwiJ5H4V3HXbkJrhQozU1pLff22u0feDKduVz3YL7q9PDQuyPI4HGkvmzmabnF87LCH2xaaHS52ep25CaChwmizyKgBFRiLixlU5mTWF6o18lDFU/QldvMLAqZJbllEbifFInL2/gbG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrP/wgSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrP/wgSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3B21F000E9;
	Thu, 28 May 2026 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779961493;
	bh=ZmDykwHmbDlHGt8sWJeNhUg4XHecBNonkDjK5kc+x1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nrP/wgSOkm3QXCEtw3KIexhzlfoETf2ZoGPjYvxpmZQa1yZy5FBBXS24xhQMYupbG
	 2Uwuuapyg50LBvgcHALEBCaQJZQPyE9QP8H+cwKFPQ63eV0nxIcUI47ohyTlNduvx1
	 DFTJiIb+9+n/SKKlJSRJ3OjKUWVeEE9J0OfEeSse+o0OpG9Fn7Xaj2SqMY87IGTDow
	 9L+7ecZSuUmThBBQFWx33bK+EYk9sVnzl3DFf0oe4e6Rxmh5jn5Ynk+tbGcJI4NSSk
	 xsFkB21kLxsc6iA5ZFUqCuYqtq3+7H1IQ6XXOPrLoJQRRN3GBIaFaiDr1tpWVyIuT9
	 +Uu/V9NYYHJEw==
Date: Thu, 28 May 2026 10:44:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Petar Stepanovic <pstepanovic@axiado.com>, Akhila Kavi
 <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Harshit
 Shah <hshah@axiado.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: add Axiado SARADC driver
Message-ID: <20260528104442.428cce3f@jic23-huawei>
In-Reply-To: <CALoEA-yfqYky=Un0r5K8QBc_H8DVziuiKuLap7ArAQOmaLKnZw@mail.gmail.com>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
	<20260528-axiado-ax3000-ax3005-saradc-v1-2-345dd5f6608a@axiado.com>
	<CALoEA-yfqYky=Un0r5K8QBc_H8DVziuiKuLap7ArAQOmaLKnZw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 11:02:05 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu, 28 May 2026 at 10:11, Petar Stepanovic <pstepanovic@axiado.com> wrote:
> >
> > Add support for the SARADC controller found on Axiado AX3000 and
> > AX3005 SoCs.
> >
> > The driver supports single-shot voltage reads through the IIO
> > subsystem. The number of available input channels is selected from
> > the SoC match data, allowing AX3000 and AX3005 variants to use the
> > same driver.
> >
> > Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> > ---  
> 
> Hi Petar, a few comments inline. Additionally, Sashiko came back
> with a few issues:
> https://sashiko.dev/#/patchset/20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a%40axiado.com.

I'll review on top given it's a short driver so Joshua hasn't cropped anything.

Mind you seems like Joshua's email client has replaced tabs with spaces
which briefly made me wonder if the patches were corrupted!

Joshua caught most of the larger things, so mostly formatting and similar
from me.

Note that convention is to leave a new series on list for around a week before
posting an update. That lets more reviewers have the opportunity to take a look
and cuts down on how many revisions we end up with.
I'd soften that a little in this case as it is a relative small driver but wait
until next week before sending a v2.

Jonathan

> 
> > +++ b/drivers/iio/adc/axiado_saradc.c
> > @@ -0,0 +1,218 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2021-2026 Axiado Corporation
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>  
> 
> IIO specific headers should follow the generic <linux/*> headers and
> be grouped separately.
> 
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>  
> 
> Don't use kernel.h when adding a new driver. The existing drivers in IIO
> are currently being moved away from kernel.h, as it is a catch-all header.
> You should include what you use manually (there is a tool for this, it's
> called iwyu-tool).
> 
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +/* Register offsets */
If you name them to imply they are registers then it will
be easier to spot if they end up in the wrong place in calls.
AX_SARADC_GLOBAL_CTRL_REG
etc

> > +#define AX_SARADC_GLOBAL_CTRL 0x0004
> > +#define AX_SARADC_MANUAL_CTRL 0x0008
> > +#define AX_SARADC_DOUT 0x001C
> > +
> > +/* GLOBAL_CTRL fields */
Include enough of the register in the name to ensure that
is obvious.

AX_SARADC_GLOBAL_CTRL_CH_EN_MASK
etc

> > +#define AX_SARADC_CH_EN_MASK GENMASK(31, 16)
> > +#define AX_SARADC_SAMPLE_MASK GENMASK(6, 5)
> > +#define AX_SARADC_MODE_MASK GENMASK(4, 3)
> > +#define AX_SARADC_PD BIT(2)
> > +#define AX_SARADC_ENABLE BIT(0)
> > +
> > +/* GLOBAL_CTRL values */
> > +#define AX_SARADC_SAMPLE_16 FIELD_PREP(AX_SARADC_SAMPLE_MASK, 0)
> > +#define AX_SARADC_MODE FIELD_PREP(AX_SARADC_MODE_MASK, 1)
> > +
> > +#define AX_SARADC_MANUAL_CTRL_EN(n) (BIT(0) | ((n) << 1))

Add a define for that BIT(0) to give us a little more info
on what it is. Also a mask for that field you are writing (n) into
and use FIELD_PREP() for that rather than a shift.
Doing all that will be a little more code, but will act as documentation
of what is int eh register.


> > +#define AX_RESOLUTION_BITS 10
> > +#define AX_SARADC_CONV_CYCLES 13
> > +
> > +struct axiado_saradc {
> > +       void __iomem *regs;
> > +       struct clk *clk;
> > +       unsigned long clk_rate;
> > +       int vref_uv;
> > +       struct mutex lock; /* Serializes ADC conversions. */
> > +};
> > +
> > +static int axiado_saradc_conversion(struct axiado_saradc *info,
> > +                                   struct iio_chan_spec const *chan, int *val)
> > +{
> > +       unsigned long usecs;

Blank line between declarations and code.

As below I'd have

	guard(mutex)(&info->lock);

in here rather than at caller.  Simpler scope and makes the association with
adc conversion more obvious.


> > +       /* Select the channel to be used and trigger conversion */
> > +       iowrite32(AX_SARADC_MANUAL_CTRL_EN(chan->channel),
> > +                 info->regs + AX_SARADC_MANUAL_CTRL);
> > +
> > +       /* Hardware requires 13 conversion cycles at clk_rate */
> > +       usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * 1000000, info->clk_rate);
> > +       usleep_range(usecs, usecs + 10);  
> 
> fsleep() is preferred over usleep_range(), it selects the optimal
> sleep function while guaranteeing a sleep of at least usecs time.
> 
> > +
> > +       *val = ioread32(info->regs + AX_SARADC_DOUT) &
> > +              GENMASK(AX_RESOLUTION_BITS - 1, 0);
> > +
> > +       /* Stop manual conversion */
> > +       iowrite32(0, info->regs + AX_SARADC_MANUAL_CTRL);

Blank line here.  Always nice to separate 'simple returns' like this
so the eye sees them more easily when reading code.

> > +       return 0;
> > +}
> > +
> > +static int axiado_saradc_read_raw(struct iio_dev *indio_dev,
> > +                                 struct iio_chan_spec const *chan, int *val,  
> 
> Small nit, but I'd move int * val onto the line along with val2 and mask
> so it's logically separated.
> 
> > +                                 int *val2, long mask)
> > +{
> > +       struct axiado_saradc *info = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               mutex_lock(&info->lock);  
> 
> I wanted to recommend using the guard(mutex) macro, but you're
> only using a mutex once, so up to you.

I'd move it into the axiado_saradc_conversion();
+ use guard() in there as that already has nicely defined scope.

> 
> > +               ret = axiado_saradc_conversion(info, chan, val);
> > +               mutex_unlock(&info->lock);
> > +               return ret ? ret : IIO_VAL_INT;
> > +       case IIO_CHAN_INFO_SCALE:
> > +               *val = info->vref_uv / 1000;
> > +               *val2 = AX_RESOLUTION_BITS;
> > +               return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static const struct iio_info axiado_saradc_iio_info = {
> > +       .read_raw = axiado_saradc_read_raw,
> > +};
> > +
> > +struct axiado_saradc_soc_data {
> > +       unsigned int num_channels;
> > +};
> > +
> > +static const struct axiado_saradc_soc_data ax3000_saradc_data = {
> > +       .num_channels = 16,
> > +};
> > +
> > +static const struct axiado_saradc_soc_data ax3005_saradc_data = {
> > +       .num_channels = 8,
As below, add a name to these so that we can report the part number
via sysfs name attribute. Something like "ax3005_saradc"
> > +};
> > +
> > +#define AX_SARADC_CH(_index, _id)                                       \
> > +       {                                                               \
> > +               .type = IIO_VOLTAGE, .indexed = 1, .channel = (_index), \

Go with 1 per line as it will be a bit longer but easier to read.

> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> > +               .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
> > +               .datasheet_name = (_id), .scan_index = -1,              \
> > +               .scan_type = {                                          \
> > +                       .sign = 'u',                                    \
> > +                       .realbits = AX_RESOLUTION_BITS,                 \
> > +                       .storagebits = 16,                              \
> > +                       .endianness = IIO_CPU,                          \

You aren't yet doing buffered capture so don't introduce scan_type yet. It's
just unused data so leave it as 0s (c default) to avoid implication it's used.
Same for scan_index. 

> > +               },                                                      \
> > +       }
> > +
> > +static const struct iio_chan_spec axiado_saradc_iio_channels[] = {
> > +       AX_SARADC_CH(0, "adc0"),   AX_SARADC_CH(1, "adc1"),
> > +       AX_SARADC_CH(2, "adc2"),   AX_SARADC_CH(3, "adc3"),
> > +       AX_SARADC_CH(4, "adc4"),   AX_SARADC_CH(5, "adc5"),
> > +       AX_SARADC_CH(6, "adc6"),   AX_SARADC_CH(7, "adc7"),
> > +       AX_SARADC_CH(8, "adc8"),   AX_SARADC_CH(9, "adc9"),
> > +       AX_SARADC_CH(10, "adc10"), AX_SARADC_CH(11, "adc11"),
> > +       AX_SARADC_CH(12, "adc12"), AX_SARADC_CH(13, "adc13"),
> > +       AX_SARADC_CH(14, "adc14"), AX_SARADC_CH(15, "adc15"),
> > +};
> > +
> > +static int axiado_saradc_probe(struct platform_device *pdev)
> > +{
> > +       struct axiado_saradc *info;
> > +       const struct axiado_saradc_soc_data *soc_data;  
> 
> Use reverse christmas tree order.
> 
> > +       struct iio_dev *indio_dev;
> > +       int ret;
> > +       u32 reg;  
> 
> Reg isn't a really good name, regval would be better.

Agreed - people sometimes use reg for the address, regval avoids
that possible confusion.

> 
> > +
> > +       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
A common IIO convention is to have the device used by devm calls , dev_err
etc in a local variable.

	struct device *dev = &pdev->dev;
Shortens all the lines a little and we shouldn't have code directly
touching the dev inside the iio_dev (see below!)

> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       info = iio_priv(indio_dev);
> > +
> > +       info->regs = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(info->regs))
> > +               return PTR_ERR(info->regs);
> > +
> > +       info->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > +       if (IS_ERR(info->clk))
> > +               return PTR_ERR(info->clk);
> > +
> > +       info->clk_rate = clk_get_rate(info->clk);
> > +       if (!info->clk_rate)
> > +               return dev_err_probe(&pdev->dev, -EINVAL,
> > +                                    "invalid clock rate\n");
		return dev_err_probe(dev, -EINVAL, "invalid clock rate\n");
Is a good example of where using local dev shortens things enough that
we save on line wrapping. As below - I'm fine if for some of the others they
go a little over 80 chars.

> > +
> > +       info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev,
> > +                                                              "vref");

For IIO we tend to be a little flexible on line length when we get someting
that would  be a lot nicer if we went slightly over 80 chars.  So put this one
on one line.

> > +       if (info->vref_uv < 0)
> > +               return dev_err_probe(&pdev->dev, info->vref_uv,
> > +                                    "failed to get vref voltage\n");
> > +
> > +       soc_data = device_get_match_data(&pdev->dev);
> > +       if (!soc_data)
> > +               return dev_err_probe(&pdev->dev, -EINVAL,
> > +                                    "failed to get match data\n");
> > +
> > +       mutex_init(&info->lock);  
> 
> Use devm_mutex_init since everything else is devm.
> 
> > +       reg = FIELD_PREP(AX_SARADC_CH_EN_MASK,
> > +                        GENMASK(soc_data->num_channels - 1, 0)) |
> > +             AX_SARADC_SAMPLE_16 | AX_SARADC_MODE | AX_SARADC_ENABLE;
> > +
> > +       iowrite32(AX_SARADC_PD, info->regs + AX_SARADC_GLOBAL_CTRL);  
> 
> Sashiko notes to add a small delay here to prevent a zero width pulse.

That would be true if an external signal. For internal SoC signals everything
should be fine without or documented.  So just check to see if there is a documented
reset hold time. If not this is fine I think. Sashiko is seeing a lot of gpio
style resets where that feedback would be valid.

> 
> > +       iowrite32(reg, info->regs + AX_SARADC_GLOBAL_CTRL);
> > +       indio_dev->name = dev_name(&pdev->dev);  
> 
> Hmm, Sashiko may have a point here, this could break the ABI.
> The name member is usually assigned a hardcoded string and
> it shouldn't contain whitespace, dots or dashes, which dev_name()
> could return.

All true, but critical bit is this is the part number, not something
originating in the kernel device naming schemes.  Given two supported
parts, ideal would be to provide the number for each.  Just put a
string in your soc_data and use that.


> 
> > +       indio_dev->dev.parent = &pdev->dev;

There should be no need to do this - it's done inside
devm_iio_device_alloc().  Shout if that doesn't work for some reason or
I'm missing that you have an unusual parent and need to override the default.

> > +       indio_dev->info = &axiado_saradc_iio_info;
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +       indio_dev->channels = axiado_saradc_iio_channels;
> > +       indio_dev->num_channels = soc_data->num_channels;
> > +
> > +       ret = devm_iio_device_register(&pdev->dev, indio_dev);
> > +       if (ret)
> > +               return dev_err_probe(&pdev->dev, ret,
> > +                                    "failed to register IIO device\n");  
> 
> You can just do `return devm_iio_device_register`.
Sometime we should do an audit of that function to make sure all the
plausible error paths (i.e. wrong config data etc) definitely print.
They should - so it should only be -ENOMEM that gets here without
providing info, but more than possible one is missing.

Anyhow not a question for this driver!

> 
> > +       return 0;
> > +}
> > +  
> 
> I don't see any kind of cleanup procedure, like a remove() function
> or devm_add_action_or_reset callback, is this intentional?
> 
> > +static const struct of_device_id axiado_saradc_match[] = {
> > +       {
> > +               .compatible = "axiado,ax3000-saradc",
> > +               .data = &ax3000_saradc_data,
> > +       },
> > +       {
> > +               .compatible = "axiado,ax3005-saradc",
> > +               .data = &ax3005_saradc_data,
> > +       },
> > +       {},
	{ }

For that terminating entry.
No comma as it always needs to be the last one; the spacing is an IIO
convention in the interests of consistency across drivers.

> > +};
> > +MODULE_DEVICE_TABLE(of, axiado_saradc_match);
> > +
> > +static struct platform_driver axiado_saradc_driver = {
> > +       .driver = {
> > +               .name = KBUILD_MODNAME,
> > +               .of_match_table = axiado_saradc_match,
> > +       },
> > +       .probe = axiado_saradc_probe,
> > +};
> > +
> > +module_platform_driver(axiado_saradc_driver);
> > +
> > +MODULE_AUTHOR("AXIADO CORPORATION");
> > +MODULE_DESCRIPTION("AXIADO SARADC driver");
> > +MODULE_LICENSE("GPL");
> >
> > --
> > 2.34.1
> >
> >  
> 

