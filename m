Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF842AFAA
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276096; cv=none; b=Awxmur4QcFafE1YrQiiE+zc+K2/JAAVXSCe2KHlQ9weDfJNYJ/8DhgVerEWY9rUjpIXZtAK8csn/t3XdUlWtSkAr8jPpjEd65BAv8tDuCcKyAeqM1wFYU5wrzTw93DSOHBwElMiaLpYZXj97F+/ZXiL68qkSYPGJ5wamyLNWBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276096; c=relaxed/simple;
	bh=haEcaONaRja1qUOHyi3OxXLJqfw+TC0USxhfuYRWozg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQ62VPCyRP97/IGYEdmawOcdMcQ+rHNOKEIaBHluLHg/o5FZMYZAg+7cEOIRbYVx+nQc/zhtEBhbZqAIe/g1DsPdE2y/UiEl55yafXkw9CdS57xDFFWBwuHtmsrZMcOsMwl87oYf45weaktgIXiyDqTKatAOYzcEOcHbwKlsbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSk507m4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSk507m4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d8fd3b729dso29017795ad.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788276094; x=1788880894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7XaLq54eX4gxpoy5NbzaGOOpUsCKXEm26+G5a1HE7Ws=;
        b=YSk507m4Ke8PfiPnB83iNy/yvrEpZoCbXRDeKDFBYyovcYQR5Spi9brVJxwx/Kgvr5
         d1RNHPHmkWi/ReFsFm2tafGpxFD0Vl57sFfVOk3deJMLF7gPn8784+s0SZTFQsGtyKIg
         1+xcu2mIrRg1HXlkcQQ9X+61TolFHaTEXOA21RXljUKRuVDopoq8c8agRDGVVX3cNoyq
         XtnwralrZ+ytP4T25dUsRlN4cJEdDBSsItQtDrYp8CvSCU5x0WaBq4uaIs30I/z1JsRF
         wF/Xu9/dhx20KOSF0fTAx9UF9wG0e5S5uYMswe8kKeg0gOONikECyk0xoXpmJYYyvUAR
         8ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276094; x=1788880894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7XaLq54eX4gxpoy5NbzaGOOpUsCKXEm26+G5a1HE7Ws=;
        b=dseFMIVOdvxRa01/hr3peD1XGk7iGbJ8PylRAKCbPEFVXja/rQscBZ2ly1ov1UrPqJ
         Lni7xdrFQknDeYYHtLmBX4BT+sHxs5RfnhwngJYZ1Q48bERS7g3UaEhGNSNDGnskFrSO
         Op2aeaxVy+iY92Td7fxan5lHKai6z4CRr3ns/c3UxOTmLX6BBEMdnFuTBG9FjwQmzh8B
         Ye+1IMzOSoZxobZgFYPPJLhZUdei3c6r/DykA596ftH4kv01J5LCdMOjnZctoqBNkF/r
         3DcVKSyFw9rySTPQYJT1GA0jK1XGl19Z+kX87+3u9pdgqqom8jn5WhK7YAQFAQg6eTzG
         daTg==
X-Forwarded-Encrypted: i=1; AKwUvByCwsRtsksBXSQfDoUnBOEG1j8BDi94lo7LfZGf3+BPSu53tQ87SobbjY6dgBn2zda/qraSqpw6jEc=@vger.kernel.org
X-Gm-Message-State: AFuF++mdtLCPQ7CR2vm8/bXF+S4uS3TYp9qlu+8odd4fkKX+4EBiPDy8
	LF6AH6EcaSqES3xAYzWpD1VbZVqmfKIjwG4U2LjOMKLTBqTe22+hID8=
X-Gm-Gg: AYBFou0iIU2UBgOeWk+gtU9Gwoq3FKRojpI/awOMBVPuweYpVqi4r2XUN3xmF7CSv+W
	TPgUSfFJps5tOrpNRPIiF1OPdn6rtD5Pj+FSGAE1yNBTDwdOYAoBNWQqgYejDbTKI48opc1xNu+
	ZMqFwkbcjTI+mjzbYHwRP4ovqxIVceKNJmME9e/4dEnX4iK9tyzaiBjsIVPmTktK5V2y+7WF3C8
	FJKImbwEVX+lIn+5257zZdJmsQ/TBjRR2rFxDkZl1pcFaqRPXR+6zN/iDHZbXT6n4N4+oi5hvUr
	/tlhiu2W35uEui0L254625O1DBsLQ21MGoXI+7czp56e2KpMwyiNZrECjhGsfcLNoC8CfOIAguh
	wmxCHFz8Zr4RuD4lUyZDPcYaSpcHVuXcdwVVrKNDE9j6kAn6B4y76CPaEotqvDE3Y0mY0CyflJg
	ywmonb4dI3ym0HOxmlLQaKdDXcBFpsADrDBwjmzqUThfqDW2c2GqQomfpXXRqgvRPpjZZqQ22ZX
	g==
X-Received: by 2002:a17:902:cf12:b0:2d3:7c58:b0e1 with SMTP id d9443c01a7336-2d94a2e3a54mr149081855ad.0.1788276094509;
        Tue, 01 Sep 2026 08:21:34 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6496:3266:16f9:fc9f:f197:159b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd3a8bfcsm695975ad.37.2026.09.01.08.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:21:33 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Song Qiang <songqiang1304521@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH] iio: proximity: vl53l0x-i2c: claim direct mode for raw reads
Date: Wed,  2 Sep 2026 00:21:26 +0900
Message-ID: <20260901152126.533902-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vl53l0x_read_raw() starts a single-shot ranging measurement and reads
back the result. Once the triggered buffer is enabled the sensor runs in
continuous mode and its data-ready interrupt is routed to the trigger,
so a concurrent in_distance_raw read disturbs the streaming setup and
never gets its completion, returning -ETIMEDOUT.

The original submission claimed direct mode here, but it was dropped
during review because the driver had no buffer support at the time [1].
Continuous (buffered) mode was later added without restoring the
claim [2], reintroducing the conflict.

Reject direct reads while buffered capture is active by claiming direct
mode around the measurement, as the vl53l1x sibling already does.

Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
Link: https://lore.kernel.org/linux-iio/20180911160300.GA9212@himanshu-Vostro-3559/ [1]
Link: https://lore.kernel.org/linux-iio/20240909101508.263085-3-abhashkumarjha123@gmail.com/ [2]
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Only compile-tested; I don't have VL53L0X hardware to exercise the race
yet. The change mirrors the existing vl53l1x sibling.

 drivers/iio/proximity/vl53l0x-i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 9fe14ceb8be7..173e69753df7 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -219,7 +219,10 @@ static int vl53l0x_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = vl53l0x_read_proximity(data, chan, val);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.53.0

