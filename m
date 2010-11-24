Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49887 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab0KXSl1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2010 13:41:27 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, matthias.bgg@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] staging:iio:gyro: Merge adis16251 into adis16260
Date: Wed, 24 Nov 2010 18:47:58 +0000
Message-Id: <1290624481-5522-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dependent on previous adis16260 series. Last patch in that series was
[PATCH 2/2] staging:iio:adis16260 add suppport for adis16255 and adis16250.
Sent to Greg on the 22nd November after review.

First patch is a bug fix - my bug :( though bug probably had no real effect.
  Fix happens to involve adding an id_table which will come in handy for the
  next patch.
Second adds support for the adis16251 into the adis16260 driver.
Third removes adis16251 specific driver.

This part is very similar to those already supported by the adis16260
driver. The minor differences are easily handled by adding a chip info
structure.

NB, I have none of these parts.  I know Matthias has an adis1625x part
but I think I have done nothing that could break that.  Analog guys,
do you have a handy adis16251 to test this on?  If not some eyes on the code
to see if I have done anything silly would be great!

The previous adis16251 driver needed a lot of work and, with the benefit
of hindsight, should probably never have been separate in the first place.

Note there are some suspicious elements left in this driver, but I have
stuck to adding device support in this patch set rather than a thorough fixup
of this driver. That can wait for another day.

Jonathan Cameron (3):
  staging:iio:gyro:adis16260 Make memory test dependant on being
    adis1626x
  staging:iio:gyro:adis16260 add support for adis16251
  staging:iio:gyro:adis1251 remove driver

 drivers/staging/iio/gyro/Kconfig          |   15 +-
 drivers/staging/iio/gyro/Makefile         |    3 -
 drivers/staging/iio/gyro/adis16251.h      |  185 -------
 drivers/staging/iio/gyro/adis16251_core.c |  777 -----------------------------
 drivers/staging/iio/gyro/adis16260.h      |   20 +
 drivers/staging/iio/gyro/adis16260_core.c |   93 +++-
 6 files changed, 97 insertions(+), 996 deletions(-)
 delete mode 100644 drivers/staging/iio/gyro/adis16251.h
 delete mode 100644 drivers/staging/iio/gyro/adis16251_core.c

-- 
1.7.2.2

