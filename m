Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E246AECF
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805590; cv=none; b=dt3sbPzMKgL3IwGe5rZ8f/efgK/jZJgtBkCBGBEyfdSDpFBl7upE/k4rgSywJsvUpBjjTx+tBU19758hTzQ9ykKY7GWf4svotIpN3CX8SsnnQeT9YzAeI7xpkzLZ3q4z23TQG9qpgKllTBtZRtPSwRI/XgoarikVuuzTMJPpQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805590; c=relaxed/simple;
	bh=+3QF/qLJ+eGfzFmJW1o528mBIogPPz96eo0+FniqcCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efN1LrN7HMHhh5Si4UzA/xhIfZ7o1VCywr2gzvz3e9+wUs2uWj/UxTJpHFwA6hrfg2BbSKhdBl7Dnl6/nxXEpElrtxf4QjX65LJUoYRPgUc/tuPGtEXHFemd76bT6+l1KDDKPFq2xlgfutlAkARPShvlvkGFif83RhBuJXIj/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4YXlrG+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4YXlrG+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6af9cc73235so1336184a12.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791805587; x=1792410387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M0WPcETHCmHpx54uZlEU6KywOxQOrIIbX1QyEesZpp0=;
        b=V4YXlrG+7l/s2D4XxoOYrljxdCkdKFmyW+hlF427M8DujkI+iCEAo77T0dDO9jAbjy
         tolnbrtvOuLGte6yN+j7XHKvkTgw+reJxU4jHuhvWAGQHl4o/5XpnVWNIWOE0nzwUfca
         Ns/qRCuK+psJd+/mLfvigM4dcbSPew/gtr7ZzrF9cQ8XaMkEIco8HubpBEcT7kx5sayh
         pezyWutyr6vBKoJl6F6K/iywaN0Ma0q9AJeHbDPc1TnFcgS2FJNmSxUiGpkoiIIPsN6r
         hn7cN3jiSmvBvRr/N0kjsLXBQ2G7hgiEOmav/d3ZWJS9a/OiDYSUMgqhASDRaxQsJp3A
         CZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805587; x=1792410387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M0WPcETHCmHpx54uZlEU6KywOxQOrIIbX1QyEesZpp0=;
        b=tgERmOzsL22iFQz9/wxL5on9+h7xZ1pTsam/A7HO1tqtUB0ZHW9p+pek5j38sWxZ6l
         EzO3r8/FQJwPxWLqxIgc+i/x283CSSE4TC3INbdTcCvY2e3koIpA9/umeiwkJ54zL1/H
         Dw8rV/GLVgn2/5hJK4jbuNMQgzd/bSio5ISNhXn9PW9uQeShiUX6Rh4PWO8VutyLQqkU
         bKKyUnHYfYVEiekP18k7ZxiRu2rRNptxFqxsBUl3DpgUdRz53TKatS+znLI5Zr/c+pIX
         DU/+EpF9a37Cs7RtRjjxLcIlgxaFgNaU4mldm2fSlsGQmWcjrdnLUR7fSdNpXo2iJce3
         QJog==
X-Forwarded-Encrypted: i=1; AKwUvBxapkz8cP3zMXmvfQRoQf4VWolLYCNBHX4uL9k1Chp7fN9AjsAWBjegFLvog57lKxedPwxrVPLoVSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqveP6KxVErf06UuHRB6n/tKdfL0Ahc+/EFYRByF4hmYj6GL7T
	OJvK6LRHaqLTEOkDnBjm7poTHm20e/yxgQMYkwaXXbNFZdnuHSAomZbw
X-Gm-Gg: AYBFou0nKgbny8dXKyWrL6xrhYHSM8y5K2ZpKAQMdjE48CfsGisWXo/KAWhtv+ctQYV
	SO52EwMyel68FfRVqKQNM8GGaOVQZxUWjoL1yeBuSpXQ1Qy4LNLgBFsNwgYuqfSQxLupZhidOCM
	hBQYezk7ny7EvImcHl19oa9oQOCTKqacU56yUuVfeSD8KXGKi+p1sJFSKoGWSTHjUHGHT9slvsT
	FjPLIo0RM0GS/QzoMUepnQ7kZXLBSJ/k+nF0KB2Vb4Fom5QmdYHUMlp3ifdIaGWAR9jk56edgGr
	MFfHkjB5jsANMThHY3M3Tm9c53lSWt2IRtqrOjlVh0IBjcC6CrCd58QLreCaaxqS/HKY21QLmtI
	ZXbD+JVK3cFgpE+mlldwChEb6LakV1/HJ/yKjC81o7nJuYQ9PJot9BDgFrkvOyEfQvjVF5bza6y
	NaqWY2k6VMZJPiN11PJVt108COq63UH46mBYtvDL09SX3jsJJl9tcClv7qhYTrPE5JjBVKgLbp1
	sr9MhwA6IOv3WW0LZr1WNc10HEFJL3uDvY6WBb5WruIi8CvYoGJ9gGF/WYbeVMSHTTxVj9ocC0s
	nermiMlpvzHMy+N30L3PTYSAaKoHaJhLZg==
X-Received: by 2002:a17:907:961a:b0:c31:7a83:bd78 with SMTP id a640c23a62f3a-c31a70d32bemr875942866b.27.1791805586880;
        Mon, 12 Oct 2026 04:46:26 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c34d011dfccsm118669266b.42.2026.10.12.04.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:46:26 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
X-Google-Original-From: Paulius Zaleckas <paulius.zaleckas@ui.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 0/4] iio: pressure: dps310: fix pressure overflow, add Zilltek ZTS8032
Date: Mon, 12 Oct 2026 14:45:46 +0300
Message-ID: <20261012114550.1680054-1-paulius.zaleckas@ui.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulius Zaleckas <paulius.zaleckas@gmail.com>

The Zilltek ZTS8032 is a register compatible DPS310 with two more
pressure calibration coefficients. Bringing it up showed that the DPS310
pressure compensation overflows s64 at most oversampling rates, so patch
1 fixes that first (Fixes: + stable); the rest adds the ZTS8032.

1: Evaluate the compensation polynomial in Q20 fixed point. The current
   p^3 * c30 / kP^3 sum overflows, losing the c30 term: about 20 Pa low
   near sea level at oversampling 2, 4, 8, 64 and 128.
2-3: Vendor prefix and the zilltek,zts8032 compatible.
4: Per-chip data for the coefficient count (c31, c40) and the TMP_CFG
   startup value, since TMP_CFG bit 7 is a rate bit on the ZTS8032.

Based on iio/togreg, on top of 4334dc4092c2 ("iio: pressure: dps310: fix
CFG_REG bit definitions"), without which oversampling 16 and above
returns -ERANGE.

Testing: ZTS8032 on an arm64 (MT7987) board, both fixes backported to
6.12. in_pressure_input matches the datasheet formula evaluated from the
raw and coefficient registers to within 1 Pa at every oversampling rate
from 1 to 128; the fixed point math was also checked against a floating
point model over 300-1200 hPa for all rates. Builds without warnings
with W=1 on x86_64 and i386, dt_binding_check passes. I have no DPS310,
so patch 1 is untested on one.

checkpatch --strict suggests BIT_ULL() for DPS310_Q_ONE; it stays a
signed 1LL << 20 because it multiplies signed raw values.

An LLM coding assistant (Claude Code) was used for this series: it
found the overflow while porting the ZTS8032 vendor driver, wrote the
code and changelogs, the floating point model and the hardware test
scripts, under my direction. I reviewed and tested the result.

Paulius Zaleckas (4):
  iio: pressure: dps310: fix overflow in the pressure compensation
  dt-bindings: vendor-prefixes: Add ZillTek Technology
  dt-bindings: iio: pressure: infineon,dps310: Add Zilltek ZTS8032
  iio: pressure: dps310: add Zilltek ZTS8032 support

 .../iio/pressure/infineon,dps310.yaml         |   4 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/pressure/Kconfig                  |   4 +-
 drivers/iio/pressure/dps310.c                 | 149 +++++++++++-------
 4 files changed, 99 insertions(+), 60 deletions(-)


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.55.0

