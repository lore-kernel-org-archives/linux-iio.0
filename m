Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31700 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755748AbaC0Ajk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 26 Mar 2014 20:39:40 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org, khali@linux-fr.org
Cc: linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org,
	ktsai@capellamicro.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC Patch v0 2/3] i2c-smbus: Allow building with I2C_HELPER_AUTO support
Date: Wed, 26 Mar 2014 17:42:11 -0700
Message-Id: <1395880932-19124-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currentlty the config is conditional on !I2C_HELPER_AUTO.
I don't know their dependency, but without this we can't build.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/i2c/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 7b7ea32..212ed73 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -74,7 +74,7 @@ config I2C_HELPER_AUTO
 	  In doubt, say Y.
 
 config I2C_SMBUS
-	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
+	tristate "SMBus-specific protocols"
 	help
 	  Say Y here if you want support for SMBus extensions to the I2C
 	  specification. At the moment, the only supported extension is
-- 
1.8.3.2

