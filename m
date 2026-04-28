Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6C3C0634
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360585; cv=none; b=YFoT/hVi5rdZ+mWAT0RJ5Sw/lXnugPtYo0l4V0yQnemF512rwz/rKKECWENMEWqhpE58J9I5cHY5A+jCbFV14HZ5+CrAZzbm8yTXpykzFPFUkZXc4Tjf7BhpomQksompIywZnTZnMu7EINwExvNgOOAX+EHFHoG2+POpKOAO64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360585; c=relaxed/simple;
	bh=ifnmbOiTAaKA5N9L530ZePE5ed3hcT8nLx4J4jUOmAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kq5omI/JCtUacbWB+wiBBpqGnX8o1x3KWS8ZZv764s1wD+VVOuvkHJo2MsMDeneocE7R1SCbsV5PgfLPYEPhD5gZw2U4rHBq1SKFGnkAlSngCLHJPDhajLaXpmB+oc+KonZ+5gXcKY7oDBK8uxhPqD+KB5PKI0+fMsvsJKGLg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avIIt/6n; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avIIt/6n"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso4262772b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360584; x=1777965384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an6Y7XCXgxIhor4TOtxCGopkHxLN4AXeWyw2UxzqmNE=;
        b=avIIt/6nqs3WMq205RMEV7SaTKMsgAGLfZkpOOl/I7NP50SleNpAtQ3sK1+YjlzWbr
         m/gNNXAGoPqECfulHcRKQvPYoRsvouiAlorzQza/jFYPLmKjz9vVAiEGukpusUKaTEwm
         ID31UNuVpTKqN14bhYfEJz108sDBETFme8sNgty1ZK2B+8vtKqsNKU2Hr4fwygxWGLQh
         7r+fRBButsIqCjvZBiZj25/dQXtmOm+GDgOnGl8UEgowM+yt7+5FHk7Q6NslylLJ1c5l
         /zjkz6EexsTYhmVBTzIK0L4ozX7AIpChvPrqXI9z048jpP5j1XT2w8WrlZZkfydsm3tO
         kHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360584; x=1777965384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=an6Y7XCXgxIhor4TOtxCGopkHxLN4AXeWyw2UxzqmNE=;
        b=q61GogTmmw651yHjHPs1nalv53kfUEQLApZpO5FeP3zUPBzd0wIJJ6kN2vkOS+5bBj
         092zVBZnfK59fGh0LOp1fzFcWjwFMAfB/43PH6Fj7ubjfy05WWuiafEBBOUtn6FwLl+k
         nRWiw8FYMybaW1LqkydKPpInsY2GCXKfU36TwipDQUKgo3fu9YiaP28KQVsJbgB3tM8S
         fX/dwj1qzCQBpiQgZJawxG5SfacDz0aNZoU+WaWuBE1M0SQZ6l2J7udfoOsD5cWXCJjt
         VOP/CHleyrLbxXBznIj7wyCOYHWZ6tAC3nQDcRc2ATzvLA5bRlAVLEhGEMZSyhqQBsqh
         oMdA==
X-Forwarded-Encrypted: i=1; AFNElJ/cguoNuBxD5RySTwFFJMe4bIB2k9XSSy2XcMhz6JmXygBGskp3qPhqJNkYoYfm1uPD1gCUFvLgrEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsWJCc6zS9YWIYmBSZqP4N1kDv1e1GjW2JYZvZ+RkPjksJqzv
	+ZXX4PnESKEW+nLJN8CTPGKah89Bp/F59DYhOPQQHCrUG3/j9+QIyQ0w
X-Gm-Gg: AeBDies2pd/2mDPjqUXOTivfGmsNhHx6cSyFLZpCTVZcXC/JL0sPdX/YBj1ZXzNbKto
	r2talRDIG4hbKd+Y0rmO0Q97m1Fvg21hvdze1TEKmKOAtadQFQ/sQeuSthB03HXysEHo2CmEdTJ
	+imeio3zTZ2vLrafUmfAzbnxmmqMeMagoko+5VXj5iHPdkg/fQRUT9hqYOy/feA29gyJjWDCmFb
	ZdVA/MULhLY/v1IO8m5hREqijNV2v5MUZY8w8iEvj75ET4mteDk2MxdrKsg1lXJS7nCkccsxn6X
	vaZDywEGvl2fGZGsGD8Nw7G2HW8Kf35TFn7GX7l3zD4ZC/KC3xd8a5LZznrQGYJF9ybExMBKmJo
	tMVPjbRHaamQLaqXivf+zLO6PQHMdSj98mNEtrKfPbrFRQfOiGNi5tZRm0GHxhavxwusyR7Hxso
	KGVhNrzIZvZBXfR8aS0apSU23WJ9S9cnZRzoD0QOiGEY+g/SpT5c/v/KCddMM=
X-Received: by 2002:a05:6a00:3486:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-834dd91736fmr2214971b3a.0.1777360583715;
        Tue, 28 Apr 2026 00:16:23 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:23 -0700 (PDT)
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
Subject: [PATCH 01/10] iio: hid-sensors: drop redundant iio_dev argument
Date: Tue, 28 Apr 2026 12:46:04 +0530
Message-Id: <20260428071613.1134053-2-sanjayembedded@gmail.com>
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

hid_sensor_remove_trigger() uses struct hid_sensor_common to release
resources acquired during trigger setup.

Earlier implementations required struct iio_dev to clean up buffers,
but with the current code this argument is no longer used and is
redundant.

Removing it simplifies the API and is a preparatory step toward
converting the trigger handling to a devm-based API.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..28d050b45c74 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -218,8 +218,7 @@ static const struct iio_buffer_setup_ops hid_sensor_buffer_ops = {
 	.predisable = buffer_predisable,
 };
 
-void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
-			       struct hid_sensor_common *attrb)
+void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
 {
 	if (atomic_read(&attrb->runtime_pm_enable))
 		pm_runtime_disable(&attrb->pdev->dev);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index f94fca4f1edf..afec46ecbe71 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -16,8 +16,7 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
 
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb);
-void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
-			       struct hid_sensor_common *attrb);
+void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
 int hid_sensor_power_state(struct hid_sensor_common *st, bool state);
 
 #endif
-- 
2.34.1

