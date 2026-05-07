Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8523F9F41;
	Thu,  7 May 2026 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162979; cv=none; b=hkQxX3JW2H0Q2CiGQYX/SBaD/ebGCt62+0U8ibsnMSRrlwuDl92QiGGBdXVXNEaxoLDl3+rhhvaav7Hxxx6JslC7co7KGdPzgkcWyDtifLQ8qf0X3UCAaxv7vG86POySY8SaCTpjYvVrDjBdF1yoRfyKoRWnEStgzQWnhwtxk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162979; c=relaxed/simple;
	bh=ePTub+l+dmEw8eLwvn4wyKLaBUBGl7v4gpWQPJ2imJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pD+gtR3gaieZ9jiiYt5WS4YLbLXDFKAd+xK4M99W4Y6HZ6a6NJBUscBqpzVMoqSC7Egjo7HUoUekocTOhnH60RsFVng7B85a3sTld0rlbnBx2yC8XFMplCWqlPIeorJelsUO5VCRw72SSXS7Gi9cWtS0gnQcDpNSUhbvDyIXpNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvLR6X90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvLR6X90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE7BC2BCB2;
	Thu,  7 May 2026 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778162979;
	bh=ePTub+l+dmEw8eLwvn4wyKLaBUBGl7v4gpWQPJ2imJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvLR6X90qQX1kGs4+n3LBtIGKSfRKsTrzZbBEYAJ1j1OJ7jAc8ON5FTWxCDYrLnfy
	 U0bPuBFJBaHEfZ8Jbsk3y0PY0n4lIkTQiH8ZlFHaHUpGcnf4DhYFeCqaD8j00LpyPi
	 mUbWqwCt3KgDzBAt8ATEHGdA4clkK9v+ZcoWh1uF6oeF3eJtNY/JXr14srEOfaxNnO
	 J2FoAD4J2UbS3QcpGGLY5OIyhmF9uPODi+uhvY2knEaqpIt/WH+Xq8d6bbS6ppyd/K
	 xQ3THEqieITQcYOUq5ihI0VwwYdh0qVQfNNi2Bo3wmkSdES14lonuUFV6CgA087lie
	 DDCjuAOkJ0aiw==
Date: Thu, 7 May 2026 15:09:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Uwe Kleine
 =?UTF-8?B?S8O2bmln?= <u.kleine-koenig@baylibre.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Message-ID: <20260507150930.0f13a8a5@jic23-huawei>
In-Reply-To: <LV9PR03MB84140625A4D0D32174303304F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com>
	<LV9PR03MB84144C0FF2FC2197AAFED941F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
	<LV9PR03MB84140625A4D0D32174303304F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 May 2026 13:52:20 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> > -----Original Message-----
> > From: Sabau, Radu bogdan <Radu.Sabau@analog.com>
> > Sent: Thursday, May 7, 2026 3:17 PM =20
>=20
> ...
>=20
> > > =20
> >=20
> > Hi everyone,
> >=20
> > Uhmm..., why was this fix marked as Changes Requested? Is it something =
I am
> > missing?
> >=20
> > Best Regards,
> > Radu =20
>=20
> I have also had a look here :
> https://sashiko.dev/#/patchset/20260428-ad_sigma_delta-fix-v1-1-8e3f925ee=
8d2%40analog.com
>=20
> Therefore here is the reply to Sashiko's review:
>=20
> > For devices that lack the optional disable_one callback,
> > ad_sigma_delta_disable_one() is a no-op. In that scenario,
> > ad_sigma_delta_set_mode() executes the final SPI transfer for the
> > conversion.
> >
> > Because sigma_delta->keep_cs_asserted is still true when set_mode is
> > called, its transfer will carry cs_change =3D 1. Since disable_one
> > does not issue a subsequent transfer with cs_change =3D 0, will the SPI
> > framework skip teardown and leave CS permanently stuck low?
> >
> > Could sigma_delta->keep_cs_asserted be cleared before calling
> > ad_sigma_delta_set_mode() to ensure proper teardown, or should an
> > explicit dummy transfer be added? =20
>=20
> Good catch, thank you. The previous version only moved disable_one()
> after clearing keep_cs_asserted, but left set_mode(AD_SD_MODE_IDLE) in
> the out: block where keep_cs_asserted is still true. For devices that
> do not implement disable_one, set_mode() issues the last SPI transfer,
> so it carries cs_change=3D1 and CS stays stuck =E2=80=94 the same bug rep=
roduced
> on a different code path.
>=20
> Fixed by moving set_mode(IDLE) into the out_unlock: block as well, so
> both calls execute after keep_cs_asserted is cleared. This matches the
> pattern already used correctly in ad_sd_calibrate(), which clears
> keep_cs_asserted before calling set_mode(IDLE) and disable_one() in its
> single cleanup block.
>=20
> ...
>=20
> > I noticed an additional state tracking issue in the error path of
> > ad_sd_buffer_postenable() that wasn't introduced by this patch.
> > When operations like ad_sigma_delta_clear_pending_event() fail, the err=
or
> > path calls spi_bus_unlock() but leaves sigma_delta->bus_locked =3D true=
 and
> > sigma_delta->keep_cs_asserted =3D true. Since the IIO core does not inv=
oke
> > predisable on a postenable failure, this state persists.
> >
> > Subsequent SPI operations like direct mode reads will observe
> > bus_locked =3D=3D true and incorrectly invoke spi_sync_locked(). As the=
 bus
> > is not actually locked at the controller level, this bypasses the
> > SPI framework's bus_lock_mutex.
> >
> > Does this allow concurrent access to the SPI controller from multiple
> > threads, potentially corrupting SPI bus data? =20
>=20
> Yes, the concern is valid. With bus_locked =3D=3D true but the controller=
's
> bus_lock_mutex not held, any concurrent spi_sync() from another driver
> can proceed unobstructed while our driver issues spi_sync_locked() =E2=80=
=94
> exactly the race bus_lock_mutex is meant to prevent.
>=20
> Fixed in the same patch by resetting both keep_cs_asserted and
> bus_locked to false in err_unlock: before calling spi_bus_unlock(),
> consistent with the teardown sequence in predisable().
With that lot in mind I'll drop this version.

thanks,

Jonathan


