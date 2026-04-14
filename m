Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D51EB5E3
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186221; cv=none; b=DGMm+3T7XmTqqflofaY5oH9cNRvG5RyBcPNh5YRWMEHQ+JqZ/Jc/jZ6flhfs97sdKGfAmx2y5T/VeAMLfXbQ9tDKg5yZ/zr8yZqMnR/X4tlK+RLNTMajFYoiVdeT7pqkRsHZmnfygTggeJm52OMV8ZXVtfi+OWc+I798QklTd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186221; c=relaxed/simple;
	bh=T/XMurYRuTVT4oTepbsatx2cslFrqfzDZHyYG0YGZag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKplUgyfIXPcw/3J78olvo2CH5LxpCewGWKhfmK6QF/W/zKetwxGr+p9vJbioobVZP75os9JQz4IUHt07z+ZX4venUib0+llItqIAyjBq2rJzOOEQxqcOQhzawRzqg13nRgJbHVdnm3DaqFTZ6K98n23sDOrwLkPiSTyLWe2a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT69b54A; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT69b54A"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41920so1964397b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776186219; x=1776791019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yZsDfEipTuhJP3aeYuYCf7/iyzaTCrgTFB5fEefPrg=;
        b=WT69b54AHVZRlzc3RII6DwdzulV5WXmo79Hpi+7/4IpfGvSr6yr+XrSQgpwWuzqW1r
         7RYJ0+TCHyDubphFJqvRWrIkD2sx7arhTFEp2/RVIYZnvCpSo2lqa6AWgdvBr8Z5qhQX
         U4fsnTfj894+CNRP7MklijXrVXjDERmSgyEVbOc3jufJLNHk3zi/9PojBa77rqj4Eflf
         tyoQ2Fz1PrkL4do8G+ubztcWRC5mfL7Vx1vNJKfgSoApnVAzHVr5oUw/oubR3WSfvHk/
         8Igp3+E0anJ3oiNWI21KImHkZA5toxHKU6n7GTTYmMB91k+JmKKUa+uQRIvckTW9hxbI
         ZDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186219; x=1776791019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0yZsDfEipTuhJP3aeYuYCf7/iyzaTCrgTFB5fEefPrg=;
        b=iXmH+nEiQWdPO85LFx/eZlh2RGcrDv5IHpt3FNUnl7+ivduAqIAK0lFt0VH1TQV2D4
         NGH/WCx8yskVVTJqVzx/bzBENNIMO2WlYPd5EMqiHUKkMYqRFA5+/A2g22vdjaV2wN//
         p4ynJfxdf4E5y/y0V12gN3kmAwQRDSRwaoeu3kwUgDn514I6bSBdIEPUYRBSVN1+coWm
         IWajXva2xNFvSoDNIbyFBTtwXPG7HKFkRjHhYDrxm4QXMgGBvH5AQAACi1M090LMOXyk
         ElyYhQ2Zcb16xACwgKgcf3G7kBehs/zfz0YfzpH5E4rHysJXLCDLMYHxsNqB2lhqmoQ8
         DEWg==
X-Gm-Message-State: AOJu0YyD1BhorZPmAagCY++Z/RSwsAvBLTP87JOUZvGdXm3xnS9NP66G
	my5ob7GGVGVvBFjpFRsAlBt6BkCXySua1nbK5Bkik1dTiTATCM3kGDS1lj/ZJG4nbKDc
X-Gm-Gg: AeBDietD0KDR2kRt4P32IO8q4afgINHyYe1Bclk1Q1QVaQYYDP0V9j29lqgiT039/+K
	IEpdZEj0KdsYk6iTNDahIB9/fUyXCqClaALIoI1G9P+OSr/1K+OyXYOXnFGQvCYmqAYq8z2ctxE
	OpQOjpMhVclFhTR+W/kkEeh8qUIm1zJl9VkeaxOpWwpJxS72S+NfsbGtfJ0TwkXiSQXvqjctVB9
	qjV019uXYEbm2O+fQfmDTgALRV2Rts6MLgt/R95qTmdNoijY6EFy3YkmTvRSEX+hDkjBgyGRZjx
	Y2RlYiceoSt6+Js2PTel6e9pgWRhKZTJfDvMAlA+w5gD1RJDS3xVrKCZPtnKZr4rbQJeIwC/7b5
	+KGBa6IDMvdqwXpdLY+hrsuola27hIjgnQ2vTnpqEAyetLR9pGN9ZftWNzoB1S8QO24MTVdhV5F
	SpD67V/wZNYSEcG7VWBOooRKHM9KFrF28xpU1jG0nIcK4=
X-Received: by 2002:a05:6a00:302a:b0:82c:daa4:ce29 with SMTP id d2e1a72fcca58-82f0c2d93admr18210161b3a.47.1776186218745;
        Tue, 14 Apr 2026 10:03:38 -0700 (PDT)
Received: from nik.. ([101.0.62.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e3d41sm19077474b3a.48.2026.04.14.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:03:38 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v6 2/3] iio: dac: mcp4821: move state initialization outside switch
Date: Tue, 14 Apr 2026 22:33:07 +0530
Message-ID: <20260414170309.6151-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414170309.6151-1-nikhilgtr@gmail.com>
References: <20260414170309.6151-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the iio_priv() call outside the switch statement in
mcp4821_read_raw() to avoid repeating it in multiple cases.

No functional change.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/dac/mcp4821.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 29187f2a9d3c..102ae3718514 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -115,11 +115,10 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
 {
-	struct mcp4821_state *state;
+	struct mcp4821_state *state = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		state = iio_priv(indio_dev);
 		*val = state->dac_value[chan->channel];
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.43.0

