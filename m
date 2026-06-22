Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAB352024
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106236; cv=none; b=lkM7+fbCZhsndeLqs6dN9t9X8XFOXqug8iTmZ6ugvyDYMEkGeWk/8V86GqkQP9cx4dz176LpzknZGpqN5bm4pF1jGKH4XWbhHl44OWf2kUkgvMLfhZLFVZgqtN4FtSS54zZF1la/90NCFTHAnyIe34prAmS56JbqNTdXeVtoVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106236; c=relaxed/simple;
	bh=KPGsAc0xHkCSffaHYbNkB0P2MrqYG3ZskIcF9usyp04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okCggFDJcW8TNOyQ61LBQaQrgsJheAr1Ej5+KdBqzJiFgBk71DBeDpVhv255rUp/iId2p7yVvnxFj1Ql/Y9vAbK1hHWmqcrU3zfkwATBWMzpBNAQpVbpUdSlXgf9KKpK4TbXDW5MPOnSa1SyYugtx7iTMuRalIeCClEa/OhfNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGqkFYBy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGqkFYBy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so28339895ad.2
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106234; x=1782711034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2/mdmwgKQOPCBV5u2PomuE4r/P33TYPyI5ZUv87qNA=;
        b=VGqkFYByRbwOQtwccIaG/GHtHCxLXtDkS6PimPRZZcPokOZGM4+xr6RZJR91t+T2rb
         CyoiO08se2YAjM5AH6y89nR3YEANAJYUJER1Gbd1O3SKH4z3e/fSKN7fR9Haz4nlR4XO
         S5zxiHbXdATVdY6ZJloowDOt3oiwGS3FynYqFyiYoqoArYJkwpdWKwrBDbyo6+zv7yxz
         IMDMxK3AmNnEI1H1F8KELUZImj1Vr2lbQWjFIAjFtXh5V/9heRb0sdaOrL6HasMcpXjG
         K/wyYH7RrVzdjXygN3Vl1DYmx1lIVGGXcz3dmfRwE3btStsYgsIG3A3UXjmfCBCzRgWH
         Cn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106234; x=1782711034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w2/mdmwgKQOPCBV5u2PomuE4r/P33TYPyI5ZUv87qNA=;
        b=GzXqI70TV+l3+NABx/bo3zuwJ9SctAmgEPFCtLoxgj1yrhN5RYwtWMTp0Yu393uTwq
         xrjrzBLkF/23t2uHKjNuqBIpQKlzYEV3Obl1bN4STQSTjWqhpkxX1sDAZn96v2q3dFYp
         r22t5Qp636+nM5pZXs7ZknPmp4iX1R0+whcbxg53VrxlXyObCZRyYHJ3Gwa0ByXOeckF
         DCbXGbv3J8Ck63IdIDs2EJXpwvoGVUUk6RlRgenl/M+KOMalLnDMxCaSowRqUjHYSReX
         0aJCm3wuc1UEW/hTUitgdIqapTAAArw6IAhLS5GRkaiyH+1yuUSf5Z75TdU6NFagQo95
         bUuw==
X-Forwarded-Encrypted: i=1; AHgh+Rom3kKpCzd1uqDhNF/S5PV30fA2QamdWHOa3Yca8lxQQI/Ug1xa/PD82ZX+ttMaSB3izPJBqtPaOLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsk77Te4Tn+RVU9tMMxe7S6AD32biAsqLsCZbHFyjyJiRxpeWU
	Cw5qek4VK/AtFnq9vF7BAFfRiTBQKrP+MPZzhcBc39y2RqwNe2KlOnibNk4quQ==
X-Gm-Gg: AfdE7ckOOfXNdpMhJI9wkWDiO1ZowvPNW/voKPq7C/ifsoDD3tvUHXTNfJQ7A2ALOpn
	uwH8D/hNNVICx+/egsJDqp88V34Opg9aQsC+p9/z0c4VSt1VV/MJIrgCnuBaQ59PFV9imCg1a9w
	Xy3MTeZikbB5XwCSKZieH4onb8sThYth8gh0g5yZajCpUlj3FM4qrgq8WPZT5VWSqTrkzrhjgop
	L7jntKll7i4XlB2lW/OrWQX5nDItpWMeMWu5Du6+8lXh5ABi2M0AMPZ+ZNYnWeffs+DKtKXBIyf
	lXakGK8LtH5sfwCXJEm4TfMwKXwyAsrArJy2+52ZsYki+h2JXTYlCqMVgTBEQGKCpJBfNDhPpsc
	D12flqL1r9OTyJKTX1BU5KoraSsP/qcakesAiZagyUGJv2zBNbt/HzwzOiQQq/jVfQVkw20mGtG
	olJEHOavxv9c9rInCw+wfjf92Kmk6XwyztPJy//w==
X-Received: by 2002:a17:903:3b8e:b0:2c0:ca99:3d73 with SMTP id d9443c01a7336-2c725a659edmr127848605ad.8.1782106234304;
        Sun, 21 Jun 2026 22:30:34 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:34 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Mon, 22 Jun 2026 11:00:00 +0530
Subject: [PATCH v2 4/8] iio: pressure: hid-sensor-press: Avoid race between
 callback setup and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-4-1cfabcd1881e@gmail.com>
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
 drivers/iio/pressure/hid-sensor-press.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 3e47a10d72a8..8f81a6d65b9f 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -291,12 +291,6 @@ static int hid_press_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	press_state->callbacks.send_event = press_proc_event;
 	press_state->callbacks.capture_sample = press_capture_sample;
 	press_state->callbacks.pdev = pdev;
@@ -304,13 +298,19 @@ static int hid_press_probe(struct platform_device *pdev)
 					&press_state->callbacks);
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
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
 	return ret;
@@ -323,8 +323,8 @@ static void hid_press_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct press_state *press_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
 }
 

-- 
2.34.1

