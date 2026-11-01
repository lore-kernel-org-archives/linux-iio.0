Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528742;
	b=BR0cnFLIst0TQ5VBTbQix6G/EdWtJa4oJlKlxAu3UGo4imckjk3g6jiljw7cej7WGFMz
	 j6+4EDGgg0SMtPIWnsqiz1K7ojGQAWs36aeLm8Pv8XW3eLnjBDFQvd28NnakSsquwcPuz
	 9UCzkD2E9s6/hFKzcrsDxk0PBMO+Nn9wXx2ToEmUa3EFcFQ+G48SbrrWGwSodLOvlPH9L
	 s1avYcKO9hozEPUCKfGXcAspKDCAFQJAeQnKQY93dSgIkXw9xhyu5+5hB/1bhMuGW/qU+
	 1t4OgkQ1wwJ1rf4pbCj4CLgXaWWuAALfQCJ9rOdf/rRUTPjg2NC0HWBrlzptsPoexoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ScDmKIg4acvR723VJmmxd0Toi7h9g82TlLCDxj6T2go=;
	b=jbyE3TE6EOZlY9dz4FUdvo26laa85j0IiCZegbQCdajgaQ6PyoigsjRW69/dc0yCz1kd
	 mlnIkgipHbSpXsJmwyxYK7NeE7XrVd4lDKMWrXQDl6rDMrQP6okCWqgvTIu/34IB0CrqT
	 iUcQQ/FrCye41TUgW8wjB6zGlf8Q9j+6i6j6A3RBPvJhEAyGYygxmae6oaFC2xP5qdi6u
	 VkrJYf0qwuTubYG0Jgiqyv/kw6ELvHqprKiuCWTV98T/acpX3PBwbOOcdiGLbS89XoKAg
	 RWf4yx1TvpLMGJ/lCIWT47bRhf6Lg0kLm31YH7YDl5QRqx6oC3k1jDrPXb5pPCGD60Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1EERYeq;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E9606A327
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 10:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF8E9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1EERYeq
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15943c9c005so301311c88.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 02:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793528741; x=1794133541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ScDmKIg4acvR723VJmmxd0Toi7h9g82TlLCDxj6T2go=;
        b=Z1EERYeqilyU8QknxfEMmyHwDcF6fm4byHkFPlQQobVw/FOEaNVTFXmU7C2l80ZFat
         1h0ZuPWY3X/gOUb6xtzVrzrmChFGdFE53UBQFCE/rXG7EonG95ph9sgqiYjTOSO8dq4C
         F0dzXiyU/aFoUar7O1KCfH+edLj0wyx6K9GOl+dBe5QaUoAVZZlc/Y6EPEoxR1jMGa6h
         SkdGKaybrGp+HAMYFvWlxziTp2I/xd/3ihMUnZrbeQiBpjNo36f7E3pz3Q9TKrT9CSI3
         vIgqdRlMjYesM9lkZmt5IJdvbewCUaUxQ6A0pBAnHikQfpyUD832tsUA3E1XNVVbEZMm
         vodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528741; x=1794133541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ScDmKIg4acvR723VJmmxd0Toi7h9g82TlLCDxj6T2go=;
        b=ZcMYXpbt4n+0s6UEwapoMIZ7iKeVkQtMaEZYfE+fn22lYO2oHOfjs3R5amB+8S2WI6
         7WF3vJe3e9Fh1e4vT8Cx/0v26x49I2uffxg/dUF6ldDnE80NS55kfs8Pmmw79r/64kJG
         R6LXgHeBpcbD7fFkeqZazSl4ChO5kkZ5gh/CVNgu0I849PRmdZ5CljKaYtg4nPTRkfws
         nAh3+uEr3fkR4lDtiQ3zch1nL1cODRTcpE2QrVyotjmT1GgYmt6qjRWBI16xcC8tzAYU
         N7iCH80vUwgTUOkjoGgKAjSTC1LzrO6hf+iAc/G/k9JlZwTaRUHHecyi924/j7iGMhDI
         5JOw==
X-Forwarded-Encrypted: i=1; AKwUvBx+pxFhbJudtSCkD2QYxhzlcv9pXeBQ8I968y3J5spK3RB+nt6+s9639+IxsqSC7FLQ4dD2rDqeqw0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFvYRuj3KlScx+v4yZzUoOlPXKX+dQm6ludcGbiyz5/3J7S393
	civpQI9oosrL+Tmdrm8dSIk4N5hUWMyu5D5sqgHr1OkainROYzgFNd3jjDSbIYKso8aaIA==
X-Gm-Gg: AYBFou3f5Uiqm6g7BMRuglhRaXlmubKtveLr8YPjYwDbCjK3OQlOJu2dWNRbz7P3z1l
	3e3A8IyCQaMOYkfnbTGl/QqfmQo6GDFlA1xdl+B37iHQdull7n9YLyx1AyQOKWqZMHqiAgcYl5c
	0tuZf8kd8uNgn7g0swdUdw1xDVNBQtqn2XQMjBDoviunLK5ZfQutLeqpfQkzXV8vvVAwDvVT6E6
	LP+LT3nMVRQbqq/j+11B0t34mp+/ORZknmk3uEvDF57c6bLdsx3+jpt9GGaIpmoPDUuYlJypqsn
	4jqfZow0g/EpyqzCc3EPd3iuynctJtTvj/nAhtRzvjUNof0WUWXZr/Q0ia7P861POarL+CumHH4
	Z+Qfaj6BOn7wQhlM4srFBWcgbYh953kLQ+AoXd07C/mT0wV5+/kh/6pAA1dD5vhfWQpnl0G4RzX
	NvTHXJlSWHxQMVoAui0tbjoJ/OABRNRSag/4ySD3T7x+Szpx+5L24a4h70x6SlPRLTSdWjw8VY0
	nJvcjzb4c9PHGi1w9NyTN9nq+Fo9cRC5rk3oH82WDmK3jydvalP0ljc2SfqWvmK7LHiviK/NOAP
	jp/KWSQiCanwMH9F1X0ViV1yNIg/WB1Eqrmj+Sl0wJ3mO/LwDCwjEmdqn52fjJGB9fhZcE/lTIp
	Ww+h7sbxH6v4DjQ9q1E0guMpTcHD7vz7XZAFettB4Xt5DxJgHddRRlKm4vtACpTq0asr15zE8hK
	I0WuTpODXnluMc4m80pEs8qKEypGQxW8rfSWbqsr6h2g==
X-Received: by 2002:a05:701b:4589:b0:19b:39f4:88c9 with SMTP id a92af1059eb24-1ac5bbb487bmr10547378c88.10.1793528739980;
        Sun, 01 Nov 2026 02:25:39 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b106edc7f8sm6767163c88.9.2026.11.01.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:25:39 -0800 (PST)
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
Subject: [PATCH v4 2/3] iio: proximity: sx9324: keep the IRQ balanced across suspend and resume
Date: Sun,  1 Nov 2026 15:55:03 +0530
Message-ID: <20261101102518.22757-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101102518.22757-1-kapoorarnav43@gmail.com>
References: <20261101102518.22757-1-kapoorarnav43@gmail.com>
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

sx9324_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9324_resume() also
returns without enabling it on error.

Make the two mirror images: disable the interrupt as the last step of
suspend and enable it as the first step of resume, before anything can
fail. The driver works without an interrupt line, so skip both calls
when client->irq is 0, as sx_common already does.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 255a36976ac4..a76c49dda354 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1088,8 +1088,6 @@ static int sx9324_suspend(struct device *dev)
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
 	if (ret < 0)
@@ -1100,23 +1098,29 @@ static int sx9324_suspend(struct device *dev)
 
 
 	/* Disable all phases, send the device to sleep. */
-	return regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+	if (ret)
+		return ret;
+
+	/* Last, as resume isn't called if suspend fails. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9324_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 
-	scoped_guard(mutex, &data->mutex) {
-		int ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
-				       data->suspend_ctrl |
-				       SX9324_REG_GNRL_CTRL1_PAUSECTRL);
-		if (ret)
-			return ret;
-	}
+	if (data->client->irq)
+		enable_irq(data->client->irq);
 
-	enable_irq(data->client->irq);
-	return 0;
+	guard(mutex)(&data->mutex);
+
+	return regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
+			    data->suspend_ctrl |
+			    SX9324_REG_GNRL_CTRL1_PAUSECTRL);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
-- 
2.53.0

