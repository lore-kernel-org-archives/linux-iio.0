Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445685208BE
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685776; cv=none; b=e6xlYaUpBod8pZnYjvOodPhN8nBs8CuV/d8EZMMSMuw3ZQo4gbxMNCm4N1/qkoYaUYK1B91vJHoLg7+FENch/WaiHcqFRvsnPFLz9qzxpbjg1GZQsxGcEXUq+KoWS8DKYBS/7MuRZRyh+IwpDw7QoTJZCJfyA4XujI7tpXT0To0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685776; c=relaxed/simple;
	bh=mOxRtsH1JPL9owXn0qNOVeNblRDMKMjv/lQqgZ1o4Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OC1Osz/H1Ae/6mZJfd1+08kztj2VDEZw6EUFbjP7CKgwgJ/IqBesEmmdTz7HlIP66iJQ+uAHpvkm7JgZGSGJNE+00gG+GIIWotU2CPM3L15diaqYoGIdTVWRwovmVl01wsWLRd1ZhE4Zl2lm4wH+QMOed2O3RmrvP+Z2+dti6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXmuXhJm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXmuXhJm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso5965725e9.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790685772; x=1791290572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrtHWB1jWF11iA4PyaL+aKgI4wfwu9cWtf1zbD3RIvY=;
        b=iXmuXhJmsqKyFQ0XvUheRdbmdvjHox9lcZyyT73qwOydBajUaXgrJqvumfLIlMT7mJ
         IEs5x/AhYwkAhsIeFmVSX0P4Wdso791EHKMG14P1HRzEbEMRVIy082O3NL94Sg4OhdAk
         WzVyx9Aa/TJ1c5yEAbaZLCoyXs0YTKSZa5tO6Qom7pSJqBkb9VV3JshtNUXNhJxBD+Q4
         ol4nBUrtAFBnjLWGAX2k0CBerSA4mE6LLB/poDIxcRMCFL0eU7EBjnlHqwhxh2R4+bmv
         IgLpOXSNkM8I8Jm/oJgThudS8CD5rkv3KkMus2o6JdZP+BBxSL1ERB1Yl3KxPcwt+UzG
         LYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790685772; x=1791290572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrtHWB1jWF11iA4PyaL+aKgI4wfwu9cWtf1zbD3RIvY=;
        b=SlHn0jp6Y85t2+Wov79KgzWjIizZPb4gOQ6LocV0KOH/vP4sfen99P9VQDCK7+qwOn
         uVy2c5+qc0v524mqCzQkG5+tEtU7yvOHvwiq76CAzdaj5XsFZHJ6BvpkbBUeTOBpKIPj
         EYu1PmufB/aJHatvDD0KrZ0jvidAUsFsTW/qRh53ygjI1+uKTcyObCBiJ08smjijY0Pu
         E8GesQdkYPjYJK9xbI2kklfB4d9buqEOaWzrtCnAT2i/hhVIe8d9VS6+1jyItnV5J1dA
         Z16KI/LqY/YLlgcGdMaFyvhSc1OQhKZEdh4C7ufV5scg59vbJbtj7O0l7gtVJ+xcvPDU
         W+AQ==
X-Forwarded-Encrypted: i=1; AKwUvBybfH0IBAvGt3rVDLCo6fgEuf3pS1mB61ks4HJdXg5bIF79WePsHBrh6dSjsavCNtz8GRC4ZqFPlFA=@vger.kernel.org
X-Gm-Message-State: AFuF++l5HncvNEstJH7Kb0KypPiMUNXZ11VQPBxBV2+RqORUvIyilqVV
	oyteSiKZ2hGVImfH3p1qnDGg/jyrGaiACEN5cKSM9ZL8cC2iqf4+ZWsd
X-Gm-Gg: AYBFou2uRQhkYc7oBNAWDePWeD+1WNjxHiRfOxXIgIKWUq/au9Wu2JbC+dG34xyeWox
	kzZCW/2XLg2uRp1lsFur3InjmNdkHXS7QC+Kkfnd+ZFu2RWoWnCPt/SZOEj/R/QHgSMarJNUdEq
	71QxAo7+5BWhLtsdswTw5Y1wj/My+MCIMYzEeLFdkXoQQ612LDGmBkb6znaBh5zatHkc2qDMQPW
	P4NU76Y+hlUB7tS0ZVg+FQTEBbW56Oa9pEVnf6DOdzPWB1iWLgwUzkGKbG5+9jqzlPO8FY/9qma
	v88XOkVcWA8fL1mDs/HE/crvM60jDftLmsfDDGoEi/TM0+OTLHrvisdL7z1ReuthNws3WJd5DxU
	N1tmFDwkRBU9ER318UwuOZA64oYnB9yqAuZ70vFJ9RuN22Wy+DdEBDLvxSIB2YXlsQhrpr2SzQR
	QsSGRFoUBUBfOm76W648P7Z1Mo/iJL9nTgSBVyJJ8wa8WwlYN54qOyOTK0VWjz50gK7yE92Xnek
	3CDFCdw0H4+M0wgTH9CHpPcOf6x2EOHOBMcQUhmMTPcdV+lTjVIn8t0n7oziAmFEtEFb879uY5/
	AbyAxiiOrrvuMxS22Q==
X-Received: by 2002:a05:600d:6454:20b0:49f:fe89:efca with SMTP id 5b1f17b1804b1-4a00d7b6dcbmr33387045e9.19.1790685772306;
        Tue, 29 Sep 2026 05:42:52 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502da06sm4436630f8f.11.2026.09.29.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:42:51 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/8] Add ADC support for RZ/V2H(P) and RZ/V2N SoCs
Date: Tue, 29 Sep 2026 13:42:40 +0100
Message-ID: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series aims to add ADC support for the RZ/V2H(P) and RZ/V2N
SoCs. The ADC IP on these SoCs is similar to the one found on the RZ/T2H
SoC but varies slightly in terms of available channels and configuration
options.

Cheers,
Prabhakar

Lad Prabhakar (8):
  dt-bindings: iio: adc: renesas,r9a09g077-adc: Add RZ/V2H(P) and RZ/V2N
    support
  iio: adc: rzt2h: Wait for the analog part to stop after a forced stop
  iio: adc: rzt2h: Add chip-specific configuration
  iio: adc: rzt2h: Add optional reset support
  iio: adc: rzt2h: Prepare for SoCs without sample state registers
  iio: adc: rzt2h: Prepare for SoCs with different ADC info
  iio: adc: rzt2h: Use scan type for ADC scale
  iio: adc: rzt2h: Add support for RZ/V2H(P) SoC

 .../iio/adc/renesas,r9a09g077-adc.yaml        |  38 ++-
 drivers/iio/adc/Kconfig                       |   3 +-
 drivers/iio/adc/rzt2h_adc.c                   | 321 ++++++++++++++++--
 3 files changed, 335 insertions(+), 27 deletions(-)

-- 
2.55.0

