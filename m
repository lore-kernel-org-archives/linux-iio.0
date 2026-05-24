Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4E314A73
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650926; cv=none; b=n8qGjNN85StGTUEkaoMEsge8v1vlYtGOX/DjbDpDjBSFyFmBKcVjwEzsQCxvfQ8mKd/B7W1/eUAnCMbGLfZhqyWLYQ9B9fElRkReik3PIlVXTVlDHEXY5muJtMRlSSa9SyecCULIeP60EyiTRHWE4t+66UH48XhxXwVULTDSFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650926; c=relaxed/simple;
	bh=JNJSbY/ycIczkqicR304eu9WvQjPtEJ9IB4Vir4qmo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LIZnI/MZiGQvwzTun5BxWcQanL32nwEQTJ7Fu8csbFF6dZd1v+B5OBKqjTSxVEgR2HkUcxwPuhC6xBgEqD9xv8CA2bmoWMGCM8jvZeCd6b3d67HGCNkS2cReDMfm49WystQYFQvOsu4LFZBSiocOVslMbsVvFjslnq8V3L2y0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcPbAWVT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcPbAWVT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so93449615ad.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650924; x=1780255724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrdao8q/yZ5XZQIaZs38auvvcwHZOuX84StnGcvRqGI=;
        b=LcPbAWVTS6rtBBv3bm1k6f8aepnbEFikxBR27ayMu2YMIODK06exUZsAkyTYbUJj1K
         VS6ew2wlM7jG3AOiJtd8R435BNwSJn/Nl6Kzir3IvbLLb+EUEvpK1wq81QP4Kwj+uweM
         lkBRu9NIcw9z0WQKFJj6/RG5Gisu0YMmFe34n4DsHPb9WU6co+MzeizSinqrhW8QiObl
         yE0GuNdKO7qg6W7dBgHPFVUH0I1Czx4Wi2STFRVfb8Yj3HAQAYZUwWUB/B5HjfFV+fUO
         ARxAV0XpQb+uO0kmNnMti8cu5cwMpwoqpb3VbWHF8PvlL0fM6HEheO4+DFn4TgobIx7P
         bD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650924; x=1780255724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rrdao8q/yZ5XZQIaZs38auvvcwHZOuX84StnGcvRqGI=;
        b=KeziucKNM8Xgncr+Y0BlN8x0eIsjlnOBpNPSum+g5M5ADTz3ypKhrP9xFBVmdjXZcP
         vLqaUIpyNt4CbMw3zAnnR34GPcVSHQ34cAWqnoaVGzyFc0vKRJbiVMOVVRL3AzemS3rf
         RlMfOlz1gT5Mhp2t0zia3mYTj15dilocHhw058UpswWJCPNfL1xCaN2xKGlAYfOrVqa5
         6XBnGKwpErdn4Jii2H5mKkDLzrPqkvpf9tNQyWEcG4Ch3KQh2si/zwGhHxVS0oC0v9tI
         UpGxevtAKNN1SMsCBeh+QjBhMMcBJENZYI+lv3r5Czc+SkjcAqPzH0bYg1w5ejUbrrM3
         pnmg==
X-Forwarded-Encrypted: i=1; AFNElJ/IgpJKS87BOKQsKeYiqAz3qXwVD87slcvC4LEp2+Lrqk+cJH75V1fg6/de6ap0lo3x0tePAn0Otu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZ6xWzGLMmA8+wwEqbl6P77kW8pgyBrxpCJA4jyIc6TO8hBUR
	gY0WIcv7x9beZ1p2Smvu5mi1yTeISxp3hcXDEq34pl72YV3mNVAMEvrJ
X-Gm-Gg: Acq92OGwaoz+jg/hWEg2l29QaJg/cQMUqJjQghZmCMXzc+Zqr67rUl03txDMh5VFwJF
	ozAGhYCTQ1WgRumVEqA+3xXtF4r+Si+5KpWQFhzIZNPC5+Xf7ZRGmU9VhDAtrJylcdsj3cR4mlP
	1voy+wFWW/SVDpp3q3yW8ttTyCqpTPX/C3VrPliF6eDk2wk2CYeC6HTgUvwvHHfi4hU10m97gRP
	8iK7xQVfzY3MyIaGAsFZM0dVN+vcO4QNbxprMpF5rqu+TkkfzvntoWF4a2QZlnwmTZPOTy1OuDK
	OzyM8l5QtIvRvwjhDzNqerBvQvHqdDnAIne9/a1MXFd4WBfLKAf9mxVF55UtDOTYIRN8V2w7xAB
	kIAOvscCF164U6w738W3eExWrpgDzymy/gKy+bmjfbABJ6Hpr/9xDWax4QyqxQlZ9+FzqkQ3cbM
	28emqFgKB3RJcl7RiRTIPrKtlRPjJO3s9S/Io0gwNIzbMkcxpF
X-Received: by 2002:a17:902:f544:b0:2bc:e628:9cc7 with SMTP id d9443c01a7336-2beb05da027mr130471425ad.24.1779650924407;
        Sun, 24 May 2026 12:28:44 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:43 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 26/36] iio: hid-sensors: introduce device managed API
Date: Mon, 25 May 2026 00:58:09 +0530
Message-Id: <20260524192812.1196549-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192812.1196549-1-sanjayembedded@gmail.com>
References: <20260524192812.1196549-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
during setup and release using device managed framework during drivers
fail, unbind or remove path.

Register action with devm_add_action_or_reset() to release resource with
devres framework.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
Changes in v4:
- No updated in change, added Tested-by tag.
Changes in v3:
- Remove cast and update function based on review comment from Andy
- v2 link -> https://lore.kernel.org/all/20260429175918.2541914-3-sanjayembedded@gmail.com/
---
 .../common/hid-sensors/hid-sensor-trigger.c    | 18 ++++++++++++++++++
 .../common/hid-sensors/hid-sensor-trigger.h    |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 98fadc61a68a..fb6a4587ae03 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -301,6 +301,24 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 }
 EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
 
+static void hid_sensor_remove_trigger_action(void *attrb)
+{
+	hid_sensor_remove_trigger(attrb);
+}
+
+int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
+				  const char *name, struct hid_sensor_common *attrb)
+{
+	int ret;
+
+	ret = hid_sensor_setup_trigger(indio_dev, name, attrb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);
+}
+EXPORT_SYMBOL_NS(devm_hid_sensor_setup_trigger, "IIO_HID");
+
 static int __maybe_unused hid_sensor_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index afec46ecbe71..6fd7c39a240d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -17,6 +17,8 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb);
 void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
+int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
+				  const char *name, struct hid_sensor_common *attrb);
 int hid_sensor_power_state(struct hid_sensor_common *st, bool state);
 
 #endif
-- 
2.34.1

