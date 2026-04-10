Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01877342510
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815720; cv=none; b=tbpGaLNKqVJiaZi1q/t5yFvYgu7Zd9eNU2LqGJla82mS4UQ1V41KveJ9bbQXCVEgubMmb3EWn4+D2QOAJJ/Sl1EXGfJJw95VqUhlJ35hntA77Jsjtm2v1G5UaSV0CsFuQg9BmQDL8H/dbQZiUnv5tu/gyEX+znbWlUTeCrR1/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815720; c=relaxed/simple;
	bh=jKXI5vmAQ/ZTnFztFPLrzkWhTwqwzddE768Xp81ZlwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3qSFjS2KLQPga8LtNZfQEDciflbyXs70tekiyKZfD3NUA/Y0PqZB8yto32Dh5crhD0TkrrkXEcYXfKHfXHxR/WHI0eGt7ggwdYGYWx+8qVihyTL/c2hZYdbDIEqnss0omTJX93TR5xFB99RZf9F47IRuBRp2eqXZVbScOpn+m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXRWS6Xo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXRWS6Xo"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66bd4f7b2d3so2071308a12.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815717; x=1776420517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8QubiV9zHwo1Oo+HC3yCo8pqsZaFDsRg+bFDJDRT0CQ=;
        b=KXRWS6XoEm8hGxrzkoYEUuzWux7o/wSl8hP75DV/cMKpAs5FF1t2PnYo9BSk/pKL9W
         dTiGqB1LMV0GbemdFyb8xlg1tIVFuRHRPRixNKkmsT1cAJi3sXICB99HpJerYJKvwyJS
         Xv8jPoUqfP+iZYMIoOwxBIsqcZdz79fItt8EKiGBw043h53qpY4VtevByDuymoyzbmLw
         8jM37P5gzWXaGp/GP1th17fdCO/3WNW2hHTW5VYoxlDhiB7eEvB4NFCCVjmjWO+dlMjC
         ePGL7qbfDAEgby843NCtTAjZ1oeCo2jjZEIqBVHO9Jr02yoyoDPQcOgVULpG9iYLkK2x
         957Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815717; x=1776420517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QubiV9zHwo1Oo+HC3yCo8pqsZaFDsRg+bFDJDRT0CQ=;
        b=fhz283B5OsU5p1ydVW89lpkrXYYl/KEnKvjUqBx3YFJuek76RevrnpJKdIQqDtLQgM
         vMAFVtgvY61s4gCZYPTteRk4dhlm8Q55Y8Icr+49mdTCMk7ykKYHaPqt7XxxuHZmb4BE
         zQmtsjAoBFo5FE+DUd0TmHG2zcIz/J9wHA2csfwpBxIJX6jPKzLuzDqv1Nhs2fbjv10+
         Biis27MGkoiH9nZo7pjrLLZO4Vx6TwjJkZYqQf76x7+5S5+8e3gogLXHEKTl2yVfUA6D
         yzLmY4a2YPH6HlVwIR3GSEkIeOWpkQf0E3wlGjJ+HOEdOAYtt+fIAO97FcTAC2ylWPCU
         orPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB5K/x2vcGKyH/gTTKfiO8COIjPPg5DdlwlpZAwRDbasYvX2IKF7eHuAHH5pG3pBGtcRrvjjyD7mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWtLc8+fQp2Vzu+wlOxSbRTtCCkWg21074HKa4nmi9HI2Tbw8
	oQGSwBioXJtmjDuXYia0lwPd89nFTQq2dquUpLxRu+itBUEnlnCxHqjB
X-Gm-Gg: AeBDietG9aVa6XOxBpOHHyVKUkKR0pnmiLlxBzbd67M9iBgtNpashcdE0QhL0s24L11
	BuHf1dgA+BTMVHEoeA1uPpPpKAOK3qxY7hBDUByrYL4e6RIIuoH2kZTEc5iaKKtcMpXQwP233+J
	4gD45ght0EhWkxUBEvX1P/dqSCFdEzjdtM1Y+QlrzzlamFNBrF32CRAGTPQ+YmKkDRLC/9kJrw9
	u5muq3mHsf9HAWwBIOFOWiH7rYxQixySEaMLza4RhLA0HHcF9z3s2ipL4GBnI6eEIutgAIn7fdM
	ZEIrgwv6LfqcdpuemPVFWB+9x9EMgftwpChrnBAgydsUxe9SS6HEK87o/u/MiQRRqGV4LYKu7Q/
	pe1au+m0EoK91ylpMkSb9bj7WfXVGd44/APtWRr2eLFFmRdYU/dxTPBjAlf4+4fZGsMpdV/ZHkr
	Qm+jhhl+zQ8nxPWAvTqCenkSHC5dSzAF0bOJtjq44lf4mo5SezeP9LybpRmdNXhbsJjdrE95kM3
	qr8aNXcTXa1ry7vxup3mxsLuIY+yJ6o/cftufggP0caeciHxHipSR3XR9LzkmKTdjvjeaR5OXaT
	bHtciEsue59vDMtiqPPiToZ9woUwL82Y4IUarbRGi1M/zVqfIM4m5CxU9kwvWuHo+D51nMYRka8
	8gO6RvZo1bFl2AhJqCDg=
X-Received: by 2002:a05:6402:21d3:b0:66f:9f63:e537 with SMTP id 4fb4d7f45d1cf-670798efe44mr992275a12.19.1775815717177;
        Fri, 10 Apr 2026 03:08:37 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (216.153.158.34.bc.googleusercontent.com. [34.158.153.216])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-670703f1340sm433488a12.10.2026.04.10.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:08:36 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/2] iio: frequency: ad9832: cleanups
Date: Fri, 10 Apr 2026 10:08:30 +0000
Message-ID: <20260410100832.1388-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up issues in the AD9832 driver,
including proxy header removal and bit math
simplification.

Joshua Crofts (2):
  iio: frequency: ad9832: remove kernel.h proxy header.
  iio: frequency: ad9832: simplify bitwise math

 drivers/staging/iio/frequency/ad9832.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.47.3

