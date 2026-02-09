Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9B2F9D9A
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621220; cv=none; b=EagZzkV/NPpAzkqr09e5SkgIn3hXTf1oC2qWG2gHzN1OyZswihxu9zBgswgRDVdQ4F3sz0TXwbgnwLVm+gPOT2VxKaSvVXwZ8cHhopsYQRAgIP77Sm1lNjfaMfHcTIY/Z6AASekprOuBDo81GXn9S/vgTTaqxpA1a4a8mLN8R8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621220; c=relaxed/simple;
	bh=wjhPJySClgeUMyCJuXTdPR22ZbR2363nYldOD0ul2/0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=q2mxrtxuSoCfGPl8j8C9tLFbHgFVnRBr+aaMUTv4rRQh5z+RrLbWRA/JtRV/7KQRweXAzo+G6wujgo5N3wwZvSAHqx8qAJ2MBhqb/KioitAl6oJPEMxrPH6cfa4UrNjf2Lg6/cHK2EnQ9G+14Mh5AUqLCKDbXyb5cH2ynTVJBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRooKwF0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRooKwF0"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59de0b7c28aso4742877e87.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 23:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770621218; x=1771226018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJTcZlZbFHgUhIybFH4cWwk7Nh3ta/uxgKGllk07sVY=;
        b=eRooKwF0vCfpmtbR5z7o7JrYBoQ3suRDgEGIIh3ia554zWhryLlSc5nwMgjkVIuivr
         l2kbaO6rE2HXqw2VoJwORSshlBHbFw2gmKRMFRBuMY4wvbwmlxgZBWhQecUZPnBQNquu
         w8B4o19nfDZbaIJ1j4+OgNLmk42FhSmxFKhEv7ZBhSvE8oD0T/QcEsM+lLWlqv15ZdN6
         Et+FsptXbXtwLYo4t3Urk2UTpPZO+kdyU9z+0bAmonHSlHqwzI5FEIN3wiVeno2GfTrb
         /ZXOrk9I8WBhTEifYiyEuC6sP6+pOBhqS7Z/wK23E7u3bleduzQAm++OPs7xl8AvSLZ/
         eSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770621218; x=1771226018;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJTcZlZbFHgUhIybFH4cWwk7Nh3ta/uxgKGllk07sVY=;
        b=IeXGkBobqnNZbZcbux/GEXUBFyP9dBmbz2rGypSE4Ovu4tRBLICKKvtQ5ivrlmNck+
         c3SaKBKZR7BxG35hJBJxqPnRtF6LKE82b0S+yIWZfoDx5sXBjkTKcBGmBSxthZuv0elB
         8X/+sQiEbeoVCUaTKydeGjcdIsav8zaibuboSraZ72Q0pVXUo17des6MkPCqNwlQFLbG
         Fru4rYUkk/WXvAGti2qjKXMyz4SiS6dWND0CCjQBpwlWK8J6kg238cVsqMUwEbauD0G4
         Wg50eK4vtUfXAEci0i0KP1N11flkZ6H5BLzQqQFQgS4pAdIr6r/9DPpx+0viiEfu5mTy
         /g1A==
X-Forwarded-Encrypted: i=1; AJvYcCXFV0P2cxqO2QHPBXjSKy8ZXxCfASR1wRPJcBz1m0BbivBmLYo/H2maG89DoqANYG6mMui4J6SvLqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+e6t1TGDWU/rYqbRLy20qpMHwTPte5/j3n4m1GUbQ72QdglOW
	+vvM4GOVb0ACHdKed3sioQBxcfPmK8SQUUYLI6krw1gvI4Zgk9z1jEi3
X-Gm-Gg: AZuq6aKUlUVUPNaiIKte1QMVyaTYQ0jkPH7g7z2mZBLoY3ChNJhQ4O3E9tMSajP/gZQ
	tM4jfVoXb66chpoipjU22SIlA9Dp6E7N0o3Flgvcp8p2mVw449ly5fL4Irz1phc/QR0AybzueNI
	nkBcv5xm3V5DLA2HCJ5MXXCMMrMPE6xFPbAUoufphotqd89LiQst6y2/mbW7UJNKwEr0pqaMoS/
	TH1l5OI5eXFSepZoDGrPw5QFFdYvm2SdL/6KJ1U5pA4lXSrV5CFeH5+vtg5AvjDqEDCrY3gsFpD
	1EEIrBLXrcAuow1EFpzP7TQh3kNfskmDUCgtTrwL24kvBtlmkkUV1U9cVnSaxOq8EKEIRvfvc0t
	4P29n8f8++P6oE0cWW4cBQoI36oLMHzMEFFX0Dd8uBPzZq2tbFslqqh+8rtKN793xvoML4Q+Pau
	CrU+iSeZTqwV8aV+8oFYYt
X-Received: by 2002:a05:6512:a90:b0:59e:49f3:658c with SMTP id 2adb3069b0e04-59e49f36647mr2144179e87.49.1770621217578;
        Sun, 08 Feb 2026 23:13:37 -0800 (PST)
Received: from ehlo.thunderbird.net ([178.137.105.239])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44d29975sm2395771e87.66.2026.02.08.23.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 23:13:36 -0800 (PST)
Date: Mon, 09 Feb 2026 09:13:35 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>,
 Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_01/11=5D_dt-bindings=3A_regulat?=
 =?US-ASCII?Q?or=3A_cpcap-regulator=3A_convert_to_DT_schema?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAL_Jsq+JzAnvW3zSC7Y=dpWTKMUwFfTOuAnMS21d+F_W=5ONeg@mail.gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-2-clamor95@gmail.com> <20260206230922.GA254792-robh@kernel.org> <CAPVz0n3EGCSLUX7jTLve0x0z4uW1yexViCwkSQLY2d_4r4qkjg@mail.gmail.com> <db9115ca-2c8f-4b5e-89ce-f3b934071a59@baylibre.com> <CAPVz0n2KwqPw88JVcPzhTQ2n+GKzahkrEThjjrqm0CSdjKTEOw@mail.gmail.com> <51eddfc0-9f23-4a7f-8729-19775d834c0b@baylibre.com> <CAL_Jsq+JzAnvW3zSC7Y=dpWTKMUwFfTOuAnMS21d+F_W=5ONeg@mail.gmail.com>
Message-ID: <20E2821E-3A3B-425B-8E5A-AEC36A2AB9CE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



9 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80=2E 00:37:41 GMT=
+02:00, Rob Herring <robh@kernel=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>On Sat, Feb 7, 2026 at 11:32=E2=80=AFAM David Lechner <dlechner@baylibre=
=2Ecom> wrote:
>>
>> On 2/7/26 11:25 AM, Svyatoslav Ryhel wrote:
>> > =D1=81=D0=B1, 7 =D0=BB=D1=8E=D1=82=2E 2026=E2=80=AF=D1=80=2E =D0=BE 1=
9:19 David Lechner <dlechner@baylibre=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5:
>> >>
>> >> On 2/7/26 3:20 AM, Svyatoslav Ryhel wrote:
>> >>> =D1=81=D0=B1, 7 =D0=BB=D1=8E=D1=82=2E 2026=E2=80=AF=D1=80=2E =D0=BE=
 01:09 Rob Herring <robh@kernel=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>> >>>>
>> >>>> On Fri, Feb 06, 2026 at 07:28:35PM +0200, Svyatoslav Ryhel wrote:
>> >>>>> Convert devicetree bindings for the Motorola CPCAP MFD regulator =
subnode
>> >>>>> from TXT to YAML format=2E Main functionality preserved=2E
>> >>>>>
>> >>
>> >> =2E=2E=2E
>> >>
>> >>>>> +properties:
>> >>>>> +  compatible:
>> >>>>> +    enum:
>> >>>>> +      - motorola,cpcap-regulator
>> >>>>> +      - motorola,mapphone-cpcap-regulator
>> >>>>> +      - motorola,xoom-cpcap-regulator
>> >>>>> +
>> >>>>> +  regulators:
>> >>>>> +    type: object
>> >>>>> +
>> >>>>> +    patternProperties:
>> >>>>> +      "$[A-Z0-9]+^":
>> >>>>
>> >>>> I thought it was said on the last version to list the names=2E Con=
sidering
>> >>>> you already have them below, better to put them in schema than pro=
se=2E
>> >>>> And pretty much all regulator bindings define the names=2E
>> >>>>
>> >>>
>> >>> What exactly do you propose? All those names will not fit into a
>> >>> single unbreakable line (more than 125 columns in length btw)=2E Pa=
tch
>> >>> checker will complain about this=2E Duplicate pattern properties fo=
r
>> >>> every few names? Please be a bit more specific=2E Thank you!
>> >>
>> >> Making checkpatch happy is not a hard requirement=2E If you have to
>> >> go over 125 characters for technical reasons, no one is going to
>> >> complain=2E
>> >>
>> >> I already gave an example on the last version=2E It is just a regex
>> >> expression=2E (And note that you didn't fix the $ and ^ either=2E ^
>> >> means beginning of the line and $ means the end of the line=2E So
>> >> the pattern currently won't match anything=2E)
>> >>
>> >> patternProperties:
>> >>   "^(SW1|SW2|SW3|SW4|SW5|=2E=2E=2E)$":
>> >>
>> >>
>> >> And I hope it is obvious that you are meant to replace =2E=2E=2E wit=
h the
>> >> rest of the names separated by |=2E
>> >>
>> >
>> > David, thank you for your suggestions and I did not want to offend yo=
u
>> > nor Rob, or ignore=2E Using this large string IMHO feels a bit wrong=
=2E No
>> > offence, I will use it if required=2E At the same time I was
>> > experimenting with possible representation and come up with smth like
>> > this:
>> >
>> >     patternProperties:
>> >       "^SW[1-6]$":
>> >         type: object
>> >         $ref: /schemas/regulator/regulator=2Eyaml#
>> >         unevaluatedProperties: false
>> >
>> >         required:
>> >           - regulator-name
>> >           - regulator-enable-ramp-delay
>> >           - regulator-min-microvolt
>> >           - regulator-max-microvolt
>> >
>> >       "^V(CAM|CSI|DAC|DIG|FUSE|HVIO|SDIO|PLL|RF1|RF2|RFREF)$":
>> >         type: object
>> >         $ref: /schemas/regulator/regulator=2Eyaml#
>> >         unevaluatedProperties: false
>> >
>> >         required:
>> >           - regulator-name
>> >           - regulator-enable-ramp-delay
>> >           - regulator-min-microvolt
>> >           - regulator-max-microvolt
>> >
>> >       "^V(WLAN1|WLAN2|SIM|SIMCARD|VIB|USB|AUDIO)$":
>> >         type: object
>> >         $ref: /schemas/regulator/regulator=2Eyaml#
>> >         unevaluatedProperties: false
>> >
>> >         required:
>> >           - regulator-name
>> >           - regulator-enable-ramp-delay
>> >           - regulator-min-microvolt
>> >           - regulator-max-microvolt
>> >
>> > Will this be acceptable? It passes checks
>>
>> I think we would rather have the long match string instead of
>> repeating the rest of it multiple times=2E
>
>Yes=2E
>
>105 chars:
>
>    "^(SW[1-6]|V(CAM|CSI|DAC|DIG|FUSE|HVIO|SDIO|PLL|RF[12]|RFREF|WLAN[12]=
|SIM|SIMCARD|VIB|USB|AUDIO))$":
>
>There is the yamllint of 110 which does have to be followed=2E
>

Amazing! Thank you both for your suggestions=2E

>Rob
