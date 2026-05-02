Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923418A6CF
	for <linux-iio@vger.kernel.org>; Sat,  2 May 2026 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777688304; cv=none; b=MKk50egSShorwIyR0fp114H6BAuAwuDox0YquLJSgMgoMH4ticwfS5tCp3Po+Bn5yl4EU8Fc46hqANIWFU87fznHMrsIfK4con1LFPP0f7NpUA8oh3mvMhJgeZh1gtu/9FdJpi5HgOr5a74V9HQ5H0ag/jJ4MsxbL6oCLK7HMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777688304; c=relaxed/simple;
	bh=3/+Pr4j5iSVX/Vmbx8yW6ovs9S4TRVc2mRVxpfIkpCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNzRBWb5B8/nSn+JMGjQcFELPldCN6D66HqMXz9/KYzHCsdDqJmaABKt+hXleebpOY25gGzc+Ns02LI0NEifx4p92ILuK4S2Fy3edbZxi92KdJXCQqyT44P8BK7yr+E8YExK9Vs2xxfvrHy5VxR4sCuzEJ6nobcYY02DBCJQMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4V3mjXC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4V3mjXC"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so1745799a91.2
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 19:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777688302; x=1778293102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bus8UEoB8rKoM7Ii6ZhV3wSXwGSHXrSXqNMvxh7aHw=;
        b=h4V3mjXCBK0UxixoiSa9bjB8LMhLaqnqzcgYnLkwY8reP1SGS+J+H6lxNnTY8P4W5D
         o53DfBCiafBoRjulxUy1kPTCG2ex0Pz2n8IfHLC4LPSP3D4cIEFqbE2SKiPANRGTzhKk
         PJyX5VqYJXFZautO+rl/Sc/6JOz3gyfcYj29P8sWMHwlJk+3X9x1wZ2j30CMtly3+Tcx
         qposqG7B50qQf7dijluUVdVNJJ+RkXJuWNkcPwlgryb5jMYMD6pmOEY7ZF8gTjFrviG9
         y0m/CpyFibHsd/onLwSUzo1idNiOITPBlECPcV5FKBe8JY1qSVu4h0yqfTBoMW+fsM9/
         tEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777688302; x=1778293102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bus8UEoB8rKoM7Ii6ZhV3wSXwGSHXrSXqNMvxh7aHw=;
        b=rb91+RTYCP5DoHXHPZZDRQ/BSt74sW8bQYU8OPUm4iR7mJMLw1gXyl0RwvrdttEukV
         onQJbRvihAI8g1Wk2NBNwSOTj55TElH1Z3cXQyCA3ONH2i5TMMOarZaWQxcIfARpwQ9o
         hnUqWAt3S4bZdzNEJ0htgIBCdAocjQN51yAFGp91+K+odkvR6wa8XASKqTzjgQDtE4AR
         xePGCa+WLC8Bx6yaoFzIuQuRsYu1Op/a6ECHV6Z7VucMWzrwQrLCK3IaVGHKVQMVZhbE
         kZn5VUWv2YQWHAXQnMxr7u25yzRzvZ1gPpPKD4aRjoBsxPk0eS2yOPnC/IdaPPtdI0Ld
         Evwg==
X-Gm-Message-State: AOJu0Yw4aTX+x8twH99KjQQT+wrvtwWauEST7/KE7Ixyj09k40a+H7Dy
	CopxLR7W8byq6B4EffsObQhJPXqKWJu7D92whgXyTdfZtBjkJE+8gnaKJSgQSj3Y0xMXxw==
X-Gm-Gg: AeBDietT00fDBOca0OsOyCfO4dgA19SEKZhKaV3/ZxmqnvSuCCNluaWxt8/wV+Q3S06
	csG+7ztf+NkgkQYLimc3ImTVYYu2yu1JLGXg79baa+CaBebem1mHaTXJ5n6ty57e90RmYUQTBZ4
	YtQvprpDwSfQCW1HeNuftIm/8LuEsjCYaiex+C5cyf/wxMVQSal3V7/e2w6O4ld5Kyj50PZUdvN
	MoFdf+/xVj6UDmBGQyGnT6pGKGULkSjSA+HliLGcYTZ7H73UsfxUuZYsQ+O03lVo3KNhBAymh0b
	jqeaZTn1lwfrkMpgcqiBZx2Lj6W+RwG7NQitmLM2KLoxGRRpnJK86wxyUa0vKZ9Ndf8Ug/zvyd8
	hsnY3j/UftUJPTqXXzXfRNecjtAV1ucb1tKXhQYtYL3BHDN6xAbDPFizfKfCkbmhyfXZ4GcFtfS
	H9MOuoFvRSpYWwV6g86c1+eLnd4QRijIPppyE14no=
X-Received: by 2002:a17:903:4b47:b0:2b7:895f:407b with SMTP id d9443c01a7336-2b9f25e3063mr14076565ad.21.1777688302096;
        Fri, 01 May 2026 19:18:22 -0700 (PDT)
Received: from scootaloo.modem ([101.179.112.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae110acsm31770245ad.42.2026.05.01.19.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 19:18:21 -0700 (PDT)
From: Angus Gardner <angusg778@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Subject: [PATCH] staging: iio: ad9834: fix probe error handling and comment typo
Date: Sat,  2 May 2026 12:18:15 +1000
Message-ID: <20260502021815.3953423-1-angusg778@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_err_probe() for the master clock error path instead of open-coding
dev_err() + PTR_ERR(), consistent with the avdd regulator error path above
it and with the equivalent driver ad9832.c.

Simplify the -ENOMEM return after devm_iio_device_alloc() to a direct
return rather than bouncing through a local variable.

Fix a copy-paste typo in two comments that referred to 'AD9843' instead
of the correct chip name 'AD9834'.

Signed-off-by: Angus Gardner <angusg778@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index bdb2580e29bf..5968aca74ecf 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -164,7 +164,7 @@ static ssize_t ad9834_write(struct device *dev,
 		break;
 	case AD9834_OPBITEN:
 		if (st->control & AD9834_MODE) {
-			ret = -EINVAL;  /* AD9843 reserved mode */
+			ret = -EINVAL;  /* AD9834 reserved mode */
 			break;
 		}
 
@@ -239,7 +239,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 				st->control &= ~AD9834_OPBITEN;
 				st->control |= AD9834_MODE;
 			} else if (st->control & AD9834_OPBITEN) {
-				ret = -EINVAL;	/* AD9843 reserved mode */
+				ret = -EINVAL;	/* AD9834 reserved mode */
 			} else {
 				st->control |= AD9834_MODE;
 			}
@@ -389,17 +389,14 @@ static int ad9834_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, ret, "Failed to enable specified AVDD supply\n");
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev) {
-		ret = -ENOMEM;
-		return ret;
-	}
+	if (!indio_dev)
+		return -ENOMEM;
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->mclk = devm_clk_get_enabled(&spi->dev, NULL);
-	if (IS_ERR(st->mclk)) {
-		dev_err(&spi->dev, "Failed to enable master clock\n");
-		return PTR_ERR(st->mclk);
-	}
+	if (IS_ERR(st->mclk))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->mclk),
+				     "Failed to enable master clock\n");
 
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
-- 
2.51.0

