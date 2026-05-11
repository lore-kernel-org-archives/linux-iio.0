Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483BF37881F;
	Mon, 11 May 2026 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500999; cv=none; b=qnHX71WDPO1rX5RyU8GK7W2i7iwHViKm0Qcd7R4+e4JSr8pICKRxNM0Bs0er5rADZHc397wtQ53OdZ0kBj6Wrw74sqpsxjtxku/1qIA9rEr+7RY/KljydRJXipJAW+piZAGUnTJV75p49QzrpyYTKYXnkMEJRNK6V9ZQJVlLVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500999; c=relaxed/simple;
	bh=ZPW0CojFwxG11OiesI71H0TFpWkdcU94PWt13h2Iois=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL0ncpjmWKZoGYEH0CPsR2KXctLA6cXL0rzO6gcnDugHVsSlmrtLuBn2zy99VxX3ZLfCvZXQ9sb0z9JQIk6tAGYnJekszL5z12RQJSxRLpW1RUeGso5HPcpSEWfM0WExaM/JQs1Q2EgRIfoKP7JxdDAs+P+/eTmNlakmlQuvfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD6rWrKy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD6rWrKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C5CC2BCB0;
	Mon, 11 May 2026 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500998;
	bh=ZPW0CojFwxG11OiesI71H0TFpWkdcU94PWt13h2Iois=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bD6rWrKyPkEVSPPAawUOV2QzvMliOtSIwfok9E62jCgUNIkvbYPKyJQBdeURtixVO
	 nXasspGm3Soe29P+0wpQzsUm3B/0VCxQYz2qENOc1byd/W55V0yJb+CzEGWuyVVMOx
	 79ryJOfevuACEWFzvcR+L4MHIxVHlBtk21+9Fy3eRq24LM9zDDd9kxgEybuM65d6c5
	 7YFFrtcq9WzOIUDiwswveGAxJ1/C4g60thp3UL3TISwTd+W4ylVLBPivXg0OhVPkYi
	 b0NFkLfzHtxavc4O83F5GTdgsZScg0/oZ50EVJQD71y+ViWxnioG+iyVMy7oa8TTDV
	 PIgLMyCD4Im9g==
Date: Mon, 11 May 2026 13:03:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Tomasz Duszynski
 <tomasz.duszynski@octakon.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero
 error
Message-ID: <20260511130311.52d65bf6@jic23-huawei>
In-Reply-To: <CAKqfh0EfaVqUPbhWZ4hVX_mFUN7_CVwir1sAHrR_LC=ZU7fk6g@mail.gmail.com>
References: <20260509211921.84969-1-m32285159@gmail.com>
	<f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
	<CAKqfh0GXzfUMhp0+-BPpQ3ra3H5jSKUU0g5RnAtKhP88RDocmQ@mail.gmail.com>
	<f3030dd0-123c-4b3d-8b65-148058dfd44f@baylibre.com>
	<CAKqfh0HUttZhhC1ysiA64rxMztBvfuu+d=m2C8TrnCUuWzT4Gg@mail.gmail.com>
	<CAKqfh0EfaVqUPbhWZ4hVX_mFUN7_CVwir1sAHrR_LC=ZU7fk6g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 9 May 2026 19:47:53 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Sat, May 9, 2026 at 4:53=E2=80=AFPM Maxwell Doose <m32285159@gmail.com=
> wrote:
> >
> > On Sat, May 9, 2026 at 4:47=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote: =20
> > > On 5/9/26 4:36 PM, Maxwell Doose wrote: =20
> > > > Yes, we're reading over either SPI or I2C, the sensor supports both.
> > > > Hardware failure is going to be the most likely cause of this path
> > > > being taken, but I could also see some sort of noise on the bus bei=
ng
> > > > the cause. Perhaps we change it to:
> > > >
> > > > /* Likely taken if hardware is failing or noise on bus */
> > > >
> > > > best regards,
> > > > max =20
> > >
> > > Sounds OK.
> > >
> > > A more verbose alternative:
> > >
> > > /*
> > >  * Value of 0 is unexpected, but could happen, e.g. due to
> > >  * hardware failure.
> > >  */ =20
> >
> > Also works for me, I'm impartial to either. Perhaps we can see if
> > Jonathan is willing to change it during merge or if I'll have to go
> > back and change it in a v2.
> >
> > best regards,
> > max =20
>=20
> Also maybe we update to use dev_err_ratelimited(), sashiko has a good
> point here:
>=20
> https://sashiko.dev/#/patchset/20260509211921.84969-1-m32285159%40gmail.c=
om
>=20
Do we care for something that is going to be a very rare hardware failure?
That's one interesting attack vector. I suppose maybe they have another
exploit that lets them trip the scd30 into an odd state.=20

Ah well, doesn't do much harm to rate limit it I guess.

Jonathan

> best regards,
> max

