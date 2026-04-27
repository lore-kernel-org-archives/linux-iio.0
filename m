Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D939FCC4;
	Mon, 27 Apr 2026 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283983; cv=none; b=cXhqyIfbp6hoZG+aWsGfdOsATNRka38z6gjvsG0iWIU6Ux4OL9plhlmfUF+xR16FjaEWGpk+9ARt6LuAnJx90oyKmB8Ai+3SoZb4BAp+1uNGStNP9BB0Q3irs9EIXLZJt/11RnSjDwfyrVcCY6QiKYuSudbUZw6ljalyyBhO3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283983; c=relaxed/simple;
	bh=FSaXwopToFHGSbp6zJjvzRg9Qo4fhIOtz1gJ/p2ujYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4iJztOMN0YlAQ3xvt0BJebHOet423MfEAgybP434eO4mA9FNBG2l+9FCGn4udF2hAmJ3lCQ9a4JJ/x2YiENNbTZRxlB3AJiPUsl1a13DDxV4pEFNxQSwve23koVJJjns15AVwsPBdL7Ltzu8HnV6oYZk5ZASieQFiC2w0VJV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKB2q9JD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKB2q9JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AA9C19425;
	Mon, 27 Apr 2026 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283982;
	bh=FSaXwopToFHGSbp6zJjvzRg9Qo4fhIOtz1gJ/p2ujYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TKB2q9JDT87p6PfJ4kQU3VdMwa8yti+aafDQ1bzVMplaw+mRZoqkbKawt77L0AnWZ
	 7QVm56/pmYAlZWaFwm9BN1Wd2L2P4/iELeDfcZKdOcLZ82o3SKooKWvovbR6AZyi2j
	 JTMovBxlVlI0WERNDHdtR26dTHeZsbHqa0SA1R7Z0mMFujFkvnPm+gKTSphT/mmw+A
	 30B+DrjYqEJCvBFPtsX3qAylJeFGEXcMDXbrkoqkA8kzaJE1FBHtwqtPKEO01vhZ1p
	 k4KOM6SFYpoKQUiGcNdCcuPJx3j1LdKpdYvonq3zgis8VDFgKafu/YVA+BEjRF35m0
	 i/Ln/Lk5uwBvw==
Date: Mon, 27 Apr 2026 10:59:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: Add error handling to
 adt7316_spi_probe()
Message-ID: <20260427105931.471655e9@jic23-huawei>
In-Reply-To: <20260426205039.125818-1-m32285159@gmail.com>
References: <20260426205039.125818-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 15:50:38 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Currently, the return values of the adt7316_spi_write() calls in
> adt7316_spi_probe() are unchecked. Add error handling to return early
> and pass on the error code if we receive an error from
> adt7316_spi_write().
> 
> While at it, move all three adt7316_spi_write() calls inside a for loop
> to condense the logic.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/staging/iio/addac/adt7316-spi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
> index f91325d11394..ffd1dae8d1b1 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -98,6 +98,7 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
>  		.multi_read = adt7316_spi_multi_read,
>  		.multi_write = adt7316_spi_multi_write,
>  	};
> +	int i, ret;
>  
>  	/* don't exceed max specified SPI CLK frequency */
>  	if (spi_dev->max_speed_hz > ADT7316_SPI_MAX_FREQ_HZ) {
> @@ -107,9 +108,12 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
>  	}
>  
>  	/* switch from default I2C protocol to SPI protocol */
> -	adt7316_spi_write(spi_dev, 0, 0);
> -	adt7316_spi_write(spi_dev, 0, 0);
> -	adt7316_spi_write(spi_dev, 0, 0);
> +	for (i = 0; i < 3; i++) {
> +		ret = adt7316_spi_write(spi_dev, 0, 0);
> +		/* Check for errors, if we get an error, return early */

If this is tested (and I agree with the others that this is a special
bit of code, as it's hammering a device using one protocol with messages
using the other, then the comment is pointless given we can see the code.

> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
>  }

