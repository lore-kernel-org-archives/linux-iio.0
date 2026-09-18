Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A20632;
	Fri, 18 Sep 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717015; cv=none; b=D6hRxIl0NX4YsLKz3JfKiX5Y6ec8ryXK5WGZJARIdxCRHVvo8XXhhXc8EoV7iw2N4oxl6JlGT4YC/DTcBXiVvVTEEraG/KRTOcnEv6QEQPqNLDqIsyH0atJ1kxRUK3J5TrAJoJIO4jR8AjBoRVgMF4xJ+nWXxmzYLGe6zxcPZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717015; c=relaxed/simple;
	bh=ArZcDThcurlJ0nD6yr9+gwux3lXVW1q0qXu9PpWMjSg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uc2/2zRAGlc60bNIRXegHusRRHclD9eidbSp/j/2bK99WCw/vIudYjxc83o+X4sgwrSbWvUOfVJ03bJXxZe4PMeypqQBlPoKR9sVUY5qFStWMMgkp2H4T98n/2qiRrhQAWPjs6LZ3eiQFDPw8ETJm9ZgqiQH6ZhEtQC2nO/1eJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=s/ROTyyK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="s/ROTyyK"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5wKFb570743;
	Fri, 18 Sep 2026 03:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=viFGZ
	LX5Gyzr3zRHG5k+XuJmn61uaJo4fgcVYFFmRFo=; b=s/ROTyyKHUAsZJDfj05io
	0bR1kNlC2BN4CWgam2imGfUtrVbZelLjTdBj0fGkp5VloOy9BHEP8aeIMPb3fLPO
	nT2jUYQu1cRjiQnAdCF3//RgprmV+h6acRpYPGWyDrSiYTDCggwpOVek5E0XIjQ8
	yTuN0X5qXmsMDUFNcDA8okHgDRxCSDDpQpqU6FZI/okcoatGoecaY+f+KzSGG/9e
	Tap5MeNAfvsyAJSQsi3zD0je8v1Oj323x9f7iDJ/aqLNUaORLTFhy2v742QGS++b
	bi9JABNSkUZFeHTxPGKW+1IM+RLcPFFDyweGKmrPbxvX0LNTQqJMasvJt+tVUN1j
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4grk0h3ubj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 03:36:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68I7aNS1011068
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 03:36:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 18 Sep
 2026 03:36:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 18 Sep 2026 03:36:23 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.219])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68I7ZjpW019677;
	Fri, 18 Sep 2026 03:36:15 -0400
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
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jakub
 Szczudlo <jakubszczudlo40@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 4/6] iio: adc: ade9000: gate the DICOEFF write behind a chip_info flag
Date: Fri, 18 Sep 2026 10:35:33 +0300
Message-ID: <20260918073537.1572-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918073537.1572-1-antoniu.miclaus@analog.com>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfXyqNmLa4XOvKn
 Za49AHB07HCSW0r2Z/T1Jw1lQIXmSYuqrzzdiHE5JnMYmIsi58ENSTAmdIwVbvFgiljho1szSsW
 L5okolq20bT9FRxCFapDPIgJX6pzMP/znyGMUJZZtnhtQqFOH3Cd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfXyd31opQCh0Al
 2SQNJW4wv2yQsQBs9zcLB2ukMcCoSgaolYsH/yEqrhJTC15Yb3VM8rRdFSoLeaf3KBXmmkFawfg
 s+SyXOqMXxA9hZAA56iF2v3uSAFqSUNO2Uh+rDaiESRydUwH7x/sHtTHCxWkShkHEnDkDfIYB4Y
 Qt+GTz/CbbDrsp6ZH8rFe5Z73fdTB0+wJmngM8awnI+MzvOLToEQG91iPQS8wikwmzr+kgpKLCZ
 p9vlCfS3xjIPyK4I0mr/NlPuZDohkNg/JmGGG1jEwtakLsXmi/lC2tSZ8ySE5YDVZxQH2uyS1re
 9TGGlj05Dv3vns7ZZJ5xZt/iTv3AAvs+WCTtuEy7bH7KVVAPGjsfpowqJgwvmdQYTGUD8S33SQT
 D7XfcE4vkq4xNEZO5ZW5Z41y73JXyiyq/yhdO+d3tXOaCt6ZiUVoDvmbEiiYELitT9NnB3N4/GY
 EvoJ/n/c7GWVKY0nRpg==
X-Proofpoint-GUID: GQKX71cEFcHn1KVTpKlWEGCSuX0qLR8_
X-Proofpoint-ORIG-GUID: GQKX71cEFcHn1KVTpKlWEGCSuX0qLR8_
X-Authority-Analysis: v=2.4 cv=IpqL47/g c=1 sm=1 tr=0 ts=6aace9f8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=HWq8w0C2B1yOpf0TK-AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180102

Some parts in the ADE9000 family have no on-chip digital integrator and
therefore lack the DICOEFF register; they use an external analog integrator
for Rogowski coil current sensors. Prepare for such parts by adding a
has_digital_integrator flag to the chip_info and only writing DICOEFF when
it is set.

Move the DICOEFF and RUN writes out of the shared initialization sequence
into ade9000_setup() so DICOEFF can be issued conditionally while RUN still
starts the DSP afterwards. All currently supported parts set the flag, so
there is no functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- new precursor patch, split out of the ADE9430 support patch.

 drivers/iio/adc/ade9000.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index ce0317766698..0167d5bcdb74 100644
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
@@ -680,6 +682,7 @@ static const struct ade9000_chip_info ade9000_chip_info = {
 	.rms_full_scale_codes = 52702092,
 	.watt_full_scale_codes = 20694066,
 	.pcf_full_scale_codes = 74532013,
+	.has_digital_integrator = true,
 };
 
 static const struct ade9000_chip_info ade9078_chip_info = {
@@ -689,6 +692,7 @@ static const struct ade9000_chip_info ade9078_chip_info = {
 	.rms_full_scale_codes = 52866837,
 	.watt_full_scale_codes = 20823646,
 	.pcf_full_scale_codes = 74680000,
+	.has_digital_integrator = true,
 };
 
 static const struct reg_sequence ade9000_initialization_sequence[] = {
@@ -704,13 +708,11 @@ static const struct reg_sequence ade9000_initialization_sequence[] = {
 	{ ADE9000_REG_EVENT_MASK, ADE9000_EVENT_DISABLE },
 	{ ADE9000_REG_WFB_CFG, ADE9000_WFB_CFG },
 	{ ADE9000_REG_VLEVEL, ADE9000_VLEVEL },
-	{ ADE9000_REG_DICOEFF, ADE9000_DICOEFF },
 	{ ADE9000_REG_EGY_TIME, ADE9000_EGY_TIME },
 	{ ADE9000_REG_EP_CFG, ADE9000_EP_CFG },
 	/* Clear all pending status bits by writing 1s */
 	{ ADE9000_REG_STATUS0, GENMASK(31, 0) },
 	{ ADE9000_REG_STATUS1, GENMASK(31, 0) },
-	{ ADE9000_REG_RUN, ADE9000_RUN_ON }
 };
 
 static int ade9000_spi_write_reg(void *context, unsigned int reg,
@@ -1672,6 +1674,21 @@ static int ade9000_setup(struct ade9000_state *st)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to write register sequence");
 
+	/*
+	 * DICOEFF must be configured before the DSP is started. Parts without
+	 * an on-chip digital integrator lack this register, so skip it there.
+	 */
+	if (st->info->has_digital_integrator) {
+		ret = regmap_write(st->regmap, ADE9000_REG_DICOEFF,
+				   ADE9000_DICOEFF);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to set DICOEFF\n");
+	}
+
+	ret = regmap_write(st->regmap, ADE9000_REG_RUN, ADE9000_RUN_ON);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to start DSP\n");
+
 	fsleep(2000);
 
 	return 0;
-- 
2.43.0

