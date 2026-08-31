Received: from out-2z4y-a149.jellyfish.systems (out-2z4y-a149.jellyfish.systems [198.54.127.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B381C45561A
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193630; cv=none; b=V6U4Wlb7Flg3vIKaajyGqDtrGNh5ftnaU72ACDdu1kJxuokUQH2Zqi95aPIXfebOsUprqJwLPalsl/9+u/n+0oWmQq2lB6YF9MsvpLaiKNMy/4c6pn9n0JhbryhmFSUie63UA0RU+QbwN+V4D66T4Wj95/RFzJda2g0HBNbFTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193630; c=relaxed/simple;
	bh=KzPvc7CmYgesOOtbeUQCIr7Dh7m2v5p9kHcd+JzBsd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uBlPBqpqByQOM5aTK3awKCMsLTwYUFN6yTvPvC92QefeRbWNu6lb6jvPCvcxXoPsnmZuJCcZocym/5LecaIa8gwAVMCGqNEAVc70A+KHzKtdjRqsHEgSqBf/MmMlAy9Mab//lQUUU97qSwakMSqIB0yCbKa+w4KyaFOulhCtSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=e3PXBqEb; arc=none smtp.client-ip=198.54.127.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="e3PXBqEb"
Received: from [192.168.1.106] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hYZBq15Ydz2xBB;
	Mon, 31 Aug 2026 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1788193620;
	bh=5tddOBd7dVOrv6zV3NixClhiHGTuWK8xZ1nqIYt6MhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e3PXBqEb4ZqVUXQJGU2eTcPPA0CkCRq4xZEoBpXKC8I+bhiR3zLjmvaB9Twwj3yGd
	 8betetBYBRoGR34YiDYpxq8nv0e4bK5cldjD8BjCqwEPyRvTaqhclH3HJHXWSOhNcG
	 FU80g0bvo6fdQ4y0wQzxBDS6cQtWEts3jYDV/AO/tdcvHhIDO9nklnP7xHhhyvor+m
	 BduTvHXZUydH0sbaud2yVtVzaoJNfDHHjuG2MQYnDkpRp6UJ1rXW0/RKG9CgQTetra
	 LzX6iIaXT2tlnZGnZJJq+aVqaCCQVe761Z1FYOw8CapwVzyv9J0sYV7kWUCD2oUGRM
	 KU1VmUhzrOOeQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Mon, 31 Aug 2026 09:26:30 -0700
Subject: [PATCH v3 3/3] iio: imu: bmi270: Use in_range_inclusive() in
 bmi270_write_event_value()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-minmax-in-range-incl-v3-3-30444a2fd2a5@gurudas.dev>
References: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
In-Reply-To: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
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

No functional changes are introduced by this change because @min <= @max
in the inclusive range in both signed and unsigned readings and hence
the check correctly continues to hold and is unchanged in behaviour.

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

