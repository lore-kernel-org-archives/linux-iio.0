Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A555428373;
	Mon, 17 Aug 2026 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934748; cv=none; b=CwSFzVIb+ot3+xYG+iojbBTfOBBNGTkXE/6zocOdkcpSsz0ixrVcUkfhaAiunZij3xj9Lo/ToLrIwth/IM9L38ce1mXL08fwwD8gAJNA7Q8mDa2A6eod39Q7Vk+EAP0x/qwPaN1l2Xcg8Iwv/EHmpUYXz+X4K3NjPLK/apzD7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934748; c=relaxed/simple;
	bh=ojvMs5tauhaG9Xv/sXKZGCz6S8w8IEgmRwJfQYMgubI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dk23U44xewQQU+Royp/8901NjOOGjz8MlLjofU4VyI9F+i8PejeoD7OddybOw9sKOhcFLyVSR6QsrRkaTRiEXR97tXEzIS7+GDB2uJ/mN4FU1sjun1hNLeFFr7qyBbV2dOiQTGt086X+SA9y0jLzRTthiuzIfxTgf3zhcJPbLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo6ioraA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo6ioraA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E011F000E9;
	Mon, 17 Aug 2026 02:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786934747;
	bh=A8y6rSl+mOT4rzHXtsv7e1d7LlCzxXlgMvDb3lpWqsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lo6ioraAzzVI9sgU3qv0U0dMaDFu+0BR1KhIKpbso8eHCx4TAJgUtS8DXZi4Px08S
	 nwNAlIn947dhYdqmNmRESAAufsdcpNcaoDTSYAlfE6z7d3b+y4xoX+Zmp9YTyo0nAu
	 KqbdcV9BQH35sM7pTdmVpd3Vy1cZzWKr/iZI20GKJPh7NNKwNr2wvnQ4jlKpPt2vRP
	 7iWOPSyWFX/C9XImK1K4HhOGN5ierxVJPwLQe32nQtibqTsaDTnI7KeyM9/sI1cgZg
	 JL4nrE3Ik0jvqkxiR7WzKvhSDT8riSZ7ijSlsSZIQ6S6iBebXOSqQcw8436Tm0O157
	 dlgppLJ5jqV5w==
Date: Mon, 17 Aug 2026 03:45:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petar Stepanovic <pstepanovic@axiado.com>, Akhila Kavi
 <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Harshit
 Shah <hshah@axiado.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <20260817034541.053dac28@jic23-huawei>
In-Reply-To: <anoYDi-bt-t6ZeeD@ashevche-desk.local>
References: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
	<20260810-axiado-ax3000-ax3005-saradc-v5-2-bb0df3ecedaa@axiado.com>
	<anoYDi-bt-t6ZeeD@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 21:27:26 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 10, 2026 at 07:49:36AM -0700, Petar Stepanovic wrote:
> > Add support for the SARADC controller found on Axiado AX3000 and
> > AX3005 SoCs.
> > 
> > The driver supports single-shot voltage reads through the IIO
> > subsystem. The number of available input channels is selected from
> > the SoC match data, allowing AX3000 and AX3005 variants to use the
> > same driver.  
> 
> ...
> 
> > +/* MANUAL_CTRL register fields */  
> 
> ^^^
> 
> > +#define AX_SARADC_MANUAL_CTRL_ENABLE	BIT(0)
> > +#define AX_SARADC_MANUAL_CTRL_CH_SEL_MASK	GENMASK(4, 1)
> > +
> > +#define AX_RESOLUTION_BITS	10
> > +#define AX_SARADC_CONV_CYCLES	13
> > +#define AX_SARADC_CONV_DELAY_MARGIN_US	10
> > +
> > +struct axiado_saradc {
> > +	struct regmap *regmap;
> > +	struct mutex lock; /* Serializes ADC conversions. */  
> 
> Choose the same style for all single-line comments (here is a period present
> while in the above, for instance, there is none).

Hmm. It is inconsistent in other places, but those two are arguably
correct. The second is a sentence, the first is not (no verb)

Anyhow, I did a sweep for other sentences and not all of them have
periods.  Given the rest of the driver looked fine to me and the other
suggestions Andy made are easy to apply.

Applied with the following diff to the testing branch of iio.git
Note I'm fine with rebasing that (and will do on rc1 once that's available)
so extra tags or review comments are easy to add for a few weeks at least.

Mostly I did this just to reduce how many patch sets were undergoing
revisions... I'm still over a 100 emails to read and run out of
time for today.

Jonathan


diff --git a/drivers/iio/adc/axiado_saradc.c b/drivers/iio/adc/axiado_saradc.c
index daa98dd2f176..699ee31616fc 100644
--- a/drivers/iio/adc/axiado_saradc.c
+++ b/drivers/iio/adc/axiado_saradc.c
@@ -34,10 +34,10 @@
 #define AX_SARADC_GLOBAL_CTRL_PD               BIT(2)
 #define AX_SARADC_GLOBAL_CTRL_ENABLE           BIT(0)
 
-/* GLOBAL_CTRL SAMPLE_MASK field value: 0 selects 16 samples */
+/* GLOBAL_CTRL SAMPLE_MASK field value: 0 selects 16 samples. */
 #define AX_SARADC_GLOBAL_CTRL_SAMPLE_16        0
 
-/* GLOBAL_CTRL MODE_MASK field value: 1 selects manual mode */
+/* GLOBAL_CTRL MODE_MASK field value: 1 selects manual mode. */
 #define AX_SARADC_GLOBAL_CTRL_MODE_MANUAL      1
 
 /* MANUAL_CTRL register fields */
@@ -76,16 +76,15 @@ static int axiado_saradc_conversion(struct axiado_saradc *info,
 
        guard(mutex)(&info->lock);
 
-       /* Select the channel to be used and trigger conversion */
+       /* Select the channel to be used and trigger conversion. */
        ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
                           AX_SARADC_MANUAL_CTRL_ENABLE |
                           FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, chan->channel));
        if (ret)
                return ret;
 
-       /* Hardware requires 13 conversion cycles at clk_rate */
-       usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
-                            info->clk_rate);
+       /* Hardware requires 13 conversion cycles at clk_rate. */
+       usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC, info->clk_rate);
        fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);
 
        ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
@@ -220,7 +219,7 @@ static int axiado_saradc_probe(struct platform_device *pdev)
 
        soc_data = device_get_match_data(dev);
        if (!soc_data)
-               return dev_err_probe(dev, -EINVAL, "failed to get match data\n");
+               return dev_err_probe(dev, -ENODATA, "failed to get match data\n");
> 
> > +	unsigned long clk_rate;
> > +	int vref_uV;
> > +};  
> 
> ...
> 
> > +static int axiado_saradc_conversion(struct axiado_saradc *info,
> > +				    struct iio_chan_spec const *chan, int *val)
> > +{
> > +	unsigned long usecs;
> > +	unsigned int regval;
> > +	int ret;
> > +
> > +	guard(mutex)(&info->lock);
> > +
> > +	/* Select the channel to be used and trigger conversion */
> > +	ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
> > +			   AX_SARADC_MANUAL_CTRL_ENABLE |
> > +			   FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, chan->channel));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Hardware requires 13 conversion cycles at clk_rate */  
> 
> > +	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
> > +			     info->clk_rate);  
> 
> I think it's okay to have this on a single line (83 characters).
> 
> > +	fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);
> > +
> > +	ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
> > +
> > +	/* Best effort to stop manual conversion. */
> > +	regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG, 0);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val = regval & GENMASK(AX_RESOLUTION_BITS - 1, 0);
> > +
> > +	return 0;
> > +}  
> 
> ...
> 
> > +	soc_data = device_get_match_data(dev);
> > +	if (!soc_data)
> > +		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");  
> 
> -ENODATA
> 

