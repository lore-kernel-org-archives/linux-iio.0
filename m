Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01241CAA92;
	Fri, 24 Jul 2026 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853514; cv=none; b=MQBzikzAcLAVySaqMqqPAQhSeROaCIGmbSyUiH1b3IiIKZFFEd9II++R3zyseLgoY7k8rRCLa9uV7UY6BZ25PJ/G8zmIX6GQY/OVol8sun9ffqBPRsZMG0xst1sLWcGN5yMUMwXcxejPNaIyknFxNRhBAcu7MYT/BrJRNl8owF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853514; c=relaxed/simple;
	bh=Ptw8lv/h9rCTVhS66ZTLqrLuhMBe1epEP5MVp5VuoI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjrMrqbir9W1et8jUQXwoHcnBAFAczNMZAnNFCyjo6XdG2jBPxl45MKlHNVUiPDUrS3yu4BjkhVZ5ZyEAsPktMmAjn20NilpoParmG4yoozo11PZW/9H5bEQ8b0brpl52QatVjoqOGpDEpcE8Z2qIHm3l3cJByYFbnywqBVv6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru34b9CQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru34b9CQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F341F000E9;
	Fri, 24 Jul 2026 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784853513;
	bh=SwEjmO2jCXryeO/+vZSbFs1N6H7TTum1y2++GBGUUZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ru34b9CQiENfO28wghlORZ99k5a6Qafr5UFErOW+1ZPgeeRayAzWdrFN56Ox26gko
	 idtHjNs778tynHv5PWhJSzkoezoYI6o0ZxAl6exBn2LMkPlIAHyl8qCv1P0RrKmWND
	 1UrLV/N/VvLsXWJC5vfxX7AQt8c8lH0zdLCSxJorXMovhpA06PM9M2SpZIqZCaupTI
	 So8QE+wKANFrlp4aV8VrgtDp9/dNsnu/uz/KtPSf1Z0vTpjemiRB+xe94XOzs54pEv
	 Vgf0elAzxrjxSSZ6FeQY4I8Klkx1gUX2lzqPdYFBTUWivOGMaZQfsX1qkBjSvbrAbc
	 uYTpHUf8pTdUw==
Date: Fri, 24 Jul 2026 01:38:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Linus Walleij <linusw@kernel.org>,
 cocci@inria.fr, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH 15/36] iio: remove conditional return with no effect
Message-ID: <20260724013827.612dd9ab@jic23-huawei>
In-Reply-To: <20260723184538.3888637-16-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
	<20260723184538.3888637-16-ekffu200098@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 03:45:17 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/iio/light/isl29028.c      |  6 +-----
>  drivers/iio/light/tsl2583.c       | 14 +++-----------
>  drivers/iio/magnetometer/ak8974.c |  6 +-----
>  3 files changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index b88e7c4eae3e..ea38d797082b 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -405,11 +405,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = isl29028_set_pm_runtime_busy(chip, false);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return isl29028_set_pm_runtime_busy(chip, false);

That should have been a return 0.  The call to pm_runtime_put_auto_suspend()
can return positive (in theory anyway).  The intent here was probably to eat
that positive and ensure we return 0 or negative only from this function

Please split up a fix for this as a separate patch.

Even better if you have time would be to do that and then a second patch to
get rid of this helper that adds no obvious value.  Smells like code
that evolved into a slightly silly form!


>  }
>  
>  static int isl29028_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index a0dd122af2cf..a38a0130d854 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -456,12 +456,8 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
>  
>  	usleep_range(3000, 3500);
>  
> -	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON |
> -					    TSL2583_CNTL_ADC_ENBL);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return tsl2583_set_power_state(chip,
> +				       TSL2583_CNTL_PWR_ON | TSL2583_CNTL_ADC_ENBL);
>  }
>  
>  /* Sysfs Interface Functions */
> @@ -790,11 +786,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
>  		return ret;
>  	}
>  
> -	ret = tsl2583_set_pm_runtime_busy(chip, false);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return tsl2583_set_pm_runtime_busy(chip, false);
Similar to case above.   It should have been eating the positive return
by return 0;  Also the same suggested follow up cleanup applies in this driver.

>  }
>  
>  static const struct iio_info tsl2583_info = {
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index c7fdb7c2f543..c988d0e40cea 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -379,11 +379,7 @@ static int ak8974_getresult(struct ak8974 *ak8974, __le16 *result)
>  		return -ERANGE;
>  	}
>  
> -	ret = regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
This one I agree with.

Thanks for looking at these.  I suspect you may want to take a closer
look at any other changes you've scripted that are similarl

When code is doing something silly it might just be that, or it might
be intended to do something not so silly!

Jonathan

>  }
>  
>  static irqreturn_t ak8974_drdy_irq(int irq, void *d)

