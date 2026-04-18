Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A736BB5B
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776548816; cv=none; b=mNPyQSv7s37LCmG3fNghrPTwFaMm6Pw8v8U2KHW8Q/68S2BXO3Fx4scg16R8T8s+ODZmVs8ddXLS6PyIPmGqq+XX5BN3ZcQ2BqTZ2T/Ny+tB1mtb2IBGg8shvPMcZzXH9c/BWzPV8O/l35s4BjOBfpfYfP72ITdL3yGcCD3zk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776548816; c=relaxed/simple;
	bh=CyRHcuY8zYNdos8cSAYeyx6FOS92k2vX+NfUNR6+NvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2TxTx+ljBYA9evP1eejhl0McD8b15KDiPh0TuRSzuH9ngnMYTcyyMSXJJigm4zilaV/179n49P7cUBNgJfRCFwZavsvWEoWuM8VPiS04Kw16prHdJcUTIznVEsyelCodSfBNXbN450PI9XE3N9R3qzXyRFY4jYQslfR2N+cITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=rkiFmKRi; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="rkiFmKRi"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479932ccb9bso553573b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776548812; x=1777153612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlFal52AkQM6BisW0M/k3f7NMBBq+4z5klxPyW4MPx4=;
        b=rkiFmKRiFU7njH2JrGUhcQBiwd1AxwF/hYMHnMwP0n5DkkVucJpN3TF/RzKGcz5Rpr
         WWHHPmojEh4cHYXCSUYuYt7u2foMRCi6tlE9xdXGEmnfHiucZVa26jbLUjEOjQOxOCo0
         0vDEgstM55V4Di5gEoUBJrlifNyIoLinZAPSI6buqnGZQhBultbEf5fwoyUZ16VIsWk8
         I7pNXZ5A+jppFcuY+SZdJABv3KqEVQUwW4lceZbZzK8hS40QBgRjw/mCmH5SQ+FwtirK
         IFdcFpEaipPr1ztug935MZowFwm2hOqpGjW/h9bMyEPlR3qojqfGqavZMEyAssYejJJ6
         lARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776548812; x=1777153612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlFal52AkQM6BisW0M/k3f7NMBBq+4z5klxPyW4MPx4=;
        b=iYBQ+gEbuljyCHgALuT2nc9ky85NmWmH5eM4h1Pz4+k7yUJyzHgJgJa+I2cgVw+BdJ
         aLs/GKKLNeI3E1dRMqer2uE6A83FLY1GK01S8KfFRasWFbPj4hA7YpLr/zzkd1ia8TEM
         9uZ6TnCnYmoZBlvaMmVGNCBu5KV0gLQNe1czmMOm36kBvjeWoRzaOaOAvlh92vRQJ4ee
         FQ4aaHvlNFrtdW682yegvlG02y+PqWJ9ekDoc/vVZhTqPKsb5FRlhmwHBI8lRHgUxzZY
         ziutE/S7k79yS8cxErlw+ynG4mexeXqWf4fTcvrUfMiD4wXA2Ga6ydOzSNaIj0R2siIa
         fHkw==
X-Forwarded-Encrypted: i=1; AFNElJ+R0OEq9VP2+3a0s7r/1nnnC5ZCOpj/7UvuqT8hBvanwa/SDWp+nT8uZxJ35pBRZ8PGF4SteQvDG2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgDVFHJ0Ic1/X5TdG/9HYwC3YYaTDDhERY7RRYltV0An725HO
	KCC6ulT2WYiMkvwCQyi/bQRY2n5N4HPxUWPob4B9lcLyWkf3MtftSdbFELHD3GnI42g=
X-Gm-Gg: AeBDietLjnpFu6UtoX1CfUiYYDZFdHqZfn5Lm4Quqo1flPjpWsse/dhDCdTpqr8YpWS
	v8ZMVWqkhuzcsOZVOVgcS2tsgl1QVcxfSf0UGJeRSCtv0vCIHxDGQ8ORcyJqbgndVE0n+Xv+pI3
	iz5CiJhBL6XFUfv1KRFJ1f7EI3JhYKhYT6Xsd2VWxHmRCHX4+BMn45IGlH94QsFPKx2fDqxrDY7
	SlNZQdISMCr8dHozogDGYpxo3iB/UPZeaWLhgvhd5WWqA1AVXviVs825kRUBLXGSPzjOkJfNY9C
	zHQjjWUqHfZmBuzF6YX0UL35n1TdI4qzUZDCMEL2PdyBwa0rfsM894dz9Gp19FZZcgVIk5U8j0W
	rEVXJeHLdW2LA45DKpbk43L4ObLVGwANzMDiysu35jnbsH3f+q6uiFpY08bJ3RTPMy3/56b3LVk
	enPZ8LV9SkyEEOz17F7pQe92Uar4wdzwQgZQzCTBpIugxVa18wdux390fGegmO0QFaT64Cbvy+o
	fccDYcZlnN624V9l7PO5og=
X-Received: by 2002:a05:6808:1442:b0:467:ca8:c397 with SMTP id 5614622812f47-4799c8782efmr3858530b6e.4.1776548812273;
        Sat, 18 Apr 2026 14:46:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799fead505sm3790789b6e.2.2026.04.18.14.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 14:46:50 -0700 (PDT)
Message-ID: <23a00548-feac-4ce6-9a71-509b7636b372@baylibre.com>
Date: Sat, 18 Apr 2026 16:46:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: avia-hx711: add avia,hx710b
 compatible
To: Piyush Patle <piyushpatle228@gmail.com>, jic23@kernel.org,
 ak@it-klinger.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260418170549.312446-1-piyushpatle228@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260418170549.312446-1-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/26 12:05 PM, Piyush Patle wrote:
> Add the HX710B compatible to the binding and describe the variant-specific
> channel and gain model.
> 
> Also add an example node for HX710B so the schema covers both supported
> parts.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
>  .../bindings/iio/adc/avia-hx711.yaml          | 36 +++++++++++++++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index 9c57eb13f892..19318c4dd994 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: AVIA HX711 ADC chip for weight cells
> +title: AVIA HX711 and HX710B ADCs
>  
>  maintainers:
>    - Andreas Klinger <ak@it-klinger.de>
> @@ -12,9 +12,19 @@ maintainers:
>  description: |
>    Bit-banging driver using two GPIOs:
>    - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
> -    and up to 3 cycles for selection of the input channel and gain for the
> -    next measurement
> -  - dout-gpio is the sensor data the sensor responds to the clock
> +    and 1 to 3 additional cycles for selection of the input channel and gain
> +    for the next measurement
> +  - dout-gpio is the sensor data output the sensor drives in response to
> +    the clock
> +
> +  HX711: 24-bit ADC with selectable gain (32/64/128) and two differential
> +  input channels. Channel A supports gain 64 and 128; channel B supports
> +  gain 32.
> +
> +  HX710B: 24-bit ADC with fixed gain of 128. Channel 0 is the differential
> +  input and channel 1 measures the DVDD-AVDD supply voltage difference.
> +  Channel selection for the next conversion is controlled by the number of
> +  trailing PD_SCK pulses.

The bits about "bit-banging" and "channel selection" sound like driver
implementation details that don't belong in the DT bindings.

>  
>    Specifications about the driver can be found at:
>    http://www.aviaic.com/ENProducts.aspx
> @@ -23,11 +33,12 @@ properties:
>    compatible:
>      enum:
>        - avia,hx711
> +      - avia,hx710b
>  
>    sck-gpios:
>      description:
>        Definition of the GPIO for the clock (output). In the datasheet it is
> -      named PD_SCK
> +      named PD_SCK.

Save the cleanups for a separate patch to keep the adding HX710B changes clear.

I'm guessing the existing binding for HX711 is quite old because it is quite
incomplete.

It has avdd-supply, but is missing vsup-supply and dvdd-supply.

It should probably also have a way to describe how the rate pin is wired.

And it should have a clocks property instead of clock-frequency.

It would make sense to have two clocks, on for XI/XO and one for PD_SCK.
The second one being optional because of sck-gpios.

HX710B has many fewer pins, so we will need an:

allOf:
  - if:
      properties:
	compatible:
	  const: avia,hx710b

section that sets anything for pins that chip doesn't have to false, like
vsup-supply.

HX710B also has a vref-supply that HX711 doesn't have. (Unless these are the
same thing by a different name?)


>      maxItems: 1
>  
>    dout-gpios:
> @@ -43,6 +54,9 @@ properties:
>        Definition of the regulator used as analog supply
>  
>    clock-frequency:
> +    description:
> +      Bit-bang clock frequency on PD_SCK. Keep the PD_SCK high time below
> +      the chip power-down threshold.

I suspect that this was meant to be the crystal frequency (XI/XO), not PD_SCK
since sck-gpios already exists for PD_SCK

>      minimum: 20000
>      maximum: 2500000
>      default: 400000
> @@ -58,10 +72,20 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> -    weight {
> +    /* HX711 example */

The compatible string already has the part number, so this comment
doesn't really and any new info.

> +    weight0 {
>          compatible = "avia,hx711";
>          sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>          dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
>          avdd-supply = <&avdd>;
>          clock-frequency = <100000>;
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    /* HX710B example */
> +    weight1 {
> +        compatible = "avia,hx710b";
> +        sck-gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
> +        dout-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
> +        avdd-supply = <&avdd>;
> +    };

There is nothing significantly different about this example, so it
isn't particularly useful.

