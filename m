Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93130E821
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650901; cv=none; b=lADUWN2zvBAjKx3UUhZD71waWzWThH5EgBx2k51GU1ylcnW0EOjAFA/Qdu8Gy89NrwkUR7lT+C1qXAr78OVRMLmOw4A1kNqyGUtDbhfGX7xZHzI4XLHaEGMyUO7djzwvP6NBCS2y9s9f+P77ZeSgA3kmVMNfWC1ClmpY9VyssNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650901; c=relaxed/simple;
	bh=7rWPsgjTg6A5zkgLqVjcHYBm51EamTh/i0HBYIDLjMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZLZp3KDvW6UnwCfnbKRMe8Pegxu5rFBPvpH04c3wlUVb3H3Ypx/Wg9DcEolwb0viPxp1XWLpRw3kzH4CG2z3rV0kH453ZsX6t0bwWGKMlCcSQdajZYcJshSko2/7+k5aTpoy1igBaaZnjsW3NnH32PruJ4aYRQrXreiDpKo8/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/zYQCYt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/zYQCYt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba928852a5so61934745ad.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650899; x=1780255699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJQ8EdbnMqqdWkgNwl8JeFNzEKvmTn4BJmvszB6ugw0=;
        b=W/zYQCYtrM4IaYpg7s9iUWcNuQnqItZ1/DEyCTabgEfveMvEO2l1lI5GRRZlZrHXYM
         2DdynDR1Q2AZWCIldcOftJq/2kSvjiti7jk2naDkB4H/iRxfAqaEwJ/AtIJhegDQEdo6
         7JL0KzbIrMqwwi1ggcLKPo51mInjyMpXvmUinCGs4D0y15ZJuW4gOY0MjDajGamnW29K
         o2X+UV2ArKN/QKn/fHbJF7iFmTFkR34aE6l3CGnPVlrfrzEhACzLM2rHiK5CjFj76nLp
         eb2GUuz3PONn2tmAqbrrIhvP9CjbeRH/j1Ui5qNecE0ecn0bSsIlVFZol6jOdCaeDMzQ
         kezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650899; x=1780255699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJQ8EdbnMqqdWkgNwl8JeFNzEKvmTn4BJmvszB6ugw0=;
        b=SZz/DrBfAdbc2XLhIL5wbTwr2FJgh0VgPj9P6HgmDlTUvmDkJ02z04BGciO0Hoe1PK
         fPlmgXzBO+96Msemh+aylzxAsegnwqhZ5FdpZGwGP8f6q0aKPhbu4GdjSmfYSMxbvS5a
         z3qJaXCSJvkNzDq6b/dozk+/874Waqsjsyyh4WEgkWI1MbTa0UbEbwENsqEHnx5ElCYA
         kfW2yRNmV+DSSQzDQxy+2SGCU04G8vPOi3/S4/0BlH6w9oZ9vFvY4gMyZRigLvRSqFPK
         jFIqA5RAGFKzVc0DAIAHoCUKtWDkzYM5KqQqhE5h6/RT6uOtiw24o9P6oywXAfBVIU8g
         /mbA==
X-Forwarded-Encrypted: i=1; AFNElJ+c88H+R2hPXV2DgeMivIqb26TXVVT6wkxGoGaYbw8vS92wknX58b7M5Wx1NIX+TCKeQKhr6dSZkaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cVNZ40cFjM+6yjEpuNUx55kStiMM7rQ9TFFEP8Hekv2L3maa
	w4etQRBu9tsZoGtPUDBz1jdUsloB1CV2QfJzNOKpEgzh2jKew94TViSw
X-Gm-Gg: Acq92OHDUMcVhfcTqpGTy8vKSbT7Gjymk61tBCq8E6YauNwBFhuofm+EAMPB/a+VUhB
	aXaJp3z9ti0zFqqALTbOm5N69UUjqatUHCGgshBzeX5RTIzR2hKIw009L+5FOIUYVKqVEOB2Zn4
	z7DonEhf02zTUXdkucFpNa08KHx0azPNT1y2Q51UqBiML4pwuyh78OssvV4lb8O4K5xklECrb/a
	BFZPF/MtcA0kJB2zu86p2cXdnTa/9lRrm5CL5meXefAOdK9HI2D+EQW7SHicJVzfLp8z8FpkdoV
	1KeyfaBBoNlO8XdaNibCmXGepJcvAloH9JV7dmcAqdGfieTnwGK7c1TJZ3QaRW0iHirkrGaZoTk
	ZjqczMDcICublgWtclR+Yw58ykRd3QV4D669AV8nk2zsILDfEyHveqjLjBRj5U/XR6Bn81wFkhP
	8SPMHCM5gS6qo6BjFPUwMxcrciz2ErfiXlWQIrXfvKV7sFoer6
X-Received: by 2002:a17:903:4405:b0:2b2:b117:1e1b with SMTP id d9443c01a7336-2beb0758814mr123561725ad.17.1779650898727;
        Sun, 24 May 2026 12:28:18 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:18 -0700 (PDT)
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
Subject: [PATCH v4 20/36] iio: magnetometer: hid-sensor-magn-3d: use local struct device
Date: Mon, 25 May 2026 00:58:03 +0530
Message-Id: <20260524192812.1196549-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 36 ++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 73dd2e7768db..cf08503ff1ef 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -352,6 +352,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 				u32 usage_id,
 				struct magn_3d_state *st)
 {
+	struct device *dev = &pdev->dev;
 	int i;
 	int attr_count = 0;
 	struct iio_chan_spec *_channels;
@@ -373,34 +374,34 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 	}
 
 	if (attr_count <= 0) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to find any supported usage attributes in report\n");
 		return  -EINVAL;
 	}
 
-	dev_dbg(&pdev->dev, "magn_3d Found %d usage attributes\n", attr_count);
-	dev_dbg(&pdev->dev, "magn_3d X: %x:%x Y: %x:%x Z: %x:%x\n",
+	dev_dbg(dev, "magn_3d Found %d usage attributes\n", attr_count);
+	dev_dbg(dev, "magn_3d X: %x:%x Y: %x:%x Z: %x:%x\n",
 		st->magn[0].index,
 		st->magn[0].report_id,
 		st->magn[1].index, st->magn[1].report_id,
 		st->magn[2].index, st->magn[2].report_id);
 
 	/* Setup IIO channel array */
-	_channels = devm_kcalloc(&pdev->dev, attr_count,
+	_channels = devm_kcalloc(dev, attr_count,
 				 sizeof(struct iio_chan_spec),
 				 GFP_KERNEL);
 	if (!_channels) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to allocate space for iio channels\n");
 		return -ENOMEM;
 	}
 
 	/* attr_count include timestamp channel, and the iio_vals should be aligned to 8byte */
-	st->iio_vals = devm_kcalloc(&pdev->dev,
+	st->iio_vals = devm_kcalloc(dev,
 				    ((attr_count + 1) % 2 + (attr_count + 1) / 2) * 2,
 				    sizeof(u32), GFP_KERNEL);
 	if (!st->iio_vals) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to allocate space for iio values array\n");
 		return -ENOMEM;
 	}
@@ -426,14 +427,14 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 	}
 
 	if (*chan_count <= 0) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to find any magnetic channels setup\n");
 		return -EINVAL;
 	}
 
 	*channels = _channels;
 
-	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n", *chan_count);
+	dev_dbg(dev, "magn_3d Setup %d IIO channels\n", *chan_count);
 
 	st->magn_flux_attr.scale_precision = hid_sensor_format_scale(
 				HID_USAGE_SENSOR_COMPASS_3D,
@@ -454,7 +455,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
 			HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH,
 			&st->rot_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+		dev_dbg(dev, "Sensitivity index:report %d:%d\n",
 			st->rot_attributes.sensitivity.index,
 			st->rot_attributes.sensitivity.report_id);
 	}
@@ -465,7 +466,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_magn_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static char *name = "magn_3d";
 	struct iio_dev *indio_dev;
@@ -473,7 +475,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	struct iio_chan_spec *channels;
 	int chan_count = 0;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
+	indio_dev = devm_iio_device_alloc(dev,
 					  sizeof(struct magn_3d_state));
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -491,7 +493,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 		magn_3d_sensitivity_addresses,
 		ARRAY_SIZE(magn_3d_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 	magn_state->rot_attributes = magn_state->magn_flux_attributes;
@@ -502,7 +504,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 				   &channels, &chan_count,
 				   HID_USAGE_SENSOR_COMPASS_3D, magn_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to parse report\n");
+		dev_err(dev, "failed to parse report\n");
 		return ret;
 	}
 
@@ -517,13 +519,13 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &magn_state->magn_flux_attributes);
 	if (ret < 0) {
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
 
@@ -533,7 +535,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D,
 					   &magn_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

