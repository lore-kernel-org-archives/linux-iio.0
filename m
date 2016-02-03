Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:59684 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933290AbcBCQsC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Feb 2016 11:48:02 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	daniel.baluta@intel.com, lucas.demarchi@intel.com
Subject: [PATCH v3 0/2] ms5611: Add triggered buffer support
Date: Wed,  3 Feb 2016 18:50:36 +0200
Message-Id: <1454518238-7242-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

First patch reverts 7cb46c2a066 ("iio: pressure: ms5611: remove
IIO_CHAN_INFO_SCALE from mask") because we need the scale to correctly
transform "raw" data from buffer into correct measurement units.

Second patch adds the actual buffer support.

Changes since v2:
	* addressed comements from Jonathan
	* get timestamp inside triggered buffer handler
	* push all channels data to buffer and leave demux to take care

Changes since v1:
	* addressed comments from Peter
	* explain why the need for allocating a buffer of 4 s32 elements
	* correctly handle data copy into buffer when not all channels are enabled
	* fixed timestamp channel index (2 instead of 3)
	* added some new lines for readability

Daniel Baluta (2):
  iio: pressure: ms5611: Add IIO_CHAN_INFO_SCALE to mask
  iio: pressure: ms5611: Add triggered buffer support

 drivers/iio/pressure/Kconfig       |  1 +
 drivers/iio/pressure/ms5611.h      |  1 +
 drivers/iio/pressure/ms5611_core.c | 92 ++++++++++++++++++++++++++++++++++++--
 drivers/iio/pressure/ms5611_i2c.c  |  7 +++
 drivers/iio/pressure/ms5611_spi.c  |  8 ++++
 5 files changed, 105 insertions(+), 4 deletions(-)

-- 
2.5.0

