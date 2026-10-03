Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6264766B7
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057030; cv=none; b=E7DYEsgtfksOQCokiSkU4sJ9tv9y1jXBrRFqRZ1nD8l4FOPjXpVPjUbwTrPMiLKwf8MRCRkeIHSbl8iJisDPMNZiXGT+cDXCpigWGtW78BvsDVVJhrHLae2t3YqPDzzbY4RTeK5ZeXBMFd4Ziiukc2eQOSuYpys79XMiSf3BmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057030; c=relaxed/simple;
	bh=yKZ3RAuB9c8QvP51Mnfq7TMJVSdVuwbAyl129LQ9ebY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+6cMS1szjOZ/G4UIm67SbJ5d21DgcyMynCk9oAyyu237MDCdwrN6O9Z2fKJcn53gHjsOFfBLAdmngNNgo5ciaJW//+KeO1lmRuOGhFgO8OpgzCw5/IUWy+imKSMTQa81E889axQ+9VhVV0VETSxvnOZQRucOiGguArHsL7nQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lyqb8zE9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyqb8zE9"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba7ed32ccdso565051e87.0
        for <linux-iio@vger.kernel.org>; Sat, 03 Oct 2026 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791057025; x=1791661825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5x87dEIj4ZkmRs3wXiwE88rd8/NOqK6OzoSInLWsrs=;
        b=Lyqb8zE9sgqhqV0kyP3ceGmPlg91WdRWhkk5T3fGgHAO7ucWpiCxgqIrOYXYHzRfzU
         2Sc8KOQgutl/iBTfeASgQXavElWsAUycjxltcrtN+GWoEQlIZOD0t2oNHHbEDjMctiEN
         5r/wjCZw+uTmQWa3KRzA8CkfNuaIXxgwVri+aszSq3G3UHfHThlHqzYm+c7rEvcS4xBy
         G0tKmUewWXh82Hj5RECJRwT2ffvZOA7DavhhJv716WYH9/3hZU8cZJu7+UY085UEKfJs
         T2l5Nh9ETWw2Yuamx04p7hJgWf9GuHzxP6O5UnuyGUAzrBtoFFv9ssngwsnZIWXKwnrn
         fvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791057025; x=1791661825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5x87dEIj4ZkmRs3wXiwE88rd8/NOqK6OzoSInLWsrs=;
        b=oEgrTt9nsmSnkAe8s93m7o8ww1xq7aI+I1U/UB7eGGnFbYXtWxc7W4BuP8Yn6tqs/z
         M6P/1TBdkSZx0BWk+iU40H0pWgxF+0ezFgigh7k6/6/lDp7XULVaJNL+HmGTQGz4uK7Q
         60PxxR7M1pVJ29ssWwRntVXd3Kn773xWzMpAD1qSpaxE94a/Ii8/fHGbtAyCjELtD626
         iRjooV+wvU8mNcEexodr0WYxJPoVQbx01h901qqW+EbAcobK1h2ursS+RunAVcEXAt5y
         JJ/HZtGvj0t1hqfUCpjcVGgNw7ROVc1AbWStOGiuqgpvLmyY72GkNwlRLsSy3xJpGjc6
         nUBQ==
X-Gm-Message-State: AFq9FYLQH6qkk4qJORjAUDAWsogx3ljC4TMF9W6M1iia9fui1g7LJ14H
	AHaROKKhwTqNy2rccRGkiKYQHZsbcHHgdBwpbo6wP8jaCMvGyOuHirF1
X-Gm-Gg: AYBFou076uHu1de+wYA+x24SQzsI5R6SAHHc47sQq3uDASRmtxPiFlW0I46RnViBGFr
	1J5ElaCJ2dsk8RkpZsATH//Ey4Z+3fyYU/N6L3pSV/AUo7mOBDyKEcedZzHql3o72V7yptUKM/n
	jNyTxKuxdZkVsGYM6E4Hv5GzQvuo6NDf3qw0py4Y5NG90Y7ktBuZN7FspYjfLRyduTnzJiWEJba
	k/pc2h4sraqiP/JbjZte/HY/yC2T5DCsdNXL8QZ4g3q1HaS8GzuUvFYrnutoNAGMd4iebKfQlm+
	tfpJgZ+mTQSfJaw9wbsgDWJfD0kXjvEShV6mNwFSwU4TioUa10cg2y/XETHXbsxgpyK6W+GYzrL
	78Jwju/lpvGeO9Zpy2/ZL4uIEGQej32Vgn6ef6wYNm05r1VZBgfo9StPVHF2cRkvMzTNIkjpknw
	ueOtCte+42FbK0pvvu8AiEJvHnIst1JoDx/a6oMYOCM+Ixf3up/cgKMFmV8skxDSbknIMGLMvT6
	aWOlsB2BjQ6960xN9IcM2f+UFxejnMHhPVKfHYyamfPQ7O/b31BXw8ovwanvidPn0ZNFA==
X-Received: by 2002:a05:6512:110c:b0:5b8:f7fc:959e with SMTP id 2adb3069b0e04-5bcb546ac23mr1367126e87.34.1791057025052;
        Sat, 03 Oct 2026 12:50:25 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7abdbfsm1762608e87.65.2026.10.03.12.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:50:23 -0700 (PDT)
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
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v12 4/5] iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
Date: Sat,  3 Oct 2026 22:50:10 +0300
Message-ID: <20261003195012.92948-5-zoone.rupert@gmail.com>
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

Let userspace drain the FIFO on demand rather than only from the
periodic drain.

Hold the mode across the drain, so a concurrent buffer disable cannot
free active_scan_mask while it runs.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 528dc9283738..d70a0fa69c25 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1086,22 +1086,29 @@ static unsigned int dps310_fifo_push_held(struct dps310_data *data)
 
 /*
  * Read the batch out before compensating it, so a pressure entry pairs with
- * the temperature preceding it rather than the last one in the batch.
+ * the temperature preceding it rather than the last one in the batch. Stop
+ * at max_scans, as reading an entry removes it from the FIFO. Zero means no
+ * limit.
  *
  * Returns scans pushed.
  */
-static int dps310_fifo_drain(struct dps310_data *data)
+static int dps310_fifo_drain(struct dps310_data *data, unsigned int max_scans)
 	__must_hold(&data->lock)
 {
 	bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
 					 data->iio->active_scan_mask);
 	u8 kind[DPS310_FIFO_DEPTH];
 	s32 raw[DPS310_FIFO_DEPTH];
+	unsigned int scans = 0;
 	unsigned int pushed = 0;
 	unsigned int cnt;
+	bool is_pressure;
 	int rc;
 
 	for (cnt = 0; cnt < DPS310_FIFO_DEPTH; cnt++) {
+		if (max_scans && scans >= max_scans)
+			break;
+
 		rc = dps310_fifo_read_entry(data, &raw[cnt]);
 		if (rc < 0)
 			return rc;
@@ -1109,7 +1116,12 @@ static int dps310_fifo_drain(struct dps310_data *data)
 		if (rc == DPS310_FIFO_EMPTY)
 			break;
 
+		is_pressure = rc == DPS310_FIFO_PRESSURE;
 		kind[cnt] = rc;
+
+		/* Only the measurement that drives the scans counts */
+		if (is_pressure == pressure_enabled)
+			scans++;
 	}
 
 	for (unsigned int i = 0; i < cnt; i++) {
@@ -1146,7 +1158,7 @@ static void dps310_fifo_work(struct work_struct *work)
 	int rc;
 
 	scoped_guard(mutex, &data->lock)
-		rc = dps310_fifo_drain(data);
+		rc = dps310_fifo_drain(data, 0);
 
 	if (rc < 0)
 		dev_dbg(&data->client->dev, "FIFO drain failed: %d\n", rc);
@@ -1180,6 +1192,22 @@ static int dps310_fifo_hold_alloc(struct dps310_data *data, int prs_rate,
 	return 0;
 }
 
+static int dps310_hwfifo_flush(struct iio_dev *iio, unsigned int count)
+{
+	struct dps310_data *data = iio_priv(iio);
+
+	/* Holding the mode keeps active_scan_mask alive across the drain */
+	IIO_DEV_GUARD_CURRENT_MODE(iio);
+
+	/* A trigger drives the capture instead and leaves the FIFO empty */
+	if (iio_device_get_current_mode(iio) != INDIO_BUFFER_SOFTWARE)
+		return 0;
+
+	guard(mutex)(&data->lock);
+
+	return dps310_fifo_drain(data, count);
+}
+
 static int dps310_hwfifo_set_watermark(struct iio_dev *iio, unsigned int val)
 {
 	struct dps310_data *data = iio_priv(iio);
@@ -1315,6 +1343,7 @@ static const struct iio_info dps310_info = {
 	.read_raw = dps310_read_raw,
 	.write_raw = dps310_write_raw,
 	.hwfifo_set_watermark = dps310_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = dps310_hwfifo_flush,
 };
 
 static int dps310_probe(struct i2c_client *client)
-- 
2.43.0

