Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793580435;
	b=ffdBkbrfij18pV9sc7nSDxoK+aM57xZYqQ7Ho/Ic7oWixsxv46Tht3INROQyj2/SPLoJ
	 HVO8g756DT436y2SkwW7ksqYEAN/CKUe4A75eTWyVscOH3iCY9JW8AdhUzVMXcGhTsAYR
	 1pxU7Yx+vpTzqJnvC2YCi0NMn8BCxj82xU+eSJsCxhcg19cfjZ+5HRNDprs0TzTndWm2x
	 F7okTdaDiNPGT2D854xEJEdqMT6I2FIIGXBmaoHTrdbd2ssciNcRm3IfoDw+6w58dqunu
	 IMy/wM5Xw4Vm28Fs+vpO2EttlISRzFvRfNEGBwPjg2xkBkC7abpeMRzim88+IpB+Cog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793580435;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xdlnoIvzsYxTwffLVnVth1spc9WrvS6NQ0FCDLT0Qo8=;
	b=YmeEq2pMEZp29fo7MDCIGR394DOQjvxDmmtkOoBC01Twh9uslsfFuEOH+JmLP8GZe9Jr
	 59BbZbK1GQjEvLySQEeP3u0Ga/xD/X/Sj72FCCHsyKvK0FPgcY6X4lYhk0A+AbiZ1gGJS
	 tkGtFFldNRhUcL/49ogq2WnaYOFqXW0LMJCPDBsQ7aiIiGyGjGcsr5Pr2ibMzfmaSZT9W
	 Vs/EV+G8QgI8UZuLccNGAuY1672EvjwQeJWuMnlxVlNyAJjuUb3o6ENBK8sLWRq5LVKio
	 dDsVJAsgN1Xzt2KaKEoJATCMSY/T5u3lpxj8yP6gILmJc1EFGjlc47lPDFVZ9ffTM4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMCVJOd3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA3606A324;
	Mon,  2 Nov 2026 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMCVJOd3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF031F000C1;
	Mon,  2 Nov 2026 00:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793580435;
	bh=xdlnoIvzsYxTwffLVnVth1spc9WrvS6NQ0FCDLT0Qo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VMCVJOd3wp0SY4Snxaqf/xi2jnjf6dbnTfr9yNxgv31cNT8hh3kk8o3IUgOJTdmEN
	 eKXeKRB8iGp3kSdeUX38UW2PwtPl/RufOdusR1jVaSBdG/lPAMBnjagLCfTiPjAyA2
	 kaLYAKHea/NIgO0ZjBBISVAjT6bT6QewCOisYKivxO+bQCevCcNrPXjBocMIRZuU5J
	 GlsCtHJlg8J0NHRnL7d4dGU+SOlzUGgCVZGyqSzTeDuiYNUwnedsRcZTUea4AJg2ZF
	 HKFjpTrdc3R3xaAYrtGkpXNJFvp7Us8aqWJEKBvIcoyQ5hZ+fb2qCP+WyYXD9h6peZ
	 t4WqND+8bzAsw==
Date: Mon, 2 Nov 2026 00:47:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Stephen Boyd <swboyd@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx9310: report a hysteresis of 0
 when it is disabled
Message-ID: <20261102004707.596faffd@jic23-hlaptop>
In-Reply-To: <20261026112054.59895-1-kapoorarnav43@gmail.com>
References: <20261026112054.59895-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 16:50:49 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9310_read_hysteresis() turns a PROXHYST value of 0 (no hysteresis)
> into a shift of 0 and reports the full threshold, which writing back
> then usually fails with -EINVAL. Report 0, as sx9324 and sx9360 do.
> 
> Fixes: 08f0411c48f2 ("iio: sx9310: Support setting hysteresis values")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Seems correct to me, but not massively urgent. So with that in mind
I've queued this one on the testing branch of iio.git.
I've just rebased that on the newly available 7.4-rc1, so will give
it a few days exposure to the bots before pushing out for linux-next.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Invert the conditional (Andy)
> 
> v1: https://lore.kernel.org/all/20261026100041.16018-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1); I don't have SX9310 hardware.
> 
>  drivers/iio/proximity/sx9310.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 79ba46d8a0aa..dc1b1c3f4776 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -446,11 +446,10 @@ static int sx9310_read_hysteresis(struct sx_common_data *data,
>  		return ret;
>  
>  	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_HYST_MASK, regval);
> -	if (!regval)
> -		regval = 5;
> -
> -	/* regval is at most 5 */
> -	*val = pthresh >> (5 - regval);
> +	if (regval)
> +		*val = pthresh >> (5 - regval);
> +	else
> +		*val = 0;
>  
>  	return IIO_VAL_INT;
>  }
> 
> base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9

