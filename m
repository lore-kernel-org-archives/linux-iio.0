Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A83A1691
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430202; cv=none; b=riIGNFBj3rmzHqll8ua9MADJHpxXfWlG0Ioq0omlNbfzA7xyKjKxwtojR/Rw74pw6nBlf0EZL+/48oDgRZWcjqEbd18YguEOYbhuhMgZeYiNV0/0NaJSakyaX5dCDYpI3513Op60m5ep3mg3yjq0Frmxw6JP/H4elWUuoZRKFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430202; c=relaxed/simple;
	bh=efwicCyrZDEtkztr6vEZiYX/J7Lp4tCEUvHc1dH2h3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ym+YkNXuKkRVXWUaifamLBGxvVePVtnBwgi3aCLgBL/EWX5B6y5aIIMMjk5GMXWP1njAsvFvARGWweKE/fimcG21d5rLP7tOLg0awlTRSd+q4K4ul3QQ+n4XBGFrEfeyXbD8qtO82gSGnJGJz9gv5RzyzWuIK9BctB9s+BpZSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwOU0yLc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwOU0yLc"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so437586a91.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430200; x=1777035000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihHREKrqctIVfsWwTzXBg6atiRkWkjOXg5T5trA8kd0=;
        b=NwOU0yLc/F99nQicRfom8whD/UflaURuvxOj7LsqEbR5R1wP2Me509/SnxPxevPcgl
         MA2BNF3+VWmTwD6WeAtEhXNVtkIO7PZbth2XttW1bZ/xLPraEICUtqDbAlYgWqYVUffe
         YxgbCPwNF1roRi4zGuFaajEGK1LKewz1y9v05OB9tLC03ojMbyufTFGXHtBa6uS7KEy3
         4W7aCLAsoVerHjEpTPgZF7K7qMk2LdjN6hGLbmXC8BPfqVa1hFsi3jZ0hiANDmZ9FcmS
         0iyQ6N/uNm+oU6AxTnReoAy4ZSrlqvCHBUDe5o8jajalw2PU/nXEAKp8kCz21asVO3nX
         fybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430200; x=1777035000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihHREKrqctIVfsWwTzXBg6atiRkWkjOXg5T5trA8kd0=;
        b=iMq858AZjyHMuxvAZ38HEzeb6wgkwb8GkIIqOnqnGypedLoUvDX+h8b1NBFUfo9s+r
         XQmPW5/nntS8DLUzQmP3yoDR81vf8tVFcsG/CMQd6Fc+jZ9x786nhc16+dgeQjYIPYNs
         Fvg4C0fnvUy3QrgiR6MaVf2ZbrsILih6COqbYBA6QsKkjuj+ODEQ+1dRhV3czdJ1GCIJ
         dzJ4nkUJjxwdjfg/Xntt4tqf7YidcYr4VFJn800j60xLS4FBWnQFsNhZKreiZu6Fu1tn
         jmgalW/vf+KccfUtxWxZxIu0BchVDIWl8UfKRAeT950zSAzQQboeaeCAUkAJl1WYoXqt
         VKmg==
X-Forwarded-Encrypted: i=1; AFNElJ9EekvSIdI9YWfKJ1lFjyacU3Mldza//Mj4HHE8LQ7bgGOFTLek0/Bcc7usbh5flQjheO0+yM+T1jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6IYNZgx7biU8UPeI/G9/hqsyb+59PzdGonjqoW47XuMAgsZok
	ko73jLZkZfSQHl1M50dSkZfDEkDold97XBdAmJ+QH0PGfl8GH/rMIZZe
X-Gm-Gg: AeBDiet7Zf+mOCGJUQwDykax8MV0VjBcteX8V5zYqLO1vT4RpMxbzphnWtCxR+zVJ5A
	dAXNrVJ3zPeoi9sE/eGQWRkuIliBR8+IKbt3ulW3YfFs1Dp/pmwZdnDXRpipjM3TZJ3GXY7+9IO
	+q6h482PwFeGIJN/VUa98WZfIsve/r9pbu4bn8Ac5GWgfB5EIba6y8rw4EIUXi5RVz/92wa6VdA
	E14oNSeWQWGw7XmrNi/FvZWAyWDWafaYhvGfFfF6m4r32xB7vwsHExk6L0pYzl3KlxJgkaPcKwe
	cHcK/+8NXE17c5TPAHuThx1p2fe1CGtCjsuhWqU8qoVCecBp2ku61KbIdh8N0VqTZlZ2fZMx28F
	sAMtQrZs6T+RKOc3+0GuYLpgYI8s5M3PJn/V7i90ibWyu6k7J/oJBGbzfM/LLCORCHBWZCsmXGX
	BeAF9Jx/LB+vfMYVgw5A0Hem0cKlWaLXuosGAh953qomxjkRAxw+UGH+HFMfE=
X-Received: by 2002:a17:902:d706:b0:2b0:b016:773f with SMTP id d9443c01a7336-2b5f9eb2233mr20425945ad.11.1776430200498;
        Fri, 17 Apr 2026 05:50:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:50:00 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	puranjay@kernel.org,
	cosmin.tanislav@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	ramona.gradinariu@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] iio: accel: adxl367: Use devm-managed mutex initialization
Date: Fri, 17 Apr 2026 18:19:22 +0530
Message-Id: <20260417124924.353189-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417124924.353189-1-sanjayembedded@gmail.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/adxl367.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 0c04b2bb7efb..63a0b182824f 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1445,7 +1445,9 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	st->context = context;
 	st->ops = ops;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->channels = adxl367_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl367_channels);
-- 
2.34.1

