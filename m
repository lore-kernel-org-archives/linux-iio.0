Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204233689D
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918171; cv=none; b=YtmhwGvMNZy3UF6U0PZdXcBfupiMoWaBVIm+5xrtSMiLeWQxaM23+dQu4ztxaTFT9UyHDEqv/SeRwDcjEUA9ZuH0X6SWLr664ZEaOlu6fhtDzf3Y1NP1S/JlCd0Dr9aK2FiaO8Um8zol4QX52U6n/XMEjBIAhEaE8X+dI3v/bYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918171; c=relaxed/simple;
	bh=WrqL3yauu3lnqQOwYJcaBtVmyiMULhjAZfpSSlokRfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qdSvGUZJNIAeNAly/aaQ5ck3KaWc8QZZIvpM3goCsyKLHMTnlNOkvEooAWVAvzR/zBQpsTTTSRQ5RmjzrRkCJhQkNHLgE7DZw3PSjeKYtwP+/vUX1Fm/TtcuEz25k66EAhxQSvI0eFX1lNuxwcmH/TcO5ue8Os37m47ecYaHvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eTXDVB8E; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eTXDVB8E"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d55b97f358so7804026a34.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 13:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772918167; x=1773522967; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBhICo6K0vCDwfk5k1LFwGSmR+AACWQpZvfAyNHAL5o=;
        b=eTXDVB8EBn/D9oLg04HSY7pM0UEbg8IVS2sKv5LM+GLMsz6r7eU31bCEE/s5yUr5vB
         /kEBaAwe+E8hwFZY6Efy2o0Ya84B+3Ijm+ZqNzEQa+RRddh3dxD8NxrnWyQ8pAIDL/lM
         JwDmZXGyvl5qV5FOVb5Lfk2cRsi2so0qiZtJpdI8/jKfI/9/AXtNwRNdrsHyowiz/UbK
         RzzTyIEcmO6y8FDsnvGeL3u03KFJH/kyaQo+r7Oxo8jmqIjgZM32r/5xVRI1AGkdHuEW
         0dzGeU13SueKz//sagLBacj0hJzAgkq27y32giQyGGq8UW8M7cR04jjCuQEMwWa8DTp2
         +GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772918167; x=1773522967;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBhICo6K0vCDwfk5k1LFwGSmR+AACWQpZvfAyNHAL5o=;
        b=WQNseRg74ShF9yJcoVluKtj5bDD6AJ1G8esequcBQmmqdT6WNHn4HIkYuvFKGZvv0y
         QXzbWWscMWpGUGQg95K/TxZ1TEPzp4ZEXcKuwPdc2bgyHjTC12MmZHDqxj1Mi/gFhRCd
         ZFpQi7dgH5ePM3Bf1rCrEj8GujCvu+dmSHCv9q5aJ0Oj28z0fYgrhnm7LfAAOXwzxlcA
         72p0wWDeu7okyiMW11hnj4sWq2QPAvNTdaN5gO003WYdHrXyNTC+qLip2betwBw2RCpz
         2F5dYBD5lcNiGS+ghckiWarX9O2P8KR3r/r43J4aA6dTueTUWqX8pwGCOLZiRSU9Zk11
         W5bA==
X-Forwarded-Encrypted: i=1; AJvYcCXB322GTQzzTaNTwhpxnCMlCPuVh3VS+kpScW/9OAP3IB28Ep0iQyPBLN6sxpb3YMpA3vHIxrjVQ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yype6Gd0f8MDDUOHKdGBK1Zl8FUyLO7vjqsMX1xWITou/apfM3d
	jMkAW2ZyV71kr7NOR5SiQah2S3y1SQem/Z2j/SziZevJ1iRLiggRWMWgsXUs2yn5sic=
X-Gm-Gg: ATEYQzx6+RyKbX6o1eNUjNtAzLlxGLOC7TUxCVw/zWdY/GvQEtqM7fb6GmbM+HGnFms
	JS681zrHuMIwlSGElai9uIwqzRDxkFl/LgINa9CYBoMkerUOYm7UC4dIICcnN0wZLPQY8+tBVYc
	FgYwHm6ql9H1ybl5kzZ67lPVde8kkzKtr4OJCCT6ieR9D4JBNTTSdeCOnrDEOFVI1oM8bm8/a7w
	Qmgp55RDnbcfTcW0j/4+KlI/6CeD9Zcn/l/EaiSkHOKC/DK0xC8WQiZWj0hnJPTRV82ZQESq6S1
	75uyhKS018VxoGap5eMv835/tFZKt516F7ckFZNuBhW6DMMWcgEAesBV2nMMl0+Dh1YhzFdCa3v
	g9ZoCnj7OaNdjRRyWb8BGjg1jq4VFwWSfciu/jGUn8rtvf6vghF/+UPvSUsfRc4CbNUpSjgyjXk
	uFTSs1mwZ/tYaw/aVhdxaS9GdpBUEq
X-Received: by 2002:a05:6830:82cb:b0:7d1:90ae:bc16 with SMTP id 46e09a7af769-7d726f46099mr4612141a34.8.1772918166863;
        Sat, 07 Mar 2026 13:16:06 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d738e3f421sm1949310a34.25.2026.03.07.13.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 13:16:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 07 Mar 2026 15:15:55 -0600
Subject: [PATCH] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iio-adc-ti-ads7950-declare-dma-buffer-v1-1-79b1309338df@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBCF4auUWTsQI22NV5EuJsmMjmgrk1aE0
 rsbdfX4Nv9bobApFzg1Kxi/tOg0Vux3DaQrjRdGzdXgne/cwfWoOiHlhLPWKX1oHWZOdzLG/CC
 Miwgbhtz6LojQMUaoraex6Pv3cx7+Lku8cZq/cdi2Dxx8dbSJAAAA
X-Change-ID: 20260307-iio-adc-ti-ads7950-declare-dma-buffer-9d5269ffa8bb
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=WrqL3yauu3lnqQOwYJcaBtVmyiMULhjAZfpSSlokRfk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBprJWN4HnG8bBFned+R+PJCel5v86OS8sLgWD6O
 w0iwIgVTvGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaayVjQAKCRDCzCAB/wGP
 wIFWB/4mt5sZnK3pnw4mb9D3hxLc8gwRj4rzI8qvE+S5/MSGRSjBkuYihQnZYH140bDTyuiZdUL
 TBt5t9hC3hAWzEE2bzuOdS6AnXZ0P4VETLh0Bjb5CkwZ7laCT0reHqXuuqccXP52exNmrqyiG0T
 nyHbEFbFWv2UElE/KAodUZKyvv4c+o5sEE8zHaGl+MVgJLQQPnTaF5eYgS3KrHFHLcxl+seiTQa
 cbUUmHlKJInOE2Xv7BaIEVSeyEUhzlOyHD6z9Owl28fKq70gOtjlWIyj9uEjklKtSnDiRmEEVdr
 gRK5EsAzWzxluJD1ybKCxYWG7qC9HnmbbUPswZgBg1g3KSZ1
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
when writing the timestamp in the rx_buf.

The previous implementation would have been fine on architectures that
support 4-byte alignment of 64-bit integers but could cause issues on
architectures that require 8-byte alignment.

Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Since we were looking at this driver, I was going to convert this to use
IIO_DECLARE_DMA_BUFFER_WITH_TS() but then I noticed that we actually
have an unaligned access problem with the timestamp since we are
ignoring the first two elements in the rx_buf when pushing the data to
the buffer.

Unfortunately, this will cause a merge conflict with the series Dmitry
is working on. I don't think there is any rush to get this backported
since no one has reported a crash from unaligned access. Since fixes
should go before improvements, we could apply this to iio/togreg then
Dmitry can rebase his series on top of it.
---
 drivers/iio/adc/ti-ads7950.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index bbe1ce577789..53825c8b350a 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -47,8 +47,6 @@
 #define TI_ADS7950_MAX_CHAN	16
 #define TI_ADS7950_NUM_GPIOS	4
 
-#define TI_ADS7950_TIMESTAMP_SIZE (sizeof(int64_t) / sizeof(__be16))
-
 /* val = value, dec = left shift, bits = number of bits of the mask */
 #define TI_ADS7950_EXTRACT(val, dec, bits) \
 	(((val) >> (dec)) & ((1 << (bits)) - 1))
@@ -105,8 +103,7 @@ struct ti_ads7950_state {
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2 + TI_ADS7950_TIMESTAMP_SIZE]
-		__aligned(IIO_DMA_MINALIGN);
+	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2] __aligned(IIO_DMA_MINALIGN);
 	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
 	u16 single_tx;
 	u16 single_rx;
@@ -313,8 +310,9 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
+					      sizeof(u16) * TI_ADS7950_MAX_CHAN,
+					      iio_get_time_ns(indio_dev));
 
 out:
 	mutex_unlock(&st->slock);

---
base-commit: 6f25a6105c41a7d6b12986dbe80ded396a5667f8
change-id: 20260307-iio-adc-ti-ads7950-declare-dma-buffer-9d5269ffa8bb

Best regards,
--  
David Lechner <dlechner@baylibre.com>

