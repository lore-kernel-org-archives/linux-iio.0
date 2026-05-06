Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671848A2B1;
	Wed,  6 May 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079394; cv=none; b=njVg4M39L0EHDy2Rg1gjKtEQn6SHhr5/oPvgbaG/hGxyIrvWnsTCnnmoliMC8PZa9cgfQOVjbqVSCAFZkBv7h+Yh6L/cUD0QyXsYBMixB4t/m7ugeUQt1SxTHbPqPVr2z66PTig9xddEgTl/FBBztdTkPAbaA6cKyFB60RB+ANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079394; c=relaxed/simple;
	bh=bsx0g8RkKR5HeXJ4S13Js2wdRNvek52tucLoRCTiuXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAyYvqGVETGj8c2E6nxLBgh1VKtZcR8X/KBmiU0nWBZmFnONPo3HoOsSLSnRL4Zr9EkxH4AC6ZPWOQeZSjdDAN+KCE6X+Un7LPVqus6fjGXTYtOtH4n5s2mb3ynj9o8/LfBP+91t0GgD+p+pJkyek3Rp45VGWSsmI/yVR0Jf2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoBC5/IY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoBC5/IY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBF4C2BCC7;
	Wed,  6 May 2026 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079393;
	bh=bsx0g8RkKR5HeXJ4S13Js2wdRNvek52tucLoRCTiuXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QoBC5/IYlle6Vq2hjQXnBQOo894nXVp5QJ02RZ89WtAhqUTM0tDM14RkOaO4LxJNA
	 AErds4eMBwdMIOkKRD8PKrNYGvPi1XUBXkr8ypSBq0fN3sO+nTMgXAyYsIzeWODE9B
	 bxtD6SYSYRb/ip5194RD2Qr9eaOnfGUS0pGbcHkTWZedRvUuNMH02KrlVLCxkJdJnj
	 gYCoblx/GOqMgQxusTpuEcGEbQalUhI8/ovIMtDlB6d1Tx999WliDiGOUrgZdw6cp3
	 j8N2q/JdYSd+dZ1F5DWpJ5lO5oACn4EFQunWZz2O088S8aLgH/tYu8y9Niu00dQdbk
	 c7GVGPFYi9o6Q==
Date: Wed, 6 May 2026 15:56:21 +0100
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
Message-ID: <20260506155621.5b858f6f@jic23-huawei>
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
https://sashiko.dev/#/patchset/20260504-wip-stmark2-dac-v1-0-874c36a4910d%40baylibre.com
has valid suggestion that if you are using BIT() and GENMASK() you need
a suitable header include.


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
> +#define MCF_CCM_MISCCR2_SWT_SCR		BIT(12)
> +#define MCF_CCM_MISCCR2_RGPIO_HALF	BIT(13)
> +#define MCF_CCM_MISCCR2_DDR2_CLK	BIT(14)
> +#define MCF_CCM_MISCCR2_EXTCLK_BYP	BIT(15)
> +
>  /*
>   *  UART module.
>   */
> 

