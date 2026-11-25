Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627891;
	b=ZDzKjAt3Db9wghzdu0V/daSpvUPLH68l7S5Xr4Xa2XQH/+RWxYyg9tXuTczMxNSnyHf5
	 Aj4dWAZQxprEL1zf+B9usIDWvuqOshP7zXz5Ogw3xTqseM7Xwvmhsh7wVLUd62OeWQvzQ
	 jc9W9jGXg2eJlY8kUXq+yuJMBoYstLiv5WC+aq31Pu6DTeAvxJDdyT4ZrEgofbu2XggtF
	 xvpf/q/I8XoIvOPL87G1FoAhLFlYc7MxiiuGikKXwSfKWbKIxhoA8vUg+yUA4n6lyGvoV
	 NgwRknszooZx0q8/EJxLdL0ar3wE2+ckuv9pJ9hsmUn13nU/yjENiszyn9axDmLxd7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627891;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XS3eIHi5UuZWCUtDjSvWRCxA/x+dQV/HyQs2ohE6QW4=;
	b=kENAUkGV4KIKoEIonqhksSAQF3j+HT5FGkl654U2lJxPD6nEPmPMtuy5awB4WfyoY7oJ
	 2Mj2ML+0+PHGnVcdgslYQFnTCfus/bfHdQngTLkOa0zJeSLT3TlQoTxmT6qvtKV4xJ/CO
	 ivkbzxdD9L7qUJDraVww8LLI8OIA3yS3NHVjx4BcHEKhE+3tbmSzep7gN/M6SM8Bnebob
	 rzm2+6RNarCtDTSEYyNjH9CTmBLt8Tyf8fxOFixxTr8oF5jg43qf8MFV6d3oDUor06Ofg
	 Qw6coWUy3V+bGhZp4A2N3HI/Xb9JkEOHP3ICuYlKXkoqzPuvtyRyommDZqfB+amg2DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6MlHa5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167A606A32E;
	Wed, 25 Nov 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6MlHa5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3041F000C4;
	Wed, 25 Nov 2026 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627890;
	bh=XS3eIHi5UuZWCUtDjSvWRCxA/x+dQV/HyQs2ohE6QW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M6MlHa5JQNpB+G3v1Ghgo4FVo7W4SDi94YdzFo0n/KoU/WkkQZqm7s6BvMMIoBVgC
	 7FWpHhTtLRi9PiTHG8bhO4n0/c0KRo4pHaHsGTZ59UkRa0fy4PRje8TSKPoIeKgSko
	 z0Gl+IwrJPhdNg//9dFj2c9cqhK/Fc0EJWrgLSNZiaOmiUfiFC+s+xOugluccVpMEa
	 lrJkGqv316FqmHQap+D02K9vUOlOr2LN5j9r/JKMlbWqi27tPEQuv5kDLa8OJpP4SZ
	 RV7avFFRbhumJ6JNQe0GztH8Fp6MII8BnPyhfwvJY7JiUMqtCWTeLLxQifY9vLW+tt
	 1e5Y+llcYJ3VQ==
Date: Wed, 25 Nov 2026 17:31:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Ilyas NHASSE <ilyas.nhasse@skf.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	"linux@analog.com" <linux@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adi,ad7124: make interrupts
 optional
Message-ID: <20261125-antihero-tartness-df3e03c9db01@spud>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
 <20261120-ad7124-no-irq-v1-1-7826c5c3fd25@skf.com>
 <20261120-deflator-purifier-c746b2f9bba6@spud>
 <BR0PR09MB441440387856BA66983FCBD37A89442@BR0PR09MB441440.eurprd09.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="mZgf9zJdIVcx+b3z"
Content-Disposition: inline
In-Reply-To: <BR0PR09MB441440387856BA66983FCBD37A89442@BR0PR09MB441440.eurprd09.prod.outlook.com>

--mZgf9zJdIVcx+b3z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 08:49:14AM +0000, Ilyas NHASSE wrote:
> On Fri, Nov 20, 2026 at 05:46:10PM +0000, Conor Dooley wrote:
> > On Fri, Nov 20, 2026 at 12:26:47PM +0100, ILYAS NHASSE via B4 Relay wro=
te:
> >> The AD7124 signals the end of a conversion on its DOUT/RDY pin, which =
is
> >> also the SPI MISO line. Using it as an interrupt requires the board to
> >> route that pin to an interrupt-capable input as well, which is not alw=
ays
> >> possible, e.g. when the ADC sits behind a digital isolator that only
> >> carries the SPI signals.
> >
> > What does this actually mean? Does the isolator only permit data
> > transmission when CS is active?
>=20
> No, the isolator passes the SPI signals normally. On our board DOUT/RDY
> crosses it as MISO and then only goes to the SPI controller's MISO
> input; it isn't also routed to a GPIO or other interrupt-capable input.
> The isolator doesn't really matter, so as Jonathan suggested, v2 will
> only say that DOUT/RDY may not be wired to an interrupt.

Right. The isolator having nothing to do with it explains why the commit
message made no sense to me.

Cheers,
Conor.

>=20
> Thanks,
> Ilyas
> The information contained in this email is intended solely for the use of=
 the individual or entity to whom it is addressed and may contain informati=
on that is confidential. Please delete and notify the sender if received in=
 error. SKF does not accept liability for any damage arising from this emai=
l.
>=20
> For information on SKF=E2=80=99s processing of your personal data, please=
 visit SKF=E2=80=99s Privacy Policy available via www.skf.com<https://www.s=
kf.com/privacy>.

--mZgf9zJdIVcx+b3z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawcbagAKCRB4tDGHoIJi
0la8AP0TFnFIK+AbZT/3vzkzBqsMDQPFBQUWeANxvf4VdNkVuwD/bdyaOmF356CF
XKWDvgd5z3T+QC74EJ1tZ8IvOwPl6QE=
=EUpp
-----END PGP SIGNATURE-----

--mZgf9zJdIVcx+b3z--
