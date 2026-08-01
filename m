Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35139368D41
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605450; cv=none; b=TLpc0YNA7JafE7eDFAIXTzQ3n7HD6GhFIufdwxVn41pOZATUw7saBoEoHWTW1zhaKuizDqDsJtAVGXQs9gRxsnD/pqHvc0c4VbIAA3RkPOT+Tld7w3dEoo9/ZsZcBSYBYk9YMZTM4lmIYRdWi9LpqX9PCnCUYNIHMcrXqVlkVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605450; c=relaxed/simple;
	bh=PltSu/sVA6TYR6Jx3qt79OpymfJ6HHMaUviftaN88AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzsVShdFSOuY2iCEm/HxZh5Zb15vhGxpVPqsjELPKnJDgItU7apn4FCaI4ICt73OFdoYe/SoUki7lurFI0aRifZAdNg6grSdilbqdgR94AtZW7c22oW2cdXr1Fbw76/iUnf4Snoge2XZNdxcSV8fWiw3QZz0pkcnQZuuV/654UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AOkjh5OS; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AOkjh5OS"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6ab04bbcc11so618211eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785605446; x=1786210246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKfWZJAhPCXSe4r4r5GwzlxdXwfptY+Qsd20FWoEYvU=;
        b=AOkjh5OSMO4fcFSNAbcntt2yaVbXEcM0TbuUFl9QD8xV11OYTVdopq8RHBVLUiAXoJ
         ECSyxlvxfOw0ocWyzRsnijjuR/esOuinC+JeShmE0wbQhaicb98OqA3TNbH/rtgMZlj8
         RJW/iAM/ar0XvR6X6KlJN8kom6OUYKMGONueA+HpT7mA2Cd23EUAP+TRJaKUMHs08R0M
         yzodc4KkaXCgjQXCRyXHOn010kEE07NBA6X4IOxiNUXlLNfri2r4bGKw/b+ja/A5ZgBM
         ifPJuvX/pALQwy4+53Pqc2QWCjQtKBU4kTG+ABR4Ih2bU2eTHycMe40SyrUypexm38Cy
         gH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785605446; x=1786210246;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKfWZJAhPCXSe4r4r5GwzlxdXwfptY+Qsd20FWoEYvU=;
        b=PkZWXdAr0frF6AaHavAeOav+FPnzD42WRdxXITsZRUyXUgHur2mUPSziTHM75rdKBG
         bfZr/YYOdXT8ZlBL/V7JaqkXlDAMCYkjYmttGvXpehQQuWNv0QoMmFBfmgKrl3WoM2gJ
         2lYF8/BplMPZDNj/ACk515Ld5ce1dhWvSIcoKWAHoWGteAHwCkVS9t4DI6yotCzPbZbU
         gWqwKNRT9WkKu6jNk4MrhN5MhWA16RvGiFruX+7hkWdiTX647eZWxJP7wG1LBzu4hRyB
         RpqWbVqhQzTH8nuBPFZhqNjbnBt2SaT4YKAaX+fjcfLKZM2HVerZpAR1NwB89oLD5HxR
         PHjg==
X-Gm-Message-State: AOJu0YyYceLiEGlPBb7ub5Xj14mWmKA7JHsesRvxg0g4fAa00Fs4622u
	DxiY83cQowJ2RXDTjmPuMqCiRxNuuMmJMNdQKYpSZ/CzeDP1oGBvzu0S2555/cHSNKc=
X-Gm-Gg: AR+sD11WtSliZN6SXhSO3IB3fM2E7HmoWMgAqzWVy40AYLjME0mEs8+NyrDfK0vdnBi
	ROJ+XxQU+gBmWSNQTN7q0BkLDp8vgO/IZr3bUrukGypeT7XiHxH2vyuAzCwq6ujt5Q0CTr33/rd
	CN6fXECUSy9O3toDck6XuQemNHQKstriATFv37F4t1vT/WMoYjiU/5rzV/B3RzQ4g/IvzIyGKel
	/4ceojvfaSWfsfIoJrGWKF19crawdd8ueyW1yQvEwpQbIu6SAlbxilZG/MrhuEaZwAoFsHSjNmh
	7BJpQzMdHJYBWUTfhzfTqBvLPsj+WIpRCxPKVC7OA4iqz5BtfIFir3YWqgqe5XlBg8O3DTzcJzv
	cqThghKn8theyArBzxDZ3d/wBPCqEAn0Jg0Pu1oq9tYZj2iRQwXC9rggaX2woj4EIkCXnW2m9qK
	UIvuvu2VjDv+dkSN61mWD6RxW84N7PBuU0nJX8aoD11fpiWaC6HznLPDBiTbK+6fH8Vu5/9w9rU
	3qmqNAZZD221NY4yYv9OEXECp7j/FCFh4g80J0=
X-Received: by 2002:a4a:edc3:0:b0:6aa:e1f6:32c7 with SMTP id 006d021491bc7-6ae43201d81mr7470917eaf.13.1785605445905;
        Sat, 01 Aug 2026 10:30:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f60d63fasm4181757fac.5.2026.08.01.10.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 10:30:45 -0700 (PDT)
Message-ID: <a869acd6-9c77-4495-a581-232ca88ac9e2@baylibre.com>
Date: Sat, 1 Aug 2026 12:30:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add support for PAC1711
To: Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
 <20260728-pac1711-v2-1-609bc026093c@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-pac1711-v2-1-609bc026093c@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 7:03 AM, Ariana Lazar wrote:
> This is the device tree schema for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitor with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1711.yaml        | 209 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 215 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..846e7801a1667c312c753ab8ee4d5637e258e2e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> @@ -0,0 +1,209 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1711.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1711 Power Monitors with Accumulator
> +
> +maintainers:
> +  - Ariana Lazar <ariana.lazar@microchip.com>
> +
> +description: |
> +  This device is part of the Microchip family of Power Monitors with Accumulator.
> +  Datasheet links:
> +  [PAC1711]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1711-Data-Sheet-DS20007058.pdf
> +  [PAC1721]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1721-Single-Channel-Power-Monitor-with-Accumulator-DS20007088.pdf
> +  [PAC1811]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1811-Data-Sheet-DS20007066.pdf
> +  [PAC1821]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1821-Data-Sheet-DS20007097.pdf
> +
> +  PAC1711, PAC1721, PAC1811 and PAC1821 are Single Channel Power Monitors
> +  with Accumulator, having 12-bit or 16-bit resolution. The devices PAC1711
> +  and PAC1811 can measure up to 42V Full-Scale Range, respectively 9V
> +  Full-Scale Range for PAC1721 and PAC1821.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1711
> +      - microchip,pac1721
> +      - microchip,pac1811
> +      - microchip,pac1821
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  interrupts:
> +    description:
> +      Could be triggered by overvoltage, undervoltage, overcurrent, overpower,
> +      undercurrent, step limit, accumulator overflow and accumulator count
> +      overflow.
> +    minItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - enum: [alert0, alert1]
> +
> +  microchip,gpio0-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Defines the function of the pin. This is a multifunction gpio digital I/O
> +      pin which can be configured as alert0 interrupt, GPIO digital input, GPIO
> +      digital output or slow. When functioning as SLOW pin pulling the pin high
> +      overrides the programmed sample rate and results in a sample rate of 8 sps
> +      (Slow mode).
> +    enum: [alert0, gpio0_input, gpio0_output, slow]
> +    default: gpio0_input
> +
> +  microchip,gpio1-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Defines the function of the pin. This is a multifunction gpio digital I/O
> +      pin which can be configured as alert1 interrupt, GPIO digital input, GPIO
> +      digital output or slow. When functioning as SLOW pin pulling the pin high
> +      overrides the programmed sample rate and results in a sample rate of 8 sps
> +      (Slow mode).
> +    enum: [alert1, gpio1_input, gpio1_output, slow]
> +    default: gpio1_input

Maybe I missed something in the previous discussions, but this
seems a bit too restrictive and also a bit redundant.

interrupt-names already tells us if A0 or A1 is used for /ALERT.

And why should we restrict GPIO usage to only input or output?
(Binding should have gpio-controller and #gpio-cells properties
for that too.)

It also isn't clear to me how the slow pin would be useful when
we can also program the sample mode to the same rate over I2C.
So maybe we should defer adding a binding for that until we have
an application that actually requires it.

And this is missing the possibility that the pins can be used
as a conversion trigger as well. Likely that would use a
trigger-sources binding, but as that isn't common, I would defer
adding that until we have a use case.

So I would just leave these properties out.

> +
> +  powerdown-gpios:
> +    description:
> +      Active low puts the device in power-down state. When the PWRDN pin is
> +      pulled high, measurement and accumulation will resume using the default
> +      register settings.
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value in micro Ohms of the shunt resistor connected between
> +      the VSENSEP and VSENSEN inputs, across which the current is measured.

It looks like all of the datasheets say VSENSE+ and VSENSE- rather than P, N.

> +      Value is needed to compute the scaling of the measured current.
> +
> +  label:
> +    description: Unique name to identify which device this is.
> +
> +  microchip,vbus-input-range-microvolt:
> +    description: |
> +      Specifies the voltage range in microvolts chosen for the voltage full
> +      scale range (FSR). The range should be set as <minimum, maximum> by
> +      hardware design and should not be changed during runtime.
> +
> +      The VBUS could be configured into the following full scale range:
> +        - for PAC1711 or PAC1811:
> +            - VBUS has unipolar 0V to 42V FSR (default)
> +            - VBUS has bipolar -42V to 42V FSR
> +            - VBUS has bipolar -21V to 21V FSR
> +        - for PAC1721 or PAC1821:
> +            - VBUS has unipolar 0V to 9V FSR (default)
> +            - VBUS has bipolar -9V to 9V FSR
> +            - VBUS has bipolar -4.5V to 4.5V FSR
> +
> +  microchip,vsense-input-range-microvolt:
> +    description: |
> +      Specifies the voltage range in microvolts chosen for the current full
> +      scale range (FSR). The current is calculated by dividing the vsense
> +      voltage by the value of the shunt resistor. The range should be set as
> +      <minimum, maximum> by hardware design and it should not be changed during
> +      runtime.
> +
> +      The VSENSE could be configured into the following full scale range:
> +        - VSENSE has unipolar 0 mV to 100 mV FSR (default)
> +        - VSENSE has bipolar -100 mV to 100 mV FSR
> +        - VSENSE has bipolar -50 mV to 50 mV FSR
> +    oneOf:
> +      - items:
> +          - const: 0
> +          - const: 100000
> +      - items:
> +          - const: -100000
> +          - const: 100000
> +      - items:
> +          - const: -50000
> +          - const: 50000
> +
> +  microchip,accumulation-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      The Hardware Accumulator may be used to accumulate VPOWER or VSENSE values
> +      for any channel. By setting the accumulator for a channel to accumulate
> +      the VPOWER values gives a measure of accumulated power over a time period,
> +      which is equivalent to energy. Setting the accumulator for a channel to
> +      accumulate VSENSE values gives a measure of accumulated current, which is
> +      equivalent to charge.
> +
> +      The Hardware Accumulator could be configured as:
> +       "vpower" - Accumulator accumulates VPOWER (energy)
> +       "vsense" - Accumulator accumulates VSENSE (Coulomb Counter)
> +    enum: [vpower, vsense]
> +    default: vpower

Why does this one have to be a DT property? Can it not be switched
at runtime to accumulate one or the other at different times?

Also datahseet says it can accumulate vbus measurements.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - shunt-resistor-micro-ohms
> +
