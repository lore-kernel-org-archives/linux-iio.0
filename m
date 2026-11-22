Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306452;
	b=kiR6QSxhkQrPsE0BMwMk+PKUPGM9sKQs3C6tV/C6T1757PK2Uk5BsfksOpJjdC3V+4U5
	 yw9YsNARxwrrqDBPh988Q+q53ikvc0CZUYMChwbtIS9lzelYEnhxcxsr9DNOz2/3uEIUb
	 FMlrBkHDv+QH7cja3VCf2oNHpBhCSecp3/ZGnJ8LDwzitCeH6sHUwK0IhjD9nanscEkUE
	 /Ju5qDA6gLpHSoNSRz6Z/MtvuPgv8Zj5/oUvbrYkbgunRMYgsA8L31hxqkhPHKeqyURBc
	 mrrY+q/FbE8N5q1I4TX+3AppUOAfZ7DXIzu+qOQ25Fz+sd9w4K+mOmW5d8UGlJodrUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306452;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6sa9fpr/80cMKeC2gBrVVTJtk5Tx/0YTWpeSWh4DN2U=;
	b=yFPsHf0k56Rqu1Kkv1i7+NG0GoKh6iEnoCHfDoYqwz6CUqQqmgSMuhkKVVJ7NszLgN5X
	 ZUJqBzFqe0wT7SPVOm9mV+zBMXaZIbHPDqjkMkM6xRXrD5/qZNrxvKdb3bJIVb0G2fKcI
	 Ev1oNLdJ87cSaxn3H5Sotk6Rot8F28UyH3Hm5PdWPdNCbNjsV12DueZ089kYUIEoJ4pnC
	 2r+BGnBfcNBFwRjHQyctx9FDHkv4cO0A0mRCXCIsX2ubdloBVIjZuJav+EWcd7yx9TiE8
	 pP8+MUr0Ax3OfhhFvvF6Z6HEt8XZTvm8eY7OsUi8ugsmgPpaupFvea8DU8o6I2LK/qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIpjJlOr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B0606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIpjJlOr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E881F000C0;
	Sun, 22 Nov 2026 00:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306452;
	bh=6sa9fpr/80cMKeC2gBrVVTJtk5Tx/0YTWpeSWh4DN2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TIpjJlOrX/KUThmCDwD5JiwcsQQ9GDtrT5xRX+S+Vi+CYMRD51IK9j4XOgPTfGxOa
	 oOgeDtj246mc8nFHb6gsD0dkLQdnw0aMs8FG38SFUw0CPXdHQ98UsQEQmtEXJzp3BH
	 vb+MrROiySweujB2k8+A42ypmGrzx4W25L19HuKKTSAmjEZv+I9aZegn4TKOE8QmKX
	 MPDO96YQQ6M4j2OR47Jw5TD4Uz8UCRgDLo3X6RYiXyTUJ27QAdOp1pxg9dQACeSg5E
	 XeEX3tb3QHKBKJXyc5tWmzZ+p7s42N33rvvbBvchsLevCiVYW/FkUVu0lHvDv52+St
	 rEAPlIwWc4Mfw==
Date: Sun, 22 Nov 2026 00:14:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: proximity: sx9324: Convert GENMASK() to use
 static parameters
Message-ID: <20261122001406.42ce09dc@jic23-hlaptop>
In-Reply-To: <20261117143556.1759717-1-andriy.shevchenko@linux.intel.com>
References: <20261117143556.1759717-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 15:35:56 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no need to use run-time calculated masks in the code. Besides,
> GENMASK() over non-static parameters might lead compiler to generate
> much worse code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/proximity/sx9324.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 1c8ba28c030a..d3f56ec57531 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -72,8 +72,7 @@
>  #define SX9324_REG_AFE_CTRL6		0x26
>  #define SX9324_REG_AFE_CTRL7		0x27
>  #define SX9324_REG_AFE_PH0		0x28
> -#define SX9324_REG_AFE_PH0_PIN_MASK(_pin) \
> -	GENMASK(2 * (_pin) + 1, 2 * (_pin))
> +#define SX9324_REG_AFE_PH0_PIN_MASK	GENMASK(1, 0)

I'm not keen on a mask being defined that doesn't correspond
closely to anything on the data sheet and these are not hot
paths.  The original code is nasty but if we are going
to change it I think we needs something cleaner than this.

My first instinct is going for the thing that may well 
give the worse code gen and use the dynamic field_get()
field_prep() calls with the mask still being generated
at runtime.  Or given it's only 3 entrees just define
SX9324_REG_AFE_PHI_PIN0_MASK GENMASK(1, 0)
SX9324_REG_AFE_PHI_PIN1_MASK GENMASK(3, 2)
SX9324_REG_AFE_PHI_PIN2_MASK GENMASK(5, 4)

and drop the loops that are making this messy.



>  
>  #define SX9324_REG_AFE_PH1		0x29
>  #define SX9324_REG_AFE_PH2		0x2a
> @@ -187,7 +186,7 @@ static ssize_t sx9324_phase_configuration_show(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	for (i = 0; i < SX9324_NUM_PINS; i++) {
> -		pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);
> +		pin_idx = (val >> (2 * i)) & SX9324_REG_AFE_PH0_PIN_MASK;
>  		len += sysfs_emit_at(buf, len, "%s,",
>  				     sx9324_cs_pin_usage[pin_idx]);
>  	}
> @@ -877,8 +876,7 @@ static u8 sx9324_parse_phase_prop(struct device *dev,
>  		return reg_def->def;
>  
>  	for (pin = 0; pin < SX9324_NUM_PINS; pin++)
> -		raw |= (pin_defs[pin] << (2 * pin)) &
> -		       SX9324_REG_AFE_PH0_PIN_MASK(pin);
> +		raw |= (pin_defs[pin] & SX9324_REG_AFE_PH0_PIN_MASK) << (2 * pin);
>  
>  	return raw;
>  }

