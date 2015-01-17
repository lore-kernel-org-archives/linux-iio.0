Return-Path: <kristina.martsenko@gmail.com>
From: =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
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
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: [PATCH 4/4] iio: mxs-lradc: only update the buffer when its conversions have finished
Date: Sat, 17 Jan 2015 02:22:11 +0200
Message-Id: <1421454131-3501-5-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Using the touchscreen while running buffered capture results in the
buffer reporting lots of wrong values, often just zeros. This is because
we push readings to the buffer every time a touchscreen interrupt
arrives, including when the buffer's own conversions have not yet
finished. So let's only push to the buffer when its conversions are
ready.

Signed-off-by: Kristina Martšenko <kristina.martsenko@gmail.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 5b5cb205b9ed..d60ca849175e 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1153,10 +1153,12 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 				LRADC_CTRL1_LRADC_IRQ(TS_VCH2));
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
