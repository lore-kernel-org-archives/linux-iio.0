Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB03D3D13
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360610; cv=none; b=OpWj/T4km7J0F0F4H7wO1Fe8CMDN2GOg9cH1FyxUcQ1mXNTo8Jqzasd8VVk6xVVN/0/YxR6ym2IQVXhEOf7lU4NBBf3j56CNuKGkY364/p6801INTjRzawZdV4EDRCemHqzj+zx2L2WOT3CLvnoox097OiRqiRMB65vO7WXwdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360610; c=relaxed/simple;
	bh=dSkKJ7Howa8/r4sWuIZt5n9X5Q8SwwWpZB/z0c/7jDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3G465Tn6GCB7MDluZMzF/Ar1uOplPK0JW+QhTQFeDH40RHqGHgNc8XkWWhQnMT6r41c9KRUTowEsMDKN+zO8tKiC+VbWKAB4XxhU1HBpHkcN+GZjXyDzqldL7biXX9C18L+1LwITnYk6CXthlTj7ZQv//xCeMvt2x7QNJ02Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pP7BkeJ+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP7BkeJ+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-834da62e52dso335584b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360608; x=1777965408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7mkX+e8bgIQ85sCXfa5nrQnLaf7XTdt8ByhqMB6hCw=;
        b=pP7BkeJ+ajK/LdDoi1VVXAhOtRKBqee/gf9FcJ0MSNEAl/QzrK8HxemRZNbx0IPHgU
         OzyXooy5/FZMt3fRqvEhgrR+UscQOWENZv4nmvkO+g3Ota+6PSuUf3C8kXC3knxtzNQr
         3FrNHcv9/x/wwOygkNf1OBQaSsXy6vRCxo6LJNwmmgZPCUvSG+jNAroLQ12CmBWew8UT
         PJ185C4SGmOiExHsIDTKnQVFpncH2D2zk19N2anBpHMtOfZFhY0fdxtVAb+WZWbfxZI/
         bd2Zmuj057Wv6xzSOkdMzrWDgV3kS/Po4HsVCVqlV+uN6hvhbqTEA7rQqdYwjlqT4aR/
         TvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360608; x=1777965408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7mkX+e8bgIQ85sCXfa5nrQnLaf7XTdt8ByhqMB6hCw=;
        b=bdZ0Qulu6EGzVpQ10B1dcq47PXxxNb7fcnf5Us1nFowf+qJ0xaLoevMsZof+GJLc6w
         qE0tDQ9f1oVos+7HxNK+RDuXrGD8bCnEH4o+oKLtXOE7HPOKmYqEVut1TXTyXK6bRs5B
         MrQzWsiWxuWHYBbi19k+HGXCTz3/wXyKYmGAnFnTu+KXHNTtn0+bzcKC/KrGRNeviw+4
         WAgAutWtMrbitxzEjZ3XULExW3vyzM4hSYVrXt2y2czZ30LAX6eLVKFdBGxvWgiaTZKG
         yiJ/i1Lrohaa7xMo6Sc9+ALgPyBegGqrkcVJ4D+vXG8lP8G0uxIDs6Yr0QGt0J2VujHl
         1Lcw==
X-Forwarded-Encrypted: i=1; AFNElJ+/eKgbC4fkv/QD9yHsMauh7Bv+UNHEoV3rkhanHB3gNzxFX3iibQ5GozF3pUjVqwzNjCiEh+4LUKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrqPF/7rB2rhiBqWHIGH8GuB7otBNIpBvqaT87mjSfRnECX/T
	Hd6lutdGajGdhXprcuU76mpJUbi9Qx9hqlfcMZEl8/gnzCB9eiMmsQb+
X-Gm-Gg: AeBDievDa/MGtV0z0AY4c2nMMvyHKeasU9SjLlbXOuRBLGw49FAJNzPtoBwitiQa0IP
	nqERwKaGoUUYR/7xT6/A8XY598sYVcVjTid+cDz/+Q4NPnr2iYjs6qDtKs9BDmbdyUMDZS+2E5a
	n8H47BHepjkrE93B6kpbk2rYQ/vApIAFpcUk/Vq09a7dMyNEWCnmTAIxKYsixxtij6D+9TfVkMZ
	Tgj8VzJvjATG//WTfqZiKjsArMkj2zF6YwLBEvSbEBRGERagZx55zKbTY6kOXCIxXnD9XJfROdc
	M7BfpjEXwu0zQ2JkJV8NK6Y0TorhjtgG8X2bpHvo6TGvJq2GWmZ75Cc0Tm+KmDYjSVSgcfXuJ0v
	CDmGZ0UR5uukWoisxVQ5WrzwDF6kWciQAyI0W8d2NB+yyb7ADmQZfsx4eBfFB4XPT9SoHziczk0
	nkKEOtj33FV/Fg10FcGFs3eioYRvnPeipnlKmiyK+pGSdUCDHyR93LkjNutDg=
X-Received: by 2002:aa7:88d0:0:b0:82a:ea3:c172 with SMTP id d2e1a72fcca58-834ddc0c4bfmr1981054b3a.46.1777360608302;
        Tue, 28 Apr 2026 00:16:48 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:47 -0700 (PDT)
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
Subject: [PATCH 07/10] iio: light: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:10 +0530
Message-Id: <20260428071613.1134053-8-sanjayembedded@gmail.com>
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
 drivers/iio/light/hid-sensor-als.c  | 4 ++--
 drivers/iio/light/hid-sensor-prox.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..9b57cdced18a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -432,7 +432,7 @@ static int hid_als_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 	return ret;
 }
 
@@ -445,7 +445,7 @@ static void hid_als_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 }
 
 static const struct platform_device_id hid_als_ids[] = {
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..473c45626487 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -340,7 +340,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
+	hid_sensor_remove_trigger(&prox_state->common_attributes);
 	return ret;
 }
 
@@ -353,7 +353,7 @@ static void hid_prox_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
+	hid_sensor_remove_trigger(&prox_state->common_attributes);
 }
 
 static const struct platform_device_id hid_prox_ids[] = {
-- 
2.34.1

