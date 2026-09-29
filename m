Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095B4E4C2D;
	Tue, 29 Sep 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721872; cv=none; b=jF10ow3bpFdu9TncAWb2WfYFlU4muUOfn2BjebVWyL56/PSKJ6TSF7+UDz4XZc0P0nsHByrX/O+LEpANkpuTMpWfydPapfeuZYrNbfvvtH2bB6HZNwBiDypEUI190bVWIbNuSky/DGNZ783lo3y0Co0RMaxigGbE2jvMMJerRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721872; c=relaxed/simple;
	bh=72ge+QkzgaRluyGkqR4bm9xu4Pr0kV4tvihtFiboyiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTfE9oAC7cjeOF/Um9czkkanosY2mtB03p3IdU6md6Ax7zaVzSnh1PS8DVwHd9OZUVPjFspThJMqvY0d3lZ35k7cFG07bTsZL3kgv36HmzMkwyr9++ot6A+U47eAEkHuDWB6dI/+FoMm1mrbojgoBNs3Fo+OqsG+IBVKWneLfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zLKYQ9M0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zLKYQ9M0"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TKYVj31298256;
	Tue, 29 Sep 2026 18:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=urmds
	V5UPSlLuY828bPjUARXN8uhN7GDcTFD9kbujls=; b=zLKYQ9M0oZofGQnJVOir2
	1l5i0eB0wV9EaJP/LVKXNNnO8vzGRnFAZvx78QJpv7MC57uLAFDr6VxFp8HbkRWt
	SFL8l87C58K0KJ4i1CDManVnEzIPq8czUzaHIoq5bkZ1HI3jdzsm436F9d0+kVHz
	E7DQQuHX4TBE4VTHfblhmL/2FiwTIj9WO6rmF6GLP4dVh76bOCDT9DRajt2MRtiy
	vhUCzIpEIgvo8iHLjQjIAPItrHvAwng19EDRvnpGuC4OsnpfnJEzetMeFP+qKS/2
	gH4IfHO/9KxpFlM8NKXelE2IWY87B3JdPW0j4uyW7vcp2TCTMStFxF/GNsej9Oqb
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gyugbrtst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:44:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68TMiNYD041527
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:44:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 29 Sep
 2026 18:44:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:44:23 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMi93q008202;
	Tue, 29 Sep 2026 18:44:12 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 07/13] iio: adc: ad4134: Support buffered data read
Date: Tue, 29 Sep 2026 19:44:04 -0300
Message-ID: <095cea21f1a9fc39aa0a81b990e87c1046bb3dc9.1790719424.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX36IeLcwD1pUZ
 dKpu+F3XmhzyykkKFg4LJsB6Ozb/EuaBs+uMTnxX0OXAWdlz183itMmrEJCOCeCtyWUxhK84cfM
 NnQEqfqDFpDYgdVj09zsX6s6DB2uDrdfjfs4ZUO+MYIPjv1wZf3Lg2t4rM36hnbUx6b7Bzl57Rk
 ab8pmgN8oBHXFWwjg0fjKuTA9zdxh9lPugtBDANUYBZhpR9sluF2e0NZI3f999FEtw6OGT0ak6i
 9s3Sj84b6S4Fayz7cbqjR4qKpZkV5FOF1zTwTcWXMZ0SfNj6OVowVorB3+wHxmCATn1Fpr9aXvH
 6ZhId9p3m/QHobpVKqbIIrP1sV9By/QnmC3oA3l7ItrzmGKwUGa26qOTpfxKLi8Z54G6GXww2Yo
 1+JLWnaFqrvyc4KdD0Vfz4yDMqFzteONlWVHQ8mvyzFXCyhQBzFD9CFTQ6NhN6joyQR1YqPS58X
 6GeTtmLrhmERMjfHfqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX24IQx4uTREVY
 reoLuwjHjHtcaMVvFGH6CQVhjUnMMhPPdmf3CFG6+LNxaZcr30CH8zyFXgxfPQ4Zup133HRMgIJ
 azxmxZCUOnCunGkRaMzWvY3Mnobezc1wns6JIKvngv1qcOTmhSnI
X-Proofpoint-GUID: GjKjRQzUq5PQfSIA2O0xiH2ftPCFuPV2
X-Proofpoint-ORIG-GUID: GjKjRQzUq5PQfSIA2O0xiH2ftPCFuPV2
X-Authority-Analysis: v=2.4 cv=Eexd0/mC c=1 sm=1 tr=0 ts=6abc3f49 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=viz8uc1E70eCCRT_w6QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290090

Enable users to run buffered data captures triggered by IIO trigger device.
Add an IIO timestamp channel so each data scan is provided with measurement
time information. Require single-read operations to be in IIO device direct
access mode to prevent buffered and single-shot data captures to disrupt
each other.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Now using IIO_DECLARE_BUFFER_WITH_TS macro to set properly sized triggered
  buffer storage that includes room for timestamp.

 drivers/iio/adc/Kconfig  |  2 ++
 drivers/iio/adc/ad4134.c | 61 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

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
index 14996a0d1fe8..f0196126515e 100644
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
@@ -269,7 +280,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 	 * interface. Now we read data from all channels but keep only the bits
 	 * from the requested one.
 	 */
-	for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
+	for (i = 0; i < AD4134_NUM_CHANNELS; i++) {
 		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
 					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
 		if (ret)
@@ -333,6 +344,43 @@ static const struct regmap_config ad4134_regmap_config = {
 	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set) - 1),
 };
 
+static irqreturn_t ad4134_trigger_handler(int irq, void *p)
+{
+	IIO_DECLARE_BUFFER_WITH_TS(u32, channels, AD4134_NUM_CHANNELS) = { };
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4134_state *st = iio_priv(indio_dev);
+	struct spi_transfer xfer = {
+		.rx_buf = st->rx_buf,
+		.cs_off = true,
+		.len = BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS),
+	};
+	int ret;
+
+	gpiod_set_value_cansleep(st->odr_gpio, 1);
+	fsleep(1);
+	gpiod_set_value_cansleep(st->odr_gpio, 0);
+
+	/* Execute transfers for all channels so the entire data frame is read. */
+	for (int ch = 0, i = 0; ch < AD4134_NUM_CHANNELS; ch++) {
+		ret = spi_sync_transfer(st->spi, &xfer, 1);
+		if (ret)
+			goto out;
+
+		if (!test_bit(ch, indio_dev->active_scan_mask))
+			continue;
+
+		channels[i++] = get_unaligned_be24(st->rx_buf);
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
@@ -342,6 +390,10 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
 		guard(mutex)(&st->sync_lock);
 
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
@@ -546,6 +598,13 @@ static int ad4134_probe(struct spi_device *spi)
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

