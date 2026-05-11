Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC43A1CE6
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503568; cv=none; b=AwkBitB3HZzyBHAw4HUUDDGcfbf+8eKlhhUqMq/OeD778ZgX/qY2dddslUPdu6VeuB3j9zALrw8ptjZTxeJPgBVmWVvLMRsyVzUZPNM5PQUvEXLrMAe1t+rNWPR2ZrgDggeCmCOkpIa+QKUOtFT+grZn0JCWylyD9imcPUyY9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503568; c=relaxed/simple;
	bh=ah+L7XjFPxAStMvJXlWIUi2176ncgWCDMGxDiPNGJBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U8g74M9iBWCgfJOBFVN8KJeUmdkQvEw3tPjNP1Up8l1UNjXLxcx37B5QVDPTRI2IMH59HqSejQRKm0cTYqvEC0CxBM0kSzO6acpX0do7UIByf0rriYJAAiVO49MJ8An6470C/a4yIDzxMv6ZaFjSciGi8hcDY8eEhDTHD0nZ5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9sLFMU7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9sLFMU7"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44c44af71f8so463027f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778503564; x=1779108364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1BQNIkn+QGmcRpc4xARpcTaU9/uXxyUpoOywmJXqXA=;
        b=q9sLFMU7gcq2BdPX+q4/UWV7/LjJGdDQrRucGmiT89VMvKQdl6s5u/A41fadlWvYcH
         iV602/19Csviu3Nbg+HU1lEKH4bZwChxo9SA/V8HfUh1m8fuoSEG82UE3WvNsozx/N1C
         yWH/9JD8DnNLuLP9F5aV0Nlx/Vx8aMasxg5Df4aQqT9YOCULwKoXftXntMVD5CgEX6Lh
         EML9XjoVIpCHhuyiMjkvM5FS6Xc+a93KkcxrmnCgxtjIgXd/9e0b1VURr7u59eVR03hO
         zl7nPpwpbOqEX/cv4J13Xp8eM2Kxqbv+rSPKF4ze7m6fgQYMaimuH1nXpzRxofDg1CYc
         i3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503564; x=1779108364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1BQNIkn+QGmcRpc4xARpcTaU9/uXxyUpoOywmJXqXA=;
        b=bHu3bj7Espipv7pc7z9TLwCvylyTfDG0wZ5oL6KRafZ1eB9/QX1dqJY/bXaRiOwmV8
         qtnwj7D5yEikfJYaF7hrPulXe7gEinjRVC8jNyXKohJxY33Bs3GAJx5jNZKr4jC+xxwU
         s1Vw+thy1NOutWZkeh2XIU1S/BS98iUE7Iy5b/OgbEOh4kqLP40oFqEdYbx22NVV1n9h
         FtPG0wwO2UA7orkGtMBlUfBvRKZpQK+UVZ4xhSPON75vgWK36zLVXnZ84DcffUFS6r6L
         ev4EAyceld5TK4itiT67ESQsAdEoQAe+5ccZcmD4Fuugeyq7LOehm6s7H8M4R2vuapYP
         kFqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iFLirFAI8o7O9gy11qyT/uUbvbFpTITY0k+8zHwoby9nZEMhsNpoH+g/kvwmin240Fg/er2HV/hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGLasd90sorkBxkTKoDsWUbh6LS1X8q3vHOcR/gXFIcGNLXkC
	Boe5p7noGGoIKbakuTir2qHvPRLtMFAD+vsB9hFacLxPzZQ36zR8TZKN
X-Gm-Gg: Acq92OH+PNMZe/YFFmbW0tMuawJRl3mB+3Er3X+8/HhTEGVTQ3n7nqn+3ztE9YNUvLF
	vYYQ6taEpMm/iCtMosOgPRtKYqaG5kG+nOC0ZkY9hCZwUcm1o2BUc+iKsOPOhCBGjZQsQ2KYRNs
	ww1jMC1uF4+jw1PfMfsNtlAlvPocDL/wE/CT2bWDcgGXuTh52IKvUFspqjhzaTJpUeFHF3PkxA5
	3qsKt+MfOB1Ali+llNKdZShYF3WEaDMCRcmwt3qADHRe0iEjAXVjXgYBQ+swJu5ZHSjh28ZCoq9
	QsVNGFS6nrmu6RW0AvbxSxZqxruDMfNuYUE+ACTCjgRFPAKsHEu2VqXxEJscCzJgBsCgbaUkh/P
	6FlvhGMyLyUj1HachWTn+4s7Gs+LlKiE4mIPHqfi6rhgEeVHEYxti1Ci7hvKhJWsSOocmPU3Vcu
	J5kKK1mPgCBhyHgogqqR4XbWVAHK50nEglxNd9fFPMmbfP
X-Received: by 2002:a05:600c:3508:b0:488:ac4b:59d1 with SMTP id 5b1f17b1804b1-48e532b5cd4mr172402775e9.8.1778503564268;
        Mon, 11 May 2026 05:46:04 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7e45ff89sm129305255e9.8.2026.05.11.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:46:03 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: adc: ad7793: replace usleep_range() with fsleep()
Date: Mon, 11 May 2026 10:30:43 +0500
Message-Id: <20260511053043.229-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD7792/AD7793 datasheet (Rev. B, page 25, RESET section)
says: "When a reset is initiated, the user must allow a period
of 500 us before accessing any of the on-chip registers."

Use fsleep(500) instead of usleep_range(500, 2000). The 500 us
minimum stays the same; fsleep() picks the upper slack itself
(about +25% on a default config -- narrower than the original
2000 us).

Add a code comment with the datasheet reference so the "why"
of the wait is visible at the call site.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/adc/ad7793.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 8ff7b70d6..dbc6b47b7 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -268,7 +268,12 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		goto out;
-	usleep_range(500, 2000); /* Wait for at least 500us */
+
+	/*
+	 * Per AD7792/AD7793 datasheet (Rev. B, page 25, RESET section),
+	 * allow 500 us after a reset before accessing on-chip registers.
+	 */
+	fsleep(500);
 
 	/* write/read test for device presence */
 	ret = ad_sd_read_reg(&st->sd, AD7793_REG_ID, 1, &id);
-- 
2.43.0

