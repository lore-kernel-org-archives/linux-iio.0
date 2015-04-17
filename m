Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:33172
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbDQOFp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2015 10:05:45 -0400
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH] iio: mlx90614: Fix duplicate const warning
Date: Fri, 17 Apr 2015 16:05:35 +0200
Message-Id: <1429279535-19730-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix a typo triggering a duplicate const warning on some compilers.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
---
 drivers/iio/temperature/mlx90614.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 06b7b96..b2d3b56 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -263,7 +263,7 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 }
 
 static int mlx90614_write_raw_get_fmt(struct iio_dev *indio_dev,
-				     const struct iio_chan_spec const *channel,
+				     struct iio_chan_spec const *channel,
 				     long mask)
 {
 	switch (mask) {
-- 
2.3.5

