Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772C42A79E
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009507; cv=none; b=hRi18D+Azm/91jq7+o0lPIfw5Ib06JvN4jaGqfX1f0UWVaJETlbp3fHFbZxET/1fKp67DL4caYB958WS5t9R6K7Q01db8rAlO6L03H7BIKMkVqpTTk+4zhVMQ7KNr7xMcus0ssIbhUeBf1Fs9c7m+pck/93RXTMzR23LF8V2vCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009507; c=relaxed/simple;
	bh=TeAZHoCbWw14IefsUCwbSK6oDvJqdpRiQEV6O22Uwdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6hLN+QAUJ/S7y0ffvke9WHv4kuC0kZsDK+ILI+lfzn3d4SsERG2wuRlKNocGLgH4GdAUI9A6ZBNUqZnDy3W8XwCHeaXRHe/PWUTG6oKRjcVzdrEP6FO9DzeUyNTxpQLDj17aN7N51HdgqXwSj1QLEqB45wkT3Xu/B/Wq51kXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szjr0vtA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szjr0vtA"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954afac04bso21740655e9.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786009503; x=1786614303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2/mFRvlwdBz00We0HdqUhSQE0scSFWYjxULPu/jANo=;
        b=szjr0vtABgDNLyJLaIOUkNG4QiFcJuC7rtENQqJ5To1adbXwnZ3PHeoSehHSyCWPYT
         ZamsyWainDw38aNnbKu5r5bfCnwyAQo4M62fQsKKguB8tVYzLocf+3lDHGN0ck/ob/TL
         hNvZIdRL6UXS7nleOEx7DVt1YC5s8OjNGvaLNxbgxknXnBFJ86OmDwbxvR8qYaqWiJH7
         ABwjxWnN/ANtN873GWzzRP/00rvclcLBuLaEPmhEtjtRFr5l6FIMczWAAXO0l5P9Kqpl
         1/8q+AGNW9h9inJXWwVwWiI0vJfRrCrRmuWdCJpGtq+0FCDKqRVWcWXvlS6t4y+M1873
         OFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009503; x=1786614303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G2/mFRvlwdBz00We0HdqUhSQE0scSFWYjxULPu/jANo=;
        b=n8/r3cfJooddB1SEdjWTOGLh93b6fMmz94Go+G9uKki0/0Ir6vrAlR7o/x0475Ym1O
         Yhq2j/DnQ4CmemfECLuZmpYmEPudlyXjcc90K7dqcdgC3u+CY7XVVx/98RYKxZ4uISq4
         gKberjdJYCCeATCffkzz6eQdK+OnSFyjPn0IkD3D9/bimpDU21lapTvFxoJnHB4BKCo7
         6Xxpz/hAIes1D7kiq6bNncnl7hmCHW/0UML/9v3li0Um6d/TiFs8GZ2BVDrZwiqP6ltS
         6c+a3nahBQLmL+U+AQzK/EOZv2lJBzW9JJUhiMgLyxYAvzA2E+S9oK3/Tfean8wku1a1
         MjtA==
X-Forwarded-Encrypted: i=1; AHgh+Rro8PwFX07hR0fSstBAQaMSmNAbc/7CRk13fAxz8pBRZrolKSyAmsyRn9q++RhPVPGs5vUOUspd2Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc90CdG2HH4FkghMQlUHLzyfbdk/EiGR2P2Sqvao9izIpQsLsP
	/dZKW4NouJ9Bocx+LwsAMuvmrFdXYrd0wH9hAAFkcn0HCj/gbj96vgoF
X-Gm-Gg: AR+sD13+yiEuK+o8JcUytyHIgmL83Xub3VZnOCV0D9zadxxsXD74iWDJLsJ/AOiPpcV
	9kz4+7YDqQ/AHR3LzSj6RgBQfPYJixE4lVMmrLgRrdLt/9EqWfmaGCXvE5oUwtjsXXRVWt+ISNl
	ti4abqnZrjdhuOEbLGq45F5WkQYcheUsv/XwTKdBY2YLmXB4lMolhZh+nJsItmpzjJ8CBHxYK6x
	Umg1RHNtPTueU3B1B12ERILNgRcNbZDHJz7PQT0M9HzF/Gdtvt+N08fexj817gqrd3F1IU+e+Nu
	tPVphW+NQK9ma4LV3x3ltxX84oKK2d9SnjoRZqqGmfV27sQNDpc796sfEzn4M2QEbR+M2tKBwYe
	LePO4TACkZhQgsrsM3QNHaGFC7K5iImGdBXuzx0mGtr9J8UkP4JQP/jCIH7Rm225gWDiFhT3Uor
	HL7hyf5QWqqXdosAJdEARSNCb3dqEDhQvEiMuw/MxyWPdyHtll9sHK
X-Received: by 2002:a05:600c:4444:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-4994e7d4057mr171030015e9.18.1786009502685;
        Thu, 06 Aug 2026 02:45:02 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e99b8b5sm76385095e9.2.2026.08.06.02.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:45:02 -0700 (PDT)
Date: Thu, 6 Aug 2026 10:46:13 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, David Lechner <dlechner@baylibre.com>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: am2315: add am2320 to i2c_device_id table
Message-ID: <anRXbXxTLUfUgEPd@nsa>
References: <20260805183733.1000550-1-nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805183733.1000550-1-nico.antinori.7@gmail.com>

On Wed, Aug 05, 2026 at 03:37:26PM -0300, Nicolás Antinori wrote:
> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
> communication protocol and measurement conversions.
> 
> Add the "am2320" entry to the i2c_device_id table.
> 
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
> ---

One minor comment from me (maybe Jonathan can tweak it while applying).
With that:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> Tested with Raspberry Pi 3b+
> 
> Used as reference AM2315 Datasheet [1] and AM2320 datasheet [2]
> 
> [1] https://cdn-shop.adafruit.com/datasheets/AM2315.pdf
> [2] https://cdn-shop.adafruit.com/product-files/3721/AM2320.pdf
> 
>  drivers/iio/humidity/Kconfig  | 4 ++--
>  drivers/iio/humidity/am2315.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 54f11f000b6f..6907805945f3 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -5,13 +5,13 @@
>  menu "Humidity sensors"
> 
>  config AM2315
> -	tristate "Aosong AM2315 relative humidity and temperature sensor"
> +	tristate "Aosong AM2315/AM2320 relative humidity and temperature sensor"
>  	depends on I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for the Aosong AM2315
> -	  relative humidity and ambient temperature sensor.
> +	  and AM2320 relative humidity and ambient temperature sensors.

The above (same on the tristate title) does not really scale nicely and
we've seen too often already. So I use something like "... and similar
devices"

- Nuno Sá

> 
>  	  This driver can also be built as a module. If so, the module will
>  	  be called am2315.
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index f29baa251f9f..5bce5eec45cc 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Aosong AM2315 relative humidity and temperature
> + * Aosong AM2315/AM2320 relative humidity and temperature
>   *
>   * Copyright (c) 2016, Intel Corporation.
>   *
> @@ -251,6 +251,7 @@ static int am2315_probe(struct i2c_client *client)
> 
>  static const struct i2c_device_id am2315_i2c_id[] = {
>  	{ .name = "am2315" },
> +	{ .name = "am2320" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
> --
> 2.47.3
> 
