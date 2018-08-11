Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:49160 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeHKLp5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Aug 2018 07:45:57 -0400
From: Stefan Agner <stefan@agner.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] iio: adc: max9611: explicitly cast gain_selectors
Date: Sat, 11 Aug 2018 11:12:19 +0200
Message-Id: <20180811091219.5048-1-stefan@agner.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After finding a reasonable gain, the function converts the configured
gain to a gain configuration option selector enum max9611_csa_gain.
Make the conversion clearly visible by using an explicit cast. This
also avoids a warning seen with clang:
  drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
      enumeration type 'enum max9611_conf_ids' to different enumeration
      type 'enum max9611_csa_gain' [-Wenum-conversion]
                        *csa_gain = gain_selectors[i];
                                  ~ ^~~~~~~~~~~~~~~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 0538ff8c4ac1..643a4e66eb80 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -289,7 +289,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
 			return ret;
 
 		if (*adc_raw > 0) {
-			*csa_gain = gain_selectors[i];
+			*csa_gain = (enum max9611_csa_gain)gain_selectors[i];
 			return 0;
 		}
 	}
-- 
2.18.0
