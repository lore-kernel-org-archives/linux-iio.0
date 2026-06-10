Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4332410D24
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099940; cv=none; b=tRVvirTHUC3og86O+6G4zYN3BVHuosc+JfaWx8mRKv+3DRiIxJAlmaZlWUYpKB5QW5VshDd+Upl9zfiu6vePJ2PZ9Xvz6kcMSfvWbNByBXd1yVL4/lW4u3veUGtJlSnsO73cBg1G9yqqMxvu/0mC1f2YZeR77zCBagIf7hxBQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099940; c=relaxed/simple;
	bh=payPnzYmDM/36lxFGB5n5kKaLu/Wz2PoP49Wx4unezE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kF3UYpkRznNYzxH24Twcte8TMJ4mWTtUBr9XZG3uvrNwBLn9BnVFBgwv5rovUOoL/3lgiJ01O5YqPrQJ41/dKrlisUZrEePeoGczZ5XKo0KIMd19MC032/ELk4ELNixQ6ZP1KjMcqyMC7z1E0aeTzuScHdBwhroWgsLcGBVVTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvgxifS9; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvgxifS9"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304f0039c02so12278667eec.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099938; x=1781704738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WyQKeH1KsWsKtNSUJJsg5vwIt3+UnUidjq/3f2D1ls=;
        b=kvgxifS9atqT5KTLq6GJhdaz+r/RkxNkeG9wT8Hvv6gPVwRr6x1uxlC+YqALnt4l6x
         /wr5dn5cJSER+O0MgMdSePcBmSPyj1+y3JzA4sxPp7Y3MwQF6hkMSNGGmFngj2zWXR5H
         LsyA8xe+9qfLWx19UdX4uzamcf5NJSOyUBqg5npO0nVeLCygeKvTILWk/cf03IBRQo4K
         C1/WFfRLSu059nEqiaKGiFdv1gvDmTDtrugOnjqUtO3LkLchTpe3RZcZE9qlN1nk2KBy
         fUyDIJvdDbjplffF65WnMGC+GBI2s7uukBf+6UzIAZv6kOzQUvBQMOyQOsFwkDmE0WDk
         YDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099938; x=1781704738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WyQKeH1KsWsKtNSUJJsg5vwIt3+UnUidjq/3f2D1ls=;
        b=n2OQCVaKqZc1j00ZtTn3pBt7Zm4eB3WwFvSwCE1DeGChB67Sx36ASQqZO/vssZil9f
         rCJXxZcIJQ9kPJZeznBvWFSc7g6uzBiDZh+7MQGwwZDoCPtIrYKJhealH5P5m9nyS44S
         +tgjHMp9cJKX4PqauAowgGbZRXQTqlUQJN0I/I+u8RUEEex/Z9uTH/EoOpQPZf9R4mn4
         2YNgxyf2ugh4pWdTQx8IFfEZvI4c8iCtzeNE3Cn+dOfvOVDhX+cWE2hT637JxQfloydE
         1zQXtSQ8YTR5RKiyDIhRjoELyKUWRU/LWcXBfd0ZjOjxNdFlPPvbjajMTT+bygsbAJKY
         RLXw==
X-Forwarded-Encrypted: i=1; AFNElJ8a90RxwJhutvGiQE22DRK+LKfgm02YavYF4bpwc0KvsD2vrKtTI6JUKNGOMubOUkAVFiwy7hkJVlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcWczzEZ+HY95wdZPN280wkO0DYBC7XsU6pejvI99yeOTumA+
	owAqTBo5ElGol/WX2BuV06PKACMJBJr2kNp5bsnoZb9JGjaeXKZy4wDO
X-Gm-Gg: Acq92OG6ngnHtIbF3xZu9GBauuoxiUd/zbihMQmMiIRNqdmPEQ6dFoEDJ4BpjnQAa9d
	zb6A8Qx/zg44LV1f323CtPnqVLRlSgqPnBWHmWwxppkQJ/ujLBqDInb+Wm85GNnNs/B4Bdnn6wP
	CJ50T+ywExVHx0QaAj5IIXZ6Ob/T595W5Kc+YjiaATfDSEesp3ZtMj2cb1JP3Taj+intcSWMnwK
	aXSdbkno45/MfLnSNvKfYsTppisj8uo3bfEVgU3LBsyk0fLpCAYqYn47zkA/NAzeaf2/vrNf69x
	/tckwarFcBm9rEIzo3KB8uJ2iAa+Iow/ICoDE/CjHMWIiZpUaSNLHRp5BapgQ3bi4/TJeAZ/gEw
	E0f7uyilWUDs5GKhXOs310JK8dE23GERYQ9HHV05W6+bCehOJHAMTM9giyZX8JP81WVSOdMJhM5
	9pqlYTx3nOHuDb5Tyifoi3zOTPhC6CYhu8NNYbgTa1CThxw1L/Af9smVA/21mW6sJxFw==
X-Received: by 2002:a05:7300:80c5:b0:2d9:6373:ad22 with SMTP id 5a478bee46e88-307d5fed6d7mr6331854eec.12.1781099937980;
        Wed, 10 Jun 2026 06:58:57 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm33092237eec.13.2026.06.10.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:58:57 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v6 2/2] iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
Date: Wed, 10 Jun 2026 13:58:31 +0000
Message-Id: <20260610135831.91739-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610135831.91739-1-dennylin0707@gmail.com>
References: <20260610135831.91739-1-dennylin0707@gmail.com>
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
index f6639d7fab04..ee8092d4006c 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -9,6 +9,7 @@
  * (C) Copyright 2011~2014 Bosch Sensortec GmbH All Rights Reserved
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -246,14 +247,14 @@ static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
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
@@ -291,7 +292,7 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
 	ret = regmap_read(data->regmap, BMC150_MAGN_REG_OPMODE_ODR, &reg_val);
 	if (ret < 0)
 		return ret;
-	odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;
+	odr_val = FIELD_GET(BMC150_MAGN_MASK_ODR, reg_val);
 
 	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++)
 		if (bmc150_magn_samp_freq_table[i].reg_val == odr_val) {
@@ -304,21 +305,17 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
 
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
@@ -801,7 +798,7 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
-				 state << BMC150_MAGN_SHIFT_DRDY_EN);
+				 FIELD_PREP(BMC150_MAGN_MASK_DRDY_EN, state));
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

