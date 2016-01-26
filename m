Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36340 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbcAZPrA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jan 2016 10:47:00 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de,
	ludovic.tancerel@maplehightech.com, tduszyns@gmail.com,
	akinobu.mita@gmail.com, daniel.baluta@intel.com,
	k.kozlowski@samsung.com, afd@ti.com, broonie@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lucas.demarchi@intel.com
Subject: [PATCH 0/2] ms5611: Add triggered buffer support
Date: Tue, 26 Jan 2016 17:49:06 +0200
Message-Id: <1453823348-23074-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

First patch reverts 7cb46c2a066 ("iio: pressure: ms5611: remove
IIO_CHAN_INFO_SCALE from mask") because we need the scale to correctly
transform "raw" data from buffer into correct measurement units.

Second patch adds the actual buffer support.

Daniel Baluta (2):
  iio: pressure: ms5611: Add IIO_CHAN_INFO_SCALE to mask
  iio: pressure: ms5611: Add triggered buffer support

 drivers/iio/pressure/Kconfig       |  1 +
 drivers/iio/pressure/ms5611.h      |  1 +
 drivers/iio/pressure/ms5611_core.c | 89 ++++++++++++++++++++++++++++++++++++--
 drivers/iio/pressure/ms5611_i2c.c  |  7 +++
 drivers/iio/pressure/ms5611_spi.c  |  8 ++++
 5 files changed, 102 insertions(+), 4 deletions(-)

-- 
2.5.0

