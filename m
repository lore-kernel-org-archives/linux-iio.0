Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9C33ADB0
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068601; cv=none; b=H6/nte1AlGpAy/zFAVBooNC1nNaI7gdrGmAhx2CHm5yX+skCVkv4bGkji10WjhcYNeLPWdAXgONatAco8myd7Z4dmhLmSfE+SnI63r3Skpow/jfrUKKrQ1/vvxhrM33SR0BWFltpQZ4ReDr6XJZ4FsuliDtpFbQgJER1nU1W7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068601; c=relaxed/simple;
	bh=F6l76IQ8dAb6WlRRggtkiMnm01LfXBWXQzOtxFTNaSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mg3vSM2KBRPZanPmsQ0KUJb96qmPzPp7bWIxIVaB9XeNmNgGfzyvaz8cLHEClyp5wZNuI9X0avfd4UFiDSCVJnBgwY0FcuYrPtLZ8OENZFshHajJxgpvxmyHR39IVIuDd9PGCY2vaIzrXUaCuReayZzBca+bDjBRhFBK2kbxrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIBo5at6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIBo5at6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49978908b35so71935e9.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787068598; x=1787673398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYBO4w8nE9hrwkdhLesdmpIxIW6mbpXceSl7ZLKVMA8=;
        b=iIBo5at6SRmdlWN/FiuNJ+lKGLzJZWZ9wFC7ywxklNFi+KMKjYFGZzSu5aQgMXLTQY
         KqwrpXDn5guPUNKKxQiLk0yQ69ArGOGcepIivA5cFWQpUbGvFe21RcMqU8oPqnBbv6On
         0XWKnTjSWW0Yy1U/eGmPlC9o+R/fZL8sElYSjQA2W/fo6ih7um17iz+vi9WlFaZAtxIA
         35n0Tq2hlTIrCTgVIbs22QWo7pT50E3GQqFjQfmquQV7y2ADt9++WegcXhLd3l54k8vi
         +54Or34tYUkV8mR7leEZ/lycSMga5dVS3/SQu3nuPpLPjB5T46rdmbnuJkl9ImRwvfu1
         4TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068598; x=1787673398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYBO4w8nE9hrwkdhLesdmpIxIW6mbpXceSl7ZLKVMA8=;
        b=IfEj8lp+Rg13wJ049e7T6IF7TUsguP+ZQkJntFV1rmCwbKS2gPi05eorO3naeJCbIG
         YpwkfNSDgUMKvRNmNC2x7+MO+thi1kJg03luZfg9AXbGHNQfbxYcwzxNSABXsDhuGta5
         Y4FXzOvxIo7H93By5JU9NJxrtwkBSsFy5RnyBNnJsfhZ0H6zzHS2bXJmRM5EjFXjbcrM
         dLIZYl3xtREHN+WDfA45delnO/SwOwBZfs/manfpsd+XBHG/4EPLBFXHlFKUfo3T/gNJ
         Ykvze0AIskMKBscjM4LlrX3fgYCj6h0L7X1HEQTRvmZHE/yS68P1EKO3Mw1MJHJ/hSTU
         /7OQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSXusn7sdp0i5ZyIf1Tp65B+pYTXuxlv6b87ZL07p0Ea76sS+OpnLvRcMQZeDJcvPWBX18ZmsyVy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bczWRnvlO67lHT+i9xzsTlQ99OuRakPYu2mhjZ0wWEagsTmQ
	gZJAytkhWD9s6nnIqlMu9CO9KmqI1GeCf9IqSg8Qn4z7AnZje8tdcuHb
X-Gm-Gg: AR+sD13W/fBxaoY1WRU6ElTsCUaiWNwBLjTB+dh0RO5vYpMm2Br8fhO1rVrN5VDYw89
	7pOatolmxDDHXhiJyPknnoM5Bgoa/APFlUuDgSvgWFUhSpyuOvHBBXJxkzAgETVnJh9W8kiokP9
	1oqDLeSQu/9t2Munbr88xPvAkPN5cKdSN80/bfKVYARjIN2X17ztZnfePAfvDcaT9bn/aILrn71
	eyuuQv4HO6gD4lYc66kKETBfY6NdhzfsqrsMqUo+hQwyrnBurrnX9T9Pt14ioXkdsDjfdPfTh5v
	MD4ZiJ2zhA2qV8R49+amBMcVWA+eRV1M8dhcy4ggCzJDSpze13KapQbV2dLQzCYYGjtWickZY9i
	GhRklApB+LcKEedyd5JCXqul2WayGgvAR1M9e8nEwbDfTlr450VanfqPUBBKYpU0nTSyt6Bpq8l
	7+S6bXwxYkDK9/XFYVbpXFBkJ42DfpEaig3qVWrVAy8n3c0MleFckuwhQpkbB0pV6n5U1Zh9fvC
	f/P9ODGnt0ShN4Y08gBKaYhi1q18LqBJ+Bk7+L/Fm32
X-Received: by 2002:a05:600c:8b6b:b0:499:8f9f:e9ee with SMTP id 5b1f17b1804b1-4998f9febbdmr488685645e9.7.1787068597675;
        Tue, 18 Aug 2026 08:56:37 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d10ba73sm148499265e9.13.2026.08.18.08.56.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 08:56:37 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()
Date: Tue, 18 Aug 2026 16:56:35 +0100
Message-ID: <20260818155635.8367-1-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), which takes the destination buffer size
and checks it against scan_bytes at runtime.

Both push sites already use suitably sized and aligned storage: the FIFO
flush path pushes data->scan ({ __le16 channels[3]; aligned_s64 ts; }),
and the trigger handler pushes data->buffer (__le16[8], aligned to
IIO_DMA_MINALIGN). Both are 16 bytes, which matches scan_bytes for the
3-axis plus s64 timestamp layout used by all supported variants, so pass
sizeof() for each.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 02dd1db7a646..ed0fffd83d3f 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -864,7 +864,8 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
 			chs[bit] = sam[bit];
 
-		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
+		iio_push_to_buffers_with_ts(idev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1034,7 +1035,8 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(idev, data->buffer, data->timestamp);
+	iio_push_to_buffers_with_ts(idev, data->buffer, sizeof(data->buffer),
+				    data->timestamp);
 err_read:
 	iio_trigger_notify_done(idev->trig);
 
-- 
2.50.1 (Apple Git-155)

