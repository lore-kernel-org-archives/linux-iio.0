Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3A1E98E3
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260827; cv=none; b=pFgato9di6Lssijmo54fN+VQv2mNIyEj4wJGaGVrKXCRSktIjSIddW2cJO5WY9lGiYD648FHHu+ro4T9xgN0isID5IR1xXtTIGw679Hgcf+STDWkDvx+qqZ2Qwv4sgBvche+qJyUx0MBeRJd43XOTxrg3tni5RVCRYIarj1O66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260827; c=relaxed/simple;
	bh=srtVSx+D8qPZCXPYcX6dhnDwmJ7/WuXkrCLIk51CUQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeW4F+dXXl1RKeQx7BveZW6s4Blzj7J3NPQuD0T2ZS5z+fT6Tkow8TgIsaSqJHqNZBTvUnDij6lWIONNzbxDKYi/YqlCaRCeqeRcyuKLHlyAHsIFju8ibL9qgOKEB6fgJpMosVxMEmWMFQPkHJHB6woytETiISHmkS9TuDbVke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCk02djP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCk02djP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc61541f8cso11128765ad.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784260826; x=1784865626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zZBgevOBqGup95rqVpZgxAvq7nTF5bn0HYRiCeBYRfo=;
        b=iCk02djPebupKTv4IsMobvcUb6YafFco+pe626h1KIhYg8uyQ3S8EXMDxcMkPsqgCL
         DBAUwVx/ddnuZc9kD1CquNFpwbumne0foNaCW1RStsoyDJX0lMLim5WSGwS26qIMe2Og
         l3w9sCu+oeqcmDWJFeKtlJ5kTYbko57fEfVnUHoN6TTb9UL4zqc8Z+8jTIPTI2AJH6rO
         0PrkAxY48Ac1WhXVnYmxuNfEVSU7RtYzC7SDIeQACtwEukKOPjdqGExW6BdgH4q4zrI2
         wS6p0/GHPaiXG5Y1cpwlnRQJHzsUu5CjR0qhO0kqPJslFF+uwozZo530LRUdNHsKUMRC
         7/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784260826; x=1784865626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZBgevOBqGup95rqVpZgxAvq7nTF5bn0HYRiCeBYRfo=;
        b=Pl1MyhcrgcKQT2l+ZlZQmBh10B+X/U3nZ6hts3/wsHJ9GLVbx6HtLC9OXD1W5o+ywa
         uxqNF3Y5fKyGv5nWG8NwjjODYUp4U4mbk8n2Fh70V7uDTVIHZitbp8+rwOvftlJBUvw+
         u5I0ZQii9agt7p+zd57J4Fa2iITjI5xM3n7LbYuxHjP/LR8KuFp8d+zJv5WKigEwhYtk
         dCzwJxLPs+gnCt5B/9KTiN3hQxXRNob1guhRGpm2rKrbnO0r09rmTP2jL8LyQRtje5Xu
         Nh9q03dCMbmO3vKsxN96Zo/p+pvmZulrPfNJ44FH4yIunaydFXxdUOgCX7ue2hviLxWA
         PUIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtdZgmL6xBdfVP+FWtp7K+qNhyp+dGI46OuqsyKbKOhisC/qPmywR1u55LpcaL+0fdtJMizUq+ohw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCv0ZpgtOhhk7msOHmKCs7nxb2QAQ9N8e5EP5Aulh8KPkm+35
	yyVYltA6op/Y/cjQxvLH3jfo3jatAIWtOm5t3rrWYryK3y7rmIJ1r6qL
X-Gm-Gg: AfdE7ck4Rkook/kynpO9zpLIaRKWUwqloOoZsSTDOpfwSa1ELA497VcGgnpdvVIMUn8
	L3lpxyDy40UxWt0D0Vmqayyi8MpBHEgTtjK+yurvxEmdVhdlzSfumcy2ulKRqedusxNezc5iRyL
	V3rlks/eaGLOHERa+X2ykJF7qkxN7AN98wZj8kBe2BNXopzcrOTF8Oy9BjAnMHrIAOk1/JGlvCP
	XCow0m0gTR6RmBHkEl/pu40jL0ALPKgnvAMHTDIYbgHOrVnFXodVp9orgS478HJ0ygxrbFOG4pz
	y4/XNkxi1qucovKbRIg859aSfO1N9hmesLxrwNb4kvPiUSxNpSGNHW41bjhbJaSg28RnSskdd3x
	AZEHeUS3uU04DgUxyStKQ8XcyalJevcxN7lnlUScPXHpRfihDkQdpMPXhxxFFtlxGaBWjGHzmv3
	lSfg==
X-Received: by 2002:a17:903:2ac6:b0:2ce:a6a4:451b with SMTP id d9443c01a7336-2cf1f2e71eamr57782865ad.11.1784260825887;
        Thu, 16 Jul 2026 21:00:25 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b1ef8sm3207915ad.21.2026.07.16.21.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:00:25 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH] iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source show
Date: Fri, 17 Jul 2026 04:00:24 +0000
Message-ID: <20260717040024.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad3552r_hs_show_data_source_avail() formats the available data source
names into a 128-byte stack buffer, but bounds each scnprintf() with
PAGE_SIZE instead of the buffer size, so the bound does not protect
the destination at all.

This cannot overflow today - dbgfs_attr_source[] has two entries,
"normal" and "ramp-16bit", 18 bytes formatted - but the bound stops
protecting the stack the day the table grows. Use sizeof(buf) so the
bound matches the destination.

Found by smatch:

  drivers/iio/dac/ad3552r-hs.c:593 ad3552r_hs_show_data_source_avail()
  error: scnprintf() 'buf[len]' too small (128 vs 4096)

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/iio/dac/ad3552r-hs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 02a124ac4855..f865843aa439 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -590,7 +590,7 @@ static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dbgfs_attr_source); i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
+		len += scnprintf(buf + len, sizeof(buf) - len, "%s ",
 				 dbgfs_attr_source[i]);
 	}
 	buf[len - 1] = '\n';

base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
-- 
2.43.0

