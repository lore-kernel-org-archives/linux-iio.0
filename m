Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD347126B
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001099; cv=none; b=Aq4xkqnzZTjJ/TTl5FTqo8YZCnmFqKcI0xFLgiFG/Q48kxuduUbOIFtWC/LlREEt0AloYEUw24sAsgza1sOnp1f6+Rntchy1lDBO0okA0w8i3tdKNv5bWNS7ENghB86mhXkB7b2OeO7NHNlReSVvJL/XBTGiQVwAbjuEZjjlNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001099; c=relaxed/simple;
	bh=Z9Qda5xfMXdPM0y7cS1w18J7wtGYePS3JSB15genqNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlBYMWNzu6hErvYCkSrsb3odY+ulYj7HJENejYW3enPF9g6wv7mqcno5z3ByvSO083wB3qJEQd9FPXRJGAOZg3jO9eARleVPDb7wH7dUkxeohExVBVZ9VB7Fj+i6hOwCTWSqbhV/J9ypNYdsstmPcc1WIPoQTBubu6aB0DKa2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwdC0oFV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwdC0oFV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495437bb891so2833865e9.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001092; x=1787605892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mf18W8QZAz94WDVtYPu89VIwzujNXA0lX7aId/Aud6w=;
        b=XwdC0oFViIjdYnSC2LmEXQm79fiXONJMvKkA42enzl1OCCCvkEKmtAZndk90PpC3sQ
         cYDCDbTX1hKK9McHkvBGWS3TQTnMW2tHxPnJxLDsIrcUgd3kfqK8hdQowOLxo5aJuk7M
         i/F4ZiWT2W/pDCOqL59/FAXbABfydflXEdCqjM4lu9W3Rl1jSB8nldxcdteRH2skSdoC
         w1nWz3x7g3R78hKPGlU5d5yv20TfnLV5nD0m520uwb/WNgvpGyRmZTpKibp951/Zma2n
         rxWpv68dCpCUZ93vmZQ7CNVVvQRbQkDGQFshoYR0d5WVNO+fveLaByixQuyFzgArrsyX
         eg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001092; x=1787605892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mf18W8QZAz94WDVtYPu89VIwzujNXA0lX7aId/Aud6w=;
        b=AhOXOBIoBRyoCoqwEvePcjC9P+b708R0TgQ/TIrEMCAwbZUWDnHFlkdz2HxkLx1q3P
         xkkm1l9Le3dBObL74PmpGonEAta6A1RcDbkHIFpyL9YfdkLyI0R3DVKM7+/NgpdtFLSf
         0uxH5Vw/IjMXqxsaub9LrgfalXs4X/ULT0AuSq3Y1joQ7Iz5fZEc7c5hl3Q2USFwvftO
         Yp8Ylg8yZdsFr/rHr+MY6oDS7h5ePy+0Ruf4SRpxjs7lmRcJaRUieX1+ckokVTnRlP9o
         Wh70VqtN9/2nY4F2ebONLMOFA+UtHglF/p+ARtwx2UoxEKHyUSXBL5s38RXUhiPIHLud
         ABnw==
X-Forwarded-Encrypted: i=1; AHgh+RqmmRk/oKbLHGJn+lZuxB+rc21DctgPP7mUfFSXV6oKoc3MoxcPtj5y/msDdaNXTBn1pT2sDxzdlVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyndqSY+fTd+b6gzaTpfYKrHybrNaH6QR/y/gCaNVw4AumRucDK
	4Qj40Aowm0qwM0FVLtZKLZzWfYDueyaFxgIR2dz3k1DBc2FOydAgSvkTHnPUZg==
X-Gm-Gg: AR+sD10guXEG7oKzyn6l7sh9cRF/VHVMU7SUtmxNX73ZdHkq1evwaLS4fesCgyZRIRR
	Y3hnz9DMjYzumHQr5P1jXiihUXysO1emnULFBH6PP3EenO67SYbnWDMhbdU1MdPW8oWGmipfmMF
	ts0hib6hnyIk9Y9FbriikrtT3Gwu/tfZEt1Ovklnd9zE/dnM7FUzL7uYcTUw3dN5YC+g5XJHDXX
	bb314DOApRTDEXM9a8vjmSHUsjcG8HpM1IIYf9wo07uohFaMhwniPC5yCYCN44F2aW5+sHyDnmR
	unZWzSFWKe9FC5XUNjKXW842y5mk/MxgtQpjn7Wmw2S62vJ/HWjcaRYqkw355tb31gK2S7PT40D
	MbYohmPEu3cYBiDeqI2qeGw+UtNKpRms1uTCmgy1L1+jMuZ3qHifYEEEoZJ6tHtq25ghrY44VI6
	+CN1HaBThGK+XKzGXf5fdDeD7AOTJ+FlNaxvhHJsk8c+j7BaQBQ7RCpxGXiMae8HFwOB37iQhl6
	GREynEd8sAiLvNFildI/wQ=
X-Received: by 2002:a05:600c:8b77:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499a206a553mr7835055e9.6.1787001092211;
        Mon, 17 Aug 2026 14:11:32 -0700 (PDT)
Received: from fedora ([105.74.73.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm134587625e9.10.2026.08.17.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:11:31 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v4 2/6] iio: dac: ad5504: Align headers with IWYU principle
Date: Mon, 17 Aug 2026 17:11:11 -0400
Message-ID: <20260817211118.21833-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817211118.21833-1-0rayn.dev@gmail.com>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the header inclusions to follow the IWYU principle and ensure
they are sorted alphabetically:

- Remove <linux/fs.h>, <linux/slab.h>, and <linux/kernel.h> as they
  are unused. The driver relies on devm_ managed allocations, so slab
  is not required.
- Replace <linux/bitops.h> with <linux/bits.h> as only the BIT() and
  GENMASK() macros are used.
- Add <linux/mod_devicetable.h> for struct spi_device_id.
- Add <linux/errno.h> and <linux/types.h> for error codes and data types.
- Add <asm/byteorder.h> for cpu_to_be16().
- Add <linux/array_size.h> for ARRAY_SIZE().
- Add <linux/kstrtox.h> for string to integer conversions.
- Replaced <linux/device.h> with <linux/dev_printk.h>

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index ad1a74678cf2..689147cdaa14 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,22 +5,26 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/fs.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#include <asm/byteorder.h>
+
 #define AD5504_RES_MASK			GENMASK(11, 0)
 #define AD5504_CMD_READ			BIT(15)
 #define AD5504_CMD_WRITE		0
-- 
2.55.0

