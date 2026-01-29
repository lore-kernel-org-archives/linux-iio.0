Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DE33F362
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703632; cv=none; b=rFXObxPpUZ6s4zs6IEEg3uWlQeWbf/YhJRV5elIPZRdMjNxIMxnCZE49kpmOexwCbwTAVYya7ZgfruC6RNHKMA3V6gbbSAzoz5pkGRdfP6chUXAbu7FoBwRQW4EQML6kV2hB5RctbfObs+xzN85Hlsqdd5Trbg2e0qhjOzH6O60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703632; c=relaxed/simple;
	bh=EGsRY7aG0zzAYU857y9QMnROLwSVALHkPRes/8MaDSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FWATwx2Zr+JaOcqqxz/gs2HBE8L4/7nd0Wl6iQfPchA0YtGGIVDN9a8Vjz9hVoNZhNUyIjEGjVNLwoMdhcZ1B/FLOoP7BkuabFaU03Rms5xN/pMifkkhmuyQ+Ap4u1ey7nr/tdpIBSyF09yQxTZFeRpk+q0W/Y+T0WLHbc9TIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L1mMlLB8; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L1mMlLB8"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-124899ee9d3so788721c88.0
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769703630; x=1770308430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOn+Bs0qoUGUzxsaUu2YGKwHvxmscu6j9iNcuCgMsM4=;
        b=L1mMlLB8xCwzeZpeKHkkBH6smX7+6helVTuSQ7qmRxi8GtnAprEhlUW0ci8HNWVFNd
         z7z83MPNMvDjeaCb1+cO1H0f1MXRZ6vu5Kx3EdPgQ7l39u+90vqOqWR0u8Yy9uNiKdhx
         QfDhO+GyfpplyoVD9ldqr5WKVAPDChBBko6UhEuk2ZSlo2e9idjOKo4VrNaeOcUaNzCM
         jyNY+S1Y8qgXjgcaqyuPwDDcApgV9LSazkz26Beg1Jx7l6La5dVzV94v9+dK+JsT/Gc6
         9zkP2+6GKx0B6GmzoQp0uor2QNZYq5aZJc0Ifk50S13NL8yM5xFErP3Y8HMLs2z+lU0o
         Bxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769703630; x=1770308430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOn+Bs0qoUGUzxsaUu2YGKwHvxmscu6j9iNcuCgMsM4=;
        b=U/ov9cD83DNcoCyFZiqbORM0Mcnmirs2nXP/3OsdMuQOU7iPNGFMJsPYoeMGynb6wE
         6C17w4xosF89lIF4491QWQLJCYVGOO5HWbMIRzix1WwUoPsK79UZ9orkdZzGZG2NJg4y
         Rba5ODya4pkBHJWrW2+tJJPL4fX1PvPtYvTYYhcxQIfqMfFzjmhtydxqFn1/azv87FLI
         yZKlRcYTbT75mng/OpgdLhV0hCMbUPp6qNmhjfkiOUiuwBbV3/mJ8PmDusPbSuR3emwE
         J6Z1Zehp0XViBWxs0Bz7sEm6rTmo/kSpLmOodgqJi4oH5RRUfLrjXpQrZLq9vQZOEUju
         AmUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUy4i3RIXFn8Cu2m4kN84o0uI7qONlBweOzRiUWZuuwghcQFiE3HovDU2paviuvXCtFTpksR+QcOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YMv2dzjALpGQ3xbEUm1grkQ9wzd2i6rRotj/hgFLHk/fxT6w
	y28gdohxEwbgcNB8xvPTsQj4Y3gNkvzrNMu4ivyYqlTtlLuKgoN2ylKvQGzIOx2yn3E=
X-Gm-Gg: AZuq6aJHRkUo3udGwx+KuSgmk3MIpIICrMB9tJR9Gh9iTPo5MTc/w7IuFz1TC4d0OAB
	XcPfTc7h6wvZCuH6Gx2YH7fJ2zMJmiitiXfrd6GM/5+4h4fcUAjieDZ0vASLZxRluKzQhJ+x3r2
	X1OKqqnAFg483AKldZT5gMA2cx5d4JGlaJMFfAsNxE/B7UwGvySVgArOEAbB2osoMT6ufn2p5zn
	VWLbYM7ulFCBIAdxDXOa0prKzTSap1Y7b12t/AZB2BNgYCGl2s8z17DTIvJgshl6M4l5eX7ir+B
	qO5HPEAmZkZ9XV607NYc1poIujdjN/VCyIn8NrGAuMZxx55PHyCm+jsv+B+9dxGcgFhLeyb4V2/
	yMAaI/SvRRuhPEeZSqOEOPx/yluSwAJS4U2IRrJCi5Sy4qR6v1uF7s7eKEIT0EgexGtN6IpSLc7
	fxRI4BDF/On9lGbjEsx9lIlUAzsMiFV/uC67zqeVTLYtrTcy2WYaF+kV+aX5aN
X-Received: by 2002:a05:7022:220d:b0:123:331f:978f with SMTP id a92af1059eb24-124b101ee64mr1698024c88.7.1769703629586;
        Thu, 29 Jan 2026 08:20:29 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:eca6:912e:45a4:4837? ([2600:8803:e7e4:500:eca6:912e:45a4:4837])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d6b663sm6740743c88.1.2026.01.29.08.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:20:29 -0800 (PST)
Message-ID: <5d2e85cd-caa2-43a6-a451-3b822bd0ef01@baylibre.com>
Date: Thu, 29 Jan 2026 10:20:27 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4880 support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129152731.154368-1-antoniu.miclaus@analog.com>
 <20260129152731.154368-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260129152731.154368-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/26 9:27 AM, Antoniu Miclaus wrote:
> Add AD4880 dual-channel ADC to the AD4080 bindings. The AD4880 is a
> dual-channel variant with two independent ADC channels, each with its
> own SPI configuration interface.
> 
> For AD4880, the binding requires:
> - adi,aux-spi-cs property for secondary channel chip select
> - Two io-backends entries for each channel's data interface
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4080.yaml          | 49 ++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> index ccd6a0ac1539..3909e3095507 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> @@ -18,6 +18,9 @@ description: |
>    service a wide variety of precision, wide bandwidth data acquisition
>    applications.
>  
> +  The AD4880 is a dual-channel variant with two independent ADC channels,
> +  each with its own SPI configuration interface.
> +
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4080.pdf

Can we get a datasheet link?

>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
> @@ -31,10 +34,18 @@ properties:
>        - adi,ad4084
>        - adi,ad4086
>        - adi,ad4087
> +      - adi,ad4880
>  
>    reg:
>      maxItems: 1
>  
> +  adi,aux-spi-cs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Chip select for the auxiliary SPI interface used by multi-channel
> +      devices like AD4880. Each additional channel beyond the first requires
> +      its own SPI configuration interface on a separate chip select.
> +
>    spi-max-frequency:
>      description: Configuration of the SPI bus.
>      maximum: 50000000
> @@ -57,7 +68,8 @@ properties:
>    vrefin-supply: true
>  
>    io-backends:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    adi,lvds-cnv-enable:
>      description: Enable the LVDS signal type on the CNV pin. Default is CMOS.
> @@ -78,6 +90,23 @@ required:
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
> +        io-backends:
> +          minItems: 2
> +      required:
> +        - adi,aux-spi-cs
> +    else:
> +      properties:
> +        io-backends:
> +          maxItems: 1
> +
>  additionalProperties: false
>  
>  examples:
> @@ -98,4 +127,22 @@ examples:
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
> +          reg = <0>;
> +          adi,aux-spi-cs = <1>;

We can already have multiple reg for a multiple CS device.

             reg = <0>, <1>;

So we shouldn't need a new adi,aux-spi-cs property for that.

> +          spi-max-frequency = <10000000>;
> +          vdd33-supply = <&vdd33>;
> +          vddldo-supply = <&vddldo>;
> +          vrefin-supply = <&vrefin>;
> +          clocks = <&cnv>;
> +          clock-names = "cnv";
> +          io-backends = <&iio_backend_cha>, <&iio_backend_chb>;
> +        };
> +    };
>  ...

