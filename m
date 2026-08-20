Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6674756B7
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235302; cv=none; b=nNDpSm0vqfJby6I1o1Hzf/nTxI/hr5CZoxEWiyLh42TREuMZUcVV5nYxTX53SWecmogy/7Y98eTpl+wtlpTawDFSV8iOpYtoSqcOLn59353bUM0NVfkmHLGXyYfQ0Li4oTvU9jFdlJPFZnE/8TWywhxmi1t65Uhm/yA3X8ehIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235302; c=relaxed/simple;
	bh=O4lrNP5pRjWBnHyOhiG2P5CCWzZLHXZqncot6iOw8L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJxU4/ceamlRWQ61zDS5YHBpw8DYheLqxxP0pErVrdWuUrmO05F5q8FOwELWZCNev1J7NWaU2wVrlV4wweAXwPCrskSJTR8fv+OaDS4QtAP0IzhAqB3thXRfFwEK9hkDlmfhKc4JG4P9lGgkXB0Uo3zHsHUi0tLu1+FCl0g1XZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKQpxhGO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKQpxhGO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e50a650a0so128678785a.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235299; x=1787840099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0JXpwNx5P1ghjJnIanPjbayWoIG4aYa16LvuZHaRkc=;
        b=lKQpxhGOYG0fSncRa5gretapPovyYRKyqWJXBwyaN41PG73Mtwhv4eiuNDMKq4EKPH
         Ki482A1efGs6T/Pk9cgLbEkNyb3ok8tLrSD2YxA9QhbCLslaTSW+Pc3fXOwnWyHGtTgr
         62sdvTnqi5xKGqyQsmAmwlnwOmP0q9nZlQXmRyG8YYXPBQKGwJk0emEyAgkMQmMaWzWU
         QgZhTmI/ZmKPSp2B0RAG0Y07w5rDP/G+iXHW67jHm97+jtdkbpM4wWW4cVYoy+r9bcT1
         FUwDl3+/f3veHNamhezs6MExbCB6U5Ap6+ItDuj8KieeCP/xcSr0AOti6+YnO0bhsU7z
         2IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235299; x=1787840099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n0JXpwNx5P1ghjJnIanPjbayWoIG4aYa16LvuZHaRkc=;
        b=LIg76593YRrJJunu0cv1Bp9KKmQG7aNKqeOemqLVHB+zNNEtCtGssNIgxRXHJnxVBo
         p+u/CdIx4bjv4z472AH2nTD810MiYJh1mshFLzOuTEYeWv6kPt/9PhMslCkRws/8scKD
         YLuOVPTl1Hkop6MyikRO+O/PuZTR/en52CG1OXpJZhN2yZGFNQ45NRc8CvCs0G5A36wr
         htHGMfOjpAvssMn93Xk7WMQaKK7k6Dt6FsKw3cwmVMBHtAxr71cm79InbT+GwF3TF6AV
         CMEfM1DP+TQStoJV4ZcLfaSskok5mgUL9l7cuEaoKUKKMaZ7iZP/47BOqXuUfr4hgwtv
         U+hw==
X-Forwarded-Encrypted: i=1; AHgh+RooLrK7sYh2oqtirS7NF92YJcCc81chH4vRjhsYgJJAdQ5AmAALO7gukMsTdfuWbSs55rn4KvVvmVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDV/rziKiKVVqITDFEPRtBJaPeu7jaGmTXIUcekMNP/Azv3ADy
	sdaNFzVLK/gjzKCAdD80miA/kEpN32mOVog5mXLnE+I+Bk8nb8w8yTME
X-Gm-Gg: AR+sD11FSNwwAow3T4e5Dyw59js0bRRxs0qvBwWiuGZNChQUUnjTFDQpuo7hx6YNHjM
	D1yFbzX1FftRzKC5R70WdLTcR7v/HdBiHl4WItPcVs4fkhkCPyk6I242ii7q8RXK+85+glClB68
	wyARY7xStKXRkX2ZONAwHFcnZAy5TQJW46b4pyv6+APscQ1UduJwbfKKUZL5kwnjjYcRHHluK66
	lFBVbrDA7LFJyRqLQ1xy2qqVTDN2U4NK5VFYfqQMZX2FL+plndmfYyBh7YxAyKeVJDxgzUwb+3J
	VdfeU8XuqNlcA80m3zucyD94NKdT2GGO+Qy7HrmMv5KvKliy3B+rwAJFTJLcyuyFebZlPkI+CRb
	GeRPgQ6meMmLN1g+e7kIFg6SIa6htzaF+0MPOzC2+ZBpd829m+q6AQDQxuH5FugHimlubMozH9B
	ALbx4fBSlAZeuDZ08Ir0IiyowdvzEkjVFD81cgoDC9mb3dmn0J6kNvPY4Rs4EJhymN0/seMm1OJ
	g==
X-Received: by 2002:a05:620a:1b95:b0:930:987d:9cd7 with SMTP id af79cd13be357-9371e2565fcmr1284352885a.11.1787235299390;
        Thu, 20 Aug 2026 07:14:59 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372059de87sm372738085a.47.2026.08.20.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:14:58 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Louis Adamian <adamianlouis@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] iio: pressure: ms5637: Add missing ms5803 I2C device ID
Date: Thu, 20 Aug 2026 10:12:16 -0400
Message-ID: <20260820141224.23730-2-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820141224.23730-1-adamianlouis@gmail.com>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

meas,ms5803 is in the OF match table with no corresponding entry in
ms5637_id.

Fixes: 649ef114a0a0 ("iio:pressure:ms5637: add ms5803 support")
Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 drivers/iio/pressure/ms5637.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index be8921644558..4f9f556bd123 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -215,6 +215,7 @@ static const struct ms_tp_data ms8607_data = {
 
 static const struct i2c_device_id ms5637_id[] = {
 	{ .name = "ms5637", .driver_data = (kernel_ulong_t)&ms5637_data },
+	{ .name = "ms5803", .driver_data = (kernel_ulong_t)&ms5803_data },
 	{ .name = "ms5805", .driver_data = (kernel_ulong_t)&ms5805_data },
 	{ .name = "ms5837", .driver_data = (kernel_ulong_t)&ms5837_data },
 	{ .name = "ms8607-temppressure", .driver_data = (kernel_ulong_t)&ms8607_data },
-- 
2.55.0

