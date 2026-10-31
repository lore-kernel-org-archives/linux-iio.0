Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433530;
	b=WCofasI+bTPZGzjRLdqxf6iqvSHXgkZXh+q7eSISmo4wkCBzN3FlezsAJpWc2q3k5bI+
	 Kdh93bt42ghauE3qfnbq38G8z56pWz0oZqE/igTXc1g5bBgHVipHle4tAj1fLIFoi3dF2
	 g6g8Z48KBwC1FnrKwJjP6PwQG9Q8WlmC8BkR/rBGxKs5r+DA24qQxHYwy57jt2+M1lVpM
	 nHyRgBrME6qeD/vBlHsNe9aNVeY6wbU4TucT/Plj3aNLAlWePn9G+5iteorQnGUCaP9Y+
	 QSltzdq0EzgtHX1QiCzs/wXdYvtalfXo7F/oZuOj0hkNZiG+Jk+CVA6v8ON9/X6kbCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YkC7yBaZrE2XAa9kIglc92DWg36i3099yYhR26+EG0M=;
	b=w5+FWxDAPrBn2dQCpMmWFhNZPvsZMNOcItsDfRnx38PrRLyb8RYTGuRo9qXpbLjA6Agx
	 JdB4IRZ7W2kvs+o2R6XFikmXX+bsxZS8nixmUwieicH1QL/jKk+fmZW3b68iIy6Hf6JcG
	 02G6KSEAGaYfvZ5ga6YebosBu1O/IGrWNLARvnDnXzfAJsXE7HPfVFqukl4k3k9ZVYw6s
	 +yj3rjRk4jJEaXuj/8K7Yh+wERAkNekdWmdZHuwktX8ys/lb/nv9wBNLa7r5FiVcDiOcr
	 1zC4ThQ+BpQobOjBRrMRHQC4znPztHJk7o/O05rCyDzglJMjVc0rOjENhdKwG9PUQeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H0G3eb09;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C449606A31A
	for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 07:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C449606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H0G3eb09
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-369f33df08eso2955328eec.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793433529; x=1794038329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkC7yBaZrE2XAa9kIglc92DWg36i3099yYhR26+EG0M=;
        b=H0G3eb09ygcaFWSjKKmNKV+YORd7Smdlry6rmKBzidUhveLgb4ch9hs0W1HQ0lWXkf
         gpd59b93tk00qK4wRbOUf965w/GrwfhPnl0QW23PhLC4Q7C/mLgJfdTXtWzP+JAhTbYY
         zqX5vROdDRBoe+/qKApKHMCjsvHh/0sziWaSDGbIyUBANR55u+GwsdBcEDM6Jb/ayZHW
         yU4frhxTLGADCvBWMwtMZh00efdFSzLGAtq0gWVbgKkzcYrpDAh2ZPV9nleVWECwZEDj
         4qs4KYVpOsihEX9QCVonpWWVRtJjuS8xWlszLDMntU38l4OMZxg+/zNRCGOLBxVf8+4i
         F9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793433529; x=1794038329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YkC7yBaZrE2XAa9kIglc92DWg36i3099yYhR26+EG0M=;
        b=fbDpQkqJsH4HXeepoZdPI4JJHDP+4WVW9Uz2KpB7oDDSxrpyzGwkskDo/HTiSQzykO
         rmWdW/1rK+vzj9rNkT7TFkTCRLF4H3H5DUgREPhTdh1f7mXitG809O63bLgCSUf7yMxz
         dbDYAadaK7n1MNRLDG3xLYsASPyyeVzONUf6WE1StKm6/FIyUCN2SVa7D6Wb2iUv/wK6
         p22t0VGXGE57HD4VQYVf0uqp8hanWRthshQpya9ylxRvyAUJDKG/ct6kMWmFSbs9BJ1K
         gpXUB652j1sPQuEWlETUKTSQeUmP6UyrPqkm5gms2PYPq+/YZdi094hG316MOkaeSbWl
         Kv0A==
X-Forwarded-Encrypted: i=1; AKwUvBz67zbNxFogE2L9t4/s39ictOoN1Rh41iUULEL/kVHIGkRAllyCMNOcwYF4jSRxlzKAWrRqjoQUbkA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvfG+eAUXG2xaOgyfAiw+FyLnUEOoUnNNJcC7AZdck9b6zxoT9
	tsXJyNEg/3GwRzuTW2q99IJxAGE6xIhrjacsynoLwBrsjHyA8Xzqt+cL
X-Gm-Gg: AYBFou2DfsHKvVxPjV/mZrxrZbfQ530mcUA78b5OgBDlBcbXBR0hlxBFWfrucU9rQQk
	X5BXakmS2g9Q1kUlIF1QPHXv30mWdopEnqVSBD15kI6wXP+xNlKqOD9oqlYi6+clNTGZ5poagYQ
	5T9444f/x+JcNcIficGxEdc14FpHAJKCCO60sJ8kIWrowyV4rnDWhUJ/JuYIWTS5L00qXptBRwl
	xyKcb9kgOEHFF6ZYNDKvgYqWGklIhh9Bu68fpX1oUwa9wQv/V3vhe8LlIRR4bCTt7Hc65qXIwZF
	kB8lIdUxsSVSPeodZtC6v7Tgrt5htAYylM0YoEyxhBaSkWrotG695RFHyhCYZeLhRZroSsbyOEA
	kcrBZ+oP1Bq8WzlqPUur8bSF/xEBj8uFbnk9y85RYDAG+2MGvcpkaZ70Su6CaugKHelaOXvuFax
	iKA2Gm3sQHzdp29LDcKyfeJYbsPfv7TJ7XZLcubAd6RdEspMopyFU41mrVwHUbCS/64oEzCZz+m
	0XWC2btCeMCBuKUDPj/bACLruzAEADq6pCV1bTbWuNdWMAhCrXpD2ZdAh1wzoq+NawPkQhFvZKl
	mOrQvmxIZ+EIu7bXoPeQp1nCj//2EN4USerFf6RuMSMxRPHCebDEhbs2mg==
X-Received: by 2002:a05:693c:894f:20b0:369:d992:e3 with SMTP id 5a478bee46e88-36a4242b2ebmr6391012eec.32.1793433528497;
        Sat, 31 Oct 2026 00:58:48 -0700 (PDT)
Received: from archlinux ([2401:4900:ccca:8aae:db4f:18dc:62fa:a502])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm14275467eec.8.2026.10.31.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:58:48 -0700 (PDT)
From: Nithishvelan M <mnithishvelan@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	Nithishvelan M <mnithishvelan@gmail.com>
Subject: [PATCH RESEND] staging: iio: frequency: ad9832: use devm_mutex_init()
Date: Sat, 31 Oct 2026 13:28:14 +0530
Message-ID: <20261031075814.34379-1-mnithishvelan@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Replace mutex_init() with devm_mutex_init() in ad9832_probe() and
check its return value. The driver already uses devm_* helpers for
its other resources and has no remove() callback, so this ensures
the mutex is destroyed automatically on teardown when mutex
debugging is enabled.

No functional change intended. Compile-tested only.

Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
---
Resending because the first mail carried the patch as an attachment
instead of inline. No changes to the patch itself.

 drivers/staging/iio/frequency/ad9832.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 35f823f24f..a90ee89803 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -325,7 +325,9 @@ static int ad9832_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->spi = spi;
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
-- 
2.56.0

