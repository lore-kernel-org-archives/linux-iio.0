Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:52684 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab0JGMEr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2010 08:04:47 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] staging:iio: misc fixes
Date: Thu,  7 Oct 2010 13:10:18 +0100
Message-Id: <1286453421-7584-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Typo, plus two left over bugs from the scan_element directory picked
up by Michael Hennerich.

Jonathan Cameron (3):
  staging:iio: timestamp_en naming typo fix.
  staging:iio:sca3000 fix bug due to scan_element directory move.
  staging:iio:max1363 fix bug due to scan_element directory move.

 drivers/staging/iio/accel/sca3000_ring.c |    6 ++++--
 drivers/staging/iio/adc/max1363_core.c   |    6 ++++--
 drivers/staging/iio/ring_generic.h       |    2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
1.7.2.2

