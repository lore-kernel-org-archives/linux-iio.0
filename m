Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:45380
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbbC3IfN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 04:35:13 -0400
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH v3 0/5] iio: mlx90614 enhancements
Date: Mon, 30 Mar 2015 10:34:57 +0200
Message-Id: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Many thanks Jonathan and Lars for taking time reviewing this series.  Please
find next follow-up patches addressing your comments.

This set of patches adds the following additional features to the
mlx90614 temperature sensor driver.

* Emissivity setting (patch 3)
* Power management (patch 4)
* Handle errors in temperature reading (patch 5)

The changes have been split into 5 patches to ease code review.
Patch 1 introduces IIO_CHAN_INFO_CALIBEMISSIVITY in iio core and is a
prerequisite of patch 3.
Patch 2 introduces devicetree bindings documentation, which is complemented by
patch 4.
Patches 3-5 implement the additional features and are mostly independent
from each other.

Patches 2 and 4 introduce device tree bindings and are the only one sent to the
devicetree list.

Patch set history:
v3:
* Rebase on iio.git testing branch, drop 3 merged patches
* Rename IIO_CHAN_INFO_EMISSIVITY to IIO_CHAN_INFO_CALIBEMISSIVITY
* Split basic devicetree bindings into separate patch
* Make _probe and _remove mirror images
* Return -EIO instead of -EREMOTEIO on read error

v2:
* Drop processed temperature output (v1 patch 3)
* Drop raw IR values for now (v1 patch 7)
* Drop iir, fir, and gain attributes for now (v1 patch 5)
* Introduce standard attribute for emissivity (patches 4 and 5)
* Add patch 7, fixing wrong readings
* Return -EINTR when wake-up is interrupted during read (patch 6)
* Make adding vendor prefix explicit in commit message of patch 6

Vianney le Clément de Saint-Marcq (5):
  iio: core: Introduce IIO_CHAN_INFO_CALIBEMISSIVITY
  iio: mlx90614: Add devicetree bindings documentation
  iio: mlx90614: Add emissivity setting
  iio: mlx90614: Add power management
  iio: mlx90614: Check for errors in read values

 Documentation/ABI/testing/sysfs-bus-iio            |  11 +
 .../bindings/iio/temperature/mlx90614.txt          |  24 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/temperature/mlx90614.c                 | 355 ++++++++++++++++++++-
 include/linux/iio/iio.h                            |   1 +
 6 files changed, 389 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90614.txt

-- 
2.3.4

