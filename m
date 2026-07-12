Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB873B42D7
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887917; cv=none; b=cEP4nrx7qgYYXM6SZidXrduKYgmPqAjBSCppPfZ5KEd1iIPfTzVM28X+xsMayenJSHq7zHI/QuSAZOSBe825uy6VDLz+GVfSL0Zm+06W42hXTFiSMvHlPm64xXyipR1W74W2VHpkdYh6MtYfEFottzzccL0UrmEo9jxqN6sT3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887917; c=relaxed/simple;
	bh=B9oykJbY1MY1CnaQH33h0JVuWS2mpWhoqz0M2Lji6Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u48EMnjrBYF1dEIinUgDti6zIzyGwBrPHFN7X0U5/V+B91OqUJHLH+bnGqLCGOCg1d07wo4RShXij14Zx1t+tE5TfEexMMwEWncj5NNzuy2il6ECupVTnvRD89g43o4lZKkEUo1LSZnzZ2KrTHgUfpnNmb9/9RKQh6Fb4LKAjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG1HQp1K; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG1HQp1K"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so1618213a12.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783887915; x=1784492715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhB40GX9r2MWq3eX2ITmrKlJx8RApsn1rpbCSOUkYAw=;
        b=PG1HQp1KL1Q1uUGdrfBrWZwa9F6ufBeIJNHOZ8LksIZ3jDK7OXn9PDtdXCuI+nq5FS
         8NCyQZc4E+oClHh5mvwt9WkJC/iPRuCXuqLNcSpfW1N6S58W0BB6GdABZZdSq/JHGhkS
         poLhaqpNB8ctzz4Gs1a7K36HaGkZbEfUqtxyr+Wjt74n+gOqftaphkuFpqXqHo8eDEpB
         pFGuk9lkOmgS9aditzlviav3VCr59ybCB9vkhfGMUIOlYZGCv8DvMH7s8NPrGqTYwfW/
         VOS75YCvAUg2e5PriLsaCfJlqsvPELI1ONhOLbX9FQqtN/vaF2Spbe9+//cE7lJxeTgT
         OKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783887915; x=1784492715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MhB40GX9r2MWq3eX2ITmrKlJx8RApsn1rpbCSOUkYAw=;
        b=AO+0iYIIF6VPiHZZx97KV++VfczQjD6uf9szXO0Zqxsilv+NltVhh+7GiVp/c8zK5L
         /HPynSGIggDyn9UhUJIczTmQZGL5HQuQ7yFM2u7dKfdiV4gz8QdiqQqOxU1Pi3wAXq5g
         fRUbLkOC8QWfaHk0yZrkZ95FLX9wnf4dGzrr2wkLmhCL1+xsgOSyme/kIhO4cBNJbrlx
         /E1S28QKz0/heWZ3XHnwIkxbxWGBlKTit8UGGrW2PQdECdY1JDgFWb9iZB5NvzXOI04F
         mew2ByLaxJsdHAHdeusAE9/fDXVdBgSCovVpcRRR2Lumnuec/GLPAY5MkYuP009jfiIA
         51pA==
X-Forwarded-Encrypted: i=1; AHgh+RpuBBZNyNoROz7RqUfJNtApOsllEazn9pvYCjogeZIOABe/OzlpBhmLwxvIeJbwsi61i4V6k6fV7co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaqYgu1I74q3SuZSu58EiuLfpPHsVBIIFLzNMNZbxCqkFYorBu
	YAA6ktcCgHO7CLvxfyCRpH3l4SwqjvP2VuuKamgvgHKpfAL34rIY8/E=
X-Gm-Gg: AfdE7cnF+O1Wx/av3SQQ0YBFCnqVvK/F0aiamkPIk9S99ILMczGzkjkKL9YuewGecUy
	RyLxJwvKgscccCM0e0XIf6JX4ybvUz8GsMJLdL56MEJbgB8cH1QmYhwAPATAG4ldCN1huDsSClJ
	FIE6TGll5WsTePxvxUxWFzM4GvcVFJUOe9IySeuDWdWqzDHaA2SmCG/fIStYOKswZ74BKhVors+
	EiE8apjov00wIq/D0PJVIXpM/zdJs338zMC/W5MrsazjaRoOUKJBSWjgoy7wqIz4d2hRLNd+frX
	tdUWGe/wXHTTRYAv8vPESIg57kKncQo4bBJX/XmpaWYBGt357AozDNDP8vH5EGKobRyEiezZ2Fa
	uYs+DBF3h7p6PTWQY2KakYewNC4wB8LdBOrQMCoxy2RU5Bfz9Bb1DluEyekBeW86+MAwMlDxf4T
	YHU5Xa09CCyN/oACYyMMQykPmgHpmR+HQavbWYeYgudlj7wE2HlEUH
X-Received: by 2002:a05:6a20:c5a7:b0:3bc:5284:4859 with SMTP id adf61e73a8af0-3c1109e29d1mr6726693637.13.1783887915255;
        Sun, 12 Jul 2026 13:25:15 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm58833648eec.4.2026.07.12.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 13:25:14 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v1 4/4] iio: light: opt4001: Fix reversed GENMASK() arguments in fault count mask
Date: Mon, 13 Jul 2026 01:54:51 +0530
Message-Id: <20260712202451.20822-5-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712202451.20822-1-nikhilgtr@gmail.com>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(h, l) requires h >= l, but OPT4001_CTRL_FAULT_COUNT is defined
as GENMASK(0, 1). The define is currently unused so there is no
functional impact, but fix it before anyone builds on it, and add the
_MASK suffix for consistency with the neighbouring definitions.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 31a5397926eb..294532bcbc50 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -39,7 +39,7 @@
 #define OPT4001_CTRL_OPER_MODE_MASK      GENMASK(5, 4)
 #define OPT4001_CTRL_LATCH_MASK          GENMASK(3, 3)
 #define OPT4001_CTRL_INT_POL_MASK        GENMASK(2, 2)
-#define OPT4001_CTRL_FAULT_COUNT         GENMASK(0, 1)
+#define OPT4001_CTRL_FAULT_COUNT_MASK	 GENMASK(1, 0)
 
 /* OPT4001 constants */
 #define OPT4001_DEVICE_ID_VAL            0x121
-- 
2.39.5

