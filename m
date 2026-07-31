Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026963EF0C8
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504089; cv=none; b=NhqsFXSQgEngBZgSDqGTDbnvCrIjtoBexltI/h0wsoCJ15BGiXbEuzveu//PaBI4aVJ1IthUUP6EngyeV+c5bLut6eeib2TJXoihAOGPaAbOpzxNfNvFwqMvquHxd+JmUSKA+RZ9JvkPXp4IjXWMDapG+ES48C0EYUZcpSTbE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504089; c=relaxed/simple;
	bh=lPdoWeeyKj9fSYT1nyRXwOHG+zy531mjImV5i72oVKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0Sp5ayQgLrVsufq2atTa00VCxqP8YTIW6TW9lNeB/POsdld/155iCSamqwL0dZ+slmUdQ0Zyoom3WN3i++agK4Q7C7dLnMoVZaJSz37v4rLZA2rJ3XVkqHZxQrOcoPW6FX1L4V5go4si6ygnp9hV04I73TzTy4Tqxfb1lkR96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVaZh9E7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVaZh9E7"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698a99b1c37so158552a12.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785504086; x=1786108886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FYERtEQAnWQOlIECqIVTadIigrKOp3Tps8nppRp0o/k=;
        b=eVaZh9E78yYp31SErsSQOMEC8qnIi6AVX1OE5exjq2MYeXyvvP3XA8pjBT2/xpSgpe
         unTBQwgzsJmyXBBupdlQyOivUF/POVED4BrdMcsFtRkAHu/jRkhsE0I8YboTURzlDNx8
         yrDygROHy4wwTAeoTNrG7htXKCS2iox6eHw+p8IRcKWsDo5J5NFYoiEwd9eSkizVPhiO
         Dg7cwE6wTbHwRPKCrTcrvfSquJjHcu7+1f33D2D8+viSoz06MFr8tbLtLzIRWPMPh081
         tcUS3hvkcc/eVQYGV4IZKEwrB3LwwEaYRHFCEmPNYQ6sM0Omx7sDB7Og/AyLvYnzA0+R
         Hikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504086; x=1786108886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FYERtEQAnWQOlIECqIVTadIigrKOp3Tps8nppRp0o/k=;
        b=NevTELDkwo5HnCJQ3cn19DPR+Xj3FsSGYYIZeJ0thC0W2AwBWnel7Msx5hv7jhZf8A
         5Q9b4DSayAnaxV3JPFGV76px+Aw8ZymVkrSRywmxJddXKAsZdE6Iova7blhN624ToxwJ
         5rgJZB0ifS9vkLa/A5hXr5h3Idm2WZ9aZZna3GYMLR57DuKKfC7eOQW1SCy6eaw/eqY4
         NY59UeVbzURz6ClmfgVegFTS7CEcnComtS5/Taxb+VPpEqD2X2SwWQkNj7IARHHnVhB+
         4brdPAhDDOuM+byd5B71joO/DiuOCqNCqdZRhoIRygFWGC57CLeEqKxiFDoeL8wH0djJ
         u3Mg==
X-Forwarded-Encrypted: i=1; AHgh+RpUfiAh8BpzuNySQ82pTo+9cDxB9ac4qvmHe9C6buIw64hvXi0VNFQO/v9j72mXudDq5BLuHXiRL80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9l2g7CT149xeY9J39Zzv8QK23/+0p5OLcp+wWkvxt+mPhKfJ
	5zR0uy7p0jhkzj7HbcBnOywaFH130DzqkLVXNM4afuVg1mSm4PbrKOub
X-Gm-Gg: AR+sD13Jlic7GR3Whk7kGwrrV3Br9o5ET4LZk/dS357XS1ahMnA/cSe0KE01AbnQzk/
	lPfPHZuQ4dhCHIiRs41+hHjg6i8CLf0cD27Q5af5+SSl7EJOrL3fSWyjLZVCOBcPB6HzaIV1oFR
	OcAzTKKuqsHAObaOB4oZxb8rXSB5Z43LsbOqsMgAnec9nqx6x+nyLXwv7VJshCWBCqUxFF5eiP2
	BUMvXS4/iCfr/uedStzfT1TSCXPiusumcaUsA0hGSTi32p2319LZhWfhVq1cS+oDJQpibdOYjGh
	hv+hMAunDJn1uTId3V4Nfo2YlzIIGGAxeeB0Vp7wqT9MnaFaP4vNvUkvX6pQusKgPh0wuwQ6lSJ
	/370BwL/wBMaG0CfFzKjPfQ+koRPLjCVODSpgy4u3P1PnujZrA4CXhzwo1qd7t+7K9/zgcKt0sm
	JXOQEyBz22QuwSYZ9XjA2ymfmUCOKwxaLi1RnIt8eqQHYJVrveE8NTWwiElhbf6wh149yNkMLco
	tAakAANqrdSoT62ecWSSdhosLHsNWriV+XAZw2pC+KbY0e2Ij6YGOpI7J9QyNFR0/xC5/Vnwam4
	wmEwfIR0sSpwZA==
X-Received: by 2002:a05:6402:4287:b0:68e:4c0:f59a with SMTP id 4fb4d7f45d1cf-6a098d2b24dmr1467405a12.2.1785504086003;
        Fri, 31 Jul 2026 06:21:26 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c664713sm1548846a12.30.2026.07.31.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:21:25 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Subject: [PATCH] iio: light: cm32181: return zero after writing calibscale
Date: Fri, 31 Jul 2026 17:20:48 +0400
Message-ID: <20260731132048.199946-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>

The write_raw callback is documented to return 0 on success or a
negative error code.  However, the IIO_CHAN_INFO_CALIBSCALE case
returns 'val' (the user-supplied value) instead of 0.

Fix it by returning 0 on success, matching the behavior of other
calibscale implementations in the subsystem.

Fixes: 971672c0b3cc ("iio: add Capella CM32181 ambient light sensor driver.")
Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
---
 drivers/iio/light/cm32181.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 2590fc8fd154..b32a94028f09 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -368,7 +368,7 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
 		cm32181->calibscale = val;
-		return val;
+		return 0;
 	case IIO_CHAN_INFO_INT_TIME:
 		ret = cm32181_write_als_it(cm32181, val2);
 		return ret;
-- 
2.52.0

