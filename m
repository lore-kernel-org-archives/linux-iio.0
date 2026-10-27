Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117991;
	b=I2N4GSHPBqWC/PXpI4SoS+P6l3SIuVAKsNdZydsdHlWssQ+Fh9gFSYQGwKUEEUB2ZoXZ
	 79CSuRAa35dK/BcC84HqEZ+65N7KDgFvuWglVfNyyjcki80zUOB+cK550i8kBTH4wHn5d
	 4D54lqJt6Kn4QfCnFzC8Eoe4IKx3uGCG9YuGe8jZbKL/3JukeDWpY2pnrRzo+jN/gmujP
	 UlxWZ6PHlBRmWy3gYgEuwCtNNW309BIIoEyRwfDtBQJ7WmTqHjFbfO4LuctxWsgphqTuT
	 89Ik+yHoeoOrbwtg/QU3+Uw7nkpNo2dyJbqYTe4je2as64mQFZEyC/OvDTnCBg1Gbug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117991;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5Qz954FfKhxiBvNDtW0TClzsDfBKO4noqaERMsBmA5Q=;
	b=t4EiJ9EQ7ENeT8R+DdrGnsMAAToZp2+v/XbAWLMuxjiu/31LY2nAqzuYEg3xsCxIzKuR
	 rmbBcsrrNdnCPMmvWyrXIz78IP2iR493fOsmuVSNHGfOUqtxiL/YGfrZ6ydIbzCa8+bL0
	 bRpUWpdoV2O0DlhYqL3QfPfWDWCu1FBpdc0rfSyXhhkzrDD0JkJWwpp/arNkZJh8KUGV4
	 NGVjx4mv9mFhRfsnCkmiucVLyl/CUOlPUHVsyxcUVX/wcCJCY1MTFT76rwOl9+CWZSPQA
	 o2p6aIHPA7ekxEgiNUmPAG4qlLOC5g3ZlZeZDm+qyIlSmC1hIAuGHv2LLvqBmfxEADQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=O9fWBwjV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372660A2604;
	Tue, 27 Oct 2026 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=O9fWBwjV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082151F01829;
	Tue, 27 Oct 2026 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117990;
	bh=5Qz954FfKhxiBvNDtW0TClzsDfBKO4noqaERMsBmA5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O9fWBwjV9fdtYBAbrFGLXW43ZXLP8e5Mly1RtNT/JEFdzMGZNJj8QlW8Le/fVF2K0
	 C2qTFKYD3VPnjcEXVeJuwlWUhlKNEAvQvav6fX3swuNh1FGvb2GxVdGxoaMFb4J6MI
	 b1xeSg0lEOkutVBnh/ep579I3+K9oMOoaiJ3AT1k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:16 +0100
Subject: [PATCH 12/15] iio: imu: inv_mpu6050: don't disable the IRQ under
 lock
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-12-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2410;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=BFJs09BfJW/TDsVBDvZCHtVCvlIyhy2kepf0ms+E/60=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjMfWXP1hGHkg2kF3i8Yyhk2L9Ka5m0u49r6+8jPm
 Ur5TxYs64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJPC1mmB93VnTDpnT/M597
 nu5U7tofJzA/3JxhwY2ElXnlLu2x236V1aYw/jjafe7WLAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

If the chip is a wake-up source, inv_mpu_suspend() calls disable_irq() with
st->lock held.  disable_irq() waits for the threaded handler, and
inv_mpu6050_interrupt_handle() takes st->lock to read the interrupt
status.  If the chip raises an interrupt while the system is being
suspended, the handler waits for the lock, the suspend callback waits for
the handler, and the suspend hangs.

Disable the interrupt once the lock has been dropped.

Fixes: 305914d01807 ("iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode")
Cc: stable <stable@kernel.org>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 38c3f3b398d4..0ae9d497ccfd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -2166,7 +2166,7 @@ static int inv_mpu_resume(struct device *dev)
 	return result;
 }
 
-static int inv_mpu_suspend(struct device *dev)
+static int __inv_mpu_suspend(struct device *dev, bool *disable)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
@@ -2212,7 +2212,7 @@ static int inv_mpu_suspend(struct device *dev)
 		if (result)
 			return result;
 		enable_irq_wake(st->irq);
-		disable_irq(st->irq);
+		*disable = true;
 	} else {
 		result = inv_mpu6050_set_power_itg(st, false);
 		if (result)
@@ -2223,6 +2223,21 @@ static int inv_mpu_suspend(struct device *dev)
 	return 0;
 }
 
+static int inv_mpu_suspend(struct device *dev)
+{
+	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
+	bool disable = false;
+	int result;
+
+	result = __inv_mpu_suspend(dev, &disable);
+
+	/* Not under st->lock: this waits for the handler, which takes it */
+	if (disable)
+		disable_irq(st->irq);
+
+	return result;
+}
+
 static int inv_mpu_runtime_suspend(struct device *dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));

-- 
2.56.0

