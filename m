Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3672309B2
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195040; cv=none; b=Durjr445v3Awie0RXhG2Xe7Ae/YTT3lO4Unm9oPnWNmJ9zNmNvMCK8Twy1CbvwseLVXPoL6Oqu00Xdu77KKeOEhr6uTqTp8Acxzl922zh6yJBfAvdoIKxBd1Oezwu/gPwYW9fwS1gsnD2y6Y3cVRDOycpKBclBdQehAQjO/Q9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195040; c=relaxed/simple;
	bh=6YD5lmuSP/KU9lSsngIbKF/df/VIgmIJ9/4WCeguCmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t76lA+Ar24FUFqKO5CfpnaH31ITKISX32s4ixcL5rEZj8rgUiyVcsolaBhldz3PXsm/Cm3/N08yroI6C2Ge67byPOUftMbwPvlDV2Hx2ttEJeeIlcDFOu8Ocpda1Q2o9xliS/rS7vlV+YzmA2iSWDbzjwILHC6qdGbaLbgMFcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXM7L3e6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXM7L3e6"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f8cebc935so3978315b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195037; x=1777799837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s31dAbn/prtdXROzCOwtXc84m9pisb+JXLl0mELobmA=;
        b=nXM7L3e6ZAwll678BvsQyPFMylCzMPYXDAi7ujxfGVAesmOaBxXXf5V0jsjh99cP0P
         ij2KbNKKNKN+gLa50qtJEuuWXTQXoZEeoy/wa++ej0o6G6hKWfDYsxlLdiVKNpnk0Kon
         9wNkkTE7q1dfW41zxh1kC+NMf91+OiDzLRH2qBOzMxhTDwoVfDxnyirhptDyryw1wM/C
         WCRWB8J66M3ISPmf8YnHxjX/bqgfL6zmZK8kP32Jbvc/WTROb7gFHm+Kib97Jz2Cdkfl
         c43mm9HpashgOythsCoxhTVW+tBbqQgZTiLFmMaYvcDzeWYpTKIBbdoI3nJ4tvptdhN5
         vTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195037; x=1777799837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s31dAbn/prtdXROzCOwtXc84m9pisb+JXLl0mELobmA=;
        b=bDrbQsFw1KqW7MddH/xQXA56QVVareDywy2b+PdhqUcLRIANQklYjZmXOZ/5Ub0bPA
         Jb+lGaPhV3GUTO6HO3BuYIQvTYaBjgQyqn6Iyh5J59MpoULSDAh9QpXWuK2SypF8IPhA
         qI83+vUlrjYvthhwT2p1+qM9JHzkQ13DXoMXJ0kNBH9YS1J7UnX5gP6g7RVIe0CjR5J0
         P/RgCr4weubcQsKpquDYcfaUri4WWSiH73ahR5DOVlBlRuZVJ8EEH/YMg1eqFaqTmKBI
         ECBaduVzyG27b5H2fRgzWTD8qIdLsWK7+YdHOqw3CiuBO/sekTeSdkKao+b4Pqge3suQ
         BjDw==
X-Forwarded-Encrypted: i=1; AFNElJ+bPnOg3uZRN6MWnK+jIQ9W/ITDkcDnRlew6qvjM2a+Mv//ojiZ+c81TUYGJNFB9lbFY6N4cOQHJrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzka4sg5qMLgNqVRZjYpr3jqxoyUKtwKUlOUjmQ0IokXK/mCgT9
	AWowfY9CcvMZ9J0IcuMUdtZzazCsnwPlTrmARI8Q93Uh9v74k9ZqchLR
X-Gm-Gg: AeBDiesMzJRie6wd06nGBScndA8MXdknwAPQ2KRIT9p42hPXGCmkC2/utvq/bM4cZZV
	SGtpUPWGIFRxDiYP6LKgCZt5UOTlij1ESL9O/V+mBNjg7IsTuSLXNmMeUPiLh1egkcmcQXYLKux
	5q6YcPDUA9WMF4w4w3Yvkffw6SjjmH93gXUU3gVg+9fqdLrdLTiEiPa56ZGufi3ojzk9QbfRVk8
	tiZuQ2KXQjlbGTEwdZhRwEVUA2d+gGnEpjGWXQR48i0L7dFBiRihDfi2MVw0uXTY3ZU4hSdfrow
	TVKbSuuhJDB1yQMPKbiaGOqJSRsohSZ5jxBB02XeQYPipEXZPNneeoFKJksE0/zop7Q0od6UGld
	C+FyBerddP/LckXLjCdhd2Wx1bmoxM2MZ6ffMTLJw5JUeSnEZfHq/sWOWAOj+lmqglOLHGHAxqd
	zqqOyYsZ+YOI5DXxoCw7SzBdOVQnYgN/brw7CscS3KalCCBrkI32LzUWDzT6Q=
X-Received: by 2002:a05:6a00:21d3:b0:82a:6de8:fa50 with SMTP id d2e1a72fcca58-82f8c82eac0mr38746714b3a.18.1777195037434;
        Sun, 26 Apr 2026 02:17:17 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:16 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	kyungmin.park@samsung.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/9] iio: ssp_sensors: improve resource cleanup
Date: Sun, 26 Apr 2026 14:47:01 +0530
Message-Id: <20260426091710.3722035-1-sanjayembedded@gmail.com>
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

Sanjay Chitroda (9):
  iio: ssp_sensors: cleanup codestyle warning
  iio: ssp_sensors: factor out pending list add/remove helper(s)
  iio: ssp_sensors: cancel delayed work_refresh on remove
  iio: ssp_sensors: factor out mcu enable/disable helper(s)
  iio: ssp_sensors: use local struct device
  iio: ssp_sensors: Drop duplicated wdt timer and work cleanup
  iio: ssp_sensors: convert probe and teardown to devm-managed resources
  iio: ssp_sensors: Use dev_err_probe
  iio: ssp_sensors: reuse embedded RX buffer for SPI transfers

 drivers/iio/common/ssp_sensors/ssp.h     |   3 +
 drivers/iio/common/ssp_sensors/ssp_dev.c | 168 ++++++++++++-----------
 drivers/iio/common/ssp_sensors/ssp_spi.c |  78 +++++------
 3 files changed, 128 insertions(+), 121 deletions(-)


base-commit: eade2b843d9b1f668fc1775f15611bb0a1999cd9
-- 
2.34.1

