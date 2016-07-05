Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37776 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755023AbcGEKX2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 06:23:28 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: light: vcnl4000: Use BIT() macro
Date: Tue,  5 Jul 2016 12:23:19 +0200
Message-Id: <1467714201-11429-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
References: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/iio/light/vcnl4000.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 071ff97..7f247ed 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -41,10 +41,10 @@
 #define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
 
 /* Bit masks for COMMAND register */
-#define VCNL4000_AL_RDY		0x40 /* ALS data ready? */
-#define VCNL4000_PS_RDY		0x20 /* proximity data ready? */
-#define VCNL4000_AL_OD		0x10 /* start on-demand ALS measurement */
-#define VCNL4000_PS_OD		0x08 /* start on-demand proximity measurement */
+#define VCNL4000_AL_RDY		BIT(6) /* ALS data ready? */
+#define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
+#define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
+#define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
 
 struct vcnl4000_data {
 	struct i2c_client *client;
-- 
1.7.10.4

