Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5F3845D9
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309088; cv=none; b=i9cjmX+V14xK/SsQoUKxTCsG4SI7Iyjl2zCNmsKBaeyb6HU9GBMcEO59UkO6RV980mwGSVXFSz0Slam0kKyGeNrHO+KRRvMfWq2KUnD0eMrk/HZSPWz/tKfvXhua89BCxBWXoG7+MJngywRsIaKENrK6ToHdl5AezXlQkYcxMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309088; c=relaxed/simple;
	bh=DkOQpD4lRejOxmK9oIvR5xMEtCH7MLNHROWYAAlBnnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmCSKX8xrqnC4FZlRQp+2HHvTCJOzg5K8eego23IyA5JGSo/tAyCC3ly0wT8YD0VE8cQtnmOzmD98A9iJpKm6V/HI/benrCZ7btanyZm0wzYBqDQ2CTjCrEbeHV0pvTlNPA6S5tqkaReJi0ZwZj2uz+MGUS5uaGnjK5ZPYxHMlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQwz3MpZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQwz3MpZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso110122555e9.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777309085; x=1777913885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o3ZI0LJNGOCBI20WP1P2qZ+bTqh4ah0JmxhMCroQ3y8=;
        b=qQwz3MpZAt0iEh7PC9aI9Oo8XKunCDt78NWJShHej0wPoKyndCRbruLhZbO8klclQ8
         S8NnezAcBwRPGi89qmrkFa+I1mMDDx3VuppDipwEXn4jkCpiXZuHdClT0cUtF+v0UkMr
         4wzlB7+DvisK5leex0IgWIaOW2QcG3wX1HgzIMCN8x3+UdtUWKeFvUBGgXZ80JVLmVqo
         Pmzs+X40SgeTe5GumuL254c0OWNM09DFvg9n9p/erqXEOvSJm7LD0bI1mIcg657zzk8q
         co38yQd7VYciCg9Fl3Mgc1ugNHEVJK/NoyJfKQD+6xCvAshh2lHlA+B08ulAIrWFD6t6
         P7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309085; x=1777913885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3ZI0LJNGOCBI20WP1P2qZ+bTqh4ah0JmxhMCroQ3y8=;
        b=k8GhMjafn5HF33YOY7s98RIT+SQHDge4AgydK45h2Pm5XO1Mf/MauC9dSQF1VMJ6xd
         sQNipwo3OT/IyhPSO0Mk5u+qbR0/Slj0ssCY2XU+m8/5KqZKL4F3s7zzRSyRO8uT8CBx
         F8Mn5vOq+OGnF5yKnV4QzSMdIuCQdRZY4lGHJdXanf5e75dDsEj0Nn3Iqmy11fv1sv1E
         rIWAarYZ6SdrvpJ/RNTZbGYPG6PU+0opO+eCzg5jbWMuJKpewGPCPxlsTDX+yHFzQ96H
         vUaoT8/2+fDcA2VLuTHAkpChTzuIW4TXtgSZstL3FkXrCroncQZ1xsMZkCSzdznrmuE2
         YSKA==
X-Gm-Message-State: AOJu0YyLZlWh7vO57glWUTJ1XDy7iFenBy1H2fxd9uT9Wvw5sw9aowoz
	KOp7p9WAoHk1kiJN5oTF44mM43aMOZHbWccT41077ccPb1NDHTiDBvyI
X-Gm-Gg: AeBDieuNyEj1veo0nHQXKRhmg17vUBWIiSDBlF6SeLbrqR2D7hiRIcFWll1Ae9jCKoM
	CPjB1a29YCaQH/CwpZphkHmZmlU8hz6eNXCqC4i6QzUtyG1c14rdNBDongFkunUgcUCYMZfSJxo
	hjijWKmwXdr5IBalFapUufgONi2S2xfSGYJywHvg7yv5yjI4ccnwCwNffZUYloZElcMT8XUuz7t
	PUuj5r8kdIR1JK+CYZtdyaraIpbWyhiqgwimzSZ92Srl5nr7h3vnkT1rRNph5bAmhdM4m0/5NfE
	T62p2RMGBqqCk6Slk4S0M9VgkwmgsKbZAyzR7wahGN35MLfbKRtRRLIBIFkOpEG8iypK0Z01NJM
	H7P5WjPxHztf6tqN9sugXAOmCNMUrWI4xtXU3GpjvbBXijXsJOnxTf1BT4k30VmSrOsWYznfnbZ
	gLpJAmCZfYUYQXdrzTCKBZXH/t2I+lS/dzG+yOXKZZLOXA+SPl
X-Received: by 2002:a05:600c:a319:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-48a76f91970mr1400915e9.29.1777309084799;
        Mon, 27 Apr 2026 09:58:04 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a76f7f483sm2721465e9.0.2026.04.27.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:58:04 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: adc: mt6359: fix unchecked return value in mt6358_read_imp
Date: Mon, 27 Apr 2026 17:57:59 +0100
Message-ID: <20260427165759.5756-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt6358_read_imp(), the return value of regmap_read() is currently
ignored. This is problematic because if the bus read fails the variable
val_v remains uninitialized.

The function subsequently assigns this uninitialized stack value to
*vbat, leading to incorrect measurement results being reported to
the IIO subsystem without any error indication.

Update the function to check the return value of regmap_read(). Ensure
that mt6358_stop_imp_conv() is still called to clean up the hardware
state before returning the error code.

Fixes: 3587914bf61 ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
- Added Fixes tag.
- Re-examined the entire driver for unchecked regmap operations.
  While several regmap_write() and regmap_set_bits() calls also ignore
  return values, I focused on this specific regmap_read() in 
  mt6358_read_imp() because it leads to an uninitialized variable usage
  (val_v). This makes this fix critical for reporting correct data 
  to userspace.

 drivers/iio/adc/mt6359-auxadc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 6b9ed9b1fde2..f927bff4a26a 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -497,10 +497,13 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
 		return ret;
 
 	/* Read the params before stopping */
-	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
+	ret = regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
 
 	mt6358_stop_imp_conv(adc_dev);
 
+	if (ret)
+		return ret;
+
 	if (vbat)
 		*vbat = val_v;
 	if (ibat)
-- 
2.43.0

