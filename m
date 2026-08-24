Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E041A4E0;
	Mon, 24 Aug 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574697; cv=none; b=QQIT1leth4ECHCW6itZDJmZ7f+cwXfftR6mbIqlgR36CJYZk0PKAVqZGyLkAzeWpDl7Wuph38ttNgbJZJzI6SfPt8jOSz0xg0lf+/ZVMHu9lQ/vd+eS6zCpw89og4740SXe8IY0OLBydQPhuWDsEJQ8jZxT0xHN/uHlLX8lYcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574697; c=relaxed/simple;
	bh=QCU6ybMTej+JbME3Y8uLe9x6qDs9WyhgQ4MpAnIADYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSdANgQ0+0H4RUzgq0nOELzU5ojL/AKOhIkxpJmeQu4pS0mUJrQTXoHBn60pJfPC5KX1ypFAed8YqDRoVppwVvATAWj2mJsw31fD7ttyn8/jeDCM1DHZnx0K0xhDH56zRN4hZTsYKcrNiV68byl1lOlquv0zMHvTlanIqNfn8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSAKU9O0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSAKU9O0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6733C19425;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787574696;
	bh=QCU6ybMTej+JbME3Y8uLe9x6qDs9WyhgQ4MpAnIADYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JSAKU9O0PYj2L9UswmdTyeHUe6VP+grUTODEFiSgQpsH2MWAlmEt+t3dRj7Ho+eqH
	 hO8+CabebB6YYuhLYDJAhGR8YZSNQRjv5UZGRVHq9FYiUwEqUrpMFCYBg4XHEX93kS
	 55GpY737IBPA5SFTIs4NlCxprisXWxkkO7BTubm/JIAyuIUPcEpDEmi66t4OVJsTl4
	 vBEgYp2Gor9aaspEipf+iamB6L0pV4AilEq2vxo6rUEUfShYZrxHDw78YS4GmWPaOx
	 XSUdm/WjBjquEALweMrTymVm1SmhEn5rqPbk1txrmR8s4qNqEf0CcByFyYgrNlDAjF
	 WilT474CiyErg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C93C5DF9B;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 24 Aug 2026 14:30:07 +0200
Subject: [PATCH v2 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-inv-icm42600-enhacements-v2-1-0040837fde12@tdk.com>
References: <20260824-inv-icm42600-enhacements-v2-0-0040837fde12@tdk.com>
In-Reply-To: <20260824-inv-icm42600-enhacements-v2-0-0040837fde12@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787574695; l=2859;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=zSqZCZXt3vQQXgixrfVXug/hYSEOSR96v8Z7vTJ9wTQ=;
 b=YJI9IgVr8hcnwMOHHh5Mq6YLB3CiZwlm/1i0qFSAmX87D4SUtvpmbaHw78JA9s9WhfUNQ1gv/
 fVubuloT/ijCO6YdWQ4kzQXDBgoCbMFZF+BTAc9p340DysdDNxuvVWQ
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When turning accel or gyro on, a sleep is required for letting the
mechanical part stabilize before reporting correct data. Move the
sleep before enabling FIFO data to prevent push of incorrect data.

We need to unlock the driver mutex while sleeping to not block data
of the other sensor if it is running. There is no possible race here
because we are already under IIO mode mutex locked since it is a
IIO buffer callback.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 16 ++++++++++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 16 ++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 4b0e3cd8a506..3197081a808a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -254,15 +254,23 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 		fifo_en |= INV_ICM42600_SENSOR_ACCEL;
 	}
 
+	/*
+	 * Sleep maximum stabilization time before enabling data in FIFO.
+	 * We need to release the driver lock to not block gyro data processing.
+	 * There is no possible race here since we are under IIO mutex locked.
+	 */
+	sleep = max(sleep_accel, sleep_temp);
+	if (sleep) {
+		mutex_unlock(&st->lock);
+		msleep(sleep);
+		mutex_lock(&st->lock);
+	}
+
 	/* update data FIFO write */
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	/* sleep maximum required time */
-	sleep = max(sleep_accel, sleep_temp);
-	if (sleep)
-		msleep(sleep);
 	return ret;
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 253bf571439d..9de5c383665f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -126,15 +126,23 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 		fifo_en |= INV_ICM42600_SENSOR_GYRO;
 	}
 
+	/*
+	 * Sleep maximum stabilization time before enabling data in FIFO.
+	 * We need to release the driver lock to not block accel data processing.
+	 * There is no possible race here since we are under IIO mutex locked.
+	 */
+	sleep = max(sleep_gyro, sleep_temp);
+	if (sleep) {
+		mutex_unlock(&st->lock);
+		msleep(sleep);
+		mutex_lock(&st->lock);
+	}
+
 	/* update data FIFO write */
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	/* sleep maximum required time */
-	sleep = max(sleep_gyro, sleep_temp);
-	if (sleep)
-		msleep(sleep);
 	return ret;
 }
 

-- 
2.55.0


