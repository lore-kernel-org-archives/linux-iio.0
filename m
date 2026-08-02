Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF54184
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697635; cv=none; b=sQxM3LRq21JA+cnKaWQa9EQ/mBuX/V2A++YGIrbfui5VP9sTh1zYjQzPEnbUOV2ZGV9gzvuh/gQWIael+4u2aGyXegtfUum3CcZcnNixF6b85mdMOCYSu4DdZn0HaMsqrpETVgpjcU9XvTbX7QZpwMEVRj1KUiyj7Tl18mAdwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697635; c=relaxed/simple;
	bh=qBxSFoCzQaqnh+On9GpKXj78dp0yTwBTfmfH4W/cnM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVWmvZNjJnX2XgxzhUukn38TMEqXkcJXrYmxAiuKZFGEFkBKSt+xBS0I6c1w6z/V+9fAnrIDhXpNnyaXFefrjSz3JWAzYUb+OKgc5WgaBd6PEFx3OHe05OJZycYtmiigbzvwjDi/Bzeah4CIjwRe68CrUE5TDEV4GXrbeRZT4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSRXLVgy; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSRXLVgy"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1432413a12.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785697633; x=1786302433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCRPNpaghBi1odlqwrDxT5domUb3WMfvy7ws3EyQGHE=;
        b=DSRXLVgyYmooOir9KKr8ndTRH4M70NDF42u7YiITjkDPKKIe242AW8+Xn9AKZi7WZU
         1yA+NJBsWEEKckqIr+ge+CN80irHl8z9y1OSEvtQ8M4kliOSlhhPWrKxQOKHanFGhckV
         lBIexM5xaHWBLQRKzNM/MAX2elomwNwCTvajRujKpVxxW2GhmSdgTiM3O4VHNX+Ot5v5
         5AUTflMec7k1f1+fEuyn9P71hVOK+NK5Nepjkm04PTTF5WCH9lGJ2AYBgmqpXduifhF2
         nkfo6HuDESI1OPpVPE+OpbLPT5U185uM7gtIP+DELmW2roS22U6CUC5rXXbn3hQYCKGt
         6nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785697633; x=1786302433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCRPNpaghBi1odlqwrDxT5domUb3WMfvy7ws3EyQGHE=;
        b=Hwg0EfhsXKVqi7kqHg3LyqUbpLVxH1TIOLfFmPThVTCq921ZisdSUoeeOviQAyPlxv
         wh8D5hxeLFyCQhtVVd0iOkSCm+lowA2VXScdck73vlp9yVEhJqajD4FajOhE3r0FHsS4
         wyN+2lG6jQDjMR1HrGctx4eAcUNuQ+19S4tkmTJhYr3yHmYHyQJ7W56261tgFCENbTp3
         a5NhB0OQSirU28HgW00wUEkkl8IWeigkQB4Z2Rg/bdL3aGtxicuXrkjx0QPGiRcZklfu
         OWgafkc5HyAR77YyAoP9mJ9KoROjKynrqHx09TGNeAYrzgaIMf0ta0U/t8ieigeoebEc
         qMZg==
X-Forwarded-Encrypted: i=1; AHgh+RqdnFsJg2guGsgFxF7n6eCr8wThuJe52tAK2RPC93JoikVqLLj/EqpWMCxsKnA8tCoOUMWqP4S3H3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbo+1+wd5t46MLuFI3tlL3/lPAo/31KAK4Mo+jKpCebdsQlXF
	S7drhWdgsWM7JbO+hjgpV9BNhvTD/DS3NDmPjU+yBJ4VQ+o5Zs/uZsQw
X-Gm-Gg: AR+sD10JMa6ORZMxmacjof0b9j1SaLkS1IgfWT0BSjir6+YiLBmkTOsDkC5p6rJ50Ez
	YETtde+7r4K1n1ZXgTC9tG7gUv5vvfT+F2z4brImxlX1WpbAw/5OpH2ZyLVqd4gEdQroAh2eaRn
	pNToc+EDZ9H+oilNGVEXS1WkLr2gIXhzThSlCzl0hla5YukoxCbQXy0QPWCUs/odXE3WTNgo8NN
	HCt+IR2yFsC2o5TLCHarqr5sfsQdeCfM6Ci8CiunR51GbxhOY9eSB4tx3xrWq6chXmsh+hAQybk
	NmR5PzKc9nYfTFKvSuG3x87nrckpZU9RbmhqWvG32SEcGRp9jE3AiqL28Ed1xag8ngQoI+shEct
	ME1csAPK0OYi6Nu/FH1/IgwKYaGiHYQmRt6nYpdmOHAh4nxoRkRWXwwvQiyR/DRpE1VTHSWQuzH
	Opm2aqsLVynK9KIsFNAVI+dedglEC8/9ZcLL7YAWX3t/OlRboXNfJCxcfwO32jLbqgr/tBJvoOy
	bcahhLxz6LQAJy8eAf3u7/gW7CJ/YZsAcufz9w=
X-Received: by 2002:a05:6a21:700a:b0:3b3:241f:66c6 with SMTP id adf61e73a8af0-3c92a830f9bmr7094838637.26.1785697633053;
        Sun, 02 Aug 2026 12:07:13 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([36.255.90.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm23531153c88.2.2026.08.02.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 12:07:11 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	subhajit.ghosh@tweaklogic.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH v2] iio: light: apds9306: fix PM reference leak in apds9306_read_data()
Date: Sun,  2 Aug 2026 19:07:01 +0000
Message-Id: <20260802190701.10685-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apds9306_read_data() calls pm_runtime_resume_and_get() but several
error paths return directly without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference and preventing the device from
autosuspending.

Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR() to
automatically handle runtime PM reference release on all return paths.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
Changes in v2:
 - Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR()
   instead of goto pattern as suggested by Jonathan Cameron

 drivers/iio/light/apds9306.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 5ca4c87524fe..d582bda4d847 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -469,9 +469,9 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 	int status = 0;
 	u8 buff[3];
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret)
-		return ret;
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return PM_RUNTIME_ACQUIRE_ERR(&pm);
 
 	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
 	if (ret)
@@ -535,8 +535,6 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	*val = get_unaligned_le24(&buff);
 
-	pm_runtime_put_autosuspend(data->dev);
-
 	return 0;
 }
 
-- 
2.34.1

