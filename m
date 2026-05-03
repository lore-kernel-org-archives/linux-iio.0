Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E73AEF49
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810246; cv=none; b=q9r0Ev/01m/OAddJIgxzHR2eQf+NcTH9JoMXxNzytbNYyaYX/I35eAO3qGOZUNr852o0ue3M/fyMNbdCcJmfhsR2jd6/Q+F+suHYMrY7X7E98GKZZhh3V9oK03ZOsdEXPjCTxw8a4Js/J/RHH0vKONPxM6AJHugQN1/UCJteEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810246; c=relaxed/simple;
	bh=5i023lPUKhimKsYF9M78AvT6vY5pZfCNtFZKwv6bJVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGprr3l02pNbRLG1XTs8WgEcq0qdef1yBEEbpCtcXfEw7buuacicsAP7NCFTsj6wdiMH4zvJSXHG+sgvS4eFrYOvpDjVZGIdMvxXOKgLeQISiWGvwAqFdiLM5NEe8P7JATGZ7dEaOnF3svBYhRRK8E/s5tTbqdVhICwt8SeS1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBNxEyo+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBNxEyo+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso1700657b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810244; x=1778415044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eXI08ZZvBOZRhVvTrMA+ciVmwUlugzbu9mfoWqF/18=;
        b=XBNxEyo+3IHLC+MKHKhJx65Tltwsdi3YiabT1lR3GqPBfGV7Zq88BrTtGTEXKO6hnF
         IvohGbUnuWApjrAlJdC6sDi9n/O+JDZO30yRdfw773EXHSjzu67T1hkZgbvWg2Ksh2kH
         cJfBljznW6WZwkDYR6OPCriZut8VDfnodrSzf+0CXUdiz7Opo9x1NFpB4q5/OMx1mk7Q
         IEm2NxvwkwHINnFQSayhDB73W9+lMj3nqw/WuLt5Fw7T1Z8oLWeImwuC/oI93C9ggsWb
         34URMaz3VlJ53aeA9I+rBq93lr4QvHrSUe+P8l36N3YJlilVMv5eteV0QmsCILEmEEkY
         7H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810244; x=1778415044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/eXI08ZZvBOZRhVvTrMA+ciVmwUlugzbu9mfoWqF/18=;
        b=tUZ1Q5KJNkWg/VDyTT3F29PJVYuGVRockUQlyR3BBh0H8I5o4taukpVTPWe5wr6BVW
         NJpnIoSt1S9zwUJXLh3XSXiV6Lii/AftSziZfEfC4/C/W2M48JPNHb5BmYwc0BV5Kvak
         SrIT0yx/Uig+LEK8h0TF0X3FyIooTMihOaNcCT448NWnJRwTtK3Y6TXddkpw9Ho339Jy
         8d5RzlyXS3yuL4wfiAOBlMOu/fEGfeZgEfwnetNtNoy6DJaV6XlBiWvvAiQaE9fKrNOX
         RfXnvytriLNIOWANAtFVfPq1Ieu4DaCeReU1knTorjdJlkCvS321lFGaXZZf4lNFhOOi
         4ITg==
X-Forwarded-Encrypted: i=1; AFNElJ9Ktj7IR71poO/HG8U8YfXysFDs8TfMpdpFTeqW99eZfnlkCDHyiQuMt/cia5LhULpaTFhzmPAdQ10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvMrGdK9xU1P6HQoLKiN1IwsNZQtkjKz/3oSUSVUFgVsKn8qf
	lV91nRk23bVH8iSwktR74msftoyUBIvlPwXo/3NDVvP1vxodjYI1ei5+
X-Gm-Gg: AeBDieuKNy0IdHX+Nsm6bD/D7hVJTzfG69Yt7qa37uHdIULppKmnJMo8RAhWwbPLKuo
	+R3qqlZE84HepgJGRwpPfyVyGdLU4SzGtqmG6vehfftybmNvnAw50aEF8E8ZqZrPASaOs6zqZv9
	kngUgIL3N0so9aXV9CsxFbtC2IWB1hXG4rn42YiKrTB20q9An0YNuvM9oVJDkVsPrdEAikorUou
	HeWfeI5bBvnpJKjdzf1p3/lg0jNYoVurXQaLg96SDmWMSZWgMZGArvo5hZBAMo8j5EBHhAM+Ndy
	3OWyBEo+glOTYylK0pbohecde9hzSIPD/IS19JVklrF8EV6udWPFAhp21D2cyAVflSXoXvrKTXq
	NBpNacnIA9XFKLvtT4SSCbvNHuT27CZxhfu3TSsj8xGvx5HwOJo9jl876tK6+7EuDWqTvS04Gr0
	Fle2P4ciAurKvdhdwFMDDjV5F57Z8DI2G+rL2wVYTt8ld/zNDs3ky8Px/X/1qbNgRDm+nypaiSP
	pyYDKsji2bweLN/mD9pMi1ZNcSXe/SCiNKaqLqgcW5nIsLoZBX3Iee4dQViv7ABBw1k8rLHapfK
	TJ6XQg==
X-Received: by 2002:a05:6a00:2d8b:b0:82f:776f:a78d with SMTP id d2e1a72fcca58-8352d1a68admr5782544b3a.19.1777810244142;
        Sun, 03 May 2026 05:10:44 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:43 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/11] iio: adc: hx711: pass trailing pulse count into hx711_read
Date: Sun,  3 May 2026 17:39:36 +0530
Message-ID: <20260503120949.80292-8-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
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
 drivers/iio/adc/hx711.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 534b73fcaab8..637114635867 100644
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

