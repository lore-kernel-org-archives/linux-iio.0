Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111CE2DAFDD
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831680; cv=none; b=Ol8Ki0B9DKdVT6PCZkj8Y8cxaoEMzCMsdh7/EYdIEPoaCV7t0rsS8iN+eUcbF0+6iZvrmq1m64T9anTS4MiznXCdzT0Kc96WjAS0cM64b+fAtm/8sRdd+dM3mk25K/e0yu15l8Af9L+3Wyx1fc/93cdcGLmYB7FNOBM4eMFxVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831680; c=relaxed/simple;
	bh=5AXL3fJ8zHMD1fm5epFOB7PEXhYhl9tjyeqwyukrC4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXSiKIXAVwmFrdk2vBMGmoRBcAfH+if6Xll+WsLuY3uctsaVZcaYBtXANIZ4l7jYb3ws8fwpvktjs8VlGY0KSZaGPpp8x95bQThpBuxj3K+r7FqKbS74WmmCrfwwI9DyCQ98ddzCnHVxd39cErUqjdbkcLTbfaelkq5fG5Eht2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGAsbvTR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGAsbvTR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c648bc907ebso6065314a12.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 13:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831678; x=1773436478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkZG4b5nCG4xLj0JoI913fbQOS8uw78r9eiwk9OqnzM=;
        b=eGAsbvTRpzH5AT1VuAMGJF2XUorMKBEgwxWl76NWZnpDDPwNCoRSthJ0Ve8jzpFoBW
         W7L8+4a4xoMhy/Qzl3oTPUs1g8t8BABpFHP1tp+s5oNSm6W+s3C0Y53khdv/gRGjTIHM
         y6Hn19nKR1speani7v1PTP31Az50DyuHB44/BFgkxDuKrTxc+yC5c5IaSx6IDW524HSB
         ukbOPjPw6lfpVf39rl3R6hMGJDpjmxFZnkeTDT7dwteDF+yXmwj2HCWxBiQVBUXj71GK
         82kSX8HvdPt2XEHLQ3lbGafOT4s/efw2kUMSNCqvo7gtl4qWjOix/+IpPhzJ6hi+Z8uk
         dCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831678; x=1773436478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkZG4b5nCG4xLj0JoI913fbQOS8uw78r9eiwk9OqnzM=;
        b=kOau0IYbfS4S0UOvIUVkboYha+KBA0uO5KdkMFK1qTl/AtmoVJDuHs9RH8fVQ8UYjt
         kYZMt54CuCio0CbEjIWVOYufToWQouhS0TIuu/Fd9KpWhZ3DlqBNxrJC+qBBC7rSkWM1
         wxiK6QJyEa4RDQigH25lASs5oZCz7tIBtP5z+cH8y2wdR8RPznXCRdPnmZKsCVXZj+kF
         HemqV3r34SxiCTbgw9GrNFV3rB4STih2CRcHllxpqq+LjlAlfKWeHvWWxe/1CNQWGKGH
         Fu5SftjLrgyIy/0Xc+r0l1dgKTnCe4xqTh9XUai6qB0j/r0MqrCCP3nUvhRQGkJfBBLt
         s4qg==
X-Gm-Message-State: AOJu0Yy4WpWH55INlIbQxQaKQ/g00QQlOa/fSnpXL6od62a8iqBy59dc
	PUOBQvw7w7t6ClO12Dr22JpBMFmHaOXcMYoEhIuble8vgERtQB2csITZ
X-Gm-Gg: ATEYQzw7tQ37hMRt8eoyXN7f5d7LKDUGaM318VRIMxmwnkBzdxjCvX73xeRtrXq6drK
	U2SkWKurlq4zgmPNNvGE1wWTc3yLOeK1z7FQtcUrVfwhmfJzOZdYp+JOybMpdgCgXFzHaz3kOgr
	ErBqe4TmXt0Wj+L4OO4p8nrUl17VLTVPQE5AMIsorDz42HBMmwU2FxJbmuFdldBk4UUka8X5NIN
	v9TSkgZ+k/eNwycB1+AXr/IQO1+RSpl0VPySiSRgmifHxdMoiMgnYVVPCL4vrlnpMOrql/opIl+
	OnTIQDsMMW6KjCWARRS83SzPnO5HEEXiwy4MP3keUgtNhODkOi7gK649z536/sQ4Z1b4g/Miwkz
	zgSkU3SQ7R5lSJnsmFQT0zG9O4uC1+QLY0NLj4ma+V9VjEtApuKjBexuBekJ2WUrkH/yXm1tOrN
	YMDN1eC9UtoNLGOeI6z2OTct6OdbtQGXOVNkPw/SDxI6WmCXu2yGPsvC7fXAHuC05Ewwk2xCLNj
	UxqKtHJ5dn9iUN1SjpPhk4I
X-Received: by 2002:a05:6a21:400f:b0:34e:8864:793c with SMTP id adf61e73a8af0-39858fb61cfmr3373014637.8.1772831678449;
        Fri, 06 Mar 2026 13:14:38 -0800 (PST)
Received: from fedora ([103.215.156.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170c87sm2661331a12.18.2026.03.06.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:14:36 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v2 3/3] iio: accel: adxl372: convert to guard(mutex)
Date: Sat,  7 Mar 2026 02:41:52 +0530
Message-ID: <20260306211152.65109-4-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
References: <d587dd07-ce23-49f1-9a38-ea741e4ef14c@baylibre.com>
 <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/iio/accel/adxl372.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 28a8793a53b6..24a79f61900d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -336,17 +337,14 @@ static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev, unsigned
 	struct adxl372_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->threshold_m);
+	guard(mutex)(&st->threshold_m);
 	ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
 	if (ret < 0)
-		goto unlock;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
 				 ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
 
-unlock:
-	mutex_unlock(&st->threshold_m);
-
 	return ret;
 }
 
-- 
2.53.0

