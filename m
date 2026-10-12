Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE13C3437;
	Mon, 12 Oct 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831596; cv=none; b=D8wPLizQXQnxgDCIk6oZlibTgvdqnQqJu5Oi7vrMfWvq07O+d2Bmmx5frvoEuBpwebIKC7g5MKMkWj+o+iHuCZ3kIJd33jt+Pm8UZvfjWr8l7wLQx1aWZbsyWoYdo7ITUvBKb+1nmOQMGMMiea6pnxCDlOfvEi3melXWjDeWU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831596; c=relaxed/simple;
	bh=N0AzcY+h16VvQpwwOgEORC3Dp+bRJ7rP2iWE9TsLdhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjmLlQgPfJCQbUj6YdM4EhcZlR8EgaJQtW6S3ppCdrv8HF/8kXHo/slSJ9Vqfh+avOu4oJImgtQRq0QGZgsUQNGo7kkvalUlZSYxaRZfdmyTHTrw9JAByMzpkrWu8rzD6Mj5Q5kxC7Dot9y3umtVj65aGPTTw/VPib71ADZH2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8o6+aWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8o6+aWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697261F008A1;
	Mon, 12 Oct 2026 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831594;
	bh=q5fULpa7daB6TmBmnSA1BqoQzUcnMbd3JSJ/cqN+aA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e8o6+aWkatNqHNXP1/EJ6Yd9RNAGqB1H+CnNLdrSJqIeGHrxVy6VuvzdnusvZpIod
	 E8GhmTVcfFiGFzFXqeBfLXNeUd/vYZChykFSKJo+n7XxdLxYQhntpWpUxyQ2Im/Sfg
	 dsJnEtINWyl4rHKGBBYKoY53WRtj4iToMDZlcO+eP0OFdTAibxsZBGzrdDAfagftFZ
	 durKsuti0zzc6H1A+n++qPMJTcIFKkucSdXV5x9ShxqfNS75SYTBLleMMJts+33YpJ
	 UrxXJwPh7IjBymoqlYDS/7f45adah2biSrEDL9oITpapVgh0cIivTsVkWCW9e5zlkL
	 PKXAlvcy4fLEA==
Date: Mon, 12 Oct 2026 19:59:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: adi,ade9000: add adi,ade9039
 compatible
Message-ID: <20261012-thinly-debrief-615f863ffa77@spud>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
 <20261012111342.48040-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5zlPZex+sMIpH8TI"
Content-Disposition: inline
In-Reply-To: <20261012111342.48040-3-antoniu.miclaus@analog.com>

--5zlPZex+sMIpH8TI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 02:13:38PM +0300, Antoniu Miclaus wrote:
> The ADE9039 is a polyphase energy metering device from the same family as
> the ADE9000. It is register compatible with the ADE9000 for everything the
> driver uses, provides the same on-chip dip/swell detection, and shares the
> full-scale codes of the ADE9078.
>=20
> It computes only fundamental reactive power and has no total reactive pow=
er
> register, which is noted in the description. Like the ADE9078 it supports=
 a

AFAICT, this first sentence here is what prevents using a fallback,
could you be more clear about that please?
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Thanks,
Conor.

> maximum serial clock frequency of 10 MHz rather than 20 MHz, so extend the
> existing spi-max-frequency constraint to cover it.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/adc/adi,ade9000.yaml         | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> index bcc166aad713..70106dd052ce 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -5,26 +5,28 @@
>  $id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Analog Devices ADE9000/ADE9078/ADE9430 High Performance, Polyphas=
e Energy Metering
> +title: Analog Devices ADE9000/ADE9078/ADE9430/ADE9039 High Performance, =
Polyphase Energy Metering
> =20
>  maintainers:
>    - Antoniu Miclaus <antoniu.miclaus@analog.com>
> =20
>  description: |
> -  The ADE9000, ADE9078 and ADE9430 are highly accurate, fully integrated,
> -  multiphase energy and power quality monitoring devices. Superior analog
> -  performance and a digital signal processing (DSP) core enable accurate=
 energy
> -  monitoring over a wide dynamic range. An integrated high end reference=
 ensures
> -  low drift over temperature with a combined drift of less than =B125 pp=
m/=B0C
> -  maximum for the entire channel including a programmable gain amplifier=
 (PGA)
> -  and an analog-to-digital converter (ADC). The ADE9078 and ADE9430 do n=
ot
> -  provide the on-chip dip/swell detection available on the ADE9000, and =
the
> -  ADE9430 has no on-chip digital integrator (it uses an external analog
> -  integrator for Rogowski coils).
> +  The ADE9000, ADE9078, ADE9430 and ADE9039 are highly accurate, fully
> +  integrated, multiphase energy and power quality monitoring devices. Su=
perior
> +  analog performance and a digital signal processing (DSP) core enable a=
ccurate
> +  energy monitoring over a wide dynamic range. An integrated high end re=
ference
> +  ensures low drift over temperature with a combined drift of less than
> +  =B125 ppm/=B0C maximum for the entire channel including a programmable=
 gain
> +  amplifier (PGA) and an analog-to-digital converter (ADC). The ADE9078 =
and
> +  ADE9430 do not provide the on-chip dip/swell detection available on the
> +  ADE9000 and the ADE9039, and the ADE9430 has no on-chip digital integr=
ator
> +  (it uses an external analog integrator for Rogowski coils). The ADE903=
9 only
> +  computes fundamental reactive power and has no total reactive power re=
gister.
> =20
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9000.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9078.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9430.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9039.pdf
> =20
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
> @@ -32,6 +34,7 @@ properties:
>    compatible:
>      enum:
>        - adi,ade9000
> +      - adi,ade9039
>        - adi,ade9078
>        - adi,ade9430
> =20
> @@ -79,7 +82,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: adi,ade9078
> +            enum:
> +              - adi,ade9039
> +              - adi,ade9078
>      then:
>        properties:
>          spi-max-frequency:
> --=20
> 2.43.0
>=20

--5zlPZex+sMIpH8TI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0uJAAKCRB4tDGHoIJi
0ix1AQCLvE7M8UkUH+NIXzYoXwsPJ+9FaDwV/TxNECsv/eJlZgD/c4Xf1FJ3SdTl
XQZ9e7c7XXRKMEajWTu67xiP0iA/HAo=
=waQP
-----END PGP SIGNATURE-----

--5zlPZex+sMIpH8TI--
