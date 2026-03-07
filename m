Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE19277007
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880512; cv=none; b=J+gmBURTCeuo6fhrFzaNcNcTdESepHubb1bAnS371bHP+KNsTvkgNizaLmz9T4zuwj6mLiCJnNPb6y+SwhUL4X7MqAV1EQVpbGnXe9757cGsgu4EO4SQ+mbwOY7T3kmSVaRboC11k+5+ClRmXWKr4DYIAvnpWKLV3HlzIU/wPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880512; c=relaxed/simple;
	bh=jHEAdmrC6y004m74YPLjP6vi0EZDRSFt9YV3U5hwQc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmoaNZjoKUaCVZ4Js7Ls/1WpYNa+wl5jgIJr7dL01sFCOdAWDzsTE9H46JK9rHsLMlZKjw9tNViKq2QtplLu8AI0TxQ9njOjz+Ib7UeMEeq0Zf1xs3GgIs4XiUZEepntCKzmPqpavi907bwn1SFBCaVhRJyFKRPBINrp5hWQzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEfy9id8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEfy9id8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a871daa98fso75942325ad.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772880510; x=1773485310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wles/u7EUe+I8KrQrOUvRzJE0YVmunOPPbjCvvfi1dk=;
        b=LEfy9id84k/qQcHaWxHMwc75IeEIbc5+oKKuEAMEuYrOHBMIF0thHWXb3Xbc0INrNo
         UQkNX7TyiY5M6BRDTLMeBP2QySg0o5RbxmP0yVwjLVXI1p/Ftm5EFyB0GaWtAPbQEX+q
         WqBf3vNG5lL+846Kbo8UKoU9UHQKAiRrFXQqFEkPNJVi7sqPIwJrwbwJv/ZKFzbx+7Dp
         E+4cow+TxCrBLceWo3JXWPkQWi2IJqBSrVE/oNwx5s9y9s7LVb16Mcmh1dvhZuSWZEpR
         DV6LonmZT5sjFNHXJqxzS5mEhuFDTjT9ruJgjLP7/0B5xBqE+KSvBlph5GpUKG7KcIzs
         XMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772880510; x=1773485310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wles/u7EUe+I8KrQrOUvRzJE0YVmunOPPbjCvvfi1dk=;
        b=h7zI+MWNMl9TNlFlAwy710WQZlTRux5gHUXGUbVXJanMGMAsldHH+pMZeB2KfISwT0
         mlTCNPKZBBUxw9il0c6BtgJEsOrSsOnMeC1hLVslvONLzH2fMIziMIK1UzzZzzTdnKE3
         I2Yd0owYELKr6b2kNSYRj6/UKkeaIyPLx984H/MR5uJzakhrKAsjv+oV+a4P6ON4bm1V
         hS2S0n/KMKTYf1vO+O8LabyANtes87H0KokOPdlXJE1LeI5QfM8a9jYH57D1nSUhTBSd
         q9gyjvc93wte0eqRoE7RXa722uvj4FNutMKqn/72iEcZIMl6yYdrLzjLitG6FQs0keNz
         Q0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVewsVd2sS0dsedb5vGAwjVJpXTXxa4L6I1pMmGXfrlDE76bA1Z4Y8y5WweElAP5ZIhLSJd15c+ge8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+uP/IdN1aABhLB4/ahnDQIcrwhvgj/pTthnMR49C174uTY+oV
	LlRVDkuc+3AHNTeOgXy+wSmVbsN5QsriduqCmTC+n6KJckKybcCbQnQy
X-Gm-Gg: ATEYQzwVXNX3H6CHGZrMoo3/oNBmuVCOgt/YQsii06ZYZ4jS2ss45EZ7eVuQo/WI0NS
	W5nk0fee/oZtCb76Y+J8PF3dKYMoyvCgjbMv1pBTbIsrZazoA3AMGBRIuq4GdOHuuaSesYp/yZv
	Cqvzhm6uHtQMnug8+KKn5xaTouQHhbv6+opG99TaGUPbNCa6+bsRsZIsQQkku0j+NXHF7THZC2D
	x6i9feFWU/PDfg8unppUEy6nohBrOA1hbwBkY6DiekgJ7hmaNwaHHE49x381zdSqrLWzF65NRaM
	yH0gRAsT0P6IkA41Y7MbAZt/tR07nrleTI9L4to39KztEDYCwRjIUL9RQjKDIpMILWzRHkVf0ku
	l2f4xTwqs8eoqeeso8YatOlqcvN57uW5vhVtkzn0uscYAdqwEP++g+kWNQsx6RWJT4eWfc7rctE
	LYqGhinI2O3TjPInrd1Ljj3eAb
X-Received: by 2002:a17:903:b4b:b0:2ae:3dd5:c69c with SMTP id d9443c01a7336-2ae82444561mr52930695ad.33.1772880510515;
        Sat, 07 Mar 2026 02:48:30 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:49e5:cff6:c6fd:2f81:fb7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78d48sm49541235ad.22.2026.03.07.02.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:48:30 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com,
	i.shihao.999@gmail.com
Subject: [PATCH v2 1/6] iio: accel: fix spelling mistakes in comments
Date: Sat,  7 Mar 2026 16:17:00 +0530
Message-ID: <20260307104705.49129-2-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307104705.49129-1-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling in comments
- celcius -> celsius

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/accel/adis16201.c | 2 +-
 drivers/iio/accel/adis16209.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 5127e58eebc7..87ad843d1e49 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -147,7 +147,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
		/*
		 * The raw ADC value is 1278 when the temperature
		 * is 25 degrees and the scale factor per milli
-		 * degree celcius is -470.
+		 * degree celsius is -470.
		 */
		*val = 25000 / -470 - 1278;
		return IIO_VAL_INT;
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index 41ffd92f27fd..c9f34e2824ab 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -186,7 +186,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
		/*
		 * The raw ADC value is 0x4FE when the temperature
		 * is 45 degrees and the scale factor per milli
-		 * degree celcius is -470.
+		 * degree celsius is -470.
		 */
		*val = 25000 / -470 - 0x4FE;
		return IIO_VAL_INT;
--
2.53.0
