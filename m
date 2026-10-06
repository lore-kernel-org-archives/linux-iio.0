Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F583DEAC0;
	Tue,  6 Oct 2026 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310703; cv=none; b=h2VY/tweNOurIg7XicnKXCDDuRCHdjm5OtjMKma4PUQVZXtyHluJX4zAkBISGLM1mhP+t9/utoaU/XCMbCovZ3IBQBXvfU63qxMUGwxXMLuQtHP/JsSQpjnEXHEsMvQziJyr5rbsuiJBaK0shvZ3caDpneeyvcQfY5EjJC280nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310703; c=relaxed/simple;
	bh=NxuYA860/h02yF4H+cCOjbIsq2WVdVnoKg2q+Me+DdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeubB3x+U9kUSfWVGc9D+nDJOAFcmWkorbphXoE/gsm+eBUJdcoQUGL4hETKoc0jYdgYLn22w85YtoI33CdlFHsKfOw9SZt4+icE4zxv6agpGdAi+/J36eqKaIlLblQpgfMFHChTzUJPM8OQ4Kfd43KqRDhv5s+/1P5KmSMAEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=nx5dtSlo; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Nyi/Ihfi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="nx5dtSlo";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Nyi/Ihfi"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HhLxr2187768;
	Tue, 6 Oct 2026 14:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=0zXfvNVuGtYG5T2joqJcB/kBgb6iijjW6RPweTDSfRw=; b=nx5dtSl
	oMfr1aSK1DVc9pQbZ/bOUy93U5KJHO5GRqEahbQAlvqRxu9FDoeM5EtWJqFNA+jY
	0P+Lo4ofNvHImZSMk2nCgiPRD3/4mC3MmO6KrD5EqEVa6Q6sfXbceEn3DRpgEq2Q
	ZikHq/hTuZSTP4nX2MFqMVh/WmRlrZHljtXkMv02wdnUJLJ4Mp0sWRHDXQduO84R
	mXkCjhavaUWSDD9DRdpPTmXtmwWi+V+4LDb1VL3r5EL6nauOzqTNJicTSqdfsmEn
	/p0R1yc+2cohW8kPfQE9+7NM0poZDJFZsi4KMwK8eNiDvFSGC1TW9ZoNCVzMgzwl
	vY4orcXazdoEyUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0zXfv
	NVuGtYG5T2joqJcB/kBgb6iijjW6RPweTDSfRw=; b=Nyi/Ihfie5VZsCOGonShR
	q3zuK89ZNYpeWFqH/QBDgA53UH35lSFTvflkHPcpfKORSxx086bDIBayM07gaGOY
	rXDFh/vNBeHNghoxyx9WEmJlTp5i/7hEo/M3IO1Ji1pueIOBq65qGBNpiux026ZL
	NOn8Kw8g4hHhrr7duN6eYANFXYjruGXxZSEsJSbCvE4QqI+gr4JsETw6TdMqXpm2
	8OjGi2fmHd/Mfebo39nS5DI5PIEBMF5MxMLU7VKQCmi+LIT9GQAKrLKl1mbhXmGS
	/LyPyl+Lr7kp/qmkYtfW6/qTILTgX/maPV1W6SlvG8rc+6Qa1XHJSZi+8BkUxoQ1
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4en5faw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:18:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 696IIFA4021691
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:18:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:18:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:18:15 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696II1BK001016;
	Tue, 6 Oct 2026 14:18:04 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 07/13] iio: adc: ad4134: Support buffered data read
Date: Tue, 6 Oct 2026 15:17:56 -0300
Message-ID: <5d31212a27c2099c226cce189aa96677e75ca529.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX7oTguoMUJvET
 vMqHk+nf0aX+gGd2bAMUtePt+oeMxeIgtUEBYmqM2fCyVv7BA6agJF7lzY7CigxAK8+uRzt5hUb
 0gMKbSeVswclzzdjwf28FckkB2+n064hFgzWUb8zfkmoXvVT9sai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfXwN42+2fBNsbt
 K6cKsmv+4MT6pAMpXcFgjZR+elDqY14zjDYlWc2NynT2oyXMIzqA+bBnTxLQJC0eqWnvpZtfRF6
 CWylL0ch2Vo8ji7ZuRMygRxyw8uLwdUE7JNjlh5RtROXs0zCxHeECxG8bTFho9EXvwv3MRRuuSK
 1Tv7DEq0r84VOel7kbnlcluW7ChIXqvdwK2L23p8TGJVOO+e+GdiXZQJghnuF0H5d7mGKq0j1qU
 dGIUPM4RHPWMAlHiPl787t6EHxTptc2M9Uy1izTGg+k4b7sioypfZ5kOpBG2Bu+9tGOO49HTffW
 KNVpmrfVhHW076iX3Cdf2DBn9npuJ/W3fhd1Ec85ju/GQ3r+u4Y4nrjN30YhH9QU1G0VRDnTj+e
 UpSPtkrofv+f/artzBTAdgfgDZwDmVy4wK+RwCEjlY047wsIEqBGWp4Oa++wL3612HR9QqNoBBw
 HZOsSTLVhXMuo2M7vHg==
X-Proofpoint-GUID: SHjqpvTMNOq55zXiX6B5HI8zaMGDRGlU
X-Authority-Analysis: v=2.4 cv=DdCCOftW c=1 sm=1 tr=0 ts=6ac53b68 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=yVcpVfG0frc_sdMPSFwA:9
X-Proofpoint-ORIG-GUID: SHjqpvTMNOq55zXiX6B5HI8zaMGDRGlU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060072

Enable users to run buffered data captures triggered by IIO trigger device.
Add an IIO timestamp channel so each data scan is provided with measurement
time information. Require single-read operations to be in IIO device direct
access mode to prevent buffered and single-shot data captures to disrupt
each other.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4:
- Now grabbing the whole data scan with a single SPI transfer.

 drivers/iio/adc/Kconfig  |  2 ++
 drivers/iio/adc/ad4134.c | 64 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..fc7de0bb400a 100644
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
index 3048e61a3cb1..b5207f16054e 100644
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
 
@@ -124,6 +127,13 @@ static const struct iio_chan_spec_ext_info ad4134_filter_type_ext_info[] = {
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
@@ -131,6 +141,7 @@ static const struct iio_chan_spec ad4134_chan_set[] = {
 	AD4134_CHANNEL(1),
 	AD4134_CHANNEL(2),
 	AD4134_CHANNEL(3),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 struct ad4134_state {
@@ -149,7 +160,7 @@ struct ad4134_state {
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
 	 */
-	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN * AD4134_NUM_CHANNELS] __aligned(IIO_DMA_MINALIGN);
 	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
 };
 
@@ -269,7 +280,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 	 * interface. Now we read data from all channels but keep only the bits
 	 * from the requested one.
 	 */
-	for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
+	for (i = 0; i < AD4134_NUM_CHANNELS; i++) {
 		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
 					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
 		if (ret)
@@ -333,6 +344,44 @@ static const struct regmap_config ad4134_regmap_config = {
 	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set) - 1),
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
+	for (int ch = 0, i = 0; ch < AD4134_NUM_CHANNELS; ch++) {
+		if (!test_bit(ch, indio_dev->active_scan_mask))
+			continue;
+
+		channels[i++] = get_unaligned_be24(&st->rx_buf[ch * chan_bytes]);
+	}
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
@@ -342,6 +391,10 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
 		guard(mutex)(&st->sync_lock);
 
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
@@ -546,6 +599,13 @@ static int ad4134_probe(struct spi_device *spi)
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

