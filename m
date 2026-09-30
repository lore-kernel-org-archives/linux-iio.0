Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD23C378A
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762533; cv=none; b=cOAyzMiRivujrkPlCBC974cy1tG8XRO52SQIs4h/MKGQ7ENQhRleArbcSnufqxbVYAgmTjyEIc9ZAfM5c+YqXg+kPS0R3ERJetMo4NpBhNJ2Iivv5SvaP2t42WxjN+Z6qUeOtzSuUTYqmq7MKmpGlXNZ+y4jX3hmdhh1xp1QwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762533; c=relaxed/simple;
	bh=1rFZsg+Z5sWsSqhdGi/mlZV+y/+IRKzY2Itze28hDCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxCnWPrif+m0lGK9cb1Ggq0p+jXlbHGhc1TfyvlWAykxCNMWMJE0eaKldNTYEYpcgveT4yMiTT3N2nQ8blGPk5kzJp+jiVAdgtpuEctAPJmF+/q4oBoRac0b5jSYhoqulESK85Vj+LXi1EmnqBeGh+mkiRL1EkmdGLg4pKKbIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndzOvIeV; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndzOvIeV"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba330a7e46so1373293e87.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762528; x=1791367328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQXVYE5SQMyZN1p+2/OR0/p0MeYTZXXNgWFF5Z/oQKc=;
        b=ndzOvIeVft5DDCmnTQ/PcDueKUj2EDYpOZXUqXmXvo++QLNBmmLrxj0p6FjLkq7jt/
         NZj1TdRypObANNd+LJLjSQoMT5dbxake7qW5WZyAH9hfJzjztOepK5L4eZ0622NZaV5X
         wwneKWRxd7DSj0Er0n5kBkZPd1pXh8vJYUf7PbvRwj5dvHVD4fx2/EtqYqMXZC+Z0hc8
         1/kCMxeAD4tELrtCBJKh2ps6OSJHlbpp7mizxStc4HhLAArCtoP4PFIMI9RPCzZs4cp3
         Y4yYlB9aEpuFPLGwWO7FFu98tY8Ct6nNMoEL1iGYQuRonh9xifdVnqmc5eHyskh0U5yS
         5vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762528; x=1791367328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zQXVYE5SQMyZN1p+2/OR0/p0MeYTZXXNgWFF5Z/oQKc=;
        b=rCcoAkt/c7LTrfhYKont+IqpRY3HB9YcwewbIg0dHKN7oGCjNVqrSnAQ0wc/OnJTAc
         4xbSM7UwUoTQsIT5RVwZYB9F2HB635b9LVl+/BYd5w5NX9TafdqM8ZCo1htteyezu9gC
         IcxfxSgIJTUClMBSH4QqIqouXp7VYJq6TU8KoyygnHjvBDkP2JoGmKZesAirQlXu8BZo
         bjqJPRQO76lF32ngNAOLrjoDif3Thf5Cqyl6HnMcwZ0buzaLG5hwhC/VZ/pdlWsbfkZr
         LnPe6wdai57MMNYlZXP9wZ5OJEEf1iXongVNSCliMI75GKg9GdI4hHoeU44FKVfilN76
         vTiw==
X-Gm-Message-State: AFq9FYIMy0aMwPD+ezkiKH+omjDfqSzqE+X4cyEhyV+LQWWm3Bj271ap
	/2jqH7urTvkhbLmJ65gNLQi9jRnUAgbYdpcmPPg6qFEIetiVIb5IF+H5
X-Gm-Gg: AYBFou0Xcd4aUwIvxW1TmeNz7MGOHbKTxo0hUQtQtH0MBTCR2uz0zTd4Ch1iJSvS49F
	CBLLo0K7EGiv9hOvtOzrkwFGGrUFYA9pf5xmN5cYAFxljqS2wzfmes8ZHdBbciX9ojR8anZOhAi
	JJWq1rGmBGS8avHSzcW6OmCLuQ44Z3Z6B8U45Y9GQAyX+mLKkg3l6oDnjYwB8IkCRfKXQuuamaq
	v5BCGy8pD8lJfX1B6oKLJq27N5mXkPuVyLDrDaKIDZUP0drSGb6Uik0GIjQEyjLHzNkazypsQkv
	qOoxGWFZ/qTWNOtsyjXVD3yzYfOj/3A2hOXHBwDLFMeO3kKmJI9e7HqDQJj+Ovqgdz/x27njcKR
	Eyip2CFrLO6lYjyqLVz6CujjRnUt5ZybIKVXNzSf3KwU3O3n3sixKxs96p/UZtXHv6OoT0CZFjJ
	Pr4ij1WfGztIkLsVDFcFBt0e2vx9Vnsf++9MXrz5mLGuWn48P2Mk6NgAprCPiH0AKQGEo4RSHdI
	a7LgmrF6bns2353ctPsTpi5hSh40Huh7AwPu+S5LBeM0oxTg2DSmephUIpi3SZlDOdkoQ==
X-Received: by 2002:a05:6512:292:b0:5b6:1a7c:fd83 with SMTP id 2adb3069b0e04-5ba40602483mr257747e87.41.1790762528177;
        Wed, 30 Sep 2026 03:02:08 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba3fbe6c06sm240422e87.22.2026.09.30.03.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:02:07 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v10 4/4] iio: pressure: dps310: assert the lock at runtime too
Date: Wed, 30 Sep 2026 13:01:58 +0300
Message-ID: <20260930100158.957977-5-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930100158.957977-1-zoone.rupert@gmail.com>
References: <20260930100158.957977-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__must_hold() is clang only and does nothing in GCC builds. Add
lockdep_assert_held() next to each, so lockdep catches a missing lock
too.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 01fca139433a..791ff22b0304 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -12,6 +12,7 @@
 #include <linux/cleanup.h>
 #include <linux/i2c.h>
 #include <linux/limits.h>
+#include <linux/lockdep.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -358,6 +359,8 @@ static int dps310_set_pres_precision(struct dps310_data *data, int val)
 	int rc;
 	u8 shift_en;
 
+	lockdep_assert_held(&data->lock);
+
 	if (val < 0 || val > 128)
 		return -EINVAL;
 
@@ -377,6 +380,8 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 	int rc;
 	u8 shift_en;
 
+	lockdep_assert_held(&data->lock);
+
 	if (val < 0 || val > 128)
 		return -EINVAL;
 
@@ -395,6 +400,8 @@ static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
 {
 	u8 val;
 
+	lockdep_assert_held(&data->lock);
+
 	if (freq < 0 || freq > 128)
 		return -EINVAL;
 
@@ -409,6 +416,8 @@ static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
 {
 	u8 val;
 
+	lockdep_assert_held(&data->lock);
+
 	if (freq < 0 || freq > 128)
 		return -EINVAL;
 
@@ -508,6 +517,8 @@ static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
 {
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_ready_status(data, ready_bit, timeout);
 	if (rc) {
 		if (rc == -ETIMEDOUT && !data->timeout_recovery_failed) {
@@ -538,6 +549,8 @@ static int dps310_read_pres_raw_locked(struct dps310_data *data)
 	int timeout;
 	u8 val[3];
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_pres_samp_freq(data, &rate);
 	if (rc)
 		return rc;
@@ -564,6 +577,8 @@ static int dps310_read_temp_ready(struct dps310_data *data)
 	int rc;
 	u8 val[3];
 
+	lockdep_assert_held(&data->lock);
+
 	rc = regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val));
 	if (rc < 0)
 		return rc;
@@ -580,6 +595,8 @@ static int dps310_read_temp_raw_locked(struct dps310_data *data)
 	int rate;
 	int timeout;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_temp_samp_freq(data, &rate);
 	if (rc)
 		return rc;
@@ -601,6 +618,8 @@ static void dps310_refresh_temp_locked(struct dps310_data *data)
 	int rc;
 	int t_ready;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
 	if (rc)
 		return;
@@ -706,6 +725,8 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	s64 kp;
 	s64 kt;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_pres_k(data, &kpi);
 	if (rc)
 		return rc;
@@ -831,6 +852,8 @@ static int dps310_calculate_temp(struct dps310_data *data, int *val)
 	s64 t;
 	int kt, rc;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_temp_k(data, &kt);
 	if (rc)
 		return rc;
@@ -939,6 +962,8 @@ static int dps310_fill_channels(struct dps310_data *data,
 	unsigned int i;
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	/* Compensation needs a temperature, so it is sampled either way */
 	rc = dps310_read_temp_raw_locked(data);
 	if (rc)
@@ -969,12 +994,16 @@ static int dps310_fill_channels(struct dps310_data *data,
 static int dps310_fifo_hw_flush(struct dps310_data *data)
 	__must_hold(&data->lock)
 {
+	lockdep_assert_held(&data->lock);
+
 	return regmap_write(data->regmap, DPS310_RESET, DPS310_FIFO_FLUSH);
 }
 
 static int dps310_fifo_set_enable(struct dps310_data *data, bool enable)
 	__must_hold(&data->lock)
 {
+	lockdep_assert_held(&data->lock);
+
 	return regmap_assign_bits(data->regmap, DPS310_CFG_REG, DPS310_FIFO_EN,
 				  enable);
 }
@@ -1015,6 +1044,8 @@ static int dps310_fifo_read_entry(struct dps310_data *data, s32 *value)
 	s32 raw;
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	/* Entries come out of the pressure registers whichever made them */
 	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
 	if (rc < 0)
@@ -1039,6 +1070,8 @@ static int dps310_fifo_push_scan(struct dps310_data *data, s32 temp_raw,
 	unsigned int i;
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	/* Direct-mode claim keeps sysfs reads off these */
 	data->temp_raw = temp_raw;
 	data->pressure_raw = pressure_raw;
@@ -1065,6 +1098,8 @@ static int dps310_fifo_push_scan(struct dps310_data *data, s32 temp_raw,
 static void dps310_fifo_hold(struct dps310_data *data, s32 pressure_raw)
 	__must_hold(&data->lock)
 {
+	lockdep_assert_held(&data->lock);
+
 	if (data->fifo_held < data->fifo_hold_max)
 		data->fifo_hold[data->fifo_held++] = pressure_raw;
 }
@@ -1076,6 +1111,8 @@ static unsigned int dps310_fifo_push_held(struct dps310_data *data)
 	unsigned int pushed = 0;
 	unsigned int i;
 
+	lockdep_assert_held(&data->lock);
+
 	for (i = 0; i < data->fifo_held; i++) {
 		if (!dps310_fifo_push_scan(data, data->fifo_temp_raw,
 					   data->fifo_hold[i]))
@@ -1109,6 +1146,8 @@ static int dps310_fifo_drain(struct dps310_data *data, unsigned int max_scans)
 	bool is_pressure;
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	for (cnt = 0; cnt < DPS310_FIFO_DEPTH; cnt++) {
 		if (max_scans && scans >= max_scans)
 			break;
@@ -1180,6 +1219,8 @@ static int dps310_fifo_hold_alloc(struct dps310_data *data, int prs_rate,
 				  int tmp_rate)
 	__must_hold(&data->lock)
 {
+	lockdep_assert_held(&data->lock);
+
 	data->fifo_temp_valid = false;
 	data->fifo_held = 0;
 	data->fifo_hold = NULL;
-- 
2.43.0

