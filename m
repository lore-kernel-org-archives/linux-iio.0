Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114883A1695
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234518; cv=none; b=lGQ87obtG3OcB6im0j35aUXZgHOG3W0qSxD/RxIt2rQ4ykeAQAITtPZActg4lqfo2S724ePC+sXwYhI7vxwqkcb8HB3+fFFwIibRkx4jptShi9lfQ0hYrk0uFLkXV8kH1VrIfK37CBtPcH3oKdhwNL1S6xcGodrQdtYX9ym30K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234518; c=relaxed/simple;
	bh=QSiv7WSpFd2YKxc//BeochhaYMtiyPIjzqQwxwybp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGFz4Dgf6hSARpZYNRaqX0pRAB3Rz61BWaDfGUPUFzDzsDA/UZ6AoOopZb5lYFwXxbeIWyVmarI+ibMk49m1hQI2nnJGZXjifZk8tZcgMdf7RX9hU4R3OY8emahP1+yztozEYXfVtnGUIBDH/UvD+RSnpPzXNwBmXJ7HGThlijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kseqh+rt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kseqh+rt"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-911af978bf2so501530685a.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234516; x=1779839316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0NDejsVUf9MUY06XbPz1Snkq7R09XiljUeZXWH8Ubo=;
        b=kseqh+rtwnL9RZ0cG478Hyut6+BRTclDmn7wdOa8Jw/1umJ73pUssr1TKlPUwAwuFG
         +0souUazjfr5mOvFiRX2t8IA1Qh7TQxmb6fqNtDXfh3OfXwdNzYigEPUqETxpUTr3Tly
         EA2WQI1TLMpw9TsDXxmvMMwVI81hGzXmoQ1u1ROEeaKi8QXsBiu+rK1mADiUU8q/PvUZ
         Tv8uj52z1jKF4qTfgRoodhEjVDzaFMFeCtMY2RHbS8h8iMpjg/BFuBj80OsdzkRTolsV
         0qFALr64I3i1IqcecOej8Gy9y1q2CpEPT5YUM6QkesId2Rlbqtf+B+ek48+L3j11U6UX
         GwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234516; x=1779839316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0NDejsVUf9MUY06XbPz1Snkq7R09XiljUeZXWH8Ubo=;
        b=JfTWuqAU7i0fP6RDH0WiX8B2KuS1+xpZBYYIr/de6Sasxn90F/A1Mhxdt68LaKA5Yv
         k4cWwVvOhrbCEKomNzArPRs3ZXBGvMcllCIUnBBOkdFJlnLHHnNQJ6eM+5oduXBdO09Z
         0F0KroZ9QTz0rdskPaaYl63QaUbY3rk0gVFmG+1YjMiH3MnS9RNik38ioCK88GtfNjTP
         ejTR2XLIyf4lDCVthSS3+FPtYQx1AkIaDD9qD3muTW5fZm+pF8r7V/P/jmQ7ncp+ntRA
         KSznueSPQc6cKibDmjuPMNeuMYi+2hCi6wZ6dqe8mSusxejlaz4hXdc+dAE3ABgdTNWu
         /0bw==
X-Forwarded-Encrypted: i=1; AFNElJ/oTB/N1cJT64LT6RH2LkYf2IxnNGiq7I8SKvsRm08Fm+iozBG+Nj1KbeW4rmjcAm3Kc/r6RQ8jclw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6z1Y0URgmV1HM0sD+ShuBDYOy9B+U6t4YLvByCgOY2L1gFEft
	NzFprmKxE4/yMXidqZ+LuuIA0cGZqNsUSJOs3WwtCtxnlPlaoA/nVZuZX6xAYX1scnU=
X-Gm-Gg: Acq92OEb6fNO+/SV2jUZNse/bUFTdld5a4kmBigKVZT04msJmTFOLw+jGvqpnZSPyiN
	8z85s2wX6uwdzyq0E/Hy/fh57jZYgZ+ivo/TCjZvcndB+0kyU+p7xGvhiNSt2x0vRUFyIk2RsZ4
	ZF1OmS9WYbpwdDclW7izgfBU3DaGiOUw9MdbbLgLn/D+9cK4+GnvmOvEJDQVs+jXZozSA2O4QvM
	iDyRT2kvPa8lY231Hd+yvUlqkSyu6FLZ1rUQUxXeJ9/aFMLv65FKuR4mkAJGd3Y0VvpYzP5SShx
	DrMIpD57dkS1crzLDMZXeRyJLJXHik6zPh9ntnIjwiuUIYuHSe+3yIP0CbMmqnZbuyhleCQFc0U
	Riznch+pkrGWWN0CJgFJgFZzbM2lNeHBO+eQYGUSHOYkwxs1S41R1M/Yta3VDABltdCPeeuOmTc
	R787zbjxsl4SOTxSNdETvhMqQwEhB7
X-Received: by 2002:a05:620a:4148:b0:8cb:5176:ef8 with SMTP id af79cd13be357-911ccd8bd6amr3179246485a.8.1779234516135;
        Tue, 19 May 2026 16:48:36 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:35 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 6/6] iio: pressure: HID: hid-sensor-press: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:48 -0300
Message-ID: <20260519234752.23911-7-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519234752.23911-1-natalia.andre@ime.usp.br>
References: <20260519234752.23911-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the local press_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/pressure/hid-sensor-press.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..a039b99d9851 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2014, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -53,17 +54,6 @@ static const struct iio_chan_spec press_channels[] = {
 
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void press_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int press_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -225,8 +215,11 @@ static int press_parse_report(struct platform_device *pdev,
 			&st->press_attr);
 	if (ret < 0)
 		return ret;
-	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
-					st->press_attr.size);
+	channels[CHANNEL_SCAN_INDEX_PRESSURE].scan_type = (struct iio_scan_type) {
+		.format = 's',
+		.realbits = BYTES_TO_BITS(st->press_attr.size),
+		.storagebits = BITS_PER_TYPE(u32),
+	};
 
 	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
 			st->press_attr.report_id);
-- 
2.51.0

