Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501413502A4
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441585; cv=none; b=KPycFqQgowkRllRdbxWToZyjB46q4KxCYfd8MpwO7fA3U081CTTvC3YNOWDZqQgpzkRjYT6e0iqo7XVBIxJnM/5DANR61pIS7POQCkI8NDkknOcx8yt16nPBFkjmv66l7wZ14P5AajEqYwV2Redfz4l5mHhfDnBR36l7YA9lLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441585; c=relaxed/simple;
	bh=xXaxi51qGj7aWurvmfktAlX9UTUq1LtX72gN1BATBxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n981kIDWFveTKeg/hwUBxLRLk1itJ9r3W1kzPAOcA9Hj3LkqL5wrMXC418NgzDbxjavB2ebNJGPYsZ4bFgqUNl8EWudL5kTAeIvusX4tPjV3ObLcyOn4t9qhDeem5AgrHfnFxcVwYHprLODLWZxCxd3TTlQCqAnPTy1jIVYrGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OirhAIjf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OirhAIjf"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b24fede2acso80311245ad.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441583; x=1778046383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxEW3u9KIKQo+IcX8Gj4fVHnzWaGq05CdwSfKooXYVY=;
        b=OirhAIjfm7Rhik0AuLp0Nslvu++fvKXzdfigB4laAFx3VXS+PZLc0FJX8GgKZu8j6h
         Z+2FIGj6HW248w5gHn3fsVwjD2MCV6HkQ489hlWKWmhXD1szT3FRVt4GBguAwaovfUIq
         QEw5SjQ08yj3cgCwz2hu2Ujj7RrJ4Fy6oMggwsJnWteR+joHPQBpoLA3urq1j4BojVgE
         ND56zx9ewilRLsIKugQfWaxOSKexMFSerIpoVe/GkIDh+stobQokFqoebUJ6LYJij2Q2
         64m5n98dpwg/5weJ6V/z6s3U9dFe6ZP5pS92cCHhLliinjNVbufJxthOxeHYnXzFhwhw
         dxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441583; x=1778046383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxEW3u9KIKQo+IcX8Gj4fVHnzWaGq05CdwSfKooXYVY=;
        b=YKZjKk3fa29A9uZp+yoAhchuN8tlXrLhklprq1UHxglPxNhemD8m7Vuggj0S0u72cc
         b71lsq9demvtGkjl61CGncK3klJJq04NH/LTAnVptHpv3QeeuJKdkIWoNzwQTB7YmRbj
         tR04Cm7mzk+US9iAOkBlGzflflzuCWtujvIsueVjYhIZUcW4+xaaASHQ0EwzJZPAWnA3
         romTmkniiQG7tI3d2HrwILSudSvx6BygIZ1FTKTYW7nxXaeZvoRolc0KtLwbteqgs9k8
         RCZeGuirj8gWKqPptFilpq/UTZKVSR7A6iVg96PsuomJCGvSURsxsp5bbNWKRn7yHi7R
         PWcg==
X-Forwarded-Encrypted: i=1; AFNElJ9hWZDYdlCOpp/A5n6PY4qHNecJp2SeCsaSaXzAyHXOREGAhQvOR+d+I3ivUL5WAkx3CKCcIsuCDCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbhrpgsKuyb4B+Fr0cZyiaK1XtcMR6FKUGFpU6K06orzskwk9
	U7T+Oe0pTqOqvTwjvgKZ5BgazqUMLSA4m9XKq9zBrAyZkdxOEyziRZQE
X-Gm-Gg: AeBDiesKi7sT0yaBfG1GQZP+mhdAJgQqFOJFPIPwxmxe0L3StYAg4SQ9qgmsLVzOe7I
	X6diapnheIaZQTqPr+G0An9n6zs5Qvo9ruBV++NGF+DZWNV7h2zcpgNAubAXlRsTL8hGvzJZzib
	bPYg1Mo9BLGy4j0UHykjfRueHRn7xrFaPhGBPkQ5PjadPHVvxiMK1mMMjY0gjpx71Mw9ihBSmiD
	bleQIxcqH8N/8EbaJ9AHW+TgyckRHlEHeluSxaBIKW+e/3u87q41UNEjIzxURSQbs51sRoeQo0I
	xZtx6dPiqwP26qAQ36Sz4s5MZrlbsnd37RQdASCS+mXHx0N83iVeGfS5Zx0LpjLliloPm+E7wcQ
	WZkJaj4ETRzwK4m0Dea3nIdNu5Jbf83RlYvNkhW+Dl8jOnIxfb6k2tGObww/gzSi3qWggJmcZbh
	LkUfNGZmXcCabB0noqEN6PuxDDUbLKOjMOXMfm16tOpjl+ghnbPqx+22dzuvSAhu1HDWRGc7ju1
	dOjaMGNghTSvl7+PCnKq5t1CLzWgOFXgT41NgDbwoH4RWvtdA==
X-Received: by 2002:a17:903:380b:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2b98733776dmr22390335ad.13.1777441583465;
        Tue, 28 Apr 2026 22:46:23 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:46:22 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/11] iio: adc: hx711: pass trailing pulse count into hx711_read
Date: Wed, 29 Apr 2026 11:15:40 +0530
Message-ID: <20260429054544.123862-8-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
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
---
Changes in v5:
- Split the trailing-pulse refactor from the loop-iterator cleanup.
- Keep the loop variables unchanged in this patch.
Changes in v4:
- New patch split out from the earlier refactor during review.
---
drivers/iio/adc/hx711.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 666f64284a0d..d85ff2f4a3dd 100644
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
