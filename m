Return-Path: <bethencourt@gmail.com>
Sender: Luis de Bethencourt <bethencourt@gmail.com>
From: Luis de Bethencourt <luis@debethencourt.com>
Date: Thu, 17 Sep 2015 19:02:00 +0200
To: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Axel Lin <axel.lin@ingics.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: twl6030-gpadc: Fix module autoload for OF
 platform driver
Message-ID: <20150917170200.GA27396@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index df12c57..becbb0a 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -875,6 +875,7 @@ static const struct of_device_id of_twl6030_match_tbl[] = {
 	},
 	{ /* end */ }
 };
+MODULE_DEVICE_TABLE(of, of_twl6030_match_tbl);
 
 static int twl6030_gpadc_probe(struct platform_device *pdev)
 {
-- 
2.4.6
