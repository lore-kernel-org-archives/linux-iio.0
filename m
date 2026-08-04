Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0263A0E99;
	Tue,  4 Aug 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865617; cv=none; b=MyfrATQK+Nq7+S1305tToY1HSFRTiFzH4p9ZMBthrJp5oA+kAn8sSZQyqYqRdZZzUY2aZR2aaQ/FHCdZYxM+DBA9M94tG1xcJLbESzFm4WmNjLNSDTBlLTfVhOeguZVxfNBETcQeZslwIGGijNjobycN7kq+idnyH0Hr2D/lKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865617; c=relaxed/simple;
	bh=8bS6rY5Z84xBuNdz9oIjeOWVaxNllCLB7dHER8USCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSLETMo4wZQ2eTMUdggG3IpBY/iN96krmAz3Ww7G7KgTnHPgG73uipozCTZJKDdtx4rnvO1oPNLAqc6m+oc4/6qZNTSbbqhzAi1wSrx26TQ0P9wPUNdFqXoN8w4FNMABtgpciAp6Dew8OwF/pOQGesBmY9lD5EAYOVH7u+TC7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBqMjyM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBqMjyM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27B11F000E9;
	Tue,  4 Aug 2026 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785865616;
	bh=8bS6rY5Z84xBuNdz9oIjeOWVaxNllCLB7dHER8USCXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CBqMjyM2zfyQH+l1Tl4AR36KpJck1WeF1OJZQ3KGr+GVvN4GcZ51vVX5+GPtgcTxv
	 sUggidh4cKMa8e4Rl/mXGtTuLDO6v/0TpnDJESFcOICOTBcIhbHuHBQNrSJeBbuIxD
	 sJ6POEbrYRhpSUZ3Gv1a3hUd1uRk/0d4tjZlxo9wB/ZGjAS7ZX8xV8lMJD7EnrR6bn
	 SEZiI+SUDDCTM/5HIBjO7CFuiMC9oq4IWPMCaykikCrHiTu5n6kZMTvMg/3WjGxgtE
	 Blc57nYygdrNys+u+2iQQwdi9+OYndJksLZVdVwqDH+vQjeAg04RGRPr03ud84J7lK
	 CDzjIMI5KhO8g==
Date: Tue, 4 Aug 2026 18:46:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260804-patrol-surpass-8e7c2a829e12@spud>
References: <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
 <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
 <20260725230739.63ff7000@jic23-huawei>
 <20260728-patronize-thwarting-56fab2e11077@spud>
 <20260728221719.7f668a73@jic23-huawei>
 <20260729-hundredth-suffice-f28afa67bc06@spud>
 <20260730000929.2ec20cf8@jic23-huawei>
 <20260730-impaired-protector-b58ae56ae3f6@spud>
 <20260801024114.4c606ef7@jic23-huawei>
 <c20621fd-571b-4c96-8397-c644970c6548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqdqxmi/we6pcyex"
Content-Disposition: inline
In-Reply-To: <c20621fd-571b-4c96-8397-c644970c6548@gmail.com>

--fqdqxmi/we6pcyex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2026 at 12:36:46PM +0200, Janani Sunil wrote:
>=20
> Hi All,
>=20
> Based on the discussion for v8, I plan to:
>=20
> 1) Drop the Microchip-related patches from this series
> 2) Keep the spi-device-addr property and the AD5529R binding/driver and r=
epresent AD5529R sharing one CS as one device using the address array.
>=20
> This would reduce v8 into just three patches related to the AD5529r.
>=20
> Please let me know if I missed anything.
>=20

Sure, wfm.

--fqdqxmi/we6pcyex
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCanIliQAKCRB4tDGHoIJi
0nkiAQCgqo7hK7tjCd47M7wIm/wUnyb4ezgxRvkbfBzCVq/jDgD/Y8iYse3Eu6Yf
w5TWvQ9BEP9YOsPps0bzKzhJ+Qll8ww=
=0fIc
-----END PGP SIGNATURE-----

--fqdqxmi/we6pcyex--
