Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A273DBD63
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866826; cv=none; b=KCOLgzeRJoLiOk1Wr5DV7oGcI2hu0D7meMBXbpuc/dDu1pJR+Rwsfn2d4utCg+BWNGniuu7WtzjlpuMW2tTqZm5NXllWOrUpRd0emu36Eg6NKJakNYx/Nan9+dALT805i+3I0UfCS6uYZwVIyK1/vjLSIU9wdEm+EEC69F6mJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866826; c=relaxed/simple;
	bh=1d7ax7ArmIlwziusrBmRiXgwOXf2GODx23Y9ZvnXiWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WyAJmDCJ47eMbqgeN6ReuBS7dlKuwYmr96GEEM5VFjuKwkcTLtNvIZ4REHls5tFS7AZmaf76FfGXTKfLrdW++x6810MSwwvTDCB7sq44ZEufnxvRUfawg7EFcdzeEWwDfxs1RfD9sNJ7PrZ1FjL1si+/CXF1TuLVZV0a/ZlaFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWCdpnEe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWCdpnEe"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-83975e992e1so58223b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866824; x=1779471624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiA/iTtJ+uv1zyDP+7sre2EJnO7Q7Yw46hIXDh1qJ5M=;
        b=lWCdpnEezjgtE6SOGOdB69W7xbE5L4Gn0C1bIjLBQLtEeUDsCKSIZdHRyrIhNHR0+g
         P279TKQV07a98q1aWPeR3kpUqT8YxRL6bCvBsNcbG/9YE8BK7of3U/yp6bhZPdhCpQMl
         OtyM6gq/Lg4jd6Qs4N+jx+EaHWEUopfF431wf5CEXBfaOPPKtJOkF0qYIcI6ecSEjsDh
         5Am5EtG9Ivzcu47YV1sHlr3gpBtrMHKgO9LDO6k01rNpus+3bE5iV1HcU4+7h/FJtuNS
         aek2qNqK+87e7yDXy+wm4IYhTaqYupTUM8PdIg60QmMg3QSlXuq42QAscFu8SdjSfpgD
         54bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866824; x=1779471624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiA/iTtJ+uv1zyDP+7sre2EJnO7Q7Yw46hIXDh1qJ5M=;
        b=ai0vEOp+6KNBmlff+Cz5s8b//eL2e0F1E8e/FOszgmjnAAvcnDwIItjxg9nRGz/EyM
         Erz5M5ILmhiLTmkfYE5KDOoLMBiaYytAruzeOhX2nmyfpOCciXKl+ZxFNgBTHrHW0g2p
         EdnyQ+zRHJP5MqAS6C9P78uGJvMVr0ufjLeRBpFqjgaZcF55Ro2eSLYxaOf4uPCvUrxm
         2ZLAiTfwHs6KY3HXov3bMsT5AoI/8YIpduSKn8FYq4LLVFkNpp8qmXfIQmO3gXTEHHvN
         0KWW1bKhZSWqkp/Qqv8+AcUL/05yxJQWKE5ZIVOQDm3IoQH5FJW5HQKmr7ngykfT17nx
         gcLw==
X-Forwarded-Encrypted: i=1; AFNElJ8Kqguu05/nrOwEEXncfGvAX3YnBxcJD5tTAYeJZO4nXKYg8Kq3cXZAb/dXv/iVV7TqneKiQOvJSrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnk2FyteXYrMDbrmyu/Ktijd+QzdW8MiLoYasjCZdKT64yB9F
	0bv4TjMVbAaYYV/CkugXXtzyn+qRdhul4HyCTixWzxsEJ+/XpqHOTrSm
X-Gm-Gg: Acq92OHsz3LXdDD+okK/a/BXKZgTvGyoGeX/t2sWR/S/dPaXGmmOyy4prokXBx+Qtc+
	nagR7X9plQJGirWYxuOVznELaF8aNjHhANMY9IBN1MdLF6Io3xxAVvIBzhahtFIg8VJgLFRj5ub
	kiN6EhfPU/kwhdzsmblf+z4RXI0L42ld8M8wOT/la14ENbFRm9L1BU0VqSZ1c6992eUXb975+2R
	Mzxvx0O0dYkGWbjgJo29FYK5J469NMTzkCNvNJYCWTQKKzJeLwyTP4aMEtVMzThB5W/wDwRFU5h
	UDxVuNZ4LlJ5z5hAB2452gwzmpHSlX0llPWHj9i8DAgffUQzEs64kEYuh+blBCnLXDMBrUo6dHt
	vKvffG6ZjkCV2OYNpjNv/KLUo4qBdYotZ65b2q+va2rInFvIfS4kCgZxB5Yw7jGm5XpKEbpWwKy
	kE95f69ZPqlXdMn47xZXMF66bYaSgBYRmPcvJWINzr490lPLBLzztEqdI8GyA=
X-Received: by 2002:a05:6a00:4399:b0:837:eaa9:381f with SMTP id d2e1a72fcca58-83f338c1fa5mr5148258b3a.0.1778866823951;
        Fri, 15 May 2026 10:40:23 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:23 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/12] iio: ssp_sensors: driver fixes, refactor and cleanup
Date: Fri, 15 May 2026 23:10:05 +0530
Message-Id: <20260515174017.3962168-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi all,

This patch series improves resource cleanup and error handling in the
SSP IIO SPI driver by adopting the recently introduced cleanup
helpers.

The changes focus on making probe/remove paths more robust and easier
to reason about by reducing manual unwind logic and ensuring that locks
and dynamically allocated resources are released consistently across
all exit paths.

Key highlights of this series:

- Reuse embedded rx buffer for SPI transfer instead of allocating new
  DMA memory in interrupt context for write transaction between AP <-> HUB.
- Replace dynamic resource lifetime management with device‑managed
  (devm_) APIs to simplify cleanup and error paths.
- Refactor common helper API, improving readability and reducing
  duplicatation.
- Address minor codestyle warnings and use dev_err_probe in probe path.

Changes in v8:
- 0001 has been added fixes-togreg howerver keep this to have baseline
  changes for next patches in series
- new 0003 -> refactor transfer logic
- new 0006 -> fix variable type and declration as per review comment
- new 0009 -> use guard() resource management API
- new 0011 -> use return in all legs of function to symmetry
- v7 series -> https://lore.kernel.org/all/20260426091710.3722035-1-sanjayembedded@gmail.com/
Changes in v7:
- first 2 checkpatch patches are applied to iio/testing
- address coding type review comment from Andy at multiple places
- add warning fix in ssp_dev driver
- add new change to cancel refresh work
- add helper API for enable/disable MCU
- Following input from Andy add local variable dev to use with APIs
- v6 series: https://lore.kernel.org/all/20260415050749.3858046-1-sanjayembedded@gmail.com/
Changes in v6:
- 0005: Drop remove() path using devm action with input from David
- 0007: Replace dynamic memory allocation with embedded fixed size struct buffer
- 0004: new: drop duplication in remove()
- 0006: new: Use dev_err_probe in driver probe()
- v5 series: https://lore.kernel.org/all/20260406080852.2727453-1-sanjayembedded@gmail.com/
Changes in v5:
- Drop usage of guard() helpers to avoid mixing mutex_lock() with
  guard()(), based on reviewer feedback.
- 0003: Refactor shared helper API, reducing duplication.
- 0004: Convert resource allocation and teardown to devm_ managed APIs to
  simplify error handling and probe/remove paths.
- v4 series: https://lore.kernel.org/all/20260326081815.925373-1-sanjayembedded@gmail.com/
Changes in v4:
- Update sequence and make checkpatch style fix in base change
- Split WARNING and CHECK change with input of Andy as 0001 and 0002
- 0003: Use guard() instead of scoped_guard()
- 0004: Use preallocated buffer to stash memory allocation
- v3 series: https://lore.kernel.org/all/20260315125509.857195-1-sanjayembedded@gmail.com/

No functional behavior changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Feedback and reviews are very welcome.

Thanks,
Sanjay Chitroda


Sanjay Chitroda (12):
  iio: ssp_sensors: cancel delayed work_refresh on remove
  iio: ssp_sensors: factor out pending list add/remove helpers
  iio: ssp_sensors: refactor transfer logic into helper
  iio: ssp_sensors: factor out MCU enable/disable helpers
  iio: ssp_sensors: use local struct device
  iio: ssp_sensors: fix variable type and declaration order in probe()
  iio: ssp_sensors: Drop duplicated wdt timer and work cleanup
  iio: ssp_sensors: convert probe and teardown to devm-managed resources
  iio: ssp_sensors: use guard() to release mutexes
  iio: ssp_sensors: Use dev_err_probe()
  iio: ssp_sensors: return errors directly from ssp_irq_msg()
  iio: ssp_sensors: reuse embedded RX buffer for SPI transfers

 drivers/iio/common/ssp_sensors/ssp.h     |   3 +
 drivers/iio/common/ssp_sensors/ssp_dev.c | 191 ++++++++++++-----------
 drivers/iio/common/ssp_sensors/ssp_spi.c | 146 ++++++++---------
 3 files changed, 178 insertions(+), 162 deletions(-)


base-commit: 1548c54e9adc32a719499216f63fba14b2fc07c3
-- 
2.34.1

