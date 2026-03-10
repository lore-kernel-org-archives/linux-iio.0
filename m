Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC793164DF;
	Tue, 10 Mar 2026 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173470; cv=none; b=bzIHcoIPb2zpY9o0zattWjx/Ac5fWHXySfMseeQEJCogTQ1a7Qu9FHU8j7/H0tC29qXuBn/XrHx0jJnMSjvHQ6/+VRH/ZycpamQY74rOcasunMcvj3sXdOjRu12Kb08gGBPzqY96x5C07EXKJczs1JgDjmMl0snn2s17E1jFUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173470; c=relaxed/simple;
	bh=4Z8XqE3UvYxBjddjBwKXl7xeUEpNa0b3S65LVm1zYMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jP4UdwINCbzzFv5Oj3kbbLvTlVX0kCkA9HAp10bSG/0jKqJOwOWKU5MeRr1LvNAV0x3zRdKKs/VXtBAOsnhD5zl2CIHWFG2hycZdpiAZR3CKFle25GMUSKD+IPLiwJb4zxY63TNPWER0+ja6dW63VWeOISkRCtNedsMhfDogl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ciey979u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ciey979u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D0EC19423;
	Tue, 10 Mar 2026 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773173469;
	bh=4Z8XqE3UvYxBjddjBwKXl7xeUEpNa0b3S65LVm1zYMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ciey979uCqn87um4aS/XCmH8eKO4hap2RIoDaD+0lj6VrzisYCppigRsnIw2B7KH/
	 AkWpP1fPvKQJ4g3qnKWQA5h77sg6VGHhoqevmni3m87UJ8u4aJbKSnUR8D9F7Yg7br
	 Xlkvx5oUM9CT9JS0UdvgB2BdY2nl/bBbzFzNKrlSsqhixcCFTp+2V3uUwsSe9Db+Dn
	 aHBLv0ATH8DO/FqJ42cl0QFDMUZ2pLibzBdAqwrgtrilVX2nBTjVHe1pqbEKN1/DwY
	 Sviz8IewhMbNOfhn7wGuvdlnme+YkCLbbSZ0Jhmvk65GenWDaDYizl/T6fE3Ww351r
	 BOdW+47c4ljHA==
Message-ID: <a617bbfe-0339-4334-8b52-dc85de12c626@kernel.org>
Date: Tue, 10 Mar 2026 21:11:04 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: dac: ad5504: add output-range
 and missing gpios
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
 <20260310174835.24209-2-0rayn.dev@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260310174835.24209-2-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2026 18:48, Taha Ed-Dafili wrote:
> The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.
> 
> Use standard output-range-microvolt and range-sel-gpios properties to
> describe the hardware configuration of the R_SEL pin. Ensure mutual
> exclusivity using the not/required logic. Additionally, add missing
> vlogic-supply, clear-gpios, ldac-gpios and datasheet links, and provide
> a complete usage example.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>

Hm? Where did I suggest writing such patch?

Are you mixing terms here? I gave you review, no?

> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
>  .../bindings/iio/dac/adi,ad5504.yaml          | 40 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> index 9c2c038683b4..c0b2d470949a 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> @@ -10,8 +10,10 @@ maintainers:
>    - Lars-Peter Clausen <lars@metafoo.de>
>    - Jonathan Cameron <jic23@kernel.org>
>  
> -description:
> +description: |
>    High voltage (up to 60V) DACs with temperature sensor alarm function
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5504.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5501.pdf
>  
>  properties:
>    compatible:
> @@ -27,16 +29,48 @@ properties:
>      maxItems: 1
>  
>    vcc-supply: true
> +  vlogic-supply: true
> +
> +  output-range-microvolt:
> +    description: |
> +      Specify the channel output full scale range. The R_SEL pin
> +      determines if the range is 0-30V or 0-60V.
> +    items:
> +      - const: 0
> +      - enum: [30000000, 60000000]
> +    default: [0, 60000000]
> +
> +  range-sel-gpios:
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

This is technically ABI break and nothing in the commit msg explained
why you are doing this, why this was not required before etc. Changes
you make must come with proper background.

> +
> +allOf:
> +  - not:
> +      required:
> +        - range-sel-gpios
> +        - output-range-microvolt


Best regards,
Krzysztof
