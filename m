Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299179;
	b=vFK4LR4iA0j5i9C4lRb6bYb0AaL8P/K51K+qvkdfYyFbGoCBShjB96IviJxv/g3MY+Q1
	 TeUpqyGbvgVp8KGUVIvmxbT7uzwNMeD2RWXXRwB1YWBydtA2rmaFt7DNq+LunjFSr4K7J
	 D1k7B8yHnwUkOiOs4MjwBbm7Qjf08KbtUk6OP9zWhyRgszaQ5AYwhT/VBsmrXeoC6rSkV
	 vN6tHGrd1Q6+WV7ccbI7MqNP1HE4BOkRyD0PAKZusS42/InvDQOA4a9p27NuXxrPoj4TD
	 nMStDKrsLMV6KbDdATcavW8yQe7Lp5GtxAQmX2hffotqlW7Dax8gSDacPadulTUZc5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299179;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IrWjpFOSin0IndP+BnNBaUo0YqHRWBYSKdjWN0hgW+U=;
	b=Ep/EgmZMT2a12xxKFLenR2nyD+DU+0jNWJhDD9MACQoEP+wSn/itE0CCrj4AnZldmN0A
	 qWWKpGg6amXgGKavXZaXS/fE+O+JAjE72iBX0Z2hPjUfiD9iLmwZzMcc+k3laDkUf6Txf
	 TSu16a1hYkkDCKsIvzkaLRezcap384OEiVhJxRqvtMVavHklYpv7ukwdMsjoCEYOz6Yyn
	 0pFio98+P2a6NgNBGBBJvyV+3ljPGiNsDRtgZhc9XRjoyIJBvt57pIMDyZc35pjjRURgw
	 0pghN0rCXQhvbIMGb4pb8A3+iG6tYxjeNrtof0VoNTiYBfJ5KPhJGu+DZwU2JSgivPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kaKEu/fy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA60606A320;
	Sat, 21 Nov 2026 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaKEu/fy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BB11F000C0;
	Sat, 21 Nov 2026 22:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795299179;
	bh=IrWjpFOSin0IndP+BnNBaUo0YqHRWBYSKdjWN0hgW+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kaKEu/fyBs5YfNqbkJ6xVdXmd9ZDSt4em5geygs4xRgj8B9Q+oeLx5PNoJG75gw8x
	 2iIORo6fDOMs5TTV3nVoVL6/zUvD8AJig9cEPCnAEKirewCluicRbvBbdLR/ksIMZJ
	 8eHWq1V/QjDkDz6QAEwq5YDZ3arDOAV69IqH+s1e7xaq0JSfBLNk6tZajULgkcfY03
	 iTrTMg2za3BPmoxSnz426N/dG9IN+ot54X3gdf5dtss424gvf9FfSnVjcFs9kVj8Nu
	 Cw6GP/GrcTa83ej5ttuMpINPnBR+BI/hKfSVI7V+vMeo97RGa9L3G8D9ARS1LCfJwt
	 Ox6qW5NvgCIcg==
Date: Sat, 21 Nov 2026 22:12:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joe LeVeque <joe.l@reflexrobotics.com>, jean-baptiste.maneyrol@tdk.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: inv_icm42600: return -EBUSY for
 temperature reads when idle
Message-ID: <20261121221249.7eec65d6@jic23-hlaptop>
In-Reply-To: <awGxj7xP6oTlkUt0@ashevche-desk.local>
References: <20261120020850.24318-1-joe.l@reflexrobotics.com>
	<20261120020850.24318-2-joe.l@reflexrobotics.com>
	<awAT-ofy0p_uhvGN@ashevche-desk.local>
	<CAJLMkXafYtUx7gXE8g-sJ0keGW8eSrVGPc2ao5EzjkxZ-nN2cA@mail.gmail.com>
	<awGxj7xP6oTlkUt0@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Nov 2026 16:58:23 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 20, 2026 at 10:32:52AM -0800, Joe LeVeque wrote:
> > Hi Andy,
> >=20
> > The -EBUSY here is consistent with the existing invalid-data case in
> > inv_icm42600_temp_read(), which commit dfdc31e7ccf3 (=E2=80=9Ciio: imu:
> > inv_icm42600: change invalid data error to -EBUSY=E2=80=9D) changed from
> > -EINVAL to -EBUSY for the same situation (both accel and gyro off).
> > Patch 1 returns the same error for the stale-data case, so userspace
> > sees one consistent response.
> >=20
> > https://git.kernel.org/torvalds/c/dfdc31e7ccf3 =20
>=20
> I see, but even if it's used otherwise, perhaps we need to consider to re=
place
> in both places (or rather replace existing one first).
>=20
> What about using ESTALE?
>=20
> > On Fri, Nov 20, 2026 at 1:33=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote: =20
> > > On Thu, Nov 19, 2026 at 06:08:49PM -0800, Joe LeVeque wrote: =20
> > > > The temperature sensor only measures while the accel or gyro is on.
> > > > With both off, its data register keeps the last measurement, so a
> > > > temperature read returns stale data. On an ICM-42688-P, a value hel=
d at
> > > > about 52 C was returned while the chip was at about 62 C. The data =
only
> > > > reads as invalid before the first measurement after power-up.
> > > >
> > > > The temperature is the die temperature, used for accel and gyro
> > > > compensation, so return -EBUSY when both are off instead of stale d=
ata. =20
> > >
> > > Hmm... EBUSY means they are doing something and kinda hints user to c=
ome again.
> > > Would this condition change on its own if user comes again later with=
 the same
> > > request? =20

We use EBUSY for failure to claim direct mode as well.
In that case it doesn't clear on it's own as typically requires some
state changes such as disabling the buffers.

So I think this is at least consistent with the subsystem.

However, we might have drivers that use this for things that should
actually be retried, though in those cases I think EAGAIN is more
appropriate.

This type of condition is tricky to describe well.  Whenever I've
though hard about this I've ended up with EBUSY even when user
interaction is needed to clear the busy.

Jonathan

>=20
> ...
>=20
> > > > +     /*
> > > > +      * The temperature sensor only measures while the accel or gy=
ro is
> > > > +      * on; with both off, its data register holds a stale value.
> > > > +      */
> > > > +     if (st->conf.gyro.mode =3D=3D INV_ICM42600_SENSOR_MODE_OFF &&
> > > > +         st->conf.accel.mode =3D=3D INV_ICM42600_SENSOR_MODE_OFF) {
> > > > +             ret =3D -EBUSY;
> > > > +             goto exit;
> > > > +     } =20
> > >
> > > I would choose one from the below (they all have their pros and cons)
> > >
> > > ESTALE
> > > something like this, but error message is specific about file handle
> > >
> > > EL3HLT
> > > what is level 3? But we have the only user, and it is outside network
> > > and it sounds close to this case, but why not EL2HLT? (Also the users
> > > are outside network.)
> > >
> > > ENODATA
> > > also used a lot, so semantics not so clear, and data is there, but ou=
tdated
> > >
> > > Depending on the answer to the question at the top of my reply, the e=
rror
> > > codes may be EIO, ENXIO, EPROTO, EAGAIN (but if EAGAIN fits to the fl=
ow,
> > > EBUSY also fits). =20
>=20

