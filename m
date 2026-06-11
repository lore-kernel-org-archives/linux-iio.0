Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB9383313;
	Thu, 11 Jun 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197764; cv=none; b=C01oT8UpqnYFNkC9zePn+E5X17xmCrkstRIl5akrwIxg/dSnQz5B1VAO2OGiJ8cKHD5rCuB1SkB2TlOJwf8MYKTJJgrVQ5YOFnMzTu0Ga8uzI1LSTDWUmXw1xvmqWZuJ7AoWaznNn238ll8usq0wrsg1Yf+gNU7yAYSIFSOdqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197764; c=relaxed/simple;
	bh=57JWXQKEUu5sflbwXfYeMVHUNcxQKSHcXvJ3/fBVOkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOdg6E4E6+Nv98OkX4ddnfeRrmMH/2SU+4MZjEoUD0fJYU1wPB79NrbnvoBo+1KekvRxk6yWO7SQZO34ImezBNG9sCO7Dxfq9a4f2oVZm6bTw6wImXfjtMf8ibv2478LRANid4vOMej3b6iAOvlur6vegcDP5JyHal4wQjiL71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1EMNY+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1EMNY+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89EF1F00893;
	Thu, 11 Jun 2026 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781197763;
	bh=qxSgrBU6UhzfGJhuHY4j9tFUchVICbNGzthxmYtLpMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W1EMNY+95jxz+IfunpDiKPj6FEZUJBRt+/jtxNRDVrT8iksbR2DfabWFgwvdlvbeq
	 a7dJyBgvXqfkDn+VoGzt/OuutFf75npOvzEzSZPWarVnkkbo8ZXewspxb8U+kvzGjP
	 avAApMcM3tfOmhKBp3ic9K47Xn2wCkBKYxQed+JwKzY9OvwN8ZsSVCkMO48uy/usrx
	 /bo0cAV1aFV0OWyCwxrs54QBTFuoFIL6NcygdbFE9CrlEZyuaJa0G+Aki5osStSXdq
	 qZI2wUpttSS1K+50J9wMMtOkWllcnv9ibXt62WSEyc01ZJ0Z/hlH4GrVnuDJlvrNLt
	 Z+NnLIjLLWddQ==
Date: Thu, 11 Jun 2026 18:09:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML
 schema
Message-ID: <20260611-spoken-prewar-b5a4b94787cd@spud>
References: <20260610110051.1228-1-shofiqtest@gmail.com>
 <20260610165640.411c1477@jic23-huawei>
 <20260610-cytoplast-pessimism-dea888887526@spud>
 <20260611140640.4b144bc2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wBSfdhl4raE88nCA"
Content-Disposition: inline
In-Reply-To: <20260611140640.4b144bc2@jic23-huawei>


--wBSfdhl4raE88nCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 02:06:40PM +0100, Jonathan Cameron wrote:
> On Wed, 10 Jun 2026 17:40:04 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Jun 10, 2026 at 04:56:40PM +0100, Jonathan Cameron wrote:
> > > On Wed, 10 Jun 2026 14:00:51 +0300
> > > Md Shofiqul Islam <shofiqtest@gmail.com> wrote:
> > >  =20
> > > > Convert the STMicroelectronics LIS302DL/LIS3LV02D accelerometer dev=
ice
> > > > tree binding from plain text format to YAML schema format.
> > > >=20
> > > > The binding covers two variants matched via their respective bus dr=
ivers:
> > > > - SPI: st,lis302dl-spi (drivers/misc/lis3lv02d/lis3lv02d_spi.c)
> > > > - I2C: st,lis3lv02d   (drivers/misc/lis3lv02d/lis3lv02d_i2c.c)
> > > >=20
> > > > Document all vendor-specific properties read by the driver via
> > > > of_property_read_*(), including click detection, IRQ routing, free-=
fall/
> > > > wake-up engines, high-pass filtering, axis remapping, output data r=
ate,
> > > > and self-test limits.
> > > >=20
> > > > Also correct the click threshold property names: the driver reads
> > > > "st,click-threshold-{x,y,z}" but the old .txt documented them as
> > > > "st,click-thresh-{x,y,z}".
> > > >=20
> > > > Validated with: make dt_binding_check   DT_SCHEMA_FILES=3DDocumenta=
tion/devicetree/bindings/iio/accel/st,lis302dl.yaml
> > > >=20
> > > > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com> =20
> > >=20
> > > Hi.
> > >=20
> > > So the conundrum here is whether we want to keep carrying this binding
> > > as it dates to a previous era.
> > >=20
> > > The driver never made it to IIO and is still in drivers/misc.
> > > The majority of what is the text document should never have been
> > > in DT in the first place. I'll guess this dates all the way back
> > > to the wild west days before we had regular binding review. =20
> >=20
> > I'd say this should be treated like a staging binding but for the fact
> > that this has a user in arm. Problem of course is that it's probably
> > impossible to get that board and so doing any rework is probably not
> > realistic for this submitter?
> > Is there a general policy for iio devices in misc? Do they get reworked
> > to be moved?
>=20
> It is tricky if we have upstream users because the ABI will change on the=
m.
>=20
> I'm not sure how easy this would be to add to the existing st sensors dri=
ver
> as these are very early parts.  If we could maybe we'd do so and just deal
> with the mess of having to disable one or other driver.=20
>=20
> My gut feeling here is ancient part, let it get dropped in a year or
> two and not worry about adding support to a standard IIO driver unless
> anyone actually has hardware and wants to do it.
>=20
> >=20
> > The user funnily enough has the binding's click-thresh properties:
> > 		st,click-single-x;
> > 		st,click-single-y;
> > 		st,click-single-z;
> > 		st,click-thresh-x =3D <10>;
> > 		st,click-thresh-y =3D <10>;
> > 		st,click-thresh-z =3D <10>;
> > 		st,irq1-click;
> > 		st,irq2-click;
> > 		st,wakeup-x-lo;
> > 		st,wakeup-x-hi;
> > 		st,wakeup-y-lo;
> > 		st,wakeup-y-hi;
> > 		st,wakeup-z-lo;
> > 		st,wakeup-z-hi;
> > Dunno what that ultimately means in terms of which should be used
> > though.
> Set those as defaults in the driver if all upstream users have those
> values and then drop reading them from dt?

Actually, there's more than one user in arm, but there's a mix of
compatibles and properties used. Probably not really viable unless these
are all unique compatible + property combinations. FWIW, there's more
compatibles used than those documented, that fall back to the documented
ones.

--wBSfdhl4raE88nCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCairrvgAKCRB4tDGHoIJi
0j/iAQCcKjp5crpOUIhPRrQfv3cZzFpx8GwRdWjPB0Q2IzrXqAEAiHYVxZMcLtKX
QjMnLbKKAJ5WSKw6vsC2p3NLLJS9mQk=
=fqlj
-----END PGP SIGNATURE-----

--wBSfdhl4raE88nCA--
