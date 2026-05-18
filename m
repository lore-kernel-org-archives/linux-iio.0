Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2F3E63A6
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097412; cv=none; b=RuFGs+DYoGuD8ogiI0kY9TvJ3DQqRg+kO26NBMVnxh0Lf/vverHSOp40Bal/abigjddeq94M3hwcjRYJLBfsxc7KNFwwO2N5RpzQmA1aSsZYiJVMm5WFUvel9UgqI6g00oLfa3TZJzmXLdifAyZ0EPkxAcih3LVwyXs6oP25Gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097412; c=relaxed/simple;
	bh=mCWaicM7yQ277dT759ekQHkrAGXRlx+Heqr7EifxGXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWXNW8rm5EE4ReVy9xOnXJRreA74kxLpn/QnmvxaJ1CI9HtmwTB/s0PG+6NV7Tyx1+xjyRqkAaatIlM+vhTyAxgg7OL8jb0CG6+uhP11M4LWi7jjCglGwxSNOmwUSemKcxSq01jz/CYGBUZdXzL3ThX+AE+CwE8oAh6HMrN1azE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzdeWvv3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzdeWvv3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48fde653997so2520975e9.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097408; x=1779702208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vze5/vjAlQ577aFItS65iPZiAe9QKZObGH0nwUk9xXQ=;
        b=bzdeWvv3CD9hIEi8bffWs156OgqWDX/6LNGYoJCVurdSDgre26BVRpS9X2hjiGtmpl
         b3ZkMBtgqy3Nt97v4bq688xqQru7OGLTdRqR/4++uzjqzAumG0UquavmHtczvKH4yajH
         3Y1NWnLH90ajl/fGNXkc0hPMMFc16SJ42fhG1FWtSgDuCuxqV/u4fD/JJxjOmS6HFkmm
         NKeEJ9MyD221E14f+q79XSbY8jh1o11L8hEcOFkk+hlTe2KMC5Md3uT9QOD4pGSaSOlF
         Ynw34HrZuqnCx0ZuBYbxtzjFLDVQeKEXGcfsSMp89ZDbPMFv1QfeiCOPx4w917sFoeBi
         jKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097408; x=1779702208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vze5/vjAlQ577aFItS65iPZiAe9QKZObGH0nwUk9xXQ=;
        b=bdaCCc2BfTgr5MkDUAidC/C0T50a2q5kkPoMK+4eNPVPjJlHLb1Im7Xc2uMkeZwT3P
         yH7rhaZEOMhasDhyUITuxjxNx/Al4C9Q0e1ua8jsYoRAa4wULEa7VK3lu2t8HYWxWjZN
         ccxyH1sMNRI+dh3nyyOaXeUSQlOu1yGe/PgzBrkblT0xlt78B4JTQAcjoVSgFOyFQvjQ
         MYytbrLRvb43/ZX/rSVcWuNX6JYLuVzfyn1PJlTJ0hchNy+kwl0nICXLlErOlBBDGN9P
         ypgy8xiqz2abSdAm1IKoxzmuuti/fMYZ6JYwtiQG1zkqqE3wxl8faAkCDCf8hRm6ZQLh
         PrYA==
X-Forwarded-Encrypted: i=1; AFNElJ+5aVeIfvoJQ9Q06AqmB6qngC/qucc12WPCwENKW7fOHYuh/2SQx4jjmKnuUR9Mj1ztFo1M8KVJYmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQKA+OKPh8a4wTvCaoNlbTaFSx9RTZ8/d7GECxE5o0vnY3yig
	1jpUdI/TXDIEBJBjhNb4sOWPQREfPj2h5fxDIYTDFtjOfBjsw5a/CSa3
X-Gm-Gg: Acq92OHdpuMyv/Jl/c6TlxWVjSCYMRMuDLH5rtGt1XBhgfR25vRX7PM8O8/HiODs/oD
	Cq3UPquEkyyQhUi9y6/dQuUXsTOxoJZcXqda2Xhd/VPU5m/axczGd7J/ART8ztTpR5Xd9ykJaW6
	jeVsSQJ5FwjrEpBIf0pioM8DnGh+6jOSr7Tbt6jTYE/dQMjg7M8j6WF8cAtO0UeK5qJu/D2qcwY
	K1bEDsgYkP9mugnPxr5BOpL+RJ4KN1gKw5yF0qnjfRR5MP8rbdT8WOJjp4Df83jU+/odW+zMLSu
	6Rbh4bzr2GoM6w9VdABhSZPlxfHp+JmYrpoLYPWhn6ua2aK5xPsLQ98JFtl1p3fZVn8okKU9fst
	kXddZz79zrtE++iVx4nUSXYnNm76QA14ClfSBYV2hmyIjD0H2eJdUUch6BgdEpIb96WpeibwnGI
	js7oLSMP0RY6xYOX46B8Oxv2cP5+Ue9v+XUMWsCNvqZR2Q
X-Received: by 2002:a05:600c:4513:b0:48a:5501:799a with SMTP id 5b1f17b1804b1-48fe664c27cmr106648685e9.5.1779097407982;
        Mon, 18 May 2026 02:43:27 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7e442sm75446435e9.33.2026.05.18.02.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:43:27 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	joshua.crofts1@gmail.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: light: tsl2591: return actual error from probe IRQ failure
Date: Mon, 18 May 2026 14:43:11 +0500
Message-Id: <20260518094311.2000-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260517181042.668-1-sozdayvek@gmail.com>
References: <20260517181042.668-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When devm_request_threaded_irq() fails, probe logs the error and
then returns -EINVAL, dropping the real error code and breaking the
deferred-probe flow for -EPROBE_DEFER.

Return ret directly; the IRQ subsystem already prints on failure.

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Drop dev_err_probe(); just return ret (Andy)
- Add Cc: stable@ as suggested by Joshua

v1: https://lore.kernel.org/all/20260517181042.668-1-sozdayvek@gmail.com/

 drivers/iio/light/tsl2591.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index c5557867e..c5ccd833d 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1137,10 +1137,8 @@ static int tsl2591_probe(struct i2c_client *client)
 						NULL, tsl2591_event_handler,
 						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 						"tsl2591_irq", indio_dev);
-		if (ret) {
-			dev_err_probe(&client->dev, ret, "IRQ request error\n");
-			return -EINVAL;
-		}
+		if (ret)
+			return ret;
 		indio_dev->info = &tsl2591_info;
 	} else {
 		indio_dev->info = &tsl2591_info_no_irq;
-- 
2.43.0

