Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AAF370D5C
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066337; cv=none; b=U2B2r3AXQvTFk2ZMqmU3MKq86Cs/SD2hoDsEJHwY5gC0+7AOZfXw9v0kFmcQ8OgVl+DcYSdHh7IAmuXOfEl+TcYzVJs/iNkSELlM3GeNoN7M+o705adZKVb4o3pwZgsHZfJFTzAzYQfy7JINcTdwJsb+96t9zYZjgRGllo8OQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066337; c=relaxed/simple;
	bh=0xzkMbZb8DmdjsLxVwu910Gns04flVx/nSnZbEzm/z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fmm+2dQHJ9sAQRjtffBanu8APnS3B5J+mpR8ZlnzobVRE0xWhVYqMinobZ1Irt5klIqr4mM1AQMll08hwPqF5riRA2KVztNBUTJgx3xRpOK873NM3Dd/MCMUT15mk18f+YgWls/mbsj0h2rZAmiZpePaetoiGJPK0kumiLsqvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3yQYQHY; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3yQYQHY"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-3078e0dcd67so4216032eec.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 21:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781066335; x=1781671135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuhTtUyVMPvx6z9MESU78WsNrQ7meZFqbXjW2dOVHdI=;
        b=N3yQYQHYSyPBbBSejVYKeW5xjJiv7rLIvQRW1v07Zhbet+tpRxuHN5bN2LmC1TSywY
         UkxfjsnhJy2+gWz9m8MqofraqkVXnEd/JG/xP4sAXYqQYP8mTeejqPbQ8z0ric39KNHH
         Py6Kg9EiMgVDOnWonmo3AD/J7L3pZRAC+lv1TxuoFf9BFV6WqczMww6BmuSsqcF41lzt
         3celA1hCClZB5eFP4pIL0QHVWKSR8ZiTUgChUSSuqe3Xadq/1hWJk17Sx3B7kkzQ4hYd
         7dVa5vsL4F0MHq27bdDtSPM/RKloT9sdS8GAC6CJzzMgUY2LLdXs+WNiJwpSO5puxab2
         DGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066335; x=1781671135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BuhTtUyVMPvx6z9MESU78WsNrQ7meZFqbXjW2dOVHdI=;
        b=ZAzdtMeJZ8Rup5bYhboB15fsNvt9aII4JFWVY23/iR1SpenSIdL8ggq9Jpr0quy3ZM
         MZRP9NuCYkSeLRQGuj3rt/rsT7mYRZpXCppji0xE+FFckqiEkZnJE7m60TyQ0JXv7Lf/
         Y87dzEbHwUMP/aNaBmTdZMt7GYXN54CaF4xsBCUh41T4HKCHr+cpA5kK+8XxEW2Nhq7J
         57zr/gstO+EpkQJx6qyOxurk8ALcJoY0RLLnGxsxWdsEPzjtunhCUQ8zVXhbBzIH1PkD
         YDr/XqIHBhRCjZ4YPeCiejn1YwM5d4d+O3z2C0Nbw1bcKsXSB6CpyqUm2fOoajlUUrmF
         BSIw==
X-Forwarded-Encrypted: i=1; AFNElJ8mpazKRV2oapV38tH3JQpiFkB+GphHLtodRhYQEeWuh8r5yRcd5mB911w6nS+kGkJNf5XsmQbBY3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjG31F8UIL0z81M6dVVuhm0Q8PFhM8y5Ol//qQG3f2zQYUzeR
	nfqPRS3bpQrf9Kxa7CYlDJUD9heIGFgwih+RKNt1o0nMTt+OKvo0GCt7
X-Gm-Gg: Acq92OFaTb915RIkxmVx3EWMvhaBnGPC0P3TjujOC8+D6q1kfNVOL9VxRW3AWDH+K7i
	3QYNw3KSyt3I/t3iOjn0GTz7aFgWSaF7yxw22oElnbK8mbiTvJ/Wmu5SpjUhW1dGg34tTch7MGi
	hq3wZ0u3bK4uRa5REXanWOnaz2hhr0jvLCTvOEMhzEhLuhR4plLA5tSMOJOKGg3SnUhNPSYJhau
	HI/Z2kUYi7nHIpSy23rGWgtdD15WgVClwa27d8yOlAPK8DxEAQWGXRCzvwQPfQPLCRuYoTRjf54
	66P6Cn6ovEffJBp4wGuX3ylRRBqr9S2BDwA4fNWSJzFZDJmPswDs39f91y9aB4tXjeELQIogWu0
	wUfiC2g8BkB/1tfeQj+seOCGy8sValz31O3P/tssjS4mq0fmbOZqoh6JAnpBZZlml0CY+kT3kdw
	lth828aV55nW2u+hAWy2Ze0x8/OoCIRupbitWYTtaqoR3/R3QkW8tce2YKFk9OBmAsfA==
X-Received: by 2002:a05:7301:1e94:b0:2ed:b131:240e with SMTP id 5a478bee46e88-3077b283e85mr14057362eec.23.1781066335190;
        Tue, 09 Jun 2026 21:38:55 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8708sm25693676eec.15.2026.06.09.21.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:38:54 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v5 2/2] iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
Date: Wed, 10 Jun 2026 04:38:38 +0000
Message-Id: <20260610043838.90708-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610043838.90708-1-dennylin0707@gmail.com>
References: <20260610043838.90708-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded bitfield operations with FIELD_PREP() and
FIELD_GET() helpers where appropriate.

Also simplify bmc150_magn_set_odr() by returning directly from
the matching table entry.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 33 ++++++++++++--------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6f2a4a863fbe..b5ec19dc500c 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -9,6 +9,7 @@
  * (C) Copyright 2011~2014 Bosch Sensortec GmbH All Rights Reserved
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -245,14 +246,14 @@ static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
 		return regmap_update_bits(data->regmap,
 					  BMC150_MAGN_REG_OPMODE_ODR,
 					  BMC150_MAGN_MASK_OPMODE,
-					  BMC150_MAGN_MODE_SLEEP <<
-					  BMC150_MAGN_SHIFT_OPMODE);
+					  FIELD_PREP(BMC150_MAGN_MASK_OPMODE,
+						  BMC150_MAGN_MODE_SLEEP));
 	case BMC150_MAGN_POWER_MODE_NORMAL:
 		return regmap_update_bits(data->regmap,
 					  BMC150_MAGN_REG_OPMODE_ODR,
 					  BMC150_MAGN_MASK_OPMODE,
-					  BMC150_MAGN_MODE_NORMAL <<
-					  BMC150_MAGN_SHIFT_OPMODE);
+					  FIELD_PREP(BMC150_MAGN_MASK_OPMODE,
+						  BMC150_MAGN_MODE_NORMAL));
 	}
 
 	return -EINVAL;
@@ -290,7 +291,7 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
 	ret = regmap_read(data->regmap, BMC150_MAGN_REG_OPMODE_ODR, &reg_val);
 	if (ret < 0)
 		return ret;
-	odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;
+	odr_val = FIELD_GET(BMC150_MAGN_MASK_ODR, reg_val);
 
 	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++)
 		if (bmc150_magn_samp_freq_table[i].reg_val == odr_val) {
@@ -303,21 +304,17 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
 
 static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
 {
-	int ret;
 	u8 i;
 
 	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
-		if (bmc150_magn_samp_freq_table[i].freq == val) {
-			ret = regmap_update_bits(data->regmap,
-						 BMC150_MAGN_REG_OPMODE_ODR,
-						 BMC150_MAGN_MASK_ODR,
-						 bmc150_magn_samp_freq_table[i].
-						 reg_val <<
-						 BMC150_MAGN_SHIFT_ODR);
-			if (ret < 0)
-				return ret;
-			return 0;
-		}
+		if (bmc150_magn_samp_freq_table[i].freq != val)
+			continue;
+
+		return regmap_update_bits(data->regmap,
+					 BMC150_MAGN_REG_OPMODE_ODR,
+					 BMC150_MAGN_MASK_ODR,
+					 FIELD_PREP(BMC150_MAGN_MASK_ODR,
+						 bmc150_magn_samp_freq_table[i].reg_val));
 	}
 
 	return -EINVAL;
@@ -800,7 +797,7 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
-				 state << BMC150_MAGN_SHIFT_DRDY_EN);
+				 FIELD_PREP(BMC150_MAGN_MASK_DRDY_EN, state));
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

