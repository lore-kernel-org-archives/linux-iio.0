Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC162D8DA8
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678560; cv=none; b=KhDLvbGxTp/ue/Vm5HMXeYozqBcCLvO/E9y5jzR78QSlVqVyWGS/x8nQJefIC4MH90IDD6b+Zi/vY45I2YJu+kvv4SU4v7b8wvc086TFmIboS3wB9iK6BOCFnH3Pi5+8vMH1tWum88ySWIDzbe9NxhpNA8FJ5uM2x1Mvssu0R48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678560; c=relaxed/simple;
	bh=bgK+DZod7mmJgogZgW1zioKzetKNGqoKIW9z56Vpb+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3Me4L7J0L0WVdVIpdcugee2mC91UO480Qk7vnTeJSqhJ7BTm/a3JDv9+E8bgakXeBWpkymuKfxoGelZ7zU3wJcSqtKmHeUN/CuRSOaBYw9kABJ22AzsKhY3+O4vEXegZ3iH+GBiQmggrG7HKvL0DWeZpqzEhN1JK+Py05n1xoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5Fpg1Ox; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Fpg1Ox"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso3158791a12.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787678559; x=1788283359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2F/5Rn1z2wIFmLqiH74YcGVKvaBMa7CAe2jvYLlnR4=;
        b=I5Fpg1Ox/w5PoGChNWtvYZpUSRwCWU66/u0ejMjzdvrPcrNFt0WJUdLknx2OuHTjit
         ElBjpVpGVH5mhyAIuBznrb4h12oy34PORXfTlNKviKjlylYSakm05ILvo92sHoJmkRly
         eWVis35brfyptMZYlwxvMsZOGcNBcmq8l2n5gisXParb6skzJ88iQpUItgBNeCNR7HFQ
         +ulTV5EMwpm5p49eNpaOJVgzKvuH70uoNfTTag4cY+WqNdDeTMoRYTSzG9jKz4SvVfut
         /LqEHo4eI1isEzD5kk5i241hxJpukC+ItC2AdJR/Mk8EI5XeNz2nDHjc3smobZJOuWM+
         yrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678559; x=1788283359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H2F/5Rn1z2wIFmLqiH74YcGVKvaBMa7CAe2jvYLlnR4=;
        b=e5Ia1gkPBHPcZaYLltyjWHseXE6QPhSBrbLRF7F5lyog8Ufxx/yqcA3dNHvbI9y3U7
         9IcWG5q/vY7SP3fZWq4fUeiG/+X2hYAgOOXrdiMgC11QLdHFnE/FE1eXgdJRy3HQ6U8w
         iYmcVQNgFj9KQuq9C4CZgA6yGbgnzhEUPARpGMX81mqclm3rQDFaL+z9EHIA1DOcgFd0
         RLNKqBqDKudeRpzYhBKj418ILjmv/LIPAP5Z4D+L8/SckW8hzkGbQrjG7AO1PeuB5R5y
         Io+P3VmELbJpj2mEliQBNSH3fpR8vEKazggK3s920PioiCWl+gMcv5QHoM6QUAGsk8I/
         JWWw==
X-Forwarded-Encrypted: i=1; AHgh+RoffWCe80IxwZBcaXhEbQFLPiD+SafdUosUuQcJWjiL0V6vsvYt/eOr5pdh2gx8zXt6JyCiWWmZ1Sw=@vger.kernel.org
X-Gm-Message-State: AFuF++mRMrlzZZ+I5OHRKwlwX5kBdV8xHXcjqVXWi9EoL0/88+7UDRud
	mcRH1uybznYWK6uW1mHWm+Eg/91o19PpUw+TqXiTulRcP75GyTZdsPPM
X-Gm-Gg: AR+sD109PnOQvJG/NOoEUNzYhuGUKnfzXFk0xN33Hsb24lH+ucRINjdkwiIgAansiAn
	IvjJQVIlwRfI4WIWt9/rUSomInj2+a/vUnRDO4AiFWu0l7lwBGRegqDTPb4aH6nTtvMsoAqeZu6
	59d+UY956qI4zhdq32fvlxtWhTjfwZ1CQC3izXzx0svOZAU1cB/188XPEitjcSGqSgW5aJY5suR
	4SPq3ORRh6dNTAw1eozTdWZRRl+z7vFAPx8geHPX6RRJXOFyKbgyRNxow8ql8DOAhR/IKbS5IRa
	vEUPhvDPbEffFr4RkLVt487uX5MI/4zsxqnuvqsOeS4UDoOCosuU+5LzMEsPAelYY321Z+rOZt/
	/EdIS2hHKXBiymB2PoUP92fIWzxr7/cgIQmyzhjN06ZjxKAv89zK0drvi/JiKTENMtWcWOM+BaC
	A83XUNzXdMVTFGxb5QDQ9NDRz0i8BYpboAuOUQBTiP05v5sVafd7PVihkEIvw=
X-Received: by 2002:a17:90b:4a01:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-3966d1bae93mr1317136a91.6.1787678559136;
        Tue, 25 Aug 2026 10:22:39 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:7ed1:605d:3bd6:fefb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8d208csm327637eec.23.2026.08.25.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:22:38 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v1 1/3] iio: adc: bcm_iproc_adc: sort headers alphabetically
Date: Tue, 25 Aug 2026 22:51:53 +0530
Message-ID: <20260825172155.250484-2-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825172155.250484-1-mdshahid03@gmail.com>
References: <20260825172155.250484-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Sort the Linux kernel headers alphabetically to improve consistency
and make the include list easier to maintain.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index ab66b97d2f04..e46e3761993a 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -3,14 +3,14 @@
  * Copyright 2016 Broadcom
  */
 
-#include <linux/module.h>
-#include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
 
-- 
2.43.0

