Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F1248886
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737488; cv=none; b=TwOIvT/SxCD5S4wQY/uet8YnnTRAhXMaV3QDy0qoGdeqcBIJXcevrvzvNm6yK59r/wb/gEsI2+ALCtQa64O+TCReefNRPcgCRSlXJzsV2SRxb6VLdOm9T28SnE/alC31jbMK3Injfh9xcCqIV3JSuyGjicLaGozUu7b/Qw8DW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737488; c=relaxed/simple;
	bh=+0pYD6ausHeA+Qoih/gPboa591zGAm4ICLPpuJTNEZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i82ehiK88RwJGzMSwoPVhTP0F60B4Opwxn/dRcCHZP2KARH10PAlf4PMlw7iy53VfS8PXMYjwRouD8+gmc0f4MLIdGoAIIWDgwqVOazz5yWNi5aV32LvDmCEYbPVvdgwNB+HLckY8mQAbJn9O7mBt90hHj9DURHleYT9MCs4e7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Crv4+e6U; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Crv4+e6U"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso3870571e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 19:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776737486; x=1777342286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQa1NdnhZHREk9MFYDs4MIha9t+VWvBZFkKRTUMEm8s=;
        b=Crv4+e6U8TyhJZVHoZrDkH3dAWRBv4dii1EUXBJkuyS9MJ1xSEXMi5T5fLRFhDijtg
         nGfneFFYMRZs7cWV3p8oIebZrzOabqWnySo6KhjtRp6yxmDB+NZnbC8snvKFA1OZ5gnE
         GizRzTWuvhJfGsNMguDM4GGQNjgRAanA/3qrwgXvtf1DUuO3UWGsfePjY00eYCdpFDqP
         laxWaOfMZtPPRNhpRxqfKlPA9gM9cOGuSfePPTKWpETcA1OHFXOTxH+Dxr/AfEUxbcco
         le+P6Z2vZW3+m9gr4OYbBMrIkFMuyFI7nLLdFj7ApevLBna5Qh+LwwbB7lku4h5RskZB
         Nl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776737486; x=1777342286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQa1NdnhZHREk9MFYDs4MIha9t+VWvBZFkKRTUMEm8s=;
        b=gCDcSxf0NUv16lPC9GPuUA/mmogN+U4qzvMAC2iib1u9rzfhjizFHls3JqoF/2XqpV
         BplRTud58Zymd0uhky26y1lsRRCMHIX5wDWxtfpY6nJvj9xjsu0gBqu8bbHhdPXkvv7J
         KxXSdTsi+u+acXPFpgyfHx/QuDQlj/o2IqEOLqXUMHtpwh0pFciMG+QZtdxlvjJdp7hF
         FJAqjByBfWFOKhYM5JuykgKDu1BPKSgdGM1HEJ1KwMMNF0WpVmSNMC1hf/cct8/NYxLA
         zZ2Fp7eWSNVxhcqHWWOB1faaLH8e4464KznweZy06xouNkE7wcElJC1Nq5ZTdSdKu/gS
         frGQ==
X-Forwarded-Encrypted: i=1; AFNElJ81noQ4dh9UaOFQ7OYAdnm4Iq2YhHkAxidOP1OllCzoEJiWTQp7mDXJK+jxRsPGDNTxiXLJ14K8wK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiOIvVP63D4v3j/r3LQ7UawiYLRpPnoK7tYP59yypuPZpC9R+
	IaTqS8+cNvoCupHqLFFkS1dFkTppLbx8dguL6F2OqcVqO4WrDjFxenqamzSPtL0Pgyk=
X-Gm-Gg: AeBDietLg16NWFTEIYWPXKJ7tcBy6lMWMhWO9snsdfu0/AqA/baUKMgP2fZ/NtdQV65
	DG948M8TtV0Gn9OxHrtLaTycwYxB6H42A5NIKvso5xBmCmcnOTHgCJLVsVpRMLey4sJ1MxzpK5o
	PYJ0MAvNjGKP7MybVIDoImx2/cnKFpK78s58u5hDHJvHee7brmNfY2HFeOPH8IeaUIJEW9OpZ3N
	jiggR8YHgRrELQ7J7JBbTzXG3d3PxrfhDU7tMd80rxCHB1vzFIEGE0nHQIDMETrtkSjEAsMFE78
	crS0dyik+mOC77wd9AzePTf4Z8NSVOfsD80B1Oas2hmYi0zoct7BuniuO2ICMXZIEU1Wy6X2i5p
	Ef5V7I1wdUa/ABq01IWuz4KBOgonhZTDf0mjFnxNFd3SOEdET3+n8jcaKrIN0gM0edSaVw8eNje
	77H1eh8zxNoXpmmSMm8bUCkTQFvmHnLA==
X-Received: by 2002:a05:6122:311a:b0:567:433b:e903 with SMTP id 71dfb90a1353d-56fa589b89emr7799096e0c.6.1776737486021;
        Mon, 20 Apr 2026 19:11:26 -0700 (PDT)
Received: from sales-arch ([2804:7f0:d889:b103:1320:e321:eae6:2f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa9351ca8sm6932891e0c.18.2026.04.20.19.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:11:24 -0700 (PDT)
From: rafasales@usp.br
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: "Rafael B. Sales" <rafasales@usp.br>,
	"Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] iio: light: ltr501: use automatic cleanup of locks
Date: Mon, 20 Apr 2026 23:10:01 -0300
Message-ID: <20260421021023.563290-3-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421021023.563290-1-rafasales@usp.br>
References: <20260421021023.563290-1-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael B. Sales" <rafasales@usp.br>

Replace `mutex_lock()` and `mutex_unlock()` calls with guards
to reduce boilerplate and allow for simpler code blocks.

Signed-off-by: Rafael B. Sales <rafasales@usp.br>
Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
---
 drivers/iio/light/ltr501.c | 94 +++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 75a49fd9bce0..d84b8f23c5a2 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -251,7 +251,7 @@ static int ltr501_ps_read_samp_freq(const struct ltr501_data *data,
 static int ltr501_als_write_samp_freq(struct ltr501_data *data,
 				      int val, int val2)
 {
-	int i, ret;
+	int i;
 
 	i = ltr501_match_samp_freq(ltr501_als_samp_table,
 				   ARRAY_SIZE(ltr501_als_samp_table),
@@ -260,17 +260,14 @@ static int ltr501_als_write_samp_freq(struct ltr501_data *data,
 	if (i < 0)
 		return i;
 
-	mutex_lock(&data->lock_als);
-	ret = regmap_field_write(data->reg_als_rate, i);
-	mutex_unlock(&data->lock_als);
-
-	return ret;
+	guard(mutex)(&data->lock_als);
+	return regmap_field_write(data->reg_als_rate, i);
 }
 
 static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
 				     int val, int val2)
 {
-	int i, ret;
+	int i;
 
 	i = ltr501_match_samp_freq(ltr501_ps_samp_table,
 				   ARRAY_SIZE(ltr501_ps_samp_table),
@@ -279,11 +276,8 @@ static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
 	if (i < 0)
 		return i;
 
-	mutex_lock(&data->lock_ps);
-	ret = regmap_field_write(data->reg_ps_rate, i);
-	mutex_unlock(&data->lock_ps);
-
-	return ret;
+	guard(mutex)(&data->lock_ps);
+	return regmap_field_write(data->reg_ps_rate, i);
 }
 
 static int ltr501_als_read_samp_period(const struct ltr501_data *data, int *val)
@@ -505,9 +499,8 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 		if (new_val < 0 || new_val > 0x0f)
 			return -EINVAL;
 
-		mutex_lock(&data->lock_als);
-		ret = regmap_field_write(data->reg_als_prst, new_val);
-		mutex_unlock(&data->lock_als);
+		scoped_guard(mutex, &data->lock_als)
+			ret = regmap_field_write(data->reg_als_prst, new_val);
 		if (ret >= 0)
 			data->als_period = period;
 
@@ -525,9 +518,8 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 		if (new_val < 0 || new_val > 0x0f)
 			return -EINVAL;
 
-		mutex_lock(&data->lock_ps);
-		ret = regmap_field_write(data->reg_ps_prst, new_val);
-		mutex_unlock(&data->lock_ps);
+		scoped_guard(mutex, &data->lock_ps)
+			ret = regmap_field_write(data->reg_ps_prst, new_val);
 		if (ret >= 0)
 			data->ps_period = period;
 
@@ -669,18 +661,16 @@ static int ltr501_read_info_raw(struct ltr501_data *data,
 
 	switch (chan->type) {
 	case IIO_INTENSITY:
-		mutex_lock(&data->lock_als);
-		ret = ltr501_read_als(data, buf);
-		mutex_unlock(&data->lock_als);
+		scoped_guard(mutex, &data->lock_als)
+			ret = ltr501_read_als(data, buf);
 		if (ret < 0)
 			return ret;
 		*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
 				   buf[0] : buf[1]);
 		return IIO_VAL_INT;
 	case IIO_PROXIMITY:
-		mutex_lock(&data->lock_ps);
-		ret = ltr501_read_ps(data);
-		mutex_unlock(&data->lock_ps);
+		scoped_guard(mutex, &data->lock_ps)
+			ret = ltr501_read_ps(data);
 		if (ret < 0)
 			return ret;
 		*val = ret & LTR501_PS_DATA_MASK;
@@ -705,9 +695,8 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			if (!iio_device_claim_direct(indio_dev))
 				return -EBUSY;
 
-			mutex_lock(&data->lock_als);
-			ret = ltr501_read_als(data, buf);
-			mutex_unlock(&data->lock_als);
+			scoped_guard(mutex, &data->lock_als)
+				ret = ltr501_read_als(data, buf);
 			iio_device_release_direct(indio_dev);
 			if (ret < 0)
 				return ret;
@@ -820,9 +809,8 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
 			if (val != 0)
 				return -EINVAL;
 
-			mutex_lock(&data->lock_als);
-			ret = ltr501_set_it_time(data, val2);
-			mutex_unlock(&data->lock_als);
+			scoped_guard(mutex, &data->lock_als)
+				ret = ltr501_set_it_time(data, val2);
 			return ret;
 		default:
 			return -EINVAL;
@@ -971,18 +959,16 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 			return -EINVAL;
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
-			mutex_lock(&data->lock_als);
-			ret = regmap_bulk_write(data->regmap,
-						LTR501_ALS_THRESH_UP,
-						&val, 2);
-			mutex_unlock(&data->lock_als);
+			scoped_guard(mutex, &data->lock_als)
+				ret = regmap_bulk_write(data->regmap,
+							 LTR501_ALS_THRESH_UP,
+							 &val, 2);
 			return ret;
 		case IIO_EV_DIR_FALLING:
-			mutex_lock(&data->lock_als);
-			ret = regmap_bulk_write(data->regmap,
-						LTR501_ALS_THRESH_LOW,
-						&val, 2);
-			mutex_unlock(&data->lock_als);
+			scoped_guard(mutex, &data->lock_als)
+				ret = regmap_bulk_write(data->regmap,
+							 LTR501_ALS_THRESH_LOW,
+							 &val, 2);
 			return ret;
 		default:
 			return -EINVAL;
@@ -992,18 +978,16 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 			return -EINVAL;
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
-			mutex_lock(&data->lock_ps);
-			ret = regmap_bulk_write(data->regmap,
-						LTR501_PS_THRESH_UP,
-						&val, 2);
-			mutex_unlock(&data->lock_ps);
+			scoped_guard(mutex, &data->lock_ps)
+				ret = regmap_bulk_write(data->regmap,
+							 LTR501_PS_THRESH_UP,
+							 &val, 2);
 			return ret;
 		case IIO_EV_DIR_FALLING:
-			mutex_lock(&data->lock_ps);
-			ret = regmap_bulk_write(data->regmap,
-						LTR501_PS_THRESH_LOW,
-						&val, 2);
-			mutex_unlock(&data->lock_ps);
+			scoped_guard(mutex, &data->lock_ps)
+				ret = regmap_bulk_write(data->regmap,
+							 LTR501_PS_THRESH_LOW,
+							 &val, 2);
 			return ret;
 		default:
 			return -EINVAL;
@@ -1100,14 +1084,12 @@ static int ltr501_write_event_config(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_INTENSITY:
-		mutex_lock(&data->lock_als);
-		ret = regmap_field_write(data->reg_als_intr, state);
-		mutex_unlock(&data->lock_als);
+		scoped_guard(mutex, &data->lock_als)
+			ret = regmap_field_write(data->reg_als_intr, state);
 		return ret;
 	case IIO_PROXIMITY:
-		mutex_lock(&data->lock_ps);
-		ret = regmap_field_write(data->reg_ps_intr, state);
-		mutex_unlock(&data->lock_ps);
+		scoped_guard(mutex, &data->lock_ps)
+			ret = regmap_field_write(data->reg_ps_intr, state);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.53.0

