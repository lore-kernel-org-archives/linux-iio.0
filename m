Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF941D114;
	Mon, 12 Oct 2026 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803722; cv=none; b=Nby3lDuxl4YvkXwkT2nJ+Wr7o7aVVV9QWClfM2dc0DFo0eAXiGE49cM0PdxmccqIbaAhqjZvzHCef3ruGHpNPAUmVGstS8ljQa+4Ck9WJ8sCJiV0gmoei1AGZpibJ7wkdmAFFA8Jlz7y2NnvshFv/4sJOhZVWbOQY3OsTW6RoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803722; c=relaxed/simple;
	bh=k0dh1T4lvqR6EmGY4J8j70xPoySdxwLEvge2dYehx6I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZVKrAPJO//TzCf4KeYDMWqYBUW1LXUPmhBEzxB+IJgRskGeUCAPnsR0uhbb1xyQ6Uti2B3KDLKQx9vNH+NXjX8qepfA1U/kIb2FKTtvE/YTbncuFT6HcOLFCQ/EhKYcTiIiG++7AEvWGxUuADbVXgnrJUXlOWB1VpOa5izg+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=eOkCCVbL; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fAXpRbFs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="eOkCCVbL";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fAXpRbFs"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8NcYc1713910;
	Mon, 12 Oct 2026 07:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RpBN+
	Z0Q8KyN7wAcPP69qAxRhoqMHCS06I0soE89yac=; b=eOkCCVbLMAEOu4Dl2eB0L
	knMD++ahUnCZGyV5vnCWcAD6sAfnlPPAk/2XB2JVcZIbd5r8S9mm8kWZyAKN7XZr
	jqrPmK2Op/gI5SgD3wjdtCdYsk/vJ4zno4+lCm6byNv5fUJ2ndEsbd07xfxJiBr0
	bZd14TQNziAD8G1TnXYb1RoM7Y0qnJLZag5/x40TK/Yok+kqVZPU7jG4S0GHYepu
	C2lHwT8n8zvCYfZKj4375cSmNDGI3NcdcWzCL/gmLqVmTGnUsQdVcAvESHcUoeTJ
	PwrlMaHnnuWNY/xWWDYAeBeMbsVkqdynyRmdFMW961A87ib/oBv2mPd3dTULhb6m
	w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RpBN+
	Z0Q8KyN7wAcPP69qAxRhoqMHCS06I0soE89yac=; b=fAXpRbFsFjE4pqnQ261UI
	AZCNspBQ8yh3Kq2c3jdpetndGsLm0BMCzZPHGi9Q4b2K/iVKdZAbO8wHZ3FNrOvY
	9erKjnvbrS85FAr7/jWQBwHArKGdEAYXSs1Rx2fH5ARob07dtKu7W9RMHCM4UqYe
	qEPyrEC/S0M+ZLVmdOa6xp/Gi61UuQQ/2ewhlIz4v4ploahFS7Yqn/e5qGGNSTBq
	5+TF26D4BsH4hceEWNynF8f/QgNWlRWU1W1bPX+Tv8udnro2uF/ZH1d/4Yn0EVEl
	rPory/ZOQ6bgGezS3FcpRAbEdp0AVxjbMWzyYwFprUhtrbuJamNfAE1kh56EO42V
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h8r8mhre1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:15:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69CBF8Yi036787
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 07:15:08 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 12 Oct 2026 07:15:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 12 Oct 2026 07:15:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 12 Oct 2026 07:15:05 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69CBE1X1024898;
	Mon, 12 Oct 2026 07:14:45 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Janani Sunil
	<janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Jishnu Prakash
	<jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 3/4] iio: adc: ade9000: add support for ADE9039
Date: Mon, 12 Oct 2026 14:13:39 +0300
Message-ID: <20261012111342.48040-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012111342.48040-1-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=XudvqlF9 c=1 sm=1 tr=0 ts=6accc13d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=lCiKYj-FRYtbH-NUo1MA:9
X-Proofpoint-ORIG-GUID: UB29Zd7-ZP2g5fi3JSXrt-D5eYREVlOj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX5U4YZDfbjlTc
 m1MEEOOiUvnVfMdGgJZANzwdBAO1TYJqemLBFYSQ5UmCJD134IBlnhhUEeFG5D72VMl7OBBixll
 BbV03JCR0Opue3jpacwn7N7rOztAV36Y9RBb/+R9wKGxHn47I/Dv
X-Proofpoint-GUID: UB29Zd7-ZP2g5fi3JSXrt-D5eYREVlOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX6CaAAbeqbgA0
 wQE6PNGy/RSfYksjWWHfK9McVlPNh6glH30fc4ehgoZkJ2c2Q4sKmDQE5X5iuU7pjwcyA7hXPuH
 gjpGZFO02wR4RrXM4O1XEnQxCPMjFmeZN+nxQvnaBzfQXPqXJeaYNOWkmdi3YK0k8LPKC04OFBK
 RAMKSltuZy6Yls88yJgXPJtON6KS5UI5lyCHBQsYTfjMRjtBTR3yV9UAQCFfGT2RJYhbwAQSzTw
 GJXcL/QUAiJIKkQfZtM6sNaGUsDtNuboJeSd4yY7AalrSaWnFRMNHfYRlFpwQSRQNbE38ti5sCs
 dvbSwUC7mBQfoO0wOk34BkgDK/kM62H5YsD4KeFkkOA2kZqv6enfG2fRFBVYWIT5bvBFIe+JQEZ
 HhPRCqwH0CF4CumJUiRo0vK+EBJhDUO3XVP1JWXMV9lXzWiCGvcgxogSQsFOv6GpO2+K+0gQdKh
 LesDLzgty6pJKHCPr7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120044

The ADE9039 is a polyphase energy metering device that is register
compatible with the ADE9000 for every register the driver touches. The
differences relevant to the driver are that it shares the full-scale codes
of the ADE9078 rather than those of the ADE9000, and that it has no total
reactive power register: the register map has no AVAR at 0x211 and no
AVAROS at 0x010, only the fundamental AFVAR and AFVAROS.

Add a chip_info for it and a channel table that keeps the dip/swell events
of the ADE9000 but drops the three total reactive power channels. The
fundamental reactive energy channels are unaffected, as AFVARHR is present.

No change is needed in the CALIBBIAS path: with no channel carrying the
AVAR address, that case is simply never reached for this part.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ade9000.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 02de4809ae31..3052a86c460f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -603,6 +603,7 @@ config ADE9000
 	    - ADE9000
 	    - ADE9078
 	    - ADE9430
+	    - ADE9039
 
 	  The devices feature high-precision analog-to-digital converters
 	  and digital signal processing to compute RMS values, power factor,
diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 03b69556b62f..e7f509bbac77 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -683,6 +683,8 @@ ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL,
 			 ADE9000_POWER_REACTIVE_ENTRY);
 ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS,
 			 ADE9000_POWER_REACTIVE_ENTRY);
+ADE9000_DECLARE_CHANNELS(ade9039_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL,
+			 ADE9000_NO_POWER_REACTIVE_ENTRY);
 
 /*
  * Full-scale codes referred from the respective datasheets. These are the
@@ -718,6 +720,16 @@ static const struct ade9000_chip_info ade9430_chip_info = {
 	.has_digital_integrator = false, /* no on-chip digital integrator */
 };
 
+static const struct ade9000_chip_info ade9039_chip_info = {
+	.name = "ade9039",
+	.channels = ade9039_channels,
+	.num_channels = ARRAY_SIZE(ade9039_channels),
+	.rms_full_scale_codes = 52866837,
+	.watt_full_scale_codes = 20823646,
+	.pcf_full_scale_codes = 74680000,
+	.has_digital_integrator = true,
+};
+
 static const struct reg_sequence ade9000_initialization_sequence[] = {
 	{ ADE9000_REG_PGA_GAIN, ADE9000_PGA_GAIN },
 	{ ADE9000_REG_CONFIG0, ADE9000_CONFIG0 },
@@ -1883,6 +1895,7 @@ static const struct spi_device_id ade9000_id[] = {
 	{ .name = "ade9000", .driver_data = (kernel_ulong_t)&ade9000_chip_info },
 	{ .name = "ade9078", .driver_data = (kernel_ulong_t)&ade9078_chip_info },
 	{ .name = "ade9430", .driver_data = (kernel_ulong_t)&ade9430_chip_info },
+	{ .name = "ade9039", .driver_data = (kernel_ulong_t)&ade9039_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ade9000_id);
@@ -1891,6 +1904,7 @@ static const struct of_device_id ade9000_of_match[] = {
 	{ .compatible = "adi,ade9000", .data = &ade9000_chip_info },
 	{ .compatible = "adi,ade9078", .data = &ade9078_chip_info },
 	{ .compatible = "adi,ade9430", .data = &ade9430_chip_info },
+	{ .compatible = "adi,ade9039", .data = &ade9039_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ade9000_of_match);
-- 
2.43.0

