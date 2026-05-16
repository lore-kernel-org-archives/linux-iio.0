Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0B2F7F13
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778966382; cv=none; b=RvLx15pKoSkcuRH81WM0aCigqjJuJPdUnh/RfA5QjsNi1Dwg2ICbRDWTNETWqFjprGCUBliBZtudSqL8omxvTqB/7Jot7QTEjoC8PkLTwJrC3gp2tRx5CuYbvbr2SOI2MXPl1m+GxVkTjjpH18KP6VRN+++wwKXxEKajwDvRBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778966382; c=relaxed/simple;
	bh=PC79iPS+240j7MFgm/wfU2Jxq6Do9p9oBBwpT5FYjcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4MF2v1pd9tcVcR2C30DQrfyP6be/6FEASobCEcw26lh4hglCRXULB7eZ2/8vwuyFu8ugxb0kHVzVJP7v3YD2Mj19EDQ6fOXgsSgTehKzXl4NwemDKsD+wdwaN622LvaUZeOEPy2uupq3NzmZ//OXFcs50cSV+NV97DrmjcreuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i142tKTF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i142tKTF"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a884815606so1417257e87.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778966379; x=1779571179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqM1dQ0E8jRDZSUeqjW3SdY/BoKmGuJOH4GMYl0BB8o=;
        b=i142tKTFctrrRadvAdSzBak8mvVzUdHLt26mSVwnrjPou+4uBNo7pNqkIFKx8XnyUN
         Q79GhYHlosZPLATkNq6CLUI+HiXcefIgscpo4U7WTx0Nt89g34XhsPqNpHjraUn/rpNd
         rF41PEwDF2dUh4ga1B64s/nk81SmiprOLQAs/Ty2uFYmAzxt3YhxuFn/UdAi0j/RtpYH
         Z0pzjPw8XuI8DfL7V5NgStzadnZJgzytuIXzI3DVf73TeVSo6kBwS7kTZO3N4JDOaqN1
         daQOZW9Fw9ASyoyQrbKX/oLjrt/K4PRY0Ad5FNbU5ANa6hsB8aKoJhBsrnGkuziC0BL1
         Ywag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778966379; x=1779571179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqM1dQ0E8jRDZSUeqjW3SdY/BoKmGuJOH4GMYl0BB8o=;
        b=Q5/nUstI8ocrU/YFLdCes+K2gmDJlGiCiN2dBnglzjtUvPi8O+SRxr02pLSfPKyx2Q
         R2O4kOzsgNHMS5C0MLvhYgeSlk0CmCgrH87Y1iaK7HHKA6awEhU9qQK47gamwVc29dvg
         cZpsjrSg594KsaI0WdfbDQ9LcfYT20pBQSmD+QOL7+r4sCotWHRsRSkaCTEbZBFqOFxy
         AwsWbLA2en4eYbC8RuKqSJMvzhuS6SUEHaQ05tvGCAhu8wMJE9uBdmJctklPW8MwTIwp
         PNGae+NZzWtdtDF92TlFuHPBs3lwH374wYpMxJYroRlL0y/ZFqC4KF+SG4MuT1+JWRba
         qDvA==
X-Gm-Message-State: AOJu0YxMtjKubFHBy/aL93lth+TORY+Um1aCVtS5JgxPI2zxVrQ1C4CJ
	VjnTW5mlRfdSls+L1SLafAkvZDqQh6KDcS+vmKIqohe6UmfLSd90TPPBBJZRFSdw
X-Gm-Gg: Acq92OHpBUxWyspKQDBup53C87naZmldWvZvmRt8rQX7u6FfuYv3OfPfNxramezFzW7
	VP0cTn+b2D7x5ZVHJ92cqTnQa5hSF174gkWyBtAvvitROilCQ/u77L4dBDs1iJaQG0/D9GqNK4h
	MWC0D3hy9SGL6vTljGQ5d7mI2d1qQLAV0JDFBMmiG1Tx28bS29SB31W92Lsll6LCU8EZ/ClExPS
	CD7RgWBklyzaeciOg/1+3nfIpoUENhQ8wuQuQWrRNyHS7sazMOtrMwaNbtAxFIgQL1yClpL7w8e
	PV+jdWhPvRfiiWhBWhIboIWCnyRYJGT79W+VDMevL4C18G6ysn13uXbelJ7c4uGE2yWtClGN5C+
	iUasOZFpInvfyiuFrMYRlPa8gnRGB7NScFLKQ0ZSXGBnZe7EtAHkVhziSbftwfGlE6X/7AuOS0q
	Nenk6hbcfpTaqDpgJGVYN/Rww67vnp/y3YtlKW9ZtZr+c77vtvDb5GqDPu
X-Received: by 2002:a05:6512:1106:b0:5a8:eaeb:40ca with SMTP id 2adb3069b0e04-5aa0e7426d4mr2496920e87.31.1778966378834;
        Sat, 16 May 2026 14:19:38 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c578sm2202070e87.12.2026.05.16.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:19:37 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: accel: adxl372: Add timestamp to FIFO data
Date: Sun, 17 May 2026 00:19:35 +0300
Message-ID: <20260516211935.36773-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver pushes FIFO samples using iio_push_to_buffers() which does
not attach a hardware timestamp to the data.  Capture a single timestamp
per IRQ with iio_get_time_ns() and reuse it for both the event push and
the FIFO sample loop.

Use IIO_DECLARE_BUFFER_WITH_TS() for fifo_buf to guarantee the required
s64 alignment, and switch the FIFO push loop to
iio_push_to_buffers_with_ts() which accepts an explicit data size and
timestamp without requiring a separate scan struct or memcpy.

Add IIO_CHAN_SOFT_TIMESTAMP(3) to the channel spec so the IIO core
enables scan_timestamp and includes the timestamp slot in the buffer.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
Changes in v2:
  - Use IIO_DECLARE_BUFFER_WITH_TS() + iio_push_to_buffers_with_ts() instead
    of a separate scan struct + memcpy, per review from David Lechner
  - Add IIO_CHAN_SOFT_TIMESTAMP(3) to channel spec (missing in v1)
 drivers/iio/accel/adxl372.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e375d068a..266e80e27 100644
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
+			iio_push_to_buffers_with_ts(indio_dev, &st->fifo_buf[i],
+						    st->fifo_set_size * sizeof(__be16),
+						    ts);
 		}
 	}
 err:
-- 
2.51.1

