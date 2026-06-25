Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1526F29B;
	Thu, 25 Jun 2026 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398168; cv=none; b=Jq98ducbh2eLAC+mouEtJ17Jh/Ntg3XG//cRNOn6nKeu2S6Zk3FQmTvXBmgrRnZTEVdlcORQBBDBFmQhgvqPDhf+8vZnYaqgqk5ScQHFcR3+s+5FMwF3EpSU/F8NG1UYgCiweZ9w9gGwBfoC7sZy3DypSUN8Ym2m4AwzccUTAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398168; c=relaxed/simple;
	bh=wyfJZRWpbHH+8UVJIRWoDWm+ZCQQkeRQb/KVg4VE0fA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unuDSTC4WdE2dWRS31Q9T4OG7sI5+HuHJLdGi4jpKxcPhSFssvaEfmUJZauG77qimYXv4mq7VVcdqV0O9RTIepSOcAdn3e8T8qTM8tQ/7QfuXRmwgT6j/V2Y4Nt6u3v4wkauTGEJ+GYGke1GdcszGR00F7y4k4aF4ldb0PasgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xYqm2/HQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xYqm2/HQ"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PDOkJR3712198;
	Thu, 25 Jun 2026 10:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UHtMI
	QnPOJWv5gu6XIqi6TQtb/U9td3hShol2nhwsjk=; b=xYqm2/HQa9/xj67wpIUWF
	P98yw4VyM+Cg8aee2JVsCkY6/h+6DaA8MMF7cUuTiBfw1EMT2VLL5ImN6i8SG0z8
	BkbbCc0NCHG7uBb5STS2qcSQb4/qfW9g84cFN9sdnxZJFZ8QcAIQWsYUeX9WnEcj
	xPxeFFJiRqQBUGNIHfM/m7Q9XLpyhAyCJ41OiOLDv9NM84ztWffxpJoKHPYn84wx
	9Fr2mwOovV1JNLx5RweVxt7PrpRHSov+Iihwi+6yyJKFA+x0mTMucvOc3PDxpHx0
	sIy8PXo0ZMUpgX5qUYaO24NzTyAmTOlhqhJ9yjylVOglWh9HAM9Z9QiUwl0eC5Ai
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f12em193b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 10:35:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65PEZwrP048472
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jun 2026 10:35:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 25 Jun
 2026 10:35:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 25 Jun 2026 10:35:58 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65PEZjP2009925;
	Thu, 25 Jun 2026 10:35:47 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 3/4] iio: adc: ltc2378: Enable high-speed data capture
Date: Thu, 25 Jun 2026 11:35:40 -0300
Message-ID: <7d91f48bb03a16e6876e7aeb05fe259e33ae625f.1782397418.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1782397418.git.marcelo.schmitt@analog.com>
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oPA7oR6wFKufENwSlwS3gfitujDNw-OP
X-Proofpoint-GUID: oPA7oR6wFKufENwSlwS3gfitujDNw-OP
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a3d3cd0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=6TZDX-Px4Ew8zm9tUvIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNSBTYWx0ZWRfXwnlV6DfbU4yf
 LqfdEN97kTTeLq5ibfv0w0cqY3YNqyKBuZov0FQAX3RPDlo+KFW26RRzeXRr/UWdRpxuVd7H+K3
 4uq+n2aOrVKX/9D1J1jbSknpq0JMqv5REBR3R3Cx1V/OXBlx3SYwfJVnYkA8t7+F8UgCAR3yqVF
 a1G+YgujA8M7O6L+m0UEFgmtHJBTAacukpBxkjpi/En2hNtTZNyS4Ae6OKBRcBg1exEImkEDEZ/
 I3951RZSZ24CqqRU/LHdYIjk7NGPJBYpm2WS+lcne8z0mucemTcHkKz46bD/AVU3ALSjcQ1RUo4
 lygtWHnCzm3yOnRx/PX5Ymut1y/eIr9K/uXu2VPyPf40FJhEbFXGS8blTwWiVBIXM0Sq39Y3K0p
 jQRLYhIsNwvu/H/x6TFPsdlM9QVBZOdO9SjgPEQQ4SMrznfowaDr0J63lZoFtAQIXbMlLjykgYE
 doeDzALO+br7kTfY7DA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNSBTYWx0ZWRfXwg41m7Afkewv
 zojj+bytpZNQOiKcvhgzW2YqKmgcH1u+D0E0pHC9SbcjVlduGIcgJhcYiwWRucI5AVgdpiYGsVQ
 XJ0UPwkoD1/gZDcwLYRoyq4T52A+esx2uA3L3GZDZDtO6yYByHJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250125

Make use of SPI transfer offloading to speed up data capture, enabling data
acquisition at faster sample rates (up to 2 MSPS).

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4:
- Squashed offload support into main driver since selecting SPI_OFFLOAD and
  depending on PWM is acceptable.

 drivers/iio/adc/Kconfig   |   6 +
 drivers/iio/adc/ltc2378.c | 359 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 362 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 07a8a5911a09..8d2fadbf74b1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -946,6 +946,12 @@ config LTC2378
 	depends on SPI
 	depends on REGULATOR || COMPILE_TEST
 	depends on GPIOLIB
+	depends on PWM
+	select IIO_BUFFER
+	select IIO_BUFFER_DMA
+	select IIO_BUFFER_DMAENGINE
+	select SPI_OFFLOAD
+	select SPI_OFFLOAD_TRIGGER_PWM
 	help
 	  Say yes here to build support for Analog Devices LTC2378-20 and
 	  similar analog to digital converters.
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index 9a9f32e4989b..5b28630003b1 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -12,16 +12,29 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pwm.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/types.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/types.h>
 
+#define LTC2378_TDSDOBUSYL_NS		5
+#define LTC2378_TBUSYLH_NS		13
+#define LTC2378_TCNV_HIGH_NS		20
+
 #define __LTC2378_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _offl)\
 {										\
 	.type = IIO_VOLTAGE,							\
@@ -46,10 +59,19 @@
 #define LTC2378_UNIPOLAR_DIFF_CHANNEL(_real_bits)				\
 	__LTC2378_DIFF_CHANNEL(0, _real_bits, (((_real_bits) > 16) ? 32 : 16), 0)
 
+#define LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(_real_bits)			\
+	__LTC2378_DIFF_CHANNEL(1, (_real_bits), 32, 1)
+
+#define LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(_real_bits)			\
+	__LTC2378_DIFF_CHANNEL(0, (_real_bits), 32, 1)
+
 struct ltc2378_chip_info {
 	const char *name;
 	unsigned int internal_ref_uv;
 	struct iio_chan_spec chan;
+	struct iio_chan_spec offload_chan;
+	unsigned int max_sample_rate_hz;
+	unsigned int tconv_ns;
 };
 
 struct ltc2378_state {
@@ -58,6 +80,15 @@ struct ltc2378_state {
 	struct spi_device *spi;
 	struct spi_transfer xfer;
 	int ref_uV;
+	unsigned int cnv_Hz;
+	struct pwm_waveform cnv_wf;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_message offload_msg;
+	struct spi_transfer offload_xfer;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *cnv_trigger;
+	unsigned int sample_freq_range[3];
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -78,101 +109,161 @@ static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 	.name = "ltc2338-18",
 	.internal_ref_uv = 4096000,
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
 	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
 	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
 	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
 	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
 	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
+	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
 	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
 	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
+	.tconv_ns = 412,
 };
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
 	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
 };
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
+	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
+	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 675,
 };
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
+	.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
+	.tconv_ns = 412,
 };
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
 	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
 };
 
 static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
@@ -254,7 +345,126 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 			*val2 = chan->scan_type.realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->cnv_Hz;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
 
+static int ltc2378_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length, long mask)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = st->sample_freq_range;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * SPI offload wiring schema
+ *
+ *     +-------------+         +-------------+
+ *     |         CNV |<-----+--| GPIO        |
+ *     |             |      +--| PWM0        |
+ *     |             |         |             |
+ *     |             |      +--| PWM1        |
+ *     |             |      |  +-------------+
+ *     |             |      +->| TRIGGER     |
+ *     |             |         |             |
+ *     |     ADC     |         |    SPI      |
+ *     |             |         | controller  |
+ *     |             |         |             |
+ *     |         SDI |<--------| SDO         |
+ *     |         SDO |-------->| SDI         |
+ *     |        SCLK |<--------| SCLK        |
+ *     +-------------+         +-------------+
+ *
+ */
+static int ltc2378_update_conversion_rate(struct ltc2378_state *st, int freq_Hz)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+	unsigned int min_read_offset, offload_period_ns;
+	struct pwm_waveform cnv_wf = { };
+	u64 target = LTC2378_TCNV_HIGH_NS;
+	unsigned int count = 0;
+	u64 offload_offset_ns;
+	int ret;
+
+	if (freq_Hz == 0)
+		return -EINVAL;
+
+	if (freq_Hz < 1 || freq_Hz > st->info->max_sample_rate_hz)
+		return -ERANGE;
+
+	/* Configure CNV PWM waveform */
+	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_Hz);
+
+	/*
+	 * Ensure CNV high time meets minimum requirement (20ns). The PWM
+	 * hardware may round the duty cycle, so iterate until we get at least
+	 * the minimum required high time.
+	 */
+	do {
+		cnv_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
+		if (ret)
+			return ret;
+		target += 10;  /* Increment by PWM duty cycle period */
+	} while (count++ < 100 && cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS);
+
+	/* Double check the minimum CNV high time is met */
+	if (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS)
+		return -EIO;
+
+	/*
+	 * Configure SPI offload PWM trigger.
+	 * The trigger should fire after tBUSYLH + tCONV + tDSDOBUSYL.
+	 * Minimum time needed: TBUSYLH (13ns) + TCONV (part-specific) + TDSDOBUSYL (5ns)
+	 *
+	 * Use the same period as CNV PWM to avoid timing issues.
+	 * Convert back from period to frequency for the SPI offload API.
+	 */
+	offload_period_ns = cnv_wf.period_length_ns;
+	config->periodic.frequency_hz = DIV_ROUND_UP(HZ_PER_GHZ, offload_period_ns);
+	min_read_offset = LTC2378_TBUSYLH_NS + st->info->tconv_ns + LTC2378_TDSDOBUSYL_NS;
+	offload_offset_ns = min_read_offset;
+	count = 0;
+	do {
+		config->periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, config);
+		if (ret)
+			return ret;
+		offload_offset_ns += 10;
+	} while (count++ < 100 && config->periodic.offset_ns < min_read_offset);
+
+	st->cnv_wf = cnv_wf;
+	st->cnv_Hz = DIV_ROUND_CLOSEST_ULL(HZ_PER_GHZ, cnv_wf.period_length_ns);
+
+	return 0;
+}
+
+static int ltc2378_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ltc2378_update_conversion_rate(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -264,6 +474,111 @@ static const struct iio_info ltc2378_iio_info = {
 	.read_raw = &ltc2378_read_raw,
 };
 
+static const struct iio_info ltc2378_offload_iio_info = {
+	.read_raw = &ltc2378_read_raw,
+	.read_avail = &ltc2378_read_avail,
+	.write_raw = &ltc2378_write_raw,
+};
+
+static int ltc2378_prepare_offload_message(struct device *dev,
+					   struct ltc2378_state *st)
+{
+	unsigned int resolution = st->info->offload_chan.scan_type.realbits;
+
+	st->offload_xfer.bits_per_word = resolution;
+	st->offload_xfer.len = spi_bpw_to_bytes(resolution);
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	/* Initialize message with offload */
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(dev, st->spi, &st->offload_msg);
+}
+
+static int ltc2378_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
+	if (ret)
+		return ret;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &st->offload_trigger_config);
+	if (ret)
+		goto out_pwm_disable;
+
+	return 0;
+
+out_pwm_disable:
+	pwm_disable(st->cnv_trigger);
+	return ret;
+}
+
+static int ltc2378_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ltc2378_offload_buffer_ops = {
+	.postenable = &ltc2378_offload_buffer_postenable,
+	.predisable = &ltc2378_offload_buffer_predisable,
+};
+
+static int ltc2378_spi_offload_setup(struct iio_dev *indio_dev,
+				     struct ltc2378_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+
+	indio_dev->setup_ops = &ltc2378_offload_buffer_ops;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma), "failed to get offload RX DMA\n");
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
+static int ltc2378_pwm_get(struct ltc2378_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->cnv_trigger = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
+				     "failed to get cnv pwm\n");
+
+	/*
+	 * Disable the PWM connected to CNV in case it was left running by
+	 * something else.
+	 */
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
+static const struct spi_offload_config ltc2378_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
 static int ltc2378_regulator_setup(struct device *dev, struct ltc2378_state *st)
 {
 	int ret;
@@ -313,7 +628,6 @@ static int ltc2378_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->info->name;
-	indio_dev->info = &ltc2378_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	st->cnv_gpio = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
@@ -321,8 +635,46 @@ static int ltc2378_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
 				     "failed to get CNV GPIO");
 
-	indio_dev->channels = &st->info->chan;
-	indio_dev->num_channels = 1;
+	st->offload = devm_spi_offload_get(dev, spi, &ltc2378_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	/* Fall back to low speed usage when no SPI offload is available. */
+	if (ret == -ENODEV) {
+		indio_dev->info = &ltc2378_iio_info;
+		indio_dev->channels = &st->info->chan;
+		indio_dev->num_channels = 1;
+	} else if (ret) {
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+	} else {
+		indio_dev->info = &ltc2378_offload_iio_info;
+		indio_dev->channels = &st->info->offload_chan;
+		indio_dev->num_channels = 1;
+		ret = ltc2378_spi_offload_setup(indio_dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup SPI offload\n");
+
+		ret = ltc2378_pwm_get(st);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get PWM\n");
+
+		st->sample_freq_range[0] = 1; /* min */
+		st->sample_freq_range[1] = 1; /* step */
+		st->sample_freq_range[2] = st->info->max_sample_rate_hz; /* max */
+
+		/*
+		 * Start with a slower sampling rate so there is some room for
+		 * adjusting the sample averaging and the sampling frequency
+		 * without hitting the maximum conversion rate.
+		 */
+		ret = ltc2378_update_conversion_rate(st, st->info->max_sample_rate_hz >> 4);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to set offload samp freq\n");
+
+		ret = ltc2378_prepare_offload_message(&spi->dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to optimize SPI message\n");
+	}
 
 	st->xfer.rx_buf = &st->scan.data;
 	st->xfer.len = spi_bpw_to_bytes(indio_dev->channels[0].scan_type.realbits);
@@ -393,3 +745,4 @@ module_spi_driver(ltc2378_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.53.0

