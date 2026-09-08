Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828B30FF2A
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880383; cv=none; b=RrqqNX7dOV4EDOBXv6p1RY6+NUrzfPp7Xr17W0HP3rz+4uQtZ2fr6uBWRrpBxchyIboVqx5b5z6m9ZADrXwCWL7RzHG4tprOlXGDuc4F+MZC5mnJuiAVmDLl6/bIbRWogam14JFffcEj5u1zoqA9BA5KQvT8xiTAg8fggl0UjxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880383; c=relaxed/simple;
	bh=Doj+ZCEyQBnoNJxOjsX1VqYVjYJ/WamXYne20s6EuPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRK6/8qta/tSbpIDZUZYrmebbkS22AThuHoZQ/AzcKsohY6wDoO18WIiOAy91c/1uLmH8goq8hwspQ5440dp6zB9m1kKyZu4H6hc6vwwjb1OUX1sMQqdqZWVcdUhSfVt88vpDx4ra00ma1asW0tRfPjDn4kH8H2QgDlb/viVTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbI2GhOV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbI2GhOV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso34712425e9.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788880366; x=1789485166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTgfNw2BEojIwEu1GKTPFuPQGMGtUKwmZuzA7RAeACQ=;
        b=mbI2GhOVU5hVYrA6X7OisrHVk6+nFnwrTJ1tYU9BCoo9hbtVC8TiYKvCFhDfDzaHBb
         HWbrCinpMmsyqOj1KCHqMrfGEi5L+0tDp61aoFPoacUTDoyqGyN/EQjHep2H2P5xVCPV
         rCNqZKQoQpgbCFtPIdqrH2W/2MHOUQVX4/ktVv4JYZoT7l8azXpaFuKO5F0vublJr+Rz
         YMl2/Us/mJuAk+Ojt7oWuIAWki0pAz8ua4FuKh9DTt27KiId8ewA8iYFBAmU6RDVYXZs
         F4HfUk76HgQLbQ/NYTns8c32ujbtd1ZwDLJU+CiKqy2yJWHC3xmrXUSLSxjPNu1S2TZA
         VeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880366; x=1789485166;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTgfNw2BEojIwEu1GKTPFuPQGMGtUKwmZuzA7RAeACQ=;
        b=NDI9bBT5j/FpOaKw4wmiVonRToGoEDjSlCuTJsNTVh7Epiew1Ctubbn12H2B7HRde7
         N2exo53v1N2l7xs/wh0RVuG5HXF9pQD90xVl7sxVOj8r9iwuL1KKnnM+qDeTRlzgR7iH
         ze6sd6RBR+PjNnevoGyBzHLdreUSB/YTTQ5u2P2z3xios1MVXS01HWwCByqtPaQLiF+8
         vN2PTKsTEfPd3Vu5kdhEyhqDZdDkSbo+V2ZOOwogD5oq9c9lcLLeI09e4duynz7rPRUV
         NelyvbA8xuuxUH+hw4knAljyBxt6ZwDkRzbB461nILjb1C64ou8uNZkL19oGmk6I/7lv
         G9Hw==
X-Forwarded-Encrypted: i=1; AKwUvByHHO8Wq5/X6zm4hN4HbPzEwEgwEw3fBeMDgU8aAzzzR412zCmfx+icTLBcb1IjKFjnWswQmT5UNJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kzvAKTV+hIZpKphIZLSojUx4jF2n3UWMH3+Ttwe/DNZ717qiaU
	KZ8lTWrad/bRajgPHMktoBGtjVZtFgd/y9LBj7tPv5RTUL3bMz5Z6qHK
X-Gm-Gg: AYBFou0WEG4Cq4MivYqy2vOI5ipEMkMvE9+Jhde5ks9FVE02TtyP0QDXhVxClwrpAZv
	CfZm4GNk3w4DqEJyXmpmqD6AyisluQZ8yuXuDySwikZa7IXY5be7zM6eGZdkrtQDgOTNOCDUsqg
	d+ZpnwHLsMlrXMFd+4StlOdBS0cQwDTXrxpN9RwMWEzgML4uv4wbMjbOhyDc1Mq+ZoXCnuZTZba
	2psT5vL+m6XSiOabhnnx82g3NrlvgkDRrERCQxexTJQBVS2HDyOhObjFEK11mx/w3oFLrz6dTRZ
	fE+fLSznMiUI/CyV3F0beX/dbUHhGGVGprqwMizgmNJx6TsDfnTOA19bnW8J8gKyKdQmqOfhbsX
	8EFDZmdx05AKojGjj0rGGpmgLimi1PMBxN1h4EswlLUhrOPSArHbgmtw4+1Ym9bAHn28prEAtw8
	oDr9+v69cSqQsFvZQRNVwQN51Er9JRc3l8+NFaxaWloed7DUoeCwpbgtCJvgcLajI38tX8aAiX8
	BRKVEUPqvDNhhUKIpIRBiQuCz80G2wwFgo56TSp+HvbbzZ7KoXikUwpAiSzKygHKwePSTee/a+X
	PDdi9waHmzSTATX9Ih8g1djzPJIfNpwuKVfGBw9htrG9eFmCDhLFfCBfB8GKrmsPcRGehhamBIg
	kTSu7U1PJw2LllfkVXAjhtHfnwnkqrK4Z1n74j/g29wz5pAbQw19T9BZ0NCdaySWxHl4l8AY=
X-Received: by 2002:a05:600c:4e94:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cf81e368emr508972015e9.6.1788880365425;
        Tue, 08 Sep 2026 08:12:45 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm507187685e9.6.2026.09.08.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:12:45 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:12:42 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE
 macro
Message-ID: <20260908171242.00007f88@gmail.com>
In-Reply-To: <aqAlAJEJPrglb2E_@ashevche-desk.local>
References: <20260908114047.1360-1-joshua.crofts1@gmail.com>
	<CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
	<20260908150311.00000da6@gmail.com>
	<aqAlAJEJPrglb2E_@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Sep 2026 18:08:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Sep 08, 2026 at 03:03:11PM +0200, Joshua Crofts wrote:
> > On Tue, 8 Sep 2026 15:41:23 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > On Tue, Sep 8, 2026 at 2:41=E2=80=AFPM Joshua Crofts <joshua.crofts1@=
gmail.com> wrote: =20
> > > >
> > > > The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TA=
BLE()
> > > > macro.   =20
> > >=20
> > > Is this a problem? =20
> >=20
> > For systems using devicetree, no. For legacy systems using spi_board_in=
fo and
> > this stuff, yes.
> >=20
> > If you're referring to the mark for stable then I'm fine with removing =
it. =20
>=20
> No, I'm trying to (implicitly) tell you that the commit message misses
> the answer to "why?".
>=20

Oh right... Will update in v2.

--=20
Kind regards,
Joshua Crofts
