Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B93DB97A
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839688; cv=none; b=jrGiZJCSZiXYhB7DSkT6acqoDS1NAw42qlD4cSdc1AeGMzSkme4xYy0l3YI1ri2/1BVaJ+p+nUfbUoVhRVJcGjnKKa9pDMPjpo7jT/RQduJuJUpzpOiYJFr79zpMqk076Bq8ZtOYnRC7eKzgubMNfp06bOSub8NGGgbPu+aKFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839688; c=relaxed/simple;
	bh=yI4LIb23rfKE/21+3syEgft1Xeo2c0ZRsRWLnRGk4wc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fqaR4YtqO3ZVIV3Gaoe+L4Kpvy+zi7SMGZkqE35zRdXCgYe4NN3xMDXcbYOODvGEJMFN7g5jD0M87MMSNkxDuve4kKwUr1yRs4eiTJqa5CusYRY+H51XQzne/9qckfYs4OCGjqaBUYXT5Sjc0NKHp4BU5KIRUZSWSbEcXihlXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR2Nh1tf; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR2Nh1tf"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59ccf81e6feso1597808e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782839686; x=1783444486; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj0dzyKkgM+YsTOclkY88VSZr2slrmcvgTQm6yEB8ME=;
        b=PR2Nh1tf9U45X2QPsNMjst7ZwGhxnGXhjDNwcur0Llo8NsqsykiXkUt9lvx0T23OwK
         ymp+6ljMMOa/z/OLuagQ49NrKixAp1JPPYYF1KgCLnGuEf84RaywJNM5CuMKxB8QqcIG
         gUtcYQ5cKwM+1+cP93GVTDGsZs5f59wpf8+Gv3UnlYeJNF2vWqRHedCblxFmhu/4QTWj
         Y3gxg2WE6mShEjrsGVX2cCSGQ59OED6BH9ZJLvOd3bi5Q8xPYQFfFoW3486lXgL7C58Y
         owy4CgGeKhvfItdjkCAQJiy229dmrH2g0TT5k/irjgkwHbtX2aKXf+/+tZ29WJ7Wenp/
         JDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782839686; x=1783444486;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yj0dzyKkgM+YsTOclkY88VSZr2slrmcvgTQm6yEB8ME=;
        b=k0LDfGoVOo9knulfaMjdpwjSsA0ieInc8pXE07eqOOdL7ZxwjZuXTrk4uy/HzteDxt
         9GRqsHtwwAqLC4TkpcI0CIck03nyx4B6E4X0chopJw912lV/1MVSfJYA6afueI71R1A+
         VOQKkShKEOQ+pCS+5/IfFNVe6/nOzuDOzGkDdKSyqpTrj7PWaROlyCecll2TNVLIBrrd
         OieNd7lnYx+cdaTZ15dq3piWRCfER8PqeUU7FDeZoRotstn40GwQUc8FxdU0ElRDHLYD
         BAOlDQYcR1IqGJog2aFkfrvTqNYte+gvdC4hH3VDL4DiKkoFJjMqiJNiGX7dCGzzSuEO
         K/Yw==
X-Forwarded-Encrypted: i=1; AHgh+RpakCp2YdWKKRRb+0V7OX1i5v/MRRyHjewyH6eOv46iAiz12mahOI7ji7eU7GrZf5on22HOQfzSBC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Pj7iP3iWR4OfSlr3GNrKxND1EVIsJ8128pLqyLy3HryHDv/a
	NTn8ZQ9aq7MVVjdbD/8STauq0gMLe7yl/SXpa47aDHJ8J97yjiq0gUFVU9T8nA==
X-Gm-Gg: AfdE7clRcHhW9OB6nLC0Rj9EO0Ps+Bv+ttVDK6HgXNoh7omXOIpL2ebyuhJeX6RshBR
	wcPt6qboct8JAWErrUeiREh9q+ZiDSJdXWnNyl66sqYaL9TKrwOfeejs/SD9Ov3zqGiUTF/5iTk
	6Kz4jVZ46X76p/HO6647UzPyXm/UfcAPrR0++bHVmKPPjPEoojHcATqvydTsRO24tGnealQUZUb
	lfUWIjL3GqIHdMeSKY6IA6qXAIMisgF2c1ju5G9cTY7Q0M0uXOg6VJNcOgW7M2pnR0ya4y5bTOZ
	021t8d4okzorB4epgKjspsiOxPzZxI9NTsJeuMEq+vjRSaRTtpyruroJZT1fatYVJeyw+v+/gmQ
	Dd8YtGMTBoOEXZOpvfDitQDz8vJwNCTyF/I8m1s2FTkOz9xEkxPzIfn3LttHepbEkBrez8IT6AB
	rGgIQ=
X-Received: by 2002:a05:6122:4b11:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5bdbed0ba9dmr1958656e0c.7.1782839686037;
        Tue, 30 Jun 2026 10:14:46 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bdc184957csm1836979e0c.2.2026.06.30.10.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 10:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 12:14:38 -0500
Message-Id: <DJMJX5FGSZ9X.1GQK24K6CI60X@gmail.com>
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
 <DJLOAISPZLG7.VZYX8B16QU4K@gmail.com>
 <22e1e1c2-659c-4991-857c-b38d66769c7e@baylibre.com>
In-Reply-To: <22e1e1c2-659c-4991-857c-b38d66769c7e@baylibre.com>

On Mon Jun 29, 2026 at 11:43 AM -05, David Lechner wrote:
> On 6/29/26 11:27 AM, Kurt Borja wrote:
>> On Mon Jun 29, 2026 at 9:21 AM -05, David Lechner wrote:
>>> On 6/28/26 2:12 PM, Kurt Borja wrote:
>>>> On Sun Jun 28, 2026 at 10:45 AM -05, David Lechner wrote:
>>>>> On 6/28/26 12:36 AM, Kurt Borja wrote:
>>>>>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with =
an
>>>>>> integrated PGA, internal reference, excitation and burn-out current
>>>>>> sources for sensor biasing and diagnostics. The ADS1263 adds a secon=
d,
>>>>>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>>>>>
>>>
>>> ...
>>>
>>>>>> +
>>>>>> +patternProperties:
>>>>>> +  "^channel@[0-9]+$":
>>>>>> +    $ref: /schemas/iio/adc/adc.yaml#
>>>>>> +    unevaluatedProperties: false
>>>>>> +
>>>>>> +    properties:
>>>>>> +      reg:
>>>>>> +        maxItems: 1
>>>>>> +
>>>>>
>>>>> If we want to allow single-ended/pseudo-differential inputs, then we =
should
>>>>> also allow single-channel (positive pin) and common-mode-channel (neg=
ative
>>>>> pin) properties.
>>>>>
>>>>> This will also require additional common-mode-<N>-supply properties t=
o allow
>>>>> for the negative pin connected to something other than GND.
>>>>
>>>> Ah interesting. Why the N though? wouldn't a single supply connected t=
o
>>>> AINCOM be enough here?
>>>
>>> In theory, any AINx could be a common mode input by connecting it to
>>> a constant voltage supply.
>>=20
>> Technically yes, but there is a pin named AINCOM intended for this
>> purpose. Can we do a simplification here? I propose having
>>=20
>>   common-mode-channel:
>>     /* AINCOM pin */
>>     const: 10
>>=20
>> That way we would only need one common-mode-supply. Would that be okay?
>>=20
>
> Ideally, we shouldn't limit how the chip can be wired up in the devicetre=
e
> bindings. It doesn't mean that we have to implement everything in the dri=
ver
> though.

Makes sense.

I just have a doubt: In the ADS112c14 bindings, is there a specific
reason why you didn't describe common-mode-<N>-supply?

--=20
Thanks,
 ~ Kurt
