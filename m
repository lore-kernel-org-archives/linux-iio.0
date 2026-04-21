Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBB3D6CDA;
	Tue, 21 Apr 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785077; cv=none; b=lv1kaxWW0b5RE3s4pNDKaxkCTRs5SLoSGtBkn6q/1pKChYIekr7PUVCz/M7wlLKLBgGmQVl0CPulnvYf3n/YuMkv1jddYecOxL3FDJsTv1wvAFw16lxE/MAoxJYDLCbNoyAyIi4kVoCLUXSuNRJyklUxHy9x86Zzk6H+8CMjGBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785077; c=relaxed/simple;
	bh=sSP5GcARyyyJNFeG38uOQN3MVrLh4jrtH7tZm2P6oRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeJr6mwXKqPgoOa13/GfT/Y/di4YpUiDBNBdY8ZxX55G85ZL6NR7PXgOkG6+dDVgWHhQNbgd8/5tBFhSX61iz9bMOy27B1nxwTs+pWbsZCxJE5Kpppy058TGV5HqLTKwhdcOKc92P43GbZwqpW1gcaDxAiDyLueVqbIor50jDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmchx5SY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmchx5SY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA824C2BCB0;
	Tue, 21 Apr 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776785076;
	bh=sSP5GcARyyyJNFeG38uOQN3MVrLh4jrtH7tZm2P6oRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gmchx5SYtwZq/eE3a4v55AsTU0fIb3yKN2fRMfnGm/H4Cs1Qe0erBl/3h0dZBTHaC
	 1veGcOql5VbBp0vjPWc7YhztEjcJf+5hI/oAxqRtdfqUz70R9cM/5KWYid2y+Yxm9n
	 WUues0HtclkroawNJLP0NIrZqQWUgRR0HeKFL1T0nCf7ZruOsCmLALGLLJxdZyTCwA
	 TgizjxDD9U4aLk9jYChRQ00t5qbIRbNpEncPNAB8rX5zQjXYy3aAWdhmSi5Zh8iQnz
	 87NcH91paU8tfqVvIX5Y2BCSxMCJ8lkF/Jxwebl7vMDDYuZVCY1Zx1XhetMaENGq/b
	 JtwF9EWHP8Ucg==
Date: Tue, 21 Apr 2026 16:24:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
Message-ID: <20260421162428.30c52309@jic23-huawei>
In-Reply-To: <67B89EF1-C05C-4317-8E8A-A8DB87748457@gmail.com>
References: <20260414192045.3598010-1-sanjayembedded@gmail.com>
	<CAMuHMdXCYxrCoi7zdUfmbgxXwdwiSKB3YczG-odUQLgvUJ9HQA@mail.gmail.com>
	<67B89EF1-C05C-4317-8E8A-A8DB87748457@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Apr 2026 07:23:06 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 20 April 2026 1:36:14=E2=80=AFpm IST, Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:
> >Hi Sanjay,
> >
> >On Tue, 14 Apr 2026 at 21:20, Sanjay Chitroda
> ><sanjayembeddedse@gmail.com> wrote: =20
> >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >>
> >> Use pm_ptr() so the PM ops pointer is automatically set to
> >> NULL when CONFIG_PM is disabled. This avoids unused-function warnings
> >> and follows modern kernel power-management conventions.
> >>
> >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com> =20
> >
> >Thanks for your patch!
> > =20
> >> --- a/drivers/iio/accel/mma8452.c
> >> +++ b/drivers/iio/accel/mma8452.c
> >> @@ -1744,7 +1744,6 @@ static void mma8452_remove(struct i2c_client *cl=
ient)
> >>         regulator_disable(data->vdd_reg);
> >>  }
> >>
> >> -#ifdef CONFIG_PM
> >>  static int mma8452_runtime_suspend(struct device *dev)
> >>  {
> >>         struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client=
(dev));
> >> @@ -1812,7 +1811,6 @@ static int mma8452_runtime_resume(struct device =
*dev)
> >>
> >>         return ret;
> >>  }
> >> -#endif
> >>
> >>  static const struct dev_pm_ops mma8452_pm_ops =3D {
> >>         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_f=
orce_resume) =20
> >
> >You are still getting defined but not used warnings, as reported by
> >the kernel test robot, due to the use of SET_SYSTEM_SLEEP_PM_OPS()
> >and SET_RUNTIME_PM_OPS().  Please define the structure using
> >DEFINE_RUNTIME_DEV_PM_OPS() to fix this.
> > =20
> >> @@ -1835,7 +1833,7 @@ static struct i2c_driver mma8452_driver =3D {
> >>         .driver =3D {
> >>                 .name   =3D "mma8452",
> >>                 .of_match_table =3D mma8452_dt_ids,
> >> -               .pm     =3D &mma8452_pm_ops,
> >> +               .pm     =3D pm_ptr(&mma8452_pm_ops),
> >>         },
> >>         .probe =3D mma8452_probe,
> >>         .remove =3D mma8452_remove, =20
> >
> >Gr{oetje,eeting}s,
> >
> >                        Geert
> > =20
> Hi Greet,
>=20
> Thank you for the review and feedback.
> I will update changes in next version.
>=20
> Thank,
> Sanjay Chitroda

Trivial process thing.  Whilst it may seem less polite than you'd=20
like to me, emails like this just add noise for those dealing with
a lot of review.  Save your thanks for the change log of the
next version (under the ---)

I've not grumped at anyone about this for a few weeks. You just
happen to be the unfortunate victim amongst many who do this!

Thanks,

Jonathan


