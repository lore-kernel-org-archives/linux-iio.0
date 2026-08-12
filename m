Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CC33A00C
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561198; cv=pass; b=BUlKXqeuvmRfk5U6EqBAkcsh+jTxrpBbQytWYp2Ib4cOwaV675Xh73HQUpR1lB8FofliLw3NMYOlpqavIBJ6iAQY1L6H+dAWE76YWep/Z+b8vp6pliU+19BKwcYuCwJKiPN7Emx3c1yNq/e6GnHOV6egpEDSdSuPVA6tvVjnIBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561198; c=relaxed/simple;
	bh=5YpsLrQd66mt/oElMkbWRCNsoeN3vBlsEy3jrovT8is=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hfnVHMn4xiQcnJayhEkKmjU/zjmqGMrAtS4nJxyPqdQ7yi5uagW7C9GOHqHr3NqywJmaenE2p0lW73vmHLztGcrdukRQOpKeHPbSO2EQ+V8ocvYyUU1MsUhZxfersp0ePT/1Ow8pPhkYkyCQu4BjyeW5KkECW3V269aAeW9OG0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtCHCBM4; arc=pass smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtCHCBM4"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c166aef4f02so79623866b.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 11:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786561195; cv=none;
        d=google.com; s=arc-20260327;
        b=bwfKvAlFfE6+rhkiJMpWj1tvCDUBmHJcG2pgOgO0mHabQEmwDtI3SZBPMMTKBvHUkc
         mH0MV7zXZPpfZwMY0ywGvcL2wxCvJX/a+FNaw4Paw8opeytD24/BnMprgYr4cfavZntN
         gosvJALPEOvt03hFH5TuNFu8aVVwAVaJ1df1eryhO/W96ViLN72dQoU3mosHmwp4hDF7
         qO6Cx4nVkwxMFGXnkNuarmubtK0blsD4IBpI0GzDMTeB379BNH5ZAHAF3FhJQmZberOb
         c4cVnAJJWeWJdGjKdVdxeB925fk/4F3OwS042xr77nLTBTsBnpvfkB1eYwl9pfycXU+x
         PBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5YpsLrQd66mt/oElMkbWRCNsoeN3vBlsEy3jrovT8is=;
        fh=mN8Ldyc0GnCihpOZnbTT0XqRZriBRaxpTIrucs4x4MI=;
        b=n47yNMg19u8qWw8sfqZTlEseBBDXP2O0AP1JAHPPhMr8oGV1bTqmpAL56EbR3/Pxdc
         JcKT1OlMoYLw7lk1uQYUCidMfN73dIxzYKV3SdR8q0blZQ+dmFUx5l8P8O82hsFSFV/7
         xwp3Ikp+LUCBe3dov69Rq+6MMjKDY1YzciV+mo7SwbZ63rpeaCopZovDq2x6bm+pmfw9
         h0zI6lR+5i9NmVf/RRI4YkodA6BPCq9br/YMFv78mYV/3kmh6cKx1ZiOpvuR6JZgtzYv
         GNqZqXA0NK5f1KNwk4Ud6A3twJaQkMNGSvJDUr4/MZ3p9qqLGd9ab907WA9earFzKVAS
         jYtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786561195; x=1787165995; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5YpsLrQd66mt/oElMkbWRCNsoeN3vBlsEy3jrovT8is=;
        b=OtCHCBM4LiYOH9ymaLv9fpa9fKBO1JdzlD7hoVceFgPUK42O7WbaYNSFj9ul1yqbOu
         IMRkkdEF8t5IMKZj1uqEhJJzZNlhKukekvuWrd0zfCIbZmOXnU2ZKAXknHnxlMQ31/R3
         PNfzQbjCd3kbGE5gSq72bzmnOk2COM5qLhJ2bSrt08zU6776j3KV0kW/wP4j6TOvaM/K
         BaZf0D1QVFl0pcVxqAvLyCkwY0eoRLHmyjdikZ3nHw54fJBeUyN3wMycfabMoee52kpY
         N3hizElaCe+/GHWj1wGvE4EEPmSLplg9ZSBUO8jU0J67Vuwfv8VqhS0iQbYwYoSk59VQ
         QOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786561195; x=1787165995;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5YpsLrQd66mt/oElMkbWRCNsoeN3vBlsEy3jrovT8is=;
        b=RDnwTFDVuqSaGKEVfyMdH8uz7wXdGFxWrbTiqGYo+ydkN31NDD0LKrLd3XtOq5UgnJ
         kz7SGfxao5T/Qn2vpGeT7wyrqF2Y6axiB2NnWvvAphQa3mq8BsawMS/9nznzlUM0Ahfm
         bLz9D2SumtqspKea7uztxTnxvUtLPk/7LH6fFT4+yKBMNCUt5vgOales/o0iOTOtIWSx
         sLjZ3o9ICe24bI9x+2pmZst4NP08ImaLEWMfm5K0IX6QWm66p0cF7Dzrm5eFUiL4H3vY
         D3B7BMrm5TBruPLYGf3cukmdlowMkPB89/ohGf3tMys67zp6WOeePlmj5jEqcd9me2uE
         QKsw==
X-Forwarded-Encrypted: i=1; AHgh+RoY5/VrrK7QHUR9vBME3hDGZZqckfUpm7z37cTGDu7QG2HNxNXsITGYy6xPObe+MX/LJ/Yy4CY030s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAYWX+62bfm0UpGjJr9ssk/2+Tu1ZKii19WPCs9vU/idCFhfZ
	vgYUiyXfsJaJWNLxqxooXBwRvmvWQqtWjbAvOV3LT+KQiL//u3BFRgIfA8+OFRvwTuqV+APlnd6
	3eqZFNen1MsrOHwNAkzhwByc+BIDem8s=
X-Gm-Gg: AR+sD12EDU2RxranyS23kpdpHBUufJEBNQ7vGDQOsyXJtUs1giJQv1Z2rAkdxQVCGOe
	C7tNTlwRlYmkgsN1Rhudocg7JVHq7J1DtapyNwAgQwL2/IJmjcbjXL0lfSF2JsGcOoQ25mrF2Tz
	StzFRGimQc1MtLRvzJsFlh9CDa598YqAUKS/I413+bSGItgXTabqaySd/Fo4ar0BBMD+Bs1rost
	6mLlL5l9g+DFjSifKgzEWFfuqtKmqZ9zwNAgY6gGfb2Gp8gJmZjl9XlnoVPpeZgYtf2kFEa4BKy
	d7/q+SylJqwSu5NgQoBk0TlSU+rkhLNi3oorKv/DoY4a
X-Received: by 2002:a17:907:608f:b0:c12:1651:17b2 with SMTP id
 a640c23a62f3a-c2108e5bfb5mr20737566b.9.1786561194813; Wed, 12 Aug 2026
 11:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shehryar Ahmad <shehryar.amd@gmail.com>
Date: Wed, 12 Aug 2026 23:59:43 +0500
X-Gm-Features: AUfX_mxI720OVCqWCabncilafTVACGGIMPo2NOHI0XObuFT7-5YQDH77NnxYQqk
Message-ID: <CAHR+CoTo3yX=1-pfnkxu_UM2jXx0Fi8j6ZU6T-vRR4Pgb95mJw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Move adis16203 inclinometer driver out of staging
To: nothingchang@mirrorstack.ai
Cc: Michael.Hennerich@analog.com, andy@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com, gregkh@linuxfoundation.org, 
	jic23@kernel.org, krzk+dt@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, nuno.sa@analog.com, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sheng Kun,

Is this series still being worked on?

Thanks,
Shehryar
