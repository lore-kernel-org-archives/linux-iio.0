Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53444 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743Ab1HZJ5k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 05:57:40 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 05/14] staging:iio: fix typo
Date: Fri, 26 Aug 2011 11:05:39 +0100
Message-Id: <1314353148-6670-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
References: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index edc295e..d7eb0d8 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -6,7 +6,7 @@
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
  *
- * These definitions are meant for use only within the IIO core, not indvidual
+ * These definitions are meant for use only within the IIO core, not individual
  * drivers.
  */
 
-- 
1.7.3.4

