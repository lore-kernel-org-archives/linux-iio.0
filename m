Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144E33A6ED;
	Thu, 22 Jan 2026 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111601; cv=none; b=GSwnNu2o2rQkRUF36Pr7s2h/pKwIw/gyvDnKgtVEHaTVEn6WnaExE1IFNOAAsAHsvKCGVMd6FgY1An4WilukAjYdP7LDkft77PGHh+5CBR9jHiIzhUlEq2nNBOfeglbQZu2jJyuV0yBr8VY3DtjOkjqzgRVjvJb92Np/lmGGGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111601; c=relaxed/simple;
	bh=oT4/MA+K+m0OviyBjFj8MxdSzV5XU4lIW7en1Lb9Mzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laFUAAJudiof2+vDiwKBXFmchiRq6WyWIgMl1UeZRflPNyc/tYam+9xvpjJgD204fCsrba5v2i72oQ/pXaayh4YLznBNk3sSMLje2yD1RQ6OE2CDDDlrdC/viCUA3vXm16RrE8Cunqn1Ihtu+XCN1yH951W4G1BNZMLWn/ukHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRnPiP4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRnPiP4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E3DC116C6;
	Thu, 22 Jan 2026 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769111600;
	bh=oT4/MA+K+m0OviyBjFj8MxdSzV5XU4lIW7en1Lb9Mzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRnPiP4/N9RgBcr52wYKKDt1p5joMZE77pcKlzCEXl0A0ww+ylQ/IVKMBsX3s10OG
	 u3ZHlXyyddP/Smufx3/wvyVvGpWFuPRiiitEC3Jd1vD2tqn/0pXsxbUVlKCr4BMLLH
	 fKZgZJR85PlL+2K4mT5l9bDfwFybPqH248Qq0aQYsRiU0e3YQqbac7fzs1PMYD/o6z
	 Q1FULejg5srCmZBOfBJWQmyuco8MhN/bQZcfvwG4CjFs2ea1R+1LaVgeSLet+5XxX9
	 PKbhE9TWrDQfuOFGcJE7B9kjMolTGFeYy9vbn6X5pzi/mkcAcS+NIR2bLXxusm5ZDt
	 NeQ4jjjy4dopg==
Date: Thu, 22 Jan 2026 19:53:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl380: Optimize reading of FIFO
 entries in interrupt handler
Message-ID: <20260122195313.53fde73c@jic23-huawei>
In-Reply-To: <20260119102317.1565417-3-flavra@baylibre.com>
References: <20260119102317.1565417-1-flavra@baylibre.com>
	<20260119102317.1565417-3-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 11:23:17 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In order to minimize the time required for transferring FIFO data from the
> sensor to the host machine, perform the read from the FIFO in a single call
> to regmap_bulk_read().
It's a call to regmap_noinc_read()  not regmap_bulk_read()
I'll fix it.

> This allows reading acceleration data for all 3 axes at 16 kHz
> sampling frequency using a 1MHz I2C bus frequency.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/accel/adxl380.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 650cdbffd4a7..e3e6b182eb3d 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -965,14 +965,12 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
>  		return IRQ_HANDLED;
>  
>  	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
> -	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
> -		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
> -					&st->fifo_buf[i],
> -					2 * st->fifo_set_size);
> -		if (ret)
> -			return IRQ_HANDLED;
> +	ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA, &st->fifo_buf,
> +				sizeof(*st->fifo_buf) * fifo_entries);
> +	if (ret)
> +		return IRQ_HANDLED;
> +	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
>  		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> -	}
>  
>  	return IRQ_HANDLED;
>  }

