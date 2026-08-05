Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5831E85E
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933196; cv=none; b=eXZmWY55cFt9/2Jik/KL0nutgeV+HI84ZQpFdRiL/Rpz4QhQmCtrZ5FX3B1qB66kdFH2LR9Af6IjOEkfBDsQIrWmW9FTVppFM+ACCMUCCttnOGB0BgDDMEVoaUPwhP88duyR+3Tsq0271+7yLOU46Wx0gZuJuHpo2TgOKfF08Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933196; c=relaxed/simple;
	bh=7xB8g3Iq2b2YwoKXH+QIeqhcQ8+NE37RjeD5rBHRwks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tt1+NNKLyooWGOJH7ZZAvUQ/0lkk/hqaK5ujOWIobrUCHyC2Z4u9NUSK83egFnot+xamO3XLbAzxGX1VCYbcmEo1Z80IEJxNWVaqd1aMIrcgtDKzJO5m9+TAu2OvPAd1w5EDLe1quK0JgAJ0pgH/ggmTl/dJrMru2u9R85Kgajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJRGVlVD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJRGVlVD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47df6a5655aso123352f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785933193; x=1786537993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=87GixfRmkz4UiL/TsgmQVGo0Qsy/9UQMNwfCm4Wh3ko=;
        b=VJRGVlVD55Pa0VMkaSF5NDK3EDBrq4aJdOtxI4ndgl+Da3uDMNvbHmelf1fxBRm2Bz
         qFUSkNPSBMNOBNz3deV2YR3Gwxf/njFcI1HqXNY3pDKI/e0WHljMSJd0FUrdWtLkaCD+
         xb5DeVYrVX5jpNTHVVrP4H9C4+u9kqNQTfqK/KZfgFx2pd7ER1tr/TLaTy+C2D1yK5j4
         /eO5BUBcAQSl+SJs8ycpSgLEsHVUsHxugX7MfCe4ib59EDarh6syu5FO/gHm97N6cP8G
         HdORj5JmY5RjiQLnad5+bNfp/DPUDwKRmZKvU3SaYQhd+CI1TT9l5ejXrxmYmKd92OxC
         WrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785933193; x=1786537993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87GixfRmkz4UiL/TsgmQVGo0Qsy/9UQMNwfCm4Wh3ko=;
        b=Vz+Gr2OPrQUmp9H+2Wor6kD2i8zoeslk/ccVi3h2R7VbluqdbO2sHphmRtJFGg3rdv
         iaWc4ikzARnLpOY530xavQax7JznLiWE6DsmJZtS6EvzbCbCUgdIkm2KVtmwnYYFWEhG
         uPzU7R0T+Lx6AeS6nkV4iP7DKXbKQB6XcBoWUFPTijzFF9Cy09R9H0r84+QrRWLhagIk
         9jUW2GDKbJyJyHGe2lmMAIuBr3bupjb6Sp9sGa5+7gDQE16U7NE75VVWVq5l224jo+08
         mqyK4azxe2myl9eLYAXrrhWghHs8QR2olXffqEVZTFaxIDbU9f8mf/pCYqeMiL8zzLea
         Q7mw==
X-Forwarded-Encrypted: i=1; AHgh+RrO5c9vKEc5LzV2xqIdKLbqIYxDblJND56uEVhA6uEpsP2UmT0+PprYrydIn1Ix9GDEG0tlPvIBwMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rRIG1349GRZWOTBDCyAaHdAeQV/Bxe0X7BJ1oEAYe6F7ojpC
	UxH/rTwUTFMWzLtc9LkQWTb1A8s6BiKu5MnHrqUm781DYS+t0aGbOZu9
X-Gm-Gg: AR+sD104g6Sc8guAx46CqIvHNEDOuAMq9KdijwTr1qvuwv8ng12UNZ3OAiobxC19dOk
	43HilnM3BnHQ9XuWn9k8w6D3kIb2WDmnakqNcRePF6TKmPNb3MVJiq1vkEoeckVlLVROsf+u2ub
	twbWz8GPeGK6yC/zlIbEKj4c58UfeWM4Ieo6rJQpT6SQot+iwa3Qx6/x3K5tQ7o7cVQarKWZZ1N
	ZquKztd8yuT88R+RNLg9mdy9oKt1aeVYeqDjnqeG67hbffGn8eXFrR4zFFyfN5nARNVQkcoE8Kw
	q6utQEDAA5YsJWArsDpg0s3P/GKYz+V3jNFwC+9+7Aqpo6pT26FP+njPSvsu3L176qz4vOr9kDL
	WenhRwTjF9bDJLUrxBpXiJ2xGvEUNZe5V5dfXKNHv5YUh+afn9kl+NSf8VYE8livVlTyWEK28KC
	nKGr5X40CswADYHE3jM8/z7V5axQe9kBRxuyenn7bTIR2zBxOvt2c26gdNa8pfy59BMQVPZvM9c
	5FsPHXbClAi8ePx+2/YgRSGZSq9aEvT3M54UaKzKUJheaAN6E/+xLTh153wmnKhmCqBLArvGUit
	VbJCt4q8BQLvtw==
X-Received: by 2002:a05:600c:3b20:b0:492:4a7a:e415 with SMTP id 5b1f17b1804b1-4994e7c898bmr38003015e9.2.1785933192303;
        Wed, 05 Aug 2026 05:33:12 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e03589asm75983315e9.9.2026.08.05.05.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:33:11 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: twl4030-madc: read MADC_CTRL1 from the correct module
Date: Wed,  5 Aug 2026 16:31:59 +0400
Message-ID: <20260805123201.219547-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>

twl4030_madc_set_power() does a read-modify-write on MADC_CTRL1 but
reads it from TWL_MODULE_MAIN_CHARGE while writing it back to
TWL4030_MODULE_MADC.

Fix it by reading MADC_CTRL1 from TWL4030_MODULE_MADC
so the read-modify-write operates on the register's actual
contents.

Fixes: f99c1d4f94f9 ("mfd: Add twl4030 madc driver")
Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
---
 drivers/iio/adc/twl4030-madc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 0ee7e16b5e24..1156e68ebd91 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -718,7 +718,7 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
 	u8 regval;
 	int ret;
 
-	ret = twl_i2c_read_u8(TWL_MODULE_MAIN_CHARGE,
+	ret = twl_i2c_read_u8(TWL4030_MODULE_MADC,
 			      &regval, TWL4030_MADC_CTRL1);
 	if (ret) {
 		dev_err(madc->dev, "unable to read madc ctrl1 reg 0x%X\n",
-- 
2.52.0

