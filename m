Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613799;
	b=ctbwtlqQuxW430ezLnmCants/8ToKjO7SNrETK4yG+ZlTMyUzd9szSfhlZWz03RrzFba
	 Y81gI8Bd6GfI0FeViFTVjDjK+TuVhnXpIoVJdJRSYKMvIR5Sfe+o1OPZ1ZEs+5uu4C7yk
	 VpDqg6mGVfpYwGjZXw6TbTwBAkmZwdp0VWubd1t0fBPiHywSlzCxf6zL4suMZUhkLJsUo
	 b6qYgcrQIZcrpiA0tGOGqfilQXdjIr+0Z8I3ThF7jt3c398SpOchUfOpJBJ1zw+aWkyNj
	 ydvxVePyi7/v0UFpxfvPRAyWjsUupueLKAddNZF5lxhZQxk5xTLRTFNpFXpGS+WJUjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613799;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2YGEq7yMAkzCJ7AWvTtLlTFsQxxR0DtnZuHVN93H/rY=;
	b=mupCGKQOB5Nt1tQCm04+uVr6clO1ocWpe2/xZBtlGuczxbl4e1B5i8bIDOnPLINTuZna
	 o6s3zFoZBt267acVXVudx1QZGgmTuRZc/jkjInasRW5FC3RMis/bUMMIml7FriHgfCsbc
	 s2i+Tr87pw3OhDWGjivAj1tItHqgZR9hgabZ2cNJFyrt5ZdOl49st2R2llC5hQw/G4AjR
	 ci7ebNI+7ajThJQfcI9BTMNt6gD/qo16or+ZfSPYX2KmiEB9A6bEUeE22WMFAqKkHb37y
	 aqmo+6LuaT7wFcPnuHzYkLjKR9/h9uFoimzkOuKcSmNzPIBefh03xgZ95CSd3Q3bR1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9ek7HXm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71276606A333;
	Mon,  2 Nov 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9ek7HXm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3491F00A17;
	Mon,  2 Nov 2026 10:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613799;
	bh=2YGEq7yMAkzCJ7AWvTtLlTFsQxxR0DtnZuHVN93H/rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E9ek7HXmlKDrt+9Nsevchyw2AYqqlIabzlTWy0RvTQhcI3BS9M0og+wnlDHDQBe8O
	 fGj+nuxZSewsoCijUBzEkhxt44uS09gYz4Xhd58RvKajYZ0zEZaRJ/zYDQ7K7yBWJD
	 Vpx/N5GK55N33cj2mhRnaSIM/6ZMN8tzUkWs2HBg5hgxnn4bs7b6jRtboZo9d84qjt
	 tAoBWlZ4j/00omnc40MYDhOZh9kobrco975mAl4yIA7+EjGfe06e7XTBF9eVNx64DG
	 Rx+zjTgTRW7iNt6DlgZNmimTOIKLN9iC3QVAKR462Apqsef7S4aZFZOuY9bBARo4Oa
	 cZnqlZW8elz4w==
Date: Mon, 2 Nov 2026 11:03:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Message-ID: <20261102-bald-mysterious-alpaca-13b8fa@quoll>
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
 <20261030031501.130290-2-cwweng.linux@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030031501.130290-2-cwweng.linux@gmail.com>

On Fri, Oct 30, 2026 at 11:15:00AM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add a devicetree binding for the Enhanced Analog-to-Digital Converter
> (EADC) found on Nuvoton MA35D1 SoCs.
> 
> The controller provides eight external analog inputs which can be used
> as single-ended channels or as four fixed differential pairs: 0-4,
> 1-5, 2-6 and 3-7.
> 
> Describe the four hardware interrupt outputs, ADINT0 through ADINT3.
> ADINT0 through ADINT2 are associated with the corresponding conversion
> interrupt flags, while ADINT3 is shared by the ADIF3 conversion
> interrupt and the ADCMPF0 through ADCMPF3 result-compare interrupt
> sources.
> 
> Also describe the functional clock, optional reset, optional external
> reference supply and optional DMA request.

Don't repeat the patch contents.

> 
> Expose the controller as an IIO channel provider through the
> DT #io-channel-cells property. The cell identifies the logical EADC
> channel selected by the reg value of the corresponding channel child
> node.
> 
> Restrict the channel binding to features supported by the MA35D1 EADC
> hardware and use the common single-channel representation for
> single-ended inputs.

And here even more.

> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> new file mode 100644
> index 000000000000..97144a8eeb5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
> +
> +maintainers:
> +  - Chi-Wen Weng <cwweng@nuvoton.com>
> +
> +description: |
> +  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
> +  12-bit successive approximation converter with eight external analog
> +  inputs and one internally connected VBAT input.
> +
> +  The external inputs can be used as eight single-ended channels or as
> +  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
> +  connected VBAT input is not described by a channel child node.
> +
> +  The controller provides four interrupt outputs, ADINT0 through ADINT3.
> +  ADINT0, ADINT1 and ADINT2 are generated by the corresponding ADIF0,
> +  ADIF1 and ADIF2 conversion interrupt flags. ADINT3 is shared by the
> +  ADIF3 conversion interrupt flag and the ADCMPF0 through ADCMPF3 result
> +  compare flags.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-eadc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: ADINT0 conversion interrupt output generated by ADIF0
> +      - description: ADINT1 conversion interrupt output generated by ADIF1
> +      - description: ADINT2 conversion interrupt output generated by ADIF2
> +      - description: >

Drop >

> +          ADINT3 shared interrupt output generated by ADIF3 or by the
> +          ADCMPF0 through ADCMPF3 result compare flags
> +
> +  interrupt-names:
> +    items:
> +      - const: adint0
> +      - const: adint1
> +      - const: adint2
> +      - const: adint3

"int" is redundant, so honestly names should rather go away completely.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1

Best regards,
Krzysztof

