Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6D27FB34
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422434; cv=pass; b=c7rpmOjDi8uOsevDLTAM0/0wzuyN1q+hYemepDK/sxibInzWaYiCv8jp6F37fACtD+Yms1oA63ETzzRkS9yokd/IRbh8rYeOPYEwwroHe3RS2NI6lhY6DHKwgx9e38cgJFt29I7RApg+BNQKYSpdRR8/0vC1ZUQaGjsmQQ7lhZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422434; c=relaxed/simple;
	bh=wy+avasr22mgfIucIYeDtvO+JIZdj7VULkHTn3GuJCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U60zlt1+G/5JNU+WwS0qsxDbJvlAUnr5G2eLbgKGl1045K5PHbaBvieFPESc7jfM5RUj35BdZVlwOYqV8tPBM2AyFeJZcWKdlZyCbqMMPHFYhScw0jIjHv2fiei8sZOZAzxhvIxUhJLmFoJMwsBDLIMDRHBT+BciY85DZhe1UMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elnDSJUZ; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elnDSJUZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305914so3719771f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 02:13:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769422431; cv=none;
        d=google.com; s=arc-20240605;
        b=PByEpiDCPOErOrv4eUU0ZbTbJ9ont/yUeoyB6D6CNPgez5cOwOZfcBj5wW0DC3pfrt
         /NQL2Bj9pUhm4EU6gLwDfY4QqrfNPZz5itMDqePj2QvQKDywMokObO9YB2ZYUY36ZgKZ
         FzfBr9w9f94ATv6ziqzF6c13G/fj3ZyROwF4q90KTSjrAi2Ui7AoKYpAYHF0KYhoFipQ
         1lA6Zv5knCy4gkxJ+5OJuIPI6tHiEqqvuRAjz4tFpDQtzH9nkmkqQ+v9F5Upje979FQD
         k32JDHFbUH47ea75owntyFKiJnvmX9qseUtiIu/mEISuwWtEP5BX06Rqwlm0yFjtqwbv
         aSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/9dTPcMDWhfJ1rIvjDmwY/itS6IYJkkuuHjxU9ulEjk=;
        fh=u/d+wjqdcWvla3+CNXi7fF2JRpLUbuJF6fhFcBnqCpc=;
        b=Wn4KNiU24s2xf/1pBvUWfzv+r0jmecJQW11RU1xrf4FhtKMvfNzVD2Vql7aiuKw9NN
         gPlYOQf+W46uvEwKPzVd+32Il2NyWc3MUJdmrTr4vVFzm5BLuUJCD3udbwAZc37JJsig
         BMF/Cl8cokKd2SCvOW7FWvEQuygAIWyCuTki7pE93WIDSoT+roC3xae68OT7GsT10WRA
         3kIflDDp2xKb50vmW7Ej+iYG3doxfnrtgBR03M7PEMjZ8TdxqZMW6zK65qtnGwc7iKGc
         jWBzDeR3mQV0+5v6xmjd1dGce6psnKafBq2jiL2rJ3nOT2Q3ph5MEvbHQ7xzCygY1Pep
         DFEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769422431; x=1770027231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9dTPcMDWhfJ1rIvjDmwY/itS6IYJkkuuHjxU9ulEjk=;
        b=elnDSJUZbStbMHWx0dcASZueczLi03SuEJsFL7IWU8wcbnx3DTXbep8uw9YePkzG2a
         MuTQuJRp/opoXbEc0fjd7uRRwemI0apD/kQ8c0wMbhLFwNAl3QHaQWkRhCuYsWR/Xb3p
         aP9cV+le9oVbyg+/15e3VGrLhAQTu2syytcHTQZDHblerrvvYDDdTadSDkScRiZK+FpT
         6j0+uLvSRF6LiCa0AdzaS0s/fRZyF0mMfjv0l6b+i2yZ2+GV5ADc6nxa9nYTAd0NT1ob
         Ho5mTEI/Eb6UPZPt/8nmr9avjBraCnrEeoInuVfPXtgeJOzB5zIK1IkAaebXI3vry6hh
         0J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422431; x=1770027231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9dTPcMDWhfJ1rIvjDmwY/itS6IYJkkuuHjxU9ulEjk=;
        b=arTnrKrAXHkMIejTQPSCiIGmnRO1PNAuJgJfP4wDsfYGi5PBFNWPxfieVidvoTcnDA
         WSVwhnmlRhVv/z7iIRMxPAqNwqKx5wq5nmtB8VGAD8NAHl1xO6YTRVZr5V+8Xulmivti
         /JQP5A9H1j+xOM3hQRxuD0qfm9xN/O+8ZKIkCsFqRlctMf92a6cfaeasyovsotRYTMoh
         I0VEXCqkYTOGBXeLOgMr++uHXCbLg2kaZk2x2BbLGfz4gjxLLNsispPaUdVoyHODjERo
         PWIANIC7RWC7GUVBregV83vWSCPQwfPGMailIg/IRXh1t0CjOruHU27DEu1A35BKLhfr
         KpPA==
X-Forwarded-Encrypted: i=1; AJvYcCWxHbSWuGYHQAg97cYi6EDV5zA88Ay8tZuVNPjsY/AkHabw6Cct5TyJRRrsxrmp5JvEuNT7X8bkTA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0ezwSyTbM1neOM7DBUBPlv9DWIcIawivW+D1tfVLtrdzfcGF
	jTWAP7T9/ku1z7THwA/Ht7nkJA2SAyDB6/TL4z2BhdnUHZJNEDSyeSWZoL7ZAG9d3WA2/ReUf87
	LI5f/s5+BpXk7JFnPThVtbptCOHkln/M=
X-Gm-Gg: AZuq6aIFFgdXt/UsRRK9ml8XXfZb2xPcmDPG2WZ61gt0L8/9sEoRXuFR/JGkOBeXBUx
	k4kzRhMyizLNKMkubKETdVjLA/09L94kF5BknIFNA1QBRZdQ9QUvRqmNgCwb9XppO8AERbmlAqc
	6KKhjgpA+GP+uNWrGHzt6doHejVEdSvig/E4iYE58oA75cFwFCfr0FdNCn2lY+xd4k2XEwViCHp
	glY6JhPnKObVgoSfZyZOaKGfaZgG5XOUz+3VT3VX8BGRKZ7fyEaVPIpZXDnzbCL9Mxtmb80
X-Received: by 2002:a05:6000:3109:b0:435:a464:f468 with SMTP id
 ffacd0b85a97d-435ca1b0a8amr6471509f8f.47.1769422431344; Mon, 26 Jan 2026
 02:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-3-clamor95@gmail.com>
 <aXc9n_gc7TEFvNA8@smile.fi.intel.com>
In-Reply-To: <aXc9n_gc7TEFvNA8@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 26 Jan 2026 12:13:39 +0200
X-Gm-Features: AZwV_QgQiSXyGE1Y1qrMc2HU_ThQY8l_CasgZEnx0m0QabZgNO42haOxvzkombQ
Message-ID: <CAPVz0n0MM6OcjOWnNBaGk=6eYcb09P0XBFDn+MYHtXXcgkcvQQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] regulator: cpcap-regulator: add support for Mot regulators
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 26 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 12:10 Andy=
 Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Jan 25, 2026 at 03:42:54PM +0200, Svyatoslav Ryhel wrote:
> > Add support for regulator set used in Motorola Mot board, used as a bas=
e
> > for Atrix 4G and Droid X2 smartphones.
>
> ...
>
> > +static const unsigned int sw_mot_val_tbl[] =3D  { 600000, 612500, 6250=
00,
> > +                                             637500, 650000, 662500,
> > +                                             675000, 687500, 700000,
> > +                                             712500, 725000, 737500,
> > +                                             750000, 762500, 775000,
> > +                                             787500, 800000, 812500,
> > +                                             825000, 837500, 850000,
> > +                                             862500, 875000, 887500,
> > +                                             900000, 912500, 925000,
> > +                                             937500, 950000, 962500,
> > +                                             975000, 987500, 1000000,
> > +                                             1012500, 1025000, 1037500=
,
> > +                                             1050000, 1062500, 1075000=
,
> > +                                             1087500, 1100000, 1112500=
,
> > +                                             1125000, 1137500, 1150000=
,
> > +                                             1162500, 1175000, 1187500=
,
> > +                                             1200000, 1212500, 1225000=
,
> > +                                             1237500, 1250000, 1262500=
,
> > +                                             1275000, 1287500, 1300000=
,
> > +                                             1312500, 1325000, 1337500=
,
> > +                                             1350000, 1362500, 1375000=
,
> > +                                             1387500, 1400000, 1412500=
,
> > +                                             1425000, 1437500, 1450000=
,
> > +                                             1462500, 1475000, };
>
> What a style! (Yeah, I see it's being used elsewhere here...)
>

I have just made it in same way the other tables present in here.

> ...
>
> > +     CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
> > +               CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
> > +               0x16, 0x1, 0x5, 0, 0),
>
> > +     { /* sentinel */ },
>
> No trailing comma for sentinel.
>

noted

> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
