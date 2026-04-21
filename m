Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BF3BB5A
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737482; cv=none; b=rah8RcT8Bg/icITYXO9z1mgXsPB9yoF/ZzPLRLFGbH3Z4PTzOFgmfBThmG0rcuCHDTHp2aFQN/fQyZdlKgGzPknifo9Y5Qjs5j1bSQo3FiHGiGOquLrGVIZ97snItFppuYTkz9EVvgUu4NBSqkeVk1Nih8iKDeFJZ1JZpUTW80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737482; c=relaxed/simple;
	bh=GKHdqf98ke7lwtZULWzteHavQsnHriW0Xsr2jUOEwNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4Xeq4nQXTJzSgbdK2y618r5U+HFbp+gTQfg1hO6TtxIGGEvRoiFDUz3cSajhgn8bqO7IPhGasEKpkZMLR78ZC3Vf3vQAPUaKp03tAqv81oGbIiBK+8N86Dm/xyZgSS3wof+5m4QNJnb8j+AmaUKyt+Sv5BEG8/sie3myK5Y1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=SqPbYHl9; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="SqPbYHl9"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5673804da95so1143451e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776737479; x=1777342279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qNb3D3KMiruYQFbZV4d5blRxigq8H6GxhVvxpdugJI=;
        b=SqPbYHl9/qk+YFYJbGI7CzTUDL8thGcdiqat3Q1keFWZbBLawMcWhLd9jdH2X9Rz+C
         MTLkI/wPX83dsCR1AyMKNHf1++2tpFKxI5wpcasS4/jLZXYQk1eYqZxTK3OIdV12CT5t
         qf/AAGgzllWt/UqVgvxnAE7t4JwDys00Ng+cfMSwFAn0StZCGPnTOF3YlijpI0n9vH36
         Plw3ineD6hxlXTW5ht1yya3G2lY5xDbzNlHU7xVUjL7MItUis+1LJzk6RfLkVq4ff7+m
         yszkyHmqtiS5cob1uHV1uNtCjFTOZH2bb3y33g7z7W9QRDkO2LgdL3qOofgPVmtH2Zdl
         w/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776737479; x=1777342279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qNb3D3KMiruYQFbZV4d5blRxigq8H6GxhVvxpdugJI=;
        b=Yi7B819NUFbZTFCIMzfKkszquEE+blp9tduB7fNgTKhp42F/HpIIGyFOg29SxNxGit
         HSwX+mwQOhUYKw+RpXM439MvLwoxk7byHeZdtrBjtpehLAv5WrCUqMouYwCyz8yUQ0MU
         LVnViw1LPYzPhANxsEy9FgfYFoQqcVIjRv2VeDa8vtGT1xemsbjD8sAkJwpHhTYS2tu2
         WfgN+KJgr4LbUekRnCDUju+2KEp+ETB+rVgMf1sjTUgKYa8RI14TnSlNPuQ68rlpFsXm
         7Ivz1Cv5OFIxe0jg2E086beU2t8Z7LPd1D5BFf1OADc1hlfJZv1PikZmhdGFcrPzQebw
         u9Xw==
X-Forwarded-Encrypted: i=1; AFNElJ+F+5zHHG35scAEm+NpyrVlQ1Hno52RvBoWkljx1UssYxh3O1+bVe4fYTQl12mgnMkKnJS5P6su83Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43gtaclxIPY15PH05echL/r0rceZzBNkZFTXM+CpNi4BQQmXB
	q5ETumOLHpNdQqeKHZXP8FpTg9OIlreFYvK6gG5d83dLZv+LdVX3wk3ze8VV0FVYkbo=
X-Gm-Gg: AeBDievbyEshZ9/5HfnynnpaDIyvhAawv6kWzA79zmTk7hzpQRqAuPI2ipHeTMs2HBT
	RKS4yYGD+y5SIrfwtMbo6tKeD+tdzIKICpA98v9C/NI86HaWTNMumAoNPkitBgzze2609CtI1Jf
	JcuU5V8Ig0RfZgZPX6gUU+8cMagGfq0ITfJURNYtB0TMi2mPid/Edk0OGcFIHavnR31kcPh1mBB
	mMineoIfCIE+jWZy/10NLAohgZJc9pWt7cC298Ar6D4HAHn2awSZ7YCeUnMsot8dyoEXtI7H6pF
	SPzUnQcVc1FzzCAjgJGrhE12RPG3ZOjXXgAMrIU5E7tglPK3oTIUYLTy0t5AgaMSnZLYWVt7H2t
	pz75JnH4M6vw2GjgFmcVaWxUoWQoxFgTEPzajrnIXYRMf8N4MVCP6xYtioG4k8F8VpBe0Z0go4q
	Kfzn+/vhUVhaFQEwFDmoEFy6676HQFmg2WNgkHDRSE
X-Received: by 2002:a05:6122:4fa2:b0:56e:ded3:98eb with SMTP id 71dfb90a1353d-56fa585d299mr7511665e0c.6.1776737479356;
        Mon, 20 Apr 2026 19:11:19 -0700 (PDT)
Received: from sales-arch ([2804:7f0:d889:b103:1320:e321:eae6:2f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa9351ca8sm6932891e0c.18.2026.04.20.19.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:11:18 -0700 (PDT)
From: rafasales@usp.br
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: "Rafael B. Sales" <rafasales@usp.br>,
	"Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] iio: light: ltr501: update header inclusions
Date: Mon, 20 Apr 2026 23:10:00 -0300
Message-ID: <20260421021023.563290-2-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421021023.563290-1-rafasales@usp.br>
References: <20260421021023.563290-1-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael B. Sales" <rafasales@usp.br>

Update header inclusions to follow IWYU (Include What You Use)
principle

Signed-off-by: Rafael B. Sales <rafasales@usp.br>
Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
---
 drivers/iio/light/ltr501.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 4d99ae336f61..75a49fd9bce0 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -9,20 +9,38 @@
  * TODO: IR LED characteristics
  */
 
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
+#include <asm/page.h>
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
-#include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
-
-#include <linux/iio/iio.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/iio/types.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sprintf.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
 #define LTR501_ALS_CONTR 0x80 /* ALS operation mode, SW reset */
 #define LTR501_PS_CONTR 0x81 /* PS operation mode */
-- 
2.53.0

