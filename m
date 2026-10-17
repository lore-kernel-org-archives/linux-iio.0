Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5A3D3326;
	Sat, 17 Oct 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263046; cv=none; b=qYW3BD5Q/kLOq8SVbOfGYBwa4ty1F0KhJooR1SPN9C2nW7iQx7vylu/V4KExgh/voDzKKgCeo2Hx78q82OmjqeEcyYYYRBOCRhNhKSrKB4eNJ7J8GI4JvAVrtAm8Nrjo653rtZuIGxDVFRmxd6vLbjET+ZSKfz1O85UZBAxmYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263046; c=relaxed/simple;
	bh=PGkzB09RuuWpB1ura3zGHWQ56j64JHnYqI2vkEBLkoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNluzlRRLeEqIwdbJFExKsfmpgHzVeIeKAS0FeUn2Bk4t+qHw+zTeEClWkVJK4yDn1bEV9jjvQJZkjE0zs6KwqiMZnNfhB4jGEoO+fh65jfwyy0WrYgeRO+Sb/TO1n8O02r5HVxpjyAMVvThnUe4Sc/SecW0SwqjmB+8abvdlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaUPNrin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaUPNrin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3BC1F000C4;
	Sat, 17 Oct 2026 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263045;
	bh=0tKSwTjSH0ap5oKePnXXk+8FCIiUrNWgGYBWCoOi6+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eaUPNrinWQtG5q4bOispMZioCQtvCUWiYr2hbytQwkCJe6qQ25TjptBmcv67/jpZp
	 RT+wPW5VEFabdwidmUOwgr8CtrliErhjUsFIQGK0xQ68X3D8ZmaX4iX9rJgfP4ZUo6
	 WD3E7nUOTXfiq8JjOiS3ALTXr8cI98M7b0742gj/p5k2HY4otNzdy5YlrpdMOizGWg
	 GgqzZE1hI7wfa0HULeNQlvIekQ6akstZdN+skPaDzxBwR7KJ0FqTcvktx55oCoi2HW
	 C/I3GBuVQkcNF/rn5uASRke+Q93bdDsO+ol2Lj1vlYelrHV5ofQkKbgk3mIkj0e9lp
	 Lk1Kt6LCjn/PA==
Date: Sat, 17 Oct 2026 19:50:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wenqiang Zhao <berringtoni36@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: adxl345: update period cache after
 successful write
Message-ID: <20261017195037.5501e184@jic23-hlaptop>
In-Reply-To: <CAF2O-sN=PM1MUaWzv2r3zT0TozZZje+0eYPiJLQV_LHB3-Qj6g@mail.gmail.com>
References: <CAF2O-sN=PM1MUaWzv2r3zT0TozZZje+0eYPiJLQV_LHB3-Qj6g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 04:48:25 -0500
Wenqiang Zhao <berringtoni36@gmail.com> wrote:

> The ADXL345 event-period read path returns st->inact_time_ms. The setters
> for inactivity, free-fall and the ODR-derived default currently update
> this cache before writing TIME_INACT or TIME_FF. If the regmap write
> fails, the sysfs write reports an error but a subsequent read returns
> the requested period even though it was not programmed.
> 
> Update the cached period only after the corresponding regmap write
> succeeds.
> 
> Fixes: 8a1536cc4a1c ("iio: accel: adxl345: add inactivity feature")
> Fixes: f6f22950d925 ("iio: accel: adxl345: extend inactivity time for
> less than 1s")
> Assisted-by: LLM
> Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
> ---
> v2:
> - Keep Fixes: tags on a single line (Nuno)

Sadly I think your email client or server is fighting back. I'm still
seeing the split one. If that isn't easy to fix, look at using b4 and the
web gateway that can use.  Avoids any opportunity for email corruption.

> - Use a Latin-script name in From: and Signed-off-by: (Nuno)
> - Drop the long validation notes; build-tested only, not tested on hardware
> 
> The missing serialization between concurrent sysfs callers that Nuno
> pointed out is a separate issue and will be addressed in a follow-up
> patch.
> 
>  drivers/iio/accel/adxl345_core.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 6c9080d..cd58304 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -391,30 +391,47 @@ static int adxl345_set_default_time(struct
> adxl345_state *st)
>  	odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
>  	val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
>  		    min_boundary, max_boundary);
> -	st->inact_time_ms = MILLI * val;
> 
>  	/* Inactivity time in s */
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	if (ret)
> +		return ret;
> +
> +	st->inact_time_ms = MILLI * val;
> +
> +	return 0;
>  }
> 
>  static int adxl345_set_inactivity_time(struct adxl345_state *st, u32 val_int)
>  {
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> +	if (ret)
> +		return ret;
> +
>  	st->inact_time_ms = MILLI * val_int;
> 
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> +	return 0;
>  }
> 
>  static int adxl345_set_freefall_time(struct adxl345_state *st, u32 val_fract)
>  {
> +	int ret;
> +
>  	/*
>  	 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
>  	 *
>  	 * Recommended values between 100ms and 350ms (0x14 to 0x46)
>  	 */
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> +			   DIV_ROUND_CLOSEST(val_fract, 5));
> +	if (ret)
> +		return ret;
> +
>  	st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
> 
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> -			    DIV_ROUND_CLOSEST(val_fract, 5));
> +	return 0;
>  }
> 
>  /**
> 
> base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83

