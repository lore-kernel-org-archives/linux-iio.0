Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54883357CE9
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019871; cv=none; b=X5sGXM0WKC3+A2t+MRa52clqbeQzwoGC7RD4SkM9zkbd0MbGnKlQFzdjL5pFi2BkNeLt58vZ9750xJd3waXkCLHBE78hgMiMcVKfATA/mff/ioPuJC4SlD1HcRnkCDC0TRA8VsmQQ/kqRtMhUHaIzoL+exereYPsv/jBS8+JgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019871; c=relaxed/simple;
	bh=qvmCBYSL3eRozWWoFw9uAUicrqWC8cgTbAY6q+Jw/i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocFDHQlEMS05QQ2DbJtnl2YUkHDXlvgam3NGiMCfCvN0mKHEEQVQD6euXAYOhtSaHa1Oqozyz0sjNk/alRZl2NgVxzm2YEUxgDEh2LIX6P6CB02Kt1/krQm6WpDer85TFfuu99MMoJ3BcQXAbE5JCgKzeGyyRflMbH8iepyJ8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtLjLHwz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtLjLHwz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b7612475so18820905e9.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783019868; x=1783624668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ono137WuuYaDIY/ZGTdWsaSipbM1LFMnFpwwFqmnrpA=;
        b=FtLjLHwz9ump+jdHn2WtfMazPB3R3FNya9qlX5ilfmezpaZaMdfMlgWXi+tcD+vDXN
         mbQp8gFzcdwqTW1XyNHuFHOr/5cfcYvEfFn+4RXACXTyjVmrOnmRcJrN1m0FFcLBHEIg
         Iqrl2ZyyoNB/EdR+EHKdtsiSmH4K3UwrxAePcDvYJHWx9d38zLp1Eqcfz0aOAZUDhNXC
         YThUxM5pL3vBVrJsBOcI6odff+7x7rSg3XhJXnYzc3v2fOf8g6yOPnc/R7IeaTAGofF4
         r46Av+dWbMosZPWYfGmqJsKpHe67gHVyNQHo8SyrN6NbEhFDJBaIX5w9PpUyhgnZohU1
         PqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783019868; x=1783624668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ono137WuuYaDIY/ZGTdWsaSipbM1LFMnFpwwFqmnrpA=;
        b=s5M0mf+GwmF2v+Agw4Ottc7vrhmLyJ2RxotgR9TvJGrhH72I1O+QD5aa9h04pqUred
         ukPCYi7cBVumbf6gOsl5m0j6oAB7HEUsGYN/IfkxXAswhOeLDH24kZ1+o0OYu/weR7Hl
         x4f6JMJI3H67/1hzcFRUnb0BW8iAzTJnOcPQ0836Y7MIeYE2aGLuGpd87naPH4SsmmCP
         +j8X3cgg8rC+o9APGNCgRtx0UxN+aCRiU482mrr927P9EQ24vyVl2/gBTMfl+d14lDwb
         Jhz4kENni3w2vOANLeT7aI1TvK8jLTSofOwMfBi6qHDxURCUHcGOdDPCGOZf6voSwndE
         znvQ==
X-Gm-Message-State: AOJu0Yw+Zw8iHVa7n8oRbauyY2ALn7dFA42v31ucY5gJxefnNM1UHoL3
	nS/BvJv/xgYdOmdLp+u4N970h93L9byaS9TgHE8iL/L27DPPed4KXRLg
X-Gm-Gg: AfdE7cmLPOakZ3UWgD6sOSt0qn9ntEfEpQt+MRcoKL2BW+7n4SHqLoMnvBjJF2PRoR2
	BVH3BwiMV96/0ClHD3hW6qiCgbCmKRwO8Pobotkj6Or0WGQA56oV0yLFKQ7dLVuw2TEksvVKukX
	/H9Vc4Q5S0DP+MzjzZDH9BicCXqeWO+Fe8mJ16fr2OQ1IiGfoEKfGHypTEUNyl4XacyVfvYCL3k
	4UwI1yf1kNe9jdAjaXPO9c3jK5cQVSbHtp7NO3qJq3HCs20JwupPA96ZaGKHbiD1GAAEov4KpV6
	syYjMC1GkVwtajeyW+ib8etjSUdEXf7t3Z2376oLNwL25r5Vy9v838hl2Mnb0ul2tf+MMbKjSSO
	0LT2tTJh52q/MdNMB32QfaBboJGV9tBxKGLUVQ2FS73mX4iSAyRukaxMtfJE0ZCHVeJHq5Ws4st
	KQipYqka5SK9znVjEwCJM54+ktoKdurlboCColUBZAlXLPuDPsm7o+ad5tYjca40ZgPgw=
X-Received: by 2002:a05:600c:3e0d:b0:492:3e66:6c84 with SMTP id 5b1f17b1804b1-493c2b99b63mr105888895e9.30.1783019868354;
        Thu, 02 Jul 2026 12:17:48 -0700 (PDT)
Received: from arch.lan ([91.230.98.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6368f89sm64678805e9.8.2026.07.02.12.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 12:17:47 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] iio: chemical: sps30, scd30
Date: Thu,  2 Jul 2026 21:17:40 +0200
Message-ID: <20260702191744.118898-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces old email addresses with a current one to
make sure changes show up in my mailbox.

v3:
- move mailpatch changes to separate file
- update binding file
- Added Reviewed-by tag from Andy
- Added Ack-by tag from Maxwell
v2:
- add missing mailmap entry

Tomasz Duszynski (4):
  mailmap: add email mapping
  iio: chemical: sps30: update email
  iio: chemical: scd30: update email
  dt-bindings: iio: scd30: update maintainers field

 .mailmap                                                      | 1 +
 .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml     | 1 +
 MAINTAINERS                                                   | 1 +
 drivers/iio/chemical/scd30_core.c                             | 4 ++--
 drivers/iio/chemical/scd30_i2c.c                              | 4 ++--
 drivers/iio/chemical/scd30_serial.c                           | 4 ++--
 drivers/iio/chemical/sps30_i2c.c                              | 4 ++--
 drivers/iio/chemical/sps30_serial.c                           | 4 ++--
 8 files changed, 13 insertions(+), 10 deletions(-)

--
2.55.0

