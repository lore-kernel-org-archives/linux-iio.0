Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188C3630AF
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065476; cv=none; b=QCbMYeY/fKqp62sqPIik6DToQgdZSc25ob5WMSY3azq5xf48DOrr32rhh7otJk3btckc4iw4Pa+s/Hca5KBe1/jWNN6tKmUYaYcakt96IlpFx6JTLQhP8UMjyLNeQN3UaaDYzO7xeL3112a7iVOqBtogEpvQufAr8feBsM8sl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065476; c=relaxed/simple;
	bh=9M5GPmdNqIXqkG9CpsR2NODL59ShANf4I82yZOxyN2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IHT6U5G2FIEj5z7Di5JFcNMHoezqGO8jmfaaoTgnDqC4kKNyNnM8ECsQ3sgiQlXnq8VJmriw4kvENJNJL3yOVBJ+3vmE4lVv8bySqzA/oLadsw6q5xrepwoiE44Kn4LhRy+sjsVmj2zyMtr9FFUCczu7+G1yy4heez5i6h1Y70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF5yS1ET; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF5yS1ET"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1370417c01cso8301995c88.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 21:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781065475; x=1781670275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jjXyfjM9Y5GYTs/KbPwC5lsFRedcbtN53s1l4Z8gmM=;
        b=cF5yS1ETCgRWu4rxRvSVqd1Vx76SkbZ6APUOI1JcSiMoJk070YdE0h9iuUms99l9HT
         bdKaYbwRg3RMXbsilNIxGOS2U0fbUpN+LH2h5Asgug9czvlB4MV0hIAzi396/qQB+W0W
         gMn3B0F00zbH23t0IsFtlvy34BvjFJO+NUzT/Aq6Tns3WiUHvXuqbKv4ye2wHw68MWEy
         80evx9kbaEvCATBkKWEfbCrd9Y9MZ0quKgL/F+qdfoy1ClPnhzJ81BJkPKAUGURGDy3h
         YlzA+fZMUUa7G4Wdhjc0gRqLwXv4dn5o8ZTxUg8ZY/O9pxOx+gsf22oMfqq5C16bXcKZ
         ++TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781065475; x=1781670275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3jjXyfjM9Y5GYTs/KbPwC5lsFRedcbtN53s1l4Z8gmM=;
        b=tQMeISs4l4Re/jieuqtp91mv2gx7jOgnBxScPqSNKKPMh5g9dYP7CRti7xodl77mjP
         +TsVnWAvxXnAOzoowiEyLpZNFUNR/k+KH/J46NQ2eDvUM423ZYZylXbES5uwTgbfG8xc
         gs+319iwIx+BUz6B3X5rihHldzN2jzSSYhSYcKTist0R0MS+wvYMJT5g+bzLTP9ZMwMF
         48wFRUEbVH7YbEU3wu9dzcv10vw+3WbahvlTKkS787fspGBCdFSNNokhVXf/GK3a12W3
         Lr5GTedD7EsXzTSrGsOywUhHhFzlvPWB2gfciNVwulFPsVMY81R7Lf+nQOsZgnwm2J96
         5ATQ==
X-Forwarded-Encrypted: i=1; AFNElJ+p9mM65BuerZYJ9m9jOaC0F1RbOK7LZ3dJo1GcCOyZ+BSFGKYgt7zSq9jphaPznLW8PvDH4tOlpGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9V/5O8tCBP0IQR+/QlL15U98zDB4s6U76nXhA+njRubnoLNy
	403QUOXqjC8DXjRfvE1vnaTZfZBb0pLvPpWVFt33JG9AfAWVl0FBGriM
X-Gm-Gg: Acq92OEuItcDsSdODDFEuvZsMRxdYA/uRANBX4Q3sxVyskEGCB4qIKgbUczQlqji4/o
	BY14+G5hnCPRQQqiYXeNOvitpekYLilXDYX5L08vLA6A/sdMG4Sc7dFNwyzpM4I/kOnZHHuldL9
	EJWuTj9KvrmIhhTtWijtg8ZJoPlfCHBhBjAv3OMHe6Z4BC7gpUiHkas6HNjtHQLGKKN4yXrELmI
	GBdHd1ASqXcvKR4NaAffVZRjyNMGs1cT3l5L9JvTzF/sxkpJCZq1mUbz3XKb/W4dw1g3u/0TrPQ
	xlNaSYI/ReE3oCNgKqEO7IIrRucN4F8O8dfEnGRYfQtfonv9WEJm91OVi0CsSToJiBhhYzCMfce
	G4QiJQwnTtVfJaOwPiW9JCwWigVTj10Hf3mFdm+ENaalOtBmPpzghJCeRvcB26GehAM8cVZvthm
	FpB/w5DSvGSVm6Lbb+WSR6UxV43YVylVBbdtMwvP4c7e/HWzgcmbY/+liUAvIKLKDKng==
X-Received: by 2002:a05:7022:2222:b0:138:63d:e328 with SMTP id a92af1059eb24-138065b6855mr11419781c88.0.1781065474802;
        Tue, 09 Jun 2026 21:24:34 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1381495bb00sm10941619c88.3.2026.06.09.21.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:24:34 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH 2/2] iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
Date: Wed, 10 Jun 2026 04:24:18 +0000
Message-Id: <20260610042418.90308-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610042418.90308-1-dennylin0707@gmail.com>
References: <20260610042418.90308-1-dennylin0707@gmail.com>
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
 drivers/iio/magnetometer/bmc150_magn.c | 34 ++++++++++++--------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6f2a4a863fbe..c402ac852efb 100644
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
@@ -290,7 +291,8 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
 	ret = regmap_read(data->regmap, BMC150_MAGN_REG_OPMODE_ODR, &reg_val);
 	if (ret < 0)
 		return ret;
-	odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;
+
+	odr_val = FIELD_GET(BMC150_MAGN_MASK_ODR, reg_val);
 
 	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++)
 		if (bmc150_magn_samp_freq_table[i].reg_val == odr_val) {
@@ -303,21 +305,17 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
 
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
@@ -800,7 +798,7 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
-				 state << BMC150_MAGN_SHIFT_DRDY_EN);
+				 FIELD_PREP(BMC150_MAGN_MASK_DRDY_EN, state));
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

