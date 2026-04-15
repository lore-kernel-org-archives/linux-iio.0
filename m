Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F2281357
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240514; cv=none; b=FsKqvpr4rrtH8mn4+dF6MMf5ciwDiG9fEwni5cfCcUg8J4l+7SKCFhj0UmHaP1jRNHzNl4yjT0hbAWYPM3ff+noHEkNBj8izWm84XjVKWK08NSYcx7ZsDTg3+1hVGAUTZS5uTZGIgkTVjMzMtVx4/gZktehSR2ZRyGLktrmcaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240514; c=relaxed/simple;
	bh=3AArAB9JkVvyDUqHt5XNi95GMBX1UFZCe4XevFQvJI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rj+GO2Vmgn6BgeYmsSxPjfhXRhkeQIMP45vM0M/h801t1Wtbe2H3RN+sZ+FzsArrgg2LUvMXLCsiI/3zu9ptzc8LyfoKI5Zb1tuCSZrTbQ0zl1aeDm3b0o7Nq2nCCiEGQWiijM2siSYDoCPagJ07vjPP5i0/iRNu3CT6J4xE0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYepKO34; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYepKO34"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9c745e18a0so955432166b.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776240511; x=1776845311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POKoIB4YdAqGLajEiumFbnc3D55zVPH6mCJ2YioMkMo=;
        b=iYepKO3460kgUnyOwiqOwOab97wyp5FyReIo58CdWoEtN+ti8TSHzidggru4hWBjLS
         /tagQfZyB5P5QQFZXJ9dEA8VX/s84o3teIy1RGImryOyQbay96NEfBdJ6yfgcaiyYpyi
         pe08iQU8QZdVRtkrEYzP/PblITyBfYCkvzDauwKdsPkLu/w/YqlA52V9fIUSoiBx6ktp
         jnw6v9P6rcUcO5GBQOTtlOdWiWGlFDREqBQhs90x3zHXCVjnc1e+qKjbSWfdKEo/GT98
         evY1SYIBZYzkU3+yGQ0pX+zzbyfv9bWyCy7641o5QAmF1JT0G5cmzxA4EchDWutnoueO
         RUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776240511; x=1776845311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POKoIB4YdAqGLajEiumFbnc3D55zVPH6mCJ2YioMkMo=;
        b=BRXB2xNV62q1fyZysJmmdujhz2TsopOtAfMT5m0QgtYQv/BewFRebc7fUpQsZjqJav
         Xfca1Q81OMB232/9I6zDqP8bm6o2SKnBEKe3jHowvyPFDWrnNvhbCin7LGCaIOSQZDnE
         y4FB4yM2xHH2CoLxkCGKCpbYthcUPw/SCXpsgUFV8t1zDiDgA0BDgooqzWNxV5cIrP/s
         kx3C8Ovkno63x+c2MR0QLXwpUc4q2epndai+R+uyw/NwJqanhsojY8G3xs8dEZ+zxJZ1
         TAzgOwuRE0qRYi3gsBL7JLfy98uu9qBzRZFoCgnxGyJ4MNjTyqGKxiPYvNIgXyz1vI3S
         fx4w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZZk2PCkAD7ElWKJhVo26nm4/QCNvh2rEhNGXla2/2Ss0gUrrZdJMdD4bgw2IuqkdS8DUt8ggLKuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vv+B3NDnUAe5PaUNbyz6jR+1a9BK2TMWYnnoQ1MP/j9whDPg
	KcacC82pqiVMm9NWERPLKE+KgR/ZY0GZL3INUnRnj3W4Iw4IpiNcRzRpRj1YbS5p8Rj+9Q==
X-Gm-Gg: AeBDietF5sPbU45qEsISI8ooHpRwAmsavaQuWJx2kp0RfT1Hmd4arrqRHlZ7KgKHRgC
	Vlqz6TxqPIUk6m6VheB7SbF+KK5G4mrd8tM9VEo5Jy0bMorkG+pNxXZ7n1FUh9pB1mDclz+7CLx
	zZ9OsOT7WzrKv58XrcVXIzAxOzBktH8hTRZmHwiSgAP/XaPqvsRV4oO65SY94cVj4mOHDBaoH+Y
	KAlfefFq0XGzpXES7bfHP6iXberltvA3wcboIoyeuFXg0d3LGoJJkGueDoO1Blp2WQE1PE2Vh3I
	fqS55zobiDR77rpKTbGsIk9wxY39XKCJpyBZK2SWidkZ9eSbKKhA5wFl2XQAqae9siPaBCt5p0f
	iJ0TYJDME9sFwFyG0mCSA0l59uT8boPV6eTCfJIC9QOs9DrRCjfKJ8rso+cxXFtcjE5oCZ/audW
	O4k0pzoU/S5PlNtL1k/TY8KUgNqXP4zpS/XS7GaFWtpjaCVXBAWWv7gzpshCwAH0nyHJ9H4Yyoo
	/P0ih4BJ9iB4nng68TRg23OIjPe6kZbnQtAP5gz9uU9MWIYXO+IQAp3lv7YJ6qUlVvHd2pxq3Xr
	glsbQa7708Pl/+gtE61VDWMZbvydIRow93klkMaRnSQ2YEWFV6H3CN/YF1moZH+OLTbcaHQqQR0
	JQ0nhPeSI4UL9OhFfwWF7P6Ofsg5s1SLKAkwdmD5NB81tN3F2t68LLoxPDrs3Q5MDb8voyHDL1j
	CiQY+kAU9zMw==
X-Received: by 2002:a17:907:1c11:b0:b90:4838:46ff with SMTP id a640c23a62f3a-b9d76da5ee5mr1129889266b.21.1776240508407;
        Wed, 15 Apr 2026 01:08:28 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (239.185.141.34.bc.googleusercontent.com. [34.141.185.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1773c2013sm29720066b.34.2026.04.15.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:08:28 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v4 0/2] iio: frequency: ad9832: cleanups
Date: Wed, 15 Apr 2026 08:08:10 +0000
Message-ID: <20260415080812.1284-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series cleans up issues in the AD9832 driver,
including proxy header removal and bit math
simplification.

v2:
 - PATCH 1: removed redundant bits.h include as it
   is implied in bitops.h
 - PATCH 2: changed ull to u64 type
v3:
 - PATCH 2: remove rogue vim typo
v4:
 - PATCH 1: removed slab.h based on IWYU
   recommendation, header reordering

Joshua Crofts (2):
  iio: frequency: ad9832: remove kernel.h proxy header.
  iio: frequency: ad9832: simplify bitwise math

 drivers/staging/iio/frequency/ad9832.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.47.3

