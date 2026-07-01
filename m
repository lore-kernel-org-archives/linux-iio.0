Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A43B27EE;
	Wed,  1 Jul 2026 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899058; cv=none; b=IfJ3VHhUkJ9Oroej/iTaC2t6FCgS3ph52Mc0UdU/MZUejMXbWX0IET2bp2e9bJGMzyBRocffWY2Ama4K2fhOEUUvUALxZbvoflvCDwcte7FTB8ohmy80Sj+9J17UxWf4TV6X696PUDt43wHmwCT75hJHjeINdDCDCCV3kI8yJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899058; c=relaxed/simple;
	bh=L6gkE72ufhclaMsI9upfCCNyGuXGgsjo3LbkP0RV2nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Razp98PZF0S8TUBGg3wtHNi9BJsVkkAqS1T/R51WhoBexkzCPm6wwT/+yRuZlG1AN2kQf1WA5QUAxDsxuMuR//g9gUP+o+E9zhBIiDjlLpMtU2k/vC//+TqhqHabLmd6Cc89GrBblfuRNVkEF2BastJtDbu0+7Ux9w/G4CoQOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoKche5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoKche5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11781F000E9;
	Wed,  1 Jul 2026 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899057;
	bh=pdPYIL3HALxZogHYg0wjFJy2CbGUybJni4StUn9EnZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BoKche5ZxfRqJ9lbhZ1h7tEhVaEhxuOvJPRI2Vauwh8RZw5BhkISbdiJGOiyjHOYZ
	 0vjdkZWVL8bORczFhKTZmzCLdfpYj8YQOFUEJNVyn/Lw1gx2o8pQ1CVHEhAkAq7XBx
	 t+7YnM88YthN0QEly28funTYqOsCfvOyuJp9JPVnk11wGkc8nb8f8Z+9UOet80cejX
	 vh8pcIYToGdadBHc7E0hQ3oPudIA4waAQCiHQZvfhY86Cr4RG3sP3+rIxk3PLPcd1V
	 akHtJUazJuqPm5UktfVPA55tHjfun62zimeIslcUIvDxbcM0hfB5GFhz0M6oErImFK
	 aW2BkXA8mjL4Q==
Date: Wed, 1 Jul 2026 10:44:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mike.looijmans@topic.nl, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,ads1298: add ADS1299 EEG
 ADC variants
Message-ID: <20260701-relic-urologist-87fd855061cf@spud>
References: <20260630140311.1473031-1-shofiqtest@gmail.com>
 <20260701001428.1670e3cc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RoLiFFBC7RdAvuci"
Content-Disposition: inline
In-Reply-To: <20260701001428.1670e3cc@jic23-huawei>

--RoLiFFBC7RdAvuci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 12:14:28AM +0100, Jonathan Cameron wrote:
> On Tue, 30 Jun 2026 17:03:10 +0300
> Md Shofiqul Islam <shofiqtest@gmail.com> wrote:
>=20
> > The ADS1299, ADS1299-4, and ADS1299-6 share the same SPI interface
> > and register map as the ADS1298 ECG ADC family but are designed for
> > EEG and biopotential measurement.  Key differences from ADS1298:
> > - PGA gain up to 24x (vs 12x for ADS1298)
> > - Internal reference is always 2.4V (no 4V option)
> >=20
> > Add compatible strings and update the vref-supply description to
> > document the ADS1299 reference voltage behaviour.
> >=20
> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
>=20
> > =20
> >  maintainers:
> >    - Mike Looijmans <mike.looijmans@topic.nl>
> > @@ -17,6 +22,9 @@ properties:
> >    compatible:
> >      enum:
> >        - ti,ads1298
> > +      - ti,ads1299
> > +      - ti,ads1299-4
> > +      - ti,ads1299-6
>=20
> As the channel count is a discoverable feature (encoded as a field in the
> ID Register, I think we can use just the one compatible).  FWIW it is
> nice to see a manufacturer making this discoverable!  I'd expect any
> future drop in parts to vary the other part of the ID, but this field
> should be respected - as such this doesn't fall into the stuff I've been
> discussing with DT maintainers about fallback compatibles needing to
> be specific (I'm way behind so not sure where that thread got to!)

I forget that thread too, but I think the difference is discoverable ID
versus discoverable capabilities. If you match on a generic compatible
with a new discoverable ID you've got no idea how to handle it. Matching
on an existing specific compatible with a new ID, you treat it as the
existing device. Matching on a generic compatible with the ability to
discover the channel count, you know what to do.


--RoLiFFBC7RdAvuci
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakThbAAKCRB4tDGHoIJi
0qvMAQCJ69bB5L3ocBA6VKhb4Wr9dF1buVfCYfzqkr76eKFUrQEA7LN3v7YQXcuW
Q0UlZmdAvhGtveWrDdS/gRU8P7DlWAI=
=ZT6k
-----END PGP SIGNATURE-----

--RoLiFFBC7RdAvuci--
