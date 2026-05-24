Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E3314A79
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651005; cv=none; b=eNeiBYdyjFW1zad3mX/F1hiESIYFmicpSMpJX43h4dAxzbWOiDVtbbR8s//rV8R6ysBKhEtBBi+BghJnVkJFCfUqAblSJXdFEqPUIB/ykdYNfjE+U3BT+5JfYiDMTo2I6T5DiacmTYrbVqTBxQNp3LxaU8jf1DQX+KFlRkOzFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651005; c=relaxed/simple;
	bh=M2CpJ3xtzToTWZ0nDbiz5lluQfYt2acasvX6J510RzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4rA235Nju++cauqaOnXeQVdXEB7i+PgbffCt1wUTDFMi2K3GMNp5MZ7eutLANzXdgJENtBvJn2SeXo5F3j8UPEXHHM1Yv5l4dh1Yjc6/ZBBn3xwXxWH/dAvwdCfOatQQnxVl/I3Pl2+8t2mf1Z+utDWccsrVC9qQPbtp9e5Ce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC9M9rw8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC9M9rw8"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2be75f658f3so40597645ad.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651003; x=1780255803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz3QfcZjdBXZKKQx7sSsyUwoEHT5drY36P7DpKzPpO4=;
        b=WC9M9rw8lMU/D1rq6hUdBpJI83i+GSLsRcbE++1x5wV0rNYRjlIfTH6q/vauyKw1W5
         4VPc2hOBduUB+pEuLCKep/iRJMvxuRY3QijpQowhEe3uHN3W/j074HC91GjQId9o6GZ6
         3k9wBdTBPsHW8tmjL6hnaKMVC+17jQr8bCyf7Rbu51+pKcQehy7s63KuCFuIkolYObws
         9rF0yE3FIkpsuvOlrcosxwd2DhGFBzuhUvvC6/Xyfsr5hsZnXZ88mZxE3OqqPUNVXH4T
         kV7XL2F/x5z0gb2u2qbUfXPld9m+xKje9clZNH/5t+uoUMSxy0mxZq0BLoknGSdyWvyj
         nO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651003; x=1780255803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dz3QfcZjdBXZKKQx7sSsyUwoEHT5drY36P7DpKzPpO4=;
        b=OuKKngWwEezNBO+/aijzn2gGOxI6ue6zwdpJ9ZW94RB6leJeZqZ7ypBkC74IJ3bLIX
         mglp37VHwYS6R9L3AdW/3ZnJGdl7wrfmx7KC4Y5ZtF+jovI2sbnl7z7fvnfKaIVjPvWs
         CXjWlgQDmNbfooG8T6jNTsReA4zFMu2A7N11BdLEFUnTilgFwiUJdNVaPhOIxGGhjqEF
         VOL/qfk+l3toINy+8RRwt6lokYgtfB9fSU63gGutRPYQSLwGS9jBtJwpfPBg8jNjGGkq
         z3gxjdZRyWcU6dVMGh0pQopwSfMcsvU8piSeE1Hfi436iOVugVVB/d4MkvBCegb+FCVS
         E8aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PIN8g2ZEt9sD9vSYcedjD5OGKd4y4gxR7+q2TO+UlOLFspDJ9zQIxRbrnQcDY99c2AbbSxb2uc/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyBLnPzsyliqu9HaNONiJEM1T0uWaYLCAEAuGoiwwigX3SkYA
	1BzlQQ6XfVzJ9BRw9G0T/T2xUuJM//AhFrsII5MU5Bavdeuzv5ZdHsvS
X-Gm-Gg: Acq92OHfInRlWzp3hD8NPwxDcTOcxs8HpadzXJp96FLha/yzBvn+Zf62OA2DHhFkDov
	/8WoQIdA4F9h0wO4yo5Qai8iP3zMdqeNPiVHQIi3I90uds8+/w+pu//R7rwcWluIefajolhQPjt
	Y8/6ptrCia5lQdKUXtXToqvkBXxHDaa40Wwc3j+gHncKSIXfGX2qBHbAPutH5dt4Pfirw9ziSuR
	ji7WP2Ts5c0//FCU80aiN5gEbyygs5ZnkF8FsADSzrLbUAdi7fei+apc9wDN8zixYzeXIsZMstr
	yxqGIUzrQI3HBHcU2wOuEsJeMrOIqueu96EsVPd6nDW7DIcchHdMGBDFW5O6MpCf+TE4MPlWAxn
	JaSat4BNKsxsSrAaqcdK5Yw15ln96lao2FW0eFNDT9XlFcmmbZDh2hymOwq9jHtW5OyYzJFxCC8
	tsfBXcV7CAbYjknRnerZpbHje2O5CLDlIiAj3WJ6jB6Pf2ZB8X
X-Received: by 2002:a17:903:2bce:b0:2b2:4260:109 with SMTP id d9443c01a7336-2beb074f776mr122688625ad.23.1779651003116;
        Sun, 24 May 2026 12:30:03 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:30:02 -0700 (PDT)
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
Subject: [PATCH v4 33/36] iio: orientation: hid-sensor-rotation: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:40 +0530
Message-Id: <20260524192943.1196773-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192943.1196773-1-sanjayembedded@gmail.com>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com>
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
---
 drivers/iio/orientation/hid-sensor-rotation.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index cd9fe74b5b30..28336c40403b 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -325,8 +325,8 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 	atomic_set(&rot_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&rot_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &rot_state->common_attributes);
 	if (ret) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -335,7 +335,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	rot_state->callbacks.send_event = dev_rot_proc_event;
@@ -352,8 +352,6 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&rot_state->common_attributes);
 	return ret;
 }
 
@@ -362,11 +360,9 @@ static void hid_dev_rot_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct dev_rot_state *rot_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&rot_state->common_attributes);
 }
 
 static const struct platform_device_id hid_dev_rot_ids[] = {
-- 
2.34.1

