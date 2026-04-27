Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F983E5580;
	Mon, 27 Apr 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310347; cv=none; b=aOjYc50w0RczixuHlEjudXBcfJZWzkMu11VFj7qab2teFX0S45FEwXOMHsdPZNQWNbJ8BTqqb5foP/7p6PdBBC2HTImcZI/8+NqhC+Ng1DYyxdWVV/hmhngXVBb+avWSnEXU1gLBkr7/FMhShDJuN/764X4uv2TxGGzK9K8SAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310347; c=relaxed/simple;
	bh=mepkGGhsNTUJswO/3b4246rhiRDTDWXlZZW2YA/w71w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaxX6Zw3G7+3zsikzZG7jIcVDsjFeJ0sXODD9nmdSRpe0s8BwgunWINnnSdToX8SUX30970MiUTZ3Y8VLZvomfkEBCVj25Ru2eBqlvUZKS2EX6UV2w+oYk828VdqGFbEZa8khghHeze9c8n42/zMCb+xZXtr7ftKNVGq9UU1K2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK1GySpR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK1GySpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CADC2BCB5;
	Mon, 27 Apr 2026 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310346;
	bh=mepkGGhsNTUJswO/3b4246rhiRDTDWXlZZW2YA/w71w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VK1GySpR/+ruwGR+XpTEZu6x0iADUCf91xLH8L3bhPIdG+pvpT9ssxCS0989Sew7V
	 L7hsSv7HFAeLG57GPDHtbc+Az66WYRGam54gYYGs1Y9t4MD1fMZE4Lhtr/NiLBIW1b
	 PD3YBfH6p5hE+/y2kzPZGf7XbdwB7VsRx2GNTay4hRZnlwZIuRVQhI4DR0X05i/g1N
	 ZUMuJna6+WQDOyhIs0D20LSta/kt0AaTzbBEb12ICwZ5WVog5bQD7JJHHzVQn359Eo
	 q1RNCDItCIXw2+r/eUeA/JkM8dtXm/tWjfad4wuQYztW85SAZUCxjkbt4rRec0k7v+
	 /Abd13yBi3Pog==
Date: Mon, 27 Apr 2026 18:18:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] iio: adc: mt6359: fix unchecked return value in
 mt6358_read_imp
Message-ID: <20260427181856.613a22ee@jic23-huawei>
In-Reply-To: <20260427165759.5756-1-salah.triki@gmail.com>
References: <20260427165759.5756-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 17:57:59 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> In mt6358_read_imp(), the return value of regmap_read() is currently
> ignored. This is problematic because if the bus read fails the variable
> val_v remains uninitialized.
> 
> The function subsequently assigns this uninitialized stack value to
> *vbat, leading to incorrect measurement results being reported to
> the IIO subsystem without any error indication.
> 
> Update the function to check the return value of regmap_read(). Ensure
> that mt6358_stop_imp_conv() is still called to clean up the hardware
> state before returning the error code.
> 
> Fixes: 3587914bf61 ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v2:
> - Added Fixes tag.
> - Re-examined the entire driver for unchecked regmap operations.
>   While several regmap_write() and regmap_set_bits() calls also ignore
>   return values, I focused on this specific regmap_read() in 
>   mt6358_read_imp() because it leads to an uninitialized variable usage
>   (val_v). This makes this fix critical for reporting correct data 
>   to userspace.

I'd be more concerned about what it might otherwise report.. Will expose
something random that was on the stack previously.

Ok on this one having a fixes tag given the uninitialized, though as I mentioned
I'd have been tempted to take the approach of just initialising it.

Even with the code as you have it here a static analyzer may not be able
to see far enough to tell it is initialized and so throw false positive warnings.

Still, let's see what Andy thinks before you change anything.

J
> 
>  drivers/iio/adc/mt6359-auxadc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> index 6b9ed9b1fde2..f927bff4a26a 100644
> --- a/drivers/iio/adc/mt6359-auxadc.c
> +++ b/drivers/iio/adc/mt6359-auxadc.c
> @@ -497,10 +497,13 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
>  		return ret;
>  
>  	/* Read the params before stopping */
> -	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
> +	ret = regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
>  
>  	mt6358_stop_imp_conv(adc_dev);
>  
> +	if (ret)
> +		return ret;
> +
>  	if (vbat)
>  		*vbat = val_v;
>  	if (ibat)

