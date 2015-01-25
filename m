Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34612 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbbAYQaU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jan 2015 11:30:20 -0500
Received: by mail-lb0-f173.google.com with SMTP id p9so4390726lbv.4
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2015 08:30:18 -0800 (PST)
From: =?UTF-8?q?Kristina=20Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	Juergen Beisert <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>
Subject: [PATCH v2 4/4] iio: mxs-lradc: only update the buffer when its conversions have finished
Date: Sun, 25 Jan 2015 18:28:22 +0200
Message-Id: <1422203302-17090-5-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com>
References: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using the touchscreen while running buffered capture results in the
buffer reporting lots of wrong values, often just zeros. This is because
we push readings to the buffer every time a touchscreen interrupt
arrives, including when the buffer's own conversions have not yet
finished. So let's only push to the buffer when its conversions are
ready.

Signed-off-by: Kristina Martšenko <kristina.martsenko@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/staging/iio/adc/mxs-lradc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d2e0c275bf4d..ebcbd12d48b9 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1152,10 +1152,12 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 				LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANNEL2));
 	}
 
-	if (iio_buffer_enabled(iio))
-		iio_trigger_poll(iio->trig);
-	else if (reg & LRADC_CTRL1_LRADC_IRQ(0))
+	if (iio_buffer_enabled(iio)) {
+		if (reg & lradc->buffer_vchans)
+			iio_trigger_poll(iio->trig);
+	} else if (reg & LRADC_CTRL1_LRADC_IRQ(0)) {
 		complete(&lradc->completion);
+	}
 
 	mxs_lradc_reg_clear(lradc, reg & clr_irq, LRADC_CTRL1);
 
-- 
2.2.0

