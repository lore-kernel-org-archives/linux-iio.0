Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547956;
	b=ayPzY1IGM30iO/JpaBH66n3CoLI4jMQ+FtxJNKfWaR0EaS0YfigAblpzNs5pwfITqHUN
	 mhFaqoLYtkcXV/xnrv6QhOt9s4CTWVRiO+fiGu4xet/dMDI7jvSc6d5tW1kWlMMMwMJKK
	 nRy97QpMFHPVBgfgxjeZhaBuvGPGiQLhVsu4IdAC3TlxGHTUqI1IQxaQZhIFX+gfUZDqs
	 du9BRXg1sQGJqwE7qJmi2J9vc6sPK9vc1Vg7MqDLHomwfdqOFw1ZVCk1F0UpfIXroCUTj
	 dTL6is8w9G2+i2tPDWZyLC5id2L7oc8VXMu1IokfRZsEZSN/Kt/jgOUZRiOuLGZhRcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547956;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=URuwE5bz8eWMgV//wrlENNhPFo9Zn9170qnevD1nibo=;
	b=3YWGGIlQLtzGhyprzMJn5KeEOow8BrXW7BHLV3iXhe4CiJ9LZrS7ctSdsOtX2jUP0vpR
	 w6cpWnnwjlZjOil1sdurE1hgDgx9btI+eH0zyOmnxuJknxS7VFMWs9yziQ54YG4ikPnLB
	 WRGA226f0FW+/eztZIzIVH5xIZay09LsucXlnuv8z5UOZKmZWnjczFPIEhyMxxiXsRC5H
	 6lMncmalmc+9JwmoR+Wa5Le3Ft5YIFPCGdAF4uH8BGlZy0j2XK3SKfaUrzldXEZDGQ9/d
	 ISLLN0Db5QEjUJ3a8uGsGk8JSkOpnFfCxS3PtpkWJGJzabVQVMHKlwE4Sc+vl0yBsCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=AsB1CyOr;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dcQNhire;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A3606A31D;
	Wed, 21 Oct 2026 01:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31A3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=AsB1CyOr;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dcQNhire
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L0sQHJ2442089;
	Tue, 20 Oct 2026 21:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=URuwE5bz8eWMgV//wrlENNhPFo9Zn9170qnevD1nibo=; b=AsB1CyO
	rPrL6gtPxA5i+tDkSe+TxTZmy12ReNO3dfY8E/QSBdFFX2pPcyyfdV0BK6H66him
	zd4ICsZ4T46WmI7Q3lU3lKAVe+2TK7Gl/C1WOjCb9r2YLEgJqPe064LfXfjgAYqS
	Pcbifp+sNpY6lHoZwn7Q3jCXLvxI9Q5dI3atTlYQWys1P0HWShhASlJn4kETXAlm
	7YyLhIU6UenVlRB7dezHNqFOw1IPJP52zSjVMLO5f/tLirmgsteq1ydw2HurKBdm
	8fHDEL/HIh2u3RH94f4bty69S9w55T3SRIjKYYjoIYhSETQCQOgbw2prmTr9pk/t
	4I63tU/awu8GCMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=URuwE
	5bz8eWMgV//wrlENNhPFo9Zn9170qnevD1nibo=; b=dcQNhiresXVP2SnC51Om9
	qxB1lmEzum3wCq8cAp4QjV5+2n2f6PU9eNj+xU6oIDXOeDJnwYaRjlRp2CRaA86M
	GehcKBIkLa2Y4C8lfCfMuBwwvqAcX8k2J/8ksXMBAitId4uIUAnoTZSqBUakmoTk
	S7pQn7RndT78lesPzb24l5+By7XMfSy2/fEgGkkLNIazwPVQI+svtCGRhS8LxGhZ
	tHHnjlCJnp21kdOTd/KOUXO7LxQizlfLpjyv4MxhtvfJ2dpdOmUMzMsmybia4PqV
	zry7OVEkU42G5T1lQeu+nNw6RR0aRpY7a5t6wrXazl/nPuTU5dbedeM2BYbG+bUL
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hef2khjqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:59:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69L1xBQg062433
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:59:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 20 Oct
 2026 21:59:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:59:11 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1ww6w029102;
	Tue, 20 Oct 2026 21:59:01 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 9/9] iio: adc: ad7768-1: add support for multiple chip aggregation
Date: Tue, 20 Oct 2026 22:58:53 -0300
Message-ID: <7afbafd67ad52b2342af30c278b8b001413221ee.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX4pex+0BXBLHt
 rf3cMi05e6T8nS49RfRkSvhSclmyIDRehUdrrCKgIWeKQxqfybfIZS3jycEgF1K9l9ciT7HLhuA
 cwpYEbRnPLQM9ZGQ/DRtxCV9OXaB30sE9hFBpB8dXQMFmqKGHay1B8fVIk7VAu92b4Yl/5E2eKX
 NEFaE9WdYhyErBmwI/mpQuJLl3b4yq82i/R11dc1A6pypKphPeTAKCmGxRmcJCe1JOhUKPDJws9
 83eLd2HcbQ94vJF131XW15IIAl6Z6unz4EAFZgQPpaoncog8OaA45DHTWLxlWCLXsAvJ3/6atBP
 DUAf6CGe5ExoIV6WE9oD5LsNnxJ2HQckpx9smZBBPYmTfetoRc331ymkqUo3k7r8CxFTwIlD0bJ
 LStm5IJzeEPDBaHl7YZlzXSBrksCLrHTivDY6KgF/2GwPATkX2ilQC4XK4WjdebkI2AxvYrcSIg
 0dxEbkJvJgXaVtlvgCQ==
X-Proofpoint-GUID: yK2kILLSa7V3mjBjf7Y128AoC22LGoZw
X-Authority-Analysis: v=2.4 cv=KIHPn1Fo c=1 sm=1 tr=0 ts=6ad81c70 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=1TctlgW-Hzn0q3-P7isA:9
X-Proofpoint-ORIG-GUID: yK2kILLSa7V3mjBjf7Y128AoC22LGoZw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX3ePuSpbond4H
 v0j7vDZ0gY3zl1QoOZGlk17b6EPwQxRy4PZj3V4hQummkbq1ZQaqmJu0lQYdeejLT7styYsdVL0
 0qhDVLpE00s1Bzm+7K6d12P1zQSxNE3C6IjYw5KrMI3jZtERw35I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210007

The AD7768-1 family is a single-channel ADC, but it is designed to allow
connecting multiple devices to the same SPI controller, each on a
dedicated CS and data lane, clocked synchronously, and sharing SDO and
SCLK. The number of aggregated devices is derived from the number of
CS.

The DRDY pins are combined to trigger the data interrupt when all
devices are ready, and since the synchronization pins are tied, they
stay in synchrony.

To reflect the multidevice setup, IIO channels are dynamically set
based on the number of devices. Restrict buffered capture to the
all-channels scan mask, since all devices sample in lockstep. Register
an ancillary SPI device per lane for individual direct reads, and enable
SPI_MULTI_LANE_MODE_STRIPE in offload mode to interleave samples from all
lanes into the DMA stream.

Since all devices must be in sync, all configurations that affect the
sampling rate are unified, so they always have the same sampling
frequency.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* Fixed the st->offload_xfer.len calculation to account for multiple 
  devices.
* The number of aggregated devices is now defined by the number of CS
  instead of number of lanes.
* Used devm_bitmap_zalloc() and bitmap_set() for the masks allocation
  and definition, as requested.

Changes in v3:
* Modified channel mask allocation on ad7768_parse_aaf_gain() to get 
  a static value, Since we assume the family is single channel. Added a 
  comment explaining.

Changes in v2:
* New patch.
---
 drivers/iio/adc/ad7768-1.c | 100 +++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 3972821c295a..064b4b394a2e 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -6,6 +6,7 @@
  */
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -20,6 +21,7 @@
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -120,7 +122,8 @@
 
 #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
 
-#define AD7768_MAX_CHANNELS 1
+#define AD7768_MAX_CHANNELS	1
+#define AD7768_MAX_AGGR_DEVICES	4
 
 #define ADAQ7768_PGA_PINS 3
 
@@ -300,10 +303,12 @@ struct ad7768_chip_info {
 
 struct ad7768_state {
 	struct spi_device *spi;
+	struct spi_device *spi_anc[AD7768_MAX_AGGR_DEVICES];
 	struct spi_offload *offload;
 	struct spi_offload_trigger *offload_trigger;
 	struct regmap *regmap;
 	struct regmap *regmap24;
+	struct regmap *regmap24_anc[AD7768_MAX_AGGR_DEVICES];
 	int vref_uv;
 	struct regulator_dev *vcm_rdev;
 	unsigned int vcm_output_sel;
@@ -322,11 +327,12 @@ struct ad7768_state {
 	struct gpio_descs *pga_gpios;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
-	const char *labels[AD7768_MAX_CHANNELS];
+	const char *labels[AD7768_MAX_CHANNELS * AD7768_MAX_AGGR_DEVICES];
 	struct gpio_chip gpiochip;
 	struct spi_transfer offload_xfer;
 	struct spi_message offload_msg;
 	const struct ad7768_chip_info *chip;
+	u8 num_devices;
 	bool en_spi_sync;
 	struct mutex pga_lock; /* protect device internal state (PGA) */
 	/*
@@ -335,7 +341,7 @@ struct ad7768_state {
 	 */
 	union {
 		struct {
-			__be32 chan;
+			__be32 chan[AD7768_MAX_AGGR_DEVICES];
 			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
@@ -478,9 +484,10 @@ static int ad7768_set_mode(struct ad7768_state *st,
 				 AD7768_CONV_MODE_MSK, AD7768_CONV_MODE(mode));
 }
 
-static int ad7768_scan_direct(struct iio_dev *indio_dev)
+static int ad7768_scan_direct(struct iio_dev *indio_dev, unsigned int chan)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	struct regmap *regmap;
 	int readval, ret;
 
 	reinit_completion(&st->completion);
@@ -492,7 +499,8 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (!ret)
 		return -ETIMEDOUT;
 
-	ret = regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &readval);
+	regmap = st->num_devices > 1 ? st->regmap24_anc[chan] : st->regmap24;
+	ret = regmap_read(regmap, AD7768_REG24_ADC_DATA, &readval);
 	if (ret)
 		return ret;
 
@@ -989,7 +997,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		ret = ad7768_scan_direct(indio_dev);
+		ret = ad7768_scan_direct(indio_dev, chan->channel);
 
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
@@ -1388,9 +1396,11 @@ static int ad7768_offload_buffer_postenable(struct iio_dev *indio_dev)
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
-	st->offload_xfer.len = spi_bpw_to_bytes(scan_type->realbits);
+	st->offload_xfer.len = spi_bpw_to_bytes(scan_type->realbits) * st->num_devices;
 	st->offload_xfer.bits_per_word = scan_type->realbits;
 	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	if (st->num_devices > 1)
+		st->offload_xfer.multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
 	st->offload_msg.offload = st->offload;
@@ -1694,6 +1704,63 @@ static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
 	return 0;
 }
 
+static int ad7768_probe_multidevices(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *channels;
+	unsigned int mask_longs;
+	unsigned long *masks;
+	size_t num_chans;
+	unsigned int i;
+	u8 cs;
+
+	num_chans = size_mul(st->num_devices, st->chip->num_channels);
+	channels = devm_kcalloc(dev, num_chans, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	indio_dev->num_channels = num_chans;
+	for (i = 0; i < num_chans; i++) {
+		struct iio_chan_spec *chan = &channels[i];
+
+		*chan = *st->chip->channel_spec;
+		chan->channel = i;
+		chan->scan_index = i;
+	}
+
+	indio_dev->channels = channels;
+
+	/*
+	 * One scan mask with all devices enabled, plus a zero terminator. Each
+	 * mask spans BITS_TO_LONGS(masklength) longs.
+	 */
+	mask_longs = BITS_TO_LONGS(indio_dev->num_channels);
+	masks = devm_bitmap_zalloc(dev, 2 * mask_longs * BITS_PER_LONG, GFP_KERNEL);
+	if (!masks)
+		return -ENOMEM;
+
+	bitmap_set(masks, 0, num_chans);
+	indio_dev->available_scan_masks = masks;
+
+	/* Setup ancillary SPI devices for single device access */
+	for (i = 0; i < st->num_devices; i++) {
+		cs = spi_get_chipselect(st->spi, i);
+		st->spi_anc[i] = devm_spi_new_ancillary_device_with_lane(st->spi,
+									 cs, i, 0);
+		if (IS_ERR(st->spi_anc[i]))
+			return dev_err_probe(dev, PTR_ERR(st->spi_anc[i]),
+					     "failed to register ancillary device\n");
+
+		st->regmap24_anc[i] = devm_regmap_init_spi(st->spi_anc[i],
+							   &ad7768_regmap24_config);
+		if (IS_ERR(st->regmap24_anc[i]))
+			return PTR_ERR(st->regmap24_anc[i]);
+	}
+
+	return 0;
+}
+
 static bool ad7768_offload_trigger_match(struct spi_offload_trigger *trigger,
 					 enum spi_offload_trigger_type type,
 					 u64 *args, u32 nargs)
@@ -1833,6 +1900,12 @@ static int ad7768_probe(struct spi_device *spi)
 		return -ENODATA;
 
 	st->spi = spi;
+	/* Infer the number of devices from the number of CS */
+	st->num_devices = spi->num_chipselect;
+	if (st->num_devices > AD7768_MAX_AGGR_DEVICES)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "Too many devices (%u), max %d supported\n",
+				     st->num_devices, AD7768_MAX_AGGR_DEVICES);
 
 	st->regmap = devm_regmap_init_spi(spi, &ad7768_regmap_config);
 	if (IS_ERR(st->regmap))
@@ -1856,11 +1929,18 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->mclk_freq = clk_get_rate(st->mclk);
 
-	indio_dev->channels = st->chip->channel_spec;
-	indio_dev->num_channels = st->chip->num_channels;
 	indio_dev->name = st->chip->name;
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (st->num_devices > 1) {
+		ret = ad7768_probe_multidevices(indio_dev);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to configure multidevice\n");
+	} else {
+		indio_dev->channels = st->chip->channel_spec;
+		indio_dev->num_channels = st->chip->num_channels;
+	}
 
 	/* Register VCM output regulator */
 	if (st->chip->has_vcm_regulator) {
@@ -1892,7 +1972,7 @@ static int ad7768_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
+	ret = ad7768_set_channel_label(indio_dev, st->num_devices);
 	if (ret)
 		return ret;
 
-- 
2.34.1

