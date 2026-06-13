Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE5283FCF;
	Sat, 13 Jun 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781358666; cv=none; b=gMnsUOSASYJ8h4ONT8O/ccrQT/TMOintJFwgQWbvmhGl1NXW+cIMl2kVzovzJWoPloTuhxglQlsqK0p8uC5eb/MdZtMbcwoID2DFPCkBncZhowQ8B5NZLItmFFf6f4lmegOTcEumS0GjG6kohfJj+f2Ufk4Xb/fGMpfVGUVXsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781358666; c=relaxed/simple;
	bh=jN3SlDuiV5stp+Buf5kpbd349ZwyzjpyEHsr9AvDj6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPuSR7d8/38CjwqahElZkxqJTBCZ92A5UgJk+8OoYKtP6ZKYlc1/vX1ZUpgl0dhHGNSIOFGK2PwRApiUbWojRK+Os1qEqerHUNgbGBTGmNg6QSZ3aZZ0DELGCXvIJYb2VWPOOJkkUB0s8Xsj76mpocvHdjWMNrfHGLg9uhIDkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW3vOKcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW3vOKcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD83B1F000E9;
	Sat, 13 Jun 2026 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781358665;
	bh=tOV/mV9f5iulpY/spBqX8ZpBgnL8iS2MkL1dmpe4PXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KW3vOKcwLvi+0AZ9U1BftRWGZ8UnidZm0sDbOjoUunn7olxl9iC4TdoflBiy3dkkR
	 njgxykl2t7knz+6hhs7HoOkiMKaTqCaPdLFJDxalBMV6AKzOGviLpWY/uwzXd6ZKIo
	 vgdy9tK//iL9QuFLlL5aMed5wo3+NUO3X/RZzHvjsthUS3+s2eVUIxqluB6Tm0QWHE
	 mFxhcV7lQjJFdaZaTYDQk7npDQ6vqucdj735kbdjd9EBfMNUw01uHkVFUHFaH3iRWB
	 CuQ5GnyBW8CFFvcin1or8+YxECFuO+qqFl0itOagsJGeBqfSNPL/KwpVQUj3UHI/iV
	 VZkAskKtlIe7w==
Date: Sat, 13 Jun 2026 14:50:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: adc: ti-ads1262: Add calibration support
Message-ID: <20260613145055.06aedf2b@jic23-huawei>
In-Reply-To: <20260612-ads126x-v1-4-894c788d03ed@gmail.com>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
	<20260612-ads126x-v1-4-894c788d03ed@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 17:46:22 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add channel calibration support.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1262.c | 70 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> index 6d5f22836ad8..b33505e7fdc7 100644
> --- a/drivers/iio/adc/ti-ads1262.c
> +++ b/drivers/iio/adc/ti-ads1262.c
> @@ -217,6 +217,10 @@
>  #define ADS1262_RMUX_AVDD_AVSS			4
>  #define ADS1262_RMUX_COUNT			5
>  
> +/* The calibration word is signed 24 bits value */
> +#define ADS1262_CALIB_WORD_MAX		((int)(GENMASK(22, 0)))
> +#define ADS1262_CALIB_WORD_MIN		(-ADS1262_CALIB_WORD_MAX - 1)
> +
>  struct ads1262_channel {
>  	/* MODE0 */
>  	u8 conv_delay:4;
> @@ -453,6 +457,32 @@ static int ads1262_dev_start_one(struct ads1262 *st, u8 runmode)
>  	return 0;
>  }
>  
> +static int ads1262_read_calib(struct ads1262 *st, unsigned int reg, u32 *val)
> +{
> +	__le32 lval;
> +	int ret;
> +
> +	/*
> +	 * The calibration word is a signed 24 bit LSB-first value.

Single line comment.  However, it's also fairly clear from the code, so maybe
no comment at all. 

> +	 */
> +	ret = regmap_bulk_read(st->regmap, reg, &lval, 3);

Read it into a u8 [3] and use get_unaligned_le24()
That avoids us having to think too much about the bits that aren't
initialized and static analysis / compilers having to figure out
they don't matter. I general it is easier to understand.

> +	if (ret)
> +		return ret;
> +	*val = sign_extend32(le32_to_cpu(lval), 23);
> +
> +	return 0;
> +}
> +
> +static int ads1262_write_calib(struct ads1262 *st, unsigned int reg, u32 val)
> +{
> +	__le32 lval = cpu_to_le32(val);
> +
> +	/*
> +	 * The calibration word is a signed 24 bit LSB-first value.
> +	 */
> +	return regmap_bulk_write(st->regmap, reg, &lval, 3);

Similar with a u8 [3] for the '__le24' storage.

> +}
> +


