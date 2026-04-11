Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9962EE611
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894725; cv=none; b=W3zl1GLihgofm0GeOAUQjLRlgD0Gw10yzjC9ITuKfC6J82ZjlySahAiE44sK/4c7mpc1AOHDa4/ohd55ZsZzJqlNLaqPGtnvWtd4gckihfSICLt13jG6tXciSXB0QslH80igKGkCB2TC4kTe+V54AWc26EIbn2AJ8HZvL4RSkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894725; c=relaxed/simple;
	bh=BTffGS/gCY2Nhw4JwAa2fMfT8m8fmomn9ZHDLdl05cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckdYaiMZ4bxx7uXdnZA1TsNrjISps88E5zy2NiVqM4tRat5OLnWROpDSbzii2Xo8VrlvvpA2y2A6+cYYgetVcBW6FjSZoJVRwMZb1fVePi+umb4WhNL56BKQ79th9Tt/NejEk1PN+eBf01/OErVp1XGdHIenVBp1EyfRBLBO7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5P1Rsnn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5P1Rsnn"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f2766905fso38358b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775894723; x=1776499523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAoYJAvzB2HJXU7lElfXwN21XkOVJNicGBCcf7Ya3j8=;
        b=I5P1RsnnYChFxGNvZVaAw/lS5uJoNNe5v/L9BQ9J2iaH/qggbw+r3ASv8EjyuNMxGD
         F/WeB9EZH7TP1oG9EqsFWm0hmsxmcttgWV4Gf09IF9I4g4Q+jlnOdk5+nH2sLfP6ZQWa
         nyS8HXv7UjzOdJhFgJbdplZMF+INJ8KJXva6+IUIl7tM4dY2aYK3pZT3NDV2zGMGJQp7
         j2gB5RQdP5O5iFiUwUdi2IZvUu37tQVRmJHL4SfdJ9kemrBPFBTnEECleKB4uPMfuqQT
         oHuK8xmZP4vmGkrXBvhOG2l7QeDrxLQCWBsqfKmW9Hw1hIVDEOOdSUVX1LJwysaNDK0c
         F4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775894723; x=1776499523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAoYJAvzB2HJXU7lElfXwN21XkOVJNicGBCcf7Ya3j8=;
        b=jqXQlYEBFOEyyyjlwEs8MmFBMXr1Ry9eUHwqSX54OdgkheYOARAroBg0U+yVI607OK
         ng0mRvgDAXNzmuIvmCDVValckNt+5HBYCXfFfJaGLcXnZBRayw5yGz2mMegbqnIF17so
         JHdSlfY5YgvUsq0x7OZKFAbljZGZX0WX4oEICVMy4IwyUbY6ASsY6eW6d1xsfyo3gZ63
         uVupQFf3ywD+86OQ1QkZr5E3dJWTDQ089c40CXh2obZf8Arg/64RyCyJW4TMUYvP/MKs
         W8Chu5oGLfey6s9Rj6cDSOIOL2uTp0dkukCPwmS5fZzySWRh6rX5l9TdouJbeFSu0NXg
         j5mg==
X-Forwarded-Encrypted: i=1; AJvYcCWRx4sWUhil6swH19EiV+onQFFpBWsnGJ92ARiZK4v2b7uiL8eYt8ktiMu/QlHMuOHba4ZvXXOTsj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKeDhEHDyIWM8E5oUfZjIfgtC9xMkdPfPXZgdxCaHfnZuEd3f
	rFNByhKIlonI1ySrAPXw+2Qy2QzDumAR5mp7sxWMavN07HkjP6Z56a3S
X-Gm-Gg: AeBDiet2V8v9IRWyYzFioZOtPwHHhbFTI++8Sd6yrvvjhAPfJ7OP2ck2m2hyvqgigdd
	yYVok2N6uP+Q1NHmZ2ePysGJLIIzP4Jyh6fvxPsHS7VseYTve/JZQNWEnui/1bo6h8yWUUJHDKm
	rz7P5oSpr+Lsq/wjvvxl9iQmIz5Cj5U6ojVW5f0EZH3N9a49y4hfTTIA1UdJHOaegJU99sMrKXM
	t3412bYrGZdqt4xjNVz/a+w/IQJ8VR/34DEznj8Wh+XW+zIm5v73PV8B2jfevKqi/jsmq/OzUpQ
	S7cRzeL0iyXP0IaIVPCjJRcQQp8K3hCYHzieor1vHy8bI41QWY+pO34/XE7qESMxuB6u9S+ZPJV
	ueDZDqWuSCArSjFcML61Le/hR2EVs3m1//2DQdKRYqaTpz6p2e+SC2Jddo0u4kNlZOayPSX7mCb
	q+WCxnynFBFkeMXKMFlsVdag==
X-Received: by 2002:a05:6a00:12c1:b0:82c:e1a3:986f with SMTP id d2e1a72fcca58-82f0c324538mr6784698b3a.43.1775894722730;
        Sat, 11 Apr 2026 01:05:22 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b251esm4820466b3a.37.2026.04.11.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:05:22 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: trigger: Fix refcount leak in viio_trigger_alloc() error path
Date: Sat, 11 Apr 2026 16:04:35 +0800
Message-ID: <20260411080435.2125626-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In viio_trigger_alloc(), if irq_alloc_descs() or kvasprintf() fails,
the error path frees trig directly with kfree() rather than releasing
the device reference with put_device(). This bypasses the normal device
lifetime rules and may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

Fix this by using put_device(&trig->dev) in the failure path and let
iio_trig_release() handle the final cleanup. Also update the subirq_base
check in iio_trig_release() to test for >= 0, so that a negative error
code from irq_alloc_descs() is not treated as a valid IRQ descriptor
base during cleanup.

Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..ab544976018f 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -509,7 +509,7 @@ static void iio_trig_release(struct device *device)
 	struct iio_trigger *trig = to_iio_trigger(device);
 	int i;
 
-	if (trig->subirq_base) {
+	if (trig->subirq_base >= 0) {
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
 			irq_modify_status(trig->subirq_base + i,
 					  IRQ_NOAUTOEN,
@@ -572,11 +572,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
 					    0);
 	if (trig->subirq_base < 0)
-		goto free_trig;
+		goto err_put;
 
 	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
 	if (trig->name == NULL)
-		goto free_descs;
+		goto err_put;
 
 	INIT_LIST_HEAD(&trig->list);
 
@@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	return trig;
 
-free_descs:
-	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-free_trig:
-	kfree(trig);
+err_put:
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.43.0

