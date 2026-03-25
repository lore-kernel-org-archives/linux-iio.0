Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B63CA483
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438342; cv=none; b=T5jvpefS4MnzATJLMT6Lw8ZcBxkYG/+hYoWuBwcES8ZWnSjFDsQy3t1RiAT4NkQGycOz8F0VAIiOznOjlxUj2jNcIZGkP4tsXSU+G9NyzUbQaiJ7hyXcGM4EoB5lfiepqVIbH8FptWxTPq7xw4bCwD096KqimiPDUrBZvvqJctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438342; c=relaxed/simple;
	bh=9bHD5B8Z/ub079DT2qNTWRc1w7uwq67J5LW4kHpKAwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V82mMjnSHemoQbrkelOjFr82LBog6UOZK1K4x8Xe/0spu1NMWHwFGVfHqYsvZnqqXGbcCb+xSFXDwpoGcsCSAT1az40o0RFa55JVm4iG/lcBgbEjLx8bDne1RjTwsRjflVF3F1KFiFAP59Tv36Lg1Hd1kjh+EAxVsb5ESSa5jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buATWnnr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buATWnnr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so46486405e9.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774438339; x=1775043139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLb8SeapcYekp0ky/kzoMYcKAyEOhoSGzMw7aqCMNho=;
        b=buATWnnrUsdye2HS+LEooLSx+VDaKO7Ag0CgeFmDxJTSrB1OYWKA1V1pmDm7/EA5Hp
         u018xpdqgWa/93ZVQnfHWB4JukFMEw0pKfKD9Shx5FoPPCQyznBWB/pRVDdbiWnGqYcG
         ZGuyc2Z7HoQ7sKamDmRBHkFY3NetIRbC80Bc7Pu2049HsWJ+fQPzlCvOYYxzT2vHlHeT
         f8KRBjfqW5XHl1iZu/m01Z/OMEyw9hd34thpJXcJ4c4aZLXAt4xAHYh/EhVJg5AWRE0d
         lMcYZGQZmmpihI7pj1BI0CuvvCSeXP3XHozyLyPMovc4Tku8aJ7/JweE7nIy6DsYgn/B
         foVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774438339; x=1775043139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLb8SeapcYekp0ky/kzoMYcKAyEOhoSGzMw7aqCMNho=;
        b=KqwWQpWT5bG92o9fHBluh+hGI6XbGYHjpc4JABMSoViJbgWq+RCGGIWmXItZiEMy4z
         fe6ulS//vX3ThXvOLMYvePr8SSKe7zjZQk+czeCGtus9HdVDg5NiSWakbLLtswy5X/r9
         leTPoeUHz1ZfmtwGLYY16mFqGZOtSVNwgn/mO7uTp+AAgbAJHiUMi0uX2/Yt21/xiLbk
         2Fs5vHzENSdjXtofe2OChgMij3JfmQTdhKnDFj5UnKJnFgNdNQPSZx6o+Zltkxh4J5Jl
         fxJNMhSTXAT6871rdA/i/9Nq6zhk4bdnJrh8v9AGiua8I1k2dLKxWkKSD97fq/Tgg94U
         dPtg==
X-Gm-Message-State: AOJu0YyS161aSHwcaPXZF8LCnJhWxju9Rm6lfazWE4WUN05sfPWbwxTC
	9NtZPLn4VwJzaDCOcw2hCeK0C2HxRQPi4s9xf8CobNugQqR9MeP8TRwi
X-Gm-Gg: ATEYQzzRJxZGYFqcu8v8a7C80yWk/tjBxsdnF63ZJNhVTZADUyS3uzU0SIn4wFdB8xM
	1faOLHojP3VS3HvhK22rUJrgWhirzw52Lv5nxgrBBWFY/ZiKQWK1BjqjYek2OuA58gAO8qYJ2Ip
	S6O4YmG+qqTyvsnrM79s1O9zHhcv6FPlW+GShfxxNJq+ifTNxYp0G9MxP+yn03UsOtIwqeZ+oka
	gc64giSHLnm00hN/wL+5Xg/JxzKWmwxMOFMyjALxwUpq8vpdXz9Tr+OnY8ykux+1eY2a1kfqdKj
	qyr2v3JaVDWwRoOSOBWzAg34nihZj/t0UdR6RKa+IGh9cWujOJfSh7neYKPqJnzQQgaD1Bi/HYm
	KtD72kqnYsJXVXT/oYEdEKCT9yqMQMDaqo4EX6OIPuSn7a+a7mrmxk/U4Zj3+XCOKYKB8wHf2SR
	y5If0+kh+LpuwfDx/lkT5Ey7vbA8KoYeTjWHAKg1ca7PVDUHe6XhVu
X-Received: by 2002:a05:600c:a4f:b0:480:1e40:3d2 with SMTP id 5b1f17b1804b1-48716067246mr41383255e9.29.1774438338781;
        Wed, 25 Mar 2026 04:32:18 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm46510360f8f.18.2026.03.25.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:32:18 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH] iio: light: veml6070: fix veml6070_read() return value
Date: Wed, 25 Mar 2026 12:32:16 +0100
Message-ID: <20260325113216.170357-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veml6070_read() computes the sensor value in ret but
returns 0 instead of the actual result. This causes
veml6070_read_raw() to always report 0.

Return the computed value instead of 0.

Running make W=1 returns no errors. I was unable
to test the patch because I do not have the hardware.
Found by code inspection.

Fixes: bb18885ed823 ("iio: light: veml6070: add support for integration time")
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/veml6070.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 6d4483c85f30..74d7246e5225 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = (msb << 8) | lsb;
-
-	return 0;
+	return (msb << 8) | lsb;
 }
 
 static const struct iio_chan_spec veml6070_channels[] = {
-- 
2.53.0

