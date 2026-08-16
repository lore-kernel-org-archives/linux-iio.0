Received: from out-2uec-a117.jellyfish.systems (out-2uec-a117.jellyfish.systems [63.250.43.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F03C062C
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786908403; cv=none; b=Yt6SkM2P12OzbhXIrEExsVYiTb0doA2KxSoUIyyiVfQb9OaY5bmOy3/8SZ5Gfoo/7/PuAhbp3/FeaObLebRZxdFm6Cp6SB2YViPWtU562gYJvLUmuCtw8dz6i0pbfiqU4JKN443n751+ICPh++1gfh6+iHphppyqDRuIfVuqgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786908403; c=relaxed/simple;
	bh=cTsNzRTilqXtdq5//WH6j43o0iiaxMk9zMpXRgUbrWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHtzqrRQWgHRVUfx06jzg4Pqn21eVWFrlz1xVTjP/6U6KPWrDiO1bCccLo0UJHOEfr6Pe/ubAJ1g+VekhXqHnYg08x15Jl37X1cPc0QCb/noZML+RaMb0vd8ebbInbhJEMGFgu5UwsNbA1gvE21zS4/1ewuloM5Uk2EQZxHITbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=CjsHwqdF; arc=none smtp.client-ip=63.250.43.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="CjsHwqdF"
Received: from [192.168.1.104] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hNQtn06Mlz2xBx;
	Sun, 16 Aug 2026 19:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1786908386;
	bh=kkA3d5yArNZAMgQ+2D+cnIfWefjUctmtxT844zZK9Bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CjsHwqdFMTk+o1kZU/XbQNtlALC4r9vYbCWh8zK6dW821Nf8+UUgNf9CTgAKcokLu
	 OJA8STqxHavDGl4a86TQ4i4csBg0RTBDfejuJH01jIINBjbQRXx+mT2sCtLKdarYJC
	 QLqiAwtB9SE8hUrufpccnq5dZluanqdv3Wa9Wa9NgfPd99H9iEGJMYd8xdrSehX3eC
	 Wtte2yAJ3P3n8vlzpAi6p8SxpVhHxIUdPGRKcLvWPA1nySuWwEjl9Wyv19A0sEg4dz
	 HXWOd6qX3zLlYo+kdpwjCTb8w0SJJf0YqKuv21NgVoKfuuIsHsfo9mKwQavsSChPYu
	 yWkZLjvB8kbwQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 16 Aug 2026 12:26:21 -0700
Subject: [PATCH v2 2/2] iio: imu: bmi270: Use in_range_inclusive() in
 bmi270_write_event_value()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-minmax-in-range-incl-v2-2-766f737dd6bf@gurudas.dev>
References: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
In-Reply-To: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
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
in_range_inclusive() helper, expressing each as the inclusive [0, MAX]
range it actually validates.

No functional change.

Assisted-by: Claude-Code:claude-sonnet-5
Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 2ad230788532..7f386a615b39 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -1132,7 +1132,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 	guard(mutex)(&data->mutex);
 
 	if (type == IIO_EV_TYPE_CHANGE) {
-		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))
+		if (!in_range_inclusive(val, 0, BMI270_STEP_COUNTER_MAX))
 			return -EINVAL;
 
 		raw = val / BMI270_STEP_COUNTER_FACTOR;
@@ -1152,7 +1152,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (!in_range(val, 0, (BMI270_G_MICRO_M_S_2 / uscale) + 1))
+		if (!in_range_inclusive(val, 0, BMI270_G_MICRO_M_S_2 / uscale))
 			return -EINVAL;
 
 		tmp = (u64)val * BMI270_MOTION_THRES_FULL_SCALE * uscale;
@@ -1161,7 +1161,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 		regval = FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK, raw);
 		return bmi270_update_feature_reg(data, reg, mask, regval);
 	case IIO_EV_INFO_PERIOD:
-		if (!in_range(val, 0, BMI270_MOTION_DURAT_MAX + 1))
+		if (!in_range_inclusive(val, 0, BMI270_MOTION_DURAT_MAX))
 			return -EINVAL;
 
 		raw = BMI270_INT_MICRO_TO_RAW(val, val2,

-- 
2.55.0

