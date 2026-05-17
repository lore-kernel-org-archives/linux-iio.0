Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBF1B808
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009462; cv=none; b=glAA+lywNJ+LMSyumCXoeJAUsc7K4/hw9ymrBw5hLUvB/DKRknRzDwX0z/c013g/ffEv7pojYoDjUdPVszUnQjei0Myt9F5EcOfU6w8sXr+SlTwTQJ3RyMJAqHaAHEGueAY7F3Xjcf7h2hVranQbm3Snt4VcCQkxpCvPFIlkB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009462; c=relaxed/simple;
	bh=5BAU+BmcR/O5jbb0JHnDDdzDYzzCjh86VvMn9SLtINo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCGKzpoOLSDX+0qJFMjoo2lTtbTgaGL+iRI/ySIJvM3vAJqGpNYLeKMbY6G8JdU2O2U4FJKOb1mHb6lc1rmP83ekn26zG19wXQLJmmuOG7kysOiEJqEVStUF1jCnFLK+WG3DyOo0IOv8c7keWWGNCYSYwTpBSZUjyEwXcs7fPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmI5Vudi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmI5Vudi"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa1b2327c8so614390e87.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779009459; x=1779614259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsXVvKAHjvox1kSAnpaHc8zcTaIsvFES6v4D6Jm6txA=;
        b=GmI5VudiyRqGU5kUbEz1zrqgquMmDYJ0nqRrvgvUvlmpeZ6a0cfn/v3Q8tKX5koIwz
         FuGp10zdMbl7CtGlEUGINTtoQbGnfY/MSs5kRzgqbXY6T2gQzZnhWuYTIdf+o8zuyypc
         0gCon3pDowsB5oN0rHUMHSGOY0lE2X8AtioX9n/vGbFvbjGMkY1pG7cBeoQEnjmyB/8Y
         vgtHLTj8eN2nr2XbHsJT0okFiv2m8joTh+pVKCRRQ80mfX2oKbqYjEAJOVyUJvS5o3YD
         fkCWVW2gA2s9GRNRRvUn0U+Jj1FaTghEa8yHfH910Af6KVyeonXYWVyYY3cppfCoc4S5
         A0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779009459; x=1779614259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsXVvKAHjvox1kSAnpaHc8zcTaIsvFES6v4D6Jm6txA=;
        b=gbDfUO9xeKY6gsKFe+nWCQp5QlUsHaiGaBxjG+pIhv+BzFKgNj4wq/Z5EPAVVehh1m
         OqiRmJZwFkNpLj1rb0ijPlCOuMTWgZYPWq/53qpQE6dq15FY6uL6CqTo2siim7THE5OF
         smUXXUKMLpvUlnnx27rHDPPqZJw5PyIvorud156dgekyvpFeKaS5YkbRzuZtjCBVM1pW
         e0kDvUxip+OvdzsRek1volHOpzzQXDZB6Ejj+X7G9WAUMbROIGI+qZw/XYkJb5pmns1j
         E1CVguWr1emgxXOBVj/bgF3Suz8Zq8uLD2vsJAqIHjt1MJajN9iP4C9HUDqtRm0+h4Dv
         Gipw==
X-Gm-Message-State: AOJu0YweLyweOaV3DeFAPR8ffuT3olMkIn3libG7YSP7xflPR0xvt/xz
	AVjqpJORY3SUzgNe548QXp3Gbu7/UoRiE1w7zRaZh7wEaUzkZsPC3vX6R25+1VUq
X-Gm-Gg: Acq92OH3+c2DJiePTFqSzfarOpO5AXe29YK0U73dNhQsCzAha44xA0zMc3FQMbH3MMo
	XiYtQQ7EGTNSpqvvDVyTvcD/wXPTL9kW3vQkTwPT9SKDC6I7LKWmZRHUAsTSPY3/D0UAPquDmk6
	iMTcZMC0aRzvKra3tK4bjPNF386bCvnzZ0lt1OtZZnMc5Q/kC00Q4jWw6z9yIPuOW24kVqcZxtt
	/j0iLQTV342SS6rfiyJTxUxkUx13/DYr+6eC3RYCzS60z41B+EIj2P2yJEgu49ShQedp4gpXBa2
	dZKbSdFO+mCRhxK/PZ0KFsOL8QvhXrWCnkj95LaxxnoswiZk1qhOsqUnkzUeDmGKCGJr2IYW8Bc
	Mm3VoLFH2gtim0yW3okiYlYjN+bmdrXsvFr7kD5JkziJFd0hpYchfhnN1ALn+EKoyJ9zLYIukQr
	2X7LeotsL+uGOx2LnN9fJTkmp/WfRHTD93TGN96rqlpEEJuRKQy5JrRElV
X-Received: by 2002:a05:6512:3b9b:b0:5a8:950f:e92e with SMTP id 2adb3069b0e04-5aa0e73059dmr4489926e87.23.1779009458578;
        Sun, 17 May 2026 02:17:38 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11a5casm2603434e87.29.2026.05.17.02.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 02:17:37 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	shofiqtest@gmail.com
Subject: [PATCH v3] iio: accel: adxl372: Add timestamp to FIFO data
Date: Sun, 17 May 2026 12:17:35 +0300
Message-ID: <20260517091735.135610-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260516211935.36773-1-shofiqtest@gmail.com>
References: <20260516211935.36773-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a software timestamp to each sample set pushed to the IIO buffer
during FIFO readout. IIO_CHAN_SOFT_TIMESTAMP(3) is added to the channel
spec so the IIO core includes the timestamp slot in scan_bytes.

The timestamp is captured once per FIFO watermark interrupt via
iio_get_time_ns() and reused for every sample set drained from the FIFO
in that invocation. This is an approximation: the single timestamp
reflects when the interrupt was handled, which is closest in time to the
last sample in the burst. Earlier samples in the same burst carry an
increasingly stale timestamp. This is acceptable for coarse event
sequencing and consistent with watermark-based FIFO readout in other
IIO accelerometer drivers.

Use iio_push_to_buffers_with_ts_unaligned() rather than
iio_push_to_buffers_with_ts(): the latter writes the s64 timestamp
directly into the source buffer at offset ALIGN(data_sz - 8, 8), which
in a multi-sample FIFO drain loop overwrites FIFO entries not yet
consumed by the next iteration. The _unaligned() variant copies each
sample into an internal bounce buffer and leaves the callers data
intact.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
Changes since v2:
- Use iio_push_to_buffers_with_ts_unaligned() instead of
  iio_push_to_buffers_with_ts() to avoid writing the timestamp into the
  source buffer during the FIFO drain loop (Stepan Ionichev)
- Update commit message to explain the single-timestamp-per-IRQ
  approximation and why _unaligned() is needed (David Lechner)
 drivers/iio/accel/adxl372.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e375d068a..b108b214b 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -344,6 +344,7 @@ static const struct iio_chan_spec adxl372_channels[] = {
 	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
 	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
 	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 struct adxl372_state {
@@ -365,7 +366,7 @@ struct adxl372_state {
 	u8				fifo_set_size;
 	unsigned long			int1_bitmask;
 	u16				watermark;
-	__be16				fifo_buf[ADXL372_FIFO_SIZE];
+	IIO_DECLARE_BUFFER_WITH_TS(__be16, fifo_buf, ADXL372_FIFO_SIZE);
 	bool				peak_fifo_mode_en;
 	struct mutex			threshold_m; /* lock for threshold */
 };
@@ -703,13 +704,15 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 	struct adxl372_state *st = iio_priv(indio_dev);
 	u8 status1, status2;
 	u16 fifo_entries;
+	s64 ts;
 	int i, ret;
 
 	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
 	if (ret < 0)
 		goto err;
 
-	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
+	ts = iio_get_time_ns(indio_dev);
+	adxl372_push_event(indio_dev, ts, status2);
 
 	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
 	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
@@ -733,7 +736,9 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 			/* filter peak detection data */
 			if (st->peak_fifo_mode_en)
 				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
-			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+			iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->fifo_buf[i],
+						    st->fifo_set_size * sizeof(__be16),
+						    ts);
 		}
 	}
 err:
-- 
2.51.1

