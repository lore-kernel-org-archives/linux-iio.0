Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAD29D264
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050557; cv=none; b=PuOTBRftNrw49Au7LafLbJVqGn5zJf0BPJOxYp+1D9ARgR8Kr1+UhynBRtjuurfxirSyjqePPV3RX2ZFqtDOHPAHzR95eWZlB9kG6VSPmqdVpDSr3z2aU7BNxRcBAj7opbB7fY8OVJNVJN+zxR+4Oh7TyduqPvaLNShGTgHB99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050557; c=relaxed/simple;
	bh=BRFbbCYCLJXsF1HXbH6hdxAa6IeicWv9LcASOBc3tBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZaXimJoDORGfiMqW2wSmEsaal60Q5JX+fWawNoCsgFHYrgq/H55WVu5KHeFQ3Hu0o/YcxPGhqekjULi/IJYWvRazHcAnnXLyvY6jOsL57C0kclQRmalsA6pY+Zk88quZXwX0Xqp+890ZtT3dXpmJf4qEHd1xanPWSvLXJ/FS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWarp53z; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWarp53z"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e682b30ecso238932b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785050555; x=1785655355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALDCpU9q3P5yJFut8wzhArihk8jWGEArMKTWcf6dg+0=;
        b=KWarp53z8clnWLEiA7F6scZ50ig2t5uBRBaSEDXpe3IYZ3sdy0QuAMexZJcwY8wjM9
         UcUypxgnHbJrc4R0cnvRaHam2MhMfvsCNzghpwPuiub6NyOTPPPkFDE5fPoUG78NpDeU
         EjMm+NCDAVbfTxnw3bt1nSWWO81fNULVlRxyyXrXPaA/d0HGvKbmT6M+jp6Bbip+wWVy
         TT/ybD8oApKZHNiX3RW5sYpmPb/cyja+RWipgtSaplJxQKGFYGav8pCHmtLox/PN82HU
         U9Jiva8iaqhv/PkRKSSB9Mqr1r3ET7QEPau6uTI18Cmtp24l9QUFOhkWg6L/9U52KKBo
         7Ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785050555; x=1785655355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALDCpU9q3P5yJFut8wzhArihk8jWGEArMKTWcf6dg+0=;
        b=eo10M4CpSx6FGFI1nswaXvqSJMiFsXYdEDBFHRoPa3QdDIAbHNKa7gOQBJAUSy+oWo
         aVu1qJ/jYdDhpYzgiCcjLgXOtl7T7k4/MPiYpsvE17oo9Lhv7Xjj22gPJscz/idwbUYQ
         ovzQDTi3Yo90aGbhfSWIbUXSfLnbbEHiiO/qeyfCSzm9rqvBNxJBYHhcGkfnDFauY7PT
         We1VyFhk5ZT1s5aOBoagwy9hsqXOx4gmKFbBVz9qF+6DQqBFwBy8y219Y2lkAq9limuG
         GWuk+RVL3k5L23IqlOzusaffzlMHMVui8QQGTq8O5VzdKII55575J28nSL6kN1sk+3wg
         hpuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdQ0hKU+Rqw6a5EfdEYEtDPXIwj/NoJOlUXvGupvgpcmQYosXTPojZWy2b1Uk743e9AMfqb9GOKHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbM0ViJIYfy1uazygyX3gskm+bQf+NbrdXmGdQp2E/N36cqIm/
	vBaLK85+BDUUTzqxRxPt5uSQ3skpdy9BR64afd6a+PibWN4CGk6vmWe+
X-Gm-Gg: AR+sD137ZMnxVsfHOQbAp7XoHK+R0ZoIqfwjDNuPmJZvDMWSqnIdzCTmP5Zd9aZka4O
	ytX5XAOs2eT4T87qWj/HyHQn1cbaGmzr5nAYDSW6G+8PTt5vVarSDCcXMcwnkOIa4rg4Y5fYkqe
	rXdePBQzOSZwY6taAAzKASkVX+GVDQcdEdhacDdpYxruN/t7Fv7ROwVhrtogL0IvA2iZH9xct3g
	rW47zrhU5boTBvpK5Ey9q2zMTOgyIrPwhclTJaVtZALIjHrPptHwhRU/36yI7QqM7xpTVY65uBi
	at9fX6pbZBso9HcW/Ay1io+vI2I4t/lz6oI4Mij5RJByYzQc0GbxuSl/TWsonWvDJ1hDm0KeZo6
	0MJq8TFHtQh98VteCFCKiJmx1JS7KQuMR2LNN8qztC2P+01HOXa33vlOdOI3AAnCkqIjRJ3og4i
	sXwwmaCjlLaLZH
X-Received: by 2002:a05:6a00:1798:b0:848:2f58:e1ec with SMTP id d2e1a72fcca58-84e4e428644mr4864467b3a.39.1785050555155;
        Sun, 26 Jul 2026 00:22:35 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532585edsm1637461b3a.4.2026.07.26.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 00:22:34 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH] iio: pressure: abp2030pa: Remove unreachable return in abp2_read_raw()
Date: Sun, 26 Jul 2026 07:22:34 +0000
Message-ID: <20260726072234.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the IIO_CHAN_INFO_RAW case every arm of the inner switch on
channel->type returns - IIO_PRESSURE and IIO_TEMP return IIO_VAL_INT and
default returns -EINVAL - so the "return IIO_VAL_INT;" following that
switch cannot be reached. The sibling IIO_CHAN_INFO_SCALE and
IIO_CHAN_INFO_OFFSET cases have the same shape and no trailing return,
so drop it here as well.

Found by smatch:
drivers/iio/pressure/abp2030pa.c:382 abp2_read_raw() warn: ignoring unreachable code.

No functional change: the compiler already discarded the statement, and
the generated object code is identical before and after.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/iio/pressure/abp2030pa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2030pa.c
index b44f1bf4c633..41395036e9ad 100644
--- a/drivers/iio/pressure/abp2030pa.c
+++ b/drivers/iio/pressure/abp2030pa.c
@@ -379,7 +379,6 @@ static int abp2_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
 		switch (channel->type) {
-- 
2.43.0

