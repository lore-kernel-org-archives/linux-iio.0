Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33115 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcFXJMO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2016 05:12:14 -0400
Received: by mail-lf0-f52.google.com with SMTP id f6so111667618lfg.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2016 02:12:13 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/6 v2] iio: magn: ak8975: allow a delay after enabling regulators
Date: Fri, 24 Jun 2016 11:11:54 +0200
Message-Id: <1466759516-20586-5-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
References: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The datasheet actually specifies that we need to wait atleast
500us after powering on the device before trying to set mode.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes.
---
 drivers/iio/magnetometer/ak8975.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 378bafb9eb88..2fcd52a49759 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -399,6 +399,12 @@ static int ak8975_power_on(const struct ak8975_data *data)
 			 "Failed to enable specified Vid supply\n");
 		return ret;
 	}
+	/*
+	 * According to the datasheet the power supply rise time i 200us
+	 * and the minimum wait time before mode setting is 100us, in
+	 * total 300 us. Add some margin and say minimum 500us here.
+	 */
+	usleep_range(500, 1000);
 	return 0;
 }
 
-- 
2.4.11

