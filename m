Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F89424D5A
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789910079; cv=none; b=K2YJOd1wrn1vafrIHYm6ES0XKsntYNLYfaeDKnYHhIv0jBOfOZ1vXRHkOlIuUBq3v5c74XlV+BteEqhvPwrUp9V8j3v4rg3DooxsnrGf2pf/hhF9mIO1JnI3/WrT5/6LlL8XKgio7RMZM2NmhcaHe4YCp1c565pgVQmLU0SOkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789910079; c=relaxed/simple;
	bh=VK7RoF1IQoNC3f+NsiDh8gGx5Rb6QtODUmRQmxHqHFo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Qeqsy/yixtkRx5qhTEuqotRTM3NXv7a+FNg36/HcvJBj1PXel5tvaG7etIJnfdzr7N63ufCnDNb3R8M0m4Ow3xVT2N96c9Xd8q0JL5PSOEsArmfkROBtwALd5aAe2L0ElT1OsW0Z7iwMY1Sm65y5a24jco3cSzIDhPteSvXwKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie; spf=pass smtp.mailfrom=conchuod.ie; dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b=dr7GKYjW; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conchuod.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b="dr7GKYjW"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9adea43b6so2741945a12.0
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google; t=1789910074; x=1790514874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JFbD+COCu0lnrDJVoD6aOrFo9jVKtOVDblrxwIMvKRY=;
        b=dr7GKYjW0O938xlBYo71Nf8w8sZxU1L/11ABaMXkYAqK20BDj5lUPGzLSj1njfjrlr
         vmgr8kcZDwcF/muUwxBF69aeGzF1hhW8xG41PT7R243TwuuTgXqYvRvkCIgUPuU0fh5r
         t1qKa+WTgNJ/5BqeV+VDPNJr5V+z2ijd0nQbVo2waWxOriLRZ8rjqfcDKbo2HT/OBBlW
         Xs0U1eaQPH5JzOn6za6Fx+clcwk8liJhjlvUDdBJaeJyUmGhbZhcqq1kqjlZ756h30zM
         C1Y643pvyFmioyWqN6XtnvG5ajpTiK2o1tJkgey0/iaP18NPL/1hmG5fJoJdjeXDOQYI
         Hdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789910074; x=1790514874;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFbD+COCu0lnrDJVoD6aOrFo9jVKtOVDblrxwIMvKRY=;
        b=SIb0jrKjh6ThrXl7zBEUUJPOaK8bj0hqDssurHbbzaPpTxYATGaVZ1ItXNhgRK5RLu
         TV0Sze/Z5sFCGd2UPBM6O/3fqQncEIfzn7c2a5PTD7zCVIfjfpc4AGMUWw05kdwTzGlw
         B47vG2qKW7ex+fuFdyNoNRhl9FTYietbH1oAKEj4A6cfdyFHU29jKkR19eH2XUCBs9Ih
         yc72jhLaik27cDLaHn+ghjjxsl/S1FporGN2qwV9vD6VmQQca6MqUf4hAGkk0YamdwPu
         eDT/bWRKmjs6gEbCakPCUhAswoYFPDRW3Tt9c1mrgIm6nC6Fretin/Idn2OQ3Lrvqbz6
         4Riw==
X-Forwarded-Encrypted: i=1; AKwUvBy/46/p+HDDBuPLd1CmctvA1IO9rGGDmiYO1uMGVpq/aVSafSvTSmXD2UAIuibU6OTm4rwluX9HNjE=@vger.kernel.org
X-Gm-Message-State: AFuF++nsTk94cvNZOorXauDWYNVtkWQ3wJtANNrJ9j19hDaNdSsL6gNN
	bs+8sWnABYEUjpNf0TdD/9v1xooDcPrFJ283QWBwnU9DMwsN269Qk+Cjc1glmJpzaGo=
X-Gm-Gg: AYBFou3kfHBhTiVACGpkgH/1ZKeKg8TN20NqwZhU034x7ECvy3/TRKpHnS9PZcjyPpo
	TKR+XrltE7OH2Cy6lmTBmW+OtAinxDoUv4yrWjGqwtD4TPHimtb6Mglm6UNvA7vSwoW4KhnwJxO
	Hjr06asN6oEznKIQ96lqVwGZRC6Xj5/PHhn4d+0d0F714cyeUtSo6MQZuy6so6PfDfmrNEdgqFn
	TZLWt8SwCBCKRG4sW+fpN953F0x7OnmBtyIqDPRKgwiJnnfj6WZVcpWlZnM2FMKWND/PDOE5PY2
	JbNGYI4hbQocILEsekPDHHfCRy3toOrvi5YEbazkl8+XnKkq4K6QkWgODdUpMl4tcU9QIAUb135
	fi2yIFPhA3+xzyMwAXuTagv0hYuPdCO1ysmhICvLCKZ3GmD++4qTL4PmEJPeV+bKviOy9ZsFs9k
	jfA+R1GwX7OQkNEz8FF9kTmlr0j92vgJuTUM23+Lz/fqR3JzFjbRp5uY6Tiqc6pFSytIH31UhN1
	ylsz/F9XyAZwjTuhWOsJAnGmmnSwSbGV+ALVyCv4rMF0M7FplI=
X-Received: by 2002:a17:907:9703:b0:c29:4fcb:2886 with SMTP id a640c23a62f3a-c2a15b739a2mr686473666b.39.1789910073446;
        Sun, 20 Sep 2026 06:14:33 -0700 (PDT)
Received: from ehlo.thunderbird.net (ip-077-020-009-205.vkd66.pools.vodafone-ip.de. [77.20.9.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67daf380sm2634379a12.12.2026.09.20.06.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 06:14:32 -0700 (PDT)
Date: Sun, 20 Sep 2026 15:14:30 +0200
From: Conor <mail@conchuod.ie>
To: Jonathan Cameron <jic23@kernel.org>, Chang Yu <marcus.yu.56@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shi Hao <i.shihao.999@gmail.com>,
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: add as7343
User-Agent: K-9 Mail for Android
In-Reply-To: <20260920010448.114fc597@jic23-hlaptop>
References: <20260907210042.32552-1-marcus.yu.56@gmail.com> <20260907210042.32552-2-marcus.yu.56@gmail.com> <20260908-dinner-shelve-1d61e19ee3b7@spud> <20260913014203.2bae2222@jic23-hlaptop> <20260915-gleeful-jester-c8114edf28ff@spud> <20260917034823.03940ac4@jic23-hlaptop> <aq3rdBcMw1XcHnkL@gmail.com> <20260920010448.114fc597@jic23-hlaptop>
Message-ID: <77D15400-6ECD-4661-8733-E1F4F85077AF@conchuod.ie>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20 September 2026 02:04:48 GMT+02:00, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Fri, 18 Sep 2026 18:55:00 -0700
>Chang Yu <marcus=2Eyu=2E56@gmail=2Ecom> wrote:
>
>> On Thu, Sep 17, 2026 at 03:48:23AM +0100, Jonathan Cameron wrote:
>> > On Tue, 15 Sep 2026 18:11:17 +0100
>> > Conor Dooley <conor@kernel=2Eorg> wrote:
>> >  =20
>> > > On Sun, Sep 13, 2026 at 01:42:03AM +0100, Jonathan Cameron wrote: =
=20
>> > > > On Tue, 8 Sep 2026 19:13:55 +0100
>> > > > Conor Dooley <conor@kernel=2Eorg> wrote:
>> > > >    =20
>> > > > > On Mon, Sep 07, 2026 at 02:00:41PM -0700, Chang Yu wrote:   =20
>> > > > > > Add binding for AMS AS7343 which is a 14-channel multi-spectr=
al sensor
>> > > > > > with i2c address of 0x39=2E
>> > > > > >=20
>> > > > > > The GPIO pin is described as a generic GPIO for now=2E Bindin=
g design for the
>> > > > > > more advanced measurement/LED synchronization use cases are d=
eferred to
>> > > > > > future patches=2E     =20
>> > > > >=20
>> > > > > Unfortunately, you can't change what you document, so picking s=
omething
>> > > > > correct now is needed - even if the driver doesn't use it yet=
=2E   =20
>> > > >=20
>> > > > Definitely needs an outline of how it would be backwards compatib=
le and
>> > > > an explanation of why not now=2E  Sometimes a portion of the bind=
ing is
>> > > > so uncertain that we do kick it back from initial version but we =
'must'
>> > > > be sure we can extend the binding to new configurations=2E  Norma=
lly this
>> > > > is one of those we are fairly sure, but not entirely sure cases -=
 or
>> > > > picking between two options where consensus isn't being reached=
=2E
>> > > >=20
>> > > > Chang Yu: This sort of things needs discussion and is one of the =
reasons to
>> > > > go slowly=2E   =20
>> > >=20
>> > > Ye, I note that there are 2 more versions of this since I left this
>> > > comment, but you seem to be on top of that=2E
>> > >  =20
>> > > > > > Datasheet: https://look=2Eams-osram=2Ecom/m/5f2d27fff9a874d2/=
original/AS7343-14-Channel-Multi-Spectral-Sensor=2Epdf
>> > > > > > Signed-off-by: Chang Yu <marcus=2Eyu=2E56@gmail=2Ecom>
>> > > > > > ---
>> > > > > > Changes in v2:
>> > > > > >   - Add the LDR, the interrupt pin, and the GPIO pin to the b=
indings=2E
>> > > > > >   - Fix node name and unit address mismatch=2E
>> > > > > >   - Include MAINTAINERS changes=2E
>> > > > > >=20
>> > > > > >  =2E=2E=2E/bindings/iio/light/ams,as7343=2Eyaml        | 69 +=
++++++++++++++++++
>> > > > > >  MAINTAINERS                                   |  6 ++
>> > > > > >  2 files changed, 75 insertions(+)
>> > > > > >  create mode 100644 Documentation/devicetree/bindings/iio/lig=
ht/ams,as7343=2Eyaml
>> > > > > >=20
>> > > > > > diff --git a/Documentation/devicetree/bindings/iio/light/ams,=
as7343=2Eyaml b/Documentation/devicetree/bindings/iio/light/ams,as7343=2Eya=
ml
>> > > > > > new file mode 100644
>> > > > > > index 000000000000=2E=2Eb06d445b92b3
>> > > > > > --- /dev/null
>> > > > > > +++ b/Documentation/devicetree/bindings/iio/light/ams,as7343=
=2Eyaml
>> > > > > > @@ -0,0 +1,69 @@
>> > > > > > +# SPDX-License-Identifier: GPL-2=2E0-only OR BSD-2-Clause
>> > > > > > +%YAML 1=2E2
>> > > > > > +---
>> > > > > > +$id: http://devicetree=2Eorg/schemas/iio/light/ams,as7343=2E=
yaml#
>> > > > > > +$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
>> > > > > > +
>> > > > > > +title: AMS AS7343 14-Channel Multi-Spectral Sensor
>> > > > > > +
>> > > > > > +maintainers:
>> > > > > > +  - Chang Yu <marcus=2Eyu=2E56@gmail=2Ecom>
>> > > > > > +
>> > > > > > +description: |
>> > > > > > +  The AMS AS7343 is a 14-channel multi-spectral sensor with =
i2c address of 0x39=2E
>> > > > > > +  https://look=2Eams-osram=2Ecom/m/5f2d27fff9a874d2/original=
/AS7343-14-Channel-Multi-Spectral-Sensor=2Epdf
>> > > > > > +
>> > > > > > +properties:
>> > > > > > +  compatible:
>> > > > > > +    enum:
>> > > > > > +      - ams,as7343
>> > > > > > +
>> > > > > > +  reg:
>> > > > > > +    description:
>> > > > > > +      I2C address of the device (0x39)=2E
>> > > > > > +    maxItems: 1
>> > > > > > +
>> > > > > > +  interrupts:
>> > > > > > +    description:
>> > > > > > +      Open drain output active low interrupt pin=2E
>> > > > > > +    maxItems: 1
>> > > > > > +
>> > > > > > +  vdd-supply: true
>> > > > > > +
>> > > > > > +  ams,led-current-microamp:
>> > > > > > +    description:
>> > > > > > +      The driver current for the external LED connected to t=
he LDR pin=2E
>> > > > > > +    minimum: 4000
>> > > > > > +    maximum: 258000
>> > > > > > +    multipleOf: 2000
>> > > > > > +    default: 12000     =20
>> > > > >=20
>> > > > > Rather than a custom property, the tsl2772 uses led-max-microam=
p:
>> > > > > tsl2772=2Eyaml
>> > > > > 46:  led-max-microamp:
>> > > > > 81:                led-max-microamp =3D <100000>;
>> > > > >=20
>> > > > > I wonder if the same should be done here, or if there should be=
 an leds
>> > > > > subnode? Perhaps the IIO folks can comment on that=2E   =20
>> > > >=20
>> > > > I don't think we've ever bothered with a subnode as there only te=
nds
>> > > > to be one of them=2E  Given the enabling etc is all hardware cont=
rolled
>> > > > I'm not sure a more generic LED binding makes sense=2E I don't kn=
ow that
>> > > > much about the led bindings though so maybe it is worth doing a s=
ubnode
>> > > > just to use the leds/common=2Eyaml definition of led-max-microamp=
?   =20
>> > >=20
>> > > Could always just put a ref in to leds/common=2Eyaml and not bother=
 with a
>> > > child node=2E I'd stick with the additionalProperties: false, since
>> > > there's lots of leds properties that probably don't apply to a devi=
ce
>> > > like this=2E
>> > >  =20
>> > Sounds good to me=2E
>> >  =20
>> > > Cheers,
>> > > Conor=2E =20
>> >  =20
>> A quick heads up, adding a ref produces the following error when runnin=
g
>> dt_binding_check:
>>=20
>> properties:led-max-microamp: '$ref' should not be valid under {'const':=
 '$ref'}
>> 	hint: Standard unit suffix properties don't need a type $ref
>> 	from schema $id: http://devicetree=2Eorg/meta-schemas/core=2Eyaml
>>=20
>> So it looks like we can just put led-max-microamp, and not add the $ref=
=2E
>
>Ah=2E That's a bit irritating as it is assuming the ref is to get the
>type rather than to make the connection to the standard definition
>of what it is=2E  Conor, what is the best way around this?=20
>Maybe a comment to say where it is documented instead of a $ref?

From=20the error, it looks like this was done incorrectly, but impossible to=
 tell for sure without the snippet=2E
The ref I was talking about would be at the  top level

>
>J
>
