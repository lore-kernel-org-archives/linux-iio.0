Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8439FCA7
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141793; cv=none; b=S/ANQCEkPtI7B3RTyx/4fkWidIiYi21n74di+EU4leIld9pUWvNAabO8FnxFmYAlk8WUZ2yWHAWiCFFfW1rys0bUwQpuhMBSSWfnDrLd0BAtXcX80+1y7VnNQUoQ0JaSJevpfqgyOFKkZbmxYtiBvAnD+/Ob1D28keWbLGVmpw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141793; c=relaxed/simple;
	bh=SYBXHINTBKF35umDA/Ci4NtfcsdeWgeH1PRaMh4zRvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4KOm6doYNk8lGN7tRF1TrbRWt0tRO+K5sK/aR1sGO2AOnEJhP9HZfJ5spRP6Z6UkSf1HGNsUcJv+0b8FPntwGZ17fK3DHaGwLM1JNXAsnmwpEm8M4v0Z8Ywsi8jZcLUjSl4KWY66ob/6tUGwMayWYNIPSXQ6yaLPaGxoU/cLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROTD/znj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROTD/znj"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1195697b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141790; x=1779746590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ae3/JbEJyowtyIvHRgRioSvia9PJ2dzMefDwMaXfbE=;
        b=ROTD/znj1SOgZt/pjwiZlK4xbcIP/SomI6Pwa4FE0oKjdsTqS8gy9kXRbDGeQEdiGT
         EKjpSO/1u3kbQcbT1wx9iM/5/4g+nivA8qfuXmWZWdZlFfwoxYedSml61OknuMghw/Gm
         kUptQWuZDvKvNiJ4B0hnIXCUdk7E7FV883F6pQfh+BFZbsX3fSrrbOZ7NBZ1RNMNEDg9
         3/AMw6c8Q6X3axgAelyNvHaei4BjyO+alqtYgFFdGHlbduNETTY7CiHoJuuQn7awrSti
         sG/zWdByBdxC6Q2wxzOvDhn4dadFdP/j0ki6VcPCbfa3KgLIOL2JlzlleYzUjO2WjxPk
         94tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141790; x=1779746590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Ae3/JbEJyowtyIvHRgRioSvia9PJ2dzMefDwMaXfbE=;
        b=aWyO8qz/gzgJ6U4K4YM2MHVnWO+ji08sjQNN8ncL9RohVJu6kOFHTQdi9Vf2EX5nC/
         3Zj3D7WSI8CXuQfi8xN5G4FvLjzK3ZvE2JPaDolf9OcZQ1PNYr+4PDNRHeeW94gRfn+d
         dItvupmVXKkXjHns1IqUFnBzG+C2beRMtuSGfUlLesllXZSbtb1V9V2mtYiWrGuGJEa1
         Fwtfr36w2DCLq28oWOOmaYDzgbef5KaahHFtzIvDOE9peZG+7NfsubPjNjF1nN1b9C9X
         6jzBrg/5QN0l1uNEblTDw1vUM7C9mVr6C7G1LuTHTUp/3TaD8LUjAo/iSh1M4oijJkMH
         0fRA==
X-Gm-Message-State: AOJu0YywlEbROeRvTHLA9L0ECY7Ph5v+I69V9b7qNIbhS2sFmWp1zCcU
	iobD5ykEgvRRyXeuFf6uVC/u0Lo9ACwm7FX+dqNKYVNmQXF2JEdz51og
X-Gm-Gg: Acq92OE/Y3YHhHJTq5YapGJNJP52W/DJER6S06lMPab2HvWJadvtI37d6cDnMtFbWGf
	yfKqSwv4BESjW1BNbQ3f1hNZ0HPWYRnxkvvgKEOPAj5L42SVlUUUWLNzaE9omaovGtNRoRFGmFk
	Nh0JxGTyoHQKmj1MFNfLOz9yWCz6q02xMYoDwOH38lp42/InEeFtZpV6g1xJ4LC7AbwRlH/iMT5
	bGshRI6L1asFDnIXpg5XrrdbeiP0ZvC9iBZ3CHyJ4AzIVYoPV2nwXPO9Gab6xNVCbN7TGKm965L
	4vH1WDq2gM0Fd/YcS7iDqLPUYEjZfOJIm4GyKj0FwAFnmxdNnNRY5bNvE/kiWN7KkmgLugMYVnv
	Esorq+6zHadujKfwGzb2TLOZUlgiE1y1GfOrw3hc+0H3Ctcbe6SnTGtxPCUdyYxhzLgmyi7JLeN
	NVhmIbEVp6+0HsNraDXnCc3bqs4PEYVK7DCMUgptufcZskhgM8iOwNccGopDyoPv1dKRaWkxDM5
	zsFhepctDtt+9PdzrAfyAAE5LVv7K1mXPqHA4Izdpn8WmlmySdvCc1fvZ+Y
X-Received: by 2002:a05:6a00:3907:b0:82d:556b:7a01 with SMTP id d2e1a72fcca58-83f33c25b5bmr17418803b3a.16.1779141790385;
        Mon, 18 May 2026 15:03:10 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:03:09 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 08/11] iio: adc: hx711: split variable assignments in hx711_read and hx711_reset
Date: Tue, 19 May 2026 03:32:24 +0530
Message-ID: <20260518220228.63322-9-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518220228.63322-1-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the initial value assignments from the declarations in
hx711_read() and hx711_reset().

This is a small preparatory cleanup before the later loop-iterator and
variant-specific changes adjust the local variable layout in these
functions.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
No change from v8.
 drivers/iio/adc/hx711.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 30e1ce321747..9e5cafa1e307 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -159,9 +159,10 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
 	int i, ret;
 	int value = 0;
-	int val = gpiod_get_value(hx711_data->gpiod_dout);
+	int val;
 
 	/* we double check if it's really down */
+	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
@@ -204,7 +205,9 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
-	int val = hx711_wait_for_ready(hx711_data);
+	int val;
+
+	val = hx711_wait_for_ready(hx711_data);
 
 	if (val) {
 		/*
-- 
2.43.0

