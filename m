Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB7329363;
	Wed, 28 Jan 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621665; cv=none; b=iKcOgT4rZ+YunBvug/kPWZyrhu9s6SwKPP1kwkZ3NLZzWVEy7n4E1KrsfxsvbwRY09p/VXEyFcNdxJM7D3C2MPCutRkq5NBEnMDQvq0sksbV8RMIayme2ClNCUascIA2UvytgS0LzA8QuOPx7IAlpuMLLppyLL+Orly9YAWUPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621665; c=relaxed/simple;
	bh=c4++0Lc5a/ZCC9nKGRP577RPglS/5LiDOZ4+U9LMTHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOsajuXJjADg0DQ2ioBaygldOlh5Ez3aKD+5YTIe8iUXXXUOsgQEpZqVA73DtrgQTWLb39wj2CnVao8Vxd6FhEE+y4bliC/x14dtHJQkJh+WQHsUmlXL+bLPQrJdUFz7d39DUErHMwZVPXybiKVrCJR2X3IuL+eA8J9RpCGHBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdxZ9AQA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdxZ9AQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFA7C116C6;
	Wed, 28 Jan 2026 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769621664;
	bh=c4++0Lc5a/ZCC9nKGRP577RPglS/5LiDOZ4+U9LMTHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdxZ9AQAcl2drcvA6O8YwtCvLQY7MCnQAl1zmNB7hBkYvou8HVLnBnXZD5Ggtqxi2
	 D2h0REpvq9WejMk2TPnlIFGk8NTByBIZSHCzgCI3MEyddy7LbXFSLMyE+AhM5orDDZ
	 AAeGtfRtPXKTuooTIbCNiL4faST9OcZF4tABSl1ssbdaCEK3QcHqywxAV4+O5X9T0p
	 Qjfi8dBXVO3Z+m8mWMaqd8V1TNya3I2xE5oGukEKlhE7p3Kp/xIHmwrVZQUa3A8xvN
	 mT/zkpBI6e0UVHpLT3S6+2aVI78dIBCQU1F1WF+XQL3t67Qi6VvsZTwd5WgPuDHPTM
	 H1Mk7Dn5AsTQg==
Date: Wed, 28 Jan 2026 17:34:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260128-relative-wistful-a31575a2fdbc@spud>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
 <20260128153824.3679187-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z/3YYTBCmD0QVShB"
Content-Disposition: inline
In-Reply-To: <20260128153824.3679187-6-o.rempel@pengutronix.de>


--Z/3YYTBCmD0QVShB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 04:38:21PM +0100, Oleksij Rempel wrote:
> The Maxim DS4422/DS4424 and DS4402/DS4404 current DACs determine their
> full-scale output current via external resistors (Rfs) connected to the
> FSx pins. Without knowing these values, the full-scale range of the
> hardware is undefined.
>=20
> Add the 'maxim,rfs-ohms' property to describe these physical components.
> This property is required to provide a complete description of the
> hardware configuration.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Z/3YYTBCmD0QVShB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXpInAAKCRB4tDGHoIJi
0r4dAP0YZLAEba5y1fyxTLX2JsyBWx9DzA0MPR2WD9qEAERLIAD+Ktbz9EhLFVz6
5r/5LlCLQVqXnIVkN6M9yAA6WDxCJg0=
=YMqh
-----END PGP SIGNATURE-----

--Z/3YYTBCmD0QVShB--
