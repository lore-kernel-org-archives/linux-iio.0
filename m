Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4402DEA64
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775986687; cv=none; b=pMuTuWUrF2furDfZroJ3YvbTlL7jzeEJv23TZbir2JBtHJ1afxmP5nEAeotZfZUKwnlmjpWLKKLaUqaf97lvkGyJE13G3rkKZWqHuSsnwYRzvYckP+vaeOLlrivkPWmRJdHGf0/wsjOeRjfHh26SFo12Ay6NWS7Iv0DzXElo3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775986687; c=relaxed/simple;
	bh=NfppAcx4h7mFpBVBGvpC3TbT8jbBt8+mLrq17bPTb50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jhDLJ8V/cuR0CWHPdfLVLF0y8pzOc8JWoa08VuRNW8GN0TuvmSta4XmXHJKR+jHocwZJXbU9CH89cPDrdiqrKkXrp6UzDrmbpd3RAJHRorZcxpYDy5HTytniNHQsfG38C1tGdZ8RBkVQ/W4kbI4LAAUQqI3ORgRPeFGVXj6Qn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oH+OnZfm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oH+OnZfm"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f22f6b0feso356473b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775986685; x=1776591485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iivg2YP+C1CTGh9qXKnltagD0RTxEYWwojJWATan3Y0=;
        b=oH+OnZfmR/cvNRJcx6mrakWeDtBX11mPEHLPFDmFK7aB6MFddjOm6xBz3EG3gwHBd6
         7cSY8llG13jieaXElbybIcKm/9KPhkZJG51ryDO7ODG5K1V16NNCi6wugUAdCgkF1QQc
         MplMwIkpuOWUp1xRHNNg2WWt2to8a0NRzEbvgsyRWxEUCXs10hh8fDWe9KhzkJq2U0zD
         8isL64wfNSekM/IBl7X1UkKpsnAwH0D8EWCjY2Ts3tDGTWDaVAVlYmGYtt75xmqGlhtY
         tlALnPSrnv5kN5+jINn4q5ivCcUrXlWAtpKEyPCzsGJ40O79MIlfYUb2dhPzVZXOtpdk
         ULKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775986685; x=1776591485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iivg2YP+C1CTGh9qXKnltagD0RTxEYWwojJWATan3Y0=;
        b=BHwQXk+aDh6qkaR4p/ABMmsxF5kau/yAYMc70e1yh0k8W22xOUMonGU/jcKgBKiH70
         CgSCdlbGr+EEfQC8sGFhF+wKi/NfuikAxCmv0V8Z/9WFW+Wi+HUjmWYCdoWG0HqqsX1Y
         p4LxzSC6Xd8Z0WDdn1i15xm5ODwo4HljwKWwt1JasVFyoFxLsEKjBoYgLdO7WM6K3ZkJ
         x/XOWbtiqtiZCOLhLkkUsLzbTZT5bU95qkr9Kz3cQ5NLS9cxGYELK50hGG03NCRO/B6R
         x+kfs+NnA/eurvsK0lOVxfX0yXaXQjGpEXZqcckg07CSaeQJ7wXa7+kQ4mzL7Dj8zHi8
         Babw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ic/9ZpDdpI2HBNsop4FR8/PgaQD6Ogv+Ib33wwmuBTWe/dDoOmEGK6063oqLx4Dr03QVjQ0xffLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+WcPRoEz86+q0o5cSgXY5Of47uRjMElgYaj8FHWFowAYhmYv
	ENMHgnZG0H7n3X545W2FGJ+50jkWKZ7wzN6sDkot5jqOsvwVrJ6hbYbM
X-Gm-Gg: AeBDietswpG9DB0T/4Rf5HPN3rFh8TO7JwNsHukB7+7O3Lkcr28s0X7XeJwwaa4BeXV
	t/krFEJzIgl7KHL5iCLmdOSZz+wzD5nwpfWHQXlKJlM8YconJygC0OUb23WZXIugV3KASnn/vtl
	3cehGrYhd3WMVxjGOJT+7mA4XyTInN63niN1qqeMb7Pp2DsrmmOEb3o2Kq+UCdPqI8Qw7KN5w9g
	M990iu936YizsY/U0xeAmgel/QnPwmuliWhxG+C4ijH1rCziYE7E2WxIk5xFNq56ze8Fr2/BZJg
	FGtYdvovdEZEt2ECa/qqSp7A2f+hzk3ablTlz7vs4ytkCdxknFZthlEiiD8x0bd7CeAeETIovam
	q1iV1fi1FYlWtE1kxvwpbhBXLDU0SiQlfBsOY0Pu2gn0qgtoB185Fo+aMNum1DDm6ga4j8RPo7R
	TwGQEpEJWT0Uliiv0MdRj3qEpuo9a+oyJzg9GPlOs7i+LxMeduwOn9s0iyZOXLy5pOMywhC+IH
X-Received: by 2002:a05:6a00:10b:b0:82f:1d38:f68f with SMTP id d2e1a72fcca58-82f1d38fc7bmr4444350b3a.31.1775986684965;
        Sun, 12 Apr 2026 02:38:04 -0700 (PDT)
Received: from debian.ari ([152.56.156.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm7885038b3a.24.2026.04.12.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 02:38:04 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v8 0/5] iio: adc: ad799x: modernize resource management
Date: Sun, 12 Apr 2026 15:07:34 +0530
Message-Id: <20260412093739.17116-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ad799x driver by converting resource 
management to the devm_ infrastructure. This results in cleaner 
probe error handling, the removal of the ad799x_remove() function, 
and improved overall code maintainability and safety.

Key changes in this series include:
- A prerequisite cleanup to sort headers alphabetically.
- Static allocation of the rx_buf using IIO_DECLARE_BUFFER_WITH_TS()
  to avoid dynamic memory leaks during scan mode updates.
- Caching of VCC and VREF regulator voltages during probe() to 
  optimize read_raw() performance and simplify power management logic.
- Migration of regulators and mutex initialization to device-managed 
  resources (devm).
- Fixing a potential race condition by moving mutex initialization 
  before IRQ registration.
- Removal of the manual ad799x_remove() function and all goto-based 
  error cleanup labels in ad799x_probe().

These changes ensure the teardown sequence is always correct, 
following the reverse order of allocation, and remove unnecessary 
boilerplate code from the driver.

Changes in v8:
- No logical changes.
- Dropped unverified performance claims from the commit message of Patch 4/5.
- Added a blank line for readability before devm_mutex_init() in Patch 5/5.
- Added Reviewed-by tags from David Lechner to all patches.

Changes in v7:
- Added a prerequisite patch (Patch 1/5) to sort the header includes
  alphabetically as requested by Andy Shevchenko.
- Moved devm_mutex_init() to the very beginning of probe() (before IRQ
  request) to prevent a race condition where an interrupt could fire
  and attempt to take an uninitialized lock.

Changes in v6:
- Addressed style feedback from Andy Shevchenko: used '(MICRO / MILLI)'
  for clearer unit conversion and refactored the optional VREF error
  path for better readability.
- Removed the phrase "Reading the regulator voltage via
  regulator_get_voltage() can be a slow operation" from the commit
  message of patch 3/4 as requested by Jonathan Cameron.
- Confirmed with maintainers that the devm_add_action_or_reset() pattern
  must remain to preserve PM functionality.

Changes in v5:
- Used devm_add_action_or_reset() for regulator disabling instead of
  devm_regulator_get_enable_read_voltage() as suggested by Jonathan 
  Cameron. This was necessary to preserve the regulator pointers (st->reg 
  and st->vref) required by the driver's suspend/resume power management 
  callbacks.
- Simplified voltage caching to use a single 'vref_uV' variable.
- Converted mutex_init() to devm_mutex_init().
- Resolved error path ordering issues by using devm_* exclusively, 
  allowing for the complete removal of the ad799x_remove() function.

Changes in v4:
- Simplified voltage caching to use a single 'vref_uV' variable as
suggested by David Lechner.
- Capitalized 'uV' in variable names as suggested by Andy Shevchenko.
- Removed redundant 'if (ret < 0)' check in read_raw() (dead check).
- Used devm_mutex_init() to replace manual mutex handling.
- Introduced a local 'dev' pointer in probe() to simplify function calls.
- Switched to IIO_DECLARE_BUFFER_WITH_TS() for the buffer declaration.
- Moved goto removals into the respective patches where devm conversion
occurs.

Changes in v3:
- Split the monolithic v2 patch into 4 logical commits as requested by
  Andy Shevchenko.

Changes in v2:
- Eliminated dynamic buffer allocation (feedback from David Lechner).
- Cached voltages to prevent devm/manual ordering hazards (feedback 
  from Jonathan Cameron).

Archit Anant (5):
  iio: adc: ad799x: sort headers alphabetically
  iio: adc: ad799x: use local device pointer in probe
  iio: adc: ad799x: use a static buffer for scan data
  iio: adc: ad799x: cache regulator voltages during probe
  iio: adc: ad799x: convert to fully managed resources and drop remove()

 drivers/iio/adc/ad799x.c | 133 +++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 70 deletions(-)

-- 
2.39.5

