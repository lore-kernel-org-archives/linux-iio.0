Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB21A682C;
	Wed,  2 Sep 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369850; cv=none; b=evejerKubY4ZbSJ4XYbz1tUNM8xQkcil/UubankrpSJAZF0HoX9p7vHXkX1Q+CoEq+42VhZ+/E1f8aGPvsORZu6XNisntWFVKqawglXyEBYjH11vjrCHMKdoldzrwky2DSiCfvwMrzNQBO68IXR/xdGCuKmqWaNJPfHcTQWC7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369850; c=relaxed/simple;
	bh=Qmp9bNeacKqPe3+xZKVvtFR7lIbx00GgtZVi3FA1S8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdliDawAXcbmgqLArzb2wq6aIWAKqiNv1sKcfSgdDh5OQPjdxiPRjXcgAUFIR6+vYWR8Q2eA+Lc0L26cQL6F3Tijv/YHMDn7uolmyHBsnSzscH9yk6QuduMediatXN42tT2Hsfz+I7TDvm/58KhyWS4tKIm0bk5bTNSBj9tr4rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Dtx1f9Ad; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Dtx1f9Ad"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDTQI3088296;
	Wed, 2 Sep 2026 13:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=93YP6
	f0ZFEgPt6D8hAiIp6RnbrtVmnAhizpuqnH5Slo=; b=Dtx1f9AdpuXVkC9DjsoAb
	KrwPLNEzOLuqvSahYa6o5yE40ov7kJdb3pfdQyEwW3ZkG+JMW5cOmlTwumQfWHy3
	dINJLu/9/9xAhd18Caqis+Z+XjCMnJC3Ri9VW/qsgzcQSjmeAUcBzolgWqBY5ZcI
	n35y2hlJ0Q1JLS+36DKhzwZqoODsBPs35onV+dTroj8n/yGxlj/bAlkAyQvBUz0f
	G7FS9IXF05F3mKfPIKmlkxoTFHkAWCErzwbUBlcQpf8z9h/shC2fsNEOrPXDfY0h
	hLWJITE0r5fRCKOia8qY1vRK9Dlf152Gjiy9HIERfBDNHzMFu7qddPzpsJg6635W
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gea7ubt09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:24:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HO2Q4041330
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:24:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:24:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:24:01 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HNmtK004242;
	Wed, 2 Sep 2026 13:23:50 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 07/13] iio: adc: ad4134: Support buffered data read
Date: Wed, 2 Sep 2026 14:23:42 -0300
Message-ID: <b44fc7cd06c295781e2144ae3586eac80b23bea9.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX2yVu74PtoxWP
 UgL0P3hpZdWIrC0xG3+JCU/bqaIl71R4ubUDHGbt6xdbx0G8gzX4bjwycxJVV5j9VjCOcsOdIrl
 BucVDF5n3lk5RqKxcuTSdjMU/D9IKeEsoALBPSSEwiBzD78f84qdfe8doh07GhmpbGpSu9JcRBp
 rYzGWEjKtidY+JVtt/bhJv3rJBfMJwYjBLPMcHj6SvyN46D9zn8BUs+KG0R4Jz7uQEL8Rl1w4mx
 1g6cMPVzHief3avTnhgL25Us1P06DrlkkZA6SxgEjALYKVmARDkWD6r8x6izWIMEXEk10bNl7pN
 QNodFwFou4HJPlQ7X499mPiNR4nCiJQYA6hjcsNd2VxJChJeQeb4Ys/q7nIXURW3d4BILzn7p89
 bzCXkPcwLozhNThWfWsWuU+SQ96Ge6UMjOrnUm39DDvVMER9stHL1X8vZ2ntJe4fzGCppBevadU
 whEw8gFhVInOcr6vjbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX+8Fgs0yvmIuS
 gMgPW+dgekzCyPhkYL89zYLGXwnstKMojHJ4OjA6Q1Aq6atSiQNIqQwmmPhxBJtdb8y68Wtln8P
 UHCyO6bXopPePWXxuA0goeQtfckaBnvQ2uuMmvJGCngTk7PIo4jd
X-Proofpoint-GUID: yR6NE9fCVz_9Rx_YFmPc-VXnDvkXSMEP
X-Authority-Analysis: v=2.4 cv=a6EAM0SF c=1 sm=1 tr=0 ts=6a985bb3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=FOnSHgA-kRAbL4hVXUYA:9
X-Proofpoint-ORIG-GUID: yR6NE9fCVz_9Rx_YFmPc-VXnDvkXSMEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020153

Enable users to run buffered data captures triggered by IIO trigger device.
Add an IIO timestamp channel so each data scan is provided with measurement
time information. Require single-read operations to be in IIO device direct
access mode to prevent buffered and single-shot data captures to disrupt
each other.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/Kconfig  |  2 ++
 drivers/iio/adc/ad4134.c | 59 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 02f189e90c30..584251a3f45c 100644
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
index a1474316e330..0751b89dec8f 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -27,7 +27,10 @@
 #include <linux/unaligned.h>
 #include <linux/units.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define AD4134_RESET_TIME_US			(10 * USEC_PER_SEC)
 
@@ -126,6 +129,14 @@ static const struct iio_chan_spec_ext_info ad4134_filter_type_ext_info[] = {
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
@@ -133,6 +144,7 @@ static const struct iio_chan_spec ad4134_chan_set[] = {
 	AD4134_CHANNEL(1),
 	AD4134_CHANNEL(2),
 	AD4134_CHANNEL(3),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 struct ad4134_state {
@@ -151,7 +163,8 @@ struct ad4134_state {
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
 	 */
-	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	u32 scan[AD4134_NUM_CHANNELS] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN];
 	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
 };
 
@@ -336,6 +349,36 @@ static const struct regmap_config ad4134_regmap_config = {
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
+	for (unsigned int ch = 0; ch < iio_get_masklength(indio_dev); ch++) {
+		ret = spi_write_then_read(st->spi, NULL, 0, &st->scan[ch],
+					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
+		if (ret)
+			goto err_out;
+
+		if (test_bit(ch, indio_dev->active_scan_mask))
+			memcpy(&st->scan[i++], &st->scan[ch], sizeof(st->scan[ch]));
+	}
+
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ad4134_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -344,7 +387,11 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (info) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
 		guard(mutex)(&st->lock);
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
 		/*
@@ -364,6 +411,7 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->refin_mv;
 		*val2 = AD4134_CHAN_PRECISION_BITS - 1;
@@ -547,6 +595,13 @@ static int ad4134_probe(struct spi_device *spi)
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

