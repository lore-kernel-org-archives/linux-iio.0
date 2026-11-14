Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697184;
	b=3ZPR8xIH/6W+3BI/7IjCOW3uWzgj7qj3UiDdk4YZ+UCnHwhC+Cg0pQNFtucM3VXfjl9f
	 AtOSEct+k8iO+oOJNFlQXaOcXJJfde+M4733jdsD5hhTEDow//deitwxUV2ot5H9BS/j2
	 GwVtIoT0Z5QN5obq9gEU0QzzIyJpJcAkYo/+9SkiS1Hjf2rbf3nNvlNh4ZnTd8XgZ6AAP
	 JruaYGyU40pcE5AwgiA8nMZpzgQcQFaWGF5k9nW1070VNOsR8qMy1I/U4avU3tpynpG1c
	 THR+0Hx05J2iVRS2W9IloDTQXiORZZL6xS0k0rMtLVBMBTSesFcwgMBke2Kxv3qyJnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697184;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1RjSw3udwOeS4kl1fq7ydLZRlJKs8s+Pg2HK9HfkKlc=;
	b=bGjPKmKzueMVSn+Yi7Va+zR9zdfOzDt7I184mh42pm2Ha7XG9Lg4rntOAYdME09M2MBz
	 9VzkBIaIcPu2nBegCdBm+U1/PkKJUpOlUX9dNmszrkHKnZzGkeFvB9x0bC+o/GPFH0KO2
	 EEWY0RtYapdZ02Q00wTKjCps+ERabVHR8RHaU+umnB7E5oh31BgJki2fEkoX9Lq2Wc/Ts
	 dc8hsgSwLjxVcksu86UAeeyCadqdzgyBlJWRqsrOTlkRtLMl2ioIfPkUXO1DJ5FC/I0cB
	 PJt7leEj1JWGWX01f6BEfA3opsWIo9Q9lOY0Zz0gsz0n/TGm6mV/1A7I16YuIE51q4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlbqojKC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D1606A323;
	Sat, 14 Nov 2026 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlbqojKC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65F91F000C4;
	Sat, 14 Nov 2026 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794697183;
	bh=1RjSw3udwOeS4kl1fq7ydLZRlJKs8s+Pg2HK9HfkKlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VlbqojKCq4unXRlhspCIOKhbgHOEd32Kg9g8Wtkh5qqzDw7ZrQ+P1RN5/sGnTWY69
	 9GhV3SUTmOio6dz7cvltBdz2MDXK1BrLK/QZcycgBg+XRJwXtkwwfDM832GFpY5TjN
	 2YOpjNsmr9sTFjJgiNSl7WgRzjWFMPlZIibZGteSqqw8b9Qk8qp4LnEQce/lu40loF
	 H4ukeEMd0d+DOYu1WvAAZX8pebPdN9KQNw8v8HoHoYgrde6t+xH0L16Rfyhs2sAC+v
	 DdqddnwOiM0+Cfpn0uYdkiadvTKT2w+EJIlXV9YF9G+GUXNfeTisLLMtRZ0/88G7Sr
	 OUguS3/FYiZuQ==
Date: Sat, 14 Nov 2026 22:59:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, kernel test robot
 <lkp@intel.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
Message-ID: <20261114225934.396da0ae@jic23-hlaptop>
In-Reply-To: <CAPVz0n1UG6L8divtcXgg7mfS7C3bO9tKv9d-Xh6VbyayG7p8-w@mail.gmail.com>
References: <20261108094253.83899-5-clamor95@gmail.com>
	<202611090518.mm6yt2nO-lkp@intel.com>
	<avInQ08dVrsc-Rbo@ashevche-desk.local>
	<CAPVz0n1FqXV-XXyBJpnp1ivd+uk6+zGvngobQZfUXMNBBPyORA@mail.gmail.com>
	<CAPVz0n1UG6L8divtcXgg7mfS7C3bO9tKv9d-Xh6VbyayG7p8-w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Nov 2026 16:45:02 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:=
07 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > =D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 2=
2:04 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
: =20
> > >
> > > On Mon, Nov 09, 2026 at 05:48:09AM +0800, kernel test robot wrote: =20
> > > >
> > > > kernel test robot noticed the following build errors: =20
> > >
> > > ...
> > > =20
> > > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > > >
> > > > WARNING: modpost: vmlinux: section mismatch in reference: trace_ini=
tcall_level+0x28 (section: .text.unlikely) -> initcall_level_names (section=
: .init.data)
> > > > WARNING: modpost: vmlinux: section mismatch in reference: __arch_xp=
rod_64+0xac (section: .text.unlikely) -> initcall_level_names (section: .in=
it.data) =20
> > > > >> ERROR: modpost: drivers/iio/light/ltr501.ko: symbol 'iio_find_ch=
annel_from_si' undefined! =20
> > >
> > > Forgot to import namespace?
> > > =20
> >
> > It is not exported in the core
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/drivers/iio/industrialio-core.c?h=3Dnext-20261109#n319
> > =20
>=20
> Should I export it? Do you have any suggestions?

Sure. Export this one.  It is a very simple helper so I have no concerns
about it being used in drivers rather than opencoding the same loop
(which I suspect some are doing!)

>=20
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > > =20

