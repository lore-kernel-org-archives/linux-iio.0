Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A138E5DF
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316076; cv=none; b=Us0sOb6uuasokqPn9CvrrUTYMHA6ilHCnqm99rhcGD7tNtzKqYfBHEMVdBILooxGfaK3jFMZ44kuZmYPfaQzr2Y9kdaqyZVgBlnRYniQkK3Djc7B8ueIfZ4HIWYDCkpBapN9nA4jmpZixQzDblLB8AXC6GRGOhAN0+7lFAY7ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316076; c=relaxed/simple;
	bh=7NVYnCMvS/7X3T3G89maX0Gdoroi3w8DAJG4EMNUKLk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iF5xrapUN6uR1wZBQgW2b4zihWCurAy6hp56v3nITrf56QC36R+BWw9wq7+uJNoe/7msv7LZGhvlC21lC6Dsagg2tTIgHcHuDECMK/36sUXwQfnYtwzkPhbl7NHZ3na46uw06KSG35yNSahBmk+H2R/UebPjeoKgKzWU/eo272I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYv6RUfb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYv6RUfb"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso25734675e9.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778316073; x=1778920873; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CgQX5/FDdpguyCea7DnUd7QUmiY5RWdQxW1ZkTMJo1E=;
        b=MYv6RUfb3OWzv1bChKsymL8cVLtd/31NU+x7+YVr9nGWa40Ey7TWIyY2MVmlPmVgj+
         gv4nmsy5ioo/OeLMduDkMel1SMwsfe6pt4RlzSvOD4JAes/u2PpNix3dcnjq5kw2kt5+
         v3cQcZOxRTA2PPhmZIJPBJi4WI0Z6iR7kJAaL177imD+lF04ayhzXjjcddSAmlA80w+h
         eD8FJWw6TMtvmov5uKE3rhSM61lzMKmnVuR2ZC5h5i65hf0kmav6ogD6xQqbopVxl07e
         iifwI30X7rGFWCgYK+KP8mkLN536vqF1g6Igv7OOqyW7/gnoizWUecE7PXg3WcVntuS9
         qWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778316073; x=1778920873;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgQX5/FDdpguyCea7DnUd7QUmiY5RWdQxW1ZkTMJo1E=;
        b=ebI1NBZEZ+rfTG0xidRvd4U/KRWtbLS7iuwSMqOTUS9IhA4ZwX+qBmPJGgXxFdOY6s
         XLWa3BaA1q0wh9w5E/D0+XhTuH0JnpXaoegEBfj6wiRrkYaAIPCrYnfHz3OZDbHfXH45
         iA76dNZrNgpIyiViIlhCzvSoselPCc51xNzE9yg+eAPKOX8KXfwZ9/Dab20bz/hLwhpC
         gtWbOd5txU1ht0/prSCNq/yVqPevYBbLOgCh6+I+5d8R/oPbtXWaAQ3ZI53P/X5Boj2h
         tIKLY+OPj3xhfMC8f3Xw/vj8juFc3DcnADBghXzYQqlMmLw4fH/P+Jhxtb7Qgnp29mP3
         qOAA==
X-Forwarded-Encrypted: i=1; AFNElJ/Gg2eugTU53ooG42gQ+puUAmQXQ4goIINnj3jpDbyAc973Mty+pFZ7wVKq07zqW/k5IFFKI4zSWUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfqW92rL7IErhox9JU7QMI5Ihj4CcmLw67Ce0SM5XD42qaHAp
	dcKLytxuCuQ/fJiRAsLqGnTfihYOc/Yryf5dKNxLCJIGkLEIEGm6MOig
X-Gm-Gg: AeBDieuBkHRwJu798u+5sjGA7VYWRSJfXlHT3gVVncsgYbm2Po41oWlQmYCUzQPh1fo
	xVLYmlsOSQwSGrSZJ3Usl5SXgask0D2Dmy76JvOo8YAE7lXSDBIu79dr5vWAWZUUC9uGVhML13m
	HL2AGhVtxy6aiJQuQM6UGqklMG2IqHqpIDHwU+TahSapOAGP5QEWTdlkxBSywwUqfalNorY0yTI
	R8fyHWMI/RLDV/e6eNbGkwoEBCyUOcLFmoHSjhuqjSTA3s+ya8vTl/Cy9z/k8t3jb6D+qvVxGO/
	XnTvtD0uRCoe643J+EW8rT6p/eVr2NHxwx+K0MPW+AdI5JcmXmSZPiUYuMV6jhFGySQn61f52Hh
	qm5ud3ebZMD9xfHm9qgTveYXabu/mgxU2w6ijEGgqDu7DFYhTUcdvPKfvrCuL/9KbHGkDynKbPx
	lOADqZEUKa79jY0dayRRSkavfCTfaNil+6FsqvyDgcRWIEmU61B6AG4RVQ24E/S/ukHB8FiAY6b
	w==
X-Received: by 2002:a05:600c:17c3:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48e70687ec7mr13078515e9.1.1778316072356;
        Sat, 09 May 2026 01:41:12 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db0b08asm24056555e9.8.2026.05.09.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:41:11 -0700 (PDT)
Message-ID: <a0d363994bc55ef2b4c3c5c70b0cd91e94acaeef.camel@gmail.com>
Subject: Re: [PATCH] staging: iio: addac: adt7316: check SPI write errors in
 probe
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>, linux-iio@vger.kernel.org, Jonathan
 Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, 	linux-staging@lists.linux.dev
Date: Sat, 09 May 2026 09:42:12 +0100
In-Reply-To: <20260509082636.85114-1-dennylin0707@gmail.com>
References: <20260509082636.85114-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-05-09 at 08:26 +0000, Hungyu Lin wrote:
> The probe function issues three SPI writes to switch the device
> from the default I2C protocol to SPI protocol, but ignores their
> return values.
>=20
> Add error checking and emit a warning if any of these writes fail,
> to improve error visibility without changing existing behavior.
>=20
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---

Hi Hungyu,

Small comment from me. With that addressed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/staging/iio/addac/adt7316-spi.c | 9 ++++++---
> =C2=A01 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c
> b/drivers/staging/iio/addac/adt7316-spi.c
> index f91325d11394..25b7772bd05f 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -98,6 +98,7 @@ static int adt7316_spi_probe(struct spi_device *spi_dev=
)
> =C2=A0		.multi_read =3D adt7316_spi_multi_read,
> =C2=A0		.multi_write =3D adt7316_spi_multi_write,
> =C2=A0	};
> +	int i, ret;
> =C2=A0
> =C2=A0	/* don't exceed max specified SPI CLK frequency */
> =C2=A0	if (spi_dev->max_speed_hz > ADT7316_SPI_MAX_FREQ_HZ) {
> @@ -107,9 +108,11 @@ static int adt7316_spi_probe(struct spi_device *spi_=
dev)
> =C2=A0	}
> =C2=A0
> =C2=A0	/* switch from default I2C protocol to SPI protocol */
> -	adt7316_spi_write(spi_dev, 0, 0);
> -	adt7316_spi_write(spi_dev, 0, 0);
> -	adt7316_spi_write(spi_dev, 0, 0);
> +	for (i =3D 0; i < 3; i++) {
> +		ret =3D adt7316_spi_write(spi_dev, 0, 0);
> +		if (ret)
> +			dev_warn(&spi_dev->dev, "SPI init write %d failed: %d\n",
> i, ret);
> +	}

Hmm this is a bit useless no :)? Agree we should check for error codes but =
we should
bail in case of errors. You can also mention the loop() introduction. =20

- Nuno S=C3=A1
> =C2=A0
> =C2=A0	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
> =C2=A0}
