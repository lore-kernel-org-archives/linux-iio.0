Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806260;
	b=Nsyq5MJbZwF3y37+FuDGJrGfXvc085YsZF6eo/Zp3zE3VcTa0udqSuyCY3iObv3win7s
	 ghEcz3RWTSIki2G5temGMa6OqTvl+Wj6BKudLIWxTtnwCP+37Yii2jfOOZXb8mWsjNCo8
	 p6+Qs+mMRqM3rrl8CFnZGMS1jgsh+vz7iRxx9bTMGeUkZ6mr9CWUOxtYniPb4cuei4I/y
	 w7PtNUpn+Zo99n/QBDBTP1Qv+zfHtx4QJ3VzAs6rIUOwNjdI7uvZc00oe8oFz9VkIGSVe
	 1J1Bzt/FbiUVXs3uenXOkMlNVJyNX326tbWamyk6sPDZHI1tfTHWaFXztUNmDOZV9JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806260;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RcA6NgDzwdyhPOZofiKPLepQmqwVn5qMh3MWdeVUR5Y=;
	b=A2y/aYvSF6HT+KmHibxP7kjPwwKYFtv8K2SIPDeIscZ48BXaqdSJHKTigCQnT5xa/rXa
	 baPtJXqnmA2UMbnYaj97g7KDeoEpaejsRF31Cjt6WenOwkMiQvT0D64HidkJGZBsBa5ov
	 TQDYL45J2HV3SK/Snn/pQxObFED4yH3lsgM7WPqGZvg+r4BL+52Gm2r8O/2FlcjfWoI/w
	 P3bFw9UDtXPNp5HcircZhPpUhd6uduiE8H3FAKsL6VONGgHrZoOWToEGbROCLZ2VS24k6
	 nxF0OwdKDe5yPx+oh4jthAmWEcQdVYPVFFZZYnbzSkX21WdpikZO0qGY5mNtBskIYjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeDgx7pC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205E606A31B;
	Sat, 24 Oct 2026 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeDgx7pC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09811F01825;
	Sat, 24 Oct 2026 01:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792806260;
	bh=RcA6NgDzwdyhPOZofiKPLepQmqwVn5qMh3MWdeVUR5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AeDgx7pC74sQPUM3WGP4IayUX+OTFLBRFSjVjknZAHSNOCRAWTeHJVmJYR8sKUSVJ
	 2Tb/dqrjJYjQII/XA3V0FQMO7VwIFEew1b6TeW638tuGqKfPODFW3kl0wMH3Aj1u7M
	 oKYqLrfiYaw51fJtmGnzsbSQS/ec7sBjid0l0RJbidtnFflad2TGDs2fQhFHTnRzKA
	 ywv0aHOe6LP+22ph93h0ql4Ljdh1QbO0ZuyXkQOGcv2BwNKXTRhFPrRTy5Q8XvemFq
	 mifdyXfwIr8wwRKuZRIJO3q2GuUT11JlFEFtLeL882j656fMzz3U83+ShxJomlob+6
	 pDOrj/EWq8hSg==
Date: Sat, 24 Oct 2026 02:44:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <20261024024412.2fa37c17@jic23-hlaptop>
In-Reply-To: <20261023204209.48556-2-olivier@mgcrea.io>
References: <20261023204209.48556-1-olivier@mgcrea.io>
	<20261023204209.48556-2-olivier@mgcrea.io>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Fri, 23 Oct 2026 22:42:09 +0200
Olivier Louvignes <olivier@mgcrea.io> wrote:

> The X1600's SAR ADC has four auxiliary channels, each with its own start
> bit, interrupt flag and 12-bit result, and none of the touchscreen or
> battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a small
> driver that exposes the four channels as voltages against the 3.3 V
> reference.
> 
> There is no datasheet here: the register layout and the clock dividers
> come from the X1600 driver of the vendor's 4.4 kernel.
> 
> Tested on a HiBy R1, whose play/pause and volume keys sit on channel 0
> behind adc-keys: all three read and report correctly.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Hi Olivier.

Very clean driver. Just a few really small things inline.

Thanks,

Jonathan.

> diff --git a/drivers/iio/adc/ingenic-x1600-adc.c b/drivers/iio/adc/ingenic-x1600-adc.c
> new file mode 100644
> index 000000000000..d54f6d7989b6
> --- /dev/null
> +++ b/drivers/iio/adc/ingenic-x1600-adc.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADC driver for the Ingenic X1600 SoC
> + *
> + * The X1600's SAR ADC has four auxiliary channels, each with its own start
> + * bit, interrupt and 12-bit result, and none of the touchscreen or battery
> + * engines of the JZ47xx ADCs that ingenic-adc drives. The register layout
> + * and the clock set-up were read from the vendor 4.4 kernel's driver.

I'm not sure we need the comparison with the JZ47xx ADCs here.
Keep that for the patch description / cover letter.

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>

Drop this. Now assumed to be coming via platform_device.h
after that header got broken down into bus specific ones recently.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
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
> +#define X1600_ADC_VREF_MV		3300

Use _mV . Fine to use case for units in IIO at least.  Avoids
us maybe thinking it's Mega Volts :)

> +#define X1600_ADC_BITS			12
> +/* The vendor kernel brings its 140 MHz APB clock down to about this. */
> +#define X1600_ADC_CLK_RATE		1166667
> +#define X1600_ADC_TIMEOUT_MS		20

> +static irqreturn_t x1600_adc_irq(int irq, void *data)
> +{
> +	struct x1600_adc *adc = data;
> +	u32 status = readl(adc->base + X1600_ADC_REG_STATUS) & X1600_ADC_CHANNELS_MASK;
> +

Split declaration and assignment given error check should be right next to assignment
	status = readl();
	if (!status)

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
> +	*val = (data & X1600_ADC_DATA_MASK(ch)) >> (ch % 2 * 16);

Can that be field_get()?

> +	return 0;
> +}

> +
> +static int x1600_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *iio_dev;
> +	struct x1600_adc *adc;
> +	unsigned long rate;
> +	u32 div0, reg;
> +	int irq, ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(iio_dev);
> +	init_completion(&adc->done);
> +	ret = devm_mutex_init(dev, &adc->lock);
> +	if (ret)
> +		return ret;
> +
> +	adc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->base))
> +		return PTR_ERR(adc->base);
> +
> +	adc->clk = devm_clk_get_enabled(dev, "adc");
> +	if (IS_ERR(adc->clk))
> +		return dev_err_probe(dev, PTR_ERR(adc->clk), "Unable to get clock\n");
> +
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
> +
> +	/*
> +	 * Powered up for good: the keys poll it every few tens of milliseconds,
> +	 * and powering up takes 2 ms.
> +	 */
> +	writel(0, adc->base + X1600_ADC_REG_ENABLE);
> +	usleep_range(2000, 3000);

fsleep(2000);

Lets us be lazy when thinking about what slack we
should allow by standardizing it for us.


> +	writel(0, adc->base + X1600_ADC_REG_CTRL);
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

