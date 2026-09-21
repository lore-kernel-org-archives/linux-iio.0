Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE279501296
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015515; cv=none; b=b9aETFeV3vGyL9jXiGh3CCISkDPxOctCIvKw2mpg7rHlK3xL2jUO0ttNI6bePClf++9MGCuS/85p1zRQg5OxUy0UiokQunOxue1rITmbBiHreM5fpnKWJPXPWqhvxcfx6yZEQO+1z+5m5lmVcLUXkFWGx2F6tXyLpnNZ9/mDbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015515; c=relaxed/simple;
	bh=W+X4H/UMTXCi1rpjpKYwefBmr26TJf9yG3HSNcI2DDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnqM/YFr8hVXDIe1bFqRORaKC8CeDOC5aZ4t81/KeOHxH+gkILmtHwT2kCzgChd+zy0jSKYbDTHqzHHLMq6bMxk/ZRHjSrIYRnBwgx0LDHRoCXfVW1jjtVq/ObDIIAU6+SVQsazM3aAhz8+sH21QU74uhtqfDnZbhXLoo2qLAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMGljpat; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMGljpat"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f17450so2892279e87.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015511; x=1790620311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IDFrmjcxCDMyDqDCFYCMrvNRJ2RlyneJJcA1pkODkaI=;
        b=qMGljpatAKfZCTPBX+4bG+AvK82e+UcD/INZgA8C18Jc72KzisWtOXfLrdAgYJzX+C
         BMbDlZzSnfG9gy7a0eAsacIycdp/whBzrmtcnIyuLp2Gjyt4b8usrkihbnzizOWF/ZQm
         2FOqSrf82chFimrpsdtSqQMVtzw8YVHYJGmzshyXDScoZtIydiWpsUA2AivpLVt0Yb1l
         tnNkbhrJYs2hccbJeyrbK7ZyHNwo4z9gHokLVlM6kxtTwDG/nqK33trE3EH4eJqpyXbz
         BUeVEdsKm5F27P5k5ajM3ORAN6ava+D5mW9dFotShUcYqkL6cseIHuNE3nRH725bNC0l
         g53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015511; x=1790620311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IDFrmjcxCDMyDqDCFYCMrvNRJ2RlyneJJcA1pkODkaI=;
        b=Pdug5hb6ueFGikT2J9zF5xEFTvcp/Yo4amuSkKOO6tqhL7f+8z0d5f7QfbQZi0wNaz
         7gbWctXhQC2lQ4sZcT7HmNSYiMvlzaVGy8lbr6nrhlYF5VIgkUByRm2BLCiN0fB0Wz3p
         QBhAQZiuTVjn+8R2kTfwTth5p8QjWsIEK2DxPJN6fqqIpQU/fdiMaBSvjjik8qi6zJjc
         yKZDLuvd7vCjNUZC4APnxQErmAYc2V++HAdpt19vI51pVf5ocAlsLzZbZEIP6EIhq/K6
         dGC/km4en5rLZ8SnPLf31ICcZUXBB+kzY9qII+KyMYbwbeNlbBsDxtRGNyILsXqRZEGO
         V4pQ==
X-Gm-Message-State: AFuF++kO6zyq2YqgimnBTrCFKbKS4dl1MKpz9Ow3qOB/LqVE5VW+hUuy
	+COWVhDk8RY8aYHoKe2wbNjXIeUc6PbJxyvtGHXZq2Fr9g/CL2cdnUQ2
X-Gm-Gg: AYBFou28y9sxG5rOmCJodkxwBm68TjWJMO+4+ZsXq+OGXcQIB/HiDm1FEnE3rs/Jx3f
	oaK4SdhI5tFmPIByy0KldoSElmW/v00F8Gx63R/gLjtRaWSCFFfWpIwkLh9zYmd4fW8N9jcrKI5
	C4HkuIgaOZEcXbvZFOWixnXw+NZQnMQu8oaBTbO8w3FxfMR10IB+Q0M87m2gzoikHOYH+VYyUYc
	4Dcpc0b62Eo3bxO8HsqzsbOMz7L30m3O20r5Oh2390to/F3sNAsIFr28TBdVDugcfQLXRTP8kX0
	AIQDkNWO2lCVZLskqE6YVCLe4c+qi4NRkACSeGR9b1lfXt5QaWDKAepK3hp1fRIqD0sr0YwJUlY
	xptXR/oAr7RTHpPZV0ovt5VC/TNQaY/MfhAC7u0g6EsG0SPufKR6Pwcu4fPs/EzTDHQ81PGhF7g
	z3bueHOq20cBCJw1+Na3h/GlR4LAnnShBYQXX3g3PUV45btRaTFZl8PRw+RN4GeGe7gonoPatuP
	ADd2qHRkVme3enV+eoAT6dws+ytwUfyM4cEf4ev4bCOvvQD/eoMNuoM42yoJeigrui7aw==
X-Received: by 2002:ac2:4c4c:0:b0:5b6:183c:5c88 with SMTP id 2adb3069b0e04-5b8c1846df6mr3737251e87.38.1790015511240;
        Mon, 21 Sep 2026 11:31:51 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:50 -0700 (PDT)
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
Subject: [PATCH v8 09/10] iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
Date: Mon, 21 Sep 2026 21:31:31 +0300
Message-ID: <20260921183132.233136-10-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921183132.233136-1-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
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

Hold the mode across the drain, so a concurrent buffer disable cannot
free active_scan_mask while it runs.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 36 ++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 974630eca547..59203df1ae35 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1093,22 +1093,30 @@ static int dps310_fifo_push_held(struct dps310_data *data)
 
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
+	unsigned int scans = 0;
 	unsigned int pushed = 0;
 	unsigned int cnt, i;
+	bool is_pressure;
 	int rc;
 
 	for (cnt = 0; cnt < DPS310_FIFO_DEPTH; cnt++) {
+		if (max_scans && scans >= max_scans)
+			break;
+
 		rc = dps310_fifo_read_entry(data, &raw[cnt]);
 		if (rc < 0)
 			return rc;
@@ -1116,7 +1124,12 @@ static int dps310_fifo_drain(struct dps310_data *data)
 		if (rc == DPS310_FIFO_EMPTY)
 			break;
 
+		is_pressure = rc == DPS310_FIFO_PRESSURE;
 		kind[cnt] = rc;
+
+		/* Only the measurement that drives the scans counts */
+		if (is_pressure == pressure_enabled)
+			scans++;
 	}
 
 	for (i = 0; i < cnt; i++) {
@@ -1166,7 +1179,7 @@ static void dps310_fifo_work(struct work_struct *work)
 	int rc;
 
 	mutex_lock(&data->lock);
-	rc = dps310_fifo_drain(data);
+	rc = dps310_fifo_drain(data, 0);
 	mutex_unlock(&data->lock);
 
 	if (rc < 0)
@@ -1201,6 +1214,22 @@ static int dps310_fifo_hold_alloc(struct dps310_data *data, int prs_rate,
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
@@ -1338,6 +1367,7 @@ static const struct iio_info dps310_info = {
 	.read_raw = dps310_read_raw,
 	.write_raw = dps310_write_raw,
 	.hwfifo_set_watermark = dps310_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = dps310_hwfifo_flush,
 };
 
 static int dps310_probe(struct i2c_client *client)
-- 
2.43.0

