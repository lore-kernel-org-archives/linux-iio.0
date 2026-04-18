Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262EB39659C
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523505; cv=none; b=SfoA4DaTud23zA+CIVML2fnlY8QvqWQckQz0LBI8Y0Bm6QXxipGVaLIJp884mkwwYPjLVlrg/QopdJ2KfQKnSqOG4hzJ8CgCLGziK0oLWTnE7VkJhBG7SH/IlNak0jJ7agJFissjAtePGvQ1j/ud6AeOWo+qwRwZSqq7ozQRmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523505; c=relaxed/simple;
	bh=Skz/JMc5l0S8y4wn56JYPZZCHEq8Mh3SCZ+OurWUs2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWl4nuN0btD23e0qmT+fZGT+RzpKxL2tsH2HQsk29Eh6ISlTR4bSV86XzPxFnLZ/C/bCbYIwefQ7knc3Ec0kVHqgprkyBHDttUwe+Koo5TF2B0SBJL6p3+cquhO3UIfgGwQy7dM4C430drQKTHJ2b7eRmFN5ngeVewVOxUUNtjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvvUcnSI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvvUcnSI"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d7670826bso222481f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776523502; x=1777128302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQo5VyIpHKP7FuwA0nYLcbJmjyB1U1LZ5Y6n7Oa619s=;
        b=VvvUcnSInYONtZejp03UJVG3HbZRAXk1zN/KB8nRrtUyqlJx0tZuqVX8EeLbBMA96R
         9FBHpkDCiYOm2Kcg2PArb6S8R3VB2xL3+CXxL6HSbHDZWgy2hO9NeOJEPSVYPfJeVpB7
         n5dHDOo+vDjMtXhd8pnyzJLbCSfNeBi4DLSLdq2ro7xKD8KXFwKqlFcQLIuqG8XWlZ6B
         VZSg2aJ2OOlXlkamQDvVshxOfFdNTnw2PwOSCNSO+BLdwdaeykQRI4KTOj/vAGTOeDje
         lO3FkgY6+jlkEfSKeYlZZaVwPc5iDVZo2dfKchRUNKVU0PyUIWxGcr+RXISlB+ZnwLuZ
         ZZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776523502; x=1777128302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQo5VyIpHKP7FuwA0nYLcbJmjyB1U1LZ5Y6n7Oa619s=;
        b=VSevF26MoAsnNYBVCGLtsevuwzYKWEeBaLDKQlFYgnrZ4ddePlpo2VBbEB4Qp5/eyU
         pGEXteRXEcFgLx7NxfNViMgcyCNJZkU6m0tKMJxAY5l9Uf+2RE3O0BBFnZmxEw/Si2su
         hZ73vbUzPRH33OqHACG37zcOEFam4NhLZecDcb3HWXB+Nb+Vhqzqw6vLI9Y4yIXRwC+t
         LZ4s63dDCAHXImjuB2Xn5XT480nzCyrlNjhoG6+OlkpTpC7AAHWXvIa5vqkNulCBfxcN
         hOqSRhK8kTbJUQ3VmyNHsy4SODhC9qnfoq4YsHTwuYtZFVJR9v6CA4Rr7BQVSIn4pUMR
         yh5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+kq6FLo2ZmoZDZE4OBReEJpcQylvxKoi4r/qjJPeGoLhYE4gdoRxprIZsUAN6MQi9kF1kdcQAokRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmV7fGJGc62gKgZFlNWqb1HFTl1MpIVJLdQcAmZnzNPurXc0x
	d4HcNjPAB+PY7wRoSdHUw1yq3dKnPo4re0Ld2T6c8ZeiYoe8B593ghgH
X-Gm-Gg: AeBDietdrxO7GsVyZ4nga73PqUVmn6vhkPbgSgM7miJeqzwCmvEqKGCaEWjS0vpQGsP
	fJEw1oyFxp+GkRnT+YDVrqwrb6HsGyxZNVZ4/PbMVGIvLZbpw85r1W2CMH+bq9BJfoNEzo8qgfI
	Avqa+jMoSFf2zaJ8f30AjY3B2fj6M9ooB/kY5XxTNwIvHx323XuK69cTmMT/irNDP+JcE7MlUrM
	LmY2H9vVv7T4sbSyyvQah/zKQxyvjLseBP/XiEHiM75QDXaXhMK6IfglfGG2kdKCalmM+vvkrrE
	qE9NZ4QGrCgGDegFWhMPvDw9TSKkwb4pzEfttPQsic11vjeVteIuG4ag+yC9XcuWYPavACpu1l7
	3TW074aGDUn8JSo3TGcLLDLrZPWEDz4XoJhHYWS6UDkDaYuymwsXUgNK25I3P/Zo9SpyUfVNud/
	aZFe5AQl3IRZMJ3y0fU7dOvaPLK7MrPbVPFZcqiRKj4GVsMhZa8fE6h0iS3yF8Dx6ziuVJdaip5
	btFvGkBuwXgD0w3DmcyprtUPKM8fSSAAD7sFjetSNB2HCShtRFfW3FVHWnGGi0=
X-Received: by 2002:a05:600c:5252:b0:487:575:5e3 with SMTP id 5b1f17b1804b1-488fb78bfe0mr58232135e9.5.1776523502253;
        Sat, 18 Apr 2026 07:45:02 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f93dsm205105925e9.3.2026.04.18.07.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:45:01 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ti-ads7924: Use guard(mutex) for locking
Date: Sat, 18 Apr 2026 18:44:32 +0400
Message-ID: <20260418144431.138815-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
simplify locking and make cleanup automatic when the lock goes out
of scope.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ti-ads7924.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index bbcc4fc22b6e..21bd5cb973f4 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
@@ -226,14 +227,13 @@ static int ads7924_read_raw(struct iio_dev *indio_dev,
 	struct ads7924_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&data->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->lock);
 		ret = ads7924_get_adc_result(data, chan, val);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
-
 		return IIO_VAL_INT;
+		}
 	case IIO_CHAN_INFO_SCALE:
 		vref_uv = regulator_get_voltage(data->vref_reg);
 		if (vref_uv < 0)
-- 
2.52.0

