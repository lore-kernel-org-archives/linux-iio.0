Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730083;
	b=KwZFTCI/i/WiYXF2kfmpxJ3jpPZBIEknmjCuf6bIkzsQTRlz5+RpqdDQpX3krLiDixaK
	 7M6UzygTRKug6R0FArCjLzbOePhOzxI415hzHPSJLF3DUl1HKuV93YkKKmJ6EUuNbMRv+
	 iPm0TsNeNuiDWFvgWtHBf8jafdrY8pGYWanvHjQZurw1zR+Oed1z2hRqpgln74P+A7kXN
	 Exr2s3/3ssNghVuvoaPh8Py2czwkdJCziagWwLZ+8FtB3JmewjWyrz7H36kzFRIXDFrWH
	 ftE0K3Uy+IdEHRNy3MyCcqAi9lepv9lO0kP+KLFojBogNHw2X0MKM6sZweFY3Tooc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730083;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FFg5lBDyaTkqCOMiyU7y1v3jtarrni8pj6cJLPTtz/k=;
	b=vqrc4zeXhMDZBx8RB8z4kt64ZoHoJ3AN0QLkyiXqaFX6T9JwqpR+2unjt4pB6PVj7T9S
	 9WzQz0tIu7kSHyikUdW1t+y29vTiMN4LNHjAskxxVwCIvhmfwmVJfAiB2SwyKxhsic0ln
	 zYrGRFGeccDxtvFqX1v5XbBHphq28zJpRNe5teXcjCb0zIC1CCMy2/4UqykQOAuG70AWS
	 8Qe3toxKBjHqPe927zJ0iyTSEgdBLEf2dY3YAnPAABrv+PYSNLlIhEWWqmW5yZ+yc62+1
	 ZvfpJtHtfiQy0vaCZGP9O5dUi1LH5k44m9Rjih31pq320B85jZnyuif1DIzg+ry3ZKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JRkM/Gwg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2E606A324;
	Tue,  3 Nov 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRkM/Gwg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9FD1F00A15;
	Tue,  3 Nov 2026 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730083;
	bh=FFg5lBDyaTkqCOMiyU7y1v3jtarrni8pj6cJLPTtz/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JRkM/Gwg3Yp3XqQ43iKxJKBDjXY3d6QFU6avJyOTBXRoYR0bnVOoV0c3otj23KqiF
	 3pQQlb50xV8Vls8XvLBtU+uoXcaCxa7udtEs6jv6tqF9mvO9MxIyYwFm/A91KVJVOd
	 R72yASFR2heC4eCnDvKxBbgaVXDcRP1cA8fClEQg8IEWgtfhfG35EYBQwE3zKYggtq
	 vKsI8M6ht4jzbvF8ubctqDIaIuxrbwRllqjqlv1b2GzR21pXAdD8Eqfs+eOY1K55JW
	 UN9rpgrj1YDYXYb4NY/TbxWK/KyJFWM7TMeclo+gFZ4SvvdjjspaplJxjXz6OHr5mY
	 Ofkw3A1QNe/JQ==
Date: Tue, 3 Nov 2026 18:21:18 +0000
From: Conor Dooley <conor@kernel.org>
To: "Sabau, Radu bogdan" <radu.sabau@analog.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux <linux@analog.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <20261103-defective-clip-8b6689ecf2cb@spud>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
 <20261102-adis16607-v5-4-4f98b0d271ac@analog.com>
 <20261102-barista-haste-6f219aa98c81@spud>
 <20261103-accomplished-real-cuttlefish-b6efdc@quoll>
 <LV9PR03MB841498F9B9889C8F1908EF01F7692@LV9PR03MB8414.namprd03.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="KxjI3xIIqfBUAzAW"
Content-Disposition: inline
In-Reply-To: <LV9PR03MB841498F9B9889C8F1908EF01F7692@LV9PR03MB8414.namprd03.prod.outlook.com>

--KxjI3xIIqfBUAzAW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 12:15:50PM +0000, Sabau, Radu bogdan wrote:
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: Tuesday, November 3, 2026 12:55 PM
>=20
> ...
>=20
> > > > The binding exposes optional properties for:
> > > >   - An external clock for sync mode (falling back to the internal 8=
 kHz
> > > >     clock when absent)
> > > >   - A hardware reset GPIO (active low)
> > > >
> > > > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> > >
> > > Why did you drop Rob's tag?
> >=20
> > Explanation in cover letter is confusing. There is no difference between
> > v4 and v5. There is some description change betweeb v3 and v5. So was
> > the description change something forcing to re-review?
> >=20
>=20
> Perhaps the explanation can get a bit confusing around that "since v3".
> The quick history of it is that v3 to v4 saw a change in the GPIO descrip=
tion
> and so Jonathan suggested I should've dropped the tag in v4, therefore
> I did so in v5.

tbh, I don't really think that justified removal but w/e.
Since I can't re-provide rob's tag
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--KxjI3xIIqfBUAzAW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauomHgAKCRB4tDGHoIJi
0pqWAP46Yk+3+HeDXpRD/ncdrcQCIqpRULqh48V1tzKP6OS/MQEAuHNM/lrOur2W
I+5JpbOrijCU4gkCWMIUkOp0bYyqcQo=
=WlQ9
-----END PGP SIGNATURE-----

--KxjI3xIIqfBUAzAW--
