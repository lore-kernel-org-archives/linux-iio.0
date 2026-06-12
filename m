Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2F31F998;
	Fri, 12 Jun 2026 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282946; cv=none; b=M3gXuWYbJOKY9uBdR0h/EwbEsNlMXGgbzRlbI8gpBzCh0nYIQtT3wbAe0hIHaPzKDdI05MnY0+IEmPHn0h6ynFqzsC20P7nzYSOx9LtB9CZa+9/joTXriHAWgpuxXMHpZ+O7OD4kXWNFfQgopeZE6LJgGymy0+5nEjO/YMdz7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282946; c=relaxed/simple;
	bh=bT9lRJt+dwm52f6uacmaifEuDH9YT7X/eCng14IOZ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nrojc0hY04ecogqVlzcBKcFKthy7d7BLNR82EpFwfU2pL+lS1Ec93OmcmK32T31PvS2/qwugf3aUMqx5Sf9pZBfPQMfalBgkcUGtYhne4eO3344OAc1kKbNsxJuWgylAmwoQAdRZv8QpqQTIq/1gJ1/TNMkufpqEawTc4XAZ80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPaiYc6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPaiYc6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7A41F000E9;
	Fri, 12 Jun 2026 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282945;
	bh=S832i2jSNg4cBamp8N6WT5Eh3SFFvEOMTQE4vCId6qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PPaiYc6OrwfmbXE6Vf5bZxB+lEU6BNsq52xUoEUdYTE1fbMFIZMcygF1r2KJSIckI
	 VpDupvgYar7fFpHTheMQHDvAhgWiVQqmR7xr2LVuFuEMq2lQIS4Y/xpE8Jv9VdvvRf
	 k5NP13iooljPo6caPprKmTGyMRI1bgVBtdBI9wLGR8CDGeApoc9liY3o9zggLnJLcE
	 PdxKx1JfoNHYH6zISI9yG/0yeJ8uFqWwet+8ASHZtJ7D3taE56OMPF9mqK6w5qYgmo
	 0wCed+MN2vmoRpvznQle1utLKnIX3Gmq3qnAUttAbMoelAPj77qIgorl9UCn7DC5p8
	 VUWN6mguoHx4g==
Date: Fri, 12 Jun 2026 17:49:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: add entry for qstcorp
Message-ID: <20260612-kinsman-wind-ee21a6ca0fef@spud>
References: <20260612124557.13750-1-email@sirat.me>
 <20260612124557.13750-2-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5CjzBW7JmYQ5EH6Q"
Content-Disposition: inline
In-Reply-To: <20260612124557.13750-2-email@sirat.me>


--5CjzBW7JmYQ5EH6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 06:45:25PM +0600, Siratul Islam wrote:
> Add an entry for QST Corporation Limited
>=20
> Signed-off-by: Siratul Islam <email@sirat.me>

Link: https://www.qstcorp.com/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable


Cheers,
Conor.
=02

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 28784d66ae7b..11aac47f90ce 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1355,6 +1355,8 @@ patternProperties:
>      description: Shenzhen QiShenglong Industrialist Co., Ltd.
>    "^qnap,.*":
>      description: QNAP Systems, Inc.
> +  "^qstcorp,.*":
> +    description: QST Corporation Limited
>    "^quanta,.*":
>      description: Quanta Computer Inc.
>    "^radxa,.*":
> --=20
> 2.54.0
>=20

--5CjzBW7JmYQ5EH6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiw4fQAKCRB4tDGHoIJi
0jSMAP9Z2ImdyL4CMc4szu9odY8gpkujm+mcZ0ZSzAqUUrnewQEA0LHzFy+gwFiL
rSsofo/4p2hLZnFFv9zhE+WUQq8r7g0=
=X33N
-----END PGP SIGNATURE-----

--5CjzBW7JmYQ5EH6Q--
