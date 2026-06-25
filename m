Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD42D5412;
	Thu, 25 Jun 2026 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398186; cv=none; b=eT6zm1H5IFq/C1RDkKPj6WuFdXttKJ6mRIfE+YBCwDv7vPAhRpM43zUlv6jkLldYvJ9yVKy1jwwGDuhVH5wRGjRzpAeSxdlpFuMhYTcntlTwLdMonSuN5N3iL7aeCigg3lUFVS5qxp0hCcHTc+iaTnnNqZRZOSLZdfEJZxZlppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398186; c=relaxed/simple;
	bh=A7O0nwM2hcG1TjSPABtKtBeDbqoapZ8PlZ1+87Lw3Ao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmAsG6IwYIDSrUG+WNihxpjWVMRugclfcDZzBqXtkgqkJZkonsQcsseTsTMJKHPE4k+w+oIO3ZpA0emnacItOt0xgq2P+DW3RH1nZsxYhX2yS+jvi6TTRBVE+uhylkMNX9ASGSYm9s++71RBdEbm0h9FKelDtDNRPFcvh4Q8xzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qQ1ZJSXm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qQ1ZJSXm"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PAfxDG3238929;
	Thu, 25 Jun 2026 10:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ox2Gb
	h5WL/ej84GImQpx0m/i3ZhTmiIMBtMkrUIFxOE=; b=qQ1ZJSXmQy5P6xpnzrdhY
	VEeAzvJ/6IfIO2jYrLeWEZKiSMxxyeIBjuEGTKhLe9GJ1atsBBx6MeNkJDWeKHhA
	HeGiqOdyw5brrLDCV+A7/PjJUxvoYa0NTlg590h7AqAS67Eykb0YueQTgim6+wA3
	qdgRSjmzkVorD6xjRh7bq+Aaq/lTlcmOtlArBAYCeHkntqBckN+zJiKaQ3jeA07Q
	PmOed2ylkzZaDZx690EdfHG+iESiIKBOdZ2o8DCxXQGB4B0kmMT255hwB4LeUB0C
	9SzY+QW4u77XsQni4VxE8oUPC56yg4FV0I7RAp8orhppoQ37aaVUcIkfdqqymcGW
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f0yf1t5pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 10:36:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65PEaKEJ048607
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jun 2026 10:36:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 25 Jun
 2026 10:36:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 25 Jun 2026 10:36:18 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65PEa7G7009929;
	Thu, 25 Jun 2026 10:36:09 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 4/4] iio: adc: ltc2378: Enable triggered buffer data capture
Date: Thu, 25 Jun 2026 11:35:59 -0300
Message-ID: <a98804f122b7c1d1c159ba20060a250ebe2caaed.1782397418.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNSBTYWx0ZWRfX5I/PEvZlWodF
 TI9NqTMIz5Q7R8/4p8wIc/J1xOYrOLGhwJQxaA2W59vwPTZ4BIu087YsuV7qJbPRRIViKYETzdh
 Kyvv8v6xqmV9loqHWMoeHoTrTkgOlahweJUQYwTWan2j/OfH+fNMEmvvSoEW21kjzJYlLtyaOSj
 9m8TkrMHZur2WuoUu/DzySV2fPwgXrYq6YbMiqKahRjjrXo59ZFa16eJbInATa+4A85DrpbndBS
 Z2Y8XZXQPW+oSxn3MLO7Oa4GDnuUxgy3CC+bpYVKaPdUEDcTAeZzdGw6zkelGVjdAwRRjOPGJBF
 YsueR9nA/ZiGGWw0HV/CycoOJww5vcqDzHmLZKJtLJqd9hmjLNcAkoSC3WrV6Akh3qfr32DQcRT
 X7bCvbQc1dqxQYpkNjjOhwa2A9nu+tgdmu5My8ugNj1oSuSOMi1xZZnoXlh5kET5XYQH3xUzy7f
 IEMiEN3L7UHCAns8PbA==
X-Authority-Analysis: v=2.4 cv=bPsm5v+Z c=1 sm=1 tr=0 ts=6a3d3ce5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=LKWNKb2UafNwrDgNmc4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNSBTYWx0ZWRfX81KOr2HB1pBN
 9+vKB5o7uwMAg3RejVEeq3NlRoEz4ec3SBXXjHbiJ8NZmzdMaTFNem0QMXAscpFFlJ0OOjFC6Pf
 rYhHmlsWkBVEEAawD0k/ugQDTWJGqO2EEtCW7SYGNRU8l8eFwpE8
X-Proofpoint-ORIG-GUID: 2BYR26-WCaEHtxmBotD9pwgyYlQ2MuZg
X-Proofpoint-GUID: 2BYR26-WCaEHtxmBotD9pwgyYlQ2MuZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250125

Enable users to run triggered data captures with LTC2378 and similar ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4:
- Squashed triggered buffer support into main driver.

 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ltc2378.c | 76 +++++++++++++++++++++++++++------------
 2 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8d2fadbf74b1..ac162425dc91 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -950,6 +950,7 @@ config LTC2378
 	select IIO_BUFFER
 	select IIO_BUFFER_DMA
 	select IIO_BUFFER_DMAENGINE
+	select IIO_TRIGGERED_BUFFER
 	select SPI_OFFLOAD
 	select SPI_OFFLOAD_TRIGGER_PWM
 	help
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index 5b28630003b1..fcccd2774549 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -6,6 +6,7 @@
  * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
  */
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
@@ -29,6 +30,8 @@
 #include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/iio/types.h>
 
 #define LTC2378_TDSDOBUSYL_NS		5
@@ -68,7 +71,7 @@
 struct ltc2378_chip_info {
 	const char *name;
 	unsigned int internal_ref_uv;
-	struct iio_chan_spec chan;
+	struct iio_chan_spec chan[2]; /* 1 physical chan + 1 timestamp chan */
 	struct iio_chan_spec offload_chan;
 	unsigned int max_sample_rate_hz;
 	unsigned int tconv_ns;
@@ -108,7 +111,7 @@ struct ltc2378_state {
 static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 	.name = "ltc2338-18",
 	.internal_ref_uv = 4096000,
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -116,7 +119,7 @@ static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -124,7 +127,7 @@ static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -132,7 +135,7 @@ static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -140,7 +143,7 @@ static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -148,7 +151,7 @@ static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -156,7 +159,7 @@ static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -164,7 +167,7 @@ static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -172,7 +175,7 @@ static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -180,7 +183,7 @@ static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -188,7 +191,7 @@ static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -196,7 +199,7 @@ static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -204,7 +207,7 @@ static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -212,7 +215,7 @@ static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -220,7 +223,7 @@ static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -228,7 +231,7 @@ static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -236,7 +239,7 @@ static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -244,7 +247,7 @@ static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 675,
@@ -252,7 +255,7 @@ static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -260,7 +263,7 @@ static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -279,6 +282,25 @@ static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
 	return ret;
 }
 
+static irqreturn_t ltc2378_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ltc2378_convert_and_acquire(st);
+	if (ret < 0)
+		goto err_out;
+
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ltc2378_channel_single_read(const struct iio_chan_spec *chan,
 				       struct ltc2378_state *st, int *val)
 {
@@ -640,8 +662,16 @@ static int ltc2378_probe(struct spi_device *spi)
 	/* Fall back to low speed usage when no SPI offload is available. */
 	if (ret == -ENODEV) {
 		indio_dev->info = &ltc2378_iio_info;
-		indio_dev->channels = &st->info->chan;
-		indio_dev->num_channels = 1;
+		indio_dev->channels = st->info->chan;
+		indio_dev->num_channels = ARRAY_SIZE(st->info->chan);
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ltc2378_trigger_handler,
+						      NULL);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup triggered buffer\n");
 	} else if (ret) {
 		return dev_err_probe(dev, ret, "failed to get offload\n");
 	} else {
-- 
2.53.0

