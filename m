Return-Path: <SRS0=ajWN=7T=it-klinger.de=ak@kernel.org>
Date: Fri, 18 Aug 2017 00:08:29 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
	hdegoede@redhat.com, wsa@the-dreams.de,
	chris.packham@alliedtelesis.co.nz, jelle@vdwaa.nl,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/5]  iio: srf08: add support for similar devices and
 triggered buffers
Message-ID: <20170817220829.GA4687@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch series adds support for:
- triggered buffer
- ultrasonic devices srf02 and srf10

Changes in v4:
- rebase to recent git repository with trivial-devices.txt now under
  devicetree/bindings

Changes in v3:
- introduce struct chip_info for device specific features
- remove locking error in srf08_trigger_handler()

Changes in v2:
- removed unnecessary patch "[PATCH 6/7] iio: srf08: add buffered to device mode"
- incorporated patch "[PATCH 7/7] iio: srf08: change text in Kconfig" where suitable
- changed order of patches to improve logical flow of changes
- improved distinction of sensor types

Andreas Klinger (5):
  iio: srf08: add device tree binding for srf02 and srf10
  iio: srf08: add device tree table
  iio: srf08: add triggered buffer support
  iio: srf08: add sensor type srf10
  iio: srf08: add support for srf02 in i2c mode

 .../devicetree/bindings/trivial-devices.txt        |   2 +
 drivers/iio/proximity/Kconfig                      |   8 +-
 drivers/iio/proximity/srf08.c                      | 227 ++++++++++++++++++---
 3 files changed, 203 insertions(+), 34 deletions(-)

-- 
2.1.4


-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
