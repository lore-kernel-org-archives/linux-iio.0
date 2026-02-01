Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2D284672
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769970828; cv=none; b=LglV0Il8jRwDAH1u20pJr+m+65+QDkw7JuNIzG2dMQmLJKu3D6Fx1Trsts4RBlXrPFzKctsaxU54BBd62hNW3Z70UKgMhQK1A18Zh5LJhAzKjw3+QJ24ZdfE6OygJhsJJmzXCE9OpeKQJm7mUiHjoaQhO0j417TunWDYdknmN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769970828; c=relaxed/simple;
	bh=9aHRWQRIj+vjq7aojPwZL22fm2LfK7+rNgxELwFuuaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvZZtOtK0npS30ifx3GFPVqkmAmO/5F054mEUkrofU3D7eru0l8spUz5PZMvStRP1zbkPo+gLn8AifSPVTcYneRdray9tQjCpNPNqn70vs2tSxILFSahRhiHZA6Dg4eGUe0JHNN6VkUSJzJbvacOdOTqbC6FWmoQ+85Jn60P9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR0h5R6L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR0h5R6L"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee07570deso30969315e9.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769970825; x=1770575625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcfKK1uOL+FesMU0XVhvzXmDqRlJZPCMwhVufj0BSo0=;
        b=BR0h5R6LVGfH0tfCQCAEQb/0vWuK/xFRFuyNVwleUEo8l9QpiyVy7NlSx82+Dk8TbZ
         0KeBwzLECaKNXmuHFSAhxK8NKmZQlIrdgtUfDE4m2LNDnKZZBFEHMOIIqK1g3sUcHuDd
         /b67jfVidRmC8Ozue5HTCdzHU9Sf1naIlan5bX3AQkopetJ3dR0cFojzc9LQrWfHSiNe
         aiV5/rEz2tjGnP/tAiBmRxuT1v+E9vkBZmB5P94BIsvaOBAnzzhq6CcHTUwiwEBQGwF7
         Gz0TvASRdo38a0rdeznpf6+7keGJ8PbOo8X/dcwBeP171ns5U43qam3M/tvi6IQ9VyZd
         ++WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769970825; x=1770575625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcfKK1uOL+FesMU0XVhvzXmDqRlJZPCMwhVufj0BSo0=;
        b=D01kt/Q2/aNjKug00CcXYyUu2m4l7XoEYpvn7cq8P4YbDhi4vTcrT8INjA9TcBjJ4U
         q46fxrFV3LAwFEbZisAC0VUfmTi3FHOHyshPQaCrs+SoMnckFDbliOQyqAT1w8IZH5fT
         9NieLlXqIge6z4u/3NZQbZBzeTxy0oEUtrkWroEGBc2q2NJkQr9tidvIFhZqbYlalbRE
         uWDZEm2Or8O5Xd6+0Tc2E1J4Aa4lyoaOQSAxd14Z9Y1HTrnd/Hg0yZGRzaWUeX4g2grO
         niOc6iB3PZXfWhP3AcZOWKj+zDu57D1/x5R0d299uHb4NODe/W9e9HsPCyDmIDc1pddd
         W/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGonGsszfmzt0DnjjJ2DgsoHSLT3DXLAWpTaTqmrH6+K3SZJiEd2apBJ1mGCvpUSR27D/IdpRV7Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4Y58E2nfB5qG1uYQD8OliUQCV3TWPV2yj2VubUQ1B/Hl0AyK
	lb9Qgs84KneIOTeu33iOTzlnuf6vuW+XvNO/yJLEHp13+YR38bI29A6b
X-Gm-Gg: AZuq6aJHhv0Sg77U/91QmAyaKN3GWHqytjx7629lykoXyjEBNjGSKniUOXadCNnbkNy
	7tvm2AgK5+AeB4GWw4LYGLLbHn6KRuI+dK27FRkqpRCkFpqDg3ZmEI5d0BAOuzWp8kzadsSGN0t
	SNEJ3ZYujB/OWbc7LXV1euxus//9toQW5KrGQeWzRfdrc82JbgcWPI8wydUrHSvRurBNZZ7dOV9
	a9g8YlTNqqoFq3XSl/ZTHaFvbUi0P2+LU9C7UjfoKxdTLTEEtA8NxpLn0pL7xlclf0wmA+6dFkm
	4ZwNBNX7n0g9i/7Dph7MkfPVI11g7fzjZq+mSszrRnIHSUuNb8aC2l/a7Rd4pkopUKcHO0p56sB
	v/5qjyN81qySivZOPHpp/5vPXAZKUQ+NzM8geNlumlKz5F/j2dLF7Hy808apOh4Wb4Pv8rFBze9
	2MUzYYG2+uqjmzXoVCA8LwXF0i20Ds9I2ahxCt1GhJsOK0bg==
X-Received: by 2002:a05:600c:3586:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-482db45237cmr145131415e9.4.1769970824962;
        Sun, 01 Feb 2026 10:33:44 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm41400084f8f.13.2026.02.01.10.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:33:44 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	rdunlap@infradead.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v2 0/4] iio: accel: adxl345: Add event scaling and doc fixes
Date: Sun,  1 Feb 2026 13:33:09 -0500
Message-ID: <20260201183320.27023-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses ADXL345 driver non-compliance with the IIO ABI
for event thresholds, following feedback from Jonathan Cameron on v1.

Core Changes: During development, I noticed IIO_EV_INFO_SCALE was missing
from the internal IIO core. I've added this constant to the iio_event_info
enum to allow proper ABI compliance. I would appreciate a sanity check on
this infrastructure change.

Testing: This series is compile-tested only, as I do not have access to
physical hardware. Implementation is based on the ADXL345 datasheet.

Changes since v1:
- Added core infrastructure for IIO_EV_INFO_SCALE.
- Implemented event scaling (0.612915 m/s2) for ADXL345.
- Fixed technical math/decimal errors in existing documentation.
- Cleaned up grammar and pluralization issues in .rst file.

Many thanks to Jonathan Cameron for the detailed guidance on v1.

Taha Ed-Dafili (4):
  docs: iio: adxl345: fix typos and grammar
  iio: core: Add IIO_EV_INFO_SCALE to event info
  iio: accel: adxl345: Implement event scaling for ABI compliance
  docs: iio: adxl345: update math and examples for scaling

 Documentation/iio/adxl345.rst    | 63 +++++++++++++++++++-------------
 drivers/iio/accel/adxl345_core.c | 28 +++++++++++---
 drivers/iio/industrialio-event.c |  1 +
 include/linux/iio/types.h        |  1 +
 4 files changed, 62 insertions(+), 31 deletions(-)

-- 
2.47.3

