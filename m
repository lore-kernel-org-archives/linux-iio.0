Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7039BFFA
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683352; cv=none; b=rdW/mRMFfn24i7+AyoO3RuhAw0GCHNBsTKM6MGmtnnbnhxrMI3jr2cq7hifqg7X2gk9ayvDfOqT+ajaTdHkEjUx6h8LiTDrN2LX/BO5ib/zT1VW12MaEPItgA7L3+O3xdIYCyUDqOv55AztNv3HCQ4eXCJvhcKR4Dg2f2zNBKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683352; c=relaxed/simple;
	bh=Y0QILhGhd0B8dtuTXJGSpz1BHey8Q1pRSKj2xvxBZ04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1/Lhi4W9Qsv8fug2eclJXp588G2OkJISBkXRJMHTgtrKlGguGCUaHmA0YkbCio1ugtS6gypgf2YUIeCh5SdBwgO+opFnBjTl1QCEAKQLj5N+GLGuw/XdEHkNBo+NjxCPs3u2HxI35na3YqyYrUZ53FVRqtiEZ40cgMSsL4778M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A14Fi8iG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A14Fi8iG"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba67b332bbaso180671066b.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776683345; x=1777288145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLU+XAKpTvO+4Iu/eH+x13G7bBNmZuBsJLFgBVP0E38=;
        b=A14Fi8iGU5bAMoZgoSFKSK1+m4sr77zMTfwyC3Mm6nEdduGQqJYYBvBt7qU6P5VDoq
         e5aJFSwm24cj/hwRF7FJIk2iPB/Zyo5SjUgKNCDMFTq1OevgxoPOlTrVioaltB1YtDKL
         LbpBoMUT1c8v7xBg8xw70VUONcnamcmw5lBosjJejpnoPpb0EpCC8+8sP79pYgu+gezj
         A8UX6/e9wfT+JC1FMVkd/RibScOzexlR8OOJOzVuL6BH8+WS50Nf7h6jcdFeZdgDWFT8
         KLX+SQY3BJC/5Ex1p5h5+LctxCEaWoHyeu1K+BcOVVcs6Qw9+0sRBicaen5H2dMag1JY
         +4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683345; x=1777288145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLU+XAKpTvO+4Iu/eH+x13G7bBNmZuBsJLFgBVP0E38=;
        b=lWt3XJQUVcuyczh1GPDdu2o9T0pp0ysrAe5gn/QTp9N5w1ewmF8R1kwbnyauNnP6l8
         7q5+u8En243mG4uohYtvhw0u5Lpkuva2qcO6M1FHOahOU9vVcMuoeOs/1v7XS2zgEnlQ
         4CzmgjvV5Yl6ziFywV4kIb3DPkPJNggNQjCpn3Ho4JPij4owayAcZp7Ypq8DS517l/UM
         bmGyJ2tbkMDL6lcXI+GiV47vlYI3nqC4CKq8GJCvlFBUQvq//5vnJ/f3OySxcktl9Z3u
         GoQtS/9PYu3eUKGVN082jpng59624/6AVzSamJsoSDYd8fZQgx2jsusBtUnH4nQ7VfHa
         rmLw==
X-Forwarded-Encrypted: i=1; AFNElJ/G29+ar40Atlhg40w6w93BXaOMJT8c3Is1IalSJjExfF2/0E22bcYhUwOlHgS9Hh5+OoMaAOHAkDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYxWSiKbw4T3wisTDs/jK3puayfGckcQiUaTM1yG33CsKSRoJ
	UC7KkWPuy2VL5aI/VjnTJib48GqwTL4BuRrFhL1FZgjxwrJ7ITiyKsZF
X-Gm-Gg: AeBDiesZLJJ1vKriXy6Zmbc3ZGOofZa0AWAZNaaamcdRSZ5PtyuRqcyvcNgCGGaPqMP
	zItD8QgcF1daB4SX1KAZrXg6aVMHOavRM3JvjPJrvBe8l+OPwvrPEg41p4L5K9ZgZxrb5gFT7xO
	+2bbof6IuvpAh+e0/qwQpMlGoFnWKknh1ZVweaGp2mBqYfiNKqDmF5idcyld2Qaz2l69Y1L/ajr
	WkLLjHq72OL+DKJBj2m7NpDgCxbpG0k0dmcbM+8VOEZgPD0Lhweahxk/n8g46IEx2iWyEI2bLzo
	u2gUVCs6r8psqrUE7xC/R/tAut0b1qX6OznvBVwNL2qyrJZdpmLLM5rkmxSk2JfFy951mL1ILY3
	OeiNcjb3yKunW4Ks2jZLtOQZ95yPm0r8K5Cg9pwJqcNpOgbnR6eQ2cA0B23x9kpzUXefXfk694R
	kmbJdc0n8P+7f41guEsk7IppZ33gaqiFelVigrgq2dVS2woo8+F0Zd7meP8lY3ck6MmdrTpWovN
	wJZ9T2m5Gq+bkuYeszhucBDTUK1miwTzdLlaz+3JtYSI4iUlN+EZnPmMCJ6jMmPZc6Or3RjA95m
	konSXVIiEO+2fAGWLKRiGuRofQukUSVMAihTRsG5S2i6AfUocA+QK5cCTaNN+oVDDkd1PR5aCoO
	Z9B/Y70B6x8f02T3CZKKs/fvLiU32DkjxigHLI2hzjNWJ6aWOMx1RHiFm7X6Ytei8gHHSjqPlZe
	RjK5ruzZ4=
X-Received: by 2002:a17:906:7947:b0:ba5:a3a0:4a60 with SMTP id a640c23a62f3a-ba5a3a05c87mr367260166b.1.1776683344902;
        Mon, 20 Apr 2026 04:09:04 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (254.196.90.34.bc.googleusercontent.com. [34.90.196.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe8a0sm1947664a12.5.2026.04.20.04.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:09:04 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/4] iio: magnetometer: ak8975: modernize and cleanup driver
Date: Mon, 20 Apr 2026 11:08:00 +0000
Message-ID: <20260420110804.1353-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes and cleans up the ak8975 driver, migrating to
more modern kernel APIs and cleaning up legacy code.

Changes include:
 - replacing usleep_range() with fsleep() for optimization
 - migrating to iopoll macros for better device polling
 - removing unused headers and adding new ones
 - checkpatch.pl fixes

Joshua Crofts (4):
  iio: magnetometer: ak8975: header cleanup
  iio: magnetometer: ak8975: replace usleep_range() with fsleep()
  iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
  iio: magnetometer: ak8975: modernize polling loops with iopoll()
    macros

 drivers/iio/magnetometer/ak8975.c | 77 ++++++++++++++++---------------
 1 file changed, 39 insertions(+), 38 deletions(-)

-- 
2.47.3

