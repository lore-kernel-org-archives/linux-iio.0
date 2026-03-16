Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213C37419C
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651645; cv=none; b=bEODGp6atE8yUpgPISCeFhCGZA9Cc2ueJ2DJdRfPvkCoDxWkgWZSj6iJn+APv8tnmQ9CSoL0/BHAgB+lLofXssdIALGhAHs/AwojyAIwG82dpPhtSmQiVUuIdRz4JvyGrme5jUcnNt0n5XfbR2PIidTitFUwEvlbBOrhg7ETmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651645; c=relaxed/simple;
	bh=Ez+0uGQ52+IUV8Lt9xv4qouXLy2kKV9GFqAUQ9JNWMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWz2RMP9dYO4Ut/e88HAeNtS/eOizasgT2UkYDwZZRWmBGQaEWuPaQPeDuuasJlPIFy/FQZAT1SibAiYBEdGwS5c8CN/sIOJZXy7a5hek7KxD7FjkKokAtSAEaTW3r8Zoq094CSeAeUu+P9PT8tHEnaVm6nzqKNkv3wKP1qKtn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEwusloi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEwusloi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae4816912so28345915ad.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651644; x=1774256444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOeJvDxArRmAukka7WzQkPiarwYqVEMJb3GhbN84k5c=;
        b=YEwusloiE39L4OdDhn3tPgx+k2D3IPIaQHvAVCf1urUaQEl/vauRS80o8O33HK9QbC
         g6INkF2npQwxg28zWwb/xS9EgAK4m1IfycYJ6WL+A9MQxXJTWlq/kNFXXtdC2gc0hojs
         1tWHxNwbNL8yyWqYD1Lvx2d/vP/PjtFfMo8H6n0qDigcSwWJGUTOBv8otHZNFcuY84AT
         3mQp2iMjKcEZOLE8E9+7ckhLy1HHgNvLSA/i4Je6phx4gSz2Df9vFvEx0CfrPn8twSbu
         ysqhAcSrPkou1jH0qEJlzcl/eqm7Hpy6Hrrw5Wj038U1xglt5oy8RN41XNHzY9kMXNRU
         3+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651644; x=1774256444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOeJvDxArRmAukka7WzQkPiarwYqVEMJb3GhbN84k5c=;
        b=GTQVtvat53dPVMwZhS1NsQoQNMBz6GbEMQGiKS43DSSHQ6E094CINLgo/xfdwHugzH
         IckPVjMw66fjPftkKNH7r2GD1tzS0xjhxJDguPlna8BTINdJ08ZS0RqrauJC7uYCUHJn
         dQ6T36SZYFFGUNceLtpp7tqLaeKHRt3AZeCmFl1D6l8NRxoWGjxYyyJBy49SByxgQgG1
         nJZS7oQBRiMZWJsH3JRPSQFdK9mmI0dSmM36HJ8+WRoSO5jJz97OaNjoxJ0IZMDw36sH
         Wa8X1hbtMcrtrjAr96z0UGk561he9XCKTKXEkFVx5y0Pq1m8FHCZQ4qJM3PONhyxKzH0
         nYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF+65Pfnku/3PiLscPz+yug22lbbxDwN74ThIhZgxFznw3NHHA4boEBZTtTLOJQdm2NToiTuv9uLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56Lj6WOc1JEitDA+haGByEHpDTx7Yr2PCM/OhGWwgh0IbLBNb
	kRiF/EjeQKLrKFsm60q30sMqW6uM87M2AvEgRdci9C9YU8Ini10iQVAB
X-Gm-Gg: ATEYQzwVRFpVEdCy5Uf0ROONTRTjLlzzCq92diVThTEkeVVjXnF4gSiM9bVbYX9PEIy
	T8B8My9zEssfjwoCKboXezcXSIRnu9Xv33wIDScXIvVrwbl5HLkvCrXige0fH0tKTGT9konuS3z
	K4tfk6QskKcwsGC6sThEnl44yoTM7IU5klfnRLGuc4Vh4aEPYSvXZOTvYrBiYgcDcBi59JgPTzf
	bXJVgVxBKWOG+dtMiLsrB1UM9fDgY/ZyajVRJpgR1rREipNuxPUtsL/WylaUzOyKm58PlI9qyY4
	ZLudzXozSp42WpNfKJaYfq3y3uTBY/EY3YaK6Ij7Xjh5oKQuTEE2zoSNhNLdYY13NpejJK36ZkU
	55Mpla9VFp1PRUw+n4MqjPSwETwjWSV+/KywnFFtTqp5/ZpRYL3RpqUCmyoDV3DeMq69hAJeonZ
	FcyR7p8rozCqSy7uawZkQWGJ3njWZJKf3333c=
X-Received: by 2002:a17:903:8c7:b0:2ae:b9cd:d30e with SMTP id d9443c01a7336-2aecac3b278mr133202565ad.37.1773651643803;
        Mon, 16 Mar 2026 02:00:43 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:00:43 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 01/14] iio: accel: fix typo celcius to Celsius
Date: Mon, 16 Mar 2026 14:30:09 +0530
Message-ID: <20260316090023.14691-2-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling in comments
- celcius -> Celsius

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/accel/adis16201.c | 2 +-
 drivers/iio/accel/adis16209.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 5127e58eebc7..ba0f97944c6d 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -147,7 +147,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
		/*
		 * The raw ADC value is 1278 when the temperature
		 * is 25 degrees and the scale factor per milli
-		 * degree celcius is -470.
+		 * degree Celsius is -470.
		 */
		*val = 25000 / -470 - 1278;
		return IIO_VAL_INT;
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index 41ffd92f27fd..04e169f221c4 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -186,7 +186,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
		/*
		 * The raw ADC value is 0x4FE when the temperature
		 * is 45 degrees and the scale factor per milli
-		 * degree celcius is -470.
+		 * degree Celsius is -470.
		 */
		*val = 25000 / -470 - 0x4FE;
		return IIO_VAL_INT;
--
2.53.0
