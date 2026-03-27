Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6213E0225;
	Fri, 27 Mar 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608007; cv=none; b=sT9EXr8IpNw6xSOD4RwlgH6to0xVdH0wsb4yhkw7kqCbuLEmpMXRVVXujGz4+QqYc8ODOB7tRGlz5n4U8MQCDU2+nC8UQTy2vu9q4tXgMTwBEYDgoz6Eh5HN1LHi8hCcvBtgXCG4pfvAGWYKk2TR/mS51axbE84ljvOgrq2sNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608007; c=relaxed/simple;
	bh=UhK3nMg6cqK3TjkYtlNwnFqMu2qyrZHHKcrLbLoBuzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYacK7biCcqUrLiNQLM5ha7H2zdm0rCAk1B9v5I71gDVVx9iPny38YsNynbGZxqzGsCYJVt8aEGt91bHQH0gyihW5mk0IAcM/QcmwvQmxwV75yz87fxjrU9Q2EFNlTIReCdZzCwBZtapTTWj0b1BBTpMY9KCN8E2M7zx+CwapUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: rastyoginds)
	by air.basealt.ru (Postfix) with ESMTPSA id D7DC9233A4;
	Fri, 27 Mar 2026 13:32:02 +0300 (MSK)
From: gerben@altlinux.org
To: jagathjog1996@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] iio: imu: bmi323: Fix potential out-of-bounds access of bmi323_hw[]
Date: Fri, 27 Mar 2026 13:32:02 +0300
Message-ID: <20260327103202.459143-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Rastyogin <gerben@altlinux.org>

The bmi323_channels[] array defines a channel with chan->type =
IIO_TEMP and enables the IIO_CHAN_INFO_SCALE mask. As a result,
bmi323_write_raw() may be called for this channel. However,
bmi323_iio_to_sensor() returns -EINVAL for IIO_TEMP, and if this
value is not validated, it can lead to an out-of-bounds access
when used as an array index.

A similar case is properly handled in bmi323_read_raw() and does
not result in an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 6bcb9a436581..64ead4f667e0 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1713,6 +1713,8 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_TEMP)
+			return -EINVAL;
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
-- 
2.42.2

