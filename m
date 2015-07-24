Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36725 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbbGXN1B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 09:27:01 -0400
Date: Fri, 24 Jul 2015 16:26:09 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 6/6] include: linux: iio: Add missing kernel doc field
Message-ID: <d960cd2edacace9344f69ae131a1f399ce7a1f8f.1437737942.git.cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1437737942.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix kernel doc for the iio_dev_attr structure by adding its missing field.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 include/linux/iio/sysfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index 8a1d186..71fdd6f 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -18,7 +18,8 @@ struct iio_chan_spec;
  * struct iio_dev_attr - iio specific device attribute
  * @dev_attr:	underlying device attribute
  * @address:	associated register address
- * @l:		list head for maintaining list of dynamically created attrs.
+ * @l:		list head for maintaining list of dynamically created attrs
+ * @c:		specification for the underlying channels
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
-- 
1.9.1

