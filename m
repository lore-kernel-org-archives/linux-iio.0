Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB7392C2F
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745901; cv=none; b=lO9t6xXmD50noo0X8uFc0bF2a56OkeDdeZ1SrUJDLcda4TVqTxBaEqvQ2br3YnN4CvsIp8UC1E0QPYTC9CFYb011hQWtwukuNSrUvwpIgbLsR1m401763o0rraeTRp4cINdh3pqbGfGdZKCopPXSdwC3Z/OciZHO/pSVIZPngG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745901; c=relaxed/simple;
	bh=tdQv9XeP1nHQ7Q2g9P5Io42IT+SkPtnTaQNAZxqkqp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GB/l0VqWNDVn7WYN9VPO7b28+fKEBJUzJHTe2aIpHHQzHqkFCXYboDTqVEoDKgb9+yJmzusPgdItFpAPWXrkURzVJf3YGTaq2yolPmGwpSI8yt6hS7Mws3mAF7ifSkIYzjilmHZPFLHQovJKXuxwARvpgBIroj8kxU2G68jOA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMxaeRZ0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMxaeRZ0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b8d414666so1717910a91.3
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745899; x=1781350699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEHHw98dpwCFQIjo5hdkWP0eBsP9ued+vfNrFXHgBKU=;
        b=TMxaeRZ0DMS4YisfkNrsfTLIDVgAwkGVQmyEuRNJd8W1jtkIkk5nWBcBeW+uznD1rV
         iqtLWqSqFdQFtVZ0TFil10ZaVbj9EUy6C5PmEA1sfS2EQMX4HR7WGPzRpfjNJZlgHUsq
         +n0aFGjwvmXw8Hk2gwGk2R4pfn6qv4Bks83bQWALY7o6OsKbKF/PibxkkBa4nrisLY5G
         reHgsCGOl1q8Mi7AFfUXPVQU+x4pknv259g/8MayFVc62X4z9EYRL/8iTma26gfLrRFn
         4RZBoLaXq/JSS4pr7ySpKzOBzIfBy+ZIweX/tduIF5TayjGozn6frGG74/XinJGZWCoH
         /beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745899; x=1781350699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MEHHw98dpwCFQIjo5hdkWP0eBsP9ued+vfNrFXHgBKU=;
        b=kSxZnKy1IWmeNs+/9F0Mib2n0Y73OV7uTLqlt6wOOrmkYaE16i0ylTqxMWFVK3tyI8
         xtdA2U36BAXWAUfzP0MDZbwP4rR5vZFakUbq8xYyEXSTlGnjbhmbEAJeKZOuFIGhnkFq
         R4CdMUfVpLcHtD1zYr23QYHFUsMNF9/i8utGqbxQg4BsvFZbmo6Bi4qHwXg/Lcm2UVUs
         pGtofzV2fAYHW1fWO3h3cMVov+w4hsEzsdra7LnUnMjgfPJo+hUEaEnnGvH9ediatutV
         klH/oFdqh0oP/k48I/qSIi+rGwgOHBtEipaKKOaGG3IxhvN+XUUsAHxrSResCnHkoHfn
         j4wg==
X-Forwarded-Encrypted: i=1; AFNElJ9ny8HvFst0WTx+jFiefA2u1APumcU/WFsEWKG+3Fzupn7bo41Vc2j9rBr71P1msb8oE3gtOYYDmoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1csRyNR7NZcjCrX4WhINY1djZpEGPBMswRi/3sdPNxbaKs3r0
	OvsO3cY2VKdoHJcoL0Jgh2nvDO1BSAksOhChXz19Bxgbl2Gm4VUJDMZk
X-Gm-Gg: Acq92OHAfNjK0mE6PL97PEgzoBSuH3IW1k7FZa98lUsz+foX//Gig0M/E2zUWtZC9tf
	zobWDQz+FYZSzyh1aRqJUirv/2ISRFPFaqUKMHbPyfVID3QiUnpRgeimYv1AtXyBYadAbcRmvb6
	xh/PF23kGfIxmRd6pt50qsGwV6Csg0OaxoEK9j6BMvebtMopFdUamSSIPxQKRw+1ng2VqwAJz7F
	ENurJizZ+0SfLX4khoux95D5lQoOXOESjczKclClUOuJ4aVSFwI+d/w0vkJ6BR8chx1uSNwkn8d
	K6Y46hTC+EZgANYYhP86prhCss6FTFNEVYSvCdAbcYNLXJ6cE1WhmTfnvmGnP1TvlQqmsIIh4Ww
	I4P/oAIDYo+NAznywfiWkBFCXcGX7dfoIbkszltBxSgEIlv4eD+HEoFw1uT4T4nVOE4MA1Wk6i6
	KJJs7iDT0SlMbBOfY8aDfAiXbzYslfK/JFbSI8mhHA7ywn90eU2NfnjqStLQ0=
X-Received: by 2002:a17:90b:1fc3:b0:36a:fcf5:64d2 with SMTP id 98e67ed59e1d1-370f0b554b4mr9229712a91.16.1780745899160;
        Sat, 06 Jun 2026 04:38:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:38:18 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:18 +0530
Subject: [PATCH 9/9] iio: accel: hid-sensor-accel-3d: Fix race between
 callback registration and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-9-27a848c5758f@gmail.com>
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

Fixes: 45fe6f7d002c ("iio: hid-sensors: Added accelerometer 3D")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2bf05ab5235e..c000e001c001 100644
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

