Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D717557E
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968117; cv=none; b=F8C2OMi/9RvNatGejJBzV01alT0CnmEPEl38FSlAdNdxnMcZPWZSikUY08K7Zg60gY4mQYeXH6tlZktYwsDXI9h55BstsYvf5ZEDip+6Qq6g/4+vVBVaG9EKZDcsYa46hg3T9uWt0up1i4LDEMNYic4Ng9Hl6CFvZnb43DpV9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968117; c=relaxed/simple;
	bh=ClVmOPRDZbczQeQTMQJc0gzFE+32iWL1PtVo27XcIw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E9EDPNlnyWaUz0P/b9ns8sXbLfI2pDmRREF8xrcBr5GI9uTy3nENEQbeAhJFB3tMAYWlPh0tF/QrwtH1dpoUlbREGEnPFEJAeBrVpyRLJQRKt+x8TTqqRhKm6YKm7MbgkhkzV/pdRV1bwjyFrHzbzi5XIqXzcoI6EkYjbmrSpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2rg8Aof; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2rg8Aof"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304cf518c9dso6096799eec.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 18:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780968115; x=1781572915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1T6M3q9vWUARIrQ+Jhsac3VXCz7mYnZ7/30iC1lOPm8=;
        b=o2rg8Aof+GX0BAkXmin+9+kdWDKN5R4v57nMD6EazZ9RRqUY7M/M9ld7wHmjGyoA4R
         o10bk4QyRiAEtBHi4Ad2/+ac7ChTAqP2JKVSORkc7Y7yTS6uOzcneiSUFsyn+Zcjxho1
         MdJYZZc4614iZteo7teDhuLhQ5tPeei7/NJzqaDMyUZ7ctgNkarvtEuydobtIB2wIW2L
         ecYsBpnzwNiYaaL+S/L1guIWKuXr4vu/YbWA+3/FJbetOsDRn7zunYH2j2L8lVHFcFuZ
         PXcc/Ns13XjYjXlfnn6RdkzokrdJiWhTCwlZcIDNTMm/Gs6TZrDPywsgCR0dPYJKND+o
         8asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780968115; x=1781572915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T6M3q9vWUARIrQ+Jhsac3VXCz7mYnZ7/30iC1lOPm8=;
        b=hsMhGH1A37/gKUIKkUZ/etatrd4mKhaGc3sLeg0Z4ZtwgejnDtC1RFnN2ZojWdL2qR
         ts/MjNF/QwFFpyKM521JQFT4bfKdqKbOTsbNeTa+wQlPIGCy+xefs3yon6gDNR6QyBKy
         vDiGweGyisR+bICnhCU5eDclJRTOwlUy3SRboOMr4ABlsPqQiQuz3U7jXzXyIe8O1/Eb
         U1Pc1vH3R5SEG4sDwpTqp7Ezf3XUPxBvjTYkJXOHuv8iHL9laeLkeLXDtn6sBl9FHmHt
         E6bymLqsIS8Tf1X627fA6hwnTR+BRW6Qqo/F/XVG1UJ6CksHK7kpsZgkgaKzgJsplWna
         XADg==
X-Forwarded-Encrypted: i=1; AFNElJ+U4yYf32216s8oV5tfXFCZAawcVkQoFi8J43vlVGhA5UWaCHmhf/ULc2hZgxWXzPrzAcI/0SOvN9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp2ctEBdL3TXV2MpryM7R2QVNOrwDqd5JzsrR00qPVddNPW/15
	hUn7TXZmiRb57Pet/YbBWVKdVt0C1t8apuCcXK4be03ockG9EjKIIkAa
X-Gm-Gg: Acq92OGBcFTkpvKcl4A7pfhWz4XzWDrqAMng1jT6X8pV578RHYgpqCkoRjlKDMipC0Q
	2g1vEAwA3vpJ3o7jrFz/mJPpf83EjGuvs77A0ywZw3Q4pP80v/g0RBKkSS5+XB8IxkzSVpG0NAf
	R7iTFmMkJhCcCvzrzdnzQaTM8EStX8Qi2H9KSSWE+CwkoArO6sxAA8lDxt+7YKFZxLAe+bubspx
	DmHt+XP05QOK6puDIquzmEsWHYmC4Zy3OWN1YyPZx6c+4FNr+/BFhm3KIk4FNu9X7gGp6N9yI99
	/Z8KFCqCI2PYQ0y/IZecH9IKuNHGb/8XRmEgmZpszniWWscR/DJVd9AJZYGBkeCNKBi9swy1qVO
	9gq3AJBrkv0mLKCbZ7Yei5a7TTaiY6SlJQfPPzyc8ujOxNgEg65VMSBIHIp47sGgUxV/DkosuyE
	EYKUIqJmzSQGisAPZQNu3XFWKzgwmKWe1NGvAqt5w3UaiSnt9d0FRhCgBWIqW62tAzjA==
X-Received: by 2002:a05:7300:7488:b0:304:ed85:5f43 with SMTP id 5a478bee46e88-3077b1e1aeemr9735492eec.24.1780968114755;
        Mon, 08 Jun 2026 18:21:54 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm19638913eec.24.2026.06.08.18.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 18:21:54 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
Date: Tue,  9 Jun 2026 01:21:45 +0000
Message-Id: <20260609012145.87180-1-dennylin0707@gmail.com>
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
v2:
 - Use FIELD_PREP() and FIELD_GET() helpers as suggested by
   Jonathan Cameron
 - Simplify bmc150_magn_set_odr() by returning directly from
   the matching table entry

 drivers/iio/magnetometer/bmc150_magn.c | 33 ++++++++++++--------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index bf2551988008..716b6a088c33 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -245,14 +245,14 @@ static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
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
@@ -290,7 +290,8 @@ static int bmc150_magn_get_odr(struct bmc150_magn_data *data, int *val)
 	ret = regmap_read(data->regmap, BMC150_MAGN_REG_OPMODE_ODR, &reg_val);
 	if (ret < 0)
 		return ret;
-	odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;
+
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

