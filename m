Return-Path: <sst@poczta.fm>
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 04/10] iio: adc: mcp3422: remove spaces before comma
Date: Thu, 14 Apr 2016 21:36:36 +0200
Message-Id: <1460662602-2951-5-git-send-email-sst@poczta.fm>
In-Reply-To: <1460662602-2951-1-git-send-email-sst@poczta.fm>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
List-ID: <linux-iio@vger.kernel.org>

This fixes the error reported by checkpatch.pl:

ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/adc/mcp3422.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index d7b36ef..d1172dc 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -61,9 +61,9 @@
 
 static const int mcp3422_scales[4][4] = {
 	{ 1000000, 500000, 250000, 125000 },
-	{ 250000 , 125000, 62500 , 31250  },
-	{ 62500  , 31250 , 15625 , 7812   },
-	{ 15625  , 7812  , 3906  , 1953   } };
+	{ 250000,  125000, 62500,  31250  },
+	{ 62500,   31250,  15625,  7812   },
+	{ 15625,   7812,   3906,   1953   } };
 
 /* Constant msleep times for data acquisitions */
 static const int mcp3422_read_times[4] = {
-- 
2.8.0
