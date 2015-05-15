Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-168.synserver.de ([212.40.185.168]:1041 "EHLO
	smtp-out-168.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934243AbbEOPSn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2015 11:18:43 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/5] iio: adis16400 fixes
Date: Fri, 15 May 2015 17:18:33 +0200
Message-Id: <1431703118-32676-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This series has a couple of fixes for the adis16400 driver, mostly
concerned with the handling of the burst mode which is used by some devices
when running buffered mode.

- Lars

Lars-Peter Clausen (2):
  iio: adis16400: Report pressure channel scale
  iio: adis16400: Fix burst transfer for adis16448

Paul Cercueil (3):
  iio: adis16400: Use != channel indices for the two voltage channels
  iio: adis16400: Compute the scan mask from channel indices
  iio: adis16400: Fix burst mode

 drivers/iio/imu/adis16400.h        |  2 ++
 drivers/iio/imu/adis16400_buffer.c | 26 ++++++++++++++++--------
 drivers/iio/imu/adis16400_core.c   | 41 +++++++++++++++++++++++++++-----------
 3 files changed, 49 insertions(+), 20 deletions(-)

-- 
1.8.0

