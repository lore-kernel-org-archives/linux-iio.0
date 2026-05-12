Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4A3A4507;
	Tue, 12 May 2026 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585528; cv=none; b=FB6RJLXZlg3hIUZn7eibVUC1s7AjGK0yaWIEwnIX49dJEBdXChl0e7ko6eJv+rOyex2wQap3pfN54MaOf8RIT9xNWiVZMy2sHK0LqqIB4Xnnpx9yEUQXbBl9pQDkwdNFYbu2Wvn/qtLOFeDmtMfjbzKHSdbee2G1FYhdSPGWkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585528; c=relaxed/simple;
	bh=QYjwpJk+X2kgtgpstMgPDm1ZdZq2P4IToEYTXBf2VDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+fflIYq0xz9etV7aF2jhFMmK0XoRIKexWWkprPnZGH3twbNPzRx4WbVdgwskKroDKC9EfDn2JYAb9XBy+URS8PAXEmc7mWypZDEzg5OkW+6MZJM9TnhNCydAsMQR5Egf6hvjdB90iFl4ZiNPpbN3rAPKURvHLDPrem+cKKY6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqDZxyvI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqDZxyvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3433CC2BCB0;
	Tue, 12 May 2026 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778585528;
	bh=QYjwpJk+X2kgtgpstMgPDm1ZdZq2P4IToEYTXBf2VDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fqDZxyvI6JrOKfdfdd4iLVQ3+oXpcOoTv9xof+TMSly7tqOXVgF+iot1woGgL87eh
	 WYiFbAq5mF4rhRoYvDPPYuKjn37D6R3JrdBWuID/g18H5NWQNciw683qysQk+AI+nl
	 xML9QA4goaGBnY1keqPQbKs5O/WuLd84Gsbb8cm5NikZJMW4Wa7dIywrzLbPHSe2+S
	 zJ2uaJkJ5xUtyP0Acarmoe9zCSH1oWjM2zuZwguQihL+OMbYMIU3s/V8KLwGptZ8A+
	 edr3n0Hm472K2IJLE/VLmcleky6d5B/Xo9Kn1EDYLIYWj2CNa+oefDgmF/VG3nLZl4
	 WVD5cPJJHjzDQ==
Date: Tue, 12 May 2026 12:31:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rodrigo Alencar
 <rodrigo.alencar@analog.com>
Subject: Re: [PATCH v12 07/11] iio: frequency: adf41513: driver
 implementation
Message-ID: <20260512123159.11d7fe6f@jic23-huawei>
In-Reply-To: <svusdjojnunrgjuojwk3htqdudzesnc2owfd5wmbvp56ap22oq@7nr6p7fpozin>
References: <20260510-adf41513-iio-driver-v12-7-34af2ed2779f@analog.com>
	<20260511224355.6ED49C2BCB0@smtp.kernel.org>
	<svusdjojnunrgjuojwk3htqdudzesnc2owfd5wmbvp56ap22oq@7nr6p7fpozin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> >  =20
> > > +static int adf41513_set_frequency(struct adf41513_state *st, u64 fre=
q_uhz, u16 sync_mask)
> > > +{
> > > +	struct adf41513_pll_settings result;
> > > +	int ret;
> > > +
> > > +	ret =3D adf41513_calc_pll_settings(st, &result, freq_uhz);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	/* apply computed results to pll settings */
> > > +	st->settings =3D result; =20
> >=20
> > [ ... ]
> >  =20
> > > +	if (st->settings.mode =3D=3D ADF41513_MODE_INTEGER_N) {
> > > +		st->regs[ADF41513_REG6] |=3D ADF41513_REG6_INT_MODE_MSK;
> > > +		st->regs[ADF41513_REG6] &=3D ~ADF41513_REG6_BLEED_ENABLE_MSK;
> > > +	} else {
> > > +		st->regs[ADF41513_REG6] &=3D ~ADF41513_REG6_INT_MODE_MSK;
> > > +		st->regs[ADF41513_REG6] |=3D ADF41513_REG6_BLEED_ENABLE_MSK;
> > > +	}
> > > +
> > > +	return adf41513_sync_config(st, sync_mask | ADF41513_SYNC_REG0);
> > > +} =20
> >=20
> > If the adf41513_sync_config() SPI write fails, st->settings and st->regs
> > have already been updated with the new configuration.
> >=20
> > Will a subsequent read of the frequency channel via adf41513_pll_get_ra=
te()
> > return this failed frequency instead of the actual physical hardware fr=
equency? =20
>=20
> Not seeing much problem with that. Reversing the state on every spi write=
 failure
> would be too much effort for an error that is already reported to the use=
r.
> Most likely another spi write attempt might fail as well, so would it be =
a platform
> problem?
>=20

Agreed.  It is fair that sashikio raises it as a concern to look at but
as you say unwinding state like this on an spi error is fiddly. I think it's
only necessary if the device ends up wedged as a result.  As long as we can=
 just
try rewriting the original thing that triggered this flow, not a problem.

What to do in cases like when we get errors during buffered accesses is more
of a black art. I'm not inclined to spend much effort and greater code comp=
lexity
to harden against those - the way out can sometimes be unbind/rebind the dr=
iver.


> > [ ... ]
> >  =20
> > > +static int adf41513_write_raw(struct iio_dev *indio_dev,
> > > +			      struct iio_chan_spec const *chan,
> > > +			      int val, int val2, long info)
> > > +{ =20
> >=20
> > [ ... ]
> >  =20
> > > +	case IIO_CHAN_INFO_PHASE:
> > > +		if (tmp64 >=3D ADF41513_MAX_PHASE_MICRORAD)
> > > +			return -EINVAL;
> > > +
> > > +		phase_val =3D DIV_U64_ROUND_CLOSEST(tmp64 << 12,
> > > +						  ADF41513_MAX_PHASE_MICRORAD);
> > > +		phase_val =3D min(phase_val, ADF41513_MAX_PHASE_VAL);
> > > +		st->regs[ADF41513_REG2] |=3D ADF41513_REG2_PHASE_ADJ_MSK;
> > > +		FIELD_MODIFY(ADF41513_REG2_PHASE_VAL_MSK,
> > > +			     &st->regs[ADF41513_REG2], phase_val);
> > > +		return adf41513_sync_config(st, ADF41513_SYNC_REG0); =20
> >=20
> > The ADF41513_REG2_PHASE_ADJ_MSK bit is set in the software shadow regis=
ter,
> > but does not appear to be cleared after the shift completes.
> >=20
> > Because the hardware evaluates the PHASE_ADJ bit in REG2 on every REG0 =
write,
> > could this cause unintended phase shifts during future frequency update=
s? =20
>=20
> We don't need to clear that, if phase adjust is set then the phase shift =
is going
> to be applied. There is no phase accumulation or side effects. I think the
> datasheet could improve on that, but later on it says:
>=20
> 	The phase word in Register 2 controls the RF output phase. As this
> 	word is changed from 0 to 2^12, the RF output phase changes over a
> 	360=C2=B0 range in steps of phase value =C3=97 360=C2=B0/2^12.

Bit of a running theme that AI bots sometime point out unclear datasheet
text ;)  I know folk were using them to scan specifications looking for this
sort of stuff where it's possible humans would also get them wrong.

>=20
> > [ ... ]
> >  =20
> > > +static int adf41513_pm_resume(struct device *dev)
> > > +{
> > > +	struct adf41513_state *st =3D dev_get_drvdata(dev);
> > > +
> > > +	guard(mutex)(&st->lock);
> > > +	if (st->powerdown)
> > > +		return 0; /* nothing to do */
> > > +
> > > +	return adf41513_resume(st);
> > > +} =20
> >=20
> > If the system cuts power to the regulators during sleep, the chip wakes=
 up
> > in its default Power-On Reset (POR) state.
> >=20
> > If st->powerdown is true, this function returns early and st->regs_hw is
> > not invalidated.
> >=20
> > Could this leave the software state out of sync with the physical hardw=
are,
> > causing future partial writes to leave the chip unconfigured? =20
>=20
> That is not an issue because partial writes would not power the device.
> Also the resume() function makes sure to write all registers so a power-up
> sequence is completed.

Makes sense.  Thanks for addressing all these nice and clearly!  Helps me
a lot.  Whilst sashikio is great, dealing with everything it reports is
making reviews take a lot longer.

Jonathan

>=20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510-adf415=
13-iio-driver-v12-0-34af2ed2779f@analog.com?part=3D7 =20
>=20

