Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01A3033E6
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880461; cv=none; b=EntApohTo5BqQuKvhD5fy3Ms9I8xOzdo2DEbcTomE9hh3mibyiz7gzt19fgDGMSnbkF+5+DzuR4e2p1fTucTdBI4Hfn9olFOjw+vuSgtIFYZhySz4tE+3s5TkFWPgySWVLhoGhnq+7lKZXigfO2rVp9ZBe8GnrzQcecTEqkbsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880461; c=relaxed/simple;
	bh=xNBzACMCOB3e4CUyWB3qnTOeE6CJTZFIbk52mtjQWv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nj2n7gpL0tl2n1+15lx+uaumyCq6pZlgvZz+NtYZ3I7XFsTy+kCsucYUCEMoLvxnxLsN4WmLEYe7Cd1dH5/1rgLyx2AuDyBtaBXQvv+Zj2ZCyFZ6/au3+BuPUuMl5x5dmS4u+RXW9K7vmYOCU7NBtX/reZWp9Viig1XKrS9Sczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/UAgAOV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/UAgAOV"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3597fea200dso5053292a91.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772880459; x=1773485259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k6imQY54g3nSQPw4rVdUIT9KroYSgZ8bDJBrElfTIoQ=;
        b=f/UAgAOVTEw5jOBSDP7uy6BfICjtEq4mr8W3w/d/ubbB8uA/KjDnH/WF7i2WyDRsQT
         MgQ6lOjdAisyNANiM6AHwrdQVwoNKpNxRqFKm3TjfTV5D+XlauIZFdrr19Lz4WiM05Mg
         jeSv2OW/Q+ifB5ogfk+7e5PzRWqSV3oesKaDvFvFRnOgFY+VenPp2dMZBIrvQSzC7bfu
         HWPukyGCeICxs1VCI6TzjUyu1JYdbHoH4O+h9fsewDwPeLrez1NQgUXjUK5qmzbiJdrR
         589r4uxV+3yI0oQ7V/s76+DegB6c/oBmCDwwrVqg3UnuOt+S55PyDTJNAtQ1RocfkfuB
         w2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772880459; x=1773485259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6imQY54g3nSQPw4rVdUIT9KroYSgZ8bDJBrElfTIoQ=;
        b=pJSIwetb1e/XM4t5X+4LQxfL94SFE2ppKiuOht6vvp2M/MTgh5PeOYBCsRRIyQe3sr
         SBLkH+QxIOrYvsapr6GDG9uu9pDXHOCGtPm3GoabeQ3T43PxCuZJv3T1nZBH+GUn/y6A
         fcjsrGptr5VbtP1d4c2W2z+2JQM0sI7DwCb4u+7EU8eMe4ZxoSjAz0gmNPSFVRQRxZsM
         AADx9Sc7psWBm1jRu+8g8xAr6SGbGyCNrhDhKxdjpqrpsWA+dVIQWjC0VKXkGQSTuAKs
         xue1SZrsdBwbfzpq22+C9iV3vl9y9qzA4g/xvs+FxmwFnHVA70PDlo8gsXEIzkSHVvd1
         Cqvw==
X-Forwarded-Encrypted: i=1; AJvYcCXO10D/pwP+gZSoUpOUk1iliPtiSaNLDyDW2XlG1XmqYcM6VJlDrmLLcKjqytXPn/Kq2z/dnZlxVRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Luz1XCwarFYtVZwsyaC51ry2FkKtYyFxVVn8aiy0kShWbqR3
	FLh8Xo/uK5mhAnlv867qlAXhbuw0VK4G2j4wdYWO+P4+FwiXhx75EB3G
X-Gm-Gg: ATEYQzz9R1Kle1LcVet/wqL/TkPpiqbhbNKRVdfjiH04Fx1ylRSO9RrKObqV2dIyGVy
	RogMB2WCRkVef5AwOpX8wwtxNikkZSQgb71EFPtWbhZlFYZjx664ockosf8hu256lx0N1yburQv
	HbeZ5NfVM1KKsWAfQs3zFJTHSsXCq40gSRJ4ChDMhqljw+abXpBgPUpQsBp4STCnOtTf0TZLHR9
	q/wPTX+L0Oafjwd+bH9BUPuagzrX2oydbLnyr23j6zu3ERbCkImFSh0YCJ9TjDat3XcWrZ/oH+x
	4zau4wmJ+isb8tpyFfRnqIfSgEtBQXEx3XGv9ZI26TQbOd/gI04jxZH/NHU1h3U6S6hMM2Cwpez
	n+sWY9bXLHJxC+Ce/8oBNf3Im0bPF0DquRyyayIFVhJhirH3aDQZQIwJl+gMwOEPv8i5Ge9C3I7
	R68QVaiXVMk3teI94ufNS5vwWd
X-Received: by 2002:a17:902:ef0a:b0:2ae:4fc7:8053 with SMTP id d9443c01a7336-2ae82481982mr62452895ad.46.1772880459435;
        Sat, 07 Mar 2026 02:47:39 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:49e5:cff6:c6fd:2f81:fb7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78d48sm49541235ad.22.2026.03.07.02.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:47:39 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com,
	i.shihao.999@gmail.com
Subject: [PATCH v2 0/6] iio: fix spelling mistakes in comments
Date: Sat,  7 Mar 2026 16:16:59 +0530
Message-ID: <20260307104705.49129-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes spelling mistakes in comments across
several IIO subsystems to improve readability and code
consistency.

v2:

- Split original patch into 6 commits
- Fixed commit message formatting and typos
- Added necessary tags in commits
- Added more fixes then previous

Shi Hao (6):
  iio: accel: fix spelling mistakes in comments
  iio: adc: fix spelling mistakes in comments
  iio: amplifiers: fix spelling mistake in comment
  iio: cdc: fix spelling mistakes in comments
  iio: chemical: fix spelling mistake in comment
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
 drivers/iio/adc/twl6030-gpadc.c                        | 2 +-
 drivers/iio/amplifiers/ada4250.c                       | 2 +-
 drivers/iio/cdc/ad7150.c                               | 2 +-
 drivers/iio/cdc/ad7746.c                               | 2 +-
 drivers/iio/chemical/bme680_core.c                     | 2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
 29 files changed, 34 insertions(+), 34 deletions(-)

--
2.53.0
