Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54782253EE
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840838; cv=none; b=MC6aKMJNPIHWY+PPNtd+2xiIkGZJJ400Ck3L7o/CqzsQsXELHZjSXDbcjmvXCCN9ebYOypWp1dKmXKthy+QMslI/TQoJtD35JM8rHy9aiDh0oq7wyGdLa9Ur3BjlMf4nSNpx6UHkLWVHYrV2T+yW4meez94LgyHOGFzcMVrJbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840838; c=relaxed/simple;
	bh=jKP9+fHUgkONd+OEs5wzKAR947i8Z1a3ARbhT17+syI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OFFccTNKu5wdgJdxYskPa148fI0Mfs7uAjE3cSij5gIQMtFiylBcetgN8eQK4vgorshukqYRoO0+3fZ2fZyHwLqnOB4PpLtLts4QDWRNLqrr43b4hTDGDtNT2hrzZMEb/WTWOOGH/yYYPMFYRbLI12fkcBsbZ+Muy9SB0r+D/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYvOYpnJ; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYvOYpnJ"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304f590dd91so3667065eec.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780840836; x=1781445636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlQtD5hNQ3qQQNswkZH9BNz1aB+yRfkIoZHyFOn2t28=;
        b=WYvOYpnJIWdcC5qKkXurzZUT8dNO1mpeiiLiPc7rHOZMNM4+je+eDMVxu133P6ORYg
         TljqIGb1zeDM6UK8XUFwh4sQCQhYR1PW1kXk+9xqdnG0quyHQCrGGi6pNMbSzvp385xv
         HRde8IDp8ZK1CpXaFqOnh78X2La2GTEM6hnhadVwSt8qVYivMJIV4Ldt4vd4vsTDdO3g
         JRL+ioWkv8MEoq0QoBn6MRGS++php/50Enhg5UgSCMdsiQRlGYMNfaXy7WsBP/eM6zCU
         P/J5t4Twd3aEl/uN0Elw1+yCHsxOKjdjqKAaegf+5w17v2ZqUyp9ZICIl/Rf+EcA14qT
         531Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780840836; x=1781445636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlQtD5hNQ3qQQNswkZH9BNz1aB+yRfkIoZHyFOn2t28=;
        b=jKqYansOQafo9KkEYXvkOHWuZee9tUtNFaI+1ifNGNkW9xZxzAsJtdEaVXEDZ3SnNz
         2fHk7RhlKhgwzxB2MYMN8eNifntkTPUmTfj2ZFCwEKkdwmS85S767vbDrItk2UdYw3J1
         1A0EbomTbc3LaRI1OtYScIicSFtUeNToqjRKKOU9EHVD+VtZUlqhG2Cj9pgeOXHsV0SE
         vK6qyXeDMr/3sQVanBed01fYqUK+rUqT8GH5GASEY+pCCIih5/pMXnjJuik08IgoqDTi
         2aeoqKl/MU1Rn6wdH/XRzjOMxg/3ZJYNXeoIZRCDQNL857onIUMdlI3q8eXjFkWV9ORU
         BWEA==
X-Forwarded-Encrypted: i=1; AFNElJ+UslyYrWyDVkgnjiYUdaBt+6WaEW7MgicT21sbcvmeHZ2TwOYRippKt1N4JTGliCtkkPw738rX81Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpr7cgTZIeWxLffflGCzRyb6ryIy2uscobH89svzE0jxctwMk
	oZuuJdpm43YC37duCYX1SSR/XPR3hTTqVLyk2vpQcKTaYZ7z4F3u/Ms3
X-Gm-Gg: Acq92OH2xqYr0bz9uJngdWrA/sWgfyN4UEeSmt+03h3Q3R6Yv4bB/GJwov+g5US6APc
	fEmEoOVv0UgvwvD4zKARRpyZyIHVzbuWCodX3YdRYmgkO8uBGPQTYhy03AyO0XpUfcEXuCh+4Ch
	GGvxuagmP269HBZ6VneWGMJHs6KsxcmuZeigwguQg3hjrKK/ahX/zBy7Dg1BXHjf6ANir5toYNk
	x/+dAucQuhzA9iV3D9+yNuBtTWRxsp65TSnfYiKXHU03eab8kPHgGXFbdshQGzPWgIVU6LVqso2
	zKJfx4s1ob2Q/c+NJ+uZkJe+xq5Ozd5QiTRqwwOE50JGXU1tPbYf5kDOiMvBDAfH9bIrZHRTj23
	Iij7a+vVi9PIO1//BwYrs5IWFkdfO0zXJVg/MEkCdiXBQj1/5H0Lcfbie9bYCxBIb9eJozMQJGu
	bvpH2mKEZsSoQX70O3ybuuPgGuA2lXHrdhSlumFRe5/GiOt8LChY3IdH9NUXB4SeuCqZnnwVI/j
	RXu
X-Received: by 2002:a05:7300:214f:b0:303:f2dc:8ab4 with SMTP id 5a478bee46e88-3077b32a447mr6515342eec.2.1780840835827;
        Sun, 07 Jun 2026 07:00:35 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df3b234sm17989689eec.23.2026.06.07.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 07:00:35 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] iio: pressure: bm1390: replace short msleeps with usleep_range
Date: Sun,  7 Jun 2026 14:00:18 +0000
Message-Id: <20260607140018.59586-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace msleep(1) with usleep_range(1000, 2000) for the
driver's short delays.

The BM1390 datasheet specifies a 1 ms reset cancel wait time
(tSC1) during the power-on sequence. Use usleep_range() for
these short delays, as it is more appropriate than msleep()
and avoids unnecessarily long sleeps.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/iio/pressure/rohm-bm1390.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 08146ca0f91d..35b9abc25a8a 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -486,21 +486,21 @@ static int bm1390_chip_init(struct bm1390_data *data)
 	if (ret)
 		return ret;
 
-	msleep(1);
+	usleep_range(1000, 2000);
 
 	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
 				BM1390_MASK_RESET, BM1390_RESET);
 	if (ret)
 		return ret;
 
-	msleep(1);
+	usleep_range(1000, 2000);
 
 	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
 				BM1390_MASK_RESET, BM1390_RESET_RELEASE);
 	if (ret)
 		return ret;
 
-	msleep(1);
+	usleep_range(1000, 2000);
 
 	ret = regmap_reinit_cache(data->regmap, &bm1390_regmap);
 	if (ret) {
@@ -575,7 +575,7 @@ static int bm1390_fifo_disable(struct iio_dev *idev)
 	struct bm1390_data *data = iio_priv(idev);
 	int ret;
 
-	msleep(1);
+	usleep_range(1000, 2000);
 
 	guard(mutex)(&data->mutex);
 	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
-- 
2.34.1

