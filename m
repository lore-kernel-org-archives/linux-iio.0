Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76660259C80
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315680; cv=none; b=PHOBbOEOZYWK1ChewZ8nJ6oq+4ZXPYBD/iEEj7kHlGo2KwIcBqDtdJ9mVy2w8G+9XzlhpLPpOKoJBMYQ+voySSXw6qGbjfRtYMdtJUaV70FYz7cLEUi96MXKoNoRhgXpdbjEHUzmXNCTwES80hZyKUdfOZ8K7lxIKamKtVHnRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315680; c=relaxed/simple;
	bh=wTbxh2MlTF/SATwgPxcSgasOURGnrHvN7V4NMt1Xms8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfMH0GxYYa/ONdsTiVvvnYo4E/C/9b85HOSpM0t8u4FdPkPYW+J/5dlqnCS42ESfFKSa7pqwT7bSUlqjp2lEIilSo+2fNAqipqj+NPSbIIxsJ1ZIxf6Ak1F6WsSirzHpbeFrY1RXuixOdJJw2gFqRz3RCOMNNR9sXJa8O2UHw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TokAy0a2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TokAy0a2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so8443144f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777315678; x=1777920478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nxqm9/Nr9w8xSnN2bsQcEKbrb6xQZSKT9g2jbx5CPmY=;
        b=TokAy0a2PMJXf07pujNMldVoYwHWNeIVrpl/Cl1lhL8E8lKMLHlGv+N4MZcLscrvGg
         4OapBQMCHJl3GBm6nH35u4n8mSvSD20XPgqyu+zVBygvint2jNiPTzV8P49lMj3ws+rE
         cz2BH9ktOTNI3xhCCHQh/wZGxCtKjhWT39Sqj37PQSI1iagv0wxVw1EDVDsaHZ0D7Y8g
         y5tuVk0cCNqnCDignIfK+MPp97Kwg23wRe9XS4sz10XQmSvLiBdsTju/mAe1/bHYc1Cr
         LyMm/p213SQLvOlVVaxIzlV3auGuR7CDcqjmzw2vSCFcYmxEH2tb2BpMJrp1pduckSKN
         R2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777315678; x=1777920478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nxqm9/Nr9w8xSnN2bsQcEKbrb6xQZSKT9g2jbx5CPmY=;
        b=lpk/WD07NzKAB/4Bkw6o9SWIb2CABxTEk7vclBCov+uUil3WX29pvqpdLhPqeOBgxI
         Ryy3KhTn3BuNfqUSooHJ1hxEF1Qq/z6/O2F1qJi1oRY9tYrLkUK1rm0rSHF3ZC+iHRV6
         KpCa/Y6ddXFu56+Id3vB5ZvmvgCrhg0HFiEMjxWWk6usgLBrYOXEo99TYHnuiL6Dzln3
         sPNYBXlHe4mXLZklmaO5p6ATgFIRB47sTWYbglG4CrmBJT86AQdmeWIMW3HJ3Au/82GL
         bdmSBt4VqOax1ZjckhWMjTUsZoWoN6kXRLvS2cdNlpzdWnk9nUzW2uiKzH/AINxkS9Vc
         TwWg==
X-Gm-Message-State: AOJu0YyDbCcmenAV5VxBlFkDd94cfVZer4O3WRL6eaPmSxJLjEgDkJ66
	t+LoUYl5f1zKsrGoA+lYbdvnrBRp/foIH/WWRR1mcOlTmcB1DtQJbi3I
X-Gm-Gg: AeBDiev424xpFWBZBVkGO6RQD/0DAA0Ty38i1teyoE1Lgp2Sda1RVS/+SneJ3nnX8wL
	k8tSBlgUchCqQVr7HM+s2g9gsd+sfLurLsqujhLEI2B0VRXhpi5or5EB8ru968AZYU4R2GfWSwr
	l5zMFB1hnijdJ/yo5S9knIrK5G5Eca5axRsc1SrIMYIcpmFnYQvF5zR0xwMxsV7g+2+tIdYN6Pg
	Cx3+FrtU0IFvuCDzeaolh8/gWuaZ5zBFAuMQWTCVR/iLJuBcHL3pAX5GissZI5sMjrkcnvfPNlj
	Zjn65L/AtdJ+IkwzZXYj0D2wWZ2CbdEZvbhj+XHjnJTge41RPjWNFBEsg0n6fLSckZtcnqeBkYU
	caOWzBQgjFo+1isdxe3rmJZGLeobe5AvUARK5i8GDY/P8gXU9fr9IQhfGINF9nPI5G0RRv85/b8
	NE78KhQZzz3IVsiXKwd3NJlBXKi4ZbLzvCgzz6u6YT183UsFPCdaPD0IX2z7g=
X-Received: by 2002:a05:6000:2207:b0:441:1e41:194 with SMTP id ffacd0b85a97d-44647dcf477mr119745f8f.17.1777315677578;
        Mon, 27 Apr 2026 11:47:57 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fa89140sm242134f8f.27.2026.04.27.11.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:47:57 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: dac: max5821: fix return value check in powerdown sync
Date: Mon, 27 Apr 2026 19:47:46 +0100
Message-ID: <20260427184747.12149-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function max5821_sync_powerdown_mode() previously returned the
result of i2c_master_send() directly. This is problematic because:

1. A successful I2C transfer returns the number of bytes sent (2),
   but the caller might expect 0 for success.
2. If a partial transfer occurs (e.g., only 1 byte sent), it would
   be treated as success by the caller checking for negative values.

This patch refactors the return value handling to:
- Propagate negative error codes from the I2C core.
- Return -EIO in case of incomplete transfers (short writes).
- Return 0 on complete success.

Fixes: 472988972737 ("iio: add support of the max5821")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/dac/max5821.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index e7e29359f8fe..bd14f578d8c5 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -90,6 +90,7 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 				       const struct iio_chan_spec *chan)
 {
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
 
@@ -103,7 +104,15 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 	else
 		outbuf[1] |= MAX5821_EXTENDED_POWER_UP;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+
+	if (ret < 0)
+		return ret;
+
+	if (ret != 2)
+		return -EIO;
+
+	return 0;
 }
 
 static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,
-- 
2.43.0

