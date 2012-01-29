Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com,
	guenter.roeck@ericsson.com,
	khali@linux-fr.org,
	dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de,
	linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com,
	w.sang@pengutronix.de,
	marek.vasut@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/5] staging:iio:Documentation in kernel pull description.
Date: Sun, 29 Jan 2012 11:46:53 +0000
Message-Id: <1327837614-24176-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1327837614-24176-1-git-send-email-jic23@kernel.org>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Very basic description of the way iio consumers work and how to use
this functionality.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Documentation/inkernel.txt |   59 ++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/inkernel.txt b/drivers/staging/iio/Documentation/inkernel.txt
new file mode 100644
index 0000000..b9a4d0a
--- /dev/null
+++ b/drivers/staging/iio/Documentation/inkernel.txt
@@ -0,0 +1,59 @@
+Industrial I/O Subsystemm in kernel consumers.
+
+The IIO subsystem can act as a layer under other elements of the kernel
+providing a means of obtaining adc type readings or of driving dac type
+signals.  The functionality supported will grow as use cases arise.
+
+Describing the channel mapping (iio/machine.h)
+
+Channel associations are described using:
+
+struct iio_map {
+	const char *adc_channel_label;
+	struct device *consumer_dev;
+	const char *consumer_dev_name;
+	const char *consumer_channel;
+};
+
+adc_channel label identifies the channel on the IIO device by being
+matched against the datasheet_name field of the iio_chan_spec.
+
+consumer_dev or consumer_dev_name allow identification of the consumer device.
+These are then used to find the channel mapping from the consumer device (see
+below).
+
+Finally consumer_channel is a string identifying the channel to the consumer.
+(Perhaps 'battery_voltage' or similar).
+
+An array of these structures is then passed to the IIO driver.
+
+Supporting in kernel interfaces in the driver (driver.h)
+
+The driver must provide datasheet_name values for its channels and
+must pass the iio_map structures and a pointer to its own iio_dev structure
+ on to the core via a call to iio_map_array_register.  On removal,
+iio_map_array_unregister reverses this process.
+
+The result of this is that the IIO core now has all the information needed
+to associate a given channel with the consumer requesting it.
+
+Acting as an IIO consumer (consumer.h)
+
+The consumer first has to obtain an iio_channel structure from the core
+by calling iio_channel_get().  The correct channel is identified by:
+
+* matching dev or dev_name against consumer_dev and consumer_dev_name
+* matching consumer_channel against consumer_channel in the map
+
+There are then a number of functions that can be used to get information
+about this channel such as it's current reading.
+
+e.g.
+iio_st_read_channel_raw() - get a reading
+iio_st_read_channel_type() - get the type of channel
+
+There is also provision for retrieving all of the channels associated
+with a given consumer.  This is useful for generic drivers such as
+iio_hwmon where the number and naming of channels is not known by the
+consumer driver.  To do this, use iio_st_channel_get_all.
+
-- 
1.7.8.4
