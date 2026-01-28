Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB932ED24
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600416; cv=none; b=sx6N9pZCUBzxnwYHFif1WcPID/eb1AN7rc+md0slhyA1oAT8pR9C93ovLEfmboTc+r1VCnA3MRHw29YtF2T1R1UGaFfDrrFjcAspHxQLtA0jUM098zMJ53FgjJKP99pzO21QM3hrOubwO1Wchaku2Z/dXisns0/RbkraRCC+pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600416; c=relaxed/simple;
	bh=KB+cTTZ2B/upxhJNZQuf6e9ml0y2/4jWR+djJXUwpqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQpfCRGwsR05HkDtDy8yPdbRxXPJSTWbIzOt5RpcvzRr+foKGmYiAVrnBUk9SOWnecEmFBEHMYFrRMSytnLTMTVHoC8osPOFe5xhzCy6VKlxwe2GIbSzQXdQk0ut6HSVRCjWhSt8iIcuRc95faZM/BWjmR6zFhtlbQdtoHs958Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pys07qyS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pys07qyS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso6998845e9.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 03:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769600413; x=1770205213; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vqRfd2vfHh4nYKD1extyhWwNfCg5ToGGBeU/+CUnFPM=;
        b=Pys07qySDJAJvNd2AJQ/VNpD71BF5GVT/dlynJWJ9AR9rda6UvzrfqE0+eFPlgZ6Vy
         jGKy4UsjjCHyK0uvG18Z9pNoGJN4VEOkAUknvBQgtw6Iubr/ZWhDK6XHOu/3TkUuKcVS
         iiypkb+ifoXG2HfyLwDGtTCZVjvqNSFoeHXx8u10ifPcURYOj5fQhq9JZzjlJlEwSoRI
         MJZQph8mt357UpH28e5tlb43ceDqHaMN/GO+Bc6y8S0cEpny4LawhbaU2AgC9htK95Kp
         4EOhOqt334N+uKLotem/+a3SkvF2zrakRfiSjHv5U/C1O0hitsVkqV5BYswISDUh58sD
         ChoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600413; x=1770205213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqRfd2vfHh4nYKD1extyhWwNfCg5ToGGBeU/+CUnFPM=;
        b=M6HUqOp0BdqDn8diqo1LqzflDfCUIZ+/MbtiSjwhQjFPUCSnDXwXdvKPia9TU3vWCa
         X67JVBHendk4U+xxDFPMVsih6peau6YTaq3QM0ovJ5Fa3xYmUmOrbKGXdW0QXOgdZZw1
         XJb1m6M5QPhxKK6Do6QTY31ln7glLaJtNP3nt7eMsL24EuIzBdjm4NY0LNRaUV8fmIiF
         JvEnLmC0ERvs+O43g+NPSxl4fN03rs5ed3uCDAeTtq0cKtho0Xl5FNZESnXSngV27K+y
         YPXuGgJ2J5m3dZq6o59wo/d+kp+hskio1cZrYZ91fyJWmPSIgQMmQmrCKFpQUgYIN9Af
         ls1g==
X-Forwarded-Encrypted: i=1; AJvYcCV5zz2Br9MnPgBduREUUqTVaEV3cGigON71z7XKwNRWPKa7t+/JJpKSnR77kUdo4IWPnMabvjOM12U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2f9vw+p2LYl2QduMvGMSncmxCNHBVuweOCugLd+gacoJ4k5K1
	wpglkIpchjTSntcPtUlUbw8eWC41EgW+yrtH9Vud2R2dT5c2TMLA91mg
X-Gm-Gg: AZuq6aK9AxKcPm8RD7fMcYspVfaXyKYWMYWIo1MDw7sI8vBkQVFQ9JWMeJ2UJAk2PyS
	AtqdEisRG9NQcp6aaQ9ZUP1IEK0kT/TsJZAmiypPHiF3/ZNAaPkpIWw1Ue7mkW9tWeyyzAEQCW+
	QnroVTHAk9CSz6j1L/fTYxOUWK55tWuCigHWyfR7fFm0G0i37Qwbd8yFD8r6CLj7MXa8QzWN5tv
	9IqRYYxGEEKyEstmQKP8iPxdGebrauW7atHyzrArZV1eBbcrgfMZGJNAJ6aeXM2ORowfMNaaQrQ
	LDy+EI4/SzJYWjQlyLKFfLaqeJ0UXQAYBbSuGUUG/ap1bl36HAtapqwUrqn73wEN1Ssd/P4gdCM
	EDybFXK1oq8Yyb6zwulH/xjjGgtlhCGcxgb9uzM5HIwCDh28x6f0SUOsg/u7WtW/BEoPPdQbLGH
	fzTzE967m2H7vR6i4Fic/66j/EVbTVTA==
X-Received: by 2002:a05:600c:4448:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-48069e9b5dbmr70565845e9.17.1769600412962;
        Wed, 28 Jan 2026 03:40:12 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e2e50ccsm4732965e9.17.2026.01.28.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:40:12 -0800 (PST)
Message-ID: <91aafb3174ca943e240dd8164f27080eab085e29.camel@gmail.com>
Subject: Re: [PATCH 20/21] iio: magnetometer: Remove IRQF_ONESHOT
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org
Date: Wed, 28 Jan 2026 11:40:56 +0000
In-Reply-To: <20260123113708.416727-21-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
	 <20260123113708.416727-21-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-23 at 12:37 +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> The force-threading functionality is required on PREEMPT_RT because the
> handler is using locks with can sleep on PREEMPT_RT.
>=20
> Remove IRQF_ONESHOT from irqflags.
>=20
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index 3fd0171e5d69b..d30315ad85ded 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -581,7 +581,7 @@ static int ak8975_setup_irq(struct ak8975_data *data)
> =C2=A0		irq =3D gpiod_to_irq(data->eoc_gpiod);
> =C2=A0
> =C2=A0	rc =3D devm_request_irq(&client->dev, irq, ak8975_irq_handler,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(&client->dev), data);
> =C2=A0	if (rc < 0) {
> =C2=A0		dev_err(&client->dev, "irq %d request failed: %d\n", irq, rc);
