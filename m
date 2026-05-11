Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A924330EF8F;
	Mon, 11 May 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515343; cv=none; b=PmHryeli62mWNZUp9MHk+9XymHKCqnMw0QQhYM3ZsN9DIr3dF+yqrtaOrL+AIrjtECxWoQxt6ivKWr4T+dAa95vmwppeJUS59ASS9EcWUl9q4zPUMfBu3v34za/NPvAXiYAm4adL/CLqsMUeVYmN9Pt7LVRbrnXCBZjqH0nherA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515343; c=relaxed/simple;
	bh=d8WItIwthuDEpX/UiQlfKMc9royYtzyV+pGcQrzVbPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjrBXks+XDd3kabapx7dW6bq9IhE8LIO0Y3mPp/1SsXPrnZtvc1KNuaRHYyeISM7JnoIPoJyQf7EX/tI32JI6JXTo1ZQNafvfm9Jt/B5V5qsPXI3pC3gliq2x9rfWRFYWhA4H2y4IJHwZadZl5ZQx8l2gxq3urrtipxsZdHAOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GvQN5vbE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GvQN5vbE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD43B16F3;
	Mon, 11 May 2026 09:02:15 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67AD03F836;
	Mon, 11 May 2026 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778515341; bh=d8WItIwthuDEpX/UiQlfKMc9royYtzyV+pGcQrzVbPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GvQN5vbEqBrW0wVLOoCaZCwYaB+zRsucAkYwhhEFXPQKUICM7t7svrPEDy5uaj+ns
	 koT6QL4ySkLHNb8hlT0lW7CUe/p8+ozsHkVDoem0J+IMLPLrb8zunUwkoguvPjtPiQ
	 LU6mDfZgyMRgjD6pA5Fr64Sd6Zr6hbl/BrrcWKu4=
Message-ID: <e7269822-afc4-4a80-8408-297f9dbd6791@arm.com>
Date: Mon, 11 May 2026 18:02:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add GPADC for Allwinner A523
To: Michal Piekos <michal.piekos@mmpsystems.pl>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maksim Kiselev <bigunclemax@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
 <20260510-sunxi-a523-gpadc-v1-1-4f6b0f4000fb@mmpsystems.pl>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260510-sunxi-a523-gpadc-v1-1-4f6b0f4000fb@mmpsystems.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michal,

thanks for adding this!

On 5/10/26 14:57, Michal Piekos wrote:
> Add support for the GPADC for the Allwinner A523. It differs from the
> D1/T113s/R329/T507 by having two clocks.
> 
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> ---
>   .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         | 37 +++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> index da605a051b94..89da96cd705f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> @@ -17,6 +17,7 @@ properties:
>         - items:
>             - enum:
>                 - allwinner,sun50i-h616-gpadc
> +              - allwinner,sun55i-a523-gpadc
>             - const: allwinner,sun20i-d1-gpadc

As Jernej already mentioned, the A523 GPADC is not fully compatible, 
since it adds another clock. The question to ask is: Can a driver only 
knowing about the fallback device handle this new device? For which the 
answer here is: No, it misses a clock.
So add just a single entry for the A523 (plus adding it to the driver).

So looking at this I wonder if we should add some property to describe 
the number of supported channels, since they are slightly different 
between the SoCs:
- The D1 manual mentions 2 channels.
- The T113s manual (same die as the D1?) describes 1 channel only.
- The T507 manual (same die as the H616) reports 4 channels.
- The A733 has 6 channels.
- The A133 has 1 channel, but it's channel 1, not 0.

So all of this is somewhat covered as channels are described as child 
nodes, and have a reg property. Ideally non-existing channels just 
wouldn't be listed, but I don't know if we want to rely on that.

So I am wondering if we should introduce a limit, or rather a mask (to 
cover the A133 oddity)?
Either a DT property (channel-mask, as a single sell representing the 
bit mask), or derived in the driver from the compatible string.
The former would avoid introducing different compatible strings just 
because of that, though I think this type of property is somewhat 
discouraged?

Any thoughts?

>   
>     "#io-channel-cells":
> @@ -29,7 +30,12 @@ properties:
>       const: 0
>   
>     clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
>   
>     interrupts:
>       maxItems: 1
> @@ -40,6 +46,35 @@ properties:
>     resets:
>       maxItems: 1
>   
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            - const: allwinner,sun55i-a523-gpadc
> +            - const: allwinner,sun20i-d1-gpadc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - description: Bus clock
> +            - description: Module clock

I am not a YAML expert, but I think you can drop the min and max 
properties, if you just enumerate the cases. Same for the names.

Cheers,
Andre

> +        clock-names:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - const: bus
> +            - const: mod
> +      required:
> +        - clock-names
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names: false
> +
>   patternProperties:
>     "^channel@[0-9a-f]+$":
>       $ref: adc.yaml
> 

