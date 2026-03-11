Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5128466C
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194487; cv=none; b=EnUsWBmYCiAa3f+nMs/UGcIchOC9coyFdKUz670TgiX1bxjNhzrnuwFUG89HKBL/k4qESQtqf0Vjp/Y2H2wUFxB7C/oxdQeWmy+gRefKO3wQOlzJatZzmjtHHAOJNKzXXURSMkdDNmwRpvDcSt7BAu0aoFZCx42MUki3BagZ7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194487; c=relaxed/simple;
	bh=QY6PxO64XoZhcth5ov6YZyAvrX6JOQB86Oj9F4LIfgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTwCWzMRDAVRJlHqZiKWoZOtOI6DdElB+CaiWsVqmSH8N867dp4ZdvKJqrdXkyvvrPDeAjos+I1GqrdGBP1Cb1unu6sYuddrXLiTciql+qmt/kRjVcK4bFuy6XkaBUEU9AbPAd81cHmhjXIvqcjZeCDmq0hWIHKy/2ILaiGB5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX920Bpz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX920Bpz"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb40149037so1453290685a.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 19:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773194485; x=1773799285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7IvZ9ggFoFIJ/kaG1UJfehIdidvgncjVHyDF1WxJK20=;
        b=RX920Bpz/I+AvmdoIJ8pTx+v1vxOxtkNAPYbqJ9/CfWPH9KAAh49HjKUxGRmYrHTb2
         9u45RkA/V7ycw4Ynq39MQVh52otNENnl/25gqdQR2TZRSReiynaim3CkXc85DziEWbVH
         sU1JtFYfEs+R/OgwJgFnd+ebmFuEbU4nTIoa40Xg9DlqanPpcfNG1GiLSiu4lNauL5B2
         Dk1pjsDvco7NT72k5G8WOHVDrIZt+XLRrykyzX9lOsoPnxOdqAV9rUOOU8QHPZayXiCM
         lTr+3B3n+YqmXU7/r02fik6SUaaKKhEw6o+9q9wEc5/AtRqvzyl3LYQjTbRobAcKJd1q
         +iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194485; x=1773799285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IvZ9ggFoFIJ/kaG1UJfehIdidvgncjVHyDF1WxJK20=;
        b=up1tOdQzVdVSJS8kTxo7Fj+7ghhbiOuqoUbOl3VA6rAlKFRYCr9R/iMwoCATRRFOF2
         ivcjZ0C2oXg4LdVnNDOgzNr0C8puwZZLhgdq+XCKHk7Dzf6H7tMDEX17anOxvLDSxzhc
         gpWfLPLiH+xKQb37y28aPqJSaD4f0xEurYFUY64Kq9+fCdIGCBPaFTdUDbTFTSL2JLfV
         LKPE44ksfVSUk+U8FLvJU1oE/GbU3p9LM3luaulPu4nhR+e5akvQfLp3zZnBShk4v57w
         dr9KJ55huakTXb1h5WJT4hoiB2N+u8MRcNy371s4O6losjEWXnXXFszK2Xc0K4Tz6iS1
         mknA==
X-Forwarded-Encrypted: i=1; AJvYcCUWEqLkB+2vtc3cr5a0vB/AYPLLe4MfqCe9h74isi1/5uQxtLN2WjJ6dsKXGIe/o73wXNC/G9QodxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlA8MTKpDwhuqcoUNhhzrof3RQtHwi4n98eAw+TbnjKhaqgYrS
	xVVbB+waLdjfzjzOlCqpTiejxvoPDuR2kF4LcxL4LoVMu0ldkax1ifXI
X-Gm-Gg: ATEYQzxq8909+c50G5KmWrUZ4otKugTTphMuaYQrMlXvzRLT86ArTVj9rcmjXVnoVyX
	xPeH+i+CfyLSXECnIEyEM8GoYYQ1SJifhYfp7tBotFagpIKBGplcBB0E0O94DBOVYbMFhkTIcZZ
	YkdkKSVI32a1hSnlAz23MmEwYzLKblMAfyfKb0ul7OtkhJBlFrTBhNIWNO0ddfJcRJnXNyq4fjU
	pzZ2O0Ldp2GpMgcSEkRC6Vf2iPHbl+KBKNGjSGuQhGtt4IJH7iF0tA7xqSZHokMiYaJjSMuKhed
	Gw6hecMEU0bsav3k+qDAINknEc4ltbyvRZ8xk/gSSD54PPcWQtBy74QAyWbZY56rM1iD3u8sMl1
	O19gTBpbirkM1b7xkHHYyXzg6uYeFzMKhFaBT84stco0CK2L6quuAexONSjDodYay8DumSXfjND
	ZVu4kimcYOoJH5Bhw0cxEsMCLj6VNXifb+A2i68k6yqw==
X-Received: by 2002:a05:620a:4481:b0:8cd:7685:760c with SMTP id af79cd13be357-8cda19b163bmr129934385a.13.1773194484684;
        Tue, 10 Mar 2026 19:01:24 -0700 (PDT)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fbcd2esm46308185a.5.2026.03.10.19.01.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 19:01:24 -0700 (PDT)
From: Neel Bullywon <neelb2403@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH] iio: frequency: adf4350: replace loop with order_base_2()
Date: Tue, 10 Mar 2026 22:01:15 -0400
Message-ID: <20260311020115.56321-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the TODO in adf4350_set_freq() by replacing the iterative
power-of-2 shift loop with the standard order_base_2() macro.

By utilizing DIV_ROUND_UP_ULL(), we
can calculate the required RF divider selection in a single step.

This ensures freq is properly shifted to meet or exceed the minimum
VCO frequency.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/frequency/adf4350.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index ed1741165f55..e07be6d5e67e 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -17,6 +17,8 @@
 #include <linux/err.h>
 #include <linux/gcd.h>
 #include <linux/gpio/consumer.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
 #include <asm/div64.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
@@ -149,18 +151,12 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 	if (freq > ADF4350_MAX_OUT_FREQ || freq < st->min_out_freq)
 		return -EINVAL;
 
-	st->r4_rf_div_sel = 0;
-
 	/*
-	 * !\TODO: The below computation is making sure we get a power of 2
-	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
-	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
-	 * and friends.
+	 * Calculate the required RF divider selection (power of 2 shift)
+	 * to ensure the VCO frequency is >= ADF4350_MIN_VCO_FREQ.
 	 */
-	while (freq < ADF4350_MIN_VCO_FREQ) {
-		freq <<= 1;
-		st->r4_rf_div_sel++;
-	}
+	st->r4_rf_div_sel = order_base_2(DIV_ROUND_UP_ULL(ADF4350_MIN_VCO_FREQ, freq));
+	freq <<= st->r4_rf_div_sel;
 
 	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
 		prescaler = ADF4350_REG1_PRESCALER;
-- 
2.44.0

