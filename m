Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7B3FE37B
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303119; cv=none; b=htzs7uHcdcXQDLKRbJfDhARiK32YHmafJmiaUparYbqPQMel4aZCzPKnzayKCAh2oeIQR+nj7FlqYzXbg5fN5teCItfCIe5G7P3POeta7TaJnskQ3LC4JyotWxvcUkNb4bxrFHI7OHDfX51xggof6uerDk6bkiQcUvk/53bc7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303119; c=relaxed/simple;
	bh=H3E+RZJ0ZZQdGvIV9hZi2HA8RPpyijoz6EaLubDIzr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XA44sunqDF1CcL1tNiCZo3LnDdnYVpkAXbmanFji+Q4dDRqKWOO5ZsKxckThQG/yaV0JCJmFKt06XOWHwXQKCFpFulXhPdPkVCdLkhRh6b/lNE5qBFn+99dGSs6rzSX7s4G/o53uHCsH7Qmt9VEdC2rly+8qSrKyz9iq8bmgZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yvuyyfv0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvuyyfv0"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe5574cb9so351649f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779303115; x=1779907915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPQEZefd1Ef2xxJ5Qo6FIZLbI7JvvMhU7kzfA8EEsl8=;
        b=Yvuyyfv0Z/yjvFrTAb0o8G0pe35OOxVwv5rt1hlTR1QBDknx+I9eTQTWCyN8R9hxdi
         IN5Uz/LnuegGO2rsyOnhp3GLI52wxq4Ht6RanA2skwsB/unZoECcltT6tirFrTtruVnP
         WwgNF9PowrmIVy1UzQmikIz44iC6kXwxZ1g2O/p2vFGxT/iyNvzgVDhMK9F/ekXUfIeh
         GI7Sr7mI5JuvNqrasqX3L3RFpYdkq1J9l24Yb6W8V/1/loWLptycTqh0ZdV7n3zw1toZ
         fNnseZ5CbM8mfO5LZ+bGiWcsqcFQnXRzx5yc6U5st/xSmUYTwIcGpHcUBTbwiMiy3OFC
         r0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303115; x=1779907915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPQEZefd1Ef2xxJ5Qo6FIZLbI7JvvMhU7kzfA8EEsl8=;
        b=svGU0xP38UO3htKgHzukA3M2LPKfLTvAWqJgQwf945NGPMWovM73f7W/LXgFbtCImp
         vW7ng6ZfotC3SECCZwgTFZml0N2PehlTtqM6AE7AKUeSRHXxnSBK29AGUqvOU3iLvMfA
         ztS5FhFWOlK24v0nmYKWIoweaTShbItsvLIwXzsCAM/Q5NuLZKVM/VFfssCg2woqkO9m
         XWnCEgjigJLo3t/wgML4MWaU43VmKs2yJu2WR2fwYKKhQnK7K20GmFfB6f3bWj9g/wQu
         F0/In78Br0NfaPcSb1/VOq3MmOXEOmZq+OMGsLmuW68MbBBWfc2jrYevHCpkbZCfyM6h
         MQBg==
X-Forwarded-Encrypted: i=1; AFNElJ9DFannF+xi+O7BD3kI74WSuJpRUBy3w0a/z4PvB0CBnqn0jgObamvIlDqtXhJ6qoCaqX7Hmdibhic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz35w19+42xr/7IJDlOsImllkgrxvzG9T1X0ZkpnZT4y6b0x3En
	VXCu7xLk6BY8NtXibEq9rlnvr4pSUixAMLvkI/i9U3DxsG7QebbwUmWw
X-Gm-Gg: Acq92OHiQd6HuTEMhk4wkFri5JyITavo/DHGO5evbqP+HWqstvyYg8fYD3tw+SKuxo1
	JReY9T/I3VyGd9Wj1zZhNe4zxqCbV7bJrpBQvZOcHArAk8OslWh7ol1ilo6XuzkrHFrLC70y780
	TQ74UAiezGhpb6uVd1SnJS6bxpCviHVFPB3JNRtsR6ugil6wztmDrae3567Dra4/onQb4iM6yJ/
	fAoz/0GvJ9QcrSm/gcRNpxOpArerKJspDl2o2hJUW+krenAZKB+dJmafQZea5ueesajJO1XT7mr
	xJEsVKjxWmWwZfp/kUta7mOvDP4oiE8VWJUzb8Fy0Ybjp+LnBQzJz4+erfmKltAGnseTdMGzc6u
	3GvHW/dRBEIlQAvCiDQz+YEocZiA51XxWt+eLdM2ojTBbcL89qYkb+oIYEP4J5Tp41S8pV5Cmt7
	gmYCp1Ah9e7ShwNnr6VwKEcx9nqw8DYCbZmcKAsaW3SKy9
X-Received: by 2002:a05:6000:24c3:b0:45e:8a84:bf68 with SMTP id ffacd0b85a97d-45e8a84bfa2mr6451715f8f.3.1779303114806;
        Wed, 20 May 2026 11:51:54 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm60518272f8f.31.2026.05.20.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:51:54 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: potentiostat: lmp91000: fix NULL deref in probe by reordering setup
Date: Wed, 20 May 2026 23:51:41 +0500
Message-Id: <20260520185142.34015-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lmp91000_probe() calls iio_trigger_set_immutable() with
iio_channel_cb_get_iio_dev(data->cb_buffer) before data->cb_buffer is
assigned. The struct is zero-initialised by devm_iio_device_alloc(), so
cb_buffer is NULL on entry, and iio_channel_cb_get_iio_dev() does an
unconditional cb_buffer->indio_dev which dereferences NULL.

Reorder probe to acquire cb_buffer first (handling -EPROBE_DEFER) and
only then set the immutable trigger, register the trigger, set up the
triggered buffer, and register the iio device. Move the cb_buffer
release to the end of the cleanup chain so a late failure properly
unwinds in reverse order.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 36 +++++++++++++----------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index eccc2a343..7a938a023 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -330,17 +330,27 @@ static int lmp91000_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb,
+						 indio_dev);
+	if (IS_ERR(data->cb_buffer)) {
+		if (PTR_ERR(data->cb_buffer) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(data->cb_buffer);
+	}
+
+	data->adc_chan = iio_channel_cb_get_channels(data->cb_buffer);
+
 	ret = iio_trigger_set_immutable(iio_channel_cb_get_iio_dev(data->cb_buffer),
 					data->trig);
 	if (ret) {
 		dev_err(dev, "cannot set immutable trigger.\n");
-		return ret;
+		goto error_release_cb;
 	}
 
 	ret = iio_trigger_register(data->trig);
 	if (ret) {
 		dev_err(dev, "cannot register iio trigger.\n");
-		return ret;
+		goto error_release_cb;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
@@ -349,35 +359,21 @@ static int lmp91000_probe(struct i2c_client *client)
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
-	data->adc_chan = iio_channel_cb_get_channels(data->cb_buffer);
-
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_unreg_cb_buffer;
+		goto error_unreg_buffer;
 
 	return 0;
 
-error_unreg_cb_buffer:
-	iio_channel_release_all_cb(data->cb_buffer);
-
 error_unreg_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 
 error_unreg_trigger:
 	iio_trigger_unregister(data->trig);
 
+error_release_cb:
+	iio_channel_release_all_cb(data->cb_buffer);
+
 	return ret;
 }
 
-- 
2.43.0

