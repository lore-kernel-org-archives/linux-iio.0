Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15448C8B0;
	Wed,  6 May 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086552; cv=none; b=ZFpivPCAMm1rnom4bT+6x3EzCz6lHB+Alkq89wCvM9UJamm6hjKsds/yaiu3FVFb2DOBwrcTNxTXNXn/2qK+dnoFXCn2USq69W6EhxwkPanEVWe7i1W/pU/TSWEap16X0gqVGzHpkeuo2nvX8ZEU6Uq3Uh0mwAkG5VtuSpmBh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086552; c=relaxed/simple;
	bh=sm1z1oIj02TJCKbT/FVlGxd/13a+RFi7X3nmfvYPBtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwQxI4xWJHHnrapME7ldEali/k8007rx8uuuc1ULt5BP1Oi7MiJcWZuQ/20G/AefBanAwa/mXAQyEeV5xpK3f0fusUi9CwI6LJz4oB2HLVidfUViZZ6LSTSu1JonYwDF7JA8MdD5pCX9UAVJgMr4buLjJXAhTP4UlTrWLShgBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuABrnkd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuABrnkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEEBC2BCB0;
	Wed,  6 May 2026 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086551;
	bh=sm1z1oIj02TJCKbT/FVlGxd/13a+RFi7X3nmfvYPBtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QuABrnkddydr1tvKxKbsLgnD3/KeHqLzmO28DX/SRyUJkymX7gJ0i4FX1637xSCbt
	 8VzoszXUZUwxSXezS2wnxCeDWG55E1v3ZqBRH9dy3xWMnXOw4EjZG8pSEDBO9XZGrk
	 ZcTSOWghJvwUPYsb3rBkw4sCJA1ooN85s8T1IbyEHfjxmK/34c0mzdxMAlXDMRdc8X
	 JJ+qyLqLtdjz9AsGthKjTvuugxDOqCszE2uyHOa8Y9tCazAvsAJkavvKkYbaxdtRto
	 tNyeOREv0/q+NxNCFgTTgeA6PuG43AKvH7iV9XQk3TGv6Gf8a2lWhe0iS4AJx889Vn
	 p5LF6RpzuTJUw==
Date: Wed, 6 May 2026 17:55:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 10/18] iio: magnetometer: ak8975: drop duplicate NULL
 check
Message-ID: <20260506175542.0c8192b2@jic23-huawei>
In-Reply-To: <20260505-magnetometer-fixes-v5-10-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-10-831b9b5550fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:46:06 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> The gpiod_set_consumer_name() is NULL-aware, no need to perform the same
> check in the caller.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied.

> ---
>  drivers/iio/magnetometer/ak8975.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index c36d068081066ef6b42cc2f9c3c2e8978ec51623..7a971de2eebf127fc8ab68300fb82f38d9476c0c 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -918,8 +918,7 @@ static int ak8975_probe(struct i2c_client *client)
>  	eoc_gpiod = devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
>  	if (IS_ERR(eoc_gpiod))
>  		return PTR_ERR(eoc_gpiod);
> -	if (eoc_gpiod)
> -		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
> +	gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
>  
>  	/*
>  	 * According to AK09911 datasheet, if reset GPIO is provided then
> 

