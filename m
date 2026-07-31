Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4B3D953A;
	Fri, 31 Jul 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486655; cv=none; b=frerlM9xs9zXrMjAwWvXlMP1M3nqrl0uI3eVKEWnN/lBPsHbuJFF5L2sGe3VjlR1HnW296K7zQIr3Ghrvfpa6fLfIGsN2tIJ+b9jlT3/L1EX3zdJzklovYDqUdHoQN0p5K92paTm/I2N7d8gzHN6C5Cr7VEsO11L76I4nqSUQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486655; c=relaxed/simple;
	bh=80lx2QP9Q84pUQbWXF6tTDBmLo/A1sVN7UUPcL6f0PY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLX2PkXWFFgaU32PKu2zrnOz/k5WtAXhbMsfMNAuKKB+0/+TiIbiQbiOPFPmTPKJaNoRbTNMHhcAaWrN/kkdGKJ8atMcUXC1/kMikAbQTcPZPPLFSFhWBPkulYcfZVYILYUsE+rUapKDLM+X9GqE7g8hzBPdjGlggIBmIxM6gOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h0g018h1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h0g018h1"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7xZPL2896907;
	Fri, 31 Jul 2026 04:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fkL1q
	HNxjHzfC8+5BLUM/Ym9nmK/SDKvYfqICN+Jz0k=; b=h0g018h1frosAIJHfLpjz
	9UuZrLYOFHe6eFRacgLHBVzDeCHrCaDABTh8BRupgBmY/mO0lZ1pCqwYtW+d9xHo
	EfTN2pahL9SH6cE+qG00jdXGFjDp8jAAVRTa+Mz0N8W9zIb62x5vyTweh0L2aBgk
	nuwH+0jwKdgoLIveW311o5T2vEgtuhTUGFA7iJKGRfkX5q7SqvlYA0v791rp6isf
	9RHPvoA/U5K2E5DOWOcvWSSNP3vsNmvcK38t87pFkNzKp3MBdXS+w8AxyPunzeD9
	v15IkrOi3OaycltiLcVGH8iVeknxB7o9ls8inTV54EcofSA8/8hpAr4BKta4uRct
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fqag4kd6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 04:30:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66V8UdeE039906
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 04:30:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 31 Jul
 2026 04:30:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Jul 2026 04:30:39 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66V8UDN9026738;
	Fri, 31 Jul 2026 04:30:33 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Radu Sabau <radu.sabau@analog.com>,
        Marcelo
 Schmitt <marcelo.schmitt@analog.com>,
        Jorge Marques
	<jorge.marques@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 3/4] iio: adc: ade9000: add support for ADE9078
Date: Fri, 31 Jul 2026 11:29:49 +0300
Message-ID: <20260731082951.1228-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731082951.1228-1-antoniu.miclaus@analog.com>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=V/tNF+ni c=1 sm=1 tr=0 ts=6a6c5d30 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=YwgtIo4Oc6jtI8F_Jh8A:9
X-Proofpoint-GUID: gYnP_IoxA3uisTU5tvHJ0ssfbgObGVyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfX6Npl/6OXbv81
 KDBC3pr1AMI0JqA1tt0o9lTCl8uiP2+k4xmLrTr6wtJkyyQc9wcl8Pm0ke7xJCkYvEXJlu1zz9e
 u8KcxyB0t4QMdhIhpMKEcTLzxyiVlfwDdnRPrd43EQvERt5Marl8UvQabbESj6Gpx5FrDvq9IGW
 s4ZCdk3D6L8EPRe1FyBkMnBxNbMdqaVXoNP922pvCgBumuOOh7M8maOIXVWsbPUZoMNdsV+xaUO
 X/Y2WT/TSjwRf2h1VooVFy8ipzQsUk0J92qWeQUb/byfnwitp07e+X+W0KxaEXm4PmIKwqw+KqX
 B9FwwafNS+A78MYgc6OVAKV6qGBphd+z6mGQURq2tYeAmFbZvn/PBfm4tXqWe1Zh70VAaaMrijF
 B3mu0jrNpFmzPIg39jg+kCZqKwnjRLlHPav9rUF9j7KFahPhzvmCstBhvBnaH/iNH7u5J4w7lFu
 IRhptASyhcRt9PA5ZjQ==
X-Proofpoint-ORIG-GUID: gYnP_IoxA3uisTU5tvHJ0ssfbgObGVyC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfX2QJ/bBMD4OeP
 TU/CErnV5oEbHoMu4pDZdctqduM55jNrWZW6bod1JFvjZY2x+yy60DpqVlRm6JyaYUD30no++3g
 Q+LNua9EbFEhCXAT9+Y5+EQ51+UN/6EaQxPIygI7lqJ7vhn252MS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310060

The ADE9078 is a polyphase energy metering device that is register
compatible with the ADE9000. The main differences relevant to the driver
are the absence of the on-chip dip/swell detection and slightly different
full-scale ADC codes.

Add a dedicated channel table that omits the swell/dip voltage events and
a matching chip_info describing the ADE9078 full-scale codes. A separate
RMS voltage channel macro variant is added that drops the swell/dip event
spec so the ADE9078 channel table can omit those events.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- use a generic Kconfig title and list the supported parts.
- duplicate the RMS voltage macro instead of a shared base macro.
- drop the full-scale codes comment change and reword the commit message.

 drivers/iio/adc/Kconfig   |  16 ++---
 drivers/iio/adc/ade9000.c | 119 ++++++++++++++++++++++++++------------
 2 files changed, 90 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 642c42b1fae7..daebffa93a83 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -573,20 +573,22 @@ config AD9467
 	  called ad9467.
 
 config ADE9000
-	tristate "Analog Devices ADE9000 Multiphase Energy, and Power Quality Monitoring IC Driver"
+	tristate "Analog Devices Multiphase Energy and Power Quality Monitoring IC Driver"
 	depends on SPI
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	help
-	  Say yes here to build support for the Analog Devices ADE9000,
-	  a highly accurate, multiphase energy and power quality monitoring
-	  integrated circuit.
+	  Say yes here to build support for the following Analog Devices
+	  highly accurate, multiphase energy and power quality monitoring
+	  integrated circuits:
+	    - ADE9000
+	    - ADE9078
 
-	  The device features high-precision analog-to-digital converters
+	  The devices feature high-precision analog-to-digital converters
 	  and digital signal processing to compute RMS values, power factor,
-	  frequency, and harmonic analysis. It supports SPI communication
-	  and provides buffered data output through the IIO framework.
+	  frequency, and harmonic analysis. They support SPI communication
+	  and provide buffered data output through the IIO framework.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called ade9000.
diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 030bb9109ab6..fd1362a98052 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -502,6 +502,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 	.scan_index = -1						\
 }
 
+/* With swell/dip (sag) events - ADE9000 only */
 #define ADE9000_ALTVOLTAGE_RMS_CHANNEL(num) {				\
 	.type = IIO_ALTVOLTAGE,						\
 	.channel = num,							\
@@ -517,6 +518,20 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 	.scan_index = -1						\
 }
 
+/* Without swell/dip events - parts lacking DIP_LVL/SWELL_LVL hardware */
+#define ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS(num) {			\
+	.type = IIO_ALTVOLTAGE,						\
+	.channel = num,							\
+	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMS, num),		\
+	.channel2 = IIO_MOD_RMS,					\
+	.modified = 1,							\
+	.indexed = 1,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_SCALE) |		\
+			      BIT(IIO_CHAN_INFO_CALIBBIAS),		\
+	.scan_index = -1						\
+}
+
 #define ADE9000_POWER_ACTIVE_CHANNEL(num) {				\
 	.type = IIO_POWER,						\
 	.channel = num,							\
@@ -598,44 +613,61 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 	.scan_index = -1						\
 }
 
-static const struct iio_chan_spec ade9000_channels[] = {
-	/* Phase A channels */
-	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_A_NR),
-	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_A_NR),
-	ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_A_NR),
-	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_A_NR),
-	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
-	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
-	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_A_NR),
-	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AWATTHR_LO),
-	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AVAHR_LO),
-	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AFVARHR_LO),
-	ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_A_NR),
-	/* Phase B channels */
-	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_B_NR),
-	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_B_NR),
-	ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_B_NR),
-	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_B_NR),
-	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR),
-	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR),
-	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_B_NR),
-	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BWATTHR_LO),
-	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BVAHR_LO),
-	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BFVARHR_LO),
-	ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_B_NR),
-	/* Phase C channels */
-	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_C_NR),
-	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_C_NR),
-	ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_C_NR),
-	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_C_NR),
-	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR),
-	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR),
-	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_C_NR),
-	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CWATTHR_LO),
-	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CVAHR_LO),
-	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CFVARHR_LO),
-	ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_C_NR),
-};
+/*
+ * Declare a full channel array. @altvoltage_rms picks the RMS voltage channel
+ * variant so parts without dip/swell hardware (e.g. ADE9078) omit those events.
+ */
+#define ADE9000_DECLARE_CHANNELS(_name, altvoltage_rms)			      \
+	static const struct iio_chan_spec _name[] = {			      \
+		/* Phase A channels */					      \
+		ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_A_NR),		      \
+		ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_A_NR),		      \
+		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_A_NR),	      \
+		altvoltage_rms(ADE9000_PHASE_A_NR),			      \
+		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR),	      \
+		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR),	      \
+		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_A_NR),	      \
+		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR,	      \
+					      ADE9000_REG_AWATTHR_LO),	      \
+		ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_A_NR,	      \
+						ADE9000_REG_AVAHR_LO),	      \
+		ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR,	      \
+						ADE9000_REG_AFVARHR_LO),      \
+		ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_A_NR),	      \
+		/* Phase B channels */					      \
+		ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_B_NR),		      \
+		ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_B_NR),		      \
+		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_B_NR),	      \
+		altvoltage_rms(ADE9000_PHASE_B_NR),			      \
+		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR),	      \
+		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR),	      \
+		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_B_NR),	      \
+		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR,	      \
+					      ADE9000_REG_BWATTHR_LO),	      \
+		ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_B_NR,	      \
+						ADE9000_REG_BVAHR_LO),	      \
+		ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR,	      \
+						ADE9000_REG_BFVARHR_LO),      \
+		ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_B_NR),	      \
+		/* Phase C channels */					      \
+		ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_C_NR),		      \
+		ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_C_NR),		      \
+		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_C_NR),	      \
+		altvoltage_rms(ADE9000_PHASE_C_NR),			      \
+		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR),	      \
+		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR),	      \
+		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_C_NR),	      \
+		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR,	      \
+					      ADE9000_REG_CWATTHR_LO),	      \
+		ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_C_NR,	      \
+						ADE9000_REG_CVAHR_LO),	      \
+		ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR,	      \
+						ADE9000_REG_CFVARHR_LO),      \
+		ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_C_NR),	      \
+	}
+
+ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL);
+ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS);
 
 /*
  * Full-scale codes referred from the respective datasheets. These are the
@@ -650,6 +682,15 @@ static const struct ade9000_chip_info ade9000_chip_info = {
 	.pcf_full_scale_codes = 74770000,
 };
 
+static const struct ade9000_chip_info ade9078_chip_info = {
+	.name = "ade9078",
+	.channels = ade9078_channels,
+	.num_channels = ARRAY_SIZE(ade9078_channels),
+	.rms_full_scale_codes = 52866837,
+	.watt_full_scale_codes = 20823646,
+	.pcf_full_scale_codes = 74680000,
+};
+
 static const struct reg_sequence ade9000_initialization_sequence[] = {
 	{ ADE9000_REG_PGA_GAIN, ADE9000_PGA_GAIN },
 	{ ADE9000_REG_CONFIG0, ADE9000_CONFIG0 },
@@ -1800,12 +1841,14 @@ static int ade9000_probe(struct spi_device *spi)
 
 static const struct spi_device_id ade9000_id[] = {
 	{ .name = "ade9000", .driver_data = (kernel_ulong_t)&ade9000_chip_info },
+	{ .name = "ade9078", .driver_data = (kernel_ulong_t)&ade9078_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ade9000_id);
 
 static const struct of_device_id ade9000_of_match[] = {
 	{ .compatible = "adi,ade9000", .data = &ade9000_chip_info },
+	{ .compatible = "adi,ade9078", .data = &ade9078_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ade9000_of_match);
-- 
2.43.0

