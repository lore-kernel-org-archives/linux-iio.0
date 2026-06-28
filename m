Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBBB1C695
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618512; cv=none; b=HLmaKg2hVpykSe2Fxk5spIZsS1a/+eQpdizgIDk5r7REkAZhA79Wvz61agtUhgl0MoFemgmvbKR+URy6yzspIXmozLdMLWGo9FBBStleWo0FqiNuJugldavLgwypPaEhZscWeI2cmtUNJqTwQMz0cMJD/O56NzU0m2A9EttaaqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618512; c=relaxed/simple;
	bh=gQMgT0CyDt20+h/TDTxVmbs/IVoBiq4YAJlUuJSJvAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdyZpu8azMiLa+GxDhP6iyBLw27mmSH3AUp5D1Bgx//MPibncd3SHAAnk2vgmXzVNgAk7Pk5xkvYkufq+vr8SonUDrKQnN5Zvu7kfAijKniLA5WJSnNhEO36wOcwVMnrB2+LPmUKFEOmIgKZNMWO+L6R2suembBDaJla9P3TT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Jiv4qGqw; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Jiv4qGqw"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so4759401eec.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 20:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782618509; x=1783223309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnzluTym9A66Bl2WsnmimA8VRlCDF0/Im6UPS8r6rLE=;
        b=Jiv4qGqwem5BrUVAXzuxyUEeLKnf9zfwPL/3801qpAyzVBUaXE5eLFqU1HDv95Mrxz
         XjBT0xtvoow/3YktQHoEoAth5F+RWTxkcpMw5ev4hxM91Rcwl2MASJhU25vLZDgznz4d
         ivbJuTJQBmVErEW+2PL9aCRKC7Th3st9yt+1Oc2u4xYfUQljHRQDcXKt051GytFvmVoQ
         bUk9ENF4iNHxfxbwL++8DVJnZCfkzA5YK9IzQquIJWAwplftnuSWmnesP8TvUONKBHF8
         vTa3qz02q8JoZsuqfwZXdhuyUHZ9OJqUhdNkkrxlrSn5Aia6UVIJ7d/P3TrQbA92lcZD
         IXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782618509; x=1783223309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnzluTym9A66Bl2WsnmimA8VRlCDF0/Im6UPS8r6rLE=;
        b=UIx4RM98nrep8x9SCP6sboSCSvyOxrzFnRmlBo4Izut7DJ5KjqLe357r78wUMg9SsL
         qtIuR+qeWbWyO1nLO2Sj1frBVUhqHwN1CgXt0N6160ucV3AzDADiVyd8FMzxIlzOAEn6
         wNdrfn9e0oT1trP5ZRBnV01KhP1U2Dsbibu6dF5eQGMPNR7ufX0zrh8oek4WXGZjv7cR
         HAV71Dsdx/LEU1t/RD1u4P4lCMwcf5ArZGN22HARYSORHcvHT+tUGiZSFMGkhm12Bd6P
         wkQAOQiBCkaG+FYwuPuTW/nbQfVd6qoIePHPyqB0qUzU7ZFvClH5wEf6HZ6MUeWlc2Zr
         I8Ng==
X-Forwarded-Encrypted: i=1; AHgh+Rr5ROA/V7tr0ljgdBC4zS0ehNVxNK+2Wtbp07f+otyM4GI7CTZ5q4ZtFTUrSYH7bMnQ64jM6wmkih4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73XHEU3yx/r90hPxM7pCffKz9ZCHt/OeOuLeMPo4oZp5XDBbY
	+qnHVEBvyWtyap0wevZm6NsHKk2T2UAMcFZKvVgm/7MyVP/0OH/URmVs60cicFiDNIM=
X-Gm-Gg: AfdE7cnxOncSMXrO9cQlepOxzRBPmJGYnL1iZyrHsUTWfdo09npp0D99jTU7kzDKGCJ
	POtLGbW9AapJ0G8utXIABWyAhS+jlRkO98fXO5TvCUUaib5y3I5WPCUG+RayD8xgaBQRjpBrDnO
	4FJ/A390aQ7HAK4buv+YCrOwYLULw8n/3+2uu5y8PYoZAyVczA23Zzb+RE1fow5BxUZqPK2LO7t
	SImZ/2LmBa7fljG12Sk59ozSyVfR33NjYhEiWW4UO3vrl58+cqY/Ye6yFrfRVVbu/9c5wilf+1d
	VFuvN3jgdnq7oPvVOwWJwaq9I78k/5l18l/rAUmzz9euwnhHOuTf4VO6bmgMf5glHdGEB56DVjI
	GRvXFeq1OS6V5BfqJ+lM8j2VuDdUoSUs+CU7YVpq77ewDjgITOIymfEJf38gs103vpbBPA83bW8
	07iFGNrIepb7/B56oyAXOi3iulYtQ=
X-Received: by 2002:a05:7300:fb96:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-30cab22afa3mr6083708eec.18.1782618509170;
        Sat, 27 Jun 2026 20:48:29 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:dab8:1927:ea27:9d41])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30cac1b9751sm15085691eec.3.2026.06.27.20.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 20:48:28 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v5 1/3] iio: dac: m62332: Sort header includes alphabetically
Date: Sun, 28 Jun 2026 00:48:09 -0300
Message-ID: <20260628034811.152946-2-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the existing header includes alphabetically within their groups.
No headers are added or removed; this only reorders them so the
following include cleanup is easier to review.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/dac/m62332.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 3497513854d7..56cd0081afde 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -8,13 +8,13 @@
  *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
  */
 
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
 
 #include <linux/regulator/consumer.h>
 
-- 
2.51.0

