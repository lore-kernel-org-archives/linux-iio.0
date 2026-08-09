Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22473A7F60
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264000; cv=none; b=KmK7Mq7ze/16voAxgRsdZcF3MMbRaW2dTB3ThWWBy4H3pZu/DjZ7UbXuSEEBugEzUY9EZtCL46sEFOqJ6AbOYXcHx2K5AA04npcEKKtJnRfdY+ElZG858+3RVFnT9wfzVLhBK/DOcVRj40r00BIKnh1BFTEW4FSZKuOvEgfc6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264000; c=relaxed/simple;
	bh=t0JDNj9mERyDG8GojcBw/UvrNqGcmnYmtqSdBqzS86s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=ivt/u/CbhD2XcCZNaD0/1GMIA4LFxzhx7OxJEYlSJk8JrSiqQu4eoHzxGClZsvxzyTGcexpfLtDTy2pzW8zm3fw/tHkl7XZcCCEcT2J3Qhl/jEBHI1TCEgZKiC1Zf7oqq6U7D+sXYzAG4l8qSLv0E/Ks2eCxYeflVd4cyz0idfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erWkiBdE; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erWkiBdE"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97017a60b06so113311241.2
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786263997; x=1786868797; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ahfqHlld29daSD5k+fkfkkNtfM5Y9Y/mUH1o32pzzv4=;
        b=erWkiBdEbdmiMRXMLUxuxMD+4FnFwnKbqOfJSSYkd7x6hX3/7G5M6bysM8wSGWVXVc
         sd67fAKdjlS7E6lhe6KQ6NI1rKkpdho+p0ehVpYTGXiHFYQpI50alKWYPlpSw/0parWm
         Lx+4iJJM2vl5QWv5gAGW6p03GoGSY4MCzfJA8pDheVrp6RrDwNG7RwrMZMjV5FW5XmYN
         LxXLMXc1IpV/DeIk0jrND3ybHC0O51hckQFHgDNcO7nQoci/U4A6oEdPhYVRCnJH8d7X
         UQ+dDEF/eToCbi7xTJakiFD6+JWdwIxMbp7C97jL0l0mzYFQy1hArX9UYZouRRdZttRc
         v+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786263997; x=1786868797;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahfqHlld29daSD5k+fkfkkNtfM5Y9Y/mUH1o32pzzv4=;
        b=j1UTzUMJBKWWGQPRSDEDpgb3lr6awgixHcTT5T7ugLrsQb7hKZIHUBJjqRt/Fx0R29
         4DCkcEQ7x5NpFlxUXMjfnU6gD3uVXM94BModf4/p/F096Zsq+UrqsDfqQiPVhD3zhy3/
         grmH15NreSW/jdx4zuDe+8VCXtO78LhyLLQZADf7aUSrzkvq2+M10ygiQOssPRPn1bmo
         mDdL757QTkBd9cX/axrzu0HgmlirUgv6QIHO26BrxL/h31HDG5HV5Z5sj488omO8izok
         einPRRekahf27EUMcB0J5uoFexCz4Hz/jRL6H9XD93IX1OdaYc0VukqTYoDeJr+VMbRf
         8hkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoY95IZDI0ZNECQApQbwTPMEp4JS17bK1waHXHP0FHs89xrV4BcXdqcPupC9wrsEPXeZC7N/zVr9Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/dWfeYcgKutxCLapJyne4g2M1VxfZIkk439IPCFvj0GjUCSe
	SbNY1HRxxwzwKC9DlCwBkEYgKWtL0gRoGrZfuZXqVvffIordKNvoZ08M
X-Gm-Gg: AR+sD11NI5hCRu0ShBjD34bf2+54VcX0fDstg+7phw2r/tD5SE52O0IScLCewsLlJuN
	cEv1V1iK6JHkUxuNxASZLWYT4DdmSVmJU3HC3QRRH8maFhOApknqoRhjdVbkavKwDFI93vtrVyl
	0iZ+MlnOyxnMkTS6o9jEJG9QX1NENxsM8m6dQoZr3mj3n3fhwDq5n/EBLHAW9z98JRcNsyRzpR7
	rg2fygjLu1nSC4qEJ2zj5yDshcWVP+5dP9olGISoOZd+xARi58jYMmOrEtyuSO1L8dWiIPG7x8m
	m4ml5kbacW1/YN6qjS9A8gFXVR5PCI3FFLPgdwG+Ef75SFwl08SdUqw/NbrHkqTgx306ej1/CHZ
	/wW1WgVSh2XXHQ1fvCHgCCFyov/ydDbBNArXCVj3w/BOfZdzaygc9BcTpYPgJWNx/915ahxeVY/
	+vrY+gdlcN/qzZVCCqxnZL/4ZtLwbV0uRtN9GPVlVciU4lMi2G3Og=
X-Received: by 2002:a05:6102:3e87:b0:738:9abd:9eba with SMTP id ada2fe7eead31-760e77ea7f5mr8084364137.4.1786263997382;
        Sun, 09 Aug 2026 01:26:37 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-979f2eac14fsm2391114241.7.2026.08.09.01.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 01:26:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 03:26:29 -0500
Message-Id: <DKK9QKE0OYZA.3BCNK78VTHNYN@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-1-f89925d72792@gmail.com>
 <c7faac0a-e3a5-42bf-8cc1-aee1370ef662@baylibre.com>
In-Reply-To: <c7faac0a-e3a5-42bf-8cc1-aee1370ef662@baylibre.com>

On Sat Aug 8, 2026 at 1:38 PM -05, David Lechner wrote:
> On 8/7/26 10:58 PM, Kurt Borja wrote:
>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>> integrated PGA, internal reference, excitation and burn-out current
>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>=20
>
> ...
>
>> +patternProperties:
>> +  "^ain([0-9]|com)-supply$":
>> +    description:
>> +      Common-mode voltage supply connected to AIN<N> or AINCOM.
>> +
>> +  "^refp[1-3]-supply$":
>> +    description:
>> +      Positive voltage reference connected to REFP1 (AIN0), REFP2 (AIN2=
) or
>> +      REFP3 (AIN4). If not described, its assumed to be connected to gr=
ound
>> +      (0V).
>
> Would we really have a case with a negative only reference? I would say i=
f not
> described, assume the pin is free for other use.

In bipolar supply configurations, I believe it would make sense to wire
the negative reference to -2.5V and ground the positive. Also we have
the ti,reference-reversal case, where you may wire the "negative"
reference to say 2.5V and the positive to ground.

>
>> +
>> +  "^refn[1-3]-supply$":
>> +    description:
>> +      Negative voltage reference connected to REFN1 (AIN1), REFN2 (AIN3=
) or
>> +      REFN3 (AIN5). If not described, its assumed to be connected to gr=
ound
>> +      (0V).
>
> Assumption is only true when corresponding refp supply is described. Othe=
rwise
> we should assume the pin is free for other uses.

I'll clarify it.

>
>> +
>> +  "^ti,refp[1-3]-refn[1-3]-resistor-ohms$":
>> +    description:
>> +      Magnitude of the external reference resistor connected between RE=
FP<N>
>> +      and REFN<M>. In ratiometric configurations, such as RTD measureme=
nts, the
>> +      IDAC excitation current returns through this resistor, generating=
 the
>> +      reference voltage for the conversion.
>> +
>> +  "^channel@[0-9]+$":
>> +    $ref: /schemas/iio/adc/adc.yaml#
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        maxItems: 1
>> +
>> +      single-channel:
>> +        minimum: 0
>> +        maximum: 10
>> +
>> +      common-mode-channel:
>> +        minimum: 0
>> +        maximum: 10
>> +        default: 10
>> +
>> +      diff-channels:
>> +        description: |
>> +          In addition to the analog input pins 0 (AIN0) - 10 (AINCOM), =
there are
>> +          special inputs that can be selected from the following values=
:
>> +          11: Temperature sensor monitor
>> +          12: Analog power supply monitor
>> +          13: Digital power supply monitor
>> +          14: TDAC test signal
>
> For reasons mentioned in the reply to the cover letter, I'm not a fan of =
the
> monitor channels here.
>
>> +        items:
>> +          minimum: 0
>> +          maximum: 14
>> +
>
> ...
>
>> +      input-chopping: true
>> +
>> +      ti,idac-rotation:
>
> Should we make this one a standard property like input-chopping?

Maybe excitation-current-chopping or excitation-channel-chopping?

>
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description:
>> +          Automatically swap the IDAC1 and IDAC2 connections of alterna=
te
>> +          conversions. The ADC averages the alternate conversions to el=
iminate
>> +          IDAC mismatch.
>> +
>
> ...
>
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    spi {
>> +        #address-cells =3D <1>;
>> +        #size-cells =3D <0>;
>> +
>> +        adc@0 {
>> +            compatible =3D "ti,ads1262";
>> +            reg =3D <0>;
>> +            spi-max-frequency =3D <8000000>;
>> +            spi-cpha;
>> +            avdd-supply =3D <&avdd>;
>> +            dvdd-supply =3D <&dvdd>;
>> +            #address-cells =3D <1>;
>> +            #size-cells =3D <0>;
>> +
>> +            interrupts-extended =3D <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
>> +            interrupt-names =3D "drdy";
>> +
>> +            /* Typical common mode voltage configuration */
>> +            aincom-supply =3D <&ads1262_vbias>;
>> +
>> +            regulators {
>> +                ads1262_vbias: vbias {
>> +                    regulator-name =3D "vbias";
>
> The node name is already "vbias" so giving regulator-name is redundant.

Is it okay to leave it empty?

    ads1262_vbias: vbias { };

>
>> +                };
>> +            };
>> +
>> +            channel@0 {
>> +                reg =3D <0>;
>> +                single-channel =3D <0>;
>> +                /* The VBIAS is enabled on pin 10 (AINCOM) */
>> +                common-mode-channel =3D <10>;
>> +            };
>> +        };
>> +    };
>> +

--=20
Thanks,
 ~ Kurt
