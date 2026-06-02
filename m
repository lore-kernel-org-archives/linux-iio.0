Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A175359A8B
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406778; cv=none; b=dbe5/b9UlvCADUo9084kwGyLXHROBpmhzOgRnovxxmBd64WgPhrlgbXECbwzQR0dJ87sSMhbUp5ps4ZMyvkyzT7PmU0EDFHLuJ2qYoX2EbgzkQNSrkcMhOh4KvpKSQlGZsblwhJkWVzE1KvrA2yEe5aaWc16NfuUHODT9SCOdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406778; c=relaxed/simple;
	bh=r0E5CivM1/ZEcIXD1h7mg0sFWV73cnFrKq+QZeFEXyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FojmApXeSrp8EDuu6hCID1nogamfCFKCkRNQYWo43y400UBnVZ19jokn4d496DY9DcotLIponRG/4IcAR95LFxDMDhBLtaJn1ws8yt3zfEC3Jp0+BHzmhZw9R+RxSsVPFh6qFL7WdVxPAFfsWsqB4iFvXRnw6CbsVk1iANxuJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAMwKjH8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAMwKjH8"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1488900f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780406774; x=1781011574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PMTKUy6ENsicmAq/+c5qKf2rQ3PwGVi1nptZesNjVc=;
        b=gAMwKjH8NMbnTst+E/elrm9qiv2ve+Ol4ZlMdvAWm6fNCGBpkcm3Wf7wI701oXvlHM
         bTD1+2WuyxQ6rU6Nxew9j/Yxb2YcAWqhNvt9fEXQrW0Fbx5EQHTMCybrRnoA2qq2beaU
         adVyqkhR6o6HoelvGP0E2WgYk/wjSbS5f4C4RnavNKj+rRp3it4he9B1iKknFg0Ubg+b
         TI7O8lpAthzz8C3fLTIJ2gMfUtV1DrKA/t1D2SgvfQZyUX/Dqk31HgJNwRdT6NbYOGvz
         S/Hy9XUHULTA8y4sL61AgEJZO64RS7QMfmyxDy5hS8PV4WSqCoQG7ya9AIBCGZSZ32Mf
         bIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780406774; x=1781011574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PMTKUy6ENsicmAq/+c5qKf2rQ3PwGVi1nptZesNjVc=;
        b=RJ7CvnlqxhUPwv+HSq5lKGLSZBHMU59onVEs+oPCX2oM19x/9EBwESJbUQgJUS95x2
         LvOMeQ/GprhqZN+W60oe8Swz8ePzqWkrixDmd3J300u18WeTBwDskgY4kZ0dPfmOLFsS
         t7MT8jeXp6d5G9pVRr/faJSm/6GV2LqpKLP+Ha4rZd1+p3l5U/5lkMM9f3rVVxt7sW60
         s9aoWy4JjY51yb2LIXUVvWZTCcN9UzXlD7ijATMCp1oez9GmMvdbJzDO1CJTaqIxjPLk
         wf7OGfdphwDNwBqrCu8ts1W8q+W24Z/SpTuV97B7x0Cl2Qk3LX7UWJujex7PE9dKD33R
         7Gcg==
X-Gm-Message-State: AOJu0YxddjlSmEs8HK4GcKYs8B3P54H/4Wum+uvMAszuGFpzWsiQody9
	NSCp/nMqy1cLDOsE/3xki5q2jojkFzQEN5FyJ03wC+1gzESLECrDMToq
X-Gm-Gg: Acq92OEBuGJW4Y/rJsmOKnh/4vDW46PYZ0STK3hdpMVv6VOjuxkCJElgnyFFMYsg9vA
	qwFtyymE6zWqx7jyf+nKS2b58r0OPUFbKeQiHCaPMNklcaJ1n26XcPgiGStsSKc3/S7s7bGWleL
	L5FjsOq88+PSjD0iY2mIZdTSeY5XmPqyYWMvy2gXc9IUWH7eu2HVG5VgPJk39Iv/xbEef5ymNCs
	MMt8x6lchUdWNADZC55nxB0jn3bWuNdTeSOsyTQXglieoAR+1TZ3lBE/l+T0iTHILTIEr1/vUIG
	8n8fza+KXnrHsiixRzEy+0whQOaMRDh/Mc2xeQ+Xc+Uxrk/j+e8a9vF65PUB/mZ1e8X3EdXs27c
	aQUOVP/H0kzGtAvNcWuVMxROiOqgKKfpTIic3TuKP2eAM1MBTPg1nUJqR36PBlJpYG7e7Po19pL
	mEB8nTGIq4pg3vipKmKP+adLfup0Fldu51+/S9m5xnYNKXadZFgZlBvxlZ1eSpxQl3v0LwykPxM
	sKiLyvWevsfm2k=
X-Received: by 2002:a05:600c:3587:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490a2941425mr300222235e9.29.1780406774058;
        Tue, 02 Jun 2026 06:26:14 -0700 (PDT)
Received: from fedora ([102.78.143.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e3431bsm63273725e9.12.2026.06.02.06.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:26:13 -0700 (PDT)
From: Jad Keskes <inasj268@gmail.com>
To: linux-staging@lists.linux.dev
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jad Keskes <inasj268@gmail.com>
Subject: [PATCH] staging: iio: addac: drop CamelCase from adt7316 symbol names
Date: Tue,  2 Jun 2026 14:25:34 +0100
Message-ID: <20260602132534.101554-1-inasj268@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch flagged several CamelCase names in this driver.
Switch them to snake_case to stay consistent with kernel
coding style.

Signed-off-by: Jad Keskes <inasj268@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 64 ++++++++++++++---------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 8a9a8262c..124e416a6 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -663,7 +663,7 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,
 		adt7316_store_da_high_resolution,
 		0);
 
-static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
+static ssize_t adt7316_show_ain_internal_vref(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -677,7 +677,7 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
 		!!(chip->config3 & ADT7516_AIN_IN_VREF));
 }
 
-static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
+static ssize_t adt7316_store_ain_internal_vref(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -704,9 +704,9 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(AIN_internal_Vref, 0644,
-		adt7316_show_AIN_internal_Vref,
-		adt7316_store_AIN_internal_Vref,
+static IIO_DEVICE_ATTR(ain_internal_vref, 0644,
+		adt7316_show_ain_internal_vref,
+		adt7316_store_ain_internal_vref,
 		0);
 
 static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
@@ -787,7 +787,7 @@ static IIO_DEVICE_ATTR(enable_proportion_DACB, 0644,
 		       adt7316_store_enable_prop_DACB,
 		       0);
 
-static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
+static ssize_t adt7316_show_dac_2vref_ch_mask(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -798,7 +798,7 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
 		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
 }
 
-static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
+static ssize_t adt7316_store_dac_2vref_ch_mask(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -825,9 +825,9 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, 0644,
-		       adt7316_show_DAC_2Vref_ch_mask,
-		       adt7316_store_DAC_2Vref_ch_mask,
+static IIO_DEVICE_ATTR(dac_2vref_channels_mask, 0644,
+		       adt7316_show_dac_2vref_ch_mask,
+		       adt7316_store_dac_2vref_ch_mask,
 		       0);
 
 static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
@@ -948,7 +948,7 @@ static IIO_DEVICE_ATTR(update_DAC, 0644,
 		       adt7316_store_update_DAC,
 		       0);
 
-static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
+static ssize_t adt7316_show_dac_ab_vref_bypass(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -959,7 +959,7 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
 }
 
-static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
+static ssize_t adt7316_store_dac_ab_vref_bypass(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -982,12 +982,12 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, 0644,
-		       adt7316_show_DA_AB_Vref_bypass,
-		       adt7316_store_DA_AB_Vref_bypass,
+static IIO_DEVICE_ATTR(dac_ab_vref_bypass, 0644,
+		       adt7316_show_dac_ab_vref_bypass,
+		       adt7316_store_dac_ab_vref_bypass,
 		       0);
 
-static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
+static ssize_t adt7316_show_dac_cd_vref_bypass(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -998,7 +998,7 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
 }
 
-static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
+static ssize_t adt7316_store_dac_cd_vref_bypass(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -1021,12 +1021,12 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, 0644,
-		       adt7316_show_DA_CD_Vref_bypass,
-		       adt7316_store_DA_CD_Vref_bypass,
+static IIO_DEVICE_ATTR(dac_cd_vref_bypass, 0644,
+		       adt7316_show_dac_cd_vref_bypass,
+		       adt7316_store_dac_cd_vref_bypass,
 		       0);
 
-static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
+static ssize_t adt7316_show_dac_internal_vref(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -1041,7 +1041,7 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 		       !!(chip->ldac_config & ADT7316_DAC_IN_VREF));
 }
 
-static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
+static ssize_t adt7316_store_dac_internal_vref(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -1082,9 +1082,9 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(DAC_internal_Vref, 0644,
-		       adt7316_show_DAC_internal_Vref,
-		       adt7316_store_DAC_internal_Vref,
+static IIO_DEVICE_ATTR(dac_internal_vref, 0644,
+		       adt7316_show_dac_internal_vref,
+		       adt7316_store_dac_internal_vref,
 		       0);
 
 static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
@@ -1644,13 +1644,13 @@ static struct attribute *adt7316_attributes[] = {
 	&iio_dev_attr_da_high_resolution.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
-	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
+	&iio_dev_attr_dac_2vref_channels_mask.dev_attr.attr,
 	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
 	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
 	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_dac_ab_vref_bypass.dev_attr.attr,
+	&iio_dev_attr_dac_cd_vref_bypass.dev_attr.attr,
+	&iio_dev_attr_dac_internal_vref.dev_attr.attr,
 	&iio_dev_attr_VDD.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
 	&iio_dev_attr_ex_temp.dev_attr.attr,
@@ -1684,15 +1684,15 @@ static struct attribute *adt7516_attributes[] = {
 	&iio_dev_attr_enable_smbus_timeout.dev_attr.attr,
 	&iio_dev_attr_powerdown.dev_attr.attr,
 	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
-	&iio_dev_attr_AIN_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_ain_internal_vref.dev_attr.attr,
 	&iio_dev_attr_da_high_resolution.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
-	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
+	&iio_dev_attr_dac_2vref_channels_mask.dev_attr.attr,
 	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
 	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
 	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_dac_internal_vref.dev_attr.attr,
 	&iio_dev_attr_VDD.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
 	&iio_dev_attr_ex_temp_AIN1.dev_attr.attr,
-- 
2.54.0

