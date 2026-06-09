Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CAEED8
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966657; cv=none; b=mB7nW7Da0IZFeXB4gO96/PhbUHgOCzfHSrigHNWC08TFjJBnJINeNqEAHtKNzK0px4DAIyfJDbwbcZDknaXA983sEN9rT4XtV1ECIDDwiukF9OrIaKKF5zBYeCacjBqPmhgJvS98PnEwCKgbLYrVlEDo94WqW0hcH5ORdNBZBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966657; c=relaxed/simple;
	bh=yKr1HKXYLYUQG4AmkiVREKX/pCC+chnS0oHPmD1N+qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5R9QW4QR1FDX9MhgBlG2hmbqpdhPh3JZ0YqjQUL8YUFUVIAMI3tMG+spA9bpywJhnfAUiP0jlMqDUeX73VxVwhrVaQoBiNUsGk1xfA1DGyXHsEJe5iUyevUb5Rc+bJ+F1PhNRDMvPVjAN0VMdT0dy7rF6kEyuwdJ9G6UqDPEZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwxqgf3o; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwxqgf3o"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-3074adb8fcaso8293977eec.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780966655; x=1781571455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y+2qZXsp0ZKsYrWF8sEbRP0rZBwsEdCkk0HTYYr3MQ=;
        b=Iwxqgf3ohQmBikgKoT8n79/67dHc1uG1zQhsj1Hk/yfXiIuoMSy5nKc4rjk+/+PTB/
         x6wCGzJLj+TbRxa+yr0WJyDCRKRO5iZ0jsf894e0sIz1/mxcsmWEz3UZM50eFCqBXSer
         3E7izkAY+GzStyhR28j20CvgkeZgfwSjyfPsRi7WzdIwlUcTRMGj7N71b0Ag5JU3lR3a
         4Za/y8zFI8EgtiAYs6mTJzOMLaOtvBeSKr7KtKCtvEBEP4NsUHuRH0CKqp2/O5PbUwo4
         PX5CWrkTSoGoFI0h21ZfR7f2fnaigwdKzGq423Xyof8svmmcvhyqHV6nPi5yRlGXwZuZ
         2sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966655; x=1781571455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y+2qZXsp0ZKsYrWF8sEbRP0rZBwsEdCkk0HTYYr3MQ=;
        b=Kj+0IXtteE/Omxh2rZFEBnl+8Mqa17K3quaAZQxuwURKogEx2bMKlLKyaoaQwpoKWL
         q3qd9kXXA6M9K+FmrjMsygL072TT6yQPjWtwC8h6FGqQ17qW29fr1tl24RWUDzf0kFVB
         iHnevHvQ4MfwRXnieZ1JBFpp5atAbkcYkwOSmB8oVNP+PmFIdknZMw9DdlMrvQo4/UnT
         lgcKHonO0S3a3EqFtYS8fH3gMb8coFmomAEP1Ey+0TCjC8MPeVep1lftIkTuC1d7cMiu
         0jVqvJe23KFZ795MVtgYXXOTSeakUQ28o59sISb0GqdWjaFiCdBhZ4ZG08bz3iOwzfvM
         E3fg==
X-Forwarded-Encrypted: i=1; AFNElJ9lfQD4Gg8A2RERAaWNIBqeyoFHNG1LHTxL2xP0jOKfLuY0oe02j1hDHzogIakUlARh01cbL33ZdYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyYTygaJp+B9S4XqzBk4joa2Ru68Czg86c0HxMYH1Zk2A9Mns
	/xf4xfXQqFxJF9E3fwATTJmi0ymts0cqaGsoTd6/TfU5ZmWHBByFjGI0spxNX9f+
X-Gm-Gg: Acq92OETPMc1W+7FEIx2tbN7Bzd1HUhiDFa5eupGN52qRM44IA2XwkZ6p1fLRJgytqk
	W3aobpsT+knWiYJ28JGlP5c0T1zJmbTBKjTpd59YuFGS9/0TCN7//qsiSKBCX0h8fvYUStdH6W+
	D6Rmi7jbNpXOiTdUC22WD/MqE/rioroCYKvTX6PPMeEOCYNBZL+V+L/8/49VYZ5vv7oteuS/y81
	53aWR6+Z1Mmwi9F0jXbEyDUl80pwWTTKO8GkRF6cFORTA4XsXwkk+I6x70TNqT92XfXMSXpt2WA
	CdUko5XEddHkfutNIeKFgG7QCPIJq4yH9/akFr0bTv+lbUCD211VliE831tkha+ReUGqU8clNnN
	M6i2jMcjw3SwJukkk5OIrD/Tz3FCryBxrHgadvITdSdEEHVSTKHgGF/Cm3bFlsIykY2kdcHrnv2
	8XAxa1B9tkeRkKVl2nfrIjkN6iuaZzAgR7s3wCU/yw3sQE4jSg3RNtTHEXAZcHdln11qmSJzoU7
	YrA
X-Received: by 2002:a05:7300:7fac:b0:304:dddb:f8 with SMTP id 5a478bee46e88-3077b357f7emr11014914eec.35.1780966655160;
        Mon, 08 Jun 2026 17:57:35 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm24654023eec.6.2026.06.08.17.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 17:57:34 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] iio: pressure: bm1390: replace short msleeps with fsleep
Date: Tue,  9 Jun 2026 00:57:10 +0000
Message-Id: <20260609005710.85842-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace msleep(1) with fsleep(1000) for the driver's short
delays.

The BM1390 datasheet specifies a 1 ms reset cancel wait time
(tSC1) during the power-on sequence. Use fsleep() for these
short delays because it automatically selects the most
appropriate sleep mechanism and provides standardized timing
slack.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
v2:
 - Replace usleep_range(1000, 2000) with fsleep(1000)
   as suggested by Jonathan Cameron

 drivers/iio/pressure/rohm-bm1390.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 08146ca0f91d..71b08333b746 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -486,21 +486,21 @@ static int bm1390_chip_init(struct bm1390_data *data)
 	if (ret)
 		return ret;
 
-	msleep(1);
+	fsleep(1000);
 
 	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
 				BM1390_MASK_RESET, BM1390_RESET);
 	if (ret)
 		return ret;
 
-	msleep(1);
+	fsleep(1000);
 
 	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
 				BM1390_MASK_RESET, BM1390_RESET_RELEASE);
 	if (ret)
 		return ret;
 
-	msleep(1);
+	fsleep(1000);
 
 	ret = regmap_reinit_cache(data->regmap, &bm1390_regmap);
 	if (ret) {
@@ -575,7 +575,7 @@ static int bm1390_fifo_disable(struct iio_dev *idev)
 	struct bm1390_data *data = iio_priv(idev);
 	int ret;
 
-	msleep(1);
+	fsleep(1000);
 
 	guard(mutex)(&data->mutex);
 	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
-- 
2.34.1

