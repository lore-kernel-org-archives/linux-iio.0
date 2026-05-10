Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D536C597
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401573; cv=none; b=V8SoAn72jDRI4sVTsdNbh1bXtJMyv/BXjYko8QPdNl9SSjpI4f7lbMCc2lB2ryInHiI1aCQkIpqHeZ5Tkv9oy2CDZhdOHuuchYa+V+sV/tK4cWG7GrM5OVHD7RXpf6y4Bftpt+7GoKza019+erCxtAz9Ftx9tQ2GWX8VBrfBSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401573; c=relaxed/simple;
	bh=iaJf4eQ8HxR6dXQrwEH11DB5zzXKQDKlPWgeVb4A6AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBiOhTbK+nMKTFzq5vGubQzeaMo3sid4HTfNlyorg9Dm+p7v95OR2tqEYtXWGLeq3QkqKVAFQgBkMGK3xC+a0CJWxxYmb2IE7WTHOQAiv8+tzR4n9AWpOYiSA04Mn4sRt8F+h/kmuEDwLUrW7AC/jzRqwKRQ9mDdDxkAyjqXpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m35KTjlB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m35KTjlB"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38be5e86918so42451241fa.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401570; x=1779006370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+59MZJaWkQ0G1PO4esX2L0KFQJFCEFOuwsd03ctIGgI=;
        b=m35KTjlBno5uWoDpocK+m1a84Al+8z5c+ljMRczSvOaFoIWABqzfdsbkzQFheREQ6i
         C3R0xNw+MYlmnno2j3nYTT/xnZ0VouOQ+i5Tfz2ubk44al5vi1mD5xAkwJJPJ1lojruG
         82XiQYqKhJ89OVuiHoeAes286o/idtsYGBzjL4uC4Bj8VTkVpke5EszjCRsKgr9zi2oI
         rJ9pVmtkkdH1x9yz0hoE+ZKQmv960ffa58FSW/o1C+6AlBYzRxDcq0FqASY+SW4AfmgL
         deSmQW8WwcRhqyHkdDXV55TVpScjy/WwQ0wwgJmcl0HquG7s+GNgi/Ung4faNImipRzd
         TlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401570; x=1779006370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+59MZJaWkQ0G1PO4esX2L0KFQJFCEFOuwsd03ctIGgI=;
        b=jKgtFPDuFHogNdYBNnf07o9+aMpEb4jpNpUkMuusUocJu8rn25ysJQX4JZ6mcaRqHl
         snJTTk81wNjfHXVpiKTzNJ8amFiv4lUGQMvu1UbC+46fAh8S+4bjjbZYV2yp29jXgTHu
         1FrmgrrFxwfeFxuRZTxfcXfWUeDWllc0/+KzPbzSXAjSWIzFP4jhPl7O9Fjr+9OhmWzw
         c5Sig6XXAWV67801keTuLG5mMtxdLcLJ5r1vP3yp2CxgzbFvoLuHSS4qVltQXmPUOEfG
         2MpPwADZ7FrijSa9856BVMtedS7btHK9O4JUrxhBv/XxBlxfBUhLXmRmBDR7I4J8zfkF
         zB/A==
X-Forwarded-Encrypted: i=1; AFNElJ+z/cSp/Al7InITsXYw5gH/VUD+ujCGsC7/6EdUHApasIPDP/0yD/xPxzJXR4MvvaAl86bMBSLwdhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsBDjzgTEF8pWf2vg8c8oXzNG3klocj3QqbUiU4X+nQkQMHCN
	9GmFMKjRmEZcKEr7u6szML8PziBBaJQda+BisLU5aqjAmCbOK4v7BVV1
X-Gm-Gg: Acq92OEk0OmwdtTdGkxXkV4QbUAbESPM3S+rxxyHS2HgVsgLcPZpXuKF3a4tXCaFDEM
	0ugt5wBhE/x4OfCt6JMQ7gxKUx7h+kLHS9KQMOEyJc86m7O1Oa1A1Tr2PHS//FqNjSsFbsJ+8Al
	LZERye26xQ+AXVwX5FpomNhBu16H5yr5hrRb209yJiC/Ok7vApXv5aRyjRLKpQ11mB2gxK9q0/L
	gSNk5yuCO1eHGmzrnt3I6iLjlnEs0mDk1S/yEdVjeviTD+BxFsyYxtIF8edeUzcs2rGcl+ydXPp
	C2XO+7A08c6CDjeEv3scxKM/5Z2YNu9CtJMWAPjgnmVJg9emJAtrBWZG+hNSvoaSzuecfw6BEQJ
	legUMWz7yyjPzTbZQWZ/iBYREc0iAjwNPjyAoRXZXVA2cecNFf0wu1II0X5qG/VPxWHjmJ6m25+
	VziWJKbK2brFOu325mj3SwpVNyeIQVh/WxlPrUyh7rYLbjvmpQW69WEBHOz7NTdns+
X-Received: by 2002:a05:6512:23a0:b0:5a8:76c0:a7b7 with SMTP id 2adb3069b0e04-5a887add288mr6982498e87.7.1778401569489;
        Sun, 10 May 2026 01:26:09 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4dasm17810681fa.20.2026.05.10.01.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:26:08 -0700 (PDT)
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
Subject: [PATCH 4/5] iio: accel: adxl313: Add timestamp to FIFO data
Date: Sun, 10 May 2026 11:25:55 +0300
Message-ID: <20260510082556.3867-5-shofiqtest@gmail.com>
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
with an aligned_s64 timestamp field to struct adxl313_data (in
adxl313.h), capture a timestamp with iio_get_time_ns() at the start of
adxl313_fifo_push(), and switch the push loop to
iio_push_to_buffers_with_timestamp().  The ADXL313 always scans all
three axes together so the scan buffer layout is fixed.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/accel/adxl313.h      | 4 ++++
 drivers/iio/accel/adxl313_core.c | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 75ef54b60f..ea5792fae2 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -94,6 +94,10 @@ struct adxl313_data {
 	u8 watermark;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
 	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
+	struct {
+		__le16 channels[ADXL313_NUM_AXIS];
+		aligned_s64 ts;
+	} scan;
 };
 
 struct adxl313_chip_info {
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index bcc11dabdf..bd45b90c42 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -1013,6 +1013,7 @@ static const struct iio_buffer_setup_ops adxl313_buffer_ops = {
 static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
+	s64 ts = iio_get_time_ns(indio_dev);
 	unsigned int i;
 	int ret;
 
@@ -1020,8 +1021,11 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < ADXL313_NUM_AXIS * samples; i += ADXL313_NUM_AXIS)
-		iio_push_to_buffers(indio_dev, &data->fifo_buf[i]);
+	for (i = 0; i < ADXL313_NUM_AXIS * samples; i += ADXL313_NUM_AXIS) {
+		memcpy(data->scan.channels, &data->fifo_buf[i],
+		       sizeof(data->scan.channels));
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, ts);
+	}
 
 	return 0;
 }
-- 
2.54.0.windows.1

