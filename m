Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04673D3481
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360605; cv=none; b=LXG+lmsyfZ7EXHUBBXmz3IPSz17oXqXXCCwSK+vrK/LWdrnXZkXQekT70m+7Z3N4mtPRmTcb9hSuu2yoOh68KmGmFxkGXhHGwvGHbb3Cl7/3iyYQV1HxqyYRYSW/X6MzZlhDbVCSDSNR+5vSthiXFY7C2Rrxf2C9+/eB/4BglIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360605; c=relaxed/simple;
	bh=cewLy2WqB68/tbc5qDfV4qId9cmPsWq1aneTgM01BlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGK5aoISEH7AOq5O4t+TxFIEAAbV+ZXsOjJT9/ya9ggJYoiCmqFPW/cDaYWL4iv8MSPXOe2GX0jFUwPx87KLojVoauG0rX8PyHNQQ72tv7BU1PNzFfFGSZ/CxbvBpLct6l6IWaMIJesBFZVby/kAYddxadXgsjcOas8dkWae92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RChWxRqE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RChWxRqE"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824c9da9928so5370605b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360604; x=1777965404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JuVbh6hdR7S7K79ksdJ8FflVGwGwinNinRhTfjkwrM=;
        b=RChWxRqEe6WtEsC7nU/XWG8M7qUUeQWZojhmvxDgqN6+abSRrY3EimiivcvjMwjLLf
         vYW4hQukL5VRxMgUtvwzyysVcRgxIcCgHi/zX0QTFSxzhpVu8cnlWDQZYDQS7EaF/PXu
         bcQpmxQcunNTKHfb6r1fzHwTivP28xMHWCqmBwIwHQu9FNJuscm52lId7Cl13WIEVi9J
         rXLwOOX5st0RauDm1mq+fwkXpSfrJ39qFnx2hA6tFrqxinC0ekTZhtEFtRhc5UWszqTh
         UZrWcLkKkp/K/tAK/U8BnMPmKpOYzMj7DJLK9seiy4SrgVs+M3ZjalVE71ceWvZKtIJI
         3Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360604; x=1777965404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JuVbh6hdR7S7K79ksdJ8FflVGwGwinNinRhTfjkwrM=;
        b=XZoeWIZMKEJ4bBtU9gAVYvNhQBhq1kagO5100N49s7iSmQaewIcfSdhusulZlPavk3
         rtRJKrETZI/SXBV0eC9ReIBGPBw1wH4C/QpOaSz1sfLMH1k1jtzL4IJFkGs0IM9YYe65
         nIl1qfkhMCcvIrZyZNuN8AlQsab+a0LytLoQO2o1qet7zjwjDAWwGFt6z/Ph5EdyK8XG
         JJuBo4X3tMV6ZJlCPw/cA64vcybchoHuPq6y1fwDrpw2ig0bTOkR3OmgnoxBe8fTH/Ja
         0uTxlzWcPv5rMsjrIXH90Gj0SXMLmuX5ODLtZVtAtvm+aAh0KcmFjjG13rEcIpzj/SA3
         DGNw==
X-Forwarded-Encrypted: i=1; AFNElJ/EcTUX8nNGqG41nBT/0+CRC8NpYZ/4TpwuGow0EhcZ3yP0qvBG0XSn82XxqYvya7+DkE+3x9rAGpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDD814zCi4IClDqqzkWq6JXmV74oD+nd6LWeha8eJAVYNeA1H
	nauPrLNRbvmyzlcs6EFJvFYpIqzjJRKMefdEAn+Zt5hNbUi78fGnHJtg
X-Gm-Gg: AeBDietSPbeFN/wkJjfqbt9m61IxwOIAwksE1Ql2NUQs6vfrMYtWwfna4OLLAo6Pv+I
	CEBiXhaJwPy53/ZPiNYR9j4i2hQ2Do1B7ivWPmWeExwPqjrqKLDC95GnoZUu97L4aJf9PRkdUD1
	mCcENc1N03c2AEOkNpL5naI0+xaViWq+YjZwGfWKatFkrl9HWecjru86wAJGaS7qHeEyl8Qlzi0
	eNVjlHFLYGC6akLI+tteY/TR4XQlRgwv84RzQUtrzbVC8II5Y7lSfO47lm3OG+xEYQ2whmfjPGl
	UqgDOZu4HaDB/ZqZKHz8/USP+BFfg/YYTtNSQBIyKroFNV4+oYnp6bTmA0EjUm3DiQWQpZhzhnB
	7vJ6+bbEvr1Rsnoa5qkEY+35TmZeSCc1Bo1qJYTe0TkjZ2FBNnD2+rwxa/Xb+PaF+f5TYw7nomW
	Nk+Tuw8OpuNPz9vxfWC86VtR5Dc1GiLVIGOoGzJFM+y56QtB9YvfLbWLgEZTA=
X-Received: by 2002:a05:6a00:3403:b0:82f:4cc9:186d with SMTP id d2e1a72fcca58-834ddc8f656mr1872109b3a.46.1777360604220;
        Tue, 28 Apr 2026 00:16:44 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:43 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] iio: humidity: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:09 +0530
Message-Id: <20260428071613.1134053-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index be2338d5f407..e580a2af9562 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -255,7 +255,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &humid_st->common_attributes);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -268,7 +268,7 @@ static void hid_humidity_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(indio_dev, &humid_st->common_attributes);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
-- 
2.34.1

