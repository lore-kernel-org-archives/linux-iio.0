Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D503446AF
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705201; cv=none; b=UubSO00hTM5GEiZKON4zdx4818OeLJh3o0hlFUo4fHItFmZUBYlxePj7V09lsdtwFYcFC3m/DPtC3PZer2KyO9wn2u4u8LsdZsaFfT37aklXFEnzGhitEzm2oNR/nVRfikbPkS9+N/KEpTg7TkrKT0R1GQPQA1LtQipP9tSYM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705201; c=relaxed/simple;
	bh=06Yu0cheza3u1SIYgfg53idlzfJF6Rcd80IYs6YTqvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a846yUsFuUrWDkHudI8wy1oEJ2zpg/nDZ1QXQcKRuKvhtZ+HITnwaLPcJaCw5yXgt6v7FRxbg+wYjY3larIFwahfTyzEzse8LtzAq76zzwxSdiPgClKmY17A1pZZxJQh4MAdisqZQEuONv044ioMOD/zKa6WbqlNRLuOGbYK5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3AEZpFE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3AEZpFE"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-435f177a8f7so440439f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769705197; x=1770309997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2q9Y+U2EjlfzP1ztQbm0j6KAL4MGa9Xk07DRm0b9uM=;
        b=e3AEZpFE5fZznZ3dsyGCHp3wGVjthHZ39C7eZWb6rgeJfV4ScnLB0Lt4FuI7+nYMGM
         kYswm73Z8KMBZVJTiVo6G1flhbGbsCFqk+Kg6lRKEz/y/VRTnKXdTXJ07z71k2fQBi7K
         uVNIUhyiYElpYUl4IsDkjA7ylg9vyVaMPQf/uUhpqZHyWcAU8IXcuzxd74q4fTOOSk1N
         9ofgP2MCgiePc6kGWNMSj5oS1Im+/e9TkaHmdniqgbrO2Lqsl3Bjv/Kzz+Zf5e9IphpJ
         p9vIk5aLrXkBc/d7qOz6g6rG3EOsQBevwz7ivfIlCZk0ceL+bXcx+wKFhQxWKiDqL7Iq
         k8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705197; x=1770309997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2q9Y+U2EjlfzP1ztQbm0j6KAL4MGa9Xk07DRm0b9uM=;
        b=uGAsdG9Bba8V3t7GMMZlLz0HeNP+Biezr9w/jmfKaKz/k6dYa1UC3zrgJZgKpvcFBc
         FGeIZbkRnZw9AhqxRAZ0IAj2s31uFVLUTSrxmiTlanDsKD89uj2IxN+iGw40g+DIQ1mG
         tMlCsVvDIHuP/o68gHrgbTStE0KFNcWsRJaESwOSnFy/esFzTCoAwF4DJK5uvN00JquK
         ih/nkauqh8Stw6Zh6WwY4uHe5DWuuWgdDNYp2YlipyIdEt+sLe9xrnew80ts2iunkDAZ
         E5pnGDrb6zLYVRU1o0u0YGyLO725w76ckC2gHsbZ2XR+F6ALRvPdro1H34JuuzFZ8uZe
         WRtg==
X-Gm-Message-State: AOJu0YzPwNgLWGMLqIK347QeyoxqJw4OqIQ16wMPkTEtDf/GPYz+FNYu
	oMlTzcjICQp+tULs13vZ1DrtShKHX00BB0rVGQ2lw26iLSxktzyvTZbhifcnNg==
X-Gm-Gg: AZuq6aIYyrooTwRjOshhSVmrZv+FkhMdjmmPSuXRTmepUiQsd6VvpOX30xGRbIiLzLA
	wEwXjyGTwNvd2Jx3Cb3M0I2bKAuGfoJzal5VptEyL/cE0HmJj+aYtZBh+0nDBJEay1sp/0HcF1W
	K4BbwVKC2mVOhl93CxXTXKajmd4zV5rVOohu8Y4Kbx16X12W3LmqfTJLoro6h4ij0kRCDcG6Nbs
	+Wuc0+I5ktiooJ5SI1DpsnATRnr3NR8eQzvL3kHgRc+mqp00cpTn1OaYqlzX+C3k5evOz9Dq+iN
	NLlT1XSQCDOrxvGXcKv4icAeKEhvcspGOut4MiGjsddiuNuxfkh+0D1E5ggW32zR0VFJfYhlt30
	ClSuIfUaV8TWIizRC+XeeSLcDYu7ODotqCp955t674o1Ndh7T3vVn1tWrjDsUmy4AA2oBvVSu4q
	iWT2gw4mhjVURpqI8=
X-Received: by 2002:a05:6000:144a:b0:432:c0b8:ee55 with SMTP id ffacd0b85a97d-435f3a0abafmr360737f8f.0.1769705197202;
        Thu, 29 Jan 2026 08:46:37 -0800 (PST)
Received: from arch-xeno ([109.228.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm14965225f8f.3.2026.01.29.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 08:46:36 -0800 (PST)
From: Menderes Sabaz <sabazmenderes@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	andy.shevchenko@gmail.com,
	sabazmenderes@gmail.com
Subject: [PATCH v4] iio: dac: ad5360: converting to guard(mutex)
Date: Thu, 29 Jan 2026 19:46:10 +0300
Message-ID: <20260129164610.81917-1-sabazmenderes@gmail.com>
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
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
Changes in v4:
 - Fixed alignment of ad5360_write_unlocked arguments to match open parenthesis
   (addressing feedback from David Lechner and Andy Shevchenko).
 - Added Reviewed-by tag from David Lechner.

Changes in v3:
 - Removed unnecessary local variables (from v2 feedback).
 - (Note: v3 had incorrect indentation and versioning confusion).

 drivers/iio/dac/ad5360.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 8271849b1..3503b81bc 100644
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
+				     AD5360_REG_SF_CTRL, st->ctrl, 0);
 }
 
 static ssize_t ad5360_write_dac_powerdown(struct device *dev,
-- 
2.52.0

