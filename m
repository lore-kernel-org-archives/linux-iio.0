Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006F4D98E6
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629914; cv=none; b=DoLslXCX1MWq8UXMHFJ+vypTaUAIEca86cNkYl+CjicxzMB9eGc2SLbuvM8TnaoO2yGWRci5F7Jh7eZPXIBAo9Vb3arDqyZVcgvxT12J5zZuZEPqyK3mvaDRdMZQHx1nnSacG7RKk/eH/TVR3fC3Me+jo8ZCpeHPckCvr7sfpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629914; c=relaxed/simple;
	bh=iOi0SALGXUSx2PqVV7wx8zKmv/6Gwivbe/N39Rn+vEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrpyKrU1ymwLl6/ZmCNLFIHDC90OcZPs9LkAMhAYHEXhbIORJJAsPbtdXvVRsBgCg5AHsdbaUpOK3d7QaEvIiwcYqBiRWWEKR+uXCphyaAtD61qKAj3FOvwj6gD81N6FruXkpLDQmfMja5JB5ni8aIhiwF+0WaFuDM88xKg3R9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sX/ey2h4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX/ey2h4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso209866e87.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629911; x=1791234711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkRx2iV/b5B3Na2z7TIs8JNm+okbfXp0Qv/fhcKZ2vk=;
        b=sX/ey2h46c79uPtIdsnBRy7d2okg88MAtzE5KkmY3HyWEPSMGewvN1zcHcgyM/85Yt
         v388yhkKBglz5dK9/gnNkAgMZfo5lNzFMuwKzk3ODIT24G4inacfci128qqlUT1isMW9
         sHgtQ6KxAJ7dWU370OGYsOoAUjVxtsROSIdjPe3mBJqxZBAH6Cg7I+g3+dWImK1BFSzo
         mH0VN1H5prV4c6EhfqtKhKke7U863ccqfkZJ4A6k24AffLvsYWp224LpdRoUtTG7SSCi
         u/AWPjSmIPhaKdflNVR10ykq/LS+b+ivzAQFcAhKjESD3E6olfcWHCILQnM1W6fK4EMU
         1PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629911; x=1791234711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkRx2iV/b5B3Na2z7TIs8JNm+okbfXp0Qv/fhcKZ2vk=;
        b=a/wtrwbhFANHSkeeNH8U7vOpszsX4fnmLL9ZoqJ3AnVfy0jM7UZYET5u7acfxanwsP
         wT17aCQ2WlUERulxREkdla6lUEWEMH/NnjXknLJJ7zncJwfp1MZko1W9UqUXSwUsQ045
         gweZYmDwOjIgY3sUWchgxk4/p6SozhykgOSOM66GVAeR+i2f9xHenGcDJOSfsjzpoXJh
         eApvkoglTy7QxPPk0rG25rASDFGP88dMwen2cBgxHEcSF+tTZ/x0YOo+0cKgQ5EJxc2l
         KhiBnZFA+XCcNcA85+aXTD/nxo7ry5X6BKQkv6EjGxf/lPs6KbbGMDPOYHC81iw8Ki9r
         29wg==
X-Gm-Message-State: AFq9FYLtTmyMUy8DN/H1hYq+PZplGBEvSeczNtRTRePcT33ISHmzpaMK
	7AuyIiep3jXfvuhwa9MG3bV3LbFRzysX88HnZn7XDhvCYOCja2bS3MId
X-Gm-Gg: AYBFou0zZWp8yrVmJ9w+cAwhnQWTdK5n0fCD+fD9uzfpLVAMi11KTTTHjKDo3QMDF0k
	JybTnirtnsUw3aLHR8dn+B713o727k0QNK8g2YppRNenaqpsr9CNHS/Ywep/Ybr7JYnBnfqsiRE
	Dp3/aJHTOg0noFI/Avy+/CFxw/D5aly2ylSBTAh16hTypdeIY0NegE4+JVuIcTW44T8YcFeJVI2
	qX9mLmup85cFtnSbGisxQYBJOFh7+xJFhyDTkoxLpQT39d15vfhGW9uc50WDOlpWd0/jebHX0ER
	Bl9S+swfhqv/PqvLiiiWIyInLMoKUyU3v0vyU1bMP5dEvROOO6t++Ag8WDSRC1z5qb5ou8PA8Qf
	jzg2O9cSPQQnNnBp7uzKXQZrCHOUJwG1Aln+7OonijkvivZ+xuh8hk5NZINo9JxuWXHY+9xIQqu
	csQVWE5MyUlb9SBywZzMrgB7PV4ubPXWzkfRPzPsDL+viKhgSV+kvpYqQOosCfbrl3Z2o7wUGi4
	ES7thjSWUQT+EGOzU7u3r9v9CK7Scka45xbGMcLXsyRTnSMpR2GL4h8R8EPZsgZZBg/0Q==
X-Received: by 2002:a05:6512:230f:b0:5b8:eb9c:abff with SMTP id 2adb3069b0e04-5ba2e6a8ae1mr134827e87.41.1790629910938;
        Mon, 28 Sep 2026 14:11:50 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b9d826fa06sm842860e87.8.2026.09.28.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:11:50 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v9 3/3] iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
Date: Tue, 29 Sep 2026 00:11:27 +0300
Message-ID: <20260928211127.641828-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928211127.641828-1-zoone.rupert@gmail.com>
References: <20260928211127.641828-1-zoone.rupert@gmail.com>
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
index 66f24adc8df7..2af2971de970 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1088,22 +1088,30 @@ static unsigned int dps310_fifo_push_held(struct dps310_data *data)
 
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
@@ -1111,7 +1119,12 @@ static int dps310_fifo_drain(struct dps310_data *data)
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
@@ -1151,7 +1164,7 @@ static void dps310_fifo_work(struct work_struct *work)
 	int rc;
 
 	mutex_lock(&data->lock);
-	rc = dps310_fifo_drain(data);
+	rc = dps310_fifo_drain(data, 0);
 	mutex_unlock(&data->lock);
 
 	if (rc < 0)
@@ -1186,6 +1199,22 @@ static int dps310_fifo_hold_alloc(struct dps310_data *data, int prs_rate,
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
@@ -1327,6 +1356,7 @@ static const struct iio_info dps310_info = {
 	.read_raw = dps310_read_raw,
 	.write_raw = dps310_write_raw,
 	.hwfifo_set_watermark = dps310_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = dps310_hwfifo_flush,
 };
 
 static int dps310_probe(struct i2c_client *client)
-- 
2.43.0

