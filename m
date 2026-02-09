Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039227CCF2;
	Mon,  9 Feb 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648308; cv=none; b=RSGC+0Wh+msJVBlr+JhdmIQC2b4jdJA2BIUPGojh0Qju12TpTUm9QGB4lTG0ql3SHzy98jP875JAfGv4xFIMb50q+ksbSu7Zm7pC3yxEBMOfACVWG5ZUQ2g+lEqvbQcA8vu989HqqEbOkhElK5U3uwP1Ma/FdBu4VzOidQFk55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648308; c=relaxed/simple;
	bh=YdYoyk5Ci8Y1p9o6ixSRLudnboGADccmpN2dxZQGJ2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbtTIA2YF7d9G13inCiCtrC3ubDklFT41+QCvQGrN+4UvpiWSgS0hJp7Xbj87wRiafQD36Mc8N1stJEI8BGP1Q+m+2vNQwW7xhJnQ9jGgpL3+LZbF41cWnHQ3VmnQyugD6L8NTqqyakDqUAy2pOmDpjfwbGs3PFZaUVkwLQzlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cox5UCSV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cox5UCSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1048C19422;
	Mon,  9 Feb 2026 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770648307;
	bh=YdYoyk5Ci8Y1p9o6ixSRLudnboGADccmpN2dxZQGJ2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cox5UCSVck3KssGy/xSU1b6aHDxgoePQd5LeEOhe5V2pz/jI5LVTLirEhio8qihnk
	 5cxmeFesCTDDM/ijcO00VWPI8BlGcRyt3qRuEVHxLL8WqUbO/oqAAEuKYnZ4njRbXh
	 mCjUYFA+GYP6AkZ9BsmSRhd/VDOc7tOpLS2MMx7QejhpR80BE+oMx2F2ZjNHvPZYRO
	 rU1RSqKtzsyRJAmCWtXwyZ5ZpHKZMo8ieAVlHjynmKbvcFPZ3oq2eYomg95R+jqgPl
	 L/17Qk3jpkiXGTXyko7rccta4Mu4JRAoI0rDr/bU5Q8CRIrYHLNEMDriTTMk7TtnYk
	 4gsBTqHmkq3qg==
Message-ID: <5614db64-3ee4-4a41-bd8b-5b89cc3264aa@kernel.org>
Date: Mon, 9 Feb 2026 15:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: Add binding document for cm36686
To: Erikas Bitovtas <xerikasxx@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
 <20260209-cm36686-v2-1-a48126d2b124@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260209-cm36686-v2-1-a48126d2b124@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2026 15:23, Erikas Bitovtas wrote:
> Document the Capella cm36686 ambient light and proximity sensor devicetree
> bindings.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "bindings document". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

You are just missing one redundant name for the redundant-subject-bingo.

dt-bindings: iio: Add Capella CM....

> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  .../bindings/iio/light/capella,cm36686.yaml        | 97 ++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml
> new file mode 100644
> index 000000000000..0e54b681e197
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml

cm36672p instead, since that's the fallback... although


> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/capella,cm36686.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Capella cm36686 I2C Ambient Light and Proximity sensor

Compatible says cm36672p... Confusing.

> +
> +maintainers:
> +  - Erikas Bitovtas <xerikasxx@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: capella,cm36672p
> +      - items:
> +          - const: capella,cm36686
> +          - const: capella,cm36672p

Why higher number is the fallback? Explain this in the commit msg.

> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device. Must be 0x60 for both cm36686
> +      and cm36672p sensors.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Regulator that provides power to the sensor.
> +
> +  vddio-supply:
> +    description:
> +      Regulator used to power IO and I2C bus.
> +
> +  vled-supply:
> +    description:
> +      Regulator used to power proximity LED
> +
> +  proximity-near-level: true

Drop

> +
> +  capella,proximity-led-current-microamp:
> +    description:
> +      Current for proximity IR LED
> +    enum: [50000, 75000, 100000, 120000, 140000, 160000, 180000, 200000]
> +    default: 50000
> +
> +  capella,glass-factor:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Lux amplification factor to account for packaging - a number by which a
> +      lux reading is multiplied.
> +    default: 1
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - capella,cm36672p
> +    then:
> +      properties:
> +        capella,glass-factor: false
> +

Missing ref to common.yaml.

> +additionalProperties: false

And this goes after required as unevaluatedProperties.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vddio-supply
> +  - vled-supply
> +


Best regards,
Krzysztof
