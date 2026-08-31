Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC2397E89
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210824; cv=none; b=EWKM/acuptcvRXtN0e6+kVQJ+FFPNUrmXrt1ONdFsiAnAGTfvxaHZhSF/kysm8uU1qgMjHYJLefRIiVXLPWsIGfpaofnXU6vUqu7YDjHZhei3PqXMF7e2vONOCmCfPEfH9iVYccOQlHLg6HmVUdsREmdnk6C2/6YBL61IVNaM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210824; c=relaxed/simple;
	bh=jW53cz7kjVnoXurd4I3ohM3xctyABDVxUF7y45R7I8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=soFLxr0gC61O0kRZb8LJLDGEdxvqSGNeBKj0t5FABsGXqlmBbFCxnVvL7SEPHGsWqQ4G+bncOoHYYK3oOAQFhuSYcMXlYkgJMbYTJSOkgyev0yCwdSF2VSgcwybxS7vdSOcmyaGoCSNV+yrJ31ElsDzZVNl/ls1oyWVvpAXSHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwzJWa9c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwzJWa9c"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso45302395e9.3
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210821; x=1788815621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5xGBgSpjI6ilIuBwW9NQ1zMvUmD0ICcrq8TK/D9+gk=;
        b=VwzJWa9cluPPcHAH3+KgAHI+gHI1/A3B13Ub4c4lT4oRx6oWC4JSrnwL41Bth8w0Ao
         2cGc1vrVi5O+SrQ3wdDyjPDnUsA4SDXkjQ9xdoPEWUEpiQGvU6LjeoGvYvZDs3e8AJwY
         npQltAuFCcHPgBqMK+xdJz7D6426e+Qf0ifFdG1XsOlrJ7DAA0Op0tiegla6W0XgkFNc
         hbG6e4By1INYORaZA6MvxBdk8hrTL9WX7yLZI/576Hiv+7QWAvAJek3HtT2fIp8CG8vp
         mYYQP+ulkbFNJBDEpN+t1xGRlt6/mpweJ1Bxu2yBwOJCcEHsafU6M87cmyDN8ger7LgQ
         eHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210821; x=1788815621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w5xGBgSpjI6ilIuBwW9NQ1zMvUmD0ICcrq8TK/D9+gk=;
        b=BnGz5gZT3hIaFOumbw5VCB9cLxAKkbdJUltgzRQp+Mp6W+lb+iGCYYWbjMxx1Z3PxV
         sh+3o7fp6xd52SNxvpScvmOt6XjfVRt8dCIhSzGB0r8rci0NxBkvCZerG95B8jsuM0zW
         nFeHz5l9x6UxxuWJzs8XUyK7h9jcD6KNcM8DFnXlgKkWSJ5ZH8TbgSacA3Lj+dOB09YL
         tUdew5qB6kPO4Saevqab/4OpJ7UxiUYlmfmklluvJ6RAQbdeQGuvZRAq0AP8S7g1mwqy
         v6oGEY6YVrjAiU+G+0k1Qj5ODrnSpdLx475MKti9mBvm88I7PQVYvKT+pPMx+a1xZ0O4
         CHig==
X-Gm-Message-State: AFuF++kp8EfcaYhDqigsk+VjZyJZpVhDqRlnz/wuR5FEyIOYP54dPlt7
	XroZKIjd5PQSL1Gi31VfnTfEvCw+0UXJOwgbFToqUzGiFv4HqJh8Ntse
X-Gm-Gg: AR+sD12WWfIJoJ6dXk5EebdTb6xWI4toLU74xfTvVZeY4VB0lxhTyBaiZ8NNfPI4/Pr
	GRcB61Tf2mTtKa1Wqzf2isnn30oPWs5p4ZynWpfYJ68ATOsqY0h/bSSxPSWU5c5efyYMPJgG7Wa
	ME+uUTKFUMkiBXW5l/wamnfX0TkwaHljONbdr3JrT1cxnkYPe0u5v1uMgn75V/qlehUeEj1bno/
	rwzFhmWRsaDiEziBX7R4afdu3j+7JMMoh//hZ9pVPkU9siYUzCKeA7JhetWjwIktLazdIdsrw8z
	7hLx61nJUe31UnqHmTqu1y2/MHVrLqguAjxTguAswZhDLEhNA6YzyCNQObaUN5VRHk/tBzoezXl
	Ziz33+RgWXUlSpEGPOa9Rjun36nYNVjtiKONuu0jDj76RCtrqYcMTb64krMHzx9pffY2lnFvwF9
	miAHQfFUiYPHIa5DFjFya3b6jdzRhMRrFcBWLLEL1KyfzlJ6N8SHJjmLQHBpzSA3Apv8Dhp6lQX
	8Y/XVKzexSnPVKbwuwOL95iL8r6g4DA9SwZnbAr6IKZXBQZWiFLKfnzkSAgDSYib655l6e/ysGA
	9HG7lovR35Sb3hjCRA3wDv8hV0DZzy6Bs3cLw4ajpPhEbZhOstKOHX1xVDSs4EdFY/s5kf+/zXt
	FDkmBsa1lKEcUvHCzbVtpr/Yp
X-Received: by 2002:a05:600c:4747:b0:499:dbba:9859 with SMTP id 5b1f17b1804b1-49cdc57bf3emr51326665e9.5.1788210820792;
        Mon, 31 Aug 2026 14:13:40 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:40 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:32 +0200
Subject: [PATCH v2 02/11] iio: temperature: ltc2983: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-2-b92b580ef5eb@gmail.com>
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
In-Reply-To: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210818; l=1026;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=jW53cz7kjVnoXurd4I3ohM3xctyABDVxUF7y45R7I8I=;
 b=IIbK6F6UgtEK3QRn0JhHJC+PueyrmHRWwfj0ERbPtx3pDY9MXjTjKShRT4JhIVkcRqPNQT9+O
 cRiMr9nM+MGBotgv0jRVtXjnLZ4DLgfk9dfUuvAD8xRZQOU+tN3Po0b
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Separate the IIO specific header and group unaligned.h with the other
generic <linux/*> headers.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/ltc2983.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 6efb5252a773..fe9eec3058d4 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -11,7 +11,6 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -19,9 +18,11 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/unaligned.h>
 
 #include <asm/byteorder.h>
-#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
 
 /* register map */
 #define LTC2983_STATUS_REG			0x0000

-- 
2.55.0

