Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0D34B40F
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782593537; cv=none; b=uWvxzPgV6MtbexGmE++ZNQOKvWYw5LcX1m7N0sIJDaz4t1xobL5UOpGeF7wE5f/9WipsNl2ZYvgtsvAuUhQK0P+ZJNQW4K5yohKBmYca6+/pRT/cZCZTr/dUDAnY/Ym3jsfR91noP/B/D3f4/4QIFuiVE+la7imkGMzi7j+9904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782593537; c=relaxed/simple;
	bh=IkakVxDtbrRgaFZDWIp3xaALJeOQk5FoWZbBwtFFfWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkpqRR3wTpp7kqs/kULvAv02WfwS17iV4Rhkd820gFQdAA7G2uijSwUtYzEhzYmggULEL7/6Ku4dmhHIR5TqJCb1LhMqsW9mXxrjcnfl8vTJ4Xe+ZInRWihHj8L2HQntW3ZsSkCSN5dJFlXrJwtSxU3E6cjAPAf/ydk7WZZHSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dIMS63OT; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dIMS63OT"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9c6ae2a79so291976a34.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782593528; x=1783198328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hnrtf+GXtMeqvARB3jB2Em97iDENxN+Q1kl7oXZwf7w=;
        b=dIMS63OTBJypELyJrpnVUiZN5yHdk3mQ6SbDQ9oEQKsyjYSWnynONT5rvPH849py1L
         JkLcA3lSkJnEwRSUPPqZP3bTvvbh1oC9KKU56AyQSCBaBtiX+abBGjgjjtUrfT+seTEk
         X42HWVLd5N/0IKez8HOfP7vZIGXb1z37GzRoO0NHmeOS+xVq+Hhh0KUNY5PzkepbtRc0
         FC5aCvhyXPxjGvt4rJg1YDo0rLXPMHWC3ecIQuYLf5RSb06ad2qurLPRxrzcYLlgQk0p
         g/9DlNTpvXZk2WXgB9E3xgAyIPy/453ex5HA+AS0UF5Ubu6Nwwit56zcGw+qayYUqpp4
         mlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782593528; x=1783198328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hnrtf+GXtMeqvARB3jB2Em97iDENxN+Q1kl7oXZwf7w=;
        b=FBXfr9RXddJX+kIALL25pkjM3S/N0joDzCWZMIT7eFiB6UbWt/ZEnYAm0HvmXLQEPD
         n7LUkfBVE6afpgLUhbOGTRyp/94UgGAnl6P/UaQ7MwFXK0bFQg1X6MveVTPx5RtkgnA4
         VRbh60KmWxlUps2W9OIuas4r8h6+1jkeBhzCCVL0Ra0u5NzlZiIwAUZqv90tyISpeNwr
         8mG25t1Bv4OW3FgWcqSTHg2hZY1DuVktkvJFzmGdOHKOEcpfypL8RZXIPrsdjZ75a0dp
         XCGo/m92NxiFd8oyzaqjTzpeOOeeX0h2NgKynOjgKKgiwBbuy4gDFwHuPzQf6USFs9Ez
         u2iA==
X-Forwarded-Encrypted: i=1; AFNElJ+XAgNqorciHpwl+6m9gsdXiLFRf3fSy0h0ns21twfIK+qDp4iJS73dF5J9aISv7/tA2M4hJmB53Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxpkVvMYwIl6no4/Ju9HsPFkOnTgb5agxCT4ZW22GnBeHOkU8
	Ln3aEschA9uW7QvfwZr0ekzwxFE9M0ii3KrOWPIqths64t9xNAsQp/JbTrLYUYSWov4=
X-Gm-Gg: AfdE7clZdn5AOWoEmmF7YL1u5vXsA8BJ0tQOzfczZkRjpHl6tJPEtxubpkfEiQU+Pm7
	OzioOhjWLOa1FZhftuYu/4qYfKzrt1kQSd0yHUuZXOf7dWefui0v/+c8IatLR3mpR3OhTYeYCUw
	lBiXuwy3VarmiiNjeLJ95OVuhecGrWVReuxE8ubbSTwx1aGpEf7XbxzoU4CqALJ1AG+6CeIvB00
	Mp/bzZF4893JD4/gf37QsHXldIRHRn61ZvQJkjEIS0c2C5C/UFV6Zr+mU4FuzWpFFmvbUzcXl1y
	UkVxcOCCZW5ayUrh4VaFVH2eTxoPmRmYBxGn44TwRmr2qi2L1+zzcVhnFBSgRcJJNoIXwt1UH1W
	FbLwnGK1Gjz0gLOmYQXtOhDnWUIqDAvsZqZcY/qt53TdLnoXP1PseA7inRo9qDJT+pgt4CZ9R77
	Zz3D6pYi0W5iInvXLRLwKat1R+Qcs9gMWP65LoN1Nm8rooRGwvNLUs5Y7SvO0XbEQ=
X-Received: by 2002:a05:6830:6d99:b0:7e9:b772:9aab with SMTP id 46e09a7af769-7e9b772a32amr3304681a34.7.1782593527571;
        Sat, 27 Jun 2026 13:52:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa57a229sm4966046a34.4.2026.06.27.13.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 13:52:06 -0700 (PDT)
Message-ID: <66ad5723-6589-473a-91da-b13e2ba90aeb@baylibre.com>
Date: Sat, 27 Jun 2026 15:52:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
To: Chi-Wen Weng <cwweng.linux@gmail.com>, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-3-cwweng.linux@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260625110638.38438-3-cwweng.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/26 6:06 AM, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add an IIO driver for the Nuvoton MA35D1 Enhanced ADC controller.
> 
> The driver supports direct raw reads and triggered buffered capture. The
> controller end-of-conversion interrupt is exposed as the device trigger
> and is used to push samples into the IIO buffer.
> 
> Channels are described by firmware child nodes and can be configured as
> single-ended or differential inputs. Since the differential enable bit is
> global, mixed single-ended and differential buffered scans are rejected.
> 
> DMA support is intentionally not included in this initial upstream driver;
> conversions are handled through the interrupt-driven path.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  drivers/iio/adc/Kconfig       |  10 +
>  drivers/iio/adc/Makefile      |   1 +
>  drivers/iio/adc/ma35d1_eadc.c | 636 ++++++++++++++++++++++++++++++++++
>  3 files changed, 647 insertions(+)
>  create mode 100644 drivers/iio/adc/ma35d1_eadc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1c663c98c6c9..43409999a94b 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -981,6 +981,16 @@ config LTC2497
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ltc2497.
>  
> +config MA35D1_EADC
> +	tristate "MA35D1 EADC driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for MA35D1 EADC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ma35d1.
> +
>  config MAX1027
>  	tristate "Maxim max1027 ADC driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 707dd708912f..7b9b38688223 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_LTC2471) += ltc2471.o
>  obj-$(CONFIG_LTC2485) += ltc2485.o
>  obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
>  obj-$(CONFIG_LTC2497) += ltc2497.o ltc2497-core.o
> +obj-$(CONFIG_MA35D1_EADC) += ma35d1_eadc.o
>  obj-$(CONFIG_MAX1027) += max1027.o
>  obj-$(CONFIG_MAX11100) += max11100.o
>  obj-$(CONFIG_MAX1118) += max1118.o
> diff --git a/drivers/iio/adc/ma35d1_eadc.c b/drivers/iio/adc/ma35d1_eadc.c
> new file mode 100644
> index 000000000000..0c075126e139
> --- /dev/null
> +++ b/drivers/iio/adc/ma35d1_eadc.c
> @@ -0,0 +1,636 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton MA35D1 EADC driver
> + *
> + * Copyright (c) 2026 Nuvoton Technology Corp.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/bitmap.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define MA35D1_EADC_DAT(n)		(0x00 + (n) * 0x04)
> +#define MA35D1_EADC_CTL			0x50
> +#define MA35D1_EADC_SWTRG		0x54
> +#define MA35D1_EADC_SCTL(n)		(0x80 + (n) * 0x04)
> +#define MA35D1_EADC_INTSRC0		0xd0
> +#define MA35D1_EADC_STATUS2		0xf8
> +#define MA35D1_EADC_SELSMP0		0x140
> +#define MA35D1_EADC_REFADJCTL		0x150
> +
> +#define MA35D1_EADC_CTL_ADCEN		BIT(0)
> +#define MA35D1_EADC_CTL_ADCIEN0		BIT(2)
> +#define MA35D1_EADC_CTL_DIFFEN		BIT(8)
> +
> +#define MA35D1_EADC_SCTL_CHSEL_MASK	GENMASK(3, 0)
> +#define MA35D1_EADC_SCTL_TRGDLY_MASK	GENMASK(15, 8)
> +#define MA35D1_EADC_SCTL_TRGSEL_MASK	GENMASK(21, 16)
> +#define MA35D1_EADC_SCTL_TRGSEL_ADINT0	\
> +	FIELD_PREP(MA35D1_EADC_SCTL_TRGSEL_MASK, 2)
> +
> +#define MA35D1_EADC_DAT_MASK		GENMASK(11, 0)
> +#define MA35D1_EADC_STATUS2_ADIF0	BIT(0)
> +#define MA35D1_EADC_INTSRC0_ADINT0	BIT(0)
> +#define MA35D1_EADC_REFADJCTL_EXT_VREF	BIT(0)
> +
> +#define MA35D1_EADC_MAX_CHANNELS	9
> +#define MA35D1_EADC_MAX_SAMPLE_MODULES	16
> +#define MA35D1_EADC_CHAN_NAME_LEN	16
> +#define MA35D1_EADC_TIMEOUT		msecs_to_jiffies(1000)
> +
> +struct ma35d1_adc {
> +	struct device *dev;

It looks like this is never used, so we can drop it.

> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct completion completion;
> +	/* Protects direct conversions against concurrent register access. */
> +	struct mutex lock;
> +	struct iio_trigger *trig;
> +	unsigned int scan_chancnt;
> +	bool scan_differential;
> +	char chan_name[MA35D1_EADC_MAX_CHANNELS][MA35D1_EADC_CHAN_NAME_LEN];
> +	struct {
> +		u16 channels[MA35D1_EADC_MAX_SAMPLE_MODULES];
> +		aligned_s64 timestamp;
> +	} scan;

Unless the hardware requires all channels to be read at once, we should
use this instead:

	IIO_DECLARE_BUFFER_WITH_TS(u16, scan, MA35D1_EADC_MAX_SAMPLE_MODULES);

It means an array with enough room for MA35D1_EADC_MAX_SAMPLE_MODULES u16
data points plus an aligned timestamp, but doesn't specify where the
timestamp will be as it could be in a different place depending on how
many channels are read.

Also, this is only used in one function, so can just be stack-allocated
in that function (with ` = { };` to zero it) instead of allocating it here.

> +};
> +
> +static inline u32 ma35d1_adc_read(struct ma35d1_adc *adc, u32 reg)
> +{
> +	return readl(adc->regs + reg);
> +}
> +
> +static inline void ma35d1_adc_write(struct ma35d1_adc *adc, u32 reg, u32 val)
> +{
> +	writel(val, adc->regs + reg);
> +}
> +
> +static void ma35d1_adc_rmw(struct ma35d1_adc *adc, u32 reg, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = ma35d1_adc_read(adc, reg);
> +	tmp &= ~mask;
> +	tmp |= val;
> +	ma35d1_adc_write(adc, reg, tmp);
> +}

Why not use regmap?

> +
> +static void ma35d1_adc_set_diff(struct ma35d1_adc *adc, bool differential)
> +{
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_DIFFEN,
> +		       differential ? MA35D1_EADC_CTL_DIFFEN : 0);
> +}
> +
> +static void ma35d1_adc_config_sample(struct ma35d1_adc *adc,
> +				     unsigned int sample, unsigned int channel)
> +{
> +	u32 reg = MA35D1_EADC_SCTL(sample);
> +
> +	ma35d1_adc_rmw(adc, reg,
> +		       MA35D1_EADC_SCTL_CHSEL_MASK |
> +		       MA35D1_EADC_SCTL_TRGSEL_MASK,
> +		       FIELD_PREP(MA35D1_EADC_SCTL_CHSEL_MASK, channel) |
> +		       MA35D1_EADC_SCTL_TRGSEL_ADINT0);
> +}
> +
> +static void ma35d1_adc_disable_irq(struct ma35d1_adc *adc)
> +{
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0, 0);
> +}
> +
> +static void ma35d1_adc_hw_init(struct ma35d1_adc *adc)
> +{
> +	ma35d1_adc_disable_irq(adc);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL,
> +		       MA35D1_EADC_CTL_ADCEN, MA35D1_EADC_CTL_ADCEN);
> +	ma35d1_adc_write(adc, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_INTSRC0,
> +		       MA35D1_EADC_INTSRC0_ADINT0,
> +		       MA35D1_EADC_INTSRC0_ADINT0);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_REFADJCTL,
> +		       MA35D1_EADC_REFADJCTL_EXT_VREF,
> +		       MA35D1_EADC_REFADJCTL_EXT_VREF);

As mentioned elsewhere, external reference doesn't make sense unless
we can get the reference voltage from it.

> +	ma35d1_adc_rmw(adc, MA35D1_EADC_SELSMP0, GENMASK(1, 0), 3);
> +}
> +
> +static void ma35d1_adc_hw_disable(void *data)
> +{
> +	struct ma35d1_adc *adc = data;
> +
> +	ma35d1_adc_disable_irq(adc);

ma35d1_adc_hw_init() doesn't enable the IRQ, so this seems a bit unbalanced.

> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCEN, 0);
> +}
> +
> +static irqreturn_t ma35d1_adc_isr(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	u32 status;
> +
> +	status = ma35d1_adc_read(adc, MA35D1_EADC_STATUS2);
> +	if (!(status & MA35D1_EADC_STATUS2_ADIF0))
> +		return IRQ_NONE;
> +
> +	ma35d1_adc_write(adc, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
> +
> +	if (iio_buffer_enabled(indio_dev)) {
> +		ma35d1_adc_disable_irq(adc);
> +		iio_trigger_poll(adc->trig);
> +	} else {
> +		complete(&adc->completion);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ma35d1_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int i;
> +
> +	for (i = 0; i < adc->scan_chancnt; i++)
> +		adc->scan.channels[i] =
> +			ma35d1_adc_read(adc, MA35D1_EADC_DAT(i)) &
> +			MA35D1_EADC_DAT_MASK;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan, pf->timestamp);
> +	iio_trigger_notify_done(adc->trig);
> +
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0,
> +		       MA35D1_EADC_CTL_ADCIEN0);
> +	ma35d1_adc_write(adc, MA35D1_EADC_SWTRG, 1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ma35d1_adc_read_conversion(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      int *val)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	long timeout;
> +
> +	reinit_completion(&adc->completion);
> +
> +	ma35d1_adc_write(adc, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_SCTL(0),
> +		       MA35D1_EADC_SCTL_CHSEL_MASK |
> +		       MA35D1_EADC_SCTL_TRGSEL_MASK,
> +		       FIELD_PREP(MA35D1_EADC_SCTL_CHSEL_MASK,
> +				  chan->channel));
> +	ma35d1_adc_set_diff(adc, chan->differential);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0,
> +		       MA35D1_EADC_CTL_ADCIEN0);
> +	ma35d1_adc_write(adc, MA35D1_EADC_SWTRG, 1);
> +
> +	timeout = wait_for_completion_interruptible_timeout(&adc->completion,
> +							    MA35D1_EADC_TIMEOUT);
> +	ma35d1_adc_disable_irq(adc);
> +
> +	if (timeout < 0)
> +		return timeout;
> +	if (!timeout)
> +		return -ETIMEDOUT;
> +
> +	*val = ma35d1_adc_read(adc, MA35D1_EADC_DAT(0)) & MA35D1_EADC_DAT_MASK;
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_read_raw(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		mutex_lock(&adc->lock);
> +		ret = ma35d1_adc_read_conversion(indio_dev, chan, val);
> +		mutex_unlock(&adc->lock);
> +
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ma35d1_adc_validate_scan(struct iio_dev *indio_dev,
> +				    const unsigned long *scan_mask)
> +{
> +	const struct iio_chan_spec *chan;
> +	bool have_single = false;
> +	bool have_diff = false;
> +	unsigned int count = 0;
> +	unsigned long bit;
> +
> +	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
> +		chan = &indio_dev->channels[bit];
> +
> +		if (chan->type == IIO_TIMESTAMP)
> +			continue;

Timestamp channel will never be set (it is handled differently), so we
don't need to check here.

> +		count++;
> +		if (chan->differential)
> +			have_diff = true;
> +		else
> +			have_single = true;
> +	}
> +
> +	if (!count || count > MA35D1_EADC_MAX_SAMPLE_MODULES)
> +		return -EINVAL;
> +
> +	if (have_single && have_diff)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_update_scan_mode(struct iio_dev *indio_dev,
> +				       const unsigned long *scan_mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan;
> +	unsigned int sample = 0;
> +	unsigned long bit;
> +	bool differential = false;
> +	int ret;
> +
> +	ret = ma35d1_adc_validate_scan(indio_dev, scan_mask);
> +	if (ret)
> +		return ret;
> +
> +	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
> +		chan = &indio_dev->channels[bit];
> +		if (chan->type == IIO_TIMESTAMP)
> +			continue;

Same here.

> +
> +		if (!sample)
> +			differential = chan->differential;
> +
> +		ma35d1_adc_config_sample(adc, sample, chan->channel);
> +		sample++;
> +	}
> +
> +	adc->scan_chancnt = sample;
> +	adc->scan_differential = differential;
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int i;
> +
> +	if (!adc->scan_chancnt)
> +		return -EINVAL;

Should this even be possible because of ma35d1_adc_validate_scan()?

> +
> +	ma35d1_adc_write(adc, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_INTSRC0,
> +		       MA35D1_EADC_INTSRC0_ADINT0,
> +		       MA35D1_EADC_INTSRC0_ADINT0);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_REFADJCTL,
> +		       MA35D1_EADC_REFADJCTL_EXT_VREF,
> +		       MA35D1_EADC_REFADJCTL_EXT_VREF);

How can we use the external V_REF without knowing what is connected to it?

I would expect this to use internal reference unless the devicetree specified
a vref-supply.

> +	ma35d1_adc_rmw(adc, MA35D1_EADC_SELSMP0, GENMASK(1, 0), 3);

There should be a macro to say what field GENMASK(1, 0) is.

> +	ma35d1_adc_set_diff(adc, adc->scan_differential);
> +
> +	for (i = 0; i < adc->scan_chancnt; i++)
> +		ma35d1_adc_rmw(adc, MA35D1_EADC_SCTL(i),
> +			       MA35D1_EADC_SCTL_TRGDLY_MASK,
> +			       MA35D1_EADC_SCTL_TRGDLY_MASK);
> +
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0,
> +		       MA35D1_EADC_CTL_ADCIEN0);
> +	ma35d1_adc_write(adc, MA35D1_EADC_SWTRG, 1);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int i;
> +
> +	ma35d1_adc_disable_irq(adc);
> +	for (i = 0; i < adc->scan_chancnt; i++)
> +		ma35d1_adc_rmw(adc, MA35D1_EADC_SCTL(i),
> +			       MA35D1_EADC_SCTL_TRGSEL_MASK, 0);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ma35d1_adc_buffer_ops = {
> +	.postenable = ma35d1_adc_buffer_postenable,
> +	.predisable = ma35d1_adc_buffer_predisable,
> +};
> +
> +static const struct iio_info ma35d1_adc_info = {
> +	.read_raw = ma35d1_adc_read_raw,
> +	.update_scan_mode = ma35d1_adc_update_scan_mode,
> +};
> +
> +static const struct iio_trigger_ops ma35d1_adc_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static void ma35d1_adc_init_channel(struct ma35d1_adc *adc,
> +				    struct iio_chan_spec *chan, u32 vinp,
> +				    u32 vinn, int scan_index, bool differential)
> +{
> +	char *name = adc->chan_name[vinp];
> +
> +	chan->type = IIO_VOLTAGE;
> +	chan->indexed = 1;
> +	chan->channel = vinp;
> +	chan->address = vinp;

Setting address is reduant if it is always going to be the same as channel.
We can just use channel directly instead. address doesn't appear to be
used anyway.

> +	chan->scan_index = scan_index;
> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);

This should also have IIO_CHAN_INFO_SCALE that is based on the reference source.

> +	chan->scan_type.sign = 'u';

This field has a new name:

	chan->scan_type.format = IIO_SCAN_FORMAT_UNSIGNED_INT;

> +	chan->scan_type.realbits = 12;
> +	chan->scan_type.storagebits = 16;
> +	chan->scan_type.endianness = IIO_CPU;
> +
> +	if (differential) {
> +		chan->differential = 1;
> +		chan->channel2 = vinn;
> +		snprintf(name, MA35D1_EADC_CHAN_NAME_LEN, "in%d-in%d", vinp,
> +			 vinn);
> +	} else {
> +		snprintf(name, MA35D1_EADC_CHAN_NAME_LEN, "in%d", vinp);
> +	}
> +
> +	chan->datasheet_name = name;

We usually don't use datasheet_name. It would make more sense to implement
labels and get the label from devicetree.


> +}
> +
> +static int ma35d1_adc_parse_channels(struct iio_dev *indio_dev,
> +				     struct device *dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	DECLARE_BITMAP(used_channels, MA35D1_EADC_MAX_CHANNELS);
> +	struct fwnode_handle *child;
> +	struct iio_chan_spec *channels;
> +	int num_channels;
> +	int scan_index = 0;
> +	int ret;
> +
> +	bitmap_zero(used_channels, MA35D1_EADC_MAX_CHANNELS);
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (!num_channels)
> +		return dev_err_probe(dev, -ENODATA,
> +				     "no ADC channels configured\n");
> +
> +	if (num_channels > MA35D1_EADC_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "too many ADC channels\n");
> +
> +	channels = devm_kcalloc(dev, num_channels + 1, sizeof(*channels),
> +				GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node(dev, child) {

Can use device_for_each_child_node_scoped() here to avoid needing to put
handle on all return paths.

> +		u32 diff[2];
> +		u32 reg;
> +		bool differential = false;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, ret,
> +					     "missing channel reg property\n");
> +		}
> +
> +		if (reg >= MA35D1_EADC_MAX_CHANNELS) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid ADC channel %u\n", reg);
> +		}
> +
> +		if (test_and_set_bit(reg, used_channels)) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "duplicate ADC channel %u\n", reg);
> +		}
> +
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			ret = fwnode_property_read_u32_array(child,
> +							     "diff-channels",
> +							     diff,
> +							     ARRAY_SIZE(diff));
> +			if (ret) {
> +				fwnode_handle_put(child);
> +				return dev_err_probe(dev, ret,
> +						     "invalid diff-channels for channel %u\n",
> +						     reg);
> +			}
> +
> +			if (diff[0] != reg ||
> +			    diff[1] >= MA35D1_EADC_MAX_CHANNELS ||
> +			    diff[0] == diff[1]) {
> +				fwnode_handle_put(child);
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid differential ADC channel %u-%u\n",
> +						     diff[0], diff[1]);
> +			}
> +
> +			if (test_and_set_bit(diff[1], used_channels)) {
> +				fwnode_handle_put(child);
> +				return dev_err_probe(dev, -EINVAL,
> +						     "ADC channel %u already used\n",
> +						     diff[1]);
> +			}
> +
> +			differential = true;
> +		}
> +
> +		ma35d1_adc_init_channel(adc, &channels[scan_index], reg,
> +					differential ? diff[1] : 0,
> +					scan_index, differential);
> +		scan_index++;
> +	}
> +
> +	channels[scan_index] = (struct iio_chan_spec)

The macro already includes (struct iio_chan_spec) so we don't need it here.

> +		IIO_CHAN_SOFT_TIMESTAMP(scan_index);
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = scan_index + 1;
> +	indio_dev->masklength = indio_dev->num_channels;
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_setup_trigger(struct iio_dev *indio_dev,
> +				    struct device *dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	adc->trig = devm_iio_trigger_alloc(dev, "%s-trigger", dev_name(dev));
> +	if (!adc->trig)
> +		return -ENOMEM;
> +
> +	adc->trig->ops = &ma35d1_adc_trigger_ops;
> +	iio_trigger_set_drvdata(adc->trig, indio_dev);
> +
> +	ret = devm_iio_trigger_register(dev, adc->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register trigger\n");
> +
> +	ret = iio_trigger_set_immutable(indio_dev, adc->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set trigger\n");
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ma35d1_adc *adc;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	adc = iio_priv(indio_dev);
> +	adc->dev = dev;
> +	mutex_init(&adc->lock);

	devm_mutex_init()

> +	init_completion(&adc->completion);
> +
> +	adc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->regs))
> +		return dev_err_probe(dev, PTR_ERR(adc->regs),
> +				     "failed to map registers\n");
> +
> +	adc->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(adc->clk))
> +		return dev_err_probe(dev, PTR_ERR(adc->clk),
> +				     "failed to get and enable ADC clock\n");
> +
> +	indio_dev->name = "ma35d1-eadc";
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

devm_iio_triggered_buffer_setup() sets the INDIO_BUFFER_TRIGGERED
flag, so we don't need it here.

> +	indio_dev->info = &ma35d1_adc_info;
> +
> +	ret = ma35d1_adc_parse_channels(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	ma35d1_adc_hw_init(adc);
> +
> +	ret = devm_add_action_or_reset(dev, ma35d1_adc_hw_disable, adc);
> +	if (ret)
> +		return ret;
> +
> +	ret = ma35d1_adc_setup_trigger(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, ma35d1_adc_isr, 0, dev_name(dev),
> +			       indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request IRQ %d\n", irq);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ma35d1_adc_trigger_handler,
> +					      &ma35d1_adc_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to setup triggered buffer\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;
> +
> +	ma35d1_adc_hw_disable(adc);
> +	clk_disable_unprepare(adc->clk);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(adc->clk);
> +	if (ret)
> +		return ret;
> +
> +	ma35d1_adc_hw_init(adc);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ma35d1_adc_pm_ops,
> +				ma35d1_adc_suspend, ma35d1_adc_resume);
> +
> +static const struct of_device_id ma35d1_adc_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-eadc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_adc_of_match);
> +
> +static struct platform_driver ma35d1_adc_driver = {
> +	.probe = ma35d1_adc_probe,
> +	.driver = {
> +		.name = "ma35d1-eadc",
> +		.of_match_table = ma35d1_adc_of_match,
> +		.pm = pm_sleep_ptr(&ma35d1_adc_pm_ops),
> +	},
> +};
> +module_platform_driver(ma35d1_adc_driver);
> +
> +MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
> +MODULE_DESCRIPTION("Nuvoton MA35D1 EADC driver");
> +MODULE_LICENSE("GPL");

