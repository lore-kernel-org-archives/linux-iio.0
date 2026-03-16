Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAED386431
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651697; cv=none; b=EQtYE7PWgpz1dTbqEi1PKAruEZKBx4L45/HA0jAPbD19Ab6bdYiFR42qZUcK3gCirUq/WsVfTIyjTSIJlF2mZLlWxPvYB94obGbZotcdOuEzSbTf0j9tHP0JHfhFkaz6egSVCc/4FizWCp5kF5+MvKUJUS4R0rT/0sUNg1DvrUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651697; c=relaxed/simple;
	bh=vnlTaEbQkXcBVgZJUSBKKiGJHSj2+ifIboa8T73l4/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWlxOK5KOnO8KfcquvDasl0scS79WLR3MX0WsyfufLTQmkZti1vuqYKH8XwkwTcCwaDEfRsrecBcMoOXbQJsoR9gYKcJyoMFggGLP0s15FGC7dz5pyrRmfe+uVU1yfBA+q7O1ogtG6zuXYFDOKOBhoVpYBUYruE2AVXIBJADFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZQk2aTW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZQk2aTW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a9296b3926so34083355ad.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651695; x=1774256495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX7xNcVJfH3cNiHUfSF4zy1INoYYmvBzCMNf3iU2VD4=;
        b=kZQk2aTW1jkZhDx8DCIi4WzgfvkqDFCL8R5ODww5eJZzO2uUHrnwid6MDZe9yVdRyv
         2U1308bhZ5ocXKOV3Hl8A9G/V9LVCt/xmL2VJR8Zq4X3sFZ7xiT4sfd3KaJ8K01EHjxl
         P/oNgwoIQ3X8ztBCABDVMeNoPi51w2niTWRdc8Q8EJHjmAXSpThZj6Ns1LXa8KeGCrlF
         vZI0TCuGgUuwWYKC7Ecomj51bUlHr9D+Z24o4VLzghN8OFQtNvNkUpFbdqJg47tdK05F
         pPXTWTf5A9DPZZXSwUWTsJ4HWDqfiTz4DjEzUJNPdr4m0SbMh03/IVTOyouK9bRWqCsJ
         D8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651695; x=1774256495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GX7xNcVJfH3cNiHUfSF4zy1INoYYmvBzCMNf3iU2VD4=;
        b=nFnpjpzwCD+twL1IDLgBs2/fdpB/1FnRxH8lBdCpJrFQlQdkk7tSZ2Tw60Htj6eEuC
         FGMx+zZPNxli2WyBTQX0Wqr4ao6CM2eyHGJbPSdnGXO0RhSqcjiYS8OUNn9zl4pBLy36
         qjWovw7y9HeIpoQ82Uo7M+xqIcFX9jBzOdd7nxsdR6i8lGGMoZNzqz7kMCuzo6TFDwms
         JJB8YD5SnvSUSG5Yy6tJHBgxP9Mahk/rhsmSGDP+biI4R/0JR9D2RAbYzwAWlfXFJdwx
         zbMJXdGwnzgEwRB7DkFM/h+AM5pRdtnuP0bXZBvV5Gjd2rN0nCgIH5nbMv4dBCQjsZog
         g7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXTZGNVhEThWefNNvvjgSDK5EXApuycfDJ8klf0rPINHfhO8bMAE7k5qQyNxzU4FzrbyARjmokR7k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwCestQmSnMfbG05bjqdOSh9cne09T3F2DhAVnzCOPtgbxC0d
	nBlCs0yj6f8egYnXsFLN4Pyg9vKpMsvhFMXqsFE8gsiEqbtVwuQkzTXi
X-Gm-Gg: ATEYQzz0QP3me2Db8U+uTt6dxfW3yunx/ARgNrMbgJ1V+zxpAOdM2ysMxb+ZeYM6hI1
	07UprI5hQSPDwC3ny3hgDDjysYb1fRPd5qXDMRbn/CRgoHSyjLWNJHZq5NN5xtaMmC6t4AWIH5+
	86zJPVlxaQtmMt79aRAPGiANTyngJa7KYpV6Owh5meSTc2nchAVmWN4jMTyUrjcxyf+eZqoKRd5
	8FBQUQp36c57t9hqfr6x9qSCiHNpCWEgTwNuAkxLlGXWyxvv95rkB0KyiQJSmgk47cQ6ZVatFvj
	HYs7mTIs0VRKAGiBaRQuq40WTn8Pv1YxAUssjwqxCMMUO4k8C8SAo4rw/fa7OczWVJCMjtTgK2x
	WceHxF+hQAeV0dcMRPyCGQAzkfSOQYOtnirzSmV0U94sKBJtS6Tv1ap9jZs7w3dynNpK9EuZh2U
	aAFnz08YC6Z7xoxnFgm6y2nw7V
X-Received: by 2002:a17:902:d542:b0:2aa:d60c:d48a with SMTP id d9443c01a7336-2aeca967d83mr133924975ad.7.1773651695002;
        Mon, 16 Mar 2026 02:01:35 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:34 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 10/14] iio: test: fix typo from neeeds to needs in comment
Date: Mon, 16 Mar 2026 14:30:18 +0530
Message-ID: <20260316090023.14691-11-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling from neeeds to needs.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/test/iio-test-gts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gts.c
index 11250bc905c9..6ffff85ba853 100644
--- a/drivers/iio/test/iio-test-gts.c
+++ b/drivers/iio/test/iio-test-gts.c
@@ -20,7 +20,7 @@
  *
  * If yes, then adding a test is probably a good idea but please stop for a
  * moment and consider the effort of changing all the tests when code gets
- * refactored. Eventually it neeeds to be.
+ * refactored. Eventually it needs to be.
  */

 #define TEST_TSEL_50		1
--
2.53.0
