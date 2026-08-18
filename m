Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48824BBF0
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089890; cv=none; b=cEwAg8Xk4tat8l8y1GMrUA9nsCvz+hJ+O7jHfQRegDJu6pFtVP9m1z/0FvgNLWZYjUTV2bzSjnYwUg6I+LLvlxBPjrdJUNs5rPMoQ8UQPnt4P9gMM9wFKgc0FYA7g6c6Bx1kPxZyhbQ3nfh0aUVX6hpgXfWvIIUUBqkc2YHzVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089890; c=relaxed/simple;
	bh=cADMsmusSrGSDye/opLwB2wLx0NWkn+4WwO7wo307s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prILrAlJwLfe3w7vMeIAw9Ln80zI3DDHZ3mRUDHd3/gnuh1znCBAsdvux6ZqsyqLYHJlNgaGSBUigAmiey3pnysTD7+oGKMI+sOxjBMGTUGt0MHUsyw8eXWZiKI6Ai0lG+nbRHGn0vn7mEa41drItr2V/oZqSU804Dqr/TQX8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0Fkw5pj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0Fkw5pj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f7027ca11so164881f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787089887; x=1787694687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/PFfEiRzL6XYiqizCiYq05ubJUY1mC7Aw3ATAk3dg0=;
        b=r0Fkw5pju05AAV832uYOpIumbCOQmQxUEvXOj1ridvO3Uea12VRT4tTwYu+jKHW+fa
         oIc+xAiu/9rm86BkiSkKo1foOkhQrWe/CO/8jmRrJdUnU01HzniE77fP3Zt7h2MehSnQ
         sG6zYeMQIa48vfCKkSuk2MWwOnLPQGaH4lkZZIxJXuAy4Z8YPf39CZiOniuAfNUFjwzq
         27BQKxTUGCI+3X8mQkz5fh2CRhU53UR6O8q8aFmuBmHyxEurE0eumjaEPEDowds9BWta
         BmI8pVw2jcLlbZYknBatkrATNRr7uEV3XmY8gkPNOStLDoct8Zfr1aZC3B+xZWorONsj
         MN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089887; x=1787694687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/PFfEiRzL6XYiqizCiYq05ubJUY1mC7Aw3ATAk3dg0=;
        b=PbeI2XS2622oclWtOPtss2UYMCxVHcVudD2s3Y4eNJf/Ge9NZY7ON/eu+z0PlNU+vR
         j6uW4xThUed04H0TmK3BuFodfTFcebXBEGNDRCMArXEHBVMCgSgTX5twDxVUq7UZpCO6
         F3Y5EE+Y5BnmVDyFAEkEPmelpJK8eOgUWzlyl84DOwc2jioZHbcMsNmWE7IS7wa0iwfZ
         gcqBzC0xJmGEcjTkMp+R4JMx8tEt4EIC0e7Z1Twm/s8hZXiP8a684nawOuYtuaB0JNkm
         O46Q1m7xLHiD5MH9QTwDu0mHe3XIbsFctYIMMblt9Z8kXP/UTj/CToDaeGe4CGSSXcEb
         jRpw==
X-Forwarded-Encrypted: i=1; AHgh+RoRwlXhWd0tQlZxz4Y2D9EVA1MKJeO51fy/24wsUIIRtfx3uzl162ipqY/JBbKcKpR6bRpXSSz/OLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpnlDpqzUGQM6hx7Y5Oqk8tOSBlvcZleYqloq33FIXvkg6mAEk
	+aJPaW56CVv7raortJ5vYYREZDTmvcANTRLpVjJ//QsvbxY2Q8QUCg+L
X-Gm-Gg: AR+sD13ctLf5u8Owgw/bZ/5KNz6yu3IYrvVJIItb71vH3yitnZ3It6hrd7GWc5VIGpE
	f+3ewxtg7zOXMEI9+6P/3SOEo5k0o+4tAjvD/XBWpDJOfeohBc2AVSw4mv3ceZ3ZC4mq9vS4lEr
	FEgXlCTCh6Lf0byxRwdDsU8wKWoZuv4mvS/fgs4pLEw0R0zhTOphCGiM4KqjkVbDUgnoaSkU15p
	zXKzxgA61ee9LaYu3DkndLIHRNDbr/KRz6dwyvxFDvKwraRubo1WvZmSRew3m07pD2+4C4Jw5LE
	McfpPq4XPtadPFav1/TUPeneq43D12Mss4X5OqAQlxch/yhN6OfXqq7mNgbqtqeu23IzNPxXjV9
	1EED5VdUNBuf1vTM0C9mAdJBBrkMVGcy1AgtJL5F35cH230N5NB2VPCgMNHLX9TuVRtD4boKd+5
	/Fo3QRhRT7fc9MB0B4TsOFdMW8bX98fuCMkylyZHOul9QM7fdJf/qHdP128KxiPI9mIPoHgIX2G
	85DtHWzeC7f88zq6GOt8AN2Wr5+BsuhOQ==
X-Received: by 2002:a05:6000:4b10:b0:47f:93b6:8d06 with SMTP id ffacd0b85a97d-482b0789703mr1977137f8f.0.1787089886836;
        Tue, 18 Aug 2026 14:51:26 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c33b3sm187546f8f.27.2026.08.18.14.51.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 14:51:26 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: accel: kionix-kx022a: use scan struct for one-shot and trigger reads
Date: Tue, 18 Aug 2026 22:51:21 +0100
Message-ID: <20260818215122.52715-2-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818215122.52715-1-grondon@gmail.com>
References: <20260818215122.52715-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver kept two separate staging areas that hold the same thing:
buffer[8], a DMA-aligned area used by the one-shot read in
kx022a_get_axis() and by the triggered handler, and the scan struct,
used by the FIFO flush path. Both are three __le16 channels plus room
for the timestamp.

Drop buffer and route the one-shot read and the triggered handler
through scan.channels, so the driver has a single staging area. Move the
IIO_DMA_MINALIGN alignment onto scan, since it now backs the regmap bulk
reads that buffer used to.

No functional change. get_axis() only runs via read_raw() under
iio_device_claim_direct(), so it cannot run while the triggered buffer is
active, and the triggered handler only runs while it is; the two never
touch scan concurrently, exactly as they previously shared buffer.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 02dd1db7a646..cf2cb751b4e8 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -301,11 +301,10 @@ struct kx022a_data {
 	__le16 *fifo_buffer;
 
 	/* 3 x 16bit accel data + timestamp */
-	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
 	struct {
 		__le16 channels[3];
 		aligned_s64 ts;
-	} scan;
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
 static const struct iio_mount_matrix *
@@ -613,12 +612,12 @@ static int kx022a_get_axis(struct kx022a_data *data,
 {
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer[0],
-			       sizeof(__le16));
+	ret = regmap_bulk_read(data->regmap, chan->address,
+			       &data->scan.channels[0], sizeof(__le16));
 	if (ret)
 		return ret;
 
-	*val = (s16)le16_to_cpu(data->buffer[0]);
+	*val = (s16)le16_to_cpu(data->scan.channels[0]);
 
 	return IIO_VAL_INT;
 }
@@ -1029,12 +1028,12 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	struct kx022a_data *data = iio_priv(idev);
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l, data->buffer,
-			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
+	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l,
+			       data->scan.channels, KX022A_FIFO_SAMPLES_SIZE_BYTES);
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(idev, data->buffer, data->timestamp);
+	iio_push_to_buffers_with_timestamp(idev, &data->scan, data->timestamp);
 err_read:
 	iio_trigger_notify_done(idev->trig);
 
-- 
2.50.1 (Apple Git-155)

