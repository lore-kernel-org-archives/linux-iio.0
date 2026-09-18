Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4824ED1A7
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734335; cv=none; b=Ek39HbSLKIzfQOpKj+9RmCFx2G0dytv8D99kEDx3+vTxZf7I3eDi57Cl4VBn4CcNO6/vzG07i4uVD+SNbtrG1fqKx0QFR23wvKfYBTybmHHdB3PJn4URF1S3pqhI05KlTMOTooNutKw66Q4Tp53DyFk2WMtc6Qudt2dDOCfd+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734335; c=relaxed/simple;
	bh=NquUPFXNGtd4Ni0z6JEwZnVsUBIfxDLoSJ0188QE9MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1G5I7iLlUsDLqqD6rPPXEEcFq6gtygC9J+MsnV4yMoZORjStU0DynYqvxXFRWfsRG1Dykbz4ZmEhdG92SOEU0uG6dZDa0S0GW2IDDt4QRk0F6m8eg9XP55L9BwEbzyrvksc7kUwAwhzicLtB1tbg4/hp7+HscZ/nOKGhEcEIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RivCcwWn; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RivCcwWn"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16cd1so593535e87.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734328; x=1790339128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buSpNdyZjmDa81oD9lpAG13/8iu4Pu88B1wBEU4L/m0=;
        b=RivCcwWnFwFyKL9y3wVD53VY01KNk1UlxJtPhRhVzOigMK76FZzYeiQcSsLSeQhqdU
         uexGNQeeSvXbefsbndTDm7Y64Pwq9HdhtW30S4L2aADuTxXcUdrHD985CnY7t3lW8kd3
         neck8s59KGdr/31GiAM9OfGnZU0kOYiIVo6SPU95uYfk+hS3UVCxJP963i3dsU0cNpiZ
         yrFsxlXCa/2BXwR9mk2anVDV4hXNchnB8rRUC8Tb8+/rcXrhKdtDbGWcSty8QRhBMuZk
         CAa1H9qGypVQD/WuS5X9ZwUB2RhSPCH8vHWBtueWx/w1W3wJe+8dhwz9tuk7W/uRSZNu
         6zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734328; x=1790339128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=buSpNdyZjmDa81oD9lpAG13/8iu4Pu88B1wBEU4L/m0=;
        b=Lm7Kmpo8B9KN3KZcdVlXybyzkcDQ2DX2ney2FS0P2EnHqIQ2cNwvzNHRm97iDBKGtm
         DVe14RwdoGBeNNCiPEtww3pZWXzGUmsK+YJ5s+onVyhyKHSOIFWGpGHLQR8qvlqnP/Bv
         3+gOhp2ok8nmIpOo1C4lneXzNCdEb/N/VnKAG5MaSkJ2XHqNIbGwC1S6x1FnQni7nIpK
         Qwp2ZHI8a7HpLEsV29ubiN5T6i5Y785f0oW/Y1uKJ3k10FNTQRM5moy0K4nD7UEFI0OC
         jbKZciDKdcekg7yrtprF+GLbXBT3Dcln+VLnrBXVWZ7DkaKt8TbSHWAuWmMz/wRDwwy+
         J86g==
X-Gm-Message-State: AFuF++k19eMpXNRmaPSpZsYn3fV8ttTEFsryxssM/dMMV4azAls9jaAV
	6E7d8H5WsY3ngkzYn3xhRUA4qyUIQnHVTgbE78ZI8XYrfkMOrWtQYFJ3
X-Gm-Gg: AYBFou0keH/YNuTxLUX0Ys2iweGmLorRMIgpgKBWUkXNhdZnZwxLOvh40axggLP3YmK
	qUu15HurgBFzjY1b5KZr+7OsoSHNMdkSRgg/3tiyvUryRrSw+FfSKH0KAMhdD1kC8Sh3QqFCcRv
	MVIeS3yfjVBq2j4m/KGM7Fq1zHPR9O/EwSb6LZaB+N5To08yY4RQblUZc+cLJvlAxgBNuNJcLKR
	Y6GYAkuCt3SRzrnvP9r+nDjXibWlbQA92h46oCeJbPBCGbErIOECdgyfTV2Hfbk5zd62nCJA1ND
	OZBkW+eeOiJfFL+QFwLrKnoU9vwhprbvIpX9BdPVVuWCLtRZucKh8LN3epARI5KpVcQrEbn1HIC
	oYdCdn0ZjLfW00G+UHw8RYw7O7REJIffMo7X58AGsL+YCF8woEaYbPmLB2+xAZu/35QWBTCJbHq
	vCLYi58DCw+LsUkiMDGxeWkyoc6u0rr7vzGRqlLEBxB5WSwibmYEMNNuVPMu0rZ0iUGBIokUrNN
	V0pEZK4nWZASInzV9LaQwCTf3ZAf1IuCUV1sIJqmPJ5graGldbvcZnLE12YieZVP0oMNM7VWCWF
	O6f+
X-Received: by 2002:a05:6512:4023:b0:5b6:1a7c:fd96 with SMTP id 2adb3069b0e04-5b8c197532bmr717255e87.60.1789734327937;
        Fri, 18 Sep 2026 05:25:27 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c270ea53sm398549e87.12.2026.09.18.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:25:27 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v7 09/10] iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
Date: Fri, 18 Sep 2026 15:25:16 +0300
Message-ID: <20260918122517.377565-10-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918122517.377565-1-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let userspace drain the FIFO on demand rather than only from the
periodic drain.

With a trigger attached the FIFO is not running, so there is nothing to
flush and the hook returns 0.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 024fcdc7f4e7..f888bff2c996 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1092,18 +1092,22 @@ static int dps310_fifo_push_held(struct dps310_data *data)
 
 /*
  * Read the batch out before compensating it, so a pressure entry pairs with
- * the temperature preceding it rather than the last one in the batch.
+ * the temperature preceding it rather than the last one in the batch. Stop
+ * reading at max_scans rather than after it, since entries leave the hardware
+ * as they are read and any extra would have to be thrown away. max_scans of
+ * zero drains everything.
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
-	unsigned int i, n = 0, pushed = 0;
+	unsigned int i, n = 0, scans = 0, pushed = 0;
+	bool is_pressure;
 	int rc;
 
 	for (i = 0; i < DPS310_FIFO_DEPTH; i++) {
@@ -1114,7 +1118,15 @@ static int dps310_fifo_drain(struct dps310_data *data)
 		if (rc == DPS310_FIFO_EMPTY)
 			break;
 
+		is_pressure = rc == DPS310_FIFO_PRESSURE;
 		kind[n++] = rc;
+
+		/* Only the measurement that drives the scans counts */
+		if (is_pressure == pressure_enabled)
+			scans++;
+
+		if (max_scans && scans >= max_scans)
+			break;
 	}
 
 	for (i = 0; i < n; i++) {
@@ -1164,7 +1176,7 @@ static void dps310_fifo_work(struct work_struct *work)
 	int rc;
 
 	mutex_lock(&data->lock);
-	rc = dps310_fifo_drain(data);
+	rc = dps310_fifo_drain(data, 0);
 	mutex_unlock(&data->lock);
 
 	if (rc < 0)
@@ -1205,6 +1217,19 @@ static void dps310_fifo_hold_free(struct dps310_data *data)
 	data->fifo_hold_max = 0;
 }
 
+static int dps310_hwfifo_flush(struct iio_dev *iio, unsigned int count)
+{
+	struct dps310_data *data = iio_priv(iio);
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
@@ -1342,6 +1367,7 @@ static const struct iio_info dps310_info = {
 	.read_raw = dps310_read_raw,
 	.write_raw = dps310_write_raw,
 	.hwfifo_set_watermark = dps310_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = dps310_hwfifo_flush,
 };
 
 static int dps310_probe(struct i2c_client *client)
-- 
2.43.0

