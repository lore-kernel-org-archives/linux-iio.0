Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028137417B;
	Fri,  8 May 2026 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244535; cv=none; b=V5lBcLh1UcHOh2i5On3FLM8z8DJbYrGOIIwRQUHN+aRYvOuO7iXxHbKpYwuxKWJ1OctoHa9GU8Q5ojI4UyA9pr5/mS2YWRM03gzrPMbpTWno53Kv9N3ftjMIjnVbh6yO9KuS8AcZHfVk6dF953gOInB8CfbmDQEzusaBJ5oIyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244535; c=relaxed/simple;
	bh=8Y96R3p8sUNREaenReFTo2/oKclTZ1VW7vYZvOu63XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srg8R9it4+O49lqS+pWTsMUVgjtkZnfPxduOy+WfOMiRLtA46ztyEFLDWM7hW/RnwZiVsCTK7sU1v7Zt6fzKlnq4rBzqO7JFQICdHNVITpGRKzyPzL6LzI2YPPQmHkzaxTd4Z79PSEKWz7frHovGcaVzqqDWqB7CDPzmXbT/jN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1M7DEnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1M7DEnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78F8C2BCB0;
	Fri,  8 May 2026 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778244535;
	bh=8Y96R3p8sUNREaenReFTo2/oKclTZ1VW7vYZvOu63XE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c1M7DEnRcdd+92ZqSAiqlSHHPEKAQWghayvTa7+5HtKFUC64Cv8X/o5bUFo9/dTrF
	 Uj7MLRYD9YsdWpz+F8Ry9cf6vC4WN1PlFGVc03wBsXh/MQLQ22IVpJg7MFLDNUxDHG
	 nbSq6UNrBU8e35zXvT//FCRfXOaWH6J/3VxXVavuXzhMTegqjor+CrErWT82CIcWqc
	 dJm13h0Slv3ZPyJHyjlHZAQsAd6Hhs19ypPBavr6gTtWgBCxzM/x+xEdTZZ60pNI6x
	 MfDB/9Xe9W99bdY89Aso5Up+trOiuIwQBZtiKwbVvYZVq1G/FNSGXTtYaOgIDPvrx/
	 IvdPMvLsaPgwA==
Date: Fri, 8 May 2026 13:48:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, "Jonathan Corbet" <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>,
 rodrigo.alencar@analog.com
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260508134843.7646c4f5@jic23-huawei>
In-Reply-To: <20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
	<20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 13:55:47 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> buffered voltage output digital-to-analog converter (DAC) with an
> integrated precision reference.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 96 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 103 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> new file mode 100644
> index 000000000000..f531b4865b01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5529r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5529R 16-Channel 12/16-bit High Voltage DAC

How is one device bother 12 and 16-bit? That sometimes happens for
ADCs where it is really reflecting oversampling or for device with hardware
FIFOs where storage space is saved by using lower bit rate. I'm not sure ei=
ther
applies here.

> +
> +maintainers:
> +  - Janani Sunil <janani.sunil@analog.com>
> +
> +description: |
> +  The AD5529R is a 16-channel, 12-bit or 16-bit, high voltage, buffered =
voltage output
> +  digital-to-analog converter (DAC) with an integrated precision referen=
ce.
> +  The device operates from unipolar and bipolar supplies. It is guarante=
ed
> +  monotonic and has built-in rail-to-rail output buffers that can source=
 or
> +  sink up to 25mA.
> +
> +  Specifications:
> +  * 16 independent 12-bit or 16-bit DAC channels
> +  * Independently programmable output ranges: 0V to 5V, 0V to 10V, 0V to=
 20V,
> +    0V to 40V, =C2=B15V, =C2=B110V, =C2=B115V, and =C2=B120V
> +  * The device supports SPI communication with Mode 0 and Mode 3.
> +  * 4.096V precision reference, 12ppm/=C2=B0C maximum
> +  * Built-in function generation: Toggle, Sinusoidal Dither, and Ramp wa=
veforms

Interesting - so this is a DDS, be it a simple one. +CC Rodrigo who has been
wrestling with one of those recently.  Rodrigo, can you take a look at this
driver and see if it fits in the ABI etc you've been hammering out? Thanks!


> +  * Multiplexer for output voltage, load current sense and die temperatu=
re
> +
> +  Datasheet: https://www.analog.com/media/en/technical-documentation/dat=
a-sheets/ad5529r.pdf
> +
> +properties:
> +  compatible:
> +    const: adi,ad5529r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the RESET pin. Active low. When asserted low,
> +      performs a power-on reset and initializes the device to its defaul=
t state.
> +
> +  vdd-supply:
> +    description: Digital power supply (typically 3.3V)
> +
> +  avdd-supply:
> +    description: Analog power supply (typically 5V)
> +
> +  hvdd-supply:
> +    description: High voltage positive supply (up to 40V for output rang=
e)
> +
> +  hvss-supply:
> +    description: High voltage negative supply (ground or negative voltag=
e)

I don't mind doing it this way but in some similar cases where 0 is somethi=
ng that
can be considered the 'default' we've made the supply optional.  What was
your reasoning for requiring it in this case?

dt-bindings should be as complete as we can make them - with that in mind...

There are some more interesting corners on this device the binding doesn't
currently cover such as mux_out pin.  We'd normally do that by making the
driver potentially a client of an ADC

Easier though is !alarm which smells like an interrupt.
!clear probably a gpio. TG0-3 also GPIOs.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - avdd-supply
> +  - hvdd-supply
> +  - hvss-supply

