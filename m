Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FE3CA4AB
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240516; cv=none; b=Gp5V5qUeViY/7C/IwdM624znPMGnBA1znY48rxvREcyTlYbZI+f/aOqtH5tf2+QQ2pj/LEeOyOb1xsm1SkOv2eowp9G6qQk+Oue9YWsTdLdDI7TPPx1jbPD/3WvIZd6wXJ8xWGbBeQ6Dt/e+1JQ/oIxuYig4LszCkBiEh+RvUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240516; c=relaxed/simple;
	bh=Y/Ufmv8I6uI0ZK4iqLWg4zoVsyDU/NpPCnNLF3lRh08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQDUAYtQseAb04RrJw00XDo5MMhaGgxxJ8xKhfbWBJKdY9W8DbsJ8o1NJxXwZtjCyvpDwLFck1T93FENs7HS6tggfSUc3WZoHqHRf5vFph4p4Ob0Yc36olMcYYuuQub8eSDoXrBz17WlXI8friQc83UtxjWsoGPhhmLSQm5Js9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX2mdm+F; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX2mdm+F"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9841aecf72so827132766b.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776240514; x=1776845314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdZTpzbciWGX9V3+t+J5jEvv0BObPRDJMbvo38f+x64=;
        b=PX2mdm+Fz0et8P3ssixscSkvhOTsV9PcMSUnL/QnqPRN5vVAcsj2MqXo2PErCSdjcD
         PVHdsbCYyeD8n1SseXxDFN1YDW4QjAeWbl1FOEEfbk+TyBmS6V5e7hXvejWiSoi1CnK3
         dOSIjQEMBu6xmT236Yy5HqiXrMcQ6dseWO3WHoBmaIhe0SLd++JhTTGt3I36HDBTWEUn
         IfQxzECvbTi6PJgv3e4lezB5O1J40VwlbN9KILzgFAFgpoqZM6BHFnzByviEbjeDQS/y
         ZyVgPl8SzTf8Zt1IYjrGKISHp0xycIKg2wXNnhV6FEchID1oPEFrXv0TlUOei7qdDSa3
         uxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776240514; x=1776845314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZdZTpzbciWGX9V3+t+J5jEvv0BObPRDJMbvo38f+x64=;
        b=Df6SThJg8t8sm6MrZ8SREAPMaAvYU8tp9V5OFpOA1zr6waHYILa1DGOEE5kwpDU0IS
         N5RekkquHMJwuwTHf29t6EwLlzjqADVt9GSF8hM5rCwanAIE6UIpsG3NRqxp9yiE/t4J
         KMY7dfCn24KVP4vf37YlStTi8iIGoLeJQJnS82hHc7ZzEZjnw1WCYrKZic/GSICKCvuz
         /Mq+FnB25VZRruP6nKGN6s9g9fsIJvOlVNaiIcMRdhLgN1Krz7/21A5oTMGdXSwwjWR7
         APMhQ8zuqHzh16wSmniD+1Yn8LAmnIQuV3j4mz1sPW73MNtKNEFwDQW1yatg+Nfh3SRP
         clhg==
X-Forwarded-Encrypted: i=1; AFNElJ+LZ45L2q2B/985CYbiSIpQ9Gh4wOEjGzwvPKhsXyHAyAEXD4IUK63P3BJ0vVjt4xoLw6n6VJaW+WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTA4bD/D8FBTF7VKBUILRa0QISTVJxzt7GAxTWARSaSkh9wfGX
	zqBT0c/jcLG51Fo4BMsUYoHr3h3rM9+Bdd7WKbUYc/33dD2kUxIAr9KE
X-Gm-Gg: AeBDiesiXq4RjeB+EwOyLQL1tsF0AX03wSrcrb3Z5QBgOtrEbi3E1LRgxdujl9Dt7CX
	g369rgjVFIldui6NsrnxMaXdrvlUJrxSTeI0s9jFt3V0iHR3i6MEkHtlMG5QRjwYx+tiCKEvCL5
	WvS2f7fsBDtzrsPAu/SoJTi42Z1pQWrfH6dvsf1K84AAz8SAu3ofp3wVM9HO7kp7S95DOqb86su
	NLO67XwaKNQb82PBMOp7BE2RxN3tNTuw5Fi6nwdInTgpp8RtfLZN5LXhXho9rySdANkHZeBv7Cu
	Be2XO7ok0AYtq0rl2V2fMYpBeKvZ8sbRNKlvnI0mGD1PbO4d3oY1DGJV8h74h/4prnn1iijOzcb
	z57wprfgGUvo9GTX3McV/W9tsqMyDUCWkkjNerYpuz/v8IISUQYMR0HdjNEgMHEk8H5MU0n7xWg
	8VEBf1p6ZDTutO9iu7baiN+kL667C9Yvh6Wcat7bn8bzhEjUQxqdP/eXSGneo80HKz5qizTAOCC
	Ckx3PGWT8JWCUdEYpHlQ7REytjdZi3GzUf0Mc36HWexptUGbfJQPQEfljw2XEIHIEy966hEF2Zm
	krgYJTdQSiMBU9rd9QyryTELY37fb6rK/GjC9f09XuAFAm6E+6lnJ7Gf+ewAD8zY3za5WnovXPi
	stDRUwuJhHpZgeEyNQvGZS2IxCW2ZELhoaJHOuCOzwKWAtMxNy1JWDYBTwm+kyZ69+2Nyy9RJUV
	baSU3Dl/1FXw==
X-Received: by 2002:a17:907:3d51:b0:b9b:38d4:2cea with SMTP id a640c23a62f3a-b9d724caa11mr1286568466b.23.1776240513089;
        Wed, 15 Apr 2026 01:08:33 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (239.185.141.34.bc.googleusercontent.com. [34.141.185.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1773c2013sm29720066b.34.2026.04.15.01.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:08:32 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
Date: Wed, 15 Apr 2026 08:08:11 +0000
Message-ID: <20260415080812.1284-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415080812.1284-1-joshua.crofts1@gmail.com>
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove kernel.h proxy header and add bitops.h for
better dependency control and code clarity. Also
removed slab.h and moved asm header below generic
linux headers.

Checked with IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/staging/iio/frequency/ad9832.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..fbcfdbd398 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -5,21 +5,19 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <asm/div64.h>
-
 #include <linux/bitfield.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/unaligned.h>
 
+#include <asm/div64.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-- 
2.47.3

