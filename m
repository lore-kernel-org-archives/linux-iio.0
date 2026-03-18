Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1C3B4E95
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826196; cv=none; b=rH+0TrOgIS7kD+kcf1vg22Axt52xzy2UOxGCCaGYiCtW1UGNkXNeNKwK5Ip26p3y9HTOzrjKh5zrzkYbmEXCdcm+6E6hNQqFmA4YoO5jO/R48LLb0w8b0uF+DpzeZDsrnq23/ZsJT/i4jNhA6uaQnpIm1Ea9VdVhw9f4DpQW3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826196; c=relaxed/simple;
	bh=YeA5NTit+vRgO6O7UM7usIAyOEi9ktUs3te+RyJJPCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxudkxxXQ1jUfBgU77trgqKYBZnXGC0AIzqZd5WXD4cbMCn+jmBZoc11n92zgrat4AKPofhHOZGw9O8pIVvZl3dPMWzHzndm+bEHxPjUbcDqepxxwSnecE3dEykFWl/rCyI8DzGiNCm3sips5XJJZSnbftEq4QHjJ4axPJ36GG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7xh4Bcb; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7xh4Bcb"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2735544a12.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773826191; x=1774430991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7lW8LFGu1hdwVKAacX1pBoH1829SaNw1Lo72wdjeU4=;
        b=g7xh4Bcb4gqqNnVVvNpUHt9mKxhVcQfevQ+1J8Us/shLocSleLAhyz73N/6X9MojeV
         YLQ31TLU0BpAyHjV2pwPxZiFvOx8aZxYj9Wc+EWbFxDFtmpaUwklJwZb/g5yUrlx7msb
         xTRNOfkpP1uqJe2GePxvKR2ho4lBbqEgdDbRDRolIKOsFklRaz58hl5XFmbSfEuegVct
         NvtB4Qas4v0JTuVBIXr9ZXIXSjOw0SVqrhEBG4PUfEVFAnxk/5+IC4y+hG8GyYWRv1pX
         oKVicfgJVIPQIcIc6wPEtm2hmCrfpm/WIABv4anZovu6vDWFlnGMyU6CtlAVO7Ks0kjt
         RCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826191; x=1774430991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V7lW8LFGu1hdwVKAacX1pBoH1829SaNw1Lo72wdjeU4=;
        b=rdUcXC2XDv4xkd6CjsHdjpgBAzYqVtbzICkr3vLqGFV5QUURvvhkVk4CAMN/qkrn/E
         h5LT35B4uVzGaS53iN2U61m5zaiYhwjk4vKnvFqvby2GK4O3DNbfrdHxoYazbDUX+dWD
         KmG04TZauYSEaJJxRQWat6EoO+dHynGy3rv7A3oAs5tbQvS0x9T2zcecSlCmKEpiDxrD
         sQErwFOVKFOyxGyw72HiLXptc6Rqg62JSGfpHqSKfppsVhfRcJZNOa1eHBdQlJbDZGhq
         s6Jc7P3z29WHE3CNmknBcs77O2EhWIupB1rSlWKkX2SBg2zIUWQurogE8nIuy2pIyL0l
         FJTA==
X-Forwarded-Encrypted: i=1; AJvYcCXX16R1RV8r/fKEhNivfwh2crqbK6jl8mmCL0QRGJMV5XXbfqbEWGNErHJd+W2/zqnnGglSPocG020=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrMpW0oSJV6Zr8ggIA9MEd+jTQ5AQkipGjOCAMHrTzOGTKP8W
	DE+emA90k26SAzJDQ2ulTyHeuj9mSzBXGmJXctjL6mbTloMPmYC/+K32
X-Gm-Gg: ATEYQzwWJ6N1lk6ybnHCYH4J6ioMlWjAsNkF3scsX4w3xzGdPVemsUMPPauLcOf8Zg3
	NStAlEcBwqwLmyy4xEJycIZ4Rs1e4RNJakAeORD94I1OXdfF0+l2e1Bf0D8lZPm6LNemTo6bA1J
	L8Mc7wFMsLkrXyl2YF1xKeXwSfJuLWKBm1K45jJ8tBwZYuM7VbjPiDZi0coHJbMuo1sodAZ7kpz
	HJUTp+RBAEvNwsIp+kCLQ4pWLx3Oey6+KvdwMf/snLJ6JFnDFMYQIcflf1JFxPlA96D+D+4qM/h
	agKSuPClBKbTEnkwuwLfNmqbPpiHeMov3CCIQhZOF6dzBNX5s+qxbRWDwoxbERxUyETug4HXO8y
	+GAMH0prhOkvv6czpgYzpPaSyysUwdEc/0e9dmpyJjF0RA3ZUXTkY0lkyH5RFfJe4S0aZYLId+A
	lomrntRkbNxin5Cy0pF+GMTyg6Hp/SbCNzK+L7uw4veA80LirRs+rNkj5wlwnRV8j+5cGJDb0Gp
	ENq+JJctWg=
X-Received: by 2002:a17:903:1a67:b0:2ae:3b9b:db34 with SMTP id d9443c01a7336-2b06e41a91emr26532705ad.42.1773826190696;
        Wed, 18 Mar 2026 02:29:50 -0700 (PDT)
Received: from debian.ari ([152.58.182.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e616351sm21168315ad.67.2026.03.18.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:29:50 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 2/4] iio: adc: ad799x: use a static buffer for scan data
Date: Wed, 18 Mar 2026 14:57:13 +0530
Message-Id: <20260318092715.42538-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318092715.42538-1-architanant5@gmail.com>
References: <20260318092715.42538-1-architanant5@gmail.com>
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
 drivers/iio/adc/ad799x.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 9825abc9285d..7504bcf627da 100644
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
@@ -217,7 +218,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	}
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, st->transfer_size, st->rx_buf);
+			cmd, st->transfer_size, (u8 *)st->rx_buf);
 	if (b_sent < 0)
 		goto out;
 
@@ -234,11 +235,6 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	kfree(st->rx_buf);
-	st->rx_buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!st->rx_buf)
-		return -ENOMEM;
-
 	st->transfer_size = bitmap_weight(scan_mask,
 					  iio_get_masklength(indio_dev)) * 2;
 
@@ -896,7 +892,6 @@ static void ad799x_remove(struct i2c_client *client)
 	if (st->vref)
 		regulator_disable(st->vref);
 	regulator_disable(st->reg);
-	kfree(st->rx_buf);
 }
 
 static int ad799x_suspend(struct device *dev)
-- 
2.39.5

