Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A54279FC
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750460; cv=none; b=QQQ99lSmTQtisIkYfr6FlI40uGCs33RL1kEzZ8K42Fy2dxPZ5WnCF31uw7jCU/82Cc+IGtKHk2J5M8Lyj8ISq0Z3iOCv2AnQfR2RD3RI2C5IuxRWoxuM5/mM+n9Ik6ibrgwJcx93zOXNE2VlvErme89jiFFOtWS28RmRprFxtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750460; c=relaxed/simple;
	bh=LRBuWO7sXtjtuQCETz0veDvzO9V3r3MdLYVKJFAqd54=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ku1jUsixWJeeRT7IXHhcRgB+YP1vU4LxtULwImWa9CMVtS7BUGPinwofQVcOlXJeoiJxD5Zc2K4G0xparP50qdTdc2HUyJdG7RbQSQS5G4HdT5CaBUko9OSXnNMHcG6yMk5Pz4ZxBPipuPOOgT2/zhOXZIajeGWrfNW2GcJ7KKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2RjEyD4; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2RjEyD4"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59ccf81e74bso1184155e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782750458; x=1783355258; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLchI3E0Uu7WQf0kAyF2SZwR4eWIe2krp0NcWRo6lD8=;
        b=B2RjEyD4TNmLFibeoaiAy+6fjR7M1MssYu790doGpQ+5UZjuZQdaijLLY1YOc35JvM
         AP4Hhj7dB6Vd4cUHkqRiVFoYPx54LrPKz/5Nv3gDsGhrgf1W815o9qNco3Kiay4yLklt
         +e+iJFSQN5HdV41QPsq5zpM1f3iu7XSTAN5XwTURNdvNCbQdwO1zam02ZF5S1KAPK15k
         sIFMpyO1d8s/hWIBzJ5LYzV6I6Q6MAGenHO6PYfLtIZy1zpG2t0kHO2k2H0IkEetkjEw
         Q6VaQ2VirejOGdmpEI2Rh1O5M8iXchmQw+MDVKAO8BtjS0S9r9DSqhsnTBu/snXtg6YR
         0bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782750458; x=1783355258;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLchI3E0Uu7WQf0kAyF2SZwR4eWIe2krp0NcWRo6lD8=;
        b=AwdVQUfapYGt+yAf3QNi+Rj7d/9BzWE+B5b9accgX5BM0HRpZn1knnDqdrxFSYx5Hd
         caEqmJjfm1Adc41Xh1ChxAY1yXKfECvzM87Ed2o3KPO0K6m3yhm5IJaRX+bpls+uM17g
         TnjDMp4m94+uAq36jVAWTMTcHGjfmC2y+fg4uExr/GajoGlAFYpRRGZSBgrAxKGJHXwZ
         aYgbt74uej5CwsIJICCOzXpa463aGr1n8g1gIXUr6V3/5KtWHDO+BCf5fP80/0QlCT6w
         f6HmaXF0DE5MgIZ0QNiaUDaalhxEuFv+udxIFGCfldh++cfUqTgJTjKqIpybtvBOiBBZ
         Xqzg==
X-Forwarded-Encrypted: i=1; AHgh+RpGK69bHcwZWF7lMEPErbGcLUSquKhiuqMs9dUTqV89AqLeKDSb3YRJsplGL/lW6fB3QCmGUoAoOZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/f5X/lCkAaWxY9npumWHZ3r2aW4yRSuAdlyWZIdGskpRHpb1
	2DgPj3KQGfMXh82EOTdr17g3nRNU4cCkml7NiU9s+0Pi+u1xCAKQAYcD
X-Gm-Gg: AfdE7cm2QGog4s9G2yxxNltS6g2W6DjcjEu9HMQjJ5KlrIxETThMqNV5G59zZT5StiB
	DHdJrX2WKZILXS8fmeiQ4ZGWlBo87WfxL9p04AoNduFAO5/Y9olAh0Qcea5CfjjdRahNvhLuyN6
	/tsM4BGH/2NIhcwbheNsWIceVZiWBeZRI+kCK7aMnKdfXUZRj1leGXCe3Au0bBgXSWaILjMVOvJ
	Re+jG+hdqcUet99pd90VdjyKSacOJwImydd+xUthK28mwJbli8dQiWv7ccyeq3w/H5quhabF/ih
	vyIkojVbxLPHuDMsb+cD6RzvOEkNBxLG08PFoH3wreI4KL89inmzCMSQ6inKYWAbJgpBHVmy5m1
	EEuegRrjQlGx6quTS3yq8IqQRisKHvZwO6u/3im/XRJsnSFhTxwwI1kaCFBwI1WiO7Mb40fMlKi
	91iR4=
X-Received: by 2002:a05:6122:3117:b0:5bd:9f23:a74b with SMTP id 71dfb90a1353d-5bdbed8d55dmr293272e0c.9.1782750458347;
        Mon, 29 Jun 2026 09:27:38 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bdb2c1e818sm1119039e0c.5.2026.06.29.09.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 09:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 11:27:30 -0500
Message-Id: <DJLOAISPZLG7.VZYX8B16QU4K@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add TI ADS126x ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
 <946a30c9-01e9-42f1-bd2b-b7934fda85cf@baylibre.com>
 <DJKX600ONL4O.1YUTCD1L9FU8F@gmail.com>
 <a16f61fb-4e98-4c30-8d4f-da084e27ebeb@baylibre.com>
In-Reply-To: <a16f61fb-4e98-4c30-8d4f-da084e27ebeb@baylibre.com>

On Mon Jun 29, 2026 at 9:21 AM -05, David Lechner wrote:
> On 6/28/26 2:12 PM, Kurt Borja wrote:
>> On Sun Jun 28, 2026 at 10:45 AM -05, David Lechner wrote:
>>> On 6/28/26 12:36 AM, Kurt Borja wrote:
>>>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>>>> integrated PGA, internal reference, excitation and burn-out current
>>>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
>>>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>>>
>
> ...
>
>>>> +
>>>> +patternProperties:
>>>> +  "^channel@[0-9]+$":
>>>> +    $ref: /schemas/iio/adc/adc.yaml#
>>>> +    unevaluatedProperties: false
>>>> +
>>>> +    properties:
>>>> +      reg:
>>>> +        maxItems: 1
>>>> +
>>>
>>> If we want to allow single-ended/pseudo-differential inputs, then we sh=
ould
>>> also allow single-channel (positive pin) and common-mode-channel (negat=
ive
>>> pin) properties.
>>>
>>> This will also require additional common-mode-<N>-supply properties to =
allow
>>> for the negative pin connected to something other than GND.
>>=20
>> Ah interesting. Why the N though? wouldn't a single supply connected to
>> AINCOM be enough here?
>
> In theory, any AINx could be a common mode input by connecting it to
> a constant voltage supply.

Technically yes, but there is a pin named AINCOM intended for this
purpose. Can we do a simplification here? I propose having

  common-mode-channel:
    /* AINCOM pin */
    const: 10

That way we would only need one common-mode-supply. Would that be okay?

--=20
Thanks,
 ~ Kurt
