Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B54218B8;
	Tue,  9 Jun 2026 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010601; cv=none; b=IAB5+69WesXUg7Qdk9OqMIT9AOHVwM9GhKQa1Nm4Lob9oOpzBbACf/VSwsf7nXwOtdQmDGFBIs1DQzkKDWzTCYd+m5wA+xNtlVjuinGWPeWtyqJk5kzKZcWDtoapNBK5KiOL1AEG+VrVCgPxKbDKg2kGhCP5nyrTquFcB8KwNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010601; c=relaxed/simple;
	bh=Mnx+aFx7PfsWNVWUXIeLSqGnfz38NepIrKchcjtqg5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+iIb7AAcaMWSw2UBUGFj/VZXkg9GOpkw9/hymR9SaQvI042sAE0+7VBIKZHz7XtlzZFVZCqOlx4Zrjksu0A3L+7Qo5sf0ne15VX3ZI2QHtKb+/STxKeugh+dOm7pe/oHBFwFRwOTVfuJxEXOPmE+m8+Fxul7AMswI1Gk9DYxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krmxWFCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krmxWFCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901251F00893;
	Tue,  9 Jun 2026 13:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781010599;
	bh=f9TLLwz+vcdxqse0FK4QKflA6wJpBsIAbToszmSF59g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=krmxWFCK8YR5sKgODUq4osHv9iezdk4yTPFY6cWdq/9TaD8oOOtqX0qgEYPPwOCzN
	 q4/qsyXF4SQjWcyro4VsxdKiEL0ow8cF8664BxcZtS8fXk9LhDNmTiubKIGTBn3+8n
	 ALVvrx2NHN4vfDSnP8aiYl1m4vErNWiziirZZivFfnpcnMQu/F0ZFwH28RQcKqdJvD
	 Jw80tyLwCMcysB8iuUie9fqSGP98RfwEYrHvSKBLUuHlHMxBEvNS+KHfSDViNA9mRJ
	 W4AD+Z2Oi/r367BV8WEggDE+tama3w0YLIPcglCMTwjP8JfTxM7dQU5cG6uDtmmCbG
	 ubvnbk+2SvEtw==
Date: Tue, 9 Jun 2026 14:09:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Dan Carpenter <error27@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <20260609140950.70cd6810@jic23-huawei>
In-Reply-To: <aifJtgLkM2m3KciV@nsa>
References: <aiEtIGOFhF8AfUCT@stanley.mountain>
	<aiExQzpIOwPgwd3-@ashevche-desk.local>
	<aiE3N6zErq2WcCvS@ashevche-desk.local>
	<aiFVuvVtaWbjfVzA@stanley.mountain>
	<aiFWg6vC2cVbONTK@stanley.mountain>
	<aiGRzFrSU6QUL4R2@ashevche-desk.local>
	<aiJo1kjN3_XDUdBc@stanley.mountain>
	<aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
	<da949cdf51727f74d1f0f5b3e8248d5dc34e2219.camel@gmail.com>
	<20260608165138.16b88dbc@linuxescape>
	<aifJtgLkM2m3KciV@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jun 2026 09:10:14 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jun 08, 2026 at 04:51:38PM -0500, Maxwell Doose wrote:
> > On Mon, 08 Jun 2026 21:31:14 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Fri, 2026-06-05 at 11:28 +0300, Andy Shevchenko wrote: =20
> > > > On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:   =20
> > > > > On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote: =
  =20
> > > > > > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote: =
  =20
> > > > > > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote=
:   =20
> > > > > > > > =C2=A0=C2=A0 168=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^
> > > > > > > > Uninitialized variable.   =20
> > > > > > >=20
> > > > > > > s/variable/data/.   =20
> > > > > >=20
> > > > > > With what I asked in the previous reply and what you explained =
there
> > > > > > (thanks, btw!) I still think your patches are not fully correct=
. They
> > > > > > will require to atomically write all or nothing. If we want sup=
port
> > > > > > partial writes we need to go with that differently (reset ppos =
when
> > > > > > we got enough or more than enough data).   =20
> > > > >=20
> > > > > Requiring writes to syfs and debugfs be atomic is pretty normal a=
nd
> > > > > works well in practice.=C2=A0 These are very small writes.   =20
> > > >=20
> > > > Perhaps. In any case your patch will break existing partial writes,=
 right?
> > > > I'm still considering that resetting ppos is the right thing to do.=
 Just
> > > > need to find where the best place is to do that.   =20
> > >=20
> > > I think anyone doing partial writes on a debugfs interface like this =
one is very
> > > unlikely but it is a fair point, yes. But can't we be more relaxed on=
 debugfs? No
> > > userspace app should be relying on debugfs in order to work (though I=
 know that
> > > actually happens).
> > >=20
> > > Anyways, this is one of those interesting edge cases and easy enough =
to get wrong. I
> > > guess we should either:
> > >=20
> > > 1. Improve simple_write_to_buffer() docs;
> > > 2. Or come up with a new simple_write_once_to_buffer() helper?
> > > =20
> >=20
> > When you say "simple_write_once_to_buffer()" do you mean a wrapper
> > around simple_write_to_buffer() that also checks if *ppos is 0 and
> > returns -EINVAL if *ppos isn't 0? If so I can start writing that
> > function. Though I guess we probably want to ask Jonathan about it
> > first since obviously he'll have his own opinions. =20
>=20
> Yeah basically not allowing partial writes. Partial writes are also very
> tricky to handle in terms of concurrency (assuming userspace can do
> whatever they want). But I would not rush into writing the helper
> without understanding how people feel about it (at least the ones in
> this thread). Might not be super beneficial.

I'd be fine with such a helper.  No huge rush though as I don't plan
to back out the patch that kicked off this long discussion.
Hence it would be an improvement on top of that.   Dan probably is
the right person to offer a considered view on whether it is worth yet
another helper.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> >=20
> > --=20
> > best regards,
> > max =20

