Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C32D0C89
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106245; cv=none; b=SG273c5z6AL3Toiqcf8/nZH620jNPM4iOSR/R6gr7Epd09ERFcnXQ182IC9MYL7YOOSNhArURmJUjsIt7Luj3GS9PKTd64QhHWDT23QshBy2FG3fVJWsxl9VOundTMvfGMR/DGbh99iDZQxUcm9Xl7kOW42/utQYD5yCFbRBv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106245; c=relaxed/simple;
	bh=NdRzCGsmD2gA9WT/hiU6asZ/sU2daMgn0fUIABhbW/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJ6/C1WgUcKcyzfaNzNf2jTbVKaFNmzVtbikV9F1tUNORuLaDnRvNA2Zv8B1SSRgRoYKgDYbcci1vwkbS0kWEbhrxiK1fA5jACk8qRujYFLs+EDZ+yHlP3PMN0KinRP4n+w05PPzbGeEe+0JUQ4IG2k0yfJBmmIgN5+jELkNaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBOWfvEc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBOWfvEc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so14767175ad.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106243; x=1782711043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXIfNj+td1g2UGFAa2Fx1dBFxQFwQ+k/ADjSsFv/Ulg=;
        b=OBOWfvEcPDcNqDTExmAqqTeJDwySxuspJ1vYgIxwM5WuQncaNIcHMbMtF7EcDlY3F2
         I2O9oguDW5OJBJy6lOH2IHZAP4+Dh1SRcK4l+DJYfQEzZZ+zWc0y7Ocvt841lbGgLJGn
         4VumPTCjSDE/CB16zVlYMauz7m13grT5UXPJshCIDtELikHROnyyhGVBmgal2Nx7iPyI
         6GSIPlC9u7qOK9ogF8f+jDUm8XdpZDStzuzh+R6fXPOOY1hIrT9EnPz/YgcvuMet/9JV
         TL+3NNzwuP9EtbOZMchMQRZTjVkky5UmK42BtKtgptcAhdhnB49R1Ns+mPIEPfgXcP4F
         NisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106243; x=1782711043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wXIfNj+td1g2UGFAa2Fx1dBFxQFwQ+k/ADjSsFv/Ulg=;
        b=CbiD/pcwlesQiQnFt6zAs3BWfXj5rT8XtOG1ZyMloo9q/I8jUEx7pgvSrSGz98szp/
         46M7uqQoc0/hUHsRUKEueM6Qn+DRtvHjI609EDDNFhyRBEWVdPzX6n7PILjdZLqeNuwo
         EvK8K2/k/zXZ5aEQksiADpslM5WB+v+qolZKud6hQDOoqqczeLNPQmv5tlI59IHweG6Y
         ncjdPPgCTGMOYaCX8w3XG6WGbgduwsROt5PgGhxl2uQGtXyoh3fL6Jkx53DhhO+A8u0l
         ThtvCfshtzYrRLtBGUsVjYhGUPfWOjSIOfh6x87RWgfIfUNOX+Kv2pq/UEzIHzNdyf4K
         iorg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2aaQqZeiAXF1kXdXtLzhQQLOFr88W5yP8cb3dBDBFLBGsW/1XOknWFy7yoqlLFjDD9353GZH9zhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRJLtshG/ArNEQO+ynN9HmUgpg2g76qwPphU6PVeoKuiFE/Zp
	LkB4VP3QvbmHs/5R0RymTxir7C9DXhNZZtgh9uMP89QOfAfTKtBzAYx/qF5vaw==
X-Gm-Gg: AfdE7clAgz2wS4pDoJj4bGeylcItmLU93txWYXzIt2zqEL+vWanGZuAimntgyYm+oD7
	ZmCApbVAWNBIRoi6K40qJxmLOi1sGt3DxGTPHHVgNzNOV/QeRgKpGM4wHLTpZ2nIB/IDWikOfhV
	XWKuCDe3oGNSr9h6VUeB+OZRjweMDclyuXpyS9Ji97KA+2q0n7sEnyT7Gm4w2B4txWA5lN6AZ+j
	B6eu0sRA+rlqypW0pUB6wRKmxrWqYKL16qY45JEjbAalIEVqMKZMczs9dLYu+9VWvYyeGGqVGy+
	K3hENVhwFkrcYArWPF39jYkzxbo/4Ubrmthgi1O2+kJJV7PDCh5FsnKtRLuA0KhxdSpzoSBY+x0
	B7EzQCZFdZU9mjx1fL3pdozJjKN96Gh4n3Jr5ZK7VGcHBUJd6Rr+Y13ZD+2bZAWsuTrlxE0Nao1
	OcBX13wuXCZI2QaGttB1dldhs7wEMr4DuP+O2lhQ==
X-Received: by 2002:a17:903:906:b0:2be:3434:4e28 with SMTP id d9443c01a7336-2c742b1ce87mr85206335ad.19.1782106243367;
        Sun, 21 Jun 2026 22:30:43 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:43 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:02 +0530
Subject: [PATCH v2 6/8] iio: light: hid-sensor-als: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-6-1cfabcd1881e@gmail.com>
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
 drivers/iio/light/hid-sensor-als.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index ae2fda8dc500..823bb56b9873 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -406,25 +406,25 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	als_state->callbacks.send_event = als_proc_event;
 	als_state->callbacks.capture_sample = als_capture_sample;
 	als_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->callbacks);
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
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
 	return ret;
@@ -437,8 +437,8 @@ static void hid_als_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct als_state *als_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
 }
 

-- 
2.34.1

