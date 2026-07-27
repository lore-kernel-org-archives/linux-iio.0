Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3137DAD7;
	Mon, 27 Jul 2026 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187925; cv=none; b=WvniAxW5kIqIiaFv5s1SnnlS4G7XZNiArIRLW3Yx+QJ0/cu1ZFPdgUPGl1PHg50GHUNSf4bnfA26nWq6FAUPuPV3dX/BEWj6kuKQDvGQgE4PAz2fBxcLx6LinjA/JYr8KIXNOdB66MsHZM+gmK3vPw+C3e0bQ/3PvZDcgjvvQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187925; c=relaxed/simple;
	bh=Ccvryw5P31XRTmO8aMbj0vkVmC6+WH31BctH2FxFMzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSzHDKE9INIGtubnpZIwctxCVISwCtMQr1ZuJ7c2bD32ILjMVSg47q0Nm7vUOQQcJ6cj7mrHfKcebGdFF32Vp8uBgkw3+/ZpKZ3tB+71jFy2oIW8eIti+KvHfqO0HwmRw5BH73xstRQxUtU7vYD1itqs6YnNQcwMP7pVGMiKn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jfogxF4u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jfogxF4u"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIGbvv763265;
	Mon, 27 Jul 2026 17:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0Xcc5
	xm/udGgiQ/214QZSWSxu9gLNhWpdHq/UvsSWxo=; b=jfogxF4uVUuzEDleA4A4h
	ZyvY3ig+w+NlWFz3VCTSIbiOIPZfx+zdxskWR9Ka+O1OG/3ViOLIrRLn9Q0LI0yW
	Rm6HkRC2N6xV9ysUJK23Qqo+tw+B4K17o1qJRM7mwaPKKYAOYAJhIU8z7YUK/vHk
	0uSvd4sLmpsABio5BY3qPIIDbNmvy3mus+Fz73HA+OnCZ0Dt1djWev/LsEbdt7IS
	Qg8tx1YbIfqfo3dIqFq2qvRrbqypARh3v9Hap3RGUjv6o6BFhE9eWbmkBJqvbCAR
	CLxkASFuaR/MlJhX1frFky+Ini3JdL1FDLDrDmV5TvEdKRomnRuQuWasD7w3qZ9R
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fp5f7jbfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:31:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66RLVuRP003992
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 17:31:56 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Jul 2026 17:31:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Jul 2026 17:31:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Jul 2026 17:31:56 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66RLVhii017473;
	Mon, 27 Jul 2026 17:31:45 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v9 4/6] iio: adc: ltc2378: Enable triggered buffer data capture
Date: Mon, 27 Jul 2026 18:31:37 -0300
Message-ID: <6a543eee39b1aa8cee6a2455bb84e483b425746b.1785186980.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1785186980.git.marcelo.schmitt@analog.com>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6qxyrXyqWOSJ2VhA-mR3r9U8IF0VxCze
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfX5V8yEYVcA/mS
 tegvdGhpEp4QEn/8An0qUpYzlMYRluwsoWSMCSkKnXdGJFXDiVWesN/Hlj9yNyTjU3syI6cjLAO
 T/OUFJ3XPX9//PT/X4lUWa7ndw2CC04QVY5tRTehmfWCNYH0MnyueYPLjuDr1a1PDIelBPMTCuz
 K3F05wZhCOykk05G0SZ6IUBuYAwjqxTptLHBosTNxM6MvLsEZdDRo0vh0r8r5ZsLk2jdtDbnFjy
 B92U0gODStQcFO1bl+Opu/LaMa5/4gIjwpB9biygRC5+qjcmTI12wQYGW8P0NipDYZiTJDhKQ2X
 00Mudt7uBjBoYl+XLwpuzPCK7y6yusVyy+X0im+1G9/xD6dngKrAUbjPs27qMg7pfp8JUGjUW5W
 Ff3HUy9zL13mXcQF/gHW7cy/AlWy3uZ/VEBFpruUpo/1aH8e5qS41FAYfWSSl2hASf/aa0mEW5F
 S5oQtfapjEKutN4ELnw==
X-Proofpoint-GUID: 6qxyrXyqWOSJ2VhA-mR3r9U8IF0VxCze
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfXzif1qc9Ax2oc
 ekEGPR7ipvhLePwHSrGrFVDhCq7s8A/OTGQQX3W56TcVZPGq9+trZe5+lXiVmqzTALo5P6ALRve
 xVYRLJzYl3rriuMiBrcy0ediKDnBJFi+WXahowKturzsgpBxl8Wf
X-Authority-Analysis: v=2.4 cv=dPSWXuZb c=1 sm=1 tr=0 ts=6a67ce4d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=rAq0Ks25e31L1SkY5dIA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270193

Enable users to run triggered data captures with LTC2378 and similar ADCs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v8 -> v9:
No changes in v9.

 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ltc2378.c | 73 +++++++++++++++++++++++++++------------
 2 files changed, 52 insertions(+), 22 deletions(-)

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
index 48380a2d7dc6..146eaadbeb6c 100644
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
@@ -104,7 +107,7 @@
 
 struct ltc2378_chip_info {
 	const char *name;
-	struct iio_chan_spec chan;
+	struct iio_chan_spec chan[2]; /* 1 physical chan + 1 timestamp chan */
 	struct iio_chan_spec offload_chan;
 	unsigned int max_sample_rate_Hz;
 	unsigned int tconv_ns;
@@ -144,7 +147,7 @@ struct ltc2378_state {
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
-	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -152,7 +155,7 @@ static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
-	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -160,7 +163,7 @@ static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
-	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -168,7 +171,7 @@ static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
-	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -176,7 +179,7 @@ static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
-	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -184,7 +187,7 @@ static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
-	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -192,7 +195,7 @@ static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
-	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -200,7 +203,7 @@ static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
-	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_PSEUDO_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -208,7 +211,7 @@ static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
-	.chan = LTC2378_DIFF_CHANNEL(16),
+	.chan = { LTC2378_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -216,7 +219,7 @@ static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
-	.chan = LTC2378_DIFF_CHANNEL(18),
+	.chan = { LTC2378_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -224,7 +227,7 @@ static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
-	.chan = LTC2378_DIFF_CHANNEL(20),
+	.chan = { LTC2378_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 250 * HZ_PER_KHZ,
 	.tconv_ns = 3000,
@@ -232,7 +235,7 @@ static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
-	.chan = LTC2378_DIFF_CHANNEL(16),
+	.chan = { LTC2378_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -240,7 +243,7 @@ static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
-	.chan = LTC2378_DIFF_CHANNEL(18),
+	.chan = { LTC2378_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -248,7 +251,7 @@ static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
-	.chan = LTC2378_DIFF_CHANNEL(20),
+	.chan = { LTC2378_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 500 * HZ_PER_KHZ,
 	.tconv_ns = 1500,
@@ -256,7 +259,7 @@ static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
-	.chan = LTC2378_DIFF_CHANNEL(16),
+	.chan = { LTC2378_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -264,7 +267,7 @@ static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
-	.chan = LTC2378_DIFF_CHANNEL(18),
+	.chan = { LTC2378_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 527,
@@ -272,7 +275,7 @@ static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
-	.chan = LTC2378_DIFF_CHANNEL(20),
+	.chan = { LTC2378_DIFF_CHANNEL(20), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(20),
 	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
 	.tconv_ns = 675,
@@ -280,7 +283,7 @@ static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
-	.chan = LTC2378_DIFF_CHANNEL(18),
+	.chan = { LTC2378_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
 	.max_sample_rate_Hz = 1600 * HZ_PER_KHZ,
 	.tconv_ns = 412,
@@ -288,7 +291,7 @@ static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
-	.chan = LTC2378_DIFF_CHANNEL(16),
+	.chan = { LTC2378_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
 	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(16),
 	.max_sample_rate_Hz = 2 * HZ_PER_MHZ,
 	.tconv_ns = 322,
@@ -307,6 +310,25 @@ static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
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
@@ -671,8 +693,15 @@ static int ltc2378_probe(struct spi_device *spi)
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

