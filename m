Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DB47AF4D
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631068; cv=none; b=gAZv/BVZ3Xs4cLlcfdBW6aBbbzucLZDLlXopjciCfySjBdyyw8DHCIzPBpc5XaaB1bN+Ok3vNPxxFUlTMkD1RYFSB6oeAs2/qgGwOjlh4XgQpGUH/dpeCPvUJE2fnu9PNzbO/r8+u1cVvhLomWjMafMGo72SBOqbMCOIROC3bzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631068; c=relaxed/simple;
	bh=7wN6KFQ63zy7Pi56yP46VHM+3T2LvLOCz0Ue4+tT8e4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=BtTjFLzo3vatJGcRs08twnPNgWRJlyaYYH6kM8L0NEDjxgNRrzp46j30Jqtz+HnhJ+0zbYjq60CWMse060P3rKcHBP/4zTpAregdr252fMZYswAB5/3e1BM1vBAU58AFpSdfW/lhvt2X/FHWzGQ+757wTIwuN08LGAYAXTd68xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrrLHhyW; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrrLHhyW"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5a1490272bfso65920e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781631066; x=1782235866; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TusoqYXQtC7ZEmYrVS88Qf1B/mtpW5yAVVSfmOzzRUo=;
        b=GrrLHhyWfLp4E+g7W27h5MbIa/bxTm1Mw65Fi7mjXKSKpw9jeBkb97bCFdLUT6svDh
         7Zd9g2VrRvNNEldCBNVvvgzgsbskxgDhVoQnhr6do16mmV9fxv1TBxuNy+wsYBCnBOl/
         ViCgPW6j9oaBZH5VicdpAD+Hw8RLHGeqD1O7oL7XBqZlsr/4trYvLHnARNSM3DG7+EZC
         4cjBYOXgQCOJULYYk6Qb8hvA2xPDb2HbrZbx7Uwk1HXFOyAveqT89isaq+vpfxrFkmRc
         pCTIBAiaaeyjMpaQWlzkMl2QgT0wNDU2gMUePc7IYHUHbQfJEbwNvFDshQ/R+7isv/iC
         hEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781631066; x=1782235866;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TusoqYXQtC7ZEmYrVS88Qf1B/mtpW5yAVVSfmOzzRUo=;
        b=G8xEWnYm3aMCa1MZKyOBXAvom5PoNfLJiov4/Odcx/GYf3nKZT1JdxmKiEdtx0p6PT
         kfq4d5IwZw5mqVl+40jbWsj7AkEqp98pk0HnRoig5NjiSHJxuMDCu34NOdxDuF0FGt1U
         eAaR8qfWbNehy7KzTAOPlviNA8HJ0HiEAsZzJAyehdz9U5oRPdtNeEhQFfkRchHdr+Yk
         LkEeJEFCNvj/HUIcuL33jlhxVyH39DWuRZyRZzpoqc+nLkSvQgXC/WEY8RNmmGSZjk3I
         eChIivOvrZkXvLmjZMVTwl8v2BEJ3hRUAao5z6GNAjLsFY1vIC/hk6jEJu81TL+VFCN7
         tqlw==
X-Forwarded-Encrypted: i=1; AFNElJ8RVsGHaDE8ishfyJ9x6t0Yc2qtX0gAK/vhHMMHf2iXfPEyn5OPAzewHKc33X+EnUSAxZfMyrRatUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVcjTaFAGIRNzuxOt0TQYIKADS24igtBTdlwU6yODnDSAqSxs
	TbWce60xIgijaQv4OE1mrcgkBKEu5u8lNWiNOeRdrCmkLOFJGaJzA5yu
X-Gm-Gg: Acq92OEdLMJSQCqKxYcu6uFfeiDJKL2YnjrhoHjtrRB4+NAJcyjCi3Svpgsa5b2fd3r
	JVsTDagEnCHezsIbDPW7+WUrHy+PpPIdn8v4GvOvgNWp5X9aK2yfLWJgJyNU7ZW2lECBl5nIoWm
	jlmqWOOCIT+8nDBQd/zK7JGHY/aorhVhzcEVy4cwKproEgwMCSzjiRWpkGtMkWLMDbRQ3sDNeha
	rkrcZ50vM/JMMwTI6g1VklBQV43Iv7U83/8kmon7vgaqkCU9Yh6t5UNVt2hPvS7NOw/XKAU1bqw
	UyqWotSw+OsTcmSn+4tkWyNM6n6Ue7qRpN4kPqdaIuFT7Ob/9AbPtst2zqLFJwry0btRS7Ke+iC
	IhsS3+4tUrgUcYY2PvUsmiLmLIS2FdZGp6BdWm3NIzB0dHEc4bRAhoSTPcVBdHhWnt+iyz37Y/5
	35OsqXMdyedGLfEw==
X-Received: by 2002:a05:6122:3486:b0:575:f155:8cd4 with SMTP id 71dfb90a1353d-5bbbdc1651bmr455091e0c.0.1781631065662;
        Tue, 16 Jun 2026 10:31:05 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb901ac4d6sm6540419e0c.13.2026.06.16.10.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 10:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 12:31:03 -0500
Message-Id: <DJANI38U2UC6.2RX60CFL2K7DE@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: "Nguyen Minh Tien" <zizuzacker@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
 <DJA1PXNS9SFP.VAURJH1MR9BK@gmail.com>
 <88f29dc3-7929-4d94-a1bc-6268c41ee3dd@baylibre.com>
In-Reply-To: <88f29dc3-7929-4d94-a1bc-6268c41ee3dd@baylibre.com>

On Tue Jun 16, 2026 at 10:22 AM -05, David Lechner wrote:
> On 6/15/26 7:26 PM, Kurt Borja wrote:
>> On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote:
>>> Add new bindings for ti,ads122c14 and similar devices.
>>>
>>> This is an ADC that is primarily intended for use with temperature
>>> sensors. There are a few unusual properties because of this. In
>>> particular, the reference voltage source and current output requirement=
s
>>> can be different for each measurement, so these are included in the
>>> channel bindings.
>>>
>>> The REFP/REFN reference voltage is usually just connected to a resistor
>>> that is being driven by the ADC's current outputs, so there is special
>>> property for this case rather than requiring a regulator to be defined
>>> to represent that.
>>>
>>> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
>>> have preferred an enum of strings).
>>>
>>> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++=
++++++++
>>>  MAINTAINERS                                        |   7 +
>>>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
>>>  3 files changed, 242 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yam=
l b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>>> new file mode 100644
>>> index 000000000000..dc7f37cad772
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>>> @@ -0,0 +1,224 @@
>>=20
>> [...]
>>=20
>>> +patternProperties:
>>> +  ^channel@[0-7]$:
>>> +    $ref: adc.yaml
>>> +
>>> +    unevaluatedProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        maximum: 16 # arbitrary limit, channel@ can be any combination=
 of AIN0-AIN7
>>> +
>>> +      single-channel:
>>> +        maximum: 7
>>> +
>>> +      diff-channels:
>>> +        items:
>>> +          maximum: 7
>>> +
>>> +      bipolar:
>>> +        description:
>>> +          Set this flag if the differential input can be negative.
>>> +
>>> +      excitation-channels:
>>=20
>> I noticed this doesn't have the "ti," prefix. Is your plan to add this
>> to adc.yaml?
>
> I hadn't really though about it. I guess it could make sense.

I think it would be valuable, given that TI is producing quite a few of
this kind of devices.

>
>>=20
>> Also, do you think excitation-pins might be a better name?
>
> I used -channels to match e.g. diff-channels. The same values apply to
> both properties.
>
>>=20
>>> +        description: AINx pins used as current output.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +        minItems: 1
>>> +        maxItems: 2
>>> +        items:
>>> +          maximum: 7
>>> +
>>> +      excitation-current-microamp:
>>> +        description: The current output of the excitation channels in =
microamps.
>>> +        minimum: 1
>>> +        maximum: 1000
>>> +
>>> +      current-chopping:
>>=20
>> If you agree with the above comment, I think this too should be added.
>> In that case, can we call this something like
>> excitation-current-rotation for less ambiguity?
>
> I think excitation-channel-rotation would be fine.

I like it.

>
>>=20
>> I say this because my device has an "IDAC rotation mode", but it also ha=
s
>> a "Chop Mode" which rotates analog inputs and averages consecutive
>> conversions.
>
> And this one sounds like it could be named input-channel-rotation. Would
> this also need a 2nd set of single-channel or diff-channels to the extra
> inputs?

No, just one set. It rotates the positive and negative inputs.

I'll go with input-channel-rotation then!

>
>>=20
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +        description:
>>> +          If provided, the two excitation channels are to be used with=
 current
>>> +          chopping enabled.
>>> +
>>> +      ti,vref-source:
>>> +        description: |
>>> +          Indicates the source for the reference voltage for this chan=
nel.
>>> +          0 - Internal 2.5V reference
>>> +          1 - Internal 1.25V reference
>>> +          2 - External reference (REFP-REFN)
>>> +          3 - AVDD as reference
>>> +
>>> +          For convenience, macros for these values are available in
>>> +          dt-bindings/iio/adc/ti,ads112c14.h.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        maximum: 3
>>> +        default: 0
>>> +
>>> +    dependencies:
>>> +      excitation-channels: [ excitation-current-microamp ]
>>> +      excitation-current-microamp: [ excitation-channels ]
>>> +      current-chopping: [ excitation-channels ]
>>> +
>>> +    oneOf:
>>> +      - required: [ single-channel ]
>>> +      - required: [ diff-channels ]
>>=20
>> [...]
>>=20

--=20
Thanks,
 ~ Kurt
