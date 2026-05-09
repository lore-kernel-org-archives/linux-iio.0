Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C928641E
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292669; cv=none; b=QCXbouT4TI7RgFC38BBhESS1EyPPyky8Qv1TJX4wCLi7tw7AI4+hpOhZGQKapfELn0q3QZy2/2C4pXTF725GINdcZ5vjGjR5gFt6/BkByu1Jm+qohJQgWQ9yvas1VEauRmaRD1FHhFdXzz+3okJSIDaZL8VPvoh+RFaMCoWQjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292669; c=relaxed/simple;
	bh=CtyBJIHEMXeTx+OQ89mGTJi1wKWp98iLsNOdUkH0gMA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sgYGJE+0mQjSyXfBMGds0yXzRuEZ8GeTMBEumQalD+HvXK8TIQCu9I4jy/Tf4HtTVxEe4ulndVJYjBTgwIDb5WNJliWtP7qnLj9uMUwrBjIQwsQkJCQDV1VX+JYPipPboALwowUAHonf0DPtojRCqfS7h9z0IqFzg126bjF4CAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrKKYBld; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrKKYBld"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bc763e2ba8so1151175ad.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778292668; x=1778897468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RjCKRbJRSQKr1LfgQvzKMjrsHO6zupespXjoGUDqQfo=;
        b=VrKKYBldRHNCsnF2pv8lykVP7HRUYkmaL8qkkrpxDnuL353CRjmgHlD8gNAOhBZxr9
         l/4k3YF2CYwylWUWinYbPlZYp4W4wMeveKRnDaA3RFJUtPs5ZJKXVxYewP/nLM9OoiYX
         hHHeYeGDCfFmOVOwi+q4/lYI+YmvJlvWS8T1bn4eki7MSLIRpC1/P6WTX5nFUYSiaXgJ
         s8Xm/XDPVumqJmyDDjEDSkXRNTU1pxLWjtQXsh1BkIKe8vV4DxX0S9J85gPun95OVdnE
         dBwisT+0Gv04v+XTJvhQDdOlmYLcm8wmi86ls+zMlsvg2QTdEsuMbjFqELZIq5s/v6Sx
         BmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778292668; x=1778897468;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjCKRbJRSQKr1LfgQvzKMjrsHO6zupespXjoGUDqQfo=;
        b=WO+OlTiZedTdw3LG+iCrmL/v6NpgPX6sKG7AQefyc4uQDaG41cUOlCQlqn/hGkzjXp
         LaYA9iIKpehmKHjiKioGsXl7ub2MxvUwIfeSOJBZ/DZyDZLZFhT4U65ci+8IpEt5bfb/
         l8QoV3mHwmqMguMERm0Nkr/xEyDn1qA51H+P3DtkX8RN59F/O0xDtKV6D3KTG0Y8RIgI
         i7C0izlrECB17Teh9qMcvlSPCII+4yaQzPgpF0qNwxKoRwH0uxa8rc/r+He3mSENKyFS
         hgDpGoZQsv7TLjqmM1CfWT0aHpRbsuJN5vI5bJ1OO2z38iuLplL6n52s6LpVJg5dBf5Q
         vDiA==
X-Forwarded-Encrypted: i=1; AFNElJ/FR/YAX6s9ubsKsYYtK29URKRW0imHI42mfwElZRH4vB51xQudFfU+DrlRcUe0/NyIpXmkKipHPdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVECDg1vX/JTCKjJWFIzG2sO8NcVlmZnOVBsq8QAAVQwQz6eYQ
	pFhKpHM+o/owghxS0LLbcOCepzgjEIXxMdrb2qqzMimWCzp2l/05uG9f
X-Gm-Gg: Acq92OH/3TbPNB6M2w+dFWYMetjesV9j3qxxzVUTfZzuta5wcLLKwTgdwl8lo/fba7u
	f4dER8u2A+0VkmQ5DtAkgsgV0ny0UkuedKaRD8pm1vqt/PK2QDWXCFiIV0/Nyf174u891F6kv7s
	98q8rbED6cHpqu2YYdV/VIvHVj8RsZvJ3U9e1s1cxQKOpscRraRRUP6g9Un57Ot2MwInJTNLVNH
	d2nEo6O1C8TAO3r+y1lCfccs0DINSeunW+5HRK5X0MP4BmseEHpSBplml3vDQNLKSA+UApX0tnk
	7aM1LUgpWf7RRO1c2wF2vBAuP5tu24eFz2AM9bzWFkVAq7UHKVbOw81b4sVpaGN3tQoTL1lqo/r
	C4HXDSs8OIByGELeczr4mXIcSl8BFm53U0VSbRJnCxHaWHb3XXY/gfhKCGRtTsIMhK3dqNOsemV
	ShumECzun7xOErH7/EyoKWSJ2VZEt2lwOLnk6mfxpp7wbQIxU=
X-Received: by 2002:a17:903:390f:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2ba79285966mr148109665ad.5.1778292667755;
        Fri, 08 May 2026 19:11:07 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:791b:cfa1:9b60:879e:786b:b8d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d52f1bsm36602935ad.37.2026.05.08.19.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 19:11:07 -0700 (PDT)
Date: Sat, 09 May 2026 07:40:55 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
User-Agent: Thunderbird for Android
In-Reply-To: <20260509013745.80478-1-dennylin0707@gmail.com>
References: <20260509013745.80478-1-dennylin0707@gmail.com>
Message-ID: <F55DA41F-BF95-401B-BF6C-0FAF93EB2704@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 9 May 2026 7:07:44=E2=80=AFam IST, Hungyu Lin <dennylin0707@gmail=2Ecom=
> wrote:
>This series adds devicetree binding documentation for the
>Analog Devices AD9832 and AD9835 DDS devices=2E
>
>v3:
>  - Require spi-cpol in binding and example
>  - Use generic node name (dds@0) in example
>

Hi,

Thank you for the change=2E

Ideally, multiple logical changes should be split into series=2E For a sin=
gle patch you can include changelog like this:

Signed-off-by: =2E=2E=2E=2E
---
Changes in v2:
- Add SPI peripheral schema reference
---
 =2E=2E=2E/bindings=2E=2E
         | 94 +++++++++++++++++++

If reviewer specifically asked to update, you can mention in the changelog=
 as well=2E for examle:

- Add SPI peripheral schema reference based on review comment from <Review=
er Name>

Replace <Reviewer Name> with the actual reviewer=2E

Thanks,
Sanjay

>v2:
>  - Add SPI peripheral schema reference
>  - Fix example by adding clock and regulator providers
>  - Fix SPDX license format
>
>Hungyu Lin (1):
>  dt-bindings: iio: dds: Add AD9832/AD9835 binding
>
> =2E=2E=2E/bindings/iio/dds/adi,ad9832=2Eyaml          | 91 +++++++++++++=
++++++
> 1 file changed, 91 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832=
=2Eyaml
>
