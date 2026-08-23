Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90401A682E;
	Sun, 23 Aug 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510950; cv=none; b=SSCgJ3Uli/dwPRHpeRHCcgwTEWvqGZ2JwfEKGeTIWkIxJl2XkFaBartwNps1vOGkRHhvjB1L6dS7RVnjAHfL8yAQMkDlOVz0BfeLnH40z/3CAEs9SziDuunxAYYl6O5dz7JB0AFuBQqHhfX7iH641KinSZ6Q66IvDO4HCREZOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510950; c=relaxed/simple;
	bh=MKtjiCGtEFLDZdM5h/LP8lamZgrmEM/J6FNN8BZ3ofg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb/isSFFT99OasWjCcFwvN2MxdoiG38r467hGYLvpo0Sx1LYy0lMHpNWBgMGBlQJ0A3EM//xdfFZHbGhgmGY40mfK/VNQeHsFP1WdMUAsD8z4jB4sjyRmEhYsF+GxcoCUknQz2F/SmDdYbiVedGQYIqg3JkKN2qM+nbQmoUF8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ras8+1NV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ras8+1NV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631461F000E9;
	Sun, 23 Aug 2026 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787510949;
	bh=6zDysCKPgBwZxCSSsiOtzONsFPgbKK9sclJebpg7DjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ras8+1NVx8ndbKe0QB93BoL6SBuQFMBpzvULg1ePpluhP5bUFA4cQIL6AhKtBiPfy
	 RozXyyFsdRLXCtqdqa1Xry9JwjFXyzL+FcVHFf6Z1ZwTH+R2RY0JflXHlldw+e5gsl
	 GKU+x5mvQZ/4Myo8YIjDEB6EJp5sap9Pcwp2m4ADS9sBU+ucYQc1cpRn5jtlLpuHT7
	 Eee0FXxVeKf7L1U50QScmLJ+7SGwELa2grdH3fUH6yqHUHW+S8B5w00L1yRUTdH3ww
	 +Orh5vPTCi5QhaTltGSpsNYEgdVIzyEvXKXtlGKUKpC+zQ+DvwXsYzdbToB7CpJD8v
	 wo56dNnnOvdNQ==
Date: Sun, 23 Aug 2026 19:49:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Joshua Crofts
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2] iio: accel: sca3000: fix frequency divider condition
 check
Message-ID: <20260823194905.5a73f55f@jic23-huawei>
In-Reply-To: <20260821150113.45972-1-salah.triki@gmail.com>
References: <20260821150113.45972-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 16:01:12 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> When setting the sampling frequency, the check for `base_freq / 2` is
> followed by an independent `if` statement for `base_freq / 4`. If `val`
> equals `base_freq / 2`, the second check fails and falls through to the
> `else if (val != base_freq)` branch, returning `-EINVAL` erroneously.
> 
> Fix this by chaining the checks with `else if`.
> 
> Fixes: e0f3fc9b47e6 ("iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
Ah, I should have checked for a new version. Generally when it's just tags pick
up (even for fixes) no need to send a new version.  Never mind though as I think
the right thing landed anyway!

Jonathan

> Changes since v1:
>      - Add Fixes and Reviewed-by tags
> 
>  drivers/iio/accel/sca3000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 573831199bba..cced5cd82b02 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -638,7 +638,7 @@ static int sca3000_write_raw_samp_freq(struct sca3000_state *st, int val)
>  
>  	if (val == base_freq / 2)
>  		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_2;
> -	if (val == base_freq / 4)
> +	else if (val == base_freq / 4)
>  		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_4;
>  	else if (val != base_freq)
>  		return -EINVAL;

