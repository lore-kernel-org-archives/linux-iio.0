Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC683E9F8D
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706335; cv=none; b=NR8NynCdg/5sM1XT6c9oD7s/EZcLyPu1QTyi1/t8hjIpGRg2LeNWGPM8+UhbDvEK3I5Ra0oz+shy7PR3XjHII8IRj107GgG4OWuIt/p4sODH+locpUOPjTCxnngIRqc0QzwdEINYu/ZmFZ5XALVyR6Y6rBOHaDumBJHPMJdd36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706335; c=relaxed/simple;
	bh=aTUwaw1cZjKNO7pd1qP0S4T7HG4+2wRyJbUWydgN08M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKwHpkh//oSOfQE8TMDWCb8iFNzPI7hnqm9BxD22y96hBM+U1v6DQebvUOerxXkZRYYayVJItShameIYfCN+7ACa0l5Nm8SSXJ6K57Blz8WyUcXy+nISTxlvxrlvMv5qiLKgZlqWAaKVIajCPB7lAhCQI5jK2rWON4vsV8WWKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g26pvKJk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g26pvKJk"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso6231043a91.2
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706333; x=1780311133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4zRyyXIwuf/G23ISEa4BernDl6SyQJXsQmJd0MnDOM=;
        b=g26pvKJk8kJkKq4DB+Ey2H5NxktwBMySmxYg2LknZX71pD9WGl5QnLA21aq66PIbOE
         lo89xOMrZsrNjWBVd7+n/UE2Y93gYr8m29p5muRUknrKSA3aGXxapxWnRjuf42Qv9hbB
         8W/JDt9s8VVj3/KILDK/605zz7xFcMzZZsTd4d483hXxCk0bkslq4gtViW+awgIi3GGw
         Qo/NwKfsb/japKCVN+5EIgnv8/O/asGmROBG1DyB3FSvw75DV2p2QaeAM/LReCc63W7A
         mOph3eSdXqm2u+zVTe9+HXog2rObT+sT5Gblednrddr0wWjLaRt/pskLm2IoB8LuhM6/
         ncMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706333; x=1780311133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4zRyyXIwuf/G23ISEa4BernDl6SyQJXsQmJd0MnDOM=;
        b=qQjnYMQe1Me6kqOCWkZnyQvK/exNHqfwBur1Mh8qjsmIUD7dxGfyAP1vU4x/PMeBmp
         O7Aj6SO5yd4LZPBttAsrW7UTYgX+v+blf/atAUtvy2IliGo2MlSSCAomYuXTjiBuILhR
         rkJhS3C5rxNvXAWA7H5a9mPw3dkrOmvQWoKZyEoo7xg65hiaZS92HY0S7iFtUOBkEKYs
         42y/9nqmd4cehNn5vRKNlDZbDz5Pt67IbCM66S7YLvz9oPebjoNbTG1XUpY5vzBv4hQB
         StlziFIh9k/eleMWTR7pYUgSudQtRZXuJ3H7lBC/RlLjTM9hCtiXoVqzL/CL2HwW9S+U
         PVoQ==
X-Gm-Message-State: AOJu0YzQcJ/g5n1M+I0TodwlKhu9w9ouU7SvwFYF9JZZ5hviSdIb+j4n
	BdYgxQaWcuNWndckYB18HgB5xmQAr2FjIKuqZQK6qXUTUK3U6371yrcqpO2zFvl1
X-Gm-Gg: Acq92OGltMSywH9UsZd1LFoYqry9NwJsFIk8MFSYQzzyS/WsA/CGBTAV4J3H4vPNExb
	5NKjuMYCxBSYyi7GccebaV68rzSma1ndumHaOLgDFY1PKSgAUzrhVGQO1o6bPJP60mriE7y+8lY
	EB+SfgKD22O8/SA9y8UQU9tQI6wyPkUVPGJkgfqifWKFh/2UT01hY5Ln0/r9Q36p6qY4h3JBMl+
	J4MZCj3CHIH97qB/BwNdKA2POqFRMmtuFXFCsmpXP3W80ZAflXxbQ7yhn6jTPPfBEJV/eWGrXSL
	/YALlXOqLTtJdaBQe4ZwkuDT9GdjAVUrJRJMbOHvlHJrEv1cTy8Ry2mKKu2OH3OamugCAMGzxaA
	Hws8lapnzx4b2e/iaTejEzM4P7SHBQt66+2QQ7f52ArCttEQH1CUfmIcQioioIAoI76Qz78HS1d
	a4IiQyxDtYTTv1EOw4voO9A5GxpLmouOjysTCQDo+O1vvbEUT2sk5zIzwXFFs3Jb3cEk6as4ZF8
	OR4/EkW9z2UY9/RZ6CdaqhQ8sFx75r9OMTD0+86pZm/a+m0skiZ
X-Received: by 2002:a17:90b:3851:b0:368:ddd7:abcd with SMTP id 98e67ed59e1d1-36a678a1050mr12493640a91.27.1779706332818;
        Mon, 25 May 2026 03:52:12 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:52:11 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v10 07/11] iio: adc: hx711: pass trailing pulse count into hx711_read
Date: Mon, 25 May 2026 16:21:23 +0530
Message-ID: <20260525105127.180156-8-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525105127.180156-1-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the trailing-pulse selection out of hx711_read() and into its
callers.

This is a preparatory change so later variant-specific code can pass the
per-channel pulse count without adding a separate read path.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 10ccc69f209b..30e1ce321747 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -155,7 +155,7 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	return gpiod_get_value(hx711_data->gpiod_dout);
 }
 
-static int hx711_read(struct hx711_data *hx711_data)
+static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
 	int i, ret;
 	int value = 0;
@@ -174,7 +174,7 @@ static int hx711_read(struct hx711_data *hx711_data)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); i++)
+	for (i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
@@ -237,7 +237,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 		if (hx711_data->gain_set == 32) {
 			hx711_data->gain_set = hx711_data->gain_chan_a;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0)
 				return ret;
 
@@ -249,7 +250,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 		if (hx711_data->gain_set != 32) {
 			hx711_data->gain_set = 32;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0)
 				return ret;
 
@@ -264,8 +266,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 
 static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 {
+	int trailing_pulses;
 	int ret;
-	int val;
 
 	/*
 	 * hx711_reset() must be called from here
@@ -280,9 +282,8 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 	if (ret < 0)
 		return ret;
 
-	val = hx711_read(hx711_data);
-
-	return val;
+	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
+	return hx711_read(hx711_data, trailing_pulses);
 }
 
 static int hx711_read_raw(struct iio_dev *indio_dev,
@@ -349,7 +350,8 @@ static int hx711_write_raw(struct iio_dev *indio_dev,
 			if (gain != 32)
 				hx711_data->gain_chan_a = gain;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0) {
 				mutex_unlock(&hx711_data->lock);
 				return ret;
-- 
2.43.0

