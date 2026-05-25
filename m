Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC493E7169
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706345; cv=none; b=D2B0vG9+n2s/lSJ3BZ5bVF10q1ooreFgxWEwBc8Qoc0Xga+q4RXPfS+BDWoZnvFvEzMB2JhcWXAJDqs+EqPlrF8nmqiD0NjSTccO1uWfu5hmA6R8z6il2zDFUUJt9LlEL8lfR6x1CbfwIK6hdc+WdGOWc/8+dNhiXRtGeuBqsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706345; c=relaxed/simple;
	bh=8sTc3ePfTO1HkNzwXZekmT2AeOdDHgPOdpy0VtjDF3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tABLMoJrsFzA6Ch32prkYCL6v8JXlNWipGfzpTLZ8rP8prl0hgwDtn05UlRqHYuaP7JrDeZWLAZ6OiGANqOcZs/G0WXCwZeh76nvzQihbfIj0ruVZLdtfF1V9lchaw/Cbw/0zRwD91RfP1OIiG4EeQTde52Zw7XUz545uSjNdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYL6qeQO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYL6qeQO"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-366375c4076so3978892a91.3
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706343; x=1780311143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTBVI1ML053TliZ0TwngU1Pm81C+cTmh1wKJVMjMXjs=;
        b=GYL6qeQOgFsAbiNfZPuEXAjds/fXUhR18YR02uFdt3cNwpb59TJGKqrQ1LWb01TyB5
         7fM8s6jY9s6hRF1PEOTNNWrOMlp/71VAMlyiBZaNb0bEDtUOkARkr9L7G0H3UMMEQ4QU
         nnYR6eXyjUFM+H1fQWBR9a06hfi7rsHeifeoRriqkSXnmd6WHEKl2uVXPYWj9gUp9Hik
         yH5AFeciNE4ho56S1pThyVgSTGmR6j7fi3qZ54a6QF+TN/SyFAgDIFDxg054ortvc8pu
         UOH8OrWchUFBrg+yGKQmtUxpcuTjDQ9bCm+sSZbTqBGyVcQ9JlUPOXCpXkYZeD4EQJs3
         ha4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706343; x=1780311143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTBVI1ML053TliZ0TwngU1Pm81C+cTmh1wKJVMjMXjs=;
        b=HS3+pq1EKovLwd7Lpff/P0fhgwgZa2W78cmY6+3wKbYOEa99c0x3eBti3pCeNR4m+m
         7w/buxQVhnnoUBZi4/nm4dP89kfeR12abu2b6MLHBQCXEAivIssmizZoOsdlxlvoIY0Y
         4jEoxxd78Ge/dYvaOZQM2dv8i6+h/sv6Q68zz3pCbptmukly/UHr5QvsmFtdbnPiT4sQ
         ptGrrtp0fNRF29/Aw3hT9ZT8wulVaHG1zTTOJSyoN+b8PasbXStwfLeg7tUs784z3ten
         3m09onu/VCM1RWeZQGFmuJBcyxjkcRfEtfUivOYnPV5J/ZhlEFhyR9TAhP13K1G3vQWC
         Lg2w==
X-Gm-Message-State: AOJu0Yzg+12kfIUQsNL9aaj2dUrmoi2KldatXCeVCy4vLevWX6cOBJmo
	+mRg22MT1yHd8t8JGN5mBkHj/obnUt3YQAANs//HH49WfbaU62FQPRDR0d6AUq4c
X-Gm-Gg: Acq92OHcMbbNbRX0mlICjbzYMxoarv7p7kMgJoiOXklEwbfRDl9xNdVGejM4zJ7R8Mg
	Ua8Z4Lep+Xd/MQDnCYnUYABjmISe+Lw1MKw1gbVaxVXAhpiyiLvLbXKCcDssW5Nz+VGa/eqdBeP
	VE7mgNwiU+eF1bdZBhrmWW+h2SuNmnVGHuoBLMMHMfrt5M6GASptTPEyvQBxEe42qWd1DAW3mMc
	lMaoj72SVPQ625kt3dzsODSnA0ekKAImZ+/6JcBlmpGO/Gf1YyawEqEF8qM877TCAxHsG3vmu9k
	3fcL0K7v7FfQzuLnl187dY704uwC9KCn1zU4BvlJIuxVsjCHYBkkxZNJdhhHTX8EJ//6fVxQxqq
	9/Wrw/VG3QAmS7CffU1U4QcKslLr2DunfjKM6NUcEZY6apglD+GC6Xl7fQ9emwTZw16bk0mWHw6
	83JuQwmoHkm9KY3AxWeLlUb67OFFNS6wMHIvz7+mVbj8zQfMY+5m1beUE5VB71LnfGh7aPmC/Ep
	i28AaidDdEDZ4MVMiO6og2NQ5p2WN4lx5i6nBg8zLid7QH+/6N3
X-Received: by 2002:a17:90b:1b07:b0:369:a9e8:dbf5 with SMTP id 98e67ed59e1d1-36a6749ea42mr13009276a91.3.1779706343136;
        Mon, 25 May 2026 03:52:23 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:52:22 -0700 (PDT)
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
Subject: [PATCH v10 09/11] iio: adc: hx711: localize loop iterators in hx711_read
Date: Mon, 25 May 2026 16:21:25 +0530
Message-ID: <20260525105127.180156-10-piyushpatle228@gmail.com>
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

Tighten the scope of the loop variables in hx711_read() now that
trailing-pulse selection is already handled by the callers.

Also replace the 24-bit loop bound with a named constant while touching
the same code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 4ccb0bf2d71f..e5d842853b71 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -23,6 +23,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 
+#define HX711_DATA_BITS		24
+
 /* gain to pulse and scale conversion */
 #define HX711_GAIN_MAX		3
 #define HX711_RESET_GAIN	128
@@ -157,16 +159,16 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 
 static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
-	int i, ret;
 	int value = 0;
 	int val;
+	int ret;
 
 	/* we double check if it's really down */
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (int i = 0; i < HX711_DATA_BITS; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -175,7 +177,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < trailing_pulses; i++)
+	for (int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
-- 
2.43.0

