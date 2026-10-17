Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A1384CE1;
	Sat, 17 Oct 2026 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202368; cv=none; b=cDb6ZvM8kViRfUJwRFcqHEFUDbhr19X4kP4+UPT9duODu0e3EXJTYYdS7UUAGRznLszFt7pIhOR/FAkGLl+5Vv61Yk61LB5GN2ATQoXLba35XKRUT/pb7I7w7qF5oWEZnOAa5O/H4X1NDhGTxZngVkndNRo7vNG/XTWTHGi3pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202368; c=relaxed/simple;
	bh=Gwxdj28/9fA69sZMimOQSMI6CTyQfmfF/Z651b3eL5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAAC5hsPT/W1zp1qMhMhvVIjdTCknekIyDPRCkGwU9zacbtyR79kIVnkfmIqAwIm8NSHiHJkR/SX4QcPjxY+iDUA4qegULNvq4EhRYCHf9c2tOC5mDvhNYEDB70fpEMSiquNsf1HuuIrsaPjTvnQbOyNrPNyzzV0VCJ4kvB+vas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Vt7UTyv/; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iiE1z5Xo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Vt7UTyv/";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iiE1z5Xo"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHCug2042821;
	Fri, 16 Oct 2026 21:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=wx/zGegCo5vgcSYG5oa2i+YmYE9dacp7ekAX+PMHuNk=; b=Vt7UTyv
	/BG+rEpSqhEBEZB8/aQuWxE5htfMYbSMcX/E1zTKT7WSu8rYOgvs21LAxHqFd3+k
	/tkSv4xx5wDXNkmRTg1tEWxsFyFV5syZXuZdtOIc/JkDg9aGh2XtOYXGVU/T3q8q
	V50Hu9jPfFgP6wMMnQUtVxHpy1YESce3jm8asQsfB3qJQV5t3fO85rU8mRjANwaC
	w+KjiZ6e1ZcRR436H3dc8hToXxxMHSkqIe8DKhE5LIcDjlx5sShF9WTeZc1xX/mz
	1PpAjWpq+xQf81A1x7ucyLo7eGmaY8n3ABOouDkNDjVZ/OANB8SE7/BF9XrIk0bA
	2RR/jee5r1yr/6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wx/zG
	egCo5vgcSYG5oa2i+YmYE9dacp7ekAX+PMHuNk=; b=iiE1z5XoF8PXxtDbwFzJi
	NYSMKx8kt15KGcyxhqpgnBfQAL3BdgQxvuSG7PvwxFN/cVCLNVfaR90YGvKhNe9W
	SQjkh6L4LFB7QKRxqntLv5/Jzl/EBOignPgaEFOhmWuTIHc06WSqpkmGE4udaJlL
	XukpCmL2XzR8g3LNxQA7ouGJkn4C0Tx1lM6UAhCUr8SdO/0zmK3gGrNsOJTMzKiZ
	3oaHRTFjHPl39esGkHK5rUGWyMQflKF3b2E8CFy7o0E20h36Z4E17fL0/vUGMurE
	y2O1CjRuvWqLqsz6WuZilitiqsBwM5STlbii2WBgeDv1oPWtRk/I0H8tYEAM6kg9
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hbajk6m6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:59:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1xKS9061873
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:59:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 16 Oct
 2026 21:59:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:59:20 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1x77E004344;
	Fri, 16 Oct 2026 21:59:09 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 09/15] iio: adc: ad4134: Support buffered data read
Date: Fri, 16 Oct 2026 22:59:00 -0300
Message-ID: <dcc159585f0af92c145569331063bc867efeda8a.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXzae1VzXplBNe
 Wi2g5MGehRN0vnoDfbY0zb+OoJjDT/3dsChfkG+1w2IAQqUCaYmumSrTJ3KMtugfZSaVrejcBRn
 q3UZCGieXgVC0X5tLBLNBrnJvkj3ESjanlPnClqtMbbaghYDosIW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX9s/BAqR5RCnt
 sF+PIU3d3bS+v6lOazuBpqldsEJtzdR+uT4ebo+IH3mTtDDqyxD1NOYf5r5FNZkTD1RPzlGNhRN
 0b4VlVGYLjYfH5EfAB2Py1sHG7MNZeXIW5gJchAENiRMwvC4YbbuBYr7RGlELHJFiIIUjAQeM3I
 z3EitZLQiDKM3FrdHYlGTMxkQ6QipPTUwSxQAjY2pI2LLKoE5AVrsUykfWZuhXHPgZtkjNa8d7e
 cRcSozbPiFo1K5Hhp5HqU7K5NVPS25w00xIGLL5G5Ev37HCVnwmYj2wJuqulxs6eyfbZ1tmKqNX
 zSy9njvmLTw46CAHrQV3VNIfGkYyj8akRYW3gRfYUVQ5F79MoFu9b+LdXzZQlanEfNtR2KzZ56C
 jmsbQ5fOrzEV+DlVu/qoFm8iBQU3E1iHOJBJDmIvkuQT2xI8DoKoQ6cgpKLGxcSYchRGcAwyDZv
 23IQ6yuVnx//NscYAAQ==
X-Proofpoint-GUID: k3-OrWD_M2q26waQTZtv1k_FPLCzEo69
X-Proofpoint-ORIG-GUID: k3-OrWD_M2q26waQTZtv1k_FPLCzEo69
X-Authority-Analysis: v=2.4 cv=eLqGH3p1 c=1 sm=1 tr=0 ts=6ad2d679 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=yVcpVfG0frc_sdMPSFwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170007

Enable users to run buffered data captures triggered by IIO trigger device.
Add an IIO timestamp channel so each data scan is provided with measurement
time information. Require single-read operations to be in IIO device direct
access mode to prevent buffered and single-shot data captures to disrupt
each other.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Now using iio_for_each_active_channel() to iterate over IIO channels.

 drivers/iio/adc/Kconfig  |  2 ++
 drivers/iio/adc/ad4134.c | 61 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 02de4809ae31..d625f36a0283 100644
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
index b245001d4551..eaf5bb55f25b 100644
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
 
@@ -113,7 +116,7 @@ struct ad4134_state {
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
 	 */
-	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN * AD4134_NUM_CHANNELS] __aligned(IIO_DMA_MINALIGN);
 	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
 };
 
@@ -175,6 +178,13 @@ static const struct iio_chan_spec_ext_info ad4134_filter_type_ext_info[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
 	.ext_info = ad4134_filter_type_ext_info,				\
+	.scan_index = (_index),							\
+	.scan_type = {								\
+		.format = IIO_SCAN_FORMAT_SIGNED_INT,				\
+		.realbits = AD4134_CHAN_PRECISION_BITS,				\
+		.storagebits = 32,						\
+		.endianness = IIO_CPU,						\
+	},									\
 }
 
 static const struct iio_chan_spec ad4134_chan_set[] = {
@@ -182,6 +192,7 @@ static const struct iio_chan_spec ad4134_chan_set[] = {
 	AD4134_CHANNEL(1),
 	AD4134_CHANNEL(2),
 	AD4134_CHANNEL(3),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 static const struct regmap_range ad4134_regmap_rd_range[] = {
@@ -262,7 +273,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 	 * interface. Now we read data from all channels but keep only the bits
 	 * from the requested one.
 	 */
-	for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
+	for (i = 0; i < AD4134_NUM_CHANNELS; i++) {
 		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
 					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
 		if (ret)
@@ -326,6 +337,41 @@ static const struct regmap_config ad4134_regmap_config = {
 	.max_register = AD4134_CH_VREG(AD4134_NUM_CHANNELS - 1),
 };
 
+static irqreturn_t ad4134_trigger_handler(int irq, void *p)
+{
+	IIO_DECLARE_BUFFER_WITH_TS(u32, channels, AD4134_NUM_CHANNELS) = { };
+	unsigned int chan_bytes = BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS);
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4134_state *st = iio_priv(indio_dev);
+	struct spi_transfer xfer = {
+		.rx_buf = st->rx_buf,
+		.cs_off = true,
+		.len = chan_bytes * AD4134_NUM_CHANNELS,
+	};
+	unsigned int ch, i = 0;
+	int ret;
+
+	gpiod_set_value_cansleep(st->odr_gpio, 1);
+	fsleep(1);
+	gpiod_set_value_cansleep(st->odr_gpio, 0);
+
+	/* Run enough DCLK cycles to match the data frame length. */
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		goto out;
+
+	iio_for_each_active_channel(indio_dev, ch)
+		channels[i++] = get_unaligned_be24(&st->rx_buf[ch * chan_bytes]);
+
+	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
+				    pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ad4134_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -335,6 +381,10 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
 		guard(mutex)(&st->sync_lock);
 
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

