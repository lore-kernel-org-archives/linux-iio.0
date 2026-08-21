Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043043CCFC4
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321195; cv=none; b=RfswHWaEikoc+DXQmDsr7SAzIK5Gy14IX/vXojV/fp2ATZWYfwsObD6tzN5a5CwksNmS2xnzNVPEdb7ea/wZ78p4bLDKgI36rcMzfqK6W1LFYsxGXhn8K4oSp0GjwJSuTLpj161MqkqBqtMtsaGX8LEty0+UuueIEKEZePGhnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321195; c=relaxed/simple;
	bh=c0PiqgIwyXsHVxSOFYpXESPwhADDQ6iLCQhy0T9Oy4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQooK/RtStTXL3CveD6g4xk07FXHr6yqK9MyLRZflJZmhRuWCT/jAZVxGdiLtYR4RXxgvKra9/7qYRZU6xGtBp5tL5wvVXaRq6TUHw04PsGYTXvEGH0A4KwM1f+tvGX8Igr0QNWiUdYMLdDuW3TRdExnLXA6i9qJmJYtjxUrM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5LuzzTb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5LuzzTb"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fe89fb333so542569f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787321192; x=1787925992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d7bviOHsEyw4FvUw51zgLynA5i0Xr3L8YzOxn7FOuxA=;
        b=G5LuzzTbnEKQonUZ1qxlXpOlnIrzPUIVBhcujt26CsSXGV4mLEb84GlPEtIBu4vj3+
         k3+XmeT+qbvoKusnV2wvhf07QfNdVfgRbG4rgP7eSKBV6vJxqwCy7tgwgbzLTOhCf+zZ
         lAo4Lxuhd1d3boRSKwfixGXcej5E2owM7Hq/dVC6brZ6KGIiX42hSnbtOxwKNAOwjMMr
         +Ivgd6bT4GBsD3Bb+EJFtriihsFZSLu52greSMZIOU61xqoMduFNUJplvCU2ApcIwCws
         S9SGYCXr9JdYtd5fvNlkvFjD9FpNPCYYngprscy/CitPb78l4kvJQB3vhcSUPNuZUOKX
         3wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321192; x=1787925992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d7bviOHsEyw4FvUw51zgLynA5i0Xr3L8YzOxn7FOuxA=;
        b=EdzOVs3CSVacufSD1UlroXNsnSlP0OzNhnmL+5ZwiU3teI6XEnHrGeSf+/MnKW1TiH
         0+Q0LU1ynETaMhEDKw+pUE/4uI5dGpYYZ5i8fyYSvLhyFe6V+BEafdT5xj7zvuttQJL1
         mOwang9RksFKfOGVZRBCgYxQEdZEWBij3q7WBSpmux8dtYS9lxm2b+CG7J9EIM+9V1fR
         VEUIgkBwpUe1MlAjSBa92yqABugwQTlvYL/yS2SEBGGLEGZOmF7l17o9X9SLX9w34pj1
         lcp+S30YWRnqA4DRA1NjRfOpXyFpF4QRyMnIKn2kMBzIz1UO5GWqMxIF0/lLKJsPL5l/
         UObw==
X-Forwarded-Encrypted: i=1; AHgh+RrFLxRTlkgsxLBCRjw1OTrSmS/6PWm2NYRbptr2xPBt6/KKBiCNjr8izgtPmBmFaLMxtvOoGEmvo18=@vger.kernel.org
X-Gm-Message-State: AFuF++kemiTU+OU65no4N8EMu/saq3XE1ANZVchVIxnW7irnqk4jiAyw
	5qAzNCLzPDUs2tvemGSvlehjC3p4N7EJsoEF1jPcSF8yz/B1DWfPMjJ1
X-Gm-Gg: AR+sD13U8pigK7mVM/Ixfm2qtf/g3pZZfFwIVGaCewwRxuXcmcTj5clvgmVuvNmVjKm
	TZjPMFtnOFidvGQo4dXLLRqvjk6TiioI599EuNGgd20psE7KwwbFTElPGH1UpbmOXCJ2ggu8KCz
	ax0HYsRQdv1DvPOr0F8Vb1NyH46VMjoeFCaMRfuPGUuU8ZOH5PN1M7UTZEiDQWDiXlLxxoYYCA5
	dPRyWYZufzKzEi7Urwl1wBMEJn2+Tz4yeBEAH1IQwp0sETydzlqHa7c+BVouQ1OuxQOMZe0Qvz/
	HDqXVJS1U146tN/uyOU8eMHipdjeQnlADgcwjIGZREuK0SPiWmPOk1C1HaMNHHEAZa08GBantM6
	WOsYr/xYUjRxZivOqdS4MU8TeApWnwYnYI1A6zyFrC20HSicwkWljIaQnMIyTE2pKTbk9bbtEto
	zkAUqrR2uqie8ZkDbhK8c1Ap8t335i1JaYCBcLkWtexiXlZNAUIyCFR3hiUQZ+Lv+dKEc5UKSsY
	tOVfVxVbWXBN7g6mipuN1JW1uPaXHjglMA=
X-Received: by 2002:a05:6000:41e5:b0:47f:7b75:9dfe with SMTP id ffacd0b85a97d-482c0b5bf92mr10755617f8f.8.1787321155770;
        Fri, 21 Aug 2026 07:05:55 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:9816:5963:8c6d:ec64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm15106964f8f.26.2026.08.21.07.05.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 07:05:55 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: gyro: convert to iio_push_to_buffers_with_ts()
Date: Fri, 21 Aug 2026 15:05:50 +0100
Message-ID: <20260821140553.80246-1-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the gyro drivers that still use the deprecated
iio_push_to_buffers_with_timestamp() to iio_push_to_buffers_with_ts(),
which takes and checks the destination buffer size.

Each pushes a struct with an aligned_s64 timestamp, so the change is
passing sizeof() of that buffer at the push site. No functional change.

Gabriel Rondon (3):
  iio: gyro: adxrs290: use iio_push_to_buffers_with_ts()
  iio: gyro: bmg160: use iio_push_to_buffers_with_ts()
  iio: gyro: itg3200: use iio_push_to_buffers_with_ts()

 drivers/iio/gyro/adxrs290.c       | 4 ++--
 drivers/iio/gyro/bmg160_core.c    | 4 ++--
 drivers/iio/gyro/itg3200_buffer.c | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.50.1 (Apple Git-155)

