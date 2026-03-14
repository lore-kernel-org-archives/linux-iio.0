Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C9326938
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508055; cv=none; b=Bxh1qZ8r+tIT3YsFQpJ2taiUbu+OQJ//GxeM0A4F2QMdAqHTv0Oz4CQA7NphmHWTVHC319yricCEo4Tyyt5ciw+WrvHk1+wmW5uc2vkEfTBVyB0/udpiv7dt1jo+c1e4y3C5mSgGMknEnjpSETyMfE6H9yXD8XI7HCg5LtPUjXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508055; c=relaxed/simple;
	bh=yrd9gnH4G4XboAvtH3+r2nhqv/wL64oMNG1tqzjyoYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCqL0WN2Widw66gmoJoxq6OwRPxN8/++954jKDlGiG6wq5OyrDsJz7D1v+RupMBMKPr+fLuuiV5CAiB7t8kx+HZWHkkn0mnfPIyODfWINUsC3Nz5xDbWKiPocRPrQhqtJCBy6JAR00JJVpgbtGnPGJgG4xq4dbBOg2SVBH212JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCnvGKGu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCnvGKGu"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2096526a91.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508054; x=1774112854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yddq5l/1nbJ4rOJNrryOQK4alZgEnsRtcdvwC6K0IHU=;
        b=aCnvGKGu23RK5IeczwngLAIVKbnJXWmua7pFW6+4QGT/tFRfRZCoPbCe9KIXsTLThT
         Rm9mURvvu67SDF+F75GBZzcP1iyvxjHUPvACGlbi3ho1RXiE/A0AT9tqz0YJsgT/tP5U
         mHNfCBwk4T21EzSZIjm6zs9kVAWjNgcmvNn9SeMxKXiVzredI719ofABUornruj/SXtw
         yBO77gl3ne5vimllFpS5NzzCO+oI6USnee2u5t4+LubOnic9xSLvrMAlD86NE27gfdj6
         DY0LXyzCHwFVJEgmziDGR6ulw14aN5lyUjTcfpNbsOqp6/zE3Mhk7zlMYiVcty8UJMOv
         lhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508054; x=1774112854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yddq5l/1nbJ4rOJNrryOQK4alZgEnsRtcdvwC6K0IHU=;
        b=jTaDxriK5vdS7/+4w6iUdS+10CqDFr07FJBVdggVfjP0N+6jb2cyO5/T5/p0gFJKV1
         0GGcvUyY6GgzGJ2zKN8qah6qp5mGPL1ZJZKN4yMpem4b20MLw7jTFMPYhLOhd/s2B2TQ
         W8JhmynhuOIX1xI3hujE3cF3VllXW21CTlSaguu1yXKUC+wTM7MNOoO+CEJPTwJYe+b7
         7vtXRMcIFwKSDRI+uzk+ARpKNJMF1bUXaCNkO7/iD0DeWO3dq2oO54wwsN1N7RFLfL+v
         +Bu1Sk10PQV0Uecqf7MVFKXK6bcekHA3EBrqTlQmdtiaNFVW8bKYZgu0YWhv/YhL0kpc
         q+Mw==
X-Gm-Message-State: AOJu0YwHP2qYxt0fNXseA7e0pkuBr0QvrCrQFw1Q+Cw7G/todCbv0CSN
	W8Z7ALbGp/7CRccXBtsKbbek7L4efq0GUoaKyNx++m1ocx4p+NLOMd/0
X-Gm-Gg: ATEYQzxpAS3PO4vHNhSJRBKiT2bWmPtltVHc23gOW//VytgQrrUlQANuA++GdXP9z9+
	b7a5BjaYf+Pi6d1c5C6tH8joqtlJv2l1MnngVsoAKukgErVGEYbYGGVtsXshyykXZpr2EvOmMET
	AsoZ39ZT++LupSV6NiaWqh2sVRzfFhsitmdQoFbxdzjbUNZAuS1BC785wPGMwXDbZ3Befdu8G7D
	2OZ4jcG9Ge/8eq7yZBqGlQwrARp/jmY3MjRk607bTDAr34lWYPpi6azFKS+aTMNQ0OOv1mAMXHH
	kHp8cpWUMcxaf72wbVFpkmymGyXk3mY1J1i0eEkQslubz06PHEx/aSfsZya1rMYge/OoS9lTSsu
	mSwASGnHWdVtJUid3LCa/ydcrEZDGKURGnGP4j6yynZ1qyas4W2PWSySX4A7G/TdZLVDS7yyu1G
	m6oXEvg8hZlcNmYTgsfD4VKK82miso5EEaZJU6y7rdk6NzjslLpMHCj9VZ+5r2XZJH3E7AkcO6/
	sRB4XGslWFHlA/GxzUqtNXQ7l8=
X-Received: by 2002:a17:90b:35c3:b0:359:9cb8:db5 with SMTP id 98e67ed59e1d1-35a2200d7bamr6243213a91.26.1773508054194;
        Sat, 14 Mar 2026 10:07:34 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:33 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v4 6/8] iio: accel: mma9551: convert to guard(mutex)
Date: Sat, 14 Mar 2026 22:36:07 +0530
Message-ID: <20260314170609.26827-7-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
mma9551_event_handler(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v4: No Changes

v3: No Changes

v2: Dropped Header alignment change
---
 drivers/iio/accel/mma9551.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 31e5c3699c19..0936b148e424 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -341,7 +341,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	u16 reg;
 	u8 val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	for (i = 0; i < 3; i++)
 		if (irq == data->irqs[i]) {
@@ -353,7 +353,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 		/* IRQ was triggered on 4th line, which we don't use. */
 		dev_warn(&data->client->dev,
 			 "irq triggered on unused line %d\n", data->irqs[3]);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	switch (mma_axis) {
@@ -377,7 +377,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"error %d reading tilt register in IRQ\n", ret);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	iio_push_event(indio_dev,
@@ -385,9 +385,6 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 					  IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING),
 		       iio_get_time_ns(indio_dev));
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.53.0

