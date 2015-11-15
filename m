Return-Path: <Julia.Lawall@lip6.fr>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Jonathan Cameron <jic23@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: xilinx: constify iio_buffer_setup_ops structure
Date: Sun, 15 Nov 2015 21:00:02 +0100
Message-Id: <1447617602-12922-1-git-send-email-Julia.Lawall@lip6.fr>
List-ID: <linux-iio@vger.kernel.org>

The iio_buffer_setup_ops structures are never modified, so declare this one
as const, like the others.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/iio/adc/xilinx-xadc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0370624..c2b5f10 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -803,7 +803,7 @@ err:
 	return ret;
 }
 
-static struct iio_buffer_setup_ops xadc_buffer_ops = {
+static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 	.preenable = &xadc_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
