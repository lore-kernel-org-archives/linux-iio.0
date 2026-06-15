Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973E30276A
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498434; cv=none; b=CGuRGShqY/kPt69by8nZ4JrEhxmdcieaKhOARUh8sUZuY8cmmTtvttsfEmrcDdNhTsn/5Ey+MZzcXFQJIt9OF+tZ3QBKdUiihO7GXM672fVBoevfKaAA0wtR8h8Bz3y+1vwqBCqT2v2FHuAZiegNAtHttGVkzD9Anyv0OkmeNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498434; c=relaxed/simple;
	bh=7duavQ222Pjg3G2ZNfIGpmYS3Gzto3uKYx0OaVsfd2U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BQ+J4aVlvRHVIN16f2zg/C/z2L5WJ15RFeVNeiyB/EKg1PxiJBNTpZT1VleJheZsF0hXCzVpF850kp4qYCQdT2BLc8Y0QuSNJ3lyk1fDIFYiAjD+OZFO1h6HAPiL0s9tgHK9wbK/ONz26xQK6Gw4YLyKNiVpDqaxB23zdOMC1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSq7aa6D; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSq7aa6D"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6cfb0a137c9so1712571137.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 21:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781498433; x=1782103233; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGB285QQfzjMEZKVcQE1jA6+Ydb7tIVKdW6CKVeUVnE=;
        b=LSq7aa6Dh2KBSg+dICMeTnDHu0bQLvd3xq9k1Qymi6uAThcYmwaRZ0f+QdYUcA8SzJ
         qoFdXyEB3k+unvb549Z+OaP+6B1xf/Xdhjl5kggib3Wrt+tmbic5RdHX42Uad/ZXmA3D
         4IrGO+wSRNziabpHgLdmoj2qZ5HJRFEXtlc39zp0tgHK0cNDS2G0fKEeH7sjthumrxpr
         WNvA/GiT3RMUgI5/35X1R1/SjSFca9yN1uTG0wOiijJq1TOSeyjAKz6+PQbBx97tXKS3
         qZZXizJ6ejUAC+f8OSTRLpBcwzKK7u0dmOQbkerNfcZ5A6EZJ+e54W/I5bAT4HGU0vsk
         3ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781498433; x=1782103233;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGB285QQfzjMEZKVcQE1jA6+Ydb7tIVKdW6CKVeUVnE=;
        b=Q0UF3g0BipF3KZOoeF6XUNOhrRqxSLDvxiZj0Lz723OH/pS9MtzpfdBAuGyMXHW9jx
         3uisFgxlfnm5cpMHuGAjSVeBgZgyTWpHbu93v54T76zED7j4DrSI/rcVSqregm8bEmbb
         WoNabZjOrgbrA/Ras7dNselInDn7dLsmB2V4pYcgDMJhCLEQRR3jl5kcO6DKWkSp5vjz
         5nBiMdBy7wQr+j7PNpblX0MH/00KEdkIabgCMKyIAFHzIImmqdpSvr62VY12fsGQ3cki
         j502UdrO8o53HMdrWY9D46VK67/q0XZW/pUupsFkVuh6FINfVNyIBjh7aH5213ghRhHH
         NB0g==
X-Forwarded-Encrypted: i=1; AFNElJ+SXfApZ2n1cE+R9ggS9ZhFULZK7/ghEzshz4p+gaOxx3p1N+mbBFkuot+X/b5U+xN8Nv1ZYsC9M2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXG/1OQu4cMnratLkXtHhXiulZwd3MSm8wiDWUGKfivMWyG63h
	AQpNCRmXA4YWtDBzJqCl6ahV9ZWudhbroFKIBdSl88ZayiP0lebiO2uB
X-Gm-Gg: Acq92OF2rOr8B3MMrjuVBxRDpTslxcYB2k08WxxPIQvL9YPFPk5ZvKG2n2+ZoBTXHwv
	w3YTSknSFbnIF7mSzWy3HuletAwWOLPXy+wjNpumRXAisxTXTSIYTINKE+2HtJEHukrW5ZCD2j/
	LanONMlAzS1UWHqIocEJ3cjAg8Ww4a43TkXotnF/yr9iPjF5DF9bNySRsWl51Wk/Y4gpvq/T3po
	T7xgcIZtR2N0jSOXJScnilf+ULQaTcRTbT0+PxxTmYcOzxw8S4r6x1iR16k6RWYFfdqlmzZJEll
	dxI+h4ldKHNilibD/EFhOnhBFXNBXzt+3EM9m3Z+n2JaMPbIz9oFBBN9IBBFPB+zSjaFJER7MEC
	Hmj3+q2pUHX3lrQTUirJlc+GNixo+ZVkJacpINOYLgAFp3ojsObB+oR7ISXu19AsrCSlb2I1i4E
	2Ch0FezwQ/bOIm1A==
X-Received: by 2002:a05:6102:4243:b0:633:d7ec:153c with SMTP id ada2fe7eead31-71f5e0f9832mr4264466137.3.1781498432649;
        Sun, 14 Jun 2026 21:40:32 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7208788587esm1915399137.10.2026.06.14.21.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 21:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 23:40:25 -0500
Message-Id: <DJ9CHIBMQDFE.19RJYS0VV5N6A@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: Add TI ADS126x ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-1-894c788d03ed@gmail.com>
 <20260613-loyal-azure-goldfish-cf6d54@quoll>
 <DJ92JT0CPSXJ.1113K3KLSRHH4@gmail.com>
 <73d85fad-d39a-4c34-90c2-819998656f7a@kernel.org>
In-Reply-To: <73d85fad-d39a-4c34-90c2-819998656f7a@kernel.org>

On Sun Jun 14, 2026 at 11:34 PM -05, Krzysztof Kozlowski wrote:
> On 14/06/2026 22:53, Kurt Borja wrote:
>> Hi Krzysztof,
>>=20
>> On Sat Jun 13, 2026 at 1:54 PM -05, Krzysztof Kozlowski wrote:
>>> On Fri, Jun 12, 2026 at 05:46:19PM -0500, Kurt Borja wrote:
>>>> +  ti,neg-refmux:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: |
>>>> +      Selects the negative voltage reference input:
>>>> +      0: Internal 2.5 V reference
>>>> +      1: AIN1 pin
>>>> +      2: AIN3 pin
>>>> +      3: AIN5 pin
>>>> +      4: AVSS pin
>>>> +    minimum: 0
>>>> +    maximum: 4
>>>> +    default: 0
>>>> +
>>>> +  ti,vbias:
>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>> +    description: Enables the level-shift voltage on the AINCOM pin.
>>>> +    default: false
>>>
>>> There is no such syntax, drop.
>>=20
>> The "default: false" syntax? Sure I'll drop.
>>=20
>>>
>>>> +
>>>> +  ti,idac1-pin:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: |
>>>> +      Selects the analog input pin to connect IDAC1:
>>>> +      0: AIN0
>>>> +      1: AIN1
>>>> +      2: AIN2
>>>> +      3: AIN3
>>>> +      4: AIN4
>>>> +      5: AIN5
>>>> +      6: AIN6
>>>> +      7: AIN7
>>>> +      8: AIN8
>>>> +      9: AIN9
>>>> +      10: AINCOM
>>>> +      11: No Connection
>>>> +    minimum: 0
>>>> +    maximum: 11
>>>> +    default: 11
>>>> +
>>>> +  ti,idac1-microamp:
>>>> +    description: Selects the current values of IDAC1.
>>>> +    enum: [0, 50, 100, 250, 500, 750, 1000, 1500, 2000, 2500, 3000]
>>>> +    default: 0
>>>> +
>>>> +  ti,idac2-pin:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: |
>>>> +      Selects the analog input pin to connect IDAC2:
>>>> +      0: AIN0
>>>> +      1: AIN1
>>>> +      2: AIN2
>>>> +      3: AIN3
>>>> +      4: AIN4
>>>> +      5: AIN5
>>>> +      6: AIN6
>>>> +      7: AIN7
>>>> +      8: AIN8
>>>> +      9: AIN9
>>>> +      10: AINCOM
>>>> +      11: No Connection
>>>> +    minimum: 0
>>>> +    maximum: 11
>>>> +    default: 11
>>>> +
>>>> +  ti,idac2-microamp:
>>>> +    description: Selects the current values of IDAC2.
>>>> +    enum: [0, 50, 100, 250, 500, 750, 1000, 1500, 2000, 2500, 3000]
>>>> +    default: 0
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  '#io-channel-cells':
>>>> +    const: 1
>>>> +
>>>> +  '#gpio-cells':
>>>> +    const: 2
>>>> +
>>>> +  gpio-controller: true
>>>> +
>>>> +  adc:
>>>> +    $ref: /schemas/iio/adc/ti,ads1263-adc2.yaml#
>>>
>>> Not a separate device node. Fold into the parent... or explain in
>>> commit msg. You have entire commit msg to explain odd things.
>>>
>>> In that binding description you call it "independent", so it should hav=
e
>>> its own SPI chip select? Why "independent" and part of this binding?
>>> Maybe not independent, so basically part of this device?
>>=20
>> It's independent in the sense that it is a proper subdevice on the same
>
> You cannot use DT syntax as argument why you use DT syntax like that.

I'm not saying subdevice in the DT sense, I'm saying subdevice in the
actual secondary ADC inside the chip sense.

>
>
>> chip. It shares the serial interface but operates completely in
>> parallel.
>
> How completely in parallel? If the interface is the same, then it does
> not operate in parallel. It's impossible.

It does conversions in parallel, communication is of course still
serial.

>
>>=20
>> I decided to add a subnode because other devices might request their
>> io-channels and most importantly a different voltage reference might be
>> connected to it.
>>=20
>> I'll clarify this in the commmit message on the next version. Although
>> after seeing this submitted bindings [1], I wonder if it's a better
>> approach to do something like
>>=20
>> 	spi@0 {
>> 		mydevice@0 {
>> 			...
>> 			adc@0 { ... };
>> 			adc@1 { ... };
>> 		};
>> 	};
>>=20
>> Any thoughts?
>
> Does not look like separate subnode. You still did not provide arguments
> why this is independent.

Well, there's not more arguments than this [1].

Anyway, I'll go for David's #io-channels-cells =3D <2> approach and drop
the subnode.

>
> Best regards,
> Krzysztof

[1] https://lore.kernel.org/linux-iio/DJ93WSYC3HTT.3NXQW390CLQ82@gmail.com/

--=20
Thanks,
 ~ Kurt
