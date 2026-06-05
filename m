Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9F2B9BA;
	Fri,  5 Jun 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661728; cv=none; b=nyZ3Skyv8XdJYnLNvxv370u48MXZ/wbhmIxtCkouw6O4b0TVFrnjGvKq19UAvsW2RoNz//1/hkXg6S49hoG+BJRqexuR8dsr4+gy3inPI0a12g1uTEei/ig2KzdvPEkMzuIUzy9d5yJRQ4S8LvoxdPeokfyu+xKtP3Y5Vh4k2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661728; c=relaxed/simple;
	bh=URDeYUuT+vOSSMV0ALbnr9g/A+Dy1Q3zdgzo69UvONM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfrnzdAhiUGvL+fYb1N4Ir0cb6wZC64pTHsuvP+bguGQofqxJ2eW4/4+zXf7EOrMNTO9MNIJLbafKsdgW/be4XjQjQfihYdm15wPQW2COTlB7BlkzdEGJWbKQO7IkNbElqxkicPsT1LVVQsVCoTM0Lr6W6wHOsK/qrXj0oSmGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9O0ry0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9O0ry0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9765A1F00893;
	Fri,  5 Jun 2026 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661726;
	bh=G16OCLHi+snajjT51Uy8l8ZsT3A4HbkrRHe9ZCQeIDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d9O0ry0KIZhTNbpp4sRqlrPEx5drp+Nxi34GqSyvC59T/SJ/ReiiWhxpz2lI8RUO9
	 ImVv+yB4LNkTn/8n4L1vhF0uxMrIe2/BxsKRhzgZe5kf+wouudNzIHjaO9kA3H+/Ht
	 c5eMR8usLg6A9dOjOZjn+iKciMfbFj4l8r11qY0EL4vGV4SHZOQ2pC1LfBpnq912eT
	 edgbZfkdfJk+qwdOhZp72TAyfscnKIPMqiwXJiCjS7hytQ8C2E47GI3XrZRpzoOVYQ
	 Rz8EJQv36bqrbg4QC2FXVnpY4mf40cLOWuQ2C/y+Kw1l9cdvmq4RDuQg5EVBEPDY/F
	 paCDW6K8hmYYQ==
Date: Fri, 5 Jun 2026 13:15:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Kempe <andreas.kempe@actia.se>
Cc: David Lechner <dlechner@baylibre.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Message-ID: <20260605131518.072dad20@jic23-huawei>
In-Reply-To: <aiGmfzaSj3bNyXkM@w570anl.actianordic.se>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
	<aiGH7x531jwzOVxF@lore-desk>
	<aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
	<aiGNeKTzOR30w-Qf@lore-desk>
	<aiGZxzz8DF-E-tux@w570anl.actianordic.se>
	<CAMknhBG+u__qiLv0aRLYnUW3iYXkYDLHveQ-bs2gGZfBAD6Viw@mail.gmail.com>
	<aiGmfzaSj3bNyXkM@w570anl.actianordic.se>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 16:23:27 +0000
Andreas Kempe <andreas.kempe@actia.se> wrote:

> On Thu, Jun 04, 2026 at 06:14:11PM +0200, David Lechner wrote:
> > On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Andreas Kempe <andreas.kempe@act=
ia.se> wrote: =20
> > >
> > > On Thu, Jun 04, 2026 at 04:36:40PM +0200, Lorenzo Bianconi wrote: =20
> > > > CAUTION: This email originated from outside of the organization. Do=
 not click links or open attachments unless you recognize the sender and kn=
ow the content is safe.
> > > > =20
> > > > > =20
> > > > > > Is it enough, if the shub is available, to just always run
> > > > > > st_lsm6dsx_set_page(, false) before checking the whoami?
> > > > > > =20
> > > > >
> > > > > I think that should be fine, yes. I only added the readout to les=
sen
> > > > > the risk of unnecessary writes to potentially unknown devices. =20
> > > >
> > > > I guess you just need to check the shub is supported, then it is fi=
ne to
> > > > disable shub register access at that point (it is supposed to be th=
at way).
> > > > =20
> > >
> > > You are thinking of gating st_lsm6dsx_set_page() on
> > > shub_settings.page_mux.addr like I do, but without the read? Or do you
> > > want to gate on something else? =20
> >=20
> > How about setting the SW_RESET bit in the CTRL3_C register during
> > probe too to ensure the rest of the registers are in a known state?
> >  =20
>=20
> While the shub register file is selected, the reset register is
> shadowed so it can't be written without first selecting the normal
> register file. A reset is already called from probe in
> st_lsm6dsx_init_device() after the whoami check has passed.

The fix is fine, but I think it shouldn't be buried in the whoami
check as it's a bit of a weird side effect.  I'd like a top level
function that we can see in probe(). That can do the read + write
if necessary sequence you have in this patch.

This driver currently hard rejects unknown wai values (which it probably
should not given fallback compatibles should work). Lets assume that will
get resolved at somepoint and so the wai gate is advisory only. That
means that the dance to avoid writing to a device that doesn't match will
no be useful anyway.

As such, I'd prefer this 'reset of the register file mux selector' was
part of the reset function and that was simply called before checking
WAI.  It fits more logically there than in the whoami check function
which is just the first place the unexpected setting causes problems.
That is put it in st_lsm6dsx_reset_device() and call that before
st_lsm6dsx_check_whoami().  Maybe with a comment to justify that.

Thanks,

Jonathan



>=20
> > >
> > > I'm willing to submit a v2 if you want it.
> > >
> > >
> > > Best regards,
> > > Andreas Kempe
> >  =20

