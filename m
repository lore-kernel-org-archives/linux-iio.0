Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795023434;
	b=3P+6SvQdRsVY5U4aQCkMu6TogOvXoGRDsUOaJoUaFsuECkyHF7P1BaS9TTChFBgixh0q
	 ZAruV7fQW12ivG3qhyG16o1v5ScY5CXAudNSoU1ZMnW1sIUxDIfMoA73wbkTZDZem2El6
	 rOLT/YuEpNQXS/BV7EqAJlKJ9g9PbalfPFhyXikd5IhDuOzEnsBohY0svHbhRzPI6pfSS
	 40GZQqKa0sJKjA7ZgX+JKErohCkanRUH1DPDsOBGKha6STLHAFpzFlaaZKvVnD/u8v3XD
	 ldMYq5hBxwdcAERu38cANdmsAN5HUgqCoHGR8/59zzlVclmbT62AYCD9MI4QqA9VW1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gvDDaubiK4xTOcbQm0youXVmrD0ANoAaeBKAg/I3LXM=;
	b=qUTa6lkNWcNxVYN1IjHhrin82Pj7tqxMe873HS8AwgMEoWspiey5rs1EQlLF0bhh8Ma0
	 wN7sCzvxXrU5efM/7oEGSCDN2fLhsAGhNl3VWpnbfm4d2SAUhDU6rZvzIby/Icz7MTZLw
	 RTt95sb4psdMJ6mUtOZMRwzpYaavTcsYDiNeL+vXUP7235oNw5mIp6MqLrqpI+0Fl9tnj
	 k1RbPwv3qY3ym9jitJTdKS9QQPBv+WYldlkMLt1kDahG0RWS4YCPBmMfx2v/wZUtamn7q
	 JyPfv2E9qM5QY/lmerRqdLgE1i025tUvnUEPJMzA7/WgXZbup3TTV5Shsgjv4F+/7Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPCkEvYr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1886606CA43;
	Wed, 18 Nov 2026 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPCkEvYr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D341F000C5;
	Wed, 18 Nov 2026 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795023434;
	bh=gvDDaubiK4xTOcbQm0youXVmrD0ANoAaeBKAg/I3LXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YPCkEvYrYZi+pDD6DfGqiZBK+vUi7ax0Nk0QazWmmDmSwugCXj306PcXuUVnlfO+e
	 Av91dDmnAUWr8Udmh0JLrOIrCoduW7pWUEjfYCyWQ6ZE+mFLqWvD4hEWoo1hP/pPIv
	 6hbt6PIxbByk2aRIGfNE7xXApddOiiuPiISHT3Vhi61B/rrsY0Ebjf6jmMNvkM3Qus
	 GDo1Leg5038dwvxDTXDkosJLazYCNWK59U983H+gY5ricm5jaOyEZFhoMGi6grV/8S
	 +Z7pqPjEje0xnImd25EGlmIohGpbGP/cTrb8X+ROtkVsAmQRtRaNiqmA0aE3oF7BLh
	 XfGVrS03miEhQ==
Date: Wed, 18 Nov 2026 17:37:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: Support ROHM BD79111
Message-ID: <20261118-ancient-ominous-4f2a4a37369b@spud>
References: <cover.1795009599.git.mazziesaccount@gmail.com>
 <f69b996cc07fad1712871fb8b0436c71abd435b9.1795009599.git.mazziesaccount@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IjquCaiCLr6jpdok"
Content-Disposition: inline
In-Reply-To: <f69b996cc07fad1712871fb8b0436c71abd435b9.1795009599.git.mazziesaccount@gmail.com>

--IjquCaiCLr6jpdok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 04:19:11PM +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
> where pins can be configured to be either used as GPIO or ADC inputs.
> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
> sources.
>=20
> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
> clock.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
>=20
> Note, I had to change the 'root-level' additionalProperties: false to
> unevaluatedProperties: false in order to allow the properties in the new
> allOf:
>   - if:
>      ...
>=20
> section. It seems to me this is what a few other bindings in IIO do, but
> I suppose it makes this "less strict". Well, since I am terrible with
> writing bindings, I'd better point this out and ask if it's ok, or if
> there are better way(s) to handle this?

I don't think you should have to do that though, since the children are
described in the same file.
If you instead retained the pattern properties section, and lowered the
restriction to channel@<any number> with reg with the max of 31 and in
the conditional section constrained reg to a max of 16 does it work
without the unevaluatedProperties change? We typically want properties
defined at the top level and constrained in conditional sections anyway.

Chees,
Conor.

> ---
>  .../bindings/iio/adc/rohm,bd79112.yaml        | 72 +++++++++++++------
>  1 file changed, 50 insertions(+), 22 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml =
b/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
> index aa8b07c3fac1..4f105124ee6f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
> @@ -4,18 +4,21 @@
>  $id: http://devicetree.org/schemas/iio/adc/rohm,bd79112.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: ROHM BD79112 ADC/GPO
> +title: ROHM BD79111 and BD79112 ADC/GPIO
> =20
>  maintainers:
>    - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
> -  The ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. ADC input pins can =
be
> -  also configured as general purpose inputs/outputs. SPI should use MODE=
 3.
> +  The ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. The ROHM BD79111 is
> +  a 12-bit, 16-channel, SAR ADC. ADC input pins can be also configured as
> +  general purpose inputs/outputs. SPI should use MODE 3.
> =20
>  properties:
>    compatible:
> -    const: rohm,bd79112
> +    enum:
> +      - rohm,bd79111
> +      - rohm,bd79112
> =20
>    reg:
>      maxItems: 1
> @@ -37,23 +40,6 @@ properties:
>    "#size-cells":
>      const: 0
> =20
> -patternProperties:
> -  "^channel@([0-9]|[12][0-9]|3[01])$":
> -    type: object
> -    $ref: /schemas/iio/adc/adc.yaml#
> -    description: Represents ADC channel. Omitted channels' inputs are GP=
IOs.
> -
> -    properties:
> -      reg:
> -        description: AIN pin number
> -        minimum: 0
> -        maximum: 31
> -
> -    required:
> -      - reg
> -
> -    additionalProperties: false
> -
>  required:
>    - compatible
>    - reg
> @@ -62,7 +48,49 @@ required:
>    - spi-cpha
>    - spi-cpol
> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rohm,bd79112
> +    then:
> +      patternProperties:
> +        "^channel@([0-9]|[12][0-9]|3[01])$":
> +          type: object
> +          $ref: /schemas/iio/adc/adc.yaml#
> +          description: Represents ADC channel. Omitted channels' inputs =
are GPIOs.
> +
> +          properties:
> +            reg:
> +              description: AIN pin number
> +              minimum: 0
> +              maximum: 31
> +
> +          required:
> +            - reg
> +
> +          additionalProperties: false
> +    else:
> +      # BD79111 has only 16 channels
> +      patternProperties:
> +        "^channel@([0-9]|1[0-5])$":
> +          type: object
> +          $ref: /schemas/iio/adc/adc.yaml#
> +          description: Represents ADC channel. Omitted channels' inputs =
are GPIOs.
> +
> +          properties:
> +            reg:
> +              description: AIN pin number
> +              minimum: 0
> +              maximum: 15
> +
> +          required:
> +            - reg
> +
> +          additionalProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.56.1
>=20



--IjquCaiCLr6jpdok
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3iRAAKCRB4tDGHoIJi
0hj9AQCEZ5DA/0TOVe/Xv7/ev89OfSbx9vS5R3o/+rE/Vt/XegD/f6ThrkSEfTut
aC/xeEqi8kwKw0VLYAsywOHlxiqS7wQ=
=JZv0
-----END PGP SIGNATURE-----

--IjquCaiCLr6jpdok--
