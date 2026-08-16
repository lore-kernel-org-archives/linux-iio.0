Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13539D6E9
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786923762; cv=none; b=uXngxXcWTCouwh/OjCNRTYVQI23mPsnR0tp7T3br5hXXjipzvagyfl0nBqwt2DrUupCsEqqcm3169IcWTAuWruZBrUSdC6/Aq3MEHENjONIR6ACRhFx/yescvuF9Pb2/eKyftut7vnSJ//GrxJF9/4HLEuM56rZdFGUXt9NeV00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786923762; c=relaxed/simple;
	bh=cuAqpL4pp+pe7/LyhOOuq2paRfSRiNAJg+JRL+ZyChs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lm+XXCSmmLUrabLdjp4YIZfBgcaLeEU8dUxc003ePrGzc8UNi6iYhM3007/6yjPiLz6weOSz6HsdOvJmW+Psj7hcbRAlBBirkNQqV3MlcrigASLI6Z4syJXv+Y1lOrEETEi9O7NY/kqr/OBjC6Mm2WeJSPHBvK3ehHJRsuQua5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5Nsz8iC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5Nsz8iC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so24287205e9.0
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786923759; x=1787528559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5r6hpX1fTPK7zjwiATG/UyXCdz+ikm7jiCTRgU/Pm/0=;
        b=j5Nsz8iCEVlIGY5bMaGaw96csd28tBrUnE7OjZxDDdYEWe/+NkjT7hJK0kZKnsdVF2
         YcO9BT5PH/0YUzCv5c2qiK1HfJIGvY04+0PST6GCTKo1y7DORPcN9DnaZ7F8CiqLwSdX
         mtyhuqc5C5HfuASr9CFWrmoBTjoq1VMJjFmWsSXbhnYdUzgQFUWEZZB0bgqu8IV2wRV0
         h8PiA1iGFXMm2yqeAZZGvjC0nY8Cpru0pt2z9ul2B7x7T55T/r62Ax9bazQHhC7ds84m
         aRLYPmX2oHLf76AiPudgdOZYpQ9/T3n41v/MhMVMG/jFeX6Mug7sEcNHGC5q2SqXvJ6p
         GBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786923759; x=1787528559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5r6hpX1fTPK7zjwiATG/UyXCdz+ikm7jiCTRgU/Pm/0=;
        b=DS6sOCe8E/6BVwVxqpSSFXmPJMuAEFlXWHgiWG4sgeJHZI+mhDY8au7N6bk0+fvrmo
         wBist6GxuPhCPRYjCoP1NJi6Yb/fYuMmK23gYOGE/Gy9ZBX9duaftGcyHw49GjGHpgoY
         KtgGT8EJMazMITWAADULj+CirZnaPGnLASTM755DD2lNT4/bnokZ4xgXe0nFa5yLWOhl
         30TO0q1uo5HKI2hYMv/nnHiSY+V1kd7mOVbQ8fZmCqNQOBrawYf+xMeCUV+prQA1/lZ0
         X3RXu2rJHnc+Elv9X9ehS7sjaAChgYYzSXuUDduc9CQBGlnXhi+F4fp6w6XCj5J/w/N5
         7QnA==
X-Forwarded-Encrypted: i=1; AHgh+RrpxgpPJghv6bDUr/aVKMjMpU5K74HK2v/wtIw21P2mYYkNVgj7seRoWty2kA+VigwZJpOOVVuiymk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYu51kn7CwT0mSLTeBfZCp9oVzfm5gwkCbaAb5iEY3eOtaPXug
	5XHso2yDF8EmBI5KKEOpArwBSSZQ2e6zp4iuf/rpGFSqvU4WjDYn3PQqS1VBFr+9TwQ=
X-Gm-Gg: AR+sD133z/mb802PE+X35/S5/IAQ6SubJY0nsnNroIrdoI6zStVd1ti97F8ALnkBClN
	W10DlH1PkHUoXTo1/j917ASg5FB4nGBqTWSe+aWIqEI553Db7XrrUj6FhQpXiyicWdZ17VbqHrR
	W8ZoY6goU/T6t7rzFc6tgsjtfF+gki+fQHF1Br75OqIeaueh8iC2lwW7Hi51ZNqFS1jOIIa43bG
	bGXXRxD3L+3FV4I1BwxgbO9Qtr9izi3/ZFd3nCOGXlOpncjtNqYW9L0gHxmDjoIPGU4sVdKR1IB
	9bLFGXfVjQAfrewsnL5LELs+esmGOm9oTVISXZ+nrExdQkQvNywPiGfNTTQcYuBSu6FrdBgl0Ju
	BzmwQR8S/bs/sTO/4uxeQH0BFy/7o/UunA8JPDrvYFzilaRXRSIiWyxxd9p0ucSdtJVpAAT/CWZ
	JlpTgIK80AOe45HkDIJRz+7BQO/fWIvNrcZHKW9tnYPE5EQUxJZDuKX+lZXLbUwHFNnV14myRKf
	urCmyxqYbHzP50GZX70Yj0K0LydVakF0Yw=
X-Received: by 2002:a05:600c:1f91:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4998797d111mr281850495e9.15.1786923759174;
        Sun, 16 Aug 2026 16:42:39 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:ac71:8b16:e755:35c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960ff072sm112915555e9.3.2026.08.16.16.42.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 16:42:38 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] iio: accel: bmc150: fix event-enable race, then use guard(mutex)
Date: Mon, 17 Aug 2026 00:42:28 +0100
Message-ID: <20260816234231.14168-1-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses what came out of the v3 review of the
guard(mutex) conversion [1]: the pre-existing bugs had to be fixed
before the conversion could go in.

The unaligned-timestamp / DMA-safety problem in the trigger path is
no longer part of this series: it is fixed by Yash Suthar's
"iio: accel: bmc150: DMA-safe buffers and use
iio_push_to_buffers_with_ts()" v2 series [2], which this series is
rebased on top of.

Patch 1 sorts the header inclusions (suggested by Andy in the v3
thread) so the cleanup.h include added later lands in order. Patch 2
fixes the event-enable race in write_event_config(), where
ev_enable_state was checked outside the lock. Patch 3 is the
guard(mutex)/scoped_guard() conversion itself, now applying on top of
the fixes.

[1] https://lore.kernel.org/linux-iio/20260525110130.61284-1-grondon@gmail.com/
[2] https://lore.kernel.org/linux-iio/20260815175728.99541-1-yashsuthar983@gmail.com/

Changes in v4:
- Turned into a series: prep and fix first, conversion last
  (Jonathan, v3 review)
- Sorted header inclusions (Andy)
- Fixed the ev_enable_state race under the lock, with Fixes: tag and
  Cc: stable
- The unaligned-timestamp problem raised in the v3 review is fixed by
  [2] rather than by a patch here; the series is rebased on top of [2]

Gabriel Rondon (3):
  iio: accel: bmc150: sort header inclusions alphabetically
  iio: accel: bmc150: take the lock before checking ev_enable_state
  iio: accel: bmc150: use guard(mutex) for mutex handling

 drivers/iio/accel/bmc150-accel-core.c | 92 ++++++++++-----------------
 1 file changed, 33 insertions(+), 59 deletions(-)

-- 
2.50.1 (Apple Git-155)

