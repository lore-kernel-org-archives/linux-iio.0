Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839531355D
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745867; cv=none; b=YRdqNeVQvEYuaX8xex9bRfx4L2f+xWKK/hL10IHRoIdYRhrBvwKm6duV9+7qiXPHRQ6p86MD8NzT2p2E9ckMKgtetzuw2ZfBQkq9cFS9sDJZTe73o6kYsnYzVltOkjK79DEVvBZVJ9SVKCqnHIYSVR9Gawgt6REsVSuATHiEmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745867; c=relaxed/simple;
	bh=05LzNFyyP8p5aiiuzjn0puJUjvbiTBR1WRQ9rKJrAzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZiQGeaejFa0V3Q6OtZz8+D+1M7x6fqbfACQ51WdBDm1WIOfhnzXABRdP+AUZA6iAKQSLtGmTnK727dHID9gUbfXdRctClSHwg7Cj/Y0iCqg4Iu9hmkgply9QAUS0gu9MdCoqutKUgjJQItqK/C3Q8UuYeyVHQAIc4OWrooMxUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi3olPRP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi3olPRP"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so2452305a91.0
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745866; x=1781350666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7+XBukPZOD6mxxMvngzsGFIjLoIFkv28Pwa06nTfZc=;
        b=Pi3olPRPPCbT/ktl663qvjbUegZQnnib2TzJU52XIL2tMh9PVi2K73Bl/FyYD1Wbr+
         RA/WRsXvnVOdFX0z+2fBmXh9njrKG4xBLAcfmXU/M7F7uvRFTJWjzQHRolc0A1ZhgSXd
         OYsxQVFp2pOZ2O+OQUyD6q9vH0MQPSOSS6Z6mOQGtZDGNlt27ebgAq1QSX3gnZ9Iq+mF
         bjuwoI9CDIiDFuTxBAsruB5QeJfzkhEO8ZU1LlTnsUC9b2PsA3zkmaFyNPvVUnirwRom
         99Zp8t49x8SHuvRwLRw3mrj4fMn0o851g3oDSI/gtaYnyu/q++IaGSu6yhdqmvcr4naC
         Lw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745866; x=1781350666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I7+XBukPZOD6mxxMvngzsGFIjLoIFkv28Pwa06nTfZc=;
        b=JbmWT32cgLN+TdHS2oYByre4RfS5l1uvOz5Yz+laP+wkE7PaIed6XGVKebv2Ps/rLj
         cpYe8Ya6KTgdvIe9QhMNqJJEBfWKPpjiNKoBIpg/vnFRdpGhV7DJ9HXquPnsaNPRO71N
         VMcVQbAXJAwna50Q8Hsx7UINUQJMo4n8vWev/213fJJyHLNlD3wZEtF/XXLg1XNfYQaH
         yMBECMxQer6oLH0/O0uLyI+TCG8rxiNiGFumH2VqcHmdrqtn9SLexetgMIpotR6ezp+r
         9XOSdHLAp8uLDeJYmpUOpz71q1ZLE90PVtDUt3frRGnhRSLVmRzbtBT7L6hkW3Dye1ip
         p+5A==
X-Forwarded-Encrypted: i=1; AFNElJ+8gqHssodBIninbmEEZljpxwuLm7ru5GwKXOtbbzs4U58J99mU5hTIhLI1jiKLcQqBy0SqXAlHauc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqV61anABmWEx5FvR7xJrdHsQMOfOBfJrNsK9Xs2EvoHdEQOwD
	0pLbOFrgA+2V/7/EvzhZFdNWw7gfhxLOOj9OeBNeA6LY5cYsfoU/C6+8
X-Gm-Gg: Acq92OHTID7oLZBoUUw811WzFRkmesZHpfz52ofjOUB5lGwLYx1dtqrmQpBD0kQGAWR
	YuztZ0vsF/0L+2Df2Lg1h6SdJeuTQLGzeQu/Hl3BWkW9Su987zAg4Mi97jRjtX+tIN491GC+Ww1
	f93PDJtCh4PeatltO9uYBfnQqyflqtgP8GUsQsxhBFSXFhKgeI5tDA0ElPzU58fGdQcNnu6AmUH
	RgWZFayY9EgXHwwspauKzUKxdB8ASNLl5HA6D8Abzm0HLPMddLy/ukWvEKHE0SmLEkpNjCU9FH/
	Z480eAucIWDrfc9E2cXYaRiTtKrfP953bqh1ZFUJIlWQxg3knEmu+mNw0JGAxFZV0bk/x+zN57o
	0i7+e0KO5OXxWIY+Ys9hapoLXCNjccsKs902X6PM0u9qfrkOVb0fFMZj9OUkK4OdgrJ5yqsuXOD
	6KAN/TrMlS92mYPtn/LZNtYZGFNttOm0l/cYAq/O/ZKzGrvzE/9YqWhkI8AY0=
X-Received: by 2002:a17:90b:58e7:b0:36b:936e:73c8 with SMTP id 98e67ed59e1d1-370f0e4ad33mr9461694a91.19.1780745865902;
        Sat, 06 Jun 2026 04:37:45 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:37:45 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:11 +0530
Subject: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race between
 callback registration and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com>
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

Fixes: 098d3beccfb6 ("iio: hid-sensors: Added Inclinometer 3D")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 4e23a598a3fb..5e3d2bb9b5bf 100644
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

