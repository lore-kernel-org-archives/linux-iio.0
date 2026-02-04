Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3920B80B
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167148; cv=none; b=P7f5tri/bpFuzxisTHM0u69kENDS9RIVQmy4PqQ1ms0WN0E7qd7ocfEpmrFK1ZXFEpcbnUlMSC/R2aEG3gDLftjBXll7XhFvbqJHrRk+8kMgItAL7S53O82NrlKZEVhUIxPAttFSwwH0S09y7B2feTbc+mFQ6/9OKl7aJOhK0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167148; c=relaxed/simple;
	bh=EA+DTyM0TvkKGgHedK2Q1Pd1vEFGamuZmTnbpViWc80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kyxg1Tgg+AgCn9ec+rUvHBb0Gq7QxP8GGNnyPs0snIKqwxgQpPOzNPbH5Hw0soX44TWfCofPgvtVGue6Tb1cyn+AexlimowXc21wFFWG6XbIHk36/uXe6hcJ/MjTz9IGP8x6P0b8LUCyYKluXuMWmlNlcG+zM67m5pJnhyu52uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuOq5JGM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuOq5JGM"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88fca7bce90so78796166d6.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 17:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770167146; x=1770771946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/W/oqk8EYBypX45KeAKGlnyGIW8xFG9k4s1ez+lXmM=;
        b=DuOq5JGM3aACQI0m5uK3chsQ7B7gDU3u5MiaZnVltG01m01PsT2d1AuoWPsNgXQ+MA
         qDwfGBPq4ppjFTx7VMor0C4hsksBvddbd+pntRd2RowewC+XkvAxyl8Fut0ziqNDWybp
         finZS9VW0lkuGfPD0Ax9ugrnMEWUnsGzzsvKF9/30qTi9DU54ILlF0Af2+g+4V/sbQeY
         ENAJ+EQwKsdQmWGy49PShKRs3VPQe/JKrvzGyA1fU4y80yRZYibV98i+s3cBMjfEARqn
         /g7WgNmJwHqla5JsMbIOjBe5fW92u/XzhP0zZV3cd0THjlnhb3SUZV84B+dBdIVfN1H+
         d/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167146; x=1770771946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/W/oqk8EYBypX45KeAKGlnyGIW8xFG9k4s1ez+lXmM=;
        b=vkTNsvKOJYEnCaSNwGh116O6mysfaS2oYGSC8bCvYA4q5tzXJbbbcEsF9JLVq7Sil2
         ZA9ulIQTwJKxB5HSzcTjZfMoHCc4nYsDDgtqdP7lxHvD5Kk3TIGOIKBO5r7lvmTG2cQU
         Poj/BerZD/xNmeE8JHSw1RiSIhtyG/D4+PcDYtzKKBhO/ERPQ0FeRGv5+o3Htxn8bRE5
         QxFt5Dfb+0deqWOXC3Squ2z/1uObglpK/EhkI5kQ6+/EUx7XHSVcYF3nvXRuth/8ElN6
         Sxb2Zrh5TMGPelgeK6iXi9AQkHQVop/XaETf7GMXhlyLewkBRhPsZjO4P83LVnJIZSuY
         SNJw==
X-Forwarded-Encrypted: i=1; AJvYcCVL0X2t+nFk0fpwKb6WFrn14MiDJPPYAYCdOSajwNfeg86stVEqKfhRRBMq9rcjE0FRZLMyFiGTm3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/gcg353surU+swF/dJq9/KEv3fD6ZdHSrjiJ4X/8b8mGY8+4
	5nuOEAzDkTnWhCJFlnQEdtvL9HvLk2C26OHpWzszvITvo/FycPZ/Hy5I
X-Gm-Gg: AZuq6aIa3T3OjbQswB+8wBRxNfWUQ8Ux8S46fR1Sf4raNaQRYZ5Iqn1HtEGbQu0Pizm
	27JwMGHaTwBWC+PWIGSMLmG35KeA79a8Fv44TAlS3au/3AIjTf2kcCNApBHMomK+P1oKJCKm7Ld
	tH4J52kub0O77ijCPtweuboC5/fCodtbtRNHZ/jfe6sLc6oXh5AexMaUSre7gjY7A1lVlIaC11q
	ey8KfzKkfpPn+g/4MHe3sQmmEhYFny6f+ZNnTrguThirST6qQQtf/Rb4IUEPZouS23SVTmhZ8QK
	sdWI1YqxXccPrloT7wov5qTpZtsDEdWCHz/SbYoN72wQIwgsUSC/x4A/WlRfoAE/M8J4m4VBYBT
	2jm+KJEliBuHrXPBj5qK2vgkt+xxb6Sl09utk6gmi5/mw+DPXIusonQflohkhVX36ql1t5N7V9Q
	Xt7dxjc2xvy9GCi3J1Bcpx0a1qzMX3TiU=
X-Received: by 2002:a05:622a:1a97:b0:505:d171:7e44 with SMTP id d75a77b69052e-5061c1bea5cmr15371771cf.81.1770167145974;
        Tue, 03 Feb 2026 17:05:45 -0800 (PST)
Received: from localhost.localdomain ([76.64.58.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bfe8cfsm8837136d6.1.2026.02.03.17.05.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 17:05:45 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v2] iio: magnetometer: bmc150_magn: Used guard() for mutex protection
Date: Tue,  3 Feb 2026 20:05:29 -0500
Message-ID: <20260204010529.48000-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced the manual mutex lock/unlock calls using guard() to simplify
the error handling and reduce goto statement usage.

By using RAII-style cleanup, it ensures the mutex is always released
when exiting the function, regardless of the return path taken

This was compiled test only

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6a73f6e2f1f0..bd2706c2078d 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -794,32 +794,25 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
+
+	guard(mutex)(&data->mutex);
 
-	mutex_lock(&data->mutex);
 	if (state == data->dready_trigger_on)
-		goto err_unlock;
+		return 0;
 
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
 				 state << BMC150_MAGN_SHIFT_DRDY_EN);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	data->dready_trigger_on = state;
 
-	if (state) {
-		ret = bmc150_magn_reset_intr(data);
-		if (ret < 0)
-			goto err_unlock;
-	}
-	mutex_unlock(&data->mutex);
+	if (state)
+		return bmc150_magn_reset_intr(data);
 
 	return 0;
-
-err_unlock:
-	mutex_unlock(&data->mutex);
-	return ret;
 }
 
 static const struct iio_trigger_ops bmc150_magn_trigger_ops = {
-- 
2.44.0

