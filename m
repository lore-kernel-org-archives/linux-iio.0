Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E83A9629;
	Thu,  2 Jul 2026 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028809; cv=none; b=qPGXpeymMaPesF4TLokUyPhMP7aNcwl1uazrXSiAT8D5dsn+BAASHN/091X44GtdH0KqcMjkvNP9qvQBcO+2w88E7r5dX0S+xQZ746pq3XnEFfbZxwipDSMRpIiLSVbJ4l4w/N3f3h/CyRBxxy6zIdVFG/xaOMvpkTOdRlRctBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028809; c=relaxed/simple;
	bh=H/f8iBU4tXsu/hgMDA+4r3N+lZ2XjXekHcf5getiMnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8hIsZEbBHJ+SYllzseigTJcUfow8A2WcCvaOzezgHM2m/xnnT35zvM9a58W2hj1T1LsL0qJcd2+azJvdGJri1Qgctixc4x7zyqBMYzQIWe0gfcB7rgumM4Dbv6+a7JhfqIYXdCht7FOZbfS4fCypgHtX8gsTZ6LKdZ4dzyCKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zzO86Ym7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zzO86Ym7"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662ItbF73159259;
	Thu, 2 Jul 2026 17:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0yGzL
	IVMyaokkYPfCEyowbun+sZ7UYxJTuRSx6x8FUo=; b=zzO86Ym7iN53tDVE5Kdf9
	DFZlTDOpDR/1W3I8K+sVb3oUaIBr3k4XQh19DXAsAXe4gc9jT6CKpJlzNPwbOeVR
	L3oZV6cT1IBR2Xtl36n4utnL8qSw5tqG4LsRQFVGGST5dMdrNTNlIoL8RhbActuc
	NNlXFN9aIXb2zPdlBXNOgrsnUb2+Kr9TaDzPpCuk/b/Px56LaHq1tWo0FAnh0CQn
	w77Wa/VLbSIT+jum3BmBk/aFF595yi7XWlid4UyymUq6nz/Eaoppp11mwIcMj2qC
	wKhyq92jeETsVHTMRblOFds41g1zCoYokSjLMDdok5OGL78XvUBt6ZYnZICUgKjD
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f4x7mh58u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 17:46:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 662LkeFn051825
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 Jul 2026 17:46:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 2 Jul
 2026 17:46:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 2 Jul 2026 17:46:40 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 662LkRck007762;
	Thu, 2 Jul 2026 17:46:30 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 4/4] iio: adc: ltc2378: Enable triggered buffer data capture
Date: Thu, 2 Jul 2026 18:46:20 -0300
Message-ID: <4d970129f799b6e99a554986c3a10464e06554c1.1783028033.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1783028033.git.marcelo.schmitt@analog.com>
References: <cover.1783028033.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=H7frBeYi c=1 sm=1 tr=0 ts=6a46dc42 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=LKWNKb2UafNwrDgNmc4A:9
X-Proofpoint-ORIG-GUID: 6cNDGrYWZJkMDbv-9hSvxmQhPJalgJPM
X-Proofpoint-GUID: 6cNDGrYWZJkMDbv-9hSvxmQhPJalgJPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIyNyBTYWx0ZWRfX4TJq9geE+906
 MCpQ95n1qDK+pawVNuhyAoyt443XPw7FKSX6zDn+hYw8ISnEah/EGjWCBvJqFvVuJQvCXe7heFW
 LB8WlctdI0iBWvBXDmF3gype8+qwt9rXJux2fuyABPHCLAgNmqkCc1yMidL7IxCFai1KLj+HrcF
 fZMOGQUGYOX7G1UTfzPj98Z1H9LRirVRumomnpYFlGU4FNAGXf605Xke2rI0GmNv6MQ5fYev9yV
 zdmcHPgsU8d7dNA1yQDiqIWHijxvoqNCAIRWTjl+cTJa0N2mhdF09qnlK1kk3TK90HibnMVcI5E
 xcRNjTzXg+vfroLS/egHsyitLFD4EWg2E+GC7OuzTeYAVzoSDWvC/CDLlUAWU6mpVVWYXyWc4+g
 j7QNdtzo/I0XRPKinirSTe8s6DPj3+CmKmpqZ5Lzd4e4IjmkkJgaDq3wLOM63Wj9RGfkP32Lmdw
 8XDwJ7Lvd6L8cwHgVzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIyNyBTYWx0ZWRfX2Jnf98fnHi10
 2aXenwxuT1O35vRX2bU95Cy1fL/KuQGWQIUWRgdQeGY3q921byR8lOOUNPxNnQsq1wDTAPvukZA
 4Aau/814h50j47Tgrxo9LG26COXgrDR3XI42ky0Abew+FAemq9O5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020227

Enable users to run triggered data captures with LTC2378 and similar ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5:
- Dropped error message on devm_iio_triggered_buffer_setup() fail.

 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ltc2378.c | 75 +++++++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 23 deletions(-)

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
index b25602d91bbe..bcaecd484ab3 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -6,6 +6,7 @@
  * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
  */
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
@@ -28,6 +29,8 @@
 #include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/iio/types.h>
 
 #define LTC2378_TDSDOBUSYL_NS		5
@@ -67,7 +70,7 @@
 struct ltc2378_chip_info {
 	const char *name;
 	unsigned int internal_ref_uV;
-	struct iio_chan_spec chan;
+	struct iio_chan_spec chan[2]; /* 1 physical chan + 1 timestamp chan */
 	struct iio_chan_spec offload_chan;
 	unsigned int max_sample_rate_Hz;
 	unsigned int tconv_ns;
@@ -107,7 +110,7 @@ struct ltc2378_state {
 static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 	.name = "ltc2338-18",
 	.internal_ref_uV = 4096000,
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -115,7 +118,7 @@ static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -123,7 +126,7 @@ static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -131,7 +134,7 @@ static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -139,7 +142,7 @@ static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -147,7 +150,7 @@ static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -155,7 +158,7 @@ static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -163,7 +166,7 @@ static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -171,7 +174,7 @@ static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
-	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_UNIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -179,7 +182,7 @@ static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -187,7 +190,7 @@ static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -195,7 +198,7 @@ static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -203,7 +206,7 @@ static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -211,7 +214,7 @@ static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -219,7 +222,7 @@ static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -227,7 +230,7 @@ static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -235,7 +238,7 @@ static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -243,7 +246,7 @@ static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 675,
@@ -251,7 +254,7 @@ static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -259,7 +262,7 @@ static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
-	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+	.chan = { LTC2378_BIPOLAR_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -278,6 +281,25 @@ static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
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
@@ -658,8 +680,15 @@ static int ltc2378_probe(struct spi_device *spi)
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

