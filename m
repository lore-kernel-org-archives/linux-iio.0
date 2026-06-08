Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA631F995;
	Mon,  8 Jun 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940523; cv=none; b=knSqGjyqu5LuUZYHnYrOSSbKBdIri4MpJLgwksixUOKy9DGsGJs7E/F8OlyQH3lNMhoud/ho03buKe1ViA3wLDxOHChESMMLfNAWw74yrZK8JJGKFk0MNilVagiSq3YHR8GQH2l4Qo3Cgh4TCSuiCRMvU4vMiG0vsrG3obtON/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940523; c=relaxed/simple;
	bh=4lFgomNT6TxofbgAGvfqLmu9KdIp5qVyW7ng+LYzt4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTV5D73YPLRrJXeOtYldrWJS4jvESzJJfv5JjX9wiDtk1dIyK7mrl7nJuG9Bq8z2RXpqP71KTz+SWY7nrhWaUkvtGdebfx6P+sy3crIetUHG5QdXHuRADV+DI+Zq+1wuV6dORe2T4y9cqF4Q7fQR2wIqLzpacd3N1dMoGZimD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZULzIDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZULzIDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1761F1F00893;
	Mon,  8 Jun 2026 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940521;
	bh=sq6hdybJTB69tgzFooqwvpOCKRHUoTlvcu4WMGgWTLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kZULzIDpNxGnHhQdtGMiwzPEFRSet83YodlIFLQNZYXD+WtWjqADD/jyFpTsig8bO
	 eo+tYT4/XDRyQ/Jme339f+omSEe8pOJn+91WbLcvvfguOeYRscZjIfvuPf3uwtk6FA
	 HqwRtG21Lu6lFgAk471Kpk2eodD46oxin2EXJpdIJjbAxeyG+d70+M4VlmwZISdXfn
	 aVnDAlf9xtbvgnV4mneGYCKLtVKjEVlwq/n41QCrQhpAzCeSF5hamQNu1zfLcXeL0e
	 INahMdXSWu4cJsRVGUwUJ2RFHNRvadi0n6UcIayEl1PXEDAB+u9tiKm5ni+phq2++d
	 lKPNRuqUrl5Aw==
Date: Mon, 8 Jun 2026 18:41:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bm1390: replace short msleeps with
 usleep_range
Message-ID: <20260608184154.72a88788@jic23-huawei>
In-Reply-To: <20260607140018.59586-1-dennylin0707@gmail.com>
References: <20260607140018.59586-1-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 14:00:18 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> Replace msleep(1) with usleep_range(1000, 2000) for the
> driver's short delays.
> 
> The BM1390 datasheet specifies a 1 ms reset cancel wait time
> (tSC1) during the power-on sequence. Use usleep_range() for
> these short delays, as it is more appropriate than msleep()
> and avoids unnecessarily long sleeps.

Hi Hungyu,

Use fsleep() which has the added advantage of standardizing the
'slack' so we don't have to thing about the values chosen

Thanks,

Jonathan

> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/iio/pressure/rohm-bm1390.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index 08146ca0f91d..35b9abc25a8a 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -486,21 +486,21 @@ static int bm1390_chip_init(struct bm1390_data *data)
>  	if (ret)
>  		return ret;
>  
> -	msleep(1);
> +	usleep_range(1000, 2000);
>  
>  	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
>  				BM1390_MASK_RESET, BM1390_RESET);
>  	if (ret)
>  		return ret;
>  
> -	msleep(1);
> +	usleep_range(1000, 2000);
>  
>  	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
>  				BM1390_MASK_RESET, BM1390_RESET_RELEASE);
>  	if (ret)
>  		return ret;
>  
> -	msleep(1);
> +	usleep_range(1000, 2000);
>  
>  	ret = regmap_reinit_cache(data->regmap, &bm1390_regmap);
>  	if (ret) {
> @@ -575,7 +575,7 @@ static int bm1390_fifo_disable(struct iio_dev *idev)
>  	struct bm1390_data *data = iio_priv(idev);
>  	int ret;
>  
> -	msleep(1);
> +	usleep_range(1000, 2000);
>  
>  	guard(mutex)(&data->mutex);
>  	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);

