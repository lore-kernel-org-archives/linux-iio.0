Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2854756D1
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553124; cv=none; b=KiqPUMT99A3BgHuaK/RBAw9AKpYXevbz6FwJZRlnXfo08WxNoj/tj3p4+LIFIbZ7iKoU35dxI8y6X+BZZZdcnIf/mUFy+mfdp0dlmLe17mYmThvSVPWu+WmxEiWU+9+KK189VptfjlkDNO0qqkBwUQbbcVrYpWTvxF1YXnYT/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553124; c=relaxed/simple;
	bh=dpA+ZNBffKzsL4q2quIm0RIpAo30Tb2yFgSCok/RCmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNznHRuBjsl73PX3eXhIldTmm91s2tdjn+96SyIlmKXkW7I4iXl45m2lUITXXYf1i3LDam0L2RtsQIZB3IT3+RKezFRBN05AX0Oxauwe/3bkBZ1d6eZk2aPeNthYiZUA4wEYnocG/KyeHJG1Xk7LxiW/kXJDDrSS4WUng4s+FhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBKklI4E; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBKklI4E"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedf318752so875681a12.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553121; x=1787157921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4vX8r01+PCntUA3lkLfO0IIxeRuJPOajs9j+708JlI=;
        b=JBKklI4EFLqX3MLIk6sWI1ki2ajl6IuhgVTxGbz/MXwaA9rV/g5bIUOdmZwFFx4k3o
         IyvrfeUYg3q7ZoLjr69GsQBy+bFtdEewfgbgIfAJXzOVbXx3IQvzYYfFO30onfNXwg4t
         /dIwAEQSn9Or7SS1boe+qy7cXdyFHPm1kP8S0J6K+BGrCH1nxB7QLGhEgXzumfHlRrsd
         CYyc92aLOErQzbhnA59dSbCag7tsM7BSbzNwyfUbDi1+fDGcVOCahn6VRoPELXSCl4T2
         diGWGZ5CO3DJtodRLDjerQ4O68GoTBX6WJyBbBI/CVRRQ+qqPWlFvTR/takBDm7kqvKP
         Pspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553121; x=1787157921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4vX8r01+PCntUA3lkLfO0IIxeRuJPOajs9j+708JlI=;
        b=WRbXGNjCuHQvmL/cfh2ht8tU91oEKmK4F50mgcUsgnpPQKHKFHq/BZnB9mKKVuQMbS
         G2epfUp63etG5RhzurNQdvXF2i3D90+M6JG03MLqSx0mcirmgqWBmq1pIzuQMkQYZSk8
         WWc0N4IWWHEU+TVCwxaLGTWTUv/X3aWM2f84kOSwOVQPl5b1Llpp33qTnTG5S1NmtPWn
         RPEVzSoV9csot3b9GFlaiyKdI1+SePxIhhZKhLkWTFk6bPj1lNz5RS5pkBRlsj3fGMaH
         +ft7zFYpPW862G1g9xdjrCvMD8UqZ7g2vQe+joyrSiGsTEj1CjHs2PFvwN90qwBMrkOP
         QOlA==
X-Forwarded-Encrypted: i=1; AHgh+Rrf9JdDddZqXgEfKpeV1DWA1Vu84EtMMoFLoT7FAIdYyRQJNcLiMKV4A237EqelsITq8xNOWRwbOFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjcnkiUhi8tU5Cqnihbw4u6+MV/JVXS6rINpdhQWIvZ91PL1B
	uBS/4q7xFGXTqFpf4Q7KdJ5tJG0L5/Shp55pkA12vPA0pE46zLPwbddD
X-Gm-Gg: AR+sD12pKB3loaf8o0X87Y8Xmg1e13Qy+lJG6WtHjc+zaiNibv9lOlLK8lPHcdyZ1h5
	S5cUqrQSE1IsQX8HH3oBRt4IUBS/TMfqbOyGeEc/yityrQakx+rtX5swYVWIS70/ovWnIdc8uF2
	qd9StrgLUOBg5B3mt5bCGvSqKLXU6WQla4Zcm7acS+E+MmsBgxG+Ii14MvDscUhBTsshsNqKHWE
	LrTnaFFO7aj0pQ8/8lF36V8RwCuRJRXL5oukx5W8gls8xuIDqLPyq/YmzrHSeC5zM5mfqAjf1FT
	3CdQR0gxE4+fEYhDrylsfD0UD8j/iTjXYErQOqYbZWxaPtu13YZmULC36NBvpxwrfkWnsxKZ5Qt
	2pJyg0vxgypkd8TQa60NtsYEMVt24rBB7O+mxrtPzJZao3XO4ReuI0r3WV7kpTWkTQ1RRR7u243
	e4Ohkmm5TnT1p+JdIheZoljKjaCPdv0Sy8GMdiGjjqTTsl0gPqht+xXKDeKSMxTlDJTrdslH9pv
	v+pnaS1zjcyMuH8BES+d2FUEpDpnzsQ4Bk=
X-Received: by 2002:a05:6a21:9d95:b0:3cb:9bb0:8b63 with SMTP id adf61e73a8af0-3cc3f5eb5damr8021399637.12.1786553121480;
        Wed, 12 Aug 2026 09:45:21 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:45:21 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 7/8] iio: adc: ti-ads1015: replace custom shift macros with FIELD_PREP/GET
Date: Wed, 12 Aug 2026 22:14:32 +0530
Message-Id: <20260812164433.23011-8-architanant5@gmail.com>
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

The driver currently uses custom _SHIFT macros and manual bitwise
operations to read and write to the configuration register.

Modernize the bitwise logic by replacing all manual shifts with the
standard FIELD_PREP() and FIELD_GET() macros from <linux/bitfield.h>.
This improves readability and prevents potential bitwise errors.

Remove the now-unused _SHIFT macros from the top of the file.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 39 ++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index f92ec5941c47..3c78d85321e0 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -11,6 +11,7 @@
  *	* 0x4B - ADDR connected to SCL
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -39,14 +40,7 @@
 #define ADS1015_LO_THRESH_REG	0x02
 #define ADS1015_HI_THRESH_REG	0x03
 
-#define ADS1015_CFG_COMP_QUE_SHIFT	0
-#define ADS1015_CFG_COMP_LAT_SHIFT	2
-#define ADS1015_CFG_COMP_POL_SHIFT	3
-#define ADS1015_CFG_COMP_MODE_SHIFT	4
-#define ADS1015_CFG_DR_SHIFT	5
 #define ADS1015_CFG_MOD_SHIFT	8
-#define ADS1015_CFG_PGA_SHIFT	9
-#define ADS1015_CFG_MUX_SHIFT	12
 
 #define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
 #define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
@@ -408,15 +402,15 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 	dr = data->channel_data[chan].data_rate;
 	mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
 		ADS1015_CFG_DR_MASK;
-	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
-		dr << ADS1015_CFG_DR_SHIFT;
+	cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) | FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
+		FIELD_PREP(ADS1015_CFG_DR_MASK, dr);
 
 	if (ads1015_event_channel_enabled(data)) {
 		mask |= ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK;
-		cfg |= data->thresh_data[chan].comp_queue <<
-				ADS1015_CFG_COMP_QUE_SHIFT |
-			data->comp_mode <<
-				ADS1015_CFG_COMP_MODE_SHIFT;
+		cfg |= FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
+				  data->thresh_data[chan].comp_queue) |
+			FIELD_PREP(ADS1015_CFG_COMP_MODE_MASK,
+				   data->comp_mode);
 	}
 
 	cfg = (old & ~mask) | (cfg & mask);
@@ -427,7 +421,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 		data->conv_invalid = true;
 	}
 	if (data->conv_invalid) {
-		dr_old = (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_SHIFT;
+		dr_old = FIELD_GET(ADS1015_CFG_DR_MASK, old);
 		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data_rate[dr_old]);
 		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data_rate[dr]);
 		conv_time += conv_time / 10; /* 10% internal clock inaccuracy */
@@ -758,8 +752,8 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 
 	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
 				ADS1015_CFG_COMP_QUE_MASK,
-				ADS1015_CFG_COMP_DISABLE <<
-					ADS1015_CFG_COMP_QUE_SHIFT);
+				FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
+					   ADS1015_CFG_COMP_DISABLE));
 	if (ret)
 		return ret;
 
@@ -999,19 +993,20 @@ static int ads1015_probe(struct i2c_client *client)
 		unsigned int cfg_comp_mask = ADS1015_CFG_COMP_QUE_MASK |
 			ADS1015_CFG_COMP_LAT_MASK | ADS1015_CFG_COMP_POL_MASK;
 		unsigned int cfg_comp =
-			ADS1015_CFG_COMP_DISABLE << ADS1015_CFG_COMP_QUE_SHIFT |
-			1 << ADS1015_CFG_COMP_LAT_SHIFT;
+			FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
+				   ADS1015_CFG_COMP_DISABLE) |
+			FIELD_PREP(ADS1015_CFG_COMP_LAT_MASK, 1);
 
 		switch (irq_trig) {
 		case IRQF_TRIGGER_FALLING:
 		case IRQF_TRIGGER_LOW:
-			cfg_comp |= ADS1015_CFG_COMP_POL_LOW <<
-					ADS1015_CFG_COMP_POL_SHIFT;
+			cfg_comp |= FIELD_PREP(ADS1015_CFG_COMP_POL_MASK,
+					       ADS1015_CFG_COMP_POL_LOW);
 			break;
 		case IRQF_TRIGGER_HIGH:
 		case IRQF_TRIGGER_RISING:
-			cfg_comp |= ADS1015_CFG_COMP_POL_HIGH <<
-					ADS1015_CFG_COMP_POL_SHIFT;
+			cfg_comp |= FIELD_PREP(ADS1015_CFG_COMP_POL_MASK,
+					       ADS1015_CFG_COMP_POL_HIGH);
 			break;
 		default:
 			return -EINVAL;
-- 
2.39.5

