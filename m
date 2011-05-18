Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 011/111] staging:iio:sca3000 extract old event handling and move to poll for events from buffer
Date: Wed, 18 May 2011 14:41:01 +0100
Message-Id: <1305726161-5606-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Fairly substantial rewrite as the code had bitrotted.
A rethink is needed for how to handle variable types in the new chan_spec world.

This patch restores sca3000 buffer usage to a working state.
V3: Rebase fixups.
V2: Move to new version of IIO_CHAN macro

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000.h      |   76 +--
 drivers/staging/iio/accel/sca3000_core.c |  891 +++++++++++-------------------
 drivers/staging/iio/accel/sca3000_ring.c |  252 ++++++---
 3 files changed, 510 insertions(+), 709 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
index db71033..f77eb74 100644
--- a/drivers/staging/iio/accel/sca3000.h
+++ b/drivers/staging/iio/accel/sca3000.h
@@ -158,17 +158,17 @@
 
 /**
  * struct sca3000_state - device instance state information
- * @us: 	 		the associated spi device
- * @info: 	  		chip variant information
- * @indio_dev: 	 		device information used by the IIO core
- * @interrupt_handler_ws: 	event interrupt handler for all events
- * @last_timestamp: 		the timestamp of the last event
- * @mo_det_use_count: 		reference counter for the motion detection unit
- * @lock: 		 	lock used to protect elements of sca3000_state
- * 	 			and the underlying device state.
- * @bpse: 		 	number of bits per scan element
- * @tx: 		 	dma-able transmit buffer
- * @rx: 		 	dma-able receive buffer
+ * @us:			the associated spi device
+ * @info:			chip variant information
+ * @indio_dev:			device information used by the IIO core
+ * @interrupt_handler_ws:	event interrupt handler for all events
+ * @last_timestamp:		the timestamp of the last event
+ * @mo_det_use_count:		reference counter for the motion detection unit
+ * @lock:			lock used to protect elements of sca3000_state
+ *				and the underlying device state.
+ * @bpse:			number of bits per scan element
+ * @tx:			dma-able transmit buffer
+ * @rx:			dma-able receive buffer
  **/
 struct sca3000_state {
 	struct spi_device		*us;
@@ -179,15 +179,15 @@ struct sca3000_state {
 	int				mo_det_use_count;
 	struct mutex			lock;
 	int				bpse;
-	u8				*tx;
-	/* not used during a ring buffer read */
-	u8				*rx;
+	/* Can these share a cacheline ? */
+	u8				rx[2] ____cacheline_aligned;
+	u8				tx[6] ____cacheline_aligned;
 };
 
 /**
  * struct sca3000_chip_info - model dependent parameters
- * @name: 			model identification
- * @scale:			string containing floating point scale factor
+ * @name:			model identification
+ * @scale:			scale * 10^-6
  * @temp_output:		some devices have temperature sensors.
  * @measurement_mode_freq:	normal mode sampling frequency
  * @option_mode_1:		first optional mode. Not all models have one
@@ -200,29 +200,20 @@ struct sca3000_state {
  **/
 struct sca3000_chip_info {
 	const char		*name;
-	const char		*scale;
+	unsigned int		scale;
 	bool			temp_output;
 	int			measurement_mode_freq;
 	int			option_mode_1;
 	int			option_mode_1_freq;
 	int			option_mode_2;
 	int			option_mode_2_freq;
+	int			mot_det_mult_xz[6];
+	int			mot_det_mult_y[7];
 };
 
-/**
- * sca3000_read_data() read a series of values from the device
- * @dev:		device
- * @reg_address_high:	start address (decremented read)
- * @rx:			pointer where received data is placed. Callee
- *			responsible for freeing this.
- * @len:		number of bytes to read
- *
- * The main lock must be held.
- **/
-int sca3000_read_data(struct sca3000_state *st,
-		      u8 reg_address_high,
-		      u8 **rx_p,
-		      int len);
+int sca3000_read_data_short(struct sca3000_state *st,
+			    u8 reg_address_high,
+			    int len);
 
 /**
  * sca3000_write_reg() write a single register
@@ -233,29 +224,6 @@ int sca3000_read_data(struct sca3000_state *st,
  **/
 int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val);
 
-/* Conversion function for use with the ring buffer when in 11bit mode */
-static inline int sca3000_11bit_convert(uint8_t msb, uint8_t lsb)
-{
-	int16_t val;
-
-	val = ((lsb >> 3) & 0x1C) | (msb << 5);
-	val |= (val & (1 << 12)) ? 0xE000 : 0;
-
-	return val;
-}
-
-static inline int sca3000_13bit_convert(uint8_t msb, uint8_t lsb)
-{
-	s16 val;
-
-	val = ((lsb >> 3) & 0x1F) | (msb << 5);
-	/* sign fill */
-	val |= (val & (1 << 12)) ? 0xE000 : 0;
-
-	return val;
-}
-
-
 #ifdef CONFIG_IIO_RING_BUFFER
 /**
  * sca3000_register_ring_funcs() setup the ring state change functions
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 6abf2b7..00704a5 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -42,93 +42,73 @@ enum sca3000_variant {
 static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
 	{
 		.name = "sca3000-d01",
-		.scale = " 0.0073575",
+		.scale = 7357,
 		.temp_output = true,
 		.measurement_mode_freq = 250,
 		.option_mode_1 = SCA3000_OP_MODE_BYPASS,
 		.option_mode_1_freq = 250,
+		.mot_det_mult_xz = {50, 100, 200, 350, 650, 1300},
+		.mot_det_mult_y = {50, 100, 150, 250, 450, 850, 1750},
 	}, {
 		.name = "sca3000-e02",
-		.scale = "0.00981",
+		.scale = 9810,
 		.measurement_mode_freq = 125,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
 		.option_mode_1_freq = 63,
+		.mot_det_mult_xz = {100, 150, 300, 550, 1050, 2050},
+		.mot_det_mult_y = {50, 100, 200, 350, 700, 1350, 2700},
 	}, {
 		.name = "sca3000-e04",
-		.scale = "0.01962",
+		.scale = 19620,
 		.measurement_mode_freq = 100,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
 		.option_mode_1_freq = 50,
 		.option_mode_2 = SCA3000_OP_MODE_WIDE,
 		.option_mode_2_freq = 400,
+		.mot_det_mult_xz = {200, 300, 600, 1100, 2100, 4100},
+		.mot_det_mult_y = {100, 200, 400, 7000, 1400, 2700, 54000},
 	}, {
 		.name = "sca3000-e05",
-		.scale = "0.0613125",
+		.scale = 61313,
 		.measurement_mode_freq = 200,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
 		.option_mode_1_freq = 50,
 		.option_mode_2 = SCA3000_OP_MODE_WIDE,
 		.option_mode_2_freq = 400,
+		.mot_det_mult_xz = {600, 900, 1700, 3200, 6100, 11900},
+		.mot_det_mult_y = {300, 600, 1200, 2000, 4100, 7800, 15600},
 	},
 };
 
-
 int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
 {
-	struct spi_transfer xfer = {
-		.bits_per_word = 8,
-		.len = 2,
-		.cs_change = 1,
-		.tx_buf = st->tx,
-	};
-	struct spi_message msg;
-
 	st->tx[0] = SCA3000_WRITE_REG(address);
 	st->tx[1] = val;
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-
-	return spi_sync(st->us, &msg);
+	return spi_write(st->us, st->tx, 2);
 }
 
-int sca3000_read_data(struct sca3000_state *st,
-		      uint8_t reg_address_high,
-		      u8 **rx_p,
-		      int len)
+int sca3000_read_data_short(struct sca3000_state *st,
+			    uint8_t reg_address_high,
+			    int len)
 {
-	int ret;
 	struct spi_message msg;
-	struct spi_transfer xfer = {
-		.bits_per_word = 8,
-		.len = len + 1,
-		.cs_change = 1,
-		.tx_buf = st->tx,
+	struct spi_transfer xfer[2] = {
+		{
+			.len = 1,
+			.tx_buf = st->tx,
+		}, {
+			.len = len,
+			.rx_buf = st->rx,
+		}
 	};
-
-	*rx_p = kmalloc(len + 1, GFP_KERNEL);
-	if (*rx_p == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	xfer.rx_buf = *rx_p;
 	st->tx[0] = SCA3000_READ_REG(reg_address_high);
 	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-
-	ret = spi_sync(st->us, &msg);
-
-	if (ret) {
-		dev_err(get_device(&st->us->dev), "problem reading register");
-		goto error_free_rx;
-	}
-
-	return 0;
-error_free_rx:
-	kfree(*rx_p);
-error_ret:
-	return ret;
+	spi_message_add_tail(&xfer[0], &msg);
+	spi_message_add_tail(&xfer[1], &msg);
 
+	return spi_sync(st->us, &msg);
 }
+
 /**
  * sca3000_reg_lock_on() test if the ctrl register lock is on
  *
@@ -136,17 +116,13 @@ error_ret:
  **/
 static int sca3000_reg_lock_on(struct sca3000_state *st)
 {
-	u8 *rx;
 	int ret;
 
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_STATUS, &rx, 1);
-
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_STATUS, 1);
 	if (ret < 0)
 		return ret;
-	ret = !(rx[1] & SCA3000_LOCKED);
-	kfree(rx);
 
-	return ret;
+	return !(st->rx[0] & SCA3000_LOCKED);
 }
 
 /**
@@ -161,19 +137,15 @@ static int __sca3000_unlock_reg_lock(struct sca3000_state *st)
 	struct spi_message msg;
 	struct spi_transfer xfer[3] = {
 		{
-			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.tx_buf = st->tx,
 		}, {
-			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.tx_buf = st->tx + 2,
 		}, {
-			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.tx_buf = st->tx + 4,
 		},
 	};
@@ -236,8 +208,7 @@ error_ret:
  * Lock must be held.
  **/
 static int sca3000_read_ctrl_reg(struct sca3000_state *st,
-				 u8 ctrl_reg,
-				 u8 **rx_p)
+				 u8 ctrl_reg)
 {
 	int ret;
 
@@ -253,8 +224,11 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_CTRL_SEL, ctrl_reg);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_CTRL_DATA, rx_p, 1);
-
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_CTRL_DATA, 1);
+	if (ret)
+		goto error_ret;
+	else
+		return st->rx[0];
 error_ret:
 	return ret;
 }
@@ -267,20 +241,18 @@ error_ret:
  **/
 static int sca3000_check_status(struct device *dev)
 {
-	u8 *rx;
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = indio_dev->dev_data;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_STATUS, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_STATUS, 1);
 	if (ret < 0)
 		goto error_ret;
-	if (rx[1] & SCA3000_EEPROM_CS_ERROR)
+	if (st->rx[0] & SCA3000_EEPROM_CS_ERROR)
 		dev_err(dev, "eeprom error\n");
-	if (rx[1] & SCA3000_SPI_FRAME_ERROR)
+	if (st->rx[0] & SCA3000_SPI_FRAME_ERROR)
 		dev_err(dev, "Previous SPI Frame was corrupt\n");
-	kfree(rx);
 
 error_ret:
 	mutex_unlock(&st->lock);
@@ -288,45 +260,6 @@ error_ret:
 }
 #endif /* SCA3000_DEBUG */
 
-/**
- * sca3000_read_13bit_signed() sysfs interface to read 13 bit signed registers
- *
- * These are described as signed 12 bit on the data sheet, which appears
- * to be a conventional 2's complement 13 bit.
- **/
-static ssize_t sca3000_read_13bit_signed(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	int len = 0, ret;
-	int val;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 *rx;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct sca3000_state *st = indio_dev->dev_data;
-
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, this_attr->address, &rx, 2);
-	if (ret < 0)
-		goto error_ret;
-	val = sca3000_13bit_convert(rx[1], rx[2]);
-	len += sprintf(buf + len, "%d\n", val);
-	kfree(rx);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
-static ssize_t sca3000_show_scale(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = dev_info->dev_data;
-	return sprintf(buf, "%s\n", st->info->scale);
-}
-
 static ssize_t sca3000_show_name(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -346,18 +279,14 @@ static ssize_t sca3000_show_rev(struct device *dev,
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct sca3000_state *st = dev_info->dev_data;
 
-	u8 *rx;
-
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_REVID, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_REVID, 1);
 	if (ret < 0)
 		goto error_ret;
 	len += sprintf(buf + len,
 		       "major=%d, minor=%d\n",
-		       rx[1] & SCA3000_REVID_MAJOR_MASK,
-		       rx[1] & SCA3000_REVID_MINOR_MASK);
-	kfree(rx);
-
+		       st->rx[0] & SCA3000_REVID_MAJOR_MASK,
+		       st->rx[0] & SCA3000_REVID_MINOR_MASK);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -410,15 +339,14 @@ sca3000_show_measurement_mode(struct device *dev,
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct sca3000_state *st = dev_info->dev_data;
 	int len = 0, ret;
-	u8 *rx;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
 	/* mask bottom 2 bits - only ones that are relevant */
-	rx[1] &= 0x03;
-	switch (rx[1]) {
+	st->rx[0] &= 0x03;
+	switch (st->rx[0]) {
 	case SCA3000_MEAS_MODE_NORMAL:
 		len += sprintf(buf + len, "0 - normal mode\n");
 		break;
@@ -462,7 +390,6 @@ sca3000_store_measurement_mode(struct device *dev,
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct sca3000_state *st = dev_info->dev_data;
 	int ret;
-	u8 *rx;
 	int mask = 0x03;
 	long val;
 
@@ -470,20 +397,18 @@ sca3000_store_measurement_mode(struct device *dev,
 	ret = strict_strtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
-	rx[1] &= ~mask;
-	rx[1] |= (val & mask);
-	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE, rx[1]);
+	st->rx[0] &= ~mask;
+	st->rx[0] |= (val & mask);
+	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE, st->rx[0]);
 	if (ret)
-		goto error_free_rx;
+		goto error_ret;
 	mutex_unlock(&st->lock);
 
 	return len;
 
-error_free_rx:
-	kfree(rx);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -507,16 +432,72 @@ static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 
 static IIO_DEV_ATTR_NAME(sca3000_show_name);
 static IIO_DEV_ATTR_REV(sca3000_show_rev);
-static IIO_DEVICE_ATTR(accel_scale, S_IRUGO, sca3000_show_scale,
-		       NULL, 0);
 
-static IIO_DEV_ATTR_ACCEL_X(sca3000_read_13bit_signed,
-			    SCA3000_REG_ADDR_X_MSB);
-static IIO_DEV_ATTR_ACCEL_Y(sca3000_read_13bit_signed,
-			    SCA3000_REG_ADDR_Y_MSB);
-static IIO_DEV_ATTR_ACCEL_Z(sca3000_read_13bit_signed,
-			    SCA3000_REG_ADDR_Z_MSB);
+#define SCA3000_INFO_MASK			\
+	(1 << IIO_CHAN_INFO_SCALE_SHARED)
+#define SCA3000_EVENT_MASK					\
+	(IIO_EV_BIT(IIO_EV_TYPE_MAG, IIO_EV_DIR_RISING))
+
+static struct iio_chan_spec sca3000_channels[] = {
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X, SCA3000_INFO_MASK,
+		 0, 0, IIO_ST('s', 11, 16, 5),
+		 SCA3000_EVENT_MASK, NULL),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y, SCA3000_INFO_MASK,
+		 1, 1, IIO_ST('s', 11, 16, 5),
+		 SCA3000_EVENT_MASK, NULL),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z, SCA3000_INFO_MASK,
+		 2, 2, IIO_ST('s', 11, 16, 5),
+		 SCA3000_EVENT_MASK, NULL),
+};
 
+static u8 sca3000_addresses[3][3] = {
+	[0] = {SCA3000_REG_ADDR_X_MSB, SCA3000_REG_CTRL_SEL_MD_X_TH,
+	       SCA3000_MD_CTRL_OR_X},
+	[1] = {SCA3000_REG_ADDR_Y_MSB, SCA3000_REG_CTRL_SEL_MD_Y_TH,
+	       SCA3000_MD_CTRL_OR_Y},
+	[2] = {SCA3000_REG_ADDR_Z_MSB, SCA3000_REG_CTRL_SEL_MD_Z_TH,
+	       SCA3000_MD_CTRL_OR_Z},
+};
+
+static int sca3000_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long mask)
+{
+	struct sca3000_state *st = indio_dev->dev_data;
+	int ret;
+	u8 address;
+
+	switch (mask) {
+	case 0:
+		mutex_lock(&st->lock);
+		if (st->mo_det_use_count) {
+			mutex_unlock(&st->lock);
+			return -EBUSY;
+		}
+		address = sca3000_addresses[chan->address][0];
+		ret = sca3000_read_data_short(st, address, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
+		*val = ((*val) << (sizeof(*val)*8 - 13)) >>
+			(sizeof(*val)*8 - 13);
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		*val = 0;
+		if (chan->type == IIO_ACCEL)
+			*val2 = st->info->scale;
+		else /* temperature */
+			*val2 = 555556;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
 
 /**
  * sca3000_read_av_freq() sysfs function to get available frequencies
@@ -532,15 +513,16 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = indio_dev->dev_data;
-	int len = 0, ret;
-	u8 *rx;
+	int len = 0, ret, val;
+
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto error_ret;
-	rx[1] &= 0x03;
-	switch (rx[1]) {
+
+	switch (val & 0x03) {
 	case SCA3000_MEAS_MODE_NORMAL:
 		len += sprintf(buf + len, "%d %d %d\n",
 			       st->info->measurement_mode_freq,
@@ -560,7 +542,6 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 			       st->info->option_mode_2_freq/4);
 		break;
 	}
-	kfree(rx);
 	return len;
 error_ret:
 	return ret;
@@ -575,12 +556,11 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 					  int *base_freq)
 {
 	int ret;
-	u8 *rx;
 
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
-	switch (0x03 & rx[1]) {
+	switch (0x03 & st->rx[0]) {
 	case SCA3000_MEAS_MODE_NORMAL:
 		*base_freq = info->measurement_mode_freq;
 		break;
@@ -591,7 +571,6 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 		*base_freq = info->option_mode_2_freq;
 		break;
 	}
-	kfree(rx);
 error_ret:
 	return ret;
 }
@@ -605,18 +584,19 @@ static ssize_t sca3000_read_frequency(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = indio_dev->dev_data;
-	int ret, len = 0, base_freq = 0;
-	u8 *rx;
+	int ret, len = 0, base_freq = 0, val;
+
 	mutex_lock(&st->lock);
 	ret = __sca3000_get_base_freq(st, st->info, &base_freq);
 	if (ret)
 		goto error_ret_mut;
-	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL, &rx);
+	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto error_ret;
+	val = ret;
 	if (base_freq > 0)
-		switch (rx[1]&0x03) {
+		switch (val & 0x03) {
 		case 0x00:
 		case 0x03:
 			len = sprintf(buf, "%d\n", base_freq);
@@ -628,7 +608,7 @@ static ssize_t sca3000_read_frequency(struct device *dev,
 			len = sprintf(buf, "%d\n", base_freq/4);
 			break;
 	}
-	kfree(rx);
+
 	return len;
 error_ret_mut:
 	mutex_unlock(&st->lock);
@@ -647,7 +627,7 @@ static ssize_t sca3000_set_frequency(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = indio_dev->dev_data;
 	int ret, base_freq = 0;
-	u8 *rx;
+	int ctrlval;
 	long val;
 
 	ret = strict_strtol(buf, 10, &val);
@@ -660,21 +640,23 @@ static ssize_t sca3000_set_frequency(struct device *dev,
 	if (ret)
 		goto error_free_lock;
 
-	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL, &rx);
-	if (ret)
+	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
+	if (ret < 0)
 		goto error_free_lock;
+	ctrlval = ret;
 	/* clear the bits */
-	rx[1] &= ~0x03;
+	ctrlval &= ~0x03;
 
 	if (val == base_freq/2) {
-		rx[1] |= SCA3000_OUT_CTRL_BUF_DIV_2;
+		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_2;
 	} else if (val == base_freq/4) {
-		rx[1] |= SCA3000_OUT_CTRL_BUF_DIV_4;
+		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_4;
 	} else if (val != base_freq) {
 		ret = -EINVAL;
 		goto error_free_lock;
 	}
-	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL, rx[1]);
+	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
+				     ctrlval);
 error_free_lock:
 	mutex_unlock(&st->lock);
 
@@ -704,17 +686,14 @@ static ssize_t sca3000_read_temp(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = indio_dev->dev_data;
-	int len = 0, ret;
+	int ret;
 	int val;
-	u8 *rx;
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_TEMP_MSB, &rx, 2);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_TEMP_MSB, 2);
 	if (ret < 0)
 		goto error_ret;
-	val = ((rx[1]&0x3F) << 3) | ((rx[2] & 0xE0) >> 5);
-	len += sprintf(buf + len, "%d\n", val);
-	kfree(rx);
+	val = ((st->rx[0] & 0x3F) << 3) | ((st->rx[1] & 0xE0) >> 5);
 
-	return len;
+	return sprintf(buf, "%d\n", val);
 
 error_ret:
 	return ret;
@@ -725,80 +704,72 @@ static IIO_CONST_ATTR_TEMP_SCALE("0.555556");
 static IIO_CONST_ATTR_TEMP_OFFSET("-214.6");
 
 /**
- * sca3000_show_thresh() sysfs query of a threshold
+ * sca3000_read_thresh() - query of a threshold
  **/
-static ssize_t sca3000_show_thresh(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
+static int sca3000_read_thresh(struct iio_dev *indio_dev,
+			       int e,
+			       int *val)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	int ret, i;
 	struct sca3000_state *st = indio_dev->dev_data;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int len = 0, ret;
-	u8 *rx;
-
+	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
 	mutex_lock(&st->lock);
-	ret = sca3000_read_ctrl_reg(st,
-				    this_attr->address,
-				    &rx);
+	ret = sca3000_read_ctrl_reg(st, sca3000_addresses[num][1]);
 	mutex_unlock(&st->lock);
-	if (ret)
+	if (ret < 0)
 		return ret;
-	len += sprintf(buf + len, "%d\n", rx[1]);
-	kfree(rx);
+	*val = 0;
+	if (num == 1)
+		for_each_set_bit(i, (unsigned long *)&ret,
+				 ARRAY_SIZE(st->info->mot_det_mult_y))
+			*val += st->info->mot_det_mult_y[i];
+	else
+		for_each_set_bit(i, (unsigned long *)&ret,
+				 ARRAY_SIZE(st->info->mot_det_mult_xz))
+			*val += st->info->mot_det_mult_xz[i];
 
-	return len;
+	return 0;
 }
 
 /**
- * sca3000_write_thresh() sysfs control of threshold
+ * sca3000_write_thresh() control of threshold
  **/
-static ssize_t sca3000_write_thresh(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
+static int sca3000_write_thresh(struct iio_dev *indio_dev,
+				    int e,
+				    int val)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = indio_dev->dev_data;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
 	int ret;
-	long val;
+	int i;
+	u8 nonlinear = 0;
+
+	if (num == 1) {
+		i = ARRAY_SIZE(st->info->mot_det_mult_y);
+		while (i > 0)
+			if (val >= st->info->mot_det_mult_y[--i]) {
+				nonlinear |= (1 << i);
+				val -= st->info->mot_det_mult_y[i];
+			}
+	} else {
+		i = ARRAY_SIZE(st->info->mot_det_mult_xz);
+		while (i > 0)
+			if (val >= st->info->mot_det_mult_xz[--i]) {
+				nonlinear |= (1 << i);
+				val -= st->info->mot_det_mult_xz[i];
+			}
+	}
 
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		return ret;
 	mutex_lock(&st->lock);
-	ret = sca3000_write_ctrl_reg(st, this_attr->address, val);
+	ret = sca3000_write_ctrl_reg(st, sca3000_addresses[num][1], nonlinear);
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : len;
+	return ret;
 }
 
-static IIO_DEVICE_ATTR(accel_x_raw_mag_rising_value,
-		S_IRUGO | S_IWUSR,
-		sca3000_show_thresh,
-		sca3000_write_thresh,
-		SCA3000_REG_CTRL_SEL_MD_X_TH);
-
-static IIO_DEVICE_ATTR(accel_y_raw_mag_rising_value,
-		S_IRUGO | S_IWUSR,
-		sca3000_show_thresh,
-		sca3000_write_thresh,
-		SCA3000_REG_CTRL_SEL_MD_Y_TH);
-
-static IIO_DEVICE_ATTR(accel_z_raw_mag_rising_value,
-		S_IRUGO | S_IWUSR,
-		sca3000_show_thresh,
-		sca3000_write_thresh,
-		SCA3000_REG_CTRL_SEL_MD_Z_TH);
-
 static struct attribute *sca3000_attributes[] = {
 	&iio_dev_attr_name.dev_attr.attr,
 	&iio_dev_attr_revision.dev_attr.attr,
-	&iio_dev_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_accel_x_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_z_raw.dev_attr.attr,
 	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
 	&iio_dev_attr_measurement_mode.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
@@ -809,10 +780,6 @@ static struct attribute *sca3000_attributes[] = {
 static struct attribute *sca3000_attributes_with_temp[] = {
 	&iio_dev_attr_name.dev_attr.attr,
 	&iio_dev_attr_revision.dev_attr.attr,
-	&iio_dev_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_accel_x_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_z_raw.dev_attr.attr,
 	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
 	&iio_dev_attr_measurement_mode.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
@@ -836,134 +803,102 @@ static const struct attribute_group sca3000_attribute_group_with_temp = {
 /* depending on event, push to the ring buffer event chrdev or the event one */
 
 /**
- * sca3000_interrupt_handler_bh() - handling ring and non ring events
+ * sca3000_event_handler() - handling ring and non ring events
  *
  * This function is complicated by the fact that the devices can signify ring
  * and non ring events via the same interrupt line and they can only
  * be distinguished via a read of the relevant status register.
  **/
-static void sca3000_interrupt_handler_bh(struct work_struct *work_s)
+static irqreturn_t sca3000_event_handler(int irq, void *private)
 {
-	struct sca3000_state *st
-		= container_of(work_s, struct sca3000_state,
-			       interrupt_handler_ws);
-	u8 *rx;
-	int ret;
+	struct iio_dev *indio_dev = private;
+	struct sca3000_state *st;
+	int ret, val;
+	s64 last_timestamp = iio_get_time_ns();
 
+	st = indio_dev->dev_data;
 	/* Could lead if badly timed to an extra read of status reg,
 	 * but ensures no interrupt is missed.
 	 */
-	enable_irq(st->us->irq);
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_INT_STATUS,
-				&rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_STATUS, 1);
+	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto done;
 
-	sca3000_ring_int_process(rx[1], st->indio_dev->ring);
+	sca3000_ring_int_process(val, st->indio_dev->ring);
 
-	if (rx[1] & SCA3000_INT_STATUS_FREE_FALL)
+	if (val & SCA3000_INT_STATUS_FREE_FALL)
 		iio_push_event(st->indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_X_AND_Y_AND_Z,
 						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_FALLING),
-			       st->last_timestamp);
+			       last_timestamp);
 
-	if (rx[1] & SCA3000_INT_STATUS_Y_TRIGGER)
+	if (val & SCA3000_INT_STATUS_Y_TRIGGER)
 		iio_push_event(st->indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_Y,
 						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
-			       st->last_timestamp);
+			       last_timestamp);
 
-	if (rx[1] & SCA3000_INT_STATUS_X_TRIGGER)
+	if (val & SCA3000_INT_STATUS_X_TRIGGER)
 		iio_push_event(st->indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_X,
 						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
-			       st->last_timestamp);
+			       last_timestamp);
 
-	if (rx[1] & SCA3000_INT_STATUS_Z_TRIGGER)
+	if (val & SCA3000_INT_STATUS_Z_TRIGGER)
 		iio_push_event(st->indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_Z,
 						  IIO_EV_TYPE_MAG,
 						  IIO_EV_DIR_RISING),
-			       st->last_timestamp);
+			       last_timestamp);
 
 done:
-	kfree(rx);
-	return;
+	return IRQ_HANDLED;
 }
 
 /**
- * sca3000_handler_th() handles all interrupt events from device
- *
- * These devices deploy unified interrupt status registers meaning
- * all interrupts must be handled together
+ * sca3000_read_event_config() what events are enabled
  **/
-static int sca3000_handler_th(struct iio_dev *dev_info,
-			      int index,
-			      s64 timestamp,
-			      int no_test)
+static int sca3000_read_event_config(struct iio_dev *indio_dev,
+				     int e)
 {
-	struct sca3000_state *st = dev_info->dev_data;
-
-	st->last_timestamp = timestamp;
-	schedule_work(&st->interrupt_handler_ws);
-
-	return 0;
-}
-
-/**
- * sca3000_query_mo_det() is motion detection enabled for this axis
- *
- * First queries if motion detection is enabled and then if this axis is
- * on.
- **/
-static ssize_t sca3000_query_mo_det(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
 	struct sca3000_state *st = indio_dev->dev_data;
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
-	int ret, len = 0;
-	u8 *rx;
+	int ret;
 	u8 protect_mask = 0x03;
+	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
 
 	/* read current value of mode register */
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
 
-	if ((rx[1]&protect_mask) != SCA3000_MEAS_MODE_MOT_DET)
-		len += sprintf(buf + len, "0\n");
+	if ((st->rx[0] & protect_mask) != SCA3000_MEAS_MODE_MOT_DET)
+		ret = 0;
 	else {
-		kfree(rx);
-		ret = sca3000_read_ctrl_reg(st,
-					    SCA3000_REG_CTRL_SEL_MD_CTRL,
-					    &rx);
-		if (ret)
+		ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
+		if (ret < 0)
 			goto error_ret;
 		/* only supporting logical or's for now */
-		len += sprintf(buf + len, "%d\n",
-			       (rx[1] & this_attr->mask) ? 1 : 0);
+		ret = !!(ret & sca3000_addresses[num][2]);
 	}
-	kfree(rx);
 error_ret:
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : len;
+	return ret;
 }
 /**
  * sca3000_query_free_fall_mode() is free fall mode enabled
@@ -973,80 +908,20 @@ static ssize_t sca3000_query_free_fall_mode(struct device *dev,
 					    char *buf)
 {
 	int ret, len;
-	u8 *rx;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct sca3000_state *st = indio_dev->dev_data;
+	int val;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	val = st->rx[0];
 	mutex_unlock(&st->lock);
-	if (ret)
+	if (ret < 0)
 		return ret;
 	len = sprintf(buf, "%d\n",
-		      !!(rx[1] & SCA3000_FREE_FALL_DETECT));
-	kfree(rx);
-
+		      !!(val & SCA3000_FREE_FALL_DETECT));
 	return len;
 }
-/**
- * sca3000_query_ring_int() is the hardware ring status interrupt enabled
- **/
-static ssize_t sca3000_query_ring_int(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
-	int ret, len;
-	u8 *rx;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
-	struct sca3000_state *st = indio_dev->dev_data;
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_INT_MASK, &rx, 1);
-	mutex_unlock(&st->lock);
-	if (ret)
-		return ret;
-	len = sprintf(buf, "%d\n", (rx[1] & this_attr->mask) ? 1 : 0);
-	kfree(rx);
-
-	return len;
-}
-/**
- * sca3000_set_ring_int() set state of ring status interrupt
- **/
-static ssize_t sca3000_set_ring_int(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf,
-				      size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
-	struct sca3000_state *st = indio_dev->dev_data;
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
-
-	long val;
-	int ret;
-	u8 *rx;
-
-	mutex_lock(&st->lock);
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_INT_MASK, &rx, 1);
-	if (ret)
-		goto error_ret;
-	if (val)
-		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_INT_MASK,
-					rx[1] | this_attr->mask);
-	else
-		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_INT_MASK,
-					rx[1] & ~this_attr->mask);
-	kfree(rx);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
 
 /**
  * sca3000_set_free_fall_mode() simple on off control for free fall int
@@ -1065,7 +940,6 @@ static ssize_t sca3000_set_free_fall_mode(struct device *dev,
 	struct sca3000_state *st = indio_dev->dev_data;
 	long val;
 	int ret;
-	u8 *rx;
 	u8 protect_mask = SCA3000_FREE_FALL_DETECT;
 
 	mutex_lock(&st->lock);
@@ -1074,20 +948,18 @@ static ssize_t sca3000_set_free_fall_mode(struct device *dev,
 		goto error_ret;
 
 	/* read current value of mode register */
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
 
 	/*if off and should be on*/
-	if (val && !(rx[1] & protect_mask))
+	if (val && !(st->rx[0] & protect_mask))
 		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					(rx[1] | SCA3000_FREE_FALL_DETECT));
+					(st->rx[0] | SCA3000_FREE_FALL_DETECT));
 	/* if on and should be off */
-	else if (!val && (rx[1]&protect_mask))
+	else if (!val && (st->rx[0] & protect_mask))
 		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					(rx[1] & ~protect_mask));
-
-	kfree(rx);
+					(st->rx[0] & ~protect_mask));
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -1103,73 +975,65 @@ error_ret:
  * There is a complexity in knowing which mode to return to when
  * this mode is disabled.  Currently normal mode is assumed.
  **/
-static ssize_t sca3000_set_mo_det(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf,
-				  size_t len)
+static int sca3000_write_event_config(struct iio_dev *indio_dev,
+				      int e,
+				      struct iio_event_handler_list *list_el,
+				      int state)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
 	struct sca3000_state *st = indio_dev->dev_data;
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
-	long val;
-	int ret;
-	u8 *rx;
+	int ret, ctrlval;
 	u8 protect_mask = 0x03;
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		return ret;
+	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
 
 	mutex_lock(&st->lock);
 	/* First read the motion detector config to find out if
 	 * this axis is on*/
-	ret = sca3000_read_ctrl_reg(st,
-				    SCA3000_REG_CTRL_SEL_MD_CTRL,
-				    &rx);
-	if (ret)
+	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
+	if (ret < 0)
 		goto exit_point;
+	ctrlval = ret;
 	/* Off and should be on */
-	if (val && !(rx[1] & this_attr->mask)) {
+	if (state && !(ctrlval & sca3000_addresses[num][2])) {
 		ret = sca3000_write_ctrl_reg(st,
 					     SCA3000_REG_CTRL_SEL_MD_CTRL,
-					     rx[1] | this_attr->mask);
+					     ctrlval |
+					     sca3000_addresses[num][2]);
 		if (ret)
-			goto exit_point_free_rx;
+			goto exit_point;
 		st->mo_det_use_count++;
-	} else if (!val && (rx[1]&this_attr->mask)) {
+	} else if (!state && (ctrlval & sca3000_addresses[num][2])) {
 		ret = sca3000_write_ctrl_reg(st,
 					     SCA3000_REG_CTRL_SEL_MD_CTRL,
-					     rx[1] & ~(this_attr->mask));
+					     ctrlval &
+					     ~(sca3000_addresses[num][2]));
 		if (ret)
-			goto exit_point_free_rx;
+			goto exit_point;
 		st->mo_det_use_count--;
-	} else /* relies on clean state for device on boot */
-		goto exit_point_free_rx;
-	kfree(rx);
+	}
+
 	/* read current value of mode register */
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto exit_point;
 	/*if off and should be on*/
 	if ((st->mo_det_use_count)
-	    && ((rx[1]&protect_mask) != SCA3000_MEAS_MODE_MOT_DET))
+	    && ((st->rx[0] & protect_mask) != SCA3000_MEAS_MODE_MOT_DET))
 		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					(rx[1] & ~protect_mask)
+					(st->rx[0] & ~protect_mask)
 					| SCA3000_MEAS_MODE_MOT_DET);
 	/* if on and should be off */
 	else if (!(st->mo_det_use_count)
-		 && ((rx[1]&protect_mask) == SCA3000_MEAS_MODE_MOT_DET))
+		 && ((st->rx[0] & protect_mask) == SCA3000_MEAS_MODE_MOT_DET))
 		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					(rx[1] & ~protect_mask));
-exit_point_free_rx:
-	kfree(rx);
+					(st->rx[0] & ~protect_mask));
 exit_point:
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : len;
+	return ret;
 }
 
 /* Shared event handler for all events as single event status register */
-IIO_EVENT_SH(all, &sca3000_handler_th);
+IIO_EVENT_SH(all, NULL);
 
 /* Free fall detector related event attribute */
 IIO_EVENT_ATTR_NAMED_SH(accel_xayaz_mag_falling_en,
@@ -1179,51 +1043,13 @@ IIO_EVENT_ATTR_NAMED_SH(accel_xayaz_mag_falling_en,
 			sca3000_set_free_fall_mode,
 			0);
 
-IIO_CONST_ATTR_NAMED(accel_xayaz_mag_falling_period,
-		     accel_x&y&z_mag_falling_period,
-		     "0.226");
-
-/* Motion detector related event attributes */
-IIO_EVENT_ATTR_SH(accel_x_mag_rising_en,
-		  iio_event_all,
-		  sca3000_query_mo_det,
-		  sca3000_set_mo_det,
-		  SCA3000_MD_CTRL_OR_X);
-
-IIO_EVENT_ATTR_SH(accel_y_mag_rising_en,
-		  iio_event_all,
-		  sca3000_query_mo_det,
-		  sca3000_set_mo_det,
-		  SCA3000_MD_CTRL_OR_Y);
-
-IIO_EVENT_ATTR_SH(accel_z_mag_rising_en,
-		  iio_event_all,
-		  sca3000_query_mo_det,
-		  sca3000_set_mo_det,
-		  SCA3000_MD_CTRL_OR_Z);
-
-/* Hardware ring buffer related event attributes */
-IIO_EVENT_ATTR_RING_50_FULL_SH(iio_event_all,
-			       sca3000_query_ring_int,
-			       sca3000_set_ring_int,
-			       SCA3000_INT_MASK_RING_HALF);
-
-IIO_EVENT_ATTR_RING_75_FULL_SH(iio_event_all,
-			       sca3000_query_ring_int,
-			       sca3000_set_ring_int,
-			       SCA3000_INT_MASK_RING_THREE_QUARTER);
+static IIO_CONST_ATTR_NAMED(accel_xayaz_mag_falling_period,
+			    accel_x&y&z_mag_falling_period,
+			    "0.226");
 
 static struct attribute *sca3000_event_attributes[] = {
 	&iio_event_attr_accel_xayaz_mag_falling_en.dev_attr.attr,
 	&iio_const_attr_accel_xayaz_mag_falling_period.dev_attr.attr,
-	&iio_event_attr_accel_x_mag_rising_en.dev_attr.attr,
-	&iio_dev_attr_accel_x_raw_mag_rising_value.dev_attr.attr,
-	&iio_event_attr_accel_y_mag_rising_en.dev_attr.attr,
-	&iio_dev_attr_accel_y_raw_mag_rising_value.dev_attr.attr,
-	&iio_event_attr_accel_z_mag_rising_en.dev_attr.attr,
-	&iio_dev_attr_accel_z_raw_mag_rising_value.dev_attr.attr,
-	&iio_event_attr_ring_50_full.dev_attr.attr,
-	&iio_event_attr_ring_75_full.dev_attr.attr,
 	NULL,
 };
 
@@ -1241,70 +1067,50 @@ static struct attribute_group sca3000_event_attribute_group = {
 static int sca3000_clean_setup(struct sca3000_state *st)
 {
 	int ret;
-	u8 *rx;
 
 	mutex_lock(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_INT_STATUS, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_STATUS, 1);
 	if (ret)
 		goto error_ret;
-	kfree(rx);
 
 	/* Turn off all motion detection channels */
-	ret = sca3000_read_ctrl_reg(st,
-				    SCA3000_REG_CTRL_SEL_MD_CTRL,
-				    &rx);
-	if (ret)
+	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
+	if (ret < 0)
 		goto error_ret;
-	ret = sca3000_write_ctrl_reg(st,
-				     SCA3000_REG_CTRL_SEL_MD_CTRL,
-				     rx[1] & SCA3000_MD_CTRL_PROT_MASK);
-	kfree(rx);
+	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL,
+				     ret & SCA3000_MD_CTRL_PROT_MASK);
 	if (ret)
 		goto error_ret;
 
 	/* Disable ring buffer */
-	sca3000_read_ctrl_reg(st,
-			      SCA3000_REG_CTRL_SEL_OUT_CTRL,
-			      &rx);
-	/* Frequency of ring buffer sampling deliberately restricted to make
-	 * debugging easier - add control of this later */
-	ret = sca3000_write_ctrl_reg(st,
-				     SCA3000_REG_CTRL_SEL_OUT_CTRL,
-				     (rx[1] & SCA3000_OUT_CTRL_PROT_MASK)
+	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
+	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
+				     (ret & SCA3000_OUT_CTRL_PROT_MASK)
 				     | SCA3000_OUT_CTRL_BUF_X_EN
 				     | SCA3000_OUT_CTRL_BUF_Y_EN
 				     | SCA3000_OUT_CTRL_BUF_Z_EN
 				     | SCA3000_OUT_CTRL_BUF_DIV_4);
-	kfree(rx);
-
 	if (ret)
 		goto error_ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
-	ret = sca3000_read_data(st,
-			  SCA3000_REG_ADDR_INT_MASK,
-			  &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_ADDR_INT_MASK,
-				(rx[1] & SCA3000_INT_MASK_PROT_MASK)
+				(ret & SCA3000_INT_MASK_PROT_MASK)
 				| SCA3000_INT_MASK_ACTIVE_LOW);
-	kfree(rx);
 	if (ret)
 		goto error_ret;
 	/* Select normal measurement mode, free fall off, ring off */
 	/* Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
 	 * as that occurs in one of the example on the datasheet */
-	ret = sca3000_read_data(st,
-			  SCA3000_REG_ADDR_MODE,
-			  &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_write_reg(st,
-				SCA3000_REG_ADDR_MODE,
-				(rx[1] & SCA3000_MODE_PROT_MASK));
-	kfree(rx);
+	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
+				(st->rx[0] & SCA3000_MODE_PROT_MASK));
 	st->bpse = 11;
 
 error_ret:
@@ -1312,8 +1118,7 @@ error_ret:
 	return ret;
 }
 
-static int __devinit __sca3000_probe(struct spi_device *spi,
-				     enum sca3000_variant variant)
+static int __devinit sca3000_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
 	struct sca3000_state *st;
@@ -1325,75 +1130,63 @@ static int __devinit __sca3000_probe(struct spi_device *spi,
 	}
 	spi_set_drvdata(spi, st);
 
-	st->tx = kmalloc(sizeof(*st->tx)*6, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_clear_st;
-	}
-	st->rx = kmalloc(sizeof(*st->rx)*3, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
 	st->us = spi;
 	mutex_init(&st->lock);
-	st->info = &sca3000_spi_chip_info_tbl[variant];
+	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
+					      ->driver_data];
 
 	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
-		goto error_free_rx;
+		goto error_clear_st;
 	}
-
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->num_interrupt_lines = 1;
 	st->indio_dev->event_attrs = &sca3000_event_attribute_group;
 	if (st->info->temp_output)
 		st->indio_dev->attrs = &sca3000_attribute_group_with_temp;
-	else
+	else {
 		st->indio_dev->attrs = &sca3000_attribute_group;
+		st->indio_dev->channels = sca3000_channels;
+		st->indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
+	}
+	st->indio_dev->read_raw = &sca3000_read_raw;
+	st->indio_dev->read_event_value = &sca3000_read_thresh;
+	st->indio_dev->write_event_value = &sca3000_write_thresh;
+	st->indio_dev->read_event_config = &sca3000_read_event_config;
+	st->indio_dev->write_event_config = &sca3000_write_event_config;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
 	sca3000_configure_ring(st->indio_dev);
-
 	ret = iio_device_register(st->indio_dev);
 	if (ret < 0)
 		goto error_free_dev;
 	regdone = 1;
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  sca3000_channels,
+					  ARRAY_SIZE(sca3000_channels));
 	if (ret < 0)
 		goto error_unregister_dev;
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-		INIT_WORK(&st->interrupt_handler_ws,
-			  sca3000_interrupt_handler_bh);
-		ret = iio_register_interrupt_line(spi->irq,
-						  st->indio_dev,
-						  0,
-						  IRQF_TRIGGER_FALLING,
-						  "sca3000");
+		ret = request_threaded_irq(spi->irq,
+					   NULL,
+					   &sca3000_event_handler,
+					   IRQF_TRIGGER_FALLING,
+					   "sca3000",
+					   st->indio_dev);
 		if (ret)
 			goto error_unregister_ring;
-		/* RFC
-		 * Probably a common situation.  All interrupts need an ack
-		 * and there is only one handler so the complicated list system
-		 * is overkill.  At very least a simpler registration method
-		 * might be worthwhile.
-		 */
-		iio_add_event_to_list(
-			iio_event_attr_accel_z_mag_rising_en.listel,
-			&st->indio_dev
-			->interrupts[0]->ev_list);
 	}
 	sca3000_register_ring_funcs(st->indio_dev);
 	ret = sca3000_clean_setup(st);
 	if (ret)
-		goto error_unregister_interrupt_line;
+		goto error_free_irq;
 	return 0;
 
-error_unregister_interrupt_line:
+error_free_irq:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
+		free_irq(spi->irq, st->indio_dev);
 error_unregister_ring:
 	iio_ring_buffer_unregister(st->indio_dev->ring);
 error_unregister_dev:
@@ -1402,10 +1195,6 @@ error_free_dev:
 		iio_device_unregister(st->indio_dev);
 	else
 		iio_free_device(st->indio_dev);
-error_free_rx:
-	kfree(st->rx);
-error_free_tx:
-	kfree(st->tx);
 error_clear_st:
 	kfree(st);
 error_ret:
@@ -1415,20 +1204,19 @@ error_ret:
 static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
-	u8 *rx;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_INT_MASK, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_INT_MASK,
-				(rx[1] & ~(SCA3000_INT_MASK_RING_THREE_QUARTER
-					   | SCA3000_INT_MASK_RING_HALF
-					   | SCA3000_INT_MASK_ALL_INTS)));
+				(st->rx[0] &
+				 ~(SCA3000_INT_MASK_RING_THREE_QUARTER |
+				   SCA3000_INT_MASK_RING_HALF |
+				   SCA3000_INT_MASK_ALL_INTS)));
 error_ret:
-	kfree(rx);
+	mutex_unlock(&st->lock);
 	return ret;
-
 }
 
 static int sca3000_remove(struct spi_device *spi)
@@ -1441,87 +1229,44 @@ static int sca3000_remove(struct spi_device *spi)
 	if (ret)
 		return ret;
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(spi->irq, indio_dev);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	sca3000_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
-	kfree(st->tx);
-	kfree(st->rx);
 	kfree(st);
 
 	return 0;
 }
 
-/* These macros save on an awful lot of repeated code */
-#define SCA3000_VARIANT_PROBE(_name)				\
-	static int __devinit					\
-	sca3000_##_name##_probe(struct spi_device *spi)		\
-	{							\
-		return __sca3000_probe(spi, _name);		\
-	}
-
-#define SCA3000_VARIANT_SPI_DRIVER(_name)			\
-	struct spi_driver sca3000_##_name##_driver = {		\
-		.driver = {					\
-			.name = "sca3000_" #_name,		\
-			.owner = THIS_MODULE,			\
-		},						\
-		.probe = sca3000_##_name##_probe,		\
-		.remove = __devexit_p(sca3000_remove),		\
-	}
-
-SCA3000_VARIANT_PROBE(d01);
-static SCA3000_VARIANT_SPI_DRIVER(d01);
-
-SCA3000_VARIANT_PROBE(e02);
-static SCA3000_VARIANT_SPI_DRIVER(e02);
-
-SCA3000_VARIANT_PROBE(e04);
-static SCA3000_VARIANT_SPI_DRIVER(e04);
+static const struct spi_device_id sca3000_id[] = {
+	{"sca3000_d01", d01},
+	{"sca3000_e02", e02},
+	{"sca3000_e04", e04},
+	{"sca3000_e05", e05},
+	{}
+};
 
-SCA3000_VARIANT_PROBE(e05);
-static SCA3000_VARIANT_SPI_DRIVER(e05);
+static struct spi_driver sca3000_driver = {
+	.driver = {
+		.name = "sca3000",
+		.owner = THIS_MODULE,
+	},
+	.probe = sca3000_probe,
+	.remove = __devexit_p(sca3000_remove),
+	.id_table = sca3000_id,
+};
 
 static __init int sca3000_init(void)
 {
-	int ret;
-
-	ret = spi_register_driver(&sca3000_d01_driver);
-	if (ret)
-		goto error_ret;
-	ret = spi_register_driver(&sca3000_e02_driver);
-	if (ret)
-		goto error_unreg_d01;
-	ret = spi_register_driver(&sca3000_e04_driver);
-	if (ret)
-		goto error_unreg_e02;
-	ret = spi_register_driver(&sca3000_e05_driver);
-	if (ret)
-		goto error_unreg_e04;
-
-	return 0;
-
-error_unreg_e04:
-	spi_unregister_driver(&sca3000_e04_driver);
-error_unreg_e02:
-	spi_unregister_driver(&sca3000_e02_driver);
-error_unreg_d01:
-	spi_unregister_driver(&sca3000_d01_driver);
-error_ret:
-
-	return ret;
+	return spi_register_driver(&sca3000_driver);
 }
+module_init(sca3000_init);
 
 static __exit void sca3000_exit(void)
 {
-	spi_unregister_driver(&sca3000_e05_driver);
-	spi_unregister_driver(&sca3000_e04_driver);
-	spi_unregister_driver(&sca3000_e02_driver);
-	spi_unregister_driver(&sca3000_d01_driver);
+	spi_unregister_driver(&sca3000_driver);
 }
-
-module_init(sca3000_init);
 module_exit(sca3000_exit);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 44f9a56..8efd4f0 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -17,6 +17,8 @@
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/sched.h>
+#include <linux/poll.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -34,6 +36,44 @@
  * Currently scan elements aren't configured so it doesn't matter.
  */
 
+static int sca3000_read_data(struct sca3000_state *st,
+			    uint8_t reg_address_high,
+			    u8 **rx_p,
+			    int len)
+{
+	int ret;
+	struct spi_message msg;
+	struct spi_transfer xfer[2] = {
+		{
+			.len = 1,
+			.tx_buf = st->tx,
+		}, {
+			.len = len,
+		}
+	};
+	*rx_p = kmalloc(len, GFP_KERNEL);
+	if (*rx_p == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	xfer[1].rx_buf = *rx_p;
+	st->tx[0] = SCA3000_READ_REG(reg_address_high);
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer[0], &msg);
+	spi_message_add_tail(&xfer[1], &msg);
+	ret = spi_sync(st->us, &msg);
+	if (ret) {
+		dev_err(get_device(&st->us->dev), "problem reading register");
+		goto error_free_rx;
+	}
+
+	return 0;
+error_free_rx:
+	kfree(*rx_p);
+error_ret:
+	return ret;
+}
+
 /**
  * sca3000_read_first_n_hw_rb() - main ring access, pulls data from ring
  * @r:			the ring
@@ -45,8 +85,6 @@
  * Currently does not provide timestamps.  As the hardware doesn't add them they
  * can only be inferred approximately from ring buffer events such as 50% full
  * and knowledge of when buffer was last emptied.  This is left to userspace.
- *
- * Temporarily deliberately broken.
  **/
 static int sca3000_read_first_n_hw_rb(struct iio_ring_buffer *r,
 				      size_t count, char __user *buf,
@@ -56,54 +94,45 @@ static int sca3000_read_first_n_hw_rb(struct iio_ring_buffer *r,
 	struct iio_dev *indio_dev = hw_ring->private;
 	struct sca3000_state *st = indio_dev->dev_data;
 	u8 *rx;
-	s16 *samples;
 	int ret, i, num_available, num_read = 0;
 	int bytes_per_sample = 1;
-	u8 *datas;
-	u8 **data = &datas;
 
 	if (st->bpse == 11)
 		bytes_per_sample = 2;
 
 	mutex_lock(&st->lock);
-	/* Check how much data is available:
-	 * RFC: Implement an ioctl to not bother checking whether there
-	 * is enough data in the ring?  Afterall, if we are responding
-	 * to an interrupt we have a minimum content guaranteed so it
-	 * seems slight silly to waste time checking it is there.
-	 */
-	ret = sca3000_read_data(st,
-				SCA3000_REG_ADDR_BUF_COUNT,
-				&rx, 1);
+	if (count % bytes_per_sample) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_BUF_COUNT, 1);
 	if (ret)
 		goto error_ret;
 	else
-		num_available = rx[1];
-	/* num_available is the total number of samples available
+		num_available = st->rx[0];
+	/*
+	 * num_available is the total number of samples available
 	 * i.e. number of time points * number of channels.
 	 */
-	kfree(rx);
 	if (count > num_available * bytes_per_sample)
 		num_read = num_available*bytes_per_sample;
 	else
-		num_read = count - (count % (bytes_per_sample));
+		num_read = count;
 
-	/* Avoid the read request byte */
-	*dead_offset = 1;
 	ret = sca3000_read_data(st,
 				SCA3000_REG_ADDR_RING_OUT,
-				data, num_read);
-
-	/* Convert byte order and shift to default resolution */
-	if (st->bpse == 11) {
-		samples = (s16*)(*data+1);
-		for (i = 0; i < (num_read/2); i++) {
-			samples[i] = be16_to_cpup(
-					(__be16 *)&(samples[i]));
-			samples[i] >>= 3;
-		}
-	}
+				&rx, num_read);
+	if (ret)
+		goto error_ret;
+
+	for (i = 0; i < num_read; i++)
+		*(((u16 *)rx) + i) = be16_to_cpup((u16 *)rx + i);
 
+	if (copy_to_user(buf, rx, num_read))
+		ret = -EFAULT;
+	kfree(rx);
+	r->stufftoread = 0;
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -132,6 +161,76 @@ static IIO_RING_BYTES_PER_DATUM_ATTR;
 static IIO_RING_LENGTH_ATTR;
 
 /**
+ * sca3000_query_ring_int() is the hardware ring status interrupt enabled
+ **/
+static ssize_t sca3000_query_ring_int(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret, val;
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = ring->indio_dev;
+	struct sca3000_state *st = indio_dev->dev_data;
+
+	mutex_lock(&st->lock);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	val = st->rx[0];
+	mutex_unlock(&st->lock);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", !!(val & this_attr->address));
+}
+
+/**
+ * sca3000_set_ring_int() set state of ring status interrupt
+ **/
+static ssize_t sca3000_set_ring_int(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t len)
+{
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = ring->indio_dev;
+	struct sca3000_state *st = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	long val;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	if (ret)
+		goto error_ret;
+	if (val)
+		ret = sca3000_write_reg(st,
+					SCA3000_REG_ADDR_INT_MASK,
+					st->rx[0] | this_attr->address);
+	else
+		ret = sca3000_write_reg(st,
+					SCA3000_REG_ADDR_INT_MASK,
+					st->rx[0] & ~this_attr->address);
+error_ret:
+	mutex_unlock(&st->lock);
+
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(50_percent, S_IRUGO | S_IWUSR,
+		       sca3000_query_ring_int,
+		       sca3000_set_ring_int,
+		       SCA3000_INT_MASK_RING_HALF);
+
+static IIO_DEVICE_ATTR(75_percent, S_IRUGO | S_IWUSR,
+		       sca3000_query_ring_int,
+		       sca3000_set_ring_int,
+		       SCA3000_INT_MASK_RING_THREE_QUARTER);
+
+
+/**
  * sca3000_show_ring_bpse() -sysfs function to query bits per sample from ring
  * @dev: ring buffer device
  * @attr: this device attribute
@@ -142,20 +241,18 @@ static ssize_t sca3000_show_ring_bpse(struct device *dev,
 				      char *buf)
 {
 	int len = 0, ret;
-	u8 *rx;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
 	struct sca3000_state *st = indio_dev->dev_data;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
-	if (rx[1] & SCA3000_RING_BUF_8BIT)
+	if (st->rx[0] & SCA3000_RING_BUF_8BIT)
 		len = sprintf(buf, "s8/8\n");
 	else
 		len = sprintf(buf, "s11/16\n");
-	kfree(rx);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -178,20 +275,19 @@ static ssize_t sca3000_store_ring_bpse(struct device *dev,
 	struct iio_dev *indio_dev = ring->indio_dev;
 	struct sca3000_state *st = indio_dev->dev_data;
 	int ret;
-	u8 *rx;
 
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
-	if (strncmp(buf, "s8/8", 4) == 0) {
+	if (sysfs_streq(buf, "s8/8")) {
 		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					rx[1] | SCA3000_RING_BUF_8BIT);
+					st->rx[0] | SCA3000_RING_BUF_8BIT);
 		st->bpse = 8;
-	} else if (strncmp(buf, "s11/16", 5) == 0) {
+	} else if (sysfs_streq(buf, "s11/16")) {
 		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					rx[1] & ~SCA3000_RING_BUF_8BIT);
+					st->rx[0] & ~SCA3000_RING_BUF_8BIT);
 		st->bpse = 11;
 	} else
 		ret = -EINVAL;
@@ -201,32 +297,22 @@ error_ret:
 	return ret ? ret : len;
 }
 
-static IIO_SCAN_EL_C(accel_x, 0, 0, NULL);
-static IIO_SCAN_EL_C(accel_y, 1, 0, NULL);
-static IIO_SCAN_EL_C(accel_z, 2, 0, NULL);
-static IIO_CONST_ATTR(accel_type_available, "s8/8 s11/16");
-static IIO_DEVICE_ATTR(accel_type,
-		       S_IRUGO | S_IWUSR,
-		       sca3000_show_ring_bpse,
-		       sca3000_store_ring_bpse,
-		       0);
+static ssize_t sca3000_show_buffer_scale(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = ring->indio_dev;
+	struct sca3000_state *st = indio_dev->dev_data;
 
-static struct attribute *sca3000_scan_el_attrs[] = {
-	&iio_scan_el_accel_x.dev_attr.attr,
-	&iio_const_attr_accel_x_index.dev_attr.attr,
-	&iio_scan_el_accel_y.dev_attr.attr,
-	&iio_const_attr_accel_y_index.dev_attr.attr,
-	&iio_scan_el_accel_z.dev_attr.attr,
-	&iio_const_attr_accel_z_index.dev_attr.attr,
-	&iio_const_attr_accel_type_available.dev_attr.attr,
-	&iio_dev_attr_accel_type.dev_attr.attr,
-	NULL
-};
+	return sprintf(buf, "0.%06d\n", 4*st->info->scale);
+}
 
-static struct attribute_group sca3000_scan_el_group = {
-	.attrs = sca3000_scan_el_attrs,
-	.name = "scan_elements",
-};
+static IIO_DEVICE_ATTR(accel_scale,
+		       S_IRUGO,
+		       sca3000_show_buffer_scale,
+		       NULL,
+		       0);
 
 /*
  * Ring buffer attributes
@@ -238,6 +324,9 @@ static struct attribute *sca3000_ring_attributes[] = {
 	&dev_attr_length.attr,
 	&dev_attr_bytes_per_datum.attr,
 	&dev_attr_enable.attr,
+	&iio_dev_attr_50_percent.dev_attr.attr,
+	&iio_dev_attr_75_percent.dev_attr.attr,
+	&iio_dev_attr_accel_scale.dev_attr.attr,
 	NULL,
 };
 
@@ -263,11 +352,12 @@ static struct iio_ring_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
 	ring = kzalloc(sizeof *ring, GFP_KERNEL);
 	if (!ring)
 		return NULL;
+
 	ring->private = indio_dev;
 	buf = &ring->buf;
+	buf->stufftoread = 0;
 	iio_ring_buffer_init(buf, indio_dev);
 	buf->dev.type = &sca3000_ring_type;
-	device_initialize(&buf->dev);
 	buf->dev.parent = &indio_dev->dev;
 	dev_set_drvdata(&buf->dev, (void *)buf);
 
@@ -287,10 +377,14 @@ int sca3000_configure_ring(struct iio_dev *indio_dev)
 		return -ENOMEM;
 	indio_dev->modes |= INDIO_RING_HARDWARE_BUFFER;
 
-	indio_dev->ring->scan_el_attrs = &sca3000_scan_el_group;
 	indio_dev->ring->access.read_first_n = &sca3000_read_first_n_hw_rb;
 	indio_dev->ring->access.get_length = &sca3000_ring_get_length;
-	indio_dev->ring->access.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum;
+	indio_dev->ring->access.get_bytes_per_datum =
+		&sca3000_ring_get_bytes_per_datum;
+
+	iio_scan_mask_set(indio_dev->ring, 0);
+	iio_scan_mask_set(indio_dev->ring, 1);
+	iio_scan_mask_set(indio_dev->ring, 2);
 
 	return 0;
 }
@@ -305,22 +399,20 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 {
 	struct sca3000_state *st = indio_dev->dev_data;
 	int ret;
-	u8 *rx;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
 	if (state) {
 		printk(KERN_INFO "supposedly enabling ring buffer\n");
 		ret = sca3000_write_reg(st,
 					SCA3000_REG_ADDR_MODE,
-					(rx[1] | SCA3000_RING_BUF_ENABLE));
+					(st->rx[0] | SCA3000_RING_BUF_ENABLE));
 	} else
 		ret = sca3000_write_reg(st,
 					SCA3000_REG_ADDR_MODE,
-					(rx[1] & ~SCA3000_RING_BUF_ENABLE));
-	kfree(rx);
+					(st->rx[0] & ~SCA3000_RING_BUF_ENABLE));
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -357,13 +449,9 @@ void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
  **/
 void sca3000_ring_int_process(u8 val, struct iio_ring_buffer *ring)
 {
-	/*
-	if (val & SCA3000_INT_STATUS_THREE_QUARTERS)
-		iio_push_ring_event(ring,
-				    IIO_EVENT_CODE_RING_75_FULL,
-				    0);
-	else if (val & SCA3000_INT_STATUS_HALF)
-		iio_push_ring_event(ring,
-				    IIO_EVENT_CODE_RING_50_FULL, 0);
-	*/
+	if (val & (SCA3000_INT_STATUS_THREE_QUARTERS |
+		   SCA3000_INT_STATUS_HALF)) {
+		ring->stufftoread = true;
+		wake_up_interruptible(&ring->pollq);
+	}
 }
-- 
1.7.3.4
