Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE039183A
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421376; cv=none; b=sBr8iJeck6uG4ompYNYGAjxq1c5/IltfT20a5WULB72K4Wcz3r5F6e0W2Dj/PKpNwwe8/V4tSoNvgPxicsSIsjCZ8IfIhv8C0ul5tiefXd6lFEhIxJn2r3hjmvypFUxydLT+Vbx7/IQEh10KCcPplfcO1Dfz4UV7tKq4Xd9BCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421376; c=relaxed/simple;
	bh=ImOyXwGqY9R+Xsddf0l/0dtCBwFyC6spjxLxs+Vzb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brg5io8mG5pdqRZTtuoWWSJuvHBz8QkNMCeqShN5TU4cYwWPEqYkHgJqZ28C37124L/uILh36cIMcmjP7kCOogRIjarhW2hLlxK9pF8BHbwHpcd3Rn8BDLRbrY7UtIej/0VeFkMKnxYiaV1DPE3kmeM1JyzW/D9BqUuepKdKhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rD0MimvX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD0MimvX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c3546924so14311185ad.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 00:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781421374; x=1782026174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rraZsIATQSyWjxZIPsZ4xXDf9f10gJ+mVeYVyqxPx4w=;
        b=rD0MimvXBZQCueqw/1gHSamZ7kjkZiRoWD58B6cmZ+zHa1MkTrfitejzbpovMUDdUT
         ksgktQb0aQctr9MWPT3FUHQJne7j171vJA0+kSu531WlRXuPqTgOYp7/T8pc6GFMzHt6
         KACL63BP+7A3UfHZSxrd8mE5wUbUdDFanGkX/MbLUsIi9tllY73EJr0MKBDMdPAtswIm
         11PQ4MFMfRutnqqR9KsfmyfDL20bXZVUQVv9/9cQkHJLXPL0SNzTDldFbE1Kk+KoTSxc
         puCfe88veKot0O1GOaRuJRbDO56CIC5bYisEIYLUHRkD8Fxikht96FzypmbkFE8rTtAN
         b96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421374; x=1782026174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rraZsIATQSyWjxZIPsZ4xXDf9f10gJ+mVeYVyqxPx4w=;
        b=UfYLhMZ9RO+Y49KXsLs7seov/GVPsd7ZWaFY2F7RkA7BO0ZqUx7dZ2N8fW6G1KvhG+
         g80ZineBv0QGU3TntVBiTcKcka15Fvu0pyYXNZanxCxJw/vkD6a4K5KCLSAeNuoVNJpD
         0vtLFC/RcBK1eaPcNi9CfrJBPutXA7Bt82XCU0QzuBAReCcK+zavX6Tamx8UVoqnNvgb
         NDrPmdFjbwyFdeqSVcsDPj/7AomvBUx7DlELR5yE9jGtnQjcuqvry5f6NN1sIdmsBr3x
         KvY8Aym0vIwi+0Lyl+XImlEGS0ScAMEBomW3jC3klxCheLxo9yaQ/VKZ68nzvkbHavh5
         0fpg==
X-Forwarded-Encrypted: i=1; AFNElJ9ODxGYMVn+RXjWmsnx7Ip3pnVsugxey6QZ11Xmah4WlktpHhc06ykGUQ/0LbByTi3+I1xtIR36buQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVVTGWkI1qeW6pdD8dICfqmwnKkyT0k82WA+/vDrvhYm35FN4e
	k1g02d8NETscBtbNcPk5XunevQhajaEDL+7nGFj3clkZfsKotpFa0skm
X-Gm-Gg: Acq92OEP88TMH0w8huF/Sy9Q/NL1yhtbxkWxMR6QxgNSu+jaJ4t0cZLWgw23oFB0eJ6
	6O5zndlRdxgxHbwHRVFtmQbEWkx2UT3kmd5tJxxFQ51a/yJRYTeMTxTwviEGU9UQSUKpwO2f19s
	ZR2mPWiN4XZlLGcpwJpoI07gXSSDeQ/ENPLJSuEHFib1CMKfzm4N+JFv5BULYzgBDZs3o3uiRaw
	x2yoZBoHJsX2xpYOth8JwYwN+Ej9+T1DB4C3oG/nNKjzCAFHKm7NG2/xcNwIYmRvOPyf7gaaN7Z
	ZMEGYKJQsxunytwnEanLcxvQvMXTL9Hxe7R1/dHkZDwox5KqYGrNb9dcbLiEOj4jWxp8Eq/Ei39
	am969hc72zxRilKRVOte7oY+HX24WBB5O2eWAH1fvTcLTHFOiPkC7y5W9wF6q/P3KdNSZXuikUV
	qy9zO+DUdGkeQFFelgHrarqS1BVckHt90wsrFoVPYn5yQ9mGfWwkxR
X-Received: by 2002:a17:903:b46:b0:2b2:5515:661c with SMTP id d9443c01a7336-2c6642b0dc3mr58122065ad.31.1781421374403;
        Sun, 14 Jun 2026 00:16:14 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm65595295ad.46.2026.06.14.00.16.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 00:16:13 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v1 4/4] iio: light: gp2ap002: fix runtime PM leak on read error
Date: Sun, 14 Jun 2026 12:45:49 +0530
Message-ID: <20260614071549.81920-5-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260614071549.81920-1-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gp2ap002_read_raw() calls pm_runtime_get_sync() before reading the
lux value, but if gp2ap002_get_lux() fails, it returns directly. This
skips the pm_runtime_put_autosuspend() call at the "out" label,
permanently leaking a runtime PM reference and preventing the device
from autosuspending.

Replace the direct return with a "goto out" to ensure the reference
is properly dropped on the error path.

Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index a0d8a58f2704..886accf5e859 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -258,7 +258,7 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			ret = gp2ap002_get_lux(gp2ap002);
 			if (ret < 0)
-				return ret;
+				goto out;
 			*val = ret;
 			ret = IIO_VAL_INT;
 			goto out;
-- 
2.50.1 (Apple Git-155)

