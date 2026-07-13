Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D39285CB9
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915065; cv=none; b=Soj0z71Yws0B9C/xn8kpHtmWbroJQDCEhl8Wn7dUMNL2zJtE5iosSNF4/Lp0uDWuDwk3ox9b5AiDFugR2cdi2kTixiakJVUCIzv2HSVV8E3pI3hLrZpdzmvkd68LlMUx804Q+4cLQo06qDIBCHlWaR5b/jtSqvv++CLpcBwcEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915065; c=relaxed/simple;
	bh=dDoA6AH7eaCvDR+PPCikry8mWrSod2j07+j3hpgGt4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jhx1L8aRmLFw31ls+CrhRa/Q15kuE9wxc+f8p2diyf+3gDEzMv9X8RMtu3ra8i/mJ8p8H1TDoRC3xh8DBMnOfRw+p3EqsRf58NGim0iuO0hDeQW3y1KAdpwJVWPvdekC/NzodHAhRzhKSm/LPwKYjZCGGv34mJYBMauscyVStfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBJrYPRZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBJrYPRZ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1845194a12.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783915064; x=1784519864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rat269dSHB6S4X7EbEcwUyliidjahM1q8N/e9ebFA1M=;
        b=TBJrYPRZcTf0X7RcGKNrT8Rc6Yg4wHF0QUzOT8eZu24wvV6DJhwWAFVID1yAnBTgGF
         vB0pzIcrWmuHOI2lql7JsLRqkxNnDv6+/88KaVBwn0YGsRjvloiAgGJTN8JieTgR+MiA
         pCGT3+hZtVEkAdk6CThWpO5+aOpzGjnp+8u8hcaKeNwq8Xldyyp4n1g4pbgNDBTZTkop
         pm7di9hP6OZHvp+oYLgOlYsIKm7qR2FK/9ehNMRzWCRp5Y9HlZTjDVh/kFai/QurM0L3
         ocU7+swg5Mf0qScRa+TZUutldtuAmaVMB5awnAEXlP7mm2+bUAcEzXpG3I2tCJrHchwB
         3jCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783915064; x=1784519864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rat269dSHB6S4X7EbEcwUyliidjahM1q8N/e9ebFA1M=;
        b=rRBOG9v4r+crdndY0iPioZKSeFwCdjprTQCLpVUp+XTTDj4vcl1qTmzdcA7+BCJanS
         d+Fs1lsXrxDjQkROqh0frx1JhCVVpuavdEe8HhgiR4oxRmh16Vs1lgXsxDMuwIqfqAm1
         0pNqtYZQD1vTHCMBuSNmC2Bme3NnRq2BltAS/h/Tg7pKubaUkJ31off7i6BjMiWvFgX1
         ZgNkkHnd4GyL80r4DqxN+ytWdL/WnZX7mJj8l99RrwWv5vs0ZzJpM5r3QlRmFT+aNBI7
         JEcL93bPdpthbuCdz5Ihk1Xf1uAE7iuUXtZ+UqPvs7uLGD0bAD4WGA/QgsEVh0W5tttr
         Emvg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/g6JT8uYs5uRttQt5gUpt9vjf+kdMZJbOsoOzldUpor50OwG48fnk2a3K+NbGBKUButlmWOEP7/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcws9rkZhTNxa/73+a7xB0sWWhNrL0kyWeEN8+Won1aMK52iI2
	W1hitt0KSGbCb3Jz92fCIkOhN9ecMfXVE3qlqTcz14H1ddzNBNGcZhA=
X-Gm-Gg: AfdE7ckTCjPKXfiDwRRiPOGWAbeSVeEeMViedS7cA3lij2TUioBlK8aj8iUUVRJ4Y7D
	qF6NO7UGFHY10/0+Moi8/6fYbTmA6NNqS03B6yMdsumGI+zwdBMzatPqhoNvSJH4ycStr6y8FuU
	5cMF27PSTCY5hzYUY5hzPyxXazEuH4zXPDNo0Nefq07A30RHgNtALt/tCoUKqQaR9rg+upzfxLy
	wySEIobU+daKwgwmm6/BtHAKpCIhf4xIRVnKhd3rdJU73u8ARpXoenoBxdsWf17Mgh268BphmCQ
	w+0IWifBcpFkcEY5uWm7yJULLOdWCZmj/8XaAgC3ziPbh3E2uce4oSoSexhtjrjmHF/0ixhYXOd
	5vXZHvDn1fhDRrO43VrZ7QvqOWAxA9BEtPNXAe+pR95ZzfelovkgnuVWfZC+HBJbdnV2tPTbajz
	YV/97qfYtPE0CnTKAe2PPdZ08HJNaHGvW+98YyfSYIJArdSmfBYL/9
X-Received: by 2002:a05:6a21:a43:b0:3b4:b216:2b26 with SMTP id adf61e73a8af0-3c1107612e3mr8703202637.5.1783915064008;
        Sun, 12 Jul 2026 20:57:44 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm60862704eec.4.2026.07.12.20.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:57:43 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 0/4] iio: light: opt4001: Fixes from code review
Date: Mon, 13 Jul 2026 09:27:32 +0530
Message-Id: <20260713035736.11346-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a number of issues found while reviewing the opt4001
driver. All of them date back to the initial submission of the driver
in commit 9a9608418292 ("iio: light: Add support for TI OPT4001 light
sensor").

Patch 1 fixes the power down path, which read the device ID register
instead of the control register in a read-modify-write, corrupting the
CTRL configuration on the way to power down.

Patch 2 fixes an incompatible pointer type passed as the remainder
argument to div_u64_rem(). No functional impact.

Patch 3 makes opt4001_write_raw() reject integration time writes with
a non-zero integer (seconds) part, which were previously accepted
silently based on the microseconds part alone.

Patch 4 fixes reversed GENMASK() arguments in the (currently unused)
fault count mask definition and adds the _MASK suffix for consistency.

Changes in v2:
- Add Fixes: tags to all patches
- Patch 1: use regmap_clear_bits() directly in the opt4001_chip_off_action
  and drop opt4001_power_down() (Jonathan)
- Patch 2: document that there is no functional impact (Jonathan)
- Patch 3: add blank line after the early return (Jonathan)
- Patch 4: fix whitespace alignment of the new define

Regards,
Nikhil

Nikhil Gautam (4):
  iio: light: opt4001: Fix reversed GENMASK() arguments in fault count
    mask
  iio: light: opt4001: Reject integration times with a non-zero seconds
    part
  iio: light: opt4001: Fix incompatible pointer type passed to
    div_u64_rem()
  iio: light: opt4001: Fix power down clearing bits of the wrong
    register

 drivers/iio/light/opt4001.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

-- 
2.39.5

