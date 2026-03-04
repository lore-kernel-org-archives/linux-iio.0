Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1B38424E
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624644; cv=none; b=Ebn9X6Ob92iFAZh81mlEFcYuPbtT1oRgNF+NJLaX1x6DdLH/tYWTQzr9XUDkpJujA2wEtiJY2XE9wZ2z6Kr0lWTQrcqa5ZEwl8pPspdD6U1Iw6o/Wcg2bwziNW0vbY8taBuzJC3zXB4O6bsVCgws4EY/q+YmIlJWNB5QoARU+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624644; c=relaxed/simple;
	bh=xzsn6k2b/PVPth62pltSdIi+Q9LNbG6H/NU4wHnKMsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtwkH30XYjPuOR3Ky1qn79y6w7MtTqV1+p2sck2PXk5itFCBscq0ZRZWi+XqWkjNWck+2ux094p5nu3oEVyjt5DlaWwxYS9tUokXY8t+4e6vQenFjkGMsD+l26AWszTEsYJxdWezPKvanjWtEOVNgYhQEtBbG9LVtN5MCMaX/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjHPwwGB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjHPwwGB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso2465364f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 03:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772624641; x=1773229441; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aakhmee/raU7jdKZ9tPN3MemCiopLrjwJ8yjHuKYiX4=;
        b=JjHPwwGBMnMSo3dY3gjWpZBoElU8eS0vkwrnKIIEPLtL9V3UljCZL1IT+pbmIJ5ezf
         nN7JGMxsU1lkgUIO1Y98zE9d0dOTakGTihPNVRCHte/KNrKO4z9Zu6FLYP963MxAffZr
         +XvSfUNYFZrePOJrTK5ywPj6yV6LbYyxn4mYR0Z/bqtZJ+k6T3GyLMfGgLMx/cLzEkUg
         y0DIHxnVeZ7zrpt6uPCVCg8cZ8s5LjB6PYuVMKE3RnwDaXgMP89cfKWpHrIe+b0dz9W1
         8f6S/3PCWz+i1xkxD45ML7gxd1HFCTMoSZS0PQUJmup4YXpt5j2DSM082ZBuoIxl7vj3
         VpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624641; x=1773229441;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aakhmee/raU7jdKZ9tPN3MemCiopLrjwJ8yjHuKYiX4=;
        b=YntpmeQOfoDphpaJDSREYyHMk8Cfjc68dMnsEGoL8kNaMiKkzDxX8TBcxiZyyIGwWm
         QISiDx+OBBzmW7+uODKINEa74OTen3BMxD0b2xDt9jnadktPFK/byA3JvLraOnm5Ez5Y
         E+10L/rXTWj0Ha8dCWZ3Lt1n+V6k5bEmjZ60nYwUO4Gm4Zsv+ZcXkOkG7ygRx6BoRLLv
         T5VgnxtxXzEWilGtgHKOyjrRQfNwgC6Wj+UfTx1MeFSxrUxvYfwjGiVSCYOsyB91YAij
         JhqD4dYUA++8EGd/3eK+LsVtGL3xLUjD1AkXVXwHkLa0pke8vb9t0ghkmjfy0DdRyWg6
         +EaA==
X-Forwarded-Encrypted: i=1; AJvYcCV8MySNLqLNI9G2efgpmaYGJPbAFCozwy3ejqDYy1pUEEwk7eIvzDwlqIvPDv5PH9AUqBTZqgTOeCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqpdsX4rTmi8fk+leRtEFCoH1N0DEfuSn2w+PvqxWSrD6V2gU
	CnvYN+TrITK6Wd6UeqoEkThb+eG7wBQgxZf/slNYVpzlvy3e+aoIxv68
X-Gm-Gg: ATEYQzwEPWHOOAUudBwbeePnjEanEvRmOxJuwV7vqmcaqNGZkIDpLJ1pfBVphvHL4hn
	lL2hstBDKEagyXAwDfp5m9QbJeyPWFyuctr+dWOTTXHG1rlojVeHD8YBwoXe2/n2nVlkcmNOzPT
	DKsryUQNUQQSbR3Vj06w/MenSEUGT7ZMPppbx1sBEVxKMBRyWyk3iA1AnOaEBKsyNXhfo9dZVT2
	gl8Nq1Gg1WfkhlJumjSp35ctt/rfK2TmzS/cogXTAXajCfLVunhTh297xwnr3nSaBnLzEJC0Bup
	FK36BRF9zGIOG9bH5X7s8xXaJcY7hmT4wCjnM54GeUM8LmPSXkFYj5XPINIwhjr3VTwmDzy2K50
	INcDab/bk0GhZoSlhiZWVNNGs1JqPs8bUJhw9PfA389CCi9QFD8uH5F0T2Aul1hetIhOKG4IKMz
	ui3B3xh14JFP6YIMiMeoN8CEqa56gDdkw=
X-Received: by 2002:a05:6000:4381:b0:439:b3d2:376c with SMTP id ffacd0b85a97d-439c7f8f93emr3259733f8f.12.1772624641267;
        Wed, 04 Mar 2026 03:44:01 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b03db76bsm27413229f8f.18.2026.03.04.03.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:44:00 -0800 (PST)
Message-ID: <31e0d644f251ae29063ef5575fcb851034ab6fd5.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: no devm for nvmem_cell_get
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rosen Penev <rosenp@gmail.com>, linux-iio@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Nicolas Ferre	 <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, "moderated list:ARM/Microchip (AT91) SoC
 support"	 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Wed, 04 Mar 2026 11:44:45 +0000
In-Reply-To: <20260304041843.7709-1-rosenp@gmail.com>
References: <20260304041843.7709-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 20:18 -0800, Rosen Penev wrote:
> There is absolutely no reason to pospone cleanup of this post driver
> removal. Just do it immediately.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

I guess we do not have that many users for nvmem_cell_get(), otherwise a ne=
w __free(nvmem_cell)
could make sense. Anyways not related:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sa=
ma5d2_adc.c
> index 69bb49434f90..255970b2e747 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2259,7 +2259,7 @@ static int at91_adc_temp_sensor_init(struct at91_ad=
c_state *st,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	/* Get the calibration data from NVMEM. */
> -	temp_calib =3D devm_nvmem_cell_get(dev, "temperature_calib");
> +	temp_calib =3D nvmem_cell_get(dev, "temperature_calib");
> =C2=A0	if (IS_ERR(temp_calib)) {
> =C2=A0		ret =3D PTR_ERR(temp_calib);
> =C2=A0		if (ret !=3D -ENOENT)
> @@ -2268,6 +2268,7 @@ static int at91_adc_temp_sensor_init(struct at91_ad=
c_state *st,
> =C2=A0	}
> =C2=A0
> =C2=A0	buf =3D nvmem_cell_read(temp_calib, &len);
> +	nvmem_cell_put(temp_calib);
> =C2=A0	if (IS_ERR(buf)) {
> =C2=A0		dev_err(dev, "Failed to read calibration data!\n");
> =C2=A0		return PTR_ERR(buf);
