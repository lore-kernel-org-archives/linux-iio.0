Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389872C027B;
	Wed, 13 May 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680568; cv=none; b=ozqrwVkd3qZPcEHyiaRuo2XlQeYeEDFbNNcL3JY2/pQ0mTzKxyEOE8l4lyuDRZdQtAYYfD9faSCjjMgUBp037K0EbAc1HIVAPMFgi11c60Rpsi1xCF62von+DziSjrvdOktBUOpTymiUtEuJQhneJ0qu+Z9HaXxEOahCLl3r+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680568; c=relaxed/simple;
	bh=MXMJ2YErhR+rt5lb41KSQgYV1/p19akuZJWzhANohVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFRHTUm03k6hLGdok4fl5IndcU+cXST8ekIyArMNIi8b71gdC++2p9bMvqyb5LSHowt5LwbjMl65UGow/Peq9H7rRC79wOREV2APfNJ8tIDZfsnocu9pEoaIdDNl7xg6QqoVReGMhAZegeF8K0If01gmXiq28oHQQA3AnB74650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWq8Je6P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWq8Je6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AE3C19425;
	Wed, 13 May 2026 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778680567;
	bh=MXMJ2YErhR+rt5lb41KSQgYV1/p19akuZJWzhANohVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cWq8Je6PS5XGkz1S2cUgi5ffcz11rJG2ojxOUvvndVu0qhf08oxOU3Pl6af1ne+xv
	 2Hd8YeNeEs1EYhcq8UEF900sc5Ta7hXDFo6A6QTV8ygS1ZDBMChwuuoR+vEl6aGWOo
	 VJ+KL6Zk3T1x8tTKM91jL8NpiAURhC28ZQFCSb8fZbtar93p9wNvyoZrmIEL7hhG7c
	 4MAWL64MDOC7TiSYztz/N1s0Asj7Fvs3b8eHiEIV1Nnx3ANTdwznAk5zlIDIG97XsR
	 MecnOivwZqFMgYTjiVAo+MitaHOslFRqA6YMLn0BaRunJk1ISyw5mRVJG2fvK+pFkq
	 Kl1lJbpqlff+w==
Date: Wed, 13 May 2026 14:55:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann
 <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/11] m68k: stmark2: use ioport.h macros for
 resources
Message-ID: <20260513145554.39bdbf33@jic23-huawei>
In-Reply-To: <20260513-wip-stmark2-dac-v2-9-fcdae50cf51a@baylibre.com>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
	<20260513-wip-stmark2-dac-v2-9-fcdae50cf51a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 11:14:33 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Align also other resource declaration using DEFINE_RES_.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Trivial but I'd prefer to have seen the 'cleanup' then the 'new stuff'
after that.  So swap this and previous patch.

Not worth a respin!

However, request for some more info in the commit message - see below

> ---
>  arch/m68k/coldfire/stmark2.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
> index aa2b4d2a8a64..a5b36af8e70a 100644
> --- a/arch/m68k/coldfire/stmark2.c
> +++ b/arch/m68k/coldfire/stmark2.c
> @@ -63,21 +63,10 @@ static struct fsl_dspi_platform_data dspi_spi0_info = {
>  };
>  
>  static struct resource dspi_spi0_resource[] = {
> -	[0] = {
> -		.start = MCFDSPI_BASE0,
> -		.end   = MCFDSPI_BASE0 + 0xFF,
> -		.flags = IORESOURCE_MEM,
> -		},
> -	[1] = {
> -		.start = 12,
> -		.end   = 13,
> -		.flags = IORESOURCE_DMA,
> -	},
> -	[2] = {
> -		.start = MCF_IRQ_DSPI0,
> -		.end   = MCF_IRQ_DSPI0,
> -		.flags = IORESOURCE_IRQ,
> -	},
> +	DEFINE_RES_MEM(MCFDSPI_BASE0, 0x100),
> +	DEFINE_RES_DMA(12),
> +	DEFINE_RES_DMA(13),

Good to mention what result of splitting this into two entrees is
in the commit message.  Basically say why it's a non functional change.

> +	DEFINE_RES_IRQ(MCF_IRQ_DSPI0),
>  };
>  
>  static u64 stmark2_dspi_mask = DMA_BIT_MASK(32);
> 

