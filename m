Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35154335081;
	Thu, 29 Jan 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703972; cv=none; b=EEr3+IXKp8X0paYyE5Uwecgj1iBVoD4R6b6zGqEbT4tvxHrN3wUfkXFGmnQNlJeqgWo3S0h22jyEwKFJumaCD8kSdJqTBftY7ASl4AsbTonfhd3IfSqcAYr4Zm1NSjaC9olfHXAl2xDPG+rGVx+l6887OZSm6WECUTbU4Il3BG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703972; c=relaxed/simple;
	bh=tHhCi/yF39si+LQwI9OVpUpgjxhmW7VFw0p0zy6mJwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbSGhCcnDwYwZ5nQS+z8aA3P94RdTCJs1P1PI/xkdmznXwhNbuQDvHXwusn8805v3AyDV3yUHCLlzcfb6led1bnNDe6+cEtIbQ9r4d9UoZk4tpnXyk+7w3w6KSsMsNiV914V40tQcO4EVYJW3G1T8BmMeXtILX/AhwRWghHueDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e081R4gJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e081R4gJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4107DC4CEF7;
	Thu, 29 Jan 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703971;
	bh=tHhCi/yF39si+LQwI9OVpUpgjxhmW7VFw0p0zy6mJwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e081R4gJtzKP/aBGvI4mcksV05eag6g42mjxOFbyHfhzr1Mwlq0PDjF0D3hF7goAV
	 c24sedHEFg+8KH4StsTRSYYfQMZKM0ztqCvhqiAHA9c9UTgK+x+HwkQZ9AdFP0TuDn
	 tVdYz6LbSDF/vg19mQcOvB+fUiXxp5iww99jeFk0/CtLGUG+TsS67IntnViU0pvyxS
	 J8ExHfvGe0A9I6ydbF0AhyeceKwEgZlx73uMFynjV/zuCHzmKwgFozi3/VTTMu4aXB
	 /+OFx69l8NUHozMRE4KP1jphHfxnE3YWOPsXvosedAiIuNuITDXSpe5Dgt3uN/+Gqt
	 /QnTMfj8ketdA==
Date: Thu, 29 Jan 2026 16:26:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Andrew Ijano
 <andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: accel: sca3000: remove unused last_timestamp
 field
Message-ID: <20260129162602.694ce7e8@jic23-huawei>
In-Reply-To: <20260129141205.106285-3-antoniu.miclaus@analog.com>
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
	<20260129141205.106285-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 16:11:59 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Remove unused last_timestamp field from sca3000_state
> struct. The field is declared but never accessed in the
> driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Also fine so applied.

Thanks for tidying these up.

Jonathan

> ---
>  drivers/iio/accel/sca3000.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index bfa8a3f5a92f..950b4c672484 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -153,7 +153,6 @@
>   * struct sca3000_state - device instance state information
>   * @us:			the associated spi device
>   * @info:			chip variant information
> - * @last_timestamp:		the timestamp of the last event
>   * @mo_det_use_count:		reference counter for the motion detection unit
>   * @lock:			lock used to protect elements of sca3000_state
>   *				and the underlying device state.
> @@ -163,7 +162,6 @@
>  struct sca3000_state {
>  	struct spi_device		*us;
>  	const struct sca3000_chip_info	*info;
> -	s64				last_timestamp;
>  	int				mo_det_use_count;
>  	struct mutex			lock;
>  	/* Can these share a cacheline ? */

