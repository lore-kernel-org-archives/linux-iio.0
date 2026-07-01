Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689763BFE47
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933715; cv=none; b=tKewV54E2eu9FM80XDLYlHSYGPYg41rDRV7oMDVSuqETw3GHMv6k2o9/a8tB0YRnAwXzoNrk29NBdpbn2+QlzceppqlXomp3TfRicb1/6NnWAPKdVUGdoxuAD0FEVTzNuho31/DUWr9A520Lj9qOyuNncg52CaJw5AFdv8hlby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933715; c=relaxed/simple;
	bh=kYxAmL4+vDGixpRhm9WSeoPiYPjYqdH+eJ1grKcucW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iPIf7tqwbYZxnmqXVLUKjH4QyQXnX/zxyT6U4GeO2xJpKSUgFb6N25Hekfi22RMFJe5zoIvwTnDjzYvmMvScmDL5FzLrdcLcSD03YmH76d0+0xoUDGysH+Ep/mrPDCu03sESibg81LyWkg4joQ6dZeg6JLucr4PYX7BamPSSHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HopDi3g6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HopDi3g6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1048636f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782933711; x=1783538511; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vjlz6Sou4oUC6PMziaJquaQPB+bVCyS4KogfPbQtE34=;
        b=HopDi3g68BqktaKrumWYz3PfJNvbPMOoJLZREfhSV7jtSCrP5xJLIGIIb9DNQShK0Y
         S2kWGPyI2ROTg5EXfwwycLEyjy/YSfWCt59hZIhijkLGv2CGfS1zyJoPLPSKbFhff3K7
         tSzncI6Q32+WJNcrsi6yFKdFLf9QJSS7PNhO8uJ2fHsl/gS1+aPpjKeM+6z2L+5jAhnT
         Ed5wn8/+4e7ErkFpDUcifERD8uGpEHB/DSp53X96FzO6k+Bp90j0M4LtRc30c8IAkaIh
         RLLGhttNvuiJa0k3Ri6/dwGafwt0VcOR7+Coyz4mFrv82hTh1GFXvRjEInOLvibl9dPv
         uaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933711; x=1783538511;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vjlz6Sou4oUC6PMziaJquaQPB+bVCyS4KogfPbQtE34=;
        b=HI09DYHkDnX5usCcmVvRY7Xh0y5UCsB8s1TaVIivxP1vaEiR1F6HwgJ7kc0r0yiMpf
         Q6fsUj4wgpve/GGmDsJob3DNf3XQMG4+B8lP7bgyin+Av5N6Mrt3WT9oMuteZXcj5X0S
         6UABm4ugsEN1dGyOPG8xCutOydBHJ5hYfCUawGWoBrMc7Q0x0UTC+WHmZufIfTq/7V5f
         mlmg8dO1M2DsY6yuiItkS6wN07RSpXoJcDfOqJC10+uWsk/qok0jHWE8xUc510HlSUjb
         CQXWd9VSCVRcs2Ycjf+XqL6XIqFetOnWDjvoIIEONTd3ZgckYRJnzXfPWCsY27V5Iras
         rzwg==
X-Gm-Message-State: AOJu0Yw9UPaw+qwXX9334qsX3B1TgOlrkoqYnUwfHxICbp4FrRL/Hr6Z
	H3CxSTzsMaEznEClTPIBITFqkbFaLirwgoC0AqZ+CatYpP73mfWKAdOIOcpWcQ==
X-Gm-Gg: AfdE7cm6bkvDBIhWU/+kYdN1q3vr7wNFbkT9xg90YIAXKpHNyvK7fZ6/2Y1pHlUJlVX
	mDNsi9XJh0omXrLb3IxYeRQp1cwS6Ys5/9aRbTYIifcv+QG0SRJ2UJ4/iiY04W24EAUSr3upNPx
	OgeW/fA2Zd+LmOAOYBj8UrPyPIRwPgxs7b40PGuzH3mUx1/XQIXI9DqLWaoia/idMEgn8ZDzgNP
	sA9DTJhjsTCgu/MxbhQt5Zy5x+Yzo6zub2V5vCIjT8ysruHaPF2IBOl663YZGlaDmysAtDle36+
	VncGYOjx1MjAic4XB3H59MCsMUPgVrKVjdAzhLcL8qyVPi/nnEEiNbMxj/crCrgwp5OGDQTQjyF
	jTRkjYkS76XiUsH3/oDLDkh+R7OB2grI1E7OlaZC5Y/2EVNUjg+mHrIFax9xvI87AdjpiNSbPp1
	fp82wFPHsbXip4RoybVN4jHhXRfzkeoUPwi8KnMYXod059V9NcrboKG4bZoKX62wnIGwmymeUDF
	z0/AVTn0vRd0+j481xtCVWyqjZPgUszQ6ZZ8zSb83cRI9zw/8t1EKgAk9wqXqsTBFkJfh+DOJiM
	EZ+fXaRYkJaqrycRBhk7abUp59fovAUqPLEFsDxq6mDtRjezzi4mxAE=
X-Received: by 2002:a05:6000:46c7:b0:470:2fb1:3db5 with SMTP id ffacd0b85a97d-477b52962ebmr2062536f8f.30.1782933710433;
        Wed, 01 Jul 2026 12:21:50 -0700 (PDT)
Received: from [192.168.71.52] (cst2-160-240.cust.vodafone.cz. [31.30.160.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dbe617b1sm2081838f8f.16.2026.07.01.12.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:21:50 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/2] iio: adc: add missing 'select IIO_TRIGGERED_BUFFER' to
 Kconfig entries
Date: Wed, 01 Jul 2026 21:21:45 +0200
Message-Id: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkElKvtKdLB1qyVQUYgg+nvSY
 Q5zmHmgcBYuMDUPZL6kSAxVdNsAHS7sjOKrg1GmV4PS6LyvEJ4UwyY7ek4FV0PU2dWOnR6gpin
 zJve/nZf3/QDp050TZgAAAA==
X-Change-ID: 20260701-add-adc-kconfig-deps-b2cc49b98417
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jonathan Santos <Jonathan.Santos@analog.com>, 
 Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782933709; l=946;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=kYxAmL4+vDGixpRhm9WSeoPiYPjYqdH+eJ1grKcucW4=;
 b=7Hp7kdzo835EdJpfYEgRCDYqTK+drpskGXpaCMlOpriAVTX5iBgNRymcYDlzC0P33rhOS6+5v
 1ebYip9vb4PA0CquY3PcaRhqjTqjDEulzW3Cwi1lqqRhtM3TJQ3ZK+1
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The AD4130 and AD7779 entries are missing 'select IIO_TRIGGERED_BUFFER'
entries, causing potential build failures.

Steps to reproduce:
1. Run `make allnoconfig`
2. Run `make menuconfig` and select any afformentioned driver and
   modules it depends on.
3. Run `make .` and the build will fail due to missing triggered
   buffer definitions etc.

I seem to have stumbled upon a lot of drivers which have incomplete
Kconfigs, expect more patch series per sensor type.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (2):
      iio: adc: ad4130: add missing `select IIO_TRIGGERED_BUFFER` to Kconfig
      iio: adc: ad7779: add missing 'select IIO_TRIGGERED_BUFFER' to Kconfig

 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)
---
base-commit: 022cc99d5d1cdc76b09b424a769c3cfea3812378
change-id: 20260701-add-adc-kconfig-deps-b2cc49b98417

Best regards,
-- 
Kind regards

CJD

