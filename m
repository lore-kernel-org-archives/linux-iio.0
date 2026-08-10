Received: from out-93wp-a21.jellyfish.systems (out-93wp-a21.jellyfish.systems [104.207.68.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5143B6CC
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389154; cv=none; b=UlIYqhxBkTQwOlJ1w+PxZ853Zqk02Qd+3076zL34e3bEdtbBJRGxRO95fuA47GjQutTrmg6WzF8bFfXADJj1SxukfOFn7o8BPZKaKvMHgOMk7gzWkbwQoKh+Vxk71H9UG/L85aLSPFIYrIW7BnRa/G/NjljLugpB9sD1+/nKG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389154; c=relaxed/simple;
	bh=QKe7BxqzpcFDj0vgUeDjdOxqkMJpvMWXF7m8zaa9/PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ee6NgR7S+fW8ZF5ciWMai4dnpZbUbEQAhfDM9nfYlozD+fp9lsdUHhPKYOg7FXMnjvYZZVAsFW+uzeIjH0NFhT3nJV5EjMiw4dL3CPNZ8hc3INDodZh5hiv271llbBd2LFT7rAzt0gUuxlUE1QZMLPGt4J6+185j5yx/vZC6Ies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=104.207.68.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hJkrz2PP0z2x9D;
	Mon, 10 Aug 2026 19:12:03 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] iio: imu: inv_icm42600: add support for icm42630
Date: Mon, 10 Aug 2026 21:11:54 +0200
Message-ID: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
used in the Fairphone 6. It needs no part-specific driver code: TDK
confirmed it can be supported by inv_icm42600 without modification.

The binding documents the new compatible with an invensense,icm42631
fallback, and a WHOAMI mismatch no longer fails probe, so that a
fallback-matched part can probe; one informational line records the
mismatch, and a whoami of 0x00/0xff (no response) still fails. No
driver id entries are added: the part binds through the fallback.

Tested on the Fairphone 6 with the fallback pair in the devicetree,
via a backport to its 7.1-based kernel: matched as icm42631 through
the fallback, the part probes with the one informational line, and
accelerometer, gyroscope and temperature reads work.

Changes in v4:
- patch 2 (retitled): keep the WHOAMI read and log the mismatch at
  info level, following the wording Jonathan proposed, instead of
  deleting the check and the whoami definitions (Jonathan, Conor)
- patch 2: add a no-response guard, whoami 0x00/0xff still fails
  probe, matching inv_icm45600; both prints use %#04x so the two ids
  render at equal width
- patch 3: rebased over the icm42607 and mount-matrix binding changes;
  the conditional interrupts requirement added with the icm42607
  covers the ICM-42630 through its icm42631 fallback. Added Conor's
  Acked-by
- rebased onto current iio/togreg

v3: https://lore.kernel.org/all/20260728184351.75015-1-jorijnvdgraaf@catcrafts.net/
v2: https://lore.kernel.org/all/20260724202708.128267-1-jorijnvdgraaf@catcrafts.net/
v1: https://lore.kernel.org/all/20260720173411.82979-1-jorijnvdgraaf@catcrafts.net/

Jorijn van der Graaf (3):
  iio: imu: inv_icm42600: sort device id tables numerically
  iio: imu: inv_icm42600: log whoami mismatch instead of failing probe
  dt-bindings: iio: imu: icm42600: add icm42630

 .../bindings/iio/imu/invensense,icm42600.yaml | 24 +++++++++++--------
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 16 ++++++++++---
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 16 ++++++-------
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 16 ++++++-------
 4 files changed, 43 insertions(+), 29 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.55.0

