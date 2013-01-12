Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59642 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3ALKfh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 05:35:37 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com, amit.kucheria@verdurent.com,
	pmeerw@pmeerw.net, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/5] iio:light:tsl2563 cleanup and move out of staging.
Date: Sat, 12 Jan 2013 10:35:19 +0000
Message-Id: <1357986924-11471-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series more or less consists of the original move patch after
some precursors fixing the various bits and bobs Peter found in his
review.  I also dropped a few other unnecessary bits spotted
whilst making Peter's changes.

Jonathan Cameron (5):
  staging:iio:light:tsl2563 drop unnecessary brackets around constants.
  staging:iio:light:tsl2563 clean comments up.
  staging:iio:tsl2563 Simplify exit path on error in
    read_interrupt_config.
  staging:iio:tsl2563 drop pointless forward declaration
  iio:light:tsl2563 move out of staging

 drivers/iio/light/Kconfig             |  10 +
 drivers/iio/light/Makefile            |   1 +
 drivers/iio/light/tsl2563.c           | 887 +++++++++++++++++++++++++++++++++
 drivers/staging/iio/light/Kconfig     |  10 -
 drivers/staging/iio/light/Makefile    |   1 -
 drivers/staging/iio/light/tsl2563.c   | 899 ----------------------------------
 drivers/staging/iio/light/tsl2563.h   |   9 -
 include/linux/platform_data/tsl2563.h |   9 +
 8 files changed, 907 insertions(+), 919 deletions(-)
 create mode 100644 drivers/iio/light/tsl2563.c
 delete mode 100644 drivers/staging/iio/light/tsl2563.c
 delete mode 100644 drivers/staging/iio/light/tsl2563.h
 create mode 100644 include/linux/platform_data/tsl2563.h

-- 
1.8.1

