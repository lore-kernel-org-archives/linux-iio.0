Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792825219;
	b=3FmLperMAgMHGios8azFvhkZBm86vNg5gL2Aa5FzCqE4gAaOUqU0rjkXgJwCLIiQu6AY
	 oJ/lmcBsNliNJ+FkrEcRdUELM8kOZsdrqyffUQiNbv3IsVuxON9oN32utw8S0LAznWIpQ
	 ppumPwobrEZa607Y243KBhnjWoAoDAwTrrXvxPfyeWG+scH/UYlpwb4ybQJwRq0CQbMKr
	 XvMipwQO3w7nD8Pi4lslDZT7NRC/cxYvvqK+WF37A18vmxzzhtZmogoVmePd96EduZxH/
	 3RcZCTUfGCNaLLSjtCybeHsvUpDykIuchpFHtCPXvZFAcqNuFkRIzr3FIyvlSlu6bZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y6MPlItNnv+GsY20I3sstkpXLDue914ZTPjNUcDG96g=;
	b=WtarpijbwzPET7gw/cO7TxSy/vjyY6w8T+4d3SBjVibu6oWHirhJtXQlZhNPDI+0Aw1E
	 15UsX8vtIFTjHdxv5UWOUIs45LU+oawDARTDjiUQ9NoWechLqoqRJ91WscoauMunOamC6
	 YMVq4DiexY2NOUBCS11lPuxzNYtwZJ89qNpkIHegbJJGJqRVuh/8XEwzhEy29dhoZQbiO
	 f2uVGZAhrEGEYXCmQsht+lMBCCJF09QRa+HCcljZ5P++CpfQRm/Tkt0NN0n9Kj/rgfz9g
	 sHpweh1zFnOi7e+Ges5IZPIMXuraA6p4HoJpBWQY2IdiR8TriIxBMwb7pWx1Hk/BpWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UYn1LBbD;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE366606A320
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 07:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE366606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UYn1LBbD
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e10a70540so887120f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792825209; x=1793430009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y6MPlItNnv+GsY20I3sstkpXLDue914ZTPjNUcDG96g=;
        b=UYn1LBbD088fngO6Ea5WxjmUHVrrWb6podP0F3wiQvM0gVTs5C42y7l+i9kh6QpE9k
         /6WBRyKDvXQlY3n4SKrYRVJ+pRqc6Bl0PdS8Jsk4QAU93686VXi7iEfITXHWb3zoEUAp
         ffWyEkT9StzVDCMcGlBUQkv9QbPpYc8HQ+9SYO0UNTkec2wBNqRk8cl+ccUONziuYIYX
         P4RNH7IX+S8Eq5yDP450hPZtzCwBzIPxEIqDC2l/peyBPk7kL5dc8ghmfruKe47puiRE
         e04ghXYmkrCDjWeoVpKvxdUIGkUT5t97QMJg5jcVsnG7tcvK0gPgxd9V63dqrtH4BULX
         yINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792825209; x=1793430009;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y6MPlItNnv+GsY20I3sstkpXLDue914ZTPjNUcDG96g=;
        b=p7QLxL+PYw92Ys2hQcVJ51i9sQLPdbIyIP3zjleG9cJgPRo0rK79Nw/8I5HqUKNx3E
         8ZaSOsXozBBrbFr7MGYZI/46jiYtaYwsFwlINzDaPkFIoIm9RSSgN2elM8ujb4evVVWe
         xr8UYofkB5pENhLQetOb7Z2m+GDIjOX7Olfr6wJGzG/7UHViWviOtYk1FJ4WejDxLcC/
         QvDJSmORJVebhiAmuzRwtUmpoHlCA2AAOwITva7ljhsIXBhtIDkSHhAZ7GTz25axm1a3
         ot435ug6mb2jdFsVod7sBviNMGABtXc/cgmN2P8VGhKL0nm1cpSgkFXBVj2EieyOZbCs
         XPKw==
X-Forwarded-Encrypted: i=1; AKwUvBxMg2q/TjxEOBOGY8wJZ/F2yJxXv6hHzDHB/4XHDahBgn3mjposgPtryWOPDIg63284J5wJXmcMFss=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiYgdw+EIvRSHrwB5P9uBs2smzdGHweQ8dX2SSOTR8SmhbqPc8
	n3/MnSchLheTk4mM537LHyHveu2wtzH0vonb9v67isPo93uqhXjc9SRg
X-Gm-Gg: AYBFou0EJE/xUEDfBwYc3ItY6MzdcAnNkp3mcUOyYGvLArvvQYqMTBIokwE+hX8ckyY
	S/l9f6X/K31Ahqun3E/8XYuuARaHBYJiTx4NyeFh/DJalQcQO2Py1sZDzk0R6lwlbOjOKuzRG3q
	3Vsi5aBmpCk8iFKGkZR+RYIcPYrHJ5oNdXCpLuxngyhTrQNnHjygzo/OglDEMkKXnM7Qi/2sTKx
	z95xOO0HDJw36AEXhFEBl7BvAxbTuK/lDJCm+XKqjxkTq1x8OsAuptM9EEagwHPpms5O4utXS58
	XLmFQBCt7ZTBwYhcJELAeReaYeusbo/XtU1jK1gIbdgOd9JxHS7tcXuCxSkdndW51SHDDPksrLf
	/uTQxq8CHBLWXnlWUamvCfhQJuSehzaY0ZdcDia4hulFsSECZ67kLGR6iWFAZ9lhTV/D975SAZy
	zpZ21gtx3fRRnKlLQfB4TZpttj4zkbb7Nvx+44VNewlYdIQZymnDOTt5Eiz/7O1U6d45KL/f0JV
	/sD94UTpAHxIe25G/bKFVJxh+ct3X0XdOq7rPbJgR9GpFu9/m9TtaLtkutearSrDqLLOBRCvUnM
	Q2Qq3Qfzxr1j3XK6PDrwIqP3j5h9nQlAYT5kqH7D4so80rMXxbJo7PYUCF82R+QW5ybLPF0NmYQ
	XN//GN/QHz7I/snzioTaQ90akwTDB2+dQkwCan8Mv1yFhOJMC8wB3l6iJGnLhP6TXETWS5rRM57
	vGsQY+vuLxJW6BRGntTQmGhafKqjiDXh0kJMAq+kD7gk533kzKCE4DLCTMBsOfTQ==
X-Received: by 2002:a05:600c:6748:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-4a35aca53camr16321375e9.15.1792825209014;
        Sat, 24 Oct 2026 00:00:09 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm100667405e9.1.2026.10.24.00.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 00:00:08 -0700 (PDT)
Date: Sat, 24 Oct 2026 09:00:06 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <20261024090006.00002720@gmail.com>
In-Reply-To: <20261024041357.34346-2-olivier@mgcrea.io>
References: <20261024041357.34346-1-olivier@mgcrea.io>
	<20261024041357.34346-2-olivier@mgcrea.io>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 06:13:57 +0200
Olivier Louvignes <olivier@mgcrea.io> wrote:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc22d1149d1..bbb63228e330 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12925,6 +12925,13 @@ F:	include/linux/mfd/ingenic-tcu.h
>  F:	sound/soc/codecs/jz47*
>  F:	sound/soc/jz4740/
>  
> +INGENIC X1600 ADC DRIVER
> +M:	Olivier Louvignes <olivier@mgcrea.io>
> +L:	linux-iio@vger.kernel.org

Drop the list, get_maintainer gets this via the directory.

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml

The changes above should go into patch 1 (checkpatch will
raise a warning if you're creating a new file and it's not
documented in MAINTAINERS).

> +F:	drivers/iio/adc/ingenic-x1600-adc.c

And this addition goes into patch 2.

...

> diff --git a/drivers/iio/adc/ingenic-x1600-adc.c b/drivers/iio/adc/ingenic-x1600-adc.c
> new file mode 100644
> index 000000000000..60683f26c693
> --- /dev/null
> +++ b/drivers/iio/adc/ingenic-x1600-adc.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADC driver for the Ingenic X1600 SoC
> + *

+ Copyright (c) 2026 YOUR_NAME <YOUR_EMAIL>

> + * The X1600's SAR ADC has four auxiliary channels, each with its own start
> + * bit, interrupt and 12-bit result. The register layout and the clock set-up
> + * were read from the vendor 4.4 kernel's driver.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>

+ bits.h, types.h, array_size.h, cleanup.h, jiffies.h, minmax.h

> +
> +#define X1600_ADC_REG_ENABLE		0x00
> +#define X1600_ADC_REG_CTRL		0x08
> +#define X1600_ADC_REG_STATUS		0x0c
> +#define X1600_ADC_REG_DATA(ch)		(0x10 + ((ch) / 2) * 4)
> +#define X1600_ADC_REG_CLKDIV		0x20
> +#define X1600_ADC_REG_STABLE		0x24
> +
> +/* ENABLE: bits 3..0 start a channel's conversion; bit 15 powers down. */
> +#define X1600_ADC_ENABLE_POWER_DOWN	BIT(15)
> +/* CTRL: bits 3..0 mask the channels' interrupts. STATUS: write 1 to clear. */
> +#define X1600_ADC_CHANNELS_MASK		GENMASK(3, 0)
> +#define X1600_ADC_DATA_MASK(ch)		(GENMASK(11, 0) << ((ch) % 2 * 16))
> +#define X1600_ADC_CLKDIV_DIV0		GENMASK(7, 0)
> +#define X1600_ADC_CLKDIV_DIV1		GENMASK(15, 8)
> +#define X1600_ADC_CLKDIV_DIV2		GENMASK(31, 16)
> +#define X1600_ADC_STABLE_TIME		GENMASK(15, 0)
> +
> +#define X1600_ADC_NUM_CHANNELS		4
> +#define X1600_ADC_VREF_mV		3300
> +#define X1600_ADC_BITS			12
> +/* The vendor kernel brings its 140 MHz APB clock down to about this. */
> +#define X1600_ADC_CLK_RATE		1166667
> +#define X1600_ADC_TIMEOUT_MS		20
> +
> +struct x1600_adc {
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct completion done;
> +	/* Serialises conversions: there is one completion for all channels. */
> +	struct mutex lock;
> +};
> +
> +static irqreturn_t x1600_adc_irq(int irq, void *data)
> +{
> +	struct x1600_adc *adc = data;
> +	u32 status;
> +
> +	status = readl(adc->base + X1600_ADC_REG_STATUS) & X1600_ADC_CHANNELS_MASK;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	writel(status, adc->base + X1600_ADC_REG_STATUS);
> +	complete(&adc->done);
> +	return IRQ_HANDLED;
> +}
> +
> +static int x1600_adc_read_raw_channel(struct x1600_adc *adc, unsigned int ch, int *val)
> +{
> +	u32 data;
> +	int ret = 0;

Reverse xmas tree.

> +
> +	guard(mutex)(&adc->lock);
> +
> +	reinit_completion(&adc->done);
> +	writel(BIT(ch), adc->base + X1600_ADC_REG_STATUS);
> +	writel(readl(adc->base + X1600_ADC_REG_ENABLE) | BIT(ch),
> +	       adc->base + X1600_ADC_REG_ENABLE);
> +
> +	if (!wait_for_completion_timeout(&adc->done,
> +					 msecs_to_jiffies(X1600_ADC_TIMEOUT_MS)))
> +		ret = -ETIMEDOUT;
> +
> +	writel(readl(adc->base + X1600_ADC_REG_ENABLE) & ~BIT(ch),
> +	       adc->base + X1600_ADC_REG_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	data = readl(adc->base + X1600_ADC_REG_DATA(ch));
> +	*val = field_get(X1600_ADC_DATA_MASK(ch), data);
> +	return 0;
> +}
> +
> +static int x1600_adc_read_raw(struct iio_dev *iio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct x1600_adc *adc = iio_priv(iio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = x1600_adc_read_raw_channel(adc, chan->channel, val);
> +		return ret ? ret : IIO_VAL_INT;

You can use the Elvis operator here.

> +	case IIO_CHAN_INFO_SCALE:
> +		*val = X1600_ADC_VREF_mV;
> +		*val2 = X1600_ADC_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info x1600_adc_info = {
> +	.read_raw = x1600_adc_read_raw,
> +};
> +
> +#define X1600_ADC_CHANNEL(ch) {					\

Small nit, but align the \ with the others.

> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = (ch),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
x
...

> +	/* Powered down, interrupts masked and cleared, as the vendor does. */
> +	writel(X1600_ADC_ENABLE_POWER_DOWN, adc->base + X1600_ADC_REG_ENABLE);
> +	writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_CTRL);
> +	writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_STATUS);
> +
> +	rate = clk_get_rate(adc->clk);
> +	div0 = clamp(DIV_ROUND_UP(rate, X1600_ADC_CLK_RATE), 1UL, 256UL) - 1;
> +	/* DIV1 and DIV2 as the vendor kernel sets them. */
> +	writel(FIELD_PREP(X1600_ADC_CLKDIV_DIV0, div0) |
> +	       FIELD_PREP(X1600_ADC_CLKDIV_DIV1, 1) |
> +	       FIELD_PREP(X1600_ADC_CLKDIV_DIV2, 99),
> +	       adc->base + X1600_ADC_REG_CLKDIV);
> +	reg = readl(adc->base + X1600_ADC_REG_STABLE) & ~X1600_ADC_STABLE_TIME;
> +	writel(reg | FIELD_PREP(X1600_ADC_STABLE_TIME, 1),
> +	       adc->base + X1600_ADC_REG_STABLE);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, x1600_adc_irq, 0, dev_name(dev), adc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request irq\n");

devm_request_irq() already prints an error message on failure, just
"return ret;" is fine.

> +
> +	/*
> +	 * Powered up for good: the keys poll it every few tens of milliseconds,
> +	 * and powering up takes 2 ms.
> +	 */
> +	writel(0, adc->base + X1600_ADC_REG_ENABLE);
> +	fsleep(2000);
> +	writel(0, adc->base + X1600_ADC_REG_CTRL);

+ blank line.

> +	ret = devm_add_action_or_reset(dev, x1600_adc_power_down, adc);
> +	if (ret)
> +		return ret;
> +
> +	iio_dev->name = "x1600-adc";
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->channels = x1600_adc_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(x1600_adc_channels);
> +	iio_dev->info = &x1600_adc_info;
> +
> +	return devm_iio_device_register(dev, iio_dev);
> +}
> +
> +static const struct of_device_id x1600_adc_of_match[] = {
> +	{ .compatible = "ingenic,x1600-adc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, x1600_adc_of_match);
> +
> +static struct platform_driver x1600_adc_driver = {
> +	.driver = {
> +		.name = "ingenic-x1600-adc",
> +		.of_match_table = x1600_adc_of_match,
> +	},
> +	.probe = x1600_adc_probe,
> +};
> +module_platform_driver(x1600_adc_driver);
> +MODULE_DESCRIPTION("ADC driver for the Ingenic X1600 SoC");

MODULE_AUTHOR()?

> +MODULE_LICENSE("GPL");



-- 
Kind regards,
Joshua Crofts
