Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7012352C4F
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106226; cv=none; b=K233mVn3pKdcHO2a6fTJ3iSveRpQu1sbLrPuWuzAWsTM1HWjPBMdF5nqOzKgJeniGlQWc9sfgev6WX0EQCGEIvfVd3rQE+ZrIYDk6+5QI+wCt4hw+hQkcNF/B7qbUEa6lTghy41qZwmHYdfh2FJGcjGEn3ZHuM3y3F7vIIkMWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106226; c=relaxed/simple;
	bh=sZ+IaKxAHyS3m4rlVmOkCFrLA9Ww8PcXwY1QTqRXXbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ba/nes43m62H5vVBeNnpquQcYpbt4Ww0TeWRTHZ4pDrj9sg+jxFveP85SZhwSPPeNNmV5HHgUzdqm0tdqLvHFBvmVENic1eEnDm6lUFeNqwqUGUwJCDFBazxrbY8lyr1vLnND28iBHwuHr+ZUqwH/tKDQRG/cml9Zf7pz2Ba3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciQ0NgtV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciQ0NgtV"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d5fd50d20so2688372a91.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106225; x=1782711025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFIFtwPf4fQHlFS3PPsYcL7YhE84j0any5oPCZRUGv0=;
        b=ciQ0NgtV6WMswSLqG8Z16g32mnVWY1w7XObcgrh4DylrkOf6rQwqdK9d9VlKgV6v3g
         j0e2z7xZ7FLdLudcIBL75gE4oXFSBLkQBj+54jts3eaqcEGLngqt5Ml7YKibxBqJ6f33
         LPGrv0zKWdrIxR6qZ9IJlcyhLfZRZg5LvNxuVRCNUhfMk2b9XMF1IckWbLvaZwWmm3QF
         wG/w1oHAes6o23YcsCGSz8cbPjfonay5yo12VPKsFdKSbSMWv6cIwoipz+SyDB0ocjVH
         Rw0WZVOPOyjS7GIOrzD6/m5kv426UDRnG73mu3iZ6Yc7DLjZH6o60/cfmWwBfsCwS+8q
         N5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106225; x=1782711025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iFIFtwPf4fQHlFS3PPsYcL7YhE84j0any5oPCZRUGv0=;
        b=Uz9AVO4443P4oLlXspMc/S685K5lHSmBcw2emiiRkbSd9kx9inJYSU4RNF3XFn6dqF
         4HO1jKP4m9eq3OHNDYAyw2QnFzCZ3MKr5WIcqMo4+eYHeGj6Iy46TklkcVQ/yvsebXU0
         IWWgTNKgvTnOo7v/D6pIC8zt+d9OdIWuleJkwTo7OOgtg2uM7as5QoOcLh4IlgzV/2Zq
         R2jA8nqvRFXZYOfeGggCHXfRFmJktgcwd2J4tNI0nZo/NNrZ0AU5C3q9a/hVCN1k/JXD
         aXFfO/MeFFt3sCd1lVA3tLEME+nm0CwP3oaynssYyzFP3X7jmqVnPL7vLP/imtuU20wE
         8nNA==
X-Forwarded-Encrypted: i=1; AHgh+Rps2Qyg4lkQs1oMMEWHeXLzowka/sgOrI3HrbRC2oa3MdoIs+sLqxCyNFFf9Y4o6skNvnOMCfq90/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEy9xfjgXr0vaOKolNuq4pREQPHmD7NzNDXwchWbJgqkYUXvF
	aHbwQClb5u4cM/2wqOhaRTIvNeiYQ9i0SpBAXs+6LPKjHzuBcKirbaJjUprqlg==
X-Gm-Gg: AfdE7cnl3nWGXOOvEllDe8ce7/oqfE53BhZu/vOtz6zfs1tHqJPZuftRkMWji+tDGc1
	6GCf3146n87OzSnbDBfjI/cs5sDTKyKxxHS3Ou1DuaGLorx3FOHUxxlt2Q5vBUh98wMS30VimZT
	ctJnW6P6CpbRdRC2ttt5RmNsPuE1QHNTFmopkC8S77sRWv5LsUkidTFIXHwfX6YBQrDlo4+e2n5
	nUmGFOteTvqRnChJ2IzT0+YbTp8wCfNKwmWpJIvcmQDIa1bGSCesRkInYk0gZYD3id3m1hRhOwu
	G1iLWcAIt1mA9TF6tmSbeW0jW4IBigcV+LlOi/2XpMCt+CxQrwGSwSeZXEGoY2wv2BYZ7RKuan8
	ezZKxllDdJ/BfyRiz0nqBw47p9Oq5wl5xttUHloKRBwB0Tm9KhYP4HfQrp2Ruxuq/vMxMiS5Fq2
	Hwajs56/E9QKQe47uX3mgL0n9MG0yDN1c4+4so5A==
X-Received: by 2002:a17:902:e84a:b0:2c0:eee2:fc40 with SMTP id d9443c01a7336-2c725ba7171mr127473455ad.3.1782106224927;
        Sun, 21 Jun 2026 22:30:24 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:24 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 10:59:58 +0530
Subject: [PATCH v2 2/8] iio: orientation: hid-sensor-incl-3d: Avoid race
 between callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-2-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Archana Patni <archana.patni@linux.intel.com>, 
 Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 srinivas pandruvada <srinivas.pandruvada@intel.com>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The driver currently exposes the IIO device to userspace before
completing sensor hub callback registration, and similarly removes
callbacks while the device can still be accessed during teardown.

This creates a timing window where userspace may enable the buffer
before callbacks are available. In such cases:
- samples can be dropped,
- buffered reads may observe stale or no data.

Reorder probe and remove paths to ensure callbacks are active before
device exposure and are removed after device is no longer accessible.

This avoids a race window leading to data loss.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index c7fbff498be7..5696e4ef3633 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -356,12 +356,6 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	incl_state->callbacks.send_event = incl_3d_proc_event;
 	incl_state->callbacks.capture_sample = incl_3d_capture_sample;
 	incl_state->callbacks.pdev = pdev;
@@ -370,13 +364,19 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 					&incl_state->callbacks);
 	if (ret) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		goto error_iio_unreg;
+		goto error_remove_trigger;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device register failed\n");
+		goto error_remove_callback;
 	}
 
 	return 0;
 
-error_iio_unreg:
-	iio_device_unregister(indio_dev);
+error_remove_callback:
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
 	return ret;
@@ -389,8 +389,8 @@ static void hid_incl_3d_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct incl_3d_state *incl_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
 	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
 }
 

-- 
2.34.1

