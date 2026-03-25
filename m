Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BC309EE9
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481457; cv=none; b=KdnMjdzrUrS52luQmAFmL9BA8OQZAx3aTKHMIrWKRVdr/IjTfUbo3nvV5HcQyhDdY/lD2DF9SKgUdaK9jZ7+QPg9NYXrUVTdT1C4iHzuVMr03ZbiKAPmIOqpCLBuUA+ZnQ0ZjZvovHFfUtilfl65gEVnoQgtKWLQK5ixkulgUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481457; c=relaxed/simple;
	bh=GLgjZTYAiGPmZk3aW+sxsL0sZLEEvj5nDn1961lwb38=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=iFcBoiMUs3IFeeVD8jQZmYVkJyFt8UmqRbPm7v+cMh4zwxTYofJuRY+nEuCwq5qZeGqnmJLBeVMG4dRgZ1E/Ybcdxv/SpHOFfQZyPD6f3yHoElnwyACowOR5kmvWWFirFbgGVQuuIg9l8bzBdZZ1S/S/C2JcGaXTx/x+hIVicf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/aWXa+C; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/aWXa+C"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35bb9070644so206877a91.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774481455; x=1775086255; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRCqKHMtl0iVnbVQf6Y3jSGnNuL7QXQdXj+7zDfNdfg=;
        b=N/aWXa+CUVcGT+imekArRt5Ml4WcNmy+vVzAlO+tuMrkrwDh38LegITD8P+HHsSJKh
         UqHseu25TfFCS+dI1wyEcU13Ki+pNvFpP9YcT9GSIOrhaBXSJfXYjGw+ELmfp7qNcixl
         jiT+pVLMpWLr9/Q10M444+om5/yzfH/39bVHTforeU9s/gM7msPB+FHYpbMK0WvrEy/C
         gzCeKRYM8IAmjGssqB/9aZ4H2KGS5eZ46SnUCWnMJEajFvWSrnXUnZ0xSXW/8gqvU9eS
         XdH5cFhwzuthLMDJ58sKM3QWPDoB5bAB2sMLvIAZi8FjL7zaK1ZfnfaK7fkTAHmHv8Xd
         BXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774481455; x=1775086255;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRCqKHMtl0iVnbVQf6Y3jSGnNuL7QXQdXj+7zDfNdfg=;
        b=EHNhQ+wUD+cLbXfYcUpEVAr+Fszsqs1g0f6Gm4weL1gssB990tCMg/6+gY0v4SpYXZ
         PqAg7h0dew05Q9pAFcR6OS/um6CihFUTI6+9PMeopMBqL1gTJyYJ/5dyCLyR+pP8IEYl
         ny4og7d77VB2BiPE2RKz8QgVJIvBWY1oZA6ZMT60lpQNcHAwFRwi0D8Dxst6aDO83xpz
         bQgjl2O484vVTfUXoXhRrVXNkVaNWAiVBgmTIMPgggmC/dlqtl862yQb8xTQS+Kl+9sN
         oGwQEdUyGyHhiPBURBeZCqYcnTzXpGBABDXKJ+2oZHCcmmSr4ocYQC4O2Z3uIOAWNp7M
         yEhQ==
X-Gm-Message-State: AOJu0Yz27g/tR4dlIjx1hHZ8TSx8peYdoDCKy0L85lwYedy9xM+hY6rN
	Qof7uIo5LugvirKMQbsPRC7+v3xBTRib1Jo39Yk1H3WwulZ4oD/Zf2ic
X-Gm-Gg: ATEYQzw4cq38NXqh3WOemu0wQ/wCLnBd8nF45c/HCCrU00iXYzCRfEZSqJxs+2Yq/ut
	N75iwEE/VqvPyimFduygPKdV5eK/ptF3lE4mXcGmkIkiiPcC86+wbsIduxdiWly7/NG0dyz2zZE
	3qLpd+rpB7KQL7aaKM2qDAc2qldUIDmpG4YErglBuNKui6QnaRcb84fAjrd091DsuWVZbX/imFy
	CGLwxpEmSbEufUrCkug3UG/HPeWuZfmUOXI4Tbn1LMNlSe1gTtK6FKLBxTgBon6rsAw0E3Ij5kb
	iiZsyHMUNkax5+OUXp5AEfVYIeTMzdIL0GyRJ80StzERqNkHdv+3fAmFi59fa8edSkzH4xtrL/S
	UuJoXfTFjhuWJXebRIrZmeQ69EyPs6xQZNbkX3cwrNOpXJuWb1BGImDNuG8JC1M5Ht5TaH/9qQn
	ASm1yF043g7/9B7eDGjgj/xMNqRnhQXSIUZu8FjdW3dvZ0s7c=
X-Received: by 2002:a17:90a:e7d2:b0:359:96f7:a016 with SMTP id 98e67ed59e1d1-35c0ddc1a19mr4589278a91.33.1774481455306;
        Wed, 25 Mar 2026 16:30:55 -0700 (PDT)
Received: from localhost ([2001:8004:d00:d06a:89ef:cb1d:7260:2002])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76737f402fsm506376a12.2.2026.03.25.16.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 16:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 10:30:46 +1100
Message-Id: <DHC96AXSNFEZ.121C1XIAZNAMZ@gmail.com>
Subject: Re: [PATCH] iio: light: veml6070: fix veml6070_read() return value
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>
To: "Aldo Conte" <aldocontelk@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20260325113216.170357-1-aldocontelk@gmail.com>
In-Reply-To: <20260325113216.170357-1-aldocontelk@gmail.com>

Hi Aldo,

On Wed Mar 25, 2026 at 10:32 PM AEDT, Aldo Conte wrote:
> veml6070_read() computes the sensor value in ret but
> returns 0 instead of the actual result. This causes
> veml6070_read_raw() to always report 0.
>
> Return the computed value instead of 0.
>
> Running make W=3D1 returns no errors. I was unable
> to test the patch because I do not have the hardware.
> Found by code inspection.
>

The fix is correct, but not the commit it addresses.
This bug was introduced when the guard to handle the mutex was added.

It should be:

Fixes: fc38525135dd ("iio: light: veml6070: use guard to handle mutex")

> Fixes: bb18885ed823 ("iio: light: veml6070: add support for integration t=
ime")
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> ---
>  drivers/iio/light/veml6070.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index 6d4483c85f30..74d7246e5225 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
>  	if (ret < 0)
>  		return ret;
>
> -	ret =3D (msb << 8) | lsb;
> -
> -	return 0;
> +	return (msb << 8) | lsb;
>  }
>
>  static const struct iio_chan_spec veml6070_channels[] =3D {

Best regards,
Javier
