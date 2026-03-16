Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133034DB59
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651668; cv=none; b=Ri2hBz5CJ7rMzH5Hbx29eW/Q/9J8jDqDleyzOuMDiJei7V5pk9FBdHENCqOH4BYt+pXaaDjL0XERe9Wq08WXWzm3OBVnBJZ3nvHXiesa6m7ZZUuuzNzxpSTpRxe3CwHb/JaEGW7+RVUWMCDYvJOCvZKjpRRhT3fGxUAjCfSYHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651668; c=relaxed/simple;
	bh=eP1YnoKsQftK3d9pGTK1hsKHhInCt8UesxLnKlbO+fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAr/4cq7HjLuJMfNR08GyPwb1ha/dnb5Td0Uc7im/zPuDe1bSg8eTG2r5yLjsKQug2byISAJ8xBavF4V+4Ep5vlmAhzd8bZnonKbWn9Hkrpk/b6h7JVbufql41xGUvR8ljfZYZcd4pOz1uerdX4HL3fvusWMXDR5Sq6eM0bJsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8h3CCqM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8h3CCqM"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c73fbdd9b53so360432a12.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651667; x=1774256467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq7C+kpTfb+cPdylM4tDhu6QhSoTjF8xsUF3kXYLF5o=;
        b=T8h3CCqM9ZtlGL4Anazpz7OgUJLGJlxeE0JwONKp6Bc9iVZEdGtj2FFbAydBk0pKKP
         j32htZTbTdkOiou5Ww6Q0jaKycEOUUA4rB9BlLt1bo53NY5ajaksdRDlgy49/Ougj7sT
         I7VulbS5QlcOTJxm6RHvevhCFzxXNsySUcGtUE0TLum2BfhmrcOfneOYsE8r13OzDn6n
         vtpe1RZnz22FkCnl5RT3QcWp8ME4s4mK6u6C5l8rko2t/hCbeC1ZXIAazfi3U1pojXd1
         P9HjVJQTgF03+z903B5iV8BfanxXTSJGV/8jcix+TKfW726nwjb/lTlgAQravbwmFK9f
         VFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651667; x=1774256467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vq7C+kpTfb+cPdylM4tDhu6QhSoTjF8xsUF3kXYLF5o=;
        b=kXpjKPq3yhe/KIid+WH7Hpl6CvFXLrvTv1h7D0RNy1iDfsoG5axWD7Bv3ynNkvxGDo
         DMfo61zacsg81Bhk6Fh7ppSqj9C/mgRR0iGsO31kxsIyEDATzQ/4OgkJZg5EvFiBERss
         OLARaP955MgtN58tHi7SkzgRMQCfx0ghs8ZnHG7QXIrzEiesDEWrb6YknWP4hXA0rLbJ
         o24H+s26oy+a6hsOJ7Fg9nBo47hRYPNXAWnVHMpHZeXk2sOK78zo6ZuaXvm4eXAd5tUj
         Prf2OYjTBN3hVwemDF7FijuJTRT0QBGIo9ZNW/V2RHiBfOEMalUe2DkLZgoW1CJSKJcx
         bloQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeS0nS9wqhK6FTu/5ro/hKwTPEAGFn6gRZkTfVl3nHN0PL/35+6cc9spUTCBUPX91MGe+Z0rgRV18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8XBadXhFV6+fHD7sDREROFYW3C3MRlmI72g+CLtru20zz9xs4
	izFJlhIpTroC95vOifOWf956tVg451+0UOWTDBg6zMnbzJ9qUqmfjLDb
X-Gm-Gg: ATEYQzzsKPC5NVYeGAhCmsu4v+RRB501v1Pgq31wGoGZIqdWfhK5DG8TyCUJOyBXZdB
	Y4adQLNYTurqbhtUrqQozQ8j3nqRY8DRaxK6Y53PTeti/GEljwlr+Ly0fSo23d82wogfPiUldbI
	hBaccNX+R67IZMy/zNS/sNVa+MhZInEznnS/++gFcIglE7Aklungs2LhwMqV8u6/PXF2RGD3WaJ
	QZg5f8RcSZrUe6lc8nwLsmdSAw6R9eINUB4WFlg9hXKJMyuxauS9JkqL3YKaWhiggN8u2I7AWFF
	nFArloLaknFB6xzMVJyEEWg40MROdnU3NtmTsASUx1e9ogKtaXzTZu1yP/3/wnce1xV6LQwem9G
	iMmQ/9s4p1FY5NhrGwlIoS+1PK0kn8hZ0CTSh3AeFIQoc5VDrRQnRt+DGFNPsx1xaw/tvEkkj5N
	cjeNVqQBafBsMhf32aa/KBoS3R
X-Received: by 2002:a17:902:d504:b0:2ae:4555:479e with SMTP id d9443c01a7336-2aeca9f08bcmr130840755ad.18.1773651666697;
        Mon, 16 Mar 2026 02:01:06 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:06 -0700 (PDT)
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
Subject: [PATCH v5 05/14] iio: magnetometer: fix various spelling mistakes
Date: Mon, 16 Mar 2026 14:30:13 +0530
Message-ID: <20260316090023.14691-6-i.shihao.999@gmail.com>
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

Fix spelling mistakes in comments.

- follwing -> following
- atleast -> at least
- occured -> occurred
- measurment -> measurement
- rougly -> roughly

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/magnetometer/ak8974.c        | 2 +-
 drivers/iio/magnetometer/ak8975.c        | 6 +++---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 68ece700c7ce..817b18257608 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -577,7 +577,7 @@ static int ak8974_measure_channel(struct ak8974 *ak8974, unsigned long address,
	/*
	 * This explicit cast to (s16) is necessary as the measurement
	 * is done in 2's complement with positive and negative values.
-	 * The follwing assignment to *val will then convert the signed
+	 * The following assignment to *val will then convert the signed
	 * s16 value to a signed int value.
	 */
	*val = (s16)le16_to_cpu(hw_values[address]);
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d30315ad85de..b648b0afa573 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -545,7 +545,7 @@ static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
		return ret;
	}
	data->cntl_cache = regval;
-	/* After mode change wait atleast 100us */
+	/* After mode change wait at least 100us */
	usleep_range(100, 500);

	return 0;
@@ -697,7 +697,7 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
	return read_status;
 }

-/* Returns 0 if the end of conversion interrupt occured or -ETIME otherwise */
+/* Returns 0 if the end of conversion interrupt occurred or -ETIME otherwise */
 static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 {
	int ret;
@@ -759,7 +759,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
	if (ret < 0)
		goto exit;

-	/* Read out ST2 for release lock on measurment data. */
+	/* Read out ST2 for release lock on measurement data. */
	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
	if (ret < 0) {
		dev_err(&client->dev, "Error in reading ST2\n");
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index d49e37edcbed..140c422773f6 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1223,7 +1223,7 @@ static int yas530_measure_offsets(struct yas5xx *yas5xx)
	 * as the values for [x, y1, y2]. The value is +/-31
	 * but the effect on the raw values is much larger.
	 * The effect of the offset is to bring the measure
-	 * rougly to the center.
+	 * roughly to the center.
	 */
	ox = 0;
	oy1 = 0;
--
2.53.0
