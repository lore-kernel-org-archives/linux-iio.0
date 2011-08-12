Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:43819 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab1HLQsD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:48:03 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 7/7] staging:iio: remove unneeded include
Date: Fri, 12 Aug 2011 17:56:05 +0100
Message-Id: <1313168165-16109-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313168165-16109-1-git-send-email-jic23@cam.ac.uk>
References: <1313168165-16109-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/sysfs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index bf34cfb..0b75823 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -12,7 +12,7 @@
 #ifndef _INDUSTRIAL_IO_SYSFS_H_
 #define _INDUSTRIAL_IO_SYSFS_H_
 
-#include "iio.h"
+struct iio_chan_spec;
 
 /**
  * struct iio_dev_attr - iio specific device attribute
-- 
1.7.3.4

