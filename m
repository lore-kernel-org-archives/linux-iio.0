Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E241169F
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020779; cv=none; b=ixnE0WoYl/Cjtoh30YANJ+zJx3a0WY5rBrA5iRngnA5cs/XWYGb/oxxHnMQyKWwle/Qyh8qFfqJ12oaDjBLG9fpRwhYqdjMDMyp1YbeBRlCmm+1PgglVP4mfOz6Ozl/EvKCzfUTdwmeRtZSEEVpbnsVFNdDzZ3cGKanL9cLmSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020779; c=relaxed/simple;
	bh=HXABlvbovapo8X5ULjVoUp05rLGCvcH7Hwv2idfGruc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqk7eGPhx0DCTn9US8ZAUE61qL3sbuOhDrR26Xf9ZW+A3cLsKg5S5ECrh+2yXiVcbs3f34C8Bt06lHuqPr/gqcruRO4kWq4EMBSLetsUaHgUBPALXDYbJU7VGMMxlaMPBYjf6eTHqQD4ce/zYVGXgeJlvk5noK9thd5jR4zb0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ+2THhC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ+2THhC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so17300265e9.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020771; x=1788625571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkSPzkNePAAObmivPyMjVU/afPEpN4pzFimu9a853YI=;
        b=GQ+2THhCw2/8jDwj9Acy6LyPiCNTRZKWaY/gsDicqjjW9zEZy6p/Z83C2CUvWJSMa1
         24YlOcoft5+zaRYPjl6yG7ozuqyP3klcBff/ofgxMV9Wnsajv1nZd9jX4W6hnBEcG45e
         fhTOZ0SRwe2DTclUjCb2nQDKgXSa4nGwwyzsGjxrnmAaV5REdnqI4VInjgmw2hKf68dO
         5dNGtXVBOqfQmmOk5FKC7ymOxk7Vd3K0Y0zaQN/8jQUGODxz1DIsoDIoIhj0bWC4fJFb
         9UmXziyWfrbwdTNxCEm6y5+bg5RwZ4k6jMmBFlVYi3AcpEgjKXQ6zY0rSSbGF08XTRGu
         2IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020771; x=1788625571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkSPzkNePAAObmivPyMjVU/afPEpN4pzFimu9a853YI=;
        b=dght6bV2X/UO/P3+UDKrrbTk+120Y47ynExPXCd8c1B70H7yusZq+//vyuxn29gev0
         o514m+CdnznVaXdUPEW7NK5+vPje4kpblpRAFKJ6wdbY8V60p/L942TijR2pd6pzISFd
         f1I88od0M0yrc5trJwDWp2OQQQiCkrI96PFSav009xbyCzaeQnAM1AqbUA5vfaizA0Za
         Jhyig9J8gxWgTgVgSinN0L0b0WRLbvNwqG0yU5KqgYpS0xvLojtye+FsspjLhUeUOVcJ
         YNxd1hT9DE8MT4hcF4EwYyIcDwdHhoM38mKFGdFeL9AV/L+YvsWhzkW8T71e6AUsNQQE
         fEfg==
X-Gm-Message-State: AFuF++lcpBsUazjhg+nT1MXbeIlwOx93VJiWpYGR36gszK9hQ9MxLYYM
	VQP4bkgdbfcdAJkA7gxWdNe966bdmPpZJYu8Uo/cJyb60ehiubgiJoGe
X-Gm-Gg: AR+sD10/VOHyc2Ip4pO8BmSkLxkVtWEQ44ZkPsLz1m6JUTAOjLOPPjt0SnQZY2PZXya
	GqLjEuvkUgQW5+Wr5koKyZn9whmy+jky+rSI8hWTIeJbbpFkddPJqrEJotrDFI9wyXVE0RKKpW9
	g0Kf3G/31hNYJpi/Mm24LtrKsEBwGsOYUn4shfVl/f8n3ljjZ2dwJMnbBT7bDyziwzRNzjFZWak
	lI2364vMbRNkrHbL5SA5YX6QDQIK86doyV9JzROUPv7Hczp/squ63YNYQO+RiBwUf8suazEfRUn
	gGS7hZMuXYdAjpeb/RhFXlFfAbcsZxg7m4fG6IiUyYXzHXSWuqi948TqjNVfrdAROVFCtACZ+rS
	Ijo+ver3wNHmQfq192seVNyb9z84HNujlV7SaEFDcctntNOnREgHfDZjMCwAdncGsBW87FEljE2
	JJh//Cqgg//+B1m7sIqBhYZALPMWymD59a5dqVx//cmKHIoaz1X6/3/4quxUig6rpHDxORqhXfp
	J1Ew7AWkkc8jqTw6mlA+q8O8VuV6ZMhnR1lXYkuH4YsLxay26yyaYzO34oeDz//a9jcGnDnhbgp
	HTF3ZyRvKW+W1x0iGwrzV2UHGUmOMlqeHXH5OwQCKiczDGLR4W1r54l8Z/2TlLq8k0Icz8Oktj3
	Nlr2r0OpCX0DHfT0Qohf9N/0P
X-Received: by 2002:a05:600c:4ecc:b0:49c:ced9:ab7f with SMTP id 5b1f17b1804b1-49cced9abb7mr51496135e9.8.1788020770940;
        Sat, 29 Aug 2026 09:26:10 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:10 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:26:05 +0200
Subject: [PATCH v2 08/11] iio: temperature: tsys01: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-8-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
In-Reply-To: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=1038;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=HXABlvbovapo8X5ULjVoUp05rLGCvcH7Hwv2idfGruc=;
 b=OUcNmJXttKCBXh93LUFXqZBO3BpdQ8MEdMvSLIQiMYHIyg00ljkRND5HimopHWvwTUm26w9Mf
 p1xZ78XkxJCDlNHulKplqUv/yOSde5KSTmUx9ds6Zr6wbo+gbY9XM0e
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically and group the IIO headers and vendor
specific header separately.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tsys01.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 28b3ce022ce7..14de67ee8be7 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -8,14 +8,16 @@
  *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
  */
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/device.h>
-#include <linux/mutex.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/stat.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
 #include "../common/ms_sensors/ms_sensors_i2c.h"
 
 /* TSYS01 Commands */

-- 
2.55.0

