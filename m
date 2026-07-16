Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91903BED4A;
	Thu, 16 Jul 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236255; cv=none; b=CXccsoAnTT8Sr19oTbFs8jgCJXSvpEsw8Y9QqZrhlNziwbxk7n0xBu054yff0rXv6AgrtGG2lgGaX0piRuPvyzWBrp+rGFna4iXzTY0tamQTZpNNGisB0osk6a0igDI5rYjgvrTHoyWvA+O3T0hPBF4ON2mIKp75CC0p03ya104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236255; c=relaxed/simple;
	bh=YQ+35bixFRk5LjKcwR9TKmYCGQ96yG6Y8OP6vn0WThQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh48mb8uKqUuEh57SJbCkLrWld+HlgUc3N7NAzXhlYsMT0QqZwCP0Z5B84EYQDIO3EipmxxMvZpkkfOza+4L3qE4ExwX538hTAvVZ7UVDcwGj1jPILl1RpyMzlSDGRue0mRedawgvRQIXU9VaRSv9rw3Jq/1CaP1lnq1OMnOUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TpLEFeRw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TpLEFeRw"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GJq7Ae259810;
	Thu, 16 Jul 2026 17:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y2Tfk
	zMIDC1JwdFmDJ15x9Y/QzBTUwKxZGwdZWrlq2I=; b=TpLEFeRwsovg79W1Saiz+
	N7FTtavLBBdOVCucjSAiwyj4sQPEGITFnNdPzYimEyt+KQ33H0VCsZqs2JHVxlSn
	Q4c55/RUpuh6karO8H3XxTHlYrnSq0pAiMQ1LztLFU1wl0rfOa0WX31bdLjBtUiw
	TKoEMuAdD5nTru5JElmsKVi4EZ7gRXFLoVl2VvBrTkDiemqwP/0qfiNqAomw5b1F
	UCISBTUHuRwc3JAmt6oRjsDI52+wLzYqiQKmOyR0a4TTyFscvrOLdrVBDl1DQ9kz
	9bSutZvenoQyARAv4JGeF8OCjKyC4frp8LWPwV6oa9i+IwEBqaXjBIp8EYlG1R3E
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe70e7bx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:10:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66GLAmDX004361
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 17:10:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 16 Jul
 2026 17:10:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 16 Jul 2026 17:10:46 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66GLAY6j004924;
	Thu, 16 Jul 2026 17:10:37 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 4/4] iio: adc: ltc2378: Enable triggered buffer data capture
Date: Thu, 16 Jul 2026 18:10:29 -0300
Message-ID: <6f3984cf270b29a2030271989df179118a70bb3e.1784235595.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1784235595.git.marcelo.schmitt@analog.com>
References: <cover.1784235595.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxNiBTYWx0ZWRfX3ng5op5wEVnb
 XH5YeE0pT51SvieKhqLmMhC6lN4O9Hz/LSDP6v5+D0grKfBB/NvWG2TvFgJreifspAwIYZob8w3
 wzwiTuX5oxqKIY7ILYR68n1TQXpKbu6eEygk1R7KcRBxl9JyWTkSqtaMzQVY2UlnLR8sqLF9Ph4
 uqBiVjZf5RALClJQPPWhTzyuUwmE+Oxl4IMNsG6cmDkqaXZU20xiGRA3uJGbqHt4RacZUMcI8te
 sU8eTkjuzVTOTqC9k2/kYDICdWDGVmY/vNPdxql0XYVo2YmIki2Bei2R7fPA++WmHax7wMnjUn9
 0kQUK4+cVswNa4TEjX/DH8Ci46qWz9vVz5Qa7A8X4VVOYlGgITrpb0/MHlRBB0ggL+lZYBu7bBG
 FI5p/Uf0cvDqHfdW6BxWxNBuY/6dLQyQ7Hz1hUJsY/ddgAe3//USD/mEl/N4B9zEBc+tSnXvHWH
 ZqjFGCxMA0fFJZgbDVQ==
X-Proofpoint-ORIG-GUID: 5wMlK3a4WOCoTUPEP0xmA9dIaEOqYT1g
X-Authority-Analysis: v=2.4 cv=XsLK/1F9 c=1 sm=1 tr=0 ts=6a5948d9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=LKWNKb2UafNwrDgNmc4A:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxNiBTYWx0ZWRfX/0dqdvvhHhzr
 J2U9Xz3ekdjHYQV+umuSO/LqzJiuoqc0O19z7nzSn+ttU366+/LkKX6RvUajETHiHEXPhgp8rY8
 naZ0HWLoQU463mm9o+hLN4Hg09oasGAq+FFZWQQ+wuEc5EG3tnKU
X-Proofpoint-GUID: 5wMlK3a4WOCoTUPEP0xmA9dIaEOqYT1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160216

Enable users to run triggered data captures with LTC2378 and similar ADCs.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7:
No changes in v7.

 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ltc2378.c | 75 +++++++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 96df8453b826..6cf67f7a6eed 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -952,6 +952,7 @@ config LTC2378
 	select IIO_BUFFER
 	select IIO_BUFFER_DMA
 	select IIO_BUFFER_DMAENGINE
+	select IIO_TRIGGERED_BUFFER
 	select SPI_OFFLOAD
 	select SPI_OFFLOAD_TRIGGER_PWM
 	help
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index 7d29f021cb7b..25db69edee4d 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -6,6 +6,7 @@
  * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
  */
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/byteorder/generic.h>
@@ -32,6 +33,8 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/iio/types.h>
 
 #define LTC2378_TDSDOBUSYL_NS		5
@@ -97,7 +100,7 @@
 struct ltc2378_chip_info {
 	const char *name;
 	unsigned int internal_ref_uV;
-	struct iio_chan_spec chan;
+	struct iio_chan_spec chan[2]; /* 1 physical chan + 1 timestamp chan */
 	struct iio_chan_spec offload_chan;
 	unsigned int max_sample_rate_Hz;
 	unsigned int tconv_ns;
@@ -138,7 +141,7 @@ struct ltc2378_state {
 static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 	.name = "ltc2338-18",
 	.internal_ref_uV = 2048000,
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -146,7 +149,7 @@ static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -154,7 +157,7 @@ static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -162,7 +165,7 @@ static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -170,7 +173,7 @@ static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -178,7 +181,7 @@ static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -186,7 +189,7 @@ static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -194,7 +197,7 @@ static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -202,7 +205,7 @@ static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -210,7 +213,7 @@ static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -218,7 +221,7 @@ static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -226,7 +229,7 @@ static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -234,7 +237,7 @@ static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -242,7 +245,7 @@ static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -250,7 +253,7 @@ static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -258,7 +261,7 @@ static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -266,7 +269,7 @@ static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -274,7 +277,7 @@ static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 675,
@@ -282,7 +285,7 @@ static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -290,7 +293,7 @@ static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -309,6 +312,25 @@ static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
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
@@ -697,8 +719,15 @@ static int ltc2378_probe(struct spi_device *spi)
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
+			return ret;
 	} else if (ret) {
 		return dev_err_probe(dev, ret, "failed to get offload\n");
 	} else {
-- 
2.53.0

