Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B8471263
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553128; cv=none; b=D6y7gMR8gl85RkHwyuyL4vzqRQLiSqZCiPPnZD846vtc2hv8ey4Jp75+aYd0z0Jujg/M4gdOnlm3R9fla6SGu6a7szCdsKaZSWx6fm58WSpjK3zhSrfbqKUPCgVMRDxeXAHyaAJt9LwZtvq5818UWjlYQ4RAxapu6WiSCAvwlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553128; c=relaxed/simple;
	bh=/XNQrm4QeKduCIHL5KJ2niPZuyeWQUlCBkBf8NacRTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrjqCiD/eTTj8vZLrOJTQaEb0p7KQxsjvAhzTZ1PmdZmZc9gAy4bNqXLPdEFDbOPOjVjNV7Ro4o52oQd+Tr8qVpuTbUTuf+ETgGQTtZmWUmmfXKVmG2BdQB4TiU3lly2HbLhh1tBqOd+FWD6+TouvHiBuWXar3fwsl7Td2RXTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY+WICF6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY+WICF6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1419019a91.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553126; x=1787157926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftJ30PM4x/m5W9K7gtsE39EZFCZxBzR1FxNyACc2aDI=;
        b=XY+WICF6zkkq0TB5paXl2Nz30Y43sf9k9xvK7PlOVSCoS96EJ7v2ZIEQOORuA+0939
         9IG+OAEAyz+NKKwSfgyTH8UnMjhihbuc4FpEMnrf2Bhaf9ji87AHeLVkZgOVyeFJRSLQ
         zyxX3hj6GzzSNLp6MUDse1Gaumk7oColL0FU0aBiclxWAdMSfctJzzGFtF0cmzmCa/2D
         DI0rzfa15/Sstlc4TZQzl6YWneEAnWebqDnb/WGaDBM99qYaz3EsgXzODS7ko4SrDLkh
         uU0TZcsGKtgMVg0lZM1AH3cxFrYqFT6kyFzh/f8iC1o2Fpk2H/8ZYAeMqBUul2s+6hXr
         IgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553126; x=1787157926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftJ30PM4x/m5W9K7gtsE39EZFCZxBzR1FxNyACc2aDI=;
        b=JkFdhOOF8Qydt5crIPlKeK0mMhi6j+9ITggUZXQGMRWG0N1LysJzclO0LbQWCkK3U9
         Tft24+cyzu477R6BlJbrFDhed0/Z1E61r3zjte2HJF0oPT0NL6qbVwqkq5Ezn+APYGTQ
         JXNmLHIOmJiDLUJXYnlebJ+fhnRPDGjmZU2Kx9jmLMDBQ3KOJvPxWljS8jSHgajOUGVf
         pYkrnWrw9jkxd/ndUUg8ZfSpb++zAUB7djybNBBRlN7VKytMb8QcF7enW+p+MO67MjyC
         A4V5mcA/WWZlGH9kkugjV4vzeVTMC2Oa6VWkvrDycF9PUoj4Esu4F3zRLo6uY0LxHMty
         pDCg==
X-Forwarded-Encrypted: i=1; AHgh+RorOaGvPe2OFaMTbNWxf93LlFS6hgjpBKHuoxAKtlvWgvVZ+M+uYnAvoJtonzwotSJKr2qWxadBn8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1awM3WyWbPZwddY01sUXssutg60gp3pOm0dhjeuVZ7qVvvgh
	M+oj9EGQkyvV87rpcWquv/hnI/tiaQ0QXcwiiJ+nWuCeCQHfdkeZeo7X
X-Gm-Gg: AR+sD117offqDCo2f9U6evm82oFQOEAb5GdyU45Ri0FbExFKL/y7TjIYSme74jFrIiy
	MroQuEdK/YWn8fEOSf3WIJ0IkXErdzCcyadaWQ2RWzb+0A8iJuJEVSZ3xg9pNltFKwgBX5nqrR6
	U0bFjJ64H0djsXJZ8/uUu3aNME6/IFiglCgUNb84oGvvV3d2lyMq5nwEbocW39remWUvOYrt+Z9
	9T4KJbkAw5ki2iCbBakcTt7RI1IJOpZt2cD3h1fmfMcMFR3t/KA6OUMWfUb3RlVQt8c40B4rD4z
	A5+FFPg8/bxKiFwq/pRDVhNFLo5UzqOCRtJTV29scP+G95uQ6Pw49U9HrYC9pwyK6KJuw2rxtVd
	CapiSThDYHSTlgAiBf35PJIkgg6mO63Ne62agvqboccyiJ8E9XY7dWsyMcVlzzfZUiE0sOn/0qS
	Oq4WPTVICC+XzeR9Q8SWD+7ogT5bRYa2o38hsGN54wMEGg4Y+o35X3NaztAZTDiPE59sqT6vdRj
	k5Q8AwJHukOIzpRG5RyOxtVUEvtHdiCphE=
X-Received: by 2002:a17:90b:5828:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-393014c10cemr8570598a91.16.1786553126066;
        Wed, 12 Aug 2026 09:45:26 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:45:25 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 8/8] iio: adc: ti-ads1015: inline ads1015_set_conv_mode()
Date: Wed, 12 Aug 2026 22:14:33 +0530
Message-Id: <20260812164433.23011-9-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260812164433.23011-1-architanant5@gmail.com>
References: <20260812164433.23011-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ads1015_set_conv_mode() helper function is a single-line wrapper
around regmap_update_bits().

With the transition to the FIELD_PREP() macro, the raw register updates
are now self-documenting and easy to read. Remove the wrapper function
and inline the regmap calls directly at the call sites.

This also allows for the removal of the final custom shift macro,
ADS1015_CFG_MOD_SHIFT.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 3c78d85321e0..e6b6cf61489f 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -40,8 +40,6 @@
 #define ADS1015_LO_THRESH_REG	0x02
 #define ADS1015_HI_THRESH_REG	0x03
 
-#define ADS1015_CFG_MOD_SHIFT	8
-
 #define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
 #define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
 #define ADS1015_CFG_COMP_POL_MASK	BIT(3)
@@ -915,16 +913,14 @@ static void ads1015_get_channels_config(struct i2c_client *client)
 	}
 }
 
-static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
+static void ads1015_power_off(void *data)
 {
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  mode << ADS1015_CFG_MOD_SHIFT);
-}
+	struct ads1015_data *st = data;
 
-static void ads1015_power_off(void *st)
-{
-	ads1015_set_conv_mode(st, ADS1015_SINGLESHOT);
+	regmap_update_bits(st->regmap, ADS1015_CFG_REG,
+			   ADS1015_CFG_MOD_MASK,
+			   FIELD_PREP(ADS1015_CFG_MOD_MASK,
+				      ADS1015_SINGLESHOT));
 }
 
 static int ads1015_probe(struct i2c_client *client)
@@ -1025,7 +1021,10 @@ static int ads1015_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+				  ADS1015_CFG_MOD_MASK,
+				  FIELD_PREP(ADS1015_CFG_MOD_MASK,
+					     ADS1015_CONTINUOUS));
 	if (ret)
 		return ret;
 
@@ -1055,7 +1054,10 @@ static int ads1015_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
 
-	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+				  ADS1015_CFG_MOD_MASK,
+				  FIELD_PREP(ADS1015_CFG_MOD_MASK,
+					     ADS1015_SINGLESHOT));
 }
 
 static int ads1015_runtime_resume(struct device *dev)
@@ -1064,7 +1066,10 @@ static int ads1015_runtime_resume(struct device *dev)
 	struct ads1015_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+				  ADS1015_CFG_MOD_MASK,
+				  FIELD_PREP(ADS1015_CFG_MOD_MASK,
+					     ADS1015_CONTINUOUS));
 	if (!ret)
 		data->conv_invalid = true;
 
-- 
2.39.5

