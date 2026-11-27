Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816391;
	b=ikPs58kQTuSE3ydn0tNEEiDsO6Oi3hZ46QszpAu8Mbk+BUinEOTSmbYX8VaGs3jrmzfw
	 4NpEmhf92Tj69JhLBL7v2gKl+ncOalQgz0w+ZGzlSTveDkJpMKD0hX1Y7Z6iymLcsKo43
	 cDkPUBd8K94dN6toKBJwtYmC45eFd57TXNDEN3dyRQcRHXkyVDt9Ldv82xTj7eFRhe9nd
	 ATphdSEGsN1q82yiscc83VhQhpvzAPlsWQmE8DJ6NlyqfoM23dSPPNGwV4svc/96ncbW/
	 0zUULLcqWphVIcuLc1U6OburQf51S1sWoJ2zPCpEvcGdubLCbBd8UrphTdSP3/vaWZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816391;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ANZL66sLdX0Igs7IVCqxVUy/Owl7Fm8ewt4Cj7t42Xg=;
	b=fq8CMcr/IiilG1ILgx9a3sEysy1MtMIMw45FX7B2mVStnU1MZtnvs5PU46mUEubdwxwV
	 kewKVZVVemIKUz03BBs4qioQ/6zgjoWUfvAhne/NLjrLWxes6NlZbodcT/PtOzkqzv+Ni
	 yoPOeHX1HT0yWbjIFsHvu7x3T9MaFOys+s/Zl4VxC93f/jvjKpILNJOZbWTctTCpu1oYG
	 l3fieavsNSlrVSFtyVnltb56H0KxOGy2KCfTWACJEN5+WWhoAOjd0wb8GW5mG7wE1Vzr9
	 7OVih26VK6LsOMTQhww7NjUcwrKlWh9usnnNf2nRuxzeGF3W97rYlavyO40zE9KC/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=hiJpwKBC;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=qn1zrXPl;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396D606A321;
	Fri, 27 Nov 2026 21:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E396D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=hiJpwKBC;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=qn1zrXPl
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJBf2S1737373;
	Fri, 27 Nov 2026 16:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ANZL66sLdX0Igs7IVCqxVUy/Owl7Fm8ewt4Cj7t42Xg=; b=hiJpwKB
	CIp20I8e5owrMA8z5k7Ka7Y6WzNz3l5BxZQCGe0ZG4bkCd76mvmw9q8eS1mHahzx
	bfAPvmmXnrvTYHBPVzloJGujEQs+C9xtjBnDavHvisUKFS9jKhTtFJM/zmlBoSEN
	AEF7RTHfoUO17xEJtxaxyY4oMVLenJOL8cJGjAGH0sIqRaQFNBfYwPcggeUach/K
	MxU2KDjynLLd6SILwnHubL9RoxwNMEfAu8lJfTXYLcngo4dwZh3XltMlpsAWLo80
	CFvZ2YyhBv2sfwQ3c3OcDZL2R9LTaiz3vql1dsCWVHcxHb+4I7eDzTGIp853a31V
	PXqTi+Pj1RHr49A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ANZL6
	6sLdX0Igs7IVCqxVUy/Owl7Fm8ewt4Cj7t42Xg=; b=qn1zrXPlZiXnvGDdnHZXc
	mONDfoBK4qv4rjLwWIljzNV5hfvtHBqEmC13sddGvUbNhHS5s39EnzYy3FMGBcnJ
	ikEITaFvsWUIU/WiDNm6z/8pIkkFHOjvoJMNKB1rpUf3fg+Z2r3v+wyMBZHR3BQj
	ontlC9EaaB5rGcFuEnQRZ/kuI7gh5suIyef/9IGNOe9jTJXhqhqPFmE+bd0qfJEJ
	dASzRqNG52OrK8CAXObnOaghs27o3fUGCE/5zJ4tIDPqEo13GkvkqdSZ5GjAnNKk
	R7OdhlVnf/bwgNQMWrBNCsCya0YVWJMMfmfkNkrxnQ/uvP1XANI1aeFlqKSmBbCx
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j63xubtd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 16:53:01 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6ARLr05Z057177
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Nov 2026 16:53:00 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 16:53:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 27 Nov 2026 16:53:00 -0500
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6ARLqjq0018641;
	Fri, 27 Nov 2026 16:52:48 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 3/5] iio: adc: adi-axi-adc: Support AXI ADA4355 IP core
Date: Fri, 27 Nov 2026 18:52:38 -0300
Message-ID: <e92787fd505e967d32352db854b40e1f1985b51c.1795816065.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795816065.git.marcelo.schmitt@analog.com>
References: <cover.1795816065.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX9V1QoIqB/dpq
 aC6BMbk/iO3iciwdf2+N75hniRYbuQDBkciilTVhqqZiEcLOUuoqwxU3oS6GkAV/8woKSA+CX1R
 pnGJqX9vNbVrZjDsBpqYOT3jOnmISugSBvnrGcl15+LwnEpfJvHw
X-Proofpoint-GUID: TU7edSkiYtEl0YPWYSMVwg6pAyjRytvq
X-Proofpoint-ORIG-GUID: TU7edSkiYtEl0YPWYSMVwg6pAyjRytvq
X-Authority-Analysis: v=2.4 cv=Qt3LTlyd c=1 sm=1 tr=0 ts=6b09fbbd cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8
 a=OjnDG6chPnepvdpQngoA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX6zVzXZVFro/u
 0KhS0IsjDMTGeb8FLkK3fKetMiTwxB1lj36LPhuOPB4TuhBNJRIW30psxNiO+qhrNNcSmv05U9z
 KWzLvKY+2v4ID6NS2GGpo4jvF5PqrTFbMljUE2NEvq0hP4G0F+7SbZ6iKpFloUvLvb9HqKl8nEe
 EqU5rWxp+/93gapaSIEnkuEY5t1wXRnp8/jSFB1PgbnXCKvvpVNlZi2PyY7zpQpBqLyx8hUI36h
 rHr+zI0rI5MnVLZ1xnclZiQZxxkWkv+9WZpXAr/oD+0HmkxFBhdJaBtNRwuevNNUP8IGyy6Sg0o
 Xeh9pmXojMqoj+mFWXE5FSpQ4JQo0FIRLgzlOn+JrGKZuFvszUr51DB4CB9/2h2RJaPZ/HmoaBv
 l6azASCM330ZEtbNeY2/VliHskqMtZGb906oC9bemfYMWxgJ8FSUpuyF1v4R5QnemlRhHxQ9W64
 naTHcFe9yyHkOPGEecw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270087

The AXI ADA4355 IP core provides the HDL interface to ADA4355 devices. It
differs from the generic AXI ADC core in its register layout and requires
a data frame setup step in which the number of active serial lanes is
programmed.

Add a separate backend operation for the AXI ADA4355 IP core and register
it as a new compatible of the adi-axi-adc driver.

Link: https://analogdevicesinc.github.io/hdl/library/axi_ada4355/index.html
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 66 +++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 4b77b7169d95..965dd6dc4bb8 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -67,6 +67,10 @@
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
+#define ADI_AXI_ADC_REG_LVDS			0x00c8
+#define   ADI_AXI_ADC_LVDS_FRAME_ERROR		BIT(2)
+#define   ADI_AXI_ADC_LVDS_LANE_ERROR		GENMASK(1, 0)
+
 /* ADC Channel controls */
 
 #define ADI_AXI_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
@@ -486,6 +490,34 @@ static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
 					1, timeout_us);
 }
 
+static int axi_adc_ada4355_calibration_source_set(struct iio_backend *back,
+						  enum iio_backend_calib_source source,
+						  unsigned int lane)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 val;
+
+	switch (source) {
+	case IIO_BACKEND_CALIB_SOURCE_NONE:
+		val = 0;
+		break;
+	case IIO_BACKEND_CALIB_SOURCE_FRAME:
+		val = ADI_AXI_ADC_LVDS_FRAME_ERROR;
+		break;
+	case IIO_BACKEND_CALIB_SOURCE_DATA_LANE:
+		if (BIT(lane) & ~ADI_AXI_ADC_LVDS_LANE_ERROR)
+			return -EINVAL;
+		val = BIT(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_LVDS,
+				  ADI_AXI_ADC_LVDS_FRAME_ERROR |
+				  ADI_AXI_ADC_LVDS_LANE_ERROR, val);
+}
+
 static int axi_adc_num_lanes_set(struct iio_backend *back,
 				 unsigned int num_lanes)
 {
@@ -722,6 +754,34 @@ static const struct iio_backend_info axi_ad408x = {
 	.caps = IIO_BACKEND_CAP_BUFFER | IIO_BACKEND_CAP_ENABLE,
 };
 
+static const struct iio_backend_ops adi_ada4355_ops = {
+	.enable = axi_adc_enable,
+	.disable = axi_adc_disable,
+	.data_format_set = axi_adc_data_format_set,
+	.chan_enable = axi_adc_chan_enable,
+	.chan_disable = axi_adc_chan_disable,
+	.request_buffer = axi_adc_request_buffer,
+	.free_buffer = axi_adc_free_buffer,
+	.data_sample_trigger = axi_adc_data_sample_trigger,
+	.iodelay_set = axi_adc_iodelays_set,
+	.test_pattern_set = axi_adc_test_pattern_set,
+	.chan_status = axi_adc_chan_status,
+	.interface_type_get = axi_adc_interface_type_get,
+	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
+	.interface_data_align = axi_adc_ad408x_interface_data_align,
+	.calibration_source_set = axi_adc_ada4355_calibration_source_set,
+	.num_lanes_set = axi_adc_num_lanes_set,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
+	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+};
+
+static const struct iio_backend_info axi_ada4355 = {
+	.name = "axi-ada4355",
+	.ops = &adi_ada4355_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFER |
+		IIO_BACKEND_CAP_ENABLE,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -841,12 +901,18 @@ static const struct axi_adc_info adi_axi_ad408x = {
 	.backend_info = &axi_ad408x,
 };
 
+static const struct axi_adc_info adi_axi_ada4355 = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &axi_ada4355,
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
 	{ .compatible = "adi,axi-ad408x", .data = &adi_axi_ad408x },
 	{ .compatible = "adi,axi-ad485x", .data = &adi_axi_ad485x },
 	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
+	{ .compatible = "adi,axi-ada4355", .data = &adi_axi_ada4355 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
-- 
2.53.0

