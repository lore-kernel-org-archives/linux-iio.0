Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A93ABDA8;
	Tue, 26 May 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814555; cv=none; b=aFWZMqYKYT1opUkUsy9wcO+0608anIfQM1KrMCvLa+meoUSxgfgplw3dLE4nUBacCll897hDqDySSMiXU9qa6pqC2qhXOdVxOERbcdwAINxNx9SaPJrU7qzj0JW86qbMG8J67TwxQMDlXDVVdKxDfwu8BJH/Z4C/5APD4cBGAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814555; c=relaxed/simple;
	bh=YNGSs+Y4XlL7nSodRM8eMvMrQZvTiiDLf4Gr5twxPqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqGPAqCZD2n0oTo6+y4YE6HQZQ/3XcGmtP0VSOzA0Taacyu4VtodxLBYyPNhZD2U47JA+6KleAElVCAPAFPXnXRJ1bp0DuLgGYq0vthSBa4Xyce8JS4j0UiKyfm7AA7fZkFERy6J4BieAd1OSUMJSW8yLts6IkXTZlEysBWdqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzSBUH0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzSBUH0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB2F1F000E9;
	Tue, 26 May 2026 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779814554;
	bh=lZmMU4Z0Bc6HyIWD3UAkfPap7vMKgZEisehMRWO6dJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fzSBUH0jHNCu8BTw8dtn8j2pZTNIZekOak2TLlvzkuyRu/imTi9rdYG0P6ABAF/rN
	 ujrybrg3GKa5OpKPZH6tkNqOMs5RXh4c3+YWxdJUfJDFkwwmf72rNFO0no/XUF4SeU
	 Uj+NvGAlOMJQck/OjL+Xc+JhzaJYf/USBpCmE/Tf/572io0/h+Prz/aoSaP5QrdmQw
	 88zPTNgZrnvfQp8Emrezv9PB8MU8Fb45P5AIkHeXR1vBwwvzONURTBNrk3LFsY2EzO
	 5e3ySc0mqWOp8IkXuBrb1DknM7vBqDxBIsRffJvfALgdXVxb+uWdGjYb9ClQTq4ydX
	 ev8ehrXF9J6qA==
Date: Tue, 26 May 2026 17:55:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Francesco Lavra <flavra@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 8/9] dt-bindings: iio: temperature: Add ADT7604
 support to adi,ltc2983
Message-ID: <20260526-overexert-mollusk-72b080546d5f@spud>
References: <20260525164013.118614-1-liviu.stan@analog.com>
 <20260525164013.118614-9-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UepeDIn4Tmnt6dr1"
Content-Disposition: inline
In-Reply-To: <20260525164013.118614-9-liviu.stan@analog.com>


--UepeDIn4Tmnt6dr1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 07:39:35PM +0300, Liviu Stan wrote:
> The ADT7604 shares the same die as the LTC2984. It repurposes the
> custom RTD sensor type (18) as a copper trace resistance sensor
> and the custom thermistor type (27) as a leak detector, and
> removes thermocouple, diode and direct ADC sensor types.
>=20
> Add adi,adt7604 to the compatible list and introduce two new
> sensor node types specific to this device:
>=20
> - copper-trace@: maps to the custom RTD sensor type (18). Two
> variants: sub-ohm (< 1 ohm, adi,copper-trace-sub-ohm boolean,
> no custom table and excitation current) and standard (> 1 ohm,
> required adi,custom-copper-trace table, optional excitation current
> defaulting to the datasheet recommended value). Primary output
> is resistance in ohms. For > 1 ohm copper traces with a custom table,
> the chip also outputs temperature in millidegrees Celsius.
>=20
> - leak-detector@: maps to the custom thermistor sensor type (27).
> Takes a required adi,custom-leak-detector lookup table encoding
> resistance (uOhm) against coverage data (%). Two outputs:
> resistance in ohms and coverage in percent.
>=20
> Separate node types are used rather than extending the existing
> rtd@ and thermistor@ nodes because adi,custom-rtd is required
> for sensor type 18, and several properties (adi,number-of-wires,
> adi,rtd-curve, adi,rsense-share, adi,single-ended,
> adi,current-rotate) have no meaning for the new sensor types, since
> the configuration is hardcoded, and would need to be explicitly
> forbidden or ignored in the driver.
>=20
> allOf conditions are added to restrict thermocouple, diode, direct
> ADC and active temperature nodes to non-ADT7604 devices, and to
> restrict copper-trace and leak-detector nodes to the ADT7604
> (some parts only).
>=20
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>

If this approach is acceptable to Jonathan, it is acceptable to me.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> +            leak-detector@14 {
> +                reg =3D <14>;
> +                adi,sensor-type =3D <33>;
> +                adi,rsense-handle =3D <&r_sense>;
> +                adi,excitation-current-nanoamp =3D <10000>;
> +                adi,custom-leak-detector =3D
> +                    /bits/ 64 <          0 100>,
> +                    /bits/ 64 <  202020000  99>,
> +                    /bits/ 64 <  285710000  70>,
> +                    /bits/ 64 <  333330000  60>,
> +                    /bits/ 64 <  400000000  50>,
> +                    /bits/ 64 <  500000000  40>,
> +                    /bits/ 64 <  666670000  30>,
> +                    /bits/ 64 < 1000000000  20>,
> +                    /bits/ 64 < 2000000000  10>,
> +                    /bits/ 64 <1000000000000 0>;

My OCD hates that you have gone to some effort with alignment here, only
for this last line's first cell to scupper it completely.

> +            };

--UepeDIn4Tmnt6dr1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahXQlQAKCRB4tDGHoIJi
0vumAQD/kiU4zB8uqBAvwRoiVIFWBEUlJJG9RbWE+WOy7VgKkAEA+Q1GzfUHG/+A
gVJP8weaof7ZbyqKv62EMpnqbO+llQE=
=OyHx
-----END PGP SIGNATURE-----

--UepeDIn4Tmnt6dr1--
