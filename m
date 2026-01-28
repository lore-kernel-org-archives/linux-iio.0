Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F391885A5
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614367; cv=none; b=IlxVHmLBtDAbH8a75NvThA1vwUyUApFXbgtjCVr8dIUgrVstYdcUcc3Yn2QFprdKCcqoCQuifGc+X2Kb1HZBThTFBg/TsqPBwRhGEN1uggWgJArCYG2OQIX49V3txBT3x/a66IzgMSUUVt/Y2jLHA0p9OCmpx5xKacAzyqloUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614367; c=relaxed/simple;
	bh=SVtgJJFSIleoIY5zLpJm71UgmH1d2X9QfabU7xLTluo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB9KPKsrp19V4NPQLlguU9faRueqP34bkS3Ohuaq2aoljaf1rfJkMWrdg6DwMKoswEM4BVwXxpppKhX7B/tpLj1DutoHSWeEjcWqZRFUPpn/6SIguVCw6A9UORBZ/OENrbP64XeLf7fXuNzDXrmFOHmumjKKCYKODbdGrU0TlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwoSPM/z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwoSPM/z"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so10195875e9.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769614365; x=1770219165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9yabFbYvIobYEXkR62fAO83+7QKWcDuFjTlnApPgf4=;
        b=AwoSPM/zpdHntGDOefUaGsq8cBOYM4kmuvKx72JPOr9fkZA95TIVc4FByxOg86ZD7V
         sLORvW+u7n0QQ4vrZ7Hb3km4P/i1ezoWrQYzKk8OkzRXDFp4HtM9ozWgGrYxZmDcRqnu
         Y6Z8PM1akXDGIPSdi6/eHn5p4o1TkmwCBx1x5gAnwdP+Keb/m+0bgibnSTg1JpGXD54o
         CUV36xVPVl+e12sLrsDEh52Gt3+YcG03XGOYzecdGgLhRiN3T1j/vllxrkC1rweXRp7D
         din7qcYJfsekL5fLvle5jEtYAFAVZDYnoalor1A+XgAazneZh1iqcm+CsHtGUCJttJCJ
         l5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614365; x=1770219165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9yabFbYvIobYEXkR62fAO83+7QKWcDuFjTlnApPgf4=;
        b=PDRDgQyOrz2Gvsvgy8g7B6eIgFMX+pnDk7oefPiwdjLakd9XMNORWH3mwDIo86mrqX
         DGzQLB7lFXmLaSiaWQjIfXE+Oh+bJ5jnLjteYf2FNn9fZtCbOI7JYQ2WvGBQZ5G8NxTa
         Vf7es1xM+j47Gq4tp+Q0EGtVSQe/1PK+88w52xqCVQCweJJOFUP77tH9w11vunqDyj6r
         viwoR825CvA2DggZ9W936KHrxUZ6d83EVfnUMYWzyuOtdXSzS1ew5ENIndg6gAmb84EZ
         c3t8YRp49YC0dO1KOEDM6YcyB5alI279M/tBz+Z0jD8i9of2JtX371Rsnfce7jjVRPrq
         j/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCViXsB4HOTWiwIeIpS5Kyd4TNotngi1cRSWTlP2vXFco805slJKu+9cFYrb2pZhu2JIMot/vCItqKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3ClgfWSUZIbpt9REuaTORuxByKu/pXl1fSyY6/1nVnt48D3o
	X3agi+eQd8EL6/wDLciO95YzjCrrrNW7GPrx45YLoe+OJsUmPgfCZ1Kh
X-Gm-Gg: AZuq6aKMy4zrTAdOnoWlfoT123oJEeSpzehMqaR55yLb2k/3UVRQC47i9uwv/smBou0
	LCs+yGkEHgtpKkl0eK+9XCceVi9SbN4EYnZEw4K4bv3xGWSHIo3VXrklk7o43FvW0ZIUQjZacYa
	ts50B5XBw2mcLrHVSS29bwGTRJMwyK411hW0+HCecRsu7jakK742sN5r0S3NH+3bvjZvbjkyBAm
	a+4OXCVijComlcb23U9huVAX5P2uDvc94eRbQ7u+He179zASi3CmjoVWTqJYlmjqCnVVSb/43VY
	PDcb4rbDPBzLgB8w+A0jvQthFVHZRNGNz2PrfWihwhyOqFYyyGZYOj8SGNnF8ZXfdxXlfmtvkRN
	6+/od+WMlGSEPu5LW9+6/uYDQMwoPSFUk1KQKvppwCjs8DJW224QuXDqSwd78LkmMoIgrIPuIfP
	OiTtolQ8nK/fnIGg==
X-Received: by 2002:a05:600c:3e18:b0:480:1c1c:47d6 with SMTP id 5b1f17b1804b1-48069e33b67mr61470195e9.6.1769614364717;
        Wed, 28 Jan 2026 07:32:44 -0800 (PST)
Received: from arch-xeno ([95.173.233.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37420sm149973195e9.9.2026.01.28.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:32:44 -0800 (PST)
From: Menderes Sabaz <sabazmenderes@gmail.com>
To: sabazmenderes@gmail.com
Cc: Michael.Hennerich@analog.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	nuno.sa@analog.com
Subject: [PATCH v2] iio: dac: ad5360: convert to guard(mutex)
Date: Wed, 28 Jan 2026 18:32:21 +0300
Message-ID: <20260128153221.327987-1-sabazmenderes@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128113751.258219-1-sabazmenderes@gmail.com>
References: <20260128113751.258219-1-sabazmenderes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converting mutex_lock and mutex_unlock to guard(mutex)
Simplify the locking logic by using guard(mutex).
This removes the need for explicit unlock calls in error paths and
simplifies the code by removing goto labels.

Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>
---
Changes in v2:
- Removed unnecessary local variables
 drivers/iio/dac/ad5360.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 8271849b1..15df5dd2a 100644
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
+	return ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
 			AD5360_REG_SF_CTRL, st->ctrl, 0);
-
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static ssize_t ad5360_write_dac_powerdown(struct device *dev,
-- 
2.52.0

