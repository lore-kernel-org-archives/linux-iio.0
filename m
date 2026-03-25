Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639519E7F7
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441845; cv=none; b=V+fIT+RJRjx9OKbjWp9zLxTC1uePKFIJorV23Ejrwr20kHq75npUYNilItdP9u7LYnj7yQIduALtZOYMWbazufuRXUD7EXEgsPUf8KujcggsFPsjWz+GOMyWguljHdelCUlDB0/uKgg2eIr0n4BxGUKExhj8Ejqrq9CsIQBL32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441845; c=relaxed/simple;
	bh=eW8kpaempfoOD2PkQU4ZCS5kv+yUGMeXcQOzVD1ag18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fngrW9431EiD6sj9tHXtaGDhmqFAESoy+a+R57YmHUwm7hQo1DaI/IpWsDAGUJjemZTob5oNNx/PeOB/jUhCVgFzkgUo2UaU6oeNpN8B4xtRvLQ8QH5EH7cKCA1CCH7oCho10MuHd4x8jnJGExwaeBduPocJQBG4sIg+ULUe6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0/AknVX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0/AknVX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fb112c09so45107845e9.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774441843; x=1775046643; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AUT5pxZXZKBVWVTz66dzQVLCyUuxaud/nyfeqc23uAs=;
        b=n0/AknVXuSpI2SNPr4J7342FmwqKdO5TBkQj8GVGsk/0lXMzEyLgNqp0WsQJCbyi93
         4fFcrh8eNJ1gEwifFNLDODWkoeuxkW3+kJHwX4YoX9dfB0BW+A+UeEELH4GTtPAt2K5H
         4NB+vNjiWXAHDkTNkOF+6/BLkS2eUaV4M9uB6er4WhwB8+5kB9S1i1sZiYLxH7xn6do8
         EOlo8YNCANF1rN8GAYaFhO05YTaOibTMSd23k0oxlhHGu2cCRacXOaSDZFFGxYVZkfjl
         5564ob5F1yzdLPhfq3H6IJ343lVbDO+bI7rn+OOaJ2KZcFwXl8gissPEKKsDlVb0Tg6b
         P8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774441843; x=1775046643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUT5pxZXZKBVWVTz66dzQVLCyUuxaud/nyfeqc23uAs=;
        b=mG+WMq6HKI7mm8IjragR/RnP50hOdMPNAqcO7jJ1v7xkIZlm//dVxJibeI3nH/Qi4X
         twvgti26Q2iS4kyb+0tOsy83WpZH6qzoKlm2LPwaO9KJJ3I1wEtdvr+D7uNV5PL3DRJC
         JqHy3F4/8sRdJ3pX/lnxq0ujxz6mSIqk5VYDozd8yvxUAAGMgp4QMIbZmPRAFloI+EIU
         kdkVgW/fQMwvXbz2wBfu/qjDCHIciPpYjEortM+DrGb/q5Df0Rlayc7vFkxTj88H7pVM
         uj6UD6IgBDlhYCvtvLvYxSvDH24u87ovnzZ37mLTbhmnbnfb1PGBGxQRWU3iKBZ88ZNI
         +5Mg==
X-Gm-Message-State: AOJu0YzPjfH5K3o2RjR6rGMBu+Ritls8NzRSR6N/arh+M2dWPPrS3UtA
	xxn1siktwikgpuPmrsQMQrEiSJR/43wu4lYd9CFyNq32G99NL3Bt3fJM
X-Gm-Gg: ATEYQzzyWtX26jGw8xzbDFDcyZmTuiPjErnD8R4Fp9BL7KRssxhmcbEuK05WmZP7g+l
	RCUB2dHJNJ2pWTMRxsHTBRpaRXwHuPajfYuyhk5gIBzievfSVkhgjvIUg5i2MLym2JcbpmfPbAQ
	7tTdjI9wPtNkPWf9E/In8xJ0W0uyxlf2rDNCTRWHiigQ+eTOR3rU0VpRu4Ekdkwe8BdZC0A0fCs
	mmC/4uR3vuoRZBec7zi2Gld11Hk8TomzluraH61qanE85wzeCQjD/OsTuvsqR+lJhJOzDY/8tsa
	rjoAwODJofsF27pxa0tj/C2fsMMIPl4ZdlTcIbBj9z7HZNJmIwB2f+38EssUlGYquSOBWbEstiO
	lHfW21YK7pIv4fROEfqCk7giy3JosiV0iBT89oCYsG3VL15K1vvBoj3f+JzPx4yjy4lc1oY0WUe
	Wh1wggD870pZXlxbSYlke98rHpbZZ7P1764fSf+whMDQ==
X-Received: by 2002:a05:600c:4705:b0:486:fc4a:2951 with SMTP id 5b1f17b1804b1-48716083231mr51669045e9.28.1774441842471;
        Wed, 25 Mar 2026 05:30:42 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ac0a8sm223803905e9.6.2026.03.25.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:30:42 -0700 (PDT)
Message-ID: <510e9313c229341f963508ca480ef6e5c5342b75.camel@gmail.com>
Subject: Re: [PATCH] iio: light: veml6070: fix veml6070_read() return value
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Aldo Conte <aldocontelk@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Mar 2026 12:31:29 +0000
In-Reply-To: <20260325113216.170357-1-aldocontelk@gmail.com>
References: <20260325113216.170357-1-aldocontelk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-25 at 12:32 +0100, Aldo Conte wrote:
> veml6070_read() computes the sensor value in ret but
> returns 0 instead of the actual result. This causes
> veml6070_read_raw() to always report 0.
>=20
> Return the computed value instead of 0.
>=20
> Running make W=3D1 returns no errors. I was unable
> to test the patch because I do not have the hardware.
> Found by code inspection.
>=20
> Fixes: bb18885ed823 ("iio: light: veml6070: add support for integration t=
ime")
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> ---

Makes sense...

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/light/veml6070.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index 6d4483c85f30..74d7246e5225 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D (msb << 8) | lsb;
> -
> -	return 0;
> +	return (msb << 8) | lsb;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct iio_chan_spec veml6070_channels[] =3D {
