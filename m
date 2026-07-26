Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83B2DB7AE
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785095357; cv=none; b=Ca/ns+W9Q3SrTgxO885SGw5mVRgxJt8+jhIpmwnuR7YqSiGqfQEnj7nK04Alf0h4C7u/fY/TubwwWs+Lga8uHhdl5mEfZMTsZC51lt42vka6VsmurVQpRipiZpwobxSRDwicPc40nrLdCUqR0mJkzBIH5hPXCZuCo7JANZZ/0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785095357; c=relaxed/simple;
	bh=HutDrZoyIVX95cda8p8zTvBwg9Q9t+kX0D6sevWm/Iw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WB9uy4xTb3DdrU2wr2WxImLd7pg6sEPtFgYTflehfAnKe2A7zIOTOBQoy54Tt30DksLi5dX75YUhPtjYqcygcrgywjchoxMdKvk18EPN757OxuKMgF4Mr5s6A1aZt8c/GV4aIGjbO8nIU2ELPhHjIyplMuZXLVq2jR5YzfJAvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZzDiKen; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZzDiKen"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c11362f67eso1340027e0c.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785095355; x=1785700155; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=khUtvGXsUTKuBTJZfp3i7v8Cg04JI/BZbPu+3nRtrqQ=;
        b=HZzDiKenTvynzfR7xzZKD5GW4ZUYTjyIqYxQnZM2ryVfEdjIyZEJzZ1ZVzsVPsV5/n
         PpwgwHIUYg9R9n3DVnGd8Ayeq/xS+lr53J0LuDbQjsZ5maPfyyhe7TwR1cfkX/b9Gfuj
         PHETVVSdvDpSjqiRlOxjoVg0awwuxB2dVxSuz9iLyGQyEV6afiasY8U1qEhlrUKBTkDV
         s0VT7FxbsUzgiO8TeF5ddCmF6xvaKngXEzolcxbXhOM9Wj9wDeAHrFyom2no4gTG3Foq
         LSO3MOv/cXuti7EDIhDIes+VMZicN5GL7FLVnEkdLlCDu+TeWn1EA9a7PZpgEr3DbN4z
         owSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095355; x=1785700155;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khUtvGXsUTKuBTJZfp3i7v8Cg04JI/BZbPu+3nRtrqQ=;
        b=CbiAqYRafDPKijKQ3/ESe+G+niAMZ7CNSwgYH/yy2RDo4jvGgctnMNHGxxcx+2Ci7E
         DzVwr7S0TeZrh1JvodZis4LcZUaycFtrmgQeSZtKOVAphE7nU5G0wtDdF6Tp3mKSj/ud
         li/Pg9iMiTJTWZBmVeCQUECa4Ruk0RPOat0mnOoe0sj1xyhi6r7kiBSy4eIi4/mw133p
         rnPvG/y44jX0lyrhhelH4jdwXaQJIzkNhcwtBc8e/fHgnRmstBmdnVgYwTfcSR2r65ae
         5cviIqaBTLCYVhgZXaDm3VkNgPhY1D1t0VyKa61Ur4sYC0Kt2j/SCirsIJJfNm2vort4
         RyYQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7pwxD+Kjqbrk+SEJfCCU7KFdxCaMEkBaBDcJTpaEP6WihIbd2+6IS3H7sKOLtjaw8dj0JeuF6GtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5+odGiKWov0wK7sKRKQBWhMXSkqHyDbVGMM1yyeggeFwPnPh
	rRgtOn2PCsTkIaH6FLfD/fe+SNdenjHp7t80PP3V+oIkLbEccN9cAQ7E
X-Gm-Gg: AR+sD12m5eLKLYh+7lmOueAaVfDOQNC+/8QjDNh6CYhz94KBxSS4miIzQdC7F1X5REb
	YA/c5akYSFaz4SzeEEiqe31EuTFlU8IDfRskDsZzxMaISnJdJl6yM/Uw9eUgVLG+pV6ZAxeAbEA
	JRr8cfGN64bT+zbhoueZQvE7TtXKbEt+XM51LOsR9gyLlqF4Ue5bxBhV47rD5+DEpkeLNo5m3LU
	jDghJqzF0CfA2nNHFCWwmY46P70qER9yb5090xZ/ztTpDtBUFjnZTarjNM7v+RvF11Dc9RlNHYn
	Ns4YsFO1fL86spupyLtsEfwbVwhDxV9X8sdJaikt2sCbhLEFPbAhVXpOU75UteFIF58J2Iq+55E
	6iaRvXaa7DLw/m2M2sSyFKpEbJySR4YH2NydMVJVOMtbCwcQHx3yCuPkOXl+7b00pZvvT
X-Received: by 2002:a05:6122:7d3:b0:5bf:bc5e:e24 with SMTP id 71dfb90a1353d-5c306d72c10mr2846830e0c.12.1785095354812;
        Sun, 26 Jul 2026 12:49:14 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c305706b09sm4803276e0c.13.2026.07.26.12.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 12:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jul 2026 14:49:06 -0500
Message-Id: <DK8RHLBX32NR.AD0TDBDF1HNL@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add TI ADS126x ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
 <946a30c9-01e9-42f1-bd2b-b7934fda85cf@baylibre.com>
 <DJKX600ONL4O.1YUTCD1L9FU8F@gmail.com>
 <a16f61fb-4e98-4c30-8d4f-da084e27ebeb@baylibre.com>
 <DJLOAISPZLG7.VZYX8B16QU4K@gmail.com>
 <22e1e1c2-659c-4991-857c-b38d66769c7e@baylibre.com>
 <DJMJX5FGSZ9X.1GQK24K6CI60X@gmail.com>
 <2a0a9fe9-b3b5-49a0-bf58-5035655fc16d@baylibre.com>
 <20260701012842.16272045@jic23-huawei>
In-Reply-To: <20260701012842.16272045@jic23-huawei>

On Tue Jun 30, 2026 at 7:28 PM -05, Jonathan Cameron wrote:
> On Tue, 30 Jun 2026 13:38:30 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 6/30/26 12:14 PM, Kurt Borja wrote:
>> > On Mon Jun 29, 2026 at 11:43 AM -05, David Lechner wrote: =20
>> >> On 6/29/26 11:27 AM, Kurt Borja wrote: =20
>> >>> On Mon Jun 29, 2026 at 9:21 AM -05, David Lechner wrote: =20
>> >>>> On 6/28/26 2:12 PM, Kurt Borja wrote: =20
>> >>>>> On Sun Jun 28, 2026 at 10:45 AM -05, David Lechner wrote: =20
>> >>>>>> On 6/28/26 12:36 AM, Kurt Borja wrote: =20
>> >>>>>>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs w=
ith an
>> >>>>>>> integrated PGA, internal reference, excitation and burn-out curr=
ent
>> >>>>>>> sources for sensor biasing and diagnostics. The ADS1263 adds a s=
econd,
>> >>>>>>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>> >>>>>>> =20
>> >>>>
>> >>>> ...
>> >>>> =20
>> >>>>>>> +
>> >>>>>>> +patternProperties:
>> >>>>>>> +  "^channel@[0-9]+$":
>> >>>>>>> +    $ref: /schemas/iio/adc/adc.yaml#
>> >>>>>>> +    unevaluatedProperties: false
>> >>>>>>> +
>> >>>>>>> +    properties:
>> >>>>>>> +      reg:
>> >>>>>>> +        maxItems: 1
>> >>>>>>> + =20
>> >>>>>>
>> >>>>>> If we want to allow single-ended/pseudo-differential inputs, then=
 we should
>> >>>>>> also allow single-channel (positive pin) and common-mode-channel =
(negative
>> >>>>>> pin) properties.
>> >>>>>>
>> >>>>>> This will also require additional common-mode-<N>-supply properti=
es to allow
>> >>>>>> for the negative pin connected to something other than GND. =20
>> >>>>>
>> >>>>> Ah interesting. Why the N though? wouldn't a single supply connect=
ed to
>> >>>>> AINCOM be enough here? =20
>> >>>>
>> >>>> In theory, any AINx could be a common mode input by connecting it t=
o
>> >>>> a constant voltage supply. =20
>> >>>
>> >>> Technically yes, but there is a pin named AINCOM intended for this
>> >>> purpose. Can we do a simplification here? I propose having
>> >>>
>> >>>   common-mode-channel:
>> >>>     /* AINCOM pin */
>> >>>     const: 10
>> >>>
>> >>> That way we would only need one common-mode-supply. Would that be ok=
ay?
>> >>> =20
>> >>
>> >> Ideally, we shouldn't limit how the chip can be wired up in the devic=
etree
>> >> bindings. It doesn't mean that we have to implement everything in the=
 driver
>> >> though. =20
>
> I'm a bit confused on this.  Arguably you could wire up any side of a dif=
ferential
> pair to a common mode signal, but we haven't had this binding applied mor=
e generally
> than cases where their is a setup where the intent is a shared common (sh=
ielding
> on cable in some cases IIRC).=20
>
> So why is this case special? I see AIN_COM can be wired up to an internal=
 vbias
> but other than that it looks like any other AINX input.

Hi,=20

I forgot to respond to this email!

As you said, there is nothing special about AINCOM, it's just like any
other input. That's why David suggested to have a common-mode-N-supply
for each input.

I implemented this of course, but I still have doubts because there is
no precedent for something like this in IIO. I understand the logic, but
I'll personally be inclined to drop it. If there is no further
discussion I'll keep the 10 common-mode supplies.

I'm finishing v3 and I'll submit it in a couple of days.

>
> Jonathan
>
>> >=20
>> > Makes sense.
>> >=20
>> > I just have a doubt: In the ADS112c14 bindings, is there a specific
>> > reason why you didn't describe common-mode-<N>-supply?
>> >  =20
>>=20
>> For singled-ended inputs on ADS112c14, there is an internal
>> connection to GND, so it isn't possible to have a pseudo-
>> differential input like that. I guess technically, it could
>> still be possible, but wasn't a typical wiring described in
>> the datasheet like it is on ADS1263.
>>=20

--=20
Thanks,
 ~ Kurt
