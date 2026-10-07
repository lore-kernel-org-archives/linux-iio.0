Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52A29408;
	Wed,  7 Oct 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378317; cv=none; b=TlzTo6ZZ3jRUc98rZ/pqaY5f/RuQ4HVpW3X7Kfzh3vq0WXTtlObis0wwHWyzavIy1/yYUdV4PnJYNjdy87KrWgxLDgm47dNQPw6Wev9KKtEEn6acFwr9vxj5s1VjlrEgaLPPLnilUFFl4EvJ4Tc4xNALqKi7x4li5CWKp9L9U+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378317; c=relaxed/simple;
	bh=2tP+ifbjocSY1XmYcSlhdCFp12TTOlHyhXW/Mu7FTRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuWhxNFq5HvmDetGYzDbqbqxqDO2H5C+Xu8Nn0BjrBE+uvcRcbrED57Qtvcy9P4zaSYfGUeReUxjsnRJnAi3UhW6u8D+yBaLuQxr35qkx5o1HcCq3r/Zlp5F329Y2vFzda6ji3TjXjyIlwSzBCQU3Sj4UY1Kq7cPxD/0k2Rb7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iksfkcwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iksfkcwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA211F0089B;
	Wed,  7 Oct 2026 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791378309;
	bh=1xyFY2/qjSfzfOEEqstRe13yg3w1MmOIvKuE98LYfVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iksfkcwV7xFdTzISErXb2Xu1BYx2pGEMxaKg71yI1MLQEgNXOSHwv2IkjDJz5HAjs
	 7Bpp0JlaK+Zyvli16Ls0FnmcH3a+t5bKOUOpnolE0BRhO6IbT0YRWSwDhrj0zcWNNR
	 h5FS274dckjwIrUJPXEEKVcVyEZkzHZFgFMF5mVHkMdHTomN9xSB2hpIYEQJCq7T+i
	 Utb3ZVdl1Cn3+4BoMHMCOjErkn6QGCqm4fRq44WLzEN8xBZrcUx7SMMqrGonXOY0tC
	 hE2m90UNaT5aSgAouLeciwD9kq+vWoFCDMEgB8kXoaApbq+EccC9kS+v8v7Il3w8bD
	 jAG80pIB85LIQ==
Date: Wed, 7 Oct 2026 14:05:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ti,tmp117: describe interrupts for
 TMP117
Message-ID: <20261007-b011a79717a2ebec6f613c6c@squawk>
References: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
 <20261005-add-tmp117-notif-v1-1-c6cef6fad64c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ETSjIwFJfDXvsQMH"
Content-Disposition: inline
In-Reply-To: <20261005-add-tmp117-notif-v1-1-c6cef6fad64c@bootlin.com>

--ETSjIwFJfDXvsQMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2026 at 04:44:19PM +0200, Thomas Bonnefille wrote:
> The TMP117 can send alerts when the temperature crosses a low or high
> limit. This triggers an interrupt on the ALERT pin.
>=20
> Add the optional interrupts property.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml | 9 +++=
++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.=
yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index 7fb3e68207919..68ee936722ded 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -30,6 +30,11 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  interrupts:
> +    description: |

Valid comment here, but I wouldn't respin for it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Cheers,
COnor,

> +      Interrupt line connected to the ALERT output of the sensor.
> +    maxItems: 1
> +
>    vcc-supply:
>      description: provide VCC power to the sensor.
> =20
> @@ -45,6 +50,8 @@ additionalProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
>      i2c {
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> @@ -52,6 +59,8 @@ examples:
>          tmp117@48 {
>              compatible =3D "ti,tmp117";
>              reg =3D <0x48>;
> +            interrupt-parent =3D <&gpio0>;
> +            interrupts =3D <5 IRQ_TYPE_LEVEL_LOW>;
>              vcc-supply =3D <&pmic_reg_3v3>;
>          };
>      };
>=20
> --=20
> 2.55.0
>=20

--ETSjIwFJfDXvsQMH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZDfwAKCRB4tDGHoIJi
0th3AQCowekS+yV2wRtr/tMfZMPC0FEQS9GbKJj4Gn9d8UjiyAD8DCZzJh3a+y+v
Qh0cu4sn1ha7AjTvvYk9ivy4Y+euwQ4=
=OXVZ
-----END PGP SIGNATURE-----

--ETSjIwFJfDXvsQMH--
