Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305A4A2E0E
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851307; cv=none; b=piipggcwzkIvNLoApnvaYaE6zQiYq/89hIHez30Scj5bB2QpYoHgxq3vF7iBuVxn1QVrSZrTzlFRsBFzzcQCk+2rk8Px6+xEABkK6Wl53mN4q8p3Cb0wz0O4o6WYoaZBFuV4fYkxgSIOPveEcBFyLOF4V7sTyWTup8uKbG6y5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851307; c=relaxed/simple;
	bh=Xvm4nW+2P4F0n2X493r3Kfa+UVebUnUFiPYaF5DZ4z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqTB90LAryUM7625OfXNTbVZqATAfIalCaF67scVaLxVlrn/OUPItgR03AMx6lzmwunTWj++YQjSpKF6YGCNVewhjjpor+Wi02bxMbxnu67TpTgu3EG2gKDPLyZmP7x3FLMubKq76bA44kWpj7/bEAnmUCl7ccyFWxbBjTGVkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3wlUI0z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3wlUI0z"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e7109321dso162073a91.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851304; x=1788456104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=refqYpnhzgPaSHSNEFWOu6CJsyfTdwor7wN0Moi5irg=;
        b=X3wlUI0zVcmUd7kX0E49qG6NSSjerq11J4S7Yvr8Tujd0ryT+Q6voJZkRY5659grXn
         Gq1CFJpBbn9geb1lYCA4bGgRup2u6bT+cu0YhGTVg9h+1gi/ozMpGnJ+OuutXjKtllJ0
         trKhXfcQq9PpzJ3OSBwKlw6MjkCrIzvdto+3kekeN3H/XT3PVocmrzkxtXDoUCIqodnJ
         xdg/5K8zs+9NQsqJjPzlvFMbCLGlNnUXbBfbODWUa/HFmjzl1Dp+GzTUA0fUQ6OQM2Rg
         fRcc0RGB3u3n1IVgjU12HI7PTTm/b8S3r23z75Z4BHg/HQ3zibFAqqmk5mcNbthw+kmQ
         0A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851304; x=1788456104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=refqYpnhzgPaSHSNEFWOu6CJsyfTdwor7wN0Moi5irg=;
        b=CgdF3nDBbi/zhida1o2rNtjHp8Kps2hNnfB21VvuwuC4rsR9LyXm/UoF5AS3IBiXqc
         DcsZNIrhAvQhzrzbzeviPpVwHyNMABLRxd0al7zUppe/ulDon4LOrrwgB/JAKf9mB5rj
         PpfqOovN6uEFqEf/ekoCcvyqWSOoTCa87QqXRIryovYHU5Bu7oWS9ZziK/vtnQFogcsz
         8LUg3ut6TYqURASMc9ShXmtgq0/8mqVqXyP5+4hMnzttjjLC1NID/2dyZyZvbWqVuxYr
         djX+PCglW15VV0ufER1OfJJJceabAFUsmoNrEPadZgcLpnnkVNbXB5IoRm4UF5FxzlKc
         j6rg==
X-Forwarded-Encrypted: i=1; AHgh+RrAz+NNve8u/QX6UCCyiR3WoJF54fclgtXeQb5H+AYhN2viwhGDqlShUIBAB7Gxks5FoJcbDHyR77I=@vger.kernel.org
X-Gm-Message-State: AFuF++mxzuJt0Sd53nlQfkgKpjpE4t56JKUiLJ2xulE8bn5O6NXo6iON
	cf0SvNZh4Eht7NrPPRc1CbjNnVFHPr4zETm88+AipfwDrB0jipYhN5Ts
X-Gm-Gg: AR+sD11sMoLsF0wUXx8sfQP3qXQesVLXPblGoZMtXvoKB3p5pOLLIwLRH1izQPc5DPN
	DE6X5QX6sgOK5z95BBl1zRKb1gNtPFwit9D+vfRNu8spZHTLekzIl58L+TMVUK158AawFJ6zhuu
	yvqC5PF5zZIQyeHmGrYyBt1q7vG6++fJ+1IqBCfSrzGiZf8w6/0v8Q8wAXiAE9qNDZLtAxXtqhd
	ZdfVnMwYB0oJr97ay8f69387sH+Jaegyh0QRXLbQA4dfVbughxQ0bMMIrZb9TdOFyfbnEEWp7t+
	D9aNieVdvRSa2E7/FVCqjQCRQ229Ny8VYtnozUX83OdE6SpBjBaeo1r+Q/4m54SVcYcB+qoQOjW
	gLyVvAOCZALf5MgAoZMeTzQW2bn6X4UJIDQ+Mcy7T8/hlSIwpbah6XeOP5KfL3BaTM6k/+Ndc4d
	Ds/89iLwOwlPJaHR5CMBS6JprludZMnwmlmOCDBgxc3wpxN++Tg8x+TT7pvO227IylBlr9VORuj
	bmFD5ByRqnfK1TryW4TeT/ZdiKdT6jc6Gg4
X-Received: by 2002:a17:90b:2f0f:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-396d0d92d15mr1655610a91.3.1787851304248;
        Thu, 27 Aug 2026 10:21:44 -0700 (PDT)
Received: from debian.ari ([47.30.51.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm17797165c88.1.2026.08.27.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:21:43 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 2/8] iio: adc: ti-ads1015: sort headers alphabetically
Date: Thu, 27 Aug 2026 22:50:54 +0530
Message-Id: <20260827172100.39176-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260827172100.39176-1-architanant5@gmail.com>
References: <20260827172100.39176-1-architanant5@gmail.com>
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
index 93a165c5416a..ef03b74bda3e 100644
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

