Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106253;
	b=kTG8gD8mO5Z0FvRigCXaC6UA2SEy0pgN4Lr4T4K33AfeUUXbUkuiLSpKF3SiZ7F6l9gF
	 HqJfK3EgXs+/atFEosjQha36msEuScBFa9Phg6srsf42IHF8T0vl4zXYDg8cgPQ/8cMR1
	 7pj4vjtzYT58cLz0WyNZSeL7JyU8M/2QjouIQwqOxVeLH6AX0OXr5SgDYm5H9tRMxDA4S
	 9MAJnN2td+SUwa3UsLTkpO4njB5g4GALbDXc74hJL1fiiWYokEyLjNlwpuCesFSoiFo52
	 BJNL1PD7Vkjcvhy8zrpqrcQJM9Gk+w6r4VyLF49zf4SylL/zQr+lW/KVo+3gP3p5EIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106253;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=htU/F5AEUQsk5vxQUF1U8PnMJ5Hs4GCWD3+jrbz5OR4=;
	b=Iq/zNUmkP/3k6nP41ODQC53yTi9g+iBEntbO+koJ2TbETlCnvq8zZki660qP6zvY15Qe
	 G71AWJCAYZzzW2fRS83mbRiFDaHHJwTUhkwowqbISBvkpmudqrHJteMHxjkypXpm1mszD
	 VayNFYL/gy4cLiiy7wJjIHLP/2KwgCESyLY1ira+J0wN2Gw99tci8HYub3ZDv9z6k/OQb
	 tWmeMYcSCT/C4H7AUSuE79uaF+iBOo+4aSk9E3aASbsBlKQAbj6g+dsWL6jFgyln/yS0K
	 RzFpduC0OjELw9uVW8iSCgNjD5s4iRoq5HJ9IRIYCmBqQhmLcmowo+SnlDIvyN7Rw+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GR+uTe6K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BFA606A324;
	Thu, 19 Nov 2026 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GR+uTe6K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE781F000C7;
	Thu, 19 Nov 2026 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106252;
	bh=htU/F5AEUQsk5vxQUF1U8PnMJ5Hs4GCWD3+jrbz5OR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GR+uTe6KH4SGq10UcCgo6kKVa9S4aRu3KfoF/zuYhh76wu1Z0KS8ywZN8K4gOaVx/
	 PQraR5hvnKuDv8s3oBD7MSvipFe8stWNzb2xcgD8rMqv5JPDrGifZEy4MtgrAu8lpl
	 JzyAbIh62x+C1WRYy82DJKdcOUzOSE+vtOPNxYfjDU7f5hsT+cPEsnc879Hr+nUfki
	 kh2QKQy13S/QX4/KvWyEzz72iWviq383CUcbn1gIC38sZFmyYOEIQ/0Uag/jnrZ71v
	 kA59cq7v0LMjl5e5QzWsWHW62+fD0rZrnzNahjrfldnbAJZ/Af1XwC8poedgaw9OCQ
	 6u+o2MU56/XdQ==
Date: Thu, 19 Nov 2026 16:37:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: stk33xx: add power
 supply support
Message-ID: <20261119-giblet-epilogue-45f554c009ce@spud>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
 <20261117-6768-stk3337-v2-1-92f4c7be3bc6@protonmail.com>
 <20261118-coyness-luminance-6d0c07e843b7@spud>
 <20261119032903.4a0d3bf6@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tnBqYVFrnwBFWXJo"
Content-Disposition: inline
In-Reply-To: <20261119032903.4a0d3bf6@jic23-hlaptop>

--tnBqYVFrnwBFWXJo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 03:29:03AM +0000, Jonathan Cameron wrote:
> On Wed, 18 Nov 2026 18:12:30 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Nov 17, 2026 at 08:08:35PM +0200, Roman Vivchar via B4 Relay wr=
ote:
> > > From: Roman Vivchar <rva333@protonmail.com>
> > >=20
> > > On some boards, the chip shares a power rail with other components. If
> > > that rail is turned off, the chip can't function. =20
> >=20
> > With these issues in mind, probably it should be made required, even
> > though new required properties are an ABI break.
>=20
> I raised the same on v1.  Seems it is used by various boards
> in tree where we don't know which supply it is.  So whilst nice
> to fix we might just be creating some painful build warnings.

Yeah I don't really want to cause more warnings, but if it is actually
the source of issues, warning may get them resolved.

Up to Roman really I guess.

> Can go ahead and 'guess' I suppose or put a fixed supply on it
> in the upstream dts.
>=20
> Jonathan
>=20
> >=20
> > >=20
> > > Add vdd-supply property to document the chip power supply.
> > >=20
> > > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml=
 b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > > index f655a570aac7..114cf87eb54d 100644
> > > --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > > @@ -37,6 +37,8 @@ properties:
> > > =20
> > >    proximity-near-level: true
> > > =20
> > > +  vdd-supply: true
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > >=20
> > > --=20
> > > 2.56.1
> > >=20
> > >  =20
>=20

--tnBqYVFrnwBFWXJo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav8lyAAKCRB4tDGHoIJi
0vSLAPwMj/1u8S4FlhyKo8aV3NWP1unAub+1ycMIQtKA5Y6WWgD/UPoyizUtYC+z
yrQ4ZdtKb51d2wfXRlBkQoc0fU/x0AU=
=9FjN
-----END PGP SIGNATURE-----

--tnBqYVFrnwBFWXJo--
