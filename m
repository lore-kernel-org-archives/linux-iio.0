Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612B4949E5
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003251; cv=none; b=bAP42CFQ+iMIjrCa8GMNSI2ypt6txiNjur2NKIHQvX4NgvRmjnMD5+NqAnnR8FzGR9nDgZBhigU8NhfRYkQ+qMj0LEqKqtrIGXSVH6Tgy//yycKbi1yPIRcjk2DBD2UENDWm8KBO4KpQ+iE8JeLn5Cldhe+KZhQbwMhBXEwqQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003251; c=relaxed/simple;
	bh=0aPtEt4ko/bnfbsxB34xLGU9UY4EBvpuxCJGx/Lx0KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPcCU3Ta5kRFm93zNvT2D2nzbpEzuVqAHEJ/lHaQgbzeWhSQm9hM0rSVEFqD48KhaObadxDfEKo43SQ6EBOJV0xnxqlYJu47hbiCO8W4eJlbA2J6kha1waXte4i5ygUeu5KpjBHR4VeLrLVsQJ0tkfUWT+GtONyZtFziUlY+vCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI7Ehag4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI7Ehag4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so17691745ad.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003247; x=1778608047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMfdiYOhCtE/zO7JszEiQJezv05uUDaSwuwa5j2WLnQ=;
        b=SI7Ehag4GqX5pouq1AhEeVZn53bj37amD39Z27GCAYqeTBF0DC6nu0zjrjt9Y1Vu5s
         uTLXKFS01LSu5rM4IfY4vst0xBYFIkDS5SbJ81+Ey15RRyTzfAPYBskYkcGdj+WlzgiC
         J7imIBNyQV9QCS8kolF3iK2Z7DvkovX9zUd8YMPdAjVRB9BTqV2FcZFHTZ0r3QoisFBY
         xcjWl8veUM43cqWkyRRErdGErF4FPMhzzdKMcghLe+B4iVneeXEhN4LyBiSWYU8z4ULM
         vHy105zDRWxtAmWczVtKjfny/xCzcVtcgLul+OL3yn+156t2aT5xoWojR0TwpK9eUI/U
         LOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003247; x=1778608047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cMfdiYOhCtE/zO7JszEiQJezv05uUDaSwuwa5j2WLnQ=;
        b=rAQEZeTEY3aormNFqsIzvey65ESsILtLDg86HQxaQmqjymH3GHXh4VtQETVEdWmyVS
         72gi7uQ0J6lHrvmsaylnAwrnXQvn2n8ns013+caqhHbL6rD1JcOWPx1OB9mA8qnzkuN5
         el4EXJcx03W0tptK50cnk0sDXEelEj6QEkD/A87m8mOLtnNIfiPY7Rtg0dDLxQ+rhz76
         KRcmRe3axG+C2ACAKQOztFQK5sq72XH+7utNiJlpMNNmZiQdhJkaZOsxnWrc58YlVYDH
         NsWj43oSBagKwXlX18xgo3GHSfgIcVd26v/Zd713mQVvgqiBH9E/2G4ArU8RzTG3AG26
         GN4g==
X-Forwarded-Encrypted: i=1; AFNElJ+Yp3RO4MA5xp7GyYXWAoBesGwenFEsV2cI8JxIqBq1rfKIOLWxiKJ2CWPHPuj1+GHB2JiMp1GI9og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZ6U4a031ccE6gChFkCJnI9y9k8069kZj2IK3n/KyxV8V+X/0
	gDaYOH88v9wE3tIE4KcLJ8fvrS46jY8aXwZlND2g2o9XS3hu3Jz47Y1Y
X-Gm-Gg: AeBDiesUzznxWtHyVAbwwQbKEM1kQf4mdH4w8yDmsyXzncvvvpz+9WOV/GKcU3Nf1wH
	PgWGDXVbTuuizA+Hjv51xqp1M+QnGBXU4QTiETynejcBN5vGfucJkN5AMSBeBk9Ie7ykgFmAuVy
	EcEmE2pKZfeaXKkmthSbX6pgrId66Gr4BMhAFGO3qMeQox4oCi7C0B4obbvM0OhWCo9B0dTuZLY
	4jx2sMQHrhxyY+6eDboUqtnrLwXGFILJTrmhtMQhEeeGh0MLnsqxrwfJ7SAGgpzONhTIDFNO9Fr
	6zm8Q0lMZYOiAzdkUhe+M+8N6abhCoJ73UfPL/SW6PT2skiitVy1Ms2ZXinWVIUj7FHyrfYFsJY
	+2gZI5S4lawsi1Qx56c5NF0X3NmlW0FZX6/bbQz1dbkFOHfC8N2fB7LieP1EiQhi0tvl9eb0DhK
	wlsWSky3qomaZs8gW3n7Qbfe3g+mDZ9nUA8RePcZUZkLdf/ne3Z1k3kH5LTJM=
X-Received: by 2002:a17:903:2a83:b0:2ba:36f4:5844 with SMTP id d9443c01a7336-2ba535c0e67mr35976075ad.7.1778003247494;
        Tue, 05 May 2026 10:47:27 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:47:26 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com,
	martink@posteo.de,
	mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/10] iio: accel: mma8452: use guard() to release mutexes
Date: Tue,  5 May 2026 23:16:40 +0530
Message-Id: <20260505174640.3998281-11-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace explicit mutex_lock() and mutex_unlock() with the guard() and
scoped_guard() macro for cleaner and safer mutex handling.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v3:
- Following input from Jonathan extended mutex scope for
  IIO_CHAN_INFO_RAW case to include math operation under lock
- Link to v2: https://lore.kernel.org/all/20260422165643.2148195-7-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 3bc53cfdac24..1370674d71c6 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -18,6 +18,7 @@
  * TODO: orientation events
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -478,10 +479,9 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
+		guard(mutex)(&data->lock);
 
-		mutex_lock(&data->lock);
 		ret = mma8452_read(data, buffer);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
 
@@ -579,36 +579,30 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
 	int ret;
 	int is_active;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	is_active = mma8452_is_active(data);
-	if (is_active < 0) {
-		ret = is_active;
-		goto fail;
-	}
+	if (is_active < 0)
+		return is_active;
 
 	/* config can only be changed when in standby */
 	if (is_active > 0) {
 		ret = mma8452_standby(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
 	ret = i2c_smbus_write_byte_data(data->client, reg, val);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	if (is_active > 0) {
 		ret = mma8452_active(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
-	ret = 0;
-fail:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return 0;
 }
 
 static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
@@ -1730,9 +1724,8 @@ static int mma8452_runtime_suspend(struct device *dev)
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = mma8452_standby(data);
-	mutex_unlock(&data->lock);
+	scoped_guard(mutex, &data->lock)
+		ret = mma8452_standby(data);
 	if (ret < 0) {
 		dev_err(dev, "powering off device failed\n");
 		return -EAGAIN;
-- 
2.34.1

