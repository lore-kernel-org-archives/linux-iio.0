Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] iio/kern: consider the case where channel number > number of channels
Date: Mon, 10 Jun 2013 17:42:35 +0200
Message-Id: <1370878955-31880-1-git-send-email-bigeasy@linutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On the am335x I export ADC channels indexed by their number as specified
in the datasheet. The channels are shared between the TSC & ADC and be
used either by TSC or the ADC. So it is possible that the TSC uses
chanels 0 & 1 and the ADC is using channels 2 & 3. The total number of
channles of the ADC is 2 but the individual numbers are 2 and 3.
This patch changes the check for the the requesting channel by walking
over the list and comparing the channel number.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/inkern.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index dca4eed..1a40077 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -107,6 +107,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
 	struct iio_dev *indio_dev;
 	int err;
 	struct of_phandle_args iiospec;
+	int i;
 
 	err = of_parse_phandle_with_args(np, "io-channels",
 					 "#io-channel-cells",
@@ -123,15 +124,13 @@ static int __of_iio_channel_get(struct iio_channel *channel,
 	indio_dev = dev_to_iio_dev(idev);
 	channel->indio_dev = indio_dev;
 	index = iiospec.args_count ? iiospec.args[0] : 0;
-	if (index >= indio_dev->num_channels) {
-		err = -EINVAL;
-		goto err_put;
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].channel == index) {
+			channel->channel = &indio_dev->channels[i];
+			return 0;
+		}
 	}
-	channel->channel = &indio_dev->channels[index];
-
-	return 0;
 
-err_put:
 	iio_device_put(indio_dev);
 	return err;
 }
-- 
1.7.10.4
