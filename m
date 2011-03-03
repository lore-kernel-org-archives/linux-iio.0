Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47719 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758451Ab1CCRlJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Mar 2011 12:41:09 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/2] staging:iio:lis3l02dq cs_change fix and cleanups.
Date: Thu,  3 Mar 2011 17:41:39 +0000
Message-Id: <1299174101-1030-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Both of these were originally part of Manuel's patch set.
The cleanup changes in the second patch are rather more extensive
than Manuel suggested due to change in the return value needing
to be appropriately handled.

Thanks,

Jonathan

Manuel Stahl (2):
  staging:iio:lis3l02dq fix spi cs_change behaviour
  staging:iio:lis3l02dq use standard functions where possible.

 drivers/staging/iio/accel/lis3l02dq_core.c |   53 +++++++--------------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |    4 +-
 2 files changed, 16 insertions(+), 41 deletions(-)

-- 
1.7.3.4

