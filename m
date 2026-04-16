Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7333DEE1
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316599; cv=none; b=Xqks7OC0gom82nZIx/N9ZQK1nrKXMObjPBn2YHE9hKuVWf20eSnz+z9unxZc72ajkSbEhSQEwNjKr6+wcgghD58AjGuDDsMADUFMwb7g8jxUVoXb49seWmwOVwOHklaz/m9pnCeN4Uyx69r3BERBQt6UrDUlseSkWWb/BmOOk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316599; c=relaxed/simple;
	bh=ErOju+FcY9c7z9EGW1s3sB86ljFENQ47/b1uI0BiaPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tltm0+ZSnqsGH4tdT+qTzdFfnNU9PN5LgKXKPw0wvzWAqIGOtL3MS9H4hPJwFdcpQl0KjvsnIVzlQm5AV50PL4hVzQ1yL6ZwXbjCoxQLAu0+wQVJhFyGqmRhd3vxv7mYLJXBz2mR/uZqDtWyK9Qso7Io9nRYoM9dSEnJMX6u9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLtWZC40; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLtWZC40"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82d0b68837aso4140761b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776316597; x=1776921397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9FS3RI7hqWwxnGocikiwh9JFcYzQC8GRgSQaPG6Uzw=;
        b=OLtWZC40gagMbn/5ruj3HugUdcIYiViItuXGhfZFMTD4DLRxMldoeRhL/rDoAoz5Dk
         4oE43lDLaY9faEHeE/0NhT5DAxK6JwjMlxxaAfJ6TiBQzhmH8Uc9sqL4JpVDPblOcVyX
         ZSkDpolNrJQutiKlMiKkPx5L4kOTN37z6TRLB+yyhTinLMEVSCwslMcSrk/dCLgcQiyO
         KlpWPuMG8+A4+QgEKGJ9GkRhkdAtp7dUUeLIz7ADtH/l5WMDPaTnmhzbSKAI/9bYP23K
         LnrfEXKirs0QLMWQ+ZqKECIfKhHyWlKc4xxLJD288e0VXEAqiEsWBDxY3QOQ1I2Fo+m7
         p6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776316597; x=1776921397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9FS3RI7hqWwxnGocikiwh9JFcYzQC8GRgSQaPG6Uzw=;
        b=F86JcvScPfKbE0/h79WLC3HBJhk7Zd3Ak4y0PV3s5aXM/TOLy5kkmbs7AH/6CF6Ku/
         kvaaCgmEJ5WTECHJaTbbSmdSqiRIOKXdtz0bDp3y+kE3OTkHTrNw24yO1OTRlrsB7gSi
         /L1Z+dKRBlIAT8P4ny2ooY3JW6hoV1hYOuq3Xxkr+gTS4hMP5ETAJiRNnd74VEMCyxgL
         PDAsEbU5gHgKEH4jm9zuN0Jyw098+ELGDI1nAR24cHmUiBSOvhVN/q+DXC3lX+RwqmUk
         1a6Lf8En2i/2xEEMV+NH8CAHuHxNlxlB0EREgP4UpXs/h8pNJoe1/wteamJjJlOnFZzr
         21kw==
X-Forwarded-Encrypted: i=1; AFNElJ+lS2h/nuti3TLTteCrTg/dB16xUZuw0uy+Lz+y2EYVidamTHa4fA6S5mqfX4gWuONEAUr+B8HIbnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqx155itiXj8zo6SzTfAqSYSNzKEsWhlCHF6yleH7NFZRKiyen
	CK4vQD77NwA413iDyGRMEz8ihHquJkX9k/Zxp88zVsvTmkR6BhTd+BPn
X-Gm-Gg: AeBDiet4oJ0mN9PdPUwy4D2njp/QAR+Sb0oUXGRYfik+lSE8o8CypdpPx0C15emqjdH
	g9V/8d+e/QDsvBQw/j3DQEhQv5es1w5xTmNkBSN0eyaM/0PL2iFCiI8l2EtYXWOb/1OSOUVuUyo
	Isk5egXC+pFq+hhXqeefAWOeYM4NSBMdwvzGLDlzuZr5B6t32me828JdnX9SUm0/sAPVUwM+cuu
	rqLj6kQn7eYuUqh7Kj5/mh9m5BBlOviDhNB0Qdc/VO/qkpXIiKH8cWWJ2vC+rIr5ZvxtvVLXytu
	lwco9mERXObwpn52ZCpLzes5YLu6oAMmLLNgaRQryUuFhfFJozUBZBhfqINvF/SIAw75BaKlW9u
	B2fYr54H19jRQZoKeEdsPQfPQI23//dpLjH9Hx1YsrceFgWvvs1Mzq9+cj+1q86j6eDxiTZ7c1X
	3dzZ0eilDIk/c0hB1bF7Oef65PvmLFUD2VXlTik3DNG+iE/sylTmHH9u0RWuZY4oWCiuML/A==
X-Received: by 2002:a05:6a00:1ca9:b0:82f:5a27:10c9 with SMTP id d2e1a72fcca58-82f5a271a59mr7951298b3a.51.1776316597220;
        Wed, 15 Apr 2026 22:16:37 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67476a5fsm3948364b3a.60.2026.04.15.22.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:16:36 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: accel: adxl313: small cleanups and error-handling improvements
Date: Thu, 16 Apr 2026 10:46:28 +0530
Message-Id: <20260416051631.551250-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi all,

This series contains a few small cleanups and robustness improvements
to the ADXL313 IIO accelerometer driver.

The changes modernize mutex handling using devm-managed helpers and
guard() to simplify locking logic and improve safety. In addition,
error handling during probe is cleaned up by switching to dev_err_probe()
to better handle deferred probing and avoid repeated log noise.

No functional changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Based on:
  <linux-v7.0-rc7>

Thanks,
Sanjay Chitroda

Sanjay Chitroda (3):
  iio: accel: adxl313_core: Use devm-managed mutex initialization
  iio: accel: adxl313_core: use guard() to release mutex
  iio: accel: adxl313: Use dev_err_probe

 drivers/iio/accel/adxl313_core.c | 20 ++++++++------------
 drivers/iio/accel/adxl313_i2c.c  |  8 +++-----
 drivers/iio/accel/adxl313_spi.c  |  8 +++-----
 3 files changed, 14 insertions(+), 22 deletions(-)

-- 
2.34.1

