Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEE355819
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401225; cv=pass; b=EsIGKBGnGb3+X3q7RimnwAApf/x7hHYd+0tUtTqjblk7Cyq9M/bNwdUTj2orrsw9aa+aA9Ldn1dmg05P/ZEnANm8nhkE3N0kSh2vF3HiBi8GJD6xNtiAusvTjCfV0C3WR6JczjaAAdKtW8IB8dLe7V9fKMqEjb0QqIjzKpejUaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401225; c=relaxed/simple;
	bh=226qSkdwAuGxE3RyDwqiSlo2IOVonGu8uER8+95vIoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZSyEEoGQKXDa8Pplik8S/cLDqATiQLsygmnnF8//ocy2dXlQU9nimlogRur4i+Fhc/+8Jl5xVfYYUz86iRDwx9Y6yHYW9pYMqY+p/7g32Ywch3M2QpRLhv4BAQA+0/xw2fDFtUve/aFy3fA4xpZJV/DI8E8v2zYtZmQpMPtuxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA4kgix3; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA4kgix3"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c7a459105so3718994d50.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778401223; cv=none;
        d=google.com; s=arc-20240605;
        b=dRbylBbn/bpGJI3UCUO2jr9jz2pfXMgM1ZkcRm5vC9t1B+kYQnWl6U4ZHhhRNTlMMk
         tDAfn6j9yx/G4D0dYmANDAcEBULVifpaeJpRoP/uJOLK0HbpKaDWthfHoNDBopXh9/iZ
         SE19ZTbBxumIabVva8F6a76Ti6uIONkMmwTtYPvQSTgmTkY7G03gCV2c5JeK6LfKyJxj
         O8RNh6xNsJ4Dhvk2UjMpCQ5MzdTSXStj4e9VuJQPTboEh3Z2w/BEv+4wEEDnOoQ/cDaR
         pKWa97nApX4EaDfDHgw/X4uzyaHW6d1lon6b5kPVDkcP7l9YZSG0xtpxF/O4lhD2rGQ/
         Y19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gCbOhGmC2ASoNRhJ45rrQzr1riSuWbHWDX3kRpzdSDY=;
        fh=r54VM6lzANzHsormtk/jr6G1wyLoalYR16ezjCYLIJI=;
        b=iDOkAHZbnWfvx6Zu0Amk45i0lmjxYqeCXNMC7EtnZv+yO/jsbK1h0btt06eWJY37ww
         djXDm0QRCfg9ZEZBMI/zm74ICxpYASZDtLEpRiSqYsqUTDQAS9L9PWgsMnB6n8gd90rj
         KywSmBhmDO5tOXEk0S7fZVw9XaxI/Z8KHJfOk4hnUtudNx/hUSVm316myJo2IHi5tlN6
         k1lT+g/J2/+FE+RGEB2jXaSOjDs/9B3ySLFY+XOLCgwMzOefP/F0WejKN9Hmx/WRHyMH
         oxoAJmz/Z4d2WbOCFmY3Gujf4FxxnU2x+3js5VvYWhooV0oqZR91Mt4IhGGCa63Vrfue
         gzfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401223; x=1779006023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCbOhGmC2ASoNRhJ45rrQzr1riSuWbHWDX3kRpzdSDY=;
        b=KA4kgix3oETEjXp6bGC86im8pCdCtwbLzaRxdgdnQLzpHMugrx73YdR9JGt6GZIS4v
         PnHldFA+ZRYVkdWpOFZuwUk5lWDXG5+2krFGxxWvGWP6IpCHpI+PQGk2JSTgzsFT5Kdk
         EYEs4h9/vm4q0yVyW6/SSb7VvceeTC2uTVOE8f0ji6sw0NkujYq4mPA2qufHsFlaXNOv
         I4fHz/g6ItnjCYgmCllqY6tjO83O4fXirBzVNQJPucN+B4UVz/5/rkyEIkcnzjH5Qg1E
         yPeboEEqLsrPQq55ClqMgEsThFlwIG969/ry1OTT6Qfxvtphl5iO0xLsf9E6qIadOniZ
         gC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401223; x=1779006023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCbOhGmC2ASoNRhJ45rrQzr1riSuWbHWDX3kRpzdSDY=;
        b=Dyug01V7BCU9bwpNMx7tWkWzpo4YsLY0zK7EpJxq5X2zWsso/HyzveXSQUQfBds7Jv
         2b3Hp2c11XF/giiR27pEuePFanJGtPyOn6rHzC0xI8Eedo0b42obIfmP21Z6SOzoYJF0
         upbyf58truIrfZLRJp82Gh0ZCq/Zj3lDW9NlRb4V5EQfzyQdBugfnA9noflNbFnLkxn4
         WvtamGE0Khs26I6k+sfOFsVXYrVljrT11PxNadIbWSBhUHV92xXwO34Y2nVI1WeZAi2y
         rfwJVT8ucaLK/DKDgiGz834YsEJQgMtZDnmslIL2huGNzodm1/CnSfHnDVRYR1VjXK9C
         gEDA==
X-Forwarded-Encrypted: i=1; AFNElJ+y6PVd1YIYU4cQw+1tSZaskRcFfM0aSwVsTwJ1blb+17EDMtGsmYMsDJhrDQXdahc8UlPaw7tU//Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRZkOW6ka6NZJ3O0ghQ5y5WPxNZ44EshEtRZXxarLNhr11VQV
	rpJaBOC2UxEh7Qy2Z4EydnKzXZfeC54h06aTADL3KWAf8iBFI53ZCCk+OelWQWpWHyJM8IE8y31
	WHeCI8X75aofb4HWKouqEZ34pzcAMW4U=
X-Gm-Gg: Acq92OFKyfxaIW1spHDxtzGbuVhwmSjVYtZHB1dciaSAJLVBD6q6gt5KDAMs6+DeTox
	kXdwzr7fiGFILXgJp5EYFdW1PaDhe9yEGbpgqZq4vyUBqsizBdEvI/jJr57LU0IcjDriqzmyYc4
	edezLsteWuzkQsmnx06tUFhqFV97bFHrESHTPortITQwYIk0e7A3RcKH2i5dw6bPeBg8+XjcXew
	FdfgKlBFScd+RAURfDEgHNnTB5OjIg7qpNn7K7KbNRjltz1QYOkhGqyGHiGUk13ILfYLh9V8LgY
	uTmr
X-Received: by 2002:a05:690e:d84:b0:657:a6a4:6ee2 with SMTP id
 956f58d0204a3-65d7e7000e8mr11017061d50.3.1778401223591; Sun, 10 May 2026
 01:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510081041.85880-1-dennylin0707@gmail.com>
In-Reply-To: <20260510081041.85880-1-dennylin0707@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 10 May 2026 03:20:12 -0500
X-Gm-Features: AVHnY4LpQ1hQb4HZvp8qOey_Vx13xFcgP7QYhhLIOenZ3Ym5fNoAtrTVgU_tL30
Message-ID: <CAKqfh0GECZgj5aQZhTq8y4myp62Q7uVXhwKHUD-K2Sq-KH6UJA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: addac: adt7316: document SPI interface
 switching sequence
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 3:11=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> The device powers up in I2C mode. Switching to SPI mode
> requires sending a sequence of SPI writes as described in
> the datasheet.
>
> During this sequence, the device may still be in I2C mode,
> so SPI transactions may not be recognized and can fail.
> Such errors are expected and are ignored.
>
> Add a comment to clarify this behavior.
>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
> Changes in v2:
> - Add datasheet reference
> - Add TL;DR note
>
>  drivers/staging/iio/addac/adt7316-spi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/ii=
o/addac/adt7316-spi.c
> index f91325d11394..980532b7fa1e 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -106,7 +106,17 @@ static int adt7316_spi_probe(struct spi_device *spi_=
dev)
>                 return -EINVAL;
>         }
>
> -       /* switch from default I2C protocol to SPI protocol */
> +       /*
> +        * The device powers up in I2C mode. Switching to SPI mode
> +        * requires sending a sequence of SPI writes as described in
> +        * the datasheet ("Serial Interface Selection" section).
> +        *
> +        * During this sequence, the device may still be in I2C mode,
> +        * so SPI transactions may not be recognized and can fail.
> +        * Such errors are expected and are ignored.
> +        *
> +        * TL;DR: Do not change this!
> +        */
>         adt7316_spi_write(spi_dev, 0, 0);
>         adt7316_spi_write(spi_dev, 0, 0);
>         adt7316_spi_write(spi_dev, 0, 0);
> --
> 2.34.1
>
>

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

but please, wait at least 24hrs before submitting a new version...

best regards,
max
