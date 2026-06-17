Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C263D47A8;
	Wed, 17 Jun 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712359; cv=none; b=KYO58U7ZCCvIiUv8IT/zjOoD3EaTy4ezEvfzQq/eFPM4B0F2gEez0XJrEFOxMfQqtIUVhRiyQtKDrGeS3YyT6hjdSCFFm5HFOEfjUE3Z2gHYtA2lBnf/tG17jbwLmt55HE+8KpBoJtTZIZdWoXpfittO6rlmruyjPhAyPPAbILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712359; c=relaxed/simple;
	bh=BPAjDDex4tjdRIGT9/paeMxEwlx0JO2iK9bEzbFk6D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVBXa2fIcUfIfn0pe22xEfkjakGeEtXy8udAoD81NhRW+5I2XtQhaAJWoNPjABGLHkXVA5XBDWl5zl6gIavAj4Fj/e16ovPzBnFechvOhux5XEnH1omyDr/tpMu6poKNtLMyCmfv+fx1wjCic56M8iN3Zgm9UqOSnbY1g38WSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGCXUk8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGCXUk8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA4F1F00A3F;
	Wed, 17 Jun 2026 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712347;
	bh=ja3WzpMJouNk4MtJCPPp/AEeCMz7nlYpwbRDd6xEyvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGCXUk8WflRE1E4vG/c/TGEHoxh89baeVhLwhFb1HebaaNh+j5xZa/EIW++7XOj3L
	 /N33+MgwxkJauXUYVZcx6K/yDq6ODJqxpRhYjZJYHJzrkgQGs2eRz5TPmEAVz23sqQ
	 0IfHSYynNoD6u5OMzGGHg8KlZnBVqIGOWikTGBTNQkA5sxK44w3GCO0H5KnkmuOCdz
	 GB4FcnBS4cs7dFicBLkNBXtNtHFb0WYeROdZUODci6Fie4wfmDrha1JomiXbqLtGVv
	 SzW9WO1OKHYKWI/TMdyihZuiGXsNr1kzwdOmqG3Viw1oj4icGF/iMuEJCsOMaS8319
	 ZrVSpD007BaSw==
Date: Wed, 17 Jun 2026 17:05:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pop.ioan-daniel@analog.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: adc: Add ltc2378
Message-ID: <20260617-bok-gains-9a1af41cf0de@spud>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cozC65bBU2iQaoDJ"
Content-Disposition: inline
In-Reply-To: <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>


--cozC65bBU2iQaoDJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:03:11PM -0300, Marcelo Schmitt wrote:
> Document how to describe LTC2378-20 and similar ADCs in device tree.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3:
> - Re-added device tree fallback compatibles for LTC2378 chips, now with o=
ptions
>   to provide a single compatible string or a pair of single compatible st=
ring
>   plus a fallback string to a slower sample rate spec in case a driver fo=
r the
>   specific part is not found.
>=20
>  .../bindings/iio/adc/adi,ltc2378.yaml         | 160 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> new file mode 100644
> index 000000000000..7d30a2cade8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ltc2378.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2378 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices LTC2378 series of ADCs.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
233818fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236416fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236418f.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236716fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236718f.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236816f.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236818f.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236918fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237016fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237616fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237618fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237620fb.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237716fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237718fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237720fb.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237816fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237818fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237820fb.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237918fb.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
238016fb.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # Single compatible string match.
> +      - enum:
> +          - adi,ltc2338-18
> +          - adi,ltc2364-16
> +          - adi,ltc2364-18
> +          - adi,ltc2367-16
> +          - adi,ltc2367-18
> +          - adi,ltc2368-16
> +          - adi,ltc2368-18
> +          - adi,ltc2369-18
> +          - adi,ltc2370-16
> +          - adi,ltc2376-16
> +          - adi,ltc2376-18
> +          - adi,ltc2376-20
> +          - adi,ltc2377-16
> +          - adi,ltc2377-18
> +          - adi,ltc2377-20
> +          - adi,ltc2378-16
> +          - adi,ltc2378-18
> +          - adi,ltc2378-20
> +          - adi,ltc2379-18
> +          - adi,ltc2380-16
> +
> +      # Low sample rate fallback for 16-bit unipolar sensors.
> +      - items:
> +          - enum:
> +              - adi,ltc2370-16 # 2 MSPS
> +              - adi,ltc2368-16 # 1 MSPS
> +              - adi,ltc2367-16 # 500 kSPS
> +          - const: adi,ltc2364-16 # fallback (250 kSPS)

Your driver still matches on ltc2370-16, which makes me question the
value of these fallbacks. That said, the chip info struct contains no
information about sampling rate. What actually is the impact of the
sample rate on the programming model?
Is there actually a benefit to matching on ltc2370-16, or can you just
match on the fallback?
+static const struct ltc2378_chip_info ltc2370_16_chip_info =3D {
+	.name =3D "ltc2370-16",
+	.resolution =3D 16,
+	.bipolar =3D false,
+};

+static const struct ltc2378_chip_info ltc2368_16_chip_info =3D {
+	.name =3D "ltc2368-16",
+	.resolution =3D 16,
+	.bipolar =3D false,
+};

+static const struct ltc2378_chip_info ltc2367_16_chip_info =3D {
+	.name =3D "ltc2367-16",
+	.resolution =3D 16,
+	.bipolar =3D false,
+};

+static const struct ltc2378_chip_info ltc2364_16_chip_info =3D {
+	.name =3D "ltc2364-16",
+	.resolution =3D 16,
+	.bipolar =3D false,
+};

All the devices have the same match data, other than the name, as the
fallback.

> +
> +      # Low sample rate fallback for 18-bit unipolar sensors.
> +      - items:
> +          - enum:
> +              - adi,ltc2369-18 # 1.6 MSPS
> +              - adi,ltc2368-18 # 1 MSPS
> +              - adi,ltc2367-18 # 500 kSPS
> +          - const: adi,ltc2364-18 # fallback (250 kSPS)
> +
> +      # Low sample rate fallback for 16-bit bipolar sensors.
> +      - items:
> +          - enum:
> +              - adi,ltc2380-16 # 2 MSPS
> +              - adi,ltc2378-16 # 1 MSPS
> +              - adi,ltc2377-16 # 500 kSPS
> +          - const: adi,ltc2376-16 # fallback (250 kSPS)
> +
> +      # Low sample rate fallback for 18-bit bipolar sensors.
> +      - items:
> +          - enum:
> +              - adi,ltc2379-18 # 1.6 MSPS
> +              - adi,ltc2338-18 # 1 MSPS
> +              - adi,ltc2378-18 # 1 MSPS
> +              - adi,ltc2377-18 # 500 kSPS
> +          - const: adi,ltc2376-18 # fallback (250 kSPS)
> +
> +      # Low sample rate fallback for 20-bit bipolar sensors.
> +      - items:
> +          - enum:
> +              - adi,ltc2378-20 # 1 MSPS
> +              - adi,ltc2377-20 # 500 kSPS
> +          - const: adi,ltc2376-20 # fallback (250 kSPS)

I didn't check these, but I assume they are the same.

--cozC65bBU2iQaoDJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajLF1gAKCRB4tDGHoIJi
0szDAP9gj0vofKdfA/Kp0z6I4Ap/DJ5Wrp6jTjMR95csENDCRQEAsdJc4trP1URx
dleJPNku9BuaepRcK/79m9dBeVscggs=
=oNjY
-----END PGP SIGNATURE-----

--cozC65bBU2iQaoDJ--
