Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB642C51C
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925935; cv=none; b=B9hO0lsdpFhbIQLOJPxatL4vccSwD01jdkagSAXx8GUcQwWqPukPpbzsZaA4Fe1gcAbEcDdVf8jee6l4rMsmC/rYhcopx6Bhp25HkAECDMH81NjhH9oP69u1S5GEA8iYvRu3VAGCslB7PTn7bENMz1BmpeXRu/yju27RU/X+Iqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925935; c=relaxed/simple;
	bh=/kQ4fSekPPFinZeyqe+grEE9/hzLsUKUj00QBMn+5Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mB9nxrdsDnTHNpzSC77k3ZOojzZsJZHqIEagOM1NAgT2QWq/zJfo3YHKRbsapqifVeQJVbp2f/yJZ/7quojnwOYNobdhLL9thgbgiaCmKNSDEQbCrO6CbpzxJd+eezCXBm0TjqqXtC0nXy7bDncmqMZGUAMIDoPquCczKCxMaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwJ3Coi4; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwJ3Coi4"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a64d20990fso71413271fa.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925928; x=1791530728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sG65+SKn65DP6wBKULwQwiXjO7ctbm5y4pXnwFPOBMw=;
        b=SwJ3Coi4HLDPU452nuoEbmFp0a6k4TTqrTYldWSOefyJYJczOBYNLOFg0dEhNyLb0Z
         E2OoQez2VrRIf9ZcE2OiYI4QPXaL/gwklkGLQ01qQ8rFMzC4Zk7mTQo3dDcWV28EVS04
         vqSvZBiECtze4u+mLMnEfOt5v800aEJp31oiNlil/W4BnkWHT54ZAiQAHh8173BuE8MS
         3HZjmprcL+O7nqerlP7y3Dug1rsqlfrp7d0IuZjfDX6WSYm/tMwtS3u8bkVajlzyqcvr
         Sajc1tMiaLpWuCKO0uVOPCc5DF/DZNPXIm/Cqpm5DtFavMtDaKO5w53Ai+KOzT7s3VW7
         5oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925928; x=1791530728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sG65+SKn65DP6wBKULwQwiXjO7ctbm5y4pXnwFPOBMw=;
        b=qyMUdbseIdfzTT6mxVvHdz49tST1x6VGj9kS+3HYuPWiFHNF+XskrZXnnUm5L0VjRS
         q/DQKNOCLGybRM6OGSYhGtVcHSpGdEwQihzI+7qRre1wPszduUKD75tY6SRO8An6CVIw
         qEO1E2U1a4XXa1fNQKnK8XqMualpy1nDkrSCrBpuninvZ2IhgalQT5Bjawn4P+xBPeCt
         qwRusChfo/Jwrejp19gSh70ekva+W/pkveUVhwyffEhougWbjyTfqJuiMClZmg64M9Fk
         onwxVcr5ou+4posVb6ntM3q4pE+sV4xp1AC3TkkAsihn/BCDr2nM0MIB8ZLGrXo+Jiie
         dQhw==
X-Gm-Message-State: AFq9FYKzw3hn49bXg8DsuHD+BeQNTahdSWvdCx31yXAOtJyj41v//Z0y
	PxPzMR3n8mKNhg8JWc7vPv8y1UXWStk76KxGyBMupXu7H7euBkzV1P/R
X-Gm-Gg: AYBFou1ldpX59N+RlhpvTp9jiiMcsExdgopVK5jgCD9+kL2JpQq3TbtLEVENVGAKY0O
	RVW6P6yP441IRyEvaHHQHRO8NtjVMzW2HNnLz8FfHxOiGILcEbUMlz33dgQByA0nM49oJcRkfbd
	f7vCfbQvFq94HOaQbYkNP+ZCNLPdepD4ysP5mIArJuHDPf0B3XUJtsjgBnIaltaFDR4Rj7XwSIt
	m/ijDgJN/dXPZ0so47GnmJLAwI25r+4Jk7Vc2WPjkeOYuOhAM2+77MkBCBzX5v2Z8O/7ehwntn5
	Epd2DrH6tf7PBK9X8Nb6O1WumYl3QSnBVLrUbL1GEfOmXxaQtVza436IIqOuChG+0OEe4Wqe1PU
	f7864hQ5CEXBiOAY7eE1Txs77RCSlVA6N91P0pGVRLsu7tzh7uoAcR7/f2HNFpNhR2L/HUxl2Zp
	ypOF0AQAv0QCEU0LoIHaW5Hhm/NuHmM0td+iHngKp0d6OGiX5zOSKqpJNDQo4nDV5UFeEQ4z4QX
	hjm3rBgE84wl1JRoRzNq0cAYU3PGiezcaqJRJNTPZhG0QeG2bbTUohXTGAMjooOy+7CHifXPAhb
	Lf5g5Q==
X-Received: by 2002:a2e:a9a1:0:b0:3a9:2e08:c76f with SMTP id 38308e7fff4ca-3a92e08cabcmr2410271fa.22.1790925927480;
        Fri, 02 Oct 2026 00:25:27 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e324350sm6724731fa.36.2026.10.02.00.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:25:27 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v11 0/5] iio: pressure: dps310: hardware FIFO support
Date: Fri,  2 Oct 2026 10:25:21 +0300
Message-ID: <20261002072526.250081-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rest of FIFO series, on iio/togreg which has 1-6 and 10 of v8.

Since v10:
 - patch 1, new: devm_mutex_init()
 - patch 2: devm_delayed_work_autocancel(), modes reordered, unused
   units.h dropped
 - patch 3: drain_interval_ms local
 - patch 5: Suggested-by dropped, patch is optional

Pressure overflow fix is now at v3:
https://lore.kernel.org/linux-iio/20261001121616.109973-1-zoone.rupert@gmail.com/
Patches 1 and 5 conflict trivially with it. I can rebase on whichever
goes in first.

Retested on DPS310 with BeagleBone Black, now also unbind during
capture. Lockdep run under QEMU.

v10: https://lore.kernel.org/linux-iio/20260930100158.957977-1-zoone.rupert@gmail.com/

Rupesh Majhi (5):
  iio: pressure: dps310: use devm_mutex_init()
  iio: pressure: dps310: read buffered samples from the hardware FIFO
  iio: pressure: dps310: derive the drain interval from the watermark
  iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
  iio: pressure: dps310: assert the lock at runtime too

 drivers/iio/pressure/dps310.c | 447 +++++++++++++++++++++++++++++++++-
 1 file changed, 436 insertions(+), 11 deletions(-)


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.43.0

