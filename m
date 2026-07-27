Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693653546CB
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177111; cv=none; b=kHd99epv0QNmwh/pMz2si713FJUL0DYh4vMmoJNBbXX8cwdLnhS2ljq7UuextL54KkDc1qyRRt68jQuKRjJlbGi+F2e+68WbKCXBLxaf4sC6PFhc5Q5jBvxuVBzfvuZ9NGIRt6r1MYkI2PpI76KBCXq2hYTi/zbkVxEDZ9DcF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177111; c=relaxed/simple;
	bh=XcLu/pnyI5tANXTm5SFHad+zcyS/kPl/xXh7gOq7SU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JPp2RdwhQyoBQ6VIi00XQIISI12h11L9ysfr1c33BXljnzFBUJ0/tMtGNqxjS/rcpGoznzsX+oA7kG3fxc+dTZldMdX7wwoEYI05SwfFeNhRO38x8rcQ2FItGTI/lAj53TtReOCu6MsN6WmhNXifqX2Jd7uU9H28UHsEdhv3vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERuDPbRI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERuDPbRI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49548e01d02so15386255e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785177107; x=1785781907; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OgA/08mBhQoOORx8DgJpJSYoUaMJULrVPsxZxzMgDI8=;
        b=ERuDPbRIqNSaOOjXP7/F8IN3ek/mAKixU4QknXb8H8IgnGFqTGeXP0iC2xB6Qze2Nw
         V4jUnQQJojkTjzIHq148dsXFREatImg4bg7gMHcQUVjbPZFhvKXRiJ9Pb6utdmi3LF4v
         Iezx5BSNnAiuZTJr3DvnSkyKtziXoXgsnXZ9nLbvY4qmT5+3huoTllMk1mCOOCQxSSSw
         noXnCGOpblvI0eHuC5F/owO8TESSQpjq213ynL1/KDy/rbZ6N9uaHhmaxGC/nZibV0Xl
         sszxr5/lAeZS55PdrzGAxEvogsnTMES6TyfU2jQuiqpEKKmyo3ci/CY8AT3sLTu1tP60
         W8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785177107; x=1785781907;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OgA/08mBhQoOORx8DgJpJSYoUaMJULrVPsxZxzMgDI8=;
        b=frWE3aMxNxr8jmDE9h05YiIJJZ2C87MyGnBjkw+5A1MNtyAwMMSYDTRMCHZR1T8zsz
         ACiKOGlA1heQ466MHmo/i59HAmkks0nDWeSaQawcf3yWPdzuXsokQp6DP6KHWr4SFig2
         mBc/szU/eaXll46IfE45ODQvNTn7AYyT8JXbAVIthGip6WmOevLC0ZV/nJLHwaGc3uBF
         +l+9dtlIYNKLZoB8e0XA96uUngJzVHOgSASrP6kVrsK6mUVtf8LgnODrwx3m7qLDC1U3
         G3wXPnYAARU8stQwX+qb4Mq1AGaug00yUjgFfSm42SZg+q0pN9we4OANJjjB5nEiW93A
         mp0w==
X-Gm-Message-State: AOJu0Yx3Q55UyjCHkhWAMYQC3AsgpxPM/7QwmO6uij3SRJ7fGgWSxXGo
	yWeJe0wYw6RO+17aSsf11u1YyLWhKPPQFR1G3SPdKB6NzuFcrWXpQtd0
X-Gm-Gg: AR+sD10KfSvS8HhH1tmNaKi5hJYZr5qWbIX37suA0XO0D4tJnqOpuTHL+en2tq2UotL
	hiriNRLOhus1XwHiisqgXGTlI2/75U5pR7OsdD6eeqOY5V3bhCVFVEox36nEo3T5Z80/alHL31y
	/92ieBPKgYeS1SDtPEuJJ1+IKhUvWByqoAMbBco8c+cZoufPR+S7okkgjbdV41NKqDJWd0fih+n
	7ku13/Fw2gg/hgC0aD1LGHrxtYurcrMDDoeQF5/sk4bGcwQi5hRmPaEHsOAWZkOtVzJ3TDp4iZZ
	FTaU9cYrzesvmtmYMNg+OtESGejlXNCt+A0Ua6Orm5mNEY+giUcpYaBDH24UWbFqPsfmd+zbCf7
	dRggIXIDGvYfeK3AToLVBhyIWSazIlzMpRN+pZM1fF+RzeBnScFLeNm7cCgYMz6ygFeMHVuLKYo
	nSKDJin/0gtZ7BGM1NHeCkGdVsuKTPStptCqm4H3djJU18zolhRTw5ucuKlH7oM5Bg3eQXT3gIQ
	WIjN24ud9FWqyzOaA3DmS7wEB5ENH8S2KmdryYOJkXiVRqGk/hjpw7+MO4yvHS374fXHGmI9BPW
	hzGdj9DiGyegUyqehtj2Zbe5qLdoBd6yMwRGLAVtq2ptNZ7XPFqzy1hIZTWMoi+tnsr2yt1Lc8y
	3BDkr9p3j3jAM9Qw=
X-Received: by 2002:a05:600c:3113:b0:495:39aa:1359 with SMTP id 5b1f17b1804b1-496b570fb1bmr109057365e9.3.1785177106190;
        Mon, 27 Jul 2026 11:31:46 -0700 (PDT)
Received: from [192.168.1.187] (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44b84edsm17800535e9.5.2026.07.27.11.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:31:45 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 0/2] iio: dac: mcp47a1: add support for new device
Date: Mon, 27 Jul 2026 20:31:23 +0200
Message-Id: <20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywrCMBBFf6XM2pFM+hJX/od0MTRpO2CbkNSgl
 P67sbh0eQ7cczeINoiNcC02CDZJFLdk0KcC+omX0aKYzKCVblRLhHPvq5YJ2RiMT+9dWLHkgXR
 1GajkGvLSBzvI66jeu8yTxNWF93GS6Gt/Pf2/lwgVGlZVzbpuWlvexpnlce7dDN2+7x+gpQozt
 gAAAA==
X-Change-ID: 20260711-mcp47a1-add-support-3af1248f13a5
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785177105; l=2028;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=XcLu/pnyI5tANXTm5SFHad+zcyS/kPl/xXh7gOq7SU8=;
 b=d0zcvUdDEcgYPMvpvWack5mjo2zmYNiUr3kRUoW1qaTf+FSZJmLomIRC4nBgzDLmvHWywPYXE
 GrXjqP4161jB2qEV7jdorMuAMqUUNQhkpgtq/AKvYlWaY6DtgcW3t42
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This patch series adds support for the MCP47A1 DAC.

The Microchip MCP47A1 is a volatile 6-bit Digital-to-Analog converter
which communicates via I2C. It is a low-power, low-cost DAC commonly
used in embedded systems.

Reasons for adding a new driver:
- Existing Microchip DACs use a more complicated set of commands
  whereas the MCP47A1 communicates via SMBus using only one command.
- The closest Microchip DAC already in the tree - the MCP4725 - uses
  an EEPROM while the MCP47A1 is volatile, meaning that altering
  the driver of the former would worsen the code flow.
- The MCP47A1 maps cleanly to a standard regmap.

The driver was tested on a Raspberry Pi 4 using a breakout board with
the MCP47A1.

The datasheet can be viewed here:
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- dt-bindings: add slave address enum to dt-binding
- dt-bindings: remove unnecessary example
- move driver from regmap to i2c_smbus_* functions to reduce overhead
- remove read test on probe as it's too unstable
- add 20us delay on startup
- style changes
- remove excess mailing list entry from MAINTAINERS
- Link to v1: https://lore.kernel.org/r/20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com

---
Joshua Crofts (2):
      dt-bindings: iio: dac: add support for mcp47a1
      iio: dac: mcp47a1: add support for new device

 .../bindings/iio/dac/microchip,mcp47a1.yaml        |  50 ++++++
 MAINTAINERS                                        |   6 +
 drivers/iio/dac/Kconfig                            |  10 ++
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/mcp47a1.c                          | 169 +++++++++++++++++++++
 5 files changed, 236 insertions(+)
---
base-commit: 0506462caaecb179708657142575823177c83783
change-id: 20260711-mcp47a1-add-support-3af1248f13a5

Best regards,
-- 
Kind regards,
Joshua Crofts

