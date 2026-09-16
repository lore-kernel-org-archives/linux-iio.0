Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32581A6807
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538491; cv=none; b=M5Pw7sKWpphv8vlqrUItH5HvvLOxaIhatDO9qD7F00t+K23KxvrrlStfVKLCwB+5ro4TXuyF+U0yBzeYqfuhvoGtOAlsBYUVErOvvjoDg43o20ai++/bejijNz0nD8uyaQqv0T3ZSYgJ5TRo8qzx0vkSwOkiHaiGsXe/RiLBZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538491; c=relaxed/simple;
	bh=gIqEnxwVe50DvXv4oPtzSIzI3qcg/sTGXOy20OZ3DGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXeJW5gF9RdfcnxftpGLTMlOoZ2u2TWC6ltG6XVQUHdHuAcOZMTqJidKBie7ewCebhD8d+LO/S4lFLElyoQteuUiB0xXZjW+vRDe19uO2dvpa2LK0scNmP/H7Da/zwfSvmvSPK9g18LQBBpSTyl3F7qI0JkJ2A8J3AtkQ0JIMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrhBOJsh; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrhBOJsh"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-8069d92e182so1516975a34.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538488; x=1790143288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJGOJi9W8AEvzfvI6HU6TdGB/nZBZPfFkLPpp/UAVuw=;
        b=PrhBOJshRPqszx7BfOQOBLqEM+xorWDYp8hhnJYEPmJ1sErcoaLTiYkoeVagd7MAgH
         B20Tqzr8xIqsLgkAPSv8Rv379CVEWsh2j/F99hWFLXIpq8q9yWe7RQobhEk/rbH1UGox
         3mCfWLzJJyOWaSwT6XzM++l2S/5J/CFGJIl2mIqr625fJ55Ebe83+amOd/k78Mc+IFYJ
         eb3y6pfm6HsO3J8L79pFmq0RDJrTdQL42X6w7cTBOtm5/A/+XX8Pn3CHHmHjfS/2HiAP
         bBjyqRYy0Eexd3Wqi2x+R7NyrxROH56IbnFFw1x8Bt9vad+psG6wFHwKjimoQf/RyFjG
         A28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538488; x=1790143288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJGOJi9W8AEvzfvI6HU6TdGB/nZBZPfFkLPpp/UAVuw=;
        b=SFUFZgtbeG15vTtlvXMt3gmYX3bGqYH1wL/ZfOT645iklTTy5mGGuIDzh4vURhhgUI
         4ffKZR7OkjI/QaQtRBk1Knz8uYkxg9G4IPmN7gJ0ImNHSrWOZU4pYfegHTz7kKFNIZOP
         6QGOO3+78ZK9BhlOcRFAMljYkoMA+XIijEw29sR0dzIHDlzdFY6B8/oZAz/SlVCKGcoY
         DI30iB0pbnAljXdh/WQrt6fSPcIRBelfqdnZRW5OrH4EW2sszRpgtkEx+WdIsp36Tg1v
         GEflXuGrHbxZ3CAGOsPJknJ/3URPkGN+r10Pr89Gnx2ZPNplkblDasjIRSsdUzCFgb0s
         J6CQ==
X-Gm-Message-State: AFuF++k42mwbYnvBHEMLHIqHFRUE2jMP7suSalOdOlp5nosFs6ENA87z
	xpiGswRWSg/i/XuCVGyx1rfpGh+gVqHX4fTZwoWOaZnerSuJ+L7dv3Pe2cxPJo9htn0=
X-Gm-Gg: AYBFou1eI8kPPa/aXaQcE3IWmJHFWql3QdpDdnsgCF3rAXb9Dn8CoYNdP8i7dC97frh
	+OSfixtfxCq91cNCW2I3X2PmnxM8YRCLW3VxXOMt58tl2Cqxo4Ndc4jDJQoclvBA5A2aahT4KBg
	DjisOkNrXJ7eaQxiJMBvlEthVUEmWH9hslVZ2lPEU/bH2lIcEGPQOBpDbPMG70xNwB3DmYp47WN
	t5s/NJyz2atvCWswlM4fIfmOCmq0eA0UFyh0S8NkLkaSi7mJuR4ETMx1Qk5cM02/3QONKs8ftkY
	ZrKzylI7882wrhpYW+FSuAX6boLJ7AUv/LmlWlv+y7BOxoor8u2F/XXS0g5zHVEhTEOF+I7iSVk
	+LZrbDydyWhDE1NXyWil54tJSUsG8zeZ/e4OrLqZRbnLA+Dhjd2+VZ9y1jr1wbJRtSbrS7hGIdr
	wQcf/jRy/cdcQ9CsYz04U0bLxETDR4ythupeWH6JJzPdNgjZQpjcQfFcGIHixGIpPTpXLucvqtw
	TMixQr1JexO3yIz4PMH1bDOtqnRQg==
X-Received: by 2002:a05:6820:290c:b0:6b7:46e9:9701 with SMTP id 006d021491bc7-6c7d44e4c89mr1528053eaf.49.1789538488363;
        Tue, 15 Sep 2026 23:01:28 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm5150929eec.14.2026.09.15.23.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:01:27 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH v3 0/7] iio: accel: merge adis16203 into mainline adis16201 and remove from staging
Date: Wed, 16 Sep 2026 10:55:30 +0500
Message-ID: <20260916055547.15206-1-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v3 series addresses review feedback on the previous attempt to move
ADIS16203 from staging into the mainline ADIS16201 driver [1].

Key changes from v2:
- Fixed channel order for buffer mode in precursor patch (patch 1)
- Updated matching tables to modern conventions
- Moved adis_data into chip_info
- Added separate adis16203_data instance and dropped runtime copy in
  probe
- Fixed Kconfig help text format 

Patches 6 and 7 carry Reviewed-by tags from prior review.

[1] https://lore.kernel.org/all/20260913085307.13846-1-shehryar.amd@gmail.com/

Shehryar Ahmad (7):
  iio: accel: adis16201: fix channel order for buffer mode
  iio: accel: adis16201: add SPI device ID table
  iio: accel: adis16201: add OF device ID table
  iio: accel: adis16201: prepare driver to support additional parts
  iio: accel: adis16201: add ADIS16203 support
  staging: iio: accel: remove adis16203, merged into mainline adis16201
    driver
  dt-bindings: iio: accel: adi,adis16201: add adis16203 compatible

 .../bindings/iio/accel/adi,adis16201.yaml     |   6 +-
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/adis16201.c                 | 133 ++++++--
 drivers/staging/iio/Kconfig                   |   1 -
 drivers/staging/iio/Makefile                  |   1 -
 drivers/staging/iio/accel/Kconfig             |  19 --
 drivers/staging/iio/accel/Makefile            |   6 -
 drivers/staging/iio/accel/adis16203.c         | 315 ------------------
 8 files changed, 117 insertions(+), 372 deletions(-)
 delete mode 100644 drivers/staging/iio/accel/Kconfig
 delete mode 100644 drivers/staging/iio/accel/Makefile
 delete mode 100644 drivers/staging/iio/accel/adis16203.c

-- 
2.43.0

