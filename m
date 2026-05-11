Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590046AF12
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521505; cv=none; b=pFy5TVyQv98OGG5q97sD/kfgswKa4Y3n/2zhFJMeKHhCtBXNwvHiCaV6hm2zg1/WNn2eL9jepj/DG0BwZ2RSZQVkoEq2hGmRR5UrLComTHjTCI9ansszGcphi0NM/gZigNExR4t0LfT+YnVwTrOZSbCsAXOup/IDHe3mU9G86JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521505; c=relaxed/simple;
	bh=aTUwaw1cZjKNO7pd1qP0S4T7HG4+2wRyJbUWydgN08M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKbBT3R8RkXIX9jhialW1XC4v9lcN12xE3l3qUr8xwbPWOfqXdRR7MS9CRNO/4Efj21uScFjQ83Xui+6eiHvj510RtJmweEaFMoW4b+TVZY0MLLnE+239e01Fk07Nl4XAJqLmKf9BXdpyKxTt8NqLISerzVzL4gitKz5PuZx1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iugoT4zO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iugoT4zO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aaed195901so22471495ad.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521503; x=1779126303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4zRyyXIwuf/G23ISEa4BernDl6SyQJXsQmJd0MnDOM=;
        b=iugoT4zOwhqoOslTvEWq6jSQPZdUlKnjUWLn9zojPyzSJM2BNwOEP0W2MTmzeGayzr
         qPt32qxJLKwU/pal7vstzTQBbnnPcDGqne8n9L83xHWl+535q+Xedj99DQdApNHTCB1/
         127+JD+ottbZmY+NvNYbjBM3y4XMkXZMOT4L7doO0ea8+NI/DjNYCFQ7PIpabgifRHpb
         GyzS66UbupAcBu5OuK/AKiR+yHOf0DEXk7L6ARN0IkC46iaO93LX0GbJM3Cn3w3cf43v
         zHkCEF6QUW/72hm4irBWn+zGU7hYZTH4W2WU/s3bwusC15cG4dWTfYvYOsO/ytMHjlr1
         BSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521503; x=1779126303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4zRyyXIwuf/G23ISEa4BernDl6SyQJXsQmJd0MnDOM=;
        b=ByfzMrD0oz2zaFISlbfL/TiyXL062+z9mI4WaE9d6JaJxbsDLQe5qjsBbVQZhVVODX
         i2gtYyRMFMLSx21Cw/q3fpX/5YKPPooBvElX2rlBnRB/Yc170OblIwn3ApKpRN/QnDTA
         e9hqxdTDEDTb/gy9m3vjl2OM3aoC2laz1Fp+d1NOvQg/C0ZTB0aYO38T0P7ZlD9LbKEK
         Uq3EOIXuavb3G17Wjo8ND41Oc1QNM1af75dqTtjrGw6cr9UqdNuoHV4a43Xe4xkgOY/g
         yq9ErLtSuA51gnkBrqofQdXBwCdX2YhxG3gDSFXiXWHTBBkxswZpyYfdrGDVRL9SniMY
         UWWA==
X-Forwarded-Encrypted: i=1; AFNElJ8TrqofYyuHP23jzFohCOhPEXvawextFU+sPN+wEv+cNNZDhLSdX0oj9IVlR00WOYYaFPRpi+V03mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABvaUhr9uUhAJANzaFJkHmy42GZYDiULOTzFYIUF0W6k2ZaBX
	6gRGWrl6Dn+YL8lxmQd/6DCKCP3a72lEmSJVtP1p+CeaV/uU4VXZp5ze
X-Gm-Gg: Acq92OFCcyvv+o724Uyl/Y+hBwwBSApWT2PjBL1Vc0fPwH5KqhU3hPfa6yPMiMN2SjC
	uZbr07x75dAJ8EcjNwCVo7FYSAi80/+kiJL6xFm4bqrja/ysOg2THg/ivJ6/dNhDb8xdfUeDqbi
	OX9XUp4hfHaDBPldxFD7nyNQxtMVZ2QOavZsRwaCgFVOH6PnS0jWALqCQVACkbavZY9rhqYnFns
	GsRpNRDkn6CF9Czcwn2wFOOpSQe4a23VFC2QaR8NMNxQeg/ScDJ/hzcCVSez2pTfKThl56HzTkF
	hK3JIt0nsDGfL2GgIepxu0PaMT5SnNAfmRnyAdP4Jdgu9zL3ZF2FUUXK4/RtEa+4pcd0tat3y/K
	9vBN/+xEGhdVGLKY4lsOUPZCtMSmA/I6UiAI3JiNYzaodr3XqJVMzu7T2bGqxoPQ3hfnBi7m7Ul
	G9ECgx4iNP0BDkcTWKJjKC//pV3svVVBJbAGEzfn7HQj/l5mBxcATa0IveF23vZvmbZSSkyyE/z
	xRzZqNrBdDi9Sd29IlNkhvsal8tXDC1R5itYUlvZLNJvRLloWB4ALap5opuwgp5p1GzJtE=
X-Received: by 2002:a17:902:c946:b0:2ba:d97b:4baa with SMTP id d9443c01a7336-2bc7aa202dbmr97909805ad.20.1778521503394;
        Mon, 11 May 2026 10:45:03 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm106838425ad.44.2026.05.11.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:45:02 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org
Cc: ak@it-klinger.de,
	andriy.shevchenko@linux.intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 v8 07/11] iio: adc: hx711: pass trailing pulse count into hx711_read
Date: Mon, 11 May 2026 23:13:32 +0530
Message-ID: <20260511174342.123820-8-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511174342.123820-1-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
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

