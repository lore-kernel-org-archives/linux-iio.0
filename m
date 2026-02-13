Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93A31282E;
	Fri, 13 Feb 2026 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970311; cv=none; b=A/1eZqkKxLK3jNJVfuBuwyA/b19VhR5u15QrfqOSQFZ/jeDtV0m9LYM7hZ+zCtvd18ViH2Sc8cfR+Wq0Y/2dri7YsB655AGTh6O2l+OGKHtQ7aIPAv7CyEdlD+KivD6Va07YmmWfTycrdJ2sCH/IbqJvAy974bKX2bYuWiMrmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970311; c=relaxed/simple;
	bh=T6X3ulDE7VDmHxw4vxRh9yuGxDXS803YkGNJmrBHt54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj1XB5kXwH1VcE3NnYSbeLNT6otRzDrmL5cSjN2VjQkJGNXibBackdgzsC7CtUEsExQazq+tns4AQI4x/GGgj1Vd3KNl6QRVBRBGaAOhXS+46KMcKyRa+TKhCmSMncNYgnf42BjqbhceijJMfRfyMtknywwHBKVAzhH0J8IURU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8hypevb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8hypevb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37262C116C6;
	Fri, 13 Feb 2026 08:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770970310;
	bh=T6X3ulDE7VDmHxw4vxRh9yuGxDXS803YkGNJmrBHt54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8hypevbuIL7J9LboRe7zqKdMBAVDLg0G3aGIco5IgykNCeBVthv2m05MKyu2z5+3
	 LFZcDryuwhfDxQE6ykKGxRn8sJLrVaT+H6IFW9PExnd43qJ98ptNBLqgNE5CmjsVi+
	 ivJg5nB03iiWRjC85f//kQRhq+cwehMwLp3aqtlmDwUAy9ThIyAez38StouhfaUaAp
	 kpSf0ruP4RZ0hVlm953yJUm/pvGCyKYVuk2LRl8xuTj3komR7k0vmAnmwEPtMkG0HL
	 zL7PeLTRy6kafcbDOchAykEUP6xygH8UeahMJgbAuYygUoV+nc0vU600utCxhJ8x8z
	 KP7Q3S0TqSsXg==
Date: Fri, 13 Feb 2026 09:11:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mentees@lists.linuxfoundation.org, me@brighamcampbell.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: dac: ad5504: add output-range
 and missing gpios
Message-ID: <20260213-curvy-voracious-yak-cc13ec@quoll>
References: <20260212181955.42724-1-0rayn.dev@gmail.com>
 <20260212181955.42724-2-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212181955.42724-2-0rayn.dev@gmail.com>

On Thu, Feb 12, 2026 at 07:19:54PM +0100, Taha Ed-Dafili wrote:
> The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.
> 
> Add `adi,output-range-volts` and `adi,output-range-gpios` to describe
> this hardware state, using `allOf` to enforce mutual exclusivity.
> Also add `vlogic-supply`, `clear-gpios`, and `ldac-gpios` to complete
> the hardware description.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
>  .../bindings/iio/dac/adi,ad5504.yaml          | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> index 9c2c038683b4..3e832e501b0e 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> @@ -27,12 +27,50 @@ properties:
>      maxItems: 1
>  
>    vcc-supply: true
> +  vlogic-supply: true
> +
> +  adi,output-range-volts:

Use proper property unit suffix, see dt-schema.


And really, you should have checked - you already have properties for
this! See dac schema.

> +    description:
> +      Hard-wired /R_SEL pin state. 30 V when pin is high and 60 V when
> +      pin is low.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [30, 60]
> +    default: 60
> +
> +  adi,output-range-gpios:

So another same roperty? If you looked around you would find
adi,range-gpios, which would be better than multiplying properties.
Anyway, gpios do not take vendor prefixes, so you want range-sel-gpios
or range-gpios. I guess the latter.


> +    description:
> +      GPIO connected to the R_SEL pin to select the output voltage range.
> +    maxItems: 1
> +
> +  clear-gpios:
> +    description: GPIO that controls the /CLR pin (active low).
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description: GPIO that controls the /LDAC pin (active low).
> +    maxItems: 1
>  
>  additionalProperties: false
>  
>  required:
>    - compatible
>    - reg
> +  - vcc-supply
> +
> +allOf:

allOf:
  - not:
      required:
        - foo
	- bar

Should give you exactly same result, with less code.

> +  - if:
> +      required:
> +        - adi,output-range-gpios
> +    then:
> +      properties:
> +        adi,output-range-volts: false
> +
> +  - if:
> +      required:
> +        - adi,output-range-volts
> +    then:
> +      properties:
> +        adi,output-range-gpios: false
>  
>  examples:
>    - |
> -- 
> 2.47.3
> 
