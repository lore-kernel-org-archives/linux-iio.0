Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B5625;
	Thu, 23 Jul 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836398; cv=none; b=A52ntaz3NsPF7oJwTHAcNSDRe0D55oK3LtpSdcSPGfKxnPR8rIZvjaBqKjnUjoENOn5x/DXHREGpX5/fZAJB7/3ObJptiuPmQiSKvxaz1KXvmpqdTrFk+eR71vSiZPe2E5dGkPtrJOrvPpVxA9nRqZE7eWfIpdCUEIM8ObxOxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836398; c=relaxed/simple;
	bh=SGpbeQv15yY4MuLxvdkmLyUUbm73VYn829J75elBHYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlJqkq2Pe7oUFGBdJ2i26PeIJxcn3zRmv7wzvAxShY5D3JiLWOHnMGoJq0STyZbmGp7cgguwyoR5RbZwOAhyHnLWQywGM5fFtEA2VFgByrLwXSGy5GPSzeGyYLwusCXwmT97kaCNKNFejgGSJc/xC/OPT18jEU1eW3Mo6EV5c68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b48KFOa8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b48KFOa8"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NImkYH2938255;
	Thu, 23 Jul 2026 15:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LzgUm
	OlJJ5EXBfgWk1sCefwpD0YqbNL59zDuwFaBgwY=; b=b48KFOa8Y6ZWrXOpq25tK
	vCrusBCd/Ww05TGn4CUnIEyyDxYlUEpFB0XdbGq+0AbVoIUtGbjY6pMQjelSqR4c
	XYuKM4b7fdAU3ls3RZgYU6Uy+8DfPaN7XxTLR8CIFx0pQVCjcmcJVdLzTnpcxKe8
	N6ogWamMJGkvQVJLhBug3GXT/anlvUbR0+yFBhg+dHxdo92uGSr4jjSD0U7pvFYB
	0ccv2KrPdrZjXrxklxE8Naj5L72KWljCR8QKV89s4+p6ezZPEvUGqy1a5wEnsL3z
	WwKINla8iF6z5edWdTtKr6QawilsYIwB8cn1ZpyuOHamfq7H0M6PJwKBY5XhJlrC
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fj6v4vh3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:53:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66NJrAdF049550
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 15:53:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 23 Jul
 2026 15:53:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Jul 2026 15:53:10 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66NJqsS6030727;
	Thu, 23 Jul 2026 15:52:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v8 3/5] iio: adc: ltc2378: Enable high-speed data capture
Date: Thu, 23 Jul 2026 16:52:49 -0300
Message-ID: <c331ad2c4e4162c285a3c6c89798388ad4962036.1784835663.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1784835663.git.marcelo.schmitt@analog.com>
References: <cover.1784835663.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=DYknbPtW c=1 sm=1 tr=0 ts=6a627127 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=hZRmmEfSnIYLazgqY2MA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 1Ji1teEy4nIhHcYOzPSwQwhLS7zrwALB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5MyBTYWx0ZWRfX23X1DhUmVaSO
 dmDcBus55NjJfxi+l7mZ2Vul97M7ZiuRtwkmgYKHF6F5DF3zHt9vZpPhwZMJVVcAUhUYZZTEkoi
 7HfYgfZZ5HkurZNkf6IPjhwwqWDXb55ymwhWPB91rn8fPJusLhEb
X-Proofpoint-GUID: 1Ji1teEy4nIhHcYOzPSwQwhLS7zrwALB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5MyBTYWx0ZWRfX/LUJcnw5UEKY
 2g72CPkdbJ4WwNgum6p+ldNzkXzHDbKu+xRiFPc6sh7bptcSDm0JoTi0I3J4fPTEyfF2wP6Qtm6
 NregccO3KP7Sq2uHrtWqq2PMWdhjtHLaM3xecPgmMQhR7KwVfHb8leb60qVpMcnHlHDeVb9zp9d
 i1Y9U+L3SfYgRg5ACFaquaHjmqKWlwsKVAUphF9vYUC4R/mLmBu1InyUYc+sOgXxGMGnyOZLN9a
 2YRBGKu70WFdXjcIMsrKrI3LiJQ/XhPnFPYeyOMRVXHgmhH0/aYRyEZdB5YIDrrVZ0X0dgaRB8S
 EESeyHu0t7PY9JcOKrQg3YyHQ2z6l70NAb+MKy+fTIZxNRlge0WDrHxhlbYaZGW+ieoFFCbZvOp
 fVdPE6K6DgrQPXFBbt8Dq1k4rFNBfecyMhwZwS0ftdG3v6sfKvc3qFeNoYlVTk0WTsDuSu7ejSH
 XxXb/0PCqDETvT/ECHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230193

Make use of SPI transfer offloading to speed up data capture, enabling data
acquisition at faster sample rates (up to 2 MSPS).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v7 -> v8:
- Updated channel macros to make up indexed IIO channels.

 drivers/iio/adc/Kconfig   |   6 +
 drivers/iio/adc/ltc2378.c | 407 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 410 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 220c6739a8f2..96df8453b826 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -948,6 +948,12 @@ config LTC2378
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
index 107388f87062..7baee02450d3 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -16,16 +16,27 @@
 #include <linux/device-id/of.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
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
 #include <linux/iio/types.h>
 
+#define LTC2378_TDSDOBUSYL_NS		5
+#define LTC2378_TBUSYLH_NS		13
+#define LTC2378_TCNV_HIGH_NS		20
 #define LTC2378_MAX_DATA_WAIT_US	4 /* max(TBUSYLH + TCONV + TDSDOBUSYL) */
 
 #define LTC2378_CHANNEL(_sign, _real_bits, _storage_bits)			\
@@ -54,10 +65,50 @@
 #define LTC2378_PSEUDO_DIFF_CHANNEL(_real_bits)					\
 	LTC2378_CHANNEL(0, _real_bits, (((_real_bits) > 16) ? 32 : 16))
 
+#define LTC2378_OFFLOAD_CHANNEL(_sign, _real_bits, _storage_bits)		\
+{										\
+	.type = IIO_VOLTAGE,							\
+	.indexed = 1,								\
+	.differential = _sign,							\
+	.channel = 0,								\
+	.channel2 = _sign ? 1 : 0,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.scan_index = 0,							\
+	.scan_type = {								\
+		.format = _sign ? IIO_SCAN_FORMAT_SIGNED_INT :			\
+				  IIO_SCAN_FORMAT_UNSIGNED_INT,			\
+		.realbits = _real_bits,						\
+		.storagebits = _storage_bits,					\
+		.shift = 0,							\
+		.endianness = IIO_CPU,						\
+	},									\
+}
+
+/*
+ * Currently, the available offload hardware + DMA configuration only supports
+ * pushing 32-bit data elements to DMA IIO buffers in CPU endianness. For 16-bit
+ * precision parts, those 32-bit elements (in CPU endianness) contain 2 bytes
+ * with data and 2 bytes always zeroed out. Nevertheless, for the offload use
+ * case, the IIO buffer is configured for 32 storage bits in CPU endianness so
+ * data is correctly aligned in user space despite 2 out of the 4 bytes being
+ * zeros.
+ */
+#define LTC2378_OFFLOAD_DIFF_CHANNEL(_real_bits)			\
+	LTC2378_OFFLOAD_CHANNEL(1, (_real_bits), 32)
+
+#define LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(_real_bits)				\
+	LTC2378_OFFLOAD_CHANNEL(0, (_real_bits), 32)
+
 struct ltc2378_chip_info {
 	const char *name;
 	unsigned int internal_ref_uV;
 	struct iio_chan_spec chan;
+	struct iio_chan_spec offload_chan;
+	unsigned int max_sample_rate_Hz;
+	unsigned int tconv_ns;
 };
 
 struct ltc2378_state {
@@ -67,6 +118,15 @@ struct ltc2378_state {
 	struct mutex lock; /* Protect data acquisition cycle */
 	int ref_uV;
 	struct spi_transfer xfer;
+	struct spi_transfer offload_xfer;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct pwm_waveform cnv_wf;
+	struct spi_message offload_msg;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *cnv_trigger;
+	unsigned int cnv_Hz;
+	unsigned int sample_freq_range[3];
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -87,101 +147,161 @@ static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 	.name = "ltc2338-18",
 	.internal_ref_uV = 2048000,
 	.chan = LTC2378_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
 	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(16),
+	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
 	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
 	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(16),
+	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
 	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
 	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(16),
+	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
 	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
 	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
+	.tconv_ns = 412,
 };
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
 	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(16),
+	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
 };
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
 	.chan = LTC2378_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(16),
+	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
 	.chan = LTC2378_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
 	.chan = LTC2378_DIFF_CHANNEL(20),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(20),
+	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 };
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
 	.chan = LTC2378_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(16),
+	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
 	.chan = LTC2378_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
 	.chan = LTC2378_DIFF_CHANNEL(20),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(20),
+	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 };
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
 	.chan = LTC2378_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(16),
+	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
 	.chan = LTC2378_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
 };
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
 	.chan = LTC2378_DIFF_CHANNEL(20),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(20),
+	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 675,
 };
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
 	.chan = LTC2378_DIFF_CHANNEL(18),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
+	.tconv_ns = 412,
 };
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
 	.chan = LTC2378_DIFF_CHANNEL(16),
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(16),
+	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
 };
 
 static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
@@ -264,7 +384,137 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
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
+	struct spi_offload_trigger_config config = st->offload_trigger_config;
+	unsigned int min_read_offset, offload_period_ns;
+	struct pwm_waveform cnv_wf = { };
+	u64 target = LTC2378_TCNV_HIGH_NS;
+	unsigned int count;
+	u64 offload_offset_ns;
+	int ret;
+
+	if (freq_Hz == 0)
+		return -EINVAL;
+
+	if (!in_range(freq_Hz, 1, st->info->max_sample_rate_Hz))
+		return -ERANGE;
+
+	/* Configure CNV PWM waveform */
+	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_Hz);
+
+	/*
+	 * Ensure CNV high time meets minimum requirement (20ns). The PWM
+	 * hardware may round the duty cycle, so iterate until we get at least
+	 * the minimum required high time (or reach a try count limit).
+	 */
+	count = 100;
+	do {
+		cnv_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
+		if (ret)
+			return ret;
+		target += 10;  /* Increment by PWM duty cycle period */
+	} while (count-- && cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS);
+
+	/* Check the minimum CNV high time is met */
+	if (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS)
+		return -EDOM;
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
+	config.periodic.frequency_hz = div_u64(HZ_PER_GHZ, offload_period_ns);
+	min_read_offset = LTC2378_TBUSYLH_NS + st->info->tconv_ns + LTC2378_TDSDOBUSYL_NS;
+	offload_offset_ns = min_read_offset;
+	count = 100;
+	do {
+		config.periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+		if (ret)
+			return ret;
+		offload_offset_ns += 10;
+	} while (count-- && config.periodic.offset_ns < min_read_offset);
+
+	/* Check the minimum CNV to SCLK delay is met */
+	if (config.periodic.offset_ns < min_read_offset)
+		return -EDOM;
+
+	/* Check the PWM periods remain the same */
+	offload_period_ns = div64_u64(HZ_PER_GHZ, config.periodic.frequency_hz);
+	if (cnv_wf.period_length_ns != offload_period_ns)
+		return -EDOM;
+
+	st->offload_trigger_config = config;
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
@@ -274,6 +524,111 @@ static const struct iio_info ltc2378_iio_info = {
 	.read_raw = &ltc2378_read_raw,
 };
 
+static const struct iio_info ltc2378_offload_iio_info = {
+	.read_raw = &ltc2378_read_raw,
+	.read_avail = &ltc2378_read_avail,
+	.write_raw = &ltc2378_write_raw,
+};
+
+static int ltc2378_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, true);
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
 static int ltc2378_refin_setup(struct device *dev, struct ltc2378_state *st)
 {
 	int ret;
@@ -339,7 +694,6 @@ static int ltc2378_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->info->name;
-	indio_dev->info = &ltc2378_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	st->cnv_gpio = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
@@ -347,8 +701,53 @@ static int ltc2378_probe(struct spi_device *spi)
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
+		st->sample_freq_range[2] = st->info->max_sample_rate_Hz; /* max */
+
+		/*
+		 * Start with a slower sampling rate so there is some room for
+		 * adjusting the sample averaging and the sampling frequency
+		 * without hitting the maximum conversion rate.
+		 */
+		ret = ltc2378_update_conversion_rate(st, st->info->max_sample_rate_Hz >> 4);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to set offload samp freq\n");
+
+		ret = ltc2378_prepare_offload_message(&spi->dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to optimize SPI message\n");
+
+		/*
+		 * Set single-read transfer bits_per_word so the SPI subsystem
+		 * rearranges data to CPU endianness, enabling us to reuse
+		 * offload_chan specifications for single-shot reads.
+		 */
+		st->xfer.bits_per_word = st->info->offload_chan.scan_type.realbits;
+	}
 
 	st->xfer.rx_buf = &st->scan.data;
 	st->xfer.len = spi_bpw_to_bytes(indio_dev->channels[0].scan_type.realbits);
@@ -419,3 +818,5 @@ module_spi_driver(ltc2378_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
+MODULE_IMPORT_NS("SPI_OFFLOAD");
-- 
2.53.0

