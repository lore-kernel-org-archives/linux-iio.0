Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B34ED19E
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734339; cv=none; b=LkiuEurTCTrnUVJpdedKwjdxQC+OK+HNajJJK9ltxFgqoqNYWdKqKRYktl7+wnYv44LN8CtrqVZG1gxjU7xToYVnh3X3L6UnNiBVqCpwVARVkaxNoj8QS/cdTh/DwX5qUh0ooyhsbyctQiSI1xCFRhBO5qQ4EmhLO+xSXNpIjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734339; c=relaxed/simple;
	bh=HDxsKpPajvO1pDBGt+Cg3JRzppun/aKifwXpwM5P7LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTA86XvWrNf7ChD0GdaUTCNUXfQt9QXvknLCeJ8xljSmFlR0c5VeXTpyPQDo4GM5f7OAFybW0iiQhb22wx5J6gWdFWviwyESFpn+JgztQbGqhy8hSYqgDbnZYyanHcgZcp5PowdcthG0lcSi2X/39AaQPnRh95vrKhIjaovh9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFKyhL8y; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFKyhL8y"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d7aso870842e87.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734327; x=1790339127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qM09fZNeu0wGJcMJFEcwruCO/xWOafFLtCE4C1cUZM0=;
        b=kFKyhL8ygNcnRZB0whSwib+wdlJnytcQwJKakGRDN+5ia4oW3YAH3H+Kk4F/PttPsp
         uU95buPLgDe7aLLUVDo4BApfuLClZ/cz+vQpTDds6VktD95OkTzssxaKyxf4X5mQZunH
         gkz0Ks1Z46Q6kKe3B7d1B/fWJ4zkABBfNWn/oJh2gLDXe7NOFenhtYOizWt3gwFcJGmn
         EtC64z5jl/oD88JwrT3xTLc9E7yukAL2kcNnXPdCTf5/OdahLi3cPOJmrs8SD9oZfSrQ
         cRBHtGwTL3/HnsjeDMC5lXv9PlZFz1X9r/4RUQEjRUkQeQ22nhxTcoAJb4tDCL9dfyi+
         Ogqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734327; x=1790339127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qM09fZNeu0wGJcMJFEcwruCO/xWOafFLtCE4C1cUZM0=;
        b=jKWdMYaBICltbxYEIPJuhztXH/SkQr2CoQmdWfQ3gQJBFTCb25l0sUsw1YBOVE4Sb5
         fL2r+coJ34DO3SYfyTr3icXNXu4VNaL3SxYGK2jyPa8JMM/dlDdsHqg32WKUx10VlWzx
         y022qcMxJfBfHrcR/wzY6VeBUB7UUrSrDJA0s/Dd6kG+8LvBv0P6F3JxtsprM+Txgz/R
         79qf4ob5rpAQ3T75h+wNTnNKsa8D/h1qOQNrgQx1l6nyzUX+AS9OZGo1zZiA4wC2SWpf
         2veR0Kp1qdx48nzK5aIQUS5a34JmbMlioc9jtgjzOqieniG61sjV0a6arfiBL426fzwo
         RIJw==
X-Gm-Message-State: AFuF++khBv0h+ycm3KG+8gCJHaydi8XZRiJ5qr+SZzPYET7e0lMgkJz2
	aICtT/rFdV9va8yIsaUivG2ktIY6jmehi1momLJE/SJk5k8xDr+bofMc
X-Gm-Gg: AYBFou3Wi9NKD8NUqpc4+3H42Xu3b15at0IsdIb7m8I39C7qGGZdh+wcAMbbkoNY4lx
	k4e1Jkgv+eDxdBdttdOZHk1Jgd+kq7M16OvFSjA+pQKSviu1J9ibuk7VhwObtMjEN6dDAqjplif
	xgyUIRUrb+AfYZOz6tX/CU8aHl4iKjfx6xEN69uPjnkQKXeICEFTFI1ASTNERz4lRMEKdO0QRoO
	QHFQFzIXwjEXbzmbCrDt+QTPS8OozoogG7Omnfq9OfB4Brk/E7PNdQnVxqMYoKwheGFOxb++Osk
	VWx3gYDXdazZjjFxU5VzfIK6z/Ocg36LcdRAZtpyBL0PNuQlsccSCGpSMBzfDx/nXVWOdF4hg2Z
	VRBpwY0ohIZnEEQ3w3tWuzBazS8GHePWTdzw4UeLu76DPn0f/22LlDpnmbGJbB17a4bqL/Dt+sp
	bZ+I8d21jm4a0GvT3MreplQMMbhIrk2ik6LgkpxfQxCJp2MKAYg8Y2w7fmicDiFcdxwr//PUsWY
	LFRn/UksRygq1emIvhcPp3Y6kuxPCIK7vKe9gbS8nfKbVunJQcAMKWsg6cUccWnCjic8Q==
X-Received: by 2002:a05:6512:158b:b0:5b4:fdc3:d3f1 with SMTP id 2adb3069b0e04-5b8c18057c5mr656114e87.18.1789734327121;
        Fri, 18 Sep 2026 05:25:27 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c270ea53sm398549e87.12.2026.09.18.05.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:25:26 -0700 (PDT)
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
Subject: [PATCH v7 08/10] iio: pressure: dps310: derive the drain interval from the watermark
Date: Fri, 18 Sep 2026 15:25:15 +0300
Message-ID: <20260918122517.377565-9-zoone.rupert@gmail.com>
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
index e63ea7873e5b..024fcdc7f4e7 100644
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
@@ -1189,6 +1205,15 @@ static void dps310_fifo_hold_free(struct dps310_data *data)
 	data->fifo_hold_max = 0;
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
@@ -1212,7 +1237,7 @@ static int dps310_buffer_postenable(struct iio_dev *iio)
 	if (rc)
 		return rc;
 
-	data->drain_interval_ms = dps310_fifo_interval(prs_rate, tmp_rate);
+	data->drain_interval_ms = dps310_fifo_interval(data, prs_rate, tmp_rate);
 
 	rc = dps310_fifo_hold_alloc(data, prs_rate, tmp_rate);
 	if (rc)
@@ -1316,6 +1341,7 @@ static const struct regmap_config dps310_regmap_config = {
 static const struct iio_info dps310_info = {
 	.read_raw = dps310_read_raw,
 	.write_raw = dps310_write_raw,
+	.hwfifo_set_watermark = dps310_hwfifo_set_watermark,
 };
 
 static int dps310_probe(struct i2c_client *client)
@@ -1332,6 +1358,7 @@ static int dps310_probe(struct i2c_client *client)
 	data = iio_priv(iio);
 	data->client = client;
 	data->iio = iio;
+	data->watermark = 1;
 	mutex_init(&data->lock);
 	INIT_DELAYED_WORK(&data->fifo_work, dps310_fifo_work);
 
-- 
2.43.0

