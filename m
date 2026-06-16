Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29842EEA1
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605610; cv=none; b=jbm6VnrgmvddqymcaeIa8iJXs7/k8xNSkwAJTZ46YVzo0wJUBryl1v/YG+GVh2bcqcRGwOri1Rq/wBQ7A6QgyViyQ+QS0zJE1RVxHa7+NNh2AsgKfWvHc6ZqU7uiJYsiAKPkR8d+tm9amzuKdlz2c5R6xh0mA41eJKqIUD1G3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605610; c=relaxed/simple;
	bh=jzsr4N2PXoaGh3nytUh8ty5NcM5P1Tj8CoCH/K0NwPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7aYQLSyDl40Om//ieU8aZdPiQEk9vaw3wsZleBdOvzTfWMAxNO+XRwX9droA/R3tAywdGHwlNG7TVL1QisiWCKUlaEoJKGglqzVUCzkDFjuqQGnf5tURv8m88SxjEvTURESdydVtypKpBvQ1CGBVStuSLqRVcWcgEJ/j3mw8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYd/74wl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYd/74wl"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso2319766a91.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605609; x=1782210409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MemG8qP9RZ7LJ1ATTvsqbSJhliIZXG+V6FyiJYPAZAM=;
        b=EYd/74wlGYgiPeLGxu+kuc1YxphjTH4+NybFXRvsODw87a8HK+oDo6qy9ay5pDLanA
         rPlWas1xh9e7lPI1nSfz6I1MjsTi2yO7vcMnwFsVSD9M3dbGiANYuXXX6f90QSNYjslv
         NJCret9D6kgg56/LdBkWIW49yjizh//gk+KPNnTIh/ROXrvmwDVGsGGpyihCXBS5gnUy
         xnqwp90RZ6C+Cl0PTOZW1izvVeXtvu6kf7Mut+5UwKTFIftrDRfaGW6nsHIhrpRE079B
         LwUfGotOYm7VzNR3UnBPkIZMSVUhkzz1wu93PIuR3zZ+gGFbV5XhoWT0geSSTwq6a3wb
         AEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605609; x=1782210409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MemG8qP9RZ7LJ1ATTvsqbSJhliIZXG+V6FyiJYPAZAM=;
        b=I84IZGfDNe/i5pIxSb7cjcgeIdN86R5mLX6+ZWxQ8ZBf76Y0pLrUnvQR9QP/O2NL8Y
         EplCZkZa3kkow+rB/cWu87nS0ZtUVZjTEBcumqqt9ONtFENFT9Sfc4qraDOETF1RPzGF
         JTs/cr5PgtGuIFwwGaCIZ2CKuvAF8fm37fsSIYwOCf3NXaE1eLTw0kYtaDG8wTyUNN+s
         yBXHzFYZENEBIisd+aGXX0YvbVtqqiXqL/8XOxS0ffsLz5fjYt0Fwd79jOVbiXX5p0eZ
         LYq2V2zvD3U7CuiRmkrNd5Gxskd1sGXLNcnSP5CQ97S/pgwSRaAa8Kk9BWRSbeLZvI3x
         MJLA==
X-Gm-Message-State: AOJu0YyB3zKJ4KGja+HiWIGB4hxf/FwWvsLblNkh1LcvqQIiABhEZhw6
	Xd3FCRL6beSfFKZKPRfLEHiaESfOpuHKCmkgTJu3v4MxS8HZepnbwQI/
X-Gm-Gg: Acq92OF+JFY8JO5D1FbkTAPvHh9pzulp05S6usMWe8vC5ifFqsqKUi2Qe3Syef1zUw8
	7qPho1WYMQjSggIo2UD1iHL9gr5euiSX0RTcwQhuSvArrU47gNFKKS/iULES7Q9ie1svCR97Rtt
	XYhsPQPBd13wXAoTYlTKNoMBiIqoarEr9xoCqTH5JTz7Dr96Lmd2ACR1gX4T87y91OghVoiUpmx
	xI/eJyL7uHzd5uG5DOCVOreLmDjURc1WhkAbxH68/tmaihgUxJtn2RT1chpeviIKLW+8iFH+9tu
	TjGK1DOqPZIbuqqzfZm0awdl/dqozAptvZQUiVI2aZXyBHA8ICQe/25r1D8OJxzA6ll264fnYt1
	d1WGYpGfvwWAyXCsLTinXTicQZyTzs3ZuTH5zciKoamK0s6iwn5PF0Qs4/iLCkYvLzQmUG2eW1k
	C6BKrAd22rY71qUozyMwVxHF0ZQInPtIwbPgmz/6AEkOI0w+of
X-Received: by 2002:a17:90b:4f88:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-37c5284102dmr3071838a91.9.1781605608378;
        Tue, 16 Jun 2026 03:26:48 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:47 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:09 +0530
Subject: [PATCH 04/11] iio: magnetometer: hid-sensor-magn-3d: align
 parenthesis for readability
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-4-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Adjust alignment of parentheses to improve readability and
maintain consistency with kernel coding style

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 78 +++++++++++++--------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 23884825eb00..82507297c55b 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -135,9 +135,9 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 
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
@@ -167,8 +167,7 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 				false);
 			return -EINVAL;
 		}
-		hid_sensor_power_state(&magn_state->magn_flux_attributes,
-					false);
+		hid_sensor_power_state(&magn_state->magn_flux_attributes, false);
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -229,10 +228,10 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 
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
@@ -270,8 +269,8 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				void *priv)
+			      u32 usage_id,
+			      void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
@@ -292,9 +291,9 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
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
@@ -353,11 +352,12 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 		u32 address = magn_3d_addresses[i];
 
 		/* Check if usage attribute exists in the sensor hub device */
-		status = sensor_hub_input_get_attribute_info(hsdev,
-			HID_INPUT_REPORT,
-			usage_id,
-			address,
-			&(st->magn[i]));
+		status = sensor_hub_input_get_attribute_info(
+				hsdev,
+				HID_INPUT_REPORT,
+				usage_id,
+				address,
+				&(st->magn[i]));
 		if (!status)
 			attr_count++;
 	}
@@ -368,18 +368,17 @@ static int magn_3d_parse_report(struct platform_device *pdev,
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
@@ -426,8 +425,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 
 	*channels = _channels;
 
-	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n",
-			*chan_count);
+	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n", *chan_count);
 
 	st->magn_flux_attr.scale_precision = hid_sensor_format_scale(
 				HID_USAGE_SENSOR_COMPASS_3D,
@@ -442,7 +440,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			&st->rot_attr.scale_post_decml);
 
 	if (st->rot_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
+		sensor_hub_input_get_attribute_info(
+			hsdev,
 			HID_FEATURE_REPORT, usage_id,
 			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
 			HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH,
@@ -477,11 +476,12 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
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
@@ -491,8 +491,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	magn_state->rot_attributes.sensitivity.index = -1;
 
 	ret = magn_3d_parse_report(pdev, hsdev,
-				&channels, &chan_count,
-				HID_USAGE_SENSOR_COMPASS_3D, magn_state);
+				   &channels, &chan_count,
+				   HID_USAGE_SENSOR_COMPASS_3D, magn_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to parse report\n");
 		return ret;
@@ -507,7 +507,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	atomic_set(&magn_state->magn_flux_attributes.data_ready, 0);
 
 	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&magn_state->magn_flux_attributes);
+				       &magn_state->magn_flux_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -523,7 +523,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
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

