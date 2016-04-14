Return-Path: <sst@poczta.fm>
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 01/10] iio: light apds9960: fix wrong use of brace
Date: Thu, 14 Apr 2016 21:36:33 +0200
Message-Id: <1460662602-2951-2-git-send-email-sst@poczta.fm>
In-Reply-To: <1460662602-2951-1-git-send-email-sst@poczta.fm>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
List-ID: <linux-iio@vger.kernel.org>

This fixes the error reported by checkpatch.pl:

ERROR: that open brace { should be on the previous line

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/light/apds9960.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index a6af56a..ade18aa 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -321,8 +321,12 @@ static const struct iio_chan_spec apds9960_channels[] = {
 };
 
 /* integration time in us */
-static const int apds9960_int_time[][2] =
-	{ {28000, 246}, {100000, 219}, {200000, 182}, {700000, 0} };
+static const int apds9960_int_time[][2] = {
+	{ 28000, 246},
+	{100000, 219},
+	{200000, 182},
+	{700000,   0}
+};
 
 /* gain mapping */
 static const int apds9960_pxs_gain_map[] = {1, 2, 4, 8};
-- 
2.8.0
