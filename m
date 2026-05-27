Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC497318EEE;
	Wed, 27 May 2026 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906008; cv=none; b=DtaAWXBKrzkYYVmI6YkgYsz1R6DNEgqaZ5gqf6LEKv9lqh+yaIPgRT8D0dhI84z7xbLhUEK7FbdrJqZJmzjvcEiMVPvIhVS46feZ9Av35Yn46sVo+GJpJXdtb0RrdsOK/Vs2H/lYRae2fdSH0YBAfUTzuZDJuufDeZvgr4p86A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906008; c=relaxed/simple;
	bh=aPsKGs1Vt+vl9X7i3JuvTR3g0KIlT3qB976B0uXmgCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR79hNl98h5uAknyQvHLVfkx/P1ecmjYUfBe6hpDAo2r3iUrPbCVJAnBdKMI7kkvtHbxgRLkfiVw9/gy7xrg2lpjwrZ97C4Q8ambHUdkOeu2/rNSQtwsUP7Z+6LWUJF8ASM46noSJ83VwaTsNYIU9rMjyhsig3HcqZ5pgnRwTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khqJIDjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khqJIDjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81321F000E9;
	Wed, 27 May 2026 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779906006;
	bh=1v3rtMWVPX9yEwHbVAidEkPanehT9eODsFwqHLyity4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=khqJIDjXywD+TK0mhbGN61V0gkSgkML3plAdYeqoierrikDlTv0MAjNM2d40VYTD+
	 6yEtqsGBbC0Gruj4h+zrU04b+opcBaaFY7te9jB3BdKUHFvYQiJEBuuGS2COYIHBrc
	 l/vPGjenn9g94zzE2d8+x5v9juipD8wjHTvXzCuV7StbeWA+VSPe9mThptBVMxJ6hn
	 J+jtXEySiNj3bsoh4rmza9glaroMZ5eNZZCxWoEO/awHqy5QPt787GEfpWooOex2hx
	 u0KN6YhVJ2ivuu7Yr28y4ccK2HpglidTzNDQ4ho7JH5VK95fCwaycAr+Zukufb2z8n
	 tZJIPRU2og48A==
Date: Wed, 27 May 2026 19:19:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] iio: light: opt3001: move device registration to
 end of probe()
Message-ID: <20260527191959.5e871e9a@jic23-huawei>
In-Reply-To: <20260525-opt3001-cleanup-v4-1-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
	<20260525-opt3001-cleanup-v4-1-65b36a174f78@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 10:20:15 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Move IIO device registration to the end of the probe() function to
> follow standard driver teardown/setup ordering and improve driver
> logic. Additionally, switch devm_iio_device_register() to its
> unmanaged counterpart as current driver implementation mixes managed
> and unmanaged resources, causing potential resource leaks.
Not so much resource leaks,  more that it is harder to review as 
we have to reason about non trivial life time interactions.

Otherwise LGTM

Jonathan

> 
> Also, add iio_device_unregister() to remove() function to correctly
> handle teardown.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 03c7a87b4a8eef13bbdcf48dcaf969781aa76bd1..6a39f116f9312b6933e86d72aefbaaaf1769aca5 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -874,12 +874,6 @@ static int opt3001_probe(struct i2c_client *client)
>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->info = &opt3001_info;
>  
> -	ret = devm_iio_device_register(dev, iio);
> -	if (ret) {
> -		dev_err(dev, "failed to register IIO device\n");
> -		return ret;
> -	}
> -
>  	/* Make use of INT pin only if valid IRQ no. is given */
>  	if (irq > 0) {
>  		ret = request_threaded_irq(irq, NULL, opt3001_irq,
> @@ -894,7 +888,17 @@ static int opt3001_probe(struct i2c_client *client)
>  		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
>  	}
>  
> +	ret = iio_device_register(iio);
> +	if (ret)
> +		goto free_irq;
> +
>  	return 0;
> +
> +free_irq:
> +	if (irq > 0)
> +		free_irq(irq, iio);
> +
> +	return ret;
>  }
>  
>  static void opt3001_remove(struct i2c_client *client)
> @@ -904,6 +908,8 @@ static void opt3001_remove(struct i2c_client *client)
>  	int ret;
>  	u16 reg;
>  
> +	iio_device_unregister(iio);
> +
>  	if (opt->use_irq)
>  		free_irq(client->irq, iio);
>  
> 

