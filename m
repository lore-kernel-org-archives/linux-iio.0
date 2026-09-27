Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE11A6807;
	Sun, 27 Sep 2026 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535791; cv=none; b=Uo5J53GVQn65ogUZkgSCejI0nXOx528sPyW0i1/HqOneY4/zZghTLq8P1XZa75nZu6BPhxmuCkzc4Q41MUTDI/AOEiN5+O7d/2QHRnQx7x5BB3GTdFHLZ2owCf40pZ40sM9DHgP+n7ICAFt5XYezm0pMlJEPV14yJ60Y8aQjoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535791; c=relaxed/simple;
	bh=y6w6cLdoybaFNoUMGnzDNECRPQj1QMSt+uiayyNsibA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5lJvAQmioaBdKx3n3vfuzFypFmShNiNSSH29fyAEFTVRVDB7hUD5G5n1Jq2nxDlHejPwrpWHlzx1GEKvA2biZJrO52VieMTIVCzIjGECezNHf1sV/ULP35AqXjCEdoj1c3sQSMGryMA62dtj4K+Hhdib83z57isM4iudCPLpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUgAf9cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUgAf9cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6562E1F000FF;
	Sun, 27 Sep 2026 19:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790535789;
	bh=2sMMISr1Y352jrY84iBwVU2mEqkI1edzTv3MAWWWKU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AUgAf9cw28+LyHMOwHg/WkUG44LZRxnKozlbPw+dTp7FuQFO6ir4IsJ8qOcBPjvXX
	 jzWRw19IPfEvMIhX1bo4FvfyaDHjPlIX4fDFChShUVoGzsNE7CxBY0d/FwbGL8xEEw
	 yrWHFJU+is+NscInRil5YLrDRkI1jTkdTMd7jL5BSSJTGVsYHJkjb9kJaGjv6wJGnj
	 vpH0PHicKPC5IdCyoejXfz7xo0s5qv9+PypVRVC5kWencHX/TmczrGc79pfA8PF1+C
	 i1I7wS7f9kNNmeWPy83dCvoh6eFyYUogIFyPRy1Kp8L0NWFfF/3zLM0qLQyG2ZAUv8
	 3nkOgwkHMccng==
Date: Sun, 27 Sep 2026 20:03:02 +0100
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
Subject: Re: [PATCH v2 09/14] iio: adc: stm32: add support for vddgpu on
 stm32mp23 and stm32mp25
Message-ID: <20260927200302.66e0bb96@jic23-hlaptop>
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-9-46bc019537c6@foss.st.com>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
	<20260923-adc-stm32mp25-v1-v2-9-46bc019537c6@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 17:39:12 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> Add support for the vddgpu internal channel available on stm32mp23 and
> stm32mp25. It is enabled by using ADC2 and ADC3 option register. Add
> VDDGPU to the list of supported internal channels. Add sampling time
> information from the datasheet.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
I looked at everything before this point and only had comments
to add to Andy's existing review for patch 2.

You will need to rebase on the fix for v3.  That will probably
confuse Sashiko, so if you end up including that patch as
the first one in this series, add a clear note under the ---
that it is already applied.

Thanks,

Jonathan

> ---
> Changes in v2:
> - New patch split from V1, to avoid mixing new SoC / feature.
> ---
>  drivers/iio/adc/stm32-adc-core.h |  1 +
>  drivers/iio/adc/stm32-adc.c      | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> index 68b937e3819f..330c6c30e4f5 100644
> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -273,6 +273,7 @@ enum stm32h7_adc_dmngt {
>  #define STM32MP25_RES_MASK		GENMASK(3, 2)
>  
>  /* STM32MP25_ADC23_OR - specific bit fields */
> +#define STM32MP25_VDDGPUEN		BIT(4)
>  #define STM32MP25_VDDCPUEN		BIT(3)
>  #define STM32MP25_VDDCOREEN		BIT(2)
>  
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index a14f858299ae..a2ed3abffa58 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -97,6 +97,7 @@ enum stm32_adc_int_ch {
>  	STM32_ADC_INT_CH_VDDQ_DDR,
>  	STM32_ADC_INT_CH_VREFINT,
>  	STM32_ADC_INT_CH_VBAT,
> +	STM32_ADC_INT_CH_VDDGPU,
>  	STM32_ADC_INT_CH_NB
>  };
>  
> @@ -107,6 +108,7 @@ static const char stm32_adc_ic[STM32_ADC_INT_CH_NB][STM32_ADC_CH_SZ] = {
>  	[STM32_ADC_INT_CH_VDDQ_DDR] = "vddq_ddr",
>  	[STM32_ADC_INT_CH_VREFINT] = "vrefint",
>  	[STM32_ADC_INT_CH_VBAT] = "vbat",
> +	[STM32_ADC_INT_CH_VDDGPU] = "vddgpu"
>  };
>  
>  /**
> @@ -167,6 +169,7 @@ struct stm32_adc_vrefint {
>   * @smp_bits:		smpr1 & smpr2 index and bitfields
>   * @or_vddcore:		option register & vddcore bitfield
>   * @or_vddcpu:		option register & vddcpu bitfield
> + * @or_vddgpu:		option register & vddgpu bitfield
>   * @or_vddq_ddr:	option register & vddq_ddr bitfield
>   * @ccr_vbat:		common register & vbat bitfield
>   * @ccr_vref:		common register & vrefint bitfield
> @@ -186,6 +189,7 @@ struct stm32_adc_regspec {
>  	const struct stm32_adc_regs *smp_bits;
>  	const struct stm32_adc_regs or_vddcore;
>  	const struct stm32_adc_regs or_vddcpu;
> +	const struct stm32_adc_regs or_vddgpu;
>  	const struct stm32_adc_regs or_vddq_ddr;
>  	const struct stm32_adc_regs ccr_vbat;
>  	const struct stm32_adc_regs ccr_vref;
> @@ -725,6 +729,7 @@ static const struct stm32_adc_regspec stm32mp25_adc2_adc3_regspec = {
>  	.smp_bits = stm32h7_smp_bits,
>  	.or_vddcore = { STM32MP25_ADC23_OR, STM32MP25_VDDCOREEN },
>  	.or_vddcpu = { STM32MP25_ADC23_OR, STM32MP25_VDDCPUEN },
> +	.or_vddgpu = { STM32MP25_ADC23_OR, STM32MP25_VDDGPUEN },
>  	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
>  	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
>  };
> @@ -953,6 +958,11 @@ static void stm32_adc_int_ch_enable(struct iio_dev *indio_dev)
>  			stm32_adc_set_bits_common(adc, adc->cfg->regs->ccr_vbat.reg,
>  						  adc->cfg->regs->ccr_vbat.mask);
>  			break;
> +		case STM32_ADC_INT_CH_VDDGPU:
> +			dev_dbg(&indio_dev->dev, "Enable VDDGPU\n");
> +			stm32_adc_set_bits(adc, adc->cfg->regs->or_vddgpu.reg,
> +					   adc->cfg->regs->or_vddgpu.mask);
> +			break;
>  		}
>  	}
>  }
> @@ -986,6 +996,10 @@ static void stm32_adc_int_ch_disable(struct stm32_adc *adc)
>  			stm32_adc_clr_bits_common(adc, adc->cfg->regs->ccr_vbat.reg,
>  						  adc->cfg->regs->ccr_vbat.mask);
>  			break;
> +		case STM32_ADC_INT_CH_VDDGPU:
> +			stm32_adc_clr_bits(adc, adc->cfg->regs->or_vddgpu.reg,
> +					   adc->cfg->regs->or_vddgpu.mask);
> +			break;
>  		}
>  	}
>  }
> @@ -2651,6 +2665,9 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
>  			case STM32_ADC_INT_CH_VBAT:
>  				na = !adc->cfg->regs->ccr_vbat.reg;
>  				break;
> +			case STM32_ADC_INT_CH_VDDGPU:
> +				na = !adc->cfg->regs->or_vddgpu.reg;
> +				break;
>  			default:
>  				return -EINVAL;
>  			}
> @@ -3160,6 +3177,7 @@ static const unsigned int stm32_adc_min_ts_mp25[STM32_ADC_INT_CH_NB] = {
>  	[STM32_ADC_INT_CH_VDDCPU] = 34,
>  	[STM32_ADC_INT_CH_VREFINT] = 34,
>  	[STM32_ADC_INT_CH_VBAT] = 34,
> +	[STM32_ADC_INT_CH_VDDGPU] = 34
>  };
>  
>  static const struct stm32_adc_cfg stm32mp23_adc1_cfg = {
> 

