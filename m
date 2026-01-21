Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B30219FC
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994891; cv=none; b=oXq+ib9akSatcbuF6pSNVsbjm1q2+pyroePNpirlnALU2T7x49sblsxPBLaqyxi3w7edw2sXuUsb4KN/tpNpgbj08r1fKdHajf9NfwP9Iy4u1wR9LZCFwg5RpM42YgomYhbI+ih8o9gU0AdjTtzPHLR7wrvmRHxoYPwonFy/yzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994891; c=relaxed/simple;
	bh=LG1+3MDeEQqZwIx1k4mjgu1pKuWBTVWxVJCRcyaQrag=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qRxaqjt62jYWiYptjpP/0R9U2Xp6Ky/LpHJzJWvJoBvf0FBnwZ+QTIGGNZrkZirvj7hUhG0O9dQzSViYg2w10mZkNN+um9vdtCoR6DE8qHlKOljXqtQTlOmKIVOplzg2/mBxfwutBtAO7OlbseWuiXXyzF7iMEaLS9cs0sFabVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BlXQqGAy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BlXQqGAy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so36430915e9.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 03:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768994880; x=1769599680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Emts/ftGOfFx7XK8mF4tV5ts5d5u1KRJIjT5/dfg3Ho=;
        b=BlXQqGAyCNsD6KusA3bAkMt2mAjZXmb/YUQ5xVUdXbFmdTnN6k7NLYS3RIEUVyIJUQ
         VCoGnPf4qJ+5CPsD6Jkq0WvUSKr+wGKA4AQWZzGr83C48xQcntHRVKrhRmqtLS8fBZ1f
         ARbPf9C8dAPh2lahh/Xxs5lkCdnjrn8Nxq6crtMrmmMQVHS6HHTMMw6T7l8xKO9MX3g8
         /CB19/yJPyA1ttxo6kcoDoTg8t97VHkOqyUWLo2GieyVigKhvkvVAXfWip8b9w9NVOxl
         olWqewhqfQr2y0Cvi7lPAfm+pqHWbG99AU6xEfeQzLKwyKZqg84FOOikfjYh4N9Hfiex
         YwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768994880; x=1769599680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Emts/ftGOfFx7XK8mF4tV5ts5d5u1KRJIjT5/dfg3Ho=;
        b=RJFORNDonZBljr1PajHf+OEtSV7T3ng2us1kgiIkT55AI9g+0qWhtyuyg2llIcWvsC
         yk6wAejx4N+IJqdELY333Ch5A75yhl+uGwXIePl/m5IMONazCTOpywEqqhQRxPY3utwI
         zpRvB42gv3LDCae6urv0yaaar4AdzZwJ5VfreE/835ClCIWaJVsFPnkKGTr8PJqc9W2m
         zlZAqn4ZBUtD0xWIVoAmDXdcClw+rRmzlwkw/9RsCKwRJu5sh8d3f95WrXUux8Lhg3CC
         V4VprS0lRpAL9DuXwUcpP/wmXqYRgToU42pMQeqKWGI5bIz2zQhvE3swPIF8A8okbyKU
         vPQw==
X-Forwarded-Encrypted: i=1; AJvYcCWTCskLgHyJIraNv4o3KLQELz15z6slxWYMBdyaAR73iXNHVaILbRrp26Tqw8dbw4A/chjPsLojbwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/Mu7vz/GMJBrV9fbrI+A/1AjtbqOTOJdOunMfJnTsJjeTdoe
	y3dsHmEGeMgKnl6isnTQx09mPVbhW+U5HjOdWysTRKIhex/rtJ0XLV5p8UQOVOHtkqs=
X-Gm-Gg: AZuq6aJSh0OblHw93hXJhoTgkNL7IqX75Wz74gyDw+pvRbPMpYUDiMsuB8sxxvnvWon
	Xi7t03bJWey2S+RM8fjVUMlGC9qEbKkXqzYN1egYcpJFFqo22zP3IibLWd4evKa8m0X1PxP4Xn1
	CJcfb4r8VnvFYkdey48SvVh2gHrduWJHD69+f3Esvo/5LBg68zFC6XMelkT5xklOsEnqjbnEJVw
	WUhI1ZL1ji5OgZy9crPsLGxyXUm7Jd30pQAZJMSS7E0UGRyPZKABCNR8t55PQtWd1OfzgUVYtCJ
	k3Xdj2uwX/gHdA4iXG9WS4wBUcD+rIHahUdo2KCnXbhB8xGZHKI71w1mARf0ied7AURXLhZiDmk
	0avNdxGEUUsT5vTEQaqifTfLJchlT+sYyQYEKr1IKjKykMX7fJJn64GCcOyMRaUtAyJb1Ltsfss
	ZMFL4b3H0iApgE
X-Received: by 2002:a05:600c:3b24:b0:480:426e:9d38 with SMTP id 5b1f17b1804b1-480426e9d43mr33420475e9.27.1768994879867;
        Wed, 21 Jan 2026 03:27:59 -0800 (PST)
Received: from localhost ([151.44.214.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b83csm359556095e9.3.2026.01.21.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 03:27:59 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] imu: st_lsm6dsx: Add support for rotation sensor
Date: Wed, 21 Jan 2026 12:27:54 +0100
Message-Id: <20260121112758.1831077-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972; i=flavra@baylibre.com; h=from:subject; bh=LG1+3MDeEQqZwIx1k4mjgu1pKuWBTVWxVJCRcyaQrag=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpcLggE4vq+wGXg8VkQHSbu0KHpe+S+jFIJkRa3 vBnyzdAfrSJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXC4IAAKCRDt8TtzzpQ2 X5dNC/wKCJD00gk8yzvUcMBwZ4XJravmVoeUBsf6PNyTCfA9K3+Qm+ysNqm9SP1wMZ1TW6LZyKp 6n5cLaX0Yk2M+AglSSx3NwRZtpLRTIuYBmF0Acg+XxWHbXqbRceOEG8Tpk0Yguo/C8e9/5wCzKp 5U4qqcJjbgeA/ZanUw1FDIuTCLHT5WLau6SKfW1IrkNS4KlOPEdYN9wePgdCx1xkMzQqSBQ8KWy OYI3o7eSBgi7D8Rdmj1EzpG8Dr+6zv7Mx3WpL6IoR2OihZJ1oNW26v3E+b5RwqF0ugp6LpKLGeb lqtxKHp17KtVyhF34XlmXOrblRB9KHKCIXWOIferDIwIrFvILkHw40BuXYJ6jwTVpuQNbx8ds+K K/E8p8F36CA77OMHGkju0V7/fe/5YSWS8Dg07qsYdPHg5ct8l+J5p425mP8AS9vv/VP3SvAStgH HLnlLFrfZtnBa3hZqJBfed1TVUKRFmQSCNOo6sVBe6cBGxaYm0GFkSBDfQGe+IDCDSmqw=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The second commit is a fix to a previous commit of mine [*] which made it
to 6.19-rcX; the fix technically changes userspace, but this should be OK
as long as it goes in during this release cycle.
Tested on LSM6DSV16X.

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

Francesco Lavra (4):
  iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope
    only
  iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer
    only
  iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
  iio: imu: st_lsm6dsx: Add support for rotation sensor

 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  33 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 235 ++++++++++++++++++
 5 files changed, 345 insertions(+), 9 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5

