Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11752877C3
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746941; cv=none; b=BLtTns5Y2jRBpItvWY5YXYJ60GjEagX6o3H1UjBwWheAphmBgmgcWZi/l03ySLhXIbNIzxS0qkBBCg1aKlq31wq1y2SM+aySy0So4+BoG+bDtuRV9uUxPrDCSIvCZNjDuE1phh5ZGTif8+zPxZ/tgoyJsDMVhkzgUscKig8WFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746941; c=relaxed/simple;
	bh=TioiTsieB6K47rtqg3bei/df2tvUdqrSUuARGufw4CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuRCb28E8dYFRBxMjEW3zcybfFAkATzzB6W+KsgzxVqHuQlx7z0LpplphE6vuE3WxY+HnDBB5W79bzt9uTN24/nfQWvwBlSThZcfJFuKU0pMsKCT//ES9KPlGIkWtqYONhPPwaj7xIhIgr/DZ+ZDwz9D6O3zl0LzyXD+T3LgdiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9X7ETMZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9X7ETMZ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66bf15430ecso1782995a12.3
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775746936; x=1776351736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OO2D65S435p/l6hJEnAV5AOSC4Rv4PPYimpN3sA5FI=;
        b=J9X7ETMZArXaSAY9ywJgBHRG8SA1sQAc+t6kAnKPpHMoyMb8TaJL34NRyxZE5YbyHW
         GgJtAPq4agcoMkjJKE1GSbHvKqdl2OfxGM3ZdgoW90qqrnKIcFJUM4cnyUphM61n1NO2
         H04Dq+D201E1wRg/VThkfmLXRP0Wl/R3fzm/wi6yTdpJxs7Lkz7ZgpEApELQSsna8VCs
         Pv1aWreYQJeTtr02NIVkf168yY2r9B6H8VNevEzHJqu4+OfWdweqJH5rwpvNZaVWh+lT
         V/u63AqbTWCn4I8NR5+FhJoP3k588L8XJ4vcHg0a8W4BXJSApxotdCoHz0d8J0OiFR+n
         o8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746936; x=1776351736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OO2D65S435p/l6hJEnAV5AOSC4Rv4PPYimpN3sA5FI=;
        b=I893xv7PfkVXGKFi1EyqwrWdfbV7PZKT47hQ7ReAwC0m2L/HMWEshsZTnXOZsgvU6/
         DNFe5QyxqRpHVrslXnYf9XQ12UB0S4EIsqn75YSxYfcbGVH8MJuyKxeZg2X15DQwJLZr
         Hx6/yErhdn8QtshTw8n8A+QHa32kzO2xVI/LSn8047+erRoLYzNTgm9oobT7jmUx489I
         L3wuG6NOYGwrLT5hZqEh0ttoitAJnDwCrp/ajrgMcgK0vwilTr0UiGU4yIzFYvAT2H3/
         Gr6xc0gebz1dc9GiXYdY3hYAqKjE6rdyJgEIkqCLQ1tORgfGCPlzjO0J5qsyvY7aUG79
         iigg==
X-Forwarded-Encrypted: i=1; AJvYcCV4+/0NViPX9Dbh9R3GSlaJAjFFgqlS7dYgyls2T3R28hJ3KZs8Xh0EcRi0A8A7cSzgcLJBvR5p3bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqC007hgpb74gAXtoK79heFlR4FxljWTxid8OFW+5PJji7KDh8
	/zOSeCX2dy5hcaB/cjXaPLieTY64SUDTceMXJGcWeF0IZiscJbvc13AO9w512veU3mo=
X-Gm-Gg: AeBDieu7ghtjBUP4JKFLGnZGw39i+oTHN/o3SbZ3j4n46MbMSSsXzWK8pERh9gx13b/
	ECyQnxZYBQFfYV2UQfcn0DNKQmzbgKz2vIALrtYqTWa4RAi1vyO1tZmeLZgZV6RExDXNGSJpcrg
	xzI731TrvQsSxUt7WL9+BApkM1MTXSltJrEhH+w4mpV/ZbYVI3sYo1NZdSt7WR8uzZr+EAXLGSD
	icNGWbfC9tGArF3G2zxlZA9uYflTwul7C/xY+dwb+zOb46xmr1oFLSB/5cst9C65/mBD6OlDb8U
	lceZ0Z3FJPCqsoGRDGgoUD2eIs9WB+j3OrEnVs18I9b6IN2b8p3J6dRoAaa/JYmdSjHY5WOJncp
	0vLy9mr/A3m5S4a9nQDsrPzB2g4PMZtB9FJs5F+fGAP0zVRx5o8LXbWGUWzPgwB5sNbUIhgsakM
	0t0bSVrDc3dKGEQY1kvPMAcFAU3Ly7imLxtaRkwXUo2vCY2Mae5BHX5tu2fiV8eH/R8PPHBMTkT
	+ylYcZT4dbLogb9Q4CQNi5k6p3a6oW/r1H1+sw1IHrKr4pfo7SjSPUfVy0y3ham65k34/qCYpkZ
	1GDOVmbRtoIBcriiKC4IgN9hYbRB0vYYGCH3gPU16bEMZlWRp8+9ag+kwsAdSa/ndyB6T9pyzeD
	MBmtqinQSRlhbaMkk
X-Received: by 2002:a05:6402:43c6:b0:670:4445:c326 with SMTP id 4fb4d7f45d1cf-6704445c4b7mr1148491a12.7.1775746936105;
        Thu, 09 Apr 2026 08:02:16 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (78.182.158.34.bc.googleusercontent.com. [34.158.182.78])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033ba245sm5754662a12.20.2026.04.09.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:02:15 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2] iio: frequency: ad983x: replace do_div() with div64_ul().
Date: Thu,  9 Apr 2026 15:01:57 +0000
Message-ID: <20260409150157.1300-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026040913-spherical-slacks-bc5b@gregkh>
References: <2026040913-spherical-slacks-bc5b@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coccinelle reported the following in both ad983x drivers:
do_div() does a 64-by-32 division, please consider using
div64_ul instead.

Fix this by replacing do_div() with div64_ul(), which
safely handles 64-bit dividends and unsigned long
divisors across all architectures.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - resent email with corrected addresses

 drivers/staging/iio/frequency/ad9832.c | 3 ++-
 drivers/staging/iio/frequency/ad9834.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..61ee93263a 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -115,7 +116,7 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout *
 				     (u64)((u64)1L << AD9832_FREQ_BITS);
-	do_div(freqreg, mclk);
+	freqreg = div64_ul(freqreg, mclk);
 	return freqreg;
 }
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d339d5e8e0..83d0e1360c 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -10,6 +10,7 @@
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
@@ -101,7 +102,7 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
 
-	do_div(freqreg, mclk);
+	freqreg = div64_ul(freqreg, mclk);
 	return freqreg;
 }
 
-- 
2.47.3

