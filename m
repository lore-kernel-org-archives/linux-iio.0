Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804005;
	b=IP3jJq73MRUPS7H3Xcf9mNaNV2iGH9xk9AzwhWoaJclcYtPTX+ux6YZWWV7T4yYnPnYq
	 RiXs+xLDwf9MleJtcqKNO4mB/AJkosgcZJHB/nFXfA4SisJr57INcsUIoFl601YEGyvLy
	 2ByIVzdBAucVoIVJAuk0LbIcDooIy7fgRYBxr87+7np1OIOYtemy690+qbm+KqDCTWLCB
	 Nj+MijG9udjubK+aMCd9PHzmMZp5Mo5W4KDTlH62ZjPawTJOr0BTbjwEUTPjUQ/9S7Dpx
	 GG5iYtMgM3E9UwJLRHsQVPslB3wIPlaKAx/h4mBWlYtldGpNev3o0neAOjiWSAdLOPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eOXYjnqWWVMXkspdzQNEoKVv+Aym7CHLpb3HIl0SgT4=;
	b=MCvUTHRpd4m6y0BLq1nYRyrR0kpJPsXrXhelK4v5Q2s0alnWjVk/9zxQsGgnQmfz6Ey5
	 NAAWybr0PFRXD47VAZD/QMljylfbJsI4g3KJOeFalaBENjOpKtxO0ewooqskQ6YrQjjvo
	 IedZrKw7RNManGXR4N+V+apCZfEE8GYnL0LSf8y6wiZNwSuIVpMgo9oKSBWSMzrnqwEpZ
	 K9dKdd5cd+x7sY79wep6Papif2J1rhEQJRUKUBk9Fq4o4zZ5wZ9n+gLwB+HG1GYPA15fi
	 5nHGwtBrTA9XnR936q20GHzs4yHBLkqQ9cvQLV+f20d5elbQW/rToOd60AWSeZGdXWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KRkQEOPC;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E6606A329
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 18:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C4E6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KRkQEOPC
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9210f2622ccso89472276d6.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804003; x=1796408803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eOXYjnqWWVMXkspdzQNEoKVv+Aym7CHLpb3HIl0SgT4=;
        b=KRkQEOPCd87kLPA2kUUs7jGcm4AeRVsXt8s9xlDHnsjMInCmYo/25UNtqJTTYfQzKh
         qmHOBqF0H/OPopELhebidAqOs068fFla7OP8BRd2PNw5WQrLX6Ns1E2zHBW90bliVlp2
         dIHYAyUREp5lD8KJi64TXBruhtW2tgUpRe9ZvjNcl3g4Sr/VyGxivnwdE/ARJv+ai7NK
         wPKHap/C2raVJnXtFyW/zl4R31fAMtzpR4KtuFX+qMp2Z9dU//LesOmqlGXgk7vy3bZt
         97AYsMdynnqtLnDtCP3TEFzO59jlGszT4yfkaFjvKI40bG3FxdppzzWKAgCvt3vX0HX9
         QXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804003; x=1796408803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eOXYjnqWWVMXkspdzQNEoKVv+Aym7CHLpb3HIl0SgT4=;
        b=LbTs+/jyCN7PRxxQdfOTrifAuaFqF0lF4ZTI+UwGT9IRbt5KSjUFAcDo93QmEyZ7ZP
         M4fIuHlwBjR1NnBvtCp85kVc1FF6vz6qH+f9F3/CMQhF0o8u1bHwqg+GUSwooO2rQAzf
         z8EYIm66Zq2WfvO4pW+8yZEYAXi7lqiOX1CoCP84njSTR+6mKOIbfOPzOw4TBlKSoZCy
         qjegWeDDIh+fD1n3i7+69eWPTCIsNpX/FylCH0pEnvciWif4FOWGa4Sr1xETSioK0i8r
         xGKdGYGh9ff4W9h92PpxSBR+4JHiRtjTKLqZYp/jLXhtv0+QNsDrYPHRjuPHIuZWFPNx
         BZOw==
X-Forwarded-Encrypted: i=1; AL+hErH1Xz6pEFq8wZhP+iv50g7lW0w4olbzX3Z/3800bdF90UXRv73qpQSVw4ZIzyTSVYyKNPWTDz2p2rM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2Jn4i6aPGIXS1prQoGC/DsSOCeIW98VHI6ZzEy7c4Xmiqk9o9
	QX6xgsC6qL1geNx4EwHyM7mASX9pMh7Z80+wecbsMPCdh70MhqVplC0j00Gc7wA/CSM=
X-Gm-Gg: AZFdTZcpe9qlNJKI1b2ZGTksuVb+MwP0ek7oVLFFOdDMNJ/q06dSlPNK/Bz8WJKHEIg
	R6hayAA8Ip7coc94wyAMICZYoSmpnt8rvUbCnYd9zEoe0AT6sQGErmLnkB0o8gVheM0zy0h0lr1
	GkRr8O53oDmTDJhcRoXny1TrK+AX4X48JicbLVpaoIqG6iIzjG2Nx5PvTLhOoqXPUDsWSplqGRX
	L86tOLweiaz6HmB2YYyMeO8zDV1C42CgZTEpfaykzQDAMLD5s//SmpmsLPJT6GO8y5Un24sSqz1
	fj4qD1a/pWSAz6akYYPk9Fw9U8v9q8t/dKZd55GOnO+8jLDisWr5K90R30D1tsp9wuSWTnR6k2o
	vndgqWmVfol8cb+PwQ4ppuk2B3gyy9oIr/8Zw2AnExwpBsLqTe1dyhiVry+e7wSsXZyXNIFWRZL
	Qzcf/hN7+bFeavG4irK6g6oOxeM6IApHhiZh5H9oQanuv/29fl22oQgZWvLPddrTD9kLCC+CDIZ
	4MFjE5L2NgScO7smCZR7s/nTEAGMFZ8vl5RAdjlUe8fCE+gEAlXFVh7WPGElhm2qWebEYJm90dl
	TQhBRpv5rSrp2E6gKL5a6Ls2FYKGQ2bSS78=
X-Received: by 2002:a05:6214:4686:b0:921:1ac1:34e2 with SMTP id 6a1803df08f44-921653a9042mr253658056d6.24.1795804003603;
        Fri, 27 Nov 2026 10:26:43 -0800 (PST)
Received: from localhost ([2600:4808:5693:8201:394e:8b9f:994c:b59f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213514d20esm222777366d6.23.2026.11.27.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:26:43 -0800 (PST)
From: Marco Chen <marcochen.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	pmeerw@pmeerw.net,
	matt@ranostay.sg,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 2/2] iio: health: max30102: propagate I2C read errors
Date: Fri, 27 Nov 2026 13:26:36 -0500
Message-ID: <20261127182636.83803-3-marcochen.dev@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127182636.83803-1-marcochen.dev@gmail.com>
References: <20261127182636.83803-1-marcochen.dev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max30102_read_measurement() returns -EINVAL for every failed I2C read,
discarding the error code returned by i2c_smbus_read_i2c_block_data().

Return that error code instead. While at it, move the existing length
check above the copy as well, so both checks happen before the data is
used. The only caller, max30102_interrupt_handler(), stops reading on
any error, so behavior seen by userspace is unchanged.

Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
---
The I2C error path was found by inspection, but was not actually tested
on hardware.

Additionally, checkpatch.pl --strict reports "foo * bar" for the 
multiplication in the length check, but I think this is a false positive.
Not sure how to handle it though.
Thank you.

 drivers/iio/health/max30102.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index a553c0e011e0..829e8b18512d 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -264,6 +264,11 @@ static int max30102_read_measurement(struct max30102_data *data,
 					    measurements *
 					    MAX30102_REG_FIFO_DATA_BYTES,
 					    buffer);
+	if (ret < 0)
+		return ret;
+
+	if (ret != measurements * MAX30102_REG_FIFO_DATA_BYTES)
+		return -EINVAL;
 
 	switch (measurements) {
 	case 3:
@@ -279,8 +284,7 @@ static int max30102_read_measurement(struct max30102_data *data,
 		return -EINVAL;
 	}
 
-	return (ret == measurements * MAX30102_REG_FIFO_DATA_BYTES) ?
-	       0 : -EINVAL;
+	return 0;
 }
 
 static irqreturn_t max30102_interrupt_handler(int irq, void *private)
-- 
2.56.1

