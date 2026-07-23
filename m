Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE8456DF6
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823563; cv=none; b=izqUK179iVSYSF0bslmX1m6oQk1H7cM/BaSoUUIwPAG4u31Ekcydd/aWD4HuCcNl8t9GIoPPg2K1XuVL9qCtyXblMR1uqvKj43dN58v9GO09r3ADZB7dLQGn/4+c5DfyFRbfJd50/44Ep8DU37SBrOLnlh9OlwJYYIFXuWMQ3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823563; c=relaxed/simple;
	bh=ig76kvL9psH3DE91fqVWlMTnKGxSch2e5BZbLuGTwtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbmDC3ljneZPbGeaBKzSzTBRxNy6GkVAkhyKP94kPuGp1IpYPlk1aqIk1SFsE94O/+dnSU7XPFFYcCuIdfT343MJe+m3t6gDkvwHftZciT3OaEfE4C6PcV6lpKFuGE9zjTOf6A2UvSjM7mb8vS2vheduQICDaR4gPqOo8pa4ALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/rCwvLH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/rCwvLH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383cb94f742so857856a91.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823550; x=1785428350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lWik9mcOvPSWmwo9ZWauI742Oayf/83cjlLhW4ZICxA=;
        b=C/rCwvLHmDj4CaD2AwcdFRRbYgP40YDCU9mpFFE0xfhpZ2OgaRYXrJiuf+3msxqeLe
         M7rvm1EJPI/ERJJd0oV6K0qd3f/iatqYd27yTCPcgpyOIqAYf9J8RBeq7SbdOk6/jp7j
         XQAlNLRTZxvKKC6yDSqeKcUumQb3RdRrQRv+VSvEElmq0Mh3Z+jh22bRnEjbQ4ZkxuwR
         alT9Z8KQ2VaqBPXASUu+O7gF5LYbrmePVn8QNusG5ESiQ73JS0Lzj/y59M75HjLuPAfr
         Ptxysuvf0Lst+64/gZtM7eIyFKNqLbeC/pqoX9IekE/RTOGA8swWliu/taBsR7xC7cvC
         1v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823550; x=1785428350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWik9mcOvPSWmwo9ZWauI742Oayf/83cjlLhW4ZICxA=;
        b=blUDzjxlw/bSbIK64mmajFDV3DAVFdFq2dOUS1gG1TpWN2fCKWJwTp87R90pFGVKws
         CsV/iCWRlFzwiWwKrVSbE2j/OCitr9VMIYynaAMSsujGg1iY65fVlYoI0C3TjC3w+OBD
         ldJT/eHMQrfPUO8+A8Q+MCLST5YQsVRfPE0FPysecs45f/95iwn7iWU43F96xuYwAGnT
         d+WeBQmsO9yHOFrpqGcCCJ1tJYL7nNHHjn+0UM9IIaRhoP9F97gRET2hiKdsrUQ5cAJv
         NJyq3IYbJ95JMeqHFCNmxalgkINRsvQG0AFLJ57ir95qjQuTQngLwkpVbPSl64/xL4cB
         vHMw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5wM4DEz2fbPrb4EpJDqiW+NCdIpisRnvK2P0KUmh1GDdCEVD6+qrQKX1jZxE7/c2VVI4q7edMC1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuOP23HWogR9nYuhzPLlPn42/ehSzG+7fJiK5ARLZiXgDzoc+
	cgTV3xY9mKn+75GTtTXqQ+jeOaZxYnI6HyYh3XW/yVswYyuvQnqrQOcj
X-Gm-Gg: AR+sD100YfzeaF88ygEOUB2PJ50XmUZJotsRmqkdQT4Ea0eQCXF6RLaKFTueOid0La5
	U/eNM1xoX5bX3VfsxGJPCMYNOw2L3iflffaCd+l4ky7qTVQZs0movKgemmIa0//TXv9F8OwRPKF
	Nnz5ZTpk5MNmSSqwPp93FTlUMfbixB3bUMqiWOd4SZ7dwd0YFuKTCa383rmYDq4zLo0zxf8nktf
	ZgTMGvLT5IMvjrd+XcZUZ6loXp8AN82c7V6jCcUiqF3Z3/YG6teU6G8UBo72dUqQh43lmg52Ul7
	pttDx6jQ5zXfmPoeis7ZxV01MTdtOUtQgBS+6keeJbYB9eMel9Jnbc5/T8y4++kUyG3+3XSNzKB
	NPyHYc8969ErQiOvd36kHrptczTHLyspcIsFyyJ0GYDMOEXCGGpBtcMcEXWff206dV77TtE7V9d
	X1FnFmqWVjNpof3oloVJ9NYct1kjhEhGUBZovb0xNDp2URONevJrEyIi+QrJaM5yGkG+V6I4ElK
	hE=
X-Received: by 2002:a17:90b:1642:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-38ec6a51c61mr3504827a91.20.1784823550345;
        Thu, 23 Jul 2026 09:19:10 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea47f4d31sm1910241a91.1.2026.07.23.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:19:09 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	email@sirat.me,
	krzysztof.kozlowski@oss.qualcomm.com,
	mazziesaccount@gmail.com,
	adinata.softwareengineer@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] [PATCH] iio: chemical: sgp30: cleanup codestyle warning
Date: Fri, 24 Jul 2026 00:18:49 +0800
Message-ID: <20260723161851.21722-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by checkpatch:
FILE: drivers/iio/chemical/sgp30.c
WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/chemical/sgp30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index f10bbebc29e4..c33592a1e0c9 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -82,7 +82,7 @@ struct sgp_version {
 struct sgp_crc_word {
 	__be16 value;
 	u8 crc8;
-} __attribute__((__packed__));
+} __packed;
 
 union sgp_reading {
 	u8 start;
-- 
2.47.3

