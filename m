Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:35179
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbBYPzW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 10:55:22 -0500
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	devicetree@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH 0/7] iio: mlx90614 enhancements
Date: Wed, 25 Feb 2015 16:55:05 +0100
Message-Id: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This set of patches adds the following additional features to the
mlx90614 temperature sensor driver.

* Processed temperature output (patch 3)
* Support for the dual IR sensor model (patch 4)
* EEPROM configuration tuning (patch 5)
* Power management (patch 6)
* Raw IR value access (RFC, patch 7)

The changes have been split into 7 patches to ease code review.
Patches 1 and 2 contain mandatory symbol definitions.
Patches 3-7 implement the additional features and are mostly independent
from each other.  If some features are not desired, the corresponding
patches can be left out.

Perhaps the most tricky part is the power management implemented by
patch 6, as it involves an extra GPIO messing with the SDA line in order
to wake up the sensor.  See the commit message for details.

Patch 6 introduces device tree bindings and is the only one sent to the
devicetree list.

Vianney le Clément de Saint-Marcq (7):
  iio: mlx90614: Refactor register symbols
  iio: mlx90614: Add symbols for accessible registers
  iio: mlx90614: Add processed temperature output
  iio: mlx90614: Support devices with dual IR sensor
  iio: mlx90614: Allow tuning EEPROM configuration
  iio: mlx90614: Add power management
  iio: mlx90614: Provide raw IR value for object channels

 .../bindings/iio/temperature/mlx90614.txt          |  24 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/temperature/mlx90614.c                 | 574 ++++++++++++++++++++-
 3 files changed, 580 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90614.txt

-- 
2.3.0

