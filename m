Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35752 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbcCZTu2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Mar 2016 15:50:28 -0400
Date: Sat, 26 Mar 2016 12:50:24 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: convert bare unsigned usage to unsigned int
Message-ID: <20160326195012.GA13368@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use kernel preferred unsigned int declaration style.

Patch created using:
git ls-files drivers/staging/iio | \
xargs ./scripts/checkpatch.pl -f --fix-inplace --types=unspecified_int

Hand edits restored columns in structure definitions.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c                 | 40 +++++++++++------------
 drivers/staging/iio/adc/ad7280a.h                 |  8 ++---
 drivers/staging/iio/adc/ad7606.h                  | 28 ++++++++--------
 drivers/staging/iio/adc/ad7606_core.c             |  6 ++--
 drivers/staging/iio/adc/ad7780.c                  |  2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c   | 14 ++++----
 drivers/staging/iio/meter/ade7758_ring.c          |  4 +--
 drivers/staging/iio/resolver/ad2s1210.h           |  8 ++---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 12 +++----
 9 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 62e5eca..a06b46c 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -155,7 +155,7 @@ static void ad7280_crc8_build_table(unsigned char *crc_tab)
 	}
 }
 
-static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned val)
+static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
 {
 	unsigned char crc;
 
@@ -165,7 +165,7 @@ static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned val)
 	return  crc ^ (val & 0xFF);
 }
 
-static int ad7280_check_crc(struct ad7280_state *st, unsigned val)
+static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
 {
 	unsigned char crc = ad7280_calc_crc8(st->crc_tab, val >> 10);
 
@@ -191,7 +191,7 @@ static void ad7280_delay(struct ad7280_state *st)
 		usleep_range(250, 500);
 }
 
-static int __ad7280_read32(struct ad7280_state *st, unsigned *val)
+static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
 {
 	int ret;
 	struct spi_transfer t = {
@@ -211,10 +211,10 @@ static int __ad7280_read32(struct ad7280_state *st, unsigned *val)
 	return 0;
 }
 
-static int ad7280_write(struct ad7280_state *st, unsigned devaddr,
-			unsigned addr, bool all, unsigned val)
+static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
+			unsigned int addr, bool all, unsigned int val)
 {
-	unsigned reg = devaddr << 27 | addr << 21 |
+	unsigned int reg = devaddr << 27 | addr << 21 |
 			(val & 0xFF) << 13 | all << 12;
 
 	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
@@ -223,11 +223,11 @@ static int ad7280_write(struct ad7280_state *st, unsigned devaddr,
 	return spi_write(st->spi, &st->buf[0], 4);
 }
 
-static int ad7280_read(struct ad7280_state *st, unsigned devaddr,
-		       unsigned addr)
+static int ad7280_read(struct ad7280_state *st, unsigned int devaddr,
+		       unsigned int addr)
 {
 	int ret;
-	unsigned tmp;
+	unsigned int tmp;
 
 	/* turns off the read operation on all parts */
 	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
@@ -261,11 +261,11 @@ static int ad7280_read(struct ad7280_state *st, unsigned devaddr,
 	return (tmp >> 13) & 0xFF;
 }
 
-static int ad7280_read_channel(struct ad7280_state *st, unsigned devaddr,
-			       unsigned addr)
+static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
+			       unsigned int addr)
 {
 	int ret;
-	unsigned tmp;
+	unsigned int tmp;
 
 	ret = ad7280_write(st, devaddr, AD7280A_READ, 0, addr << 2);
 	if (ret)
@@ -299,11 +299,11 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned devaddr,
 	return (tmp >> 11) & 0xFFF;
 }
 
-static int ad7280_read_all_channels(struct ad7280_state *st, unsigned cnt,
-				    unsigned *array)
+static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
+				    unsigned int *array)
 {
 	int i, ret;
-	unsigned tmp, sum = 0;
+	unsigned int tmp, sum = 0;
 
 	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ, 1,
 			   AD7280A_CELL_VOLTAGE_1 << 2);
@@ -338,7 +338,7 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned cnt,
 
 static int ad7280_chain_setup(struct ad7280_state *st)
 {
-	unsigned val, n;
+	unsigned int val, n;
 	int ret;
 
 	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_LB, 1,
@@ -401,7 +401,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	bool readin;
 	int ret;
-	unsigned devaddr, ch;
+	unsigned int devaddr, ch;
 
 	ret = strtobool(buf, &readin);
 	if (ret)
@@ -431,7 +431,7 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
 	struct ad7280_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
-	unsigned msecs;
+	unsigned int msecs;
 
 	mutex_lock(&indio_dev->mlock);
 	ret = ad7280_read(st, this_attr->address >> 8,
@@ -602,7 +602,7 @@ static ssize_t ad7280_read_channel_config(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7280_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	unsigned val;
+	unsigned int val;
 
 	switch ((u32)this_attr->address) {
 	case AD7280A_CELL_OVERVOLTAGE:
@@ -683,7 +683,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct ad7280_state *st = iio_priv(indio_dev);
-	unsigned *channels;
+	unsigned int *channels;
 	int i, ret;
 
 	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
index 732347a..ccfb90d 100644
--- a/drivers/staging/iio/adc/ad7280a.h
+++ b/drivers/staging/iio/adc/ad7280a.h
@@ -29,10 +29,10 @@
 #define AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
 
 struct ad7280_platform_data {
-	unsigned acquisition_time;
-	unsigned conversion_averaging;
-	unsigned chain_last_alert_ignore;
-	bool thermistor_term_en;
+	unsigned int		acquisition_time;
+	unsigned int		conversion_averaging;
+	unsigned int		chain_last_alert_ignore;
+	bool			thermistor_term_en;
 };
 
 #endif /* IIO_ADC_AD7280_H_ */
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index cca9469..39f5044 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -28,16 +28,16 @@
  */
 
 struct ad7606_platform_data {
-	unsigned			default_os;
-	unsigned			default_range;
-	unsigned			gpio_convst;
-	unsigned			gpio_reset;
-	unsigned			gpio_range;
-	unsigned			gpio_os0;
-	unsigned			gpio_os1;
-	unsigned			gpio_os2;
-	unsigned			gpio_frstdata;
-	unsigned			gpio_stby;
+	unsigned int			default_os;
+	unsigned int			default_range;
+	unsigned int			gpio_convst;
+	unsigned int			gpio_reset;
+	unsigned int			gpio_range;
+	unsigned int			gpio_os0;
+	unsigned int			gpio_os1;
+	unsigned int			gpio_os2;
+	unsigned int			gpio_frstdata;
+	unsigned int			gpio_stby;
 };
 
 /**
@@ -52,7 +52,7 @@ struct ad7606_chip_info {
 	const char			*name;
 	u16				int_vref_mv;
 	const struct iio_chan_spec	*channels;
-	unsigned			num_channels;
+	unsigned int			num_channels;
 };
 
 /**
@@ -67,8 +67,8 @@ struct ad7606_state {
 	struct work_struct		poll_work;
 	wait_queue_head_t		wq_data_avail;
 	const struct ad7606_bus_ops	*bops;
-	unsigned			range;
-	unsigned			oversampling;
+	unsigned int			range;
+	unsigned int			oversampling;
 	bool				done;
 	void __iomem			*base_address;
 
@@ -86,7 +86,7 @@ struct ad7606_bus_ops {
 };
 
 struct iio_dev *ad7606_probe(struct device *dev, int irq,
-			      void __iomem *base_address, unsigned id,
+			      void __iomem *base_address, unsigned int id,
 			      const struct ad7606_bus_ops *bops);
 int ad7606_remove(struct iio_dev *indio_dev, int irq);
 int ad7606_reset(struct ad7606_state *st);
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index fe6caee..6dbc811 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -36,7 +36,7 @@ int ad7606_reset(struct ad7606_state *st)
 	return -ENODEV;
 }
 
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
@@ -155,7 +155,7 @@ static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
 	return sprintf(buf, "%u\n", st->oversampling);
 }
 
-static int ad7606_oversampling_get_index(unsigned val)
+static int ad7606_oversampling_get_index(unsigned int val)
 {
 	unsigned char supported[] = {0, 2, 4, 8, 16, 32, 64};
 	int i;
@@ -446,7 +446,7 @@ static const struct iio_info ad7606_info_range = {
 
 struct iio_dev *ad7606_probe(struct device *dev, int irq,
 			     void __iomem *base_address,
-			     unsigned id,
+			     unsigned int id,
 			     const struct ad7606_bus_ops *bops)
 {
 	struct ad7606_platform_data *pdata = dev->platform_data;
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 1439cfd..c9a0c2a 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -63,7 +63,7 @@ static int ad7780_set_mode(struct ad_sigma_delta *sigma_delta,
 			   enum ad_sigma_delta_mode mode)
 {
 	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
-	unsigned val;
+	unsigned int val;
 
 	switch (mode) {
 	case AD_SD_MODE_SINGLE:
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index e6fdb3d..9f43976 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -101,14 +101,14 @@ struct ad5933_state {
 	unsigned long			mclk_hz;
 	unsigned char			ctrl_hb;
 	unsigned char			ctrl_lb;
-	unsigned			range_avail[4];
+	unsigned int			range_avail[4];
 	unsigned short			vref_mv;
 	unsigned short			settling_cycles;
 	unsigned short			freq_points;
-	unsigned			freq_start;
-	unsigned			freq_inc;
-	unsigned			state;
-	unsigned			poll_time_jiffies;
+	unsigned int			freq_start;
+	unsigned int			freq_inc;
+	unsigned int			state;
+	unsigned int			poll_time_jiffies;
 };
 
 static struct ad5933_platform_data ad5933_default_pdata  = {
@@ -222,7 +222,7 @@ static int ad5933_wait_busy(struct ad5933_state *st, unsigned char event)
 }
 
 static int ad5933_set_freq(struct ad5933_state *st,
-			   unsigned reg, unsigned long freq)
+			   unsigned int reg, unsigned long freq)
 {
 	unsigned long long freqreg;
 	union {
@@ -282,7 +282,7 @@ static int ad5933_setup(struct ad5933_state *st)
 static void ad5933_calc_out_ranges(struct ad5933_state *st)
 {
 	int i;
-	unsigned normalized_3v3[4] = {1980, 198, 383, 970};
+	unsigned int normalized_3v3[4] = {1980, 198, 383, 970};
 
 	for (i = 0; i < 4; i++)
 		st->range_avail[i] = normalized_3v3[i] * st->vref_mv / 3300;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 9a24e02..a6b76d4 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -33,7 +33,7 @@ static int ade7758_spi_read_burst(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int ade7758_write_waveform_type(struct device *dev, unsigned type)
+static int ade7758_write_waveform_type(struct device *dev, unsigned int type)
 {
 	int ret;
 	u8 reg;
@@ -85,7 +85,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
  **/
 static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 {
-	unsigned channel;
+	unsigned int channel;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
index c7158f6..e9b2147 100644
--- a/drivers/staging/iio/resolver/ad2s1210.h
+++ b/drivers/staging/iio/resolver/ad2s1210.h
@@ -12,9 +12,9 @@
 #define _AD2S1210_H
 
 struct ad2s1210_platform_data {
-	unsigned sample;
-	unsigned a[2];
-	unsigned res[2];
-	bool gpioin;
+	unsigned int		sample;
+	unsigned int		a[2];
+	unsigned int		res[2];
+	bool			gpioin;
 };
 #endif /* _AD2S1210_H */
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 8667334..38dca69 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -55,12 +55,12 @@ static struct bfin_timer iio_bfin_timer_code[MAX_BLACKFIN_GPTIMERS] = {
 };
 
 struct bfin_tmr_state {
-	struct iio_trigger *trig;
-	struct bfin_timer *t;
-	unsigned timer_num;
-	bool output_enable;
-	unsigned int duty;
-	int irq;
+	struct iio_trigger	*trig;
+	struct bfin_timer	*t;
+	unsigned int		timer_num;
+	bool			output_enable;
+	unsigned int		duty;
+	int			irq;
 };
 
 static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
-- 
2.1.4

