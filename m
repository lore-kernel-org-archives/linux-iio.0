Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A353624A6
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010469; cv=none; b=e4z1QX1MTbmcvERbPop7Ko5TMRyTPDdeNIfjiIb+xwwnkVer9xuO6swgmgJZEijcbbcoTd8pz5vnIsHnpPv9IoygtCyvBJbNtxb0Yqwc3xNc5ycUDMeSsT3RHkxldq+GJyoRe+zMbfLuUUsmIgbxO4lQuTPynWEm+udyGCr5G1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010469; c=relaxed/simple;
	bh=y3NEValCHwI2rt/cQ4Q+fb1qS+Zs0+kL4Sc4Wp/YvFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyWiCXoJEz70IFVvbFdfNIJEytc449WmSPwI2jJZ7z+8EL7VouC/vyPTzzNoCOHyeRD5iDw3TjmoJ4elnI3fLPeKmgq6caOgxRB6d2bI8tNvI409H+szoVCiCM5d+e7ysVwuSfnopDBXTmTyOQ97/4QUssfG9s6SToAdBHmHsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdSO97wk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdSO97wk"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so6375927a12.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778010466; x=1778615266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pO4hWykCuImZiY4qhPEwG50xhEs6EbxJdgrXQV0h3FE=;
        b=FdSO97wkauKrsbrve3ZdgHt4YxUBkw67x4RO74t7KucRIrF4xTtx9vp781EX0DQoTY
         bYOeOpJFTQrcc8vwBPYr4S/0Vw3sVJvP3cPzblPDMXn3XnFIyF2SMZelzbQWM8YEDR1g
         L405uJ3RFgfwUjFOQCWaEzc7/YLdRnQLFJAxL2cJR0WCGopZVhHIXzqOOlMl3dmztJQO
         T9L5lstlMthvIPT8s914x0p4TXw5uM89XIc/p7402uNRo+PuFus8uHo90g1M7l5A+aCT
         opNqVxcnlcGf7+Zu+rpggDwgxOfutaKxy8T4cj5qsu44q6JVyC4OP1CohjRAZ+Thudyz
         WjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010466; x=1778615266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pO4hWykCuImZiY4qhPEwG50xhEs6EbxJdgrXQV0h3FE=;
        b=U2UEXAMHFf37YzQmd2dVNEcBKRVfsDnhub8TYFfh1f5aIqvcvqIsuI0JAhPycYkWhR
         u1VOHbpadubCGpR9ruy/yDPuzFJABeySdcmhtJqsZ+jK3y3ITqm9VjrXYxFNPwd8+u9Y
         3FNMLU3yiCGYvmUzI/Gi/xpz3BWhnzuPm4iNgkItYmG0Ohoo6liiRj9xlaQvMLL772KL
         /g73OrOVIYc3Wf96S3rqllfH/Sqwbtq3DFR4E6AB0pAw4WH7wWzLh5IYQQoH+JQLb9r8
         S1CQG9Cq4YSJbvQG7L3HJCI2WUGkDpr+KtuB339KHgNgjhWXiTx45tnbBQDUvgm3FEYa
         riqA==
X-Gm-Message-State: AOJu0YxoYezlJRhk5IrnsSefA6k0cYvHSwLWA2m9MF2jkZKahOfpYxLi
	ofRgE5vaZ/W1u6BV2QHsZSu8Bs/rCUXUnq7z6HuYaorAmHGEJ6aO5Qf+
X-Gm-Gg: AeBDies1906bRrI6U3elsyJYXmdjyaId7SP7X3m9jOdXjeCvNHLVqwAx5nN05I+eI4c
	MxhPhMPJBNWIZlaXAoKkAleb2cHb9JtpajB2CfE9eO9iHHP6Kmk9FTOOiXvCvxGz7HCLUzsa4Jg
	QPuSnCns05Dqn5AWHEQzsds3P7Ik9PLGKRew9sY3WPyM1Ga3+xyxlnS/zqgb4cetaIYouuPhC+X
	znc4w3ipqP+ReynfQo45W4Jlh1hnx18NzuPHI5VprNZyGQdGH+hKpvg94hfz4Eu6wn9hivhcG65
	QUmfumvLhvkfyx4os2O3e6VkNNNYBpZrjW71qDZTz0jstc9kVQa/yWRqnutjScBdnT0hmXgbivJ
	VvfW5mildYRkXMX4FR7m5zXQ6AGjU5hJWI2C5roLn3FzEJJsO0kQknZJ34E+npNbtGg7eix/vYc
	fMwmaExJ3Zrh4gHjBdisOgx78ZYXb1i0XE1zfaza2RYV7xTr6q
X-Received: by 2002:a17:906:b3a9:b0:bc4:f3eb:5a76 with SMTP id a640c23a62f3a-bc4f3eb5dd5mr87060666b.44.1778010466325;
        Tue, 05 May 2026 12:47:46 -0700 (PDT)
Received: from localhost.localdomain ([196.235.155.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc55b590924sm2222466b.21.2026.05.05.12.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:47:45 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: lmp91000: fix probe order and cleanup paths
Date: Tue,  5 May 2026 20:46:24 +0100
Message-ID: <20260505194624.98520-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the initialization order in lmp91000_probe where the immutable trigger
is set before data->cb_buffer is initialized, which would cause a NULL
pointer dereference.

Also, correct the cleanup labels in the error path to properly unregister
the trigger before performing the triggered buffer cleanup, following the
standard LIFO (Last-In-First-Out) resource release order.

Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 30 ++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index eccc2a34358f..b4676b5b60ae 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -330,6 +330,18 @@ static int lmp91000_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb,
+						 indio_dev);
+
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
@@ -349,18 +361,6 @@ static int lmp91000_probe(struct i2c_client *client)
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
@@ -372,12 +372,12 @@ static int lmp91000_probe(struct i2c_client *client)
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

