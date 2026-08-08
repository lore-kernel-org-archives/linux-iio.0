Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676339F18A
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786214319; cv=none; b=QfsJjgTIr/onQTBl6MmHi+9Lw6HxeVDdMknnZKycUapcA98SLAov2imNZV3m491RkQfxFv4Wbxw4gcw7nhNIAdLbKs64VhIbSMLTbb8pq4RvjSB+rFjXpSnAv02fk2AyrQAa0WIqpf6CCsxWKRw2T1RPaLO/KhGtr02ZpywVwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786214319; c=relaxed/simple;
	bh=K2TOovoxyOuQXz0NUxhR+aOkqI/H40z4teyVi6PX3F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtluJtbLvTATZCCDHRF5lFUNzisvp7tPUPH1tyOubb2gsJvkZ3N/D2/7Xj3P2NfbXG1qwLFhdKgpJ0jeJ3dLAnNgHpvpKzB3pF1V7KrwkuVt1QiKwnXfsxCWP21q4vIMPp8RekLM8yJKYEfFvMD51rk7PRZnH1WAvUxVqVOCUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Eu/twQzC; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Eu/twQzC"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6ae9b721927so403378eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786214317; x=1786819117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BYohLP+0c4lv6k8Vs2Mp24gW1cAJvUuJNgonaHAKjlI=;
        b=Eu/twQzCrd6A23ES5ns+4/7Ns/rHO95wM3c9D/PpuV+C1EYQJSXmG+RINA0GzL+N/n
         FPmG7TwvIgjivH8fAdH+6RJXkAJdZe1iaQW2+We0aBurNIoMKKbh4JszK5yH6e+St+F+
         3tiQWPWVopOKCvyEcw0BPSNEk/pA5p8Z6ICP/emv0UVU0ojC6i6cfCMQZSYC4yA0ArUs
         AAunM3eLcdlTw6Hkkqm+q6y/bNcCzIvseRemHnTTunC++iz8p4e4wwCNpXEX7/m0Eool
         0KrP9yLS9vSenSu9rqABgc8YrxBIcbPdoTrzpFfi3NtrBSe9g9xfW98q12j3SdQaIlpW
         YhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786214317; x=1786819117;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BYohLP+0c4lv6k8Vs2Mp24gW1cAJvUuJNgonaHAKjlI=;
        b=e7n60Ydrgw4GE9nsJ6ieQX7D6ziBgPCxkstr0UWGcXUlEvIfqhi8T5dDtqCdCY1pvO
         bur0aPBsE2yCp0kYlFCnsON/nEhjvMVixK2+Yd/xzZu4z8MUWwhRhq6DvZ7vnKyy9LHd
         AJEOrc4VS74U2w/x/JmEbYzwvrAfXFUtAnHsECm5kR5vBWojCoz8No81hJp25+IM/TF2
         AKrCV0NDijPaMv4E7g1thKRnAn06fma6WzV+jbYbLagTrGH3kgT0aPJNuUKAQkuzaOb4
         iJpM85ndCnCuDmgyTpdX0zvrlLBiM0DFVG+ee98j5DgT7+OgW/ELpzdW6MPzka6D1ajN
         BZyw==
X-Forwarded-Encrypted: i=1; AHgh+Rqr9Cjbg8RwsNI/pR7z/kBxN9cZQwbgorHjTsFkoVCRZ7ayvkRbM7a+/M4dA0VxYi4tQf3on4yoogA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzifE5CLQoxWw9I+9g/zw9y9ZFTDJfJSm+hLb+H8AaAmsk81RuU
	5GRtYc3blRIUB4Itpm9gddQT5Zjp7uYS/0uP+1QHSoS8/uiDXyZDvdzooIEfhG4rE/Q=
X-Gm-Gg: AR+sD12cQkgb3a43vgQAOaPfcbj8DDpojzBsdV6KZA74fid0CJOCz0abFiR/YqSE1cx
	xCOkJXyjNl6jYV0C7GzNxGOIy0AMfWLmTkHzk4ffzXalq84kVsxf1hzTttuzuh1v3Y94jIz8FfC
	jC6TdIcaxdoQKk3P/DpGrRDUaWn4cMJNva7u75e3jD+fr81Z+0U8VpkXHgsgp13M9smj9cd22fH
	VoYaiHanYPM2AA/5sGiGzR330kHEke/we5OldfyyH+5kWo2B5TElFJUmvgEHDFuz3fx4rn9w0RD
	K28wWa7b8rdf/l1qV+PnntBCilxEZuN90vuYGm4SwNR+5WQJbhA7xZ+KieD6DSQcG6J1UturKCA
	Cv48I+WjsNQ8UU06E9LWzyVK8138sTJq9iHOO6VVDbYRCYSd0E0D7Xeu89EpEcz2Zqbc6RcTD8K
	K1mgef4NGpMpfzYfHBbH6wzbZBclH8f57+Y1eXv1OQUuOg5wcYuYx7Cp+ChkrZ9iqgexViwXZca
	bjSBr6CRC7uEV7SS88cHmw0WUtBruoo3gYEArw=
X-Received: by 2002:a05:6820:c3c9:b0:6b0:5233:f69a with SMTP id 006d021491bc7-6b05233f906mr1653779eaf.30.1786214316792;
        Sat, 08 Aug 2026 11:38:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be9294fsm5236394eaf.13.2026.08.08.11.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 11:38:36 -0700 (PDT)
Message-ID: <c7faac0a-e3a5-42bf-8cc1-aee1370ef662@baylibre.com>
Date: Sat, 8 Aug 2026 13:38:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] dt-bindings: iio: adc: support the TI ADS126x ADC
 family
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-1-f89925d72792@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260807-ads126x-v3-1-f89925d72792@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 10:58 PM, Kurt Borja wrote:
> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
> integrated PGA, internal reference, excitation and burn-out current
> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
> 24-bit delta-sigma ADC (ADC2) for background measurements.
> 

...

> +patternProperties:
> +  "^ain([0-9]|com)-supply$":
> +    description:
> +      Common-mode voltage supply connected to AIN<N> or AINCOM.
> +
> +  "^refp[1-3]-supply$":
> +    description:
> +      Positive voltage reference connected to REFP1 (AIN0), REFP2 (AIN2) or
> +      REFP3 (AIN4). If not described, its assumed to be connected to ground
> +      (0V).

Would we really have a case with a negative only reference? I would say if not
described, assume the pin is free for other use.

> +
> +  "^refn[1-3]-supply$":
> +    description:
> +      Negative voltage reference connected to REFN1 (AIN1), REFN2 (AIN3) or
> +      REFN3 (AIN5). If not described, its assumed to be connected to ground
> +      (0V).

Assumption is only true when corresponding refp supply is described. Otherwise
we should assume the pin is free for other uses.

> +
> +  "^ti,refp[1-3]-refn[1-3]-resistor-ohms$":
> +    description:
> +      Magnitude of the external reference resistor connected between REFP<N>
> +      and REFN<M>. In ratiometric configurations, such as RTD measurements, the
> +      IDAC excitation current returns through this resistor, generating the
> +      reference voltage for the conversion.
> +
> +  "^channel@[0-9]+$":
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      single-channel:
> +        minimum: 0
> +        maximum: 10
> +
> +      common-mode-channel:
> +        minimum: 0
> +        maximum: 10
> +        default: 10
> +
> +      diff-channels:
> +        description: |
> +          In addition to the analog input pins 0 (AIN0) - 10 (AINCOM), there are
> +          special inputs that can be selected from the following values:
> +          11: Temperature sensor monitor
> +          12: Analog power supply monitor
> +          13: Digital power supply monitor
> +          14: TDAC test signal

For reasons mentioned in the reply to the cover letter, I'm not a fan of the
monitor channels here.

> +        items:
> +          minimum: 0
> +          maximum: 14
> +

...

> +      input-chopping: true
> +
> +      ti,idac-rotation:

Should we make this one a standard property like input-chopping?

> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Automatically swap the IDAC1 and IDAC2 connections of alternate
> +          conversions. The ADC averages the alternate conversions to eliminate
> +          IDAC mismatch.
> +

...

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads1262";
> +            reg = <0>;
> +            spi-max-frequency = <8000000>;
> +            spi-cpha;
> +            avdd-supply = <&avdd>;
> +            dvdd-supply = <&dvdd>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "drdy";
> +
> +            /* Typical common mode voltage configuration */
> +            aincom-supply = <&ads1262_vbias>;
> +
> +            regulators {
> +                ads1262_vbias: vbias {
> +                    regulator-name = "vbias";

The node name is already "vbias" so giving regulator-name is redundant.

> +                };
> +            };
> +
> +            channel@0 {
> +                reg = <0>;
> +                single-channel = <0>;
> +                /* The VBIAS is enabled on pin 10 (AINCOM) */
> +                common-mode-channel = <10>;
> +            };
> +        };
> +    };
> +
