Received: from out-zbxj-a87.jellyfish.systems (out-zbxj-a87.jellyfish.systems [198.54.127.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281F1DF261
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787445987; cv=none; b=iJtHdK0xCUFM6xkeW2GTLaqNzPApUtbn6kuOD6CBtb6rVD3vZgEw/UlfuuvDbjjCZM/ejHO2net4RzkJAYo5F5L9ccOq1ZqLxEfntoP994zQpenu/Jwsz8Et3rPv8UQIw3XWanSVgkm4JpaHEd6QsdsoQHHSYgww8ibxLJoo/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787445987; c=relaxed/simple;
	bh=6whiMiAEO1S7pfsaBg9Sc1h/nNsDRj1yrHCK/Dyi/n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HALU8NYrh9cT+oxyBg+K2Bp9lKRHg0YOJKdEbmoWFxv6Bu3j1eiVlcDie+8taLYATn0GimU2iA/1/jBZ6cZiwJqA9nIloC+kQxT/3JDaVPXaPrjb88UkyG5zNPIEZzqbR3Or9W7Luas6nCPZeBcMceJbdfkMlLb3Fdqc5wQJemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hSFQL0QlBz8sWN;
	Sun, 23 Aug 2026 00:33:29 +0000 (UTC)
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
Subject: [PATCH v5 0/3] iio: imu: inv_icm42600: add support for icm42630
Date: Sun, 23 Aug 2026 02:33:17 +0200
Message-ID: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
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

Changes in v5:
- patch 2: the no-response guard moves before the whoami-mismatch
  comparison as its own check (Andy); it does not depend on
  hw->whoami, since no supported part uses either value
- patch 2: the four Link trailers are dropped (Andy, Jonathan); the
  Suggested-by tags carry the attribution

v4: https://lore.kernel.org/all/20260810191157.125550-1-jorijnvdgraaf@catcrafts.net/
v3: https://lore.kernel.org/all/20260728184351.75015-1-jorijnvdgraaf@catcrafts.net/
v2: https://lore.kernel.org/all/20260724202708.128267-1-jorijnvdgraaf@catcrafts.net/
v1: https://lore.kernel.org/all/20260720173411.82979-1-jorijnvdgraaf@catcrafts.net/

Jorijn van der Graaf (3):
  iio: imu: inv_icm42600: sort device id tables numerically
  iio: imu: inv_icm42600: log whoami mismatch instead of failing probe
  dt-bindings: iio: imu: icm42600: add icm42630

 .../bindings/iio/imu/invensense,icm42600.yaml | 24 +++++++++++--------
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 17 ++++++++++---
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 16 ++++++-------
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 16 ++++++-------
 4 files changed, 44 insertions(+), 29 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.55.0

