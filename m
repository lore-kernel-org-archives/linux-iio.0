Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A52D7DC6
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787422850; cv=none; b=V5sLtZZmOfbrFV68wF3WAm4Ov0A6ly5JclGlxjreRC7wOdpo7hcKD8xFSio7L3hqorl3K+0vZjg1MB54BB2lNSECD7Ph37wd9RLvfWzkR+SpWPBtej8W5u+zKixgrkLrAQKNc7cvWqSZ3TInryLNrZVPTbvAheiPa0AEFsbwB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787422850; c=relaxed/simple;
	bh=yAd7mVfoTBbWlzpS260BpQ70itHd8Zbdwg1YAKphL9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+Yt/K4vF/2OXtdKBG30VuNaTNk3KhEeSzy0Hd/uanLsoyomiN2zWljDiK7fE+sePd9U3J8PsTNUH/NiZPVjF9WKn3rAjmyElUkAYRr/b8YBZ2QToXaW1+70nftcYD0RFEermhIVeSUu7h0G185Y4E6xA3DYzthmdtx/oM+DzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QtdB0DiS; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QtdB0DiS"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f3ff92cf4aso2197816a34.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787422846; x=1788027646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQNhgPr9yKeFxbuFf8eNz2imAjAUqFj9cvzQCXV9ESs=;
        b=QtdB0DiSzSVUfDZCjXeD9nEncE0SZ5qIlVFYDFNoIKJMeSlyjWcPg0ucyxPo3DZVfe
         KWr9do1iFWeblA8KhMWJhLkdGx9CRogPHU0ozgglmnUOIVeb5R46lIkrYHyTPPwsOGuk
         YuWsFh6BHdy4j+60yDKckvtXR8jZBd6fvuyE6wBAdTn97A/+FZUZoa7JgoZRX3ShyHCE
         ampOQ+wdbk0/QkRE1sroDVPXNvMRdcik0MtGDAqZC8OwQf8/VKeqEaNnEgFaPDK13xYS
         6TgEpgRA7wIJUvlbgbJbVOSeI0sROy66nSR1OuHh8VJqOl5cdJmJSLxO2W7uYAfpgk3j
         8W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787422846; x=1788027646;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQNhgPr9yKeFxbuFf8eNz2imAjAUqFj9cvzQCXV9ESs=;
        b=XpfeL2LD18IKUeGvZM3NIPREq83gdnwLGGRZEI+CSw32JUTDORVPon3dG16Bfwh85O
         CgwzB8GLNylNu5gWCTPpMuMKuTIa6sfyporMQHQRyT8DMZxeXLKrH34BD1qkvdaoA2wy
         rTeyD3aKAQ92/xGTX1i0izhQJncNj5VP/dUbLdENHdhYdd+jduXNX49lQtYVJDc8obGR
         To84Mz4hx2VP5NvtcHylU/w/GKxXUZRJN0S7upBu7Fep1hQJB01I2ylReSluH2LMdV3T
         Y8txpCoryfY7xGXa8JSqYOnLDNTmo146+R0wbnvR1wPPW+89aklBTrBTS7x4nISW0wQn
         Smwg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/l3RrmQQ9R/XOfAL9nsAMTqpGmUh3ie/sdBRyLnIMf+R/GMfkrXIZUeQtSJABXfhZfAn1YcpTEuk=@vger.kernel.org
X-Gm-Message-State: AFuF++kfdZtfQ8yfbfWfc3HM7C6UenGh11i7kGxErnQKr+9k3Ek7wUqO
	aRaxUbE6qefK1MMzw8X3bzTb9qkFLKvqEllwLz+qUnrGG/ee2Kj7z+Tvbqqid5Vganc=
X-Gm-Gg: AR+sD12l2TaSkd+0IWoXEBbmUvsVHNeHYOppnNyArrUrAyHvopjsj1U7aSg0Pur+Lmj
	LOlRHFq1+76WADXycUBj85W/l764MU3y1rNyYslIyMcuFz1UMtmSk0Hydhd5hGgeqhafOx7X0l6
	SgzivAaxdE1evMMOtqUN19SnhMgce2OfMl8Th2xp3VB5GUhOayTJ1X4zo8++9I/RYfNphfVSZZO
	1PvJeQzEh5BUHeA1/Qn6u6HyXEGYE3tPsq1WHQ7qLBDO+ubuAQyTP81+ojV8f/MrOMJfDvON29n
	W/Htp3XT65+q6zrVBwhc3x36Y7ExdVPOIkFtws7lDRLanSL6+2LHX4xgILLwpXo/aAX/1oRQKRQ
	/xALpgKla64/Cyxpz10g41A4kYBwtmWx5cUwg8uOSr0/sJ11hnKrwzZRrdBSNbxYOM52nUwCN9g
	T27CHu9Sf+YCncZClwpp+mz49cAo+x+dfy+Kz7uoB+wvMrviXhHZqdtzHj25tOSFJrvyohzCD1I
	OWRPGt9Y60ORsszLHYGxQNMCeoBFxWmOkBg1xU=
X-Received: by 2002:a05:6830:83a3:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-7f461349073mr19255634a34.1.1787422846094;
        Sat, 22 Aug 2026 11:20:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7065csm10638335a34.1.2026.08.22.11.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 11:20:45 -0700 (PDT)
Message-ID: <f35aea7d-0844-426e-ac81-d5b156b60e4a@baylibre.com>
Date: Sat, 22 Aug 2026 13:20:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: dac: ad5504: add output-range
 and missing gpios
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org, lars@metafoo.de
Cc: Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 skhan@linuxfoundation.org, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260822085850.17527-1-0rayn.dev@gmail.com>
 <20260822085850.17527-2-0rayn.dev@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260822085850.17527-2-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 3:56 AM, Taha Ed-Dafili wrote:
> The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.
> 
> Use standard output-range-microvolt and range-sel-gpios properties to
> describe the hardware configuration of the R_SEL pin. Ensure mutual
> exclusivity using the not/required logic. Additionally, add missing
> vlogic-supply, clr-gpios, ldac-gpios and datasheet links, and provide
> a complete usage example.
> 
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/iio/dac/adi,ad5504.yaml          | 39 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> index 9c2c038683b4..e0123dceaa33 100644
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
> @@ -27,6 +29,29 @@ properties:
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
> +  clr-gpios:

This is one that is starting to emerge as a common name, so I would call
it clear-gpios instead to match the same name on chips with a similar
function.

> +    description: GPIO that controls the /CLR pin (active low).
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description: GPIO that controls the /LDAC pin (active low).
> +    maxItems: 1
>  
>  additionalProperties: false
>  
> @@ -34,9 +59,17 @@ required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - not:
> +      required:
> +        - range-sel-gpios
> +        - output-range-microvolt
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
>      spi {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -45,6 +78,10 @@ examples:
>              compatible = "adi,ad5504";
>              vcc-supply = <&dac_vcc>;
>              interrupts = <55 IRQ_TYPE_EDGE_FALLING>;
> +
> +            output-range-microvolt = <0 60000000>;
> +            clr-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
> +            ldac-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
>          };
>      };
>  ...

