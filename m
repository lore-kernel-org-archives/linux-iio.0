Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADA332EBA;
	Sat,  7 Mar 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903348; cv=none; b=N8gs1PpGzn+7Y+pEcwYIKdCGvD1XbDKShx0Ll3HCcHo3S0Bs/c6L/GPkLwxrifVkVhPG6iYNck2JO60CkNpq1QA8S+GRYjuRvdowM6+23xZpvGd5gg+xByiBi2nFONVC6MZi1rnpXpmABYkmgPaWA+lg2n45yGIu+PUgFR9eJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903348; c=relaxed/simple;
	bh=SXOHIylA0cr1kQTEYBDxdEimp3WJ3GULkjWhhYo1DwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryhOgF9uLpRq4iOKU7+5cHywEx2A2bZK6UqztCCtJdgkrnWc5JPnuguaQH6fju2s6NOaNKME18xpXBJIl222pdGht4d7o1jD4P+7KTnWY9J1auXpqLL6MCnyCn1DEpMACTI9bB3gunnHVnH6yENL2htCt7x/0OSooJaEzRvZ8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsdxEXhP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsdxEXhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CCEC19422;
	Sat,  7 Mar 2026 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772903347;
	bh=SXOHIylA0cr1kQTEYBDxdEimp3WJ3GULkjWhhYo1DwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FsdxEXhPxocEEVo1QaSNgdjI4+WrFeA3GXFwJAghHsbWewtEhvC3Sl0AMRKktJdXb
	 FOFWUFP7V2U3Ikxfjud4SC2UrvIOkuk9CB/chMuxzIS/Mi1V9frgUVOLcCYDlr7P6M
	 isykdNEtqQejNOdXCOraLUDj86aM6nM0+xq48icLPgreC1eEcn3BagQteAT2pbUcjg
	 ZEulItWsHfyl55/6mCroNhC5agxAch6y8K/qtxGawX6KlYRYyah3TaE2z6R+RTk8EL
	 bixA0JguV54tjJkmop4BgfyYcnZ8kyVrs3haiTO08T2Pb3GUk3Qf3H9ld8UdLm84es
	 yL2q+VMrXTKHw==
Date: Sat, 7 Mar 2026 17:08:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 puranjay@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: accel: convert to guard(mutex)
Message-ID: <20260307170858.7173b5c6@jic23-huawei>
In-Reply-To: <CANS1UbgiBCH63zv8uQF_EDmct+YCRgiFH+1zA9sskF+tQ_rzEA@mail.gmail.com>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
	<20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
	<20260307102634.6eaafab5@jic23-huawei>
	<CANS1UbgiBCH63zv8uQF_EDmct+YCRgiFH+1zA9sskF+tQ_rzEA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Mar 2026 16:03:58 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> Hello Jonathan,
>=20
> I am sorry for making things confusing, do you want me to re-send V3
> on a new separate email thread?
> Or I should keep this in mind for future patches.
Keep in mind for future patch sets / v4 of this one

Thanks,

J
>=20
> Thankyou,
> Rajveer
>=20
> On Sat, Mar 7, 2026 at 3:56=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sat,  7 Mar 2026 15:47:55 +0530
> > Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:
> > =20
> > > This series converts manual mutex_lock/mutex_unlock pairs to
> > > guard(mutex) in three ADXL accelerometer drivers. Each conversion
> > > also simplifies error handling by removing goto labels and
> > > returning directly where possible.
> > >
> > > v3: Remove remaining goto labels completely as requested by David Lec=
hner.
> > >     Return directly from functions where ret variable is not needed.
> > > v2: Split into one patch per driver as requested by David Lechner.
> > >     Ensured each conversion also simplifies code flow.
> > >
> > > Rajveer Chaudhari (3):
> > >   iio: accel: adxl313: convert to guard(mutex)
> > >   iio: accel: adxl355: convert to guard(mutex)
> > >   iio: accel: adxl372: convert to guard(mutex)
> > >
> > >  drivers/iio/accel/adxl313_core.c | 15 ++----
> > >  drivers/iio/accel/adxl355_core.c | 81 ++++++++++++++----------------=
--
> > >  drivers/iio/accel/adxl372.c      | 16 +++----
> > >  3 files changed, 45 insertions(+), 67 deletions(-)
> > > =20
> >
> > Hi Rajveer,
> >
> > Small process thing.  Please send each new version as a separate email
> > thread.  It can get very hard to follow when we end up with deeply
> > nested threads so most areas of the kernel prefer to just associate
> > them via name of the thread and possibly a link in the cover letter
> > to the previous version.
> >
> > Jonathan =20

