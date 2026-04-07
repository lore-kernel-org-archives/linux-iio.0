Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B5355F22
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575029; cv=none; b=lG9hslJQyV/oR3xv1MExy/Qsa6sINk2Qln5JHOs3IfQlIBQm7ktmHplhdo9sPsdXJwRZ89dK2T9WhmOrc3CxuftN3kRwEW/mzSWX0eA4V44rFAGYH/Dz/qNq5D/ETXPCPYRbfqZ1smo2LD7oM0w7yn70u7r4ImOlDu6glh2Z7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575029; c=relaxed/simple;
	bh=BN2pG+ggdHeNF5nMAlMlL8UpqqNMmhM7u8s4CviSu9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQG5U1NiEIbaoHIrmKYrLQYknK9wHfDrbtT3aIBUZ44XFteSqqsfKMQROvR5+hfAzxMlTpULOXU8EKdJAFW3CMg5S8GUgAcVqB3XX/yhGbQ1OmWQx3nvkL7UQPiAWdE69gck413vT+jHsrU7lnPQkWxGECpja8GiMAlsK27Arzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5yOfu1W; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5yOfu1W"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfb723698so4542208f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575025; x=1776179825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnxS0m7DOJUnPu1WgBcCkLSOJWSnp+7wrzdW4TpX8Gc=;
        b=K5yOfu1WkUX4hppeU5wMMX7SjjlwY6b2kMEyxw0ajMF4JJgHXxmiP5conQdNE22NE3
         wqrla1mDNVwITncGT00YXsvY4Q2UNw/AkNH303Og1BIa0o86vfv00V138kuxGKMJiaHP
         dBBwKwVjZ7c91YL3kQfYHHaEeKYMuOyKlXKgn0+5uKaAu47A0FPGjXptyFw9kukrdNTW
         bBHjbWMfMTi+fwMB2DONJgk66u7pd+ZHsb6GDQqOrxbiSUcXGwHQ36t5VeFOR+Hns1OQ
         bIf8s+ybbEGiw1vGZorzULYLzAGOAsadN5EYiqU+K5fvh59m8ve5lGZk0dmoF6zmMFSd
         8Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575025; x=1776179825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnxS0m7DOJUnPu1WgBcCkLSOJWSnp+7wrzdW4TpX8Gc=;
        b=rg0tt7SyuBR/2Vjx2xlD21SfU/pTlfRBQo4bAKcrk29bmPlHIBh033Dq8lPmjMqT7g
         O9AXQlmZ7lJeAKyljzjieUnV2am+fxCMHJe+llwOP2QXuQbxb6lqj6ky7u7j4DPrXXVV
         0rJ2nxgCtXPuTRq6hT4K6RjFenttg1m8fbQR6f/f/jUSauqi03JOVsPJmTKEWWjKzIAF
         CRzgT0UuJQ8cvfoujZqG+f1D10FduyMySeTx0mFUwQZag//3+t0cp5wBwoQwj6JHhUvC
         Y3ZxvgSzhbyS3x6UVs1LEKuN2PaTx+DQvNX0HBqYgSiJIJ/Pqg7ei7xrtobnyqo1NAvc
         e3GA==
X-Forwarded-Encrypted: i=1; AJvYcCUREQJZFIKUvcYDV50ymrVYY2FSXO80kUT+upz228GWWGpPCu9P8uJNjzJxAvEBV7y5JDU7I+RaFQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtJ67+KNNzE9IIWTqIP5MZBH74xE1d5nbXKYotuhtX6txM+yk
	xez7pDB7BGO+y9DDD5f4CNdZh/4d2r3N7Y9z9Jd8m6nrYJymQog8V/AZ
X-Gm-Gg: AeBDievzM+dyHZqHghn3Om4xzWNSmwt0Q/kTdAs0mPxi4/Y7IkRjB+h97HO0l2fLcSz
	g4Z5rulPJVY3d9/hqhdKlzhEERgANwAP08U52pI47HsZ86+uF3uNfZaI+vppzYatp7yg5n3P7Q/
	dd5OXwDe8WRjzaqOiGUgM+AFZDwNrxNzRuLn63IkmXFNIjSJWCH9ZPtOzZd8AnkjLC/sUXUHDAS
	VYUIKCkw/YAkaC12KBKGYH1M4+YKh6ONLp/vPSctZJgzjk267ei50inLvY/JrMpXFn284wHUr22
	b79VWWfhm5ml0fKrI7fR7OD5MoGZNZI9/6lwEI/9eOYCoTM7NFrExow782siCvepkXWEB4cfBI9
	GwFSetGqRsnFFPfDSkcwYnRgtGVWkqqrOpyn2Co/bWT2BYLIUGn/tTFzlydMyWQzBV/8RnrAqC5
	C44Gy1s6TC7qw/zOG20+yXvi+2fqoKuqL9PT4y8EA8/DdbIfIcO6o=
X-Received: by 2002:a05:6000:400a:b0:43d:4c:229f with SMTP id ffacd0b85a97d-43d292e27admr25354253f8f.44.1775575025059;
        Tue, 07 Apr 2026 08:17:05 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([37.163.52.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm51924922f8f.3.2026.04.07.08.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:17:04 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v4 0/2] iio: light: cm3323: fix and cleanup
Date: Tue,  7 Apr 2026 17:17:00 +0200
Message-ID: <20260407151702.15208-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series fixes a bug and does a cleanup of the CM3323 
color light sensor driver.

Patch 1 fixes data->reg_conf being incorrectly initialized with the 
return value of the i2c_smbus_write_word_data() instead of the actual 	
register value. Tested with i2c-stub on a Raspberri Pi 3B.

Patch 2 converts dev_err() to dev_err_probe() in the probe path.

Changes in v4:
- Patch 2: Add Reviewed-by tag from Andy Shevchenko

Changes in v3:
- Patch 2: remove extra blank line after cm3323_init() error path
  in cm3323_probe()
  
Changes in v2:
- Patch 1: fix typos in commit message
- Patch 2: add struct device *dev to shorten dev_err_probe() calls
  to one-liners (suggested by Andy Shevchenko)

Aldo Conte (2):
  iio: light: cm3323: fix reg_conf not being initialized correctly
  iio: light: cm3323: use dev_err_probe() in probe path

 drivers/iio/light/cm3323.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

-- 
2.53.0

