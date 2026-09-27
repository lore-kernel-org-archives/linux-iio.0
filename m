Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EE3B7776;
	Sun, 27 Sep 2026 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535481; cv=none; b=tdAnBWY79gba6tx9wfZxq99atDLGUP41GmlPaeLvjkDGABpfa99jDPtNqGuX6G13wBtIlmBJHpW0UUAkZMu4xjxrMBHHEXPridps6NodMf3AJ/pE/edW8vuYYoGZepp3fO6jcoekpe9Nijt9Z+LfGblQoM7hQNBD1l7U3phEDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535481; c=relaxed/simple;
	bh=4ZQnLYNZ+MDkwxQHtM0/LJpwMTeZ07hysuaoYVqSn2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtsORKOysg+g5K689db/t5gWnGT31fuIT28CHTpb4Anm2l5Dhc9cXlWs39n/ioe8K01L1BXT2BWupLcGT9terCgg86Ebti9y8+Cd+2si+m5th60nCy+QzFjwB0gK7j9LmriPiG23UWfsLGHPsVDFaU/iNdUwfmMd1n/Ue79WMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYSYylrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYSYylrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117261F000FF;
	Sun, 27 Sep 2026 18:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790535480;
	bh=sBCRchsp1sI03Um1rqvmQqGg1HFVn6OU3UOiqPFqQvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CYSYylrnQBbvqDP1Ohbo7pOzh7ldRMiIiuzY7lH7ltD3BZBygrRIPavnJZKMWTeAp
	 HNgjmomDh54IocKkHvRtXClN/puPkQkltlkHSnWByL3IZM1HixHkA7+InOUE0mZ9AZ
	 x8UeJtGevKQbV7baTntZjfzSMqHihJ8M222HGCBjVNlFsudJOAVa+GjfozDRo0Porl
	 KAZINSynBWQa4SvgkrLun0Cg4K/vjOZjd9kHTVeCmV6qc+IMI6r5lWSdzDkYzxN9bp
	 BQH6Wtj5nM218LfyKOhMmxQ7XBiFjIulJwPh7Jr994MWfcxdjmB4C5Ydl5rxQ9fjbq
	 twlDpd+GJ1BRg==
Date: Sun, 27 Sep 2026 19:57:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Marek Vasut
 <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/14] iio: adc: stm32-adc: core: manage clock
 prescaler diversity
Message-ID: <20260927195753.307af72f@jic23-hlaptop>
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-2-46bc019537c6@foss.st.com>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
	<20260923-adc-stm32mp25-v1-v2-2-46bc019537c6@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 17:39:05 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> Make the clock prescaler selection configurable, to prepare stm32mp2
> support.
> Reuse existing stm32f4_adc_clk_sel(). Rename it so it's no longer
> specific to stm32f4. Add configuration data to handle upcoming
> differences on:
> - registers and bits
> - division ratio
> No functional change intended.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Hi Fabrice,

One small suggestion to use field_prep() rather than having
to carry the shift around.
>  
> -	priv->common.rate = rate / stm32f4_pclk_div[i];
> -	val = readl_relaxed(priv->common.base + STM32F4_ADC_CCR);
> -	val &= ~STM32F4_ADC_ADCPRE_MASK;
> -	val |= i << STM32F4_ADC_ADCPRE_SHIFT;
> -	writel_relaxed(val, priv->common.base + STM32F4_ADC_CCR);
> +	priv->common.rate = rate / priv->cfg->presc[i];
> +	val = readl_relaxed(priv->common.base + priv->cfg->regs->ccr);
> +	val &= ~priv->cfg->regs->presc_msk;
> +	val |= i << priv->cfg->regs->presc_shift;

I think this isn't a particularly hot path, so we can use
field_prep()  (the lower case one doesn't mind non const masks)

The we don't need to store the shift as well as the mask.

Maybe it is worth thinking about adding a field_modify() similar
to FIELD_MODIFY(). Perhaps that's not a thing to do in this patch set
though.

> +	writel_relaxed(val, priv->common.base + priv->cfg->regs->ccr);
>  
>  	dev_dbg(&pdev->dev, "Using analog clock source at %ld kHz\n",
>  		priv->common.rate / 1000);

> 

