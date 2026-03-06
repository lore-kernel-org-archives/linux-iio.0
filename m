Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEA374E59
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781469; cv=none; b=RUMFgVu/zjavwyrtXNbk7e1BgpADHUvNKK5/7YJZgcjuTmMtWGc+uRLZ2ENiXmAIlQ8oD7942w7KicI8+Qe77El+lf9DbxkMJwhLb9dnkoNX5L3tl+O25GOI/P0dtf6I5YzqyfBI++rG3ApTUh9Aifaxt88HrhRWDgVglo3VdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781469; c=relaxed/simple;
	bh=oeQmZIlz2JJz59gBI5BPetmmm+BU84jH/mvfVStshOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nc7alTHzgAs5RXl6wpENk33rsmm5FvBSnHFt57JQjoEvJgsefosbKktZ+xJ/rO4OnufLWKKULE3A7fyUOo1QGZmOASHfNgpssw5RhSotHh81DjbaPVomFTiDbDULdvS5CrzQFrwadtn3Gks+IfFoKm+Niioxt10lYPGN1YGfEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwlPhxRa; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwlPhxRa"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so10218414eec.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 23:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772781467; x=1773386267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05RQko9c+bX0Bo97buy99JJ6b/j1nxAiAkWb4nM2qMM=;
        b=OwlPhxRauwNMKq2mANiK8CEu4ocOym0LdpiWuAFMQkfX6PtYi8AfJhBk7eAAS+Ah64
         /TktnOECkdHZrB0oNndhGpW5whMdmHQl+lua9OehK9O8YxLzWCo4KrtLkKSYEVVkhyqD
         izyYG99ct1L9VlvMeN6UJ5W7WgFA2VIMhXllpGInFz4lDoDvS9jX0puynBi/pxbaYQYj
         wVVmQ41pPlDjD778DHF2o2Aqm4YoiBTOK58k1JVG0Xb0wd0I9U0+uqjJGNTJA9lgY3R5
         N5y8cfsaimXplKxXN9917y2c7cF9kYscAZmsH98weZEfyYd4HxK1T1PlgDQz5JFA9whw
         of3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772781467; x=1773386267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=05RQko9c+bX0Bo97buy99JJ6b/j1nxAiAkWb4nM2qMM=;
        b=k70FNeDy8Og1Yiwhs2pr5EoSbvU0E3j45uFe4KIVgp6tWuEpUc2wpC/uw81VU+pRnC
         J3lZK7axpR+cNalLh3hs8fbUpNeeIwjtPp8MjOmh7K8XgzlyQprXKjUKLJh93G2dPMES
         fDpPsI8HSuc/vnzEf4ZTYGNhpLuu2dYChgEesRxgLwenYKgXGmQtwTITaAUyhlpGzEjF
         Zqxc14OayJ97wGBjPtH2USRghCQdb+iPJHmLrbT98T33jBfIcsprhqRs+XHh17JTqRJj
         i/do9+RzLIc9N1kwhpJfqSRt/CNC1i3jEBH2Yd5Gd8tvNcnGJhN14FXXhkRgAHoJ3AoK
         9kVA==
X-Forwarded-Encrypted: i=1; AJvYcCUBOYSEUc+ovxmSrW8xlyyYDZF4rrrOqFU8Q9S9oTek3iq5PFWkjnqHAc5ZsFZ0eDfivNreuf/Hc/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4dINI/K9HvexVe2xzobS5gvLy4SHACiKxCOU+Kz5zVBSBN+k
	/XEqgWKnu9wtFDvqFVVZpJlLnQXg5ZEOp7Lx6t+lC8VIJ0wCgjjZNo4og2rodEp3
X-Gm-Gg: ATEYQzw5awFW2SXCsRSJUGlSndmd8/TXZgLC6wfueWf6WsXKwqOYTvqF48ZajYHaIO3
	J30fbVyn+BOgaqI6VDl+bpFdro7uwRwloKf1ylONPXHT/7Bvh1V43j/Q7KCbarFwuQgcO2eY9gO
	Y6+u6Bw1xnfyFy/mFcQCCoCplfjfymDxXbum+iCxFvYm/UAF5bOA9NO9gY+UVQb4Onrr6lNCMCP
	oePM0iQAHjvJGkJ5H27nHro1T8GX5qsKmw0XWCnYO4zzf657j4BEaleHho4vHZGrXAxfVYKiqUz
	fLK6w8fQ+wKpu5Ewnl0VJ8mCGmbWMmBb29/PGyNu55iNeAqrjhJ+nP8N6pkDA719leB3qJeaFv6
	WIU0AoL4PNl1MGlVlQSkBPeDb91K/EVAsZNIz94GgiKhfEQ9kj3K4TOx8L5kt2nUbYWwCvhVSsR
	rVuWnjzOVaFsyfQ/HtYtLIPtdWnVW305Pu+MRlNoI4DnL5lmrT
X-Received: by 2002:a05:7300:d70c:b0:2be:171c:5034 with SMTP id 5a478bee46e88-2be4de8dfe3mr416221eec.3.1772781467139;
        Thu, 05 Mar 2026 23:17:47 -0800 (PST)
Received: from [192.168.1.187] ([76.50.196.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96f25bsm545713eec.28.2026.03.05.23.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:17:46 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
Date: Thu, 05 Mar 2026 23:16:59 -0800
Subject: [PATCH v2 2/4] staging: iio: adt7316: remove shift/offset macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-adt7316-correct-macros-v2-2-3702e3841c42@gmail.com>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
In-Reply-To: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Harris <michaelharriscode@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772781459; l=6748;
 i=michaelharriscode@gmail.com; s=20260130; h=from:subject:message-id;
 bh=oeQmZIlz2JJz59gBI5BPetmmm+BU84jH/mvfVStshOg=;
 b=Ev++nxoH1vfEiiEqCE4gFGEJhwvyysEaC6C/O/fX0YszI4ksJfMyuysgemfLswxqioxHzuv8F
 EbZzrLwOkzXDbkxRQcnW0NYPomM64yCd6SyFug4hezKck92zaTJrK28
X-Developer-Key: i=michaelharriscode@gmail.com; a=ed25519;
 pk=td/zQD3XANAhdG3Kf3mSetXiynk1Ql0eM4s0+eks5DU=

Remove shift/offset macros and instead use the corresponding mask with
FIELD_GET(), FIELD_PREP(), or FIELD_FIT().

In cases where an appropriate mask didn't exist, it was created.

One of the shift/offset macros was used for a convoluted dynamic
bitfield extraction. In its place, a helper function,
adt7316_extract_ad_lsb(), was created so the shift/offset could be
removed.

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 59 ++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 1412808c50c76a68b5771a25c46dd3308c5cbcdb..b8b66f4dd14bb59c3d29fdd569d84f0dd786db9e 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
@@ -31,10 +32,11 @@
 #define ADT7316_LSB_IN_TEMP_VDD		0x3
 #define ADT7316_LSB_IN_TEMP_MASK	0x3
 #define ADT7316_LSB_VDD_MASK		0xC
-#define ADT7316_LSB_VDD_OFFSET		2
 #define ADT7316_LSB_EX_TEMP_AIN		0x4
-#define ADT7316_LSB_EX_TEMP_MASK	0x3
-#define ADT7516_LSB_AIN_SHIFT		2
+#define ADT7316_LSB_EX_TEMP_AIN1_MASK	GENMASK_U32(1, 0)
+#define ADT7516_LSB_AIN2_MASK		GENMASK_U32(3, 2)
+#define ADT7516_LSB_AIN3_MASK		GENMASK_U32(5, 4)
+#define ADT7516_LSB_AIN4_MASK		GENMASK_U32(7, 6)
 #define ADT7316_AD_MSB_DATA_BASE        0x6
 #define ADT7316_AD_MSB_DATA_REGS        3
 #define ADT7516_AD_MSB_DATA_REGS        6
@@ -46,8 +48,8 @@
 #define ADT7516_MSB_AIN3		0xA
 #define ADT7516_MSB_AIN4		0xB
 #define ADT7316_DA_DATA_BASE		0x10
-#define ADT7316_DA_10_BIT_LSB_SHIFT	6
-#define ADT7316_DA_12_BIT_LSB_SHIFT	4
+#define ADT7316_DA_10_BIT_LSB_MASK	GENMASK_U32(7, 6)
+#define ADT7316_DA_12_BIT_LSB_MASK	GENMASK_U32(7, 4)
 #define ADT7316_DA_MSB_DATA_REGS	4
 #define ADT7316_LSB_DAC_A		0x10
 #define ADT7316_MSB_DAC_A		0x11
@@ -128,7 +130,6 @@
  */
 #define ADT7316_DA_2VREF_CH_MASK	0xF
 #define ADT7316_DA_EN_MODE_MASK		0x30
-#define ADT7316_DA_EN_MODE_SHIFT	4
 #define ADT7316_DA_EN_MODE_SINGLE	0x00
 #define ADT7316_DA_EN_MODE_AB_CD	0x10
 #define ADT7316_DA_EN_MODE_ABCD		0x20
@@ -143,7 +144,6 @@
 #define ADT7316_DAC_IN_VREF		0x10
 #define ADT7516_DAC_AB_IN_VREF		0x10
 #define ADT7516_DAC_CD_IN_VREF		0x20
-#define ADT7516_DAC_IN_VREF_OFFSET	4
 #define ADT7516_DAC_IN_VREF_MASK	0x30
 
 /*
@@ -155,7 +155,7 @@
  * ADT7316 value masks
  */
 #define ADT7316_VALUE_MASK		0xfff
-#define ADT7316_T_VALUE_FLOAT_OFFSET	2
+#define ADT7316_AD_MSB_MASK		GENMASK_U32(9, 2)
 
 /*
  * ADT7316 hardware constants
@@ -873,11 +873,11 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 		return -EPERM;
 
 	ret = kstrtou8(buf, 10, &data);
-	if (ret || data > (ADT7316_DA_EN_MODE_MASK >> ADT7316_DA_EN_MODE_SHIFT))
+	if (ret || !FIELD_FIT(ADT7316_DA_EN_MODE_MASK, data))
 		return -EINVAL;
 
 	dac_config = chip->dac_config & (~ADT7316_DA_EN_MODE_MASK);
-	dac_config |= data << ADT7316_DA_EN_MODE_SHIFT;
+	dac_config |= FIELD_PREP(ADT7316_DA_EN_MODE_MASK, data);
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
@@ -1038,8 +1038,7 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return sysfs_emit(buf, "0x%x\n",
-			(chip->ldac_config & ADT7516_DAC_IN_VREF_MASK) >>
-			ADT7516_DAC_IN_VREF_OFFSET);
+			FIELD_GET(ADT7516_DAC_IN_VREF_MASK, chip->ldac_config));
 	return sysfs_emit(buf, "%d\n",
 		       !!(chip->ldac_config & ADT7316_DAC_IN_VREF));
 }
@@ -1090,6 +1089,22 @@ static IIO_DEVICE_ATTR(DAC_internal_Vref, 0644,
 		       adt7316_store_DAC_internal_Vref,
 		       0);
 
+static u8 adt7316_extract_ad_lsb(u8 lsb, int channel)
+{
+	switch (channel) {
+	case ADT7316_AD_SINGLE_CH_EX:
+		return FIELD_GET(ADT7316_LSB_EX_TEMP_AIN1_MASK, lsb);
+	case ADT7516_AD_SINGLE_CH_AIN2:
+		return FIELD_GET(ADT7516_LSB_AIN2_MASK, lsb);
+	case ADT7516_AD_SINGLE_CH_AIN3:
+		return FIELD_GET(ADT7516_LSB_AIN3_MASK, lsb);
+	case ADT7516_AD_SINGLE_CH_AIN4:
+		return FIELD_GET(ADT7516_LSB_AIN4_MASK, lsb);
+	default:
+		return 0;
+	}
+}
+
 static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 			       int channel, char *buf)
 {
@@ -1113,7 +1128,7 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		if (ret)
 			return -EIO;
 
-		data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
+		data = FIELD_PREP(ADT7316_AD_MSB_MASK, msb);
 		data |= lsb & ADT7316_LSB_IN_TEMP_MASK;
 		break;
 	case ADT7316_AD_SINGLE_CH_VDD:
@@ -1128,8 +1143,8 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		if (ret)
 			return -EIO;
 
-		data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
-		data |= (lsb & ADT7316_LSB_VDD_MASK) >> ADT7316_LSB_VDD_OFFSET;
+		data = FIELD_PREP(ADT7316_AD_MSB_MASK, msb);
+		data |= FIELD_GET(ADT7316_LSB_VDD_MASK, lsb);
 		return sysfs_emit(buf, "%d\n", data);
 	default: /* ex_temp and ain */
 		ret = chip->bus.read(chip->bus.client,
@@ -1142,10 +1157,8 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		if (ret)
 			return -EIO;
 
-		data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
-		data |= lsb & (ADT7316_LSB_EX_TEMP_MASK <<
-			(ADT7516_LSB_AIN_SHIFT * (channel -
-			(ADT7316_MSB_EX_TEMP - ADT7316_AD_MSB_DATA_BASE))));
+		data = FIELD_PREP(ADT7316_AD_MSB_MASK, msb);
+		data |= adt7316_extract_ad_lsb(lsb, channel);
 
 		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 			return sysfs_emit(buf, "%d\n", data);
@@ -1410,9 +1423,9 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 		return -EIO;
 
 	if (chip->dac_bits == 12)
-		data = lsb >> ADT7316_DA_12_BIT_LSB_SHIFT;
+		data = FIELD_GET(ADT7316_DA_12_BIT_LSB_MASK, lsb);
 	else if (chip->dac_bits == 10)
-		data = lsb >> ADT7316_DA_10_BIT_LSB_SHIFT;
+		data = FIELD_GET(ADT7316_DA_10_BIT_LSB_MASK, lsb);
 	data |= msb << offset;
 
 	return sysfs_emit(buf, "%d\n", data);
@@ -1441,9 +1454,9 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 	if (chip->dac_bits > 8) {
 		lsb = data & ((1 << offset) - 1);
 		if (chip->dac_bits == 12)
-			lsb_reg = lsb << ADT7316_DA_12_BIT_LSB_SHIFT;
+			lsb_reg = FIELD_PREP(ADT7316_DA_12_BIT_LSB_MASK, lsb);
 		else
-			lsb_reg = lsb << ADT7316_DA_10_BIT_LSB_SHIFT;
+			lsb_reg = FIELD_PREP(ADT7316_DA_10_BIT_LSB_MASK, lsb);
 		ret = chip->bus.write(chip->bus.client,
 			ADT7316_DA_DATA_BASE + channel * 2, lsb_reg);
 		if (ret)

-- 
2.53.0

