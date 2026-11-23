Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440341;
	b=MO/owrKXJq8tIn2xXBbBdrZbsZelRyXQBWWIqCRfamTYQiHxoPO0VfUOQ+KTycAMKs2r
	 iV1MYlccwwwDp/kKMpNypITuSDnrrTczHlJO5AlQoBMGDDS0fO76UsW1nYZ8ZI8VikUTD
	 CIhHrhPSgvnfFvdcfhNRPKKNuk4m9s0RaHR9TTMnU3RFIUdXhHzCYCZtB2wgjEI/j/M1C
	 EtYiq6yQ3SvtzHNSlris+lsa18fkUnoIFqHip6emGTTFIXk7Ih7kEGidZC2Axxy3HNOQw
	 xGy0lTjUAC2SZI+QLk/poltyooSf/N/jc4Kdok9k4WzPyAD3jYeqQsUaIBEAX664YHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440341;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zztcXn05wIUkS3ZMZmgNy/x1mUVakpxeGhULnaIa73w=;
	b=mdVbITUOlfnjxDIIDIlnuC6hNpRHa/ZPZvotxSMrngsVVeU3B/y2R+VixFAxw5PxNEwK
	 +Omr3VHW88fZAxPs2k5VtYuYLzQobyc/vxejh8WHf367b68mbSW5nPmVKRTM0PPjXK82s
	 kpdjDRKtbqlQ1tYfLoirRmrK5FfVoHFFJnga4QHFjfAzUlBEmkktr1mFeFOgStgtOGaTP
	 oYf5zuCSJ5amhdL/+Hycv4FDRMrfN6hjKmgV7/9AeLDirey1HfqmKiZAxeyDJModctR6E
	 Q4URGcYsNqDE3vrCAQhkN75v47zrxbEO9FulS+cPIi4AwcT9Om6m7ydahYtn6nA3/IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZnkie4m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A1606A32D;
	Mon, 23 Nov 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZnkie4m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795440340;
	b=ssRJIGLDUYq+ZKQHybNKKaQmYrVrf50KxLscW7JX/zNVIwowgMM3CXh4c2nwwncHJtQ3
	 DEADo91EVtlrDYEP5EBQcLhzPmqgt0Wtac/BNCyQyJSexI+l7syej5Xp3t+yEE+DYO406
	 fj24mVa66cdx+vLaVpbiP4yydQTwvSyphs/08AnWkmbtgvDixq5gFG7reF4qNW5DSuiWh
	 PpklDZ59M7ZOwFFt6s+43VjOaqCW+Xops0k0g74ilRiFKO+lJJXaEiLzfM8U+1TzfIDVo
	 oob5MJRBCbT9azMNWCLsVnv04vAh3ssjG5YaSb7XBShntiMc7CauAOgcILhBlpIA27g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440340;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zztcXn05wIUkS3ZMZmgNy/x1mUVakpxeGhULnaIa73w=;
	b=VWzHggXWDRe2HrD8mEmW4zKsB73lfRb4yr5ZZxWBuTDITGGfd1rH8kHrf3Uy/aU769fg
	 a2IuMSb888LTXwjgz3krzRdARhEJGoC27l9JfeBSKLxod0MlQgSPBCVAkxEO2wJsLvnEx
	 NeEKgJFk7h6wLxTLOO46Due6YYHTMRoifMeRgAx+SrQ2swZJSxw/ORiMnMbMp2qQH5BC8
	 cEIal1EUkTpWcdxy+ETmAuypTBj4oJaZytjuysSDRQE0TbFHiJ5U7uJsI66k8vw5P5bJ7
	 66qY6+sGC6tsZkI5UadI4kp4RZgQaht8G4x/NT6S0bnr8P2fNZjadzZQXL7qvQVOQ2A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 254C01F000EE;
	Mon, 23 Nov 2026 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440340;
	bh=zztcXn05wIUkS3ZMZmgNy/x1mUVakpxeGhULnaIa73w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fZnkie4mTON040KIDvp6W9Ip+S2vX9ymzV50TAcK/DJCrSz2MCZcbkVOmvfoG3WmS
	 UNJ1hiPgyWhuoX3JH6G1GAaVlpcsfEw8sBkF2fAEGLtwsphyDvJVzAilHhBUBTaYG4
	 WJMB7PboMBAEoszs7ED8kpiyQVJOUu4VIYO1s/nE1VPOKFg72b8c0+wMON7YDWQ+GG
	 IXG8f7RjpeOQ34+OrhcAAKG0eA52lohQs++ergaWty+k4qqcfdbrqQTyhPF28T6PKF
	 sCL28bX1WiyojsKBiGrRxG3AxWIvR2DTYcv0orL2WKeiNDYB2G8qNcGbvnTYfGyJYC
	 Hi6zJrKi8mGAA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A387F4C499;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 23 Nov 2026 15:25:27 +0200
Subject: [PATCH 3/7] iio: imu: adis16475: Pass the device and timestamp to
 the sample helpers
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-adis-fifo-v1-3-f6ad9e493e19@analog.com>
References: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
In-Reply-To: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
 Radu Sabau <radu.sabau@analog.com>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795440327; l=3328;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=5BQh5nF/fg8PKi8MMyTgUuL98vgwuiTzBq54Q+UqpWE=;
 b=q2YFzwSQWfu2gHQwKBpHl5wuv4anAQhOy+JEIIRBzIuzaEN2C83xXwkjK/xthkSrgiid9zMyF
 PHzStZfAEqkAgwwpcHm1AnowuvJqGuYXbv+Ew+oJJCu28GShbFSiNSa
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

adis16475_push_single_sample() and adis16575_custom_burst_read() take the
struct iio_poll_func only to get the IIO device and the timestamp from it.
Pass those two instead, so the helpers don't depend on being called from a
trigger handler.

No functional change.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16475.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 44520d9216a2..6922ffb48516 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1561,9 +1561,8 @@ static void adis16475_burst32_check(struct adis16475 *st)
 	}
 }
 
-static int adis16475_push_single_sample(struct iio_poll_func *pf)
+static int adis16475_push_single_sample(struct iio_dev *indio_dev, s64 timestamp)
 {
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
 	int ret, bit, buff_offset = 0, i = 0;
@@ -1652,7 +1651,7 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
 	}
 
 	/* There might not be a timestamp option for some devices. */
-	iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
 
 	return 0;
 }
@@ -1663,7 +1662,7 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 
-	adis16475_push_single_sample(pf);
+	adis16475_push_single_sample(indio_dev, pf->timestamp);
 	/*
 	 * We only check the burst mode at the end of the current capture since
 	 * it takes a full data ready cycle for the device to update the burst
@@ -1694,9 +1693,9 @@ static void adis16575_update_msg_for_burst(struct adis *adis, u8 burst_req)
 	tx[0] = ADIS_READ_REG(burst_req);
 }
 
-static int adis16575_custom_burst_read(struct iio_poll_func *pf, u8 burst_req)
+static int adis16575_custom_burst_read(struct iio_dev *indio_dev, u8 burst_req,
+				       s64 timestamp)
 {
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
 
@@ -1705,7 +1704,7 @@ static int adis16575_custom_burst_read(struct iio_poll_func *pf, u8 burst_req)
 	if (burst_req)
 		return spi_sync(adis->spi, &adis->msg);
 
-	return adis16475_push_single_sample(pf);
+	return adis16475_push_single_sample(indio_dev, timestamp);
 }
 
 /*
@@ -1748,18 +1747,19 @@ static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
 	 * First burst request - FIFO pop: popped data will be returned in the
 	 * next burst request.
 	 */
-	ret = adis16575_custom_burst_read(pf, adis->data->burst_reg_cmd);
+	ret = adis16575_custom_burst_read(indio_dev, adis->data->burst_reg_cmd,
+					  pf->timestamp);
 	if (ret)
 		goto unlock;
 
 	for (i = 0; i < fifo_cnt - 1; i++) {
-		ret = adis16475_push_single_sample(pf);
+		ret = adis16475_push_single_sample(indio_dev, pf->timestamp);
 		if (ret)
 			goto unlock;
 	}
 
 	/* FIFO read without popping */
-	ret = adis16575_custom_burst_read(pf, 0);
+	ret = adis16575_custom_burst_read(indio_dev, 0, pf->timestamp);
 
 unlock:
 	/*

-- 
2.43.0


