Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD82F507
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430174; cv=none; b=soofnBXU/YpsV9ddD2hOfMVJHaZzcVx3GhxgUvjx1s1IiZYnkv9wLGO+lC1uEQQGkw298hU0w7V/NbET3oJYSvmjwiKrtvLZ6NEjB/1Zr5HpdKWvRz+LOPXbLUt9G9QRHrwMY34mlix3mJ6ZSQU96zYU76k7oAkhPwn7zN9t2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430174; c=relaxed/simple;
	bh=UVALwF+PWurhclFx5Hd8PYiCfGgZkb0in3Jy0eY3yhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=liJa4ZfqtZ1Pl52kKuLmnjHEk4UJ8CEbFRAXvuy2WI2hTQ+aZGtdY/A7Al3uviCnNaFfmr1PJw+d224AfUZTy0dqi/uSLvhiyJHmevQjkueRtzg9XZPw2RHcQ/rmkLHemgXY04iI9wo4Qca/YDzCbgFD+oJf/h1acJmX7Mq349Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7zCCsX1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7zCCsX1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab46931cf1so12991395ad.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430172; x=1777034972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCOf8DQWmwYIT9cyGd4okBAij51QTtyTXuHIeY8p7n4=;
        b=E7zCCsX1M3m2GxLWDjteh1fnesQAwL7aDkdlZVQ694yYXV7KirAmJ9YbH4VsBXEmx9
         qdHSLAPEjNAoeuY6ZjQp/4pGTXcH+N4ibTe7liFWR09ABaeNSJvMf1xc767dllwdEagf
         VVgZtzguN17WKWBHzdwFaJ2yMv2FUsxZB0UZi+uMd2CrGXxo43izqc6s4q8eK2LbNfz5
         xljGBmTkqmu/LJThGzS42bHdbE0o95mwGm5YW/rsSAhI7IN1aIPjPalBqpF2RCnY+/Dd
         n2Q9dRcerO4XbV4vVR6//jkaX9QEDU3mhp0i+MXVXqNYxEsjs4XGu5YRfQTnz8YW/Zju
         VjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430172; x=1777034972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCOf8DQWmwYIT9cyGd4okBAij51QTtyTXuHIeY8p7n4=;
        b=SGIG4Tg6+PasCfV+B1BRBW1z9PVwDepClcco2oT0a80ladS46Sb6MQIXpu9yoINRZ9
         t8ezaUVUJe61LRQOpr52fBb5298eB4iKMCOcgPgCsxmSStp0HS5RN0H6HyECQDqjqBY0
         mlzLUW7yg4gOpdP99UjXDubt1zMKNQLww6CRjBKc15e2ypMglKXaIGvn4FPmQNiBwABy
         raQ4lh9ujjy6zsu7Kzt9a1RQusfRsc/mfoXZ5EQguFdQHFwSftYvzz0NO/h/0+TaeV+h
         TPAOCMacBdc6qu0l/qi4R5wE6Qmu+bk06j2AUaNs7jWGkQN4+rqgMD70O4MMDZl1zrD5
         METQ==
X-Forwarded-Encrypted: i=1; AFNElJ8693VzYvBxa+aZ26otsVb/lOAiJ8YLWXz5ZipcS2d7eJ63XSJMbwWcp7dL+XgyIQjVPB+IZ8dW3LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvc2d08DtdVVVcc7cSY6Sl50p5a/uYfK58d3UJBuyhohplRJ6
	DY6uXiCB85PrfE53fM+FqCpXRPm2bH0dznfUnafSU63LHfHBiLfDcl/9
X-Gm-Gg: AeBDiessxXjuaEtoHFa8Q3qP18/j8PZblbcZzQoO32O8zYnABqkhQnPKjd8niFkUapB
	H1EI9KItoXBqwyyp6jt1hm1/i6t60KLU65lm7S8amlvhysmczct/G2j4VoxgVX7V96eMgT01G6G
	GQ/1uUg8jio4Cn4llIGZx6izoS/8pbrDp8A/pL+AZlGMk1l6LV+LbLogPLxrA5tjvYE1bOaLfEX
	txeqJJQvCYJpONfoGZJ5/PtZY/CDgL3PoDVa18kCeZW3Q8hUfpdXkpEEbxPtRHE2oSo1gHlLqjk
	2IZrXWhXb9z5VXHDRRsO+D1I8FIEZLVmRwYEreJqTAr009Gpvv0/rc8Cyzs/KyaKck0Uyv0kUil
	hUFLbfeCuDx1G2TTO0rgQzKCFiWZxwg5l/7wG3LmDk8xjYnov4JMlO4+/EU2JKs5j9GKVwWGxyj
	K9d65KL65G4gsilTk8brSVx3yJr6ptv3bICtlVSxNcWvIiPHThCkKJ6gCfvjM=
X-Received: by 2002:a17:903:1aac:b0:2b2:54db:3e93 with SMTP id d9443c01a7336-2b5f9ecb056mr22323885ad.23.1776430171529;
        Fri, 17 Apr 2026 05:49:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:49:30 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	puranjay@kernel.org,
	cosmin.tanislav@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	ramona.gradinariu@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: accel: small cleanups and error-handling improvements
Date: Fri, 17 Apr 2026 18:19:16 +0530
Message-Id: <20260417124924.353189-1-sanjayembedded@gmail.com>
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

This series contains a few small cleanups and robustness improvements to
adxl313, adxl380, adxl355, adxl367 and adxl372 IIO accelerometer drivers.

The changes modernize mutex handling using devm-managed helpers.
In addition, error handling during probe is cleaned up by switching to
dev_err_probe() to better handle deferred probing.

Changes in v2:
- Drop guard() changes as it's already available in iio/testing.
- Rebase changes on top of iio/testing with guidance from Andy.
- Added new change for additional iio accel drivers.

No functional changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Thanks,
Sanjay Chitroda

Sanjay Chitroda (8):
  iio: accel: adxl313_core: Use devm-managed mutex initialization
  iio: accel: adxl313: Use dev_err_probe
  iio: accel: adxl380: Use devm-managed mutex initialization
  iio: accel: adxl355_core: Use devm-managed mutex initialization
  iio: accel: adxl355: Use dev_err_probe
  iio: accel: adxl367: Use devm-managed mutex initialization
  iio: accel: adxl372: Use devm-managed mutex initialization
  iio: accel: adxl372: Use dev_err_probe

 drivers/iio/accel/adxl313_core.c | 10 +++++-----
 drivers/iio/accel/adxl313_i2c.c  | 10 ++++------
 drivers/iio/accel/adxl313_spi.c  | 10 ++++------
 drivers/iio/accel/adxl355_core.c | 28 +++++++++++-----------------
 drivers/iio/accel/adxl355_i2c.c  | 11 ++++-------
 drivers/iio/accel/adxl355_spi.c  | 11 ++++-------
 drivers/iio/accel/adxl367.c      |  4 +++-
 drivers/iio/accel/adxl372.c      | 10 +++++-----
 drivers/iio/accel/adxl380.c      |  4 +++-
 9 files changed, 43 insertions(+), 55 deletions(-)


base-commit: 0ccdcdc698b7ba52f2c9bc09bfdf9f020ca0e6e6
-- 
2.34.1

