Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA23346AF2
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878715; cv=none; b=np/8WaK07fhCYxQ9FU5k8Yth+FSLxTFbRC1S1O9UDDvsWI+qej2V9EOD1CxtO2X1OnrueF1cQdaYfS3UyJPyDWdhsbom01cKN8nC8iurXSQklPIFfgcjSSmD2X7yoyj3kHzIjz4mdUP/urE020axHxzT4l7H2DmKUMvELia/6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878715; c=relaxed/simple;
	bh=r2LlFVmymWhPwFcVkiJGk/YEm63Tgz960SzCAIop0CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8uAH0uFIRiK9EEVr5BoVrDxqHcxFqCvtfVm2Rv6Zh6hbA2gfJjd427BiMNnl69iqKw08XzjvrcEUfekNZF29XFltiWtWsUwGTWhm4aDtqi5eZ9lEkngbolaj1RJ/9FcodMeZPmjIedlUiQAXLLcz5M1PeSdaXSlWd18/G9vElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dITUeNlk; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dITUeNlk"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso1493315a12.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772878712; x=1773483512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILuopjJVYJJNk1BvhCBXLzEWgrHW/yLVAVwM4GFLhJ8=;
        b=dITUeNlkvmxGbR5/LatepOoGF0aY84ROVDMo3AmSx00DVn0CKNCnhLQ+Q7jn8A4ir+
         Oj3Ncx99YHfLMNfSuc+A5F79bey/qLipCIlpojnDdM2vDGKu2NIvRmlEN57OTU2O08L9
         WDfMRuHbBdpB51Rlg0Uc8bkS/VOdx3ml7AMPOlMAm0K32W3FqvRy/r3bMhW72srbqWmk
         nPlfq7zEetcbWXoIs7fqAAFmZ45OiN06SIXdeukMgS/B1uY/2IpAVHaigQA3HFGcjFEC
         EFpJ4jXp6FXpQbqSAFfwe368s1ELzmrMN3xuDcw9n7uS6VMYj6HelfIRAXs4JU+7JiJR
         9USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772878712; x=1773483512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILuopjJVYJJNk1BvhCBXLzEWgrHW/yLVAVwM4GFLhJ8=;
        b=vFj2Sm+fo/Vv/ZeTTfZmLArCFue1cZuejli4XCxvM+johUdt4dSs14X8zFPgwZC0zn
         G+hvaxB44sgtWg9+Fwaw15hdC8jNcDL0Zk+aRxHk0TzhTxXRoIXEvFo/xRUh8JyzFVvC
         SsubqDfoggzDgtBPGO44W6PFsT6jULvnFOOECI5coLdN4GRJMu2whRxkis2NRgnIospC
         +gntXe8OgE6+Dq2zSjQ1CYfVdWZ002lGtTrzgxnrOAJ6HiBbyXdHiAEhzVI3sGKlfqKC
         KyuxyS57mhg7uDg2sSG2YWGcq5hykkOu1IQPTbnX9wRby4WcuaHF8bsFvYvPVA78HkMc
         yfdg==
X-Gm-Message-State: AOJu0Yx/qdhq1GkacnNcwA9eCrtankkv2NKoFuNBtcucr9xcsmmG7Cob
	+8Bdpqqb0rNjwgB/81/UXeoLHL7sHbHe3onyithANSffF3JnulfLZ9d3
X-Gm-Gg: ATEYQzziUf37JNgHJW3K6QSrK9FmqfTamBBhlycVlS4nH8lPyLd9lC3bLsZTzRgAWdg
	5t6zHTMNXxYUuKNbAJFyuTmp7pXz0XT9bmt05nrwaRVvkwtYht0y3u0ywzUPl5R7N/2B4qHMb2I
	E9fvXg2qPFs4/6pjcyAQcSLDzydcOmSA1curN6WXGTnOlKVXnipX0j0jxvO4ZzU1dbtZxj7ffrt
	UTGNV8woD1KL6LqYLMjBZjSXTlWWXts+P74OIdSXnkrCib84krTz3PB08QBhqoWg2ZASwIrxRvb
	t25otTTqFi+2V/2BHajUKRi4DycMm31gdhei90vMoGnag29vlyfqxTMjjgQ85TeuPN5gQ3IpQjr
	Uv1vbfIDYpwKALMUWaYAv0ymlUJAaTSuJxdEhqW1DAgt8KyA9gD3JGhmAMsUyXuQRwk7DoatCdq
	9XtW74LYp0T70cVWFGUHUk5tSbfV+R08sw5C5MlErMdTOwusRp412td8jH0s3MR//np1Up3vb+n
	UB+9M4B0R7xtYctaCXqWNgp
X-Received: by 2002:a17:903:1a24:b0:2ae:4ef4:1415 with SMTP id d9443c01a7336-2ae8238544emr50643415ad.13.1772878711980;
        Sat, 07 Mar 2026 02:18:31 -0800 (PST)
Received: from fedora ([103.215.156.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7864dsm48381265ad.49.2026.03.07.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:18:31 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v3 2/3] iio: accel: adxl355: convert to guard(mutex)
Date: Sat,  7 Mar 2026 15:47:57 +0530
Message-ID: <20260307101758.50091-3-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
 <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pairs with guard(mutex) in
adxl355_data_rdy_trigger_set_state(), adxl355_set_odr(),
adxl355_set_hpf_3db() and adxl355_set_calibbias(). Remove all
goto labels and return directly on error paths.

v3: Remove all remaining gotos and return directly where possible.
v2: Split into separate patch per driver.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 81 ++++++++++++++------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 1c1d64d5cbcb..af606e2ab8d4 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -9,6 +9,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
@@ -261,16 +262,13 @@ static int adxl355_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct adxl355_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->lock);
-	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
+	guard(mutex)(&data->lock);
+	
+	return regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
 				 ADXL355_POWER_CTL_DRDY_MSK,
 				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
 					    state ? 0 : 1));
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
@@ -409,38 +407,34 @@ static int adxl355_set_odr(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (data->odr == odr) {
-		mutex_unlock(&data->lock);
 		return 0;
 	}
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
 				 ADXL355_FILTER_ODR_MSK,
 				 FIELD_PREP(ADXL355_FILTER_ODR_MSK, odr));
-	if (ret)
-		goto err_set_opmode;
+	if (ret){
+		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+		return ret;
+	}
 
 	data->odr = odr;
 	adxl355_fill_3db_frequency_table(data);
 
 	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-	if (ret)
-		goto err_set_opmode;
+	if (ret){
+		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+		return ret;
+	}
 
-	mutex_unlock(&data->lock);
 	return 0;
-
-err_set_opmode:
-	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static int adxl355_set_hpf_3db(struct adxl355_data *data,
@@ -448,37 +442,33 @@ static int adxl355_set_hpf_3db(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (data->hpf_3db == hpf) {
-		mutex_unlock(&data->lock);
 		return 0;
 	}
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
 				 ADXL355_FILTER_HPF_MSK,
 				 FIELD_PREP(ADXL355_FILTER_HPF_MSK, hpf));
-	if (ret)
-		goto err_set_opmode;
+	if (ret){
+		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+		return ret;
+	}
 
 	data->hpf_3db = hpf;
 
 	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-	if (ret)
-		goto err_set_opmode;
+	if (ret){
+		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+		return ret;
+	}
 
-	mutex_unlock(&data->lock);
 	return 0;
-
-err_set_opmode:
-	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static int adxl355_set_calibbias(struct adxl355_data *data,
@@ -486,33 +476,30 @@ static int adxl355_set_calibbias(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	put_unaligned_be16(calibbias, data->transf_buf);
 	ret = regmap_bulk_write(data->regmap,
 				adxl355_chans[chan].offset_reg,
 				data->transf_buf, 2);
-	if (ret)
-		goto err_set_opmode;
+	if (ret){
+		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+		return ret;
+	}
 
 	data->calibbias[chan] = calibbias;
 
 	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-	if (ret)
-		goto err_set_opmode;
+	if (ret){
+		adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+		return ret;
+	}
 
-	mutex_unlock(&data->lock);
 	return 0;
-
-err_set_opmode:
-	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static int adxl355_read_raw(struct iio_dev *indio_dev,
-- 
2.53.0

