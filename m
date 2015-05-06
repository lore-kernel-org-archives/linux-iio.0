Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:48392 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbbEFVs5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 May 2015 17:48:57 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] iio: hid-sensors: Fix memory leak on failure path in hid_prox_probe()
Date: Thu,  7 May 2015 00:48:44 +0300
Message-Id: <1430948924-4756-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If prox_parse_report() fails, memory allocated for channels is not
deallocated, since it is still in local variable channels
while kfree() is called with indio_dev->channels.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/iio/light/hid-sensor-prox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 91ecc46ffeaa..d0d188108a11 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -281,8 +281,9 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = prox_parse_report(pdev, hsdev, channels,
 				HID_USAGE_SENSOR_PROX, prox_state);
 	if (ret) {
+		kfree(channels);
 		dev_err(&pdev->dev, "failed to setup attributes\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	indio_dev->channels = channels;
-- 
1.9.1

