Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EF4499B0;
	Thu,  9 Jul 2026 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630269; cv=none; b=j1sjrZBe6JMeIfyvLHsUjs+SePyZW956sjoN/OsdBUc5pTKVuLXAOu11KxDCCCk43W3nnJXvYOUA+eWje0RQznQzMT+B0vCWBjffbCZ9O1S6t84J+bs3oATzD+u9n+jKvl2Q5IsEgoLDJbIlP0uYegXPjVnDdZgOJ1/748CpBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630269; c=relaxed/simple;
	bh=HlVXnkTW+M6pD2MOdQARiJ8VobUyyBCd2ChnZ26s/kY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l05JW7Q1THn1WIcZVfOuAr/fboZ/ab7wNS1SqG0bGKnjqvPSBDfgl5Ygb0kVXvdoTDBMFIZ66G1C1wRILrGdhxAtBS+ZGaBAIPOuQ4UrygOIQgQHqTcUn6yu7vET+tTtSm/3JWrdV4L292/JrXJsjJlic+jgBmgb1uhnbhJhUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HyqJH57V; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HyqJH57V"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HWJUX1468527;
	Thu, 9 Jul 2026 16:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3ujmZ
	eRutVZA/UbD6SHJ2faPpECw9NkE8q2aY9ggMX0=; b=HyqJH57VitW7MkwHPHXcm
	/0FbTe8JKbUmbAWKMAjurIkWaw9XR1vHkouTdHNvmgbv7s0XKNYSeaMsIQCeI80k
	XyNeW5hmhO5o1ygSd+X5UBLQqEvbscX6mDWOksHfyqt0sshFFgZwl1rLYt01eAk9
	+GGczVzxd3RuD5p1vBkYHBQsIs8BeHqY7g2lJvMB8HB+gJrUqaU0wWSGiC8gE1s/
	ZboAwRJKUxNSMLWpTZrsrob70CBe/SSLjfMb6Gzv6Gvo717fU8nNQDj24Om8vXih
	WEUopM6bSFpyhLzBOCEDWvet4Tuz2GjWp0aF8+Gjhq53r/E1WTSq+mboGv6DlaNP
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fa2jgmgw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 16:51:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 669Kp2Gm046480
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 16:51:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 9 Jul
 2026 16:51:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 9 Jul 2026 16:51:02 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 669KokUj003873;
	Thu, 9 Jul 2026 16:50:48 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 4/4] iio: adc: ltc2378: Enable triggered buffer data capture
Date: Thu, 9 Jul 2026 17:50:39 -0300
Message-ID: <0ab99693049d6d98df9521788e8289bb8c15e818.1783629101.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1783629101.git.marcelo.schmitt@analog.com>
References: <cover.1783629101.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIwNyBTYWx0ZWRfX0vukNHff4T/4
 uCphiLrjY2Y5Wr5rLpRekKynz2lX2JAjxCWCYH2IVJOCyn/tLNSjpnIkhDQqK6P8Zhk/CUVvi59
 ElqJGvPJA/IloStD/YjAxJ43vom1k5ItTE1xPTjwvronFMm6mX/k
X-Authority-Analysis: v=2.4 cv=bPcm5v+Z c=1 sm=1 tr=0 ts=6a5009b7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=LKWNKb2UafNwrDgNmc4A:9
X-Proofpoint-GUID: xXAt8GozVymfrjualaWk5jbjcQX_k3Mm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIwNyBTYWx0ZWRfX2X6k3XWqYB4H
 Hd11kflsGzZXRVI7fQVYtT9Txp7sBewJkWd1mYls3JKsB7gVwC5F63dV/4oC9rEct+CqaxrBk+l
 4o3vNVZXSjaUBfaB6Bzd8VdhznZXneUol/f5GgGFYh/KqpN92Fp0/3O9OUcKgT0YawAQRJZyzFD
 N5kDzCoWk81loGcjuG1AhnfKV+ctQvMelh18oo8+zbUfkpiBHwJoukolOifq2mZc0cfotR6TWqk
 chV6eq/eIBxgoHqZRda/AaKnd1ElNx7y2uCupK7WmQR+Aos4nQcq0g2PDhfu86VmzKAnBixC7z+
 OfTiMKnut+GIlmxkwXn4kkmlNXM6zqzYMpTSacZ0VzQj3S3K9E+ACwtBaGN70GTL08PmILtxrGZ
 2uJztSvnee9ifjYhhgw+B0DzK9iz7hTOemI3us2d47+0kraSiQwi0Up7dtYpx+eh7YEtfdOVcm6
 9xYnaCVQ3qyBjeSTR2Q==
X-Proofpoint-ORIG-GUID: xXAt8GozVymfrjualaWk5jbjcQX_k3Mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090207

Enable users to run triggered data captures with LTC2378 and similar ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v6.

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
index 10f1a0c4534b..250ba18643b4 100644
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
@@ -80,7 +83,7 @@
 struct ltc2378_chip_info {
 	const char *name;
 	unsigned int internal_ref_uV;
-	struct iio_chan_spec chan;
+	struct iio_chan_spec chan[2]; /* 1 physical chan + 1 timestamp chan */
 	struct iio_chan_spec offload_chan;
 	unsigned int max_sample_rate_Hz;
 	unsigned int tconv_ns;
@@ -121,7 +124,7 @@ struct ltc2378_state {
 static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 	.name = "ltc2338-18",
 	.internal_ref_uV = 2048000,
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -129,7 +132,7 @@ static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -137,7 +140,7 @@ static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -145,7 +148,7 @@ static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -153,7 +156,7 @@ static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -161,7 +164,7 @@ static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -169,7 +172,7 @@ static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -177,7 +180,7 @@ static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -185,7 +188,7 @@ static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -193,7 +196,7 @@ static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -201,7 +204,7 @@ static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -209,7 +212,7 @@ static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -217,7 +220,7 @@ static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -225,7 +228,7 @@ static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -233,7 +236,7 @@ static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -241,7 +244,7 @@ static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -249,7 +252,7 @@ static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -257,7 +260,7 @@ static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 675,
@@ -265,7 +268,7 @@ static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -273,7 +276,7 @@ static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -293,6 +296,25 @@ static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
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
@@ -677,8 +699,15 @@ static int ltc2378_probe(struct spi_device *spi)
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

