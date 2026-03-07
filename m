Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571534FF70
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772884195; cv=none; b=gp1moJk+JIe9u1aW8MYRL4OWRtTPEAIWkmE/qJQ93dtx3asixjU9jPI50ctlIfsdDvHJUSVcodcbvqqJxTdh5WPClgSklvCr7yeBkal/Hkt721Nxdqjojw9z4mGhJeHOEq2PIgnRCfILepxU/dGkB9eJ3GR/kvhhge0mDbgCzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772884195; c=relaxed/simple;
	bh=Y6VH0Y0ioHfBudJ9lmPqZlTyuIHbsv08K7tlKnXbmUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlfIE3CATASTwbm67wObnUUzUXv+gG3yVosVSk9kmZR7u9GnwwDwkViXwat1IXBQFqZnjhtXVzhrTWWVEcuktDPpa5b6JBYd+dnV6gcUqVTDxoyrKDpqqNXSOiuNYY2ATMZDwmxVnU3TX2ZjOPcxPft0fRrZQ60+0KpPviYEqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk/4lRdy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk/4lRdy"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7381c4345cso1481838a12.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 03:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772884194; x=1773488994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMYrkrREFEqpYEwdcfjCkDC0fr9w3B26gaPmUI1pG/Y=;
        b=Jk/4lRdyTTuWv9YTp9+Fh5+SjLPIwvs5PljHE2A1X/DuubAs7HcUy/HKLStZCBNpit
         fDrUWjkaacwh8k6UA4qRCcqKQM3KiFeX+c6m976hCrX3zUMTSoRH7vS/CCYjC03FnKP3
         gZGG2rNWLGV6w+u/JLqI1bkEyZ+jXN9iVTCE6BrlBT/PSSsIJXLlDeiCxA4+WyU6jiGR
         cau+MFxc2xBemGkKbC7voB3JYTkJB/zQaipoKpqJ5nelZmWOMkxEarhx6hZv1DY6OL2M
         9fra6eT9ZgbJRzOfM+3yx6e6H8ZYrohyS+l4cTqfTwGZZ88NAReXLICm3Ecw6+y8Z3d+
         w5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772884194; x=1773488994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QMYrkrREFEqpYEwdcfjCkDC0fr9w3B26gaPmUI1pG/Y=;
        b=K50vFyrwjBJECBwfT/G5wPMRBLQkafR31RRfiWiG+fUeascaKvGu6d8aL6DHQyLi08
         qbs90bMqUbks1K7WlAPb7WpUibf+BOHK2E6BbiTu7RfeSKEBP2GbByPbwUa8gOhd1Tbk
         p6QiV6tbyeA1hhbZ+p/7ECZdxcuYaAKP/oBvwKWFas8mjqMI+/N7ycSsbneWCCvrHdV7
         I45EOE5itStrigsFc3n1Xo2rtGlo84zwdMGq4gSxlmYpEwohdORSXtghqlHIrnkOHOeP
         9Aw/OcYb2K7ovxpgqwDzlkLR6sPZt/kClCo8YRU5B6MGNCtcBMHt16QhCIFjht6vJsd/
         0+sw==
X-Gm-Message-State: AOJu0Yxne9zdnlFEyKIyYFlnHytsQgnQmHOqMuCiFA+P4Fm5u9RBApv0
	qlfvTpxIK2IHouU6qPpbui/FruyH19r/5u/gJ6QLjSGEYq2w9RnQ8BcJ
X-Gm-Gg: ATEYQzweosLH1qdTfSuM/aKyfHBMQHRqT/J7AY3SldHFHC+Gilgbt0XrQhWUBi6GZc1
	ZW8Odvkp9UhHCN2Bq12Y0eQiequ7ynyhp1gW2fEPCxxjxJ8mhG72zhUB5WraUDinzrJqytUBZjl
	qSbp8jro8pHxVJqdxAk6YnRmfOjLQmqZBTTCcROGEOegE/V+LMHsNKGeC+LuD/nkFtzmN6lidDU
	ipv/BDEnV190OjBtuAS7q1shTY79qpQgWdE5bHrNSfR62EfB5AZLOlbS6hXpVpdZCK5xnKhsgIY
	/a+sjPHg4AWV1VebsDjjSDBcgkjbNp5txr9PVU8rzRsFdqXGwFFZlalHzFzifp3ujc1kcsE+QLW
	MEbR6xCL78+aO/YSE7lebmcZfj3P8c6FRlhazPf1Iw15ExkQdNofeG1+heTlI7RRYofp2j0GXn7
	gW50JXSMAFdmETRZktLDizBOuOsKzdgUh5cZnHWVeC6e+G4qqH4+IaPuHEf8+PzdumF71mQjCr0
	c9CRzvqGom/yKruEMGh/k46Y+7cHLVYHds=
X-Received: by 2002:a05:6a21:d86:b0:366:1917:54cb with SMTP id adf61e73a8af0-3985a64cb52mr4821364637.3.1772884193600;
        Sat, 07 Mar 2026 03:49:53 -0800 (PST)
Received: from fedora ([103.215.156.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739dfbf4fesm4264696a12.0.2026.03.07.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:49:53 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v4 2/2] iio: accel: adxl372: convert to guard(mutex)
Date: Sat,  7 Mar 2026 17:19:12 +0530
Message-ID: <20260307114912.58062-3-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307114912.58062-1-rajveer.chaudhari.linux@gmail.com>
References: <20260307114912.58062-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
adxl372_write_threshold_value(). This ensures the mutex is released
on all return paths and allows returning directly without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v4: Changelog moved below --- as requested by Jonathan Cameron.
v3: Return directly from error path without goto.
v2: Split into separate patch per driver.
---
 drivers/iio/accel/adxl372.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 28a8793a53b6..4bf8656991ea 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -336,18 +337,14 @@ static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev, unsigned
 	struct adxl372_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->threshold_m);
+	guard(mutex)(&st->threshold_m);
+
 	ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
 	if (ret < 0)
-		goto unlock;
+		return ret;
 
-	ret = regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
+	return regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
 				 ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
-
-unlock:
-	mutex_unlock(&st->threshold_m);
-
-	return ret;
 }
 
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
-- 
2.53.0

