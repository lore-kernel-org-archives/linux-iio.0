Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BA28CF6F
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987099; cv=none; b=PuJELFs/wI12kArJmzJHY4E38LbEbWS86qFUTePnVoyZvd/ZYArurkiLB8SCKqVlpP1vDg29z/gfsi+c57a4qkke8EizNAqdFIhUnJ3NEt4Y9o3EGfDi1Qw6v4nUDUyvEJ0A2aau8wpzeEpdKWhksESOwKn3V1m306DCzBen3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987099; c=relaxed/simple;
	bh=xFQG7YqSPttDUo2tPyVZjf6ncMrcpC6V0hqQra57ZFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gd+IQNgIiqxMXF//mxv7bEI9GO8AJftp/6XqOuWB1bmoFQlKlm6Lc+9GvRel4RkD/Lxv9so24bjH6gACqAZgA88uN2FCA55vJjk5eKPICEbRq1iXYwV/NsMVsI9IAm9Ugu2LJjO4fy8hhitaG/gQvjlkPuLVmbiqnybctxIunVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4pLhO+5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4pLhO+5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c32d1350so1262935ad.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782987098; x=1783591898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6Srh5ZXGE+dKCbhOQOHqwJ7CrdDBo2QwVo3X/a9A8c=;
        b=F4pLhO+5zsA+CXy2R7AnllAcl7W5CCsErmxwEGYIKWzOc2wG8fEzNAv9sx39LeXkPT
         yGYuXbpJxokc6RU1+xQuGgoHe7s/owWkpxJZqedNZwNreVLWMN298auF2KT7Xy2mPnl9
         jAN1wbT22rHc0saXldyBO/hLTsinoXSIKvMGeXt3373UW3t53qQtU6IxKlWhNUwb3ZRG
         3PXNAg4tylC6EbmPSNpISAr3U10+gnGDHuIfrz8GkXV6yxisSYo7C52eIF+gQOdEelb2
         ssmzQiJoHG4uTYFaUxGoAlz2XDCG8rHYOolC98m4v/NWStnqeJr8DeA4YEVGcGy94Tfl
         oChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782987098; x=1783591898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6Srh5ZXGE+dKCbhOQOHqwJ7CrdDBo2QwVo3X/a9A8c=;
        b=Os6R/phgWp6rNYgPv0HNYl0bmxEmkoBkGJW1pCxaezORjcQO2ww2Z8thaHt787oz1H
         D4oix8cCxChijEwD0ZYmaoAkqhxxHZg03mGdlytG3vrG26hPiZDQ5cBNGDcMxt5yM4b9
         uELqbS5yaFEltxyugPx+N/9fxhbi2fDJnvYoGyoFr9f3wLBcny5Qq6ORg4ea0dzaxJR9
         2udzFMKLB+vuqUpXRofAoTcSSU94k6J6f+4nJB/ZFqNNRAeNTzSjXS8HTFwzlLLQLCKA
         AWJb664/l8KQmhDT/xuCouZ7XngEsqJbYG8k5ktC3FGvwBEyGRNAW0BTIZpQrJSURD9K
         n/1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqhNwA3y8IX7hFQktd0T7YItT0oIxm7O2oZSvLbveP9fIU93yMNhlPVKLl9cmZJQuJFyPI1MUfaPEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVyBEHWCrMwuaVxHP84NPsZYyT+1fRo4NxffHu+p9gPgaDir0
	kyAHv+ZujGcsezMj/oyms4McJ32c0Ral6c0dpix5stj5oPL2jiGxDX1G
X-Gm-Gg: AfdE7cnt08VDAD7PSEdiDe0tcqFLtNDjzR2fbbW809mp7jrWJTQPdtr9jRVufOAmQdf
	mnKS3s1IZWpPa0vWVzdW9LkbBFJo2M8d2L8lPNmj5vMyNj8R11j1KDQdf9LSqAGIJo48mO2NGii
	GXtPY35o727iIL9In1clCQaO/mtwWVU27jhlP57qIBYpF2I10qZo4c6Z9g+8eX4BCepO/1yHqEe
	64d+0//XJN+cs7RiH6XZuweScmLujEbdQtDOboyft+EbXPhMiS6ESCKTpsCWbWOGiRlIBHHb3zd
	sFIbkEpjwHzx1dgHRxl/JBZCZSHZ1PoZYYJv18+ugI/N4ww4dFhSM6SwLihRUX8ntwEu57bt6ob
	4ZbD1ZywXEd30F66Ba1fDmfEb7tPbH6OB8c+suT5+VZ/R8M8PLGWEdUCzCOs8MnZw9udDShwIp8
	uyJXzXTqccdC5BmmoQka4WKVQLtjOAuGl6hd7JeAn6RsdiNLILlo1Ti1Siy1S3raXEDc3KyGwFD
	RMzAgEnmiNCHdz40jl+HlPxBz+4QDXaVF0o5gCNcXW1EPWjlyakLDNWFfaf5xw95Zl1xf/NJnv4
	iQvpTXPe/9hwRHGP+rp8wkD2yHM1/rO0jN24bw==
X-Received: by 2002:a17:903:3b84:b0:2c9:cf5d:d9b2 with SMTP id d9443c01a7336-2ca7e74e244mr35912685ad.4.1782987097570;
        Thu, 02 Jul 2026 03:11:37 -0700 (PDT)
Received: from midnightair ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa65asm7760465c88.6.2026.07.02.03.11.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 03:11:36 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Khan <anxkhn28@gmail.com>
Subject: [PATCH] iio: backend: fix typos in comments
Date: Thu,  2 Jul 2026 15:41:29 +0530
Message-ID: <20260702101129.62445-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several comment typos in industrialio-backend.c: correct "through"
in a channel-spec comment, "initiates a process" in the activation
comment, and drop a stray apostrophe from "Gets" in two getter
kerneldoc comments.

Signed-off-by: Anas Khan <anxkhn28@gmail.com>
---
 drivers/iio/industrialio-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 4763e224ebc6..f7a4be8ec320 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -649,7 +649,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_get, "IIO_BACKEND");
  * @len: Buffer length
  *
  * This helper is intended to be used by backends that extend an IIO channel
- * (trough iio_backend_extend_chan_spec()) with extended info. In that case,
+ * (through iio_backend_extend_chan_spec()) with extended info. In that case,
  * backends are not supposed to give their own callbacks (as they would not have
  * a way to get the backend from indio_dev). This is the setter.
  *
@@ -851,7 +851,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
  * @back: Backend device
  * @timeout_us: Timeout value in us.
  *
- * When activated, it initates a proccess that aligns the sample's most
+ * When activated, it initiates a process that aligns the sample's most
  * significant bit (MSB) based solely on the captured data, without
  * considering any other external signals.
  *
@@ -1017,7 +1017,7 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
  * @dev: Consumer device for the backend
  * @name: Backend name
  *
- * Get's the backend associated with @dev.
+ * Gets the backend associated with @dev.
  *
  * RETURNS:
  * A backend pointer, negative error pointer otherwise.
@@ -1050,7 +1050,7 @@ EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_by_index, "IIO_BACKEND");
  * @name: Backend name
  * @fwnode: Firmware node of the backend consumer
  *
- * Get's the backend associated with a firmware node.
+ * Gets the backend associated with a firmware node.
  *
  * RETURNS:
  * A backend pointer, negative error pointer otherwise.
-- 
2.54.0

