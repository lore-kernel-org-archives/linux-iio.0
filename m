Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73D35AC34
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106222; cv=none; b=sbDL/ZTqSnHcQknHiHjsZraYXk6g8Ibg0rZCiaDCu2Gz/TXsCvxzHwInfzGcbz0BgAqcJwhQpRVpLYToyPciINDtym4vmAMlxRVrZENuX3tQeFn1+cTI6YBOSV9YjrFbhaYBhKMEygUB7YTNitwzEXa6ywbUE8pWwcynY3+92N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106222; c=relaxed/simple;
	bh=ld/DcKmZo64YuVRlRKEx+gQgYH9N97OfbIW65kvt380=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbCFRMxCFvqV9PRGJu28AJo2jFCt/LtYAzHPrtQt58+3sLR0O6jQubPm0ApcXEH3GCyUwPzM8rCfYqsZ2YBjTvH1eFc0ETGtACaNAvOkk2PRDSbIndnqpt/4aCpwDT6l1ZOnCH9BtE4CcVTgCR8qNRULA4jPuy6LyOGHqwbRCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8d+1PQ0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8d+1PQ0"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37cae9b7536so2252762a91.3
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106220; x=1782711020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxY4qpIdyAKznOWTpDO1hErhVIzCBpni+I5exEf2UL4=;
        b=j8d+1PQ0tXhcUsTxHNqCKMTEpeXKEbwDVihVUrqE7oXoVLSaoyt4s0hl8131PnW2Cl
         Yhx4zJnQR3oqw7riVcdE/uT0H/vu7iJVkQtkJnr4ecTGA1ZDL8YuXFGomLZup5fnO9/f
         RE3U2FOmclVI8hTIDVF/4FSz9R5YgFAIE4Ubcq3VNKJ34RigbfgVY5t5XiIZMsxzj23Q
         4VmFhxoXdNqpMOOl/Rgf8zvAb9JVgTTv8pGQmz4Pf2KEXwEP+C2e2nZfgC2hmfa1AXFr
         6gD8U3ChBSgH545oz6W7Cv4yvlg/2bqjCiJmqYtPrt2Ll1vdNdzCGSlxiBibzt9cI90x
         wo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106220; x=1782711020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zxY4qpIdyAKznOWTpDO1hErhVIzCBpni+I5exEf2UL4=;
        b=gHhKVx5W1TeV8e0P3uZDKVrl8GYM4C0GFVKZXEQ5kk4F5+YRTX7qjVTPxhxSpSrtTb
         imMKMKnOWW9R6/6x3pDxVeIFxfOOv3Vex1XnantS2d3+agbo1crL1jKl/SRL8mFbQpUo
         djPiZZkHQMu6fV/qIrBcyaNGyCsD8+VytSw4LAExhMC6bZsQfZQIQyWRhZxxmQvTt0p6
         orVzAWykaEcPCxa+laEz22Da1ycZVXrhbsi5VCryqdy49eDNwS1/j2hHN4czb6TZb8zK
         /49zUaW/N7HwQm4v8ZLUSx9wTbcaAgKeA02iZNXIuUldbNZkVRRjSByc0RiXyyfBVZ6z
         Gfow==
X-Forwarded-Encrypted: i=1; AHgh+RoPVa/pcg05Kx8sp9A8AV4ci2UGMh/4/jBax56pMqZnt0dQDu/amUnWbK9gxKeBfdQAcZrLyi7PkJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNrFCZaL1Onj21daniPn9pv7o5oQI58vOvc+JFjVhOvKf3mdZu
	cXtAfJ+JlRcXtZU3buMwk1e1uq0FU6SYgK/9Qjo6+aaHf06HXaXlLG2B/X/Caw==
X-Gm-Gg: AfdE7ckFWIwL0N5HNfaCK6LIyRRpNzKJ0sIzuymG8JbNr+g7JV1IOi5W5qM7CSdyN26
	rFzdgDpmxSZfWJHyToz2oTgeIPvEupcTcQQxA//Y9Vx4IS/qnVr23qXsfxh0/GaAj+iOyuzYhlh
	v/Q5c6dNJ/WAc3JQvCWJTrX4aDJKBgHtLhn3OXzq0A0H781j4O/WBWphyvwVyN5PRzGUs9wnGv6
	sGA9LhKu7fUT69eLcpyMexrypg8kqUyzWyLz1MzydCUt9QarsNY7ENbeDV61fbU91aBcVixUI5q
	fTG46H/biMU5tXxUmpaWdP6cfWFGasCrN8ps2BDJQjzLXEj8lBx/8+xmC0REu5eTfe3fwIH5Gak
	AXsEZADaUTpxBsZMxyyvwjW82TXTIe8VvYOPMhrrKGWPseCPSIOORPVfI6bqbWhZfOJ3XQFBAnv
	ESiRdaZQeFxiFBOOw5OTjlOv0mbo/nNysc4omimg==
X-Received: by 2002:a17:902:db0a:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2c718f1f04fmr128770145ad.7.1782106220296;
        Sun, 21 Jun 2026 22:30:20 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:19 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 10:59:57 +0530
Subject: [PATCH v2 1/8] iio: orientation: hid-sensor-rotation: Avoid race
 between callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-1-1cfabcd1881e@gmail.com>
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
 drivers/iio/orientation/hid-sensor-rotation.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 20563d8efaf6..6773bb0ec204 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -332,12 +332,6 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	rot_state->callbacks.send_event = dev_rot_proc_event;
 	rot_state->callbacks.capture_sample = dev_rot_capture_sample;
 	rot_state->callbacks.pdev = pdev;
@@ -345,13 +339,19 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 					&rot_state->callbacks);
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
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
 	return ret;
@@ -364,8 +364,8 @@ static void hid_dev_rot_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct dev_rot_state *rot_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
 }
 

-- 
2.34.1

