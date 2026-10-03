Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C78496D3B
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057032; cv=none; b=n8N9W6jI9KVDkA84XSWl09r5MQmgGYBCDzf2fy0jbq0boU9ZeNwguLsaipB1hht0daMlTZ2MDRTVKWYs/ZtHVq+lTeBS+lovHIWMoO3FqO7T+rSBu4JVS0Eul+TOJnLfyuZ3Ib35LXO2IGfyNBvcAbTCK1sVidUc9Dlr+7Ps81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057032; c=relaxed/simple;
	bh=wzKMDeKGTtEp9oc6X/r1ye9YtAdC96LVQHmGGkSU3MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm0cfIs7CzPBLOes9zKF2QiomQ4YVQ8BnScV24O1LSNVu6T/huC5H4f8wafqb4EuD6dErM8Nd5akJbvq46KeYKvZNt3NHpkGOfHPMgIP6g2FZo8IMFeoaeUbO8N96J1qLxqyKewDMbOyESvijWAz0inyeSDlkQIhVmPsaCWKCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSeCzgAE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSeCzgAE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so10390621fa.1
        for <linux-iio@vger.kernel.org>; Sat, 03 Oct 2026 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791057027; x=1791661827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IXn6S94b33P25ufvgJkMunPhNjIZY13JTvQoBrLLnq0=;
        b=dSeCzgAEMD22PxVtDuFANbvUu3Hm4W1/gvjpPDEWvvx73lQftznkGkqT2oAETmI+P3
         ZiQ76vKtUDRcQm61syO2NX1U11M9M3yJ6Aa4EC07f8YEPh+wV14CNYkMibNKCd4flfu2
         IMXftSU/bll8/3PQTeSIJ9Lf5DphRKLwpVoTHL2JUyGFhPeRkw4i/rJ+g7WtixVH57f7
         3fLxCj/xGFu6E5UWMOUPWhECqnN5mFwKNDZzmZc1w/th8VVdaKtF0KdNvToDgyz9Rm0W
         CcyUkFKmp9ixvxDzMY7Gj4mDx09Y5s+ECUtjttu5O3qBweeQ6Uu1Nars8nlC8ikn7jlU
         y3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791057027; x=1791661827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IXn6S94b33P25ufvgJkMunPhNjIZY13JTvQoBrLLnq0=;
        b=Vjsj4bBt8IWsx5t9YHHllYhYQQcZCHv/qdEaKPIKBhyPkXlnXScg66hwnm+EL+99a5
         H7b3q3mY7syjNiM1P2VR+TDxfO0hPTh81BQ/gLPDAh2q1/en/M8D+l4R7zl3e7futtfl
         GAPOTJhZHAHwqtRtN6DcuyYZ/NTwvExDWlgse8ukS6JjyH/cW7uBYs4rjtPJI/zlX4R1
         F7GxCzZWnimXnamus6JfWtCN86QtXxjo/Ff8vXafgFsz3nYEdNYBDDEoNMM3sQ2/KyIC
         1E7OHa3WNCAIc4XhDLr2D7g1YIfKK7FBXUr2+/ihvhSnbfnFCnDCa0ry337JXqW84fSy
         d4jw==
X-Gm-Message-State: AFq9FYJUq1KiomMObifD4vGAU/+1ug/THEkECMAIHSm3H8AdXpW6/xVx
	pxsuZPXLhBIacaMlNLxBIUbuohq5uRekPmH3UP/97Piylz/JaoQ/xoPZ
X-Gm-Gg: AYBFou2kw/QwICBtn5C2dmeeMtVo+sa+sIMFjMQ/uGzKfpYIbM+t79y6pCPQD3wSSrc
	fK/cVNflebAdp2+Wcv8DdCPHYQRCAFt9s9Adi36wm4/jLtdPi1dbWza1kZI8RdJ6hq3CyYp9iVY
	FCYlxi+raXJAwfJSIyFq2qbI0Od7D/mNKUR7RcicItZIRr5A1KYgeuKP7NsHoIS4mBWTQ2N04qJ
	L9msiBdXdBB/i/griuGl+FPKxDtRdECXtSGN+tk7PQr/FngVRyp5OkQav7Af+o1B8Bj66x8m5w/
	WjBJY0zhUfIBQkp4Nv8H720UtxcjGSSo213b9GnHfAoLxND0sOiX3kXdJUk89NBM3y0EigN5/HV
	DksJB/STfUJNSx1EzbZ901OuLKRZ11Lw55PKMj/c3u+oubAIADeEggj0tTfHtRVkrNwnZXA4w59
	Se1qx6BMC9IQ9tccSB2XN1rj1FlUK9t4seEE5vVEhPbb5CPWWcY1STYV4GbK91XsV5zt765nemM
	RMY24N+fk4t7Yb3YtsVj+I/72rk8yS+7xAdqkFjv2910vf0b1MaCeukUjddiS/GbAa/Afs=
X-Received: by 2002:a05:651c:15cb:10b0:3a7:812b:ce2 with SMTP id 38308e7fff4ca-3a783457b10mr17076801fa.23.1791057026701;
        Sat, 03 Oct 2026 12:50:26 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7abdbfsm1762608e87.65.2026.10.03.12.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:50:26 -0700 (PDT)
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
Subject: [PATCH v12 5/5] iio: pressure: dps310: assert the lock at runtime too
Date: Sat,  3 Oct 2026 22:50:11 +0300
Message-ID: <20261003195012.92948-6-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003195012.92948-1-zoone.rupert@gmail.com>
References: <20261003195012.92948-1-zoone.rupert@gmail.com>
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
 drivers/iio/pressure/dps310.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index d70a0fa69c25..adfab5e3ac40 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -13,6 +13,7 @@
 #include <linux/devm-helpers.h>
 #include <linux/i2c.h>
 #include <linux/limits.h>
+#include <linux/lockdep.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -359,6 +360,8 @@ static int dps310_set_pres_precision(struct dps310_data *data, int val)
 	int rc;
 	u8 shift_en;
 
+	lockdep_assert_held(&data->lock);
+
 	if (val < 0 || val > 128)
 		return -EINVAL;
 
@@ -378,6 +381,8 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 	int rc;
 	u8 shift_en;
 
+	lockdep_assert_held(&data->lock);
+
 	if (val < 0 || val > 128)
 		return -EINVAL;
 
@@ -396,6 +401,8 @@ static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
 {
 	u8 val;
 
+	lockdep_assert_held(&data->lock);
+
 	if (freq < 0 || freq > 128)
 		return -EINVAL;
 
@@ -410,6 +417,8 @@ static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
 {
 	u8 val;
 
+	lockdep_assert_held(&data->lock);
+
 	if (freq < 0 || freq > 128)
 		return -EINVAL;
 
@@ -509,6 +518,8 @@ static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
 {
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_ready_status(data, ready_bit, timeout);
 	if (rc) {
 		if (rc == -ETIMEDOUT && !data->timeout_recovery_failed) {
@@ -539,6 +550,8 @@ static int dps310_read_pres_raw_locked(struct dps310_data *data)
 	int timeout;
 	u8 val[3];
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_pres_samp_freq(data, &rate);
 	if (rc)
 		return rc;
@@ -565,6 +578,8 @@ static int dps310_read_temp_ready(struct dps310_data *data)
 	int rc;
 	u8 val[3];
 
+	lockdep_assert_held(&data->lock);
+
 	rc = regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val));
 	if (rc < 0)
 		return rc;
@@ -581,6 +596,8 @@ static int dps310_read_temp_raw_locked(struct dps310_data *data)
 	int rate;
 	int timeout;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_temp_samp_freq(data, &rate);
 	if (rc)
 		return rc;
@@ -602,6 +619,8 @@ static void dps310_refresh_temp_locked(struct dps310_data *data)
 	int rc;
 	int t_ready;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
 	if (rc)
 		return;
@@ -707,6 +726,8 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	s64 kp;
 	s64 kt;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_pres_k(data, &kpi);
 	if (rc)
 		return rc;
@@ -832,6 +853,8 @@ static int dps310_calculate_temp(struct dps310_data *data, int *val)
 	s64 t;
 	int kt, rc;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_temp_k(data, &kt);
 	if (rc)
 		return rc;
@@ -940,6 +963,8 @@ static int dps310_fill_channels(struct dps310_data *data,
 	unsigned int i;
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	/* Compensation needs a temperature, so it is sampled either way */
 	rc = dps310_read_temp_raw_locked(data);
 	if (rc)
@@ -970,12 +995,16 @@ static int dps310_fill_channels(struct dps310_data *data,
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
@@ -1014,6 +1043,8 @@ static int dps310_fifo_read_entry(struct dps310_data *data, s32 *value)
 	s32 raw;
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	/* Entries come out of the pressure registers whichever made them */
 	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
 	if (rc < 0)
@@ -1037,6 +1068,8 @@ static int dps310_fifo_push_scan(struct dps310_data *data, s32 temp_raw,
 	unsigned int i;
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	/* Direct-mode claim keeps sysfs reads off these */
 	data->temp_raw = temp_raw;
 	data->pressure_raw = pressure_raw;
@@ -1063,6 +1096,8 @@ static int dps310_fifo_push_scan(struct dps310_data *data, s32 temp_raw,
 static void dps310_fifo_hold(struct dps310_data *data, s32 pressure_raw)
 	__must_hold(&data->lock)
 {
+	lockdep_assert_held(&data->lock);
+
 	if (data->fifo_held < data->fifo_hold_max)
 		data->fifo_hold[data->fifo_held++] = pressure_raw;
 }
@@ -1073,6 +1108,8 @@ static unsigned int dps310_fifo_push_held(struct dps310_data *data)
 {
 	unsigned int pushed = 0;
 
+	lockdep_assert_held(&data->lock);
+
 	for (unsigned int i = 0; i < data->fifo_held; i++) {
 		if (!dps310_fifo_push_scan(data, data->fifo_temp_raw,
 					   data->fifo_hold[i]))
@@ -1105,6 +1142,8 @@ static int dps310_fifo_drain(struct dps310_data *data, unsigned int max_scans)
 	bool is_pressure;
 	int rc;
 
+	lockdep_assert_held(&data->lock);
+
 	for (cnt = 0; cnt < DPS310_FIFO_DEPTH; cnt++) {
 		if (max_scans && scans >= max_scans)
 			break;
@@ -1175,6 +1214,8 @@ static int dps310_fifo_hold_alloc(struct dps310_data *data, int prs_rate,
 				  int tmp_rate)
 	__must_hold(&data->lock)
 {
+	lockdep_assert_held(&data->lock);
+
 	data->fifo_temp_valid = false;
 	data->fifo_held = 0;
 	data->fifo_hold = NULL;
@@ -1222,6 +1263,8 @@ static int dps310_fifo_start(struct dps310_data *data)
 {
 	int rc, prs_rate, tmp_rate;
 
+	lockdep_assert_held(&data->lock);
+
 	rc = dps310_get_pres_samp_freq(data, &prs_rate);
 	if (rc)
 		return rc;
-- 
2.43.0

