Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E13C342F
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920974; cv=none; b=uHEn51YIqFgzDDCIaTlfvCB1kMg9mLkNdvNY2wMQ2Wnb3QNL5YC9F0nTF7ZGW6iNkOYLDPValUM6icAppGwbCkADAHkuRVKoRiLH7cc6pWYlXtni8khXQZm8gXrkcF8A1OBsw73QgLA2ZN+fYmjcglcMyXf8HE1DXhbbyjJoXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920974; c=relaxed/simple;
	bh=oNBMUn+mMhAeOSyv30eOzuHIf/mFfGxVnT8dc9PcsxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBF64utgA5Kj4ccKi4jAqn0pZ9o82XfioKDe+A/pOMeO6FYX4YrsPUhdqubjhZFqHd/uQ9EQn4j+KJKn0mZdcU8PPuo3HkfUv6po84KhaES4Zs0yTwMWs21D7BHvtErE7KbrteEGUhAZgxsbwLngossQw2+SPXbAxKJ9+thyNoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/z6bEiY; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/z6bEiY"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304ddfcf72cso4163048eec.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920972; x=1781525772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsjk/VcaiZf29+wyYtGE2Gus6d3kidtLFkyTrmz/sv4=;
        b=k/z6bEiYZSL36+83CuGtHHepJb1I2/fjLCGqauR/7fBq1v/0h/b0Q8XljnnGcyxQcb
         Yl+hgNR8viOLrIlVPJsL7ah9CMtZEtTzwjmnACiPg8feIF4q/GFYbPxleFHd6ZoxukuJ
         f4s/UC83T+oLkpUdrQOqsyoaczOtn8rm1m/6fmplEiZfIL//PNpglEGNDEFFWjP8lxjJ
         tY0CRSmg6XFau7hCiOAfrWFDAf+M0a/qbRHu80X81+SCz5K2GyMOpWH7Q1vH5T74jwpI
         GW2FYMqPpftWwxAhZ3kotAodPjwNqYc+/8FwyP4UEAVOCBoe7AgOtzOzoMU2+NqfRQha
         w07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920972; x=1781525772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsjk/VcaiZf29+wyYtGE2Gus6d3kidtLFkyTrmz/sv4=;
        b=fnVQUd1tpPrwp/ocJkkHpc1OgAZjX/BnmnwyQnjx3SREsoD1zvCtTuB+QGQsd/Yi68
         YsZDt+Y4ypljsAnbpVy7tngNt6JXMD+9xG4NVTw3LuKkSQHdVSoULB2xu0A2Cl13TJCN
         ZDc2zTQa8QNIN3XxpQOPlvINvYFSohZS0ThAK9nF0iiuATUnQ4OcsqBNnBalgKGodEJf
         NcSBpeyq02cisndxU6LnaVlZkLMMxem3Rh85btSwsCdHe4l5yFdWROFnRPNJrvOvrLDt
         ont3F/LFREmF4WvGB5fvsKp3iIRQEFknXB0IKUk2zvCOIUfeASb0VunFl8yjeBYdUNZ4
         EFGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WeI4GUYMC5vD1fBO1c0Uz0lL0QkUjPoDe50N1FvDJtKpK9OFdcUJ66wQIQ6Vc7sgW0cwIJwXyqVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhi7Doz2FGaPN+UKBtQQTqHtvcH4gn4Ky04FmuDWJB6R3iS0NV
	+TELQUMSDNqZd3K9DpRtARm+ledK6TmHuMbMhvF67A1R6IW6SXKk+ICW
X-Gm-Gg: Acq92OGkOrj8HniYYH8vx/dcXIV618u13+T+0h827kCY7IczNNb1aoz76Xq32NXOxPo
	KKrRHVoU0vOYk83FHopT9H1gWq4HVJzYmYlNzWbNKNNrvUYP4qHakRxqkaSos4QxwXqCkl2fP+L
	FXNOCf5T6ofnAuCZjXNh6zyDWZIV+1z+ckYBrtiAqtogQk6AB+57GB7tw34s2+IdIy9VOWBrJX3
	6V0cAblGyFOaE0exAFl7p3j5ao81BDW+QWd6EXpC2ZIzl54enBD7TjRppfQU3TZmOSgIvWK0Uud
	TIKuLtcA3S1ZcoBgBlxlVLj83+Tdw8zZswo+YFCPIs3VWUpKUUv22pj5/R7maFjEzd0LZ1Zzru1
	9Hlihbb70BbcAv5CGkjGFefGV75c9ZtcDK3E0sRKfm+KyTKHy+mHy6nUdd4WCms4w3XFKHck74t
	mERwsKdnv8D/RK6Nnl71PgJXGDOd3MtjJkeH0A0H2XFlGk5xANI8ST7g52UwTCf3kVpQ==
X-Received: by 2002:a05:7300:320c:b0:304:e7c9:b528 with SMTP id 5a478bee46e88-3077b2f4881mr7337938eec.30.1780920972219;
        Mon, 08 Jun 2026 05:16:12 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f6381fsm8300010eec.0.2026.06.08.05.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:11 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jagathjog1996@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] iio: imu: bmi323: remove unnecessary cast in watermark limit
Date: Mon,  8 Jun 2026 12:15:58 +0000
Message-Id: <20260608121558.85429-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the explicit u32 cast in the watermark limit calculation.

The BMI323_FIFO_FULL_IN_FRAMES macro can be used directly with
min() without triggering type issues.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Drop the unnecessary cast instead of using min_t().
- Follow reviewer feedback from David Laight and Andy Shevchenko.

 drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index f3d499423399..72955a697a93 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1128,7 +1128,7 @@ static int bmi323_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
 
-	val = min(val, (u32)BMI323_FIFO_FULL_IN_FRAMES);
+	val = min(val, BMI323_FIFO_FULL_IN_FRAMES);
 
 	guard(mutex)(&data->mutex);
 	data->watermark = val;
-- 
2.34.1

