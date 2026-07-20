Received: from MTA-11-3.privateemail.com (mta-11-3.privateemail.com [198.54.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B01446C0B;
	Mon, 20 Jul 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568889; cv=none; b=KAj5PkHrta/1c7oZhrg48nbktlbrXtf0UEfTsNV31f/lv47D5Mu50K5dQXXaAmzXcOyv+mMohG2S5vPy0zzvjiId9K1RweURHBWFAWIWfFIEov/iW9l+SW5AZGDL82IaBQrrq/KRvs29cP+vXqV278bNe9VoVtL5shEIRj1v8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568889; c=relaxed/simple;
	bh=ln5FpuLYhY3KrC6NuQrfV6H0Y9Cq3Ay/jgiTQtWb2Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ke3AHxS8nQjxd+QaYBNc/G8f3tJFN5Zuot+/TsKeaolgq5GkVWOOrlLZJUCRTdVQsZv1BUmGptkYOjInF+gtaqCewktpDpxp7NpkQ39fuonRSdRQvsLxo+SiyuEgjfcLyjafsI2p0toN43aZ3ZLHsfYYZJSQjBVdXZzU76BSfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 4h3ngv01Nhz3hhTG;
	Mon, 20 Jul 2026 13:34:18 -0400 (EDT)
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
Subject: [PATCH 0/2] iio: imu: inv_icm42600: add support for icm42630
Date: Mon, 20 Jul 2026 19:34:09 +0200
Message-ID: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
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
unmodified once its WHOAMI value is known, so this is just the
compatible plus the chip id / WHOAMI table entries.

The part appears to be a mobile SKU and has no public datasheet. The
name comes from the Fairphone 6 schematics and platform documentation;
the WHOAMI value 0x0C was read from the hardware over both SPI and
I2C, and the chip's bank 0 register defaults match the ICM-42600
family layout. Jean-Baptiste, if you are able to confirm the part name
and WHOAMI value from the TDK side, that would be very welcome.

Tested on the Fairphone 6: patch 2 applied to the device's 7.1-based
kernel (with the id-table hunks adjusted to that base's style) drives
the chip over a bit-banged SPI bus with INT1 wired to the SoC - probe,
accelerometer, gyroscope and temperature raw reads, all full-scale
ranges, multiple sampling frequencies, and watermark-paced FIFO reads
through the INT1 interrupt. The accelerometer full scale was cross-checked against
gravity (~2048 LSB/g at the default range, matching +-16g); the
+-2000 dps gyroscope full scale is inferred from family membership,
pending confirmation from TDK.

The series is based on iio/togreg (base-commit below); on that base it
builds (arm64 defconfig with the driver as modules, W=1 clean on the
driver directory) and dt_binding_check passes.

Note: Chris Morgan's in-flight ICM-42607 series [1] adds entries to
the same binding enum; the overlap is context-only (different lines)
and trivial for whichever lands second.

[1] https://lore.kernel.org/all/20260716182637.24310-1-macroalpha82@gmail.com/

The Fairphone 6 board DTS nodes will follow separately via the qcom
tree once this lands.

Jorijn van der Graaf (2):
  dt-bindings: iio: imu: icm42600: add icm42630
  iio: imu: inv_icm42600: add support for icm42630

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml     | 1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                  | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c             | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c              | 4 ++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c              | 4 ++++
 5 files changed, 16 insertions(+)


base-commit: 036d96ceec6d966339aea34d034420991e24cfac
-- 
2.55.0

