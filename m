Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243517;
	b=qlqpKjvyvvE3bjiSv5xxsJbSZu975sO6PPAuT+0nTrfEwaGAb0ggoa/Afhl4Ufgkws2+
	 AfDMzGypQwCWD3JRS8vwr1Y/uLkDKqHvYokxs0KyidWmSWakYan8isb5uDpWa/xSZC+Tn
	 IpPa4M6kCrv7c0lJKWbjFDHQK/ZbmKp1+Nqu35Iuqh0zZZ4A13CtPtn6wJTNCIJ2X214q
	 xhaKJkiVmC2U05zsI9vk3vJm3Wcc8GcUCcAHN25Yi+iH/ETLJ+Oxbuleb0BSmvoxZjhEs
	 M2P+qiZoYV1cWhJ8As1Vl4jnZQAoF4NDV/yMxAGWilc77bOwqhKts6WY5UOliP/535w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mnYSdfRu+c56LQgrzrZ7H2MZoKEnk1Re1+H57vWpHJU=;
	b=dx+PBUKguUo8BDx7bFCdx1juM2z+3IuFtHg2FdZEYpe8LLzDEBPH/UukGAszpazV7ykN
	 yKB/RywdNYnh8QX3hoRmezZ3TqVVs589AN3JyAjaXuScv/N3Hv5wzaDRhrlyCgfy9QCz2
	 KmuNgSu1JKZPteAsvRW+9/cjeHB2Qa/BJ5ckBCnBRU1rnpDzT5E+/CQTXbbaSlDLUolAr
	 9pLiAxdn5TNXfCQM1+VUvteb7t8tJwJsynL4S/7zG9ztUl64QwfzVHfpyCiestxlnOSmo
	 1BhYe1IsO0Qs4yGngzxdKSx7EoTIl1mQ/L2LbXYlvGF15b8FG0ciQ1HG/l/BnsOAUcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JQ7SOrBJ;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA15606EEB6
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA15606EEB6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JQ7SOrBJ
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso801821a91.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243517; x=1794848317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mnYSdfRu+c56LQgrzrZ7H2MZoKEnk1Re1+H57vWpHJU=;
        b=JQ7SOrBJWjn5bTTRuIVBEckh51beyH3mtLx4icnHVXiOagftE+COtGGrPJqpeEshF3
         Uirlwz4+YJ5Luo4HtnsL5+YWC23ILkRt0QSEEdZhV8/p1+IYy9Yp1C19HrLAItxLS90D
         brYC+sbErOamxKsmakGbSqeYj4KZzwC8ORigViuGSCKo4IrNiLFuOVxVJD1oSNV4JVO1
         d6l9G35iYCqZ6dsz7Mv0+PTJE74v9N3CvtBebw8OpAxe3LTjWqBAKKK+cgAoW2yBzOl3
         w6F/sih23fW9e5X+4jhIgyZO7WSBOVgvsEEVV5qorFFvbswg3hJATS5EepqOyTm9HECv
         SjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243517; x=1794848317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mnYSdfRu+c56LQgrzrZ7H2MZoKEnk1Re1+H57vWpHJU=;
        b=MS259LS7hU4hJH6idO2wnbl/n0WVz8YnPA5svfxKRJQ2VaMXMcxvZM70icAkGHp8pG
         Umk5ejmLgq02R5wUwdb1XuTvF3CkQajRZMu+3nl6c46e8mQIYXl4J9zZe5OuQP5q09Ac
         RnpsQRuR6ApNMXLHhPXtuED6fU+ISB7ivzgvhgDUuFvB2wx9sgsQV2SSmVHlcqhy4gkJ
         aXAjiFo/9UcD6g8WdSyvky9eFKM1lxP6Hrd9/X0nLmcjTTS6pEMM1t5Rd2Au6q64Pxho
         NoEhbBiJrMm3dMmF1KqRC/ehYDqpyZGDrOYNTDQcCSlnEdTjEQD0oj+agp7Tz6Du6xQj
         sFJA==
X-Forwarded-Encrypted: i=1; AL+hErEIrBM0+EL8uwJmO9tCgYrVaP8JbJj6XjGDeEEynuS0bJ1XQhXvhHIm4fGWYoRaFozsYRoCa3dOULg=@vger.kernel.org
X-Gm-Message-State: APuU4Z82izIxoUmYr3L1YCD2EuNfEX/Tn3ubJwndutayxTuaPS0uhyTG
	6QrGqVkuKhbNwvCboHCEdJFN4W0TDqzswhNqBJwIzr8/S7JkUNO9WQ+q
X-Gm-Gg: AYBFou01EPzOGknSgUM/ih5eoyVvMX+qHLqcf2+2E6rq9aU5hgDzkK40WAzTsvD74HU
	aLRBGnumSi0YtWqac+Tj0rSWlPfZ4TsXuvO29HDBHTfZvI09nBD+G8fITPaE/Ucx5jHQw9jVoqk
	YTzstvPLJOv3AbzQJbuQWb6+njm7kmmgnyokXvBTJPrxH/q0lrPNGlA2hrMzmHk97L4ZLm6rbCM
	U+8IrT6CCYqNROrudmpcOVR8gRrYos4z3l0RYnVgv+n0Yxn3yGnT7w8KuNRV1MVM/26R0WCvgws
	GRuKh2O2S3oKRU8h/DsJ9iPMOy3g6+R0wmvCFmbmO+jsgRry3ItzL96lXkB+DVbXZYRJGqFaCT3
	mCqorhSWO5/mwyvxFza0wATTcDheQjZfETDNoW8iLQCI0ClorjadSSpiJOnqULGsN99FH5JqoCE
	3YZ/URsDRb9+1RZ89gDgaHfSk6tO6vNn7kE7jkwK6mShTq2edxmZxTMZrEVlFYHUdjy4ihA0lcw
	+Jk3U99+FwRp+wRgaAmrxBaxs+LMjdtORTxQCMr/IxqBNIA6n8YN9llD2MfFMUXMKTugbmcFHpD
	4+3WNee5VwH3rY35uTuO3BeydBDl0BekdDUSmRyZBGWXNSp50wUrSDQtaBROZ0K0dDAHkdGFwg+
	0gYfotz3g+JO2zVzUO2j+i7Hebw==
X-Received: by 2002:a17:90b:5101:b0:3a4:b0f3:6597 with SMTP id 98e67ed59e1d1-3b1669da216mr358991a91.0.1794243516607;
        Mon, 09 Nov 2026 08:58:36 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16779cf05sm138766a91.3.2026.11.09.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:58:35 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com
Subject: [PATCH v6 09/11] iio: adc: ti-ads1015: use managed runtime PM setup
Date: Mon,  9 Nov 2026 22:28:03 +0530
Message-Id: <20261109165805.31160-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165805.31160-1-architanant5@gmail.com>
References: <20261109165805.31160-1-architanant5@gmail.com>
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

Use devm_pm_runtime_set_active_enabled() to combine setting the device
active and enabling runtime PM.

Previously, probe explicitly called pm_runtime_set_active() followed by
devm_pm_runtime_enable(). The managed helper changes the teardown
semantics by associating runtime PM enablement with the device-managed
lifetime.

The runtime suspend and resume callbacks only update the conversion-mode
bits through regmap. They do not manipulate runtime-PM usage counts or
other shared resources such as regulators or clocks, so this change does
not introduce an additional runtime-PM reference or resource-balance
operation in this driver.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index a65da3742bec2..93a8318e950e2 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1064,12 +1064,9 @@ static int ads1015_probe(struct i2c_client *client)
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		return ret;
 	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	ret = devm_pm_runtime_enable(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
 
-- 
2.39.5

