Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F012313523
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650913; cv=none; b=Y+BSRrwLrmd0RPJvDNR6t3QGHPcjyko2fegb9F69WjMR47d6dnHTdywjlzZWw9UfpyZ2Ab5FA5nFSAzYjWAkOHt6DYbyB+fUJTnoCzHrqkRz0m33WaMGMs+2fcbOGwPHBsp9L39xSeKaJx7CT7eBo7cR9wFlCSUMyhpS6XfKu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650913; c=relaxed/simple;
	bh=nw7SwQ1l1nFZsuBDD1Cx23RcHzPHJ8ppExun8H0RbYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1NQJ10/V2pBgEFC1vzopjEsZM6QJlxFqVA6VZdn9rEFEzg/YIFQO81GQfMxNw7p5CvMWoRBPAZFz/X0fC/shnxzekqe0N8fSgr/jBmNj7pT4uwwyl2Btv/eRXPVjpQS7AqC82UMDBXA+3bZEjZRQquVCeGmi+2HmBoxs3xsNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdw3TpRV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdw3TpRV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b9e9a6802aso38341435ad.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650911; x=1780255711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFSkdTSQypKHAxtx4UgSnAMWP1eHogWGV+jnb1N+RpI=;
        b=Gdw3TpRVOBI8CQuKfcyoJRagimAc6XfT0xz4kZ9+pCHvxxvQ7li1KGGk/qDCCNdUc9
         c83xJytnE/RWHWTvyzA/n/nk0t3SRlHuk0CzDfTcGSGC5BAJ4Sya3DMVAwhl3UD8jkln
         aeEK+ks3aSQGfSTmhJWHpnUpzheEJhSZc1PYaxx4N5UwaruvB61Uv7Qgvf+jDtD+KRsr
         RiB7+z4viohDu7oEpAndHpITFNeEKJnIULTBbsZUSMzKg/aE43+FwDq77tee5bzhZGxO
         loVAb8wq3jiz7M7SyYS38irLy8LGPW+aMkqRUZ/9fdd639zkFGibrKlNybQzL9d0FIsj
         oAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650911; x=1780255711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XFSkdTSQypKHAxtx4UgSnAMWP1eHogWGV+jnb1N+RpI=;
        b=icb2g5RBWQg83J+LJHUM2POtT1AN5VhC5v1twuyZ6XVQgVXPW/tctQuV6lVCeG9/28
         TofX5BcSv6rPjBS9apQT0iAbOy4/ITpbXecdXecJL5iEUDGODGuHXpcqOemH3vvcylHD
         GI5260+0TE7jkrut3wTwizHovreEQwvneIAC6fbj52o921g2Ey5Uk6ZFyBD/fEwjiwRP
         KjPB/iu6d1Lqtt6nX9hIq+jPaTVBAOBm7yR3mlpCgcIxDTY5xHsAgsCFcoh41Bl5kQ41
         QPSZVylNz5NId1wQ/+a6Fz5i8aTxjtxVq0xMEwtXm8oSwJVnb0LwonrpZ9W6jdwpHKld
         hN9w==
X-Forwarded-Encrypted: i=1; AFNElJ+9NsfzgfT+NvkVrYPWnv8TjiA4Q6azmH5NPqW6GuZdP0FXE9QXN/NqDML0lFMV56YyhXrscCBfhNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MrcbZixiSEndImUNGZ9IhOi+lUdxqNtAFh8oLZW4u8oGAXE6
	w/2omElWX8eTRo/+IXQ4MDFGp2VLdGM5AdZHS9c+m3aLUOSEx4PExYfJ
X-Gm-Gg: Acq92OEOleAVI9pGHLR53VB/e0dLLwU34umlrKig925lo5r8FCngXybrhS+OILlfPky
	lyW/OjwMfJtsSUs15SS513lCZp49BTieZWiZqXFZO2aktOZ2P3PGQLYYlhjCcSUywhwXmRJOdrc
	7Wl0zkJSOgw1lSfkv9R2UlCxZzS79ZDuoWuD9XVpaavA7V2ol3sSG+/+TSr+sbY5/+nf2DNW5Uo
	OKaIhdN5+NkcDkiFzJVMzZjzqQMlB1sTz2ad8cVClowK/mqmtRfTQrZYrs7LmoQ/nAC5rYsqG2y
	d/8lA+LVsIbmh1Xm+z1wU186E5V0PyhzjEVFv7E3N7NIC00uJdnx5DiYOXx/fuEt4a1EO8Pf2df
	RSxEGkgYWJLm8EkalkiS7yg0lOhK8Wpo5yLvxb6IT2EzDBfTtMVnlCfmmx4rk/YetslMCEJewcq
	Aqa5bMtWAh+l0IMBdPIdA3lN+BcZH8RYBhSO6L9w9aocuPjYSm
X-Received: by 2002:a17:902:d50c:b0:2bc:78ec:54cf with SMTP id d9443c01a7336-2beb035a83bmr136372105ad.9.1779650911417;
        Sun, 24 May 2026 12:28:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:30 -0700 (PDT)
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
Subject: [PATCH v4 23/36] iio: position: hid-sensor-custom-intel-hinge: use local struct device
Date: Mon, 25 May 2026 00:58:06 +0530
Message-Id: <20260524192812.1196549-4-sanjayembedded@gmail.com>
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

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 .../position/hid-sensor-custom-intel-hinge.c    | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 0ba9d2d43913..34c7cf734018 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -263,13 +263,14 @@ static int hinge_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_hinge_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	struct hinge_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
 	int i;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -287,12 +288,12 @@ static int hid_hinge_probe(struct platform_device *pdev)
 						 hinge_sensitivity_addresses,
 						 ARRAY_SIZE(hinge_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
-	indio_dev->channels = devm_kmemdup(&pdev->dev, hinge_channels,
+	indio_dev->channels = devm_kmemdup(dev, hinge_channels,
 					   sizeof(hinge_channels), GFP_KERNEL);
 	if (!indio_dev->channels)
 		return -ENOMEM;
@@ -301,7 +302,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 				 (struct iio_chan_spec *)indio_dev->channels,
 				 hsdev->usage, st);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -313,7 +314,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, indio_dev->name,
 				       &st->common_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
@@ -322,13 +323,13 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	st->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &st->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_remove_trigger;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_callback;
 	}
 
-- 
2.34.1

