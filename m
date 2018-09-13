Return-Path: <SRS0=9z2R=L3=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
	<lars@metafoo.de>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>
Subject: [PATCH] staging:iio:ad7606: update structs with doc annotations
Date: Thu, 13 Sep 2018 14:07:36 +0300
Message-ID: <20180913110736.31182-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The current structs are only partially documented via annotations. This
change updates annotations for all structs in the ad7606.h file.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/adc/ad7606.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 4983e3aa6b0e..f422296354c9 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -24,7 +24,26 @@ struct ad7606_chip_info {
 
 /**
  * struct ad7606_state - driver instance specific data
+ * @dev		pointer to kernel device
+ * @chip_info		entry in the table of chips that describes this device
+ * @reg		regulator info for the the power supply of the device
+ * @poll_work		struct info for reading data in buffer mode
+ * @wq_data_avail	wait queue struct for buffer mode
+ * @bops		bus operations (SPI or parallel)
+ * @range		voltage range selection, selects which scale to apply
+ * @oversampling	oversampling selection
+ * @done		marks whether reading data is done
+ * @base_address	address from where to read data in parallel operation
  * @lock		protect sensor state
+ * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
+ * @gpio_reset		GPIO descriptor for device hard-reset
+ * @gpio_range		GPIO descriptor for range selection
+ * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
+ *			controls power-down mode of device
+ * @gpio_frstdata	GPIO descriptor for reading from device when data
+ *			is being read on the first channel
+ * @gpio_os		GPIO descriptors to control oversampling on the device
+ * @data		buffer for reading data from the device
  */
 
 struct ad7606_state {
@@ -55,6 +74,10 @@ struct ad7606_state {
 	unsigned short			data[12] ____cacheline_aligned;
 };
 
+/**
+ * struct ad7606_bus_ops - driver bus operations
+ * @read_block		function pointer for reading blocks of data
+ */
 struct ad7606_bus_ops {
 	/* more methods added in future? */
 	int (*read_block)(struct device *dev, int num, void *data);
-- 
2.17.1
