Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF933A9FE
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111965; cv=none; b=EStGAja/t2Wlt4LuFiJrwenzEmmEorWm+X4jUj62N1YKfjeyGvrVAcB2xmw704zxLLf+DBh3QMJC+WZANhgutUf1i37tpMsvWeoAnOcYIsm6I2He2V4NPfKvH74R9W0hWU61z7CfsHqjTBQj48/riRzrppH6rJVpr9kPM6xbYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111965; c=relaxed/simple;
	bh=mR6YDrtsNaRCApMFx3+4ev6RinDuN92aAnva8x1L73U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1wSXFhvKxMQ5oBEEYaWu/7aUTiIZYO5E5BoV50CnE1eKzHvXbLJswRoe0rSRFPA+M8cKCXCkAOEMAWOPuoysbpuPm/8Lg98eZhwV2PWjfAhv9DItBVVTcEVhKAXmrezzAAPJBm/NsChyvKxYQoHwQjFKSZmO+FRU9AVCVp08O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=hdm7HdnQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="hdm7HdnQ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3811e59df58so551402a91.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1783111961; x=1783716761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSI4XWKv0pUmnj+beMYCn/ElRECteG3wg51iRAfobiE=;
        b=hdm7HdnQI2sdWyD5qz0Xgo9r9oIQu7MhJf4p9UspuJvuCczuf8wntpC3Rfsedqvcje
         i/6ygWLzbisNzHeeTm/7OEnEl48Ewb0V4Sr1tlzcIgPRNTIYPrOiW6umF4pIuUgvxt7t
         WTUxy9NBX1f8mQWCegmH6p0cV5kQv1tNy8yr1PYGW44zNzBYWp3XxEy7yJ72xwZ6MeAi
         pqsBJyA/enGYvxBnzaaq4GpbOi0hs1t5GbAjTwmt3kYFixUsNHTGCeagruxUV/stBZCF
         KWXxAIdHsbA/CXqh6LXN98z64NY96jxXhyPxcka1DumOQX+R53I3VkMIdNjuBN9XqWdy
         KN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783111961; x=1783716761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSI4XWKv0pUmnj+beMYCn/ElRECteG3wg51iRAfobiE=;
        b=dUJixJuUEVifPpnrRiFolFjK58k/H6Va9SC2tuX4gvDL1tFz06XOTnRrGLns3BMQIs
         92FnNd5BiWP1IgfTtYkQKSv+JayJx6B5m0tZDScyc/fkslq8t6x/XEqUdYU0/HvEtbrT
         Mt56s+GqiUVUrPLMn/O+oHcV4Z2jYU1eBFLWyKz01ukEDkD2k33plNUHtXmNACH8USwg
         Pjcq7gszughK9dVUqQVetx/qF9CVWHlsrTtICIbMnrnFOAeWl4AMsDOLMisEnMQa69wW
         6FtTWEOhUXk3aR6SsnclqVJR3wDZycFpzsnQ/R6o8i7qGgOhuMgKZ3UlbewVmqorUH2D
         u+2A==
X-Forwarded-Encrypted: i=1; AHgh+RrEY0g1G6th2gmBagAMzItXbwlrjVFkLxFvlXkB8ChPtv5ESnSS31vuu4My7wLnJB6y91eov5WYLdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJ4ByTqvfqDMFTWD+xO3+T/ztrc+eAFWVb8p82T3vjepmfsgj
	a2tO1KUeglXrluUXIF0y3eUDRTf+NxF05b+gdOBDAQ6sC83vR25Ml71gMBDUFgrh3g3T1HghNjS
	+fzms4wUBAQ==
X-Gm-Gg: AfdE7clSBFBEEleCsEb30tkL6llooKA4j3sN99MLYhipGYriMj/VMER9HZcyRq5GCuC
	KyW2uklBqSa3hEUbBGpzSKm7cA8bFfhMO8I563QX6gCK10R0oGMCZo4h3xhDcJYY2mxa04faMkC
	5NgmL9v2CHT4WH8dKJHCgOnvieQj0TZLZs8AWMhBwOVATJrAjDP3zpK0JWkZyEDCJalKR/lb4hw
	DX7Mq3ydu9htZvOhWZSaQLBKFfxuOdlnrGetJzLINPPeFFzFOqU1QKsGGbpC/ZDGpnaxg5BRlDX
	T/5KJm5+zCGV2aDeQ6ShaX9ZRaz4ikt1NfhCz3cos+9gAzkAPOh17h/LN+ctza4XyY3o4ok1Xg1
	RSM1abBxt+bBTbcP9/96c47vQT+wa+sWhzLasGJppfRLpROJ6JIoUkOyuYRO2FtiNEp2/ch1w86
	sqZscRgZt5Bba1YTJbyHqOsGXeLQ==
X-Received: by 2002:a17:90b:2ec3:b0:372:b4a1:21d8 with SMTP id 98e67ed59e1d1-38280c96dfamr909042a91.13.1783111960975;
        Fri, 03 Jul 2026 13:52:40 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:60b4:fa78:36e8:4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30f0b813c4dsm22484803eec.7.2026.07.03.13.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:52:40 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	joshua.crofts1@gmail.com,
	sashiko-bot@kernel.org,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: dac: m62332: Fix regulator reference count imbalance
Date: Fri,  3 Jul 2026 17:52:36 -0300
Message-ID: <20260703205236.201834-1-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m62332_set_value() enables the Vcc regulator on every write of a
non-zero value and disables it on every write of zero, without tracking
the channel's current state. Because the regulator is reference counted,
changing a channel directly from one non-zero value to another enables
it more than once, while a later write of zero disables it only once.
The reference count never returns to zero and the regulator is left
enabled indefinitely.

Only enable the regulator on the transition from zero to non-zero, and
only disable it on the transition from non-zero to zero, using the
previously stored channel value to detect the edge. Balance the
regulator on the I2C error path so the reference count stays consistent
if the write fails.

Fixes: b87b0c0f81e8 ("iio: add m62332 DAC driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260418130322.106769-1-erick.henrique.rodrigues%40usp.br
Cc: stable@vger.kernel.org
Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
v2:
- Use local enabling/disabling booleans for the edge conditions (Jonathan)
- Credit Sashiko directly in Reported-by with a Closes: link to its
  report entry, per Jonathan
v1: https://lore.kernel.org/r/20260630021309.36636-1-erick.henrique.rodrigues@usp.br

 drivers/iio/dac/m62332.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 3497513854d7..2c13feee8d61 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -32,6 +32,7 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 {
 	struct m62332_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
+	bool enabling, disabling;
 	u8 outbuf[2];
 	int res;
 
@@ -43,7 +44,10 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 
 	mutex_lock(&data->mutex);
 
-	if (val) {
+	enabling = val && !data->raw[channel];
+	disabling = !val && data->raw[channel];
+
+	if (enabling) {
 		res = regulator_enable(data->vcc);
 		if (res)
 			goto out;
@@ -52,14 +56,17 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
 	if (res >= 0 && res != ARRAY_SIZE(outbuf))
 		res = -EIO;
-	if (res < 0)
+	if (res < 0) {
+		if (enabling)
+			regulator_disable(data->vcc);
 		goto out;
+	}
 
-	data->raw[channel] = val;
-
-	if (!val)
+	if (disabling)
 		regulator_disable(data->vcc);
 
+	data->raw[channel] = val;
+
 	mutex_unlock(&data->mutex);
 
 	return 0;
-- 
2.51.0

