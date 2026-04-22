Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1634FF5A;
	Wed, 22 Apr 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876961; cv=none; b=MQRqblltz8fkCh7S5EnszC+plwg5Ah7rNmLcjL4AOFKRGQYqqDH6iGXrI9dhf+wkXbO+CSHo7J5B/Nvf2m10Xv9It3yicCeD9aCHkM+gG2y3Xj9RMvDp5mSiHSd9v64LAc1HnjtA8mcrMMHo64eb1TmdD/vam7xrRa6bwINRQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876961; c=relaxed/simple;
	bh=F+oQPA3XtmzG9pRI88oWKDlZiM0r5+Q9T+0KFwetuHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyHjOJ5QPBXDwQEioHWQWKKg4MSz2QJ4868dz0gZqN60qp9hRmBxaShVaFJCGSyFB8es8qITCGFZ+IGHXWx7gOM8oaUz2vJm68GjXZFkAuIwLCKTcSs1SufPbC5YNSV0s5dpoymqd4Ex5JLxTSDT3tuQquTdGrEPVst+SX/9LfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxCQOGOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxCQOGOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342B6C19425;
	Wed, 22 Apr 2026 16:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876960;
	bh=F+oQPA3XtmzG9pRI88oWKDlZiM0r5+Q9T+0KFwetuHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxCQOGOEWQLPyFLOgZLMe0hPRuHKIqp2l6I+sZcUMLmjxMwEWZxmWV4X0F3tCKl15
	 72xym+JLo5WwrQUMBuf6ExRmYvstkQoGOdeB/D9KHce2KwtIBJKBUZQM4t0KwZkuBw
	 q+9PPLDpgGF1U2S3Zg9X+QXK6iK9datQMzDs32lVKgTUxyNZzj15HUEHm+4wsZEcKE
	 3/I93XKr9xjCFLFpjg3f0Gt/N4Z3ymqFlHmwiGzlhacOIl4ytm3r7MTHT2c3+QyNfW
	 oIik0wzXFFEhUEzBHlmXbGKyI6yXtHIwNtk29zUHQs0I/ftCTeg2AaZ964bM7FvH0T
	 XB2ILwrKOktGg==
Date: Wed, 22 Apr 2026 17:55:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: dac: mcp47feb02: fix reg property
 value bounds
Message-ID: <20260422-hull-naming-2d7e822976a0@spud>
References: <20260422-mcp47feb02-fix5-v3-1-e742cbab1dad@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J0bG6QMKAX2kEJSO"
Content-Disposition: inline
In-Reply-To: <20260422-mcp47feb02-fix5-v3-1-e742cbab1dad@microchip.com>


--J0bG6QMKAX2kEJSO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 02:53:14PM +0300, Ariana Lazar wrote:
> Replace minItems/maxItems with minimum/maximum to describe the reg
> property as a single channel number with 8 possible values (0-7)
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> Changes in v3:
> - Replace minItems/maxItems with minimum/maximum reg property value bounds
> - Link to v2: https://lore.kernel.org/r/20260417-mcp47feb02-fix5-v2-1-659=
2ea499cce@microchip.com
>=20
> Changes in v2:
> - keep just maxItems value update in this patch
> - remove Reported-by from commit message
> - Link to v1: https://lore.kernel.org/r/20260416-mcp47feb02-fix5-v1-1-965=
6c2fed6d2@microchip.com

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | 4 =
++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb=
02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.ya=
ml
> index d2466aa6bda2106a8b695347a0edf38462294d03..da4897a6fd8d2522ea7fa3cb8=
c4bfd91520487b7 100644
> --- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> @@ -161,8 +161,8 @@ patternProperties:
>      properties:
>        reg:
>          description: The channel number.
> -        minItems: 1
> -        maxItems: 8
> +        minimum: 0
> +        maximum: 7
> =20
>        label:
>          description: Unique name to identify which channel this is.
>=20
> ---
> base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
> change-id: 20260416-mcp47feb02-fix5-26994c5b428c
>=20
> Best regards,
> --=20
> Ariana Lazar <ariana.lazar@microchip.com>
>=20

--J0bG6QMKAX2kEJSO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaej9mwAKCRB4tDGHoIJi
0lRCAP9IyxxkySJsPbwFWSBc1Ax7m0FCECRgRTfAsxJDL1ZFHwD/XHMRqJaDYOEi
AiTd2ln7PF+zxt04bCG/ANO22Plr4AA=
=UYb5
-----END PGP SIGNATURE-----

--J0bG6QMKAX2kEJSO--
