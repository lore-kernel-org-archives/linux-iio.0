Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BD39A800
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941840; cv=none; b=TeOQ5NU8Jy0U/kdrRkyTX6nbmDjlUT/15FJinbJrjZoviDSWNU+P3LW6fJZnahSIQoURiR9sXDlMIDKQj/adJLoWgPPG6uXt5+v7661vLy4TNSgawJP8dr49n2TDxEfc/XtPfxoJUlgvMj/l3wgUDgt33LEAU40xbr9DjvGqeCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941840; c=relaxed/simple;
	bh=+3/fywndWbMVQ2sR2gOUDdu1/eSnWYu1iI7MeYkkaOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACjQiakQuo5tOGsaPBoOQTZDyGjUdKINTLQ3zZqQzOx5MMwiM1QPlAXDag8odeBDztO4kp20cuUcOKuKIA9pLmYQPYxZY4fQGQhvQNzBT9b2Q4gF0B+CuPLkrXfGeiTuMSIQyGkmXrmg2adxI0k3MSEho1dEg17M4acUslscYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP1lXOgc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP1lXOgc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4837584120eso39099255e9.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771941837; x=1772546637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtE+z3Cy2C+XBq05qM7F+cng10U1INGp7SQFnLebO8A=;
        b=KP1lXOgc2jugsrVIImcPEcqA0WLf9+LQZ2Shu9TJT5Lr+IknXceLkTxc3/TY4FcEL5
         Hv3qfVYgMIMBNhwIZxZbg5rOTqGLAuQHPn2X++UBAPtnB3+9grrcbapWci2TPto+AsZe
         m7xkxVWioamEqZmy88tYfRwYRIzU45jF/2zKSUEXntR37oF/qI7nJELbcsTpR5Dga7HV
         sLrTNT9PPr4AMurxbb0wg1ah4hRasml6jbHuO56hvzReGPfJL8pMrX9fZXaxJrpnhr52
         3qCD1XI5/zZovPAgQJEcAF50BH7np3JKyi7FPe4raY6ik1UstDvzjjkVTfECQFmi4tFH
         whVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771941837; x=1772546637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtE+z3Cy2C+XBq05qM7F+cng10U1INGp7SQFnLebO8A=;
        b=csc0x+smp43XKNvANfu1tLpNfUelFX9jNAP21wah8v1csrBFy0NjVfKTYPR0bxg57S
         dLJdcOVLj4hDqcHcfzrQ5zCZFMlFiyTLCDBXbxWygW7UImeaiK90T3yQf8HVqlFbyXnY
         AFBy9z2iEn59sO4YImjgXYcgl8mKQ6NDf9XPF2mRZCuer3hPpYtCsRu6QrpqmGhDsJD6
         Rdqj7pOTc/CBa4ut6FQn0hYVWCTF1WE8PzCSMdCfVvh8qiX7ulgaz1TIy0XIYeqLGidC
         /SaRMnaWb2wEEV5M0JJz0IsLLb1Ae9eZ4Km9I1BZb5iJHMFXpubUUJ0Vh0P5K7O1rWBM
         qkdQ==
X-Gm-Message-State: AOJu0YxthwmeXiSf2XfwyQVKvZAwzWx6CszFVpTfYMjh0Fgz3AXCxGsl
	v9nSa6FjgsZXyQ2kodHmG/4IetHKysUWbBxlDO5z5xipr1lNl87DospiREdgg/Vz
X-Gm-Gg: AZuq6aLj5ibEHCpWWUlyKOSIoeQXEnq8jk/DxHzwloyHp19fyJkpHBIqZqQGnrGFbHK
	7p8CGOCt3/9sNol6cUqy12P7Yxevj8vFdNy4RQEre7BeSFHgmd2vqw4/JZmTG4owK4XnomxV84A
	qfkHJ+B4zjDsmlj4TSuchkSXd92LE922wFIn1F63PLjur163rIZ7fbjRpHUu//HMfj7STptsRUk
	BVv3rMBAph5F56Rv6KvOIUX+ur/78q4VAqxM7v5V0Am2ljPTDDK/wZAKNFQKyaT6SyjlXeD0i94
	fpNi70qwwLChTp9VFAk1VREjb7KlZZ1t6BL+cv/5WzgI3E+2CbyJNdllSJaH4WN3posELeLJvLC
	pOlPyBs4qPS9dmgPughoLBoUQ9vbzB81pU2Q8Htij9U7HcsRaVx5LyHrDOU8kI3GS3TphXxPBB5
	x1/cV6W+KihzgCcECQLQzzirWa09kyTH0qVRj6WEwHiN5URhx+0grGtVynpQs5VQ==
X-Received: by 2002:a05:600c:c166:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-483a9607d11mr211795505e9.31.1771941836478;
        Tue, 24 Feb 2026 06:03:56 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7010a0sm1043505e9.5.2026.02.24.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:03:55 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 0/5] iio: accel: adxl345: Implement event scaling and ABI compliance
Date: Tue, 24 Feb 2026 14:03:43 +0000
Message-ID: <20260224140351.27288-1-0rayn.dev@gmail.com>
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

Thanks to David Lechner for the structural patch feedback and Jonathan 
Cameron for the architectural guidance on ABI compliance.

Taha Ed-Dafili (5):
  docs: iio: adxl345: grammar and formatting cleanups
  iio: core: Add IIO_EV_INFO_SCALE to event info
  iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for double tap
  iio: accel: adxl345: Implement event scaling for ABI compliance
  docs: iio: adxl345: update event attributes and scaling math

 Documentation/iio/adxl345.rst    | 81 ++++++++++++++++++++------------
 drivers/iio/accel/adxl345_core.c | 38 ++++++++++-----
 drivers/iio/industrialio-event.c |  1 +
 include/linux/iio/types.h        |  1 +
 4 files changed, 81 insertions(+), 40 deletions(-)

-- 
2.47.3

