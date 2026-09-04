Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881764EE876;
	Fri,  4 Sep 2026 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535307; cv=none; b=LOTtC1uE3LzDRRmO1GeTpwQzuZjRu94DZyx4Ddkwr2wbvCnYohikETg19Pypn3sn/BGdLn4P2FLoVRVBKyBLL5Mq82W7S77dtBh2/ETffo9J43c6G9TAW4+6EQHcRFgps51CxLY6jCyGkbYfNa0ahecav2wbvch22TEypo767gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535307; c=relaxed/simple;
	bh=eGlB7yFUGI3DR0HpEmQu+AVYOpHxAZwmTj2EKLbuGxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVeR81qtSVXeeAWg5Wfsi07ACJz3hBO67CelN6/GU32kHHErJhYnReU5OYl3Gal7M+aGAWGH5Hbz0Pq74TAFel7Tu7o4FerBBOO5hBwecPoJ7Bc8tmurZeeDJsJ2NYGNkgLp45FLGeBFRHcHKORuh0s6htIO2b1DWKdydiygFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+XIaGvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+XIaGvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A528A1F00A3D;
	Fri,  4 Sep 2026 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535306;
	bh=eGlB7yFUGI3DR0HpEmQu+AVYOpHxAZwmTj2EKLbuGxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J+XIaGvxGVl0wotOP8ToO+WmTGs7y9jEuN1GmiBa9ArH74BcXqO6jVnlw0E/fngw9
	 QS6ioN62wVUq619JOYkO5nrMweUOu/OmEAnBdhoTh5ecXYSyXSR52IW4J0fQPayRDY
	 aJ/d+sKsznBo+AEsPA0xKVkppUe0OYxN1zp0RKyWsdVFhkxb5/NnXcK2lxfbB7Bqn4
	 +TmSHoi++QBJtrUIQLRRJbadYKJprOKWR+Zrvz0f0wSo9iH2wgLILQG3Jqg7pMlJ0O
	 5W6QcgXIzzP5QQ9fW3MECHueKJJu1T5Np3mdGLOFRXAgWgJY8Wye2mPQp7H+50k5U2
	 f3TTm76+hTX1Q==
Date: Fri, 4 Sep 2026 16:21:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260904-deception-nail-5cdb195e16af@spud>
References: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
 <20260904-iio-ad5710r-upstream-v5-2-76f985b7d0ee@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qVxjmn6vo5iWmdhO"
Content-Disposition: inline
In-Reply-To: <20260904-iio-ad5710r-upstream-v5-2-76f985b7d0ee@analog.com>

--qVxjmn6vo5iWmdhO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 04:35:25PM +0800, Kim Seer Paller wrote:
> Add device tree bindings for the Analog Devices AD5710R/AD5711R
> 8-channel 12-/16-bit Configurable IDAC/VDAC.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Thanks,
Conor.

--qVxjmn6vo5iWmdhO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapriBQAKCRB4tDGHoIJi
0qFOAP9baEu6mLbczGM915fgrLtYJnByb6YRCrbTJJ2G3AoqwwEAwjw6idHnQ7ny
Mjurcbg51JYpANOwqvEaj/qgfZzJmwc=
=wZSk
-----END PGP SIGNATURE-----

--qVxjmn6vo5iWmdhO--
