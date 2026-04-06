Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053FD3043DE
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462940; cv=none; b=W3cFeTkA38TmwMtQSGrljRAeqv8ohkrSDbPqUXHhnJ1FcpYCTiQENF9NfupgfYYmn9X+w8M11mLHe4UMBdEweiw1ExN6BuTI/HCTIqK1lej2XDiuOFIdsJM+M72dPXYdZc2WrRRfJSNbtF6q9uYkj3HFGN8qfzunwSO0+TBEZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462940; c=relaxed/simple;
	bh=y+miQhyfleVT/QglzDlFnG37vcecfD/Kg1w1h8wolGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F43u46J9PAU4ZcOMQ4G5LeayuU2PrEm0oZ6XkDCUYEA0ZqxbiWUJKTKnL/qxkkc2hJZaK0YANe6kDxeTOjOh5n94cI5jZjY3tIotrhEcyeziRdY9hPvYKEcGuAh190r/oayfByWY7oaVemGcTM2EdlE1pKX2m8OvARsCFj/Ume0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/b6PFTG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/b6PFTG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad21f437eeso18364435ad.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775462938; x=1776067738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ig1TReV+u6rJrOh3GodDEdZe+CeQGVyzjtit5wuoEZg=;
        b=J/b6PFTGAw+K4NTeymyIBJYliYvQWVe5r8kxoFGwpNUXuQxSsH5m8vJqrWmSVlf7EA
         BMra8MDCjtUnPU88UhpxJAL1TX7FrYbYYPGGAalOVTkOsk8PLZgyIt4ritQhvB79QMIO
         OTOPCKot1M8Dc6u+tbc97ZroYGqt21aibdHq237lWkLRHLvvFZhigOb4UkE3LQr9+oMI
         IhfTNRmWcFZzQWXqnXubFE23pj0MUfISCCDGvSt81Bf5okPb7UdQvuNZ12vPm+mXJPMv
         Wkja6UxD9v0Dh1aj6LAqsFPWkUsqJRh42+HxYczRHCQEW7eEkKwRhu6Av0rMh91yejn3
         eY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775462938; x=1776067738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig1TReV+u6rJrOh3GodDEdZe+CeQGVyzjtit5wuoEZg=;
        b=JDR6DCvXJ24hLArDOY2QiMIuxGzeyJj/yfRA3CC6LqGXS7ub3Bmhw5nOKshj9CU0iM
         /wJrDhhxHM6OhjXOsK9Ut0h/7SRbFqsp50gCAwCZhckGwVD0T79Sg7XvwEeyIi4UQAIq
         d4iIlmCz3uIgY2dCu5Zg/l+TQYsZHEetqkMvtWJKI7+jfyYnkUvJvg4Kuj6x4bO3Xoqc
         jvM73VN+uwSuCfyMV302+SPY9qhTFewknhnFhDc+zfZYvRDwJQnVVz9AE12wbkezfWIO
         9uEk9OQQwwhl+huywn3vXa2O9YH4C3TZ3waf/Dw+CegGDd+SYfxKnqNerjvwz0jaIS4f
         g5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVpNomxFG5LGX/NTmOFpIJn16oqrqb3yyvOZ1NNBktI1GGvPx/wDk4QJVIhgxkgmXN5HjRilmSeEug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUTRV+1RM04Di0EJEif6km7UxsGQDwq243RQor805VyxsPX/y
	quXTHytw8KsRa4sjYOkzJGnewZ0ryt3L1eQA4gh7l7DqFbUAW/sNm9iE
X-Gm-Gg: AeBDiesnf2uG744/duI2p+SZ+newo6yKLW8T5mEk5B6pDnxW/i6pGH2AGkfAIJEEzWv
	3Cx7nc2c/k5vfrlrMhJP5EJllaWyquxSJPc5p+WsjWOJmlc9LEsiTOxppJNxe4pGF7Tat+GdCOZ
	KJyAErLFVmLyqZsGAfGrGjz5Dhl85h3eLM37kewt/xZWgxEwsXgFJUN1s7T/kQbdOYk9QdlJfXd
	IdHi67xlMJUTP4Jq56dCaU9ReqtRVC9XwEXT5+jH4HdlbtRZVYzOttz2APbHo9V3hyYn+T5+B9+
	KNC5YemhM1rdiSI4aIb+W8w2AGQk20w7xAyyc3h6abctjE7jJ9Ddvl3H5GhNQiyum2PuAcoSFur
	75B/C9SEwT+ApRKlhyyXJbfUoEnL/bCisq1kl5UaySS6vSUpeQFC8/vcWhSMFMw393HFaKMEcPb
	avJNBOgoZv+N+Uq+DyGuvGi25rgWCCiFRQqP0hUdxrn81/p+OF+U/n9Y9ROxQ=
X-Received: by 2002:a17:902:db04:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b277e8072cmr137327115ad.28.1775462938205;
        Mon, 06 Apr 2026 01:08:58 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af19sm127961835ad.50.2026.04.06.01.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 01:08:57 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v5 0/5] iio: ssp_sensors: improve resource cleanup
Date: Mon,  6 Apr 2026 13:38:47 +0530
Message-Id: <20260406080852.2727453-1-sanjayembedded@gmail.com>
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

- Reuse preallocate rx buffer for SPI transfer instead of allocating new
  DMA memory in interrupt context for write transaction between AP <-> HUB.
- Replace dynamic resource lifetime management with device‑managed
  (devm_) APIs to simplify cleanup and error paths.
- Refactor common helper API, improving readability and reducing
  duplicatation.
- Address minor codestyle warnings introduced or exposed by the cleanup
  refactoring.

Changes in v5:
- Drop usage of guard() helpers to avoid mixing mutex_lock() with
  guard()(), based on reviewer feedback.
- 0003: Refactor shared helper API, reducing duplication.
- 0004: Convert resource allocation and teardown to devm_ managed APIs to
  simplify error handling and probe/remove paths.
Changes in v4:
- Update sequence and make checkpatch style fix in base change
- Split WARNING and CHECK change with input of Andy as 0001 and 0002
- 0003: Use guard() instead of scoped_guard()
- 0004: Use preallocated buffer to stash memory allocation

No functional behavior changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Based on:
  <linux-v7.0-rc5>

Feedback and reviews are very welcome.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (5):
  iio: ssp_sensors: cleanup codestyle warning
  iio: ssp_sensors: cleanup codestyle check
  iio: ssp_sensors: factor out pending list add/remove helpers
  iio: ssp_sensors: use devm APIs for mutex and IRQ resources
  iio: ssp_sensors: reuse preallocated RX buffer for SPI transfers

 drivers/iio/common/ssp_sensors/ssp.h     |  5 ++
 drivers/iio/common/ssp_sensors/ssp_dev.c | 48 +++++++++++--------
 drivers/iio/common/ssp_sensors/ssp_spi.c | 61 +++++++++++-------------
 3 files changed, 62 insertions(+), 52 deletions(-)

-- 
2.34.1

