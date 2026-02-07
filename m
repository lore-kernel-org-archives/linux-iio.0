Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A243242AA;
	Sat,  7 Feb 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770460908; cv=none; b=s1sbGxFyGCBRu3Boi7iqnbAWsTLODo2+XlqKUpq9+JibIH/rVO7tqylgybyJ4ONtOeWobppKO+k9kMEI5dyQvMqH81TEJRPjXAbof3akqOZWkGjCTV7xz5gabk69T5bmuNULXS2mqyM/TNY1BIWSu9Vh19FjO426erENGtgEihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770460908; c=relaxed/simple;
	bh=JFn5XByg+LkSSHOnxd5LTp3rBc3AjzTjLsHUyvk/Szw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcXQvk0MAJKGTsHjL+DnpcEoapKjNG2/+zSgqqPGvTo6xj2x0YGBzIASWzXmhECNwpP8h1nj8m4z+lK7Ug4V0AmxxgahIjqodKVizR1UOHu6sUpqUHMvYImZHR6I25JNSrPBQWDU8wzN63MDcyt2J2/9d5xhMx3ehO3qqBwjAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcrciDW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcrciDW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823E4C116D0;
	Sat,  7 Feb 2026 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770460908;
	bh=JFn5XByg+LkSSHOnxd5LTp3rBc3AjzTjLsHUyvk/Szw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcrciDW5Rfzo9FII8PA8KEe609jdNZxD5APEVrmL2SVisLslKqID7yeT6AwXWQHB2
	 fyf62qb8hMsZWMtJxe5TOaUA7kZQCbaC1md3ehz9I8CVbl1qqD0Pa/hNFkzkVt/SrL
	 7xNOEezmVzOtPws63OcPQHPvvf2h1B+CD+Q0q5mRbUrqylnNbjbg+l6PfHyYqvHntA
	 UL3J4FnIraV3n97NiJe9gmH34pX5tZkGZtzKZfqyj8AuqFEvlC7FOTAbmtIWXo0C6S
	 rLLbWJI5khA3zt/2aQiR7e6aXqR4yLdWGzH1CNWyf31aV2r5Mr1kq4brxft4Deypp0
	 Ovc/JowuyZ9XQ==
Date: Sat, 7 Feb 2026 11:41:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
Message-ID: <20260207-evasive-mastodon-of-apotheosis-e663a1@quoll>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <290f35bcbd2f1ee68333ff65f89b54ec7fbb9c53.1770393792.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <290f35bcbd2f1ee68333ff65f89b54ec7fbb9c53.1770393792.git.antoniu.miclaus@analog.com>

On Fri, Feb 06, 2026 at 06:07:15PM +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> with integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. This requires:
> - Two entries in reg property for primary and secondary channel chip selects

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Please run scripts/checkpatch.pl on the patches and fix reported
warnings.

> - Two io-backends entries for the two data channels
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v2:
>   - Replace custom adi,aux-spi-cs property with standard reg property
>     containing two entries for multi-channel devices
>   - Add conditional schema validation for reg and io-backends based on
>     compatible string
>   - Update example to use reg = <0 1> instead of adi,aux-spi-cs
>   - Add AD4880 datasheet link
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          | 51 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> index ccd6a0ac1539..7108a91bb0bf 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> @@ -18,7 +18,11 @@ description: |
>    service a wide variety of precision, wide bandwidth data acquisition
>    applications.
>  
> +  The AD4880 is a dual-channel variant with two independent ADC channels,
> +  each with its own SPI configuration interface.
> +
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4080.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf
>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -31,9 +35,15 @@ properties:
>        - adi,ad4084
>        - adi,ad4086
>        - adi,ad4087
> +      - adi,ad4880
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      SPI chip select(s). For single-channel devices, one chip select.
> +      For multi-channel devices like AD4880, two chip selects are required
> +      as each channel has its own SPI configuration interface.
>  
>    spi-max-frequency:
>      description: Configuration of the SPI bus.
> @@ -57,7 +67,8 @@ properties:
>    vrefin-supply: true
>  
>    io-backends:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

Instead list the items with minItems, so the order is defined.

>  
>    adi,lvds-cnv-enable:
>      description: Enable the LVDS signal type on the CNV pin. Default is CMOS.
> @@ -78,6 +89,25 @@ required:
>    - vdd33-supply
>    - vrefin-supply
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad4880
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +        io-backends:
> +          minItems: 2
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        io-backends:
> +          maxItems: 1
> +
>  additionalProperties: false
>  
>  examples:
> @@ -98,4 +128,21 @@ examples:
>            io-backends = <&iio_backend>;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +          compatible = "adi,ad4880";
> +          reg = <0 1>;

<0>, <1>, no? You want two separate chip selects, right? (size-cells is
0).

Best regards,
Krzysztof

