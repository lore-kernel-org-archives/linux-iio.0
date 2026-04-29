Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43638B7D5
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485577; cv=none; b=RxajHQyh6mC1KA+1bVFYZivB22nueBI/Ti90tu3ysg5IoWo9WLxAiKpBoQzii4ejDub/k7fWwNBbvQ1HTQfwaQbkHocHFcXdcRXfJ9nLVdtotP+MAv0S1qTnq3nObUCzquSWt3gdkRjzTSMEglLnbnyBBr5LtIunnEe4T5OrEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485577; c=relaxed/simple;
	bh=qLrrmL4AkQqIOhkUpsgjITx9Rs/KUJY+W1QRMNh6928=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bt1UwuxD+TASPXlR0gq5DVOL3fZqDrGR/nF1lTv7J8pTSxiN4Sv5RWQx8mzko6no19Q3WX99OO3V1IGu9hY9cU2sW+B7bx/Fj/ePK/eNddxIbvUmfdyWFm7YNyM702z4Rnncw2gp2bAzJJPeTG22g0X//5IO4OT+SLHjkMZb6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVUD85jS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVUD85jS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a871daa98fso466455ad.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485573; x=1778090373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLr5AK+EwC8gV79FD9GoQQ4ntxH7YLzxoj/qCWXjquY=;
        b=ZVUD85jSkyDGGSorM8elm8CDuXektUFwPkELUM0tVbPmDIEoyOWGofEbVJ01m4syAh
         p5/SJwXahpyhw8+7glAGIVpHZNHX0nRztnl5lugljNGw8uxo/GijjO9W+HCirBgpESpk
         R6jcNEePUCm+avT3tTAWMzL0HnEilPj+sMEVqfYC55i33NyGj2DEVxusDjS0nfvc9C9J
         ECrCFGi4v0R+qH6DQvtM+0Ll/vqyMI8Bn/sKKTiA5czXcsENhsX4MF2sbfe/ktE+KXsN
         qMA8Gsq1JfC/QTrxZK10lbg1YdCrN2rRbEn2QbwHUoGutCfnjfG8F+LPUGvAxfY3BAzU
         n62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485573; x=1778090373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLr5AK+EwC8gV79FD9GoQQ4ntxH7YLzxoj/qCWXjquY=;
        b=WAQC6nMr0ZHclVpH3C/psiH66AUVjToJe3eU7kX3J4EPo3tKDzyJpdOMhTvpwIntmN
         ib6MJaT6hdckKt3U4jfkKXycaNkLzl86EBZ9pzd6o7yba7QIAcf7raO9YDJRLSq8/ypw
         HDnHYj/R0OdVe+wUptyxqtilS/0F34ld+eH5EDjmRJWDE6NiRGK5Qjn9RBVX+fqiO+xr
         KOSADjvDmAu+Csoo5pAAossQ/34yCGp8tBjG9ID2Gsg8PqEWKiIE6sMoAfumVOuqXprS
         wDI831uOQh2TqWam0s2MQco7JCi36k5gsa2kElJIOI4qKUjpiw5O3hullZ0zzTxZrl1X
         cGLA==
X-Forwarded-Encrypted: i=1; AFNElJ+ATZnnvpDfR9b3cxHYlTs4pwtY8LsJrBTcfQzoiIqqniPqatbijnFfRFm4kPwi9/Hd67k06Fwq1kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAaN/aGlcCADE9rxbiv4MG9JFR7B2spWy5HnQy5JY7dypsoG4u
	WKZS27hJpI28ZzuCw1umPcqcNXnwPxOlAryjSYaCR+nuSzQfMqprhOpn
X-Gm-Gg: AeBDievLaJi/Msbk7cGxsXqklZ/VJr2cTTo4YJeKVppG0mqw9HUmEn5ZjhGPeDzttn0
	ytsGNCgfAd99/wtrnFQFCTvFXfoQ1+GzHi89czyhmKmVjKameqVeYh2kc4+cqisJ156Rnu4fEH0
	bJuN0e3YA73lbfszvuipwn5+1NSj1t35HqEfAkH6ilBhQqNKriCjm7snNjtQ55woQjL40V4sQMF
	IJxyjTfmWSjKhd2sNFuGMbPBIwC7ETgcSGNaBNrmtIteY10wrMmNd2uhQHQjltLusSwz0I1NDzB
	K413vFxdANHsrN4shXnxb2+fNiI3nmhDzERzcpm5nhpttlNKpQg+4ELFvPzPaPv5XRBbGM6UWLO
	S9Rw2tI6+q3eSxesSwlResoaI3JTKXTd1pmMzxjKYwlzeV9vjj6IRCw+ZsX83K2GqDMSX9bjbZS
	1d2eAO4PC227IG1QZYT8Qx8ms7EnUQZ9upMypZS60cmL1u13Zz+MHMFwVyuS4=
X-Received: by 2002:a17:903:4585:b0:2b7:bba7:5b07 with SMTP id d9443c01a7336-2b97c49a51bmr87501495ad.36.1777485572911;
        Wed, 29 Apr 2026 10:59:32 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98897edefsm27726805ad.74.2026.04.29.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:59:32 -0700 (PDT)
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
Subject: [PATCH v2 2/4] iio: hid-sensors: introduce device managed API
Date: Wed, 29 Apr 2026 23:29:16 +0530
Message-Id: <20260429175918.2541914-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429175918.2541914-1-sanjayembedded@gmail.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
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
---
 .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++++++++++++++
 .../common/hid-sensors/hid-sensor-trigger.h   |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 28d050b45c74..6692f403c8ec 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -301,6 +301,30 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 }
 EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
 
+static void hid_sensor_remove_trigger_action(void *ptr)
+{
+	struct hid_sensor_common *attrb = ptr;
+
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
+	ret = devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);
+	if (ret)
+		return ret;
+
+	return 0;
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

