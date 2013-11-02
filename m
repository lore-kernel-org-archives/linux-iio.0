Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:54530 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427Ab3KBTox (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 2 Nov 2013 15:44:53 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 1/2] iio: Fix sign extension table in mcp3422 driver
Date: Sat,  2 Nov 2013 20:44:47 +0100
Message-Id: <1383421488-5167-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

the index argument to sign_extend32() gives the bit position (from 0)
to the sign bit

so e.g. if the measurement has 16-bit resolution, we need to pass 15;
a measurement of 0x8000 should be reported as -32768, not 32768

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 1294832..c8c1baa 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -88,10 +88,10 @@ static const int mcp3422_sample_rates[4] = {
 
 /* sample rates to sign extension table */
 static const int mcp3422_sign_extend[4] = {
-	[MCP3422_SRATE_240] = 12,
-	[MCP3422_SRATE_60] = 14,
-	[MCP3422_SRATE_15] = 16,
-	[MCP3422_SRATE_3] = 18 };
+	[MCP3422_SRATE_240] = 11,
+	[MCP3422_SRATE_60] = 13,
+	[MCP3422_SRATE_15] = 15,
+	[MCP3422_SRATE_3] = 17 };
 
 /* Client data (each client gets its own) */
 struct mcp3422 {
-- 
1.8.4.2

