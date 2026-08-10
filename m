Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEA3E3159
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380183; cv=none; b=Hs4Muipq+qEqH2eKrft8QtZX/W6w9l+7IP6mRDMJmXZ4xaD23P101UtxgtzB6XkItR/55LbKTC0q8qKV076qPCJAoDY0YEwnkIVCbellyghhZ0GYJk1fUp9BeQZVWLlF4hgr/OQSc98PwyIniqWSL60QRqeKre512Lipy740U20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380183; c=relaxed/simple;
	bh=qswzUvLeWzD1ypEyusL4JpuvZviHdsdZlDLSs8pxD1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xgff7d24Xc03eJ4win6nps3Q4pm8DQE3D1PtjNBPL7pPi1gsY0CsjDi/6Wu2Td4VSft8dr3HISymmjQwqrAaZ39VXQPQavHrp6lH44PiGnr8UW9CFUrc9HBdXPFIzd6Cy5uMCht3yRdSw4n0QsiRwd2iEf8pfxXJFrlCINzv7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aeA02L7E; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aeA02L7E"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ee4399c423so1267805a34.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786380176; x=1786984976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SF0UuKcYo2PEY9aDv0M4yYRYVyTu0AJ1rxJHPH4mQVc=;
        b=aeA02L7EvQN2bdibNcN4KqlRuYCVq3wgwHOuuGnrz3J88LwnPay54FF6zkDqA8eYh0
         vbdOWfTmIz1bdwNJZIcobwTZL6Ql+ZUHtualTsqAn8+xogfK7TGHz3M1us6GxZHj1QFZ
         nVBE56zEGKRnbmSBmKV/995cThNOVPc/bdBr0iA+FhYJsVGyAXVldam5GqXwSNrkLoHz
         IFVDnqo1riis/fMhbkNF2u2Oq9ibNtCow9yaCBwB02+jlKLVxgiFUHBhBaojwl8KwyhS
         LakjXkjLSPLxmS1pEN9nJwIaFm+x/M/gjoOSFB4MeMyJK4KZ7KcPwdkdskKGQW0I4SlI
         Ju8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380176; x=1786984976;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SF0UuKcYo2PEY9aDv0M4yYRYVyTu0AJ1rxJHPH4mQVc=;
        b=cXqdqS5OIFRFr3PVYCdp3t8Z90ASoe1fx/Lu0a1kVXgf+lNRzlOgMnV81id8MePylh
         3BbKm9/ijZd3V/xbtE1+2aeNCJWFyV5EMFsj1/mAI3j53gH8hzw2cSBMV/1rrBsTsz7G
         Npg70iOfJ6WSvCiIWfXpSl0/KxHo5JhyYFjtkblXnkyZUD6NbQ8dklrFpAX0Po2tgSLp
         /Gum6Hn96g4qKXMaJWVKjfZFny3b6JXLRs/CjLEOrKA64hK8yDYEhioKh7tcafS2Y41d
         ue0G8nNbqsqFH+vTZQUF74Dt7vBwgldnWEt3fpPHrZ7oVMGQzYzuXX7hdIxy0uGx+3t0
         7zuQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5zmXwfYKdbX1kLdFeHv848Kjmf85l7jkt7Z4w7jUeMak7A6THqOz8DIOAgZ6K8bepiAhIdVgnmKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1L1eh7D9qVkiSLQ6+a+MoxlqsON2NI7Qh9K1ACDqmHkWn4K71
	ZaSHiy3TJ/kbpl5IMI+vlLEmO3DS75IuvaTgZaV4XCCR9tLYdGKGHhAjawHFsoAHC9k=
X-Gm-Gg: AR+sD11s+u/0mGzy0GMOw7cJE7pzjFRlHCXJYnmWIxW2SXbIAsJIKoElrgAPVSFtRre
	0eonuE01oH9pN8lr4nBVW//U+V2mfzZQO9+E4eRacQk99+/IjIVX8iXCrshG/bcsat5DGa9rsIF
	CAaMaXePiGmHIniUCgQgOfhoisZXrqx0CRnHkIOaJJ0csp10lTlwALQo2py03T52c9z4LV7z0Te
	j+Jdx5riEzjBm3Rst5tDKbWnMxSaK7UmRzWd0UGJ7g6kjEFBfyDWeJNDMVb+y/ikoRO2XxnM2We
	+7nYkzZiwvUBkn7bmaEHhMuNRNr+rOkN64jEioYhQenBSOYPfwCXVY16IwGNnWjRZN3lfQ7HspH
	OEGlhvj/9+J39DUPrK3SFQvpLrNfmAb63RVfiq6vNDvJBNJRNp6HL44UiO9rCW0af8XsVyKvm9Y
	E/FsYAfjDrIGcBweUkViWtdWEzW/lfYBINpKiitUQAiZbA48jPERSeOib/re/K0BBA4nGdNLnuT
	i8B70LtA+JxBJ50O7cMkYkDagIWJZxvXk3A5So=
X-Received: by 2002:a05:6830:6605:b0:7e9:d634:77b8 with SMTP id 46e09a7af769-7f34dcf165fmr18922818a34.2.1786380176296;
        Mon, 10 Aug 2026 09:42:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e05b:7923:cf50:e4cf? ([2600:8803:e7e4:500:e05b:7923:cf50:e4cf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a836dsm7575949a34.12.2026.08.10.09.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 09:42:55 -0700 (PDT)
Message-ID: <c902cbe5-6435-4548-ae92-7399d8d48d62@baylibre.com>
Date: Mon, 10 Aug 2026 11:42:54 -0500
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
 <c7faac0a-e3a5-42bf-8cc1-aee1370ef662@baylibre.com>
 <DKK9QKE0OYZA.3BCNK78VTHNYN@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DKK9QKE0OYZA.3BCNK78VTHNYN@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 3:26 AM, Kurt Borja wrote:
> On Sat Aug 8, 2026 at 1:38 PM -05, David Lechner wrote:
>> On 8/7/26 10:58 PM, Kurt Borja wrote:
>>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>>> integrated PGA, internal reference, excitation and burn-out current
>>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
>>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>>
>>
>> ...
>>
>>> +patternProperties:
>>> +  "^ain([0-9]|com)-supply$":
>>> +    description:
>>> +      Common-mode voltage supply connected to AIN<N> or AINCOM.
>>> +
>>> +  "^refp[1-3]-supply$":
>>> +    description:
>>> +      Positive voltage reference connected to REFP1 (AIN0), REFP2 (AIN2) or
>>> +      REFP3 (AIN4). If not described, its assumed to be connected to ground
>>> +      (0V).
>>
>> Would we really have a case with a negative only reference? I would say if not
>> described, assume the pin is free for other use.
> 
> In bipolar supply configurations, I believe it would make sense to wire
> the negative reference to -2.5V and ground the positive. Also we have
> the ti,reference-reversal case, where you may wire the "negative"
> reference to say 2.5V and the positive to ground.
> 

OK. I guess the better wording for both of these would be that if any
channel references one of these in reference-sources and it is not present
assume it is connected to ground (0V).

>>
>>> +
>>> +  "^refn[1-3]-supply$":
>>> +    description:
>>> +      Negative voltage reference connected to REFN1 (AIN1), REFN2 (AIN3) or
>>> +      REFN3 (AIN5). If not described, its assumed to be connected to ground
>>> +      (0V).
>>
>> Assumption is only true when corresponding refp supply is described. Otherwise
>> we should assume the pin is free for other uses.
> 
> I'll clarify it.
> 
>>
>>> +
>>> +  "^ti,refp[1-3]-refn[1-3]-resistor-ohms$":
>>> +    description:
>>> +      Magnitude of the external reference resistor connected between REFP<N>
>>> +      and REFN<M>. In ratiometric configurations, such as RTD measurements, the
>>> +      IDAC excitation current returns through this resistor, generating the
>>> +      reference voltage for the conversion.
>>> +
>>> +  "^channel@[0-9]+$":
>>> +    $ref: /schemas/iio/adc/adc.yaml#
>>> +    unevaluatedProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        maxItems: 1
>>> +
>>> +      single-channel:
>>> +        minimum: 0
>>> +        maximum: 10
>>> +
>>> +      common-mode-channel:
>>> +        minimum: 0
>>> +        maximum: 10
>>> +        default: 10
>>> +
>>> +      diff-channels:
>>> +        description: |
>>> +          In addition to the analog input pins 0 (AIN0) - 10 (AINCOM), there are
>>> +          special inputs that can be selected from the following values:
>>> +          11: Temperature sensor monitor
>>> +          12: Analog power supply monitor
>>> +          13: Digital power supply monitor
>>> +          14: TDAC test signal
>>
>> For reasons mentioned in the reply to the cover letter, I'm not a fan of the
>> monitor channels here.
>>
>>> +        items:
>>> +          minimum: 0
>>> +          maximum: 14
>>> +
>>
>> ...
>>
>>> +      input-chopping: true
>>> +
>>> +      ti,idac-rotation:
>>
>> Should we make this one a standard property like input-chopping?
> 
> Maybe excitation-current-chopping or excitation-channel-chopping?

I suppose. All of the TI literature seems to call it "rotation" rather
than "chopping", but I did find a few other sources that call it
"chopping" and that would be consistent with input-chopping.

I would go with excitation-channel-chopping since we are swapping
the current generators, not just the current magnitude.

> 
>>
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +        description:
>>> +          Automatically swap the IDAC1 and IDAC2 connections of alternate
>>> +          conversions. The ADC averages the alternate conversions to eliminate
>>> +          IDAC mismatch.
>>> +
>>
>> ...
>>
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        adc@0 {
>>> +            compatible = "ti,ads1262";
>>> +            reg = <0>;
>>> +            spi-max-frequency = <8000000>;
>>> +            spi-cpha;
>>> +            avdd-supply = <&avdd>;
>>> +            dvdd-supply = <&dvdd>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +
>>> +            interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
>>> +            interrupt-names = "drdy";
>>> +
>>> +            /* Typical common mode voltage configuration */
>>> +            aincom-supply = <&ads1262_vbias>;
>>> +
>>> +            regulators {
>>> +                ads1262_vbias: vbias {
>>> +                    regulator-name = "vbias";
>>
>> The node name is already "vbias" so giving regulator-name is redundant.
> 
> Is it okay to leave it empty?
> 
>     ads1262_vbias: vbias { };
> 

Yes. (Unless make dt_binding_check says otherwise.)

>>
>>> +                };
>>> +            };
>>> +
>>> +            channel@0 {
>>> +                reg = <0>;
>>> +                single-channel = <0>;
>>> +                /* The VBIAS is enabled on pin 10 (AINCOM) */
>>> +                common-mode-channel = <10>;
>>> +            };
>>> +        };
>>> +    };
>>> +
> 

