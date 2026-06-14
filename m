Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E9E326923
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470398; cv=none; b=KUF/KMKJw4SsS1Gj1kWoF621ZwCL2N88bt9e/ad5gUSlcsfdwO4fss/3nCHbTvPb4HTDm+iXYNT7CE0T3KvoS6YeAxIRhYTkqYmi0jThuRZuqQvnmXnc196hiZNRoODy/stuWR/ZY8OhjueMGm3Iwka5iy/Cl44bObWSRygD9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470398; c=relaxed/simple;
	bh=nSDzCXKT3jQnRAcphUHmXusud9gWL+o/NpnAWujBRdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xy/j0VgEVI6G6sDKjaVHQKpeuWvwljgNTxkjyIGA/aE71TMu5sNL7lKhLQoniAGok3pCD5BFUhodk2ZoZyLCHU3PJQdUHJRkKt0y69OFf3WKWO43hw3HMqQ4n6PlE1quM8hvxPZ4TWwhuu8rj56Xr1kc7taPsYP9sjR4y4KPBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxnSti5g; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxnSti5g"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59cd803792aso1827082e0c.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781470396; x=1782075196; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhzWVFBovbUbRqI9wqfpVReAjsX1CU4k99CUksmW2lE=;
        b=pxnSti5gBAr0tPxM+BI89Ue/9l3vE08b2Fatruwe3xCaUxC3vdGVpx4aB/w/lvUNqT
         bvTO+qPRv+btYkYv97KO7+NmspEZgAXaakHWlsV7u89Oipj/RRJW4CCtMz9LRzq+cKOX
         NxWuaMkiyY6UJHcQ3UILaVjwU8hil8BcVaUJMq11Gukjpc5Zzif1m/Zyhf7rpQd0/JTG
         RPhrh9n/gJbODdyr+/xu7bvjUGxqQK2C6szJOi366waMVeFuUaPQx1gY/ZtaFh77DlMM
         l2Ggf26wgpjdulNOtOTMEIOX70yJvrBfLa24y2jbomD79xMSKTpgrhB4GQe3Q3yInS+l
         euog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781470396; x=1782075196;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhzWVFBovbUbRqI9wqfpVReAjsX1CU4k99CUksmW2lE=;
        b=cTqKZ8JCdVT9xMzfN7AUwNA6RDKkZvrOYM9XVolcu1v5K8je4WK2Lbp1OhMEfVw8oW
         RN+xS1JWa9wCEtqPuqAMXcEtBI5PYRcb2iw0xLSdY4kZdds4uWLDFsc5BG6JYQRh6HBM
         Zqkk0GSd+tw3iqvFUYCyVZJ+kwWGw7iaT/E3SlhwQWmT7clmeiquItiXz54FTdZ632vi
         9gIHSm2VOrTDHenQqty3h+C1JKnAH5Tg9FEW3MtYDqpjWPPR5vaZJRa8GzgIBLoZSABY
         RZNSIe2shULdMdlXaOA4e6WQILl08oN2YJsj3Fsdke1/jZn2fCsohLtjxYcxAoLYdqif
         edcw==
X-Forwarded-Encrypted: i=1; AFNElJ/dqFLvAKmniO2KEey4oHad/Z0DMo0HWMZh+fiN7rY45jPM0FtFAMPItrzfybO7aB4DVA8CJtnmdOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/z5nf4AOpShP09m0DPZoUdI92raiY1mpLoz4/sO+4upuosVXu
	2lwWHghYvi8NdFjPDPoTG5Hy2WlK90a7KELwUQd6/kdbhWqlG32a5tsa
X-Gm-Gg: Acq92OG44VGwXubeiWVMY0H9GixDTKv6jqcAT3/igCWvTKR/HmWkyF3jOPbieGDKsf6
	Y5ffNnArtZ6uH6EZ3eaxKpZjsIBpjqgnrcjrAEI+WUwRp1bGLe9w4hLcOf4J+NWtFh+6BSPEFCC
	tGeaHGTOX1osUMN40SuZWcvcMhRdeZ68VxvNNtH2wohgjWbyjMgw0nn/f+e+GduUcoiNeMYEvzb
	j3dQ/jMC9P81APBoO7B1gmdNIpp4VRdcPmyYPgilu4J+iKue5TzJD+wzGhzviYS8hD+NTav0YaK
	DbtWwDufcBspj294W3/UnrlwKtlQzbzGLJdXkCdx1WUDsGt/NL4SLbbZrFNI/4wsW5hAIhLRZ8k
	rMTHAX5Xf0JQWi56MSYNitGS3/k8dxqXNKG7ju2u9Qt8JcJmi2ON/xfPjPeu74IzfNz8nETJU3/
	0HYduyzGu+Gvf02A==
X-Received: by 2002:a05:6122:3c53:b0:5a2:9154:2792 with SMTP id 71dfb90a1353d-5bb6c058399mr6140865e0c.7.1781470396353;
        Sun, 14 Jun 2026 13:53:16 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb900138e8sm2216269e0c.6.2026.06.14.13.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 13:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 15:53:14 -0500
Message-Id: <DJ92JT0CPSXJ.1113K3KLSRHH4@gmail.com>
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
In-Reply-To: <20260613-loyal-azure-goldfish-cf6d54@quoll>

Hi Krzysztof,

On Sat Jun 13, 2026 at 1:54 PM -05, Krzysztof Kozlowski wrote:
> On Fri, Jun 12, 2026 at 05:46:19PM -0500, Kurt Borja wrote:
>> +  ti,neg-refmux:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Selects the negative voltage reference input:
>> +      0: Internal 2.5 V reference
>> +      1: AIN1 pin
>> +      2: AIN3 pin
>> +      3: AIN5 pin
>> +      4: AVSS pin
>> +    minimum: 0
>> +    maximum: 4
>> +    default: 0
>> +
>> +  ti,vbias:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: Enables the level-shift voltage on the AINCOM pin.
>> +    default: false
>
> There is no such syntax, drop.

The "default: false" syntax? Sure I'll drop.

>
>> +
>> +  ti,idac1-pin:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Selects the analog input pin to connect IDAC1:
>> +      0: AIN0
>> +      1: AIN1
>> +      2: AIN2
>> +      3: AIN3
>> +      4: AIN4
>> +      5: AIN5
>> +      6: AIN6
>> +      7: AIN7
>> +      8: AIN8
>> +      9: AIN9
>> +      10: AINCOM
>> +      11: No Connection
>> +    minimum: 0
>> +    maximum: 11
>> +    default: 11
>> +
>> +  ti,idac1-microamp:
>> +    description: Selects the current values of IDAC1.
>> +    enum: [0, 50, 100, 250, 500, 750, 1000, 1500, 2000, 2500, 3000]
>> +    default: 0
>> +
>> +  ti,idac2-pin:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Selects the analog input pin to connect IDAC2:
>> +      0: AIN0
>> +      1: AIN1
>> +      2: AIN2
>> +      3: AIN3
>> +      4: AIN4
>> +      5: AIN5
>> +      6: AIN6
>> +      7: AIN7
>> +      8: AIN8
>> +      9: AIN9
>> +      10: AINCOM
>> +      11: No Connection
>> +    minimum: 0
>> +    maximum: 11
>> +    default: 11
>> +
>> +  ti,idac2-microamp:
>> +    description: Selects the current values of IDAC2.
>> +    enum: [0, 50, 100, 250, 500, 750, 1000, 1500, 2000, 2500, 3000]
>> +    default: 0
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +
>> +  gpio-controller: true
>> +
>> +  adc:
>> +    $ref: /schemas/iio/adc/ti,ads1263-adc2.yaml#
>
> Not a separate device node. Fold into the parent... or explain in
> commit msg. You have entire commit msg to explain odd things.
>
> In that binding description you call it "independent", so it should have
> its own SPI chip select? Why "independent" and part of this binding?
> Maybe not independent, so basically part of this device?

It's independent in the sense that it is a proper subdevice on the same
chip. It shares the serial interface but operates completely in
parallel.

I decided to add a subnode because other devices might request their
io-channels and most importantly a different voltage reference might be
connected to it.

I'll clarify this in the commmit message on the next version. Although
after seeing this submitted bindings [1], I wonder if it's a better
approach to do something like

	spi@0 {
		mydevice@0 {
			...
			adc@0 { ... };
			adc@1 { ... };
		};
	};

Any thoughts?

> Best regards,
> Krzysztof

Ack to the rest of comments.

[1] https://lore.kernel.org/linux-iio/20260519-ad5529r-driver-v3-1-267c0731=
aa68@analog.com/

--=20
Thanks,
 ~ Kurt
