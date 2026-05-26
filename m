Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089503B19C1;
	Tue, 26 May 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812384; cv=none; b=IkpZ49XB/VP7Blf9M0thRQJXLWxKdKxXECeq7ZO8s51X/xSy35Tiu2HkV/QngNq8hhZQcaxt1TuSQdoiHlzt0vDFRKsxPbNi75z8MaX4VBlhXToVGP4pNSRKt6fYHWhQaWh7On/1aUOH5EhGMG+uaiwXNDPuslWw4lM2VynzHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812384; c=relaxed/simple;
	bh=wX2T5ahvstsTUsFSPRjOm+/tVg+aRKBtV87CTIy5V6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPGB0kum2T+1EECbL+wI3rfMRtbUSsxux4z8JXkNOFOM+f64hw5NwIWMMjUYLPB789wUKBOvqPoRmZkb/Qd7XGG+4zIxsZo/wHbtPdURTyLf5Lf/Ob11jkq5K3scxfxIEWLAz+HYvqHpK4kkMW/iIkt0+AQI1xzZAXKfNSDJ//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo9UtqCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo9UtqCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70FF1F000E9;
	Tue, 26 May 2026 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812379;
	bh=lAMKO1kZvGxwn34y0wDp/WK+Var13mYqDq3n4y67LBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yo9UtqCiNUuq5j6nr2HFIkBedT5GTtHZ0fgXtXtGkTPRaVvdrBfNGGH2cLbaRU0Jg
	 cbZXrea07Hz2DOfNAjLt4dNwDLBDSrRw4jKKWH6nBSEBVA8juuqa+mAeTC1FtVQX2R
	 PAplWQUCIxhuTeBTdevFiCz9MEr8wjLNJW2G0/v+bgu83BbkFGc6ywyg94WTnaI+EP
	 Wu9ShXGnfEYQXtpFqLdby9l8lXOk+tarSoQ4r0Ms392EhilO44LG3IBXdAFLpzsyhG
	 bxou3+fHdzBORci9n5CB2ECi6eOSgBnY34vp/IAjEswaefCwYlS8WQ45FYWAxn1Z0e
	 Z/fPVy25Nz58A==
Date: Tue, 26 May 2026 17:19:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@roeck-us.net, jdelvare@suse.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/4] dt-bindings: iio: flow: add Sensirion SLF3x
 liquid flow sensor
Message-ID: <20260526171930.0db4125e@jic23-huawei>
In-Reply-To: <20260524205112.26638-3-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260524205112.26638-3-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 22:49:37 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> From: Wadim Mueller <wadim.mueller@cmblu.de>
>=20
> Add a DT binding for the Sensirion SLF3x family of I2C liquid-flow
> sensors.  A single 'sensirion,slf3s' compatible is exposed because
> the sub-types share the same register map and are detected at
> runtime via the product-information register.
>=20
> Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
Hi Wadim.

A few things inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/flow/sensirion,slf3s.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,=
slf3s.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.y=
aml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> new file mode 100644
> index 000000000..5ef62435f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/flow/sensirion,slf3s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SLF3x liquid flow sensor
> +
> +maintainers:
> +  - Wadim Mueller <wadim.mueller@cmblu.de>
> +
> +description: |
> +  Family of digital liquid-flow sensors from Sensirion with I2C interfac=
e.
> +  The same register map is shared by all family members; sub-types differ
> +  only in the flow scale factor exposed by the device and are detected at
> +  probe time via the product-information register.

Because that doesn't work for fallback compatibles, we often give devices
their own compatibles anyway. Fine to also detect in driver but if we get
something that falls back to an SLF3S-0600F I don't think there is any reas=
on
to think the subtype will match, so we have to trust DT to have given us
all the necessary info.

> +
> +  Supported sub-types:
> +    - SLF3S-0600F (calibrated range =C2=B12 ml/min)
> +    - SLF3S-4000B (calibrated range =C2=B180 ml/min)
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,slf3s

If you don't expect to add  more sensors this in near future would be fine
as a const rather than an enum.

> +
> +  reg:
> +    maxItems: 1

There seems to be an irq. Given bindings should be complete that should
be here even if the driver doesn't use it.

> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg

vdd-supply presumably needed for device to function so should be here.
=46rom dt-binding point of view we don't care about the kernel providing
stub regulators etc.  The supply documentation should reflect what must
actually be supplied.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      flow-sensor@8 {
> +        compatible =3D "sensirion,slf3s";
> +        reg =3D <0x08>;
> +        vdd-supply =3D <&reg_3v3>;
> +      };
> +    };

