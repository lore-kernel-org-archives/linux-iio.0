Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37472317147
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650930; cv=none; b=dmjkP+a4+Vl+9eE1v4Joc4hPmCVLpfpRuiF/cxSx0P2VUz8JvPT2j0j/mpzcr/oo5jTE/t+/pWU6OTuwsLCXEgsarj7D91ka2sqeLxL8l42bGhFDpSjElERGGhkg/7TseJ6QCqyIKGS0snyoKDhEbnM4n9kq77AZbBdNejyeDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650930; c=relaxed/simple;
	bh=/h+JkuhDHsAwIVcOgzqLP5mEs48Q8iNP+h29n9JB8JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyRKdtoUiApj4JgRg28l0tJAyPiP+yPoUl8zBuegpT1GVyiIMX8PJl9Co5Yuhw0dnX28mVtT6NojJANkzrrzWrcGWGPblH/CEXN5ZFAvUH556wQPdSC8+2q/7ZWuvbmKt2zxuX7iIu1SpvfNNekqLaTk4RpTZUpvhZyanYsol5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOLlVkYf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOLlVkYf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bc763e2ba8so44769305ad.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650928; x=1780255728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWaYk7thJEgw6qqfoqanaj0UJmMv7sk4s//LiOxIDcY=;
        b=rOLlVkYf1TRhZtihQg0eNHY0aXnM4bPnyAOFA/tRYTu1mKpP2WJa0qFgrQirY2fx/U
         6A9u/9FvRbOnfTKeaJjD5mEyViB6MMDqD9m03fbTeuQnMOW9LrXDe0hMX+kOfuJSGN4C
         j2c7llzLvCYFZYyd62GvsoL2MHXKeD2tvz1IjnZclaQe/L/b6ht09Y/2FGjSv51g0MLt
         TcwsX/l3Nr8xzHVCNg9wjhHTgVdafzIPxqq4nE+FpnTPl6ZRmspjONqGt0uio7iNfS66
         +1jjH51OSpmjG0P1ZdHyUGxslQK+ykurVFyMg/c0AF+AAjQ5DHSUXxkzZcono9Fe/+29
         7fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650928; x=1780255728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWaYk7thJEgw6qqfoqanaj0UJmMv7sk4s//LiOxIDcY=;
        b=mo7EuPEpCP4izwxAfcw6SxI2IU7Dz21mX3hAFIpYyRCRylvZWOshzG9sE/An4vyL+C
         n5CeNej0v4VMOxn8VdFNNFOCucxebduncuaTFMwW0LKdwXTMSXnX0y+mYGqT9G96hoaj
         ZXUKSL/Nq1SnLmqoPPH/WTvJ1Qkn6RIXgVD9/c4DjoH25XPNfA3UeHz1QmuoA9DgztAH
         lBaU/OleW7s96SLNXR8XIDqIQEpHknZV0Q7882GUaoSVZT5hx5MlHYMm0FJcoCMV8lCI
         3vzWlZJawd6MyL9ZPo2KFq5h+v4xUaIAP9akF7GdLT0KtLx7V21WCCGgWJQzaMBRs5PH
         pS6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9mMtZ9e88s+LQ727yQ9uDcQQ+iW6TaHosS0xyYr7O5N9fIn/2S/4J7uPdSzxD/GXaGsRsAvVGIQdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszoVJepyTuZOwjzAnQYoXgcRkYITWEzMqN3FLc0Lv9i5kUUmk
	3MxUBugJvzaxvVPNPsMMxqGQ4Za76qXp+oB2mpUtuJps8XEzXiQcNYRi
X-Gm-Gg: Acq92OHhYsLsUHSiRygsySD/fU8ShKvhEtgW4ZTtnuOCODQsLo5tXkvfWlO0DbcMDtU
	kUE0CqW5H4IJEK3XuBh+ggD4alBsXgfOxa7ZFL8Sm21VKjoXFkiVgdOZkcC3JmW1BNyuwjB5qpk
	gD4nQCMhx62PGy7wo5U6gVR70EOxwmLU0HOOv/Hw9cEdSN42c/5klpYPc458e/hcuor12d7zwob
	+mCL0qzJzd+eImzaQ/2Io0Vg3hrGrqXjRqgbDMy9y0vnvBJlZccci15GYikqMXNatqWcv8ml6Cu
	bH+wp/EkOV8K+2TSaAzYi9CAfKgyBkIHtTxDFtlDbdEJflW9/z34HqQ3/OxCFxjq6ewLpLn/w4B
	6/g7x6WVVBSTrX3bLui7VbnQS/NBOEafdwRDdwP95KCt8842RJfXRoCMMJvq4XNbcqevKOkFA2A
	G9/hijCYHeGlV+JejlRaXQvOZ2I9L8+GFbYf3nGzc4h0Vvjvnt
X-Received: by 2002:a17:902:e542:b0:2bd:b585:55f5 with SMTP id d9443c01a7336-2beb069c13dmr130581535ad.8.1779650928470;
        Sun, 24 May 2026 12:28:48 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:47 -0700 (PDT)
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
Subject: [PATCH v4 27/36] iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:58:10 +0530
Message-Id: <20260524192812.1196549-8-sanjayembedded@gmail.com>
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

Use devm_hid_sensor_setup_trigger() to automatically release resource
during fail, unbind or removal of driver using devres framework.

This simplify the setup, remove goto, avoid manual resource cleanup in
teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index f611a10b92c5..157f9204f422 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -328,8 +328,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&gyro_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &gyro_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &gyro_state->common_attributes);
 	if (ret < 0) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -338,7 +338,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
@@ -355,8 +355,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 	return ret;
 }
 
@@ -365,11 +363,9 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 }
 
 static const struct platform_device_id hid_gyro_3d_ids[] = {
-- 
2.34.1

