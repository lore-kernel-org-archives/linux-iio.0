Return-Path: <Hector.Palacios@digi.com>
From: Hector Palacios <hector.palacios@digi.com>
To: <linux-iio@vger.kernel.org>
CC: <alexandre.belloni@free-electrons.com>, <lars@metafoo.de>,
	<jic23@kernel.org>, <marex@denx.de>, <fabio.estevam@freescale.com>,
	<hector.palacios@digi.com>
Subject: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
Date: Fri, 5 Jul 2013 10:30:36 +0200
Message-ID: <1373013039-19461-2-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-1-git-send-email-hector.palacios@digi.com>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The LRADC virtual channels have an 18 bit field to store the sum of up
to 2^5 accumulated samples. The read_raw function however only operates
over a single sample (12 bit resolution).
In order to use this field for scaling operations, we need it to be the
exact resolution value of the LRADC.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 163c638..d65a594 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -822,7 +822,7 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
 	.channel = (idx),					\
 	.scan_type = {						\
 		.sign = 'u',					\
-		.realbits = 18,					\
+		.realbits = 12,					\
 		.storagebits = 32,				\
 	},							\
 }
