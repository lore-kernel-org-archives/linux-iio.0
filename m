Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C39396561
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210823; cv=none; b=PyJf4ebUn3mU/ZqJNLgsNFlZYXDVvBdp5da+FgaMXEaxRjnhrSitajYxgmZK5z+TD7cArRSHd1g0qSTRuRN0BWoAagPwRKkh7+JOpj9G/JEiCBw0xhamlT7kmGYFtn+xuXg6rC2uPDkB0dNvuSw2QWE8fnjJGjofRjCph0vFf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210823; c=relaxed/simple;
	bh=Z5IJ+lQnSXa1szk5H4U87H6lIowyP1aqRrakzryANK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sj5nuEqeQTg7Ob2bkQT13A9HAG2DWMQaV5KpB3YeZnOsGFqGyyRJ9ddg3yxG9EhQj2d5q/D0o19pj131DHHe2jgRp1CohZhKcevbvq6lWvQCx1dR/FeqgsorG2gA1myqeaN3UmzWxZn1nNAIos9S8dC61KDQDYOQ08S94ib8moQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtz6c/7p; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtz6c/7p"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso45894795e9.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210820; x=1788815620; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gKvEXBGRiYBVT7Q5MM6yjWoGfKDCD90j6xOw04lbaKQ=;
        b=Mtz6c/7pwqBZ1hkxAJlHbEzkA+oVZbvgqCXh2UrcUnXk+dX3ZU1AhgxX7cHHk4Xi5w
         zvwYufZmAI90FyiKzATuPr+7H8Wvk8Mp/2TKEgb0RlJ+NDw7ogf+O9GFV8InCErcHhFi
         bTMweEHEAqREZdo7CxT8PmMHk8oEulk4lwXxOm6PnAeWFNf0kmk608iUQ0WR/sVaH98b
         f3CbDdut+k0IfJMPbbg7Oaji8yCakv22JvEffCnVwbD5e96smcQ/Zvtrdc8HLMR4yIu8
         wgygAoD7bhUsSXq6hVc36tmH09RfPsJHawESGVcngKRn8XxuI8WkhUpa1s1/u+mFfzVY
         Xo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210820; x=1788815620;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gKvEXBGRiYBVT7Q5MM6yjWoGfKDCD90j6xOw04lbaKQ=;
        b=WXnpKfF7W1kOYa/A51hZD0R6vz+QSFbWvdxH0yMj5Nig03GCYoWFhZtxFZOGMgsIBe
         qqkXj8DxBlQuwvOtgH+5iRfvHR7lN5wLFfQSy5sZHNBLZHN3sgT86+nHIHN7cvixqpPl
         esnQnEo6PZQphAWWNZ/V5x4liG2xSaRnVCkcKtbbCO6CuZf0GKPBKN3kNvPw9D5SXJYV
         JlSRvuEQIsNvW6/fqEQ+FobRtdxCEjwnP8IkZwr8RzJOLM3I3Fr9WHnF30BjZ4kMpjAV
         vQnhrPZilmBDVeBjuYDQYapmhCwoY03xQWRXuIG04voRYn5VQRcEhoutDi9Wbr/t4MSK
         VLFQ==
X-Gm-Message-State: AFuF++mcNIZ0KWtK+cqP64wgkjJdgw0cURLHHr5d3oSGSboDY75vq8Jd
	BsZPf7zYYnFqcByv1X0uAjQxfxxax5ySQyk0qMrEr+cGIW85FJ0wAHD+
X-Gm-Gg: AR+sD13Gc+0zuiEDnZLp4NigUXAfJUKTpMwOVNw6vrbM1gvS3kR7VvJZWQ1XDP6tptx
	SqZOZe/mych0jdj3s5BlHfX2+/UzJZSFktofo39DnlZtJHmlWhDEnvZcaEXHOi27ojydR8NcNBC
	JihLP4FV/RkydVlH5A5ud8fVQmfnDaD+i/n+MMIsbYclmTA5xjtmGXbZdvVdw4cS2fdI4OZHTbH
	FeVZd0jt7NbDkYGKI+TyddXmNbHcNiEZ6K7aUShs+IjjeSxS43r3nC28lOfDR7ZOuOFaD3TY078
	h0gO6IKLWO+f9w8o9u3SnNszXDKIfUR7eDT9fohfJKk2ucbVHuFlRSxn6DxpMqD8F5r5jrqWyxj
	5quMk3j1VEVuRUAmhc7duiVyY9KFdmpHS/ByOzMJuIXSpUPxcVHqos01vtxBd3JlyWWRzALXWXX
	sQKQqUC9dXrPqecv3cYEwRNnek0wO3EGjrUBIBcHq0P3Hmp1sNHDosQ/9p9mjrhbV+Wy9Fmn7PT
	zdBAY+pbUby5aX9yZQ1ORgwCFfm8JSkJ+HCGK2gHVuZRUJ3IYL+y2OMl2J/rganQgj/fB7Lt7dH
	2xaCa/WSZUs3IEaWgL7RP7ZTVb0O+JQtTxHYJTWPVIxCZ7ZFrkvIG5PU2kbCIdQ6YoGp1ZhB8gK
	ebgYerwQcAI9MApow1BuNBiJu
X-Received: by 2002:a05:600c:1549:b0:49c:d618:e341 with SMTP id 5b1f17b1804b1-49cd618e6d9mr147510355e9.14.1788210819624;
        Mon, 31 Aug 2026 14:13:39 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:39 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 00/11] iio: temperature: make headers conform to IWYU
Date: Mon, 31 Aug 2026 23:13:30 +0200
Message-Id: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jFMfQCu/A/DotABJgI1U9NoC
 P9uJXHp8pzknrtAYBUOcMkWUI4SxM8JzC6DdrBzzyguMZjcnPPSEN5ZZx5xYOtYUXny0Y7oqhN
 3jqrCFSWk7UO5k9fWvdWJBwlPr+/tJtLX/ormTzES5sh8oIbMsWGiaz9ZGfetn6Be1/UDlXWqO
 roAAAA=
X-Change-ID: 20260821-kernel-header-removal-d95efd197d78
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210818; l=2118;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Z5IJ+lQnSXa1szk5H4U87H6lIowyP1aqRrakzryANK4=;
 b=TDyZTMysY1NiMwz8tMuUwzMJ5ODMyt3/iG/ZRtl/7LHpGWWbkyEpy2BACjT1YmL0DPBQD+7NE
 e8zKn7BcUOsBc+tjXPfMlBxfWzyDBzEPnzqM/cqbmLtPrTy7IHzYbak
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series removes any instances of kernel.h in the temperature/
subdirectory and cleans up the headers in order to improve readability
and enforce IYWU instead of relying on transitive dependencies during
the build process.

I had Gemini generate a summary (a bit more verbose) of changed headers
under the --- in each IWYU patch to improve the review process.

This is part of an ongoing effort to remove kernel.h entirely from IIO.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- Add missing headers pointed out by Sashiko.
- Swap <asm/div64.h> for <linux/math64.h> (Jonathan, Andy).
- Squash small reordering patches with iwyu changes.
- Link to v1: https://lore.kernel.org/r/20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com

---
Joshua Crofts (11):
      iio: temperature: iqs620at-temp: make headers conform to IWYU
      iio: temperature: ltc2983: reorder headers
      iio: temperature: ltc2983: make headers conform to IWYU
      iio: temperature: mlx90632: make headers conform to IWYU
      iio: temperature: mlx90635: make headers conform to IWYU
      iio: temperature: tmp117: sort headers alphabetically
      iio: temperature: tmp117: make headers conform to IWYU
      iio: temperature: tsys01: reorder headers
      iio: temperature: tsys01: make headers conform to IWYU
      iio: temperature: tsys02d: reorder headers
      iio: temperature: tsys02d: make headers conform to IWYU

 drivers/iio/temperature/iqs620at-temp.c |  9 +++++++--
 drivers/iio/temperature/ltc2983.c       | 19 +++++++++++++++----
 drivers/iio/temperature/mlx90632.c      | 10 +++++++---
 drivers/iio/temperature/mlx90635.c      | 11 +++++++----
 drivers/iio/temperature/tmp117.c        |  9 +++++----
 drivers/iio/temperature/tsys01.c        | 17 +++++++++++------
 drivers/iio/temperature/tsys02d.c       | 12 +++++++++---
 7 files changed, 61 insertions(+), 26 deletions(-)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260821-kernel-header-removal-d95efd197d78

Best regards,
-- 
Kind regards,
Joshua Crofts

