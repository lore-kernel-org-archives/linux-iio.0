Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEB3CEBA8
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682153; cv=none; b=G/4CBI+SZNbVVG6fP9cd8t6whsM6eTFUrI2WxSP0R7bBVuYrLMo5107N4CcDH6mrQp9LsSnJOtUNO+aF82scC1OsCAysnX/p5hbSowtaV6iws8YyQaLGWCyX4mk46zC/2lfvD1fEnjGB+TduWvSzBDuI93i/9DKsge8WL//afvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682153; c=relaxed/simple;
	bh=uTlCph61xbhemsq5NzrmOeRmMJAoW5saWS5o1/6nc1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqQMNTjFuOZ9qdzDoFj4pnuFttMDdoAxRq+AU0PxJKe6BIWPPFimSUcJIK3Jz2SUsvboLwHfhXPr1R8qUWNTMbv2JI2lVk5Sd3uGjFq/cAQlW8KOa15vyDDPdyzK6pSeykMy1XX40T811W12KjHRB+8dRll+bjTOtKPgsq1t+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVgTWN8n; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVgTWN8n"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so1198457b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682152; x=1774286952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6EwQCq5pHfIURqegn1LJtKiUovuMc5UBCifbdhimvc=;
        b=AVgTWN8n6dtTT+wUThxcGaMq2KuOQ6Q0s8sNroqvjIettFS4+LL9VSQc5YmFfu4vuk
         FbhvrnZ3ZPQnbAYNLS6tkdYfH5Iz8Wc65n1XepC0poDUXlU0ycSuqDyd/A6zom+tsG/+
         ydqfROj2Qc1XpXrnl0HwdhxzNO/Z1Dz0+8pIST+RRuHQ4pPT1Gj1ttDDVSeVT5WdzmFW
         2BaYPcAb9835jGVG/7fK8NfOaTcv4PEWow1Eeg2u0B4CaC+7vtWlyRRVtkWgpT5Ys7X5
         LMtDGq9Jdge8VlBtQuZeFqpuBDJfFXtd1fvGNEM11eZ8aTmnfcE4W+IW3u3q89ersvwG
         gMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682152; x=1774286952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6EwQCq5pHfIURqegn1LJtKiUovuMc5UBCifbdhimvc=;
        b=i87L5VOEK9Wvb6My8y5wo9NNqKC3fekd+mgc93iDeNyDKY+JualuKV6lKnCuhCwEnY
         eNmktHJcxrCHd0ID9z7dnWRft3VKC+uPUJujInznkT3N2qXPQX4zNAay0nsOWL25xs1z
         Eexv59PBlUNDeuf6AAcgmnIcZ8CUl1J9B/gzxXgmLwpqCLlPSpM4AYa2RwEY0hxviCWC
         x+m3nNCZ8jkm+7AP6R+KXjs40TVUbuSjVvrYN7TJ/HRekEHR7Aj/z7tttGhgqvoR0STg
         B6GPPBZWqv7WMS+5o8Ckx/vKnO2RXsXlSNLXYN3Vh8rSViZeimhE2RJkmdnVWuK7Rpyk
         godw==
X-Forwarded-Encrypted: i=1; AJvYcCVgEUEloMF9NbBSETg70XiB5mihOmAApKGIi2nIhjy62LLihU/WkCVThu8tKrecjVYkVe6J6iYjJ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyeFsMmcMNu/Z0pRR9Acc9J3mEjBkLE4FZv7Via88s/dAxd1wV
	OO5Rg5aZ1VVPihAXSNsVCSRM+ElFMXjAR+TOQVWa5mykTdnNMxwISj6u
X-Gm-Gg: ATEYQzxz0AWFCFehd9Sk2SDqUy7Z+4VcyqEAABpQWZ0VWuFgQqvPE6JPE4V9fg8O3FU
	6YCSwds9UCiwDAs4V63zsuNChEbfqWITLUbRz95/XRx7uyI3sxzGei9ZbyGDJFV5CUaMDs/7Gg1
	aejrBv1REUTAl2D7055z+4umk2deYbnLxJaT8ebsh0fS2dMRcU5IdBRJw0e9K64YNoc2+WUG5YO
	Bvw1hT2mSbGcjBfY3DVz0KwaIaIvAditCONHunvUijIyYZ7yYN3315hVFRQd3hoddiS0NBodfKA
	hyP43edMNqaFiJLheRngpkEOOstaQXFzzW5P67ufBHKbN3ndVD/feJ0JdoKU8Gg/O5Wt5lZKxb2
	AI5nh2gXFXCySgA7B5q/3Ehs1pGzr7IdjJ3aWHTuAILmIc6r1k/BL3DzRJTzFKHb0CaUIG7cDZb
	pMfaCybqEuziIEHKmEbr9imC0sgGMaFtlaIh7Ak/92OVNSKRv852wqnL/wb/4gg3nLyeGldt7HD
	OLA
X-Received: by 2002:aa7:9062:0:b0:82a:1759:5fcc with SMTP id d2e1a72fcca58-82a1994346cmr12355181b3a.60.1773682152231;
        Mon, 16 Mar 2026 10:29:12 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:29:11 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 08/11] iio: adc : ad799x : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:34 +0530
Message-ID: <20260316172735.11430-10-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/ad799x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 108bb22162ef..6c0470037c55 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -221,8 +221,9 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	if (b_sent < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
-			iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf,
+					sizeof(st->rx_buf),
+				iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0

