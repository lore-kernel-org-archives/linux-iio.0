Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0860357D14
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106242; cv=none; b=XM047K802rv++ynCbBcir1U6nmtM4PHw8TUr8SQEq0VsKmjZ9HX1ktGjehe6KhYuGr9V3vJHzQs+v/QZtv90khobCN4hh8D8of0jPPlqSJxD7TR15gOxgbM8Pv3p5RtkhPbASPT42Bx12F9Mly3x+IJEy/ALCMz093i/voW4zLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106242; c=relaxed/simple;
	bh=bry/qy/huZgB5q2NICIwly/7N/mAm2guehNuSSyVzic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAWPnPAWvGJoKkq85NCpMXtHwb1Qwgq5gutTVYSD6WUu5zgv+Mnv7XdiQJZwW4msQrfBJTySHKjGALGJMzxFWc2PFaAYuF9iY9dmNi8RV/MSzM/cFDxfl6uek64XzSNsl8setUo3wgvYYnYjCoH6kQa4rdLRggTImeql4jZOm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJp9OGX9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJp9OGX9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c40397e746so22960365ad.3
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106239; x=1782711039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3OxBcRPfrQUdQw9nRWbA+0f4GedPZWKH0C4Q4v6P3M=;
        b=NJp9OGX99Jo76g5HTuJ12UY/F78WBdqE5Z+gPIzQKZKnzF0m29WHjuROUmxoZZmi4U
         Mquu6XDHe98/H8FajZ/KdKlC+N4DXQaODvrmoI+adKI2jzAH9Clv8kZacUWXX76rudy2
         qkszMDTu+ymiaBL6St1OxXCRpw8amk3oW7/SeLQFE3PvmcmEzEFnKCLgrIfryLWLeHll
         cYULTiIAIgT0c6KA1D1bK1n3WDevsWvICl7XuWysctzGLAAJSZxAGywY0CU8H0lcFyia
         Jpv6AeYFeVMDCBls8+j+heQrc5pa07zcqJUAwhdoB8+CN/RVk5gJMleL7XpudJ/ccNnU
         22pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106239; x=1782711039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j3OxBcRPfrQUdQw9nRWbA+0f4GedPZWKH0C4Q4v6P3M=;
        b=VumTfmVfdSTY8jyQBUsOlNqT5VdPnoyzNVbqHvJZLnDDSNB3OrJmT9dHsPegAGUYaK
         d1HDAX40caSnSdIXv7tafk9DdYw0xg4vLOP1OM14wuO9pQW1er1g5SaLODcoeOr88m+l
         Ey2aie+Dn5KI72rd7LwLARX3IU4GA9h9FbjpoOj1Hkg1ZT/a/9CGm2O7ZK6/XvIv4qho
         6zurtCwwl0svT5uWwpYSqke/zi9s1yI+XZiYd7gOgG1f12QMp13QMZvxdSmlxrSbDYIX
         CJPSM3zEOUR9Et5oBahk2lqa0FpcemyQ/9nSJtPAilbTpQSdJNHEw2HPne8aS25RZh0m
         i0dg==
X-Forwarded-Encrypted: i=1; AHgh+RpCoQxRVmCwSM1PW6o2kKIfj2gHrrzkl//ooFZaIk+CU2u99tyYnjKGBPC2TZu3oipLg6W2C+ZuRDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBfutFzLWsYPVTSyDZOUrGJfaSErOUVqqwAMBy5TVCfe1XcNm
	tT5zpEY3931A5b1HobBMTWgQuw6Uo4R0hc6rFGIiC7eoTvf903xZKa0+433mBw==
X-Gm-Gg: AfdE7cnyMYdolvsWLhNzt03Szd3TXKAk9Efsv0xoGGhe8O3jI+oDr7WAuC615uCLf0e
	6SpoKvk0PY07LXwruCe3cCTYRB3hEZuQZsMMI2Ddkf3VRL6iLu3E9GpNen34qsYAYUAQM3DfGeb
	dNaqypfraZj89ICjk7yswqBZTctVpm3izSdnzUqEzZ/y0vy+sWGvKk6pbk5Xplhd2fRG9oYT12M
	DgxB23U8bjgGLsO6G+RX49PpbExrb+CLaYRJ2qExzjQLp5OB68Vut2FHOY+gykGawf3T9/Hp7Kc
	FrqZKCC00d5T0hv4fMxH5SgvwPh6kPuEdsEtu2DO9dvTb8HOIg5WdjdDXwUyS27l30mhp7hDdUU
	nMX05jjTojvxD9dIlI7PcWQEwyry1JBicrZycmSJOmDp9LvtsBpDvxFFA0uGj4HJHoTnMACaFUv
	3gNDiFhRI1z+ODxJZq8ACYpzIimbXc8Op1fDgd/Q==
X-Received: by 2002:a17:903:2c47:b0:2bf:128d:f7ff with SMTP id d9443c01a7336-2c7426f1797mr96126445ad.16.1782106238887;
        Sun, 21 Jun 2026 22:30:38 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:38 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:01 +0530
Subject: [PATCH v2 5/8] iio: light: hid-sensor-prox: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-5-1cfabcd1881e@gmail.com>
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
 drivers/iio/light/hid-sensor-prox.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 9059f00f0ced..11609dc4c5dc 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -312,12 +312,6 @@ static int hid_prox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	prox_state->callbacks.send_event = prox_proc_event;
 	prox_state->callbacks.capture_sample = prox_capture_sample;
 	prox_state->callbacks.pdev = pdev;
@@ -325,13 +319,19 @@ static int hid_prox_probe(struct platform_device *pdev)
 					   &prox_state->callbacks);
 	if (ret < 0) {
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
 
 	return ret;
 
-error_iio_unreg:
-	iio_device_unregister(indio_dev);
+error_remove_callback:
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
 	return ret;
@@ -344,8 +344,8 @@ static void hid_prox_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct prox_state *prox_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
 }
 

-- 
2.34.1

