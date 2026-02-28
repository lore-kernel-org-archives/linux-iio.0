Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B596B2550AF;
	Sat, 28 Feb 2026 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306928; cv=none; b=qnquZqmVLmoN/l5u1kUVWJpu4rAXSmtRr7wHZ58QTfnQCaZyk+YU1PhCYmHhtqJrhIDSdA7Mk1jnsct01Rse+KAyUXHwyGHZvmEEHznj2DfkKpSjxN5LBFGh/9I61n2UwhDPP3qXFzbyGQonfjCTuIcWm+YLOtjb6AdY10n85u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306928; c=relaxed/simple;
	bh=/Vzwo35NT2Uen8+FxmqZVjPz8lUb3txhetkjxDXQzFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHH8nFPE1ampr3kDsKRlaoie6FXrYCCBPFLvH1D2+SQ/qgSSw2yqHoI3O5A9VH6r1N2OSySmqKBtH8W0E3IuZWZluuMlXmoviwCQ6zRc55/Zccb7g0nBSv25m2ZhW1rPPVY9thrtcrOl1+3WM/IwF+KLTloJaGwscorGz1mB0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/eHUEY5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/eHUEY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DA2C116D0;
	Sat, 28 Feb 2026 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772306928;
	bh=/Vzwo35NT2Uen8+FxmqZVjPz8lUb3txhetkjxDXQzFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i/eHUEY5oLD4ObIWIrjd5jN4DhD9M/3VNmnaJgZTGRUZDGZY/3Td4TjTEKShF5cVA
	 +jZTulLu6nLwKMbqK4RMN08hQIk7KADG7CfHgqZaJJlx0TIS+OpCml6K+SEl20ZEWw
	 ouBEcHY0mPdqBEpMr17it3Xqt3HKTFElin34sNVu0uumKTwrxvHxP268ETVo7Pn/dJ
	 NtTmJnULITrl4Sbj9fKP3iHyB6//jdeGGmoRoBhV/aJ7UjQQ/DUP6Gn3NxvP/GRIB3
	 91t1OLVniMgz8tZ8h9AE4Z7PYFAWHwE6oaIOBQ3B6PiOX5XPJhetiAUPvp2MwJQMcM
	 b/I6uInZq+0xA==
Date: Sat, 28 Feb 2026 19:28:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Neel Bullywon <neelb2403@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki"	
 <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] iio: pressure: mpl115: add system suspend/resume
 support
Message-ID: <20260228192839.106daac4@jic23-huawei>
In-Reply-To: <d09f49f7d7643fae6cba6d7b140302cd9c38a62f.camel@crapouillou.net>
References: <20260221172601.77818-1-neelb2403@gmail.com>
	<20260222164008.7fed0ff4@jic23-huawei>
	<d09f49f7d7643fae6cba6d7b140302cd9c38a62f.camel@crapouillou.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Feb 2026 19:32:38 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi,
>=20
> Le dimanche 22 f=C3=A9vrier 2026 =C3=A0 16:40 +0000, Jonathan Cameron a =
=C3=A9crit=C2=A0:
> > On Sat, 21 Feb 2026 12:26:00 -0500
> > Neel Bullywon <neelb2403@gmail.com> wrote:
> >  =20
> > > The driver currently only implements runtime PM callbacks to
> > > control
> > > the shutdown GPIO, but lacks system suspend/resume support. This
> > > means
> > > the device may remain powered during system sleep, wasting energy.
> > >=20
> > > Add system sleep PM ops using pm_runtime_force_suspend() and
> > > pm_runtime_force_resume() to properly synchronize the runtime PM
> > > state
> > > across system suspend/resume cycles. This ensures the shutdown GPIO
> > > is
> > > asserted during system sleep when the device has a shutdown GPIO
> > > configured.
> > >=20
> > > Signed-off-by: Neel Bullywon <neelb2403@gmail.com> =20
> >=20
> > Interestingly for the non exported version we have
> > DEFINE_RUNTIME_DEV_PM_OPS()
> > and the docs for that suggest we should use
> > EXPORT_RUNTIME_DEV_PM_OPS() but as you've realized that doesn't set
> > the
> > suspend and resume callbacks. If that was intentional then the
> > documentation
> > is less than clear (and I don't remember that being the intent)
> >=20
> > +CC Paul and Rafael.
> >=20
> > We have very few users of these macros, so it should be easy enough
> > to
> > make the export variants consistent if we want to. =20
>=20
> Looks like the users are all in IIO which makes it even more
> convenient.
>=20
> It's been a while so my memory is fuzzy, but it would make sense to
> have the suspend/resume callbacks, indeed.

Ok. Neel, would you mind preparing a set to make=20
EXPORT_NS_RUNTIME_DEV_PM_OPS() set the SYSTEM_SLEEP_PM_OPS()
as well?  If you can take a look at the existing callers and
shout if there any problems with this change, even better!

I foolishly always thought they were doing this so I 'think'
it'll be fine to make this change.  Also avoids the license
change thing Paul noted below.

Thanks,

Jonathan
>=20
> > Jonathan
> >  =20
> > > ---
> > > =C2=A0drivers/iio/pressure/mpl115.c | 6 ++++--
> > > =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/pressure/mpl115.c
> > > b/drivers/iio/pressure/mpl115.c
> > > index 830a5065c008..29794ce53bc6 100644
> > > --- a/drivers/iio/pressure/mpl115.c
> > > +++ b/drivers/iio/pressure/mpl115.c
> > > @@ -244,8 +244,10 @@ static int mpl115_runtime_resume(struct device
> > > *dev)
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > -EXPORT_NS_RUNTIME_DEV_PM_OPS(mpl115_dev_pm_ops,
> > > mpl115_runtime_suspend,
> > > -			=C2=A0 mpl115_runtime_resume, NULL,
> > > IIO_MPL115);
> > > +EXPORT_NS_GPL_DEV_PM_OPS(mpl115_dev_pm_ops, IIO_MPL115) =3D {
> > > +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > > pm_runtime_force_resume)
> > > +	RUNTIME_PM_OPS(mpl115_runtime_suspend,
> > > mpl115_runtime_resume, NULL)
> > > +}; =20
>=20
> One thing I noticed is that now the symbols are exported as GPL, which
> is probably fine (better than the other way around) but if that was on
> purpose, it should at least be mentioned in the commit message.
>=20
> Cheers,
> -Paul

