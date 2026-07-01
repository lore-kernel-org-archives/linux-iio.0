Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614025B08A;
	Wed,  1 Jul 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931269; cv=none; b=KH8vF8kElN11pBvRv5E3nNyGlfS9aQw2ANW3FpZ5ygwyUS4PVwJAgIA3EPT1w/CQew9Zs0Kj6zF2QB2zRw/mhtHxmkKo46ciH7BFxDGOIKFx7q9MfSxmtiIvtu3j55GUFV4N3l/D543Oq3k+Bs4pnOjS3OnNtnWeRD6vntzNzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931269; c=relaxed/simple;
	bh=qXJldM6BUh03weti5x2Wx+CwtFDpxI/BSec/nZO2YAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MO1vlPDJb9/6waYb84mvlSJRTt70zFyIoAE0b6IhBup49ewOQcEGeFncHsbhJTsgRAxdlhgeUItESqmd/DXSo6Z/qv0UXQDgrJj/qfcpbzqlOlj9B2T+W6cvpGS5Q4QtvMNBw/Sipt8D7DhqNyWwJ6AJ64jN0eVRJSabUy3d7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik2U7ntW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik2U7ntW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CCB1F000E9;
	Wed,  1 Jul 2026 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782931268;
	bh=RtBAYlNvKsaOrj0DVhmIZREtE8lCqKZwKuktgqgnPs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ik2U7ntWPPmeip+BSU5qfzGjqrawJ4SmYad/YxAhMlYySU5qVmeurjBl5nwiSeWCu
	 O4uHwgjLviRKnDibIc9TdSQds1U7FUtlb96/rrgEE4dan5Q9azt5nQ5GGPJxTt7d0E
	 ppJzHpUslCAIeCjiBN76Qo75mZYSUQH3CowNg4qB1o8n4gaqaQQQ1RzMW7mBGWJ/mF
	 8o9xUSlNIPjgXktoKXRfzmmQJWMNm5luvrz5f7A1Bv8fM98RLhlbPGD6odO3NZEmJo
	 6/Z4ONTUHZtEAxpzrjM6PNNX41IQxW0fSw0n+ROulQ0iqlTlkrTDr/LWNON17i0x7s
	 YlP3r+MjbJXRQ==
Date: Wed, 1 Jul 2026 19:41:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, "Jonathan Corbet" <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Janani Sunil
 <jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260701194103.45541cbe@jic23-huawei>
In-Reply-To: <20260701-ad5529r-driver-v5-2-ed087900e642@analog.com>
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
	<20260701-ad5529r-driver-v5-2-ed087900e642@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 08:40:40 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> buffered voltage output digital-to-analog converter (DAC) with an
> integrated precision reference.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Putting aside our device address discussions as being handled elsewhere
one minor thing inline

> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> new file mode 100644
> index 000000000000..97075b1c919d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml

> +properties:
> +patternProperties:
> +  "^channel@([0-9a-f]{1,2})$":
> +    type: object
> +    description: Child nodes for individual channel configuration
> +
> +    properties:

> +      adi,output-range-microvolt:
> +        description: |
> +          Output voltage range for this channel as [min, max] in microvolts.
> +          If not specified, defaults to 0V to 5V range.

No way to specify the default as part of the binding rather than a comment?
I haven't checked but does
       default: [0 5000000]
not work?
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - enum: [5000000, 10000000, 20000000, 40000000]
> +          - items:
> +              - const: -5000000
> +              - const: 5000000
> +          - items:
> +              - const: -10000000
> +              - const: 10000000
> +          - items:
> +              - const: -15000000
> +              - const: 15000000
> +          - items:
> +              - const: -20000000
> +              - const: 20000000
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false



