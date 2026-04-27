Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379F31F9AA
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320781; cv=none; b=aBxX66m0sKowkNPDhB4iBg3ameoIalrbsTy4Du4Mep41py5rMtSrBomHFI2PHwyYTx/M1//8UX6XVOk4sViOuG0vBFsDGexkT+LoEuPpr+VLbJHI32xfHM0MOIkPFAxYYdqVzAmFPQ73e6ZMuRMWIecQxr/gqHibPjc2dtWZpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320781; c=relaxed/simple;
	bh=VDD3EJcDxtsD+v0HZx6dEJV9wSDLF2KCddUisNYKU/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2gnseMMF08o/AsMB79B6XtUw7pDeESxhzNn64bM5kYU7pWEf4poWEcTW1j9IaQpECLzEqhLk0RDSYo/iyi9ZrvzeGlPsvfXmotxq7PtZzULLihRY3znfYz3dcEfKQOkT2qTWtPTaC35Lh3wl0TlayeHCVbTkhuQV5dArtXl3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGH2Vplz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGH2Vplz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-445795cf6f1so646026f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777320778; x=1777925578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XX52kU6I+oTtnTaZWgm7ccpRK71cywO/xadAPHW06nA=;
        b=iGH2Vplz7bIKZ/7mOc7YUAgAlT2IZ6UkfsLNW+/1WNBgtF8XiW109XqzJVeeRkvLBk
         DyIN0TnEGG9Vo+2pmEqPrEx/im/Lt6aCuumJOoMHzreG7cq9hgu1eor9dnwITeEHtKz1
         BXqkLtNQihwHzdBf/4tQu9plVVXV+4RWsUABtem+od8V3rKanQhx/3JwsqkbvBg/fATS
         fbJ1LsFOTtzReOH0aKOyg+STeT+xc4SzKx6bvi1aRoCSdluF2pvDaSNHzlNSL0o1m1Qx
         Gj3MdH436bcJ8txnzSBZViLty+0Bq0xkbDC9VqTzox5UHY5azHeoM73T3ab45Gd+L5L3
         TV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320778; x=1777925578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX52kU6I+oTtnTaZWgm7ccpRK71cywO/xadAPHW06nA=;
        b=H/FQIoOo15ApHZZz8SXh4+OhxY9DOwP/Flt34v5rC6duL1trcmnJN8+DeWfK0vMxDp
         FsADELx1y6ehPXD1dmeAdNc4y4DHJrVt5lETH9VX6Ai16otchyQ5n0QbVLNoDyeV1Az3
         Axl0O9IpKmeZnMUD+l89PCcHdbjU6ovwM7v5+DsF14tG7VB6TQ2iDC3HXDDnvqTuX3dQ
         hlzx9G1fwe/lIp13lWEg9ntEnzb2BWpJTlpdJ787hHmwo3aKdSdiY7H//OhzaqPJVB6H
         fj2PbiIQMnASh/Ar6JVmPzS2aDADbxnPqN5nQ/RugWso7Q5rxrLVNOFUKs8inXqAZg4p
         ZSVQ==
X-Gm-Message-State: AOJu0YynmHdd8PO5KK4HErC2i7c4/x+qFc1L6JTANACNL7Q61tJ4GHWa
	6bppYFz75t8HVr/qpr526Ix8Pk+myEDTJM7YxByYlr28G/SVQf+08Qmb
X-Gm-Gg: AeBDievHGYPQmlfhbG1fDASss3rMEBC50Xl/Qe22pTKodbrdCra42riKiNTvjJbVm9r
	2lKZG+k+OCYyZNbPlT6OzcXfmJM+S9ZqYgeYO6Jh713qD7uNycHia9jgAw3JezqNtimWwCU/Y+g
	FSXKdvWtJCkuFAfe8nw0GSTwizO9i584AtwoaOthP99KBBXz2ZqfFXznSm9LxwFNVIlEL6SkYBt
	vDTAbZSfqZhg9SPYO6zYePKxV3P1ImA7H2v55NtXu7llnWGip+QLh0+lTKmF3OYxks7VtsqBc2D
	AZZ86VW+3V3NXy6O6JanM5GgJZYmAC0AxHPUHYOmLENV2cDENHYPbw9anDYQ5MVMQ2xM/UfsEjr
	fgEBfeZ3ampvJ0azFqHOxkJrZlfawyTFwEc1YEPjzJct1d5iYi6FldpNN4b0v5/AK/2uMsza5OC
	2Ni2MLR9wwRUq/vOXzjovTfgwExu16FlLaGWGRHlvfb81rQ/fv
X-Received: by 2002:a05:6000:26d3:b0:43d:7d6f:f535 with SMTP id ffacd0b85a97d-4464b1b84e6mr423171f8f.35.1777320778397;
        Mon, 27 Apr 2026 13:12:58 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f270sm726826f8f.9.2026.04.27.13.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:12:57 -0700 (PDT)
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
Subject: [PATCH v4] iio: adc: mt6359: fix unchecked return value in mt6358_read_imp
Date: Mon, 27 Apr 2026 21:12:38 +0100
Message-ID: <20260427201238.20823-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt6358_read_imp(), the variable val_v is passed to regmap_read()
but the return value is not checked. If the read fails, val_v remains
uninitialized and its random stack content is subsequently reported
as a measurement result.

Initialize val_v to zero to ensure a predictable value is reported
in case of bus failure and to prevent potential stack data leakage.
This also satisfies static analyzers that might otherwise flag the
variable as used uninitialized.

Fixes: 3587914bf61 ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v4:
- Move val_v initialization just before regmap_read() call as suggested 
  by Andy Shevchenko to improve maintainability.

Changes in v3:
- Initialize val_v to zero at declaration instead of checking regmap_read()
  return value, as suggested by Jonathan Cameron and Andy Shevchenko.
- Update commit message to reflect this new approach

Changes in v2:
- Added Fixes tag.
- Re-examined the entire driver for unchecked regmap operations.
  While several regmap_write() and regmap_set_bits() calls also ignore
  return values, I focused on this specific regmap_read() in
  mt6358_read_imp() because it leads to an uninitialized variable usage
  (val_v). This makes this fix critical for reporting correct data
  to userspace

 drivers/iio/adc/mt6359-auxadc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 6b9ed9b1fde2..1d9724ef0983 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -497,6 +497,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
 		return ret;
 
 	/* Read the params before stopping */
+	val_v = 0;
 	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
 
 	mt6358_stop_imp_conv(adc_dev);
-- 
2.43.0

