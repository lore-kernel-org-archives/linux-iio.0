Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2623B63F
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600288; cv=none; b=jWSwHy1o79F+I8Lb70vNPOJ1W0DMhvTfgnbroyjHpVdenA2AxndRtyph8QwfdV3KMjr3sGTdVAO2DSVzwGbYVttchmtT7S2Wp3V31K0zuGVzd4SUXMFPChAgDGbt34dvS+uqoGKXzBeufxEZsLJ4+wQqOyR/WgG/egTQYv21TiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600288; c=relaxed/simple;
	bh=wb5nMwOMLRVQgZtlTwQEUbr1CV9yVqh7TOE6TVDhGd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJaOUlFne0BEgPLy7uxpnkTZebHnHReR71951DHqNQ50IX92rA01ns1Rxbt7Yf3OVwPrt05dpfdNRk6KXy8KHhi8RXJpoCgNxfyS5tTTNSCXdqOOXKLlkfZ2Q7yDyCuHklCC07k7saLIatImimzfjgGfrFMV4BwP09/tFanZOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uwwijz/8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uwwijz/8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so5698205e9.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769600285; x=1770205085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMvEySfKqN40aH1Q+vuOu50FEoPH5vpnn1o50b2JyG4=;
        b=Uwwijz/8TTns1Qaz02g/i6T3d7wK407GrXM6YsZcS1nGd9VKtYZur2BuTjiHOiPb/r
         bWDA5a0i6uSVtQ/BozUBZC9cgKhVzQEuPODkysEDd9ZKyMRWYZJSvaWlYEICa01oDGJi
         25nTFd+GnTzDvHMLoEWFCKJgzb2W6DMw02Te8wzjDJRFNjtrhH+uWkwdgaws9/zlTxur
         LbeQVOetabAgjVDcjkNl4zLj9sAAwU2AM40ujxEzwC/Uhl0cRi6CA+cGdAaXx1/5V1VA
         Ecrv9v7o5cTU/oTRiJJE11ktvRBqsh/r+vjdV29Z920GJLS5OoZUfC2c0h55bPNTqrbf
         Rafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600285; x=1770205085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMvEySfKqN40aH1Q+vuOu50FEoPH5vpnn1o50b2JyG4=;
        b=l31eXGFxgzDtd+/x9P01YHkZ04p0UYEIWD9zpKFh9FMbdYzwe4jTWT762bIonHIrRR
         X71yzZiE/TkgPAqHA2VgjnHp8klcLTih+WaPhy4kDkztqAnM83MXwljfOZcqDfUHxs/m
         d3MEPw8YUauUtMpXh57S+Oho8t1QrKQNQJi9xryUujZQ/Bl8uKXwFRdOLU+10jid+S2z
         bmLTLm55m66JmasxYvuc2tNEp0S+UxD0PzAiDw8r1gPBOSgXOYYyWptpzI0xmnEgj5Nw
         6Rz1/CK890Xw0gjg/WWjB5ipM4Zw9aXMSDCjnYvWX1GWpbHQpn32Eis3SRAn1NKEJOsq
         LJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+0qTd1gAVp5V6xeNmtwm1+Kpx09QOk+o5MsUBHNL7QbGLXjcQ2+jr0cxDvjfXjd8RN1cdEWKqqv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yD4jLyk7AfE4RI7F3TtExm4lhO9nQ8akaO61mqnOfVyShMCG
	e90zMSkJdl7nodEALpuylcRgmljLOtmGZPEshxDkQ+EnZ9ijRFhF60i5
X-Gm-Gg: AZuq6aJy7WmQp1ZmsUHQDWxfyBDOUasRS5ZAgKS3pGOqa5jZ0RuElrAVBZApBxyLJ1C
	S6FRwaqt5meItfleInrsZIZ1dRGeJQedvdrJpWRSlEBnlSjsWCTnssl0ePw0eB9QM5hpDEOA3rS
	23MGrmIhQmekUoR66vksf+EYZ3G5res3g3CsAz44qq6tu3WG3dkGidv0qZihno+uGwphltfelwP
	CH3WSvngMCxQolsFp+y652QzO7i8sjJI+RCHHjxhEGLl55riiFlO4CqVIAHbWqdi5gGM2OAaoZH
	fEQOeo/y8grPTM6/3KLDZK3EMsiMM7lvD2Sj79KBSho8Qqcl3YfmXis0SXL6xWj3gX9o8kXnqxm
	szBsuS7UgdKPlxbx+mTCiHGJPPVtNdZhOL3XIz3BsTRJp4NUmiMG3HwFOwIG5OW0oLp/k9cdkqe
	C7T9wFUX923SkhZQ==
X-Received: by 2002:a05:600c:150a:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-48069e79625mr34709955e9.16.1769600285321;
        Wed, 28 Jan 2026 03:38:05 -0800 (PST)
Received: from arch-xeno ([95.173.233.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm116284225e9.10.2026.01.28.03.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:38:04 -0800 (PST)
From: Menderes Sabaz <sabazmenderes@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Menderes Sabaz <sabazmenderes@gmail.com>
Subject: [PATCH] iio: dac: ad5360: convert to guard(mutex)
Date: Wed, 28 Jan 2026 14:37:51 +0300
Message-ID: <20260128113751.258219-1-sabazmenderes@gmail.com>
X-Mailer: git-send-email 2.52.0
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
 drivers/iio/dac/ad5360.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 8271849b1..a22bafa45 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -209,10 +209,8 @@ static int ad5360_write(struct iio_dev *indio_dev, unsigned int cmd,
 	int ret;
 	struct ad5360_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -232,7 +230,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
 		},
 	};
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->data[0].d32 = cpu_to_be32(AD5360_CMD(AD5360_CMD_SPECIAL_FUNCTION) |
 		AD5360_ADDR(AD5360_REG_SF_READBACK) |
@@ -243,8 +241,6 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
 	if (ret >= 0)
 		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
 
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -264,7 +260,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	struct ad5360_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->ctrl |= set;
 	st->ctrl &= ~clr;
@@ -272,8 +268,6 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	ret = ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
 			AD5360_REG_SF_CTRL, st->ctrl, 0);
 
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
-- 
2.52.0

