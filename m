Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794988;
	b=XoXOKfKvn8O3LbLBwmO/0+gbMJnGrj9rwmw4Kkx5gCHyGwNnkw2a3PWJSAbpb2pR6vvM
	 kBCH8C6FmX7eXMO8gwHLTxcCn/znjKXuva0exLPBE3iFH9qOmJHC+1SLnDfL7dbpBGy7E
	 Zlbyb+7/gwrO1Tv6Bv1j1z1ydhkJbleLGRlZ7QKUhlDV4blfou0UhKQc05akt9rZFmFLo
	 vKJEEEf3307gIdAlPwQXt9c9OThAgkQYEnkAnwJ/a/dC75ponPGn0UXyfoSkVHAle2Oiw
	 V5PVpP/g4aipOLQw0tCh9P+X8ecQ5z1JQNmGIhgKABRieAh4Z0YkZVVKT0UVZZ3WbFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794988;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NOs35vMiDrEfrHApbpSU3HNkg8XJ64aakArMNkLS9Wg=;
	b=NDybA0Hwx80yvhPSujm5Hs1+erKTI9m3XWkChqdOkFCFvL2vpAFKjlGhfRD17jTLbgoD
	 vjyqYFQnSFLEZDgaOMWbjRY2ih1sB2efFUwSQaJwmBuuDay/QhNDH2Dpyp6oejSZuSZZR
	 UTd5Qd6NtYOey0m0gh4WVEm63hWHomTYEXdfctnnWQ4xhXcm/VsHnQ9AT+oPam1zjqoN/
	 OluG/VDNHcKQjJtDElx1x32Qaexo2mR+PlXbxZVwK7YCHmDFy5D1pTNBqm1+JwJ/uZJ1q
	 x+x26pei/wkNhiyBV6dfj9yz/pL57gXLxpVZEH3vOuo4Y1YTmWjTplR7YLYsiUM3RDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dJh3o7Di;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SLHE8yHo;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC861606A31A;
	Fri, 23 Oct 2026 22:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC861606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dJh3o7Di;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SLHE8yHo
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLwUh51783962;
	Fri, 23 Oct 2026 18:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=NOs35vMiDrEfrHApbpSU3HNkg8XJ64aakArMNkLS9Wg=; b=dJh3o7D
	ijHKfIwhduUxlDcgFyzv+ql0JfIqq+FqT43inLjmtD+Vdg1vFIrws/Mxe5TqKeFT
	nkppP4spHhK9k+KZLNjqPye2cXR4WuM8H6orymx/sc4KIemmyscKIw+XLkZA8Pxb
	orDX1ZifmcZbGVK9ZicztajbUOgAvVYsSWa30D8QjJL52JntmnlxqA1jsGMS0uuw
	i/J8bbXbR++Tc0G6W/9ZwVBD6cQrK5aivcIEihV+WS1aRpSs6m+YmLQnPBY/y8Yd
	XqcCVeXryltSGUTCx4lHwVkR9fHvzU1uQvZjjHTz3N/H2CBM0Z6t6arpjjr4VVq9
	35UWQrX/wirL6oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NOs35
	vMiDrEfrHApbpSU3HNkg8XJ64aakArMNkLS9Wg=; b=SLHE8yHoqWoAn8jr2P+qq
	Q9dLQec5CBp3pHGnxiNbaNdUgtefYBerJszINNk5fz716d89kURLsgdCBdSnyqwL
	UVGtw2YRzfL8qgOOUcN0ePinqypDmhHs2+PV6VKKMh6o8zCjg701bExnVEOviP1w
	Nf5+4AwglrVu1JEkoSBamE1oSdANHg8iibnoY793w72ABya4AsUZnr1Ntt5X3yeq
	CGNl1vd7YULIzJsCScMJKVc97HZ7TZJ6Pj584JLdLBUG7gSk4T205BURC5K23k1X
	vefEsV2URSCoAZA/QPFcM/ebjywLlbPF4kFaKgQT5AmIZ6fsgtXOrMCKPJPM+P76
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg2mvmch0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:36:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69NMaLWU026976
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:36:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 23 Oct
 2026 18:36:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:36:21 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMa7MP005892;
	Fri, 23 Oct 2026 18:36:10 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>
Subject: [PATCH v6 10/16] iio: adc: ad4134: Support buffered data read
Date: Fri, 23 Oct 2026 19:36:02 -0300
Message-ID: <793ac6a05be0d92d435af47eb3fa9030a3dc1496.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: VoW3bqa9O3VPJCxS_0ayhN_m4lqIZipq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfXx6xe476ncQWV
 Y/6cT/c6WcGDowpPewWaCbkff8zHToaxuk63+wiep7Lw0vUXnyFel2ATPttzFKhYoARbuIsiZIW
 B/mj7lRYNVZPbffgm0G/gi7nWeA4FjVGlyUNiTj6fc8s2PLNuhgn
X-Authority-Analysis: v=2.4 cv=YJoKWhGx c=1 sm=1 tr=0 ts=6adbe167 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=yVcpVfG0frc_sdMPSFwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX/Oj2ApUvuHJp
 w2Gbc2goqiBaKYGRqQZUf6Xr0z9caWiAaTAVZBuTKoIwoOCyY8N7Xz/AuqBaVEy6Vl9VtH5HrF8
 c1em5eakXNz3VQV6pxurQbyN+xREyMslngvZaWvL3i25Zh7NUbn19X1KE7BYWjElqXpHPRL/hIZ
 buAqakmy96bI8CKIEeBmMWWqHSQEgiiNmmKbQLigKDSHHBW4aWsafxQjWCqy7h0mizC6ESG+XTL
 xvKS3bD8skfvN8c21wAak5Iqk3xpmwsQwG7g7jWSc7OvnK4fn1xbqcfGV1qdoi5P7w7cAibGH3u
 rot72k5pGpZgs+COBvl0v1ELRrkhemC7yaR7AZSL/YpwSckY4UQlS1UURI5yPX+rn4gaGSsg3aH
 sWAbkkU0ZGBMR5bEVRoram/v5dpbKvSWTTUP6g+sXrBPjpRWBIE9qLIGGiM7CKZ70Vxr2LbwSfT
 cYkv5yiARmoMhkL2K0g==
X-Proofpoint-GUID: VoW3bqa9O3VPJCxS_0ayhN_m4lqIZipq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230089

Enable users to run buffered data captures triggered by IIO trigger device.
Add an IIO timestamp channel so each data scan is provided with measurement
time information. Require single-read operations to be in IIO device direct
access mode to prevent buffered and single-shot data captures to disrupt
each other.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6:
- Now running bus preparation routines on IIO buffer preenable/postdisable.

 drivers/iio/adc/Kconfig  |  2 ++
 drivers/iio/adc/ad4134.c | 61 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d970c51d83a3..50b995a6a12c 100644
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
index f752fb6cf8f1..4252244a23bc 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -26,7 +26,10 @@
 #include <linux/unaligned.h>
 #include <linux/units.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define AD4134_RESET_TIME_US			10
 
@@ -113,7 +116,7 @@ struct ad4134_state {
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
 	 */
-	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN * AD4134_NUM_CHANNELS] __aligned(IIO_DMA_MINALIGN);
 	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
 };
 
@@ -177,6 +180,13 @@ static const struct iio_chan_spec_ext_info ad4134_filter_type_ext_info[] = {
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
@@ -184,6 +194,7 @@ static const struct iio_chan_spec ad4134_chan_set[] = {
 	AD4134_CHANNEL(1),
 	AD4134_CHANNEL(2),
 	AD4134_CHANNEL(3),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 static const struct regmap_range ad4134_regmap_rd_range[] = {
@@ -264,7 +275,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 	 * interface. Now we read data from all channels but keep only the bits
 	 * from the requested one.
 	 */
-	for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
+	for (i = 0; i < AD4134_NUM_CHANNELS; i++) {
 		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
 					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
 		if (ret)
@@ -328,6 +339,41 @@ static const struct regmap_config ad4134_regmap_config = {
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
@@ -337,6 +383,10 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
 		guard(mutex)(&st->sync_lock);
 
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
@@ -548,6 +598,13 @@ static int ad4134_probe(struct spi_device *spi)
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

