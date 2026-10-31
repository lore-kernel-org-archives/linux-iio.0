Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793488458;
	b=iv4PuK1eoFNlwY1LqaxWXG/N2lfyQ0bX10VQSjUOsPaoPDrjN7PwHE/ImgBM4PnMtdY4
	 bRfJqyX59Dqm9MixOUDI3xYeo1DWroMSk9h4UTRXcCEE6Nna692Y5S8OGrwuW5z4Q9Xq2
	 DxjADBpG2/+pFul2w0y6ws9VwKggSbrICZEDK+9c9m+EGOc0Cp4NHSiSErjjtjAli0Sf3
	 bKRM39BB85JLoplM3+xyFKUTboa6UhLWdcgHKS9Yc/O7jiyHnM+bdi1TSm4cpX+IJfUsp
	 pegDjjcsIzHvvSRoQu9GeSr/3HVZT1S/i+/d7jXTFsL8V5dVsWAbJVQl2uTB5NYShsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793488458;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EvFOsNwECWzkoE1K3ThF17khYLPjrSsyxDscyOScTwc=;
	b=f0IklgoRVtZtAf8jEuRoDnwrfm6DCs0C0+j0WJSpS7A+1XF7DHxHKK6NahhQgjy7JkFy
	 skmYwOFrhu4diQkTjWm7uL8tWvY4bxSuNlWYjwwo093bU64x4tvI6plIq8YuH2q7S5R76
	 HSiFkGi6FjF0pCv9OT+ttJPZz55zJVQUrqs+WIixtG/hRrXG3IAiCmWZ6fNflcnOobdm1
	 XRyGEp+k4q3IRjxGwNpoAYeegqrUqtlyWNezbkv77rv7Xw2gXoSSlcuOrK9V+49FoRQ5S
	 xIPjhrQFKyZ9BwQzHeWZDSWoL95W3f8TQzZGetKtr9U50ZHq+eR9Bluzb6yEHTajf0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AA1GFEPR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65A606A31A;
	Sat, 31 Oct 2026 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AA1GFEPR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFFD1F000C1;
	Sat, 31 Oct 2026 23:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793488457;
	bh=EvFOsNwECWzkoE1K3ThF17khYLPjrSsyxDscyOScTwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AA1GFEPRp+kuc+mN2k6+E1+jMbxMAD1iLd8u5HDknQRvWI9ida3+udfP/Lw5+Suif
	 3nw+3kKfkPxfphua5gRRztv7XGuYv5bZGEUA5nPnvkpEhQ3YMO4KqqUPma/eTg2C5T
	 4dxcuPeJ9591k0wefY6Ru3tXBsK631cNtQZlZ77Piy7h2nkma8SnsKpo9EGApgywiB
	 NEPnMt9MDeRDa0lzQqflklGrdqT/O0gLTRN/IQOlfFU452AYe91Pk9lk+C536XCCcs
	 jhOlPGXINVA3yEsm+Lltp+ErtfIyxokNEPyRP73cPUu7Jyrs3MikR90w7bB84M8qpK
	 NDraaBHkZU8Kw==
Date: Sat, 31 Oct 2026 23:14:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v2] staging: iio: frequency: ad9832: use
 devm_mutex_init()
Message-ID: <20261031231413.19937479@jic23-hlaptop>
In-Reply-To: <20261031091236.40401-1-mnithishvelan@gmail.com>
References: <20261031091236.40401-1-mnithishvelan@gmail.com>
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

On Sat, 31 Oct 2026 14:42:36 +0530
Nithishvelan M <mnithishvelan@gmail.com> wrote:

> Replace mutex_init() with devm_mutex_init() in ad9832_probe() and
> check its return value. The driver already uses devm_* helpers for
> its other resources and has no remove() callback, so this ensures
> the mutex is destroyed automatically on teardown when mutex
> debugging is enabled.
> 
> No functional change intended. Compile-tested only.
> 
> Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
Applied.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Add blank line after "st->spi = spi;" (Andy)
> 
>  drivers/staging/iio/frequency/ad9832.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 35f823f24f..e3b4e19a8d 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -325,7 +325,10 @@ static int ad9832_probe(struct spi_device *spi)
>  		return PTR_ERR(st->mclk);
>  
>  	st->spi = spi;
> -	mutex_init(&st->lock);
> +
> +	ret = devm_mutex_init(&spi->dev, &st->lock);
> +	if (ret)
> +		return ret;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad9832_info;

