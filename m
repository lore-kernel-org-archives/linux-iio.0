Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951BC29ACD7;
	Mon,  2 Feb 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065545; cv=none; b=eJzeRJLGQmyBwen7w3jpEpnqhO1RhVEJeT3oH+S9koVgInbwgrKOPTUUoVWd8cvkaTmxKuSO/z2QX3jtNZVCkpBckofv+xs/uwFlu+PF8MtiSwlbBhGAAsiUP31GSbI5Oeepm7jJ6jeELPpJ8a6qwtaY64iQwymaRyo+OnPAvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065545; c=relaxed/simple;
	bh=h1H1phOqL2z8VDiT0vhNLRJacMkIhMw59QRE+Ups/is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJfuIlrG+pkPwYMZkXqpd2D9zY0T2/WwTXp8SJVx4Lxdawj0FYIKB2FjMak/bAW9GpnSaFLFXO/79gNY8v4Hkb0gBDe5oBuRtf0AnDPdT4QOqlYVJIGWVZlkI8brdCYy7kjRdJnF1Ty0bl1ZVxRAu0J2qTBSJlWiRrLb4Pj8oZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4s040/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4s040/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E17C19421;
	Mon,  2 Feb 2026 20:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770065545;
	bh=h1H1phOqL2z8VDiT0vhNLRJacMkIhMw59QRE+Ups/is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K4s040/PqcZi2MrygRWzCJEwZIwdgH682tfOW0OlO93JNuN6XIjF1l5UNUXPsG0rW
	 RKJOYIAZFGPta+P7yCnJeTp3tdRgzJA/xw8j8MHl8mHbi6eIVoanzLO4PvgD6jXzCr
	 oIRD82UGr02n2gwLrkuHTeB5LUQb47onpo4t6422Nmv3t6i/CGrY2TynPKPTdor++H
	 GOiW9epWthE0mO+lackPbcLKD7RXEwD7FfN8KZAZ1T6Jzc9hD/mtBSNPJyNmgUxu7h
	 qqRs87agqNKZkJhAsVAaryuMNCH1rIAPPo9h5uQerWCd1yWhzLdA1jKCLHw42BJbcb
	 fHUrwxPWpFURQ==
Date: Mon, 2 Feb 2026 20:52:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: fix use-after-free in
 viio_trigger_alloc()
Message-ID: <20260202205217.3534d14e@jic23-huawei>
In-Reply-To: <b06bee455950f59ea3f2cdcd37ec4f6d1be68b39.camel@gmail.com>
References: <20260131092333.247931-1-salah.triki@gmail.com>
	<20260131124416.19576731@jic23-huawei>
	<b06bee455950f59ea3f2cdcd37ec4f6d1be68b39.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 02 Feb 2026 10:12:10 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi all,
>=20
> On Sat, 2026-01-31 at 12:44 +0000, Jonathan Cameron wrote:
> > On Sat, 31 Jan 2026 10:23:33 +0100
> > Salah Triki <salah.triki@gmail.com> wrote:
> >=20
> > Hi Salah,
> >=20
> > This is a definitely case of the fix not being anywhere as simple
> > as it might look at first glance.
> >  =20
> > > Once `device_initialize()` is called, the reference count of the devi=
ce
> > > is set to 1. The memory associated with the device must then be
> > > managed by the kobject reference counting.
> > >=20
> > > In `viio_trigger_alloc()`, if `irq_alloc_descs()` or `kvasprintf()` f=
ails,
> > > the code currently calls `kfree()`. Using `kfree()` in this case bypa=
sses
> > > the device's release callback and can lead to a use-after-free or mem=
ory
> > > corruption. =20
> >=20
> > In some cases yes it can cause problems, but please show me an actual
> > path to this in the description. It should indeed be tidied up. =20
>=20
> >  =20
> > >=20
> > > Fix this by calling `put_device()` instead of `kfree()`. This ensures=
 that
> > > the memory is freed properly via `iio_trig_release()` when the refere=
nce
> > > count drops to zero. =20
>=20
> Not the first time this pops up and I actually thought it was already fix=
ed. But it seems we
> never got v5:
>=20
> https://lore.kernel.org/linux-iio/20251110035838.37029-1-make24@iscas.ac.=
cn/

I thought so too :(

Sadly my tracking doesn't really extend to checking that a final version sh=
ows up
and I have the memory of a goldfish.

J
>=20
> Andy already fixed it for the main iio_dev allocation:
>=20
> https://lore.kernel.org/linux-iio/20251112145735.2075527-3-andriy.shevche=
nko@linux.intel.com/
>=20
> - Nuno S=C3=A1
> >  =20

