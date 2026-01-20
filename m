Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7343E9CD
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945479; cv=none; b=Tm96GHwnQS/KLWlh6bMh+njqwWf6B50sq7jSk1lK+Flqt/jVDRcparaIRfBrRmSoQ6H2sRJQQwej2Pa0v0juxT4ClW02yjNCbYAJTSPK4yodUPAGvafjxQ5QFRBOfiiSz3N27oR1k+KGgPyKabtCv9Pk1MCjOzdjoZ5a7VJM4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945479; c=relaxed/simple;
	bh=0Psxno2fYYLnWxqlJrkIrQGdS92LSEdhDmttxxClFws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeHFqAc2+N/Jci43dXet1WgnmG/+L2zSWKZab3NX0yEqN+YRnUakmYjdw2SircT6kg0sUpNudQcXDPTM8OP+rctC7A06bn4gLYQ8IbrJaR7gbp9Kd02tyzic06hbgR9PW8oAL1LbA7H57W9RhZE3XO5B60UWPDw5gSqQS5rl5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnRAsyky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnRAsyky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2B2C16AAE;
	Tue, 20 Jan 2026 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768945479;
	bh=0Psxno2fYYLnWxqlJrkIrQGdS92LSEdhDmttxxClFws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnRAsykywsx5u69K7Qcum9dqTuYt2ilPd/GvrBCqlSUEpGcSTLmrFLCTCNBmRnftO
	 6G3buowpr5ZNBLIKLFX629ZtWsEWL4zQSuu7itIUkavl+5zjDChA2iz2+xCV6nr/AF
	 s17mSGrJgq8HdH3DXgh1blrq0Dt8arDHfiOEhpRHOBlbCxCmo57V28W64ZgYAhsl/R
	 9OTDFvO34E6KAMjo7cqwdyUrieiw82+packcoTxdvm22IYE32Og1O0jxdAsfvWyPvr
	 z4gy6X/NGYtCAyUL7p6vt/zYUXiy+JrWqTDMQalSkJy7LfBg6DJCS0Ie6RONy3Ftoo
	 RqQ6NaoaW8SOA==
Date: Tue, 20 Jan 2026 21:44:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Sasha Levin <sashal@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 jorge.marques@analog.com, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] iio: adc: ad4062: Switch from struct i3c_priv_xfer to
 struct i3c_xfer
Message-ID: <20260120214430.00d1f726@jic23-huawei>
In-Reply-To: <CAHp75VckpV8JWmJ7rwmSAVk71isd=d9J0JAOCjDjmsTH_3s4bQ@mail.gmail.com>
References: <20260119213617.745603-1-jic23@kernel.org>
	<aW8sk9mD-dOHeJZg@smile.fi.intel.com>
	<20260120095041.0000705f@huawei.com>
	<CAHp75VckpV8JWmJ7rwmSAVk71isd=d9J0JAOCjDjmsTH_3s4bQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 12:03:57 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jan 20, 2026 at 11:50=E2=80=AFAM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> > On Tue, 20 Jan 2026 09:19:47 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > On Mon, Jan 19, 2026 at 09:36:17PM +0000, Jonathan Cameron wrote: =20
>=20
> ...
>=20
> > > > Cc: jorge.marques@analog.com =20
> > >
> > > Can we move this to be after the '---' cutter line? =20
> >
> > When I really want someone to review / test I tend to put them above th=
e ---
> > so that I remember to poke them if they don't and I want them to be
> > included in any follow on threads.
> >
> > More FYI type +CC below the line. Mostly I just add them to the send
> > list however rather than having a Cc at all. =20
>=20
> The trick is that you can add
>=20
> ---
> Cc: ...
> Cc: ...
>=20
> to the commit message in your local tree. It will be kept and
> represented in `git format-patch`.
>=20
I do. This is more pointed because I see it when I use b4 to pick
my own patches up from this list ;)

Anyhow, for one or two I don't think the commit log mess matters
much.

J

