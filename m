Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351523C8C7
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773526703; cv=none; b=mgi0INyJmqg7qGOTtkYEaqy9SCeubZsKdzZNb/qQl3BZS+ZILAjhGAvs+ehHP7bi4Za03my8sqYvhWN4BWKvQku5qxh3WE1KgGhCi8y77SLTF0Se7Ysqc+CkRnrrFVCqac0mqjsz/J2WM822an6wZ33hPklBFwMHla1BCVBmyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773526703; c=relaxed/simple;
	bh=bKcY4Y+E9DqhFkvhNYpy3LHkEQMdezB6JBUJ9ambGWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eaRYsLIebvD+pO2zLoBGrmy9HPk25KuEyT119H+N5UFeGL4ln669aQZeUvvO7W9Lyy1J0xMbmO8DzMwKhDOCoPUP5l2xcu+o8tvUuAQG2XAhzxfYCpIVhhhaHPy0/4Q3TGGMahNQNHWTwsvDAZVOfKHUaxWO1vWfg73f7v44zAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y8P1fDtR; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y8P1fDtR"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67bb5e4d06eso1174085eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773526700; x=1774131500; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDbUEHxvZ6LbG5yA0b6crCNwXlRJDt1sD43ttVBDLD4=;
        b=Y8P1fDtRPGsFOmibxI1DqUWs5O0wHchm5XbmzqQFAIhRZnepC6sReV7pnpOaZBgAQw
         lnnrGG36tyQZ8JpKsWLgVvr6n1PQgUOHm917U3JqjhwUBFmgmJS5hlD8Ow3IhBfvMX0T
         m7vjKmM8aDs2AhKIuUn0IAYUYJUbE6E8zSPEMRlqp7PT5I1w8D4LZe+mO9yoBZatvMhT
         1qEC8qv+AiU3ayuYSaBUD4LvPpja34EoEvu1VwI9GHSyzto0f7YQFWqeNytGuv4Af1yd
         5sxaj/kq/BcQyV10zhUYROCTdH+Sqkya/Y8UOcL6q1pBs02uD4R/pmsQTB0wbJtU4orx
         qQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773526700; x=1774131500;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDbUEHxvZ6LbG5yA0b6crCNwXlRJDt1sD43ttVBDLD4=;
        b=d4VkeVMb36c18aFZVL4vMJkeUItGX9Vctr2Lk6DN+ULZ9hTy1ug9fF0/R8GQA1Z3e1
         xbNgnDafXvISYLAFzH6O/KdwBPUOw4gyBLT9rd5btN8xRUdt2vx5iM52iDVOH+MA+qc5
         CUN+Sor7jwFO9hjW9oQP39fZvwQIsHsS0Gl1F01m5/0MMJWsM7BA+TkA1ZTBbpG865iB
         BS+i0ofXXOYKzvSkvTscw6HMx+MHUcNpTmmxyW2kXIa1qaAmJi7P7U07Bc9MbTT2xJD9
         8yvoXLB2DszJwR1oP++D2/aGdntKld1K+XH3hzohpiW1yX2pPWnZuDhUDYiwh8810Y+g
         wKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGRGq5FKNG5N56knwR6whxVTWRQF4/baXwVcQfnlkMlkheNnKuNF+EYSE+cjpJZsxrWMNxuYsuWmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzs6fGW6s3Ak4NfIY8bHl8myHlACJRER4t2Kp0Zny7FtDJIJ19
	el/cnyTSc0F9VptZETXU/ONxIYHkueI0bUXin3CjE5Ce0IdKp4lg/Xv35HR/WDwuCGY4pEZD/v+
	gXCe0
X-Gm-Gg: ATEYQzwwESYgi4tMvc7NlzADHS9pa9mLMaHIVWxYdCsW9Nrb1udQ8xxYYhtarpNGtW+
	lfob/GXTJIaXryZuvazTtK2jhBlOkogAbpInXbxZuujP4gJxveYDHMTAvAOMlGa1D5eruwlZkB7
	yEyFIAeyEat9SDQEhY2YALZb05K1w4wiS8LCWkbkYXJujCY6sMGwof4Sno0K9CcIjcG3Xo5F83n
	tCZSy7y246p7QXi25abFEMLjEBYNNswhWMreSfvH4tYY1epjznPzFGfBNuQt0lI8280EdYdEM5J
	nL1ayelLq2erE24RIADAMOkxcnc+G/QFighPKEcxvJxDJlkww5KoXJE1ntbVo4xvqizwYpldt4C
	TxHrY95E8BvM+Xfihs0cDjorYeasH/ASFoz4HdseWfERq+0BFnSSAuA+iNklYaoBbtSzAP0ZsXJ
	pzMwP6FfPQ8dg42qvsBKuLouv7zgOPgciv6YZz6os=
X-Received: by 2002:a05:6820:1349:b0:679:96f:3f04 with SMTP id 006d021491bc7-67bdaa60223mr5518895eaf.53.1773526700359;
        Sat, 14 Mar 2026 15:18:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc8efae1asm7679293eaf.3.2026.03.14.15.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 15:18:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 17:18:10 -0500
Subject: [PATCH] iio: light: vcnl4035: fix scan buffer on big-endian
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-iio-light-vcnl4035c-clean-up-scan-buf-v1-1-400d273eb026@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQqDMBCF4avIrDswmlShVyldxHHUKSFKYkQQ7
 960XT2+zf9OSBJVEjyqE6LsmnQJBfWtAp5dmAR1KIaGmpZMbVF1Qa/TvOHOwVsyd0b24gLmFRO
 X7fOInXNEg2nFdgSltUYZ9fj9PF9/p9y/hbdvHK7rA2M8CB6JAAAA
X-Change-ID: 20260314-iio-light-vcnl4035c-clean-up-scan-buf-7aa00d36e470
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Parthiban Nallathambi <pn@denx.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=bKcY4Y+E9DqhFkvhNYpy3LHkEQMdezB6JBUJ9ambGWY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBptd6jvoxYGvHGymRs5PkwluWepv/h0jurCjKoF
 TpgeHx276aJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabXeowAKCRDCzCAB/wGP
 wOGFB/98JSVkD+O7YQXtOQTR2w/vt4CzHtUWxUEzekpEbaGugP6vgTNVOIcCj4f4NhHmMUj9xT8
 mxWD6Rn94hD67g88mCRfd8XIlnUEPn8W2YyU001H8GEwB84jB2A8HAfRNxNerXmnXWJV+C9fyD/
 ZlTM76CD1e4i9gqebBAT75+sZVV+p5abc0rlptqNQszkyowULv9n7Rpez0ct/qRih4hSTEXpPcf
 VP/+WWKVj0S3tdwJ21ZuuvebqylB9RQA6m1d/LyFxKKdxP0NELJNzX46ezlkcXr57f9CKZD/t7H
 IuEbVOK8zgTkt4M/O/q22XaMzpawe0RqdkaOdID9PfGVGa7H
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rework vcnl4035_trigger_consumer_handler() so that we are not passing
what should be a u16 value as an int * to regmap_read(). This won't
work on bit endian systems.

Instead, add a new unsigned int variable to pass to regmap_read(). Then
copy that value into the buffer struct.

The buffer array is replaced with a struct since there is only one value
being read. This allows us to use the correct u16 data type and has a
side-effect of simplifying the alignment specification.

Also fix the endianness of the scan format from little-endian to CPU
endianness. Since we are using regmap to read the value, it will be
CPU-endian.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/vcnl4035.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 963747927425..16aeb17067bc 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -103,17 +103,23 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	/* Ensure naturally aligned timestamp */
-	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
+	struct {
+		u16 als_data;
+		aligned_s64 timestamp;
+	} buffer = { };
+	unsigned int val;
 	int ret;
 
-	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
+	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Trigger consumer can't read from sensor.\n");
 		goto fail_read;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-					iio_get_time_ns(indio_dev));
+
+	buffer.als_data = val;
+	iio_push_to_buffers_with_timestamp(indio_dev, &buffer,
+					   iio_get_time_ns(indio_dev));
 
 fail_read:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -381,7 +387,7 @@ static const struct iio_chan_spec vcnl4035_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_LE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -395,7 +401,7 @@ static const struct iio_chan_spec vcnl4035_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_LE,
+			.endianness = IIO_CPU,
 		},
 	},
 };

---
base-commit: ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
change-id: 20260314-iio-light-vcnl4035c-clean-up-scan-buf-7aa00d36e470

Best regards,
--  
David Lechner <dlechner@baylibre.com>

