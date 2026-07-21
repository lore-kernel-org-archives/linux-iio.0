Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com [198.54.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796436AB6B;
	Tue, 21 Jul 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641765; cv=none; b=guLsnVDbaFQuSovpaZIEQYvTbrGO7lgdyQW/3OVaXNuB/5qeNGtuC2W+WFX//g22gw2zVP5evtwejkq/1hDOh4PLDPi2vBhj9Q0j0yR2Gx2suT06Es5xruNvH0XjACjqWewBWFWzBD3hOEn7sbHtjpxWt9wBjm4iWPvHY3ho+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641765; c=relaxed/simple;
	bh=tlxtPUyBz/219nhVHCcACjoI28fWxT+wZ3ASmm3lPWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFBjmAZtCz6Drlo2dr1ie49z/+NxdXZqGSPAWyBSqy93xmnWc6+N1bRN9yVp/YK2tarwS3l5xhHsuAovAp+Xt9N1HtQYWlR3e7RqG6Qji4ACMSHMTaH46mB7RuUlahSfAgFvR54Zd7NXXjiFwtVAt29M9ylFn2DdIIVunPGU5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-13 [87.215.145.39])
	by mta-10.privateemail.com (Postfix) with ESMTPA id 4h4JdS0PhBz3hhTr;
	Tue, 21 Jul 2026 09:48:59 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siratul Islam <siratul.islam@linux.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: magnetometer: add support for QST QMC6308
Date: Tue, 21 Jul 2026 15:48:41 +0200
Message-ID: <20260721134843.7484-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a driver and DT binding for the QST QMC6308, a 3-axis
anisotropic magnetoresistive (AMR) magnetometer found e.g. in the
Fairphone 6. The series is based on iio/togreg.

The chip is a sibling of the QMC5883L but is not register compatible
with it, so this is a separate driver; its structure intentionally
follows qmc5883l.c. Reads are polled from the chip's periodic
measurement mode, with runtime PM dropping the chip into its suspend
mode between uses.

The binding stays a separate file rather than being folded into
qstcorp,qmc5883l.yaml: as discussed with Siratul in the v1 thread, the
two schemas share only compatible/reg/vdd-supply, and Jonathan leaned
towards keeping the files separate given that small overlap. If the DT
maintainers prefer the combined shape I'm happy to rework it that way.
Adding mount-matrix to qstcorp,qmc5883l.yaml, also raised in that
discussion, is a natural follow-up patch either way.

Tested on a Fairphone 6 (bit-banged i2c-gpio bus) using a
byte-identical backport on that device's 7.1-based kernel; on this
base the driver is build-verified (arm64, W=1 clean). v2 testing
re-covered raw reads, every ODR/oversampling/scale setting (the same
ambient field reads consistently across all four ranges), the
stale-sample discard on range changes, and runtime PM, including that
the chip autosuspends after probe without the v1 usage-counter
dance and that configuration writes land while suspended. The FP6
board DTS will be submitted separately through the qcom tree once
this lands.

Per-patch changelogs are in the individual patches.

v1: https://lore.kernel.org/20260714202842.340293-1-jorijnvdgraaf@catcrafts.net

Jorijn van der Graaf (2):
  dt-bindings: iio: magnetometer: add QST QMC6308
  iio: magnetometer: add support for QST QMC6308

 .../iio/magnetometer/qstcorp,qmc6308.yaml     |  47 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  11 +
 drivers/iio/magnetometer/Makefile             |   1 +
 drivers/iio/magnetometer/qmc6308.c            | 602 ++++++++++++++++++
 5 files changed, 668 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
 create mode 100644 drivers/iio/magnetometer/qmc6308.c


base-commit: 036d96ceec6d966339aea34d034420991e24cfac
-- 
2.55.0

