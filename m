Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770A42DFE0
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605606; cv=none; b=WeDeY1MPVN+FEmC8u+fEs7W+DUk2VkvdgkIfFEMjpqPkZyPF/hioBRH6esb/0ihzsDJPXiSsmddZbjzinGB38mEtD/02QbUf9wYLAyWMvJrjSiQBfIYdo/ww+YkmUpK5Upc1YOQsAx6Nafd+NvYAO4RVpx7H+WPvn6rNs0Rd+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605606; c=relaxed/simple;
	bh=MiXs6ePEn3sZ9NekuT+G1yyLqwahKPdD+k71OxHWGho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9UjUgLmd+XQZ5+IoJ/cseB3Juvd6WzR/9D8m8T0euttRelIb0LsIO9O0F7P6ObU/+Tcfc5U6NUn7reQVhpxfVSRHQg/AoEbXdSQ0Kf64t6q5CrxC4UKgyG/a9eOu3baGfjNMvnBrElBxxsLx5kRZa4Nqqb4wtIrrX3scgnKW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4/gAHZ9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4/gAHZ9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso3424962a91.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605604; x=1782210404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHaDxa79OZLhZ4QF4J86e2LofDpLMZ2WbN9y5nNkozc=;
        b=s4/gAHZ9QJrrgeAA4ML+fiUgs/HpOrGr9vUCUfejYpbw69cG8HHtqyJBFYJQNswroW
         4pNsyKUJcM5EpuLtmyZ5HOWlffJbeTOJefQaDvdXU0kI4Bd6xXd8hsXX1d667qCIvEbW
         zY/cXBBgPOqrUHhHZKZq5zp173d+hgPPb/j9yVk9Iy7BilujTrApodM6ZnOPAEI3+4sK
         svjevqa24ssKyFp61sC/nnlj0yIYUQ33jEHmpQMMtQ9M3xFNCvj3VgO24tQNyTjJZxaG
         Nj8ld2uXGAo15TzbX8wQSTCh/i+D+r9iT8ZpksT63TfMgP7PjnDIn5u0ZOBugC6is0L5
         Bheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605604; x=1782210404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHaDxa79OZLhZ4QF4J86e2LofDpLMZ2WbN9y5nNkozc=;
        b=lo8ij9ait3PlbO+pUggLvAkHexBu/ZXxabUkycUhdOcZqwuKHw7dOSSg+EhngcLYIj
         rJBtu4Fme0KSAvHMtEhskF522sTf6msSoE/cU3EucaozfJiYHbTgLNAMJJE1tAwSt6WQ
         lBB41SM31dEdJCaXRo4+M/OJnGA7ne7IXksJYxH7H2YB/hdX9B2Iq3TWEJZ/amWl/eaQ
         WvBAAyQ5a2Vv8AM/lX253tfQCHh9zhSNhY/2+Cllh45PS12YjXjmxVtjbhC5v27GcVNA
         z7LptDNShgREXsHHJU1xDZu0H0xRdR1I3PwgsUwntRajL1hR8/uwtaoq7id9pnxlGmpZ
         dUOA==
X-Gm-Message-State: AOJu0Yxt3I/wd5JItzX7gsn+h3p8N4uEi28HbWI05dNHUsllG9d2amoO
	FZZWmJirQDkOHRr4byDzX7Cdyx++AUJ/qBxp1cit68lYnuLe1jgcQ+1D
X-Gm-Gg: Acq92OFiX/kcveHlTVZQnEKwAvZ/JCgySXpVqZnmDs0AuSqwdTcXAdxOgZgVSPVrQVy
	62AhvuwtLrb2UAntyskKAIyDqlANK2ylUB+UPxeyuUV90JNcsewbvxS+7AEv6jk6X2XmaFn9If2
	GuDPrEjCrEVIiyKzS8RxKVxOZI+52DpYiFgW5v76kcCE/+kg6MaXl8AnT7EkPJXKbC9iMNrtBnm
	pc6fTvTbXWgmKabfpoLxGSC8IX1TKw1Gd6DXlEklLxaxu+2zuqpFbgVhI0g4cd4478SRdP51U1S
	D38NbnClrfXCu/dq6z1Dgr9qe+XtVahJSMUra5JFVxqOw1d0qOzy41Wlfsb/IX3rwsgAj9IfiWK
	hluu78mmK/GQysVK+ABLgBoYi3NBrX2bQgtW8ChyYt7oydOQixa3DCIBrJUiycu1JIUq0jcnAKT
	N0ffJYGnE9Gtz4toopmpBTZZ3wDhiTtpDSTnw6JNkblB3SOLtA
X-Received: by 2002:a17:90b:57ee:b0:36a:d51d:42ef with SMTP id 98e67ed59e1d1-37c2bd033b4mr15127550a91.13.1781605604338;
        Tue, 16 Jun 2026 03:26:44 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:43 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:08 +0530
Subject: [PATCH 03/11] iio: gyro: hid-sensor-gyro-3d: align parenthesis for
 readability
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-3-0cd544286575@gmail.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 58 +++++++++++++++++------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index bbca2111e79b..fa604cf26d06 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -85,9 +85,9 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 
 /* Channel read_raw handler */
 static int gyro_3d_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2,
+			    long mask)
 {
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 	int report_id = -1;
@@ -112,8 +112,7 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 					min < 0);
 		else {
 			*val = 0;
-			hid_sensor_power_state(&gyro_state->common_attributes,
-						false);
+			hid_sensor_power_state(&gyro_state->common_attributes, false);
 			return -EINVAL;
 		}
 		hid_sensor_power_state(&gyro_state->common_attributes, false);
@@ -146,10 +145,10 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 
 /* Channel write_raw handler */
 static int gyro_3d_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2,
+			     long mask)
 {
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 	int ret = 0;
@@ -177,8 +176,8 @@ static const struct iio_info gyro_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				void *priv)
+			      u32 usage_id,
+			      void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
@@ -199,9 +198,9 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				size_t raw_len, char *raw_data,
-				void *priv)
+				  u32 usage_id,
+				  size_t raw_len, char *raw_data,
+				  void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
@@ -240,11 +239,12 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 	int ret;
 
 	for (unsigned int ch = CHANNEL_SCAN_INDEX_X; ch <= CHANNEL_SCAN_INDEX_Z; ch++) {
-		ret = sensor_hub_input_get_attribute_info(hsdev,
-				HID_INPUT_REPORT,
-				usage_id,
-				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + ch,
-				&st->gyro[ch]);
+		ret = sensor_hub_input_get_attribute_info(
+			hsdev,
+			HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + ch,
+			&st->gyro[ch]);
 		if (ret < 0)
 			break;
 		channels[ch].scan_type = (struct iio_scan_type) {
@@ -254,10 +254,10 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 		};
 	}
 	dev_dbg(&pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
-			st->gyro[0].index,
-			st->gyro[0].report_id,
-			st->gyro[1].index, st->gyro[1].report_id,
-			st->gyro[2].index, st->gyro[2].report_id);
+		st->gyro[0].index,
+		st->gyro[0].report_id,
+		st->gyro[1].index, st->gyro[1].report_id,
+		st->gyro[2].index, st->gyro[2].report_id);
 
 	st->scale_precision = hid_sensor_format_scale(
 				HID_USAGE_SENSOR_GYRO_3D,
@@ -286,10 +286,10 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	gyro_state->common_attributes.pdev = pdev;
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
-						HID_USAGE_SENSOR_GYRO_3D,
-						&gyro_state->common_attributes,
-						gyro_3d_sensitivity_addresses,
-						ARRAY_SIZE(gyro_3d_sensitivity_addresses));
+						 HID_USAGE_SENSOR_GYRO_3D,
+						 &gyro_state->common_attributes,
+						 gyro_3d_sensitivity_addresses,
+						 ARRAY_SIZE(gyro_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
@@ -318,7 +318,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	atomic_set(&gyro_state->common_attributes.data_ready, 0);
 
 	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&gyro_state->common_attributes);
+				       &gyro_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -334,7 +334,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
 	gyro_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
-					&gyro_state->callbacks);
+					   &gyro_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
 		goto error_iio_unreg;

-- 
2.34.1

