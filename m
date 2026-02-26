Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E73D3011
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118676; cv=none; b=Gq6RMrVCSpKyyfcUm3BsHj26Lyp69w1Wh0mV1dPeIqjGfr+tj7ZlGEGE95JqGecaUR+wWZwUZn2Ym0E3OJq4n/4xgX2PDg17vIYsB4Jn7DhowvzUcpRRRG6wSuBgIPq2W6aK+Az/7zQVJvXqDPV3SL1o9MqIyool6hNWiUfdhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118676; c=relaxed/simple;
	bh=ZMi6dpEdMVaOxBIiqUZQLHL9vW2CrkxbzTlPLzvZ6zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ez+Bo4NbU/bTcp1h7mWTvK5RcEG+CmZsOLK/lGysbdIcHtaRjXzRviMsGGf3Zju0g0QMbZcBuMkwkqxzg5cpOSDllv5/TzM4BGUhY53N3xI9hx6KmoUavIcLm0Be1ysNvRG3mQ3JEBkDPBu5nhhYWliXQUxWaWcj5sZxy/1nF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/ahd72+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/ahd72+"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899ab9d13d0so7648056d6.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 07:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118674; x=1772723474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZgnV/1Ouc2yynJjdbEwAn0EbZnvEMYRryFD1SfCQJc=;
        b=g/ahd72+tb2bgh+vlTCLo9gUEsqrtNlptsu/SxchhonXEyB8fvct8+KXa0LKOhtBOt
         nSzamhcGSFkDzhRopthsgnn6qsFTWgLEm+wdQ8UEVZU0bmq2pDckT+tj3VX2Sha7SsxC
         f/M0GqO0DuR5nI5FnP0hnvIzi8bWTUyWDq0lIUwL58+5Zl4n2pBdL/fYVwkwwgxPfYg3
         zig5tXq8uneJ++e9rletgqHhjsUIj1fmUuItQU8gIxs7Pn3x8qMxBc5zvGMkD8VpcQ5q
         SVQRdAk6mIy5vL+eIabfxrVF1XACC8BvbJNwnC3faRwra/rRkPSsNwakAE1dT4CxzEIm
         NXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118674; x=1772723474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZgnV/1Ouc2yynJjdbEwAn0EbZnvEMYRryFD1SfCQJc=;
        b=JOW3ONWMgZtEj8YEyFzhQDdBc7kc41r97HweRWOT0NxnR7f4ZiCuO2dgtANRQCATR2
         BLGWcHvA7Tmn8H+mRbhvPH5mU8bISfd0zix7vEYt2dflR7EP7cSfAptJrNcMGPzP1Xw9
         +a1s5vUL7kL1Bj5ASbiNqZ5ixQf2schCzNq4f9ePO0xBaCqLLF5YoLiTlYoeRoE07+9L
         SQSMgNMufO11G1fVwxVSPTyNt+pQ5QMfSJ2aRhi/lAyfcos4VnvqgWGtLhZFDv7PtNtv
         hD95DigCbmpJ2QUGSlXUkQqoEXXOD3XDGF4YepVvV3BuChbc3Bvp6G4tlgZ1WklwmYoS
         mOPQ==
X-Gm-Message-State: AOJu0YzQektGGJoTQnlK4btskJk3zTNdPYVzCCTbYCExWUzf8LfhRv01
	G9X/JCZDXm0W0iKjON0KywEFsjPWhsBNk2T1NP55O5wcrfOrZ8Dw++iGnB/kkRgY
X-Gm-Gg: ATEYQzwS2npmtWLCgXBrPO6aC0i8kaKBRWaWw53GSY9LJdXqd+pkVV5eg4jYGQLeoys
	xwsoGfnvviLRXEqK4NL2MvZgpO0+ZdmqlJc6GP0VlUN+mqg4KUfaEKj+VC9DgAK5GdNgioeXBvf
	XJmDkczu9o2qX8XDCVtTeyrko9ylpTg1y8yD66Y9boDTuTavaRmqiEQ0il7fE82H7lOtt1+LjYY
	VyB26uBBYB9SFLjdSm7vGiyQI4CNyndM/m8WPrZ0G4PCHd5qyL81KFM8tCMUJ/gZFmFgGpm0oUN
	cT8ajSId20mmcrZoUqjgZVY4CBkPaIdm1FcMUEOMSezowjoX2tp9IQvO3wNUDHCvn032xNSOAp5
	7Y8jdyjEAD5Km/9KdbGuHSmueE1Q1ARCdYqgn8F2NBXu2yVAfTYXu3pvyZnlowjYmlja+r5bEFA
	8qKr21TDBVupsKJt8ceAq+hCzNbhH9RHnsU3SPkwuFFvzhcNS5D27aow2UtLvgeA==
X-Received: by 2002:ad4:5caa:0:b0:880:88fa:d742 with SMTP id 6a1803df08f44-899c807045dmr29575046d6.65.1772118674048;
        Thu, 26 Feb 2026 07:11:14 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738e661sm19275136d6.43.2026.02.26.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:11:13 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v6 0/5] iio: accel: adxl345: Implement event scaling and ABI compliance
Date: Thu, 26 Feb 2026 15:11:01 +0000
Message-ID: <20260226151108.22383-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses ADXL345 driver non-compliance with the IIO ABI.

Currently, the driver exposes raw threshold values without a scale factor
to convert them to SI units (m/s^2). It also hides the double tap
threshold value because it shares a hardware register with single tap,
which violates ABI expectations.

This series implements `IIO_EV_INFO_SCALE` in the IIO core and applies it
to the ADXL345 driver. It also exposes the missing `IIO_EV_INFO_VALUE` for
double tap, ensuring userspace can correctly interpret all events, and
cleans up related documentation.

Changes in v6:
- Fixed bitmask pipe alignment(Andy Shevchenko).
- Squeezed IIO_EV_INFO_SCALE bitmask insertions to prevent unnecessary
  git blame churn on trailing list elements (Andy Shevchenko).
- Removed bouncing mentees mailing list from CC.

Changes in v5:
- Split the series into 5 patches for better logical separation.
- Patch 1: Moved alphabetical sorting of the event attribute table here
  (David Lechner).
- Patch 3 (new): Expose `IIO_EV_INFO_VALUE` for the double tap event to
  ensure ABI compliance (Jonathan Cameron).
- Patch 5: Add the newly exposed `in_accel_gesture_doubletap_value` to
  the documentation.

Changes in v4:
- Fixed missing IIO_EV_INFO_SCALE handling for MAG/MAG_ADAPTIVE events.
- Explicitly rejected writes to IIO_EV_INFO_SCALE with -EINVAL.
- Fixed bitmask ordering and whitespace alignment.
- Updated documentation with exact sysfs scale attributes.

Changes in v3:
- Reverted "axis" to "axes" in documentation.
- Removed repetitive scale values from documentation table.

Changes in v2:
- Added core infrastructure for IIO_EV_INFO_SCALE.
- Implemented event scaling (0.612915 m/s^2) for ADXL345.

Thanks to David Lechner for the structural patch feedback, Jonathan
Cameron for the architectural guidance on ABI compliance, and Andy
Shevchenko for the formatting and git history reviews.

Taha Ed-Dafili (5):
  docs: iio: adxl345: grammar and formatting cleanups
  iio: core: Add IIO_EV_INFO_SCALE to event info
  iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for double tap
  iio: accel: adxl345: Implement event scaling for ABI compliance
  docs: iio: adxl345: update event attributes and scaling math

 Documentation/iio/adxl345.rst    | 81 ++++++++++++++++++++------------
 drivers/iio/accel/adxl345_core.c | 32 +++++++++----
 drivers/iio/industrialio-event.c |  1 +
 include/linux/iio/types.h        |  1 +
 4 files changed, 78 insertions(+), 37 deletions(-)

-- 
2.47.3

