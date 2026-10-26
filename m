Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009101;
	b=5t8MOcVFHetOZCJN/VsciQb0m8FagSxS2TxCkyFEL6s1+HfwxUAZS/iix/JbtOut0EKh
	 gXXqbWgEvXk8K9wlDg6r04LdOsLXA89FoBhkb23NBSRxprdHSBEnAdl4eBtMFVJ1K0s+o
	 il2y1UTKytas+DebpKVPAyOJLhz9yR0tB7XVyRtQuuzEZDM1QJSmI7/5quEs9FNvLmZKE
	 uHc+IQjA2LxNtfG18auy5HRFPjMQeHp6sZQv3UP1PKAAovxusoI22JTyUyKwMqyUaI0YI
	 MbuZD+XRJyyNXAzgcz1jm7wq2/xokOFqf51Lmw6k0qAhPK7Fy3hqCBsvN9oDdGfV1hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GmPoTm80w1aA6jNGqFN5qwBH3dTXLvg28noXFFNUWug=;
	b=M2STrywXt1XZJ/Ox6Vj6SntYv26DCSBAHOIpGFL6Gra3vyJEF28QwqJk6atafs/JRxVK
	 uQP6tJ7eaplYLDnqtEZOpl4zW8zpXoEjQxzfPO59iZMD5xmuT7+L9RzdRTHtHmInSSg+W
	 tb5OeLi3QHgWkHnIhen7NCPYXbz+fhHcjKcL7vwhOqVJ9fINuP2/sP1bRQhen6ghYXDoJ
	 nz485q45RE7YuwIG8io4jOkFpR+4oF6l6sKM33ocTIZpm7lt/BZRtUxM6iDlOmj2oTaZC
	 p6vi2ToEIdDIf2zZye6GzI4xbwq7L05fOC6F08987tMJEhssAGp26zeiHiZ+5jpLCVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Uu+CGVoV;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60B60A260F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA60B60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Uu+CGVoV
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4672240eec.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009100; x=1793613900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmPoTm80w1aA6jNGqFN5qwBH3dTXLvg28noXFFNUWug=;
        b=Uu+CGVoVGuppEhU23WpAU8OKLtB7yHnTsm5kGbBiaOepEuS5LZmXuA7RPG85nTrTcj
         cJAy4LXdYDSbK6n7VysQDu9nC+galbukDwt6O/ylWyhD4zPrXwsLzZURj5PCk6PDmIZ9
         2IfC2EqmhCnsu2xqGxqtS87hXkyD/tJrH18C/LGJfWXzrHbMvRk0teXXUdy5AfYw4BUg
         D+4HaXKQz2woTld0uGJWNpILmHk2fT1WVPuNh1Mh0vYoeXXI8mMllgkYRdGIyjZOhGYo
         jsTHrGYhGHJzkvCJCCYQjB9oHwEJU4IrpsSJ8iUo10Fq62TBboJz07fsHlr7FeLYac4L
         +HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009100; x=1793613900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmPoTm80w1aA6jNGqFN5qwBH3dTXLvg28noXFFNUWug=;
        b=IH/lFJ++jf1+7qJpxIGxZh3+SrICjiQTQ9wHpf3EoZWHSTEo+eBukfptRJyFFGVBL6
         LoJckYC5v5GHcY+334+Ne53AthN0Gse5C0y/xhT9tVbk+3FHVkml9Gwz/K9Gi1qXD+L+
         tNdmWZZprZ77u5janG6CrDc8JIJNgq8J6CsIoO5NDSWhgTTAq2cEUjRLRuL1nNPb2BJN
         eJnpCriqgr5nrW8WazCQRrLy1HqFiCa2bqLnhaVCvDgJDFV5+hkZwYOjGSTSq9YTBq4D
         7AMbV3k+JEJ4UJdrhO5a6zURneJz0eJYR9IzrvduFh9S2+5Uz6ZZ0cjfi+NmQfszi47R
         zJgg==
X-Forwarded-Encrypted: i=1; AKwUvBxnYSIfhYebQSqyVhoej+UC5u21D8yLNLeX22xd5T1UFQsJPsgdwSQqHeGEcYhqVTJQLwOLiB46beQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq8xLuVOrJhUMNR+wrZ26En7lDBKF+rgmVPJm4uRqc1IyestAd
	D6kLYlsgaV2/2xuAOU9v8sNSMp2Ujf7fFD9rVFRKwA7yYo1gVCdIo224
X-Gm-Gg: AYBFou2PvhtVptyiXaM+7EdM9ymIRQIiqVlfoGWMCF+SNKwY7+4NeZa7lQglBX0IxeD
	Mrh23lGAbiB5JD2OTXLAdKCnucOwtyTjy4HvLpGMEfQe15FOQeIt3/7ab1Muz6ZNUBYQ41mrmu7
	hsqY65S4Sfp7jStsEjPLBrXEAtkvDFIiN530hVVhLgLt1ikFeg/fWGD43TWlO8VPXorpCuAHaki
	6sp6d+OkOXQ893+fw+yImXu9JSQWXSVmRQZX+P/19eTiGy+SlWhmxa0ThZxo+Ty0PJ4LgyxkMMg
	maABzBr5m1+xDB1DEBnKTRx4EuM5NwKfVBYpCh7UvHLcYnQZUAHdgWvRUsiSQidY7WHXvghH/0f
	0fV3MkYELertUGrc9Rc9SViaaI3PM3E+OraELlSqeCV6F6rDkSYfMPnE3LJcJ+6se7ZhvMRD7R1
	3DBoE8BknJdUOgwrhGWtooPWRNXWGPMvpcW0UGjjrUG0S0ZhjZtez7zMBsEroOD/kZEjW/GnNRD
	0LUPOpc/vQXC4aSZhUQx1bLZjKwKTZ1aforqN/lAKReX7HMIDGkuU5HIcnVJSl6+Ru6jE39wLgI
	gursxwattTKFZqzbYk85uzYIrKpU5Vt87GkCL9vYtQX8hlLk0yfuh6z6lKW1Ift/xD/K4ykrZHI
	QS69LcpUuj2L2C3B4DtB2OnBEmbOnKs7I
X-Received: by 2002:a05:693c:41c5:10b0:35c:e696:2d4a with SMTP id 5a478bee46e88-369f83ae704mr5296092eec.24.1793009099693;
        Mon, 26 Oct 2026 03:04:59 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daa3a8sm29726211eec.16.2026.10.26.03.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:04:58 -0700 (PDT)
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
Subject: [PATCH] iio: proximity: sx9360: keep the IRQ balanced across suspend and resume
Date: Mon, 26 Oct 2026 15:34:47 +0530
Message-ID: <20261026100450.17023-1-kapoorarnav43@gmail.com>
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

sx9360_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9360_resume() also
returns without enabling it on error. Without an interrupt line,
client->irq is 0 and both callbacks act on IRQ 0, which the driver
doesn't own.

Disable the interrupt only once the device is asleep, always enable it
in resume, and skip both when there is no interrupt.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
I'm sending the same fix for sx9310, sx9324 and sx9360 as separate
patches, as the Fixes tags differ.

Compile-tested only (W=1); I don't have SX9360 hardware and haven't
reproduced a failing suspend.

 drivers/iio/proximity/sx9360.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index ed83d809ecf5..85b83d86a433 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -797,8 +797,6 @@ static int sx9360_suspend(struct device *dev)
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
 	if (ret < 0)
@@ -809,23 +807,32 @@ static int sx9360_suspend(struct device *dev)
 
 
 	/* Disable all phases, send the device to sleep. */
-	return regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
+	ret = regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
+	if (ret)
+		return ret;
+
+	/* Only once nothing can fail, as resume isn't called on failure. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9360_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
 
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
+	scoped_guard(mutex, &data->mutex)
+		ret = regmap_update_bits(data->regmap, SX9360_REG_GNRL_CTRL0,
+					 SX9360_REG_GNRL_CTRL0_PHEN_MASK,
+					 data->suspend_ctrl);
+
+	/* Balance the suspend even if the device couldn't be woken up. */
+	if (data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

