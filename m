Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9B368294
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401572; cv=none; b=fAWWfWZfG6Iqc8V9sJtItKn4FOT5xZ+izI4VQyjAL+9GE107hk6TwLjy+FRx4Lc6TtMdTxrDVGO4yUGRYt99ahLphWDd9xpMMHh0DrARAukOPZ4MEUJkXRnuhNMKfycHlJB3NmsarfIg/vMvb92z9YTzGmdpdtWTfdbF81/4PkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401572; c=relaxed/simple;
	bh=+YIe7oRvJo8UIKQmlfWHLG1pSr8JwM13JxLnWH7+BhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSBxsWWsPRWfnna8ohDCoD9cnj3udhiRFnYSIMYFt5MJj7Fvtzk4MmOVhCab1JfI3CDrydu6wKKe5q1XsiBeXTK8whu+RaTr0YpDpAG8CPSyKP9Tr+/MZ+7KJF61bXcku8XZRAfYN5NflbvNqhYQ2nBK59RnMSkv+CcZPa3AQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCU5ZLoP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCU5ZLoP"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-393c93a0166so32870611fa.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401567; x=1779006367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHLxkH4NFWNDSnPeUf1ZCI9Mer6WRfMTeMy6jSpJ+T8=;
        b=CCU5ZLoPzdBa+qdHWeXMODiJS9PWwqmu5x939ZfQ8L/p8dk17WOMHQz3TBk98yGxe/
         jnJTP9NMejpufJfuYG5vbxQx8TsW3PVq5ote1vG6caZW171xaGCpDxcUC0757zqqfPHt
         OABNuXbAIa/gzd20sgGJvOPtYrOHYDdbWFRhJDI/Hxvz0hqfHT2D2t4ZZ5EmQYViLbhc
         dk4DPAQ5DA1xo9mP8HN9SOJuhafklbunAEd05Vd0ot2/8FGnTNJ1qW+7kdYFmqUKFtnL
         FiBv74+abRHpRCIj5R23xyrtqN6vN5+FWM3slkeUYAkhMejdIMcla/06otfES6bUajh0
         gMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401567; x=1779006367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHLxkH4NFWNDSnPeUf1ZCI9Mer6WRfMTeMy6jSpJ+T8=;
        b=sZzYvgpNDF63oHcwlO5JhVFIuLR4hO6kduCoy2SzPvcJQWMn4vG/avcqjxvR2mEpvy
         lZFcFKGevazHsDp+iaUPEDiUJ+ld07j2GmGi9XmR9bxeOGy+t9HCEtamBa+WMO6cGTQ1
         A9mT7mbdqvtwKYdG/CiqGWg+F7fPyCz+Yv+kdcMs6r2tvTixUIB/dyRHw4WqlI9rRpfN
         REGXv3bENKWK4raL2g+kr0XSximFz2d88XrBN9m3aVGhJwhAekpRk5kzcy51t99ClgTM
         3J+Kp6aCEUHliSXzlKvjJBLIiEW538JV7Ivi/VKP6j9na5BtMP9GfSY25/rQqhR0UnOv
         blZg==
X-Forwarded-Encrypted: i=1; AFNElJ/HJ270POU2LgMmJHi/ioTGJWo2drBzZxRgxxTOqhdHHh/DAf45AqEm1GTntnGfz/xxhSG661RcZF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvst63vLhgfgUK2mHXV5pkMukRiy7hQ5DfO4XN4nhFOgQGRgC
	PtRNHL1nSixs0vvSbDuWd+SqCNxmrn/8lt4Do9i9J7RNR6LhZw9cRYKj
X-Gm-Gg: Acq92OH2dacJIRNEQE+VZ0zSCPvGxP1aUfjW9MdJiWiNeUqJjHFlu4QRmgiJC2+mdMB
	oIufBLUBsPBA7nbAjt+gbiThRzmXtgMfYWZCLQ8lyd1cdayjULTmLA8jjEs6Dk1rcMuegFju4jl
	A1a8sRmfQeU4AEkLvQF2+d+0627wlksdPjm2mx9WNOUzJn+9bVR7x7sc0zUminyJMSz3cpDpWq7
	fAwbi70qVtwY9zUsQspQFmh8lAjkMwFD2es5TsXM+xRK7objg5vAF3uAiKU+iI6jN81yqEZcpCK
	/t8WhvoZs0C9A0PGkEbN9T+jNoAtfdRQx7dqBJNapyYsGzu5uCfK4KKJGGDjwj7ihuMlzEx9l5B
	G8YFx1WGs6iYmsAyb04MJ75t7JqRB3seWtUVkc1GIZS+1SHy03Z0eKPSmqxQ117O9dAMfz76ooe
	U/mtEEmfrE8QJkMirzRo1r82Hvn/EUVakxspeKCv9e9Qr8A0n9uywHW7JBEBcZSTnW
X-Received: by 2002:a05:651c:19a4:b0:38e:294a:d447 with SMTP id 38308e7fff4ca-394081970f5mr14151401fa.28.1778401567240;
        Sun, 10 May 2026 01:26:07 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4dasm17810681fa.20.2026.05.10.01.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:26:06 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 3/5] iio: accel: adxl367: Add timestamp to FIFO data
Date: Sun, 10 May 2026 11:25:54 +0300
Message-ID: <20260510082556.3867-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260510082556.3867-1-shofiqtest@gmail.com>
References: <20260510082556.3867-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver pushes FIFO samples using iio_push_to_buffers() which does
not attach a hardware timestamp to the data.  Add a scan buffer struct
with an aligned_s64 timestamp field to the driver state, capture a
single timestamp per IRQ with iio_get_time_ns() in the IRQ handler, and
pass it into adxl367_push_fifo_data() (whose signature gains a s64 ts
parameter) to switch the FIFO push loop to
iio_push_to_buffers_with_timestamp().

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/accel/adxl367.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 0c04b2bb7e..2852f2fdfa 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -179,6 +179,10 @@ struct adxl367_state {
 
 	__be16		fifo_buf[ADXL367_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
 	__be16		sample_buf;
+	struct {
+		__be16 channels[4];
+		aligned_s64 ts;
+	} scan;
 	u8		act_threshold_buf[2];
 	u8		inact_time_buf[2];
 	u8		status_buf[3];
@@ -779,7 +783,7 @@ static bool adxl367_push_event(struct iio_dev *indio_dev, u8 status)
 }
 
 static bool adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
-				   u16 fifo_entries)
+				   u16 fifo_entries, s64 ts)
 {
 	struct adxl367_state *st = iio_priv(indio_dev);
 	int ret;
@@ -796,8 +800,11 @@ static bool adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
 		return true;
 	}
 
-	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
-		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
+		memcpy(st->scan.channels, &st->fifo_buf[i],
+		       st->fifo_set_size * sizeof(__be16));
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, ts);
+	}
 
 	return true;
 }
@@ -809,14 +816,16 @@ static irqreturn_t adxl367_irq_handler(int irq, void *private)
 	u16 fifo_entries;
 	bool handled;
 	u8 status;
+	s64 ts;
 	int ret;
 
 	ret = adxl367_get_status(st, &status, &fifo_entries);
 	if (ret)
 		return IRQ_NONE;
 
+	ts = iio_get_time_ns(indio_dev);
 	handled = adxl367_push_event(indio_dev, status);
-	handled |= adxl367_push_fifo_data(indio_dev, status, fifo_entries);
+	handled |= adxl367_push_fifo_data(indio_dev, status, fifo_entries, ts);
 
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
2.54.0.windows.1

