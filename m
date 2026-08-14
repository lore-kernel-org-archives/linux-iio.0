Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7764483A3
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702751; cv=none; b=OkYyGwzc/U+v6nIUuXk1rnSZpF7+sySABOTYfGRH+UR234tLEHMIM0am+nKbgmwQLqLZnZFLDajm0PLuFySBBu1v1ZqRlMTgd7TjLMJiPyt59DHlZjOM1tlcU23HM/TPCoOc3pAV9lIJi5R7r7foqye7Im0qIhMW/LqzKvnZY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702751; c=relaxed/simple;
	bh=sjRxSOQ4VFvx+8lAtTY/KAcWMBg150hKkv/kJBdwaY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvi8Cx6SWMWJ5aTHDq8Jb1bGizU++G6N+8AApaPAbFCypyTmfJ/yNglWtw8uHFQ93lH8YLIuxqp4gHfHXA9i85u4n4JDwxEK8LoBU5F/ZmEbZrDGO/Nncnz4hZvGs9pMLcgPVhL5yz1qU6+qeNTXWb/fWMZV4Z21vM7HL+PBSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEulqq7j; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEulqq7j"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e58034d05so668623a91.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786702738; x=1787307538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00KFuqOaLqNGyqP39XavbZiyVtoK/fjrOzIbJr0n9VM=;
        b=LEulqq7jM4tVvlTE9gjIZJWB2TZuKQVRcOVvsXMe6QumZ7hBQRxewzFOL9f+fCqnBF
         vydLHU3h/eRvNOy8potQ7juhwNLxH4I1jHp/ddnVh7Ds02plOc8ObgowRapXr9UZ6CkV
         rchRsyMrMSHkVFnN6wjdf46q0G2kfkdeP/78z1SWrbViQdvU0vnJQSTV9C/eJo2dlZag
         bM1f2jxiGtDWqhB4x72HiAPYdajgfpZ7LpVF3BzcdRzAky4EkkzIiB20AhvUczf4Q45G
         ddZcFunmU/E8If3NJYgYchmDZmsp4W+CW6uC3ZjM6uRdAHAsHsADhNcwqTDtqrr8Rxmj
         Jr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702738; x=1787307538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00KFuqOaLqNGyqP39XavbZiyVtoK/fjrOzIbJr0n9VM=;
        b=sbtxSY1URpF47QXLufgf/pAlcN/d+ftf6F/tQ2vsZqIVxgDHX5cGg6AkE/xRdrxKZF
         Ucvr5nMIkSdldilCaYQOdxPg0a0iCih96mu88HFVoCMLFhgwJo0My1Pg7Y40poBWQRag
         rPE10W5Dl0AWKqnxWoCu0pfqSVylAooOUAlHHvA7M3fou/1cxaenzUfJF5CDEjbejTKH
         iGx1z/7hYmrdtjcoGLqaxuMi1HcuTJF7Rus8WK/xR0B89TOmSy1BhOqHgg/rzQiik/Uu
         aV6a3zX47yuOp5mEAgrrIwxAvgHZrX6RlFKdeUwF3/BBQbAaXbqiWK8IyoStXrYGF1hN
         5BVg==
X-Forwarded-Encrypted: i=1; AHgh+RqapvCZ33KFNu+jIli0I57B1zC4Ug2SS0yUhA71NQcfP47/0+EkGsk4TxZ3xvBrfFXcrmxZQ23CpF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyldotT90U+FIfqn+g4ARz3UpjZQPBV10n52EYfmLdzgj6ygnKA
	Z4wZKbP5Y8ZnaimYvgS8/pIT/M0DyiTykMLvfKOrTc4eem3fTn01PnD8
X-Gm-Gg: AR+sD10WrfzHZyMNofus8rsyWqVQQJP7An8qw3qQFPw0UAv2JD7FVZeuSlz59Aa877K
	uA/yjHps4GongHS6pTw/62kaKG6yPQc68t1GofAmFZjdEvO64narIzMGOCZgrjGPHA6jAuHyMhy
	SRQJ25x9ngaJFvfFY8SCk5AIJ9yviBQFydL9zt+Hm5AyEwLmJSn2l2NgUiBvLrEqE8GGjmBySGO
	3QOJhZgzKaSlm95RX9jE4kdB19Dg1x9tiY58tMCtd+qahK/0HcRPMNBD+AaaxRnq1wnV5q6PqID
	TG/o2NyxYF/aRDdTIcf0QdDV5AQRB1+ADjLPrvA5BkqMkQXtQWoBZjIwMQtBCCKECcwO3DtA95X
	vYSTYkgQN31nDtHYwYpmZkuB/OSv7S1UV6p4g43Amv7sVAWIm/12k8ANsjptU1FNAWc0yVjFxOj
	urEuDxQw7wm57H8G3fjVItktpzaF5bHmocOszVOdrMVq8va/Fyf6oeKoGI1zIAspPX9mrc0+1lm
	O2195ps
X-Received: by 2002:a17:90b:48c9:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-3933b6ea768mr5561433a91.2.1786702737700;
        Fri, 14 Aug 2026 03:18:57 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:124c:2e49:6997:3d3f:909e:c279])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm2074218a91.0.2026.08.14.03.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:18:57 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	yashsuthar983@gmail.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: accel: bmc150: use aligned scan buffer for both trigger and fifo
Date: Fri, 14 Aug 2026 15:48:42 +0530
Message-ID: <20260814101845.301769-2-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814101845.301769-1-yashsuthar983@gmail.com>
References: <20260814101845.301769-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop buffer as duplicate and s16 is not correct we needed __le16 as little
endian, keep scan at the end of the bmc150_accel_data struct with
IIO_DMA_MINALIGN, and use it for both paths.

Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 10 ++++------
 drivers/iio/accel/bmc150-accel.h      | 14 +++++---------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index dc8a6285cf3d..596ff8267ead 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1191,14 +1191,12 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
-			       data->buffer, AXIS_MAX * 2);
+			       data->scan.channels, AXIS_MAX * 2);
+	if (!ret)
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+						   pf->timestamp);
 	mutex_unlock(&data->mutex);
-	if (ret < 0)
-		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   pf->timestamp);
-err_read:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index e8f26198359f..9deff256aed5 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -64,15 +64,6 @@ struct bmc150_accel_data {
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;
 	u8 fifo_mode, watermark;
-	s16 buffer[8];
-	/*
-	 * Ensure there is sufficient space and correct alignment for
-	 * the timestamp if enabled
-	 */
-	struct {
-		__le16 channels[3];
-		aligned_s64 ts;
-	} scan;
 	u8 bw_bits;
 	u32 slope_dur;
 	u32 slope_thres;
@@ -85,6 +76,11 @@ struct bmc150_accel_data {
 	void (*resume_callback)(struct device *dev);
 	struct delayed_work resume_work;
 	struct iio_mount_matrix orientation;
+	/* Ensure correct alignment of timestamp and DMA safety */
+	struct {
+		__le16 channels[3];
+		aligned_s64 ts;
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-- 
2.43.0

