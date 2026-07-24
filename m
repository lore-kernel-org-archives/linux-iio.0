Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2B37E5D0;
	Fri, 24 Jul 2026 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924863; cv=none; b=VEidPs593UcOE9GS7RR5cOlox4FEyI6jDOSE0d4o9XQEPYa2RO1Zbb8feDOjM4LJDAPVqPWPZ1xZLN4obxc3yFkSL8TArxuzt6Lkf11SvGqE/hT1981RmIIGVE9/T+L8jOtXowY5NF1kGkWna9sjLyAd7aZlZgm2cmKwR4GPZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924863; c=relaxed/simple;
	bh=ebthC6qKVtpGd1fUKkbSQ3OrT5M5NielL2GRPzBmitk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8Xb/mv+eUCQoqvn71YePNHy4/OkkLDcjLeI51eloM9zTXq3z9qlIgPIgjo7jyscynEXOOvHem8fNgK++faEs38nwJ2+/bdXY68AD61VvnAxsGOcZfGkI4NcCLsli+f/lWGO4jMVXQiX3zL2sYgrdth86ImflQ5Sf8V0zIbju8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=162.0.218.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from MTA-13-4.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4h6KL32CLYz2xjN;
	Fri, 24 Jul 2026 16:27:39 -0400 (EDT)
Received: from mail.privateemail.com (K8S-PROD-WORKER-08 [87.215.145.39])
	by mta-13.privateemail.com (Postfix) with ESMTPA id 4h6KKb3nQlz3hhTf;
	Fri, 24 Jul 2026 16:27:15 -0400 (EDT)
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
Subject: [PATCH v2 0/4] iio: imu: inv_icm42600: add support for icm42630
Date: Fri, 24 Jul 2026 22:27:04 +0200
Message-ID: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
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

v2 restructures the series per the v1 review: the binding documents the
new compatible with an invensense,icm42631 fallback, and the driver's
WHOAMI hard check becomes a warning so that a fallback-matched part can
probe at all (on older kernels via a backport of that one patch). The
id tables are sorted numerically in a precursor patch and the new
entries slot into numeric position.

Both resulting paths were tested on the Fairphone 6 with the fallback
pair in the devicetree, via backports to its 7.1-based kernel: matched
as icm42631 through the fallback (patch 2 alone, dedicated entries
removed), the part warns once, probes, and accelerometer, gyroscope
and temperature reads work; with the dedicated entries present it
binds as icm42630 without a warning. The fuller v1 test set (all
full-scale ranges, several sampling frequencies, watermark-paced FIFO
reads via INT1) ran with the dedicated compatible and is unchanged by
this revision.

Chris Morgan's icm42607 series [1] touches the same binding enum, so
whichever lands second has a trivial merge conflict. Its conditional
interrupts requirement covers the ICM-42630 automatically through the
fallback compatible.

Changes in v2:
- new patch 1: sort the device id tables numerically (Jonathan)
- new patch 2: warn on whoami mismatch instead of failing probe
  (Conor, Jonathan)
- patch 3 (v1 patch 1): compatible now documented with the icm42631
  fallback (Jonathan); commit message rewritten; dropped Jean-Baptiste's
  Acked-by because of the rework
- patch 4 (v1 patch 2): match entries placed in numeric position
  (Jonathan); kept Jean-Baptiste's Acked-by - the only code change is
  the entry placement; its commit message gains a sentence on the
  fallback and a more precise note on the tested backport

[1] https://lore.kernel.org/all/20260722153942.144387-1-macroalpha82@gmail.com/

v1: https://lore.kernel.org/all/20260720173411.82979-1-jorijnvdgraaf@catcrafts.net/

Jorijn van der Graaf (4):
  iio: imu: inv_icm42600: sort device id tables numerically
  iio: imu: inv_icm42600: warn on whoami mismatch instead of failing
    probe
  dt-bindings: iio: imu: icm42600: add icm42630
  iio: imu: inv_icm42600: add support for icm42630

 .../bindings/iio/imu/invensense,icm42600.yaml | 20 +++++++++++--------
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  2 ++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 13 +++++++-----
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 18 ++++++++++-------
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 18 ++++++++++-------
 5 files changed, 44 insertions(+), 27 deletions(-)


base-commit: 036d96ceec6d966339aea34d034420991e24cfac
-- 
2.55.0

