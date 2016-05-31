Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:37052 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755446AbcEaRAh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
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
Subject: [PATCH 8/8] Input: ti_am335x_tsc - use variable name for sizeof() operator
Date: Tue, 31 May 2016 12:00:13 -0500
Message-ID: <20160531170013.2649-9-afd@ti.com>
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
 drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 8b3f15c..7953381 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -406,7 +406,7 @@ static int titsc_probe(struct platform_device *pdev)
 	int err;
 
 	/* Allocate memory for device */
-	ts_dev = kzalloc(sizeof(struct titsc), GFP_KERNEL);
+	ts_dev = kzalloc(sizeof(*ts_dev), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!ts_dev || !input_dev) {
 		dev_err(&pdev->dev, "failed to allocate memory.\n");
-- 
2.8.3

