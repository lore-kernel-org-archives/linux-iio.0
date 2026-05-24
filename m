Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039330F94D
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650908; cv=none; b=eNYLutlA8tQlq9brOsDHc3Ie1szuSKJI6nBWWFw25J9vf5PWphfQj0HZlo1CBR7Q7kFDXGNJfVgNTH+UK/sgpkZDkJ41SGSPoMta5DBV21ADgfORhcHE8niart8h0BcDNSR3NpoEX4WlUB+4JPfzSdrxIFQ4tbqYQblZ3w/b5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650908; c=relaxed/simple;
	bh=/gWBauii7a9+kyiocWw/OgbQM/xnvdd20KRGlAKR+0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RD4j8SUY4vE7Jhti2MzuWPMXZmjYXjwOZiZs51lLnaDPLoSPUqQk5CeA1rmVZgZeaEqXnSKUSU9Qv9Cg2ExAsrPTtxesGiO/68riyst/IfYrKEiCBB8rUFHiQqP4HI7khaef8Yq06PMZEabhjCg4JLYphpEF7wBi47jf0j/nt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qC21faO1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC21faO1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b788a98557so56765925ad.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650907; x=1780255707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaP11C7yPA93ZCo81mjeXk2B41sv1b/en7aEZbqY16k=;
        b=qC21faO113RNUVmaZ7HkMujK5k2TuOR1JbnUU8tviQ4jESxkuar7wXyg03+TbXTw+H
         +AVDvOAlo1B9cOIfOYn2nOToGThThIhgCQZBCYVVntrt4rdqbAl5YAP6+n+7f/Atb7ow
         yCjGtOdtylGPuhUhDeHxQolUNiakhRPnhWZkwDRNIWCayIeO/s6l7QM95qml9XgqV54b
         93WiEm3ah58L1gA4lugqijnbaYrbrFfsbhGVG+gbyiDHog5SDGE1xvBrxsQBh/gWN1i1
         jEtMBdPQmx/cojafuG17XvftR76yg943q3yTLKGWQot+rGZXE4r3vBvPSGmkKZArvUvj
         I+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650907; x=1780255707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FaP11C7yPA93ZCo81mjeXk2B41sv1b/en7aEZbqY16k=;
        b=dp0zYztMi+jQcz40EL2RhyUs676GroeA9lTaCU1RFEZeVnKE1LxJFRY7KfVPI4DLRI
         jW4eJaxx0PMTn0Ip0XXPophdftTl6rDDmiIQ9A5EbZ5inOIpFqsKjSz8VMFeMEJRxTeU
         IasjR+ZfLS/DD1NYna4Wl3aee/OTlTAEnBIakN3RBrpp+FZv4U9uwZU0/yhvp8zLdyw8
         QoOnxZdwKini6FDem/FGeDsX22xZRML1/528/cqnjSDXQZf+S+QzNJ7dkP3+KebXl23a
         LEhKYzsBAQ/+XfBL2Cr0FTKvKrBrMKZCpRRTZBzLinZRcQhwmuvGn2FlrmsCtFeBPIjr
         9+Lg==
X-Forwarded-Encrypted: i=1; AFNElJ+8PhFIneTFApp5WzAUx4xgCpXqpVs8AsIiphBqGswXtUyfyGrUCY3XXBDV8TsmsckptIBL/cmrSvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQpeCDBGb2TFgn4XFCMyZgCLTAMGXr9y7uQsioWDclaB15CUIu
	85KRivKJppTOIo2sLGUwZsReTmb49jlfjnny6Z0Qxs8FV/pOyc5rsv5q
X-Gm-Gg: Acq92OFYMm+uOeVlLogT2jPtq8dHCmISFpSR05tF8X3rVy4xbhS1bxPi6zAUsnXmibJ
	X3x/CziaPQQhGgeafus+Hqx1y6xggtmGzqG7QxbkltoLunuv93e3gi+05L0UyYCSyXWKi7JO5pB
	uZBb1lcUxMyGJoRg/rW55u8Oyk8jj3sW1uAkcXhiciSVVgWeeHJvki2Y4PMb/tB5mYU5bb0vl4q
	khGcUJ+aOJG1y4dY+SLOrhzqLWyMi2OCdlcQLTbUkCoBPqPJuVlMA2sULSLid/HruYUGKJNjcqY
	N0EBRVHiZCQhQAB9h9J+zMjqJ7hgr5LW460mGPc7nXEqthR8GWlTMMEMtDJtBbAZymFDPV+BJKC
	KmpVE2Qd6TPL17L6UE8HMOEAm7zr1nBT+Ezu9ScZ/Xnh8x3aslsK3NHvmwOKdyWJzi9ncWgm7cb
	TnTERrxYg6FvEgv+zOBiFaXPCrKFguKETcIQ5sQv/lhlmkXPSPq6JDK6nqF+0=
X-Received: by 2002:a17:902:e74b:b0:2bd:9803:9304 with SMTP id d9443c01a7336-2beb06cae35mr125521105ad.39.1779650907079;
        Sun, 24 May 2026 12:28:27 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:26 -0700 (PDT)
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
Subject: [PATCH v4 22/36] iio: orientation: hid-sensor-rotation: use local struct device
Date: Mon, 25 May 2026 00:58:05 +0530
Message-Id: <20260524192812.1196549-3-sanjayembedded@gmail.com>
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
 drivers/iio/orientation/hid-sensor-rotation.c | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 20563d8efaf6..332d56757679 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -243,6 +243,7 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 				u32 usage_id,
 				struct dev_rot_state *st)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	ret = sensor_hub_input_get_attribute_info(hsdev,
@@ -253,11 +254,10 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	dev_dbg(&pdev->dev, "dev_rot %x:%x\n", st->quaternion.index,
+	dev_dbg(dev, "dev_rot %x:%x\n", st->quaternion.index,
 		st->quaternion.report_id);
 
-	dev_dbg(&pdev->dev, "dev_rot: attrib size %d\n",
-				st->quaternion.size);
+	dev_dbg(dev, "dev_rot: attrib size %d\n", st->quaternion.size);
 
 	st->scale_precision = hid_sensor_format_scale(
 				hsdev->usage,
@@ -270,14 +270,14 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_dev_rot_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 	char *name;
 	struct iio_dev *indio_dev;
 	struct dev_rot_state *rot_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					  sizeof(struct dev_rot_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct dev_rot_state));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -307,13 +307,13 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 						 rotation_sensitivity_addresses,
 						 ARRAY_SIZE(rotation_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
 	ret = dev_rot_parse_report(pdev, hsdev, hsdev->usage, rot_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -328,13 +328,13 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 					&rot_state->common_attributes);
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
 
@@ -344,7 +344,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
 					&rot_state->callbacks);
 	if (ret) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

