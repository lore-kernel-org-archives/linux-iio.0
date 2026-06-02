Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECA3E9584
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406996; cv=none; b=PRqqn6QOeAr5+xphoy0ckeJMpGoN72nYkURsDUojdWbArl+oJ/T5JJr6szSV/6b2V879akzEdcFze2006MF9Hn81Kzj1ckafP9fGPaQIjoIMbsumdymJxGi9cRDdEL2uTZsrpRZx3BdevMr97SCIrnz8+2gyA69F3dEYp/9w23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406996; c=relaxed/simple;
	bh=4FpMGJ4OsVuZU9YftSRVpMeA21GrTfQm11y6TzFSqfE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UGwF6GOVT6wVps8xsLYvg0oX5ep1CNOO9/iM1eu8ANwy2c6/1iR9depjCudKXRVd0t+3HCLRf1w4spqyjnXF9hOjw/qYrOxc9P99nLOdWhXo1Ysu0dDViz0YfnTOA+N7aj9izpU/BAlRKT1aQv/5kwk7kTbqi5d9WPMhFSz0x50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDzUptvL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDzUptvL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1324777a12.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780406991; x=1781011791; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Snq+LdeDqbvOMK351yWf/iLWSA1kcQDPfEfOxIHirM=;
        b=nDzUptvLWLmJVYiolZ76ZoaL21O2o1xiGCmDx67Bc+uH34DmMQxFl1FGepepg+z5Lc
         Nx2zJ6BL3vQkSqEDm1FMGq8ZHyiAAvLMRJ+/svBleWV0lbyPeg9LNpWZNK6E8e6a4Cvt
         q/F8gKG75G4iEwsmwy22urqBjLgDCbejLZjNvq9q/9vNQ13i6qYIafYnD299mEWwgMr0
         O8Iu8vlMJn0HtV/RSH4gE6/Wu98DaTjWvRjKz04zzwlMf4hcfI/cgjmAwNHpvB8GY4ot
         nZDD8jzbdjxoMAL36P+1F67DZac8VMXjGlnEi2nkfq5al+PkDsrjVDmQUx72pdqdjERl
         rnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780406991; x=1781011791;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Snq+LdeDqbvOMK351yWf/iLWSA1kcQDPfEfOxIHirM=;
        b=SvWzWXgHOubZJP56H8p0yMGdTRj3FfGdemexhKggU8YO9AvNM7K5DHQ4duRmEn6Fhx
         lgBNr9pjvgQ5JDlSTX87l76khFwPP/9ErWfFxSLxONEI/bAI5ti1gpq09dYzOJ8+MrTN
         wBDgG2ZiQYpoC/NyvuQJ91FOjeqeGKM5THq4OGnWWfwIqPUD+H/JMlgHVLAHvktiLeXa
         leuyvuuh+qHsDtkAm1onueCZAB2ReOgw4w818J6G7woSEE8s/fbx10PymabP55LiwxRp
         RUcOdii91eWfedCLLNiM6dfR1PX3OoTBYOn8dN0aHNNVC3F5y9prpV7G2pzo+5FuKsMR
         EIDw==
X-Gm-Message-State: AOJu0YwE0Ex2BdKJYf1i+2UJ4x14oDcyHDDL9LwqsJmlYxiBpgwoMLan
	o6cCR9SK55oLdS4SnXVjordKfd59d/8Qi8awz0BcSSmzmP2CaJUXPr9Ys1H66A==
X-Gm-Gg: Acq92OGMe7++r4ETz7haHdLMAAKCXNNAFYuwToiBtFy9WFwhwgXN3A1cQLgkyshyhVZ
	1NSDULSBFBbRVE1+zTJfUxf9STLBkGA9HFpNpFGpCGT2OGiszDcPuO3k0WrCo7TruNUUikS3C6o
	YZQMVafgz7u4pAVeQOHtHICmyXLRN9orKhGJRjoi1TXawcxueTHmILthIuvzGM2vGCM56qV5TR7
	7UU4LSLbK09PylV+sZzx8czZ6sV+RhMunC49IXfaM4Fjsz48uWw6UlERNf+p/USxY3kffekxO9l
	oCLVbShLuYncJL8IbSe4lkje0T4zuu8kF2yaeaTnFaeWMTBBKei13fVAkDYOQl9MkMQRZcXxgW9
	ph12wUJu0z2RBHVaoHPH++RgH8HNYktXjxlyF0QR4weHrKQXt2u4RTzc8Req4YeaRbhafdAfilb
	TedZDGDRX1zXkN/S4CvqV7Kelfo6pkmeSFMgXg+vTwKgQAU+DPuJif3T/BGEU=
X-Received: by 2002:a17:902:e78b:b0:2b0:bed1:46f7 with SMTP id d9443c01a7336-2bf3687a3ddmr181023605ad.37.1780406991393;
        Tue, 02 Jun 2026 06:29:51 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1ee6esm148548215ad.33.2026.06.02.06.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:29:51 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH v4 0/5] iio: accel: mma8452: improve coding style, pm and
 resource cleanup
Date: Tue, 02 Jun 2026 18:59:21 +0530
Message-Id: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHaHmoC/yXMwQqDMAwA0F+RnA3EGsXtV8RD7bItg2ppVQTx3
 +2247u8A5JElQT34oAomyadpwwuC3BvO70E9ZENhkxLLVVYNWhDxOBRdUbvbceNwY1xER9QiIm
 7mx3F1ZCPEOWp++/vh7/TOn7ELd8UzvMCXwbUPoEAAAA=
X-Change-ID: 20260601-15-apr-pm-iio-mma8452-v4-temp-e040489abec3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2

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

---
Sanjay Chitroda (5):
      iio: accel: mma8452: convert to bulk regulator usage
      iio: accel: mma8452: use local struct device
      iio: accel: mma8452: use pm_ptr() and direct runtime PM calls
      iio: accel: mma8452: Use IIO cleanup helpers
      iio: accel: mma8452: use guard() to release mutexes

 drivers/iio/accel/mma8452.c | 247 +++++++++++++++++++-------------------------
 1 file changed, 109 insertions(+), 138 deletions(-)
---
base-commit: 7b84b1e9dd850a5c9b55e27daa4ecdc2dd5b3431
change-id: 20260601-15-apr-pm-iio-mma8452-v4-temp-e040489abec3

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

