Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F11C5D5E;
	Fri, 17 Apr 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442410; cv=none; b=IElB8oE4cOiDbCFw8qtb8S4gO2W3GOer19Xge5ZtOR392PsiolItdONCtxP0kDaqZkXnp9gSSCxKqP+ocvaI62jxyj/KLwZg8OcdP7DsPcbKtXP9oXrzX1CpB8kochLldSNBSyTWKAqcvbfqrJiGPN/rYmZOREwnON1WUHX7bBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442410; c=relaxed/simple;
	bh=XfR1MRCiMXk9z2QJdyVebqssfGbIKUIhMlAyQ9tajZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB/5nNXX5f8OTdBXj5GcyT5E4Bb/g72Wvj7VB0x6lGFyDBmoEH8J84FDo3qdAhhjuO87SkLWtxa1ek3A2RHlJA1G1EE2JnZ2fhdQNTy092hDzsfrk7lKNpF7inCG0fdCwykYKdFLyTD9N2eDzSVfrxjiFh8Oj9zlkEsJ7tjUINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGStOxue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGStOxue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE443C19425;
	Fri, 17 Apr 2026 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442410;
	bh=XfR1MRCiMXk9z2QJdyVebqssfGbIKUIhMlAyQ9tajZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGStOxuexWzzCFGyA/pU4nchHTnEDkJVZ5z4LQZiYHo5wS+s0DKyCkztZTonuRfqL
	 5qiy5TN5dJbc+v324u4t8qAz1X5ZUeETw02xuCLRk9t9kFtTIRmijapssIyZ+KOM8a
	 97oJEFsf5NpEnceS/Ak+AH4e/Yh7kWqyafQAlyKrMahq02LK+QEMp8TKHnSTOh8KRC
	 ssIq2o+EijYfSZMZleTegG9tDsv3Nezvlj1HhcLVokO9bcRBTZhp0BSDKNotpoA496
	 4YB9xCnNloM7l4IIiM2au/5NSzbGKITPRBp70t7B7sXsCp3HlSg98L+mpsRIeRe1kC
	 8bi6gS0v+kDQw==
Date: Fri, 17 Apr 2026 17:13:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: wbg@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: counter: add gpio-quadrature-encoder
 binding
Message-ID: <20260417-banjo-uncross-fbec3af75617@spud>
References: <cover.1776372319.git.wafgo01@gmail.com>
 <1663eb2f4bf4c826cd190fa9974fb55c321e7073.1776372319.git.wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xppdDS1/IJxjj7z"
Content-Disposition: inline
In-Reply-To: <1663eb2f4bf4c826cd190fa9974fb55c321e7073.1776372319.git.wafgo01@gmail.com>


--4xppdDS1/IJxjj7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 10:48:17PM +0200, Wadim Mueller wrote:
> Add devicetree binding documentation for the GPIO-based quadrature
> encoder counter driver. The driver reads A/B quadrature signals and
> an optional index pulse via edge-triggered GPIO interrupts, supporting
> X1, X2, X4 quadrature decoding and pulse-direction mode.
>=20
> This is useful on SoCs that lack a dedicated hardware quadrature
> decoder or where the encoder is wired to generic GPIO pins.
>=20
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  .../counter/gpio-quadrature-encoder.yaml      | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/gpio-quadra=
ture-encoder.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/counter/gpio-quadrature-en=
coder.yaml b/Documentation/devicetree/bindings/counter/gpio-quadrature-enco=
der.yaml
> new file mode 100644
> index 000000000..a52deaab6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.y=
aml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/gpio-quadrature-encoder.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO-based Quadrature Encoder
> +
> +maintainers:
> +  - Wadim Mueller <wadim.mueller@cmblu.de>
> +
> +description: |
> +  A generic GPIO-based quadrature encoder counter.  Reads A/B quadrature
> +  signals and an optional index pulse via edge-triggered GPIO interrupts.
> +  Supports X1, X2, X4 quadrature decoding and pulse-direction mode.
> +

> +  This driver is useful on SoCs that lack a dedicated hardware quadrature
> +  decoder (eQEP, QEI, etc.) or where the encoder is wired to generic GPIO
> +  pins rather than to a dedicated peripheral.

Idea seems okay to me. Please rephrase this section to avoid talking
about drivers...

> +
> +properties:
> +  compatible:
> +    const: gpio-quadrature-encoder
> +
> +  encoder-a-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the encoder's A (phase A) output.
> +
> +  encoder-b-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the encoder's B (phase B) output.
> +
> +  encoder-index-gpios:
> +    maxItems: 1
> +    description:
> +      Optional GPIO connected to the encoder's index (Z) output.
> +      When the index input is enabled via sysfs, the count resets
> +      to zero on each index pulse.

=2E..and this to stop talking about sysfs and driver behaviour though.
Bindings are about hardware.
pw-bot: changes-requested

> +
> +required:
> +  - compatible
> +  - encoder-a-gpios
> +  - encoder-b-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    quadrature-encoder-0 {
> +        compatible =3D "gpio-quadrature-encoder";
> +        encoder-a-gpios =3D <&gpio0 10 GPIO_ACTIVE_HIGH>;
> +        encoder-b-gpios =3D <&gpio0 11 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    quadrature-encoder-1 {
> +        compatible =3D "gpio-quadrature-encoder";
> +        encoder-a-gpios =3D <&gpio0 10 GPIO_ACTIVE_LOW>;
> +        encoder-b-gpios =3D <&gpio0 11 GPIO_ACTIVE_LOW>;
> +        encoder-index-gpios =3D <&gpio0 12 GPIO_ACTIVE_LOW>;
> +    };

I think this example alone is sufficient btw.

Cheers,
Conor.
> +
> +...
> --=20
> 2.52.0
>=20

--4xppdDS1/IJxjj7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeJcJgAKCRB4tDGHoIJi
0iBSAQCmdXa09NCN5DWDflfzY8xohz/vQeGrwnxCcRlvQ8W8LAEAjWqA1ZrAO/nO
j8pCYp9TVd8PG47Yb9LLJv1VXA2c5AM=
=ZqyO
-----END PGP SIGNATURE-----

--4xppdDS1/IJxjj7z--
