Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30086369990
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401569; cv=none; b=B1CUq2d5EdvBCBL4YD0q462mdCwMOz5qy67wlse9+sHQWwH6ytkNJPTQ1P9a5nz8DxPIkUgntYrktu3lc/aJR1Wp9CGuQ7h9gQnqOiuJGFWEHVSU/5pywFiSgvKCquUNQoJ2ahAjI2RzEmADC9PGZAOoFMo6Yx4NTqTuQP3Qizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401569; c=relaxed/simple;
	bh=3E3+6Hz6jkhxIgSdUSF7NWwAVU9eg2sDPOq+eO1xJgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXgjKZNgExRxLah3ueLuIoUORGYvAM0hZrcZbBtq26H0cINHfvYP9fw8qwtBBRSiRqNbSPAH1JKzXfa7jJDYt4p7I6V0FVkRk1GIayPRXAQ5lGiFyWaoI2MlCu6xp0lPBx2CoWhq8UN2D8b2dlUmVmEeeAEklZP/y0dKGqyEusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud6/7+x4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud6/7+x4"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a860667fabso3032361e87.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401565; x=1779006365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIf+gZg2PdDXH/QbSgwan1o/eNvfU6A5U8u+cFWpNQk=;
        b=Ud6/7+x4ePfLfVMaVd/esMwx8+rtpmKwZhKAAgyOMKOZq6c3GTFHWvAp9Q8mvBgykc
         XV6W0QdQevJV1pRUOG1nzymxFCYUbqWftvNrMCRHri85KC0CuRzbto2lryJIWqU94gQd
         apZPIaEIKo34KN3RcGH8Vdu7wbNMj7+a6ruU98ytrXPK02s42HZzIYTsYPiQuuYOnzLS
         3o61s6+7cerelt445Po83ystxpbUERYwuiwSabHbEkn3MefWNv7UNac5/5V3sLMUuCeo
         jKgdXQhdXN4VfTT8RoDHqd2vd22W2SQdVKBgqThb283QH2+gP7OzoEBcpXOxRw2m/9X0
         oQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401565; x=1779006365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oIf+gZg2PdDXH/QbSgwan1o/eNvfU6A5U8u+cFWpNQk=;
        b=oUvrYE4w+eynfbtQwIBDgTjIULj34ynIvfyPcULwdzjRBlqEHfChRg6cnGzjtpTBDF
         TLDcjaAnBGzMJ/MmBuLNj9coNOyK9vAw4F3Mj4fkaBTnBQVMu9ign8FVwO7B8iTg1Qys
         OUDWiW/bLeuhN0vC32xT5EvO8wc7fnzOdNWDLqwMBs4rqTPmf8DxfT6Y65iGb1hx19V2
         Fp/9wW9JMoyx7vfEXeLjD5VojEHHEe4+2EJ29QFb8ll90686tlYEtHIZXweKrVY0D5K1
         /nMTiKWDKHNldTtrF2+Zbcnzl9r/GaDOb1e9ktA/z33OSE0PT6LvpHJ1p9uPj/159f/L
         3wLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0QYS9535aVNhbw8oymHRsenWHNvP4AAk+wAh0nhV4Cs8NoQcmCeu0nhBzPNQ74D+SJ6RqAG63TBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtVYvGshS1QOClC03WI6ylduWsPGwIR8iu3bxVSAKxDcBkeRt
	EJXq5CX623AvuuMIKeVn49wY5ob6qvrt1nfkstUVIBgvWurRttcWzxKP
X-Gm-Gg: Acq92OGwiLk6le6WSVzoiEap064NpKLoGhDYG/k7SrfFx05jmQkeESNPieEA4zaCd2e
	PwxvVg6DgY1Ilz+6xgHOsnL9GSFabOwgNe3+Ge7f4q8rnwtWnROHddfP7aB61X+uIxIQuOZGELv
	5E8G4yXpWoppT1Vnq39J8P9CHCzB5VwP4xxBfQGycQsHGAl88osVkK8iYvbbLTcUePPYHdnpti8
	ypPCqbpvdvf/mehZBMuQ4gtgqqmSDs8+2ITF8dvYM1MUwrBV9fMFWveKvZIhcGJobAHW85Uwpj7
	2I9jJWSLL+6mbtLK6Cqz9EGFgGtZ98c+G8g5xurXskyAOSVuurQLfeYyG5IY8ZsAn3pOxDu6zOo
	umO1Fv8Zdm5B7TgRMwLl8Svdw+wdk+jvxWVIWUKEpqm8Lb6lLfUMB2MIpTrO1F1duae6CgCDf2d
	2JA0lNoMUd5OxMhckUUAYTCiN7vNODpRjp6peovbIO2ifdCJhUKb7A1r0nAqC55czK
X-Received: by 2002:a05:6512:1115:b0:5a8:7b52:946c with SMTP id 2adb3069b0e04-5a8a94bb976mr3086767e87.22.1778401564914;
        Sun, 10 May 2026 01:26:04 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4dasm17810681fa.20.2026.05.10.01.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:26:03 -0700 (PDT)
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
Subject: [PATCH 2/5] iio: accel: adxl380: Add timestamp to FIFO data
Date: Sun, 10 May 2026 11:25:53 +0300
Message-ID: <20260510082556.3867-3-shofiqtest@gmail.com>
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
single timestamp per IRQ with iio_get_time_ns(), and switch the FIFO
push loop to iio_push_to_buffers_with_timestamp().  The same timestamp
is reused for the event push call in the same handler, replacing the
duplicate iio_get_time_ns() invocation there.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/accel/adxl380.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index e7bb32fbc4..b8d0d15b00 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -224,6 +224,10 @@ struct adxl380_state {
 	int hpf_tbl[7][2];
 
 	__be16 fifo_buf[ADXL380_FIFO_SAMPLES] __aligned(IIO_DMA_MINALIGN);
+	struct {
+		__be16 channels[4];
+		aligned_s64 ts;
+	} scan;
 };
 
 bool adxl380_readable_noinc_reg(struct device *dev, unsigned int reg)
@@ -948,6 +952,7 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	struct adxl380_state *st = iio_priv(indio_dev);
 	u8 status0, status1;
 	u16 fifo_entries;
+	s64 ts;
 	int i;
 	int ret;
 
@@ -957,7 +962,8 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	if (ret)
 		return IRQ_HANDLED;
 
-	adxl380_push_event(indio_dev, iio_get_time_ns(indio_dev), status1);
+	ts = iio_get_time_ns(indio_dev);
+	adxl380_push_event(indio_dev, ts, status1);
 
 	if (!FIELD_GET(ADXL380_STATUS_0_FIFO_WM_MSK, status0))
 		return IRQ_HANDLED;
@@ -971,8 +977,11 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 				sizeof(*st->fifo_buf) * fifo_entries);
 	if (ret)
 		return IRQ_HANDLED;
-	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
-		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
+		memcpy(st->scan.channels, &st->fifo_buf[i],
+		       st->fifo_set_size * sizeof(__be16));
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, ts);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.54.0.windows.1

