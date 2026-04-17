Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D973290DB;
	Fri, 17 Apr 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442102; cv=none; b=o/Vl0+Cs6vaRlKwCp0sgWZZracx+AL+echkh9061fcN4fwVpH3lGLD2584ZeRnVCooK1Pq6uoZr2Cr2VMSIWfK1bd6au97wRaVyBNt8IFvzXoCT9Q0WHfBfX6hLRjNQijDJ+fS9bM0zeqWC1zzZvvmE9oHUB4tLjZoXCY8fSfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442102; c=relaxed/simple;
	bh=rCbQ3eZIJe/RC4aBBQ8FhYf7+/XDZ4kSZXQKqXKk+bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZnZml5Yt4sL98ffZ51yB5BFy9Ynz0BUEBOQdo05d8Q/IUiAKwlSVWH/GRiFcIdE+W7NrtfG3oZ1QOphQRTNyjnfWDeOTkwylHTlwP4P8sylQEsD7Y2c5Op1gzDdMSyzUk5ZiumA4roCl+jVc64kqdCIQ07y4gimgbR7F3po6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbjxfT8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbjxfT8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F3C19425;
	Fri, 17 Apr 2026 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442102;
	bh=rCbQ3eZIJe/RC4aBBQ8FhYf7+/XDZ4kSZXQKqXKk+bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbjxfT8Hd4sBS2Hn+u4EnHt6C8x+USy+R+OePVB1NR+9W/GVB6fRp3z60iSfjivbf
	 n6/J0tkOww/FMrJSmqw2O2e7mVMUVDxn9bA4VfUzbMcJOqa82GEwJeJRhQtRDoEkIo
	 TdrzSu322M5DgVMJVPNV/W0G2+V5xA+W04DjnUpYpHLXB0YtlNIBM9KCcwpoIidec1
	 7IrOZp/5xhwbHWDoiWAWEU9QoKj8RxUEnwBGqvKQmI11D2IkXYj2QNvkFAK168gr42
	 tAJLiPODr22oKOUPBfQDZx63I2lJx1BQycdoiERXxkbPPR4JHbpIIN9YbNoF6ldr7i
	 a3RnH3ES3+yBQ==
Date: Fri, 17 Apr 2026 17:08:17 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix maxItems value
 for reg property
Message-ID: <20260417-sprain-list-014458b02e1d@spud>
References: <20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com>
 <120a34be-bc0d-4202-9996-c5da8cf15963@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FZ/nzaa8zgZn+8C9"
Content-Disposition: inline
In-Reply-To: <120a34be-bc0d-4202-9996-c5da8cf15963@baylibre.com>


--FZ/nzaa8zgZn+8C9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 10:26:42AM -0500, David Lechner wrote:
> On 4/17/26 8:38 AM, Ariana Lazar wrote:
> > Change maxItems value from 8 to 1 for the channel number reg property.
>=20
> The commit message needs to explain why this is the correct thing to do.

With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

>=20
> >=20
> > Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microch=
ip MCP47FEB02")
> > Link: https://lore.kernel.org/all/20260403-speed-childless-1360de358229=
@spud/
> > Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> > ---
> > Changes in v2:
> > - keep just maxItems value update in this patch
> > - remove Reported-by from commit message
> > - Link to v1: https://lore.kernel.org/r/20260416-mcp47feb02-fix5-v1-1-9=
656c2fed6d2@microchip.com
> > ---
> >  Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | =
3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47f=
eb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.=
yaml
> > index d2466aa6bda2106a8b695347a0edf38462294d03..f2efa0ccbaa32482dcdc69d=
98c1565518538793f 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.ya=
ml
> > +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.ya=
ml
> > @@ -161,8 +161,7 @@ patternProperties:
> >      properties:
> >        reg:
> >          description: The channel number.
> > -        minItems: 1
> > -        maxItems: 8
> > +        maxItems: 1
> > =20
> >        label:
> >          description: Unique name to identify which channel this is.
> >=20
> > ---
> > base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
> > change-id: 20260416-mcp47feb02-fix5-26994c5b428c
> >=20
> > Best regards,
>=20

--FZ/nzaa8zgZn+8C9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeJa8QAKCRB4tDGHoIJi
0uAmAP4q4FFnQCEqx214vwq/24YuJXBNyLyV2gUi3uQ6RA8q5wEAptUVJZiccT0I
vhJGwXqnQGGfqphIwSgmkkZ3jjl88QY=
=a0DA
-----END PGP SIGNATURE-----

--FZ/nzaa8zgZn+8C9--
