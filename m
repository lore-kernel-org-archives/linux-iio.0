Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-232.synserver.de ([212.40.185.232]:1048 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751464AbbHENic (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 09:38:32 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/9] iio: adis updates
Date: Wed,  5 Aug 2015 15:38:12 +0200
Message-Id: <1438781901-28000-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This series contains various updates to a couple of the drivers for devices
from the Analog Devices ADIS16xxx family.

The first few patches have fixes for incorrect scale factors.

The other patches add support for devices which are mostly register map
compatible to existing supported devices.

- Lars

Lars-Peter Clausen (9):
  iio: adis16400: Fix adis16448 gyroscope scale
  iio: Add inverse unit conversion macros
  iio: adis16480: Fix scale factors
  iio: adis16400: adis16300 has product ID and serial number
  iio: adis16400: Add ADIS16305 support
  iio: adis16260: Add ADIS16266 support
  iio: adis16400: Add ADIS16367 support
  iio: adis16400: Add ADIS16445 support
  iio: adis16136: Add ADIS16137 support

 drivers/iio/gyro/adis16136.c     |   6 ++
 drivers/iio/gyro/adis16260.c     | 137 ++++++++++++++++++++++++++++-----------
 drivers/iio/imu/adis16400_core.c |  46 ++++++++++++-
 drivers/iio/imu/adis16480.c      |  39 +++++++++--
 include/linux/iio/iio.h          |  17 +++++
 5 files changed, 198 insertions(+), 47 deletions(-)

-- 
2.1.4

