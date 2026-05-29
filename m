Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B993DE45C;
	Fri, 29 May 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072308; cv=none; b=a+UM18BT8+SerP3IPTk/oehHDul64lkDUbo0vR6jk6FxdcpDRYCy2g9+GstCjQOv84FKRht7+rGZbZB0SywBijqmX8F7TkVvvqyw8Mzyw9uITQvDdrdm8zB/+iOg70QiwHC9IxFMFfBV2CFuyL1hD3SL1HarCGDbMv+5EG5BXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072308; c=relaxed/simple;
	bh=ESeXRMfx8qWbB0YQ8x/UseGEMXfKQfaXrT8L9aN9UBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHuYDK9dOYQE2hKN8GyrwZJ8H1zkYOi+P2+Str5Zt5YkX/56TGQRheSh1F2onRFJ9gjLGFxr0EKuHUen7PZplnQ7xfPOuGCHju8pY4N7MTebnU/Z01tqkhuLwQkqHwYv60/8n+2qhhXa5EuXfF5msseQnRRlxYeq0P18xNQzN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTJJaQjT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTJJaQjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680F21F00893;
	Fri, 29 May 2026 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780072306;
	bh=mLcbHWOvU3I6HLKgiFvg8x4kEjsll0o2NB1ANzufR/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eTJJaQjTS4SiDRWfywDcx+OolD9ryElqTFYsiQhD0zlbLoOYPj8bge01KxO8kmvSn
	 be9DFe2EaSohkqvjVme/nu9cp752wqfvu3wV+SpIQADFaoeCrzLgIZx7bxVfzgqFgL
	 a/gnob/6IM5vdUFZ4FV8/GVZdmu1qa648Oe567A919TCqhkMbQYU737asDw6Y1qskm
	 a8AyHWukZkQY3asO0+rnEmRa7FHJySUTEUAaldJA1o3v6E2DouzlIDOyhTio4541oN
	 fsK4lhLeXBudq1gJfXIf7nwoTso5/DCxUoToyOL3VktVlyxUUdBqXEhlJxkGOmR6Aa
	 24VYB0rroYpwg==
Date: Fri, 29 May 2026 17:31:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/6] dt-bindings: iio: add OSF GREEN sensor
 aggregation device
Message-ID: <20260529-recant-imperfect-ba65ef80e542@spud>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
 <20260529121005.1470-2-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fQokb3JVQ6ICtlTe"
Content-Disposition: inline
In-Reply-To: <20260529121005.1470-2-kimjinseob88@gmail.com>


--fQokb3JVQ6ICtlTe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 09:10:00PM +0900, Jinseob Kim wrote:
> Describe OSF GREEN as the first board target.
>=20
> Add vendor prefix and MAINTAINERS binding entry.
>=20
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  .../iio/imu/opensensorfusion,osf-green.yaml   | 43 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  5 +++
>  3 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorf=
usion,osf-green.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,o=
sf-green.yaml b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,=
osf-green.yaml
> new file mode 100644
> index 000000000..626b41fb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-gree=
n.yaml

This is still not an IMU.
pw-bot: changes-requested

> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/opensensorfusion,osf-green.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OSF GREEN sensor aggregation board
> +
> +maintainers:
> +  - Jinseob Kim <kimjinseob88@gmail.com>
> +
> +description: |
> +  OSF GREEN is an STM32F405-based sensor aggregation board from the Open
> +  Sensor Fusion open hardware project. It sends OSF0 capability, status,=
 and
> +  sample frames to a host over a UART link.
> +
> +  Open Sensor Fusion is not a generic industry standard. Public project =
and
> +  hardware documentation is available at:
> +
> +    https://github.com/opensensorfusion
> +    https://github.com/opensensorfusion/opensensorfusion-hardware
> +
> +allOf:
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: opensensorfusion,osf-green

I'm still not convinced by the compatible here, or at least I am not
convinced by it without clear answers to my questions on v1 about
discoverability and compatibility between protocol versions. If the
software on the "osf-green" is updatable (it is, right?) the compatible
doesn't actually represent the hardware, it represents the programming
model of what's exposed on the serial port to the host. That means the
compatible you use has to identify the exact protocol version
implemented, or provide enough information that the version can be
figured out by software.

Given you talk about OSF0 communicating capability etc, it seems to me
like OSF0 is a discoverable bus? In that case, compatibles for boards
doesn't really matter, all software should need to know is that there is
an OSF0 "bus" and query it for what sensors are there.

The questions I asked on v1 were:
- What does "v0" mean here? Is the data format not complete yet?
- Are versions of the protocol likely to be backwards compatible?
- Will the device identify what version of the protocol it implements?

Remember, there's no rush here, and you're better off slowing down and
taking your time responding to reviews before sending new versions, so
that the same conversations don't take place multiple times.

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serial {
> +        sensor {
> +            compatible =3D "opensensorfusion,osf-green";
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 28784d66a..f1b1f2ad3 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1237,6 +1237,8 @@ patternProperties:
>      description: OpenPandora GmbH
>    "^openrisc,.*":
>      description: OpenRISC.io
> +  "^opensensorfusion,.*":
> +    description: Open Sensor Fusion project
>    "^openwrt,.*":
>      description: OpenWrt
>    "^option,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2c6d7927..26bbdf8d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19977,6 +19977,11 @@ F:	Documentation/networking/oa-tc6-framework.rst
>  F:	drivers/net/ethernet/oa_tc6.c
>  F:	include/linux/oa_tc6.h
> =20
> +OPEN SENSOR FUSION IIO DRIVER
> +M:	Jinseob Kim <kimjinseob88@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.=
yaml
> +
>  OPEN FIRMWARE AND FLATTENED DEVICE TREE
>  M:	Rob Herring <robh@kernel.org>
>  M:	Saravana Kannan <saravanak@kernel.org>
> --=20
> 2.43.0
>=20

--fQokb3JVQ6ICtlTe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahm/bQAKCRB4tDGHoIJi
0sEcAP0ZoKZ/Ut24KMgR9zjcP48fLsZcrvTIT6PmPSoAcZL7IwEAvGdDHJN3J/3L
8zEZzUQ7YacyErwbpf8e3zpvylNp5Q0=
=Rv46
-----END PGP SIGNATURE-----

--fQokb3JVQ6ICtlTe--
