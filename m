Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7084223323
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508821; cv=none; b=HFt49MlNJqGrOkSSovdCCHuCp9ryIO/ZPiscpGTWByEpwpCWVl1yfs26qtqm4rFCBP7yYd9h6y7HSGr4BDtxmNgL6MwC/1x0GjG5CvtO/fFTdseg90RLiOl7oRY4DUIc6dZJKFbwHMtg9CauNH/aoC59+7UHzVGoK0dO/fBmDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508821; c=relaxed/simple;
	bh=Txz7Wh2Jb+oCJjmAM7o0qTCk6qfXlfp7o/c+0pOhmJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKLjB8XM94Hx1MD6y/DddsQQv6UB3Gj2eVBt9Pe+kR3I/cgGVwbFVapS98lPWMqZj3nJpXLG4TxldcooX3G7xuMI/H/iKlw7+mfvdqLlGYkTrVMiGRyoPXDS+tRkgoSnQQ3KZvC6uPnU/wdQjD99WmSoMFO4/+eTaiZwh5Dh/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDAgVptg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDAgVptg"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd77786e97so324103685a.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508819; x=1774113619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eQgV0GJfcBirHFQIwxleynpLMsruw2WGsHUL1t52B0=;
        b=QDAgVptgnXoCi32pF0PgHRBdfl9VXO3BewNKjhHLa6rhDbvyTA47NRqDHpTNy+wftJ
         05h+t3KUS3zAKK93ZXboQ28PDY5toqFKdaZwmq5Yp4yMq+aVXeG/bS9slmtGOJUViIy3
         r0KDpG1xutkZUQCMBu5J9PmOtqMVvIfwEBWXSKsGYqmwXvmsoUrz8CsXcUEef6YRiKau
         3XogEoUAYz29LkkgpJ0kPSZSIzVjM5sikeFXkZ3UDFug/99lYc2YBFMo+sPXnzbCc/2d
         V64iO/1CDAfTNtlaEy4Vty+r6TJHdDOB4JfBa/0AKql+WeKZrtgVbapSwx65oX/XNgb6
         s0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508819; x=1774113619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4eQgV0GJfcBirHFQIwxleynpLMsruw2WGsHUL1t52B0=;
        b=Rjt0YzZpHsL3IVWdBocjzEEjl0Kwa6FDKXbFhT117EP6GfmNBamSsTci1CCQ4OZ2Mi
         hq/ra+tNXl65OVBa9WDKG3OJUHoo83CP5QReoqoSqRrpxpLc5RnbVXBj96wwzSHloiWK
         aV7wv0V3bIhRFRq3Uo5edizmnGVoLvTWw4g83WkPHLDwVI/V8kbCwBReDnBFUbrLinbJ
         vPByLOdj2p4g97J83SCHsOeGcviyHIXs/haSa906AOxEvsgXfNhObIucjGd+icnUy/DC
         vAL04XoYoEXpl+q6zTMLUKqh84hAbSO/gWNePSxFtZR/aTN3NCvp5qgNz/DWNwJNiPna
         VOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXvjQtWMYpU04S5MV5nJ1gLXxD+unggrBpaCP0GOomqf7fuE+fqLBjZZwPV1l4Qa0qQp16GArVj88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVKPRTH/ISensKwtFic96Wqp9S1MvmGlg6XesueqXZ92urI5i
	9keNDWID+Pyms8WCEvngrYFmP80M55ZPvJff5668P3RaOaiufECN4wt+
X-Gm-Gg: ATEYQzwYs4zdDUPBiBaOVWmXSNMCZi2MN64nIeE4ErnUk5lXvxAnZRmKOqJvTqKYADJ
	XaxnQzMyi6qJKgNZIzyLgWFTJd3S7rzd2S4Z6LxjnzmM0VhO+CVCer29gfBGS4p+x3NPsCA5lD0
	Nnb5HJkd3GWGX1DvlvpeMyHc5yGYEiECN9bECpylUD4egaqw5oz/0pBU8hRqPx/g4EWCW8ckqmT
	72WZKk22xEDrbqDEeqeYPF/4jHTFTme7jFY5wkub5oM9IVm4S7i3NR98GA+vqDb0E72N8Dh+kXu
	7NvB+Thi0qcwyYcN+J3fU63OiFhg3PvNygqB/SJCjSVH2wZAZl90muR/wtTFpFilGVgRzwNtSmA
	JkQciCpy5/2uzD2yhrnyf/qn50orMixWpaz8tu+FB2Nsseaun7Mowde7aF6d7QmM3werN1uroyM
	6xujAjlC5GRsGnUKCD9ITjL9xrTahXBw7htUjJCg4Byfr34Q0=
X-Received: by 2002:a05:620a:4502:b0:8c6:b425:4779 with SMTP id af79cd13be357-8cdb5a05fe2mr994724985a.7.1773508818720;
        Sat, 14 Mar 2026 10:20:18 -0700 (PDT)
Received: from localhost.localdomain ([142.188.159.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21540f5sm802599385a.45.2026.03.14.10.20.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Mar 2026 10:20:18 -0700 (PDT)
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
Subject: [PATCH v2] iio: frequency: adf4350: replace loop with fls_long()
Date: Sat, 14 Mar 2026 13:20:06 -0400
Message-ID: <20260314172006.69744-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260311020115.56321-1-neelb2403@gmail.com>
References: <20260311020115.56321-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the TODO in adf4350_set_freq() by replacing the iterative
power-of-2 shift loop with a constant-time bitwise calculation.

By comparing the highest set bits of the target constant and freq
using fls_long(), we can calculate the required RF divider selection
in a single step without relying on expensive 64-bit division.

This ensures freq is properly shifted to meet or exceed the minimum
VCO frequency.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
Changes in v2:
  - Use fls_long() instead of order_base_2(DIV_ROUND_UP_ULL()) to avoid
    unnecessary 64-bit division (Andy Shevchenko)
  - Add correction check for mantissa edge case
  - Adjust whitespace per review feedback

 drivers/iio/frequency/adf4350.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index ed1741165f55..2183deec179d 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/gcd.h>
 #include <linux/gpio/consumer.h>
+#include <linux/bitops.h>
 #include <asm/div64.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
@@ -151,17 +152,14 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 
 	st->r4_rf_div_sel = 0;
 
-	/*
-	 * !\TODO: The below computation is making sure we get a power of 2
-	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
-	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
-	 * and friends.
-	 */
-	while (freq < ADF4350_MIN_VCO_FREQ) {
-		freq <<= 1;
-		st->r4_rf_div_sel++;
+	if (freq < ADF4350_MIN_VCO_FREQ) {
+		st->r4_rf_div_sel = fls_long(ADF4350_MIN_VCO_FREQ - 1) - fls_long(freq);
+		if ((freq << st->r4_rf_div_sel) < ADF4350_MIN_VCO_FREQ)
+			st->r4_rf_div_sel++;
 	}
 
+	freq <<= st->r4_rf_div_sel;
+
 	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
 		prescaler = ADF4350_REG1_PRESCALER;
 		mdiv = 75;
-- 
2.44.0

