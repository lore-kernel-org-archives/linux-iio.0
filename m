Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2C43CEDD;
	Tue, 15 Sep 2026 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499693; cv=none; b=qb2wtkus9NrhbEF2Km6/JTHGEgW//grhRzWGOdqW6MBq01Of29rRrA0WYCGsnmY/IpLEsc+MRAwtdoIicinqu/JM14bCfU+JziESgwDzOCPNYQSp2oTQvyKKlxG5L6XuHIFI9/Q1tgHHLlKPeFK57CwSpfBjTHzuU9oefNLQVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499693; c=relaxed/simple;
	bh=1ux2dFUKDIIm7fFPlxwin+ooTiJKBw50yiDGYcOhous=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jw++VaFFzGe3H6T/+hrrc4Rs7JW8Fe6f0nuqJB2IsxeOpYVEWETiFKJO9gl5XsQ89UPr3qMUfiwrRkSOaC1TSARPpTAHBIelToH8Ff5BasUlep2Tf392rhIPtiBlh355/x1i5Af7Nn6ebM4J61/+hCDHg7rlTjgxlxe+GQwqwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ah5v1y4i; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ah5v1y4i"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsIIp2052584;
	Tue, 15 Sep 2026 15:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nZYWm
	/5fZkOYm8v70MNgEVyx1EOTDvFlJe++Jn7X0rw=; b=Ah5v1y4iFjE7pk1bRB91d
	0hjxCTvIKvLELZF47E5Q0qFyi56b08PrIks+TaKlMB4hd7glh4DhZCEuA2JK3Yov
	WDLxvu6S7ezk/CGocghzr1clEdBq8slsolD3syvYItf/pYwHvGuRRaIWdC9iUNP0
	KQObZ0gZoQWxBpXIxMmF3HhzaQt8ALappFqrmwd38PCboLl95HVn5XgG7WM55P47
	aaw54WLvA6HnUvn9QbKTr6f6XyAHGwtY7pDoaWH8ZGRSE9++mzaTJElgukDpmIPQ
	UlG6cvcHYyKkRS6F0viO4exrfNmveCx9OoWKJ8QpbxiSXMa8ORtVSRQsWaVQI7xM
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq57ead4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:14:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJEj4Y019298
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:14:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:14:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:14:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:14:45 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJEVmg028158;
	Tue, 15 Sep 2026 15:14:34 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 08/15] iio: adc: ad4134: Support buffered data read
Date: Tue, 15 Sep 2026 16:14:26 -0300
Message-ID: <dbc37d95fe7f96bd158d8e3339c41205524ae217.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ch9E5FXwB8GGd8cNqmTCXXqOrYAlhrpc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX6OIQzJ4cJxxN
 QuB+dMsaLo4Kv3nEGnG5iBAZoDGR+yIogk3IcoqgG0/JJNMA55AT1V88b79r7aHekFXmCz6yOd9
 qm5GmGopWNozrIN0/luVOP7OhwbjtJOQm0tquhlSEJ+wt7y5qrg59h+J5zRtL6KTPVu+5cdkAlf
 JZVwHBb7Ja5tIgZL3d8vSGXK0Gtm1FOO5CYC9+AtmLjxzG1+v/9c1Afkj1Z9ziyhsASjJUYVYHj
 P0f53MZ4lGRkea9fYLQ+af+yOmjKuNN48mTdv8HueVgAgzdCFWzzXjUQ0xxCOwQ5Z2uYiG+oR6/
 ouOYdLDRVrZ+VDvFDwlaRVLaJQFqCNnf7gSFVPwHfPd17Ggk7tWRzwAuPHhTj/nniaDlp5ZKEdt
 vcolQf99s37C627t5XLE0RjD9e3OupMMXvk2nx5DbDhYtNnGLHLTtHMEr1Z1mS4hqy3NK8BB5z3
 jIkr2+7WvW+jvcvCx9A==
X-Authority-Analysis: v=2.4 cv=V9HoQuni c=1 sm=1 tr=0 ts=6aa99926 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=IYtGImZFAOHaZ20UcmgA:9
X-Proofpoint-ORIG-GUID: ch9E5FXwB8GGd8cNqmTCXXqOrYAlhrpc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX+xVlVTkYHM45
 4wMA0GYIV63Hb63FGcVkXNvm+HkQTMKhbCksuR59LY3rWKiPnGZTjO5ixD0/zDN5Rh8jFhm82AC
 SttuNCuloHkCGXUZ+JZW5vA40CoucpfPrwvm9wlSPdL4oOYD9IuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

Enable users to run buffered data captures triggered by IIO trigger device.
Add an IIO timestamp channel so each data scan is provided with measurement
time information. Require single-read operations to be in IIO device direct
access mode to prevent buffered and single-shot data captures to disrupt
each other.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Fixed IIO scan buffer size and single-read loop.
- No longer memcpy() with same pointer for source and destination.
- Always delimit guard()() with a blank line.

 drivers/iio/adc/Kconfig  |  2 ++
 drivers/iio/adc/ad4134.c | 75 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7f90fea3d1f0..8787b2339f2c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -125,6 +125,8 @@ config AD4134
 	depends on SPI
 	select REGMAP_SPI
 	select CRC8
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4134 SPI analog to
 	  digital converters (ADC).
diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 30c7b1d1bc67..0b6843bf8a9e 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -26,7 +26,10 @@
 #include <linux/unaligned.h>
 #include <linux/units.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define AD4134_RESET_TIME_US			(10 * USEC_PER_SEC)
 
@@ -124,6 +127,14 @@ static const struct iio_chan_spec_ext_info ad4134_filter_type_ext_info[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
 	.ext_info = ad4134_filter_type_ext_info,				\
+	.scan_index = (_index),							\
+	.scan_type = {								\
+		.format = IIO_SCAN_FORMAT_SIGNED_INT,				\
+		.realbits = AD4134_CHAN_PRECISION_BITS,				\
+		.storagebits = 32,						\
+		.shift = 8,							\
+		.endianness = IIO_BE,						\
+	},									\
 }
 
 static const struct iio_chan_spec ad4134_chan_set[] = {
@@ -131,6 +142,7 @@ static const struct iio_chan_spec ad4134_chan_set[] = {
 	AD4134_CHANNEL(1),
 	AD4134_CHANNEL(2),
 	AD4134_CHANNEL(3),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 struct ad4134_state {
@@ -149,7 +161,10 @@ struct ad4134_state {
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
 	 */
-	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	union {
+		u8 reg[AD4134_SPI_MAX_XFER_LEN];
+		u32 scan[ARRAY_SIZE(ad4134_chan_set)];
+	} rx_buf __aligned(IIO_DMA_MINALIGN);
 	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
 };
 
@@ -235,7 +250,7 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	struct ad4134_state *st = context;
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_buf,
-		.rx_buf = st->rx_buf,
+		.rx_buf = st->rx_buf.reg,
 		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	int ret;
@@ -246,7 +261,7 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	if (ret)
 		return ret;
 
-	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
+	if (st->crc_en && st->rx_buf.reg[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg write CRC check failed\n");
 
 	return 0;
@@ -269,8 +284,8 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 	 * interface. Now we read data from all channels but keep only the bits
 	 * from the requested one.
 	 */
-	for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
-		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
+	for (i = 0; i < AD4134_NUM_CHANNELS; i++) {
+		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf.reg,
 					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
 		if (ret)
 			return ret;
@@ -281,7 +296,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 		 * Clock out data from all channels to avoid that.
 		 */
 		if (i == AD4134_VREG_CH(reg))
-			sample = get_unaligned_be24(st->rx_buf);
+			sample = get_unaligned_be24(st->rx_buf.reg);
 	}
 	*val = sign_extend32(sample, AD4134_CHAN_PRECISION_BITS - 1);
 
@@ -293,7 +308,7 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 {
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_buf,
-		.rx_buf = st->rx_buf,
+		.rx_buf = st->rx_buf.reg,
 		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	unsigned int inst;
@@ -306,10 +321,10 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	if (ret)
 		return ret;
 
-	*val = st->rx_buf[1];
+	*val = st->rx_buf.reg[1];
 
 	/* Check CRC */
-	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
+	if (st->crc_en && st->rx_buf.reg[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg read CRC check failed\n");
 
 	return 0;
@@ -333,6 +348,37 @@ static const struct regmap_config ad4134_regmap_config = {
 	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set)),
 };
 
+static irqreturn_t ad4134_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4134_state *st = iio_priv(indio_dev);
+	unsigned int i = 0;
+	int ret;
+
+	gpiod_set_value_cansleep(st->odr_gpio, 1);
+	fsleep(1);
+	gpiod_set_value_cansleep(st->odr_gpio, 0);
+
+	for (unsigned int ch = 0; ch < AD4134_NUM_CHANNELS; ch++) {
+		ret = spi_write_then_read(st->spi, NULL, 0, &st->rx_buf.scan[ch],
+					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
+		if (ret)
+			goto err_out;
+
+		if (test_bit(ch, indio_dev->active_scan_mask) && ch != i)
+			memcpy(&st->rx_buf.scan[i++], &st->rx_buf.scan[ch],
+			       sizeof(st->rx_buf.scan[ch]));
+	}
+
+	iio_push_to_buffers_with_ts(indio_dev, &st->rx_buf.scan,
+				    sizeof(st->rx_buf.scan), pf->timestamp);
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ad4134_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -342,6 +388,10 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
 		guard(mutex)(&st->lock);
 
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
@@ -546,6 +596,13 @@ static int ad4134_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret,
 				     "failed to setup minimum I/O mode\n");
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad4134_trigger_handler,
+					      NULL);
+	if (ret)
+		return ret;
+
 	/* Bump precision to 24-bit */
 	ret = regmap_update_bits(st->regmap, AD4134_DATA_PACKET_CONFIG_REG,
 				 AD4134_DATA_PACKET_CONFIG_FRAME_MASK,
-- 
2.53.0

