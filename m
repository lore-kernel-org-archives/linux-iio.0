Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEF345CDD
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650803; cv=none; b=NlrVlk4+Tkm8BPR6Xt4KxZBVZ0OoJVtID4dncDcXc7OQtSQgAoKX9lRU4EdVCfDqLgZGhtK/FcDJJ7xWOCOCWrn2ptrf5hJDukyvtVVCHVY71zd/QXonFmzDDNzyrOYi3wQH1dSljxvDRdKXkAF92bC87Hqq+PeCNapFKDIG3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650803; c=relaxed/simple;
	bh=rwwj8kIUs5U4hXXdmczdq5loN5eahLFy/MFIpHjNRi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBr6rwMNCPnAxDEtyNmRmcj0Vr1qnhzTez2x6vb7rYqbRG4r1Fze73GtCHJ1PUwpQ4pYB/kpwsJh7DEdHV+rNkREoilsACjFqJLxSusRA5IT++NFZLlMMgZrZcD5+3IUG/NzucalERc/6gcg+sjgwm+VxvUuGOKwqGnSePY2ROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyVV31vs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyVV31vs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36a35e4eefeso2501762a91.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650800; x=1780255600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfsq2qmaqpO/Q8c6X+i6OJam7GzEO/qR4jyX30fJ+Wo=;
        b=DyVV31vsXjthMnep0MdlPLPp5dggrF45P/RgYYmoLiCCtTCjEZLRfh5+l4kt4EHeyu
         eQxqwIxxosUOauXHg5KFc6gWHJ2mVICnglu0xVvh2MGjBFnCml5zwNQlpHayeIPbxIAF
         4M4QgMYckPcLuvGkSYpKb94l0+ibE2KmIw6vsgK7AyOYGDNtdsnFngXb5Obe7Vhb/ylD
         xFmtlHvRL7l5giOu/X7vO9CgjWFR1v8tsXs+OVxNUkGbB7LIdaP5tYKlYRUvz8dAFVIF
         QlSj0LXz7dUJaKzb/n12cNjiaVSJ0/zpjL9pLfbsmfVIrSs2yo7LaapxU/m5LMc9Dowk
         EZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650800; x=1780255600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfsq2qmaqpO/Q8c6X+i6OJam7GzEO/qR4jyX30fJ+Wo=;
        b=H9ltHnz4HEXx9pm+7z7q0YAE9m7WWlNK4OCgf1kvcqhow5ROHaU496LWj2DaYVKKbz
         NCZC7gGWbvdRk+zWlMa1iKFyWrQTGTrdx+/v/UUgPa8O4H11PQCiQBUv1du4ytYL4Tmz
         XcTIMwIQBtBtknyPnMxbdKdhakb4OdeEBOp1+0KUBTlYE7yBsg5d0g027B/oz2JD5K6W
         Br4RZvlpNT/Nfvgd6B5z6698jfuAaVfL2FMCMoeHfRGILGaHzBgegzZZVAtA1yUbACgW
         Zf2i2LPJrzMGw8KvmFcU/cAv2cE6PX7u6GWgez4mq4uDspJ14U8Y9ecdT32ZLKYTPBPa
         btuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RdRb8TL6lF8P37+Cy/Npe3DwkJ3yLhQe3ON8XtLIY7HEq+7LX5trM6Av97frZ/tzJKJj/LsDagpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxruobDhIBw1RSUYcLelXK35gIhQib6+Y51bkDfTK7tfmGpx2
	pLIESnbXpwrcrbPxfQkbHogUy9EtNGjG7Iu7YFsHv42lAXto8HaRQ08B
X-Gm-Gg: Acq92OFuC4Q4W9HF+9Ew73U6VgMp5ZSsbSwMhdZPVeJ9vW/I9Y6WZNo3pyQ+3aapAY/
	Ym1d9LSS/3sUO3wKrKQQPgRWPcypOzCp1zC6xpSRZAwyz4DUURfmkgR7TOkSgJL58kzSPVsJVxD
	GmWtttGpaAW8zuxDUYFuAUqX/aZus1UQY70eDV3k9XpuDCQrgkGQ8PLZq0MZNIvN0VsHPAki2UJ
	PFfByDaHe3yhRet+DZxE1kmr1Oba0s3ysvQNQQNMB8V3QRroepy0Traia+dY9HbtpfqERIFjNPq
	n87WkAKHPbmlGWetMa4cFiocdoeniwSFXsymF/LLr9gaY2xu2cZh3rS7RJKFyVFQrlYVvfAuLZ0
	Z4qReyK7ADK1TN5724vXAllo/MhCMLlLgM3LC8h25kDMfM81QC6k8Z4LgqMHi04KiI59uM2khWB
	ULbidjcLq6OEAU2wXR3xGrVd9PZe6Tf2mpt0b3mDpcdSV5bBnnSw97IcV4tKE=
X-Received: by 2002:a17:903:19e8:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2beb0628a12mr126739455ad.16.1779650799838;
        Sun, 24 May 2026 12:26:39 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:39 -0700 (PDT)
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
Subject: [PATCH v4 19/36] iio: light: hid-sensor-prox: use local struct device
Date: Mon, 25 May 2026 00:55:56 +0530
Message-Id: <20260524192556.1195042-10-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192556.1195042-1-sanjayembedded@gmail.com>
References: <20260524192556.1195042-1-sanjayembedded@gmail.com>
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
 drivers/iio/light/hid-sensor-prox.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index ac55808f161b..033dace06681 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -272,14 +272,14 @@ static int prox_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_prox_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "prox";
 	struct iio_dev *indio_dev;
 	struct prox_state *prox_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-				sizeof(struct prox_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct prox_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -293,13 +293,13 @@ static int hid_prox_probe(struct platform_device *pdev)
 					prox_sensitivity_addresses,
 					ARRAY_SIZE(prox_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
 	ret = prox_parse_report(pdev, hsdev, prox_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -315,13 +315,13 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				&prox_state->common_attributes);
 	if (ret) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_trigger;
 	}
 
@@ -331,7 +331,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
 					   &prox_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

