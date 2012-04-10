Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53617 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302Ab2DJUi2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:38:28 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, greg@kroah.com,
	dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/4] staging:iio:in kernel users: Add a data field for channel specific info.
Date: Tue, 10 Apr 2012 21:38:13 +0100
Message-Id: <1334090294-23407-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1334090294-23407-1-git-send-email-jic23@kernel.org>
References: <1334090294-23407-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Used to allow information about a given channel mapping to be passed
through from board files to the consumer drivers.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/consumer.h |    2 ++
 drivers/staging/iio/inkern.c   |    1 +
 drivers/staging/iio/machine.h  |    2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/staging/iio/consumer.h b/drivers/staging/iio/consumer.h
index ef3c10c..d4863da 100644
--- a/drivers/staging/iio/consumer.h
+++ b/drivers/staging/iio/consumer.h
@@ -18,10 +18,12 @@ struct iio_chan_spec;
  * struct iio_channel - everything needed for a consumer to use a channel
  * @indio_dev:		Device on which the channel exists.
  * @channel:		Full description of the channel.
+ * @data:		Data about the channel used by consumer.
  */
 struct iio_channel {
 	struct iio_dev *indio_dev;
 	const struct iio_chan_spec *channel;
+	void *data;
 };
 
 /**
diff --git a/drivers/staging/iio/inkern.c b/drivers/staging/iio/inkern.c
index de2c8ea..b895e7e 100644
--- a/drivers/staging/iio/inkern.c
+++ b/drivers/staging/iio/inkern.c
@@ -189,6 +189,7 @@ struct iio_channel *iio_st_channel_get_all(const char *name)
 		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
 			continue;
 		chans[mapind].indio_dev = c->indio_dev;
+		chans[mapind].data = c->map->consumer_data;
 		chans[mapind].channel =
 			iio_chan_spec_from_name(chans[mapind].indio_dev,
 						c->map->adc_channel_label);
diff --git a/drivers/staging/iio/machine.h b/drivers/staging/iio/machine.h
index 0b1f19b..7409100 100644
--- a/drivers/staging/iio/machine.h
+++ b/drivers/staging/iio/machine.h
@@ -16,9 +16,11 @@
  * @consumer_dev_name:	Name to uniquely identify the consumer device.
  * @consumer_channel:	Unique name used to idenitify the channel on the
  *			consumer side.
+ * @consumer_data:	Data about the channel for use by the consumer driver.
  */
 struct iio_map {
 	const char *adc_channel_label;
 	const char *consumer_dev_name;
 	const char *consumer_channel;
+	void *consumer_data;
 };
-- 
1.7.9.4

