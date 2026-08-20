Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586A2F616A;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252564; cv=none; b=Je/X0Q/2QDAkj4pX3apAgavU74N9AMMnoGqK33mR/GvBUO+QVIo052Rd5TI/tlH0LG/dBnLDrB8DU8I3j3IS/Lsx1k89z6mgPICszX5DbR8uaOWXQ1GDkEkUibfLYrXQ0kwgR0Ut0IM36ysSCQQmiLzmvcgT/O/p+I2KJOFvC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252564; c=relaxed/simple;
	bh=0+lKZtAUGxYGhdYt52Oe+klkPEFhqiKENBd93lJ9oDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6RM5pSbaUVDvoclJe2ucLV8TDFJaRlu/a3wNPhWPfh8affIXKg7IEyihKZ2dubXu9ZK+BewzO1DY5HpWFRoFVM3wTuJje2p/iU96TZ2bD/CdGzLW4PAhNGp1Dm7Ebojbo9wr06bNrlQph7ksJnz5lEKu292dfCARQ6Vy1KYLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFMb9Y6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFMb9Y6f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04638C2BCC7;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787252564;
	bh=0+lKZtAUGxYGhdYt52Oe+klkPEFhqiKENBd93lJ9oDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nFMb9Y6f1e5Q8mfQgKd+SGnaICOAeHrOXI2E+0dzqwT8QAueIP8rbcDzyBMWzap8m
	 6S57Zg3gMr0JwB6iPOWZKOwiLKK3zTTZIEVaJVFP9z5PoXzALD0+ICTv88k0LyPzpf
	 5tEFPLtgs4dh3WRanR1rhlY735WtESMihqeOaWap2WJlt1pSivGOaU6ZS7oAgDUHGT
	 12XJ42Ph7BH2tRyAKzepKsY21ZbllGUtvsZu6v+cJnx8025SN9MpDO69JQqUjbill2
	 eiecSnxLMMXWy2iPXa645waMh3xLviXjtIgsu0lOOJwf/0L23RxURm6lnETq76RYVB
	 xAvV8ZENf2XQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718AC5DF85;
	Thu, 20 Aug 2026 19:02:43 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 20 Aug 2026 21:02:37 +0200
Subject: [PATCH 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-inv-icm42600-enhacements-v1-1-075a881db557@tdk.com>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
In-Reply-To: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787252562; l=2310;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=+bwsfyS+uWdp/eU+N8iIh3HLaiG1bPAzG41AqLrkjT8=;
 b=zEpsW03HkfJ8KN0pMsxC03QcysYWGYv2K7XFHKKbROlvxXlsVLrNVgpoqzH1JqoIqtdXkXOVE
 lcm06IPv1jBCQm1ngmRqVFbxAjqSdiSMOkUXgLcw//587Tv8vNDc47C
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When turning accel or gyro on, a sleep is required for letting the
mechanical part stabilize before reporting correct data. Do the sleep
before enabling FIFO data to prevent push of incorrect data. This is
required if the FIFO is already on because a sensor is already running.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 12 ++++++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 4b0e3cd8a506..d889c1dceec1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -254,15 +254,19 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 		fifo_en |= INV_ICM42600_SENSOR_ACCEL;
 	}
 
+	/* sleep maximum required time */
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
index 253bf571439d..34037b9c1f82 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -126,15 +126,19 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 		fifo_en |= INV_ICM42600_SENSOR_GYRO;
 	}
 
+	/* sleep maximum required time */
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


