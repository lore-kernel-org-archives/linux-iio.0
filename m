Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAC369D64;
	Wed, 20 May 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294823; cv=none; b=qbqVu7GWr2VruUcwkwk7LMMM0BRMyWM6g4DV/yGbxaLtapJLYBQCCWeCvGoxehxDCtUSb9O3RgHm+U2xjldhowKAU6wmkrnnrxmzJaKoNbW9hupWg72J4j2chsPVWPQgkFwcu1vtVa1PGFeYhInpd/wuYtZBn8LqQP4knrn1R6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294823; c=relaxed/simple;
	bh=Dg3jYGGBVZIpejkXSZNeznAE6mS8nAvhVjrJgbMBotE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBpADh9GirEJeTr7Ivt4ZH1F+1ckRa/vRB+fcYq90FVQBzYOrj8RJbEwf2ZcXw1SY4ibefGFAb04Ad5q2mZjMlunsIjUcNqN77nc/y1r+mwsWiIe/xj10EmXXi7/bHrVNnouRf4TR/zzudpQgkhXpv95DENTi/e+rULIo8NChnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVBTou3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVBTou3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757DF1F000E9;
	Wed, 20 May 2026 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294822;
	bh=QuvAeovgYbXlcjbl/ERzZ79WVydxOAiAHGfibxIYKCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nVBTou3oxSQaKh0ayQ4sn1ipUzWw8t//+zmJ8XyS3ekbUv7N61rZh93M0fhxM1FfP
	 Bs/SenIuppucf+kZ9+HtSrLcKkCa+8cilt6Ehlu22tLAmw58foW+L+sOp3jNgfsl0H
	 oBNmbNhPihgufixxe/uBAZwhgo/un1Mz52h43ToHOcgjK69vvVYAyr155MCywS/LNJ
	 1IsaLecrJoSS5gwwQHRp/luIfYAXzwRaPKpNRiTm6EcP8YNRDyXiqX0MVOBw0DxHna
	 FRDAFNoUKHKljbbfwoxDXaTevEVzQ+wDCW3iCSR7QZfEp6boZ7Ojjih8FZ+tbuj38y
	 x29x9M7X0DDkQ==
Date: Wed, 20 May 2026 17:33:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: imu: add Open Sensor Fusion
 UART binding
Message-ID: <20260520-ozone-broadband-566893108675@spud>
References: <20260520072843.3593-1-kimjinseob88@gmail.com>
 <20260520072843.3593-2-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TX8QxEPIzEcsatEW"
Content-Disposition: inline
In-Reply-To: <20260520072843.3593-2-kimjinseob88@gmail.com>


--TX8QxEPIzEcsatEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 04:28:41PM +0900, Jinseob Kim wrote:
> Add a binding for a UART-attached Open Sensor Fusion device.
>=20
> The device is exposed as a serdev child node using the
> opensensorfusion,osf-uart compatible string.

> Keep Raspberry Pi overlay and
> test notes outside the binding.

This should not be in the commit message, it's not relevant info.

> The binding has been checked with dt_binding_check.

This is a requirement, there's no reason to state it in the commit
message.

>=20
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  .../iio/imu/opensensorfusion,osf-uart.yaml    | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorf=
usion,osf-uart.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,o=
sf-uart.yaml b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,o=
sf-uart.yaml
> new file mode 100644
> index 000000000..6f329c326
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart=
=2Eyaml

I find it hard to believe that this is an "imu". It sounds more like
this is a bus or remoteproc than anything else.

> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/opensensorfusion,osf-uart.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Open Sensor Fusion UART Sensor Aggregation Device
> +
> +maintainers:
> +  - Jinseob Kim <kimjinseob88@gmail.com>
> +
> +description: |
> +  Open Sensor Fusion is a UART-attached sensor aggregation device. The d=
evice

What actually is this device?
Googling "open sensor fusion" gives me
https://github.com/memsindustrygroup/Open-Source-Sensor-Fusion
and
https://www.nxp.com/company/about-nxp/smarter-world-blog/BL-OPEN-SOURCE-SEN=
SOR-FUSION
but neither of these explain to me what sort of device we are looking at
here. Seems as if it is not /a/ device at all, but could be one of many
devices, provided that they implement the other side of the protocol?

> +  exposes an OSF protocol v0 data stream over its host UART interface an=
d may

What does "v0" mean here? Is the data format not complete yet?
Are versions of the protocol likely to be backwards compatible?
Will the device identify what version of the protocol it implements?

> +  report capabilities and samples for multiple sensor classes.

Yeah, then definitely this is not an "imu".

> +
> +properties:
> +  compatible:
> +    const: opensensorfusion,osf-uart

If this is some sort of remote processor slaved to the os, it seems possible
that the may be required to do turn its power or reset it somehow. Having
nothing but a compatible seems incomplete to me but I have no idea what
the complete set of properties would actually be.

Probably a good bit of discussion is needed here, but for now:
pw-bot: changes-requested

Thanks,
Conor.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    serial {
> +        sensor {
> +            compatible =3D "opensensorfusion,osf-uart";
> +        };
> +    };
> +...
> --=20
> 2.43.0
>=20
>=20

--TX8QxEPIzEcsatEW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag3iYgAKCRB4tDGHoIJi
0vckAQDLbiqksyHZ2KXnVctQ1a7OmmtkRm5ToYvW0NsbR6GUrAD7B0Csl89UP7WV
ACzV719XTyDY2Sasg9dIJxC6N2A2WQY=
=Lkes
-----END PGP SIGNATURE-----

--TX8QxEPIzEcsatEW--
