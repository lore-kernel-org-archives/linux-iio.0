Return-Path: <stefan.wahren@i2se.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/6] iio: mxs-lradc: fix some spelling errors
Date: Sat, 18 Jul 2015 12:30:42 +0000
Message-Id: <1437222646-8742-3-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fix some spelling errors in the comments.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/iio/adc/mxs-lradc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 1ccb367..386a44d 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -65,14 +65,14 @@
  * Once the pen touches the touchscreen, the touchscreen switches from
  * IRQ-driven mode to polling mode to prevent interrupt storm. The polling
  * is realized by worker thread, which is called every 20 or so milliseconds.
- * This gives the touchscreen enough fluence and does not strain the system
+ * This gives the touchscreen enough fluency and does not strain the system
  * too much.
  */
 #define LRADC_TS_SAMPLE_DELAY_MS	5
 
 /*
  * The LRADC reads the following amount of samples from each touchscreen
- * channel and the driver then computes avarage of these.
+ * channel and the driver then computes average of these.
  */
 #define LRADC_TS_SAMPLE_AMOUNT		4
 
@@ -238,7 +238,7 @@ struct mxs_lradc {
 	 * CH5 -- Touch screen YNLR
 	 * CH6 -- Touch screen WIPER (5-wire only)
 	 *
-	 * The bitfields below represents which parts of the LRADC block are
+	 * The bit fields below represents which parts of the LRADC block are
 	 * switched into special mode of operation. These channels can not
 	 * be sampled as regular LRADC channels. The driver will refuse any
 	 * attempt to sample these channels.
@@ -252,7 +252,7 @@ struct mxs_lradc {
 	struct input_dev	*ts_input;
 
 	enum mxs_lradc_id	soc;
-	enum lradc_ts_plate	cur_plate; /* statemachine */
+	enum lradc_ts_plate	cur_plate; /* state machine */
 	bool			ts_valid;
 	unsigned		ts_x_pos;
 	unsigned		ts_y_pos;
@@ -812,7 +812,7 @@ static int mxs_lradc_read_single(struct iio_dev *iio_dev, int chan, int *val)
 	int ret;
 
 	/*
-	 * See if there is no buffered operation in progess. If there is, simply
+	 * See if there is no buffered operation in progress. If there is, simply
 	 * bail out. This can be improved to support both buffered and raw IO at
 	 * the same time, yet the code becomes horribly complicated. Therefore I
 	 * applied KISS principle here.
-- 
1.7.9.5
