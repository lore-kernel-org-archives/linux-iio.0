Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFE33F8C1
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203605; cv=none; b=ePdRgHZQ4fpdwzB8yA7vrK35aO0tPXSnx1+BMa44r/NNS16oinkQIj63n3SQRalxxTvEvU9V3fIrCo1YQMMAbS/LTEticJvSLQCZGJYlGiFPecc15yVHbQWyAiYGSgTDs8SLbzQbZjX6Rppef1LYV9cY778jC4nUw1NwYke7wMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203605; c=relaxed/simple;
	bh=06tA7WRRm4UYgbG/TUxpnj8tNbPyfPxX+h5jV2aHqbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWdKE2nwOcotPXc9CTdvLUH37IlY+/v0wkV45uhxDgzxOkgDJbqlP5ndU40zy1p11e6W947KWnpPXBY9IHVVadkmWt54phBNLlsLFnyz5qGWmFyshpztVqMj2iVPT53MViO2/xaPp2ImzPnjGMY5dJDLukl3UVM9T44wcbK5vTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFGQcaND; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFGQcaND"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82c70e4654eso780507b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775203601; x=1775808401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiZFrpUFOrr6RoZaJU9vWVycZYWOFjUTDkEI0B+J/4s=;
        b=cFGQcaNDmQDHPS+4iS1F9OA33EHYwsYbMt0x7N9XWANUjN48W4fDLGC7D1eeX0RJWW
         FbUyq5Ow8DCmr4E9rmOxwOY+/PJv1JbIZwywM8isVNgirUQEtUERvoEzKCm8o1P8/E1j
         MralbhhGNedX7Oc0zch3a7ATKul1fjC+43dWrimy16Ks8ILsgls2710gYVcDVe61bB82
         BumS22ZSdGh1Yv5mKCNykqHLVv5shpcBXow1EPZtVTA0naUmpqAen0iHjl+ERdHEOSzl
         dysdcJ+tdpSXlpEPY5dMPL38evngTCMyLWZ66uI3cDOYlfpL0NiY13sW9wm31oODtQdx
         QcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775203601; x=1775808401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AiZFrpUFOrr6RoZaJU9vWVycZYWOFjUTDkEI0B+J/4s=;
        b=Ol5l4O3gyyLVaDpQlsSuVa3+cnTpcgECCGbDoNb8Tb4X9eJ4bjtulvq70Ai45Ik19u
         FY7YoXCZukXa14qxs70NM9tqNP/BIXXBbcXJL47+p0BeKm+wxvg14lMjKh6QykCliwHb
         wBW/FtfyCtwJR9gBfx5cc5FQA+S8f15JAw3JS39cD1mChwPyniOY7MtpDydi/UL3aQK3
         kBlQJA966tmawWDwBu1RbmTqgwv+jkvVd01N0EBzya6Fs8ja8R2nh8Q0KsrJPJJoaJmt
         PVpY0rlDOwTIflf7cMzIPw3XEW487NG1tO3vw7m3RfPlfIOY3394DmNiTs7ehIy+br1y
         m4EA==
X-Forwarded-Encrypted: i=1; AJvYcCVBzu+T4DhNDK4mxFYNWS0MQDLxGifOhp4YrvGyebrxmZ1nl2kUaa2iBLORa7qCjJUuneIiqJXvYFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLdo4btHEzN3pbs+BiumMgEHdJdVU6kNSZTFb/oC+hD+6tzOq
	4P08ITfITit6LH//6nnVkmrg5toz772iPVLwdj/WKm6Um+SoRhdKLt7PMT9c3JjnWSI=
X-Gm-Gg: AeBDiev7i74Z3CNhY+ZuYwHcHhisUwIGhodwfmP4wc4P4X+8ZcmX9ubI78vZzSjQk/Z
	eDoNL1+AW+JOIgmr0wavHNfZdjKQJgBmJ7paD+ptx8PF8uw5bLrQzsSKMyeDLoS4aqLtdI7oq3g
	gq6NGyaWMeaygRYWtB03/CSkj1mafX2rWMDxcsVVRnh3CSLeEJXKzUHWjav//HLdAn8huu5efSR
	wnVX7TXUyYfkE3HM3oywUn4MNC3zB0u4Kak8Lo69HdyBJoayl3li51ouUR+dbVmPpueIeQS+xfP
	KHiPizCO3mSS0kkEzJ5b2+s+gD5xaZaizI0KbCi3ylgy0NyWuTWwHdWPsh2xZRlCQPgMING0ct9
	i14Lwa9Ki12NwSmZMZ/4L1nqmDKXIsnxTHmsFfrYnei27BUKMX3MmCLMgBP5NUl1A81ygYR6E3y
	NHOfrtjXMEeTUlW0L6JSjRm+glv37crrBAt0WMu5THONtj91BqZfEaoi90ayLNnVnUwh7P/1x6b
	Q==
X-Received: by 2002:a05:6a00:b94:b0:82c:75df:10ab with SMTP id d2e1a72fcca58-82d0dbe53famr2001361b3a.58.1775203601334;
        Fri, 03 Apr 2026 01:06:41 -0700 (PDT)
Received: from debian.ari ([152.58.181.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm5481093b3a.40.2026.04.03.01.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:06:40 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v7 3/5] iio: adc: ad799x: use a static buffer for scan data
Date: Fri,  3 Apr 2026 13:36:12 +0530
Message-Id: <20260403080614.14213-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260403080614.14213-1-architanant5@gmail.com>
References: <20260403080614.14213-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rx_buf is dynamically allocated using kmalloc() every time
ad799x_update_scan_mode() is called. This can lead to memory leaks if
the scan mask is updated multiple times.

Drop the dynamic allocation and replace it with a static buffer at the
end of the state structure using IIO_DECLARE_BUFFER_WITH_TS().
This eliminates the allocation overhead, prevents leaks, and removes
the need for manual kfree() on driver removal.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index bf0575585a59..d8389b6e19b5 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -39,6 +39,7 @@
 #include <linux/iio/triggered_buffer.h>
 
 #define AD799X_CHANNEL_SHIFT			4
+#define AD799X_MAX_CHANNELS			8
 
 /*
  * AD7991, AD7995 and AD7999 defines
@@ -133,8 +134,8 @@ struct ad799x_state {
 	unsigned int			id;
 	u16				config;
 
-	u8				*rx_buf;
 	unsigned int			transfer_size;
+	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
 static int ad799x_write_config(struct ad799x_state *st, u16 val)
@@ -217,7 +218,8 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	}
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, st->transfer_size, st->rx_buf);
+						cmd, st->transfer_size,
+						(u8 *)st->rx_buf);
 	if (b_sent < 0)
 		goto out;
 
@@ -234,11 +236,6 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	kfree(st->rx_buf);
-	st->rx_buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!st->rx_buf)
-		return -ENOMEM;
-
 	st->transfer_size = bitmap_weight(scan_mask,
 					  iio_get_masklength(indio_dev)) * 2;
 
@@ -896,7 +893,6 @@ static void ad799x_remove(struct i2c_client *client)
 	if (st->vref)
 		regulator_disable(st->vref);
 	regulator_disable(st->reg);
-	kfree(st->rx_buf);
 }
 
 static int ad799x_suspend(struct device *dev)
-- 
2.39.5

