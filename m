Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B7481257
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524197; cv=none; b=jFDNVrTJ5AlJW+C3BlxdbnIHVRFB8p/XaXunn+myXd0niWhxidDsdvPveyJGErCMsngeUjojOmRPfEqauUEohZMFlV1R92/gvNrhfcnN6znVOOtpTB7G+P2ccgK97wYigMN+ShDGXwYQ0vUNbz/Kw2Gq86VA2fPto3p6OM72J40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524197; c=relaxed/simple;
	bh=TsNOvbA0ErkQYr4k4Y2OT+QWzLIYwGJJUAjwZfFFrNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4V19BuynOi8Lfd9UU07SrrUbc1jcwoLw4CY2eSiD86fwB1ZgQDcWosW0ifz0OX1u9V9TJ+8VQCpeH53/IM3zWD4xPazr2K3aaWcxXRmTLFGsFFUMQiDuIrWh+9bWxTRIyWXiQoTrFRGxRtP8EU5LFs3AoaZTcea63XTVcFlrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOPOtLVs; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOPOtLVs"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b1ab6d7239so760956eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524194; x=1789128994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9lG93bvWAdHFThZPOqn3PZGlfcTpmPFX52MaXkuUFA=;
        b=kOPOtLVsGszBAgHVkONoSBsfP5keCtDKaBucpqN8KLNzOanm86JxLVfObp+9naQ8If
         sGSqOpAO7Oweg8fBO8KYoCueokXdnjyXna4Ot7lsqdf0VoEnlcBFmAi4lYikAM7KH/4F
         mfHiuP/q/9AQIymnlTgmJyE+ZbxOKP/DhUzW/CSq3gYUA9w9y33qxMra93VsPpTEMTPN
         BaM3zUQFipdtXtPGsVNi5EuqT8aWiJXn/e4Dls1Wfr+Ng3c3hxJYXhtYBNkN/zAumHpC
         /cHjsZ02+okBugfynCxdc9TnHuBUODHoUtbTx0DI84Er5xSpoAdQxOeHZZrEcaLDDazI
         ai9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524194; x=1789128994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9lG93bvWAdHFThZPOqn3PZGlfcTpmPFX52MaXkuUFA=;
        b=YohwvbK4L+ne2qQMPfhdT+npgO08pSSYZHt74QXi0hCU0j5+i36IsWQ9uHC9VtmiZM
         IE5ECQ2Vha++pJpt6Uf7offwq7z+mKtsc9FdfNSNbSxyIgh1270dmYdrrWMO5wVtuxmq
         PmswE9gMXmv8115vnHF2NT2NplZVfntXAtS7SiTCCwkx5m1vrRCA8hw8N4WBkXPESCsR
         vx6OWpblVwX/n5aF5rYtN5FJI+i3+rTDXqGuPfhMyzWSK8Ok+ia00LSpEiK3NjqhV0az
         4Cd5FTn+MIpoWPLdWiogzRzeVAydYzNS2cMshUil7shF4iRyZkUzT52tK+JZDDWcHxp2
         mRYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy48YH2lcGR1KjuWox3KQgRpLvuMMWNNvkAuKosMY5CNG+XODSZWWei4bR5k6ZHWVdLChcKMgKchVM=@vger.kernel.org
X-Gm-Message-State: AFuF++lOIstMIT7Lhh64XOhpWXC2UcfcBb7lX6MmilApIvHw+BXYEqtm
	tmEwMQ0YpVgAeLfYqj3SIRhUJxqdsw8+FKvEHMR3N85K7GZ+MxBaLdK9
X-Gm-Gg: AYBFou0ED43W9EQi5ce2A/mHAMHHAJNxV4izpyX5t+ek68+w4X+nhn4iS8TJojyII6S
	vpyzCEIsWvj0DTyZcC0z2fuDCqxRXC3HbeuNY0NxvwwhIAXordwxDRS0cDnH2v5oM302yk8qntZ
	ieYv2NkIguyYQ/5F0QWg7uU0xo7pjIoDQTe60gvRY2XawF5wuawesmm1FBLzapNhX3wVjLF/hxa
	PMhLPrjNwUe7hGIvnGHRqXnbw8PwceFhi4u17ERH0oLi7hBooAh9nyJjVy2Ca/la+Q0OKy+jro/
	Ffm6Zt4d8S/j8oFqJr0uBL238Cs9jTAzbjfjKBW3YkjVoyvp9MPBjjhMa5CcqsXmsVj1uMXoVcs
	Y+P9Az2yTbrG/WvBI9zjdisb7aRSDRpTs3WgLhQjtMgpp5i4aDDF890XmN7og88QLfn5p1N1GoL
	7r/WWQfANROZbU/T0O7MBBbrCGZcZrk7mzzvjRXzPt2IAFROU/8ULciMikVpHPhcpZanDxpaZFq
	AMx/gWxkAWXa0Di8bDe/0Th5w==
X-Received: by 2002:a05:6820:1997:b0:6b7:46fc:1d1 with SMTP id 006d021491bc7-6b746fc022bmr2190770eaf.48.1788524194569;
        Fri, 04 Sep 2026 05:16:34 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm6557284eec.26.2026.09.04.05.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:16:34 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: fix typos in comments
Date: Fri,  4 Sep 2026 17:46:25 +0530
Message-ID: <20260904121628.25537-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/iio/dac/ad8460.c             | 2 +-
 drivers/iio/dummy/iio_simple_dummy.c | 2 +-
 drivers/iio/light/ltr501.c           | 4 ++--
 drivers/iio/pressure/rohm-bm1390.c   | 2 +-
 drivers/iio/test/iio-test-rescale.c  | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index a2292810e4cf..469294fd1783 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -304,7 +304,7 @@ static ssize_t ad8460_write_powerdown(struct iio_dev *indio_dev, uintptr_t priva
 	 * If powerdown is set, HVDAC is enabled and the HV driver is
 	 * enabled via HV_RESET in case it is in shutdown mode,
 	 * If powerdown is cleared, HVDAC is set to shutdown state
-	 * as well as the HV driver. Quiescent current decreases and ouput is
+	 * as well as the HV driver. Quiescent current decreases and output is
 	 * floating (high impedance).
 	 */
 
diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 19fcdbbc11c6..28ae1e7b593d 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -116,7 +116,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		BIT(IIO_CHAN_INFO_OFFSET) |
 		/*
 		 * in_voltage0_scale
-		 * Multipler for userspace to apply post offset
+		 * Multiplier for userspace to apply post offset
 		 * when converting to standard units (microvolts)
 		 */
 		BIT(IIO_CHAN_INFO_SCALE),
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index fa0d16890c8b..52125fd52f75 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -478,7 +478,7 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 		if (ret < 0)
 			return ret;
 
-		/* period should be atleast equal to sampling period */
+		/* period should be at least equal to sampling period */
 		if (period < samp_period)
 			return -EINVAL;
 
@@ -498,7 +498,7 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 		if (ret < 0)
 			return ret;
 
-		/* period should be atleast equal to rate */
+		/* period should be at least equal to rate */
 		if (period < samp_period)
 			return -EINVAL;
 
diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 57941fb4a535..db6b995afe86 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -267,7 +267,7 @@ static int bm1390_read_data(struct bm1390_data *data,
 	guard(mutex)(&data->mutex);
 	/*
 	 * We use 'continuous mode' even for raw read because according to the
-	 * data-sheet an one-shot mode can't be used with IIR filter.
+	 * data-sheet a one-shot mode can't be used with IIR filter.
 	 */
 	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
 	if (ret)
diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index bcd4a607be19..de4a09f432c0 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -587,7 +587,7 @@ KUNIT_ARRAY_PARAM(iio_rescale_offset, offset_cases, case_to_desc);
  * @str: The string to parse
  * @nano: The number as an integer
  *
- * Returns 0 on success, or a negative error code if the string cound not be
+ * Returns 0 on success, or a negative error code if the string could not be
  * parsed.
  */
 static int iio_str_to_nano(const char *str, s64 *nano)
@@ -617,7 +617,7 @@ static int iio_str_to_nano(const char *str, s64 *nano)
  * @real_str: The real value as a string
  * @exp_str: The expected value as a string
  *
- * Returns a negative error code if the strings cound not be parsed, or the
+ * Returns a negative error code if the strings could not be parsed, or the
  * relative error in parts-per-million.
  */
 static int iio_test_relative_error_ppm(const char *real_str, const char *exp_str)
-- 
2.48.1

