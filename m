Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793953169;
	b=PJMVfmBBGA6W82bKF9b4vG9HEcWd9795GpYfdTUROEIX/8cc1+IgCZEoWKquAonIlw2O
	 h/TduCVyUoybabVl58xUURqzGT7xwJ6Y4Xt23UiLRr5FuKMVGdMyl3D+jnPrhEa64CMjQ
	 EeriQzqfTIoMdGWt6gHUkNQaqINuOz5ZL/o6GFNMnKALpRyjGiJf9A1posZ9/lkccvl5E
	 PlUypVDPNuE9bykR7g9mlKhebDHva7egImy5ZXnmXLgRsL++773ODyUHbtUFHV9+KEIT0
	 yKBbqdAvblzRJLpMXDljYJ1ILN0H84QN6dtkK1XEizjopYolnNQRHBCoS9OyL1zNYZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953169;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=me+YsFg/UguNlsclaHDOFcsO/BWyeEqtiGV9h/nQi2Q=;
	b=jdCdxHQLyNQTVeQ5gHqEQTprQciMKZ4gHsMcL7nS59EeOYVL3lliqQqtOPYvVg0YttAf
	 BLLch11Ljqil2/IFPDRDeQ3AcQLIrQiR8flMRjgk82E9Kz9D/89V931GOTkbLlVtIlnxW
	 EjEcM+xkgfmR7gz0IDA0CiNGnqwf8Ye2Ww2tsTUNnDnr0gQMJEoyTY/t+7GljbTL/TO+a
	 40E7VvEGq65RFuPzf45KVjIzTTSahAx1uJb/d7N0ky0QyRlO1Jkf9qINzp+HncjmaMWJc
	 oY5dELAfJ+7zniIt/38wNgaI6ajtE0kxClME645t9SDbZWCepYCJyFfK/44KoI5W8nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=SjmtjADK;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=1p3fSd+m;
	arc=fail smtp.remote-ip=85.215.255.80
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6849606A330;
	Fri,  6 Nov 2026 08:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6849606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=SjmtjADK;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=1p3fSd+m
ARC-Seal: i=1; a=rsa-sha256; t=1793953159; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jKZCLnk+Xbwq4o6e7DEJ5rCfjLf4wR0gEW1dpNaGF6fsBkYhHvn/6t29Toi5EDOQgf
    FHzUJTQeqz86Ljc2pIzCYPNFDf7i8wKgDZEq0vLA73NPgrCKvSKzSb8jZ3L1jxgg7k8n
    XKeQrcFCEz8vGzKLPR/Z4upCtztNLqxIzneGi3k/YXUPPrvZk8B5KhcObcQJoZDo4WIB
    MLi4eNAiZgxsNkyxG0jgZwjTzK3F8Yrq4gteZygBVglN9cmHrVE9jrPYiuO1FPs6l7Tv
    ffuDcNaMt0oEBSMGVrP1Z54ALqOENEeg2dndo5jAaNMdh3qxXkx2DH5elr1bKytFCgH+
    AJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793953159;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=me+YsFg/UguNlsclaHDOFcsO/BWyeEqtiGV9h/nQi2Q=;
    b=VYCP278NFN3a7rv8oA5E7xIDs9nxtpm1DA3dtzYxZfDklHo6JmPG3+OE56ay+F8JEI
    DueFzuLSEtG8bygpdbJrsXscEQjiDA+LEGO8p+pVMB3juxiV33KUqUP2jK9WsvM+muvU
    /+qAn9LcUeNxPS1F25KB6e77AnP20AiSuympGoC84e4S3ugPUOOZHtl6HKZuyy03b2rf
    9Jee8S6qoGQPuQfUDH9xJf0I4s7aNyN/ixVK8J/FRS6HQbkTuO3cZWaPpIrRk7VxKOVr
    tEFh/AMTXKOFz2D9Kbz5HAXU7dcq8a4HMbQsZXY+BQVkJBWBLjvMH0Fv7ZbrCWVKJpL2
    SGyg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793953159;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=me+YsFg/UguNlsclaHDOFcsO/BWyeEqtiGV9h/nQi2Q=;
    b=SjmtjADKEciE685B7nyc/A6+hTCqeD5Zdbgcu0kb8guAgoedHeaekIstv8ZQRjbD6n
    Apc1WhA0zh8R+QxHv79ZtlJIY6Es10HAyOKPI+Ibh57MhXx1JV4GE5V5BFCi7qkLUdH3
    j1aMGFR5gePTt305kXfDWsZR+98A3uybXDc4X7tIJ0hoeG2S33koJ7Z73bbnARhXc+Ea
    TIm4jjRiJaz8sYhR4ppN26UIEiE0v6TksaPCL6u2Z0z3VJQUKQVr6S0gaRf7a21qWZVU
    ctNhQ9pIXGmJvDPGWxtdoBgGH5799pIh4sDGNY7Buy/2zSBWfL/HLmdBtAZGfBX6pfqZ
    qZig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793953159;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=me+YsFg/UguNlsclaHDOFcsO/BWyeEqtiGV9h/nQi2Q=;
    b=1p3fSd+mwfmO6OyifTLFMD6zWTrkPyczBnyF/XZvLfvoXUVD0Ro0gQdAO+5x0o3IVo
    kHUnHdrt6dPBFm3ZWGBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrVjZoMy8iN4frnsPsBQ4l+mfK4O7kvgww6TmAq"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22A68JIlvF
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 6 Nov 2026 09:19:18 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <f74bf2cc-c459-4b9c-ad94-c60afcaed3cf@kernel.org>
Date: Fri, 6 Nov 2026 09:18:47 +0100
Cc: Olivier Louvignes <olivier@mgcrea.io>,
 Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Joshua Crofts <crofts@kernel.org>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <05798D24-C5A7-41BD-8FDF-F7075F2F0D01@goldelico.com>
References: <20261105213210.87457-1-olivier@mgcrea.io>
 <20261105213210.87457-2-olivier@mgcrea.io>
 <49e69d9c-6cb1-453f-bbf5-e2202f97e4ef@kernel.org>
 <30B040B3-D371-443C-A66D-11EF89FC7C63@goldelico.com>
 <f74bf2cc-c459-4b9c-ad94-c60afcaed3cf@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.10)



> Am 06.11.2026 um 09:11 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On 06/11/2026 09:05, H. Nikolaus Schaller wrote:
>>=20
>>=20
>>> Am 06.11.2026 um 08:05 schrieb Krzysztof Kozlowski =
<krzk@kernel.org>:
>>>=20
>>> On 05/11/2026 22:32, Olivier Louvignes wrote:
>>>> The X1600's SAR ADC has four auxiliary channels and none of the
>>>> touchscreen or battery engines of the JZ47xx ADCs in =
ingenic,adc.yaml,
>>>> so it gets a binding of its own.
>>>>=20
>>>> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
>>>> Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # LX16 - driver =
only, no real world test
>>>=20
>>> Drop, did not happen. Even comment says it did not happen!
>>=20
>> What did not happen? Are you expecting a software test or a full =
hardware test?
>=20
> Testing of this patch did not happen.
>=20
>>=20
>>>=20
>>> Otherwise please explain me how this code was executed on a device.
>>=20
>> 1. add decive tree entries, 2. compile, 3. install, 4. boot and load =
module, 5. check sysfs
>=20
> And none of above is in this patch, so you just confirmed this patch =
was
> not tested.

???

Sorry but I can't follow you here..

>=20
> Again, please drop inaccurate tag from this patch.

Ah, on third thought I start to understand...

Because you look at *this* patch in isolation while I looked at the =
whole
series.

Yes, you are right - the dt-bindings is not directly tested (indirectly =
it=20
was because I copied the example from this patch into my device tree and
it worked). Then, the ADC driver was tested (but not the hardware).

So this tag should not simply be dropped but moved to the driver code.

BR and thanks,
Nikolaus=
