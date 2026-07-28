Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325B47FB1B;
	Tue, 28 Jul 2026 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274216; cv=none; b=TSshK4kWsbyusXjjB0xfyEZsjGJ+YrVMr7KWIQornzYOOHRgAfTeBfiaKfYVBjXyyJk2xGUiJB7Fs6av167pcEUa70n8hKMAmJpuk9Z/kcIJxx/V3A3Uq8ig4htXspBacahhGgNFjO0TZgQYVxRjeNoSpuJ554H5SnyVBkN28D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274216; c=relaxed/simple;
	bh=9+BAQ/zxJ7QAiLsw7jnaFC6u04f/DIPSFn+BQMy4y30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+HCWWqiofaLahr/SaPA/mdnU1EP1cscb1d/MFqV3UlR/0CSNdWMd3PWP86g8HQv8C1PGUePkRmbpYuQtjhgMWo43pRKyLCl13j/fC8XpBbs7Jwwm5EbWhEe+o8yZuQH37qlMJApcQo8wi5UIRpR9jvtU4Gzlsb8ZCMl3c+07XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyRgfh1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyRgfh1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235D21F000E9;
	Tue, 28 Jul 2026 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274214;
	bh=1mqwcvpVM+SO0yrFxqUTF6f741PrmWcZBp+qepbe1sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WyRgfh1B8Oxe2Np1Bc8rgrK57DIZ+vCdLkqPOkKYaATjz/xCVrhU+B80YmGzcrgX0
	 6vbZ5xKAj6zzJcS1e7eYvq0PEb4Yt1l6GoP6yA3VM2BgFa4gE8kA5udRPi+ciqCbsz
	 7/OYXeR2WFDfOMCGne0uHlOCUoj7bqLkHUyA/aUbCwPdGy9voCBBNtMHnEKwBCLBI8
	 LPTezwl4vSxpkM9we+AkXgP1rsZPr8SdVgtB2nrSinBvChAM3sD9I4IbkJgjloPDz7
	 wJQBLacNJE3b4eOjddVOaznMLY6M6fzN3Us0EPYxlnrQ4biwqXujjctXmHrd1nRYvp
	 Sji4XNjFgsIWA==
Date: Tue, 28 Jul 2026 22:30:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Eddie James
 <eajames@linux.ibm.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: fix pressure result shift bit
 definition
Message-ID: <20260728223009.0cb86996@jic23-huawei>
In-Reply-To: <20260727150934.9471-1-zoone.rupert@gmail.com>
References: <20260727070547.649074-1-zoone.rupert@gmail.com>
	<bb74b15e-6a95-4eaa-82bf-7c256b554c45@baylibre.com>
	<20260727150934.9471-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 18:09:34 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On 7/27/26 4:27 PM, David Lechner wrote:
> > In your followup work, it would be nice to start with a patch to
> > sort these in a logical order.
> >
> > Right now, there is a mix of GENMASK being sorted from high to low
> > while bits are low to high (with DPS310_INT_HL being out of order).
> > Normally, we go from low to high on everything because that is how
> > datasheets usually list things.  
> 
> Makes sense, I will do that. I have a cleanup series queued from Andy's
> review of the ACPI fix, so the sort will go in as the first patch of that,
> after the buffer work lands.
> 
> One thing worth flagging about the block you pasted: it keeps FIFO_EN at
> BIT(5) and SPI_EN at BIT(6), which is what the driver has today, but the
> datasheet puts FIFO_EN at bit 1 and SPI_MODE at bit 0. Datasheet V1.1
> (2019-07-11), section 8.6 "Interrupt and FIFO configuration (CFG_REG)", the
> bit table reads INT_HL, INT_FIFO, INT_TMP, INT_PRS, T_SHIFT, P_SHIFT,
> FIFO_EN, SPI_MODE for bits 7 down to 0. So bits 5 and 6 are INT_TMP and
> INT_FIFO.
> 
> Neither define is used right now, so nothing is broken today, but the FIFO
> enable is needed by the FIFO patches. I have that as a separate one-liner
> ahead of them, since it changes values rather than moving lines around.
> 
> That leaves CFG_REG looking like this once both go in:
> 
> #define DPS310_CFG_REG		0x09
> #define  DPS310_INT_HL		BIT(7)
> #define  DPS310_TMP_SHIFT_EN	BIT(3)
> #define  DPS310_PRS_SHIFT_EN	BIT(2)
> #define  DPS310_FIFO_EN		BIT(1)
> #define  DPS310_SPI_EN		BIT(0)
> 
> I left the three interrupt enables at bits 6 to 4 out, since nothing uses
> them and the driver has no interrupt path. Say if you would rather see them
> defined for completeness.

If there are more bits to correct (even if not used) let use doing
them all in one patch. Given where we are in the cycle I doubt I'll be
trying to get this in before the merge window.  As such feel free to
just put the fix as first patch in your series making other changes.

Thanks,

Jonathan
> 
> The rest of your ordering I will take as is.
> 
> Thanks for looking at this.
> 
> Rupesh

