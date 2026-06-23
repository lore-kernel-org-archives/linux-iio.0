Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029D39021B;
	Tue, 23 Jun 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237213; cv=none; b=TKqm987+Oc+Vi/Oui7Bk3TCYV3wsDzF5lLXBGWn2JammTQgFq+JL18lWNbM6Gzy8XWvH2i81deOwiIyJMde32BtAdp4FqlXx9DTJiUHJT4TW4p2v+l7VEl3utSqyC+S2SEWJPErOKjcpvxz43+J7vulHdOLC86sHFna9iP5H0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237213; c=relaxed/simple;
	bh=kzhw36plL3JnIWfdsW6PN0wkAfiXF2Yt9LvhFcMMxSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH2Hfrk1X9SoqkFo8Aten2u8L+Tjy7j34HoF3/N9EugqAn79Z/AJNfu9/lhWHdZxLCN3vMxmFMUbEVaKDJIh0/0sceSi69UZTY3C6QDCXfNRSgxLF2KG0Fy3IOjA36tNzNQ72/vyiQ3sAf+9EXyMp91XzXO5S6IS/aIoqNzuVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FS4V2tSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FS4V2tSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6AE1F000E9;
	Tue, 23 Jun 2026 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782237211;
	bh=Wrvsr8h6jFY/dCbYmkZoUJiifGBIXFSZCRBBOQo2ZYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FS4V2tSDcr7FobIOYLEKkpzp+pKoQ/m5EHHO367tG2ej0gd/na+UxtIIfcZ6IWMsc
	 OnbJk6oF+mdIXqreEj9IDz24c/PXYOTKm06FjGzdY8cqJWJno4D8nML/W6dgV3mQ7N
	 c9yfLMt5OgzWrB+7kVst754tTn/XxgR2kvteoyJtcJOc1CmIt8DHSK0R45/YWtK1Dn
	 NWLInHE3rJMKI/DSrVZ5VG2pr0Potkzj70QFQus/wmabjlyscnykV9GTxmtLfyZ/J8
	 /8DlYelWh+/Msnsc395zIM5K6a2IorhcHQcb2tGf41vyaUp9uYhkjtDbppghffgH04
	 uzb3dQrbi8g6A==
Date: Tue, 23 Jun 2026 18:53:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: health: add maxim,max86150
Message-ID: <20260623-frostlike-harbor-3d062b05e3d6@spud>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
 <20260623164309.16452-1-shofiqtest@gmail.com>
 <20260623164309.16452-2-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qLfn14DPQpsnaGuS"
Content-Disposition: inline
In-Reply-To: <20260623164309.16452-2-shofiqtest@gmail.com>


--qLfn14DPQpsnaGuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 07:43:07PM +0300, Md Shofiqul Islam wrote:
> Add YAML binding schema for the Maxim MAX86150 combined ECG and PPG
> biosensor.  The device exposes two PPG optical channels (Red and IR LED)
> for heart rate and SpO2 measurement, and one ECG biopotential channel, all
> accessible over I2C at up to 400 kHz.
>=20
> An optional active-low interrupt line connects to the 32-entry hardware
> FIFO almost-full output.  Two optional regulator supplies (vdd for the
> digital core and leds for the LED anodes) cover boards that require
> explicit power sequencing.
>=20
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../bindings/iio/health/maxim,max86150.yaml   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/maxim,ma=
x86150.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max86150.=
yaml b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
> new file mode 100644
> index 000000000000..1bf10fd1a3d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/health/maxim,max86150.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX86150 ECG and PPG Biosensor
> +
> +maintainers:
> +  - Md Shofiqul Islam <shofiqtest@gmail.com>
> +
> +description: |
> +  The MAX86150 is an integrated biosensor SoC that combines:
> +    - Two PPG (photoplethysmography) channels: Red LED and IR LED,
> +      for heart rate and blood-oxygen saturation (SpO2) measurement.
> +    - One ECG (electrocardiogram) channel for biopotential recording.
> +
> +  The device communicates over I2C at up to 400 kHz and raises an
> +  active-low interrupt when the 32-entry hardware FIFO reaches its
> +  configurable almost-full threshold.
> +
> +  Datasheet:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
MAX86150.pdf
> +
> +properties:
> +  compatible:
> +    const: maxim,max86150

ADI would like the prefix for newly added former maxim products to be
"adi,".

> +
> +  reg:
> +    maxItems: 1
> +    description: I2C device address, always 0x5E.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      Active-low interrupt line.  Asserted when the FIFO almost-full
> +      threshold is reached or when a new PPG sample is ready.
> +
> +  vdd-supply:
> +    description: Digital core supply, 1.71 V to 1.89 V.

This is a 1.8v supply, the tolerances on it don't need to be mentioned
here.

> +  leds-supply:
> +    description: LED anode supply, 3.0 V to 5.5 V.

Datasheet cites 5v as the max for this, not 5.5v, with a typical value of
3.3v. Makes me think that 3.3 is the intended value, since using a 5v
supply could easily fluctuate over the maximum rated value.

Looks like there's more supplies than this?
I see:
Vdd_ana
Vdd_dig
Vref
Vled

Additionally, these supplies should be mandatory.

pw-bot: changes-requested

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        biosensor@5e {

Seems to be prior art for calling things like this "heart-rate",
although that is somewhat limited compared to what this device can do.

Cheers,
Conor.

> +            compatible =3D "maxim,max86150";
> +            reg =3D <0x5e>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
> +            vdd-supply =3D <&vdd_1v8>;
> +            leds-supply =3D <&vdd_3v3>;
> +        };
> +    };
> --=20
> 2.51.1
>=20

--qLfn14DPQpsnaGuS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajrIFwAKCRB4tDGHoIJi
0pmqAQCZaTi9m9/1KpwAabZGLt0foLAUGeT+MqvOs7ivVcv4FwEA4gP5gnky75TF
78QxSE1/xNzJ1owaNByp8UeEBTJtgAc=
=NtZb
-----END PGP SIGNATURE-----

--qLfn14DPQpsnaGuS--
