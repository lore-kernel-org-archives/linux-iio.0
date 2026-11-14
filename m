Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641776;
	b=2YLvlygBHUIHI/OJGr2M9oUrzzImhblw9raby9VLCLLC+8CGIyt0RTwQq+YkG0D9YRYR
	 TPILbfWvV6E6NMn5BdZxkWwesBARoXHw87czOjDgWGPpjEo9YMNCQMBJ4/dPTIRLwJ73w
	 ikD6RLreuQDYZANmtOWBuFK4zabDhSN/GDK3i05h6jzipTbqeB1HBRFkKjpgIYaGrWCWF
	 zWSYBm99K4ZwqlT2Sj1MltchkJp+INJid9wPrfAanlbps2llgTaMMEQwgw20yVVLm4W6o
	 LO+qcQxEGypq5ZEjDQJsiIlqDNDY96rKy9V1vNW+iUbi6I3l+TGDea5TPGialJrO28g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b+IFA55NfN5aJuZh+7JKbUaWL26xhQI0occ4BKED0es=;
	b=r5wX+ePV6ur7JWlIinFvDkzFHwM7DcveZ+Fjqfa9q3S+/Rgya9AInOkLZPxQDwNIcdwa
	 KOOdZI9WsmyxdjBhphJhZROcRpFsjMVXLzb2zamIOFWvR+klHoJkNk8Bmhyuq10W6V5PC
	 k6gVzQ/GBAG4vwrSNAh2OKswWFyZRDftiLe+EP0391ng9YvnM4XtZA+Q0t+pirtxe9E0s
	 lmp1bC2BePwDPhCaA4f/S/pY5pjHLgnvALHk2NEtCFG1DzRXq+ud7bSgXBOGITRnK2AsK
	 BDPWqVSOJJ6fqaZvfOLrVlRKCkTXkU8oDfB0CaQokmY4eAia7tkanT/wMmfUkRvJ5zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UmhjIhPq;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D03606A327
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 07:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44D03606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UmhjIhPq
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37628596783so3078159eec.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 23:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794641775; x=1795246575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+IFA55NfN5aJuZh+7JKbUaWL26xhQI0occ4BKED0es=;
        b=UmhjIhPqx2Gpe9rwVAApPPqCgLG4f+Tag3njC4J86OYbqawZAaZfuhUlM+mzMnpJ1h
         G3DQCX40cUCDU+N6q65ttZRLG8LS1y1la8eU0XSwxUryE1GCHTaQsZjgFKdOz4wAUdLR
         z46Et5lGl7LxJf7q4KBp/Ohp8+1tRUDxr91irSZf2hKrpCc8W5PAcwvJN4F9YYeM2Br6
         1gVMuAJpJ2BMPhu06Jo3VbxHyTpVkXuz3GXPQfd5TiBvWbmq4qYPO35QEPgVrFL2TOKK
         UABgKpmwml8WLEVHb7SJEaLzNexEfjNXZgAKmDszHt04wv0LpVcFB7COZK/WiB75ctKV
         C2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641775; x=1795246575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+IFA55NfN5aJuZh+7JKbUaWL26xhQI0occ4BKED0es=;
        b=wBEGdaPoSmeFK6zAV7R1Sq+JsNe2HG+swb7mo6Grf1hMW0tfxNZtUamLN5gR2kOlfD
         r7YhZT34kdu4xX3D9TKiaRwjMXkaA6z2kjrLDr9X0tpnCHAVp54EBJ5p4BPnytCZEGp0
         lsYosAWlr55eJeizo0zGedh0fPvi2WElcLacPeRiHBflOS56MLwS2wEfEKSSnw6sJ7u0
         y2c81MEkn51BymmlcWM02W1hJ7LvQ5oLBeOG5nYg/vEtWBCGn7kcASYrZhVEQikgOOyX
         8PonVVYqVQOz7NUSWGup7mQWujJ2FbfFEYCk/e5bx3NEJQnIcegq/lrFaJHeHXhjXrd6
         3atw==
X-Forwarded-Encrypted: i=1; AL+hErEp5bOXoiUIftNwgxFoYXaMwu77+ERheCptvdyHeKcdldMP5Jn0opIAaH+mynDm4ZbEw7Btzc/bzrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EaykiSq3g28JDtoE9UKvgceypfgG5ZD+pRIzEHCCl7V41vTPj
	z7Gfq4aWghirr+cl2UsNLNnZIQKCtJ3tTgQDfin6TtNS7/yfEySOHKYS
X-Gm-Gg: AYBFou1KAW9ITVnEbDX4qNM45Ia4DAcKoANGacJcVmewqVk1RpnEXnLmt2rxzdso81E
	/YnVG7srbrNOK9/gwhWI8z1byx8ic4c88j9AvnumF/5uYixtQp6zu6mVZFFDLswDoG4zzjJLzzH
	dPQUVcTcIN6MrDM+1O4eWE+y2EI/qfrUdNq+1CA8cVg4Cqk0IaSbamW6OAZOuwbFnADUqZ94yJD
	xu0B4rzhxYjurtOkvztvpDPzV16XQtOt+fVA0H+FN8J8/XcUoK5TGHcMcuOT5ocjWsIkbrrtCUt
	LhKpgA43LeO0ssE6NRS2PKV0dCLmaPi0Do90EdViMuq02jL1/tgXDFdg/ZEwScD+go05gU8p++n
	hHMrT5do6wqqlhExrfb1Rn+peYZp0FDfV1ObD5t8jjKyVzfeJVc4lhA8SyoGFIjr39D+cR5drIo
	dqdmwFbAfZSxG3eL7uGmk6mC2zXrme4wdMxnOI43iSsdUydMVIBIrt+q8SQ2P+Gx2sA6Zj0K7FR
	0HCnplwHADJsoK9LAC1l/gNHazBXsHiSRAsT422qeR9XXjMS+qUPkpyHBFZ5zphIv1XXv51AaQw
	+FcwcRT870OUtRQf4EAPmEkfR6eSrgHIeocxf5n8lM/9wMckMdROzT2bqhHm3q3/pDx6i37bTJx
	B0UJdOtw61e7O8J62RwgtV57P14XoVFrbFx2LKE1EK7QFb3Umn3P2i0Ks9r0KvUmTt+TupaRLmn
	q7Tk7sBnD6cfujezAH5MWhxpqWomEq9oQfoV0sSQgzhw==
X-Received: by 2002:a05:701b:4541:10b0:165:90af:a25f with SMTP id a92af1059eb24-1b50315017fmr4613879c88.41.1794641775234;
        Fri, 13 Nov 2026 23:36:15 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d990sm16082635c88.4.2026.11.13.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:36:14 -0800 (PST)
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
Subject: [PATCH v5 1/3] iio: proximity: sx9310: keep the IRQ balanced across suspend and resume
Date: Sat, 14 Nov 2026 13:05:55 +0530
Message-ID: <20261114073601.23404-2-kapoorarnav43@gmail.com>
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

sx9310_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9310_resume() also
returns without enabling it on error.

Enable the interrupt again when suspend fails, and enable it as the
first step of resume, before anything can fail, so resume mirrors
suspend. Use disable_irq() rather than disable_irq_nosync(), and call
it before taking the mutex, which the threaded handlers also take, so
none of them is left to run once suspend has returned. The driver works
without an interrupt line, so skip these calls when client->irq is 0,
as sx_common already does.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9310.c | 54 ++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 2585b9c6fb69..71d1111215af 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -937,46 +937,62 @@ static int sx9310_probe(struct i2c_client *client)
 	return sx_common_probe(client, &sx9310_chip_info, &sx9310_regmap_config);
 }
 
-static int sx9310_suspend(struct device *dev)
+static int sx9310_sleep(struct sx_common_data *data)
 {
-	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	struct regmap *map = data->regmap;
 	u8 ctrl0;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
-	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
-			  &data->suspend_ctrl);
+
+	ret = regmap_read(map, SX9310_REG_PROX_CTRL0, &data->suspend_ctrl);
 	if (ret)
 		return ret;
 
 	ctrl0 = data->suspend_ctrl & ~SX9310_REG_PROX_CTRL0_SENSOREN_MASK;
-	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);
+	ret = regmap_write(map, SX9310_REG_PROX_CTRL0, ctrl0);
 	if (ret)
 		return ret;
 
-	return regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	return regmap_write(map, SX9310_REG_PAUSE, 0);
+}
+
+static int sx9310_suspend(struct device *dev)
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
+	ret = sx9310_sleep(data);
+	/* Resume isn't called if suspend fails. */
+	if (ret && data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
 }
 
 static int sx9310_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	struct regmap *map = data->regmap;
 	int ret;
 
-	scoped_guard(mutex, &data->mutex) {
-		ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
-		if (ret)
-			return ret;
+	if (data->client->irq)
+		enable_irq(data->client->irq);
 
-		ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
-				   data->suspend_ctrl);
-		if (ret)
-			return ret;
-	}
+	guard(mutex)(&data->mutex);
 
-	enable_irq(data->client->irq);
-	return 0;
+	ret = regmap_write(map, SX9310_REG_PAUSE, 1);
+	if (ret)
+		return ret;
+
+	return regmap_write(map, SX9310_REG_PROX_CTRL0, data->suspend_ctrl);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
-- 
2.53.0

