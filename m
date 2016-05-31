Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:37051 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755439AbcEaRAh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 31 May 2016 13:00:37 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Dave Gerlach <d-gerlach@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 6/8] mfd: ti_am335x_tscadc: use variable name for sizeof() operator
Date: Tue, 31 May 2016 12:00:11 -0500
Message-ID: <20160531170013.2649-7-afd@ti.com>
In-Reply-To: <20160531170013.2649-1-afd@ti.com>
References: <20160531170013.2649-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the code formatting to use the kernel preferred style
of using the actual variables to determize the size using
the sizeof() operator.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index d30bea5..c8f027b 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -168,8 +168,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	}
 
 	/* Allocate memory for device */
-	tscadc = devm_kzalloc(&pdev->dev,
-			sizeof(struct ti_tscadc_dev), GFP_KERNEL);
+	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
 	if (!tscadc) {
 		dev_err(&pdev->dev, "failed to allocate memory.\n");
 		return -ENOMEM;
-- 
2.8.3

