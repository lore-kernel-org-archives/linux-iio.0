Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6A446BEA
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758710; cv=none; b=HdnAafd6BARtrn31ezrAmFHkNTUH8Cv6HLYOsk2ogrLINdosF3yU3K5XkuBCzRZivYj/NgCyOuyHNzLnvHpu0P9RAM9kYrEZXjdNpabeVFmcjrcr3qUgIv/J/xwln8Pxim1/2E+9OYjmLMNYNLA5eXpq17N+AfyEDC9MGiiQG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758710; c=relaxed/simple;
	bh=b/z0q4/78sft7ci2/Yt1TSP9crXmve3hk7VMB/CxXxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKS4vUd3dcogKKVmSHinReJvHwcBZJmfEiQDsbS8xBnt7DXuwop7t5gIKTkXffR/gabSnwjsNgr0FPrgH76m5Ry6tlgnIwePzjKt4QJcCdba7Rp4meYrkI0YNrGdpF1XC4caHOzKhfnwaRVbt6DSST0msx/svgDEAxE9dO6lGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYOlOoR3; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYOlOoR3"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c1b8d7b5so4510731e87.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790758706; x=1791363506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AHFL6RmgBhtI7Ch3hS1eUkcuhMzk4tvhyeKZz8DJl0c=;
        b=NYOlOoR3PdtoFYssS9EKdzk1g0ALiM2ljZBzvS8Yh41tpW4BwQHft0CJsk7QV0kMdw
         c0F21lU7F19eQlTbIOytv15MnROkKZu9ST3WHUpGgNFevw/rHjIH4J5QgrizrbO0Waf3
         oRq8kT/XK0tKts+A1Wkd0U9kzmUt20e/UaKcLD6MABBjrsb0oRhIZoFwjxSkyYPokPJq
         lfaxgHNYijWGHHrEhzw4LoPDZAlT9tAkFC7BpQpRgOFH8/ipxSwen9DeruqEQikonWjR
         MlULNCVLVsVxczi3OiEpf9k5cgNpENov/Op9myT4CT/b72sPxXAzs5sVcItRlH/xKSYY
         h8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790758706; x=1791363506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHFL6RmgBhtI7Ch3hS1eUkcuhMzk4tvhyeKZz8DJl0c=;
        b=XJvvmGGfFrg8hEWIRl2cKS0sXrww4E/kcrOnR1UTj0jl8PkIGZPaqrzhdvihZ3DyUD
         9bmBGtlMZOutzQgHnigS/3QGFVmSsb+6xW3fprXB2LgitoyY2ZVtiVacXAsdcPj+L/6z
         +pPqD8xs5YwvXaw97miEBlNeTKfSB8mOv1FSXJkKTVB6dVeHcvT6QBfk0hd39lHPe9Mi
         tt7YSun2e4ykOcdb11rfauzXMP3dU7wByv21eSn/KCaEFDaRJUuVb5ZYZ2YL22G0UVzg
         zYlpEPSFFNQH4Bm8ubxXWxFM561pdYwMQ2oOfKCvh69T8W9S8aWxwAaaSdA2mDRMNo2b
         2Cxw==
X-Gm-Message-State: AFq9FYL+7wGembAw9SRNxAUEexdQyIWlqcYcg2SgmNofvuH6W+AlaZUK
	3XkwJlEITds8I1vzWOAF656YyWhiQnSkDnj61IqxeKyPt/yz+mUY+eCq
X-Gm-Gg: AYBFou2Ns68iUkb7qE8pPHlIPn1C8BDLIfAzFG+UHFkcaMWYGUO57fAStLOsM09PWen
	3o9ZFUQG4OLpLjt7tdInIZFswkP6h4YYw1JqmRZWJZcJvESYlayZnmaSRb4faavemfZQMeH8n//
	St1UvRM9SqWh1jsoF6N6I7THbMXUxdw9x/eyRlMuy3+d4u5RXyBuAFB0RUygM+lx3TwozZVX4Rv
	ET/TbJvjoiVGbgK4s4LXqpnBaMb0fODLZdJPnjrEXjxv//4Uv9jIszM3W8uFkdN6JloD3ZuY5Ty
	APPCT39UQy86zh7FueDNVownCkALDRm0bycRy5Yeet9bfyT2pvwtmtaB593qiUr+LLNR3QMJ0W6
	r2Vsp5s9oi++qF3Jclke641dV5BuSCnHAZm0AtE1apGu8ETc+hrIH68JfZPM87XPZaj3X15vc+H
	5ENG3X8V/FWsvlOZ72A5ey0+0r+V1j1C+1WtAkPF6YqxjW21Ng1Qz60201df0HK9cGwrWzl16qS
	UdHpmyzN4oR2K0UedFDH7X70uEkzPjHFRcndH+LCTmQC2cBbF/Cg2nVMVFlJcGE6uSk/A==
X-Received: by 2002:a05:6512:1309:b0:5ba:3b49:1f44 with SMTP id 2adb3069b0e04-5ba402b3e93mr329182e87.4.1790758706300;
        Wed, 30 Sep 2026 01:58:26 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba3fbbc051sm211389e87.1.2026.09.30.01.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:58:25 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: pressure: dps310: fix overflow in pressure compensation
Date: Wed, 30 Sep 2026 11:58:19 +0300
Message-ID: <20260930085819.886339-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p^3 * c30 and t * p^2 * c21 overflow s64 at most oversampling ratios,
and pressure comes out about 150 Pa low on a DPS310 here.

Use Horner form, dividing by scale factor at each step. Overflow then
needs a raw value far outside sensor range and returns -ERANGE.

Checked against datasheet formula at all eight ratios.

Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
v2: (s64)BIT(20) instead of BIT_ULL(), min() instead of min_t() (Andy)
v1: https://lore.kernel.org/linux-iio/20260928101803.547005-1-zoone.rupert@gmail.com/

Based on iio/testing, since the buffer series reworked this function.
Can send a version for fixes-togreg if you prefer.

 drivers/iio/pressure/dps310.c | 94 +++++++++++++++--------------------
 1 file changed, 39 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 85df58ac1809..f59fbd586ffd 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -19,6 +19,7 @@
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/regmap.h>
 #include <linux/unaligned.h>
 
@@ -660,75 +661,58 @@ static int dps310_write_raw(struct iio_dev *iio,
 	}
 }
 
+/* Fixed point one for the compensation fractions */
+#define DPS310_CALC_ONE		((s64)BIT(20))
+
+/* *acc = (*acc + coef) * raw / k, with coef scaled to match *acc */
+static bool dps310_horner_step(s64 *acc, s32 coef, s64 raw, s64 k)
+{
+	s64 prod;
+
+	if (check_mul_overflow(*acc + coef * DPS310_CALC_ONE, raw, &prod))
+		return false;
+
+	*acc = div64_s64(prod, k);
+
+	return true;
+}
+
 static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	__must_hold(&data->lock)
 {
-	int i;
+	s64 p = data->pressure_raw;
+	s64 t = data->temp_raw;
+	s64 prs = 0;
+	s64 tmp = 0;
+	s64 pressure;
+	int kp, kt;
 	int rc;
-	int kpi;
-	int kti;
-	s64 rem = 0ULL;
-	s64 pressure = 0ULL;
-	s64 p;
-	s64 t;
-	s64 denoms[7];
-	s64 nums[7];
-	s64 rems[7];
-	s64 kp;
-	s64 kt;
 
-	rc = dps310_get_pres_k(data, &kpi);
+	rc = dps310_get_pres_k(data, &kp);
 	if (rc)
 		return rc;
 
-	rc = dps310_get_temp_k(data, &kti);
+	rc = dps310_get_temp_k(data, &kt);
 	if (rc)
 		return rc;
 
-	kp = (s64)kpi;
-	kt = (s64)kti;
-
-	p = (s64)data->pressure_raw;
-	t = (s64)data->temp_raw;
-
-	/* Section 4.9.1 of the DPS310 spec; algebra'd to avoid underflow */
-	nums[0] = (s64)data->c00;
-	denoms[0] = 1LL;
-	nums[1] = p * (s64)data->c10;
-	denoms[1] = kp;
-	nums[2] = p * p * (s64)data->c20;
-	denoms[2] = kp * kp;
-	nums[3] = p * p * p * (s64)data->c30;
-	denoms[3] = kp * kp * kp;
-	nums[4] = t * (s64)data->c01;
-	denoms[4] = kt;
-	nums[5] = t * p * (s64)data->c11;
-	denoms[5] = kp * kt;
-	nums[6] = t * p * p * (s64)data->c21;
-	denoms[6] = kp * kp * kt;
-
-	/* Kernel lacks a div64_s64_rem function; denoms are all positive */
-	for (i = 0; i < 7; ++i) {
-		u64 irem;
-
-		if (nums[i] < 0LL) {
-			pressure -= div64_u64_rem(-nums[i], denoms[i], &irem);
-			rems[i] = -irem;
-		} else {
-			pressure += div64_u64_rem(nums[i], denoms[i], &irem);
-			rems[i] = (s64)irem;
-		}
-	}
-
-	/* Increase precision and calculate the remainder sum */
-	for (i = 0; i < 7; ++i)
-		rem += div64_s64((s64)rems[i] * 1000000000LL, denoms[i]);
+	/*
+	 * Section 4.9.1 of the DPS310 spec in Horner form. Multiplying the raw
+	 * powers out first overflows s64 at every oversampling ratio but 16.
+	 */
+	if (!dps310_horner_step(&prs, data->c30, p, kp) ||
+	    !dps310_horner_step(&prs, data->c20, p, kp) ||
+	    !dps310_horner_step(&prs, data->c10, p, kp) ||
+	    !dps310_horner_step(&tmp, data->c21, p, kp) ||
+	    !dps310_horner_step(&tmp, data->c11, p, kp) ||
+	    !dps310_horner_step(&tmp, data->c01, t, kt))
+		return -ERANGE;
 
-	pressure += div_s64(rem, 1000000000LL);
-	if (pressure < 0LL)
+	pressure = data->c00 + div64_s64(prs + tmp, DPS310_CALC_ONE);
+	if (pressure < 0)
 		return -ERANGE;
 
-	*val = (int)min_t(s64, pressure, INT_MAX);
+	*val = min(pressure, INT_MAX);
 
 	return 0;
 }

base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.43.0

