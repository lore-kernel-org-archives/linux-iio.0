Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1C2D0C89
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106254; cv=none; b=C9W1T3ebdJc+lKzRTWbvslvuSJKjJyCXjac8c304xg5FzCrl2Yhrpemy6IUSxW4uX+h25CfXewevf7yK3dY/i2AT6BbKVolr7sLdrfA2qPajknH38MH2nrl7EtNFW/MtVWzoax7M7duyDzdnAr719KVKXf40KVYSveHddNTuhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106254; c=relaxed/simple;
	bh=VFGoiXGki0bhoIsViuQH4DkrJinlVWY3FP89NJlAakg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQZm1HG+cv/kJXP4TUXXcj/g0uyb8g4WFdhRXPaTilPMy0elfwjBE299fpH9C9j5nnpGQPuuJzKR/Ry5R/1QQWN6Mlf542qCteEs+Dp4Ag73RJJEQitPlXIpJ6xpLPFHPIZCfjMMP1t/M4k9CdM7x6m53X/3xnNWnDNOF0hgtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiMQFWn8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiMQFWn8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cae11ba85so2889281a91.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106252; x=1782711052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tVcLshRPaZRd65d/wCo/MveF/lKliRRr0tnZ1bcPS8=;
        b=UiMQFWn8QDWvt8EE+kE+ZMqvQSsVQBqiktFm3YoTdQgrFzyufU/T0qItVgbTKIYAp2
         noKifoi4XnCMUGjfii8sF20OVQr2HpmaYN6BV27I8Hp3dKm4P4+rYEXwyHe1f6uqGk4A
         XwwS9qUEW1AjNqaubr+FNq0R/ko8pGodrk53GZ/QIqF+3aqjjIVwmFtzRU2MIfof1Aep
         oT0oYaHI1/B+E2QXzetpH68MyMEJwlE+4lgZQlrFcn72EcqyuwudFTpjq99t0ipJDaHF
         jy5Dyf7sLc/PUdN3L6H1FfFvXpGE9UsXno99UxzjRUoe/BO590UwQk1xjVHTfpQtTxfk
         WEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106252; x=1782711052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tVcLshRPaZRd65d/wCo/MveF/lKliRRr0tnZ1bcPS8=;
        b=st8L75ct8/nnpMd2uVSEqXtZKYU+qJUgfhq4AGaMzAyXDX5LBzIwBujbfqNt8UZ1Bq
         tnft64f0hHH1LmYXZyMt7lhrAlqnmJrK3NnmnvzQD4/6GsuoGxAARkP8qhvy9nYY9hHz
         lt7b+7TLFnuBQtHwlObfJnHY4gn3tTQpb5SlgGKMbq9C8ml+ffHmSCZak1lBbD+7xnqW
         nFW+LQ2Ymu709I2vPtrcGNgJBxImQqnZvK6XZu95dC53ELA/u3/CKwrCGze7wYDqBtfV
         yZe4OQKtEJVGk/j1vGvpE6saLvovTJPHF6onAdEuU+oBW56wXLCC0mYdV0mZ/l+aogWQ
         HmpA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1YHyCr3VMEq5bCH0uMVDLsoKfaXAwsWuighcGM4yI1xTLnSTZZLLyoIGK4U+sWLwKv5DmpXzes2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmqW2RLvQ3MGUfAvOAFMhkgjtTlzS2OlPICD/w3HqXHJNwPTi
	befQAjuOC4E0JwLMVoe9yLwObpKjHcyPbar99P/eNPhjKMV8tVPNoPHW65p7bg==
X-Gm-Gg: AfdE7cmJp/RlLe17V0pGsqO4a0WRKTWQ/qRTNzhoHI4qqBp3pqsYoAR4TevAjT5vS5P
	G4MyonH/ClttTw4o4k2ktAAV6tPHzPgdMXOfrMP0ty1FeEOaD6McXuv8NQ4GVVh2a2GxMZad763
	C8j+8VWzgS+MuFb0WdbXAZ9n0bAl01eLSIBDiFeR2nS4wFTxW6KvxvkPD5VQ4x8sRCewI8nBd6A
	tPD8sQS2xS5r2uc1AgcYebbnn4YSn6s2cMo1vMQlx05eUIA6RtB4BbDD+COXgv5N8iIxSGE9BpW
	A21dSnokIsraaaIR+1mtPtupbpiRmEpebcD+D3nXKJxy8/f846NKzIL8NJWt7wgXjKijQOcsJJR
	u1By+DLHcg/e0Y0FYQZU2aKifxuSUgYGNoKuro1XWz4zunwmXpmR4ZoYZUyYKYtlRFnTB6V5ieX
	PItUR1zE/9g+0WIIGRCC/xAUFTP9zLPfSNx/xxqw==
X-Received: by 2002:a17:903:3c4e:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c718f95888mr131872655ad.30.1782106252614;
        Sun, 21 Jun 2026 22:30:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:52 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:04 +0530
Subject: [PATCH v2 8/8] iio: accel: hid-sensor-accel-3d: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-8-1cfabcd1881e@gmail.com>
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
 drivers/iio/accel/hid-sensor-accel-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 42c4259bf209..12481cfe9800 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -386,12 +386,6 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	accel_state->callbacks.send_event = accel_3d_proc_event;
 	accel_state->callbacks.capture_sample = accel_3d_capture_sample;
 	accel_state->callbacks.pdev = pdev;
@@ -399,13 +393,19 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 					&accel_state->callbacks);
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
 	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
 	return ret;
@@ -418,8 +418,8 @@ static void hid_accel_3d_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct accel_3d_state *accel_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
 }
 

-- 
2.34.1

