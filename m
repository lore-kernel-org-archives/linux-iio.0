Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B536AB73
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113101; cv=none; b=VGMstcyVx4ByLcwAtz2NqMZNPDZlDj1e7ja9WXhzjht2DD2C9Qb/zfHV4uoXqPDO9gfG1qvsZ03LTsLu2q+wKrTF5bpActimkKb0Yku7uYpA+z0p/v3hVPlQJsz3r/tguWIwb36cNP042UOdIElStkZt8L5ObHYrYcW8fipscxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113101; c=relaxed/simple;
	bh=wVxNffTo0MyurTujHOZd8sjHwapMrj3UcnLfWc6pU/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Slx/3Xxgc952QTIytoZtomwdyXXIA0uwtKKmYQBiDFF+5ztKQlqSYVXerOztB/fbE04gz8Gp6WHu9XP7YG2L1zQUwqcXtnim/6gckezA5xhqsm965Xds2WqWPiYR6fLU5W9zNvBAz42Z6dIrK2j8/2KMIJA1Syd9N+i7mprzQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7GjhCWI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7GjhCWI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43985ddb926so62927f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 05:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772113096; x=1772717896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5DnFv96R8qo/DzwUZdYVIzEVryNz44N4oswd6WMEXo=;
        b=c7GjhCWIw9ekr/siomlVDvr7/VKyxwROpHg5HAyIzjfqYsZ6E12VTIWttGVeQKbATT
         AQtvblpB4GLZX5y3tDM3T6uNiP9JYncrhXPArxAMp7PyIjeFA8slprel+WR7zcco++jp
         6FGTUhucGI36CIZIAOJHjF+CEQR1qzR8ViBFxatKCdzFnMa0KwvF6STKf5FZx7SVBYfX
         E0oDmPJmFsc4SGlb1RMzzG/s9/VS6rPSfB30KbVnxw5NqwiVenUbTl4knuKShg9Uvyux
         l0S0mUPsefMz+CHG+HjMcLVRlwnxMCHtupjvsSo+/VaN1CGlwZzk0YlVrzg//hPSEOFE
         q2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772113096; x=1772717896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5DnFv96R8qo/DzwUZdYVIzEVryNz44N4oswd6WMEXo=;
        b=ukn1nOED3RbKU3M/bQZXD3i2jvorEr2XDaPu30slyOAXU7BjpZdzBQJTVv8iQPfSKP
         u0R2YbU9l8LxLccIDTwal/zedUT6XCTw+hLzRKOnIoX1Fu8WT/cGwcQpG21Hi+ls1uVW
         X+b/vrm9q7Vmzku+KrYIQZA5iJMnpdvg2hgdGu6yntQX23t/OFlsbuSo9Al5rIzXyAAY
         wSa+g5D1acvrXd1AOTKU4balXI6huxUMhnidp5QcsMXUJ6ZlWKxKjDmQtXKmOWVH6gsX
         D/VFDXKgY47tuobnuG9pvyKh3csaYrp/wSrFaZqkLYGmYE4YbDv1WWkx0WFZjFPmeviW
         HGug==
X-Forwarded-Encrypted: i=1; AJvYcCWqbdYDfdSlLGCCaPCAipaZMYivWhLF7gHA+2bVTQvZZSiI/nbe2Vk5d+iluhpbuL4MNpVNoxLtbuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdVz7QG5GLhDXGF+tK5miD2skmjrfQ7qr5MmMTHv+vwkZi0+R
	HSOT1YxpMcYfRxgy50N7TcjRkv3KjPF4zXm2aaSwI9KDkybWZtF3w6nE
X-Gm-Gg: ATEYQzziJJzP9a8CiyH2ocCO3kX8aL4dMXP6k/xcTI6BCB5UR3s5IjtGIKkMka5LivJ
	GqQM808vRdtnzCGZpsAyauKFiWss24TjvoB2SMcv4xzlDbgofmNhtX62lVFAOIz4ig3v1EOOWQj
	0Ql1ANFeZbYPw8dVuiY2QvQGbgrEZx+ztHI1J1g4QTOUmZtYbEmHTGbgYvF8FdYbAnF0SKVjZTI
	zyM2yVmI0kY70YTB73x7wO/lhw+e4p5iK88e55avb2OMKCqtbEQXkFJx3GZ5eL8r2pkJD8OSa6d
	HZgAKsXyZCXou5okq6Y+Rxy0oGK1wq1T9TYGBmOmuXYY+SeFkEcW/YRxqZkZ7Fmi5R9rKGdJl1I
	x6NbkAzkTRNYCMNZ2OBTBJH+TQNX3q6/hLVT58rL4YoDx1cE9rw3f7bT3jWMBzW9XMOdKYSznjj
	a/7nKeD4FNKtxyk5ovWm400B3IOodgRiR/aNF0fvar1AMmW/CSuV+PcxwvsKEFC/fUnzdYgzhyR
	N3P8Vpey0Lgdod0T7IFpDgG7DQyhWffwpbXL/br16nEN3Me1FYD
X-Received: by 2002:a05:6000:3109:b0:42b:2deb:829 with SMTP id ffacd0b85a97d-4396f194113mr19214226f8f.3.1772113096294;
        Thu, 26 Feb 2026 05:38:16 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm19235652f8f.7.2026.02.26.05.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:38:15 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ade9000: fix wrong register in CALIBBIAS case
Date: Thu, 26 Feb 2026 17:37:42 +0400
Message-ID: <20260226133741.437403-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch statement in ade9000_write_raw() attempts to match
chan->address against ADE9000_REG_AWATTOS (0x00F) to dispatch
the calibration offset write for active power channels. However,
chan->address is set via ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT,
num), so after masking the phase bits, tmp holds
ADE9000_REG_AWATT (0x210), which never matches 0x00F.

As a result, writing IIO_CHAN_INFO_CALIBBIAS for IIO_POWER always
falls through to the default case and returns -EINVAL, making
active power offset calibration silently broken.

Fix this by matching against ADE9000_REG_AWATT instead, which is
the actual base address stored in chan->address for watt channels.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..1499fb1c718a 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1123,7 +1123,7 @@ static int ade9000_write_raw(struct iio_dev *indio_dev,
 			tmp &= ~ADE9000_PHASE_C_POS_BIT;
 
 			switch (tmp) {
-			case ADE9000_REG_AWATTOS:
+			case ADE9000_REG_AWATT:
 				return regmap_write(st->regmap,
 						    ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
 									chan->channel), val);
-- 
2.52.0

