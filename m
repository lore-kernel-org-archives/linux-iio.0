Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91E29B8CF
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361039; cv=none; b=V4yINlVpAoMUTdflQZ1Gzug5OsPxtm7fo0g8oGFfH/dYL0fGxt7yStTMJx8FyuQc7f+9XCb0HfL7cEB5KVoZgIWHNxXzNtEUilgzNSznlYPWX+194Sdda1YDgJmyYwM19FvReMd7kAIZpniLxcZoBJc1Yyc3fjwIyPyaPGvr/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361039; c=relaxed/simple;
	bh=1awWxnMm4rgNRolCKrFaDT05Xek0Jwqhh14crlxuQRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tt3f960fIcFeQ4MFRIQPk6ocA4aFtN8SK3xoMVq7jNgd1NB8oprGj6jNbi9yesvw9y4ie4EktQP8stVYjeeonSe3mp1Q8057VY7MYv3kp6etot4t6MohT13oiPqm7Gvernfiup/9n71TkuUQMzmgev5qs99UCtznze+6JIQguP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npbmC64S; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npbmC64S"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so5454978a12.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784361037; x=1784965837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HB2l2gAUnqKDqPPuaqqN/p88qcc0rf+a8Bqxr4vlSRI=;
        b=npbmC64STKJ4DaT1b7n2EvTdRfadz4goGT2QZsQQuXUby7nsKAc8BjyqIprVaruuvN
         Evmu12v2JzfXxkP8SIBIz1qr1PcjBdzAfNnMXd8wWRpku86Ve2Wp8T4wCTprcCtP29JC
         5oPyFpYA1VPz99DCb/+x9SSOYF6yBFsxznRimGdIk9Z7VvrpyqUQcjXpTwdFQ8t3hYxm
         N4vDVpkgBHuRtqZdv2ppWpcnt+fG3u3iGD0z+PVBopCcoA0Krh/tvaxcFKRBNQ2RxPZ5
         ahLSzGtF8eeGrc5gm9tJIPOY76P6F6d/MvWjvCOVrQCCm3deGBBWM3qmsVg6N9LRq5Ez
         sSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784361037; x=1784965837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HB2l2gAUnqKDqPPuaqqN/p88qcc0rf+a8Bqxr4vlSRI=;
        b=ZVBm5p8d02mBUGiQjQUBvtZgjtHCHUU9uWQJrOfcRuQUJOD5/46aJa4aXmdd3foVaQ
         DEhdgqRMEfYZm2UguaESDdnvUIO+7nxZs8oIjR+SCA8+wR71+eeMZGwz+YpYo0rU+Hph
         dPAczPu8tV9J7oFSTVuv2zhRxCp/FBUNVPIaiKRFFTKSJruoZDF/OHhbPT8ZglmB63vW
         D0IXfUzorBPIGf2M53nMgRgF+lZi5lW/RTYGYK0o2v8JJdf/8jQYWmdNIB9k2tdmi92U
         dBjk7KNImDQt84dGFuULZmrLr1q0CThiHD6ukwiGQczZNvHCuazZoXZmKrAkZr2LIy+3
         0ZHg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/CDs9ZeGnsa+PcQURCuqJ2YfnP29WvwtPUtaLWTuEBXNZcCeJ3lczlbeoYjQFe6iOisRTurBoWHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPkngSZAu5p4+OpCxEOH4NvoG/YxoM6Mf5zBVvOJinTOXTpKZ
	qAay3pXLONV3G5tagczMpICGankuocpQDY0qmxkk/EjWuxQDzpgRjw5e
X-Gm-Gg: AfdE7clbdlu7R02t3MUUZjTzpFn+i6a4FBw+2ws1KFhtGjL3V1Ajk3vTRZRdGyYuPrm
	DJ9NHRmPRdUUSuPYW/th4IpmOo6eyWsEnof5LkrPBn9DBtm30+AqhNeI5JaEvz60r9EWJsddrsd
	crz1gpephCOLyf/7KlUiDBTtg3T07pFbXY44DaOUjvPqW1mTNlPYrDsEH19cWfvOacQAYhTrTGg
	Sugm1vDDM+9SzDc3F1fu4ecviCv54EVzlHAyo3LCXjARmJS+i1YUuVxpvd+xCEwTuZZGL9FYZdY
	ZRx6sa4Z0g1662jiTy76WN95p+FU7KQz+TBJWadMBdTkUdTAgSJ7Wo7aAX2hJ6Bn3E4a567pvay
	fj+/O89/Sf6UsW/96r3fQqLsd/7CE/a2XoE3PrsQhIvcjEP2lwUefn+EUvZJ4dYI9hdGwXBq1Ib
	QnG+qy5IlE1llBjVtiDLw1dx+1IN3b8A922jLKySKoT/GKu1bj1PmS
X-Received: by 2002:a05:6a21:4a97:b0:3c3:96dd:9ecc with SMTP id adf61e73a8af0-3c3ad93dd33mr5919063637.57.1784361037377;
        Sat, 18 Jul 2026 00:50:37 -0700 (PDT)
Received: from debian.ari ([152.56.157.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20bf96sm14354220eec.28.2026.07.18.00.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:50:36 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH 1/3] iio: adc: ti-ads1015: sort headers alphabetically
Date: Sat, 18 Jul 2026 13:20:14 +0530
Message-Id: <20260718075016.27750-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718075016.27750-1-architanant5@gmail.com>
References: <20260718075016.27750-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder include headers alphabetically to comply with the preferred
coding style and improve maintainability.

No functional changes.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 8a272af69f7d..d95efb870bde 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -11,24 +11,24 @@
  *	* 0x4B - ADDR connected to SCL
  */
 
-#include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/pm_runtime.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/types.h>
 
 #define ADS1015_DRV_NAME "ads1015"
 
-- 
2.39.5

