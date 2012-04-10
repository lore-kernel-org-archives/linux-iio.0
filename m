Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36241 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab2DJULP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:11:15 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/6] IIO: Mixed trivial fixes and cleanups
Date: Tue, 10 Apr 2012 21:11:03 +0100
Message-Id: <1334088669-21032-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

This set have all been on the mailing list for over a month and
no one seems to care.  All straight forward enough that this
doesn't bother me too much!

Original messages:

Nothing terribly interesting, but as ever all comments welcome.
If no one shouts I'll assume these are trivial enough to send
on to Greg sometime next week.

and

I have no idea how I managed to munge the previous
patch related to this.  Sorry all.


Jonathan Cameron (6):
  staging:iio:buffer example fix typos
  staging:iio:adc:max1363 fix missing update_scan_mask callback.
  staging:iio fill in some missing docs
  staging:iio:max1363 enable use with inkernel interfaces.
  staging:iio:accel:lis3l02dq add symmetry to check for presence of
    trigger.
  staging:iio: use spi->irq valid rather than querying available modes

 drivers/staging/iio/Documentation/generic_buffer.c |    4 ++--
 drivers/staging/iio/accel/lis3l02dq_core.c         |    2 +-
 drivers/staging/iio/adc/max1363_core.c             |   10 +++++++++-
 drivers/staging/iio/iio.h                          |    2 ++
 drivers/staging/iio/imu/adis16400_core.c           |    2 +-
 drivers/staging/iio/meter/ade7758_core.c           |    2 +-
 6 files changed, 16 insertions(+), 6 deletions(-)

-- 
1.7.9.4

