Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BDC3859FA
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003208; cv=none; b=dJldeliBTxa7jharIIWuWkrIkZSTK4SAM+Xde+K8r4Hv/cNVrpVnE2m22fdRtElW6uWMqQFHlgZSvuZOD9PY34KgiNIfkEHNTmjbAjVWoYpm/NNFzl1FTJuvp/ftxs8ahOo+N6WwdVKEFVyFzKozwVgUCQKBKCDhWAow8HDuz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003208; c=relaxed/simple;
	bh=PUNtSBuEatClgjBMjyLHBxPTzxpwB2V0sxv2SWHcjak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T60pInNIOpHhNwq+KE22gYiZl/hjSuZoZuSN0pObHEElrs+J+ovDjDZhs+ghFGNtjbYVI76hlI34RdObaGrOplWpi/SqONCJMcB6qiYPVVu3DSsqdpl8X1cBE0Udsqmt6IavXqflNxXubAGO8DiqW2nuJNyxyeYnboJBJUy+A5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITo4OQLf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITo4OQLf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so48371905ad.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003207; x=1778608007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzZ6I08BF20R0mHRJF8Tegn0MvDeAshZy+C4O431KX8=;
        b=ITo4OQLfOqB46NkH3Iup5mKa21rjchsmN4yTYqZbQYqpiQ9OT0KG7Y4eHBxkM3s6oI
         4KBKvstBsc5oVhrV5ZUzkfiFKHRBqUQSyMy+CznchuJ9p75jKhJc6CKjXrkH86YSqD0m
         DfG30rG+0IBxax+SzGa5sGn6ZvfOKJe4Oy47JgtTW9wVAcS+buSiF+lLwQJOI+divJ4R
         KVtFf+JiUVGTI2mSm7vsA16PgkO50kCS/vv5rRhjOG5tBPuqCiwgtxQd3XtjK/lFWAir
         D2HISmGVm4rs+TF0MHl+V+7jmLKp8cK8FMHad7GmbUhqHqI1YwFZNw/+JZuFRwOijWZK
         6T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003207; x=1778608007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzZ6I08BF20R0mHRJF8Tegn0MvDeAshZy+C4O431KX8=;
        b=VsQTvGq2jhcJe4U9VwIfxJIQPVqNr2AfPKZAUwnXMNgXQnVKwyy6QXB1nD2qM8w+Wk
         68OThsE7gwRbB7j+QWQJeL9eFCF1xG4p3U/jExftPKi8TWu99T0ZUOqIYgoC1lXa6Zb3
         Xixlr5M4aFQr/CeyIts9NGIzzqzDqbqHa55GwyBbWm9zYxvfYVMicXER3OGOs1FqgXUa
         qg0t9CNjOYJ32FJcCnG1xxF1AkG6oS+481dr5TN6AclCc1nuka06yS1WDfiYUdz8lix5
         Y93NYVTCta1rGKJcUSLdXKnpVsB3iAUw89SFHrkhbSITtbAX2UQj9QWCo4Kjgk7cv9b9
         e4Ig==
X-Forwarded-Encrypted: i=1; AFNElJ/yR/nSSoMRYG2guDqSdLTVCImvUThvCfbYGxB3/zRGzR/+QS5H6a+Ct9sS66QDBNIULPhlcay6skw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RA+IsYjWi7GfpOjkL9wYyfETeEeunvlg2cUB9WdIPXil7o6l
	L82vwXlAsZpacmo7jhJyEktq6en3sooj/6vGFsDFmuto5Z0JT1qo6mCl
X-Gm-Gg: AeBDies8sjwNvDjx4oILXRm3DnTdsWXwffpGGdTky/BN8EYXNIy8odqP+e9SpxdBpY8
	5/1jg8lfiUrD82tlFxbyuKmNVzdQJfUJDd1s73c5KpCvO9eORtCGwig/uEtbMHxI8KrBJjdtd65
	0bYYOfuVyEJkpXzbCVfFY/ibXQMvchvoRphT5DIQTbCLLK2Hq/Gvw/9MGV3TdzqJT9g9nidU+aU
	EiIpBtyQkU0hYr5vv/PeMQRtt1JunTbTsYeSNB2013sqRdpF3dwvSkmQZvZrAO0roZLXxC+ry0/
	dQ01tMPRCZAgrGU6yH6BnRYzRQttjgFoLUahdQmixFMuJoNjr/U8PTdZd9Mis5Kz5ieq2IIHz7b
	mdIXqomphJYoYqymucX3ye1UsZErLmoHQqMOJqFjHRpuPaRew0YKB5a+PTux6b2CMnB8yKNkpxI
	0oSfF1hm0C79sjlSaNEAZcrpcYcd5p4+zglUR3gT5kIl+OH3tTR2KGMQu4sWM=
X-Received: by 2002:a17:902:6bc2:b0:2b7:a3bf:b2a0 with SMTP id d9443c01a7336-2b9f25337camr96268125ad.5.1778003206573;
        Tue, 05 May 2026 10:46:46 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:46:46 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com,
	martink@posteo.de,
	mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] iio: accel: mma8452: improve coding style, pm and resource cleanup
Date: Tue,  5 May 2026 23:16:30 +0530
Message-Id: <20260505174640.3998281-1-sanjayembedded@gmail.com>
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

This series contains a small fixes, cleanup and improvements to use
modern kernel helper API and coding style for mma8452 accel driver.

The changes modernize mutex with guard(), dev_err_probe usage,
resolve checkpatch CHECKS and pm_ptr macro usage.

Changes in v3:
- Following input from Andy and Jonathan added new changes as following
  0001: handle return value to have proper error propagation
  0002: use non-devm API to maintain resource management LIFO order
  0006: convert individual regulator using bulk regulator API
  0009: use IIO cleanup helper for DIRECT_MODE
- Address kernel coding stype specific review comment
- Reorder local struct device and dev_err_probe change
v2 series -> https://lore.kernel.org/all/20260422165643.2148195-1-sanjayembedded@gmail.com/
Changes in v2:
- 0005: address review comment from Andy and Geert
  and use DEFINE_RUNTIME_DEV_PM_OPS macro
- Added new cleanup channges in mma8452 driver

No functional behavior changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Feedback and reviews are very welcome.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (10):
  iio: accel: mma8452: handle I2C read error(s) in mma8452_read()
  iio: accel: mma8452: switch to non-devm request_threaded_irq()
  iio: accel: mma8452: cleanup codestyle warning
  iio: accel: mma8452: sort headers alphabetically
  iio: accel: mma8452: Use dev_err_probe()
  iio: accel: mma8452: convert to bulk regulator usage
  iio: accel: mma8452: use local struct device
  iio: accel: mma8452: use pm_ptr() and direct runtime PM calls
  iio: accel: mma8452: Use IIO cleanup helpers
  iio: accel: mma8452: use guard() to release mutexes

 drivers/iio/accel/mma8452.c | 278 +++++++++++++++---------------------
 1 file changed, 116 insertions(+), 162 deletions(-)


base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
-- 
2.34.1

