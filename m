Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764BE3F23C2;
	Mon, 20 Jul 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545734; cv=none; b=NpHz1wLT5EgjeXXGZqFvyonTEoJNY2Lbl1vvC7TRdwcr0nIt8ALNA5XRQNheG5B9MN0Q1d5RkcpsROwkIU9ZZy995fwfedcf2DRhuWahbL1ZPhZqeLFH46117Z0SLzzD4WC48LHEIklyUBgB9W7v0nJ1AGtUGhyq5o6mmj+yV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545734; c=relaxed/simple;
	bh=Bd0qTMCXEkBOff1wTYgGYCASTpFouChBbH8c8NsXXZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl3ojOWm58LyRkaT78WHO7+wwo4S9ylC2lgDIfDW9cfm/Hg5gVVfzeNpZvPHvPFq/GLMusqkCO2TfdPfTEa3ufQdzyAjH9OUdd57v9Ox6JPR3PY2X6HL5Of6WDghi7hQQpKnP4s/Uz4+xnso75OchtaVcg3RFl9S2rp/fmW4FtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1IhqIWF4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1IhqIWF4"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KB0Reg1666543;
	Mon, 20 Jul 2026 07:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=i/bH/
	YoroegUuRyJZXyfiQjCt9c+sT8fUTx6rjDyRqg=; b=1IhqIWF4CBKsatuTCR57/
	qMkUWrtObP4vh0yErs715nX3O92yYhaKEkv10JkM9PhVLTo1dsOkNyid3mG7FgGO
	ULGN0OioAHswpQvdAAB3/5txtRlglcWatQno8nw/WmZAZoYZHgxaSPlgGwDJS98a
	14wt9xLEMZ0CwpeyTS2AQgKcmNPYCA+HIqXEGGrFFMJAY//Ign3Sk+YQB1Eb4d93
	0oH82AVFYO6XD6t2mFJZ9hjkkdal6a4K9JbrG9gCIKRIYA/kDwFJcgpNRe8YVnez
	xY+cbq9sd3oNz2oSqut9QM+X1nO9FMelrlUwlnV4mSMD0ktyxUSrvM8OaesvpTiw
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fg6d1e9b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:08:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66KB8i9Q062906
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jul 2026 07:08:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Jul
 2026 07:08:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Jul 2026 07:08:44 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66KB8HRK024360;
	Mon, 20 Jul 2026 07:08:35 -0400
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
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Jorge
 Marques <jorge.marques@analog.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 3/4] iio: adc: ade9000: add support for ADE9078
Date: Mon, 20 Jul 2026 14:07:46 +0300
Message-ID: <20260720110754.7674-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720110754.7674-1-antoniu.miclaus@analog.com>
References: <20260720110754.7674-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ds/rzVg4 c=1 sm=1 tr=0 ts=6a5e01bd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=aCWRDxNZ2XHDlcVCpRwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX9S/2d0skrW7W
 XR6dGXDORnTFRFp65tP7DRUed71UQlV35CNHfNxEm7GDQ2616raUZzOlKFk5S1hvJmH+woOnb85
 3Lc1BlnhHWK6oa9o6sJlWc+fPEiTcJGcKW00Typ87racyZHgjeOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX8jkkc5eE2q59
 h+pHFI1VqQPvZbjAYny3D4X7gWd2eRn4h4WK9uo0JFbufhQa4wlRlf8oXDPJy9f5AtCzMp5cO5Q
 2HeqMs/E3xS3SPYTzEBPWf83VqZZawk0PUMzFv3cyPho3RZbWNsFRApR/dOUXmra690ClE6sVuO
 0xDQiXeWBZoVCIpreAjyslpyXGxrSZgpoRuM8LShaKxifB2jmJb2x/x0TFLrQ6NSjA2KVvIIJeB
 flW0wRc1oBUkb7xqo82SjuK8sW6JPLK3+Klk+oJ/W2lL0eEKepkSqyqlLc3jDqNKlPmd76jdoac
 wX7W20UZPdRYZ1a5i02j9KR7oa3pld+sK52a53ZvtKbxrg/LVPxWoAstCd/v0wiI+rnkuFsP31l
 5/hslH+YMcZIu/3E1/hVFk8SDS+26sJOqHZ62nxi/NB/epQDeuEzJQo4ekz5CmqqcNJfTqh+3c5
 Ls0L1QvX6qHunoDDB4g==
X-Proofpoint-GUID: o7vtFxIT9WnGLPO4K49hz7j4SCCHb07z
X-Proofpoint-ORIG-GUID: o7vtFxIT9WnGLPO4K49hz7j4SCCHb07z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200124

The ADE9078 is a polyphase energy metering device that is register
compatible with the ADE9000. The main differences relevant to the driver
are the absence of the on-chip dip/swell detection and slightly different
full-scale ADC codes.

Add a dedicated channel table that omits the swell/dip voltage events and
a matching chip_info describing the ADE9078 full-scale codes. The RMS
voltage channel macro is split into a shared base and two variants so the
event-less table can reuse the common definition.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/Kconfig   |  14 ++---
 drivers/iio/adc/ade9000.c | 121 +++++++++++++++++++++++++-------------
 2 files changed, 86 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d1b198cb8a80..33f2c281b1aa 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -573,20 +573,20 @@ config AD9467
 	  called ad9467.
 
 config ADE9000
-	tristate "Analog Devices ADE9000 Multiphase Energy, and Power Quality Monitoring IC Driver"
+	tristate "Analog Devices ADE9000/ADE9078 Multiphase Energy, and Power Quality Monitoring IC Driver"
 	depends on SPI
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	help
-	  Say yes here to build support for the Analog Devices ADE9000,
-	  a highly accurate, multiphase energy and power quality monitoring
-	  integrated circuit.
+	  Say yes here to build support for the Analog Devices ADE9000 and
+	  ADE9078, highly accurate, multiphase energy and power quality
+	  monitoring integrated circuits.
 
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
index 38a5c7e043b3..0de55b7ad1ea 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -502,7 +502,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 	.scan_index = -1						\
 }
 
-#define ADE9000_ALTVOLTAGE_RMS_CHANNEL(num) {				\
+#define ADE9000_ALTVOLTAGE_RMS_CHANNEL_BASE(num)			\
 	.type = IIO_ALTVOLTAGE,						\
 	.channel = num,							\
 	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMS, num),		\
@@ -512,9 +512,18 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 			      BIT(IIO_CHAN_INFO_SCALE) |		\
 			      BIT(IIO_CHAN_INFO_CALIBBIAS),		\
+	.scan_index = -1
+
+/* With swell/dip (sag) events - ADE9000 only */
+#define ADE9000_ALTVOLTAGE_RMS_CHANNEL(num) {				\
+	ADE9000_ALTVOLTAGE_RMS_CHANNEL_BASE(num),			\
 	.event_spec = ade9000_rms_voltage_events,			\
 	.num_event_specs = ARRAY_SIZE(ade9000_rms_voltage_events),	\
-	.scan_index = -1						\
+}
+
+/* Without swell/dip events - parts lacking DIP_LVL/SWELL_LVL hardware */
+#define ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS(num) {			\
+	ADE9000_ALTVOLTAGE_RMS_CHANNEL_BASE(num),			\
 }
 
 #define ADE9000_POWER_ACTIVE_CHANNEL(num) {				\
@@ -598,48 +607,65 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
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
- * Full-scale codes referred from the datasheet. These are the digital codes
- * produced when the ADC inputs are at full scale.
+ * Full-scale codes referred from the respective datasheets. These are the
+ * digital codes produced when the ADC inputs are at full scale.
  */
 static const struct ade9000_chip_info ade9000_chip_info = {
 	.name = "ade9000",
@@ -650,6 +676,15 @@ static const struct ade9000_chip_info ade9000_chip_info = {
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
@@ -1800,12 +1835,14 @@ static int ade9000_probe(struct spi_device *spi)
 
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

