Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602A3FAE15
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967989; cv=none; b=Y+04M3XHlNNLSjnZER9AjVFlXDVeKTdweiD3kneK7j2Nr1HTirYMyKCQbEH0+shNFu2fOk/kp+EGY+HuXeHqRDQDLrmMK2bOBBt/j3qcefywZ+b0O7M6Xq3pnTAlCGFNSKiM/oYXfPhD8z4lYICd68HM6uE2AFFCyXdQFMDj6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967989; c=relaxed/simple;
	bh=bfCLNI1PRMYnsjfBYgdj4X+i/++F7HwXsOs4ZT1LSGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsjTpZrdrMW0oswstR0NCA4NJpZjYAh8IaKuIZtj00Vdo94y1z4F1QlTA+KFupGfeTxDTK7zqdRrc7rFLne94iabh+ViQ1dh0FFV5HdIhzuw7OVu/9DHjWE+cexBIDBml02mXIW7U3WnjxdoN4GsAXEECFgiUoLKHFGmPtsJeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUxQy59N; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUxQy59N"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so24157725e9.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786967985; x=1787572785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UCkUaJwsiIx2/8B6UmuqctR4tL1PfcLhtviHSxv/jPY=;
        b=LUxQy59NcPTaS03F/TV+DFkuyFXvwbGh8PVJP1SfFSAR+Pv5kEmUDe6mDZlX+JY3BW
         Xv8Ui+UlacrN6oXSSgUt04WMvBJY94uq0dp4Mv+VH2eE6QTjRLPyi9V4m7OlxbPBZxaf
         RUp4W3QKozU/DYdPO8BN0qBjr6NBgLKUBg0OJ8Ajyxrb7uGbZVq6wvmefEUK8EXJAGo4
         cu+FpcsUa2MNKUfF7p6NrzTTCr7B0Q5X7/QJkf2eJxdAtWQ9mCz3BO+Vihnk0UDumJOI
         gUi1TUdUis7aKQTa8daCoFec7p3uPolEHTNiFXOEBj536+VUu8br0fhPHy1HQQl9/BPt
         EeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967985; x=1787572785;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCkUaJwsiIx2/8B6UmuqctR4tL1PfcLhtviHSxv/jPY=;
        b=Pf/jF5E8HYk0Wraxv5eceWce0z2dhwX7L49fU66NnchMvt596SWzfmmxnHO3mTy63X
         36IMT02LLmrgZGMOo4L+UJpDPClr+jCCJV+9iQWZw9vyIMh8Up+pwy5XIGBhWJZsXqDO
         989def2dLxdBT1zLP0+i3jwlgruacgyzy0VNC38rbPg0W/VDijT5X23zyz1/t3vNI3wg
         ujbtnXp+60RkH7mdiNMPnoISrmkv4V8AExkmYAL8CGswgWZY7JQM5GwvHF/qMPQt8clT
         qYkBSgFAjPH0gEqgLv6u7ApreqRKZ/XD4oDzf5AHxjd6E95FDvTlEcof9soqgrYwv/LW
         8nSg==
X-Forwarded-Encrypted: i=1; AHgh+RqgrNHzd4zz9Lt7cY4OVKyFfM61k621dnPGQxmUSWV/hFyebC3lgeZ73n9REKMombaFg7JNmLOiTks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIn611JGwp3AQnn1mDTtIxqUcx2ptlBNeOswRMept2tdxmxOZS
	KujK/yu5bac2uvZQiZhSvxskeJo8ZpENGjAWKuW8QwGnEVHhJBNPXeh8
X-Gm-Gg: AR+sD13jpJf+eFRB8lHK00qHBXe4dCAfGv2rfltXa9scq8Ge3iDd2nnDluImN4immLm
	xUz7PpgUSaALKwMwQOycLkBs2/0H/aj15bnByp5mjSSYJAUxzKqzVq5hjD6y9ZH4E5EDacyjaFy
	t1zZ93tF+AWVOjsuYq8l9ZcFiWuEyPaWibcqTnHCNT6Gv2Ucqf6Mt1irgE8XilGZHIaeQTqJSNa
	HkP1Ta6TfONG8KFogRNQzrmHw3fb/L0/6SsmWjsETRbDvzVGlF1RP4fA6Za6mhdObN0NWrIfBal
	aLLIn2/96o1x+QSgeGUyXXH1pb5ybilOfzmi/dOM1qsiiisgGZhp170KshmLGL+Q7QDe9uqOlOG
	iQ3d2j8VdNKxBUUuXn4NB3WCkkVvSecv3WWaexepRZr8v1Nf5ouwld8hRprg1cuuHBSuAcUmID/
	LqZHQwV3dl+NfhoqQCFZZ/cIY7HS+IRAj+9Kmv4NAhaPDv+8L3DxFwMY+7AUbO8Iyh2yyhv5btQ
	KDZ10fgx56Qf4OSfW5BYtl89nlQITLd/UswAD/Ce8c6qvRf2ocKHagBmVk8iAP8aoWQNxGoD/K0
	SsL/tmVVEqbpxjReaWxRuh6buRF3tFXu2Zf1STcyxbpEkBezpWTpG74fWCH/P5JBsJk16+PFwc4
	WM48YbtO2n4w/gipU6DZ+S7HA7j+byOogQTyLFvGUBwvEOnbHIzdROaWBu65vVOYzFnXRyg==
X-Received: by 2002:a05:600c:3b90:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49987a4f131mr325063325e9.1.1786967985143;
        Mon, 17 Aug 2026 04:59:45 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm162556715e9.6.2026.08.17.04.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:59:45 -0700 (PDT)
Date: Mon, 17 Aug 2026 13:59:20 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Petar Stepanovic
 <pstepanovic@axiado.com>, Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty
 <pbolisetty@axiado.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Harshit Shah
 <hshah@axiado.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <20260817135920.0000461d@gmail.com>
In-Reply-To: <20260817034541.053dac28@jic23-huawei>
References: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
	<20260810-axiado-ax3000-ax3005-saradc-v5-2-bb0df3ecedaa@axiado.com>
	<anoYDi-bt-t6ZeeD@ashevche-desk.local>
	<20260817034541.053dac28@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 03:45:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 10 Aug 2026 21:27:26 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Mon, Aug 10, 2026 at 07:49:36AM -0700, Petar Stepanovic wrote:  
> > > Add support for the SARADC controller found on Axiado AX3000 and
> > > AX3005 SoCs.
> > > 
> > > The driver supports single-shot voltage reads through the IIO
> > > subsystem. The number of available input channels is selected from
> > > the SoC match data, allowing AX3000 and AX3005 variants to use the
> > > same driver.    
> > 
> > ...
> >   
> > > +/* MANUAL_CTRL register fields */    
> > 
> > ^^^
> >   
> > > +#define AX_SARADC_MANUAL_CTRL_ENABLE	BIT(0)
> > > +#define AX_SARADC_MANUAL_CTRL_CH_SEL_MASK	GENMASK(4, 1)
> > > +
> > > +#define AX_RESOLUTION_BITS	10
> > > +#define AX_SARADC_CONV_CYCLES	13
> > > +#define AX_SARADC_CONV_DELAY_MARGIN_US	10
> > > +
> > > +struct axiado_saradc {
> > > +	struct regmap *regmap;
> > > +	struct mutex lock; /* Serializes ADC conversions. */    
> > 
> > Choose the same style for all single-line comments (here is a period present
> > while in the above, for instance, there is none).  
> 
> Hmm. It is inconsistent in other places, but those two are arguably
> correct. The second is a sentence, the first is not (no verb)
> 
> Anyhow, I did a sweep for other sentences and not all of them have
> periods.  Given the rest of the driver looked fine to me and the other
> suggestions Andy made are easy to apply.
> 
> Applied with the following diff to the testing branch of iio.git
> Note I'm fine with rebasing that (and will do on rc1 once that's available)
> so extra tags or review comments are easy to add for a few weeks at least.
> 
> Mostly I did this just to reduce how many patch sets were undergoing
> revisions... I'm still over a 100 emails to read and run out of
> time for today.
> 
> Jonathan
> 
> 
> diff --git a/drivers/iio/adc/axiado_saradc.c b/drivers/iio/adc/axiado_saradc.c
> index daa98dd2f176..699ee31616fc 100644
> --- a/drivers/iio/adc/axiado_saradc.c
> +++ b/drivers/iio/adc/axiado_saradc.c
> @@ -34,10 +34,10 @@
>  #define AX_SARADC_GLOBAL_CTRL_PD               BIT(2)
>  #define AX_SARADC_GLOBAL_CTRL_ENABLE           BIT(0)
>  
> -/* GLOBAL_CTRL SAMPLE_MASK field value: 0 selects 16 samples */
> +/* GLOBAL_CTRL SAMPLE_MASK field value: 0 selects 16 samples. */
>  #define AX_SARADC_GLOBAL_CTRL_SAMPLE_16        0
>  
> -/* GLOBAL_CTRL MODE_MASK field value: 1 selects manual mode */
> +/* GLOBAL_CTRL MODE_MASK field value: 1 selects manual mode. */
>  #define AX_SARADC_GLOBAL_CTRL_MODE_MANUAL      1
>  
>  /* MANUAL_CTRL register fields */
> @@ -76,16 +76,15 @@ static int axiado_saradc_conversion(struct axiado_saradc *info,
>  
>         guard(mutex)(&info->lock);
>  
> -       /* Select the channel to be used and trigger conversion */
> +       /* Select the channel to be used and trigger conversion. */
>         ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
>                            AX_SARADC_MANUAL_CTRL_ENABLE |
>                            FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, chan->channel));
>         if (ret)
>                 return ret;
>  
> -       /* Hardware requires 13 conversion cycles at clk_rate */
> -       usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
> -                            info->clk_rate);
> +       /* Hardware requires 13 conversion cycles at clk_rate. */
> +       usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC, info->clk_rate);
>         fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);
>  
>         ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
> @@ -220,7 +219,7 @@ static int axiado_saradc_probe(struct platform_device *pdev)
>  
>         soc_data = device_get_match_data(dev);
>         if (!soc_data)
> -               return dev_err_probe(dev, -EINVAL, "failed to get match data\n");
> +               return dev_err_probe(dev, -ENODATA, "failed to get match data\n");
> >   
> > > +	unsigned long clk_rate;
> > > +	int vref_uV;
> > > +};    
> > 
> > ...
> >   
> > > +static int axiado_saradc_conversion(struct axiado_saradc *info,
> > > +				    struct iio_chan_spec const *chan, int *val)
> > > +{
> > > +	unsigned long usecs;
> > > +	unsigned int regval;
> > > +	int ret;
> > > +
> > > +	guard(mutex)(&info->lock);
> > > +
> > > +	/* Select the channel to be used and trigger conversion */
> > > +	ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
> > > +			   AX_SARADC_MANUAL_CTRL_ENABLE |
> > > +			   FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, chan->channel));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Hardware requires 13 conversion cycles at clk_rate */    
> >   
> > > +	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
> > > +			     info->clk_rate);    
> > 
> > I think it's okay to have this on a single line (83 characters).
> >   
> > > +	fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);
> > > +
> > > +	ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
> > > +
> > > +	/* Best effort to stop manual conversion. */
> > > +	regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG, 0);
> > > +
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*val = regval & GENMASK(AX_RESOLUTION_BITS - 1, 0);
> > > +
> > > +	return 0;
> > > +}    
> > 
> > ...
> >   
> > > +	soc_data = device_get_match_data(dev);
> > > +	if (!soc_data)
> > > +		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");    
> > 
> > -ENODATA
> >   
> 
> 

With the diff Jonathan sent in mind,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
