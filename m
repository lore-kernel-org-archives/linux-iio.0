Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46375305E10
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180102; cv=none; b=ihoZ14gCQkUwy7h6syMhzFZnOW10jAbIYwfnFBftlKmTFxz9TAc3fXo19orXP37wIbj604g24xsoa7RwP1qDKdZUJ6RbS6QO2d7PdcX5WgPThpgKDpHGyuq244dlVslgNlw9fDwbA0sia4yd5sONR23Pol9zh/yOVSINP+M7dNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180102; c=relaxed/simple;
	bh=i/3Y9dkkUFALBrgQDubhf7QiYS5b3t9pgBgS9vpbp1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhD+JJWrIV741uVPq/WVc8R5IWK5sZk8o2Mf6gEVCarkWOGwh5NWq+4INZhuGVDFb0qKSaMtJUYA1x3nt/9SG/l+1zO0Rpucn58RFF0YzgDZjFkHUrLI5ZHjcfjmkdo8W0NCHB5XvBw3ewQfyrUoBqEbr0LuES/15YIutjXmyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaWoDczL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaWoDczL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so7777285e9.3
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778180100; x=1778784900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmtSYkOERa9Uy3vCGg12rMdrx7k2L6utB68Iwls17DI=;
        b=BaWoDczLS3AGi8grK87Ocq8IBC+K4MqHHmEdq3lYkPF43L4jPbJKmL+vMOJ44P/wHu
         K+UEEAb5Ezs04PN1rxnMzFxc/VFjNcEFJgI/QPKAC8kCfIy0um+xL3kbjhuRE6RyTsL8
         osqBwZnnwgbkcSRFdFMOMnDkz6IR0BtT2e3/LiARGmGVG7iWDLPkdtPJ0DBFJMh8jcsk
         PViNyS6n7JI/0Ny2Jve00zCSToiTlvrJM/S8sL+8C7sG4OIDeEc22BeOrmISSOphXlaG
         gNlCn3In83gr3lkJlLLnxBRH7AIz82sLgGpaUDMys6YdpELfebe8R2OchldS5iE8kIeD
         jPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778180100; x=1778784900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmtSYkOERa9Uy3vCGg12rMdrx7k2L6utB68Iwls17DI=;
        b=f0Mxr/iEeow4ZOBVm35FhzKJbYqvfzhkho6w/l/Z/FRweFyRkdi1HrSkxH1iIl2vHq
         pxlXGEH2KPdsTQJ+Qw4uyVO2YUXin47BBPaUQF4kpZ2IgxNuIROdG8Ib2Df6/vxfTWbz
         ycwRi7tCXgUCxCNn6uOPUy6+0pBJlB+9CfNhYYg4tc1wmPi4D4RWf+fYxD+U34OZBoTw
         0NsCfHA1gPb+7dnSpCcO+TPCKb4C2CPM2zeyplfqAaG/ezGhCEOnOYq10aYwLUidzvoK
         yhIeQGgDXahA/XQhxsg/JjXH6XnV1WVSyN3bywI0jCvtNlVb1WmpcsixENqkNUXiJS1A
         tDAQ==
X-Gm-Message-State: AOJu0YyjdR6hWiFtWcVo3B5qlmTLCIkn3g5tbGtsegVVXHCcTxTXdj5k
	eMj6DFPmNBkKE4+/k8X+P3G8jyA9dOW3sv/i3OdFOtzNmkl3i1cnntDM
X-Gm-Gg: AeBDieuewwAa6dM0OQrxPWzN3b/kp2y1cHNgX9/2QGX/Myuo82eehwoOJivmVAu5M+v
	ud3UZ/gbvC3XbVrVceV/MQckW69VOKHoYsFXJKT5Bsx8qTlpuYJmZHuyefBDSjTwivW6IfsZRiG
	L0bHLb5865rbL931oPzdtiCptsabJbZP+4qicMdSY0LBxURWdEq5upYF2Kyg2kmIoxwXZlFEnlA
	phPJ5631BveKAEF4Sv4g0SnQa9tHASxduHuX3TS1TUKjta16YkJyGvKACWBSivpGBMXM46xqmx+
	PkXRZfnOhRRCBs+VFZBfCknfMiSn5z3SMCP9wDM67Rs2uTbu73LAsCejYfLJ4usGsA4uAYigTCe
	draSH3YkdlswcGIVqh/HzE9//Q6ycn4ypBmO0lF53gojBHciW/oqrx63zP/rNrddPWUGzPZ+f4y
	wgtXc/P0IpQFTq43jBHvobNZLnvhBENCvOHke7DMc=
X-Received: by 2002:a05:600c:45c6:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-48e521e6090mr145587925e9.14.1778180099406;
        Thu, 07 May 2026 11:54:59 -0700 (PDT)
Received: from localhost.localdomain ([196.235.195.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e65c0da87sm176205e9.21.2026.05.07.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:54:58 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: potentiostat: lmp91000: fix probe order and cleanup paths
Date: Thu,  7 May 2026 19:54:24 +0100
Message-ID: <20260507185424.27327-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the initialization order in lmp91000_probe() where the immutable
trigger is set before data->cb_buffer is initialized, which would cause a
NULL pointer dereference.

Also, correct the cleanup labels in the error path to properly unregister
the trigger before performing the triggered buffer cleanup, following the
standard LIFO (Last-In-First-Out) resource release order.

Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
  - Fix the subject line to be more specific.
  - Use lmp91000_probe() instead of lmp91000_probe in the description.
  - Put iio_channel_get_all_cb() call on a single line.
  - Remove the unneeded blank line between iio_channel_get_all_cb() and its error check.

 drivers/iio/potentiostat/lmp91000.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index eccc2a34358f..273127063840 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -330,6 +330,16 @@ static int lmp91000_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb, indio_dev);
+	if (IS_ERR(data->cb_buffer)) {
+		if (PTR_ERR(data->cb_buffer) == -ENODEV)
+			ret = -EPROBE_DEFER;
+		else
+			ret = PTR_ERR(data->cb_buffer);
+
+		goto error_unreg_buffer;
+	}
+
 	ret = iio_trigger_set_immutable(iio_channel_cb_get_iio_dev(data->cb_buffer),
 					data->trig);
 	if (ret) {
@@ -349,18 +359,6 @@ static int lmp91000_probe(struct i2c_client *client)
 	if (ret)
 		goto error_unreg_trigger;
 
-	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb,
-						 indio_dev);
-
-	if (IS_ERR(data->cb_buffer)) {
-		if (PTR_ERR(data->cb_buffer) == -ENODEV)
-			ret = -EPROBE_DEFER;
-		else
-			ret = PTR_ERR(data->cb_buffer);
-
-		goto error_unreg_buffer;
-	}
-
 	data->adc_chan = iio_channel_cb_get_channels(data->cb_buffer);
 
 	ret = iio_device_register(indio_dev);
@@ -372,12 +370,12 @@ static int lmp91000_probe(struct i2c_client *client)
 error_unreg_cb_buffer:
 	iio_channel_release_all_cb(data->cb_buffer);
 
-error_unreg_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
 error_unreg_trigger:
 	iio_trigger_unregister(data->trig);
 
+error_unreg_buffer:
+	iio_triggered_buffer_cleanup(indio_dev);
+
 	return ret;
 }
 
-- 
2.43.0

