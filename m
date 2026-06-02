Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D097349CDE
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417654; cv=none; b=CZy7KWBhRHKcd1ell5Omc40FDUW34Xg9tyld+uKd4d5qdegKE2NrdS55Qhu7v2erzzjkRnJl5TBhiBaydxMTezY2Ix7qIZ2TkaW8TOQYp2ipkhFpxUl3DYOFxFfraid/8PA8eJKikDXCDoCrLOqrSNSiSYjUINXXhIha1autK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417654; c=relaxed/simple;
	bh=+yN8p7DEGsSd+vBoTiX9Ys6DjfKuoshdY9jKOrkSVQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TYeqDeWSOFNUradm/yxWFoWjUAz9/mLcm2NpJpW0UMeJqYmQD3dfFwMtPahPr3Qhk75GshQWcrQaP9av66tXCJV5YxrpQ5+diWqQqG9DLan4hzWJQyY4Y+qLX9AuG5FDHAA8VeqidCtQ/wNDLKkFuvyaPYmhtIldkuiKoaHFYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUEdx/PG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUEdx/PG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b3e03939so5839825e9.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780417652; x=1781022452; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rqHvtwA/FbTxVrNzgAP/DUfo1ysapu0skhzyjdpfojQ=;
        b=IUEdx/PGCsFUDFyJ0lyrfhzepSyxJCTey0aJObNXFjbln81s3pumN13WvRRdTVsPLl
         FdBbPjZqHQc25msWsZhcQfvwj+qQS/o3v1zv6cqv3UI/hE9IvgCfaR7wes3P+lkEABeI
         y+ag2Eke4P1fVJoExW/cby7BRZnqGg/EdEORLWBIJ0AcrJGBJ+6pvFJYWDW/mx8uKxPM
         VbRGMSz0QL9cb+WQ52xLPF+85f1o3s+ccL+qZ00t+TjuWHdqWVcm0oZR/nV+WxOZKx5H
         Zn+/OhAHqdMIGFgb9A35xB0niYDEk6eOIzsHG5MDCBWPbedbTbgL7c4xFf/FQRGItazi
         5/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780417652; x=1781022452;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqHvtwA/FbTxVrNzgAP/DUfo1ysapu0skhzyjdpfojQ=;
        b=VlmVm+GCo8RZg4Q2pV4trix27rWIQvN+9uGXaKjJqebY3hR0sb4BaOQfZaJ3DAp+rS
         vnket/IMCp5h1clcxhnveiujzCaPcvTHg0S9bvT+mjeleKfIOpo7W0ykgmpIdaBwywor
         2pZ8ldXRp6mtAMFgU/HzpOw0APd/Dd18vcHDJXKKd4JdwH/DQJhUzebmOmyvVgWXH0Xx
         cabMJYR2BbbHPMfmOpS1gOI0t5dfi0TzXZ8muk0oZ2usu1/gEbGTrJtAg0Z9uryQjzQZ
         MBZYjcqzE+PBQBR2Q7MBau3p0L/FeFw1zlNAJns1rIY0Oj4lOCNCyP/wydt3RJGF8zet
         EBmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BykRWR0PsvPvU8rUOQHou3UM2SIYRluRWZXA2sgd5n+LeaB+wPJcCgzIwgzxCBMLN7y/QrcGyHhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7RLoJz2fprYTzIqFxvnVIypE+aZo3g+qzYEYxT0JkAk4akrM
	Kmur0B5pvScty488i/eA9eQPsZeMRgp/k8Dmih8V+rLKaAEAxaBUxxZP
X-Gm-Gg: Acq92OENH6xWJVZCyiM/J5J7uH3MH2uo27KxjwplDDrfV5DyhhIKof7z3gTKuxcIBkq
	nDFOMwmCpg8eUkk0re51EH0jLYHX/5CExyTrJ9FQfmfV7hMcU+UO69PTzDpPtVYHUStHqFRFrFh
	nXAzUco4eFOvGkh9D0XDrviUxaAfVtLuoorfP6fwFWE+c+lEmJGFo9DjDXKe6bq9EMSxHXqPolK
	CQMYChOOrX1oKtvpvI476+HsE5I0iZLUPPwcoDdEqWJ1CgZrkT/2ffTUt24mS20rDjlk9tRUCve
	KemoO6IMEQS1Go4muOV9eH9VEvdQy/uR7zJQMKtTUbJd/xHt9cntRFK1xZQhjXaV2KsS6EzMkd0
	agDbj4ubfsBESY0sZxPZvReO6oowwGUfi0x1BNcHpaPV4SmLP0a+9Ab24o5NdJmDjIy6kMpwyAB
	cVcbah+HNqbKxO1EQ99qwv/G/sANKa0Ybk2QLZcajxwt+5I4UM/jXybzqfmtbc0WNMjXZSrRaQ8
	p4XbR8O1rEB
X-Received: by 2002:a05:600d:15:b0:490:55d9:149a with SMTP id 5b1f17b1804b1-490b0ec9ca3mr70445485e9.18.1780417651565;
        Tue, 02 Jun 2026 09:27:31 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm381471f8f.8.2026.06.02.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:27:31 -0700 (PDT)
Message-ID: <dc7f62261b4bf665482ecd791e425bbc68aae515.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7380: select REGMAP
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sam Moelius <sam.moelius@trailofbits.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Marcelo Schmitt	 <marcelo.schmitt@analog.com>, Jonathan
 Santos <Jonathan.Santos@analog.com>,  Jorge Marques
 <jorge.marques@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Matti Vaittinen	 <mazziesaccount@gmail.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>,  Duje =?UTF-8?Q?Mihanovi=C4=87?=	
 <duje@dujemihanovic.xyz>, Stefan Popa <stefan.popa@analog.com>, Julien
 Stephan	 <jstephan@baylibre.com>, "open list:IIO SUBSYSTEM AND DRIVERS"	
 <linux-iio@vger.kernel.org>
Cc: Samuel Moelius <samuel.moelius@trailofbits.com>
Date: Tue, 02 Jun 2026 17:28:35 +0100
In-Reply-To: <20260602153926.1540911-1-sam.moelius@trailofbits.com>
References: <20260602153926.1540911-1-sam.moelius@trailofbits.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-02 at 15:39 +0000, Sam Moelius wrote:
> From: Samuel Moelius <samuel.moelius@trailofbits.com>
>=20
> The AD7380 driver uses generic regmap types and APIs. However, its Kconfi=
g entry
> does not select REGMAP.
>=20
> As a result, AD7380 can be enabled from an allnoconfig-derived config wit=
h
> SPI_MASTER=3Dy while REGMAP remains unset, causing ad7380.o to fail to bu=
ild.
>=20
> Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
>=20
> Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
> ---

Change looks good but it seems the commit message will fail checkpatch. Wit=
h that:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/Kconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a9dedbb8eb46..c79341848698 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -311,6 +311,7 @@ config AD7298
> =C2=A0config AD7380
> =C2=A0	tristate "Analog Devices AD7380 ADC driver"
> =C2=A0	depends on SPI_MASTER
> +	select REGMAP
> =C2=A0	select SPI_OFFLOAD
> =C2=A0	select IIO_BUFFER
> =C2=A0	select IIO_BUFFER_DMAENGINE
