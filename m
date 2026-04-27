Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CE2F83A0
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325609; cv=none; b=SfRBkR9EcPHxX7HNY2q1+rfe0svzBf3kmAQKKJc6Tt9mwakiotvnk+ZzGt2sS83ShBudgWcjU1YBwMDjkZcPm+YT3npDLMF2/mZVK6pGWIuadc1koBJ8xrmkAYFSET5KreO/tqeqH1nygI83SRhB1yrM6bll59YElN2z4vvLHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325609; c=relaxed/simple;
	bh=bmBhda2SXfNu+pnH6eDyxuTr7J9+ijLQlaJR1l0HlYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwIIJqULKQaAYbPIstehgpKo94JhAzJNan8Ddw0tLEDp5T6j5jyyG2Mv7nK7SZ1eEV8YbGMFmRWJkAQ3o/35fEmiCv0zc8vpQT0VBBaOs71I5ZvwpO0lfUXuBBF+5/fiWJNWOcakk4kV5Nt0kl2xA30mO8+/dj6xG2jK/i1sHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YICtelMo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YICtelMo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso79287255e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777325606; x=1777930406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Tqviw2J4SQxec8cpPz4dVaAo9bKFvw3GTwF8/MdD9U=;
        b=YICtelMoUCoiIAqvNn19Q+mI5Ro/5np4ITUGNkefe5c7HAiGVHHWNIS6TQjv8Bisly
         PJqd9NWK0xl86SIFNH7/6qTuGh+IorQpxPNOVhjAwcZGQc4g1uW19AGkPBxryqs6MN60
         A+NyATtn0bCiGkyZitbsEI1JrrhdkwQ0WLVdtzdo7QRawLpsTeYS8deL9PI2iHItEOLS
         a3+TOSdR3eNCgNQ9wrMsti2Dljovetr1HcJ6CyXZOCxV74qjBE5rmt6PdUb0kU0eJ5A+
         mlwQSs3kCaxq3WzGpbcjtHMgOohXBIRDvRs++9oFtPvdM4RZBZJmxYWGstBO+szRi1/d
         o9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325606; x=1777930406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tqviw2J4SQxec8cpPz4dVaAo9bKFvw3GTwF8/MdD9U=;
        b=YuF/xmeHAM/6/ZKC+Et8USv0Yp+EOSNd/Ih+Qa5aNR2VGGo6+eWBnH2qILWx7TmPFO
         EGoicnYukrAuJR0FS/ihvBiAvX1tb2nYsdj/QScVX3vxm3g4+YC1aqCXhLPwDbYX3qiB
         JDWX95ndPJUtFi5Crp5u90D+Ge+TjE2Q8c3aejLBD8coRcVZMY2gVaZCfWvPO8dDLZeq
         ET63t3hgx2GULv/SCMQqFiqtVhG8JRSwcwo8YuhqeH4W9Ip5KZmZVS+qu5bC2GswRp2w
         c1xIiNJLkF638yTigCOv74Ng1UdBTDN8TxrCzTwTrJVFfXGAqytr2xy4iq4Ey1nyiyqx
         Xu3w==
X-Gm-Message-State: AOJu0YyjOdMsW7wa2Fuaua2uBPfrU9r2HF2Oayv2c6mfa12QcYqebZWD
	2QDrbCQ0wgHrFgb1/9H8WnJD6uOa5ZcnNXCwQ4R9SoE2QG3S3gcFAvwf
X-Gm-Gg: AeBDiesEqGBn/11DYUfCui3RcuE6SyXE3cEn4O16kIThfSguy0KR2cBdkV6nqzEd5v2
	kUKNAv7TaZgGsdxmOy0HYV6eKlqL0gspz18mLiQre31LQFYQc84EmkPmiIiViP6hmE/uxfX+L/D
	Z/PE+jh3uzy0ftWV43nys5Z5f/G9jSqBMYre+cfqsguRPLp2Eaw4Iw2vVo0hym/46R1t3T7w30Y
	8nHBT3aelOzUKKr5E74cGf9gq9BUzZuXTZDSMRYW3rTRT5NGJ52XX2qltQItlB33clgpWYAG+nh
	LCwvXn/tFXMREgvRv3ITzmGHUfHDn8zN82Q4LgdsYpH0O2tljDDyZwVhe6emfIrTZdIO04iYVzt
	EtFohQ8O59z9PFlMtBSzxSlR6X50i85tXXC8uoZwgIM6CTRYgP8daQdkeolkEAlkT+7waXUPTz0
	+xGZKdQqgQG8pJ517MRi8237mNhkj+JE/Xl6L6j6Qc30efN1psWCkzSoxf6r4=
X-Received: by 2002:a05:600c:1f0d:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-48a77b27776mr5133205e9.31.1777325606128;
        Mon, 27 Apr 2026 14:33:26 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773af544sm13359555e9.6.2026.04.27.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:33:25 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v3] iio: dac: max5821: fix return value check in powerdown sync
Date: Mon, 27 Apr 2026 22:33:19 +0100
Message-ID: <20260427213319.25767-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function max5821_sync_powerdown_mode() returned the result of
i2c_master_send() directly. If a partial transfer occurred, it would
be incorrectly treated as a success by the caller.

While the caller currently handles the positive return value of 2 as
success, this patch refactors the function to return 0 on full success
and -EIO on short writes. This ensures robust error handling for
incomplete transfers and improves code maintainability by using
sizeof(outbuf).

Fixes: 472988972737 ("iio: add support of the max5821")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v3:
- Remove blank lines

Changes in v2:
- Replace magic number '2' with 'sizeof(outbuf)' for better maintainability.
- Remove redundant blank line between i2c_master_send() and error check.
- Update commit message to clarify that the 'Fixes' tag is primarily for
  handling partial transfers (short writes), as the caller already
  handled the success case correctly.

 drivers/iio/dac/max5821.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index e7e29359f8fe..dd4e35460195 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -90,6 +90,7 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 				       const struct iio_chan_spec *chan)
 {
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
 
@@ -103,7 +104,13 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 	else
 		outbuf[1] |= MAX5821_EXTENDED_POWER_UP;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, sizeof(outbuf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(outbuf))
+		return -EIO;
+
+	return 0;
 }
 
 static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,
-- 
2.43.0

