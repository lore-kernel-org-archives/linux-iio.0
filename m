Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0231717D
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650938; cv=none; b=JKNnC4ivHJENdYVeZfc38+0YIJP+km5wVfOtPvqcUMMCFTKTTZ+5ycucdlSK9ttFjvweswzSRpHCtgxZIrek2rWk9rnyfuZtbQI1W6Z9H+R+Zv5C6BYkl9VkHB+jhEL0JVr9Mq7tFoqeQwKepkV4X1Y2qGSilXq8NyqQ1DLYO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650938; c=relaxed/simple;
	bh=dXQ1owQJu/NNm3CrwvIAz1pCMf+D4X94TxMHlQ3LOoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGIDwCDhFx+TiPAi9k3tETur0M6sIXPeyozwnFg6VxzF/rD9e9ru9EBw0uvM/ZyFLrlgp3qY/LCdQ9IGdDCev1AI8tMgpWn4Yar7sDJw+Mn+/I21MIP/fnzlx68ZGU1002gw3n2TPqWtUTrCfOTnhTxq9Bc6F/sCfTGVTja7Ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDwH7Xh6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDwH7Xh6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bd80b3aa13so58856555ad.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650937; x=1780255737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRtYGBNh0deiKiXE6TxvFx4+EpkUyjk8HKubJk/jLJ0=;
        b=GDwH7Xh6h4wSZP/UO8WeTwwBai0jz4KPIRZbtL5nuRpP6sR6NtNzMIwzIeSA1d4MRT
         tQu5plireDchKn6cT29IjXaxi7/OlDfPgD0hiW7kaMKHvwIYSGM9ItIgvPX6wJsFk3eF
         yQFLfJPePmjWtSqJitHDADDKp1lwFkv4/m8iF8Lu0BA9NzfQwItdNJk9fXQ/G3RswMo7
         XOzQgRHStNvfMkBP9U6FJjSE+FefCT165tPzkkZfB3hQ5CWpLJOJLDkgeNom/Tn0aV37
         zVHUAt96xO47NaTzTs+TAs0K73+orJysEJKUQ6SB9pXG2yZnNBWPn+n9OH1J/tbOEoOJ
         qdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650937; x=1780255737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRtYGBNh0deiKiXE6TxvFx4+EpkUyjk8HKubJk/jLJ0=;
        b=pmOTEW6Sw56qWy5FP1seUIojRpWiu3fqcJ6yt+gtrQFPAddsJFApH0aaS6DF5dyRBX
         61sxsMJ8DDb/eOYCa12KWKX8NVsibjnuLVQf+pw8F+vYitWfyoDozj+dA9GInEKd2rgO
         7t52jWGXsqn+WAuvc2t7ZbQO4W3ZkPv7O63V8JzOJToqyFxQminrJzvXAaCBY/KK9tZF
         +1DHNv/+bEtgEKSQ1XcXMcdwKt5pWBYLHfhr3v6zcG2l01eIA0IL/ivXt0Wg6mKDxhvh
         Je009Y2X11gW+cCRm73/takwdIKkGVTmr2UBoiF88lk3edVFHyQZZlJvEkAE3hpK96uD
         rScA==
X-Forwarded-Encrypted: i=1; AFNElJ9biQPyyphE0ye5IOX4TlhBRn1mBEYk/816I8jEaaVBM5ex0W5FV73ZLBIoQOPlyvbIzvpzuE07lG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXP7Nbrry67XW8YTOi5kqhDpXVnBat5puti084QnNuG+JdZV6k
	ZVFNSexi4S3RMOd/dR+8GAj+g+B/EmQXtO6wUhi/W2QBQ6Njo+8SnlJm
X-Gm-Gg: Acq92OHcAbObpfC078K6ViJHUAv8+gtBtFGfEncin5776gLhq1u73hz9NlqvxB6nYOa
	CoiH9IjcDvv67z5/hKomqojLH+ZIqPRgHBf6+GuBm5a1+mHHK2dt6EdswQdwC297gCxPURvt4Zo
	KXCoP7JcwxPytyl1Fy5r1ynzpi3h+FbKb2OOROGgOqiOojssL/soODbryESGheBvCQ8FbCOe3oG
	mxUzeQIjYe5vrJ7fn75cRHUQfz/sf8PLQmYcAvIfpfssA/pCgEdQwaRFSiIvOpzSjMjybbsZMRu
	f0o7aedQhZV7x92qAs24GT0qIaeBC8k2ew2WNKC/yJJXpzLqfVWx7GLCiE/Fj8/gauKGFa/KzYJ
	gjQTBnB7LeOgn5DKEt9lHZt8Pno45A4nq31JDKjk58wElWBc7gteNsWNCTC3C9J8qZ7In9vYpJa
	v62o35FVUnvANX550yudpuZplOfAT+zp156WV5Bc1pgu9vuSHgxyEbaKWfBwE=
X-Received: by 2002:a17:903:17cc:b0:2bd:4b8c:fd30 with SMTP id d9443c01a7336-2beb085c6ebmr127671735ad.41.1779650937009;
        Sun, 24 May 2026 12:28:57 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:56 -0700 (PDT)
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
Subject: [PATCH v4 29/36] iio: light: hid-sensor-prox: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:58:12 +0530
Message-Id: <20260524192812.1196549-10-sanjayembedded@gmail.com>
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
---
 drivers/iio/light/hid-sensor-prox.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index eff206d7b812..85b06af67611 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -312,8 +312,8 @@ static int hid_prox_probe(struct platform_device *pdev)
 
 	atomic_set(&prox_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&prox_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &prox_state->common_attributes);
 	if (ret) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -322,7 +322,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	prox_state->callbacks.send_event = prox_proc_event;
@@ -339,8 +339,6 @@ static int hid_prox_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&prox_state->common_attributes);
 	return ret;
 }
 
@@ -349,11 +347,9 @@ static void hid_prox_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct prox_state *prox_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&prox_state->common_attributes);
 }
 
 static const struct platform_device_id hid_prox_ids[] = {
-- 
2.34.1

