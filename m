Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C31DB95E;
	Wed,  9 Sep 2026 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934793; cv=none; b=pdvCHx16YEgM+Xvybt8G46oflbKQIXEzVU2bOlna3Z/tCOlOTkhKlhLLrnGUd521O2mD3d5cY2hw7wSrPdebiVaLDkrAVPpI7aJHgeuxoSERqtP6y3BKSWgtp5A5eZZcdHgEWPaWJuT5TVT17jR4HFROFL6WPS5WviYWWXdWNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934793; c=relaxed/simple;
	bh=RObY3ClDcp9KwxJI+TSxcg/dFhFS3uZvlyN9en/QO0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lggIhtYJx5ND6kNMX4KUsqai7xRdcnYTN7nO5mt57GCjuACzIv3DMo/s2GRyjrfWuL4J+f8nRZAn0T1l+BTyI9KOZm0r/US6qd/nZ0l+fDD043oO66t9rPpjTGJladTn9T9SFrqtDO4UjUVBW6h++MIGn8J4b+6nQtZJz7ZJp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J3umhEXo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J3umhEXo"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6893am7g3768809;
	Wed, 9 Sep 2026 02:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=77YMd
	fhE2zPUr4irmdwejAC+0nI1AiZfQVXMIIIfYAY=; b=J3umhEXoTS/w42hYsuxYM
	3KF3K6rlqTcoMZNS4vnTKTZ8i3DDweXFOVVpQCMp1Nz78If8QMWJ0YBhVpGkcUQx
	xlxB2/E2vk+9Z3TkQ6Z3xVBTIA5A4bN5FBGUuTkolyvYyVwwyS3psRxL1gA5NZbp
	w20CbUNa1vnGIc6Gm1X5BFzLas6glCt9U/9wZ8/XK4Ym1Bzo1XTk9EBlBq/K34kS
	Nm6NT66m3phSP6n0TdPSLsEZQM7bxn2Tb5KAitm0awCBPGAKFrKzf0zHrzl0PWFh
	HDDW61YwxAlG7Lgjqheb4ckDd1f/t+w6E7Rh+Bjus41XmfTsuzLfI5qZfM0i8owt
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gh4dgd9kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 02:19:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6896Jcgd044551
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 02:19:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 9 Sep 2026 02:19:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 9 Sep 2026 02:19:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 9 Sep 2026 02:19:37 -0400
Received: from 10.98.41.145 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6896JFq7015040;
	Wed, 9 Sep 2026 02:19:29 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Wed, 9 Sep 2026 14:19:10 +0800
Subject: [PATCH 2/2] iio: dac: ad3530r: add support for AD3536R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-iio-ad3536r-upstream-v1-2-16ab930dcee3@analog.com>
References: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
In-Reply-To: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788934755; l=3302;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=RObY3ClDcp9KwxJI+TSxcg/dFhFS3uZvlyN9en/QO0A=;
 b=ptOXredQwW2lyPyw4pU65UOaJHnuqZdLR43wsO7t4sdHVQ0rpqOUxbzcU3Jr0mmwLDQiBIE81
 hi8f3yfTDoBBLzodPhE4zhaVNdb/KTvY4ehxAhASJySU9d1xBQxHz03
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ofyrcJpERc9dLNGt-1YefRB9pe2m16wj
X-Authority-Analysis: v=2.4 cv=f5N4wuyM c=1 sm=1 tr=0 ts=6aa0fa7b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=89PRF9wNsxcC0g65r6wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ofyrcJpERc9dLNGt-1YefRB9pe2m16wj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA3MCBTYWx0ZWRfX9u5bHmLo6Psn
 AbqBnYS5SBYc3QZVhYGOMg+EI6RsGVD/Fu4LczsXGL+yKSrp5E5H7ZBFLgpIWLJ9+Lv/kvE5Za0
 kzyb7tQ2W2loQfttinOdzBHRLHOjH3XHMyeBYByrhAgT9uciIWKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA3MCBTYWx0ZWRfX4tAS2qFscEko
 RedYP+8y1A7uNc7iVGjzhX8IcucVzsP7TvylVkH14/E84RvqaeRSzxaDRIRYDGfNCTpEh8KG/nm
 0YFZryvY1Y4Ta1Kc49Zp+k3O52svhNadAjtCZ2eW9zQ3SxRsgJt6/kPztK5yXjspAEq0kHrGaiy
 AvFF9Iw9gWDqBU9LthN9igCVFZZyfmB1N51S7Qj+6RXu/SI90mrXPZjAmhmboF1rnOWHBo2XaOe
 sBoUygj6b/KHq0k9nDhIIWM7vg4EHtFdtrqmVo7+61ILylhD0CgGe//BJdJQGm79wAbjrU0IYMU
 1OMl/nd9vHHzgJIzn4F91Hf1AL5m9Jn9NzDH/KG/D8UN2KzELkEPhKTp4YHl0MDQuNwrpvjjWIU
 8b834bOXZt3SRME9marZeizeg+Opw+RTfd7ThpVk3TmD5Krr1FKIrdUt++k/NiQff/aB5x5KhSb
 SncdpH68XanAbfyQw+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090070

The AD3536R is the 12-bit variant of the AD3532R, a 16-channel buffered
voltage output DAC with an on-chip 2.5V reference and an identical
register map. Add a chip_info entry for it and the corresponding SPI and
OF device ID table entries.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/Kconfig   |  1 +
 drivers/iio/dac/ad3530r.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index f87b72457b1d..b6c8873c68c5 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -16,6 +16,7 @@ config AD3530R
 	  - AD3530/AD3530R (8-channel)
 	  - AD3531/AD3531R (4-channel)
 	  - AD3532/AD3532R (16-channel)
+	  - AD3536R (16-channel, 12-bit)
 	  - AD5710R/AD5711R (8-channel configurable IDAC/VDAC)
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index 7648aa4da25a..9e043639801d 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -3,6 +3,7 @@
  * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
  * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
  * AD3532R/AD3532 16-channel, 16-bit Voltage Output DAC Driver
+ * AD3536R 16-channel, 12-bit Voltage Output DAC Driver
  * AD5710R 8-channel, 16-bit Configurable IDAC/VDAC Driver
  * AD5711R 8-channel, 12-bit Configurable IDAC/VDAC Driver
  *
@@ -746,6 +747,24 @@ static const struct ad3530r_chip_info ad3532r_chip = {
 	.configurable_ch_func = false,
 };
 
+static const struct ad3530r_chip_info ad3536r_chip = {
+	.name = "ad3536r",
+	.resolution = 12,
+	.channels = ad3532r_channels,
+	.regmap_config = &ad3532r_regmap_config,
+	.num_channels = ARRAY_SIZE(ad3532r_channels),
+	.sw_ldac_trig_reg = ad3532r_trigger_sw_ldac_reg,
+	.input_ch_reg = ad3532r_input_ch_reg,
+	.interface_config_a = ad3532r_if_config,
+	.output_control = ad3532r_out_ctrl,
+	.reference_control = ad3532r_ref_ctrl,
+	.op_mode = ad3532r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3532r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3532r_op_mode),
+	.internal_ref_support = true,
+	.configurable_ch_func = false,
+};
+
 static const struct ad3530r_chip_info ad5710r_chip = {
 	.name = "ad5710r",
 	.resolution = 16,
@@ -1042,6 +1061,7 @@ static const struct spi_device_id ad3530r_id[] = {
 	{ .name = "ad3531r", .driver_data = (kernel_ulong_t)&ad3531r_chip },
 	{ .name = "ad3532", .driver_data = (kernel_ulong_t)&ad3532_chip },
 	{ .name = "ad3532r", .driver_data = (kernel_ulong_t)&ad3532r_chip },
+	{ .name = "ad3536r", .driver_data = (kernel_ulong_t)&ad3536r_chip },
 	{ .name = "ad5710r", .driver_data = (kernel_ulong_t)&ad5710r_chip },
 	{ .name = "ad5711r", .driver_data = (kernel_ulong_t)&ad5711r_chip },
 	{ }
@@ -1055,6 +1075,7 @@ static const struct of_device_id ad3530r_of_match[] = {
 	{ .compatible = "adi,ad3531r", .data = &ad3531r_chip },
 	{ .compatible = "adi,ad3532", .data = &ad3532_chip },
 	{ .compatible = "adi,ad3532r", .data = &ad3532r_chip },
+	{ .compatible = "adi,ad3536r", .data = &ad3536r_chip },
 	{ .compatible = "adi,ad5710r", .data = &ad5710r_chip },
 	{ .compatible = "adi,ad5711r", .data = &ad5711r_chip },
 	{ }

-- 
2.34.1

