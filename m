Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2E3FB07B;
	Tue, 26 May 2026 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813839; cv=none; b=tyTLWfDY9iErAmpxXnJCGyOZteX6ufdwpiMf3G75vwKvTRdl7B+kF1pDc2f8iPHYf7DKNwfrS/OtDYdgGIBWHmtldVeU1oZa6E5mrLGaVQck06z8KqTM8wQ9/JoboYQyd2UUrHAg3LWjT7bwcUWyvV2Q+ffDaoa1yTwK/K064yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813839; c=relaxed/simple;
	bh=4iGxpqreUMKZqfZJta2HzBWwW9Zct0UhY51b8JS9hUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV5nH4geLishUzzN3uMwKNsOPS9VQzauUKkGhY5jTyYcG21P+pa+ZIpkoGstmc4khvNvUWSvBsSY4fPLSgChkd1isvrpfIIC8yXkgfxAOJm7U773FRlf5DmqFOOsRvtnSJs+12PfRYL45u8BBWiF4YYQur2DFIT61VyCe2g67u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot0gjLdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot0gjLdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C461F000E9;
	Tue, 26 May 2026 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813837;
	bh=4iGxpqreUMKZqfZJta2HzBWwW9Zct0UhY51b8JS9hUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ot0gjLdfkX6K9J6JjAfXoCdJ9wZ3mqd9Gb19fryXvdC1y0Z2W6K1SZRMOJvaup6aw
	 6GbBEV5K8uOJFZwtJkBuYgT+KnDc71Coe+s/uiI9hmVpx3U+QLfcXX/S9qRSWNTRRb
	 uiTDwT2NRcxcr2otoOZ0fpZOk7QMLBAPAvsBwn8fJHru47dQEsTo38eHOKdkYrOYei
	 +0fPTeZWUjgk5hNnwAR2RsGNzSVHGnuZUYgw034XF9rXXQh60iZq2eCdXErm2X6q1p
	 cehN01AesPINd0bBQsdJTOpDg2vrDsVFIQGBgHhVNzMqQPBFQ0y4cZCY3X4XtQgiaa
	 Q+yIK4dTUK4Xg==
Date: Tue, 26 May 2026 17:43:53 +0100
From: Conor Dooley <conor@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: add Broadcom APDS9999
Message-ID: <20260526-deceased-divisibly-1c76d5208d79@spud>
References: <cover.1779781224.git.azpijr@gmail.com>
 <2da5163825ceb794c73c9aebb5cadf6ab3728097.1779781224.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RmfARgWHh0ZSQRkS"
Content-Disposition: inline
In-Reply-To: <2da5163825ceb794c73c9aebb5cadf6ab3728097.1779781224.git.azpijr@gmail.com>


--RmfARgWHh0ZSQRkS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 09:55:15AM +0200, Jose A. Perez de Azpillaga wrote:
> Add Device Tree binding for the Broadcom APDS9999 ambient light
> and proximity sensor. A separate binding file is used rather
> than merging with avago,apds9300.yaml because the APDS9999
> has an additional vcsel-supply for the VCSEL.
>=20
> The APDS9999 features individual R, G, B, and IR channels with
> a green channel that uses optical coating to approximate the
> human eye spectral response for ALS/lux measurements. Calibrated
> RGB color sensing is not yet implemented in the driver.
>=20
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--RmfARgWHh0ZSQRkS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahXNyQAKCRB4tDGHoIJi
0qhGAQDbYJ6pvXiznURbTsN6RQf2dhiJeZZTPJ5szCiA12A6SQEAoStqXaokjbqX
EivfbXXKxWPHKVN7FCR3hZg64SOZlg8=
=/aVD
-----END PGP SIGNATURE-----

--RmfARgWHh0ZSQRkS--
