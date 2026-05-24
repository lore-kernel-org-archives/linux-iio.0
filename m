Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB030FF2A
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650520; cv=none; b=Deww2t01brc6lFCd07XOwP9veV9035N9AQJe9XKZ6cHt/IQGA6/quTCrGMU/jyYS9NFxAXcUTKYAwOeQHFn2iBc04MGEjJjC17Nhnz2gn8TI7C89zkQ1Svnf2P218p/xDNfW1m53DTZ17FHNUH1tS5VCFp+XmavV/xmQZzVaqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650520; c=relaxed/simple;
	bh=pngA2fHYLMbsHAfUmVEEPk9zhqxA+vmpgzYNUf0aeHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ty8dY6JShoeZWVf8O4rneM1wVjWqgA2XWuReYMpfRd+wHbJLTsRpEqRuDWBPa+MfloCndKB5fXH0frVDrOwMLCq9KscMfIp/iY0XLM1mcrEHp9WV2bTGH45gshzncCB2mmGcK5ZwhZY1zS2jnsjCaKTU4+5NpFbisiPIsGCZBeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfI6Gxs2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfI6Gxs2"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824c9da9928so3908996b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650518; x=1780255318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbrYaV7tYmRmUQKs4LOTtNhyw3TLJ8DpBeCaGDcrhew=;
        b=RfI6Gxs2RezYmWGH2tfIYiowWiJdVf3li1iTWlw2MSBerybiIRfCwQrUu8HlbQn3Kf
         87oMOd5HOQfWqgDMsiiWRlddVLUqibiodrQVOXHX6U+Dtay72mh0NaDm8tx6xzPQyZ6f
         t4JOd7cerUT7KvpGE13Hnp+9w10WIUod9f2Yftu8P+OsmQ7Hftd31VKw+j8EFHL6hrwD
         u1ntD5CmNXhcnL7ev3ghgcvtibZWjlr7BeI+jsTQlMMDYw4Zu3kWmpVkQjX6w1wcS48Y
         j+2zuPwQuUo7YUhX6TJLB4vFoaE0ZfIMQkdbC0BW0KIJRHL0vQICVecqtLuEbiRZsHDU
         CaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650518; x=1780255318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lbrYaV7tYmRmUQKs4LOTtNhyw3TLJ8DpBeCaGDcrhew=;
        b=mSzPzmp9Y3fLDeY6KzQJWRNYLYLflj29AsKxgBS1dQ+ERVSISqkREae2EsxOPU210C
         O1ZFYh3pAbg1PlTSNVWBVIlEutHZAU9wbeeCK464ga3S05fhxO7XXFDQ/t/Iqs6niiB5
         HkjJxlCzVQ6MGIfb0EtN1aJXMnoFBrDbFYD36smhWm5ycsk5LfziRr1FTOfhx/ihgneN
         Zm/0mxCLJBIid6NW9Kx2Z0FNetJx9pCs/YIQMmu4KDXrXQ1pTHSTuQka3JCjwGw1Ez2K
         MxAuuYa8A5Hdw59ySyAEMutg1xsgNVr9jtSByttstyjkPV75gfXjLy3Q/fWFfP3wKnO9
         bt2g==
X-Forwarded-Encrypted: i=1; AFNElJ+/tQeeDBmkRdt98eMd5fGHKLt9iYfMkyRGiqMq0Fb4xmoueW2b81Owp9etxDzwd6uvd+tfpspRyCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoP3naciFL06agLX4v2zPooQg7T+Osh5k5hVmp/d5Ap1suh8K7
	zRIQhY8Uqs1qYqGcqClcfp5i05j/0Y2NezUQ5jlot0Pl/qFAeHCvVWq1
X-Gm-Gg: Acq92OFYPa92bYQg/9jTVWz7WWnQDfGTzAa32Gas60AwTK3TuRDQtg3UYNrkQufu8ug
	opu9FKzWBPM+CkbOxDOs1YsZ9CjV7AMFhuIhyr/eeM9XV/snxhct8yBJh15QQRIqVg1vkFQBssN
	Y8fe2F+gUdkn0zuIEYOKP7ZULOjrXCe9kUs/bw5wmPgCixzzz6n2jaZ6ZvoNd2lPrz+OcN0t6FN
	3f4JtPU1Xs/SLWjRznkMYJqcZYJnQUz5d1vhCH+0NcyZrTuHXxnAfLuP+0vx7g7QjJpMam6GFvJ
	/BeIIx32KPPvRreTMH9qz3+RD25BZFuo2y20kycWK6blvJlzCEdD7jQ2eRp5KjS5E2U63nlyhRW
	6ie0igQ1IIwPhPjJhoqiHm7i6dNq0RXC3j+vmEmo204lgIRa+7+kOfPLxFpsTXa07kydbj6C3P8
	xsm7XEz1AaLLxLAZYl/pJQ2KW7A+8ODiv2wNPvMX+hduIYm8pIssfBkd0Qw1o=
X-Received: by 2002:a05:6a20:c783:b0:3a2:7ef4:81ed with SMTP id adf61e73a8af0-3b32900b4c8mr10913751637.49.1779650517893;
        Sun, 24 May 2026 12:21:57 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:55 -0700 (PDT)
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
Subject: [PATCH v4 09/36] iio: humidity: hid-sensor-humidity: align parenthesis for readability
Date: Mon, 25 May 2026 00:50:32 +0530
Message-Id: <20260524192059.1193716-10-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
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
 drivers/iio/humidity/hid-sensor-humidity.c | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index be2338d5f407..6fed019f4099 100644
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

