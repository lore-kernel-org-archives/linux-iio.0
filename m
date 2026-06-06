Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E031355D
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745886; cv=none; b=Wxy4SnjV2u6wcRPF6Lnf0jfJ+JECSxFsKQ2CnhzAo7HUM+gqDJ8oclI6S3k6J7FNTJl08dOUjYzISGLk8TrL1jnytmtXb0SIi95rTqO+ddMIshTxtxi4Ds4u89+x7PNTVLDGbX8mimqyBN1IGwGOwR+7/m0cAVtQbZM1ovLtNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745886; c=relaxed/simple;
	bh=IkWYpyaCbZKJ8ituXTGqG8rSXM7Oed0FmrF0L/Ijgbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmUQzgxrMRqIP0s8FzDGf2rD6I1r0JLd9RMluzVol8WhXPJscu3dY+BhxFB4dtIVBCigLzRNXg4/og5Am6GxSMbEqdqboC7TgdlcCKRlFFAgzBWyNFA+VYRMEqYjq84xXxUCb0gk3IirNPu2nHBOloOKyLTw+8VlLHDZbv1q/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOUxh4va; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOUxh4va"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-372b4330deeso17308a91.0
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745885; x=1781350685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4M28aP4OxLMO+MfHO2nNoeotU1DoAdjAzATXUUow/k=;
        b=fOUxh4vaRvea0upDM2Tg+bqtSY6QqJQg7sBBmXOIEkL4ykI6HjEybyaisHb3OnaRhX
         /sY2LS3Yzk1WX5edKlzdRRclACPJCTelTSmIW8Z0vCijP/tKvZfQxcqRo1xSz5qWjGwj
         5eV3oyAneP/KMz//I47U20uQmi/p5UbtEIIeQq8mnTwce0xh9pAIJKMq7YaMdAseSS/O
         qvNgBLtfZ1RjxcYKiCP+doNqkHSJbTa4FHaxvDSuegjiMLAZAaAGMh4euliXnAOOE0Rg
         LjQRAiYNaQPEAFGM4MnEFJdAtQviU5PhCsg5jX/rD5ZGd3WFJ/G9uOC8oGY6TqSNGFPB
         ccww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745885; x=1781350685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x4M28aP4OxLMO+MfHO2nNoeotU1DoAdjAzATXUUow/k=;
        b=clSIJJKe+reTh49UQazOatffXpkCRDe85P9/Pg6g1M8s4NxLCtn3OIo7P2tHKuC+8H
         2L2nLTB8pAury3dYzybEh0SD1pJpEyqMQk96GzD6vnrmXGY4ALg8W8TB2lx3/IMxUJ9P
         OXX2eq3To2R/DnZMCg8w8UMhYJwhJQkaM73kOghJg/tNjhZjYPfWycZ3DjMSEtFV6qAR
         5/7jTn6HrqX70TbevWky9ZTrKSQk0TYS2b08+H2rlPspgWgXo8B0a4PZf4tbfwLXel5h
         vlZz6iWDghkpdWx9/HyYn7f0/OZv2oe3g1zuI6fPLnptH3QbWkUZ9LNWeYOb7nrsUENz
         k9Yg==
X-Forwarded-Encrypted: i=1; AFNElJ9otRNjx7LuVEqKkqJwY6otJP1dDspobOZNKBtLruomuGKhFV65lPl0XMqhhE4ODcX0LuihgQg9uMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCHclRHQTes5wcdlbP7eDyS7zhiO45p+b4MpMU3qbo+BhU29H
	ts276DokWMH7uUaR00RdFChpOP1EvDsKraRjhujfUGmtQX0Lh/w/D71D
X-Gm-Gg: Acq92OEwUrJ5l5tI/Qhu7/zsxBW60rSTOrbWBhWv0ECCs+0tB8NSljtdc0t4OAa0J0I
	sEHE5KCe2ZXeU019ySmSYaoTXmTxtHglvpDCIGzE/Rde0IAEfiR37vlXI4P5kue1luu3c7AN5fe
	oB/Nz9oJSOZgj33afUT/I9ol/q2PLwzez97JEpNIvyqwQXq1kWMLFckzCHyTdKfqlm3x9tsTOyi
	t1Wu+5LcqolD/7hOkWsFfzojo1144mdLJ9FSqOz1wmrQHJX43XsH+4MFRrfynq4A1HKz5fz4wNo
	25tdbkArsQF57cT6VGmjwy66wyhcyjknYJxJveEpIbuY5cS2vcc+LTPAu+2u6dtzg3dXti2vuD4
	PV+gzlp20V1KxLhbmPErzcNlMJU3iq1z5CtRJQVf51/vxH27MuNIwk23t2QwfqUpOaeiNzR9aA7
	MlgfZie5dazf5Oly3tfH/tEsBJh7KHO7Ldz0x5XU9Cqu4aXgTYuTQC+te9WPc=
X-Received: by 2002:a17:90b:4fd0:b0:36d:66d4:270e with SMTP id 98e67ed59e1d1-370ee5450e3mr9765084a91.5.1780745884886;
        Sat, 06 Jun 2026 04:38:04 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:38:04 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:15 +0530
Subject: [PATCH 6/9] iio: light: hid-sensor-prox: Fix race between callback
 registration and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-6-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
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

The driver registers the IIO device before completing sensor hub
callback registration and unregisters callbacks while the IIO device
is still exposed during teardown.

This creates race windows in both probe and remove paths, which can
lead to NULL pointer dereferences or use-after-free.

Fix this by correct ordering of callback registration and
IIO device registration in probe and remove paths.

Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index edc9274a2c07..3df7f28d3b44 100644
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

