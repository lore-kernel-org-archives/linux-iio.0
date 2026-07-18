Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C343F0BA
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784398961; cv=none; b=heGYDtUYJ9TYbDBOH/CTdqkzmh8qzslITbsVelGGe5qrA/U4lDri03somSEq4RxP0mWHXY1ROaBr3Cpc6NfA77KJ7S2PESdU04WMBEgl0r//Nc5qGRkS5jB8G/j6RpWU3H4+VvZTwaSOLDeK3msXZZtT21nJru02hN1imJC3Uqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784398961; c=relaxed/simple;
	bh=DpaRWWvw+/hqvqndl4HHuSnjXnhT3nNCk7VMW1Lyq/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ui8Y8JUSQs2VM2Tr9A0kbsw/atQzAgYfNlb8tK6zc7cuu1Ld8L25sD8oCFbLRHEyp1+thKhP/YvuELi/jMbLua+SCmuvsLgK3kTdwsKsmDz6JUd3Cqfklks6Kfe2IBP/R3/KpiSOWVEKSOAMl5pl+fE1oekaTKmRx5U1pPDYPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnZ08Btb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnZ08Btb"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38deea72eebso6703386a91.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784398958; x=1785003758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMRcZrVGhhrJa7FEoJlY6NcwZQjRAoHLAJRWFeVvzqY=;
        b=BnZ08BtbaU1KKQDSzNqJFpdyyReQdnpccvnU2dmzURuwh8mLR69Iy6LuCuVsgQ2VlT
         mTzaswdihqAI9TDtr9pcXH3fwENJ11W+4vNd4xF0cPlNbuSDe0AmLScRNlv4tGSygLKX
         AgA9urDXyJx9CL2Ud6pJHXvZhyRH0+v0iqLQYIH/oXhZ+KU5JJgQA21Im0NYTgUprB5g
         8hV4/QobQSvXzWpkrKmwsOC4TrtUg3hEitpc+4c+8zJfIehFdPybV88i3ZzCviktNKk9
         cX+rZTNPfs9Uuejd5UJwhnvgiyfDSwHHZ7e9NhpPF+JkXKiNVP4IYWSEibcUviqO6Ma7
         SgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784398958; x=1785003758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMRcZrVGhhrJa7FEoJlY6NcwZQjRAoHLAJRWFeVvzqY=;
        b=rxFom7fHzHbGrlANg9ppX7T51RKCt7clckpaltZKmf+Z/CEfBhAYp23SXT5/j+oNsa
         zBItsNckjenfVxer1eyXwHe5TE6FrA4bQYJ4IG6/t9OG0cqAKSbN9MAC/NlHNDUWuMuA
         CyNq1E7OeFqvbfXSbGFeSpBWXmVxcWX9D18llwXUc59jltWmVco2CrBwb9LipqHwYC0p
         lzJXJvQytIePKORQ725xoesEakBz/gnVuGfvQ4D5VfiI1uGOGxf34ptwEmz5L0MD3iaH
         uE4W+5h4sVp6Sc0DPFEHEuRdEN+b6ikvIeIGpeOaH8yI1BzgWGxVBCuvuYWz08RMT2kM
         G0bg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq52veXkH2+ovBz50U74xT2tyhm1o5GPDROZ8rn9ZyzrEJI9u163oXvk7ROXznzaT9AXXxF83vvqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFXWQ4lkTklUOsGC2Y0iWXKA1TjvEK7YU5kpq5i6zWFoWBnbq
	qu9afx46Hw1L6gZHkyCkHazd5TIzxIigKTSyq8A3lQDU+u5kJfLBeshs
X-Gm-Gg: AfdE7cm5lHkkn6Dm0mSNth+VV+uMlQlVPJaDHf440qOM4kWh1+PuW32eaI9i2M5gJxT
	FIJMSeXT9fE643eS3Q2rTJkcMoJqTtxGPdlZlRRzfy20M78DjwekFiHHRBCPbL5ZSdPpEW9tUd3
	mw42mGucUW814pNyGNeMSiUCrdshki9c2dqiyxi+srWEFc6aMqBdXGsZzJq2T7u+5F7NfFd+t7f
	EPOyUgjEPwtDPfxpohw5w38+/61VLGd0melQwRwMYa4uHZDliSb4lMhxnN4J/DRLrzoYvC7cHCw
	cqxXCFW0AlPIjODYbyejYlyuEz9mAjx/T0mw77SVzHoxKBxpyYcjlWPFvM2XxQ9qgecqcZ7fu7X
	zGTCFqG4MkNfzgNGzOVMBP8YFCuacyHExJbVwoXFCqkQfjXE6mcBuqhlprIueQbIx2hJG+oJHq/
	7RNw==
X-Received: by 2002:a17:90b:590f:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38e4b46c8a6mr8590078a91.16.1784398958325;
        Sat, 18 Jul 2026 11:22:38 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4aff383dsm3129270a91.8.2026.07.18.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:22:37 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH v3] iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source show
Date: Sat, 18 Jul 2026 18:22:36 +0000
Message-ID: <20260718182236.7-1-bbnpreetsingh@gmail.com>
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
v3:
 - Return to the v1 fix: bound scnprintf() with sizeof(buf) instead
   of switching to sysfs_emit_at(). As Andy noticed in the v2 review,
   this is a custom debugfs read handler formatting a kernel buffer
   for simple_read_from_buffer(), not a sysfs show callback, so
   sysfs_emit_at() does not apply here:
   https://lore.kernel.org/r/als6lRi-H4DM7ra6@ashevche-desk.local
 - Dropped Suggested-by and restored the v1 title; the diff is
   identical to v1.

v2: https://lore.kernel.org/r/20260718044244.7-1-bbnpreetsingh@gmail.com
v1: https://lore.kernel.org/r/20260717040024.7-1-bbnpreetsingh@gmail.com

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

