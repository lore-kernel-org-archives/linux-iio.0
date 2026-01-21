Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B93ECBC4
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994894; cv=none; b=R3Z7Cfqik2RcZyg8zDEdo2y51tjvPvuVGBZJKW33rd/8ZFjS/yq5yqV6Dh6Zro2yJCLuCTXSTfeHW+ITxlcB1f0DeB0Gy9rDJuPPbZjNE5qXB5pAFA2Djsal7neco01ynmEfV2Z6VWbst19hkD9XhBEXucBHq9JmDDWHiUSCwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994894; c=relaxed/simple;
	bh=lE2IgaG++I087QsymLP2KGlkbozwEaPp0L7Yovt1IZw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NP4K+XRLbiOMvKwbsVJLkB0FPyi0LWCUy9XNyapeuCr/k6nWVrRuK6WPzyORCm/Arv26Wly2s4E71XJUWLkPhHLZABKAP7DklN8lMMcd883eubdRa6FnnbS0jU3TZiC/dYybHMIOZqcUTOyuX6+xD1tLbB4+iRR8yUpXIjlboYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=addjDmLq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="addjDmLq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee2715254so31249125e9.3
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 03:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768994884; x=1769599684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuxlWujdaqujUYBUw57TtyLwcuBmh8d7+k2M3TaDrqg=;
        b=addjDmLqiHBBvcZmxoAcDBeVc4RMCcezgivJSkcHDtkOKt9G1tDo9yS63EyKYXDz4H
         ASAH2E1TtWb24fB6RmnkiEQBU8BJF0milT2SCOy1nRtWtSTZQnqoc6HqA98YECP/+S49
         65JKvP2B/5DNrzE+sS14oAwYWKBUFFV3LxmHBEniTXbR/SqXvZFq4YqIYWStWZ48kESd
         PaTBpy1mXZb+SOjDO4u9zvYEm8ZjdVTejpV7XsLyuOeTxsB7PNJgD5cbqy3Q56DkDoer
         nte19F0uu/IGxCj8qxOnclYRJTSjB+c9vxoeVrOXR8I/ZqJ7RlhGVHW6p8/AitZy2Hhz
         Dtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768994884; x=1769599684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuxlWujdaqujUYBUw57TtyLwcuBmh8d7+k2M3TaDrqg=;
        b=Qda2MqsZnpy4pULUf3ik9Tl6SJm3ro2jln6neZLwe/zqOWEPpfn2PAfxnSWYPXNwrC
         26Dvv5oVOkNBwRm3ZFqOoKRsp/4MvaE1o8jjxCDL7vZcPz/Ejxi3je1sUmFdEJWoN5QG
         9sSlj1coqMU8k/jTHdyvLBRU2cVf3nOf1YrOBQr0v+wlA8RS7bHX5Q4QhdCfyLypZwTL
         SNNuNncCua51QWzqdDgGVMjSdgOLoA6gW14/lCzTdZWZkTF3sqdMqVFKrmh1bDyT3NqO
         xouZi+di+2fF3wkhvHpUIxeI/yo5pNiDOrjxyebZIAnRQJsR3J/AvdT0+ndK5qC2vnQg
         fWcg==
X-Forwarded-Encrypted: i=1; AJvYcCUeFLOyDeFbPZiFcsuC6pVXYfwQJXr2JU5FPhcUldlHqabiotf1PwIHd8eiEriMH9Ai5oU9T5fW9+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvH3rycWzdWrZcyHp7BBR5XHx4YS9Lry3EAkttfCGk8U/K/U3Q
	OUyIzu/JjBqx8kX2wGap8JZoSYjpJZouN4eXcyIbbBnhv1D+cYuJzUCaWTYpb3YGuMYA9EiaBBw
	YHYS/tzs=
X-Gm-Gg: AZuq6aJWBcUH1aoGPB1s10Lbe1viR8IwNpVYSgTRr645kJ0EGyV+E8OYKdcLuCf4OeH
	dj3KYx0fQAj4WjWr7TllqLMxBlzhQV5ftNCegm0dlUeU7UJ266DrlySnKz+FSS3FfR3sSBcwARB
	YsPYoul2GBH27998bWAMhRP73MVgpny5xw/VIMrXCIQUrNRYV3OtzJGPp7GfSTj6REAAWzOlUH2
	MQfx+m5LRUkeqeKAsa3AtW4Ey5wFBm7Za7UWosG2oKXoe76Q0WqsmacmPSuQvN+mFj9IwlxD79C
	7mAjSB66fm+PozBiNEnKOxH7a0SStZKMS99lDOERU2OH5V9zPz4zAx6c3AgpIL740agbsLkHx9Q
	XavOLfCdEOu+YgyCjtlDvYvsRAuVnrbTonuEoBB0kTpP+db4JYKs3VhFSI72OWA9sBYQhI5n7eJ
	cqVw==
X-Received: by 2002:a05:600c:154e:b0:47a:80f8:82ab with SMTP id 5b1f17b1804b1-48042c3a712mr35592435e9.24.1768994883793;
        Wed, 21 Jan 2026 03:28:03 -0800 (PST)
Received: from localhost ([151.44.214.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8795f1sm308810845e9.6.2026.01.21.03.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 03:28:03 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
Date: Wed, 21 Jan 2026 12:27:57 +0100
Message-Id: <20260121112758.1831077-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121112758.1831077-1-flavra@baylibre.com>
References: <20260121112758.1831077-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=flavra@baylibre.com; h=from:subject; bh=lE2IgaG++I087QsymLP2KGlkbozwEaPp0L7Yovt1IZw=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpcLgkmNhI2M+Evg51dxaQ+Pt+CbKA6izHu9SIp dzuPKMwFjaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXC4JAAKCRDt8TtzzpQ2 X8mkC/4142jkaid41m2d4h+JAZ2MtvFaUrGDqUvm1O98cjVNQaStaqftHFPeY7LEJ37mxxBSmkF 3wc3d+rN1opt+2bpiZuzL0PBtIaUq/u+HOqhYbTiO80sOZs087JeP79YjiOajJnUjiFtRmS5XMn cogLHdIRPiqUaZtNzguBUhbAnrMR4kWqpPW1LdH/HDIiJrVUk7ByhLRcRYV7hdvAjDCuuki4Sl2 4ZvuO8cir3bAMMzj4B5oex+fTniYNbX3tOlNcYEJQPmPzT+mg/RnsjLqV4ractnYvmsnhT0qR3S 3Ei40Fjyk0ZozpP5HXPAIAU1LiKIvM3tft1HQBzkoJWzvl4QDuTPmL5BwbXHzZ9sHNSsqSAW6HQ 7OL3Ypmd+jb0wnACwVEArR8vyJIhz7do+UIs+XyQ6WuP4c+5N7bcw3epEA6/pOQ2UlSM918cePg TzDfFNfXJxVPb8+IIE7vhGa7YG3Vhj0u5Mk3acK+ZGUJQ9v3aivNO10KWEt2BSJOowjOE=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The DRDY_MASK feature implemented in sensor chips marks gyroscope and
accelerometer invalid samples (i.e. samples that have been acquired during
the settling time of sensor filters) with the special values 0x7FFFh,
0x7FFE, and 0x7FFD.
The driver checks FIFO samples against these special values in order to
discard invalid samples; however, it does the check regardless of the type
of samples being processed, whereas this feature is specific to gyroscope
and accelerometer data. This could cause valid samples to be discarded.
Fix the above check so that it takes into account the type of samples being
processed.

Fixes: 960506ed2c69 ("iio: imu: st_lsm6dsx: enable drdy-mask if available")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 5b28a3ffcc3d..4cfd5046f98e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -541,12 +541,12 @@ static int
 st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
 			    u8 *data, s64 ts)
 {
-	s16 val = le16_to_cpu(*(__le16 *)data);
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
 
 	/* invalid sample during bootstrap phase */
-	if (val >= ST_LSM6DSX_INVALID_SAMPLE)
+	if ((tag == ST_LSM6DSX_GYRO_TAG || tag == ST_LSM6DSX_ACC_TAG) &&
+	    (s16)le16_to_cpup((__le16 *)data) >= ST_LSM6DSX_INVALID_SAMPLE)
 		return -EINVAL;
 
 	/*
-- 
2.39.5

