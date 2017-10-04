Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:47936 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdJDMIa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Oct 2017 08:08:30 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jonathan Cameron <jic23@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] iio: adc: rcar-gyroadc: Cast pointer to uintptr_t to fix warning on 64-bit
Date: Wed,  4 Oct 2017 14:08:24 +0200
Message-Id: <1507118906-8946-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
References: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 64-bit:

    drivers/iio/adc/rcar-gyroadc.c: In function 'rcar_gyroadc_parse_subdevs':
    drivers/iio/adc/rcar-gyroadc.c:352:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
       childmode = (unsigned int)of_id->data;
		   ^

Cast the pointer to uintptr_t instead of unsigned int to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Currently this driver can be enabled on arm32 only, but the hardware
block can be found in some R-Car Gen3 SoCs, which are arm64.
---
 drivers/iio/adc/rcar-gyroadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 2cb5397ceeea9ff4..0098c66a19572400 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -348,7 +348,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			continue;
 		}
 
-		childmode = (unsigned int)of_id->data;
+		childmode = (uintptr_t)of_id->data;
 		switch (childmode) {
 		case RCAR_GYROADC_MODE_SELECT_1_MB88101A:
 			sample_width = 12;
-- 
2.7.4

