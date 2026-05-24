Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807131A570
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650769; cv=none; b=Tp/2Dz42oxzQPikwBhxv+mzImQemyGDExpyhfGX728njMg76WfKI4kqnF8c+bfLIKDz91MymziNi76YMmiyKbo0K6Q1hbDBEwL8tqHibtHsnAeaDuvJlKr4T3mKqXvMphEqDG3Z4UtwcADrPvdHan21IYiZcNF/6xkr4lE+s6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650769; c=relaxed/simple;
	bh=UbDu/cIoGcdShOF421DZchJgiGKlnHcMa3vdMzr2ZwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdPDDZIG8NhDLGpccmOhOBdvDmRcKJZIwvU1xhrzRzNuniq0rGr5NeogWS5UN/StZw33tl6/DZEs1as0jD1B//eQSrP0rByGA5JF93dJcc9rY0yPBljPqXj0o2AluQrUtuxIVYU5T7MyQEHgIbP0EEX1HXCE9eDFhd3Pvacu9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCW30BAe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCW30BAe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bc763e2ba8so44764695ad.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650767; x=1780255567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWXevwdVOTeEM3Cej/tF5M/+ePHUTYqIX6HZwxRm4j0=;
        b=aCW30BAeSI9sMf+2qjq1Ixxu/lUgahFqeDzmuoKFurjP4fGfw632TEvEnzT7k9cUG7
         rh13qlvwTaqByg6nswZmsy9jn5YI3xdRlMOBA8pJgTDy1jGFijvErhCsVgBNxKJlOR7M
         iZMW4W+6K7rWOd937DDv+eqmbnqPBiYAfUj1CaftkYegfQ9+NBgIRVSwLULqn6a8JXId
         QUIlv2MUN/+lo2Jned6icqWZkUfLf5ful10RObqDN8US+sYq3moo3YlzlxcsTmhwJqzp
         NBUYKQFW0zPb33gBPNn0WopsNHfSCJS75k9zDNcwvjpQOJmMTKerCv/jgS9DaTGm2hY3
         rnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650768; x=1780255568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWXevwdVOTeEM3Cej/tF5M/+ePHUTYqIX6HZwxRm4j0=;
        b=eSnhE9OMpAAR4LG/As4GHwtClgHZLvUdcqApNXiOTQqKdI+Xd+nBPpMUETd7l24YFk
         FMMOL8iRMB+1XgOX7xZhfLtXe+gwg1GYU+d2KrRl04V7h6rpR2I80R8T8eyCh2J6r35j
         xl3EmAXiX14a+3hlMx/4Fs1rzHta3nDXNpUdSmTXhBPHpP4VMqf4VB2EAqvlJ5IuJ8xG
         CAbeLkOe7ZRmNi0GBYlN/mfbVnGjJE4eohKU5SkHle6qap2c2LWSgXY3IWRIHOuO9KPD
         o8IGeyGIv/f8M9b2DDH5XO74VsKqUJrpLjSHrTSoQtpZxX3fcaJWKA4KYbHqhZiV8Nx6
         N14g==
X-Forwarded-Encrypted: i=1; AFNElJ/7zdV75NJk95MmmTNv6pJpoQm3lkZOMlissap6IRtTkjEnvESi341e+X8q3laZRtk/r2zI0L2bEw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClbwzRdU1GALhFBIr8mZ+T6IzkZ8pJAM1BvEOBBAa1TyjxFqH
	NLVJbGZgrvvNuo5HVxTB3MA3oIm9llaCtspbK9TK3SWqehzBIHe/95wa
X-Gm-Gg: Acq92OHFXBUKM7eHvCpnXZTVjWqXAjZ+Yq+seDyZE2d2EQuRvsMROEQ40j1FgGeYTSY
	on1tdC4mEUPahDexCTZ7RqregV0qNQHjArMJND3CdD4jvvHySRKYvmvStGev6tBfF6JDf1m2rzA
	Uek+ku8s5ldurgwqvoxvCym50bmYTMBzCoJRW/+ZVE46zZdnPiWJEl3oYwUtfbuFu5jjxTwXf7P
	w1vav05l92ha9AdKxIe7n2FQLrVyLJzKsps6/wlNQSAxhdlqZRPjM0nkViQt2E7Rj2ULqNuQtmt
	yy82pSJAmnQewDm984r+dcNuyC+BSWY4wS9lke5up+UhbBiwgt/chYC4kqLalwlTkpuPhUEdAsy
	/4ZUFRNxk9pqg5r+z/bRbTLFbOBPwcWMe75UqVGkaOc34CVn5qZGFP5Os9TmFsQDM0UZWimpa8m
	q+8FZf/V4NP86XMLiEMwadlCrliR8TIbDr86jwQJ4r1sTz7B9h3E79ic+OnEc=
X-Received: by 2002:a17:903:2bce:b0:2b2:4260:109 with SMTP id d9443c01a7336-2beb074f776mr122632175ad.23.1779650767059;
        Sun, 24 May 2026 12:26:07 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:06 -0700 (PDT)
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
Subject: [PATCH v4 11/36] iio: magnetometer: hid-sensor-magn-3d: align parenthesis for readability
Date: Mon, 25 May 2026 00:55:48 +0530
Message-Id: <20260524192556.1195042-2-sanjayembedded@gmail.com>
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

Adjust alignment of parentheses to improve readability and
maintain consistency with kernel coding style

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index b01dd53eb100..73dd2e7768db 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -134,7 +134,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 
 /* Adjust channel real bits based on report descriptor */
 static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
+					    int channel, int size)
 {
 	channels[channel].scan_type.sign = 's';
 	/* Real storage bits will change based on the report desc. */
@@ -145,9 +145,9 @@ static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
 
 /* Channel read_raw handler */
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2,
+			    long mask)
 {
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 	int report_id = -1;
@@ -177,8 +177,7 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 				false);
 			return -EINVAL;
 		}
-		hid_sensor_power_state(&magn_state->magn_flux_attributes,
-					false);
+		hid_sensor_power_state(&magn_state->magn_flux_attributes, false);
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -239,10 +238,10 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 
 /* Channel write_raw handler */
 static int magn_3d_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2,
+			     long mask)
 {
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 	int ret = 0;
@@ -280,8 +279,8 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				void *priv)
+			      u32 usage_id,
+			      void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
@@ -302,9 +301,9 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				size_t raw_len, char *raw_data,
-				void *priv)
+				  u32 usage_id,
+				  size_t raw_len, char *raw_data,
+				  void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
@@ -363,7 +362,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 		u32 address = magn_3d_addresses[i];
 
 		/* Check if usage attribute exists in the sensor hub device */
-		status = sensor_hub_input_get_attribute_info(hsdev,
+		status = sensor_hub_input_get_attribute_info(
+			hsdev,
 			HID_INPUT_REPORT,
 			usage_id,
 			address,
@@ -378,18 +378,17 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 		return  -EINVAL;
 	}
 
-	dev_dbg(&pdev->dev, "magn_3d Found %d usage attributes\n",
-			attr_count);
+	dev_dbg(&pdev->dev, "magn_3d Found %d usage attributes\n", attr_count);
 	dev_dbg(&pdev->dev, "magn_3d X: %x:%x Y: %x:%x Z: %x:%x\n",
-			st->magn[0].index,
-			st->magn[0].report_id,
-			st->magn[1].index, st->magn[1].report_id,
-			st->magn[2].index, st->magn[2].report_id);
+		st->magn[0].index,
+		st->magn[0].report_id,
+		st->magn[1].index, st->magn[1].report_id,
+		st->magn[2].index, st->magn[2].report_id);
 
 	/* Setup IIO channel array */
 	_channels = devm_kcalloc(&pdev->dev, attr_count,
-				sizeof(struct iio_chan_spec),
-				GFP_KERNEL);
+				 sizeof(struct iio_chan_spec),
+				 GFP_KERNEL);
 	if (!_channels) {
 		dev_err(&pdev->dev,
 			"failed to allocate space for iio channels\n");
@@ -434,8 +433,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 
 	*channels = _channels;
 
-	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n",
-			*chan_count);
+	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n", *chan_count);
 
 	st->magn_flux_attr.scale_precision = hid_sensor_format_scale(
 				HID_USAGE_SENSOR_COMPASS_3D,
@@ -450,7 +448,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			&st->rot_attr.scale_post_decml);
 
 	if (st->rot_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
+		sensor_hub_input_get_attribute_info(
+			hsdev,
 			HID_FEATURE_REPORT, usage_id,
 			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
 			HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH,
@@ -485,11 +484,12 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	magn_state->magn_flux_attributes.hsdev = hsdev;
 	magn_state->magn_flux_attributes.pdev = pdev;
 
-	ret = hid_sensor_parse_common_attributes(hsdev,
-				HID_USAGE_SENSOR_COMPASS_3D,
-				&magn_state->magn_flux_attributes,
-				magn_3d_sensitivity_addresses,
-				ARRAY_SIZE(magn_3d_sensitivity_addresses));
+	ret = hid_sensor_parse_common_attributes(
+		hsdev,
+		HID_USAGE_SENSOR_COMPASS_3D,
+		&magn_state->magn_flux_attributes,
+		magn_3d_sensitivity_addresses,
+		ARRAY_SIZE(magn_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
@@ -499,8 +499,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	magn_state->rot_attributes.sensitivity.index = -1;
 
 	ret = magn_3d_parse_report(pdev, hsdev,
-				&channels, &chan_count,
-				HID_USAGE_SENSOR_COMPASS_3D, magn_state);
+				   &channels, &chan_count,
+				   HID_USAGE_SENSOR_COMPASS_3D, magn_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to parse report\n");
 		return ret;
@@ -515,7 +515,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	atomic_set(&magn_state->magn_flux_attributes.data_ready, 0);
 
 	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&magn_state->magn_flux_attributes);
+				       &magn_state->magn_flux_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -531,7 +531,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	magn_state->callbacks.capture_sample = magn_3d_capture_sample;
 	magn_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D,
-					&magn_state->callbacks);
+					   &magn_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
 		goto error_iio_unreg;
-- 
2.34.1

