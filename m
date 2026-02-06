Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08B3148D3
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398301; cv=none; b=eFNqzr5NmnT8Y9H8ZoLkwVUGgv/gPo7o8ZdZxGTdjHT3nBOZlGvPreiNlt5FFKBadn519iGbZWDnCHVK7/trSffefcDXmtNRjJ9Y8IbwnyfdSdcsN5eu/Lp3HRfMXKj+0mnv+xLUyigZ+OYnsoF1rPGT6vfLmqcA8T43o6ZakkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398301; c=relaxed/simple;
	bh=Qp3VW7lPdzZMZcPj/RaAXF/2prjbFYx6PbSaOqLf94I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkqtnpfxDYxtNqZ43jOWy6bP8CEFm7pR7ARJZDOq20OwNr7yRAHS7muaBZl80uXVJRSKoWwTRkVmL7bXh0xDrMpjfFXDkhKtzLluS+bbCk5LjbRi2REj2I03OoF0KinDlsxLnAjTJL24HLkCRC5HaJ20uTmctf2HBlDwfPQHST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpUqAUPW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpUqAUPW"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50146483bf9so26838161cf.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398300; x=1771003100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHAOn9F3wGzW3hbvbaPPEa/9vfiFND2QOSVBOy9F83E=;
        b=YpUqAUPW8mghoLDKdhIL10ulpu6iJ4SROVtkdOdDLyx+UaiDum5eZeZDiOFGk92VNB
         yqATnIqZryi4V84kCMqiHtXl1XnKeXNN7t8KF/D6AEmx2MtLvqcKS/hEY+O93is8T0KZ
         EBj4g5hkfeErrAGoiwsNYfIt9ecpGULZd75Hpx3zFoSSDin3HqTXbfhhgT/4VePTe6oR
         xkws7mJ9fwe5mbIMdhNlGARxFXOBMVidGFIMIe+0+tKtvLQa6ymIsZjga8X+OAmlAmkv
         hqTcH8MPIbjsPpn5cWT4GfR97nTxm30XPUyvkdlv1aTHBKTptqn28GlhVxr2acgr3WeG
         vsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398300; x=1771003100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHAOn9F3wGzW3hbvbaPPEa/9vfiFND2QOSVBOy9F83E=;
        b=X3VLMURgzmKH2+EOFZnyspjdPVdwacFSUsuCFGn8FlRNyo+V0LAN0oCjQUrjqAWh+N
         kRNJXcb565dVzw5U/l1pfRdydZj9Wn1V0L5Oxs1PmsmokTd8gIC6eb/pIQYUeJI2OxoL
         ameUzKlSB92RyxSQhw5VUhd6ezxJzXtBWby8Ct7/OyOsL8cP0hart2w1p0RZGxdVy/j7
         HoyaFHQmRnHaDUR5mGZ9T4LyQEIzIz47udpYxpCCEzDjhqYnpElx2Ecb5RrnIbZKJV1h
         mMuCDTIGYC+elkPilDauhOHNXnY+oJsV4zI78cUeX1FN9RD/kcZwkRSD5xbnOSzcEHB6
         qy7g==
X-Forwarded-Encrypted: i=1; AJvYcCXvLHHb13F9K9ECdR0iGc1UuPMKXfU7AgyiDAbQtmrXpTQwVOdluVPu7+T0g/KTIvWWff1mli4evl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YShoEUAQuPemLxUV/Lr/DH03vMmBmvYPDuaYksQxxNckMoov
	VBNKC1zMj/mhbu0zszrJLL9Da92Tl+6jV1sREgcdMv9or3LMA+Ek3Izx
X-Gm-Gg: AZuq6aI612tjmuclbA3u6H/t/VDHBb7G3fx6kgx7dhZvaVqZ8QRQnVpJ0vHWrSkTJTi
	zcOXH15trT7mzykmr2fYlXeLaRcexWUrQupIwM8A5iC7iw7i3MGQeR7vOdeJNGU3NbDacSPI94f
	5w03IH4b3/IcdkVh7TRTNOJoneAXALJ8HfocCHRH/+7BvtYAiBlcq+jlvr93PdyIx6rDu1DGQpw
	4RzmHxwhoRCO5RYanXB6Bis0Zv5Q93FX5WwFkwkMgMgTMZzMqKDC+A3euIB8Vm4Sijm7iDCgASI
	AOrb+MEnzwFRaBmVDuVQrILu5CMome+QxVy6bB0EmpBf2Ks1Xcr8mx4sNAhXj2LxWMzjpvek+le
	SBoiCsNgFMc+CfU409wBzbVUOv2agnFZEUzkbmOsnY2lvrQVyJSPeH0MjKzkcTb3lnJCxTIL3PO
	OmK1ZERLmZh43EGw98PJdbv3LffY5Uk4Cb2Zfl9klIluSnQKk6szp+
X-Received: by 2002:a05:622a:c6:b0:505:e4ea:ffa6 with SMTP id d75a77b69052e-5063995539amr49040081cf.54.1770398299373;
        Fri, 06 Feb 2026 09:18:19 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c068c10sm24757496d6.46.2026.02.06.09.18.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Feb 2026 09:18:18 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v4] iio: magnetometer: bmc150_magn: cleanup mutex usage and coding style
Date: Fri,  6 Feb 2026 12:18:14 -0500
Message-ID: <20260206171814.91064-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex lock/unlock calls with guard() to simplify error

handling and reduce goto usage. This ensures RAII-style cleanup where

the mutex is always released automatically.

Replace msleep(5) with usleep_range(5000, 6000) to avoid checkpatch

warnings about short msleep delays.

Also fix several indentation and line wrapping style issues to verify

cleanly with checkpatch.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
Changes in v4:
- Replace scoped_guard() with guard() to avoid lexical scope issues with goto
  and return values which caused logic errors in previous versions.
- Replace msleep(5) with usleep_range(5000, 6000) to avoid checkpatch
  warning.
- Fix indentation and line wrapping to cleanliness.
- Extend guard() usage to all mutex_lock() instances in the driver.

Changes in v3:
- Add Reviewed-by tags.

Changes in v2:
- Use guard() for mutex protection in bmc150_magn_data_rdy_trigger_set_state.

 drivers/iio/magnetometer/bmc150_magn.c | 371 ++++++++++++-------------
 1 file changed, 174 insertions(+), 197 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 73d9183a354b..8cd61ae46ca5 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -28,64 +29,64 @@
 
 #include "bmc150_magn.h"
 
-#define BMC150_MAGN_REG_CHIP_ID			0x40
-#define BMC150_MAGN_CHIP_ID_VAL			0x32
-
-#define BMC150_MAGN_REG_X_L			0x42
-#define BMC150_MAGN_REG_X_M			0x43
-#define BMC150_MAGN_REG_Y_L			0x44
-#define BMC150_MAGN_REG_Y_M			0x45
-#define BMC150_MAGN_SHIFT_XY_L			3
-#define BMC150_MAGN_REG_Z_L			0x46
-#define BMC150_MAGN_REG_Z_M			0x47
-#define BMC150_MAGN_SHIFT_Z_L			1
-#define BMC150_MAGN_REG_RHALL_L			0x48
-#define BMC150_MAGN_REG_RHALL_M			0x49
-#define BMC150_MAGN_SHIFT_RHALL_L		2
-
-#define BMC150_MAGN_REG_INT_STATUS		0x4A
-
-#define BMC150_MAGN_REG_POWER			0x4B
-#define BMC150_MAGN_MASK_POWER_CTL		BIT(0)
-
-#define BMC150_MAGN_REG_OPMODE_ODR		0x4C
-#define BMC150_MAGN_MASK_OPMODE			GENMASK(2, 1)
-#define BMC150_MAGN_SHIFT_OPMODE		1
-#define BMC150_MAGN_MODE_NORMAL			0x00
-#define BMC150_MAGN_MODE_FORCED			0x01
-#define BMC150_MAGN_MODE_SLEEP			0x03
-#define BMC150_MAGN_MASK_ODR			GENMASK(5, 3)
-#define BMC150_MAGN_SHIFT_ODR			3
-
-#define BMC150_MAGN_REG_INT			0x4D
-
-#define BMC150_MAGN_REG_INT_DRDY		0x4E
-#define BMC150_MAGN_MASK_DRDY_EN		BIT(7)
-#define BMC150_MAGN_SHIFT_DRDY_EN		7
-#define BMC150_MAGN_MASK_DRDY_INT3		BIT(6)
-#define BMC150_MAGN_MASK_DRDY_Z_EN		BIT(5)
-#define BMC150_MAGN_MASK_DRDY_Y_EN		BIT(4)
-#define BMC150_MAGN_MASK_DRDY_X_EN		BIT(3)
-#define BMC150_MAGN_MASK_DRDY_DR_POLARITY	BIT(2)
-#define BMC150_MAGN_MASK_DRDY_LATCHING		BIT(1)
-#define BMC150_MAGN_MASK_DRDY_INT3_POLARITY	BIT(0)
-
-#define BMC150_MAGN_REG_LOW_THRESH		0x4F
-#define BMC150_MAGN_REG_HIGH_THRESH		0x50
-#define BMC150_MAGN_REG_REP_XY			0x51
-#define BMC150_MAGN_REG_REP_Z			0x52
-#define BMC150_MAGN_REG_REP_DATAMASK		GENMASK(7, 0)
-
-#define BMC150_MAGN_REG_TRIM_START		0x5D
-#define BMC150_MAGN_REG_TRIM_END		0x71
-
-#define BMC150_MAGN_XY_OVERFLOW_VAL		-4096
-#define BMC150_MAGN_Z_OVERFLOW_VAL		-16384
+#define BMC150_MAGN_REG_CHIP_ID 0x40
+#define BMC150_MAGN_CHIP_ID_VAL 0x32
+
+#define BMC150_MAGN_REG_X_L 0x42
+#define BMC150_MAGN_REG_X_M 0x43
+#define BMC150_MAGN_REG_Y_L 0x44
+#define BMC150_MAGN_REG_Y_M 0x45
+#define BMC150_MAGN_SHIFT_XY_L 3
+#define BMC150_MAGN_REG_Z_L 0x46
+#define BMC150_MAGN_REG_Z_M 0x47
+#define BMC150_MAGN_SHIFT_Z_L 1
+#define BMC150_MAGN_REG_RHALL_L 0x48
+#define BMC150_MAGN_REG_RHALL_M 0x49
+#define BMC150_MAGN_SHIFT_RHALL_L 2
+
+#define BMC150_MAGN_REG_INT_STATUS 0x4A
+
+#define BMC150_MAGN_REG_POWER 0x4B
+#define BMC150_MAGN_MASK_POWER_CTL BIT(0)
+
+#define BMC150_MAGN_REG_OPMODE_ODR 0x4C
+#define BMC150_MAGN_MASK_OPMODE GENMASK(2, 1)
+#define BMC150_MAGN_SHIFT_OPMODE 1
+#define BMC150_MAGN_MODE_NORMAL 0x00
+#define BMC150_MAGN_MODE_FORCED 0x01
+#define BMC150_MAGN_MODE_SLEEP 0x03
+#define BMC150_MAGN_MASK_ODR GENMASK(5, 3)
+#define BMC150_MAGN_SHIFT_ODR 3
+
+#define BMC150_MAGN_REG_INT 0x4D
+
+#define BMC150_MAGN_REG_INT_DRDY 0x4E
+#define BMC150_MAGN_MASK_DRDY_EN BIT(7)
+#define BMC150_MAGN_SHIFT_DRDY_EN 7
+#define BMC150_MAGN_MASK_DRDY_INT3 BIT(6)
+#define BMC150_MAGN_MASK_DRDY_Z_EN BIT(5)
+#define BMC150_MAGN_MASK_DRDY_Y_EN BIT(4)
+#define BMC150_MAGN_MASK_DRDY_X_EN BIT(3)
+#define BMC150_MAGN_MASK_DRDY_DR_POLARITY BIT(2)
+#define BMC150_MAGN_MASK_DRDY_LATCHING BIT(1)
+#define BMC150_MAGN_MASK_DRDY_INT3_POLARITY BIT(0)
+
+#define BMC150_MAGN_REG_LOW_THRESH 0x4F
+#define BMC150_MAGN_REG_HIGH_THRESH 0x50
+#define BMC150_MAGN_REG_REP_XY 0x51
+#define BMC150_MAGN_REG_REP_Z 0x52
+#define BMC150_MAGN_REG_REP_DATAMASK GENMASK(7, 0)
+
+#define BMC150_MAGN_REG_TRIM_START 0x5D
+#define BMC150_MAGN_REG_TRIM_END 0x71
+
+#define BMC150_MAGN_XY_OVERFLOW_VAL -4096
+#define BMC150_MAGN_Z_OVERFLOW_VAL -16384
 
 /* Time from SUSPEND to SLEEP */
-#define BMC150_MAGN_START_UP_TIME_MS		3
+#define BMC150_MAGN_START_UP_TIME_MS 3
 
-#define BMC150_MAGN_AUTO_SUSPEND_DELAY_MS	2000
+#define BMC150_MAGN_AUTO_SUSPEND_DELAY_MS 2000
 
 #define BMC150_MAGN_REGVAL_TO_REPXY(regval) (((regval) * 2) + 1)
 #define BMC150_MAGN_REGVAL_TO_REPZ(regval) ((regval) + 1)
@@ -148,14 +149,9 @@ struct bmc150_magn_data {
 static const struct {
 	int freq;
 	u8 reg_val;
-} bmc150_magn_samp_freq_table[] = { {2, 0x01},
-				    {6, 0x02},
-				    {8, 0x03},
-				    {10, 0x00},
-				    {15, 0x04},
-				    {20, 0x05},
-				    {25, 0x06},
-				    {30, 0x07} };
+} bmc150_magn_samp_freq_table[] = { { 2, 0x01 },  { 6, 0x02 },	{ 8, 0x03 },
+				    { 10, 0x00 }, { 15, 0x04 }, { 20, 0x05 },
+				    { 25, 0x06 }, { 30, 0x07 } };
 
 enum bmc150_magn_presets {
 	LOW_POWER_PRESET,
@@ -169,10 +165,10 @@ static const struct bmc150_magn_preset {
 	u8 rep_z;
 	u8 odr;
 } bmc150_magn_presets_table[] = {
-	[LOW_POWER_PRESET] = {3, 3, 10},
-	[REGULAR_PRESET] =  {9, 15, 10},
-	[ENHANCED_REGULAR_PRESET] =  {15, 27, 10},
-	[HIGH_ACCURACY_PRESET] =  {47, 83, 20},
+	[LOW_POWER_PRESET] = { 3, 3, 10 },
+	[REGULAR_PRESET] = { 9, 15, 10 },
+	[ENHANCED_REGULAR_PRESET] = { 15, 27, 10 },
+	[HIGH_ACCURACY_PRESET] = { 47, 83, 20 },
 };
 
 #define BMC150_MAGN_DEFAULT_PRESET REGULAR_PRESET
@@ -239,17 +235,15 @@ static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
 		usleep_range(BMC150_MAGN_START_UP_TIME_MS * 1000, 20000);
 		return 0;
 	case BMC150_MAGN_POWER_MODE_SLEEP:
-		return regmap_update_bits(data->regmap,
-					  BMC150_MAGN_REG_OPMODE_ODR,
-					  BMC150_MAGN_MASK_OPMODE,
-					  BMC150_MAGN_MODE_SLEEP <<
-					  BMC150_MAGN_SHIFT_OPMODE);
+		return regmap_update_bits(
+			data->regmap, BMC150_MAGN_REG_OPMODE_ODR,
+			BMC150_MAGN_MASK_OPMODE,
+			BMC150_MAGN_MODE_SLEEP << BMC150_MAGN_SHIFT_OPMODE);
 	case BMC150_MAGN_POWER_MODE_NORMAL:
-		return regmap_update_bits(data->regmap,
-					  BMC150_MAGN_REG_OPMODE_ODR,
-					  BMC150_MAGN_MASK_OPMODE,
-					  BMC150_MAGN_MODE_NORMAL <<
-					  BMC150_MAGN_SHIFT_OPMODE);
+		return regmap_update_bits(
+			data->regmap, BMC150_MAGN_REG_OPMODE_ODR,
+			BMC150_MAGN_MASK_OPMODE,
+			BMC150_MAGN_MODE_NORMAL << BMC150_MAGN_SHIFT_OPMODE);
 	}
 
 	return -EINVAL;
@@ -264,8 +258,7 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 	else
 		pm_runtime_put_autosuspend(data->dev);
 	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to change power state to %d\n", on);
+		dev_err(data->dev, "failed to change power state to %d\n", on);
 		return ret;
 	}
 
@@ -298,12 +291,11 @@ static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
 
 	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
 		if (bmc150_magn_samp_freq_table[i].freq == val) {
-			ret = regmap_update_bits(data->regmap,
-						 BMC150_MAGN_REG_OPMODE_ODR,
-						 BMC150_MAGN_MASK_ODR,
-						 bmc150_magn_samp_freq_table[i].
-						 reg_val <<
-						 BMC150_MAGN_SHIFT_ODR);
+			ret = regmap_update_bits(
+				data->regmap, BMC150_MAGN_REG_OPMODE_ODR,
+				BMC150_MAGN_MASK_ODR,
+				bmc150_magn_samp_freq_table[i].reg_val
+					<< BMC150_MAGN_SHIFT_ODR);
 			if (ret < 0)
 				return ret;
 			return 0;
@@ -341,8 +333,7 @@ static int bmc150_magn_set_max_odr(struct bmc150_magn_data *data, int rep_xy,
 	max_odr = 1000000 / (145 * rep_xy + 500 * rep_z + 980);
 	if (odr > max_odr) {
 		dev_err(data->dev,
-			"Can't set oversampling with sampling freq %d\n",
-			odr);
+			"Can't set oversampling with sampling freq %d\n", odr);
 		return -EINVAL;
 	}
 	data->max_odr = max_odr;
@@ -363,10 +354,15 @@ static s32 bmc150_magn_compensate_x(struct bmc150_magn_trim_regs *tregs, s16 x,
 		rhall = xyz1;
 
 	val = ((s16)(((u16)((((s32)xyz1) << 14) / rhall)) - ((u16)0x4000)));
-	val = ((s16)((((s32)x) * ((((((((s32)tregs->xy2) * ((((s32)val) *
-	      ((s32)val)) >> 7)) + (((s32)val) *
-	      ((s32)(((s16)tregs->xy1) << 7)))) >> 9) + ((s32)0x100000)) *
-	      ((s32)(((s16)tregs->x2) + ((s16)0xA0)))) >> 12)) >> 13)) +
+	val = ((s16)((((s32)x) *
+		      ((((((((s32)tregs->xy2) *
+			    ((((s32)val) * ((s32)val)) >> 7)) +
+			   (((s32)val) * ((s32)(((s16)tregs->xy1) << 7)))) >>
+			  9) +
+			 ((s32)0x100000)) *
+			((s32)(((s16)tregs->x2) + ((s16)0xA0)))) >>
+		       12)) >>
+		     13)) +
 	      (((s16)tregs->x1) << 3);
 
 	return (s32)val;
@@ -385,10 +381,15 @@ static s32 bmc150_magn_compensate_y(struct bmc150_magn_trim_regs *tregs, s16 y,
 		rhall = xyz1;
 
 	val = ((s16)(((u16)((((s32)xyz1) << 14) / rhall)) - ((u16)0x4000)));
-	val = ((s16)((((s32)y) * ((((((((s32)tregs->xy2) * ((((s32)val) *
-	      ((s32)val)) >> 7)) + (((s32)val) *
-	      ((s32)(((s16)tregs->xy1) << 7)))) >> 9) + ((s32)0x100000)) *
-	      ((s32)(((s16)tregs->y2) + ((s16)0xA0)))) >> 12)) >> 13)) +
+	val = ((s16)((((s32)y) *
+		      ((((((((s32)tregs->xy2) *
+			    ((((s32)val) * ((s32)val)) >> 7)) +
+			   (((s32)val) * ((s32)(((s16)tregs->xy1) << 7)))) >>
+			  9) +
+			 ((s32)0x100000)) *
+			((s32)(((s16)tregs->y2) + ((s16)0xA0)))) >>
+		       12)) >>
+		     13)) +
 	      (((s16)tregs->y1) << 3);
 
 	return (s32)val;
@@ -407,9 +408,10 @@ static s32 bmc150_magn_compensate_z(struct bmc150_magn_trim_regs *tregs, s16 z,
 	if (z == BMC150_MAGN_Z_OVERFLOW_VAL)
 		return S32_MIN;
 
-	val = (((((s32)(z - z4)) << 15) - ((((s32)z3) * ((s32)(((s16)rhall) -
-	      ((s16)xyz1)))) >> 2)) / (z2 + ((s16)(((((s32)z1) *
-	      ((((s16)rhall) << 1))) + (1 << 15)) >> 16))));
+	val = (((((s32)(z - z4)) << 15) -
+		((((s32)z3) * ((s32)(((s16)rhall) - ((s16)xyz1)))) >> 2)) /
+	       (z2 + ((s16)(((((s32)z1) * ((((s16)rhall) << 1))) + (1 << 15)) >>
+			    16))));
 
 	return val;
 }
@@ -422,8 +424,8 @@ static int bmc150_magn_read_xyz(struct bmc150_magn_data *data, s32 *buffer)
 	u16 rhall;
 	struct bmc150_magn_trim_regs tregs;
 
-	ret = regmap_bulk_read(data->regmap, BMC150_MAGN_REG_X_L,
-			       values, sizeof(values));
+	ret = regmap_bulk_read(data->regmap, BMC150_MAGN_REG_X_L, values,
+			       sizeof(values));
 	if (ret < 0)
 		return ret;
 
@@ -432,8 +434,8 @@ static int bmc150_magn_read_xyz(struct bmc150_magn_data *data, s32 *buffer)
 	raw_z = (s16)le16_to_cpu(values[AXIS_Z]) >> BMC150_MAGN_SHIFT_Z_L;
 	rhall = le16_to_cpu(values[RHALL]) >> BMC150_MAGN_SHIFT_RHALL_L;
 
-	ret = regmap_bulk_read(data->regmap, BMC150_MAGN_REG_TRIM_START,
-			       &tregs, sizeof(tregs));
+	ret = regmap_bulk_read(data->regmap, BMC150_MAGN_REG_TRIM_START, &tregs,
+			       sizeof(tregs));
 	if (ret < 0)
 		return ret;
 
@@ -445,8 +447,8 @@ static int bmc150_magn_read_xyz(struct bmc150_magn_data *data, s32 *buffer)
 }
 
 static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
 {
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret, tmp;
@@ -456,29 +458,23 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (iio_buffer_enabled(indio_dev))
 			return -EBUSY;
-		mutex_lock(&data->mutex);
+		guard(mutex)(&data->mutex);
 
 		ret = bmc150_magn_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = bmc150_magn_read_xyz(data, values);
 		if (ret < 0) {
 			bmc150_magn_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
 			return ret;
 		}
 		*val = values[chan->scan_index];
 
 		ret = bmc150_magn_set_power_state(data, false);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
+		if (ret < 0)
 			return ret;
-		}
 
-		mutex_unlock(&data->mutex);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/*
@@ -520,8 +516,8 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
 }
 
 static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
-				 struct iio_chan_spec const *chan,
-				 int val, int val2, long mask)
+				 struct iio_chan_spec const *chan, int val,
+				 int val2, long mask)
 {
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
@@ -530,45 +526,33 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val > data->max_odr)
 			return -EINVAL;
-		mutex_lock(&data->mutex);
-		ret = bmc150_magn_set_odr(data, val);
-		mutex_unlock(&data->mutex);
-		return ret;
+		guard(mutex)(&data->mutex);
+		return bmc150_magn_set_odr(data, val);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->channel2) {
 		case IIO_MOD_X:
 		case IIO_MOD_Y:
 			if (val < 1 || val > 511)
 				return -EINVAL;
-			mutex_lock(&data->mutex);
+			guard(mutex)(&data->mutex);
 			ret = bmc150_magn_set_max_odr(data, val, 0, 0);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
+			if (ret < 0)
 				return ret;
-			}
-			ret = regmap_update_bits(data->regmap,
-						 BMC150_MAGN_REG_REP_XY,
-						 BMC150_MAGN_REG_REP_DATAMASK,
-						 BMC150_MAGN_REPXY_TO_REGVAL
-						 (val));
-			mutex_unlock(&data->mutex);
-			return ret;
+			return regmap_update_bits(
+				data->regmap, BMC150_MAGN_REG_REP_XY,
+				BMC150_MAGN_REG_REP_DATAMASK,
+				BMC150_MAGN_REPXY_TO_REGVAL(val));
 		case IIO_MOD_Z:
 			if (val < 1 || val > 256)
 				return -EINVAL;
-			mutex_lock(&data->mutex);
+			guard(mutex)(&data->mutex);
 			ret = bmc150_magn_set_max_odr(data, 0, val, 0);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
+			if (ret < 0)
 				return ret;
-			}
-			ret = regmap_update_bits(data->regmap,
-						 BMC150_MAGN_REG_REP_Z,
-						 BMC150_MAGN_REG_REP_DATAMASK,
-						 BMC150_MAGN_REPZ_TO_REGVAL
-						 (val));
-			mutex_unlock(&data->mutex);
-			return ret;
+			return regmap_update_bits(
+				data->regmap, BMC150_MAGN_REG_REP_Z,
+				BMC150_MAGN_REG_REP_DATAMASK,
+				BMC150_MAGN_REPZ_TO_REGVAL(val));
 		default:
 			return -EINVAL;
 		}
@@ -600,7 +584,7 @@ static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
 
 static const struct iio_mount_matrix *
 bmc150_magn_get_mount_matrix(const struct iio_dev *indio_dev,
-			      const struct iio_chan_spec *chan)
+			     const struct iio_chan_spec *chan)
 {
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 
@@ -609,7 +593,7 @@ bmc150_magn_get_mount_matrix(const struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec_ext_info bmc150_magn_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_magn_get_mount_matrix),
-	{ }
+	{}
 };
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(bmc150_magn_show_samp_freq_avail);
@@ -623,23 +607,22 @@ static const struct attribute_group bmc150_magn_attrs_group = {
 	.attrs = bmc150_magn_attributes,
 };
 
-#define BMC150_MAGN_CHANNEL(_axis) {					\
-	.type = IIO_MAGN,						\
-	.modified = 1,							\
-	.channel2 = IIO_MOD_##_axis,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
-			      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
-				    BIT(IIO_CHAN_INFO_SCALE),		\
-	.scan_index = AXIS_##_axis,					\
-	.scan_type = {							\
-		.sign = 's',						\
-		.realbits = 32,						\
-		.storagebits = 32,					\
-		.endianness = IIO_LE					\
-	},								\
-	.ext_info = bmc150_magn_ext_info,				\
-}
+#define BMC150_MAGN_CHANNEL(_axis)                                           \
+	{                                                                    \
+		.type = IIO_MAGN,                                            \
+		.modified = 1,                                               \
+		.channel2 = IIO_MOD_##_axis,                                 \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |               \
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |   \
+					    BIT(IIO_CHAN_INFO_SCALE),        \
+		.scan_index = AXIS_##_axis,                                  \
+		.scan_type = { .sign = 's',                                  \
+			       .realbits = 32,                               \
+			       .storagebits = 32,                            \
+			       .endianness = IIO_LE },                       \
+		.ext_info = bmc150_magn_ext_info,                            \
+	}
 
 static const struct iio_chan_spec bmc150_magn_channels[] = {
 	BMC150_MAGN_CHANNEL(X),
@@ -655,8 +638,8 @@ static const struct iio_info bmc150_magn_info = {
 };
 
 static const unsigned long bmc150_magn_scan_masks[] = {
-					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
-					0};
+	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z), 0
+};
 
 static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 {
@@ -665,7 +648,8 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
+
 	ret = bmc150_magn_read_xyz(data, data->scan.chans);
 	if (ret < 0)
 		goto err;
@@ -674,7 +658,7 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 				    pf->timestamp);
 
 err:
-	mutex_unlock(&data->mutex);
+
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -695,7 +679,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	 * 3ms power-on time according to datasheet, let's better
 	 * be safe than sorry and set this delay to 5ms.
 	 */
-	msleep(5);
+	usleep_range(5000, 6000);
 
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
 					 false);
@@ -720,8 +704,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	preset = bmc150_magn_presets_table[BMC150_MAGN_DEFAULT_PRESET];
 	ret = bmc150_magn_set_odr(data, preset.odr);
 	if (ret < 0) {
-		dev_err(data->dev, "Failed to set ODR to %d\n",
-			preset.odr);
+		dev_err(data->dev, "Failed to set ODR to %d\n", preset.odr);
 		goto err_poweroff;
 	}
 
@@ -736,8 +719,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	ret = regmap_write(data->regmap, BMC150_MAGN_REG_REP_Z,
 			   BMC150_MAGN_REPZ_TO_REGVAL(preset.rep_z));
 	if (ret < 0) {
-		dev_err(data->dev, "Failed to set REP Z to %d\n",
-			preset.rep_z);
+		dev_err(data->dev, "Failed to set REP Z to %d\n", preset.rep_z);
 		goto err_poweroff;
 	}
 
@@ -782,9 +764,9 @@ static void bmc150_magn_trig_reen(struct iio_trigger *trig)
 	if (!data->dready_trigger_on)
 		return;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
+
 	ret = bmc150_magn_reset_intr(data);
-	mutex_unlock(&data->mutex);
 	if (ret)
 		dev_err(data->dev, "Failed to reset interrupt\n");
 }
@@ -794,7 +776,7 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	guard(mutex)(&data->mutex);
 
@@ -839,8 +821,8 @@ static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops = {
 	.postdisable = bmc150_magn_buffer_postdisable,
 };
 
-int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
-		      int irq, const char *name)
+int bmc150_magn_probe(struct device *dev, struct regmap *regmap, int irq,
+		      const char *name)
 {
 	struct bmc150_magn_data *data;
 	struct iio_dev *indio_dev;
@@ -881,10 +863,9 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->info = &bmc150_magn_info;
 
 	if (irq > 0) {
-		data->dready_trig = devm_iio_trigger_alloc(dev,
-							   "%s-dev%d",
-							   indio_dev->name,
-							   iio_device_id(indio_dev));
+		data->dready_trig =
+			devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+					       iio_device_id(indio_dev));
 		if (!data->dready_trig) {
 			ret = -ENOMEM;
 			dev_err(dev, "iio trigger alloc failed\n");
@@ -899,20 +880,17 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 			goto err_poweroff;
 		}
 
-		ret = request_threaded_irq(irq,
-					   iio_trigger_generic_data_rdy_poll,
-					   NULL,
-					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					   "bmc150_magn_event",
-					   data->dready_trig);
+		ret = request_threaded_irq(
+			irq, iio_trigger_generic_data_rdy_poll, NULL,
+			IRQF_TRIGGER_RISING | IRQF_ONESHOT, "bmc150_magn_event",
+			data->dready_trig);
 		if (ret < 0) {
 			dev_err(dev, "request irq %d failed\n", irq);
 			goto err_trigger_unregister;
 		}
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev,
-					 iio_pollfunc_store_time,
+	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
 					 bmc150_magn_trigger_handler,
 					 &bmc150_magn_buffer_setup_ops);
 	if (ret < 0) {
@@ -973,9 +951,11 @@ void bmc150_magn_remove(struct device *dev)
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
 
-	mutex_lock(&data->mutex);
-	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
-	mutex_unlock(&data->mutex);
+	{
+		guard(mutex)(&data->mutex);
+		bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
+					   true);
+	}
 
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
@@ -988,10 +968,9 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
 					 true);
-	mutex_unlock(&data->mutex);
 	if (ret < 0) {
 		dev_err(dev, "powering off device failed\n");
 		return ret;
@@ -1019,10 +998,9 @@ static int bmc150_magn_suspend(struct device *dev)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
 					 true);
-	mutex_unlock(&data->mutex);
 
 	return ret;
 }
@@ -1033,10 +1011,9 @@ static int bmc150_magn_resume(struct device *dev)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
 					 true);
-	mutex_unlock(&data->mutex);
 
 	return ret;
 }
@@ -1044,8 +1021,8 @@ static int bmc150_magn_resume(struct device *dev)
 
 const struct dev_pm_ops bmc150_magn_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(bmc150_magn_suspend, bmc150_magn_resume)
-	SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
-			   bmc150_magn_runtime_resume, NULL)
+		SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
+				   bmc150_magn_runtime_resume, NULL)
 };
 EXPORT_SYMBOL_NS(bmc150_magn_pm_ops, "IIO_BMC150_MAGN");
 
-- 
2.44.0

