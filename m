Received: from out-2z4y-a134.jellyfish.systems (out-2z4y-a134.jellyfish.systems [198.54.127.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124A33F8A6
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786850244; cv=none; b=BkYeCwj47LWNFLPaqm2EQonQE2qUUQhIO7MkcNDLeHKZqbwVjiu/flcAMQEq/doa1RVTLwsX1wMZPnvGnYF00vYU/jEg+MMVU9hJnwKkPwOMDxD0yFGVvk/9iuRQ7ULCmutx2JOMieRTSdKqSvMCyLyNEYde52cN1P0qOJDE10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786850244; c=relaxed/simple;
	bh=aGFFZJFnbM7GtrtzCiVUEL6l7w2mFZNKgMqdn4tOqps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RX/CFVGKByfedm9+CDNOC6PWvISwPMWs87CVjpxLCc7S8hyowLIj+UQHI6FJ8VpX+A9Gx7TiVQgd8zDqb1oOlLgEWLjotyIvLkJStRrS/Wsj6QP9miTHCw4yrABKR7Ux0f7M9bxSTmcSJP3QtiVAZ3k7cGC0EkOa6lt6VFJFZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=ECV9L4+g; arc=none smtp.client-ip=198.54.127.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="ECV9L4+g"
Received: from [192.168.1.103] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hN1NW16Xxz8sWk;
	Sun, 16 Aug 2026 03:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1786850236;
	bh=pEFMuCMGyKSxBMm1KRuM6omra4CvFV8CDADWc2gDg4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ECV9L4+grOlZ94iv8aOt4yuYJtkJsief3yW5tMccPPvPQ4LiZFvUS+/bs7WpuNzFy
	 vE7aGW2W63PjyUZq32PoMtPjrOB2SGHkH8JobCE1HHznl2NPRjjEyn9NMupCUkrkV8
	 E4GUP8ioZO0p0BAVJK6tFrwrZkWIUPLzTZhnGJCAnh0WI48oLzpZFsUPHzzwEqlsNl
	 30Mudf3SjrM8t13t3T4qExHifE9T4rQuElwj8Vyn8aFC+1e+6naAwphsAzBe0nta1x
	 D79kPVYqj94oJ0PUNB/en9bECf/x7yEUeWnSpsydEO321WTwk2eroIsP6Nkz8DfczZ
	 C1L7zR4fxNdLw==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sat, 15 Aug 2026 20:17:10 -0700
Subject: [PATCH 2/2] iio: imu: bmi270: Use in_range_incl() in
 bmi270_write_event_value()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-minmax-in-range-incl-v1-2-a75f7d9ae92e@gurudas.dev>
References: <20260815-minmax-in-range-incl-v1-0-a75f7d9ae92e@gurudas.dev>
In-Reply-To: <20260815-minmax-in-range-incl-v1-0-a75f7d9ae92e@gurudas.dev>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Gustavo Silva <gustavograzs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Replace the three "in_range(val, 0, MAX + 1)" checks with the new
in_range_incl() helper function, expressing each as the
inclusive [0, MAX] range it actually validates.

Assisted-by: Claude-Code:claude-sonnet-5
Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 2ad230788532..fdf7f062e234 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -1132,7 +1132,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 	guard(mutex)(&data->mutex);
 
 	if (type == IIO_EV_TYPE_CHANGE) {
-		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))
+		if (!in_range_incl(val, 0, BMI270_STEP_COUNTER_MAX))
 			return -EINVAL;
 
 		raw = val / BMI270_STEP_COUNTER_FACTOR;
@@ -1152,7 +1152,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (!in_range(val, 0, (BMI270_G_MICRO_M_S_2 / uscale) + 1))
+		if (!in_range_incl(val, 0, BMI270_G_MICRO_M_S_2 / uscale))
 			return -EINVAL;
 
 		tmp = (u64)val * BMI270_MOTION_THRES_FULL_SCALE * uscale;
@@ -1161,7 +1161,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 		regval = FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK, raw);
 		return bmi270_update_feature_reg(data, reg, mask, regval);
 	case IIO_EV_INFO_PERIOD:
-		if (!in_range(val, 0, BMI270_MOTION_DURAT_MAX + 1))
+		if (!in_range_incl(val, 0, BMI270_MOTION_DURAT_MAX))
 			return -EINVAL;
 
 		raw = BMI270_INT_MICRO_TO_RAW(val, val2,

-- 
2.55.0

