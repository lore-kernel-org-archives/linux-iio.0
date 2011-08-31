Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:41482 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001Ab1HaL4t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:56:49 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: michael.hennerich@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: fixed version of the differential handling patch.
Date: Wed, 31 Aug 2011 13:04:58 +0100
Message-Id: <1314792299-18560-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This hopefully gets the event code asignment right.

Please sanity check.  I'll push the tree up later when hera is back up.

Jonathan

Jonathan Cameron (1):
  staging:iio: Differential channel handling - use explicit flag rather
    than types.

 drivers/staging/iio/adc/ad7192.c        |    8 +-
 drivers/staging/iio/adc/ad7280a.c       |   26 +++--
 drivers/staging/iio/adc/ad7793.c        |  176 ++++++++++++++++++++--------
 drivers/staging/iio/adc/max1363_core.c  |  198 ++++++++++++++-----------------
 drivers/staging/iio/iio.h               |    3 +-
 drivers/staging/iio/industrialio-core.c |  145 ++++++++++++-----------
 drivers/staging/iio/sysfs.h             |   11 +-
 7 files changed, 323 insertions(+), 244 deletions(-)

-- 
1.7.3.4

