Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280AF3CC9E1
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221990; cv=none; b=ZGGgnGTarMQQzcU/XKaiVXwrlidTCrR7lfaFLIP834LSkbwf0wS4UshMPK7spKoJM6U9P/qexB5+TJw40kLLomoIp0xJlNTHIh1MtHe57bac7r+eaRawGB4x/2fBnhcTnSdSPh8Za9RFVhUxoWld9hUSv3MN5gHueyeuLJZs6N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221990; c=relaxed/simple;
	bh=O/7I7te0qoehSuZoD2cWY5RA9lS2OvIW4LBEcOZCAN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNW+tVOAXPQ8gU1qQKlt0Drke6ftgWYsd/DctxsqV/9mROHDhe4HPEmCXGvk2Nmqucl+kg47HY9zHlLcFc5Rlt23ymdFVS13E7RKb2UnLxogrTpP0gGbJoaeYXBKXCcpHIK4t14FvMIxA4qsho87e2VmKZE7kcrH/qRQjQCHlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihs3+rGL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihs3+rGL"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so163879a91.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773221988; x=1773826788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UaTc+KrBe1LzSbyzr+Z8L98sYydFIdH9HTr3aJre6w=;
        b=ihs3+rGL34aME8zRaPQPmD5E3lIu1jYx8NcHlZ+fQDGr3Qhi1Li6Sh21WgmTe6ZHM6
         EiNnfVH6d2xbHVqVm6pS+Dhz9U21sX6f4VdYoCCs/cSsoui7UhSbuSe8k7Q1OZ7kCxrs
         4lWgALeXqeSJU029A/dE3E4h+Cfw1TIvcUZPYcrSQglbirGxWTNmOZ6xpqiswz2rCLaw
         aALugqCLdjB7Poatuf/p9sUJiGkxKd3LEi3MiegkUJea5qF4AikI7uF0Jw+vNQSP176m
         +Xg4kF6p1+E6F9rKG4He4bCOIvFJzIdxV1w90hH4M1LtFI2qOTbXClWTOjgMPIjPglD4
         gzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773221988; x=1773826788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UaTc+KrBe1LzSbyzr+Z8L98sYydFIdH9HTr3aJre6w=;
        b=Rz9ZWKMhRQYuWtSyofkFjMCJc48x9VGshubQ5Bdj4hmcikfbAHuRtaHL6cJGmYoS7f
         vB7fH9E247nZbYR/FWDYbN9esG8D/wtGO3RaMSEa7ON+fAT/mIssEC9fjC4e1nivSH4y
         cJREliHHzloCX/8xY0Bl6vCwNp3x+0SNjgDhAcnhNyr8H3y92OS6lVKL8qmmUDz3LrPk
         snG3nnfzWF9Ye+Zf0jbUsSjiK+TDFuAItriZpX3Z8sJgl59A7JmMoB0rXhzkgBZhInCR
         WNpgBZUnzk3EEmwqGnWMfHVsF0LaIJJ8lk0y1UZGx3ooTQeuBDoyX93bngdPxbMHB61o
         BS2A==
X-Forwarded-Encrypted: i=1; AJvYcCUcyclXfEfrdreQFYUMCKwwawXZZhzgyfh80iHxtaLdXMG0Ddf7R0c0WXIq5gRNywdRfcXLjcYzjow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8S31vqahYKjk/URv0Fibr7j8f6Y6wr7+Rq7OKF+bvYoPQ9UZC
	xd1fcgkeJ2uukk/ZrxDHxNmTU2/d+R6S+RuFy0mHThD8vozkna9p8hlZ
X-Gm-Gg: ATEYQzza4F4chsls+9We34EboAszOLVMk3kr+jgQpB0sYmK2w8THOnXYruk9qIDctkJ
	PeolBZsSuxTilzvOAbQ91NKmXh2RMnHytVPfB+Z4eUQOlnrC029orDWe2bQVP2V7SpF9/Ke1JYZ
	4V4S2NYe0ob2fWozTKFjE1moP3HiuA3Sos/SFnqpQcmyf8ulf5rlfUt+185q8lyN56ptcMk9DC1
	+jLZXJT2cbbWwIcrAKFsEb6wvGFur+gq8i9aJM0fklenyx1A93x8mzoBx3is038mH5QIA38v2Y4
	K4etnYbLFjbzL5rne5kAJ/qdKOQTWBCGzlhv998siaSXjVQ+cYCyPPYnXQZOhxUJXZOlPNYOytt
	3durEwNup0IVvFk//gId6gkgPy+Et50Mw4ebB+1SY0b/+390wUvfzxfUiwxJquM/bQkmyVxde/L
	WK0s0eg3QAZR+v2qrucn4p0Z0kDzY1SNc/tTM=
X-Received: by 2002:a17:90b:5284:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-35a0130532emr1672279a91.25.1773221988532;
        Wed, 11 Mar 2026 02:39:48 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:27e8:1c1d:af76:30f5:4937])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a022710edsm852623a91.5.2026.03.11.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:39:48 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com,
	mazziesaccount@gmail.com,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com
Subject: [PATCH v4 0/6] iio: fix spelling mistakes in comments
Date: Wed, 11 Mar 2026 15:09:27 +0530
Message-ID: <20260311093933.21333-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes spelling mistakes in comments across several IIO
subsystems to improve readability and code consistency.

v4:

- Fix commit message grammar and punctuation across patches
- Keep 'whilst' instead of 'while'
- Rephrase sentence in chemical driver comment
- Capitalize IIO in comments

v3:

- Change commit subjects as per changes
- Capitalize proper acronyms (IRQ) and Celsius
- Fix short wrap in commit body

v2:

- Split original patch into 6 commits
- Fixed commit message formatting and typos
- Added necessary tags in commits
- Added more fixes then previous

Shi Hao (6):
  iio: accel: fix typo celcius to Celsius
  iio: adc: fix spelling mistakes in comments
  iio: amplifiers: fix typo Curren to Current
  iio: cdc: fix spelling mistakes in comments
  iio: chemical: rephrase sentence and fix typo in comment
  iio: common: fix spelling mistakes in comments

 drivers/iio/accel/adis16201.c                          | 2 +-
 drivers/iio/accel/adis16209.c                          | 2 +-
 drivers/iio/adc/ad4030.c                               | 2 +-
 drivers/iio/adc/ad4170-4.c                             | 6 +++---
 drivers/iio/adc/ad7380.c                               | 2 +-
 drivers/iio/adc/ad7887.c                               | 2 +-
 drivers/iio/adc/ad7923.c                               | 4 ++--
 drivers/iio/adc/at91_adc.c                             | 4 ++--
 drivers/iio/adc/max1363.c                              | 2 +-
 drivers/iio/adc/mcp3564.c                              | 2 +-
 drivers/iio/adc/men_z188_adc.c                         | 2 +-
 drivers/iio/adc/npcm_adc.c                             | 2 +-
 drivers/iio/adc/palmas_gpadc.c                         | 2 +-
 drivers/iio/adc/rohm-bd79124.c                         | 4 ++--
 drivers/iio/adc/spear_adc.c                            | 2 +-
 drivers/iio/adc/stm32-adc-core.c                       | 2 +-
 drivers/iio/adc/stm32-adc.c                            | 2 +-
 drivers/iio/adc/sun20i-gpadc-iio.c                     | 2 +-
 drivers/iio/adc/ti_am335x_adc.c                        | 2 +-
 drivers/iio/adc/twl4030-madc.c                         | 2 +-
 drivers/iio/adc/twl6030-gpadc.c                        | 4 ++--
 drivers/iio/amplifiers/ada4250.c                       | 2 +-
 drivers/iio/cdc/ad7150.c                               | 2 +-
 drivers/iio/cdc/ad7746.c                               | 2 +-
 drivers/iio/chemical/bme680_core.c                     | 2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
 29 files changed, 35 insertions(+), 35 deletions(-)

--
2.53.0
