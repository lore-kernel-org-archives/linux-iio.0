Received: from sg-3-29.ptr.tlmpb.com (sg-3-29.ptr.tlmpb.com [101.45.255.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDF31B830
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403494; cv=none; b=F0OUTwPqI+BFm9qOXHFvWhFUCA/hWgLefeGDjIktZqbVqvjHHNpGVfiKQOP69D9iZ906JpjskVVsH86cOvg5Q1+bk3+1E797JIukuBv9KbuisZUZ9l4cCiLZ3bnbiS+59TcqhdUX8i2r83+4lLQ6WCmfKrncuIvqA8LepjeY7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403494; c=relaxed/simple;
	bh=2qhpwsOerN2zephpVI/+rM3QvqBkuMsPMbEkN44RHio=;
	h=In-Reply-To:References:Subject:Cc:Date:To:Content-Type:
	 Mime-Version:Message-Id:From; b=Ndc211uX6f4fcOHIj0mLb1Jb6C0yX6mMuWvbRyilp/70JfGFpW61RtOX1NogVPLazp95SA4cSZNdPIrv+wp66bmopyGsH6cPVlYoO+JRU1CfeKp7eYZUYlMHST5B3PddFxSFKi/B1344hoxvUveaoo5v9WFjKe0q5+brcUH0CYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=kzSnDhwk; arc=none smtp.client-ip=101.45.255.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="kzSnDhwk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1776403445;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=8uKUjmboHagm+FlOR0a5cgZRJN50CFrwF7YGFzp6e9M=;
 b=kzSnDhwkoPhZ60rVpsW/q3eiVwncsZg6sHPoqfBlj9/GwLG6IUELvIpS+U/TIaG9uz9PGq
 dhzhxLFCkxvS8A3o8jPf1TWJyIl6trYKWsL6f2aDNr0FOv6zt50rfUt3mXV8/ijpvZ43xI
 f82egA18THqiEAafbsJwpug7Qz2osB6yp8OXdEIFDIpkhK79hapHQLbmEL6BBylF2Ti+Gb
 bGvmyJNFlMZi7a3dAodCxucTibw6upk6Wfqq2buX7+uHFkNohex4tUuhVIkK5U1Bp2dPKQ
 QMID+KZvvv7SY9pscmbdf02CGCv9OGU7dEOMTk+9v6Wnh6CY519hwV2BVsoJ/g==
In-Reply-To: <20260416011815.9140-1-felipers@ime.usp.br>
Received: from [192.168.8.156] ([123.52.19.211]) by smtp.feishu.cn with ESMTPS; Fri, 17 Apr 2026 13:24:02 +0800
References: <20260416011815.9140-1-felipers@ime.usp.br>
Subject: Re: [PATCH] iio: adc: ingenic-adc: use guard(mutex)(&lock) to handle synchronisation
Cc: "Rong Zhang" <i@rong.moe>, 
	"Lucas Ivars Cadima Ciziks" <lucas@ciziks.com>, 
	<linux-mips@vger.kernel.org>, <linux-iio@vger.kernel.org>
Date: Fri, 17 Apr 2026 13:18:52 +0800
To: "Felipe Ribeiro de Souza" <felipers@ime.usp.br>, <paul@crapouillou.net>, 
	<jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>, 
	<andy@kernel.org>
Content-Type: text/plain; charset=UTF-8
User-Agent: Evolution 3.56.2-9
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <d47618d58e88a65f5b28f1a8e3474819894b2f9b.camel@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
X-Lms-Return-Path: <lba+269e1c3f3+3068bd+vger.kernel.org+rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>

Hi Felipe,

On Wed, 2026-04-15 at 22:18 -0300, Felipe Ribeiro de Souza wrote:
> Replace mutex_lock(&lock) and mutex_unlock(&lock) calls with
> guard(mutex)(&lock) in functions ingenic_adc_set_adcmd,
> ingenic_adc_set_config, ingenic_adc_enable, ingenic_adc_capture
> and ingenic_adc_read_chan_info_raw.
> 
> This removes the need to call the unlock function, as the lock is
> automatically released when the function return or the scope exits
> for any other case.
> 
> Signed-off-by: Felipe Ribeiro de Souza <felipers@ime.usp.br>
> Co-developed-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
> Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
> ---
>  drivers/iio/adc/ingenic-adc.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index 1e802c877..bb7abdcd8 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/cleanup.h>

Can you keep #include sorted?

Thanks,
Rong

>  
>  #define JZ_ADC_REG_ENABLE		0x00
>  #define JZ_ADC_REG_CFG			0x04
> @@ -115,7 +116,7 @@ static void ingenic_adc_set_adcmd(struct iio_dev *iio_dev, unsigned long mask)
>  {
>  	struct ingenic_adc *adc = iio_priv(iio_dev);
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	/* Init ADCMD */
>  	readl(adc->base + JZ_ADC_REG_ADCMD);
> @@ -162,8 +163,6 @@ static void ingenic_adc_set_adcmd(struct iio_dev *iio_dev, unsigned long mask)
>  
>  	/* We're done */
>  	writel(0, adc->base + JZ_ADC_REG_ADCMD);
> -
> -	mutex_unlock(&adc->lock);
>  }
>  
>  static void ingenic_adc_set_config(struct ingenic_adc *adc,
> @@ -172,13 +171,11 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
>  {
>  	uint32_t cfg;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	cfg = readl(adc->base + JZ_ADC_REG_CFG) & ~mask;
>  	cfg |= val;
>  	writel(cfg, adc->base + JZ_ADC_REG_CFG);
> -
> -	mutex_unlock(&adc->lock);
>  }
>  
>  static void ingenic_adc_enable_unlocked(struct ingenic_adc *adc,
> @@ -201,9 +198,8 @@ static void ingenic_adc_enable(struct ingenic_adc *adc,
>  			       int engine,
>  			       bool enabled)
>  {
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	ingenic_adc_enable_unlocked(adc, engine, enabled);
> -	mutex_unlock(&adc->lock);
>  }
>  
>  static int ingenic_adc_capture(struct ingenic_adc *adc,
> @@ -218,7 +214,7 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
>  	 * probably due to the switch of VREF. We must keep the lock here to
>  	 * avoid races with the buffer enable/disable functions.
>  	 */
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	cfg = readl(adc->base + JZ_ADC_REG_CFG);
>  	writel(cfg & ~JZ_ADC_REG_CFG_CMD_SEL, adc->base + JZ_ADC_REG_CFG);
>  
> @@ -229,7 +225,6 @@ static int ingenic_adc_capture(struct ingenic_adc *adc,
>  		ingenic_adc_enable_unlocked(adc, engine, false);
>  
>  	writel(cfg, adc->base + JZ_ADC_REG_CFG);
> -	mutex_unlock(&adc->lock);
>  
>  	return ret;
>  }
> @@ -643,7 +638,8 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
>  	}
>  
>  	/* We cannot sample the aux channels in parallel. */
> -	mutex_lock(&adc->aux_lock);
> +	guard(mutex)(&adc->lock);
> +
>  	if (adc->soc_data->has_aux_md && engine == 0) {
>  		switch (chan->channel) {
>  		case INGENIC_ADC_AUX0:
> @@ -677,7 +673,6 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
>  
>  	ret = IIO_VAL_INT;
>  out:
> -	mutex_unlock(&adc->aux_lock);
>  	clk_disable(adc->clk);
>  
>  	return ret;
