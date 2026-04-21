Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AD3D75D3
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785275; cv=none; b=pVNqNIKZXrFctXygkSgj3NDbcjjhXsRLrjpmDiDvxv3AAe8WHtjTBALlRxEDbKKb1HsIrVid0CH0WhlOUV/QtS0rT+x7nf7AyYaG48LcIRovGoDh9bwFpYh0ApCaVZT3ZfmsyfDGMy2gJ0M6H0CHUdZyJsM/fYpW5oKYDaj50VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785275; c=relaxed/simple;
	bh=7EyOtCSbA/MNqO9r85m30Fso+muEy41ZG9rxzZaFloE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ANAVVMlU3NM6MFagcpWvRe5ahb3OJf80YrXWcCnHKv9Sox592kxwuOvpVoKmKkcSRAuEzVbD+Ob271Q/eAwgnQIHEwqPJf3PMEp8JQhGcqGbtK8+GiVf67MvHwAk74xKKcuNrXI1E2lCnmZ4SFfkhKR4ZRi6j0PAp0Kgg1nGreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8NGv0Em; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8NGv0Em"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so4908077a91.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776785273; x=1777390073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tQC94cW67OjTFCFkm/U0f6ZM3VUVqGPZN5GOy+LfA7k=;
        b=S8NGv0Em40PZnI1GdPkHNNX0L3wZ763dzNgK6rdLGUA/MdynHlWcKlTqn2jUiXq6V+
         KXQ2gfYL7XZhbL0QJCQ5k5b9Jr7E1bu5fHoJLbeO637AWaPouRO4QKSifVXKvDMbk6Hg
         OZaK1FttbWdvsFO2mc/KgQgMKvT+zeGl49ZEMhp7bYIW7LS1avolvIgP2rmxPY+dZuHK
         2dVn0OTRLVTZLfdCj+Se80HCk/pLY84kTG3Mdou9QLTfeiIDuLQdlFKQ7B21oqJvoZNC
         +8rq9hidT6CJ4j6A9l8GAivIIojjTVvlwKYqDsZMEWt9VyuquOjw81ffI0KHtkM8Ar9Y
         Rl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785273; x=1777390073;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQC94cW67OjTFCFkm/U0f6ZM3VUVqGPZN5GOy+LfA7k=;
        b=XP75Udlk62itlD+S8vhObduutsKRCtDvNdb87ce1pocoPDgDIzPXbj2m3mE20wNxDd
         dfybvOLvJ0Ly6vBKpVlwut22pyNG1XcQokqTbKAyYbii5q3sFe9s2820hB6D/mX60VCb
         YykbEDUPx7A3uFva3LyxjCKszneW7CTtsoAGJrk2U1xqqeqC1pk6G2KUPI1EYR6S1tNG
         5q6p8lWZeYitxdrexjVamTe1m8KJ14XuyVWodgZxUd9XWrgvikj029ypFiT6AuGiE+ze
         Sq7n4/EAghA+x3SupypfAtf6tBiE7kcbBDr//SXUji2G+HrAgPZ/09gMdyjGLwpsc1cQ
         HFyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JV48vIPUcNbz/lwLlM6QA8Q5EF0Eofxsl1Jd6NacJIuXKCfkV90PwEyQ61tsMzbdnku1g7590YjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2ZhQPj6YfNX/dU0DLVZ95V494Q1sAgkqWwEz3brlvDfQysUA
	kfru3PpTFxBoflKqzWNB6mwMoBGtnIC4GCR6lRWS7BRUz0RlOeCnnlyK
X-Gm-Gg: AeBDietMnQ4y+2hvEqjjRQrWX33NHMefKiTRv2yqmmv/7eIR3kWpKjQN2jQZH5hhLLV
	ucjzy9hhBgrrxwDgIMPyF1Dvi2dr/uCLBgKjQAxRgP+rGdmDFwaXYF7iwePusNESuMGlpZw3CSO
	4HmOlg4jx+eFvlxKz7weXRERa4iAc8ZxTm5PPaISeq7uhwLpn2Tz+kaesN5Sp8foFeRDGRIRe7u
	EC/QlZUY8dwtsoCzDuA4rtvRJAryJPAlmQ3+mSanTGMEUHnoW/nyh2HfuheICb7lIC6HWJcdwZe
	fl/1eIVvKIPIilLna/NC6RqyEvWTameYRG5bruOV2sh7MOeTqJQnPvXZhdyRoJ7+/p0o8u/TVYA
	8XXE4B0xmBO7UAS5khtD/pJVFfOFYo1XWNXmDdhzOD9eOvqlkgySsHBdhuyHlupyW0VnEXXtX5O
	ws5mvG47vBO/UVCdnj1D1oCXD4BwWsA0gbddKz5t5tw2sw0Q==
X-Received: by 2002:a17:90b:5106:b0:35d:93ff:2855 with SMTP id 98e67ed59e1d1-361403e159amr17352430a91.8.1776785273004;
        Tue, 21 Apr 2026 08:27:53 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:aab9:674c::6127:5179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a9fbsm18241885a91.11.2026.04.21.08.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 08:27:52 -0700 (PDT)
Date: Tue, 21 Apr 2026 20:57:36 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?ISO-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 demonsingur@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for iio driver(s)
User-Agent: Thunderbird for Android
In-Reply-To: <20260421161950.2f2cb53a@jic23-huawei>
References: <20260418211336.1800221-1-sanjayembedded@gmail.com> <278F44B5-A962-470D-A0F5-CA7C6F11FBDB@gmail.com> <aeYGrMh59pQEgWx8@nsa> <20260420125035.6a098add@jic23-huawei> <30AD35B9-E7DE-4F9C-AA15-4EEAED583F16@gmail.com> <20260421161950.2f2cb53a@jic23-huawei>
Message-ID: <380168C0-2E8A-4BEE-AB3D-4837962B510C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21 April 2026 8:49:50=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Mon, 20 Apr 2026 20:44:37 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> On 20 April 2026 5:20:35=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>> >On Mon, 20 Apr 2026 12:00:15 +0100
>> >Nuno S=C3=A1 <noname=2Enuno@gmail=2Ecom> wrote:
>> > =20
>> >> On Sun, Apr 19, 2026 at 02:46:10AM +0530, Sanjay Chitroda wrote: =20
>> >> >=20
>> >> >=20
>> >> > On 19 April 2026 2:43:36=E2=80=AFam IST, Sanjay Chitroda <sanjayem=
beddedse@gmail=2Ecom> wrote:   =20
>> >> > >From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> >> > >
>> >> > >The listed maintainer analog domain email for Cosmin Tanislav is =
no
>> >> > >longer valid, and he would no longer maintain this driver(s)=2E
>> >> > >
>> >> > >Cosmin suggested adding Nuno from Analog Devices for further hand=
ling
>> >> > >this driver(s)=2E Add Nuno as maintainer=2E
>> >> > >
>> >> > >Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> >> > >---
>> >> > > MAINTAINERS | 8 ++++----
>> >> > > 1 file changed, 4 insertions(+), 4 deletions(-)
>> >> > >
>> >> > >diff --git a/MAINTAINERS b/MAINTAINERS
>> >> > >index c981cbdff500=2E=2Ef86a398d1a35 100644
>> >> > >--- a/MAINTAINERS
>> >> > >+++ b/MAINTAINERS
>> >> > >@@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c=2Ec
>> >> > > F:	drivers/iio/accel/adxl355_spi=2Ec
>> >> > >=20
>> >> > > ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>> >> > >-M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> >> > >+M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>> >> > > L:	linux-iio@vger=2Ekernel=2Eorg
>> >> > > S:	Supported
>> >> > > W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> >> > >@@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/ad=
c/adi,ad4080=2Eyaml
>> >> > > F:	drivers/iio/adc/ad4080=2Ec
>> >> > >=20
>> >> > > ANALOG DEVICES INC AD4130 DRIVER
>> >> > >-M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> >> > >+M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>> >> > > L:	linux-iio@vger=2Ekernel=2Eorg
>> >> > > S:	Supported
>> >> > > W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> >> > >@@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/da=
c/adi,ad7293=2Eyaml
>> >> > > F:	drivers/iio/dac/ad7293=2Ec
>> >> > >=20
>> >> > > ANALOG DEVICES INC AD74115 DRIVER
>> >> > >-M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> >> > >+M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>> >> > > L:	linux-iio@vger=2Ekernel=2Eorg
>> >> > > S:	Supported
>> >> > > W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> >> > >@@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/ad=
dac/adi,ad74115=2Eyaml
>> >> > > F:	drivers/iio/addac/ad74115=2Ec
>> >> > >=20
>> >> > > ANALOG DEVICES INC AD74413R DRIVER
>> >> > >-M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> >> > >+M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>> >> > > L:	linux-iio@vger=2Ekernel=2Eorg
>> >> > > S:	Supported
>> >> > > W:	https://ez=2Eanalog=2Ecom/linux-software-drivers   =20
>> >> >=20
>> >> > Hi Nuno,
>> >> >=20
>> >> > As discussed in the previous thread https://lore=2Ekernel=2Eorg/al=
l/d6d8660e-c5d2-4f02-a5fc-2f8b49d2e0d7@gmail=2Ecom, updating the MAINTAINER=
S entry=2E
>> >> >=20
>> >> > Nuno, please let me know if you are okay to be listed as maintaine=
r
>> >> > for this drivers, or if someone else would be more appropriate=2E =
  =20
>> >>=20
>> >> I'm ok with it but maybe a better alternative would be to include
>> >> linux@analog=2Ecom? Jonathan anything against it? Should always have
>> >> someone capable of taking over and more important, it should not bec=
ome
>> >> invalid (at least it should be less likely) =20
>> >
>> >That's fine by me=2E
>> > =20
>>=20
>> Hi Jonathan,
>>=20
>> Thank you for the confirmation=2E
>> I hope there won't be any maintainer and also this List should be added=
 like following, right ?
>>=20
>> L: linux@analog=2Ecom (moderated for non-subacribers)
>>=20
>> similar to what some company has added or without () also should be fin=
e=2E
>>=20
>> Accordingly, I will send next version=2E
>>=20
>L yes, not the bracketed bit=2E I'd imagine it's impossible to read if yo=
u aren't in analog
>devices?
>

Yes, as per my knowledge this is vendor specific alias, which generally ve=
ndor use for maintenance and review of development under their umbrella=2E

Someone can extract mails & discussion using lore like platform with maili=
ng list search, however individual won't be able to subscribe like public m=
ailing list=2E

>> >>=20
>> >> - Nuno S=C3=A1
>> >>  =20
>> >> >=20
>> >> > Thanks,
>> >> > Sanjay Chitroda   =20
>> > =20
>
