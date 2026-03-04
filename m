Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CB2F6560
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634072; cv=none; b=BC/ZLaDUPFLBhmlx6GQp3iBY/8QgGdp5IF4rpV+/QpT0JbHO+GRrs3Dwl5BH5nUCBMmMaA0wOukyxiXvq/miaLhehFZ448inOseZx0UUQdlJcHyf+b8bVEAuNz3n98TVy9RuG5SS02cuS7shX7jCi7GQ4j7vBeJFEOvclshPK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634072; c=relaxed/simple;
	bh=PRWWUKqKHoWc2ct4wK4ZzhM2kMtkMtidr8+RVkms78M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B4RgwrUf11Pv1+KSLW6jUZpdW1zTeOo7sSnrutND7Gwz6ki2orNFL6XT3ebyDiaCbR9GIQ7Pu40BUU/HgYNWyWAwWvby6fIcGpFFYtPn/VPz8dar+YmjmxGe/UhknU6B9P1meJ6ukxJMHbNGCjYyfiudwV6B3KOs20tgxW1vtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hDqTKda3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hDqTKda3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483a2338616so43399855e9.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 06:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772634068; x=1773238868; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRWWUKqKHoWc2ct4wK4ZzhM2kMtkMtidr8+RVkms78M=;
        b=hDqTKda3S2SQ8JHUL8Yt6VP+gUkRWcRrmxpDCPdG+C4DCpLssOAFgRCrtHl4Yj+vR/
         eS8euz6reU2XQkdaeX3vuDibEMF5w9+a9pU4pkHSx7tfclan6O0NgXnx22FZ2Ljux3t/
         q+iS60ddFgzIiY72jvgEA6KJCdHBdFMtcxxFANOzMZLVT3bIdAvo+Nn84bmlX6iwXsUs
         Ej5JhW26sAgidDGGRSdDjndkNZp0eamjqR7gLy8RjK44x3PhtFSdHsEewg75s2ynYjOv
         PhVd36pmoZWpgVA/WeCzdlmmhYh+pwe87Tw8nFIAAPV2VUaNz2NpGl40iNHzFqAsp63b
         ht6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634068; x=1773238868;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRWWUKqKHoWc2ct4wK4ZzhM2kMtkMtidr8+RVkms78M=;
        b=hD+VFObezhplU+hMgbKh3Jymxb/jZnrD68eVF9TPmKb2N9RD9OKZvlKjjT4q7di40q
         rM6pqr7kaHjg5rsioQZV+DDmgQvNHzZoyi6ZaCrTSIVXoDvMKBAdcMp7j0vaQTMIk9Gu
         Xu8blUTiTnyUck9IMzhiHLgkNRQOf6BI4xGYAUxhahhOVdNn8SVMpt7tO0Ae2jLt51h8
         qcir1coyI94AS4laatKUyDryF/d8be27Ufm9Wy09GU5joH2QO16VYCqFKtcef4BJF/Rs
         cut7DwjAC2udCUlDTUdaGuJNWg9zkDBz5V7bCTP50ov+i2Qf4oamKnkrunyz7heK7D71
         qviQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjee7VRsxjrF3FBfpPN3VM09CZDCFS8TT//NkSwXm1CEDoKzUKP05t07QoQHheLGvCefEUmMzX7YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUKJ6edkVOe7Eqrys2N+9HVSXYUeeExNU4PTY2YZRl6F0Jkt59
	5nBp3hjJW4TcE72liiywfuoI1PAS9VVTlfSczFwtPZkzP3HgwO8s3B4U4M8ozsnhGAQ=
X-Gm-Gg: ATEYQzxV+f7N5XCrEWzAipeEQtcBxpvF3h3QXS3q3mxS67PrJPsWk7PUVnC/XTfyTSt
	TId98Oned8hIqOrrSDkQ0kHNSUn6IFEGT66IHUHwPSrlzUKwzIzzgkFeEweEgG2fu7N5Cal0vhe
	+FmLzlhaOybDxYUrT8IgznwK7chq5/Sr7x28ho3CW5VUbw8c5KrSeHTyRbHHdCO+G/nqzyAkV/B
	O+CU5WaYgo5pfRqVlZe3YYEMLq0QI1DSTvMLp4dyG4kSc2S0IlqfvQvcNRxJeSxlev67y7U0SCz
	Z2Bh5Qk7+3bosr38YkSGtFPsqKUCJewUIVLbL0UThpw0k4JVjuX25YGdAEh2Sut5zjRBdi+MH2x
	kYX+OAf1JySpuULyAYdpKZ79bq/blWUYqtQ3rHZAnn7gx8+RPtLGqBMoie5CMI95RLqzEbfk/B/
	yIknP3gcI=
X-Received: by 2002:a05:600c:6812:b0:483:9139:4c29 with SMTP id 5b1f17b1804b1-485198480b2mr39528925e9.2.1772634067858;
        Wed, 04 Mar 2026 06:21:07 -0800 (PST)
Received: from [10.203.83.178] ([151.57.249.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851881a844sm50608135e9.15.2026.03.04.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:21:07 -0800 (PST)
Message-ID: <a265489380e7abc9343c536185bc203688c5bd29.camel@baylibre.com>
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 15:21:05 +0100
In-Reply-To: <aagc1_EkH3cqh41O@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	 <20260304080706.2844472-1-flavra@baylibre.com>
	 <aagc1_EkH3cqh41O@ashevche-desk.local>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 13:51 +0200, Andy Shevchenko wrote:
> On Wed, Mar 04, 2026 at 09:07:05AM +0100, Francesco Lavra wrote:
> > This modifier applies to the IIO_ROT channel type, and indicates a data
> > representation that specifies the {x, y, z} components of the
> > normalized
> > quaternion vector.
>=20
> ...
>=20
> > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/sys/=
bus/iio/devices/iio:deviceX/in_rot_partial_quatern
> > ion_raw
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0Raw value of {x, y, z} components of the quaternion
> > vector. These
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0components represent the axis about which a rotation
> > occurs, and are
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0subject to the following costraints:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0- the quaternion vector is normalized, i.e. x^2 + y^2 =
+
> > z^2 + w^2 =3D 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0- the rotation angle is within the [-180, 180] range,
> > i.e. the w
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 component (which represents the amount of rotat=
ion)
> > is non-negative
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0These constraints allow the w value to be calculated
> > from the other
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0components: w =3D sqrt(1 - (x^2 + y^2 + z^2)).
>=20
> Just to double check if we really do not have a special mathematical term
> for
> that already. If we do, I prefer to have that over odd "partial
> quaternion".

A quaternion is often represented as w + xi + yj + zk, i.e. it's composed
of a real coefficient (w) and 3 imaginary coefficients (x, y, z). With this
notation, the (x, y, z) components are referred to as the imaginary part of
the quaternion.
Alternatively, a quaternion is represented as the combination of a scalar
value w and a 3D vector value (x, y, z). With this notation, the (x, y, z)
components are referred to as the vector part of the quaternion; this can
be confusing, since the quaternion as a whole is often considered as a 4D
vector.
