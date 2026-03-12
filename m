Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB528D8DA
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303610; cv=none; b=p1EI7D8oor4wXKXFyDiJsSo75k4GbqiVcPqvZ+D3WfAwxLKMQNAQoJEhVJ2tB5q7bZ2XioiUjZQILte7ICqrvSjpRPSoayeUNJI4m2knnySs0/O8XH8PAYTi9hljUg3szMVYtDi9Hziiu6MaIGa2U4LqOv5Ukrxg5U3AgJG4ACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303610; c=relaxed/simple;
	bh=NlAYTQgsoTvp/MwXewZo3441KjH3CRhh5IU5pjZuv9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ub63NqRDSdABcn+0YH8fDdyTdZ8ddR48CuWwbTS+Vy23hC72bI4bu51U1MM98I32FeIacNKIvnnoErJCGZyvSyLh6Qc4PAO/Ag1GqyjFMFdDQY4bx8HqP1JzvvRiNizFwHDjhYbZiAbjsTZph7f/Byr7QgnqzixYBKjWoaGTNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwCZeFa4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwCZeFa4"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c73c990a96dso225451a12.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303608; x=1773908408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d14W8PlqgOzBQLdrceuRDDfI7sBZ4wrcqB9utrv1QuI=;
        b=RwCZeFa46b3M74gp6GAKFZbvlXcASiVVHUgeEql6hFjHSF2tYcEV/0E1Xr5owVCdOO
         AtTrdAl9FSjbW33OUkHtnRcvSSg60xstR2DgDkVIwKl4JJihMeHLhbqKuum2DxlpQtYj
         XQsyLCFUCZcmfDeGQluIHHZMyaBur/xDh59RiMPq+eCylxy7ffcG2D0vq0vObeC6bO/1
         ktPuJDfJiEgkwV+k2/2ILBDY1I8Uu/jIZ+Vs54pLZE1om6Buwa/O0WQkl5ClNgTDF5yR
         4rbILu/h4DxUGSKJFNSzueMEFdprKGGMYNvsy7qqIb9fqFw5W1Ht8kRAv1nJY7NAkEDi
         DI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303608; x=1773908408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d14W8PlqgOzBQLdrceuRDDfI7sBZ4wrcqB9utrv1QuI=;
        b=xEzVY9ItW2GM6bWLgAACoRCwzkAnu6KjuMUfH9lADU8RtsaeLuacQ4Q7YzvfzdlSw/
         MTAI9RX4hW08RzlzK6vWmu758ddk1v1lz2QLcxEMzEizNzyOYfgDC9rspV2t01eQ9NSc
         TKZqOetJVTKZ2oin42Qp4B+HJy9Xw62k/oKwGNuQ0URzxxXGw71hFgAoZpESnUIe1qX2
         iMICDDLDdiT7j9Foc4wAWcyVmKuVJJnMyhoEJ3IN7GYhrpzr+yOZHDeJtTXJQ6w5AuiW
         atbo3ZEX1er3AkTfabaiIJHg84LXpOWs5wVrAyGlxbXvYCOsTAvBtCc2L5dR1K2s+Z+1
         9INA==
X-Gm-Message-State: AOJu0YxkqyPCVJrNGlkmW5S7wtKXVanFxC+powoQzHM8B6cF9ly9yHQx
	ULtLZMMdeFzr2LIjQB8hk7njftqn28OHAOyXzp0rbIzAdbhXpN8ghRZP
X-Gm-Gg: ATEYQzw8n8yvY/rVwwmxUJdhbrUXXvk7HTee+xVPOJ1KlaLBqQ1hegdHxAz4jMBQaH/
	eQH6N0EI11sYORaJQjyjqx/hN/6j/ugWq3xhI+rDAlJEMtY5qyIyRFBLe5BYX1/VzDv0zrvZ790
	OUshR31sGxxQrGYcNLeAh8BAlKe62Lmu09xTkVs5Y7HZ11zabAuqyZL0zTyLjlhw8CCr/yN05ex
	5GCzz3yF/PlhvBLrGnDWKvk1zQ6LhVGR/aAOttfFj5jzjit1U6GIOWUEOxLnRKgewFX8ED1YQRR
	F7KUWZZjv2uCfl9rWAc9kGn9YgnuGr5zHDlB7aE6OhwVEqHV+r2YtnUvxsj1D4LbpRTjbM/d83u
	G8GO2alO9pfytJJWm9ddpwdE2K+g1qSh8hYwt6Nm4sRBE1ExbdULr4HJEFZCmwrAVEM461aqC8y
	LHruKDuAcBlJbMNFC8eDNrhE9EGpKTfb3Ot47XRJh+LMEfW145WDIZnjgaPhj+Rdk77jk+/RAOL
	mgpNlEgGVKisBH40Fik2fA=
X-Received: by 2002:a17:903:a86:b0:2ae:6012:3168 with SMTP id d9443c01a7336-2aeae8829ccmr53713725ad.32.1773303608284;
        Thu, 12 Mar 2026 01:20:08 -0700 (PDT)
Received: from fedora ([103.92.106.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae24a91dsm64388905ad.31.2026.03.12.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:20:07 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v3 0/4] iio: accel: convert to guard(mutex)
Date: Thu, 12 Mar 2026 13:49:38 +0530
Message-ID: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts manual mutex_lock/mutex_unlock pairs to
guard(mutex) in two ADXL accelerometer drivers. Each conversion
also simplifies error handling by removing goto labels and
returning directly on error paths.

v3 : Fixed return statements to make it clear about good/error paths.
indentation fix and reducing code indent -- as suggested by
Jonathan Cameron

Link to v2: https://lore.kernel.org/all/20260309153408.71512-1-
rajveer.chaudhari.linux@gmail.com/

Rajveer Chaudhari (4):
  iio: accel: bmc150: convert to guard(mutex)
  iio: accel: mma8452: convert to guard(mutex)
  iio: accel: mma9551: convert to guard(mutex)
  iio: accel: sca3000: convert to guard(mutex)

 drivers/iio/accel/bmc150-accel-core.c |  22 ++--
 drivers/iio/accel/mma8452.c           |  21 ++--
 drivers/iio/accel/mma9551.c           |  10 +-
 drivers/iio/accel/sca3000.c           | 139 +++++++++++---------------
 4 files changed, 81 insertions(+), 111 deletions(-)

-- 
2.53.0

