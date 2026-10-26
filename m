Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009012;
	b=s5Fv29jwGcvgN7OQhlvAj0JgbjETjMoIjtDLMGfVrRxOQdkbSYnZjPGz8FT1RGn1yGPu
	 +91uSXC0OE/QoF5+nUvQDUdD/KnStc/r8uSYVVYssOq6fwjn0DQFh0V+4ViIgUJnCZqT0
	 6s/yoy74l13nOxdSKP58dDJh57WE7UCIAuHefvF4+zjvstKlniBhHj7eacQ1X/4mu98UI
	 IgYDF/yaBDnvbtIZzk+YmbdQTIRR9YSB/uimM9lj3Erm8pQdBAr2EmimHJ3r1dGKmlNKF
	 rKyMETOiaA4MFU0aXbuBEN+QWbTyUFbZHQyQR9QGBPLka3a64ea3XAXryCdm8mYQMjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aA0N+9+a6HUkw1aZkKh2dECF/PPE91C41K1z8VasS3w=;
	b=eGlOSaetIcPRv7M+VNFg5ViORySPghmp+HRR6xyQSMrxF1kuXM2eTZ4w51OOS7kOFWsB
	 gkWXv0UWNaZIDqVGScr9sexrvgPusbg880QGdZqXGQwS1KnVndR7cHMqQctDiLdvyW6gi
	 bq/0KDpMWO6uVgr2Htbvrwkf02UutVu0ANt60s1BXEDRNULDsq3FUF49uSlVKnhtptsWq
	 g4mnot4JH5ubSuueCOFaX2Thx1XXyh5CwwRBwv09rRyuZVhYr/CHsf/7Pmg3Ohg1c3ExQ
	 dsExtyxbOhVNYwNUb1f0EyMDOTOv7Sqb8KEN+RA9pJ2Nzt/cokXhyB+vHmbf2AyOPBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rjIqSDZa;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D27606A31F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D27606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rjIqSDZa
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35829219da8so4904023eec.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009011; x=1793613811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aA0N+9+a6HUkw1aZkKh2dECF/PPE91C41K1z8VasS3w=;
        b=rjIqSDZauTMVYB7mGCg/n2DjJFfKtE2tu6mHEnRzFoPkIxaMDmBEY3CXNtvT5DCY0N
         rWZ4R9Lnfy78ku7xSC/ljoss4nMVoz4UyKNmQmePJKHraMo51hPTTxOJHwOotm4W/MZa
         kZIX+OPt87nhv9OmiBCTtc0RkXqZvJ9BmgOBJOh7eJMBsi8ECs/LgRB6evjBuUAY3iIh
         KG4yC7DUtXrru3/11nfVKJs1mBdmJqfyUpD4+CxXPQcWr5jxASz6cNyAtIzX/RyclBPq
         sllWyNrVSYdgHd5YsLe3/3PQaBs4nq9rOZ6dQTw2sYp6UVLM6D/DmTrbnYBK9uBGKVyQ
         KeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009011; x=1793613811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aA0N+9+a6HUkw1aZkKh2dECF/PPE91C41K1z8VasS3w=;
        b=gXG2W1eCwh3le2+jfeLon5SnlolmkOwe4kswpPkZ3bmyf9ChocbhpGmue+bf91AU+a
         wkKUCW4R9F4A+Y/EW1/9rDD3RInqLM5meURsRzfffKcBW24nuNS02dzefz69mytgVWTz
         Zd79hUG5qdtRCH6pcP1a5CYshkszSrtO1oxewfGVcxN+qmBM7/fSHsGh8RjbPZCKf6VU
         NCQSMPqyO/yBpVn6pXHkneOmQO9Yv6WA5Q0gpLyZXXzIzdfovmkBXcJ/79tjQ5NoGY+N
         7WB1FFIAqOK37h/f9zlFq4oINhn70I0Afl7WsVXiPCM+qFirWAn8jGVfWArafPA+1106
         9N5Q==
X-Forwarded-Encrypted: i=1; AKwUvByqtjcDI0nYkH1/iu2I/gEChwK15rPQ0d+bglMWlcjT57yOn5ic14m4LvlaqsC5UC6SVtTgaRNp24o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEf2imcYV6c62yEoS8usQDPFa4T5rBKv2eI8vqypED8hbxZTYB
	IJktjVp0S70/Fk8E0lt4rZpLqHLZp2wXrl8Ahl7MPEiLIBnPUMsyf+ckasGYcAegq4w=
X-Gm-Gg: AYBFou3F1WZKwV+rtXSrTKh/2wg0HbBIlA9meHGLJj+chEFef3zDxiS0zCCbNkj3qTx
	la2P5W/A2oj8th7RRzgysAXLxHwBgzkuyprjuP7KK62sPBbyxdbxvPqSIiT8+DEKG1q4Rly28wy
	cCPlwiKLyBGYPZ+eFt0R5AE3/PMKhsIcmSRGkKwW6UJzNUzTeDux9YqH6fUNk9yal6/fHb3qggH
	XP9ZtPBeQMy5sJJN3jX7W9WyUlXhbN+KfnfSSyeGSUsq44f0acLxkiiY+PSzmxaMq5z+X+w+B4s
	ibFNS36PJvTX03IkmbFnMV38NH7ZyFHhJ/1dCaKfEBa6KQqd7agwKSMQSVAukw2R1I0PAm5p/4T
	cGkQsVzFpu5jEpfOwa3PeutZFHn4CEacshNhvrPqW4QBHM0RyHlTUcP0attNtohQWbKgLwrpnXf
	l0qzoa7DcQYypykuVFcwdUZWCc4Txku8zQLcRVqIwrELtgDZU8EmJoElYvfmHL0nYVg0Qy2Q6c3
	nV6VlKPYeo6D80OEIFO+eMttkR7bg268SI8GRfHB4xUPQ1na9gTqfyB+qen1SdRssuSES5x3mAA
	V8jQl/tw20IFwBt6sqg6iyK0s3l2WwDSfM/4hpuxaJqZZ/CVutlsmMacAyM9KdSSVdS7xklYc1L
	PMh82lprtA3RtL8sz4IT9bzp8YdbIv+JG
X-Received: by 2002:a05:701b:4181:20b0:13c:f65c:d5b5 with SMTP id a92af1059eb24-199295d370amr8732708c88.3.1793009011259;
        Mon, 26 Oct 2026 03:03:31 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5a515sm21246575c88.19.2026.10.26.03.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:03:30 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: proximity: sx9310: keep the IRQ balanced across suspend and resume
Date: Mon, 26 Oct 2026 15:33:19 +0530
Message-ID: <20261026100322.16720-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx9310_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9310_resume() also
returns without enabling it on error. Without an interrupt line,
client->irq is 0 and both callbacks act on IRQ 0, which the driver
doesn't own.

Disable the interrupt only once the device is asleep, always enable it
in resume, and skip both when there is no interrupt.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
I'm sending the same fix for sx9310, sx9324 and sx9360 as separate
patches, as the Fixes tags differ.

Compile-tested only (W=1); I don't have SX9310 hardware and haven't
reproduced a failing suspend.

 drivers/iio/proximity/sx9310.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..f462e8f9765f 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -943,8 +943,6 @@ static int sx9310_suspend(struct device *dev)
 	u8 ctrl0;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
 			  &data->suspend_ctrl);
@@ -956,7 +954,15 @@ static int sx9310_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	return regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	if (ret)
+		return ret;
+
+	/* Only once nothing can fail, as resume isn't called on failure. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9310_resume(struct device *dev)
@@ -966,17 +972,16 @@ static int sx9310_resume(struct device *dev)
 
 	scoped_guard(mutex, &data->mutex) {
 		ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
-		if (ret)
-			return ret;
-
-		ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
-				   data->suspend_ctrl);
-		if (ret)
-			return ret;
+		if (!ret)
+			ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
+					   data->suspend_ctrl);
 	}
 
-	enable_irq(data->client->irq);
-	return 0;
+	/* Balance the suspend even if the device couldn't be woken up. */
+	if (data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

