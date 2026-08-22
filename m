Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646943939DE
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389148; cv=none; b=Mkj6eKbXMlaoRZmhROhBiJAFU8NqNFSRq+cQaWhwQ56jPxbsUQAR4PbUTMaCmpK5OAs1gsjpoRpEtgiPm4db1WfwPtPlViIUj2vNAaVZ+fh1/63SyyVl4sItxbmQRanWFVjI96HLTOAQE5dFf6L045D/HhZsfLN9bmMTLzzwGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389148; c=relaxed/simple;
	bh=FQ4fyjXp2OqEnkYHwsfz+TTm/oRpClpjq1D/SX+fetU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJQDW+c1MKIcBmk+6p3I545qYAM0OKXBiDEx6aK2x3gnVpr/INtZjSf7Y8g8Dn1STwXWamHwmAWtK9/axDf/3567BLZ1wwYCqWLyREpCaVjJO9MV9NQsDpmpWfXIiigbjNh/tPFZcW12bxLC6Q13m6vENKyGXW8VHb75v0yZR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTZ29IQy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTZ29IQy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so14587125e9.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389145; x=1787993945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXCIKeHXfMN8TRcCWZhE+maVe8/ByjaTIx/Ywm2GTsw=;
        b=qTZ29IQyr6WAfQFmLVuB30Z/tcSUD7tVXaK7wntNOvG6urwOXQpqzu56OYxdJ8fT3T
         ZENgOfjon76VE3iWgBQpnevOkUHRiJb5VpqpFvgLlFIgZBvjL7ifrj8x5nEWDhaYgTYW
         5uc3EocqbrSV/8BVkRXOK19qx0OjiZequFGrHv8qSyMm+eepD2hAsW/ObThzu7uJhElX
         tUs7u9pD0YdKbqqHRs3RaLyytUrsSs2o2llzZAlTtKn+EwXdt62Qx4nuIj4A3fU27UEg
         sbQzr2WG+443fExtiLF5XfIbV3MZZNdBR36wcWUgX5PQrYi8N5DGW5Lj6qpVQbVPsBMG
         yjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389145; x=1787993945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXCIKeHXfMN8TRcCWZhE+maVe8/ByjaTIx/Ywm2GTsw=;
        b=HelEb8aWY3QQXfmUhpEP5jIrjrb0L9LzZ2q343joHFtST21pl6UMNCG20PiKbfSSVr
         Uc2e4+DNBn6dXWAcfDxBdauaR/JsHeoAYA7DoeZKTqygoIbCp4lUcGjrRTNUe/I9fM+d
         PWPEoFh+N4xtUrJZOo78EfI7wo8SSeMaCdk1K9UDihuCmrhWUsOP1msvaDzkg1HYAjJh
         QSVIT3GLrTx55jhJaUKDcQ3c/YkyRAHuScLHKpmHYFv2YW58huiRhkX5jZrfDJChf8Tn
         aA4UnzArmJR0hGeKZkYw+5WPd4i8VLsqZHcDMBrMxIS+Q0+4o6+HBEFRGgIqceEksLIK
         exZg==
X-Forwarded-Encrypted: i=1; AHgh+RrhFvQApQT55QxXqF3XABY7NGtqT0cYiqHpm9xGZCJQ0SY02rn4C7HCyJv1Eh1VT+Dp5qutiPgsN+4=@vger.kernel.org
X-Gm-Message-State: AFuF++kj1fR+LY/KMgywFczFzDlUZUHIJvX0pvc7pq5np4X7rcOv50uC
	WZB82PMl59ivLiRpPjYYc2vTivqlEDIaYRQx7d91UuRtK1OxdiCG2iWw
X-Gm-Gg: AR+sD12SJp2/HFyGY2usNJHUy0Jq9DRS74hv2FF+Easjk4zEOAk7QmtwZHWucrfRf4v
	wexIjyxOOXZ5xTDJGUfhwztOfCzEiUQaOKBgAdC8829g48ImuTq9tLPzwktCEVEI3E5e51G1xK9
	mnHDUcPMh9TyzhhcmfqcS3knRTbusDBGvGE1uF3Xlo/5Pg80lda2PgWFnBbX0xAf24uRTfa/UH0
	eS9jGIC5lCJ2T/HrC/4vvSnDv7mt2DRAtOlmn9K/y6AEyjeTpGXYerCm0cne3+53+dhDI8VKzON
	u8VWo4cbiKUAf0UIwOX5R2bSWEUyrsMOCaRK4uRhlsQ5/y3Ga65qYQ6vkc1QZGwI7EngbtlMp2x
	wlZ6IQBF4tM84D6+NesldgHF2ZJ9Ghbx3f64o0V3zzfFehYE+oEw+c4EDlpKb1uQJYQqQ7QcBpF
	UdYu1FEVpsrG21jEcl7IBRGVECUzrkQivav6vm+O6iQMpClkpAMrwRXb1oesGOiGYy3lGLs54SZ
	wrej6PIgfg=
X-Received: by 2002:a05:600c:530f:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-499b82f3d1dmr168825025e9.1.1787389144645;
        Sat, 22 Aug 2026 01:59:04 -0700 (PDT)
Received: from fedora ([105.74.72.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b9fcsm13596635e9.9.2026.08.22.01.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:59:04 -0700 (PDT)
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
Subject: [PATCH v6 2/6] iio: dac: ad5504: Align headers with IWYU principle
Date: Sat, 22 Aug 2026 04:56:49 -0400
Message-ID: <20260822085850.17527-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822085850.17527-1-0rayn.dev@gmail.com>
References: <20260822085850.17527-1-0rayn.dev@gmail.com>
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
- Add <linux/errno.h> and <linux/types.h> for error codes and data types.
- Add <asm/byteorder.h> for cpu_to_be16().
- Add <linux/array_size.h> for ARRAY_SIZE().
- Add <linux/kstrtox.h> for string to integer conversions.
- Replaced <linux/device.h> with <linux/dev_printk.h>

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index ad1a74678cf2..5c9c66b04154 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,22 +5,25 @@
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

