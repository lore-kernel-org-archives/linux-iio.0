Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45E38AC80;
	Thu, 30 Jul 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433327; cv=none; b=PY7Gce2GcOUP3P0qYVfBcJxBDWKFKZt4lpxFOx4iXP4ej7b4GuIQ6+Ew4w7FUqbV8JVDCRVErIT81WHa7Kt2t0qRlwFGWRTxVKzmc34FUXmRwTPgyKWzoA10Rc/mCGMaW7QSrCx6rtA7QcAchu7/4+muR/TAcgT5S9+3gcfYVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433327; c=relaxed/simple;
	bh=8S79kJNokLqhB89neq5V/sHBzysCH6bsnXF2YAxLIdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtXZ6f896OxHVctoOjjxpfpzv9WZFGp262j0Ndrp0cMYa+KXpWnhWhLABXPRJsuXUtM0Ct6ldUn6LCKZmrJR4n9R8WMRdVszy/14PvljRJbJ85xf+s91nqOnoGpCH4/73hRtcGdy8Zn3D6r5EuBH6GouI++g6cp8ne5P1desy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmC15d2h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmC15d2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3721F000E9;
	Thu, 30 Jul 2026 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785433325;
	bh=QUN8FMkUh+sl+3ycuBTdwAxcElw1ncfsAtlWboIQqS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kmC15d2hdZUY9EhLmKh5593HMAe2+Kzz5xw7YNNeRaCXGSjekCyK+bChnbLXWKP8S
	 UkugzmfoQu5y3pHfmPhSMTiZj0+7h72w8lBmu6ObVv/NZh50y13d8jM5ers4mV5csG
	 e3u/fqmP6ZwaCE25dZ6An6jawQ1BHFBNrpMUJ9wfi9xqrwbJ4vBW9Klgd1Zak47Kdb
	 647niNuhANlJn3RBpkilGPasAhThcAcN6l4Kq3VW/vNOLUEEpCT3inX7pQMWzhU2Bn
	 /o0rptKKLGt5TqIH/EEdgW89y0ttzMSZYtz3JLxciwh9TO7nWOG21Q7JhEAW0XHGsy
	 a0h8OtxHdIVXQ==
Date: Thu, 30 Jul 2026 18:41:59 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
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
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260730-partner-yield-e2a3f91997c4@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
 <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
 <20260725230739.63ff7000@jic23-huawei>
 <20260728-patronize-thwarting-56fab2e11077@spud>
 <20260728221719.7f668a73@jic23-huawei>
 <20260729-hundredth-suffice-f28afa67bc06@spud>
 <ea9c043f-27c9-4095-9488-e81e0bbb5273@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PSCz3J9WmgpRxkdN"
Content-Disposition: inline
In-Reply-To: <ea9c043f-27c9-4095-9488-e81e0bbb5273@baylibre.com>

--PSCz3J9WmgpRxkdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 04:40:00PM -0500, David Lechner wrote:
> On 7/29/26 3:47 PM, Conor Dooley wrote:
>=20
> ...
>=20
> > Only going to reply to this for now, I'll reply to the other thread of
> > this conversation later so as not to end up duplicating discussion, but
> > I am thinking of things like what if someone puts a mcp3654r and an
> > ad5529r on the same chip select? I think that's actually perfectly
> > functional on a hardware level, provided the fuses/pins are set up
> I'm not sure this works in general since SPI devices aren't going to
> have a standard way to specify the address.
>=20
> For example, ad5529r has the address at bits [14:12] in a 16-bit
> "instruction phase" while mcp3654r has the address at [7:6] in the
> "command byte".
>=20
> An ad5529r instruction could inadvertently be interpreted as a
> command by mcp3654r. So I don't think they could exist on the
> same CS.

Yeah, actually you're right. I didn't notice that the ID bits weren't
the first two on the bus for the ADI device.

>=20
> > correctly (and if it is not, mixing the microchip devices is possible
> > and probably mixing future ADI ones will be too).
> >=20
>=20
> Yes, I suppose this could be possible, but I don't think they would
> be considered a single logical device in that case. So would be
> covered by the device@cs,spi-addr binding that we already discussed.

Right, that is what I was thinking - I just don't really want to
entertain supporting both this and the "single logical device"
configuration for the same device.

>=20
> Example:
>=20
> adc@0,0 {
>     compatible =3D "adi,adc1";
>     ...
> };
>=20
> adc@0,1 {
>     compatible =3D "adi,adc2";
>     ...
> };

--PSCz3J9WmgpRxkdN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamuM5wAKCRB4tDGHoIJi
0lRFAP0TmWqGyKsaTNLr7lLrkk4EWA6tkJv5j6gWOK+wjmysDAEA/nHORp+ng+A/
tpdB67oXMDw5wpLnCw2IQWZ/NYVe4gU=
=Trw1
-----END PGP SIGNATURE-----

--PSCz3J9WmgpRxkdN--
