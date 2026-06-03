Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9153603F8;
	Wed,  3 Jun 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483979; cv=none; b=aW6jHogCUiy0pCTJuUTX/ZTYKGF+Vfl10knnCuRjirFIfaMCSUoG4wan4AbeyyCKoIXQ0FaypGJ0gkec0i00ROUX4qZp75nA0c0Y+zD+bAX9utEiJIRrW2T2kskCmtrPrbn/htrjO/Evak7x1tGks2f6vaO2gj5vyCUvyxkJo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483979; c=relaxed/simple;
	bh=7MoMLDIhuddRy50PVWUU3uyop3f0JRLgbGCtHJ2eQu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nd0ny0yUqGnR4QAPBamC1cgfxx8XJMKMJLrw5/ZEgC5olO/to5lnvOdeGNn/R3nNTlP2ZZnpONM2LwvmrsZghgHbEStntpaRhl2sCVG9DjsBTaBwl84cHcWo0u67Ghq9yWffN+L7682I2hnBqIURfCPj2q+4G9iNMImEAzcqmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia4xxPF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia4xxPF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8933B1F00893;
	Wed,  3 Jun 2026 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483977;
	bh=MrGq5xXxgMTmyRkfE/Yx1IFyJqNA4TZh+ODk2PteD5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ia4xxPF2MryCKHr6m9dyQtptm8ABxOZjsLA0dbUgavMvi+zzhixEKGmrDXJlo5GFI
	 BudxlhYPq/f40Sxmq7IaRnXG3WBl4UwmGA6+kxRHGw8SRBcHZTr9ZAHon26iSTjh6/
	 yd+F13ETGuDIRNaJaVMQxpQWKsEmSR+7WA4LuqSEEoQlgRvQcwx6mlYilOdon4EA0C
	 5DWO+2auPajjBXXi0ssXCiePJ9rEIdkDYAlvgh5KswqsYJYqkKHt2d3OLPRP+ONgsA
	 WQ+NFwLXkGeXMJETeOzNG2kRvu3fmRfOp0dmrhpAsU+8KqeeXJrRMshUz8DUIcKkmI
	 UcTJZONQ/ffZQ==
Date: Wed, 3 Jun 2026 11:52:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Narimani <tahanarimani3443@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Use
 devm_gpiod_get_optional() for busy GPIO
Message-ID: <20260603115251.06e6f7ee@jic23-huawei>
In-Reply-To: <20260603123333.5608-1-tahanarimani3443@gmail.com>
References: <20260603123333.5608-1-tahanarimani3443@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 12:33:33 +0000
Taha Narimani <tahanarimani3443@gmail.com> wrote:

> The driver currently utilizes devm_gpiod_get() for the 'busy' line,
> which makes the GPIO mandatory. However, the busy pin is hardware-optional
> depending on the specific board configuration.
> 
> Switch to devm_gpiod_get_optional() to allow boards that do not have
> this pin wired up to still probe the driver successfully, and remove
> the redundant conditional chip-ID check since the optional API handles
> missing descriptors gracefully.
> 
> Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
I tried to pick this up, but it doesn't apply. I suspect that's because
you've put it on top of your previous patch which modified the checks on chip->id

Please send it as a single patch. Also this is fixing a false assumption in the
driver so it should have an appropriate Fixes tag.

Trivial comment inline.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Fixed trailing whitespace and missing newline at the end of the file.
>   - Converted the file format to Unix (LF) to remove carriage returns.
>   - Removed the explicit chip-ID check around the busy pin logic.
>   - Improved the commit message to provide clear architectural justification.
> 
>  drivers/staging/iio/adc/ad7816.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 0eac484..039b34d 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -84,7 +84,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
>  
> -	if (chip->id == ID_AD7817) {
> +	if (chip->busy_pin) {
>  		while (gpiod_get_value(chip->busy_pin))
>  			cpu_relax();
>  	}
> @@ -380,15 +380,14 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  			ret);
>  		return ret;
>  	}
> -	if (chip->id == ID_AD7817) {
> -		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
> -						GPIOD_IN);
> -		if (IS_ERR(chip->busy_pin)) {
> -			ret = PTR_ERR(chip->busy_pin);
> -			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> -				ret);
> -			return ret;
> -		}
> +
> +	chip->busy_pin = devm_gpiod_get_optional(&spi_dev->dev, "busy",
> +						 GPIOD_IN);
Trivial:  We are more relaxed on line lengths these days so for cases like this
where it would only go a little past 80 chars to have it on one line I would
generally prefer it that way.

> +	if (IS_ERR(chip->busy_pin)) {
> +		ret = PTR_ERR(chip->busy_pin);
> +		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> +			ret);
> +		return ret;
>  	}
>  
>  	indio_dev->name = spi_get_device_id(spi_dev)->name;

