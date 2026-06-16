Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F344B68E;
	Tue, 16 Jun 2026 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625233; cv=none; b=cE6T+ul1/yj56hQFkQ2EEcFOAJcluRw453IrAKbskkVlA3I78Falg6ZpNJerZOoj1jk+xI1vZv1/yzMY50ahxyonp6vo8GplayF+Ofzi03WaLfZubC2Ln9LYgr/ujRqhpfarMRqSu4OrCFRtGBbPoq8XitlQwwfXA/a6fFF2EIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625233; c=relaxed/simple;
	bh=HeUv89ZGguWKg6n0tqK+ayvHm1ZtgTEQS3OogBR7hRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6+jh9USR+KaH9UfRwDlNCQOYNKJd/3VjXaDgu01yxbuW+5EE6G/G/EsXY6FP2iiDda9spfGjeXiNzGmy+Odmn/+07BLUL6AX7+2Q/3yOuLOSXsXd3eaZXuksMiSrB/kDqJHJPDlHdcA+O1a2ySxV3qG8QF/2rvkKzDH/NoGDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0te7mrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0te7mrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1BC1F000E9;
	Tue, 16 Jun 2026 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625231;
	bh=scDUNIddi4ZzdKLBItR/UZauF9ckesM+pWJQRPb6Jzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U0te7mrhqPiIZQIHHMzCgoKsRWHsJ8ZOwwAmgRYaMoIi8ZKrYGnQLLqUe4hC4DnNC
	 gUMClGampF4scoWQhgSBjSVg0igadmxl6SAjLbwLsKxBp/ZAWPI/T7A0kthFrej/jW
	 cRSGVjFlBVvEBqp5DmjEBsyD+/E+GvHuqF+vQgCkLFPyWAIN9Y4A3nVth568pFaKOn
	 I8LVIHm7XXYN8d5/m0QVs8aQJuw6kTHG/djrssEaLktveZ/+lWE/ykJO6uVnjucNZ9
	 geqMOAqA+F+Hl49T7nOmExXhr6Xpf8lSh/vDsbLl7llfs2QPtnvFTiQEX+NG8OVpYq
	 USKIvibpJDVSw==
Date: Tue, 16 Jun 2026 16:53:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/6] dt-bindings: iio: add Open Sensor Fusion
 device
Message-ID: <20260616-enigmatic-remarry-4f1a4d06e637@spud>
References: <20260616072242.3942-1-kimjinseob88@gmail.com>
 <20260616072242.3942-2-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3bnkUp/jfd+0j8OX"
Content-Disposition: inline
In-Reply-To: <20260616072242.3942-2-kimjinseob88@gmail.com>


--3bnkUp/jfd+0j8OX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 04:22:37PM +0900, Jinseob Kim wrote:
> Add the generic Open Sensor Fusion device binding for a serdev-attached
> IIO sensor aggregation hub, and document the opensensorfusion vendor
> prefix.
>=20
> The opensensorfusion,osf compatible describes the generic Open Sensor
> Fusion host interface. OSF GREEN is not the Linux compatible identity.
> Likewise, OSF0 is the current wire magic and a wire-format detail, not
> the Linux driver identity.
>=20
> The fixed OSF frame header carries protocol_major and protocol_minor at
> fixed offsets. This driver currently supports protocol_major 0.
> protocol_minor changes are intended to remain backward-compatible within
> that fixed header layout. Incompatible wire-format changes require a new
> protocol_major. If a future device cannot expose compatible version
> discovery through the fixed header layout, it will need a different
> compatible.
>=20
> Require vcc-supply so the driver can enable device power before starting
> communication.
>=20
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  .../bindings/iio/opensensorfusion,osf.yaml    | 59 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   | 13 ++++
>  3 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusio=
n,osf.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,osf.y=
aml b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> new file mode 100644
> index 000000000..012a07fd6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/opensensorfusion,osf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Open Sensor Fusion Sensor Aggregation Hub
> +
> +maintainers:
> +  - Jinseob Kim <kimjinseob88@gmail.com>
> +
> +description: |
> +  Open Sensor Fusion is a sensor aggregation hub. The hub exposes an OSF
> +  protocol data stream over its host interface and may report capabiliti=
es and

s/may report/reports/ because mandatory reporting, even if nothing is
actually there, is a requirement for having a compatible describing the
"bus".

> +  samples for multiple sensor classes. The Linux driver discovers the ac=
tual

s/The Linux driver discovers the actual sensor channels/The actual sensor c=
hannels are discovered"
Because although maybe only linux will use this it should not be
specific.

> +  sensor channels from OSF capability reports instead of describing those
> +  sensors in Device Tree.
> +
> +  Open Sensor Fusion is not a generic industry standard. Public project

I would drop this first sentence to be honest.

> +  documentation is available at:
> +
> +    https://github.com/opensensorfusion
> +
> +  The compatible describes the generic Open Sensor Fusion host interface=
=2E It
> +  is not an OSF GREEN board identity, and it does not encode the OSF0 wi=
re
> +  magic. OSF0, protocol_major, and protocol_minor are wire-protocol deta=
ils
> +  exchanged in OSF frames.

I think I move this to the first paragraph and would say something like

| This binding documents the generic Open Sensor Fusion host interface.
|=20
| Open Sensor Fusion is a sensor aggregation hub. The hub exposes an OSF
| protocol data stream over its host interface and reports capabilities and
| samples for multiple sensor classes. The actual sensor channels are disco=
vered
| at runtime from OSF capability reports instead of describing them in Devi=
ce
| Tree.
|
| The protocol version is discovered at runtime.

Does that sound about right?

> +
> +allOf:
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: opensensorfusion,osf
> +
> +  vcc-supply:
> +    description:
> +      Regulator supplying power to the Open Sensor Fusion device.
> +
> +required:
> +  - compatible
> +  - vcc-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    vcc_sensor: regulator-0 {
> +        compatible =3D "regulator-fixed";
> +        regulator-name =3D "sensor-vcc";
> +    };

Drop this node, the tooling fakes one when running the checks. Only keep
nodes that actually form your device here. Same way you don't need to
actually fill out the serial port.
pw-bot: changes-requested

> +
> +    serial {
> +        sensor {
> +            compatible =3D "opensensorfusion,osf";
> +            vcc-supply =3D <&vcc_sensor>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 28784d66a..88172d4a4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1237,6 +1237,8 @@ patternProperties:
>      description: OpenPandora GmbH
>    "^openrisc,.*":
>      description: OpenRISC.io
> +  "^opensensorfusion,.*":
> +    description: Open Sensor Fusion
>    "^openwrt,.*":
>      description: OpenWrt
>    "^option,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2c6d7927..2ddefc42d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20011,6 +20011,19 @@ F:	Documentation/devicetree/
>  F:	arch/*/boot/dts/
>  F:	include/dt-bindings/
> =20

> +OPEN SENSOR FUSION IIO DRIVER
> +M:	Jinseob Kim <kimjinseob88@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> +F:	Documentation/iio/open-sensor-fusion.rst
> +F:	drivers/iio/opensensorfusion/Kconfig
> +F:	drivers/iio/opensensorfusion/Makefile
> +F:	drivers/iio/opensensorfusion/osf_core.*
> +F:	drivers/iio/opensensorfusion/osf_iio.*
> +F:	drivers/iio/opensensorfusion/osf_protocol.*
> +F:	drivers/iio/opensensorfusion/osf_serdev.c
> +F:	drivers/iio/opensensorfusion/osf_stream.*

At this stage, only add the binding. The rest should be added when the
files are.

Cheers,
Conor.

> +
>  OPENCOMPUTE PTP CLOCK DRIVER
>  M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
>  L:	netdev@vger.kernel.org
> --=20
> 2.43.0
>=20

--3bnkUp/jfd+0j8OX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajFxigAKCRB4tDGHoIJi
0tZkAP4jApEuryBk71yEz2TwmeOGIBwIW0y062x1514u4ZB2lwEA/hmJuE8o89Ip
vRV5U2GrpZQDKuU609GGj4Fm0IIH4gw=
=uVxr
-----END PGP SIGNATURE-----

--3bnkUp/jfd+0j8OX--
