Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335631AA9B
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778400661; cv=none; b=RTN0C1K8yiT+O4pkQfZxK6Y8D+VP3YQ4bnl0Z6p3vSj4cDF9FGjklxxlblT1CEhoRaasz3b/9gmRl3ARFrwbct5EDozFoZhL4swPz5HWAcyf8/FcZabWzLBwSJPMvnFpHuKLIXEu7Piu4nqqDOAVtn5gNF9o9OmOWiPvhjeTHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778400661; c=relaxed/simple;
	bh=qV39xNtfL4QWl44+opgnZA/dVGnBNDm/6My8Yisoxac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6yCcN5ZPvchdAE7RWVvndZBtPIRz2XOhO7P13ExdNQvtVstdpRH6PDClSTie4L+fQOGxkd5e5aujDXW/zyktsyIWhf8fCUh4+akZphr/DH1+GoCLjuTjBVixuXfJLBFdHBmcAIy+fwjKb0eQ9q9LHGG6m2JJXpHBkca8/S7nng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qW3a4ALG; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW3a4ALG"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1309f4ee97fso4216949c88.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778400660; x=1779005460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIvPRt9dlizeEm93tbtAZzvWwvO1azBOrboHx0X4jRw=;
        b=qW3a4ALGwDPT7Jkm5jDpnDIbkNo6znjZS/sC64xJ0u7nMQvsLb4MaJfDuwDtl/kjE7
         boy1iT74PXqRp7efX7S5jt4UyXP4mtO9is4pywKuFlY1oY0ZMsfJDxk0Gp98Fml+ggho
         62JG4WqxdOVk5lyg1aOm63T0ufw40Iva8KqoN/6+zeNzbrfxInbt0BRGkU8mpO8DnjVh
         EdhOVz7jr2V1YQS4IxZhlrSCbWHWA0/32Jp24MneF6OhXykQxUchMKVMVLc32SF77xbX
         AENrdZWl/pbNu/5MuDmhN/wIckwcMxAH8Zy4hpK5WCO5RNZz79fFlD76qGLxI4u0VEf+
         BVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778400660; x=1779005460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIvPRt9dlizeEm93tbtAZzvWwvO1azBOrboHx0X4jRw=;
        b=IhgqieK+xGaeG0KGbxUS7Oxk9hH1VxFBLpHz1O7iULQp50+pcbu4dLKPaY9nts4KK3
         chwGZbGaIsHZahSq5fZPqKPuTURJK/Rfetc0FClyBv5hWdtQzBzHD3/+OzcGSd68aPc6
         +Xd2Sa+RaZ6lpjeAoZCx0V1T58TGKphSW2GmGuDRRZf/L9YqwCefSQneDdQ2eL4t7eOC
         Bz7MhhQX4JbGZjFQcUzLWfwJG3AKkQ8x4JgZpEkIBV6MAWfDBBHhXXS5GkUVJaHquxas
         9PUJkwgmghh1Q6+Nib12rnGpB3bAXhwEX+x7vGzmql3lyWw2l5y1pnG+rYfekGV2Zw+z
         FXEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8sOXWyvMSgD9taEzfXlxxXt7ujPZVgTmkOdHtdM5AHEeJXOOtDMhZQbE3jDfrpsbI+OeCbjLZqUKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIpgl9ekU9l2B/4GQZ+a2bJmh/RlThQd5mRImErWvyf1uf9cp7
	rLav/ulQZAQWiB028a3mQHIJeYwAtWmbGGyE4v1I1ndk4shTiktHfKKh
X-Gm-Gg: Acq92OEmdgdGUyIPCt9R1DYEosztrnb5Lv8ayIOT1bhHbq80vatIxo+7G1x2N3FugOB
	HGKWOHDzasBPu5tigJpDsHA918CrOQjs/HmFTAL4LE+LDlMmnDbu/STq+QqqwLnNdl2XsYTVBDX
	lUee3KT6bpVFFQlla61WgHt0sH4tG+zIwZKJckpzibx1+ocPb/29q9Ie1xEKaz4k+gN5L1iMXCJ
	CTsit0rf43/gbjZ/LuxdkCLZsdzSdk96Z1MeYajbUcfhFsvonrxGx+TiCmKMgQGIjVmqDyKfeOb
	7KSedVZtvpv7BTBvtC/Rxq8aAyMIAbJNtZWOh/P6G6TEuOOgjv1ZyG4fFBw/KRz5JECFd8yhe5q
	RQb02Dz4s2+40povnFUs2FHZRYOlBY/it1QjSYclUJ0oJsFApro5oiQ7Q8TLm18yG9vD3J9pIqh
	24d2ace1TOBUtqdxqJCgdS6TnZ2bzZfJOdmLZsUcl/v/ndgEGE80Ce7LKfdaciRSIY6g==
X-Received: by 2002:a05:7022:4a9:b0:12d:de3e:be88 with SMTP id a92af1059eb24-131a69f2f19mr8868177c88.36.1778400659598;
        Sun, 10 May 2026 01:10:59 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm12053688c88.15.2026.05.10.01.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:10:59 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] staging: iio: addac: adt7316: document SPI interface switching sequence
Date: Sun, 10 May 2026 08:10:41 +0000
Message-Id: <20260510081041.85880-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device powers up in I2C mode. Switching to SPI mode
requires sending a sequence of SPI writes as described in
the datasheet.

During this sequence, the device may still be in I2C mode,
so SPI transactions may not be recognized and can fail.
Such errors are expected and are ignored.

Add a comment to clarify this behavior.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Add datasheet reference
- Add TL;DR note

 drivers/staging/iio/addac/adt7316-spi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index f91325d11394..980532b7fa1e 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -106,7 +106,17 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		return -EINVAL;
 	}
 
-	/* switch from default I2C protocol to SPI protocol */
+	/*
+	 * The device powers up in I2C mode. Switching to SPI mode
+	 * requires sending a sequence of SPI writes as described in
+	 * the datasheet ("Serial Interface Selection" section).
+	 *
+	 * During this sequence, the device may still be in I2C mode,
+	 * so SPI transactions may not be recognized and can fail.
+	 * Such errors are expected and are ignored.
+	 *
+	 * TL;DR: Do not change this!
+	 */
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
-- 
2.34.1

