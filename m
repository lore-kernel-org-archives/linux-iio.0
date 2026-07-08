Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9663FB046
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497716; cv=none; b=u9JXCVlhD6Dqh7vC1On2gYrO0xldHRCTkrEix8CkBSeR9Hjcev3iByZ84FA2wNBbz4eLRTvVQaTMeKoYAo8hXE+BC3gewlwHdPVk1vE/HUeMXbTp/r4eqdswUD+T/osJ5VDjPdS2Xm7EDdTJaNT8lGmFbwdA3amobKYW74aA6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497716; c=relaxed/simple;
	bh=doJnDt3o58uL+BR3TBRqwuwi7Zn1tsai9cOZ4qWtNJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdEfQLNWjGT2oSZgnS54PoO2KCRKrMsQTxEocDVQk7tfIjFLaZEqhh98f5EY6i+1sLlueLCe3yGsb/IMiitBxYwWMx2OW1i7KTbf20GXGfNb4hDMHAeJyiWecy3GugHYHDXdoGOU9aU8UsvqtSt1YVUmu0XCmPAyYm0+PB9YcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMcAr30T; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMcAr30T"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46ed4f66256so313128f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783497712; x=1784102512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTtgga4TZLikFNZUSbCVcQ/U5UwEfA90+Dcxj1wQA0o=;
        b=OMcAr30TrnqlYZQcRi7VvxvGLri8OYvb+qOrNXi+nGbN1HSn77XFUAAIIkgAsq+IAT
         bsLeA4ySuG1luN74YSwXNhDt3pFtX9MG2CN9VxeuFc1ZraZaz+lzsnKiVok/pU4DvtHO
         w3oIu9/IXipDO/YimO39ONhw+H8GaytWv6krn1Ntl3uY/BNtCjYC4t7gMvKTgH124pAM
         4dZVcvyYstAO+5Oo6tEhXxhTzPJBPmPlt3/g0EZfGY43r1QVu74NMgqdNe4Np0KAq+0F
         MiI1iCaqzdygGUJS7o3/OrCsOy32CRKPuwi0YoBFnKvWILtqXhZ6/32BoDLS4PSdos9V
         9hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497712; x=1784102512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTtgga4TZLikFNZUSbCVcQ/U5UwEfA90+Dcxj1wQA0o=;
        b=IoH2+UvLgzSt83gTogqJG72R6/zaKgTCzH2PzSZIGZ6QAsykAz3npuPW2YdabvXgy9
         Nu+eEoUnHIXxAg/AqEmfa6IG/HpSNMDwikks1aLSnQ/Ce9/73jkVzcmSWi4KuIizJNI3
         pOVqkWqGSa/uTMV2NIu97gvv8/PryFxwZzcytmUcmtx/bRx5N44Cvnmrr3vfc0B4QDYM
         ZoPGAHY8NaHbU9C3dOHMGXFvF7NvC2UoNZ+rE8aWyD+irLjfUB91P0TX29BC1owldOP+
         lG89kpIPJfUKHn8e6O99fLeNU1wzoIYd7FHALJNgQnnDGYnf/g239C6md7i6h7XKHp9E
         Rscg==
X-Forwarded-Encrypted: i=1; AHgh+Rrp2b19T7ts43JVLGjozlI0r5LCUSWlKg35mn4y/lelyUB3l3C1jItIXwy30db2eckuU5uGpJkiLek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNrPnkAsAZ2qw9DjvUGS+Ek2j8cLW4ZM98eN/C2eBtVbHzt2q
	Vs3mkKdcr8aHP+koI2MrsYMZcTb9zQwmUpv8TFjSVzQ3q8V6UDU7pGS2
X-Gm-Gg: AfdE7ckS9ayicC/IRBENGebkZZlvkQ7wKltVa1NNFhN5iWDxYINL8miyFFMZuSn4jkx
	XEUuaT+pHEtbq8HQWB+wVdEk22BDhaFpzgmnoYhw8GWlxEE1GxL3KhhWK9MwTxcS6/Jm7c3sd01
	HSogZ3nvlQZZgXeDB2/hQWpufO3UO7wHghwY7z4p1fMVav4+xIm49Ug+12wI8/F9Q+PjQmjEXan
	CQx2gsq69Ik4ICvRhYn3Nm22HD9fkdEfg8lRgZ5MwEwkmZr4cKZ2PiH1JDYLHXlhtUZBVJG5DpF
	g/k0XmtNbRPkb+LxfObnUXAUTLqdwvRhgQco78nCVRcbpttJ9Ggo33l+Vkt2/P1qpznuMNMsMxG
	hD0RcbM/uayy7tUmvAXCzq1TLia9PDcbor7581JecRPRLKs1/mqSCSQoHB3tKW9G8r5SQtxPUby
	L8R80qeqw6qB+sG4z4aDPTldR/P571t9CXMv3z0sR/Kp6Inlz3uQ+AVOR8W80oErYix0ND49fBM
	KD4/l2QdeVilrmjgGDaRSvGzJDKppYcXvmco/QKGaJ1xlljaaOe+Fy5GpsewY0DqQp2ECrR3G28
	5RMNuMqP/RUpmFsg2sxqbZ65Oq2DeFwSs/nEVkocSXu0qAAQFKSSk+SmNgkAAXVY5S9+egrfZl0
	GM1UNu2HkmJfg/cLOzPjKqts=
X-Received: by 2002:a05:6000:2381:b0:475:d10d:b582 with SMTP id ffacd0b85a97d-47df07a5375mr1374409f8f.39.1783497711696;
        Wed, 08 Jul 2026 01:01:51 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm39114212f8f.23.2026.07.08.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:01:51 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:01:50 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Ivan Mikhaylov
 <fr0st61te@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: add missing 'select REGMAP' to Kconfig
Message-ID: <20260708100150.00002436@gmail.com>
In-Reply-To: <ak4ApBBYdyVNd1Al@ashevche-desk.local>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
	<ak4ApBBYdyVNd1Al@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jul 2026 10:47:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 08, 2026 at 07:34:11AM +0200, Joshua Crofts wrote:
> > This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
> > AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
> > may result in a failure. =20
>=20
> > Steps to reproduce build failure:
> > 1. Run `make allnoconfig`.
> > 2. Run `make menuconfig` and select I2C/SPI, IIO and any of said driver=
s.
> > 3. Run `make .` and make will end with regmap-related errors. =20
>=20
> Repeating same mistake from the previous similar contribution. Where is t=
he
> actual excerpt of the failure? Please, provide one.
>=20

Here is one of the several errors when compiling.

drivers/iio/adc/max14001.c: In function =E2=80=98max14001_probe=E2=80=99:
drivers/iio/adc/max14001.c:315:22: error: implicit declaration of function =
=E2=80=98devm_regmap_init=E2=80=99 [-Wimplicit-function-declaration]
  315 |         st->regmap =3D devm_regmap_init(dev, NULL, st, &max14001_re=
gmap_config);
      |                      ^~~~~~~~~~~~~~~~
drivers/iio/adc/max14001.c:315:20: error: assignment to =E2=80=98struct reg=
map *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer withou=
t a cast [-Wint-conversion]
  315 |         st->regmap =3D devm_regmap_init(dev, NULL, st, &max14001_re=
gmap_config);
      |                    ^

Funny how I essentially copied the cover letter from the series where I add=
ed
missing IIO_TRIGGER_BUFFER entries to Kconfig - to which you didn't require
an example build error :-)

Shall I do a v2 or is this reply enough?

Thanks

--=20
Kind regards

CJD
