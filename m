Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013855;
	b=kcjYszFpk6bsEC8k5MISKu7SEth0zHr3Kine9K9zf14xZWXxh/T7fUP1wxXJmOpEkexj
	 T3++RL5Ti5vM7MkFJKEFZWzglq5ZZXM9DmEg5TP+wWfIlEAuzvCloeHU6r9ClygWmNIAk
	 YRP5aTIjve99vKz1lXnB9DpSLxEVIidLDiyRxbFKXHuCKhOGDmuXF/xV795WEz2HaYiAi
	 kRA0h+8BeYENzVFv+YYgIQekjcSzQaXFJveFIa3eDtWdwqBYft2TcDTfFmsD6/yeEAnCy
	 wQ8ItfPsu/moutgsOT3GUmtZqryFrDnHMxTrPkuAuaCvnkUp7gvKg3OTkqnZbiC3YXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gubS6R+BRHVt8ubZ457OUw2tXG30gxHEHztMFFDkJ1w=;
	b=baW6zeEZ+voX7wQrT9i60OShYmwTa89NSDwIYMl8LDcObS0xHqrdRhfLcHTlFCOEKDnh
	 Heb6T8omz3uAzENgbu7Q4uH2x2fylpWHyhIGxaraIIllCA7haMOjdHmx8EshnEL804xlK
	 TQKdawYkKP0pJWnZJm8Juv4ud2WSR7imMBF88vLkD0Jn0jObraPQ0g0Q18xD1+Sr4i4kY
	 pMd6omTMw+q2igzojoJdAErD0DFR+DC6D6eOODMROxNsPXLihA2qhx4wMJ598j+YDUPUR
	 ZALSXFS48TyaVUviSlFMjLe6CXQN7LKsAJkrOd5neSNhHqS0Gvaib8Ewk6jOOavAikw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qgxGLDIM;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BB606A324
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 11:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 098BB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qgxGLDIM
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-369f33df08eso2613057eec.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013854; x=1793618654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gubS6R+BRHVt8ubZ457OUw2tXG30gxHEHztMFFDkJ1w=;
        b=qgxGLDIMsoM4FJ6DO4vvsW71Bys782W0K5qykT5Z8a2kbmrHlyodZaKcvRolCqEo8r
         TJNogFYmpCcZaOOFX7R/2fB1nJ099mXcVZz8IBjVPsU6tbc5pgL6o/oKn5ZK4oNpej4C
         UeCltzLcj4pKGSkChM35oqzCPJ4qkKMVQG9MWzGb3Fx1z1dO8gX9twn5SyIuo+2yZHC0
         dCTqb7ruVf4I3TSzUUSIFGjcNK9t0toAfnlrtlgJKiBK8lX+5WJVuLxiZt4ZssB0x6c4
         i1+cpna32aFON2E+EVv//r0s1/EztzT8pwUuAq4OfHCUlE61Bgq0mFRhCVL/lvsyLsDK
         boXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013854; x=1793618654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gubS6R+BRHVt8ubZ457OUw2tXG30gxHEHztMFFDkJ1w=;
        b=iQ4qkxdLlc+Xe5LoaE8k6alck5JbsbHZO6pPPfvVatsLVRDGJrL49ZMkVYehRPBwOx
         cOv9VBVVCxEP6SHyOcgNNodLZ+N1aoDmdplv60AhHzuYYMM02RGUhI0C1BViJlnFEig4
         55JkYy0jtYnbLIa/il7ED90D82unAHe2WbxCG6z23d1Bp+dJDFPV1v1mshEd7eYqb5Tm
         KW4qqJGQ3RA16Z9KTSTvpHIWcmIIKqCC/awHfiaNhbS5rk4fbKrVE8ru12/nkJ439zRE
         5VPCoB2f1M8TPA4orDNUq3HtMXvqK64TZ4gOJzR4YF8Jt2tEXM6ItiItkXoa8tyq86SV
         ZOJg==
X-Forwarded-Encrypted: i=1; AKwUvBy1r8Eli9uyXYGP1pn5UKUiRuvGNexNjgDNnQXDCSzNm1CSTtte796cvL+QEMAzxMbnwyszPPsjRIE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJp2r0vG6GBZSnZd0YrQA8b1YzFdmsx041yRsttuiIjPL8K2YP7
	hcMZJ+d8/v24RNvJK/u5hNz95Xi9dTQE+wk1XcpsfrIn0NFFeFL6OSDH
X-Gm-Gg: AYBFou2Z3jNqRUbnBWUAejaX4XGJTZu6qddQkA0o3pQCdqOhVZdPOpzjokgUCxp6kMS
	04BvRveP4AVYztDg91kzNSvKMN2/HKp4BWkdijZd2cVh3q8IK+Ce4iTZcnbj2/WAWoBWgodoCAp
	Uuv1oALfUVtfZnxTEm9yorISIcPIveoEfKGIKYqZwiQyoXdPdDtkaPvnbJqozsvi3CM0kW2hnzH
	eqZRbiYbzhhqkXH0F7bqWEy68PRmX3EjPSr2YH40VPAAHE7XWtdSVMaIF2Z5dh+2KYar+SdXtMF
	/H57HjrR7NOmcTIi3PA9/7hasAVGKYLVlPnB80ZzugXhHf42DeEYIuVzlUNw8DwfBj2D3pDTYYX
	PaOEKBzq75odvqgEaO1O2WdQXePNOwpQsivexUflR2jpuKLc+OqBZVBCnI7JjNfc+r53KDX6JFW
	/X9huZ0/cqwH3subA0Qrw4bPgt6yx1hXmX8wrZLtQmTihyp/y8I/pj5pqCKmqhPc2zy6atf1xo1
	KXaDsqYD2sf86Mr6ZYQ2yppe968brDaU9alkEtmAMj6Un8moZIG5HamiNQPXlCoeIAJEuEFYX31
	hhvzpCSsgUem5eR4LqD0O/sgsCIFRwtDV96bl6Z+8cmgeGDOZ7+yC1a3JyBpm6Wrg0vU7UN+gTk
	6rWLXvmfWRJo=
X-Received: by 2002:a05:693c:2d84:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-369e84fc4admr13621532eec.9.1793013854101;
        Mon, 26 Oct 2026 04:24:14 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a064510b0sm6599989eec.2.2026.10.26.04.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:24:13 -0700 (PDT)
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
Subject: [PATCH v2 3/3] iio: proximity: sx9360: keep the IRQ balanced across suspend and resume
Date: Mon, 26 Oct 2026 16:53:06 +0530
Message-ID: <20261026112342.65917-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026112342.65917-1-kapoorarnav43@gmail.com>
References: <20261026112342.65917-1-kapoorarnav43@gmail.com>
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
-- 
2.53.0

