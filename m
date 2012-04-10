Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:56556 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758941Ab2DJURh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:17:37 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@TAOSinc.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/4] IIO: Another set of buglets plus cleanups.
Date: Tue, 10 Apr 2012 21:17:28 +0100
Message-Id: <1334089052-22304-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Nothing links these really but seems silly to send them as 4 series.

I'll try and be a bit quicker sending these on to Greg if no one
has any issue with them.  Reviews always welcome of course!

Jonathan Cameron (4):
  staging:iio:light:tsl2563 channel spec buglet / always reading same
    adc.
  staging:iio:Documentation: Fix a cut and paste error.
  staging:iio:iio_core.h make less dependent on other included headers
  staging:iio: chan_spec - take extend_name constant.

 drivers/staging/iio/Documentation/gb            |  Bin 0 -> 33746 bytes
 drivers/staging/iio/Documentation/sysfs-bus-iio |    8 ++++----
 drivers/staging/iio/iio.h                       |    2 +-
 drivers/staging/iio/iio_core.h                  |    6 ++++++
 drivers/staging/iio/light/tsl2563.c             |    3 ++-
 5 files changed, 13 insertions(+), 6 deletions(-)
 create mode 100755 drivers/staging/iio/Documentation/gb

-- 
1.7.9.4

