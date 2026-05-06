Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D53E274C;
	Wed,  6 May 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079010; cv=none; b=Dexdph8FUgSEQCi0ewKozWqB/5m7uc+Vt4lfJtxbt0iiojiFhpHSlqTGC08Zny5442nLIEiT3R+/R4nenchvvVjcRRdunQxxX1IfpDNLQ5tOKIjTl+iWIOA2w+oHFKU1J549IVlHhxDuXlJgTdQEgBPZu7P7xJdR+gO3Io9zuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079010; c=relaxed/simple;
	bh=hxc/WekCWfmbeZgwsH46Ovr1LRwT9vTuK03wutn2Jkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7ZqaQFM2LxPZoKOq7Zr8FRFFSI+SKAGPnlDKdvwzgncXjlG1CmPT/Zld/iPt7d6+tc5u8kG4uBJXmGVGzJcj6NenRl7TwvEWN5a7uMkHIV+dXDwcBOGlCBXwDlH5+k5kgpZABCbgE6MOZ4OQF0uNRmV+IwDZ7QvKUKv/QjnFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EugWsNJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EugWsNJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341B8C2BCB0;
	Wed,  6 May 2026 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079009;
	bh=hxc/WekCWfmbeZgwsH46Ovr1LRwT9vTuK03wutn2Jkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EugWsNJrryhI0StVPBsD6CczQqq7eyRAPD0mmMONG8PVWY8yKRoBDbUYg3BP/ONkY
	 65ykk2jYZ1h1266f8BK1RLmLLN6JxBZlPS0rWWCVwyxV2CUeECxW45HZCk74lfSBda
	 zC7ZTR5g9NQFEqTVPt1igmLn1JBPTeMyYYrr49+4AywYElDz3DZ0JoJeazbaTp3M6U
	 RuepEyo8Hm1okAeULdfJnC2QKN5tzEQABNQAOQQ7itaWqJV6QRYJUhte5JurnisvSR
	 Tmn6lSivHY6vcKTFN4O4K7xNjNvxqQNSnpR16X8jvT0vfgyIxZVWeTzGEjRQbAKGRV
	 qYW1aVLcRAsPg==
Date: Wed, 6 May 2026 15:49:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann
 <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, Angelo
 Dureghello <adureghello@baylibre.com>
Subject: Re: [PATCH 07/10] m68k: mcf5441x: add CCR MISCCR2 bitfields
Message-ID: <20260506154958.0c005263@jic23-huawei>
In-Reply-To: <20260504-wip-stmark2-dac-v1-7-874c36a4910d@baylibre.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
	<20260504-wip-stmark2-dac-v1-7-874c36a4910d@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 May 2026 19:16:45 +0200
Angelo Dureghello <angelo@kernel-space.org> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add CCR MISCCR2 register bitfields.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  arch/m68k/include/asm/m5441xsim.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
> index 9ce2cbb05316..93f7943d5550 100644
> --- a/arch/m68k/include/asm/m5441xsim.h
> +++ b/arch/m68k/include/asm/m5441xsim.h
> @@ -145,6 +145,21 @@
>  #define MCF_CCM_SBFCR		0xec090022
>  #define MCF_CCM_FNACR		0xec090024
>  
> +/* Bit definitions and macros for MCF_CCM_MISCCR2 */
> +#define MCF_CCM_MISCCR2_ULPI		BIT(0)
> +#define MCF_CCM_MISCCR2_FB_HALF		BIT(1)
> +#define MCF_CCM_MISCCR2_ADC3_EN		BIT(2)
> +#define MCF_CCM_MISCCR2_ADC7_EN		BIT(3)
> +#define MCF_CCM_MISCCR2_ADC_EN		BIT(4)
> +#define MCF_CCM_MISCCR2_DAC0_SEL	BIT(5)
> +#define MCF_CCM_MISCCR2_DAC1_SEL	BIT(6)
> +#define MCF_CCM_MISCCR2_DCC_BYP		BIT(7)
> +#define MCF_CCM_MISCCR2_PLL_MODE	GENMASK(9, 7)

Overlapping fields? Bit 7 in both the two lines above.

> +#define MCF_CCM_MISCCR2_SWT_SCR		BIT(12)
> +#define MCF_CCM_MISCCR2_RGPIO_HALF	BIT(13)
> +#define MCF_CCM_MISCCR2_DDR2_CLK	BIT(14)
> +#define MCF_CCM_MISCCR2_EXTCLK_BYP	BIT(15)
> +
>  /*
>   *  UART module.
>   */
> 

