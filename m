Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495073BE4B0
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099029; cv=none; b=kjg9wIdmR+JtBCxPLRVZFBOuT7eATZDqYXaD1SfmxRJ8tGD9UcEOnzzxUHjhg0dPWb3BrDcrS2+x+mKMqMDtRjj0AUqzZbFlU4fPHeQn21tKC6xX6xKJTo6zVRcpax3JZ9v2gcbKlad5ujXbsW9xtv1ZEJceCk42oc1eq2FRMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099029; c=relaxed/simple;
	bh=peOydqjJ+i16ib0SlpZWqOwRIa+l9gutlzJQ4Yv03Q0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GKnzPiShRqaTD2o1UDfpypc3UzI8mkGn4F/pZJvCYCUhVr4zUA1exQFaOaU7jBTnF94dm3x0xmkuaPgpqpG5Os1eA3zOdQY0BBB5c5+35KsI3GC8kjDrgpyp1jXvVrJQle/uJj3NgowFqVBYbgZKxt8Ye5MCwiy1r8PH/uxmCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yAAbpBaG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yAAbpBaG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso5080925e9.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 08:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769099017; x=1769703817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMTzA98CAlwup6oLDFJfQBB6S6pMdvjC2IaqkckmUIQ=;
        b=yAAbpBaG3C5s0qzVOd7Y5DDLPAqYdBgFqkVkavW0MPPiS3myna0gaG4fi98fXBCieG
         5DWVcti9Ydjbaa0bQ7XW/Ds3BcI1fssQ/ZVqci/u+DpzOSL//4XJC32w9xus+Q6ZsXds
         1gVPxJfzCHqfWYJuvcb7zgKCP1o3mbyNZQ+2sevDV2NvZcxVIzK+mQ6Ig7yzlEEpr871
         hQfSBzmBFyBSMSoQQu+UK+6CUVqaa9g8+AdLGwKDwXO4ALMRHDRCrbbp83gCHAlB7Kns
         RptWgAi20Bt1haItwig7lpD+Dre9BQopOkcPIbAddM9/erEArzEcsmcS0ZT/4hvA5UqO
         2aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099017; x=1769703817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMTzA98CAlwup6oLDFJfQBB6S6pMdvjC2IaqkckmUIQ=;
        b=Q92VF+Z0yIr820DsTAMTWLOJgbuekUMBz1t4i64/Cvm40eLmRSh/quxQl9P2alrhbC
         32UcP/zctrt/tF99BOI1M4o+u4KLxgcC+Yik9RgSHgwvj4C0vDONr2cAO1gMkByFuxva
         ZNJQoJmBjBQaGOHfCfsLjMYA5n7erRTR33A3i4zoYPWawO5WclAi8ttqI6FC/pSMb2lK
         +A0cZp7ltJz8Y4jbGgNWCQht9U48qIYodOuafbZVHa/gV0QQZmP2wcLJzJIUYuYzWpTh
         o4ot0tpkaVi93cYeipsoc2du0MKHDypnOh0HXWlyIiY8Jff45PL1shLlljgVQ+5f2HWa
         dsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3CU2x2pfGR9FJGbJfeb5Zj1L62uhsFO5Ev0KuPJHK/JiP4YtaOlzG3esVOs8B258TV3zPPA8triA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaeZQY59UNaGv5xCEOZWj1vbbccPDNS4WaWbsH6kVGq+jQcKL
	fl4aWtdt5mm+A7+Zsck7BV5Pejbz5m/JOl/XvipTYBM/cl0cES2HCIq/UhURYtgquH4=
X-Gm-Gg: AZuq6aJUxSKniiyPZ0EKLe1Z6R3xV+Rht1F4yGz+I0dcykTXARfZS+/w1DhtvZdFs79
	rKdkR8OYgf/Krbm0WDGKH9XzbRc+PUl4vqaNRozwuL62od4PY7QBgE6W4trOAPAbjj9DGSChK16
	hE1TVfILeJgdEO+l/PG6j3V9lut848gmvHYOM4F90i7zvr5RtvSNS8jj2TGxUWQxIGmolbjG84p
	IW9Z2yfb9p9M5ggwPjnHaKdK8yGzeyweny3pLn/Lh4JTk/qAxjzFw5deR3y8P/IiPzZ9r1Em6j4
	0d3XNs91sEGXrEatdw5tNE3kN30AtyWYFgcpBmfJ60NvJabu5wU1oe8y6ott8yeI/IIJDmllKMy
	ttiZ4tuTElh9FuQZI2rk0sJrNVGFIajGAoCRmLTXbEvqqninoKmH5lbGEcw==
X-Received: by 2002:a05:600c:820a:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-4804c8f63a2mr3667715e9.0.1769099016697;
        Thu, 22 Jan 2026 08:23:36 -0800 (PST)
Received: from localhost ([151.57.192.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm118098455e9.2.2026.01.22.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:23:36 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] imu: st_lsm6dsx: Add support for rotation sensor
Date: Thu, 22 Jan 2026 17:23:31 +0100
Message-Id: <20260122162335.2020006-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=flavra@baylibre.com; h=from:subject; bh=peOydqjJ+i16ib0SlpZWqOwRIa+l9gutlzJQ4Yv03Q0=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpck7i/i/WCp7wsGgvLsuNlyyvQfREGAcAiThTm pxTaJmB+CGJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXJO4gAKCRDt8TtzzpQ2 X8QLC/oCjb7eExtIshcnNINQ1mvI70S3NSEZYlIy0Nctu2olBdZ2qNSdVn8158+q7T4dkYJfjWf osBCHKeU43XjhXuWxm7KMgxwk2/FvBrefut05iSh9D6hhcGJqmIzrmRO3DX35Nq96lrjFMBvc3n nqNHUNnXMeXfTibKRf2Z+7HzmE/w0VDh/lhi46iiZIqwQv55xJ/1+et2qdAKzASG1zR7V002F3p BHwPCgvXY0OPpvFyk+PP7AFurz6mozrR0Ng4xwhJoLxYJOD4msNISIHyg8qVskOXnoHVQEcgIFx iv14BrYmj2j87PRVfhHsRgR4JaZ2TzUL6L5KUOslejcKlT4vtQPqDM65AvgFORUty4E5iNExKe9 OEsFzfXhvQvbu+Ekt45j7+euc5L5OnPUblgqWtQAzInxiVnlDsalC925rP+nZFg+zbojD///ahU fOrCduji76fXZcZUy0NoTKeFeUV8u0HAqnmsrUQJspcJxU+qUW3+PTLuIalZn/gmX+OJA=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The second commit is a fix to a previous commit of mine [*] which made it
to 6.19-rcX; the fix technically changes userspace, but this should be OK
as long as it goes in during this release cycle.
Tested on LSM6DSV16X.

Changes from v4 [4]:
- changed data parameter in st_lsm6dsx_push_tagged_data() to __le16 *
  (Andy)

Changes from v3 [3]:
- added patch 3 (Andy)
- removed unneeded checks for negative return values in st_lsm6dsx_fusion.c
  (Andy)
- replaced st_lsm6dsx_sf_set_page function with
  st_lsm6dsx_sf_page_enable/disable (Andy)
- used reversed xmas tree ordering for local variables (Andy)
- added parentheses to MILLI / MICRO in st_lsm6dsx_sf_write_raw (Andy)
- added check for string truncation in st_lsm6dsx_sf_probe (Andy)

Changes from v2 [2]:
- amended description of patch 2 to point out that there are no supported
  gyro events (Jonathan)
- removed superfluous parentheses in st_lsm6dsx_fifo_setup (Lorenzo)
- added Lorenzo's acked-by tag to patch 3
- added missing checks of st_lsm6dsx_sf_set_page() return value (Jonathan)
- added comment in st_lsm6dsx_sf_write_raw (Jonathan)

Changes from v1 [1]:
- swapped patches 1 and 2 (Jonathan)
- miscellaneous stylistic changes (Andy)
- fixed usage of MICRO and MILLI constants in st_lsm6dsx_sf_read_raw and
  st_lsm6dsx_sf_write_raw (Andy)
- replaced scnprintf() with sysfs_emit_at() in
  st_lsm6dsx_sf_sampling_freq_avail (Andy)
- replaced scnprintf() with snprintf() in st_lsm6dsx_sf_probe (Andy)
- clarified in a comment in st_lsm6dsx_set_fifo_odr() that only internal
  sensors have a FIFO ODR configuration register (Jonathan)
- modified patch 3 description to explain justification for the extra IIO
  device (Jonathan)
- moved page lock from st_lsm6dsx_sf_set_page() to the callers (Jonathan)
- s/magnetometer/gyroscope/ in patch 2 description

[*] https://lore.kernel.org/linux-iio/20251017164255.1251060-3-flavra@baylibre.com/
[1] https://lore.kernel.org/linux-iio/20260109181528.154127-1-flavra@baylibre.com/T/
[2] https://lore.kernel.org/linux-iio/20260115122431.1014630-1-flavra@baylibre.com/T/
[3] https://lore.kernel.org/linux-iio/20260119100449.1559624-1-flavra@baylibre.com/T/
[4] https://lore.kernel.org/linux-iio/20260121112758.1831077-1-flavra@baylibre.com/T/

Francesco Lavra (4):
  iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope
    only
  iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer
    only
  iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
  iio: imu: st_lsm6dsx: Add support for rotation sensor

 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  38 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 235 ++++++++++++++++++
 5 files changed, 348 insertions(+), 11 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5

