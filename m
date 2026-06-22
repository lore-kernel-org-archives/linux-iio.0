Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8593352C4F
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106250; cv=none; b=Z8c+0R/KUY4n24KcflqvIlgFlhAfgsEsaQnIbQeuztCIC8I7Ne3Rvwi7OFyOxntybqsffslruaWKkDWnz0jg3o3/uSgK3PIECYxLWy8Yoc1x04fcpNxT8369xhFgoFIeV9AkeuAiOWmicObxOiWJMOYzUvI6bBcTKdyPmDebAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106250; c=relaxed/simple;
	bh=QGvsaucVFIq+xHwax4bTuaj6Aom0zgs9eEWQ8ibyPI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G50j65izPPYEGExPDvsvbP/fgJLmWt7AijePppGm9Pm12xQqySyfAarfc3jD2obkIGZwRc36a0ZzSj9cXDWk0CNfpytws2GnxZGR6kKly53aWx79l9oWoO/UFVkq4FpkJj+R9qZ6wI/cMNlxCQdpAKeLB1C3JqQPBmjURh7pJtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMW5blz0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMW5blz0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6d31bfc70so25061005ad.3
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106248; x=1782711048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffTnpdEoTSHY7O4F9+RQTZoyKdhcNy9gFtLZp56SK4I=;
        b=eMW5blz0y+fxTlmETWuGrMXVdplJ1DU81A67x1nh3dodqD8+UihigH/e6L0HpAbYXO
         MolzWgM8wytIuaDgrlvgT/7UKeIXN96A8yo/1kfnH/UmQqvh5UvskAsgbq9dVf1LYNrA
         TgG3av9BI+pRX8eKkBDIyBf7omre8Vpi3vcLjclCczV4XhQhaNd9YVTAl0tv7QOU49KU
         sCmYq9V2a7CBiMAAh870Q8LGNxywjascaDvZZbQqkBRow9ztAvfJ7DiyCWss+a+q78P5
         HQi0/DIbSY6IoQMbsPFl3+21LkOTSqDDnlEHCaR408hfTrxRZhF0DZMXWl9uo1AnkA/7
         p01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106248; x=1782711048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffTnpdEoTSHY7O4F9+RQTZoyKdhcNy9gFtLZp56SK4I=;
        b=IlPSP4kBhewgcmxy2/yfQPVXAIEnO5D5m4Z1JyBvsYWt46fgutGG+LC0gP+IrxEnW8
         9OHoLST6CFK48lMsMtm2hxW8HEWPEm/KZDd+Ku3sgre3fl5KJfN6GoxKv9DFZ/KJeIOV
         zaOu/hJbbV5aeJDHXyh+RLgkEmA6OI2JVYxtosYfdJAX2lXFHXmJrQ9reD01HCjg+pIG
         Y0y8EXMbO4sKnka9CWST+Y7QrY9HQH+Y2a4XNbqqYNIKjfX1tXlGyk4e3aHKqDx5hWer
         /AM2+fDHXMl/jMkGZACLhC9X3EQwqd63D/hu0r/N4anqL/2PePKHP2SIYMIfF5PxMLrN
         l2Hg==
X-Forwarded-Encrypted: i=1; AHgh+Roa52mfSqI0osapgodMl4NDuS8S2Rzk2vBOgmwVeyOh9bKiUpLQrPoo1jneRitnoKoRBn0+MarJoo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZn5YCh9+W+0JSqT/JuJ944xpsADY2DL9pWaHOuJUtLwtJyYB
	fMooxUNye5+YkuzOexVwjwypZpRJjbp8/TMbHXyaaNtOSiP3Jye2WBdVj5lohw==
X-Gm-Gg: AfdE7cn1cZvk9Zq4PK+duvGcL1hPx5rZdl6GRKz7IAmYK42elmhTJir4KuQbHE2ur5r
	mkcMdhfFTLJGz6voCTlt4F7D5oDvOgpFOv0s9sWeiusc+R2aTJkSos5VW7KKB08Fv48N/bUaRK6
	NdeN8aijPwsOsb/jvAGUo3sJ7qHTr537amBRRE7+4dMqtwEcvQjq155EfLhFqxgT5EVUTkbRcm9
	M+4dxqnyxuV/Xp87gl55BYnMKgtPnGy4ny9iZFaUn34cB1/qvGLF7lhvqwWYB/BXkyWg8WkDqgy
	SAV8AqdloPcfJyL7N4gAvMaArLNnvGioA0ZtzWqQjM4lzLAaKev64A4XaKk6GWCaA+uZfHYySAL
	p68Dsx7Y1p1yJnH270Go5Hust2nwTeKz8W4DhD34fkOcnqR2WP7xNPjDScvV33MiuySn2kVQuVP
	o0TGZQrlJnLiLTmLWM359dVfsvBbRLhu1v+r6vMA==
X-Received: by 2002:a17:902:ce8b:b0:2c6:d5da:838d with SMTP id d9443c01a7336-2c725dd032dmr136745235ad.33.1782106248133;
        Sun, 21 Jun 2026 22:30:48 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:47 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:03 +0530
Subject: [PATCH v2 7/8] iio: magnetometer: hid-sensor-magn-3d: Avoid race
 between callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-7-1cfabcd1881e@gmail.com>
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
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 23884825eb00..acae77273bd5 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -513,12 +513,6 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	magn_state->callbacks.send_event = magn_3d_proc_event;
 	magn_state->callbacks.capture_sample = magn_3d_capture_sample;
 	magn_state->callbacks.pdev = pdev;
@@ -526,13 +520,19 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 					&magn_state->callbacks);
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
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
 	return ret;
@@ -545,8 +545,8 @@ static void hid_magn_3d_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
 }
 

-- 
2.34.1

