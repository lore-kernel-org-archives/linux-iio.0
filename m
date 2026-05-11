Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FD3FADE5;
	Mon, 11 May 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507295; cv=none; b=pZ1cBqHacncW93AsEE1BKrcMD1ARrXddYRvdk2ZrRkJdtE/QY9xBkdxCRF23eqmoZVXXTvkQjN5OhYiK6sCAWAa8al70OSNgyCQ5LU3pllxKqFlJBT8FoRUAHXjxYwt61IDMMxQ4AP5qncb4b3Du5pbvSFvMr5pXc4bzF4DnmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507295; c=relaxed/simple;
	bh=x7U0VhCHy3UjVzi8fmxAB4HXsHUt6tX/F3i44Nob6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/l9vbFx545/zaq0vmzziNoAhW+gqRQ2jcW20Tq2qT7o+kB87oedg9mb7kcBfM0Vm5rMqsvRpi8F+L2KaO/3b5zKFEZe6VQi9ibo509JGJGl9+i78JbxDo2mADG9YefCk9cCzxu8SvSzpQ6EQl9/ykSKp3enucCJ68wb3lxW7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdXWXddZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdXWXddZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E99C2BCFD;
	Mon, 11 May 2026 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507295;
	bh=x7U0VhCHy3UjVzi8fmxAB4HXsHUt6tX/F3i44Nob6VQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qdXWXddZZAHcUAG+oRj6j0giJ7OeYLQWjnKKB2Wm0U9hj/bLP0N0Lnl0AHaGm65VV
	 YoJ+sMytCrdTDux8V1K2lusThQ3y5U1RAFy+Yq51Ch4wX1LaPnkU5L4LUVxMdulsUz
	 KJ//kjo759OncfizaB1TNpnm2jVL1J1xAuA4wdyoTgscPvhwgwS9U7PdebP2o0FWKS
	 KYfzfvEwEZyIDLroOwnUgB/uKNiRdauecmjfm6/5VN94gTF3YCNCONQkUUsHr80crA
	 XrLKVicEp+LGieMVlaYCSr+RPk/8Rft3lA6md99YIxqW2ZZVZFhj5l+crcIf0hbDzu
	 FpgW4cy2FXQ7Q==
Date: Mon, 11 May 2026 14:48:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, m32285159@gmail.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: addac: adt7316: document SPI interface
 switching sequence
Message-ID: <20260511144805.153b1529@jic23-huawei>
In-Reply-To: <20260511023127.86113-1-dennylin0707@gmail.com>
References: <20260511023127.86113-1-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 02:31:27 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> The device powers up in I2C mode. Switching to SPI mode
> requires sending a sequence of SPI writes as described in
> the datasheet.
> 
> During this sequence, the device may still be in I2C mode,
> so SPI transactions may not be recognized and can fail.
> Such errors are expected and are ignored.

I'd not say they are 'expected' as such.  That's because SPI
is a rather simple protocol so it is challenging to detect when
anything is wrong on writes.   It might happen, it might not.

Perhaps

Such errors are therefore ignored.

Same below - otherwise we might get someone trying to verify
they get an error on this sequence ;)

> 
> Add a comment to clarify this behavior.
> 
> Datasheet: https://www.analog.com/en/products/adt7316.html
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
> Changes in v3:
> - Add Datasheet tag
> - Use datasheet name in code comment
> 
> Changes in v2:
> - Add datasheet reference
> - Add TL;DR note
> 
>  drivers/staging/iio/addac/adt7316-spi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
> index f91325d11394..bd92dcddfd91 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -106,7 +106,17 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
>  		return -EINVAL;
>  	}
>  
> -	/* switch from default I2C protocol to SPI protocol */
> +	/*
> +	 * The device powers up in I2C mode. Switching to SPI mode
> +	 * requires sending a sequence of SPI writes as described in
> +	 * the datasheet "ADT7316/ADT7317/ADT7318", Rev. B.
> +	 *
> +	 * During this sequence, the device may still be in I2C mode,
> +	 * so SPI transactions may not be recognized and can fail.
> +	 * Such errors are expected and are ignored.
> +	 *
> +	 * TL;DR: Do not change this!
> +	 */
>  	adt7316_spi_write(spi_dev, 0, 0);
>  	adt7316_spi_write(spi_dev, 0, 0);
>  	adt7316_spi_write(spi_dev, 0, 0);

