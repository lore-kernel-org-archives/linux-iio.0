Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45979 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab0KZO4D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2010 09:56:03 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] staging:iio:gyro cleanup new drivers
Date: Fri, 26 Nov 2010 15:02:37 +0000
Message-Id: <1290783760-6968-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There was a lot of unused code in these drivers and stubs
for stuff that hadn't been implemented.

These drivers will all need a fair bit more work to be
abi compliant and to reach the point where  we would normally
have merged them, but paring them back to the bits that
are actually present is a sensible start.

Jonathan Cameron (3):
  staging:iio:gyro:adis16060 cleanup and dead code removal
  staging:iio:gyro:adis16080 unused stub removal and cleanup
  staging:iio:gyro:adis16130 stub removal and cleanup

 drivers/staging/iio/gyro/adis16060.h      |   70 ------------------------
 drivers/staging/iio/gyro/adis16060_core.c |   59 +++++----------------
 drivers/staging/iio/gyro/adis16080.h      |   84 +++-------------------------
 drivers/staging/iio/gyro/adis16080_core.c |   54 ++-----------------
 drivers/staging/iio/gyro/adis16130.h      |   72 +-----------------------
 drivers/staging/iio/gyro/adis16130_core.c |   61 +++------------------
 6 files changed, 37 insertions(+), 363 deletions(-)

-- 
1.7.2.2

