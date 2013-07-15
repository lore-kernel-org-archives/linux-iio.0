Return-Path: <otavio.salvador@gmail.com>
Sender: Otavio Salvador <otavio.salvador@gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Otavio Salvador <otavio@ossystems.com.br>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marex@denx.de>,
	Bill Pemberton <wfp5p@virginia.edu>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH 2/5] ARM: mxs-lradc: Simplify mxs_lradc_trigger_init error handle
Date: Mon, 15 Jul 2013 11:22:37 -0300
Message-Id: <1373898160-8460-2-git-send-email-otavio@ossystems.com.br>
In-Reply-To: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
References: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
List-ID: <linux-iio@vger.kernel.org>

As we have a 'ret' variable with the iio_trigger_register return, this
can be used as result.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 drivers/staging/iio/adc/mxs-lradc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d92c97a..6d41846 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -671,14 +671,12 @@ static int mxs_lradc_trigger_init(struct iio_dev *iio)
 	trig->ops = &mxs_lradc_trigger_ops;
 
 	ret = iio_trigger_register(trig);
-	if (ret) {
+	if (ret)
 		iio_trigger_free(trig);
-		return ret;
-	}
 
 	iio->trig = trig;
 
-	return 0;
+	return ret;
 }
 
 static void mxs_lradc_trigger_remove(struct iio_dev *iio)
-- 
1.8.3.2
