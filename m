Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777157;
	b=FMP3VvdIf6zNHFSlDqLWYW4cq70EERYMRQA64fo/puZ4eYUFuGmFel8j/ahJVmDe1qKf
	 bBRs4a7hWDEdMttzWm+00ygMw4vBSO+eIN8G2yuaAy3iezdS6mvsEKDDTv1/usMKVf0Pd
	 DrprNUJ+FZkYMM62K43D8DGKOHoapGGsf8CIr2nXIOMViP01s69fB4beILQlxe2UpDJSW
	 VOOCJtZ7M/eQFsXIzFPZ6qHBmK3F12HzdKcsV9TtVV4bc9B+DMR75F5IWdt0nBnPEZ/K2
	 k2dsuc01kn20RU3onqXAoscI5W7blIz2tFHvz3mZHE1g3Ih5Emet4nPclAuXyRJfB+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777157;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sPGd9aFROxOhz1KFda6cV3QjwhmfwJ0s75CjYBEyrrk=;
	b=z4ZJZbFuOhmk1atl+7KgAgmz92O/TGthE3f5gpUq0r87nXzO1rG9ESAOFodKh4aK/uL8
	 uxjSuAFfr6ZLQ5ghXf59Gc73LGCyaxT4jRtF7Kl8cN4mi9dAfuwe1KS1ev3he590vnOHe
	 MUIhXUxVezW/mv2+5jmxxniMY+lwkwb/olZF+k1IZ5dqk/I2uxkJxQb2zCkZFcoZzmAR2
	 Z3u+S1So2/22uMjhRYmYGPtIXnIfcSTuYJrTNUSxV8u00nIf/8VVHs+q7kRQwXy2U82Te
	 Key3tbgPyqEU0jtwQEfEH6Eo/DUL9puQSrlBs2QRO0naE0dCmLOYqpgt4aU291+FrwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYqvYP6Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD3606A31A;
	Fri, 23 Oct 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYqvYP6Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0831F01825;
	Fri, 23 Oct 2026 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792777156;
	bh=sPGd9aFROxOhz1KFda6cV3QjwhmfwJ0s75CjYBEyrrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WYqvYP6ZKJ4Y4UemFOE4AuTFrSWI3JomDirAvL9Da3Ke2KrGDRXWjZVhzuziC4ORR
	 Tm2vFQZ9NRMxUiC3qA2csJDV2of7uuHDPiB+rSHJeHYht6zoZtepfwnJgMJNG8xyuG
	 CMfl4k2/3k0xnisEvDIomqBheiUSsxTABdeC/oLDyzwevo6U7YSvuZExkZhAm0Y/qM
	 9lUKLzh/yIabOUIayzJC8gG/XhZSqEg2p2B4B/JdRBgWtNjr8kLwuhbQsVw4Ef6Q6+
	 g+9kW9a5ceQh28XoSBqJIXmDwl3qUecAEWBMWye0HRuIB89cQN+LiAfrus0tPr5Nco
	 P5TXLa0cMjhQA==
Date: Fri, 23 Oct 2026 18:39:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: frequency: add
 adi,ad9910-axi-backend
Message-ID: <20261023-boss-matriarch-a1953ccaf539@spud>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-3-0ff7f0bff326@analog.com>
 <20261022-banish-scenic-030717ca503e@spud>
 <hx6lt2u5j5yh3iez5zimolukip4a6ak36rdqridrvaz7bb25hw@6blwtzy2iuat>
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
	protocol="application/pgp-signature"; boundary="lGRIL5kI7ggZQ17D"
Content-Disposition: inline
In-Reply-To: <hx6lt2u5j5yh3iez5zimolukip4a6ak36rdqridrvaz7bb25hw@6blwtzy2iuat>

--lGRIL5kI7ggZQ17D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 08:15:07AM -0300, Rodrigo Alencar wrote:
> On 22/10/26 19:38, Conor Dooley wrote:
> > On Thu, Oct 22, 2026 at 12:19:01PM -0300, Rodrigo Alencar via B4 Relay =
wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > Add bindings for the AD9910 AXI backend IP core. The FPGA IP core
> > > interfaces with the data and control pins of the AD9910 DDS, streaming
> > > data from memory via DMA into the 18-bit parallel data port (F[1:0] a=
nd
> > > D[15:0] pins), which is clocked by the PDCLK output of the device. It
> > > also drives the PROFILE[2:0] pins and the DRCTL pin, which controls t=
he
> > > slope direction of the digital ramp generator (DRG). The DRCTL pin is
> > > driven by a PWM generator, so the IP core is described both as an IIO
> > > backend and as a PWM provider.
>=20
> ...
>=20
> > > +  '#io-backend-cells':
> > > +    const: 0
> > > +
> > > +  '#pwm-cells':
> > > +    const: 3
> > > +    description:
> > > +      The first cell must be 0, as only the DRCTL PWM output is avai=
lable.
> >=20
> > I was about to ack this, but the wording here caught my eye. Are there
> > other PWMs that are unavailable?
>=20
> Not for this version of this core. Other signals to control the DDS could=
 be
> modeled as PWM, e.g. DRHOLD, PROFILE0, OSK... but that is not being consi=
dered
> at this stage.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

(But maybe consider rewording so that it doesn't sound like there are
other PWMs that cannot be used)

>=20
> >=20
> > > +      The second cell is the PWM period in nanoseconds and the third=
 cell
> > > +      holds the PWM flags.
>=20
> --=20
> Kind regards,
>=20
> Rodrigo Alencar

--lGRIL5kI7ggZQ17D
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatubvgAKCRB4tDGHoIJi
0vKSAQDQFFHMyIEfY+UgNmbkTiIL1nyt6ylahe3+fmkcT8fIxAD/Tcw/FliHpwOB
As/ewbCO71uqlme5mpXhT1RCHhK8qgw=
=moiI
-----END PGP SIGNATURE-----

--lGRIL5kI7ggZQ17D--
