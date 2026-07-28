Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C446D09A;
	Tue, 28 Jul 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264272; cv=none; b=uBzS+qYiMwniwiYdyFKfiFPMQsxDZuRw9lYUpKgsx0PKnvLGyTeBipd4u2Aqt/7QbR8HFHPYnYPSipNmPjj2mj5QMKssk0v7zCqn2KVXDJ/57JJZftDDmPlZHZvsEqzh8WJ/4fmD5bnJfS3KnsAFJPlyA2YtJq+QIGlXFXLGURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264272; c=relaxed/simple;
	bh=figjxBMs/UPbIekiHNitak24OhrEeM18T68Q/Ao1UhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFteKgHyLU8infn/jixAtErTdPmEpCIE5STKD5GPaj9A+CMtnMREiP2fZRbcKcI7AgJ31Ohf3bVZDuj8X3UU2UDPnoLVuY+9l9Sleickzhy1242DO0lmH1pdf1iCOzv1rBITBMta6+2s7Sx4dsliL6BFyd2hROGsa6Acnz+Gqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=162.0.218.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from MTA-09-4.privateemail.com (mta-09.privateemail.com [198.54.127.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4h8ks20vnKz2xdg;
	Tue, 28 Jul 2026 14:44:22 -0400 (EDT)
Received: from mail.privateemail.com (K8S-PROD-WORKER-14 [87.215.145.39])
	by mta-09.privateemail.com (Postfix) with ESMTPA id 4h8krZ5bkMz3hhTG;
	Tue, 28 Jul 2026 14:43:58 -0400 (EDT)
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
Subject: [PATCH v3 0/3] iio: imu: inv_icm42600: add support for icm42630
Date: Tue, 28 Jul 2026 20:43:48 +0200
Message-ID: <20260728184351.75015-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
used in the Fairphone 6. The existing inv_icm42600 driver drives it
unmodified.

The binding documents the new compatible with an invensense,icm42631
fallback, and the driver's WHOAMI check is dropped so that a
fallback-matched part can probe (on older kernels via a backport of
that one patch). No driver id entries are added: the part binds
through the fallback.

Tested on the Fairphone 6 with the fallback pair in the devicetree,
via a backport to its 7.1-based kernel: matched as icm42631 through
the fallback, the part probes silently, and accelerometer, gyroscope
and temperature reads work. The fuller v1 test set (all full-scale
ranges, several sampling frequencies, watermark-paced FIFO reads via
INT1) ran with v1's dedicated icm42630 id entries, whose configuration
is the same family default the fallback match selects.

Chris Morgan's icm42607 series [1] touches the same binding enum, so
whichever lands second has a trivial merge conflict. Its conditional
interrupts requirement covers the ICM-42630 automatically through the
fallback compatible.

Changes in v3:
- patch 2: drop the whoami check entirely instead of demoting the
  mismatch error to a warning, and remove the now-unused whoami
  definitions (Conor)
- dropped v2's patch 4 (dedicated icm42630 driver id entries): the
  part binds through the fallback (Conor); Jean-Baptiste's Acked-by
  on it lapses with the patch
- patch 1 and the binding patch are unchanged; series rebased onto
  current iio/togreg

[1] https://lore.kernel.org/all/20260727164815.65190-1-macroalpha82@gmail.com/

v2: https://lore.kernel.org/all/20260724202708.128267-1-jorijnvdgraaf@catcrafts.net/
v1: https://lore.kernel.org/all/20260720173411.82979-1-jorijnvdgraaf@catcrafts.net/

Jorijn van der Graaf (3):
  iio: imu: inv_icm42600: sort device id tables numerically
  iio: imu: inv_icm42600: drop the whoami check
  dt-bindings: iio: imu: icm42600: add icm42630

 .../bindings/iio/imu/invensense,icm42600.yaml | 20 +++++++++++--------
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  9 ---------
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 17 ----------------
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 16 +++++++--------
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 16 +++++++--------
 5 files changed, 28 insertions(+), 50 deletions(-)


base-commit: 0506462caaecb179708657142575823177c83783
-- 
2.55.0

