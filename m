Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81A4FECF2
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015515; cv=none; b=dI/TgI0/SXN0+4aKdEZQr1uUN/J/oCulxYspwKBhMCddOZmkN5Q4Xgx0xVYbXm+iQtFUChcvZ1V7yUDn0zwOhJ9H3Ot42iPiird+3TJFCTQYErCcSfIU8ru56rt52nPSvsE/NE1Na2LVHTVOu6uD5+499uPWLhyRkAwgzUTOlmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015515; c=relaxed/simple;
	bh=Qoaag+4Fgu9VnQvynmJiNTI8wvqcoEdvg1NwWtRt71M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6gx3vkQNEypuuny9AFtVpO9cR1iLZnc4+duq3dscgqPig+GMmlT/MDggHJNLaKwXjyfEJJuxbQf0cNHKccL24IDit6CuI5CW55rqOW/h0DtB9Fc1Gf1E65IZNsqyvRTjREMji3aMUkwq8kftKydDIY9M4IDxBx4+w/T136JIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIgS3LjB; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIgS3LjB"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a60e33d456so16652491fa.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015509; x=1790620309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlZd81x0oPWfA+2ykgQgxz5QAMmEdSYsOngYyrqJ/V4=;
        b=cIgS3LjBwI7Pu9HnPrLtBO3KuQ8DHSfFyVd/u/jR20R65sVflYhK2t4qe9XX96RaWE
         U4ud15hhwDEJEFltHF+8EiL5Y56+7swvbANPwFmK/y+pr/7FM8Prqaux+QdsFmyKKOhw
         LoUAKBA33jbdKoVCrRaySAsptT0HnH/86LVr0DaDFZDBIqQHiSlsBgCuCjoh8AqSrV8C
         jJPXa2qnst9M1Z5JKSzPpunkh+7Eb9n7zfUIOxfob9JYus4PSLXJQrxsHj+Ne14IDpez
         kLtZ9W+NE1TnKG2IDa2B8xoj2Afs3meShE9Bz2Cbfz7gLo5MvgVV3X4FuL3bYDKaCJtk
         NymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015509; x=1790620309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlZd81x0oPWfA+2ykgQgxz5QAMmEdSYsOngYyrqJ/V4=;
        b=kHVW23Wj0f6W7ZWRr/m3Cdlh1M8EdF8q/TynLfWICY/ZF0M0DodysJ/EghRjMAAMNN
         GIQZMfOXlJ2C8fW7xrWdpUP6OJWKT7L3dNpcmIhtBmfk+TfUgiREiCWRgGs2F3Y2d4TV
         W6OQt9/XlivbXUIOTHNNZfCL44o86rXLfcf1jVUJPtBnfHn6SPXgrSP4LScDAEKDrzKa
         XnvAcNBK9NsRk0bIsqyg3DSsqeLDlOnGr/G1TcUZToBx80XJQlkUHBQpVP60/Ao2Ccbi
         MOM4GpYx4LBTn5KGpDTL6UcjuxnNSbzDD/YZkp779EfFYi6FMKICYX0b1zgYcbo6fEN1
         KXGw==
X-Gm-Message-State: AFuF++n+3FlsuRMqeR92hMBcDBESzGaRDLai/s4+ABpXw3Bm1kRbwhD9
	6wkAtEQpFjRZIY6/Y3FpnssctmuR9wYDyvKiT9KCWUCelzLaYnEm6eqN
X-Gm-Gg: AYBFou3nwy7O7ivYKa9uQxZykXEeeb3XNU0+bggUHJBZVAfBuc4bRVX56Xuqlgimqhy
	Fpw2dLw6Q7mnDW9xoHgcHfDn8vh10a+vQWqMGCgssxi3LlAVpRga+zlyJhu1+w7H9C3m/xn0IsH
	E+HXBKZBQEBtfWutNKC+dMuI34OUxx7x8ksbFgnCAKwXmgdbX2P1ZfH5afWLKPKQesippvdkheN
	585YhNjeVBI91gIQcdaxvz+K6dQ4eCdM1rdPT7E/qw7PG34YrfqPjzsnAeru17Z6RNmFsiv1yOG
	O7vfMU4MtrihP+SRHUV8LR4jkQe2MOphJkIhxZveIKUyT4/gcOYMN9zfkDMAaRYvNZF+6eJUlvW
	HqI4mzv6FJeHSoDQur778jbnSG5Wq29Y/k/K6RTrhZRXFRsNQZ4RmQUGlmLx6p23Ez0chxio3mT
	1pwENeGWBXV04d60Rax7njQhHNm2T2w4EbM1RjRwGP3tyTQhJ1GbXw87ZjFjk27DZ0gP0JLLv5v
	VNDyDYp+iXn3IEzoN3HR9WDRdin06oDYkg3ftM0u5R4I8VZ7ntbdsvx5VHYoNv+Emwp3A==
X-Received: by 2002:a05:651c:1443:b0:3a1:35f3:d2f2 with SMTP id 38308e7fff4ca-3a5fbe7bef0mr28160951fa.12.1790015509393;
        Mon, 21 Sep 2026 11:31:49 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:47 -0700 (PDT)
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
Subject: [PATCH v8 08/10] iio: pressure: dps310: derive the drain interval from the watermark
Date: Mon, 21 Sep 2026 21:31:30 +0300
Message-ID: <20260921183132.233136-9-zoone.rupert@gmail.com>
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

The drain interval only tracked how fast the FIFO fills, so a small
watermark still waited half a FIFO for its samples. Take the watermark
as the number of scans to wait for, but never drain slower than half a
fill.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index ba59413d8e11..974630eca547 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -114,6 +114,7 @@ struct dps310_data {
 	s32 *fifo_hold;
 	unsigned int fifo_hold_max;
 	unsigned int fifo_held;
+	unsigned int watermark;
 	unsigned int drain_interval_ms;
 	s32 fifo_temp_raw;
 };
@@ -981,13 +982,28 @@ static int dps310_fifo_set_enable(struct dps310_data *data, bool enable)
  * No interrupt pin is wired in tree, so drain on a timer. Both measurements
  * share the entries, so they fill it together.
  */
-static unsigned int dps310_fifo_interval(int prs_rate, int tmp_rate)
+static unsigned int dps310_fifo_interval(struct dps310_data *data, int prs_rate,
+					 int tmp_rate)
 {
-	unsigned int fill_ms;
+	unsigned int fill_ms, want_ms;
+	int scan_rate;
 
 	fill_ms = MSEC_PER_SEC * DPS310_FIFO_DEPTH / (prs_rate + tmp_rate);
 
-	return clamp(fill_ms / 2, DPS310_DRAIN_MIN_MS, DPS310_DRAIN_MAX_MS);
+	/*
+	 * There is no hardware watermark, so take it as the number of scans
+	 * the user will wait for and drain at that rate. Scans come from
+	 * whichever measurement drives them.
+	 */
+	if (test_bit(DPS310_SCAN_PRESSURE, data->iio->active_scan_mask))
+		scan_rate = prs_rate;
+	else
+		scan_rate = tmp_rate;
+
+	want_ms = data->watermark * MSEC_PER_SEC / scan_rate;
+
+	return clamp(min(want_ms, fill_ms / 2), DPS310_DRAIN_MIN_MS,
+		     DPS310_DRAIN_MAX_MS);
 }
 
 /* Returns which measurement the entry came from, or a negative error */
@@ -1185,6 +1201,15 @@ static int dps310_fifo_hold_alloc(struct dps310_data *data, int prs_rate,
 	return 0;
 }
 
+static int dps310_hwfifo_set_watermark(struct iio_dev *iio, unsigned int val)
+{
+	struct dps310_data *data = iio_priv(iio);
+
+	data->watermark = clamp(val, 1, DPS310_FIFO_DEPTH);
+
+	return 0;
+}
+
 static int dps310_buffer_postenable(struct iio_dev *iio)
 {
 	struct dps310_data *data = iio_priv(iio);
@@ -1208,7 +1233,7 @@ static int dps310_buffer_postenable(struct iio_dev *iio)
 	if (rc)
 		return rc;
 
-	data->drain_interval_ms = dps310_fifo_interval(prs_rate, tmp_rate);
+	data->drain_interval_ms = dps310_fifo_interval(data, prs_rate, tmp_rate);
 
 	rc = dps310_fifo_hold_alloc(data, prs_rate, tmp_rate);
 	if (rc)
@@ -1312,6 +1337,7 @@ static const struct regmap_config dps310_regmap_config = {
 static const struct iio_info dps310_info = {
 	.read_raw = dps310_read_raw,
 	.write_raw = dps310_write_raw,
+	.hwfifo_set_watermark = dps310_hwfifo_set_watermark,
 };
 
 static int dps310_probe(struct i2c_client *client)
@@ -1328,6 +1354,7 @@ static int dps310_probe(struct i2c_client *client)
 	data = iio_priv(iio);
 	data->client = client;
 	data->iio = iio;
+	data->watermark = 1;
 	mutex_init(&data->lock);
 	INIT_DELAYED_WORK(&data->fifo_work, dps310_fifo_work);
 
-- 
2.43.0

