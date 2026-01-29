Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3122032D
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686660; cv=none; b=D9lowtqcebRCol8rsGiDS21uY0q5MkGHpBGALjUXNysX1gvBtXoL5dMTgzE0Fmq+OMWPmtEBeGKoClVGtppr2nUVI2Z4IbKam1JaWmp35uR8fytE0PK5/8n6GcmVR69UMlwrk8lQP/QF4SGtuVEaBm+hu9hcok/pcYDyjeSysas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686660; c=relaxed/simple;
	bh=H0RIktYbGUMjTVnrqmNjNlztqcuwLyjIbW3gqBmYPoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGy1tJxRqnLLKpxDpSnG8xd/OcNiDHB/UXYjHsbHRlGczDjXF9eHyRowTdvfdWKHa8iz1qODSvm4eni31qqdFveiclfwN0gpTQcwp2H/fVpylwRAo8/CJB4MNfyklF2GpjjsxklG64VQ7us2Enhkm9FilQXK85zXaLD0/AyzvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5eNSDVh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5eNSDVh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so8232105e9.3
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 03:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769686658; x=1770291458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+by/fhtd1bwTkOLdgg+y/ln6LM6DBnVLDc+6MtevWo=;
        b=J5eNSDVhGGzZp18eY4qpNMYpYsks1XuMUtv/p3xYVYhX+J3Z3HEov+nA+mTE64BXxY
         YLC8XoU4XIq6cSm+pHZsJ34M8fh2oFPewK2GSr0B745To3Vbepu+cRJNpELiVnlwR3J2
         YZFRg2wt5l3UiqrFUucWcLFkLVaroPjhi8Oa7HUuKk/fbZ55qSQL6/5b9nKyMHNI7BlR
         rIRU0q2e5HV+q9adUi7J5ZppBj0R3re948qx2+MigzxK2jA/nKQb3dnGyMOJqdw1S7u/
         S6XwhLpeuQW+4vkJkjAhRg29dwWrZiL6s8jFIi+qVDnSxALFsbUTmEiTvqzW3VJPzsqG
         i89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769686658; x=1770291458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+by/fhtd1bwTkOLdgg+y/ln6LM6DBnVLDc+6MtevWo=;
        b=FC6qBijcOvxmQgBdKScXnJ790MPDhx444W44PTHmHJD6DVU/GFEiJDxflUONUxuvih
         beT4hQZb5rT8vYi7sou5nEyv3aCyH0ZGBmkISv++3hJcNYe7LnP57XVQAm/+rwznJoZ7
         sZwyTvhk8yAdNIQG1QferHyx3ReYPpU3pR52+gxVwEncUYauW4jLpkzDRQN9ztJ6CxGn
         e3yy8grrflI395pagzB/XZnDUKAG1XpTv+lwH2PaWjsWLvzLIe0lfl4pFeYs9zis70aa
         FgxLlp/gKxtaltP9jZatBgLG/vduC5XxMNR8f4UVJqv1Ks0IwLETmZYwsz0Qv6XPvHvI
         Fyhg==
X-Forwarded-Encrypted: i=1; AJvYcCXYgVt0n9dWtD+q4Zv+It7h8UvIuc0s4pD6wdUEGJtbKNwzNDDo99O8OX+uFLj5kD0OldILf+meaMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1an48tRzTBQTx8QHdkGBzxQXR/jD8xeM4fKoX/+9KdVG8Hp8U
	DNB70MVHeX+iFpYHVFT2/tdnZnlPAVG/4r0BOsKDoEYrUwAu3aFQXahg
X-Gm-Gg: AZuq6aINeatj+dk8McGTnaD9cGzRMWYAV+bp6puc2Bj3fDHSDmNYhVOk3nIo0QWEZkK
	pXQfiBbpxK6A/+v6xeXG71c0CrwVsiljA5xtwg2vNe3FQWD3JtGQIfj7EaZA4+KsDmdptKIKmU1
	irkuxxrHpVjw5SnCS1e99IqWCWBZPjc9o/54t/Pe9L2AaBwgBSLJxHLS6yuRkwj9QbPkozVOt8W
	KrFVLDWhJBVHWl+QHzuvVZZWhdEKl46QDNtQ2OYMTX681F0CMtiEGOITULGeoG3d5OdYK5Kzkqy
	pjeaERqlVJjVyr7vL9Q6tgjXT33qUhRia8tHK6dEnmBVaxzypz2fT2TQLKNElXT2Zqr6cSnRLJB
	0QgC5UWoGgyKaZb7mMeLNniKhZuuXiaflx9rMSZRfMC93YDUrDE4HkX1mhdDTk5OAT6mCAJjmTt
	ZZYxh2Txfbx3R10+Y=
X-Received: by 2002:a05:600c:3e85:b0:477:a54a:acba with SMTP id 5b1f17b1804b1-48069c557a6mr125687795e9.17.1769686657504;
        Thu, 29 Jan 2026 03:37:37 -0800 (PST)
Received: from arch-xeno ([109.228.249.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd79c7sm117776055e9.2.2026.01.29.03.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 03:37:36 -0800 (PST)
From: Menderes Sabaz <sabazmenderes@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Menderes Sabaz <sabazmenderes@gmail.com>
Subject: [PATCH] iio: dac: ad5360: converting to guard(mutex)
Date: Thu, 29 Jan 2026 14:37:16 +0300
Message-ID: <20260129113716.43479-1-sabazmenderes@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converting mutex_lock and mutex_unlock to guard(mutex)

Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>
---
 drivers/iio/dac/ad5360.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 8271849b1..5f51f0c12 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -206,14 +206,10 @@ static int ad5360_write_unlocked(struct iio_dev *indio_dev,
 static int ad5360_write(struct iio_dev *indio_dev, unsigned int cmd,
 	unsigned int addr, unsigned int val, unsigned int shift)
 {
-	int ret;
 	struct ad5360_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
-	ret = ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
 }
 
 static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
@@ -232,7 +228,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
 		},
 	};
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->data[0].d32 = cpu_to_be32(AD5360_CMD(AD5360_CMD_SPECIAL_FUNCTION) |
 		AD5360_ADDR(AD5360_REG_SF_READBACK) |
@@ -240,12 +236,10 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
 		AD5360_READBACK_ADDR(addr));
 
 	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
-	if (ret >= 0)
-		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
-
-	mutex_unlock(&st->lock);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return be32_to_cpu(st->data[1].d32) & 0xffff;
 }
 
 static ssize_t ad5360_read_dac_powerdown(struct device *dev,
@@ -262,19 +256,14 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->ctrl |= set;
 	st->ctrl &= ~clr;
 
-	ret = ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
-			AD5360_REG_SF_CTRL, st->ctrl, 0);
-
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
+				 AD5360_REG_SF_CTRL, st->ctrl, 0);
 }
 
 static ssize_t ad5360_write_dac_powerdown(struct device *dev,
-- 
2.52.0

