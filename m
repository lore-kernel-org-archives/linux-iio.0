Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0038367F31
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849875; cv=none; b=fIIBdqG0RHWZ2bLUFLbJt+CSdvTcJNDJXULmCqxTvRK43C2MwfI8Wf6+BKvW5tFjm6Bwl/eQsCsSuRSKNKNH1+i2ax1jhxgSYge7XfKRu7nzKOu/dp33iA3mRn2NN6XxsIF2V6K2dzop9JhXOUwCc1mIqMg9FZVssTbH3Yyemu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849875; c=relaxed/simple;
	bh=4YCGm1MCsTx+zXEka8+p+QC7YccuIi7gf2KZprcNmqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef3MJ/H8Qso+oDXgIueIuYtBurj2lQhFiiVvWjjXEGqn8Lu3wFOCElrCKd4pAUohHHGZppUrcoE6xFSuB3gzTCgE5kf86MQHt63RE/HRVe+A49BkZF2tjidxIf9/cmwIoYDWsMzuoZFF65aua+rk/MuzZk1GO8Z5HWiuf8GucmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdCAuwta; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdCAuwta"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so31645795e9.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849870; x=1776454670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOKF4DJH51QEnmkHqfnXF6rzMox5DJ6yp6W3wNBEhxE=;
        b=YdCAuwtaYDRslv9jv43J5FzKEUbB4C/SiBUODKyOfmtIGuIuxKoAqEpBLnvz+8uLtd
         m4H3SqPjNqDPFjFK/h3we72SbNukhmCP2vq8qZ8W4Jc0Y08cFxHApEkabWpwAq+Dehg0
         GI2nHmNd1gbZOfKEN7U8WaR8gVlTAPUqkL4kfEJG5GxYryjQEni2gY9/8mYwelvGxNq5
         +o3px6bHzchTcBg2pmjpecw7IjJFTbcVkVglr/yAq7mJjzPJzgDSwmemxJzAyhGq8h/T
         gjFPiVIiZB6UeZwUJbqvLqsjR26/sxPQdof9C1riQcvhn52Ux7rqZAKND77Ep1S+0cBW
         UjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849870; x=1776454670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOKF4DJH51QEnmkHqfnXF6rzMox5DJ6yp6W3wNBEhxE=;
        b=gBRNwQKbYKsXqrAvgO7lVKB1d1aza6Exez1reY5/k84AGOgAOMjg1bBdKPMNp5Jdns
         Xd/u75NS9/xL+6m6N9VUHuY5IxZbvbl4iR7fl7+wsDzeruNyGL7amZif8YRSA/6TSMyP
         Sb+XfHFzQ6vR3KJjHK4DqYTdZ1PubWskMCEa8jko0fioCvyVZ3jX9f9MY+0kSS5re2jM
         XeDNc+ekFlxCjDFVzzyVbvyn6P7rpI4kf59xZPoRhEAcr/+/2qDHGwqsOb3vFkPOYpQM
         NVqlzsyf0JBBdH4Muafk/0Li4fYDOQf/VMeNwLMVyKEtQ7MdvViQ9ikuZq15hnkHfAiJ
         UP0g==
X-Forwarded-Encrypted: i=1; AJvYcCVvjsNbbwlyD44HKwq8pm/jjqu3aQ5pZD0Y/7cHC6ObYm3auFJSGVrYlI1b6St3xkA8FjLNTMdrCrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyds7zpvYCzE33NnT253pT+nnkO3FmxAdi/IgbevKdBz+E2qgz2
	XHSJp9oKMT1eOYnFPtxe6EgyNviXuhnuNdj2rpmoGEPIfOtS/D1ytpQK
X-Gm-Gg: AeBDiesB0pt0F4R9t193OO9++BBI+n4NBMR7DRfvdkQldYx3bxJk8tP6P1KdD/C4zUO
	cLe/ckDpaIIXv6XTBcVg3idlsZVueG7oBNa65QxvubEiYpg/7+AYRIQr+TUICu0hGO8rTCKOrYg
	UmhOk+2IVjJoEMUK8waEKg/t/pDSVg8lvakWpP7+OmiX12BN6y7JsmuoW2CMn6YQPsPwCob/9Oe
	Fzd7yS3V9FMFnE4NQxaxOAOaOQ26X611uKcIApwsO4hDXyHSBhBIV5lfib9Ive5TZoHtjVGIHwj
	GJL5UgcWne/iW8d8nz2ecM27B7xRucxfye8IIpIqvJ4anPtQYfWraBV9TmBdzWOR9TPQwkDHBIs
	uRpNp5xVCWp/q87Nr6vjtsmPJDunK3x2oAIF9Hj3mDUPmlhlbiKlNUqaVIy4JbtmnoagOn5V3SU
	FFIMD5+1YGMSTWIIkiJKLj08FYg1UPXPRg6DhXC4QuCIshkdwEMMyUOYWv3kDbTl1JddIQuV8Lz
	2BQp9VHYTA+
X-Received: by 2002:a05:6000:11c2:b0:43d:68dc:9ca6 with SMTP id ffacd0b85a97d-43d68dc9d13mr1638776f8f.18.1775849870387;
        Fri, 10 Apr 2026 12:37:50 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm9690425f8f.25.2026.04.10.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:37:49 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 6/7] iio: dac: ltc2664: Use devm_mutex_init()
Date: Fri, 10 Apr 2026 20:37:36 +0100
Message-ID: <20260410193737.35905-7-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410193737.35905-1-devnexen@gmail.com>
References: <20260410193737.35905-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() which is helpful with CONFIG_DEBUG_MUTEXES.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/dac/ltc2664.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
index 67f14046cf77..616806615d3d 100644
--- a/drivers/iio/dac/ltc2664.c
+++ b/drivers/iio/dac/ltc2664.c
@@ -675,7 +675,9 @@ static int ltc2664_probe(struct spi_device *spi)
 
 	st->chip_info = chip_info;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
 
 	st->regmap = devm_regmap_init_spi(spi, &ltc2664_regmap_config);
 	if (IS_ERR(st->regmap))
-- 
2.53.0

