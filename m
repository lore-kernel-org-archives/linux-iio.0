Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379C42B738
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605602; cv=none; b=jwsocT4dgS7ANM3QzSpjl60t3OZUfhcqWRm0FVTDJzSMWi/d7MUME5tranLdmTXSS4inLOYhP1K+iBa205SnW6mlPyU3caalX8+KwADaIpuHwwv09MxnuYJcGsfZIe/nCIyE9FUDiHeK76t5WEcr0ZtL8OwhPNdFHZV9+p4LFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605602; c=relaxed/simple;
	bh=S7vsbQcmxFK2DZ7J3vjjMBdZbeUK3xotLrcnCZE8t5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/Wo6J+f4S7LApXf5qd17pwbGSxSPRBiyMlMaarxg39Lkjdg06F7LF8ssad1RdgyJf3BEDu5EVr4TrUPzEV9C1nBu6dUfdA8G04He2P63N79hm3CXhoaPfFugCurPxzcfRZDXRnjDTA5vMkM2t1/mKgP4M+eN5yCX/kiPgKAEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pavfju4P; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pavfju4P"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37c6cd1ac98so966a91.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605600; x=1782210400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZ2UpxRBqo3gnb6ENR+rrzwxq3mO87vUY2r55BGS238=;
        b=Pavfju4PITEknFf/T8ctwKjVvPlx28uft9tFt0mKAeYYoG0ATxNCnT+cldyfWnj+Cg
         Rf4wBdI9/uSy6V923+pSjSRDE5z5P65S2l15pIl9+f+XddG+vYG4KNk6/Dzp+7ZhOdby
         FOW7h/Eu40Wh0mWXf4Bkf/35TzPsrNLNPHaY+z8mzY+ccGf/Ox0pMgu4anQ4q3wp9vNt
         gx9muJBQHfPZQQS1ZoBePlrYhwa0m83RBpwWcdNB9cfiuNMxW9GXPec2FO9KiiW2xGrs
         U7Wm3cmyy1kv58T81GYuqiFleHO24mP+CXLPay7KdsUsTOs7XRhmUSsdYGGxCGo1cYNR
         a3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605600; x=1782210400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZ2UpxRBqo3gnb6ENR+rrzwxq3mO87vUY2r55BGS238=;
        b=rHi4ORS2N9cUjf7nyLHMou339hiJRs8pddUZSIRRzmabCYWXk33wbn0LMS35Z+5t9J
         IMLPO9+zL0nSUocyECHc/fkyM+mjUtBZY91tdxO2A9oVBMbtxwIVKpDmncfP7gE853z5
         8xw56cblB31wCTB4TXgsEfMKj6eQOItRN9JTQ3No46VNs+oEU6HMXVUh2myeJVESbukS
         MQwtJJx6iQvYqMPmmF4jB7anjzzuPoPVKLJ784MLs15pKgcMFBsfeLF70uiOReqvTwmO
         FSb/pqgeF7M/DUqHLsJFOcCdrfPs8vYBdLSwnq5DolPFrlaRkQMzpcdoCBXTopyl0toi
         LZGg==
X-Gm-Message-State: AOJu0YwIpO6eWMPX9pEzNc/Tj5IlG1+RtGHgYV5lNAfFWMEtGsQu8iqa
	bOVC13cwDS19K5h6y5TLFU7Emb7h+Q/EWDlm1J7TtCyEfYX7tT9eCymZ
X-Gm-Gg: Acq92OFhP52jH4kkcAfCoNqz1KSE/pMCDFnjCq+LjQWFdncOvFpf4Q4Y9bpWSYpE3qO
	BJdFnUulV9JOauMPR/gmJ1aafnJug6pO1NUmcM/v1EfvPYDGATq9GdXXJwigJdccxgXiHgNk77N
	fhpGsIVDfSr6Iry8kVvO70g0UZT0MlDV3wnSjNsL7ANnBJ8MAlAdgJYvN8ZPMrJKMlyelFKJici
	4wfmg8HsSY5BmFxj0l8QzOMsIQzf8+4jgE/NBL256BAkZ1h1TiUG5PPnr50eme+yVg2liW3fmJ8
	qKbNdh2IXvx0o7FvVWkMTTsYJz7uTvbiye/MbLH3z+vSqFZRo4FsJtiNOGoVOXfxk4+6DfB7NFD
	YnpJN3fKromZKmUJOguv5NwTTF8wMeL34jYxI3RwJQdBbB23/nJ8MOxOu3rwlkf0TYV6g5zCiuS
	y07qGbBDt5nHy6nK2lj/jGSll7rzumHjLNgCPpXLLZuvfWeAv2
X-Received: by 2002:a17:90a:7309:b0:37c:18e0:90ed with SMTP id 98e67ed59e1d1-37c18e09300mr11985014a91.4.1781605600396;
        Tue, 16 Jun 2026 03:26:40 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:39 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:07 +0530
Subject: [PATCH 02/11] iio: humidity: hid-sensor-humidity: align
 parenthesis for readability
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-2-0cd544286575@gmail.com>
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
 drivers/iio/humidity/hid-sensor-humidity.c | 46 +++++++++++++++---------------
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

