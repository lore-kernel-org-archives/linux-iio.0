Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5F38238F
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877012; cv=none; b=OoUvpMxPmcIMHpv2TWyyTFCUmNE8NM9DXjT5NBi+RV5yL7K/9KrIPAzGE8ZLY04wjXe1O8c4rpRrAKTT4dB2fhRBTZoMAKXFiCyUelOkpOJI01Aoo82sA8HvY2eliM8nXWXmiIUc8jDO2ZbWEPfUHDexV4s/XXoM8V0iKeGwSFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877012; c=relaxed/simple;
	bh=TLvBOSNObsLvJIgCJSNv/jblDRz7/reew0opuXHeWBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p2l9HN+cy9NDqmJ8cR9jim0NB7ec+mHR1ZI52HSSRUswsyMM3pWq4T3u716E1fE+M0p69WA+vdw4Nfa+WxSFZ4qMei5jYsZ1RnlMzjvpSPh7AFELeAEayptzhfmEb8s//zapvehrXSfY/nhKNmdqxTUEBFOe5btfs1wm5qkQQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPTmxrD0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPTmxrD0"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso78356a12.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877009; x=1777481809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K12TcbgsT+4ST9MSMjjIqCkvressiDAJI7GqkumZjUM=;
        b=RPTmxrD0Qx4DvKSwXT8uvbx7Thc6lAljDR6a/ABvpL6vVTuysRnQ6RAvC6GJxGJTdv
         s7Ve6UY50BGAzcoCT9IWwz/ABKEzKhxQuoEctAYgyLCiaGeWG7Wl2gkLEp77Qbq7/k5L
         zSFdstrx9Ig0wTa9T2SceUB7g9JpzbJjSxsWHMN5oQEMwesvPSzICmHgUHwDjQeEsvfW
         FLobt4ly+ZOJR8Z1LTEvGSqJUnn1HsQeuSpMoeg4K1T5sHVKuuyMzAr7qfrYlrfk/g3k
         PN3kfxf2iZmAb5In2atDOeVNJ36S+4GtugmjH9iaSmZcBDd5zlxhDh/RjAQZ2Bs0cubA
         GUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877009; x=1777481809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K12TcbgsT+4ST9MSMjjIqCkvressiDAJI7GqkumZjUM=;
        b=LmExrH7mbu9Hv/LLV9huC8pHYr+XoiKchMT8lNqo8oCDr/0JUDOxiykam1of8Htl96
         021X+3vec02qqVYahMGOWePPDSo9FsQVbiiJAxJgeRiSaYJby+4kW79RcxewlgghV1vR
         muFrtv2N0B7e8hbZxdgKxHLxY2V/CKEMiEteIhJj2vJlFsZDagy5D0XpWGaIkoA42ZMo
         WkovSlADG74d/0Hd0OxzA3JE4fD6u8n6o7+4GEQMCRm3XfzCv16Vd6UcNEjCau4yI8x1
         21rQS/QF9/lSS3WYqcDi4TU5cyPNBEfFmO/emE4lc+t+utu8xNanOaTUCbluTjQLBC5X
         P4Xw==
X-Forwarded-Encrypted: i=1; AFNElJ9UXt22Tv4Vu1yc4/Lhm9CBf41VjyzeokikJ7cj7O7CyNmgLu254Jgm1fOWdaG5HCSQMYLeMVwIgXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5FJd/3u5VWTJyW/vkY5vg0JuS8Sctmjn3hUPryiMpQ2mR66a
	HgAg4vwa1IEtzX2y4cr8RDZ4qgayyIgmnvPYyqookK+xZXiiJ77aWAej
X-Gm-Gg: AeBDieum36YJYwUAOUKcIibvDcFAEngMEtADwU8Kp2xiCXLO8VRBmnaRjo6hm5Uys/a
	FIa20ix6Z4Yt0KtxrWoVu/2o+ElcRCcJK9NkLPorhjRXQt9x8ya4mSFEwZ4n0G8XbDJB9Fr4gpn
	hvDBVr+VEtksmvip8kcGTDIXfjNGjTCzWfvqBdLHjwa9gBJNxqYKh6tovTRTBuL/arKm9ah8W4y
	JmVJr69L3gPO0MSG05pUxUS0RzgEyTl8sILibvu4bZRegoUQYW2Q/Qes44pYwTFER1B6O3F+wou
	sPv4d4RxcXVzd4SlIEy0BUCd78JiOwscEbbtO2wDBfNoFSm94l8GMrNUzPZX1TXjgniaCaUQNZ5
	+4igbI9UFlJ28J0/mRqRUAI2Pv5zffCalPxfVKBxWikdLL+nn1oeNh+N3f/vH7HygbEgj3SXqLu
	kiEKVkKJMD8hRwWj3Sw43YMFlqwlSts56nPhVxmu96f46CDlU808aUIWxgKTM=
X-Received: by 2002:a05:6a21:3389:b0:39f:3ca8:a315 with SMTP id adf61e73a8af0-3a08d74a3f4mr26659015637.19.1776877009270;
        Wed, 22 Apr 2026 09:56:49 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm11908675a12.14.2026.04.22.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:56:48 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] iio: accel: mma8452: improve coding style, pm and resource cleanup
Date: Wed, 22 Apr 2026 22:26:37 +0530
Message-Id: <20260422165643.2148195-1-sanjayembedded@gmail.com>
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

This series contains a small cleanup and improvements to use modern kernel
helper API and coding style for mma8452 accelarator driver.

The changes modernize mutex with guard(), dev_err_probe usage,
resolve checkpatch CHECKS and pm_ptr macro usage.

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

Sanjay Chitroda (6):
  iio: accel: mma8452: cleanup codestyle warning
  iio: accel: mma8452: sort headers alphabetically
  iio: accel: mma8452: use local struct device
  iio: accel: mma8452: Use dev_err_probe()
  iio: accel: mma8452: use pm_ptr() for dev_pm_ops
  iio: accel: mma8452: use guard() to release mutexes

 drivers/iio/accel/mma8452.c | 161 +++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 85 deletions(-)


base-commit: eade2b843d9b1f668fc1775f15611bb0a1999cd9
-- 
2.34.1

