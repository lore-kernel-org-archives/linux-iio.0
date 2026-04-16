Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54137BE84
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322314; cv=none; b=KtHInRPxLCTkhkhU6GIKjo8KFCX6mBPNM81BeVl7qAWocV3vqi4uyqgmn6hMGm8W+ANWlUGXAhvoYIAkO/dR+LoSo64tRsdUvGykJQ9RuKD4AzBuaTCdwKW709zYOHlaY51ng3mKpFkvT36q8+AH4tu5ONf6Ief+s5p9vZ+skbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322314; c=relaxed/simple;
	bh=TszllyWbbslHvIqbXKuSvcCJ8gOyWVJtop3miHR4uMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RNEmUZWUQ3S3H5DzS5lUNvsxTQgn7g5T0+3aerefbZI0S9zGRXd2rt9VP4SLkumRRMSnEsI1xN4q6JzMmwHLVNoHN9xc7jCRT3ucIiar6vX5xqpXbqcbYh5mHKH1BedZeziNeZJ1D33RPIQG2FIP7QWvq53lYegyCpnh9e3IrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPQstPGC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPQstPGC"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9e00649769so481080766b.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776322312; x=1776927112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTSCZfRBVTSuZG92UJniTjMaAJat6GyvrFNfwlqbqIE=;
        b=hPQstPGCyDoUyFPFrOOlG/GWEMs4ZQgorIyvjNI2BK27SNYuiP0bCknAe+AWagYtRP
         n0YI6dus8QQXZr6fla3iY1+iugj1V6IrZ8ktjbB/9Jtmei0sT8/I5mdfdLPvv+vKWw4O
         /HIJtssztz7Osc91wOb7jAaC31n6yW41+nbKOqnyNFNJbTvDzUbcpZyWRvvpgR+7oKfw
         tzaf1aJ9IuEM/uOc6cVWL7VWZ1ySAtPm5GYItVZXkSuJVY+tnhgzO8jTg99I37gc6xjx
         15BLXfdmoNVB10aXoJ/VPTj5MbDTDRjTpt8E8cwsmKAO9fZJHJry4AApWwdiXnoth0C+
         pmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322312; x=1776927112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTSCZfRBVTSuZG92UJniTjMaAJat6GyvrFNfwlqbqIE=;
        b=fDAJfvc/fNizlyJFTR1SAQjqI+KqtyRaZ8ba7faxrcKGHFSI54KvnWq+ab4VKfFe5a
         XpeiHDIybYjX+9TjHLi6JGRLQV0q9Omx6Ab+xUYc3IpVfczrwGT8ouEQmXSX0nNOJD1z
         SlPAlr98NCiFIjZn6agw8BA2+kGlvbEyi8VBnYHNgHHywFLyGgcRH6jXDw68j1EMqE6X
         eBjbGCkCLUxqyKckjkPs+rVp8N5oDOMYNnty4oq9Cva6ofjElRWtY7HCbosrFRzEw+su
         wvL4WKq5gGcrTHLon8YxTCWPPSGeIZNnTngMtvoOLUNfAxXhwiULHEvKTtld3myOnhvK
         ALcQ==
X-Forwarded-Encrypted: i=1; AFNElJ92nBAU6bge2RFup+5K6UXnkj+GnKhyuh9BAqzbPCjBUvVss/Cig4vgERQ/5IAJ9V3krQ3QzGug0YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnJ80+VHJx/S7YdAIPCG/3ddFcBeYiJuqu0lBtKVh3+c1+/AT
	sLGdYKTw2dtg5ycGyVWHMfihTmljSBbsepOS8OA+WOfSZQihsYe8GaBB
X-Gm-Gg: AeBDieu0F31lZkXL61Xjs0cunCQYyCNjkVYMg/pTZexGGafnNcW8gKtRYLoOx9/UwN8
	n8FDUrh7LXTHBwak6TJ1HE/Z+adReZDq1lCGhJ1ozPPZuEPz7Zb92tMWiWKdI51mAu0XYu0cGa9
	b2y1rlAPce+hN99sA5Pjg5qYjI0eT91yJHHfM2QKYYBwi6XGm9+blzu6ArPttZwD9ZNPymwyndY
	bOkZ9vTeNCsoHUZiXPHtgI0EvmKj/o4JCCeDOnwpwxxjhpeqyrGNIZYNv4WuGbiWbU1G7WlmU9a
	BoQdzNA9AGdKAxoJ6x2ntj+BpfufNv1CuLVFBcHYa+zbF5LgyScRfxmwpNEP8On8B8avDlTKEvm
	8fWCiM/sf98Kq7zVLXYxa7UwdQFy8toX+4P1luYJTTkGgG+5kFlHEzPPTbuIJvWtOrdJhjWD6/H
	9Rq9mOFm93J3w/sWARrrOQwMxA8NYKGcixN5jzq87LyyEYMTUKtI6k81Bg1OAP96KXuB68d5RWD
	3J0E059qpsxS2Ds2vVZdu5d1vyCRXa5rOOMZgTHIlAomIlk01W+DGEJZg3UkFDJOWpGnWYw7MDd
	bxTAZGOyWXs1oRroFafA/GuLdKZ/eDfo+Lb6Aj118DV6LyLwLb8u8GyJdJQ3fOzrsk+jbmVqJI9
	gaGhGF5/vbw9c3Qoy5nZCU9uRWAG9wCRRuCOg9zbj8XwEVEPRuQEOWuem3Ufi8O2V5Pd3IsaJsa
	XcSmv+q2g=
X-Received: by 2002:a17:906:518a:10b0:b9d:6d06:b78a with SMTP id a640c23a62f3a-b9d727934dcmr985985266b.17.1776322311268;
        Wed, 15 Apr 2026 23:51:51 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (119.230.32.34.bc.googleusercontent.com. [34.32.230.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17341a8e3sm132530066b.6.2026.04.15.23.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:51:50 -0700 (PDT)
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
Subject: [PATCH v5 0/2] iio: frequency: ad9832: cleanups
Date: Thu, 16 Apr 2026 06:51:16 +0000
Message-ID: <20260416065118.1299-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series cleans up issues in the AD9832 driver,
including proxy header removal and bit math
simplification.

v2:
 - PATCH 1: removed redundant bits.h include as it
   is implied in bitops.h
 - PATCH 2: changed ull to u64 type
v3:
 - PATCH 2: remove rogue vim typo
v4:
 - PATCH 1: removed slab.h based on IWYU
   recommendation, header reordering
v5:
 - PATCH 1: commit message stylistic changes

Joshua Crofts (2):
  iio: frequency: ad9832: remove kernel.h proxy header
  iio: frequency: ad9832: simplify bitwise math

 drivers/staging/iio/frequency/ad9832.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.47.3

