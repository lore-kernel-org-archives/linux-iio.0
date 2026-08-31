Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A93C09FE
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162803; cv=none; b=B/DNrKS0iX1TOnnAQoXUapaD/Vs6wUVFzNRTx4w4gPrO55AoWII8rBQgQ8cVLHoXPtGCx48WIw8T5RuCiD7OXobu35lqvunzfEmYMonmsglF27+jM1dohQA18iFrhADTfXOKywhFuBl8AJSAwpWUKXadmNX8gpWPPGqbMef/gLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162803; c=relaxed/simple;
	bh=hK1ccgwDNp1FnzcsAtdYzKJecB9ZZzZ+gBEbbt719S0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=R3697wj0c71QNn0x5ZKVzTN9LwKoSlk710uANX7e6SMdihmcPxnlmdGElBpuOG4JVA4WZ4DxUQ1RY7r264IQ9w/JqhfCQ5KiTJRyimR1t8UTfnKkpyi9djJjr2jrTXUfgp638bH1Bm7ri9L01A4UH2MQF3E4n4EcshQTak7kLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dbHc4avP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dbHc4avP"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1670dad7a8so5811966b.3
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1788162799; x=1788767599; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8L251g5odZgk7HDZdrpqhA2gS9bIplpKlO5QvsDcLvo=;
        b=dbHc4avP35WRm5PY3nGdcWm9N5X2pyk72HxyAcfEeFyiKyd4E/rB13RKtcsiwITMpQ
         I5dATe8FgJkZX7ZZgIIKNBGrqb+BeaNVHbYkeAKjO9FdjvcY7cWBaxu7DKl3+2sRDtYT
         JynLrrXsoYuXT0qRAjL7Qz6Qei75w/FcM/PymEo8gHn3Iqy4N0wgVXNhi9+P+aCUo06b
         pxKq1p5MFKFufGSiTE8kP4ZHZKgzs2XYeR2Jg/U8Toh0iVIjT9X0R8DJ27ZbWJAdbXrS
         GxmDoKpf6DTi/YNLIUeyDBQtj2jVy2NLZTdeWHdA/9vvNL8keHdybc+myPHFX6mgeBwJ
         jMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162799; x=1788767599;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L251g5odZgk7HDZdrpqhA2gS9bIplpKlO5QvsDcLvo=;
        b=UKD51bNPTg/l+wWE9zLXOk6sRMpzjtnFqHj4mesfSTmTegKMsD+s/swxR3lzYNmx0u
         EZ4SHp15ZKSDASF334tDbfr2U5nXwNXUt+g11NrZ6TmdVFn5fbowdL/A6oyvXkI6iXgR
         dxXjSrITWFqTvt48ZbiTlgC9ZSxOt8MvaX1BEupq5RH7MofUPtn70DqlAma7gEunizuh
         ucMaoQpVVGKAskdTTy6v1AONih2ZKTG1NkO5uScmMOa7+N9zY9ZY+rMsV8QpZomDhc/t
         XCwD9dUKwTF0jOkZziYGS/1vS0285JyaLPpLrQjA2amvvo6Vwb3WdqCIMrkSyU2ZRjIU
         YyJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHQsstygnC6Fwa4N/6CyiXl0AWNqSb0UF+Jcwq6t0gQa6p8GUge955W9mJ4BuKcgFAOe/ysLBFkw8=@vger.kernel.org
X-Gm-Message-State: AFuF++knm/fsdBOmrhDmYJV5TeLZLjoenP/mMUPfz29atuVMbY84DSEl
	Na23yKeEKAFJNKzGEa6ZptL2n0pjNGJbqwUhXNMwzdmYvrGr/VyOy/JzgONyl1HyFF4=
X-Gm-Gg: AR+sD10bDgrxeYG33J3YzzxbM66ZjYiYLh8Ld59PNXbVDnb2j1OxztqimZKp6khgFg2
	VusNhwI/mD1gNoqAw/3+eIUMiW0K2h1j2iaSm/JqeQO6flPaNhotU+CrXgQTigGdzT+NKvdA+Wj
	hC7CXi7iDE8JEQwk6IJlBdRo84GjOqHGrxHnbOEskP/IMNPEbI+dUEbIHPLA9r+Mf08ZjSmksOV
	GuIEm1gNMnwKDrClvXDUSRa6w+18ptZfrKX58+dNDW0AplnPTSjTOqCa5MufOidU9jfw5kCHbwt
	hD1C0mPemErAi2lp2wiOYtHhVwU2nm7kKE3L2Tb9o67u5fa7PXi1xmGQNtGIJmOvTpGqYKfPdKJ
	e23zv94WCxq3+y7oOAeJI4DvPce4BjjAVImF3b/AvL1Pae3GqhF4xMrmt/8zKZ9KM/YsTg+VTzC
	I2q3rdGbZq2w+KR6eyNnO4lLO+M1+lLvdxv2K4FSKHBAcCQRqFlhfN0YXll5o2NWiuU52jmVAlF
	gxov/XKpzzGjrgmq5azQ3eTja5Jbg3coAqcCNmNQ8QS
X-Received: by 2002:a17:906:4fd4:b0:c25:8878:3e09 with SMTP id a640c23a62f3a-c2588784f62mr520709566b.22.1788162798639;
        Mon, 31 Aug 2026 00:53:18 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fa3ddsm378656166b.45.2026.08.31.00.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 00:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 09:53:17 +0200
Message-Id: <DL2YT4S4U7C4.2CPGBR94G01FD@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "Marcelo Schmitt"
 <marcelo.schmitt1@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Luca
 Weiss" <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
 <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
 <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net>
 <apRGQVfPKWHvE2Ct@debian-BULLSEYE-live-builder-AMD64>
 <20260830201950.63838-1-jorijnvdgraaf@catcrafts.net>
In-Reply-To: <20260830201950.63838-1-jorijnvdgraaf@catcrafts.net>

Hi Jorijn,

On Sun Aug 30, 2026 at 10:19 PM CEST, Jorijn van der Graaf wrote:
> On Sun, Aug 30, 2026 at 12:03:29PM -0300, Marcelo Schmitt wrote:
>> Having a closer look at the data sheet I found for STK36C61, I noticed r=
egisters
>> 0x13 and 0x14 are not listed. Does the newer part has ambient light sens=
ing
>> besides the clear channel?
>
> That looks to be the "STK36C61-A Preliminary Datasheet v0.9" hosted by
> LCSC [1], which I hadn't found before, so the cover letter's "There is
> no public datasheet" is wrong. It documents the -A variant, however,
> and gives PDT_ID as 0x93, while the part in the Fairphone 6 reports
> 0x95. It does agree with the device on the colour-engine layout: RGBC

Just to chime in, the datasheet I have access to (STK36C61-A Preliminary
Datasheet Version - 0.9.2) there are a few changes compared with the one
from LCSC but nothing too interesting:

* On the overview page LED current 228.75 changed to 218.75 mA
* ALSCTRL1 register (0x02) has different values for BIT[6:4]
  (17.92 -> 143.36; 8.96 -> 35.84; 4.48 -> 8.96)
* PDT_ID is indeed 0x95 - maybe the previous version just had wrong
  copy-pasted info?

Hope this help.

Regards
Luca

> data at 0x15-0x1C, a clear-channel gain in GAINCTRL 0x4E, and the
> shared GAIN_RGB/IT_ALS fields in ALSCTRL1.
>
> Yes, there is ambient light sensing besides the clear channel:
> 0x13/0x14 are present on this device despite their absence from the
> datasheet map. They behave exactly like the stk3310's ALS data
> registers and are what the illuminance channel reads. The ALS word
> tracks the green channel exactly, proven by the x16 gain step moving
> both from 25 to 404. The sheet's own text does describe the function:
> it defines DATA_ALS[15:0] ("16-bits ALS channel raw data"), windows it
> with the THDH/THDL_ALS thresholds at 0x0A-0x0D, and calls FLG_ALS_INT
> "the Green channel out-of-windows event", which is consistent with the
> ALS =3D=3D green behaviour I measured.
>
> [1] https://www.lcsc.com/datasheet/C49230205.pdf
>
> Thanks,
> Jorijn

