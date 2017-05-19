Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35655 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbdESOsb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 May 2017 10:48:31 -0400
Received: by mail-lf0-f50.google.com with SMTP id y126so2268095lfc.2
        for <linux-iio@vger.kernel.org>; Fri, 19 May 2017 07:48:30 -0700 (PDT)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff White <Jeff.White@zii.aero>,
        Chris Healy <Chris.Healy@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 2/4] iio: hi8435: avoid garbage event at first enable
Date: Fri, 19 May 2017 17:48:00 +0300
Message-Id: <20170519144802.14427-2-nikita.yoush@cogentembedded.com>
In-Reply-To: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently, driver generates events for channels if new reading differs
from previous one. This "previous value" is initialized to zero, which
results into event if value is constant-one.

Fix that by initializing "previous value" by reading at event enable
time.

This provides reliable sequence for userspace:
- enable event,
- AFTER THAT read current value,
- AFTER THAT each event will correspond to change.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/iio/adc/hi8435.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index cb8e6342eddf..45a92e3e8f2b 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -141,10 +141,21 @@ static int hi8435_write_event_config(struct iio_dev *idev,
 				     enum iio_event_direction dir, int state)
 {
 	struct hi8435_priv *priv = iio_priv(idev);
+	int ret;
+	u32 tmp;
+
+	if (state) {
+		ret = hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
+		if (ret < 0)
+			return ret;
+		if (tmp & BIT(chan->channel))
+			priv->event_prev_val |= BIT(chan->channel);
+		else
+			priv->event_prev_val &= ~BIT(chan->channel);
 
-	priv->event_scan_mask &= ~BIT(chan->channel);
-	if (state)
 		priv->event_scan_mask |= BIT(chan->channel);
+	} else
+		priv->event_scan_mask &= ~BIT(chan->channel);
 
 	return 0;
 }
-- 
2.11.0

