Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E641A551;
	Mon, 31 Aug 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193453; cv=none; b=n4BLY3vSomAHveksZ/cCzG7+q/eAv4FPw5INLVZK2B4h5h+DrcGcacBaK/tLF/06hFag1AHqB0d2OjqZdGnVHCSz7VZ5hzhdfntr8MGpZntZlHdRjJUJjYu8+AWs/3QyeIqDyjooSG2ZgLMr2y1Wv6vJFgSU1ZY2TeWWuJLBlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193453; c=relaxed/simple;
	bh=/w623wBQkABc5+t0xwYrUv6rI0oWlcbDgaEedLQYnfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1vrXdNLyGg+nzu/Ay+83U2nNmbolULt+mE5Z9bby5GL6DXiPUJ1EW3YRRiD2REJbYYNGcebgOfgHcHnBERDydD4iXZZESyoYcf5xL3A++7wv/26ix5auDbv6vRYsG8MI8T2IJ/PHtSa5oBCqPZCKrarsVJut3YnaF6jn2FDFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyU/UxBj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyU/UxBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3561F000E9;
	Mon, 31 Aug 2026 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788193452;
	bh=rg9iFiy/P5Gzx3wegX3cahRTxdCoNO1WoYkvR0YeYKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KyU/UxBj03GcvRe9UOzurXo0xwD1Kuk/uQKNcRep16T4qljYFmHxl9l35tmxRGFSW
	 GlsG/02qRtotKZ5Dn9znesNPH23fCyo1QyRxNhEi7mNgUAj9I6e7ZamzznM6tXlMQD
	 anVnpvr3AdP0amfrKWB5ssqqPlvGT4+Rv9w3/l8goH+i00LePXqyxaIoeN0Fkgi5cJ
	 8wAx1Wadlci1WlfPVx9XGb7cDB6CahAyzPmrZk8+zVYh6ZlKEfPp04rE4V7EyFJNkT
	 58th7bDDgahLbkWAcDT86adMJ1Ns3I1K6/7l2iYQDTbbxzL135cfgCf13dEdvjyxEp
	 rCEUmtmRVQIiw==
Date: Mon, 31 Aug 2026 17:24:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
Message-ID: <20260831-elude-steadfast-b8017ee226d0@spud>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
 <20260828-cartel-willow-9592e4e8b912@spud>
 <20260830025743.70dc65e4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V048FjMaoPN4PMOh"
Content-Disposition: inline
In-Reply-To: <20260830025743.70dc65e4@jic23-huawei>

--V048FjMaoPN4PMOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 02:57:43AM +0100, Jonathan Cameron wrote:
> > > +
> > > +  clocks:
> > > +    maxItems: 1 =20
> >=20
> > clock doesn't appear mandatory, what does it do?
> >=20
> > > +
> > > +  '#io-channel-cells':
> > > +    minimum: 1
> > > +    maximum: 2 =20
> >=20
> > What's the use case for actually setting this as a single cell? Kinda
> > confused by it.
>=20
> Part dependent, but I think we should just make them both take the two
> parameters and have the value of one of those fixed to 0 for some parts.
> Probably easier to understand that way at least.

+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads1263
+    then:
+      properties:
+        '#io-channel-cells':
+          minimum: 1
+          maximum: 2

This in particular is what I question. Two different devices having
different cells is fine, this one device allowing both? Nah. It should
be fixed to 2. The ads1262 should probably have it fixed to 1, as the
driver already does.

>=20
> >=20
> > Otherwise, quite frankly, the binding is too complicated for me! I'll
> > have to leave it up to the IIO folks to cover whether what's being done
> > is sane.
>=20
> I'm rely on David to take a look :)
>=20
> To me it looks mostly fine but a few odd corners where I'm not sure
> how things are supposed to work.
>=20
> Jonathan
>=20
> >=20
> > Cheers,
> > Conor.
> >=20

--V048FjMaoPN4PMOh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWqqAAKCRB4tDGHoIJi
0r/nAQCL4EiB0v39AnBgsiiFn/oi0tW3kJUHAfStcOb7BDKWywD9FqsK6hfleJEY
CzCS041SjBYVb2A+KByeqdF6Z5xw3AI=
=lbHe
-----END PGP SIGNATURE-----

--V048FjMaoPN4PMOh--
