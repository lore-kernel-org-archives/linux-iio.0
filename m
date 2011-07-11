Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58870 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758002Ab1GKP6O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2011 11:58:14 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/4] ADIS16400 one big fix and some updates.
Date: Mon, 11 Jul 2011 16:58:03 +0100
Message-Id: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

The first patch here is a clanger of a bug introduced by me.  Pretty self
explanatory. Sorry all.

The others are simple cleanups.

Jonathan Cameron (4):
  staging:iio:imu fix missing register table index for some channels
  staging:iio:imu:adis16344 support
  staging:iio:imu:adis16400: use strtobool for reset sysfs and don't
    assign unused tx members.
  staging:iio:imu:adis16400 remove now unused headers.

 drivers/staging/iio/imu/adis16400.h         |    3 +
 drivers/staging/iio/imu/adis16400_core.c    |  117 +++++++++++++++++++--------
 drivers/staging/iio/imu/adis16400_ring.c    |    7 --
 drivers/staging/iio/imu/adis16400_trigger.c |    6 --
 4 files changed, 85 insertions(+), 48 deletions(-)

-- 
1.7.3.4

