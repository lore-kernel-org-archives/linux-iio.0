Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641787;
	b=JOFgaO10LA7U5Fk6hlymJBk7RxC+2BEvRSolVPG0WfM7bIMGS27i2b6MEl2dAk3PylR9
	 qBwqD3UiHICYo1sMp4eyHHUZ2L6fDMWzuX+32n+5r2iLCnHdW6PUUNXC/6VjDU6WqIIuq
	 3IY3XdCrTNQBslzENFEJYIpuhmGBkfKkGpWrq44VvNtqWvmNuyIBxNNORFwn2Rw7Pi0vt
	 oHh61XQhCrecbmJfMEIzUqTtJVQunlpqHFK00LTy7hTLB1nHuOn5OTzlsXe7o3KIP85x7
	 UkBiUR86yllVxSZs3eFgg1ginqdCFfI6o9JoikmR6KfSK9MfRiWrEZAwNCe/BHxBp0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gWtPdoWO7R8JhnhKE2fYO2lEkWLFZtVvjPE+5aCE8so=;
	b=WQFL3ixwa8xKmFdBq0ySNaCqHnWZp0FTDlyUkkWC+lA5N2PnIOZzVUS1/XKtHQrgHLEK
	 toq4Yo833mqdmQrFpH4gggNUX91cdIaUZHIdkGto4fX95lrhzxhOWnvQphnigX97kUJ7/
	 kPZgEFT8kbtQYTbwOBx3xd9eiFae1WbmM2nLQgTiJ60k7RXzw9heGDrYaMFyiUq38SYXg
	 38Mxv58Uz/SdRIVyG2NqbO7herE6ZYiIm/KYYj71u8q2rgOpi6XMuTS2KLzqQuMa3sfNc
	 4VziezEYAZNTSX0Pp+KPfByz/4X6QTBSH5dxNpA8JFeS1+jVBF2240S2fMt94zjwR0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PiUV6zW0;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1A606A332
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 07:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB1A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PiUV6zW0
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so2473018c88.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794641786; x=1795246586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWtPdoWO7R8JhnhKE2fYO2lEkWLFZtVvjPE+5aCE8so=;
        b=PiUV6zW0ArlC4qQyn1eA4aIKYWd/AJKrAmdDP4P6PDmQeRMq8ukV1d2JjBHeTURtu3
         jcp0JmHYb6jf2I+nHiLNxzkwJovLMfX+fe9GOY1NqkdS5CxLGp6GQ2ZRgflPTgYj7TaX
         BnVLA38r+dSx5mHJuLOYt2d4ZoHClTQx1eApfae51cdSWlmxdeY3Fy8H3xleYO2OoSiP
         lTWpIgSqWISgxctOuxaLwMEhw0444aaGm+jhnzkvo02x40+foHpui+q06IT0d/6rizLA
         MgV5gXqE6YXvRVtuwRHRNhzqWqXlsoyk0RG6UqIqQYjZ+aS2Ffqjr8B+t4MCW9qLNl2g
         fXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641786; x=1795246586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gWtPdoWO7R8JhnhKE2fYO2lEkWLFZtVvjPE+5aCE8so=;
        b=mO1A8JxSb1BXDwtz4dpmWAXF1pUeXpNA1dFRB2zg00atYCv82BVUzCldqO+lbLpXuu
         YX3bOQUogcMKWje6BEsCP9b65FDFo/cvYJfcnUAM12l7mgQIEinRpmHUNVcvxYoO015J
         TgW1bBehLsXk1pua8yrvBxGU8YaAMY0kAcqUTkaGw2RKT9vFlVmBvxWsRFq+4Y88/xCU
         Kw6RYa/LDFuB3YY1PkD0H4hCyFRwjd/+sRODDFons0pCWp/tEiyETnuexx5grzMguYfM
         I49h7o7bjodbDHiWecdcdyiwt129Ph5ACsLBms6hUZSovxXhM2azCj7NFZhzSx8TsKUk
         rJcw==
X-Forwarded-Encrypted: i=1; AL+hErGj3Jtz0GzwPWQNanDS3DLK5wsknUXZUdRYKFV4dbPfJEZKF24atYSIaWpifjcG4/Js/sSrmexNcmA=@vger.kernel.org
X-Gm-Message-State: APuU4Z92eBEqTZIL7+inotosr2hM4DogBTxGAk9Euo2of+2kvFtXW0vV
	pJpK0idUphet+rsd5J6TiOffrFDgDAGqW6CI7BSZs/eSV+JdL0B6KzMd
X-Gm-Gg: AYBFou3v8fbKDReXdeNttyG+q9T2fHOHLv4LbsIBz3AXP/GHd9PV15iWc1UsecOQe2b
	1cqeeeU4ym72zQer6fbYswVnHRfVzBPQ3pyxsac/DjZsqo3Glf+ddy3x7crB4bnAHyZptHkI0k4
	6f8Xynyy7DY0WDHqoU5HcXSs1+M31xkwgJQtTB5ZbrVlGjnqTXXW3yWP5ritH1uIxMC44H5EKC8
	dU+L1u+iFFQtbMvlP50fGOjicYbV9Rdcb1nHmebjbpb+7vS+0qah5wYBuRfUPp/zwovK/CtM9sB
	Y1BkIASkMx1uHoCD/E56J+TenrRVhIHvkcL+yXkDVTJ9frH0l1LiQFtWBKSlOEEIs2/R25GNiB0
	kgyEtFVgTPNw21w1E6/qQBI+tZ7ucJWfssPzoDw1FyBRVbRht1Zs9uixs2Vq2TiCItEEeZQtLha
	MuQJH+J/ihOTaexRRf41hPcwLskht5LYO/blkuoRqKbq/B4E3t8dHC2IWDBZcZcaLFd1A2Zwn4U
	JfoOrJDlqI6I28mPFdT/P8ADWZlP1D6IxU/BYshEd/3uC3xVJQ9thNmWKloQ96lgyt3Q41B3/h8
	0nFD5ibryPMC5NMl7mR1aDe2Q/SZfBExe/rNs58f+Tv6jbBnf4EvpvMoOIIoJvlfzhgC7UWJZW8
	U7o7SEmXGrTyeYn4ubw2B3Y6+3uvk/HaAH37/V8FePiVRiaYoQKwQqFBHM53nY9IZWl4ou2a9vf
	ID4uC2ht2Bix3Kk1Rem86VnUjcJYhsS2pqIk3o2ts0fQ==
X-Received: by 2002:a05:701a:8458:10b0:1b5:1ee6:b6a1 with SMTP id a92af1059eb24-1b51ee6b6ccmr398153c88.38.1794641786148;
        Fri, 13 Nov 2026 23:36:26 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d990sm16082635c88.4.2026.11.13.23.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:36:25 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v5 3/3] iio: proximity: sx9360: keep the IRQ balanced across suspend and resume
Date: Sat, 14 Nov 2026 13:05:57 +0530
Message-ID: <20261114073601.23404-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114073601.23404-1-kapoorarnav43@gmail.com>
References: <20261114073601.23404-1-kapoorarnav43@gmail.com>
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

sx9360_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9360_resume() also
returns without enabling it on error.

Enable the interrupt again when suspend fails, and enable it as the
first step of resume, before anything can fail, so resume mirrors
suspend. Use disable_irq() rather than disable_irq_nosync(), and call
it before taking the mutex, which the threaded handlers also take, so
none of them is left to run once suspend has returned. The driver works
without an interrupt line, so skip these calls when client->irq is 0,
as sx_common already does.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 45 ++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2a9b37df8f62..fa89253567b6 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -808,15 +808,13 @@ static int sx9360_probe(struct i2c_client *client)
 	return sx_common_probe(client, &sx9360_chip_info, &sx9360_regmap_config);
 }
 
-static int sx9360_suspend(struct device *dev)
+static int sx9360_sleep(struct sx_common_data *data)
 {
-	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
+
 	ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
 	if (ret < 0)
 		return ret;
@@ -824,25 +822,42 @@ static int sx9360_suspend(struct device *dev)
 	data->suspend_ctrl =
 		FIELD_GET(SX9360_REG_GNRL_CTRL0_PHEN_MASK, regval);
 
-
 	/* Disable all phases, send the device to sleep. */
 	return regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
 }
 
+static int sx9360_suspend(struct device *dev)
+{
+	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	/*
+	 * Before taking the mutex, as disable_irq() waits for the threaded
+	 * handlers and they take it too.
+	 */
+	if (data->client->irq)
+		disable_irq(data->client->irq);
+
+	ret = sx9360_sleep(data);
+	/* Resume isn't called if suspend fails. */
+	if (ret && data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
+}
+
 static int sx9360_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 
-	scoped_guard(mutex, &data->mutex) {
-		int ret = regmap_update_bits(data->regmap,
-					     SX9360_REG_GNRL_CTRL0,
-					     SX9360_REG_GNRL_CTRL0_PHEN_MASK,
-					     data->suspend_ctrl);
-		if (ret)
-			return ret;
-	}
-	enable_irq(data->client->irq);
-	return 0;
+	if (data->client->irq)
+		enable_irq(data->client->irq);
+
+	guard(mutex)(&data->mutex);
+
+	return regmap_update_bits(data->regmap, SX9360_REG_GNRL_CTRL0,
+				  SX9360_REG_GNRL_CTRL0_PHEN_MASK,
+				  data->suspend_ctrl);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
-- 
2.53.0

