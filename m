Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179F39EF2A
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321475; cv=none; b=lmchELWHfxZzW8O+BLd0QUbuM/OEQ6hsAuH7Pw+q69Mn34p1he3KYjVUvUglOfcKVdjBr1Z2IZ3AyMiP1dESJxeJktu6mZljZyINBYCdvcYwXaYIgqRbcqidoDhiFxOLpkdu6gi2V7B2d6yyjXxinWptE57UmS6JvnrNi5SdXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321475; c=relaxed/simple;
	bh=q+dOw9JIxaH4UadvQHCm3a9EV/WB+WLCsK+NOBMLDn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWTe7X2z2aCPqHOWHf6W822CbiK6qm+vs1jVhzlXMMVrN6vwOUL3Efn3lvgHB+iNNKLOX4PsjpWLaRCwz1tOxaeu8ShJooUTK0ypy3JY5tmXVDTx+WN9GtAhSehySnw0fUuwkxwr04LZJOET8VKbMaqd4qoa6Fkx8Sl/RvqiMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOi22OTR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOi22OTR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b9705613ddso18025835ad.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321472; x=1778926272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZy8osW6ZxoFBcwJGDv5RLWlWq8U4K/6eriZ633rrUU=;
        b=oOi22OTRulSOhM/5Mir17nGm10LCJ8shftEm2EErlf8TfhdiaDKMrcbH52w/hBCzTl
         WPZmflndNfWlEAoa2xubUeWQ7qDqWtyGiXyw5i46ZIaBk8oL2YSCsCCP6AYpzLz7m9i7
         DAKuhPZQXqsaty6wxPZhwewn9snpeGhXa4++7LRCENzMB7UUDu+ecy+bIF1xLuHVQY4I
         V3Hkjrvy2aH4MW5GqHAT8KK0k0FCXBTH0MUt4XdOFZZ0Yy+1hYQvp/ol+cfR8h+3LZVS
         fNg+HbFIq46zyOB30raOygEkKUS5LKzZHISrHBryLDc/ut7q/IS1NP0+kDfowNKEK2SF
         Uxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321472; x=1778926272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QZy8osW6ZxoFBcwJGDv5RLWlWq8U4K/6eriZ633rrUU=;
        b=sMAC2O6u79gJXw1asxz3w+v8CJgl8ifTWPE2BAAwNU4mw/q1OJXbnyiI+YyFWFYj4E
         A9raQBV7nspbLPAD3Th2tcSQ/TSzXypfEPgqHnPNWYs9NXhxW7IDxSwD7YE82OHp9vhM
         9sD7BVaJ7WtJU1eUAdyqrXH0FAzz8iV1GsjcykjeqxLFCD4/ks/rieIUKT3wrxCC0Ysa
         Jw84b5wBjeXLlWugIT+tiDgVYD109eqFzxt7gNZxBqsGFL0sDmbxG0GqLG5BRyaVYso5
         rWBEywRbRVLyJdoX97nUUTL0Liu3w3bjPlijiSmNaBS/CpWpmulqu5xx5R7XXvjE1U1C
         2yFw==
X-Forwarded-Encrypted: i=1; AFNElJ8e0V8yipOgD1zbVkpsUimUQ1m6gNXR4LgzzchLzKU2BKzeRZrbs57Ad/JAuQJPEQmej6WHp3bDz2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAK2yE9Bk0E8xwUbJPrhGEgXkMf0XahrsnOPgwPGjCe7Tr6PUK
	KngRteN2flC+PH6aHY+JssZOSPUPtcN/HsGPGqONEWwtjs18UEKGXTWF
X-Gm-Gg: Acq92OGcPy+MUcHEs0xU+k5kzFJ0YknXtKjxERuJ1Uo4WH9f4C88ijN1H/EHEHzGol2
	qLuJvSTi/Ce3upzbkZ+HA5YVgwCQqYJ0BOsYoJ7gM6wH0Prt3A/BafJSodwMFhwM7xOYJQgLq96
	y5TxtLUlNWjHa/DKFLHqNw1/PbLIUnLwMMicPkPIv7ZOzVpjBZ280eywykWsyuO0DIpd+gfy4Qz
	1hm2OoQB6OuzXWhXFKBAPZ4eCUTNre517Hgs6THHIAP5Bw6EMxbWTRBZmuQeTeFcSQvadAuGaIU
	FHS5aWbaHbog/LwU6pSTwScwdtWYyjpCJZhsZiL8KQQz/yRr5TdI3wD90CyIj2AuhAEXYR8SyIp
	gY65T2osmteHO1zosGiuy9NlQItp/DGFdugyt23nnuTf2jQ/eFC4OTGSh0OkS3UBB4JyzxFkb5q
	F/IvZyXgt8x8efGfS9NAGzZxf9t736AJsVFLcGBTb1bo/4uG7F
X-Received: by 2002:a17:903:845:b0:2ba:bfc:76a8 with SMTP id d9443c01a7336-2ba79290621mr119308095ad.16.1778321471744;
        Sat, 09 May 2026 03:11:11 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:11:11 -0700 (PDT)
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
Subject: [PATCH v3 6/9] iio: humidity: hid-sensor-humidity: cleanup codestyle check
Date: Sat,  9 May 2026 15:40:37 +0530
Message-Id: <20260509101040.791404-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/humidity/hid-sensor-humidity.c

CHECK: Alignment should match open parenthesis

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index e580a2af9562..968dd8d4bb35 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -45,7 +45,7 @@ static const struct iio_chan_spec humidity_channels[] = {
 
 /* Adjust channel real bits based on report descriptor */
 static void humidity_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
+					     int channel, int size)
 {
 	channels[channel].scan_type.sign = 's';
 	/* Real storage bits will change based on the report desc. */
@@ -55,8 +55,8 @@ static void humidity_adjust_channel_bit_mask(struct iio_chan_spec *channels,
 }
 
 static int humidity_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
 {
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
@@ -101,8 +101,8 @@ static int humidity_read_raw(struct iio_dev *indio_dev,
 }
 
 static int humidity_write_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int val, int val2, long mask)
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
@@ -127,7 +127,7 @@ static const struct iio_info humidity_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, void *pdev)
+			       unsigned int usage_id, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
@@ -141,8 +141,8 @@ static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, size_t raw_len,
-				char *raw_data, void *pdev)
+				   unsigned int usage_id, size_t raw_len,
+				   char *raw_data, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
@@ -159,17 +159,17 @@ static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
 
 /* Parse report which is specific to an usage id */
 static int humidity_parse_report(struct platform_device *pdev,
-				struct hid_sensor_hub_device *hsdev,
-				struct iio_chan_spec *channels,
-				unsigned int usage_id,
-				struct hid_humidity_state *st)
+				 struct hid_sensor_hub_device *hsdev,
+				 struct iio_chan_spec *channels,
+				 unsigned int usage_id,
+				 struct hid_humidity_state *st)
 {
 	int ret;
 
 	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
-					usage_id,
-					HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
-					&st->humidity_attr);
+						  usage_id,
+						  HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
+						  &st->humidity_attr);
 	if (ret < 0)
 		return ret;
 
@@ -208,20 +208,20 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	humid_st->common_attributes.pdev = pdev;
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
-					HID_USAGE_SENSOR_HUMIDITY,
-					&humid_st->common_attributes,
-					humidity_sensitivity_addresses,
-					ARRAY_SIZE(humidity_sensitivity_addresses));
+						 HID_USAGE_SENSOR_HUMIDITY,
+						 &humid_st->common_attributes,
+						 humidity_sensitivity_addresses,
+						 ARRAY_SIZE(humidity_sensitivity_addresses));
 	if (ret)
 		return ret;
 
 	humid_chans = devm_kmemdup(&indio_dev->dev, humidity_channels,
-					sizeof(humidity_channels), GFP_KERNEL);
+				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;
 
 	ret = humidity_parse_report(pdev, hsdev, humid_chans,
-				HID_USAGE_SENSOR_HUMIDITY, humid_st);
+				    HID_USAGE_SENSOR_HUMIDITY, humid_st);
 	if (ret)
 		return ret;
 
@@ -234,7 +234,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
 	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&humid_st->common_attributes);
+				       &humid_st->common_attributes);
 	if (ret)
 		return ret;
 
@@ -242,7 +242,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	humidity_callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
-					&humidity_callbacks);
+					   &humidity_callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.34.1

