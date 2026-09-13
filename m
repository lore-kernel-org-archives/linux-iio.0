Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA33B1B3;
	Sun, 13 Sep 2026 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789261021; cv=none; b=ZkaaVDMSoepFBMf6kbp7+9xBcMGf+IuvWq4Q4j4g+yfC38Mg/YtamSWBffbnXpmNJzHAkR6LXA81vUKDbzhp5uC/3HId7Op1NLKqHUEOniuR3bubGPjmr9n/qfnrOeb9+IuZKCv+1gq3cIHqsZ2oVoefJR56eb5iDceHWN2LRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789261021; c=relaxed/simple;
	bh=hKwOTj1ftfgpeG99y3bk2eoTqdJ6dQv66W+pJmnKU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xdl5DogtHMkblCk3vG0IiwCoYVRhP9arxvqXRSUB7d+zN1MXnEpHEo0kqmerxIZPkfU9gq1mvJBT+mmiaRi9GSGM9bnGNNTwQjk/S+QgGQTYcD7+67XnQ439XlEyzpLyrlGFLm/CaIjw5A0YgS6C+g3TK8E7v1pzmtqWqYazW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcdIYERo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcdIYERo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E30E1F000FF;
	Sun, 13 Sep 2026 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789261019;
	bh=Yqgic5kK2sGljTKExin6A4tnKoMgqWVM6bWIrjbnwF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LcdIYERojCfZ+2kenl/iyqfDkp+gSQGC1cWa0ENQMfmGbiwDri1FAGzClkzcJyLge
	 RpLVZwVDg1vj+zcLgfNnicP35XEhtJFp1cdLkKlEp08dQR6BNfBKEg68JItc+duf+E
	 1xhv+SBrtH7f97jtC7K7u/NFxZ0oBO2qrMdQVSCMpp/iMJ57M3HXziZrES0PQB5utM
	 Lf3lpdbwWD14sSNqW6jFMkn6pryU/kdsIdgKEkUPFKayjgcpnUSNPlilsUTYbSZx1z
	 de2ps//44GuiGmXF3Vjyf+qhmxv/TQk203pJu0gsk1sfYevGmQupSvxhNqtQ6u1q6b
	 K1+CZL576z8QA==
Date: Sun, 13 Sep 2026 01:56:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, "Jose A.
 Perez de Azpillaga" <azpijr@gmail.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20260913015652.029475d2@jic23-hlaptop>
In-Reply-To: <20260912013912.51887-2-marcus.yu.56@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
	<20260912013912.51887-2-marcus.yu.56@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 18:39:11 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> with i2c address of 0x39.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>

Some stuff on v2 still needs discussion.  A few comments inline.
Wait for that v2 discussion to finish or come to some conclusions
before sending a v5.

>  .../bindings/iio/light/ams,as7343.yaml        | 72 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> new file mode 100644
> index 000000000000..d963832fb413
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS7343 14-Channel Multi-Spectral Sensor
> +
> +maintainers:
> +  - Chang Yu <marcus.yu.56@gmail.com>
> +
> +description: |
> +  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address of 0x39.
> +  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ams,as7343
> +
> +  reg:
> +    description:
> +      I2C address of the device (0x39).

Might as well specify it as const given it can only take that value.
They you can drop the description as it won't add anything.

> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Open drain output active low interrupt pin.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  led-max-microamp:

Discussion on whether an led node is needed back in v2 is not resolved.

> +    description:
> +      The driver current for the external LED connected to the LDR pin.
> +    minimum: 4000
> +    maximum: 258000
> +    multipleOf: 2000
> +    default: 12000
> +
> +  sync-gpios:
> +    description: |
> +      Optional GPIO pin that can be used either as a synchronization input to
> +      start/stop measurement or as an external start/stop signal for
> +      synchronizing with the connected LED.

So the datasheet starts referring to using this for some level of sync
but then only actually treats it as as a gpio (maybe I'm missing something).
Any idea what that stuff about start/stop is talking about?

The only thing I can find about this is the device diagram in figure 13 that has the GPIO
wired to the led driver and the automatic measurement engine.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false


