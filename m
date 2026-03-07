Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812536A02B
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878724; cv=none; b=kYyXbSPCv+zNRabGhsQsUctXuO9zSljd8NXPqbtnAjpxNOFzUQCQ9Wp43n0JPg79Q12dQodUdSykY76Bz2C2kscbrMiXsKupeHbRY/7pMxkcfTD0XidVmyN0QcwuozwhXXymexZiqsfJV+W1a7tcQX4y5Vh5EqoqNdnQfhxou1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878724; c=relaxed/simple;
	bh=/SmXTAY/xZRfSiD4uiSMI1Yh4L2ASRtyBwJyrX5qvvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4PgGZhCT1In6iwVbqXYLFDNIUSxAq08OlFlk0bO1iFoCktAhktnxo65R72ZNapWRJLEAhQBsT0mPDBRlZwaDxSh82r3MYdDOraSoXgxieL8DZvnQmb7Yoslk/Li6JE5tyGqteon4P4PMbNczHbqldM8U1bBBx450xA75VPmy6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN9UagkO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN9UagkO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad4d639db3so45721215ad.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772878721; x=1773483521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/I55kaLdBWzOitjkqtS2/HX//j8K3LJPhNqqPwMTTg=;
        b=kN9UagkOEmmEvEqTG6xjjVnRhdr6Gvtig7fgquq/78b5547MUNZ1JVfrnzlqkrSzCc
         rI0dg3ZBeAgGC7Q1QcMtwjAn+sis+YGib92cpVvET0VnJGqd3XjT3Vw5pJH9bDJXQQYd
         Mo2F+CnZFy95FxbnR+OeRyhaHcwuchv5pZiNyjCG51BvuMPh4wHB8sEth7ulbXeJvfic
         k8xR4vC8c5be/K6UEPaTmNJs20YOyeqql5xAC0pgfw2Nbp6qL0J2N2kkd9HrGnHol+gl
         ulw1/rBp//7FGR/dw4a3+gGCYnMF3px6QG5Vy02Qv9tehXWgG6dObOZtONjt5ANvGZtR
         FGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772878721; x=1773483521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/I55kaLdBWzOitjkqtS2/HX//j8K3LJPhNqqPwMTTg=;
        b=tiVMpvLJnHIRMtRtTJxDuK1/uwV6BQFncr4E+YGKzrsGto8ajKk6eWP91f3NvnX8RP
         x1j0g4/qJ03yCzPsdtyfkDTZE3FsrAKs9LkqxDnR/87q+BM6TK0T12n64VGZxZYLj2PH
         bFFKIBqMImurrIANnhpoxykUi8rOgDb7tXmveZblbRihNTVS+wdipqWLTWK2MCGlUhM3
         z82IbvZ7AQkMiDT93ex3rgf05jG5baaHUBDQ45+NOnwC8s+mMOrPiocnwS17ljarYHBh
         Ow2TCkPl/Yn0kFpJBZpXsKD1Q5S8KgWy2XR45Sw4AnopaK+f4fX64kxo7givfBNqmy0u
         /+AQ==
X-Gm-Message-State: AOJu0YxF9S98eiQonp43dfgrfu7NccRO1PQpLlRH3WM20VlGanQnDWcZ
	IoEI+443L+QKfFwhd5KjdGr9apcHuM0+drB1mz5n+TZFsbd+eAc/Jtla
X-Gm-Gg: ATEYQzw0gtuNLtw4AplsDZrcKvdv9HB0+qyt7F9QY6JcPC6vfeCmrbRQ+o1A/9kk2ef
	lCEQAxN3dSFelofK+L3XNEdPqDmle7qh5negu2WjecZdTt2NnR1aD2RRBaGx8WQhSZRS+e8+FM7
	y1zV4Px3nfJzsZREYJyQBNw5MOqCthtRVEk16vX7+vpAzlpz8mP3FHaO+aP+JZ6AqQgM31Sisuq
	c9trttKOr5mwPk7JM1C9Beb6r8vk0NTSJ3M0M4C6MRZn7AcoLjxtgg/2zI9FeB0a6BhjfaRF61o
	uaUdqqSuquiX/vzQYU3LR0B9Qi6rxklrE+vpd2iUHsiFOrjLIsVTjleIepKiatmGC4XX6TYIKWc
	w8SaKNbM5oZBLrcyBupy/4SV4q185PWPhE49QAaAsRDrXalLNw0I71GbVkzzAC/xBS+pMYBXfb/
	ycY9y56um4FKl74ELok3leO4aAwDp1hxin0+QisoelxI6pPhZCpfzY+Rakskv3ADPS99/q94bRt
	GHY821f+RMZQ5OyARoLyMFD
X-Received: by 2002:a17:902:ebc3:b0:2ae:512b:eea9 with SMTP id d9443c01a7336-2ae82430f22mr53741175ad.36.1772878721117;
        Sat, 07 Mar 2026 02:18:41 -0800 (PST)
Received: from fedora ([103.215.156.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7864dsm48381265ad.49.2026.03.07.02.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:18:40 -0800 (PST)
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
Subject: [PATCH v3 3/3] iio: accel: adxl372: convert to guard(mutex)
Date: Sat,  7 Mar 2026 15:47:58 +0530
Message-ID: <20260307101758.50091-4-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
 <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
adxl372_write_threshold_value(). Remove goto label and return
directly on error path.

v3: Return directly from error path without goto.
v2: Split into separate patch per driver.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
 drivers/iio/accel/adxl372.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 28a8793a53b6..340433782cf2 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -334,20 +335,15 @@ static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev, unsigned
 					     u16 threshold)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&st->threshold_m);
-	ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
+	guard(mutex)(&st->threshold_m);
+	
+	int ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
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

