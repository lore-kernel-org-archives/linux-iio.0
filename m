Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB06375F7B
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786297777; cv=none; b=BfvoGYfIpWbxhBFE/szqdSo+OByK9R9OLgyz4J2iz0CXw0sg36FvogzmonVealVitT20gfdZ2k8LJ4Kdox0vzNOv5sWxOq6Zm/P/SPVwCH9a85D8BqzjBqRJeIVv/nxIbeCLMLMnEEWv9ZR+MBm2vpfYG6p1AdSkkkNo59/EPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786297777; c=relaxed/simple;
	bh=rNKxzYzaJ/fqPXz08D0iOJ18xFr+7uPMxVxCZ+59FQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2/JQKPTBQL2HPL9iDqjtjbpjzDcpLBuW/LIuZPqBftBbchNK0OV6A7i52J9dvjXy+JjZHKk8X2+mIOMbBFGuFb40sZI6QGbuLHZOMYlTWO5Zu1+fDzw7e04JJZHwKQvx6QLa+Ysz89tv7tOVOMuHOUO2GvFldi8ccnZq8ifNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvWd+2kj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvWd+2kj"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so1179743a12.2
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786297775; x=1786902575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDFFcrmZ2Xw4orJ5Lk/DOEkZqh6PmfiNgraMdv8/1aI=;
        b=hvWd+2kjzCWWF+RJ+Ze5eyn8ZqRoJoTY7qHL6IBKEZIlvLDEW06T450kmuAZPFHX1h
         sqe4hhMMOnd7aqTqg7I0DC6gQQQyGM0okba3OmdzzPg7v7LLsyO/zvryxAd95bsLJywS
         Z/mX+NO5604x/4vCGIZIiybnqa/Rj3//QLNCmpSShReOQn3U89VA9RwNPm4NIQfX5wtd
         3rhLw4wlv03zP+w9mA1B9EQHJTj2cHjDVRwr+4G0seQrRjHTTdmji/Duq9UV9Ze4BUDP
         8eqbfUgGaZdwPRQggful0mbtJO0nA0jqYyU2rNUz/RQ9AMT+m6abzY3LtygXl5+cjWkn
         WsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786297775; x=1786902575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDFFcrmZ2Xw4orJ5Lk/DOEkZqh6PmfiNgraMdv8/1aI=;
        b=CG1bDzJcWOZbFShjiq68RyKEoFDl2v0XAwiWnaeDrNZf3oDaCec8DsyAVjC8WYBRxh
         m4XxUpJFNv0gJH4W7JvFbRV/bwgQAKzjJF2eJm2GV5IHsPKS4gB2Gp79Eal3Tl7/x7zl
         MmZJVyBBSsJ39/0Ac03sfiVJdwECusJgbAXdT/NW7oCU3/U2pwP0nKh8c0qOqupJC5l8
         IzDeJVqQYXr02GtBpV3Xf5fluqtmBWnbSPgI/SVV2c9W9eFI452wFTbmkYP/Jd/XpSI7
         vtFhIAAuK34IU7OUaSRLlyNMAuRpYmP6WT38Oshw5tq2aFGIyB6+6u+BH4DCoBFgc98k
         SpFw==
X-Forwarded-Encrypted: i=1; AHgh+RqX07RVbQJLjGFhmnAVlMsn0pwwJjXj1ZteyaHjOYJqyvka7XsdlQB8dvAHDxvOpd+PiPs5g7jpq14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EiIBCXgJ5AAX7Qh2/8+pUPbye5SfT81VoIZSoBpeufMru/aS
	xGouXqIOh5MQZ9DGydy+7DLfHAPDRcxIqwTxldHFj+/BeEfehIlR1JfATy7CyntO
X-Gm-Gg: AR+sD11PkohMZC7gb4khzVvUGLahtdU8yxXhmzcvCbSROb8QeouvN3AQkNmgpJ4EBfF
	UyMY9UaZsRUH3fPTOcMFh5Q107zrJhB9MkMJe58vHjDVe/eZBgaoksphSPE5zN6h1kMr3ZutDGE
	vJ6D/GjJv73C+EAZyVIB578p81h+B7OlLv3BrLh44NtyZydKW533QJftjO8mAKkQAxfyNHklG05
	XysKAYZkLHQ2lxXdKFV3ncIJfmhkswTvWel0QAg+oVyjRF8rQjGAtGXrnkPLXuOWQPRDiIsWlxs
	MGLdn3zoKNo8+WT9wF0pl95ZcOETaSrB/NT/t5MJDCYplA0cR4zj5OG1PJ3wKDq7nL4yp9mokSP
	n7c7Bp5TeLuAMR9yBfCqGrhan/MGZmuCYrQH8gBbuRtoDHBHyKU+MEriDgYJ3OSFBIesnJqcau9
	KYgNmV0zFWIqyWyw9pkiKCDaBoszPs6uPR1wEPofBtiK3xUyq+L1RqAHx7zFskreO6pU2m2hCjf
	RYsd2tW
X-Received: by 2002:a05:6a20:d508:b0:3cb:96dd:2477 with SMTP id adf61e73a8af0-3cbc0103ab0mr23470207637.8.1786297775423;
        Sun, 09 Aug 2026 10:49:35 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:1063:dad2:2cbc:2025:dc24:f4ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86d3d1sm35413700eec.2.2026.08.09.10.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 10:49:35 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH v2] iio: accel: bmc150: use iio_push_to_buffers_with_ts()
Date: Sun,  9 Aug 2026 23:19:28 +0530
Message-ID: <20260809174928.565911-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809111303.496393-1-yashsuthar983@gmail.com>
References: <20260809111303.496393-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() to allow source size runtime checks.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
v2:
- Add Suggested-by tag

 drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index dc8a6285cf3d..d904136720d5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1011,8 +1011,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   tstamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1196,8 +1196,8 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+				    sizeof(data->buffer), pf->timestamp);
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0

