Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164C37B400
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513103; cv=none; b=AGDxr/+T+MLfhIjTdvHiJQqNWeoN6vvbMCUW0DYym3rgvcMklYqnRJnixokXYbuuteoEPd1lTybOdzdCG1ZOW8XYo4f1x3Qm6pyf+sfVORPHUbz7rl8DR0/3dvpL+bR/qAO5iYRHYCKKDR6b243Ix9AV56IR7AqM+U5Pf+rf9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513103; c=relaxed/simple;
	bh=dCaFEx2o+0LHihwArJ97BO8PX8v5GOTP6rU3/4UO94c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ssss5DUCY5H8dHwTvFOZr04aUxJPgQs8VlPjIpp4n9LTI4j38TDdtDYZfPZNcLIcu10nI7SOE56CEfJZghS1r+LFym7hU+UgtUOEIny4FzHi7dfHWjUMXmDyB/570tNLa4Gaa9k0jcqdXQkBMm9Am3sDnZIZ5wbfKdKQLLVrAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsoKPT2Y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsoKPT2Y"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adbfab4501so3140255ad.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774513101; x=1775117901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTQBQpGXKWiqONM2FeQOohjZzg7y+zTv62Tl5GC5mXs=;
        b=WsoKPT2YKBk+QVj4LTlcK7cB/KNzzjLBCKqG41jaqMkn34vEsfiPXTg6T0f0BSAN5S
         jVemKz2JkCJvxLqsqC3rFhmF0aEIjjPMwCziY6R1nbx67kZx7gLvhP+q0yUP+F3aomWU
         /GJl9/M8P5Ot8nl1VJAGmUHby8TxfnlMXONALSlQScpxYrBTkpQITyN56Q9ZeoF9N8P8
         x+ypVzvg6J4XnhsTcaurtXArO0rD87VDmbvdch91ZdyPS17GGhlGsd24F2JOV9Sa92LZ
         X+e58pvOsys+NDkjVy+J5/RuWJEWg7Is39qk2FTV3vFzhkF00eX7/3MaXu4s2eWMIW3G
         H15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513101; x=1775117901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTQBQpGXKWiqONM2FeQOohjZzg7y+zTv62Tl5GC5mXs=;
        b=dNv5PJNkx8oELFL3ja+jxbqq6FU3gmhjUvI1gX8Wrt3UNk3+xrormdgwOwNQEhw6e2
         KaFUOKTsuP5e6d5zLtpk2gSr6kBDocvDhKhvJtAP4hE3WHaeTC417sMWzKTlcyz3tDdz
         wkZFa4kXYx91IQx2KktGQ2leyk2OhVouK2m77WMUmFeGV+t+G0mxRUebrqxm+g+ijHMD
         zzICdnB0GdEahQHWorodgvRjIFABOH/rVENROyB2cGrooM7tDTxVSJbXf/KeTwapYU7l
         ZwD6KryHGJYen+HQ9N5+hnKhQHUsFJ9n/PWxQgWf6KAPpBtX8yg4j4h6yhBnKkefwMrW
         /4iA==
X-Forwarded-Encrypted: i=1; AJvYcCXcA7xo4lC+E9jNQafKY8ZKUB5szeP8YU8xm6sMTVM9C3ZBXJEYC5EkB9+qYW91Bi0ui27O8w/jtlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmTcO0weXREp2h0TLg3qga3TGFLEqCOchL0L8TUbO3blNhbJV
	uHhTXPQCjHiZZnXrMQELw2aGBkevoPRhi/b25dO9jDsNfH4my6MV0xoi
X-Gm-Gg: ATEYQzxuJSdeix1Ha1jfcJ2uMNEaypz8+hFtjbmhYkiiVGtahmmOMIIfUaLl4X+pWd5
	G172i8un3MF6ZUwQrNlgSvfAEWlVgBJvVwfClK3Tda2PUcnQ6PsxY8XLkaDBAHiCrXSdaYi6h6F
	+k3gOPMN8fLLYSCkckiM9u5kf2h6sFftuLJpO0QSyXNV9f/rtmq57QBqXtVH9h2Qb88Mt0xsOJD
	HWlgB4GK63e0KkWEH3BnJW47Z9tA4H2Lf6zb0j5fpkcRsu4ke01vugDaeV2Uu0NJQpFEocuOdjT
	/b5uJSAUWvzNd+tBeF9UgoWJ6XqRgC5c68LNsuS2eOb2/qt1I0+tLv13nIlh7zsoI4bgCqqBbDf
	Ulxv/AXEvEFghfTvPkMhuovUd3I6VLHNVCJ8AbIY4UQEuf5pBVcJJbje9r5+2nVWEdNmKhCCgZR
	VN+PfGMeBZytswTHpnVuWfLfjttscEEvJvtlzIfrWKCmMKcEaAf51VuW5E06U=
X-Received: by 2002:a17:902:ea12:b0:2ae:aafa:ec95 with SMTP id d9443c01a7336-2b0b099d294mr77686465ad.11.1774513101341;
        Thu, 26 Mar 2026 01:18:21 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e6cfsm21855535ad.39.2026.03.26.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:18:20 -0700 (PDT)
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
Subject: [PATCH v4 0/4] iio: ssp_sensors: improve resource cleanup with cleanup.h
Date: Thu, 26 Mar 2026 13:48:11 +0530
Message-Id: <20260326081815.925373-1-sanjayembedded@gmail.com>
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
- Use guard() helpers to automatically release mutexes on scope exit,
  avoiding missing unlocks on error paths.
- Address minor codestyle warnings introduced or exposed by the cleanup
  refactoring.

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

Sanjay Chitroda (4):
  iio: ssp_sensors: cleanup codestyle warning
  iio: ssp_sensors: cleanup codestyle check
  iio: ssp_sensors: ssp_spi: use guard() to release mutexes
  iio: ssp_sensors: reuse preallocated RX buffer for SPI transfers

 drivers/iio/common/ssp_sensors/ssp.h     |  5 ++
 drivers/iio/common/ssp_sensors/ssp_dev.c | 11 ++++
 drivers/iio/common/ssp_sensors/ssp_spi.c | 71 +++++++++---------------
 3 files changed, 41 insertions(+), 46 deletions(-)

-- 
2.34.1

