Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB422B2D7;
	Thu,  3 Sep 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459262; cv=none; b=JQ/u6NHqlvCw5+hGMgxBEInvXMZIrqnTd2E2Q61kDz0DRYFVkAiKtxYp16hM668ZsCjDnETGlh/HuXYsCg8uwRLnxVi5QXI9WxyvgFtg6wDKIvLJ4VoWpNzO5xAF6O0WIGTDz70YLWJ9RIpxRUWd+8rbZ70rsTyOphM/alxeaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459262; c=relaxed/simple;
	bh=oa0ct9XZCNukubHIRgbt0r+Y2sziCh0Wo3Xum7WgN88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt0Fef1jVhCSOx466ojsM8znSJY0YsXFoLHhfsU4hbR3M2kuJgohBCuEGqHUVM6b2G5Cwz7LOPJZCBubpzAJslnVW2tJWuC3Af+Uxdbrd2iiQD4lxh4kbxTEnQ7Lvyi8hwWaR7Sf7qgFlqx0oshqgjPZ7d8YF2fZIqm71ouEPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF72g4q6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF72g4q6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0273E1F000E9;
	Thu,  3 Sep 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459261;
	bh=Bh0mPHUgTTVEBXhgzuscT6xYffFu4fD+871JIrDIYIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PF72g4q6JWcB45KHIC2mcejgthJR/2Is1fK2QPnr+Rjxq8I++1WXYFQqa1KNyvw1V
	 703MgAYo5AdIgkRJbcUJrM7xhHbUa2GBkG4EUXAkbBZWt92GfC7UYZYf5F/cGxeK1M
	 TG4YuMJh9bRMTeEREIGHhw0ho33HEyLO81Vw8h1uC7wI2xWUJos0VvJ/m7ZwuY3N89
	 ijCNmlsZUK/5ELnIYKvOuBQxjCBM+ttSnmCe+G/8hk1JsM0jCxLuU8wnSWbaum4SnC
	 1dRhXvVus+eOJo81DYX/o1d9hBExuwlwWhINq3Cet3UXFuUAhRQQwv5Hg9k4P4fl98
	 zhXbQeUzyMx5g==
Date: Thu, 3 Sep 2026 19:14:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <20260903-liquefy-prologue-9ec914cccf04@spud>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YN3b9okDwst2Quk2"
Content-Disposition: inline
In-Reply-To: <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>

--YN3b9okDwst2Quk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 02:24:02PM -0300, Marcelo Schmitt wrote:
> Document how AD4134 chips are connected to the host SPI controller
> according to different wiring configurations.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4134.yaml          | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> index ea6d7e026419..d843c02a394a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> @@ -131,6 +131,28 @@ properties:
>      enum: [ free-running, gated ]
>      default: gated
> =20
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> +    description: |
> +      This property indicates the SPI wiring configuration.
> +
> +      When this property is omitted, it is assumed that the device is us=
ing
> +      'no-cs' wiring. When this property is present, it indicates that t=
he
> +      device is using one of the following wiring configurations:

"default: no-cs" and drop the text about the default, but there's some
pretty interesting comments from Sashiko about #daisy-chained-devices
(used for ad7944), although I'm not sure how that'd work for the
two-channel-chain case.

I'd also really appreciate a dts example for a system
with one-channel-chain or two-channel-chain looks, given the second
device may require different supplies etc. I have no impression in my
head of how the dt would be constructed, so I'd like to see wht you have
in mind.

> +
> +      * no-cs: The datasheet calls this "minimum I/O mode". In this mode=
, the CS
> +        line is not used (tied to GND).
> +      * 4-wire: Specifies a conventional SPI wiring configuration.
> +      * one-channel-chain: In this mode, the DOUT0 line of one chip is c=
onnected
> +        to DOUT2 of the next chip upstream in the chain. Only the data i=
nterface
> +        of the upmost device in the stream is in direct connection with =
the
> +        digital host.
> +      * two-channel-chain: In this mode, the DOUT0 and DOUT1 lines of on=
e chip
> +        are respectively connected to DOUT2 and DOUT3 of the next chip u=
pstream
> +        in the chain. Only the data interface of the upmost device in th=
e stream
> +        is in direct connection with the digital host.
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.53.0
>=20

--YN3b9okDwst2Quk2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapm49wAKCRB4tDGHoIJi
0jNvAP9YzNPJ9J8T3La72HqlFhTFOeKrAe6S2QhHwteDSeRXyQD/S5O+rT5wxBa3
5PRRjkM42VOd7KsKeVnu3HboUElTSAI=
=Dxen
-----END PGP SIGNATURE-----

--YN3b9okDwst2Quk2--
