Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30861 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbcCAKa7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Mar 2016 05:30:59 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v4 0/3] iio:pressure:ms5611: fix and enhancements
Date: Tue, 1 Mar 2016 11:31:35 +0100
Message-ID: <cover.1456828051.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v1:
* temperature compensation fix:
    * reword commit message
    * remove useless parenthesis
* power regulator: reword commit message
* add oversampling rate support

Changes since v2:
* remove non printable characters from commit messages

Changes since v3:
* drop first 3 patches since applied onto testing
* fix oops at regulator probing time if regulator support not compiled-in
* complete device-tree support and documentation
* remove continuous sampling support (see Jonathan's "kthread tight loop
  trigger" proposal)
* checkpatch'ed

Gregor Boirie (2):
  iio:pressure:ms5611: fix oops when probing regulator
  iio:pressure:ms5611: oversampling rate support

Grégor Boirie (1):
  iio:pressure:ms5611: complete DT support

 .../devicetree/bindings/iio/pressure/ms5611.txt    |  19 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/pressure/ms5611.h                      |  20 ++--
 drivers/iio/pressure/ms5611_core.c                 | 113 ++++++++++++++++++++-
 drivers/iio/pressure/ms5611_i2c.c                  |  25 +++--
 drivers/iio/pressure/ms5611_spi.c                  |  32 ++++--
 6 files changed, 185 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt

-- 
2.1.4

