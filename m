Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCAE36F437
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833064; cv=none; b=OkEv8JG4+owLqU3fxhvj+ridrMvK1TzwZ4KyIKFJ2deVUykR6pDvTbhepnkQFxLoyrK8iAMtkfrpoTLSNfAUNoTOI23WO0QMHrnVlHdgho7qSEcrh/jyjbIuFu/oUQnLMCPHA+ts8D111xteLB0fTGCehzhs+yTAByregGbOyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833064; c=relaxed/simple;
	bh=ilwmPRsLFmPgkqbep4PVet62o0txIgMEH0pTIIfUWFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5Gm5kC/J7deuCUFvQ0pAAx61B+n0nifw9/BrCYkw7U02czjkyT/aTHGPxcsiU34gDsFv1EO1T/USsd0o0WCDuUUlGEzZ5FhuODlkzVT2AxvqO5i1nIjqrM1RnIt0e+WfPka4AF7v0NZXLHAwQMm9XldMcE3fFc3bBfnWOLDPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ld4sIBts; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ld4sIBts"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6128bd9b3so2374971a34.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782833060; x=1783437860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv8vYlFh+PBuicn2boO4XNNshtTQUIiWhs4Wjc5dQk8=;
        b=ld4sIBtsp58JIYgeGDjBTnOaDFLR1gNjsWaii2wL3eh7x15PsNcHCO4zvaLE6euAWk
         rpZkOMGHdr5XXZmckcJkx5wUL6QRLJbG59OFA5dLwhEIqRcIE2GdK4frv4gVrTUb7GaR
         VI2Lk62jmzmkpXwJ1SaSCIn+XvZVhdyJPCCQq/DgyWRBFw2FwSKpaOz1VExXtJynWxi8
         xlcCXMKRqQ0ixUCHUXoMwKhUyCkfp/NZKQAN+ypyQgzsebril3+5y4zDXb2VEvbIBvD8
         1WzKn/+USYj2p57npPdCvmBTVb4geoSTdq7m8cHPiwoYfUEwudd/FqQJvNI0qeVar+eJ
         2MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833060; x=1783437860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv8vYlFh+PBuicn2boO4XNNshtTQUIiWhs4Wjc5dQk8=;
        b=l22Lwo6YcLUz8cDHFEdKMd2qEObn+NSwX4tmpfdnz3UQYEQq3N9D6W71vDEnwAMOFk
         rrpmg/Et7TZZ2vfsEEPX5GHWIZ0CsIOzYBEGeK0QCF/E592bPO6cCjJUKM/e7/HbYpvG
         gQZrJhPu5Y5ButrYhO+V/xcdkGE91k+JJr6y8Ziv5OKANxX3SO/UW53D4SDMUE3ApAVk
         3ysP6WuSzrQ3epPRSGJ7k0H9zd/qPHmVY16xpgF2MEn4BoAYAQB+tnpuuQQBjwGBQW6D
         O1A0beltmWJi5S2opAa7lQeXmwGwtI9wWbeNX04b7sdLO88C8E/DBddW1RqvrBJUpmHV
         hAJw==
X-Forwarded-Encrypted: i=1; AFNElJ9CntFtCYGbuWbehzkoDNMlWCX6DHlEhnLVbbWJTGUNR2+xpJ1dkK/7kysULFuQNYYeY2Um2lxEJAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2Ji4qoxm88f+VYH6cP+oa+xgakjEtuU/Mdpv1dW/57HpltLq
	F+Vc459k01hy/vkvmIpR1UC818Ty/hAMZWPppo/SlNC0KimJzNoCTmX8PYMZd4xCaGw=
X-Gm-Gg: AfdE7ck9PuwfpttFsh/NOTSfgcV/sbzFvlvXstWIwuy3hPqPWItVEVEhkWuiWQVYNz6
	6cVtBYuBsLF2eLXb8jh3EsDAFQLeLbNOeE1mZvmvsjyWfXR550F3Jo+QLO7OAAy8zsGgM7HX1cL
	S8hjPoIHeuVqzoEHky0L5NqlCxyVIvB6Ft+IQQ4sH/73ED/Vvr8QgoA2KKgArLZy5FFB8Scjo06
	G7vm62uV5nIy5ZcrCLLpti9wUhEh+MhMLx1pZej+Vm1M6Mwd33FKTmueATRgWE5lp+jqXsHLMyo
	B8hYkZCyJKyXMDnao52K/oAmSgA0Ynp+mqybeQfBMUQ9KfcBXYq8yU/xMupvchNYpzlVT8RSoKF
	nJIdBoURYUxghCWzgCxYHYsmx4FUYz9gzwx3UGjZcN/8NwP2j291BPFrrMk/1mMWwpC9+H221nm
	c+z9HCgoeOl742NLmFrf6BCZrWmmSOMOHSl+9tOtLM3kTnyuWNAf4D35x8beEpt5A=
X-Received: by 2002:a05:6830:488a:b0:7e6:f482:df36 with SMTP id 46e09a7af769-7e9fbfb81bbmr567069a34.15.1782833060338;
        Tue, 30 Jun 2026 08:24:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e190:78b2:dd4e:ba94? ([2600:8803:e7e4:500:e190:78b2:dd4e:ba94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2ba18esm2689450a34.16.2026.06.30.08.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:24:19 -0700 (PDT)
Message-ID: <a64fd56f-6e4b-4e19-9804-ce7a96f14973@baylibre.com>
Date: Tue, 30 Jun 2026 10:24:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,ads1298: add ADS1299 EEG
 ADC variants
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630140311.1473031-1-shofiqtest@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260630140311.1473031-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 9:03 AM, Md Shofiqul Islam wrote:
> The ADS1299, ADS1299-4, and ADS1299-6 share the same SPI interface
> and register map as the ADS1298 ECG ADC family but are designed for
> EEG and biopotential measurement.  Key differences from ADS1298:
> - PGA gain up to 24x (vs 12x for ADS1298)
> - Internal reference is always 2.4V (no 4V option)
> 
> Add compatible strings and update the vref-supply description to
> document the ADS1299 reference voltage behaviour.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1298.yaml          | 31 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> index 71f9f9b745cb..82c5181126df 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> @@ -4,11 +4,16 @@
>  $id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Texas Instruments' ads1298 medical ADC chips
> +title: Texas Instruments ADS1298/ADS1299 biopotential ADC chips
>  
>  description: |
> -  Datasheet at: https://www.ti.com/product/ADS1298
> -  Bindings for this chip aren't complete.
> +  ADS1298/ADS1298R: 8-channel, 24-bit ECG ADC.
> +  Datasheet: https://www.ti.com/product/ADS1298
> +
> +  ADS1299/ADS1299-4/ADS1299-6: 8/4/6-channel, 24-bit EEG/biopotential ADC.
> +  Identical SPI interface and register map to the ADS1298 family, but with
> +  a higher maximum PGA gain (24x vs 12x) and fixed 2.4V internal reference.
> +  Datasheet: https://www.ti.com/product/ADS1299
>  
>  maintainers:
>    - Mike Looijmans <mike.looijmans@topic.nl>
> @@ -17,6 +22,9 @@ properties:
>    compatible:
>      enum:
>        - ti,ads1298
> +      - ti,ads1299
> +      - ti,ads1299-4
> +      - ti,ads1299-6
>  
>    reg:
>      maxItems: 1
> @@ -33,8 +41,10 @@ properties:
>  
>    vref-supply:
>      description:
> -      Optional reference voltage. If omitted, internal reference is used,
> -      which is 2.4V when analog supply is below 4.4V, 4V otherwise.
> +      Optional reference voltage. If omitted, internal reference is used.
> +      For ADS1298, the internal reference is 2.4V when analog supply is
> +      below 4.4V, 4V otherwise. For ADS1299, the internal reference is
> +      always 2.4V.

Not sure the dt-bindings care about the internal reference. It should
just be a driver implementation detail.

So I would just trim this down to:

	Optional reference voltage. If omitted, internal reference is used.

>  
>    clocks:
>      description: Optional 2.048 MHz external source clock on CLK pin
> @@ -75,5 +85,16 @@ examples:
>            spi-max-frequency = <20000000>;
>            spi-cpha;
>          };
> +
> +        adc@2 {
> +          reg = <2>;
> +          compatible = "ti,ads1299";
> +          label = "ads1299-1-eeg";
> +          avdd-supply = <&reg_iso_5v_a>;
> +          interrupt-parent = <&gpio0>;
> +          interrupts = <79 IRQ_TYPE_EDGE_FALLING>;
> +          spi-max-frequency = <20000000>;
> +          spi-cpha;
> +        };

Since the chips are nearly identical, not sure a 2nd example is
particularly useful.

>      };
>  ...

