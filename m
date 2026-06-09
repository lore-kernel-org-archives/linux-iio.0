Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104123BCF7
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970527; cv=none; b=uVSp5PKaBK5IlaV/2fRhS4k6QePLw5R/20P8Zf+PSM+z1ofqpUwoidfQTiZu1y3pOSVKA7njrwoNP3zH/lgKFHoqyCFgSWVAzFfly03R3dkD/VKAj5qj5BhfdPX8w90WhHCAFSdzNelMr/56p52Iq1mfdPMEhY+VG8GmTdoFtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970527; c=relaxed/simple;
	bh=QeW/STLyYG/i5jkBp17ftR+3cpihYYH8oMxgmL+y6rw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zt1N839wH/GbmI7jjPcteVVLG4NKigLCbniOiIXqiT4ZO3HTUx+0jzttni5yIKkXGln5L6XkjldMqMZcRM5XiQ0KtjKs1F1WfmmkbypqKZQODOfG2iLYM4v1SFfM6Ww92YCMmyicJGVQLrxpfUgnU8GneJkgrLk4ozMFNqGB5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxNrcDiF; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxNrcDiF"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-3042a388168so2661348eec.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 19:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780970525; x=1781575325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSgcU1GhcXamrNLMZjCeVVLL7W5g6J2Hhqtxw8/bHRE=;
        b=YxNrcDiFbOC0CMHeZPTlVIM5qGAq4MYv2hOJWwDcaQTAUU7kfGsb6f/iRWVh7s0BU/
         hhF/pwqKo1IoWtUiWHARtZndGTQuygSDZ7ROVxHJKdgkvjpDbE7NG+9qC9aYGRE8kQrY
         m47fhwYqfPZoG91kmjEaVQHmOnX+AKITzNdZ9fP+VsxByFaeogUS1iPV9AGR+NfejMoG
         9CRWJI0WbXKJi8Z6j5f6w3a17Wm3pb8r6kN211tmo8vL3Xn+6MjNFE1Po/z43EM+A5If
         t07M/eeh0kbtf0wxgv6qKfqL+wfF9AjhguYQRfAkV6jpByd0Ele5+uI+8hEAwhYvWplp
         UBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780970525; x=1781575325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSgcU1GhcXamrNLMZjCeVVLL7W5g6J2Hhqtxw8/bHRE=;
        b=V/0qrueVQj69RCbjNv1WXVSNNdQ6D2gfQiykQ6O2vKgdSkNKzawMLLmwXV/rQ23Mzk
         fBlxMOAOxOfaICqD+A7Cphi7Nkvw5LASGfgjd0wR5j6963doGc14polLQjwQuAoCdhSz
         P1Gy84GK1ixdUO8hwsG1uilxsaNHV1XjmCQRnWimGv0aUo5Bx5uQAgdMwleRVROOGPLg
         i9nhex1ap1dQPUGqqHjesuHMe5jvMdh7D1FW7M5fPaHJpgXMQJxnR6txw7/picQ2zHAA
         aeGtXJDnX2Icak++JZnxidfMCMx4WGoZTlSwEM8V/6Bb1aKKNZFBjBCMwR+CIJssPwlN
         nVmA==
X-Forwarded-Encrypted: i=1; AFNElJ/2tJdQ5+33uOOyyv+55YdBMHc3cUuW2AF7wgBv8qvoyWamypxVHLNnM3DgRHXtJBvNDqE3/Rkh1xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3SrZ09352rccFjkPPqrWktX3yOyhdOTckmGb9Pir6PyFbVyW
	cii7+soBJArAsE2cBKGi86aikAU8nLwg4/wAyGj7FtAKlme/GJeOyky3
X-Gm-Gg: Acq92OHHfnyEO8mJrVnoDZ3vPUPHE9fXgN6xXlJzDQx7GqhuWtU4VL9i+geNyN/0Ceq
	M6GpKkNFB/2JV+MnTnxlIdQsmscgUcZoxKmzOdX6Wk0vo795knQ48IghUTbnkst29o8k66mAtnY
	ctFRLb/7Tx5+fQborJ5nHJvsN8/ZQtYnLSTRKlt46BPMAjp2C9gYPO3qjlas/LyGjZFDKFuNicF
	NVyy9odyyce94ujKDIMgquGmJqI/hf4Bt602wS/3j9W/CeumJwvpLUNjPW45fI9O3NYGscQ9V7A
	jlvDeZ7NL19D3vhJrkukc8rwSXsiy1IDc9bLQmW1423DQhGFejaMS2HLn/1QmzxPdousPn/9Za7
	mLI/QKpUG2wbxHHdsBHJOQTOjztQ3/RRjGjzWwX3C77hATtwYbDrCuKiXMMq1Y0hh2ssvYRUbCL
	fzYym5MujI1szkZ4lSdJkD0t36tUBKq3waCCPGDGO6xXHw2Ai5yuLFbSHaBOs/WUY0Aw==
X-Received: by 2002:a05:7300:d516:b0:304:e258:a758 with SMTP id 5a478bee46e88-3077fa43c2emr8564330eec.0.1780970525251;
        Mon, 08 Jun 2026 19:02:05 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e8csm19046340eec.16.2026.06.08.19.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:02:04 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v3] iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
Date: Tue,  9 Jun 2026 02:01:16 +0000
Message-Id: <20260609020116.88462-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
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
v3:
 - Add missing include <linux/bitfield.h>

v2:
 - Use FIELD_PREP() and FIELD_GET() helpers as suggested by
   Jonathan Cameron
 - Simplify bmc150_magn_set_odr() by returning directly from
   the matching table entry

 drivers/iio/magnetometer/bmc150_magn.c | 34 ++++++++++++--------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index bf2551988008..fff7e88ef6a8 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/cleanup.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
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

