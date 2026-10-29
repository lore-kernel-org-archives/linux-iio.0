Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311602;
	b=qLq1DqfqRcJhxGOx7bp4sefwWdL+GfoNoOA4v+AMjsRI3pKs7ABJM9BSQJQ5ROzCBuOi
	 A/jStUu8/jpRMvBqZ0y69uNh4sqrAnjIkSO+jfSXt1HXXXpjqPH+TSWO6FXyHQpkYqFLv
	 rbA5bCBxApvQ0UrgNI00ltBiUBLxaiCsSGLtgl1b4fP0EP9NzF4vYj4pEt9ZofP8DKLq0
	 znFPwtwCxqAbwcpxVZElvHrSu/d6BA9fcBSpCemdoGJIBRpg6vOLI30ttWCwSdDehsG5r
	 BLRbf+1Lykdh8FhQ1CCfxZwR2IBAiORn8e6P/YKjcUT6mOIEeApQMvBXrwwDzKX/05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mSakZyK9vHjxdS1xBbxtvkjfj3Uy7nFotSNsY/U9cyo=;
	b=E17l4mLLCsmMwE4ze7qgPDwIDMWSJqWqkpdx3MAVTTP0wsXg3uSIczvNtgW3eGSOCu4B
	 tEkcjSXpRzcCiYsdjEg3cndHgM154VprGoifAkEQFya3/3j9ccuz7PttwodbeW5+Ihqb+
	 IJtaALuoU1M/bVX4DH4KzyUh/STDfq1mYWRrq5vUT/e3jb6OkVA/HOMnQy+jtTldRfp9X
	 Qk2EUCRBct0B7bYoaO93ooYAMJMBdiUsjnaWDsU3CrmJcvFZ8lzmHAM6f0OO9yun146zV
	 5KJoacDuhmLxaaoOKLFrbKW0CzNOgrHoLDM57KhJ8wf/Wej07HJPRICDekp13Mn88NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkybjMzS;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA497606A329
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 22:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA497606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkybjMzS
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so124240e87.3
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311600; x=1793916400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSakZyK9vHjxdS1xBbxtvkjfj3Uy7nFotSNsY/U9cyo=;
        b=QkybjMzS6x6rdyXiz+OUh53nQ9a2EPobPDtDNswmKhBrViCOiEOdQwxjTq3bsr3VZJ
         MiJxpffem/ETRRv5M7/MMQGcICg1L1faDvWBtd+aLYvECIZv0/xh13sx1gSARf24DKXG
         zg86l3qyrOv7DaArYbgWS9HA7le679BN7QEgLGyukeiauABmoi0MypAE8QcB399v43zO
         rjE+ZCrR0fEU9KX7BpNdBrMEdAHC7d9Kb1oSIKNQe3b9atnIXo7cmq5YXZIITBwant+S
         0n8iprSiqjDmySim5h1CHVR0DUxs6DCm8i7GaSB8BYydEVNrye7KtHJHkbo2TVPdQnuq
         v59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311600; x=1793916400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mSakZyK9vHjxdS1xBbxtvkjfj3Uy7nFotSNsY/U9cyo=;
        b=FvdEKV+uXN1Jl59lSE1/wLL/hUaSbxeN/XgsLgUujomBPzAd6iYR0DfhkDGf10vlHR
         anCb0xIlrUNJI979bRtHGrlTIXhPLgf9gT+f04oxQp82OJMwM+gg+stTcQmY3cEcujl2
         bP06RUDRFD7noo7ypr5kf06qCzs4/RziJV/sePQKLx6TGqs253lh4fL/3fe5xatyG+iG
         l1/EorW3lpQ9Xk/DhfzTItDVDXMTYyPfT0eopnshgz/UJ0uSxQjBPeFTNTlxADDKYff8
         aCl64OZw23WQLE36GFrjqAkjbPoEsHO2kkOe/b8ummISyO87gLUVHE14Bke2Mm94+9hG
         bUlA==
X-Gm-Message-State: AFq9FYJQrRa0xnSfbc+SQboY/4YAJxhLBBNLAt3AyumbAnD48F3bIYwq
	mPvG/0MGOkNjkrwgxsWGoOCuGSK7c2jDI+4A/iWFRj22mTos/LDmadli
X-Gm-Gg: AYBFou2c4tGancMNrntgJoMIPJOA3SmBaDEnWXHGKgT6fY1BFHPHOJkSkAJpP+W13ku
	xTASndt2etBwfLtbpgzw3G7EnU822nwM2EJt9vt1wrvmrD2u6aL+4Xklo/0k3iwjvLPdHe/nF8I
	HdRTWdFn3J4TYw6funt+IAYyqYyujjcVvuprJQTowkAzJRZtiyXlkNZKpdVW89+t+3+y2Opgh0M
	wdg+KV3/WzukRFXjBQ7V5bhWkNHRUYhDf8BlBm1ixMdUfCB1iZpKvIxJo/l9AQaBEXo9c9+udRS
	kAqrG4fRPVHbbvF8BdDDszIlV0SiW1od9D33P37oR0K9erXsgTxx88sNbUHSyPehFoRfbDpKqoP
	QZybtgil7dj++3DhfPfIcXIbRuFYatL0ENYfK1E+TBiK8rXSs7EhZ3kFBK9hYXZzbTuCmhJZKYx
	ZohxjYRGrfj6LiOndLXTh5DZgz8tURjiATNX8xF2AeTyPUNFlWfVkct/DlckFvCNloud16F5BSq
	d8utPSsdadu0Y3sfQjWcgZ6yQzWZLPu1OjErYYIkZM5FH9MP5h8DQfJq6pelO5hZhoUYda3CqsT
	4qQhgw4ZmY3m021qY7x/4B2C1gVQRRIPP7tYtAM5y2RNuQXSwHC7iQmk9ESWBFWoZegiU7F7Djx
	hp+vyvES3b0Ok/ccYcVA8XQTlT4IotlZLU+u/rQ==
X-Received: by 2002:a05:6512:31cf:b0:5bf:b96b:bce6 with SMTP id 2adb3069b0e04-5bfd94ccb81mr96046e87.0.1793311600012;
        Thu, 29 Oct 2026 15:06:40 -0700 (PDT)
Received: from yantra.. (nekmmqtmquaao4qwdoc-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:6842:e549:8c95:f73c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfd9c507adsm9605e87.65.2026.10.29.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:06:38 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 1/3] iio: pressure: dps310: reject a zero rate or oversampling ratio
Date: Fri, 30 Oct 2026 00:06:33 +0200
Message-ID: <20261029220635.18816-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029220635.18816-1-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
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

The rate and ratio setters accept 0, which also covers 0.5. ilog2(0)
gives -1, which masked into the register is 128 Hz or the reserved
precision 0b1111. The latter makes every pressure read fail with
-ERANGE and temperature read 974 degrees C.

Reject values below 1.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

 drivers/iio/pressure/dps310.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 71053f4463e5..b6aa5dbe2bcd 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -410,7 +410,7 @@ static int dps310_set_pres_precision(struct dps310_data *data, int val)
 	int rc;
 	u8 shift_en;
 
-	if (val < 0 || val > 128)
+	if (val < 1 || val > 128)
 		return -EINVAL;
 
 	shift_en = val >= 16 ? DPS310_PRS_SHIFT_EN : 0;
@@ -433,7 +433,7 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 	int rc;
 	u8 shift_en;
 
-	if (val < 0 || val > 128)
+	if (val < 1 || val > 128)
 		return -EINVAL;
 
 	shift_en = val >= 16 ? DPS310_TMP_SHIFT_EN : 0;
@@ -455,7 +455,7 @@ static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
 {
 	u8 val;
 
-	if (freq < 0 || freq > 128)
+	if (freq < 1 || freq > 128)
 		return -EINVAL;
 
 	val = ilog2(freq) << 4;
@@ -469,7 +469,7 @@ static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
 {
 	u8 val;
 
-	if (freq < 0 || freq > 128)
+	if (freq < 1 || freq > 128)
 		return -EINVAL;
 
 	val = ilog2(freq) << 4;
-- 
2.43.0

