Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78817239E65;
	Sat, 31 Jan 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879464; cv=none; b=DkrtpOe4uuHcShdjDC7NBWH7GMtOeian5EC5qFHWpGwgxN40ol3iGaluR6c/x1tJRe5z4Sdwx81wjSdtym8YYzsLHlBA3X5f7DjokDFd1Wtg8y6LDO0VY1XE8NvARS9tDgvEGkrU2OESQrOEUVDPv6O1HvlGBgNRP1DbNv4azgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879464; c=relaxed/simple;
	bh=0wbxEMqgrxxmQZZicHWOMx4uuUU4g5CXnAjkLnP92yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZwKfq+NOARfQWlJDkm4yuHIeaTo/5YsNPBM+N/HFjtXAx6OjWmi9REIMV8STIkdx1BSkOWhKAf5EfljANDeHwuiq7COguEB3ynNziknXcwY4XOOgAFhyQHpD5xxMmQcV8YuM3Kn1E/ulzSMKUoVAZwD+SM19lZZT2czkYPf7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p69zHsum; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p69zHsum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1283EC4CEF1;
	Sat, 31 Jan 2026 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769879463;
	bh=0wbxEMqgrxxmQZZicHWOMx4uuUU4g5CXnAjkLnP92yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p69zHsumjjhX6NCCrZXmfUhKzux2IDLSktoma1iARLLQr+sIe6JQwlXujRmaXs2rs
	 w6+W0WTgD4FRbwsbJLZKD0qvR0VwJ+s3u+yLes7X3aPjZHa9zaGP++CKAyRTPapqTb
	 II5beglD4YSvSwP4gPY+6zq8EhGkrCyVqitA0uk+ye3x4oy1ZziWX/B9iB2+FNmBoW
	 xA+vR28J16izTgV/WHLvAhly4tzs942Tm1PYlqr3eI3UqOUh82KuOgnjUm8XCuRnSc
	 yTX4rOhI3nJ6kUeAqNmuOWLXc6AZrgKd4YPTq+5BzUqgTxTan0FJxmTIZUJDThdZSt
	 tIlFp9U8A0Gng==
Date: Sat, 31 Jan 2026 17:10:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91_adc: return proper error code from
 at91_ts_sample()
Message-ID: <20260131171054.2b34e357@jic23-huawei>
In-Reply-To: <20260130135126.136861-1-antoniu.miclaus@analog.com>
References: <20260130135126.136861-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 15:51:22 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Return -EIO instead of -1 when xscale or yscale read from hardware
> registers is zero. Using -EIO since this indicates unexpected data
> from the hardware rather than an invalid argument.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
This is a little pointless as nothing actually reads the return value.
It might be better to either make that clear by changing the return type
or figure out if it actually is useful for the caller to know this failed.

On it's own this patch gets us very little even though it looks very
sensible in isolation!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 920dd9ffd27a..5e8719d5ac01 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -323,7 +323,7 @@ static int at91_ts_sample(struct iio_dev *idev)
>  	xscale = (reg >> 16) & xyz_mask;
>  	if (xscale == 0) {
>  		dev_err(&idev->dev, "Error: xscale == 0!\n");
> -		return -1;
> +		return -EIO;
>  	}
>  	x /= xscale;
>  
> @@ -334,7 +334,7 @@ static int at91_ts_sample(struct iio_dev *idev)
>  	yscale = (reg >> 16) & xyz_mask;
>  	if (yscale == 0) {
>  		dev_err(&idev->dev, "Error: yscale == 0!\n");
> -		return -1;
> +		return -EIO;
>  	}
>  	y /= yscale;
>  

