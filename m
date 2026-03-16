Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1E377EB8
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651638; cv=none; b=dp7KS9Eyq5B+RRnJ+MJdyhXAt2iD+ZG367fG2V7a1kJCh6iqsr/sYFQQjbQ95frawGjWdPYcuJEQrpuqcBeFRR3/ZKrmHzxxDFh7YOoDLajc0wb00qPh7p1Jf9a0KfSLWXrILSYTmCSiD8NeZCMItdh/kH9p4JENQEL6BPveALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651638; c=relaxed/simple;
	bh=IiOmcDPDYRK1gCDcPlR595jBMqPJUBhkrGgeAWvYCDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eo8a41vtFyiDQdJJl/fJCPeULHX8/Qy2QMwiGC142TI+SsQL7DTQ06/DIE4iCsou4f0aEg7daSdmuxxWq6q4ToKITl6DxtR3+vhJZkn4dJt4kerlGaDwi9CqJ8zz7+EyYtf42mVN5S8ZhhMtIGn74BNwN1BJewU51T+nFiu604I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbv5XdF/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbv5XdF/"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1409321a12.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651637; x=1774256437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDLp3aLhqczmh+E+vKw7s6AY8Kk6OpCsvnZnp6F2B2o=;
        b=Sbv5XdF/omywvihdzKJBAmWqjuFglK5ygcRk6H+P45uYdU/KKwLL2FgQAwxaLkjTmV
         kqEB0vHAv7mYuPDH2L/flygUu9D98n4rv+OmCTMmsEGVLsYrSEy0glod46amRo2xfAxI
         hLz5+XBbDG8zx1rBrVPTuyCsfS5cWp32K+OkujGON3aCknwIDvDQWQTprvkvpqpeQSVo
         W9Z6iZULk79uhKIJ9+XBeSrFyI8TF22ZdSbwx8l/TMBFp5y0BTVykDeC+kPnNPQjVpTw
         pglmLpduVvff8FDf4YYCCpGwY81CS5DTcp+4voPT9cr+3Vy66FrxfI9O44mdEbymyKfZ
         AOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651637; x=1774256437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDLp3aLhqczmh+E+vKw7s6AY8Kk6OpCsvnZnp6F2B2o=;
        b=UBk206nB+JhmbqFrngf8FV4C/hoi5Le3QPsgKNe6aWSoHda9OsUlEr8HvQmiNrf62K
         Ucs9g+bSIi7d5eJTlxCcUDx0IdnzKmQpa/C6XYb1EwEM9KZAYfK3yJ6ifYhD36lCt3d8
         4d/SDzIrA7iT+8y4T3s6dCWnIq9Vxdv0M+vZCieYMwXJXqqwXfWE6QQRKvlxuY7KwFA+
         ZZTqhPJE7gxlAappPN6N5WJmnUoKNh2/J/9370/p++LeG7TrF5nx2PAe/1vPQcQuVIe1
         q1NJbdRVCXpmdy/NZlUtcAdKf4CSd6holHqCu5tEW+4xWg+oRWtcVd/QXYz7Wg0/sZas
         zhqw==
X-Forwarded-Encrypted: i=1; AJvYcCVR93JjCjzu1a0AZMPh0c4hGmOqObdZDf9iuRaipzDq9ndK8JHk8ljIe4JF/NQ0uqjAdkY9KCaEDU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNX7MKg/N8HN5I0l0Ts+0CyxURpPE9y3qai33+hPAx/Tiez+Jx
	gLI0zEp6Mzw+Th8NIPyC0rZI1Qm3+Ff8lzyagfJOQTzpefQjJNM1dQ7X
X-Gm-Gg: ATEYQzyzEv352VOZGhb9gtEGAqvWWqKLI+or8gaw3TS01EvrBhc3opMSfkbTf4AHjPZ
	fbBzwhs7ScpGrYYUG/wfWOiQ5ZkptIuwR2I2ByUNlX7GRwNNtwK76uLevGnXWWMF5kAZxZOd8Qk
	bHSIzxzfmZXvI96LQqR9l1q1FL1xpHZP2EnRqaSloSssQNndHHnQxaZqZftd5dkPqFQdvCfjnjk
	jS50x/RC+fLTqxSGy6JD61ijCArd5t3Mkd098bBsb8PNLIicvwE6vqhTOLTB7dtwvANrnW7Ajm6
	MYBtE47VQsJZIKXk1jP4nqh1Lkl/vzRZfa6Gy80whp80S59/VaIfSQWkN0/3QZsp9iNjcwL5yFs
	WWJqx7OG71it6tRevDBB1dg6Pb8fOsH1CZciYAg6a7o0rOjq0QjB+up54HoxvtwwZBPg9ryS/5U
	NYA5pmwIr0nn6gTBK/ESocrC0B
X-Received: by 2002:a17:902:d542:b0:2aa:d60c:d48a with SMTP id d9443c01a7336-2aeca967d83mr133886865ad.7.1773651636640;
        Mon, 16 Mar 2026 02:00:36 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:00:36 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 00/14] iio: fix spelling mistakes in comments
Date: Mon, 16 Mar 2026 14:30:08 +0530
Message-ID: <20260316090023.14691-1-i.shihao.999@gmail.com>
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

v5:

- Rebased on linux-next
- Dropped patches already fixed upstream
- Added 8 additional patches to previous 6-patch series
- Rephrased several patches for clarity and grammar
- Added missing article where needed
- Improved commit messages for clarity

v4: https://lore.kernel.org/linux-iio/20260311093933.21333-1/

- Fix commit message grammar and punctuation across patches
- Keep 'whilst' instead of 'while'
- Rephrase sentence in chemical driver comment
- Capitalize IIO in comments

v3: https://lore.kernel.org/linux-iio/20260309104513.40359-1

- Change commit subjects as per changes
- Capitalize proper acronyms (IRQ) and Celsius
- Fix short wrap in commit body

v2: https://lore.kernel.org/linux-iio/20260307104705.49129-1

- Split original patch into 6 commits
- Fixed commit message formatting and typos
- Added necessary tags in commits
- Added more fixes than previous

Shi Hao (14):
  iio: accel: fix typo celcius to Celsius
  iio: light: fix several incorrect spellings
  iio: adc: add an article and use digitize instead of digitalize
  iio: imu: fix typo from adjustement to adjustment
  iio: magnetometer: fix various spelling mistakes
  iio: pressure: fix spelling mistakes in comments
  iio: proximity: fix typo from currenly to currently
  iio: resolver: fix typo from degredation to degradation
  iio: temp: fix spelling mistakes in comments
  iio: test: fix typo from neeeds to needs in comment
  iio: common: fix spelling mistakes in comments
  iio: chemical: rephrase comment and fix a typo
  iio: cdc: fix spelling mistakes in comments
  iio: amplifiers: fix typo from Curren to Current

 drivers/iio/accel/adis16201.c                          | 2 +-
 drivers/iio/accel/adis16209.c                          | 2 +-
 drivers/iio/adc/ti_am335x_adc.c                        | 6 +++---
 drivers/iio/amplifiers/ada4250.c                       | 2 +-
 drivers/iio/cdc/ad7150.c                               | 2 +-
 drivers/iio/cdc/ad7746.c                               | 2 +-
 drivers/iio/chemical/bme680_core.c                     | 2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c             | 2 +-
 drivers/iio/light/Kconfig                              | 2 +-
 drivers/iio/light/apds9160.c                           | 2 +-
 drivers/iio/light/ltr390.c                             | 2 +-
 drivers/iio/light/opt3001.c                            | 2 +-
 drivers/iio/light/tsl2772.c                            | 2 +-
 drivers/iio/magnetometer/ak8974.c                      | 2 +-
 drivers/iio/magnetometer/ak8975.c                      | 6 +++---
 drivers/iio/magnetometer/yamaha-yas530.c               | 2 +-
 drivers/iio/pressure/bmp280-spi.c                      | 2 +-
 drivers/iio/pressure/hsc030pa.c                        | 2 +-
 drivers/iio/pressure/rohm-bm1390.c                     | 2 +-
 drivers/iio/pressure/zpa2326.c                         | 2 +-
 drivers/iio/proximity/sx9324.c                         | 2 +-
 drivers/iio/resolver/ad2s1210.c                        | 2 +-
 drivers/iio/temperature/ltc2983.c                      | 4 ++--
 drivers/iio/test/iio-test-gts.c                        | 2 +-
 28 files changed, 34 insertions(+), 34 deletions(-)

--
2.53.0
