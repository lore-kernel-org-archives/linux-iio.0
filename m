Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC93AE715
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810258; cv=none; b=eWn4lSu3g0YQoId4ylsDFA8ajjj+yFbV+3fjzTdlA/E+04uK/LyOASAqMjlrIg50KAoF43n4NQAdgEIGXI2fAnmwgcnGAKd9pyJcs2fM3PqHQb651C6O765VZjP5e7jtk8E80FSzsqUXNn2pk1Dd1XV22ZV0Gb8fle0Rn9o2aqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810258; c=relaxed/simple;
	bh=fUCNzLF6hh2hm98jxnInINrsJoaAkfZjloF5s1Y/pQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNNehEJwI+YtjU3LwPYyi5br22bdcw7u6KFq1SDgytPVUcbKN+zSAI6fDzCgRXbYuMC+oQUVnjT67BNAW+oGGS/n7rdspOvWeiLE2bNNuMf0lBPccAfn312YIrudjGOsIFEdVnyboO/dDFsLnUs8T062WW7/kgGi3F+chkpVcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmjGObDy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmjGObDy"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-835399c11e0so252699b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810257; x=1778415057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waD4kNs+jxUcqAUe2S1xeZGYlwFNHw9AH2tNe0Qph1s=;
        b=YmjGObDygcaFEDSpIYEkvtsny8r+1trqmgsUGqo6czWsfaHM0oiduZH/OvDXNt7tXd
         +AFvAoye8ckGtXy2JGtl1hIZ/m+gUIwMUtFswLAqHQTMaZjSBkUqfyv41NQ6wMM4ACJ4
         7dY3EYrXcZ8mIszpHfjBs0MMtryQ0Gd7BVrT8dzMLGxvFvqsEHamwAh5yofjtJIdkOrz
         QDG57iQvYUKcIedFBFhj7j8UNdMZzdp1mOLC5z+XtobeEEG0WfvHGU+TYuNv+dwUgvHV
         wIilC6a4IpflQY2zgdMIuqdhLYlPcPbZKHrdBntZ5IICTHkH4lg8Dba7T+DC8aOiLv8C
         RvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810257; x=1778415057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=waD4kNs+jxUcqAUe2S1xeZGYlwFNHw9AH2tNe0Qph1s=;
        b=ob1JiXSJeeug5N1sxTgbAB0tiaYed+qlyGQyFGAenDaWh3UhDJ1O24tC2CKOunizl/
         3TwUvzRFEAVYfLSm7r5iGIzdwhCQBOSzrhAJ7AWLLnQyi41FqNpeZ66h/8STNZbd2OHW
         B9QCeU21WjvQymFzFSTqi20DAkm47yflDNLPAGRtMMkVQX6wekRPpB5VUjXvNvlKmunw
         pGfwsrjuHh6FTCzpMaEswVo7jKJ5seFOHlXCB07NnQioQVzFcu6O6eB64KhYq6wz8EYh
         d185n35th2aQoY74s7FXojJ2sIh9u2+7RmJVCZi45IJZJxRCumq0XP3jdpOw4hR5MAT2
         aQpg==
X-Forwarded-Encrypted: i=1; AFNElJ8kL3JJyQdaUVo4X1wZbejMs9slnqgeqQ8KE8xmM6FD5XVoGrNSR97+uBm43foPTuY++msfm96RCR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/sUFM4Zm8q+pEVvARvZFFmqGuSB3OTY/Yu0ihg/0k11aeiXga
	pUff0JT75I2OFL2eJbt8LSbOGrFkC2NifuHUOYuiM8QZQ6jjq+/k8ijd
X-Gm-Gg: AeBDies4qnDqkas9AfTXxPHIrgw/io5K+TrWpa6ZpTPWOeDIy/0h+yUiwejTnBds4Ph
	Qhh5BEhLTJHvUOU0cJ2IQuJ8UBJPtftwuvqsVgyvSD0UvkPUhgLi3y6Q7Tt4FFiQm+BD9j9pReH
	D85CQU031kaeVzYR0//z0JiR7N/QIPWKTuEhRyLuI3Qwjh0HsZ+fCtPYVbUefjKgAYIn5CJ87me
	RQL3ASvZGi5Ju2VzhG9tZPx/R6rOT9yT/INEbjMVmmrRhUYw2/Wy8ZR7QuOAE3olGn+cS8MZekf
	njfEDHgDHQL2KBKVKOjJEuAYpMNUAh0v8xAPuwuf8LfOjUKAhXL41FmoPoSfTeBg7OOzXR7tSYy
	AFDtcBhYUjL2z6yWty2LOApw7fZy+C0ZvJ90dGDrCEWfFNsyGTgZYULU+O54X+Rt+rHmIqQ8UKe
	AHIQMD70l8lSPqTIWIXrXRjriyRVJtpqRVpF+Ity0rXxf6ICB/IdDrfwJNkn4IqmowCwWdHpUzW
	Cgw/qOxI/d0lo2+1zgBaoucLESZWmBmTEqefXW1sumOK6vtrbegn/+LezV+74p431WdS+w=
X-Received: by 2002:a05:6a00:1c8f:b0:81f:ac81:d597 with SMTP id d2e1a72fcca58-8352ce0d953mr5364067b3a.0.1777810256823;
        Sun, 03 May 2026 05:10:56 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:56 -0700 (PDT)
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
Subject: [PATCH v6 09/11] iio: adc: hx711: localize loop iterators in hx711_read
Date: Sun,  3 May 2026 17:39:38 +0530
Message-ID: <20260503120949.80292-10-piyushpatle228@gmail.com>
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

Tighten the scope of the loop variables in hx711_read() now that
trailing-pulse selection is already handled by the callers.

Also replace the 24-bit loop bound with a named constant while touching
the same code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/iio/adc/hx711.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index b2de8db285b2..98fb617ea32b 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 
 /* gain to pulse and scale conversion */
+#define HX711_DATA_BITS		24
 #define HX711_GAIN_MAX		3
 #define HX711_RESET_GAIN	128
 
@@ -157,9 +158,9 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 
 static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
-	int i, ret;
 	int value = 0;
 	int val;
+	int ret;
 
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 
@@ -167,7 +168,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (int i = 0; i < HX711_DATA_BITS; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -176,7 +177,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < trailing_pulses; i++)
+	for (int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
-- 
2.43.0

