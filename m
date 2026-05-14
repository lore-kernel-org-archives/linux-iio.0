Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4B3D7D8B
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746137; cv=none; b=TsRa6xZQ10Fc1Sc04AKtUh0ybg97fjyDX0X9p6GFY+cMLeEG49Yxf5tncBBYI1bFKHjK5ue89tuPmNMua1ik/fSbj0e3P9ORfL+IWCjUjbzfg/cGg2hdQIFa7SaCQ20+5XoEzpd1rYDonSM6Q7qdj/++cZsP4QJY+k5qeiH8wC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746137; c=relaxed/simple;
	bh=qxd4CqApf+ZMtjwwgJZnLpmbs1Yi5XiqCS8GorzFoFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpEjIymevtGmarDvfaGGVyIqpUInY6w6Ota4vPs4mjzGWtYHSMQQVnpc0QQ1uHr8pcQjJx5DaLeyqvlEuns9s+73xSgfWWqNbMK9FXCNEWbrxD3tuyOxBSarIsDMG9FJTcgpRx+JDGY2yGs0dKMK156wOgFWJqaKYzLqf6bp0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tF3Bhpid; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tF3Bhpid"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so90742515e9.0
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778746135; x=1779350935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwwl8tovD6TuakxMmF8cssoXUab7dOdTy0pdXwdjtHw=;
        b=tF3BhpidoU4XKxE7Ygwu9iYdbw+w2TbIM2SMdFbN+wMpCYrh4y0/NA/cXs947UOA4R
         Tx1+71kIkzWkQOmgXSF9zzBV9/rWsJQPT2NiCfdwMUYagxAskKNHT0mlVgMDIlcOuoB+
         mE2eBtxQdR6eE580VJwxbyOvtpwE1cChSANt9e1F7vDN8Vw4gMFhxDg29w7nlbzHDdgl
         XdfJ1BpiBylH06/GfX1Wsvx4jn5g//rlQrpMSGUWmeWPd9AVoca2H3iI8SpihvoFBSsG
         YWCTIP0pHyySs6iFmwVAXooWNpGH2DsxQR4wJnvSYPWWluhT2TjcgxP94NT0Lto8B8Mj
         7Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778746135; x=1779350935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwwl8tovD6TuakxMmF8cssoXUab7dOdTy0pdXwdjtHw=;
        b=bW2DMlrnu7274le0iHUYzhY5e5EeFuRB3gjSePvVow1fPxRBNNeoJdq9PJlCV0fia0
         SfGv7k7XQlDK2jsQ4FpWTquHY2oxTPi/EEMFz+oSf4Pab+yIMKNfuygo6EkLb2JPX+oQ
         IetbRr/n1trCRiDE01tQQ5ihJbRlD5dWdrWsna9sxI3tcpeOLZwM919basqvioY3l+2i
         CgpfcNioB5BvlxEHVA+jpZD1oB87Sqe8rDtuV3hDkmM+wk0RySZ9XiNcoXB6txWfcTbq
         QoZMsaoQncw/plUiPcTlcxG5Exy5LTj3ji+taqGKe8DdcFAiux9hvheWXwM6NdxEijiu
         QSBw==
X-Gm-Message-State: AOJu0Yy1jhnlwq/1yguZT2P+m0t7zTdmhxy4gdAvPWOVuwbZkCG188xK
	OpoKrRxGLJmHQ5awiS321rauaUYmPOg7nORW9+zregYsVk++wrDuyKBo
X-Gm-Gg: Acq92OHw0f6+RI+zd51NPvMpZgt49IAzUtLT64wPy/q55BnBwt5FjwQXF+TRNj00cOp
	2fm+b5UWakUwPjGndQJINsukDpICLFwuIEaKPaKFJDsOL388LlphXVtznwAOKJPDYLXG6pf84Nd
	1uXwt/yjlsLRx5jhdo+fRF5t1/Q28Ql7t2TRmAqf63/3FWKv4let2O9hdYvpqsoEdkg2NnrTHXa
	HgFo1dI/gUdFRo0QxdnShm7wzDEKRPU4KLccJmCCanayZf8dEpjYoITIGjdX3AtcZM6+Trgi++R
	U81HF9AeGDo5qqUfsm86PxBOCAAqZAIguP9JtAv6BihghTrJ8vOlUZRLl+OCF6xOuZmDkAr4jZh
	Ln//KDsPozNnQ5ylFPhCg+35f68ZZP5TTWdapKgH6UOU+rE/DMBaMUZI7iaO+sqLlDTzLAj8ogb
	MsTVN9od4dIU8sDpYZPz1YjRnfkYA4MRAkqZAh8A==
X-Received: by 2002:a05:600c:138e:b0:489:e126:b757 with SMTP id 5b1f17b1804b1-48fc9a51304mr101611435e9.25.1778746134513;
        Thu, 14 May 2026 01:08:54 -0700 (PDT)
Received: from localhost.localdomain ([196.235.65.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd7297a9esm21131695e9.0.2026.05.14.01.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:08:54 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [Patch v3] iio: potentiostat: lmp91000: fix probe order and cleanup paths
Date: Thu, 14 May 2026 09:08:46 +0100
Message-ID: <20260514080847.296285-1-salah.triki@gmail.com>
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

Also, reorder the cleanup labels and ensure all error paths properly unwind
resources using gotos instead of direct returns, following the standard
LIFO resource release order.

Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 34 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index eccc2a34358f..30b40b3a97d9 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -330,17 +330,27 @@ static int lmp91000_probe(struct i2c_client *client)
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
 		dev_err(dev, "cannot set immutable trigger.\n");
-		return ret;
+		goto error_unreg_cb_buffer;
 	}
 
 	ret = iio_trigger_register(data->trig);
 	if (ret) {
 		dev_err(dev, "cannot register iio trigger.\n");
-		return ret;
+		goto error_unreg_cb_buffer;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
@@ -349,35 +359,23 @@ static int lmp91000_probe(struct i2c_client *client)
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
 	if (ret)
-		goto error_unreg_cb_buffer;
+		goto error_unreg_trigger;
 
 	return 0;
 
+error_unreg_trigger:
+	iio_trigger_unregister(data->trig);
+
 error_unreg_cb_buffer:
 	iio_channel_release_all_cb(data->cb_buffer);
 
 error_unreg_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 
-error_unreg_trigger:
-	iio_trigger_unregister(data->trig);
-
 	return ret;
 }
 
-- 
2.43.0

