Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4653403F3;
	Wed, 10 Jun 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109611; cv=none; b=tuT3PYQl2biMiNQVwpbWF+guDKPlcL47nnXv9WBD4CPb51TWmD64UwqQefH4H6Nbf2h6gf1A4bqkamq08VFxKTx4oEYUsisVkh8wZsw4k5a2H5T5VsGxueUrgRrXuiZFGGLXM3B418SouvHPElNldpuwmGgPBqaVr6oBkrJzDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109611; c=relaxed/simple;
	bh=nU1z4/2jYS0ts535BlBVbl9gu2e8Hj1RELMs1z3VxVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9eTUeMceX4YjAiHNm1Eosltht4UzF0C12z6bxxsqzoJBTW0+8ECplDTeKTJt8+oc55Z5UK2ZL4pCmhAMljJh8y7Q7uGBMwozUabNZe5MVU9ZvbSx/8TZmoTfVp+AKreNqShPw8QIPKOB3mOXa5iJde6LcLGN79WHcJQrwxWH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxl4Pb5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxl4Pb5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55C61F00893;
	Wed, 10 Jun 2026 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109610;
	bh=6K53fYIzePRMi3VKw2KNkHC9Iei0sXsajuMmd1hOxjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wxl4Pb5AlvyA50000Phkxu+BoSnzrctNyPP9TPE391xbvsHu+ZbNyCck93UltaS/V
	 g1cgXFUNZzarzElz2XW/6Olqe5nAekvajXNoBwMXCpej/EZfbmzqE+VV16UgVI39i6
	 2HpUmom/stpNq53hRXfmkQtykcrAsYeCVa2yi57vCumlS3O4GBUxy3MwzzSnDe8DiD
	 7ybfTeB11RcSIwBOoV8KMXBYwCyK7JYrdXL079K2gK7nOY9ZoPfMQs80bRmBI7UWmI
	 6jvayWs+87l2popZTgJ+uX7iFSYCYOApxg70OUY1VMO2wSmDZJH9802Q4ETi4AXD7R
	 z42dJupoeLufQ==
Date: Wed, 10 Jun 2026 17:40:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML
 schema
Message-ID: <20260610-cytoplast-pessimism-dea888887526@spud>
References: <20260610110051.1228-1-shofiqtest@gmail.com>
 <20260610165640.411c1477@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VpX2iA/EHztjt9DW"
Content-Disposition: inline
In-Reply-To: <20260610165640.411c1477@jic23-huawei>


--VpX2iA/EHztjt9DW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 04:56:40PM +0100, Jonathan Cameron wrote:
> On Wed, 10 Jun 2026 14:00:51 +0300
> Md Shofiqul Islam <shofiqtest@gmail.com> wrote:
>=20
> > Convert the STMicroelectronics LIS302DL/LIS3LV02D accelerometer device
> > tree binding from plain text format to YAML schema format.
> >=20
> > The binding covers two variants matched via their respective bus driver=
s:
> > - SPI: st,lis302dl-spi (drivers/misc/lis3lv02d/lis3lv02d_spi.c)
> > - I2C: st,lis3lv02d   (drivers/misc/lis3lv02d/lis3lv02d_i2c.c)
> >=20
> > Document all vendor-specific properties read by the driver via
> > of_property_read_*(), including click detection, IRQ routing, free-fall/
> > wake-up engines, high-pass filtering, axis remapping, output data rate,
> > and self-test limits.
> >=20
> > Also correct the click threshold property names: the driver reads
> > "st,click-threshold-{x,y,z}" but the old .txt documented them as
> > "st,click-thresh-{x,y,z}".
> >=20
> > Validated with: make dt_binding_check   DT_SCHEMA_FILES=3DDocumentation=
/devicetree/bindings/iio/accel/st,lis302dl.yaml
> >=20
> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
>=20
> Hi.
>=20
> So the conundrum here is whether we want to keep carrying this binding
> as it dates to a previous era.
>=20
> The driver never made it to IIO and is still in drivers/misc.
> The majority of what is the text document should never have been
> in DT in the first place. I'll guess this dates all the way back
> to the wild west days before we had regular binding review.

I'd say this should be treated like a staging binding but for the fact
that this has a user in arm. Problem of course is that it's probably
impossible to get that board and so doing any rework is probably not
realistic for this submitter?
Is there a general policy for iio devices in misc? Do they get reworked
to be moved?

The user funnily enough has the binding's click-thresh properties:
		st,click-single-x;
		st,click-single-y;
		st,click-single-z;
		st,click-thresh-x =3D <10>;
		st,click-thresh-y =3D <10>;
		st,click-thresh-z =3D <10>;
		st,irq1-click;
		st,irq2-click;
		st,wakeup-x-lo;
		st,wakeup-x-hi;
		st,wakeup-y-lo;
		st,wakeup-y-hi;
		st,wakeup-z-lo;
		st,wakeup-z-hi;
Dunno what that ultimately means in terms of which should be used
though.

--VpX2iA/EHztjt9DW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaimTZAAKCRB4tDGHoIJi
0ujBAQD+bLuNLaxrQr1IuXSkMlh8vJ7cW/WsI9rV/kIRxQGxrwD9Gc8tk4zk09mW
s8vOug6gHHjHCmkI0OARu6xf80ZqBAs=
=aWJj
-----END PGP SIGNATURE-----

--VpX2iA/EHztjt9DW--
