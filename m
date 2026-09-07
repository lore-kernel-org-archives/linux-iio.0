Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58225453A22;
	Mon,  7 Sep 2026 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776335; cv=none; b=OILICALgZQ0Q6c2N7DIH+2WYRgdA8BHeju2C/3F+9pvOja08AoZUVyNbSfSM5Wjbd2990M7bGd943g//733dN3FmYUdqudwX1VTKJygq9bDc8+bsG+fTJMa3wvDcPjfdzQdZmBfKRuhX/8uwNKUdFQXA28TA+SOVQjGcgiLQGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776335; c=relaxed/simple;
	bh=X/+lIyV5TKF2AbJW18CnbjUmNfk1Mnb+7p78luW1VJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEnU43R5xmOdtGfQPajJVBt3Yxl8EmkjdEtYKwYY3Neb3/msuQw5xrca0bLq5n/73S7sAImcmjgmtZ8DcpDazJ/gIDzCyWuJhNfU7G/owN4p9CJsYzvI0OIbZwG3EDiDpA5ShpqqFwb/rwrfCIQZo7UHUAlYHD8huYIoC5YndZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rLTuNIB2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rLTuNIB2"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879YUMR3717590;
	Mon, 7 Sep 2026 06:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EOWZW
	y8P1tAUb6fCC4AZoR8Sqsm1fd7G8oHqhkC9B+g=; b=rLTuNIB2A5JYJ3iiPLoMx
	GGQFFHtjPrPeP9fGcqOIc/spvV5z7JI+o6+mDiXdUQhxMSgNhUmj6dBz7E4X8DcA
	YDtnU/Pkik+iuXGOZ4qRbHWxahuzB+h3yeV02M/r+AxQ0oHMa6D+5FMmNyM7mFLX
	cTqWDTxEubRkJ8Bagz5YSQrVMKh5nSdHDgq1PcgN+MGiwFN4v40UWwtK+oyvlUM7
	EeELT3iwfrJcGOvpRigCRBoyh/y1EJ+Qxqqfilba5NKKHxMs+OvC9sA1y7yhkhhl
	ts6jwUWuUuEq2+OuczqycPLgmmILJpZD8viwb3wT6oCt5LQ/c4TzKahOleT3Leqo
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gh4dg4d81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 06:18:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 687AIX0q010539
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 06:18:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 7 Sep 2026 06:18:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 7 Sep 2026 06:18:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 06:18:33 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 687AI3Df007412;
	Mon, 7 Sep 2026 06:18:27 -0400
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
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        "Jakub Szczudlo" <jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 3/4] iio: adc: ade9000: add support for ADE9430
Date: Mon, 7 Sep 2026 13:16:20 +0300
Message-ID: <20260907101623.8730-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907101623.8730-1-antoniu.miclaus@analog.com>
References: <20260907101623.8730-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hh-qvLzKMaeL9gZEDUJ3diqwseDUTTvP
X-Authority-Analysis: v=2.4 cv=f5N4wuyM c=1 sm=1 tr=0 ts=6a9e8f7a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=Qowmki7bGa4GvelHUEEA:9
X-Proofpoint-GUID: hh-qvLzKMaeL9gZEDUJ3diqwseDUTTvP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMiBTYWx0ZWRfX6bWZU1qE9jQv
 Amjeuz0SNrgSbCovppW3Lje5SrfQkUyvntr4x03xDUNyBqDSiFsVWVcv3Xu00ntHu41aAVDr+xx
 lQicvcf1j3+JnEUWcD84ofSQ8g841TTEzbxcXc3JTEtpgReEOVlH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMiBTYWx0ZWRfXxsnmo8J70Zt4
 9gzunmhYVV2F3HP+VAh7J81Y3wtW7gz6qQsLVTOSs+G1ryjkh8RSA7H4VjCL7d7tWiWrCSdyNNf
 1ck7ndsiw58TYUWMVbbDunOwwwIQFOTthTSoxUHH5aF9ap5AQz9C2pMS+h4KUsjgn/ZhPzyiyIV
 giyONMiA8jZuhgNnS1sA3GVLaVW03gQ4YL134KvrLxrDT0Oy/JuXZ5bghNhs+ytQK91rLoEo8KC
 hBmnJNUXhd0N/1pLZE2E8W9cYux3mVgeFLxPlqGQMwpGSwxJOsg3FOtIWZJtHbElVPSpyXA7qPj
 4KdHxMyh+94PPftJMZm71CNFYSNUznRBEoCDSKJnjdAztGGNZGkp/ovfXQYMzQUjM62moVeMm5W
 KO9TxFFXF2t8qr5t/cNL5+/icKyH3GNoZYLkfJJJumgMM0QYOIbaOj3fqMeR2Hxd4ydWF23tJrw
 mAuanEyyj88dbvh9ETQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070112

The ADE9430 is a polyphase energy metering device that is register
compatible with the ADE9000. The differences relevant to the driver are
the absence of the on-chip dip/swell detection, the absence of an on-chip
digital integrator (the ADE9430 uses an external analog integrator for
Rogowski coils, so the DICOEFF register does not exist) and slightly
different full-scale ADC codes.

Reuse the dip/swell-less channel table introduced for the ADE9078 and add
a matching chip_info describing the ADE9430 full-scale codes. Add a
has_digital_integrator flag to the chip_info so the DICOEFF write is only
issued on parts that implement the register, and skip it for the ADE9430.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ade9000.c | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6431592c5fa3..85a10524c76a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -587,6 +587,7 @@ config ADE9000
 	  integrated circuits:
 	    - ADE9000
 	    - ADE9078
+	    - ADE9430
 
 	  The devices feature high-precision analog-to-digital converters
 	  and digital signal processing to compute RMS values, power factor,
diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 0f64bfb221da..2f5fe016a82f 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -290,6 +290,7 @@ enum ade9000_wfb_cfg {
  * @rms_full_scale_codes: digital code produced at full-scale RMS input
  * @watt_full_scale_codes: digital code produced at full-scale power input
  * @pcf_full_scale_codes: digital code produced at full-scale xI_PCF/xV_PCF input
+ * @has_digital_integrator: part has an on-chip digital integrator (DICOEFF)
  *
  * The full-scale codes are taken from the respective datasheets and are used to
  * derive the IIO scale of the raw measurement channels.
@@ -301,6 +302,7 @@ struct ade9000_chip_info {
 	unsigned int rms_full_scale_codes;
 	unsigned int watt_full_scale_codes;
 	unsigned int pcf_full_scale_codes;
+	bool has_digital_integrator;
 };
 
 struct ade9000_state {
@@ -668,6 +670,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 
 ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL);
 ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS);
+ADE9000_DECLARE_CHANNELS(ade9430_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS);
 
 /*
  * Full-scale codes referred from the respective datasheets. These are the
@@ -680,6 +683,7 @@ static const struct ade9000_chip_info ade9000_chip_info = {
 	.rms_full_scale_codes = 52702092,
 	.watt_full_scale_codes = 20694066,
 	.pcf_full_scale_codes = 74532013,
+	.has_digital_integrator = true,
 };
 
 static const struct ade9000_chip_info ade9078_chip_info = {
@@ -689,6 +693,16 @@ static const struct ade9000_chip_info ade9078_chip_info = {
 	.rms_full_scale_codes = 52866837,
 	.watt_full_scale_codes = 20823646,
 	.pcf_full_scale_codes = 74680000,
+	.has_digital_integrator = true,
+};
+
+static const struct ade9000_chip_info ade9430_chip_info = {
+	.name = "ade9430",
+	.channels = ade9430_channels,
+	.num_channels = ARRAY_SIZE(ade9430_channels),
+	.rms_full_scale_codes = 52702092,
+	.watt_full_scale_codes = 20694066,
+	.pcf_full_scale_codes = 74532013,
 };
 
 static const struct reg_sequence ade9000_initialization_sequence[] = {
@@ -704,7 +718,6 @@ static const struct reg_sequence ade9000_initialization_sequence[] = {
 	{ ADE9000_REG_EVENT_MASK, ADE9000_EVENT_DISABLE },
 	{ ADE9000_REG_WFB_CFG, ADE9000_WFB_CFG },
 	{ ADE9000_REG_VLEVEL, ADE9000_VLEVEL },
-	{ ADE9000_REG_DICOEFF, ADE9000_DICOEFF },
 	{ ADE9000_REG_EGY_TIME, ADE9000_EGY_TIME },
 	{ ADE9000_REG_EP_CFG, ADE9000_EP_CFG },
 	/* Clear all pending status bits by writing 1s */
@@ -1672,6 +1685,14 @@ static int ade9000_setup(struct ade9000_state *st)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to write register sequence");
 
+	/* The ADE9430 has no on-chip digital integrator and lacks DICOEFF. */
+	if (st->info->has_digital_integrator) {
+		ret = regmap_write(st->regmap, ADE9000_REG_DICOEFF,
+				   ADE9000_DICOEFF);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to set DICOEFF\n");
+	}
+
 	fsleep(2000);
 
 	return 0;
@@ -1842,6 +1863,7 @@ static int ade9000_probe(struct spi_device *spi)
 static const struct spi_device_id ade9000_id[] = {
 	{ .name = "ade9000", .driver_data = (kernel_ulong_t)&ade9000_chip_info },
 	{ .name = "ade9078", .driver_data = (kernel_ulong_t)&ade9078_chip_info },
+	{ .name = "ade9430", .driver_data = (kernel_ulong_t)&ade9430_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ade9000_id);
@@ -1849,6 +1871,7 @@ MODULE_DEVICE_TABLE(spi, ade9000_id);
 static const struct of_device_id ade9000_of_match[] = {
 	{ .compatible = "adi,ade9000", .data = &ade9000_chip_info },
 	{ .compatible = "adi,ade9078", .data = &ade9078_chip_info },
+	{ .compatible = "adi,ade9430", .data = &ade9430_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ade9000_of_match);
-- 
2.43.0

