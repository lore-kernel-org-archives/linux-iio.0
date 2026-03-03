Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39042F561;
	Tue,  3 Mar 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565146; cv=none; b=MFlV2zTrYSDKTqnr0t7aQbdSRsyKT5aAomKOU9QgMRgD2F8YtFc3iOwdvljDqpxhRgQbH+5ErKAeMa/r/VkTI1SuPZnDwu/OcbAtzGulGCvCXHs0WEzVfw4CoCDSZEtvLjGR+1/LZQzljXvAsJbIzfD+944ghNLhBFvWQutEXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565146; c=relaxed/simple;
	bh=XUSvetyTzglsf5OhBrTm5m3Lr8AqkfzoUD2DgyXy31s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUByAQuNcH5IpgtmzhhNwIoI68VGuU70RsBYk++caH6qmaYCaZFaWXq0sNM+lZe6+s+KYE7SdeIk7CFBqN4reP5aPEAhMxKxszP02nXwQ4llrMufOqP93nZj2gE+4RaD6F7tNVkNhdB1uvLUVG2+ALaDE0kOwIhpWVuXNZVOzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufNF0w7b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufNF0w7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B4FC19425;
	Tue,  3 Mar 2026 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565146;
	bh=XUSvetyTzglsf5OhBrTm5m3Lr8AqkfzoUD2DgyXy31s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufNF0w7bwN2xo4rjum4lbd3h1kROJT5JOE+tSGFk46Nbywuyx1K2bAXvpZ42IeNhf
	 gVrqertTAdeZ7KmUXeFa7bhIpowV1KlLe7P2aHFcI6UtaJOcuek/+vz2AdlI0UdAAU
	 ILXumH5EUAt6hWS7x5Qc5kW3R4xdpzRHEg/D/oHEoB2F+XUzhVnQ5USD0kdsZwXVPK
	 DzzKYdFgMJpJPybNsSP/By/aRB+I6QALLjrqcP7zDXLnLm79J/LAGwYZjHr9zlHInF
	 zciyLOtQRCl/CoWPdx3rBVAC1oR5aSZfTQ6uUHkXXd+PMmNYNSvf8LA+qAikOJ22oC
	 gjUSDmLjQBMrQ==
Date: Tue, 3 Mar 2026 19:12:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
Message-ID: <20260303-strike-froth-a2e082b8b59e@spud>
References: <20260303090253.42076-1-email@sirat.me>
 <20260303090253.42076-2-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eQcAm1h3NkZ4n2em"
Content-Disposition: inline
In-Reply-To: <20260303090253.42076-2-email@sirat.me>


--eQcAm1h3NkZ4n2em
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 03:02:40PM +0600, Siratul Islam wrote:
> Add device tree binding documentation for the STMicroelectronics
> VL53L1X Time-of-Flight ranging sensor connected via I2C.
>=20
> Signed-off-by: Siratul Islam <email@sirat.me>
> ---
>  .../bindings/iio/proximity/st,vl53l1x.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl=
53l1x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.y=
aml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
> new file mode 100644
> index 000000000000..1b14063ba344
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/st,vl53l1x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST VL53L1X ToF ranging sensor
> +
> +maintainers:
> +  - Siratul Islam <email@sirat.me>
> +
> +properties:
> +  compatible:
> +    const: st,vl53l1x
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg

Are you sure the supply is not mandatory?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        proximity@29 {
> +            compatible =3D "st,vl53l1x";
> +            reg =3D <0x29>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <23 IRQ_TYPE_EDGE_FALLING>;
> +            reset-gpios =3D <&gpio 5 1>;
> +            vdd-supply =3D <&vdd_3v3>;
> +        };
> +    };
> +...
> --=20
> 2.53.0
>=20

--eQcAm1h3NkZ4n2em
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaacylgAKCRB4tDGHoIJi
0gbTAQCtEW+b8yKX0PtNjJWO7RdaLVebG3jDu0s4Sz7vjuxwggD9HMVkIbX+hJKE
10m0222O40XDML8cK5rDLECnrRGszw0=
=RVMK
-----END PGP SIGNATURE-----

--eQcAm1h3NkZ4n2em--
